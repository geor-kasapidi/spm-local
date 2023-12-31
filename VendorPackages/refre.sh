if ! which jq > /dev/null 2>&1; then
    brew install jq
fi

rm -rf Sources && mkdir -p Sources

cd _Proxy

rm -rf .build .swiftpm Package.resolved

swift package update

required_products=$(swift package describe --type json | jq -c '.targets[] | .product_dependencies[]')

for repo in $(ls .build/checkouts); do
    echo $repo

    mkdir -p ../Sources/$repo

    cp -r .build/checkouts/$repo/Package.swift ../Sources/$repo/_Package.swift

    package_json=$(swift package --package-path .build/checkouts/$repo describe --type json | jq -c)

    targets=$(jq -c '(.targets[] | select(.product_memberships != null))' <<< $package_json)

    echo "$package_json" | jq -c '(.targets[] | select(.product_memberships != null))' | while read -r target; do
        required_target=false

        target_products=$(jq -c '.product_memberships[]' <<< "$target")

        for target_product in $target_products; do
            for required_product in $required_products; do
                if [ $required_product == $target_product ]; then
                    required_target=true
                fi
            done
        done

        if ! $required_target; then
            continue
        fi

        name=$(jq -r '.name' <<< $target)
        path=$(jq -r '.path' <<< $target)
        type=$(jq -r '.type' <<< $target)

        if [ $type == "system-target" ]; then
            mkdir -p ../Sources/$repo/$path
            cp -r .build/checkouts/$repo/$path/. ../Sources/$repo/$path
        fi

        if [ $type == "library" ]; then
            echo "$target" | jq --raw-output 'if has("resources") then (.resources[] | .path) else null end' | while read -r resource; do
                if [ "$resource" == "null" ]; then
                    continue
                fi
                resource_path="${resource##*.build/checkouts/$repo/$path/}"
                mkdir -p ../Sources/$repo/$path/"$(dirname "$resource_path")"
                cp .build/checkouts/$repo/$path/"$resource_path" ../Sources/$repo/$path/"$resource_path"
            done

            echo "$target" | jq --raw-output '.sources[]' | while read -r source; do
                mkdir -p ../Sources/$repo/$path/"$(dirname "$source")"
                cp .build/checkouts/$repo/$path/"$source" ../Sources/$repo/$path/"$source"
            done
        fi
    done
done

rm -rf .build .swiftpm Package.resolved
