# PalSphere Palworld Data

Structured Palworld game data in JSON and CSV: every Pal species, item, crafting recipe, skill, and unique breeding combination, extracted from the Palworld client data tables.

This dataset powers [PalSphere](https://palsphere.app), a free Palworld database with a [breeding calculator](https://palsphere.app/breeding), [PalDex](https://palsphere.app/dex), [interactive map](https://palsphere.app/map), and [item encyclopedia](https://palsphere.app/items).

- **Game version:** Palworld 1.0.5
- **Contract:** `sphere-data/v1` (stable IDs and field names within v1)
- **Updates:** synced weekly from [palsphere.app/data](https://palsphere.app/data) after each game patch
- **Methodology:** [how the data is extracted and checked](https://palsphere.app/methodology)

## Datasets

| Dataset | Records | JSON | CSV | What it contains |
|---|---|---|---|---|
| Species | 333 | [species.json](data/species.json) | [species.csv](data/species.csv) | Pal stats, elements, work suitability, rarity, breeding power (`combiRank`) |
| Items | 1,600 | [items.json](data/items.json) | [items.csv](data/items.csv) | Item groups and variants from the item tables |
| Recipes | 1,437 | [recipes.json](data/recipes.json) | [recipes.csv](data/recipes.csv) | Crafting recipes keyed by product item id |
| Skills | 705 | [skills.json](data/skills.json) | [skills.csv](data/skills.csv) | Active, partner, and passive skills |
| Unique breeding | 257 | [breeding-unique.json](data/breeding-unique.json) | [breeding-unique.csv](data/breeding-unique.csv) | Fixed parent pairs that override the breeding-power formula |

[`data/manifest.json`](data/manifest.json) lists every dataset with its record count, game version, and extraction time.

### Stable IDs

Records are keyed by `codename` (the internal game id, e.g. `BadCatgirl`), `id`, or `slug` (the URL-friendly name, e.g. `nyafia`). A species `slug` maps directly to its page: `https://palsphere.app/pals/{slug}`.

## Quick start

Python:

```python
import pandas as pd

species = pd.read_csv("https://raw.githubusercontent.com/palsphere/palsphere-data/main/data/species.csv")
print(species[species["elements"].str.contains("Dark")].head())
```

JavaScript:

```js
const res = await fetch("https://palsphere.app/data/v1/species.json");
const species = await res.json();
```

## How breeding works in this data

Each Pal has a `combiRank` (breeding power). For two parents that are not a fixed pair, the child is the breedable Pal whose `combiRank` is closest to the average of the parents' values. Pairs listed in `breeding-unique` always produce their fixed child instead. The [PalSphere breeding calculator](https://palsphere.app/breeding) applies these rules, including reverse lookups and multi-generation pathways.

## License and attribution

The structured data is free for personal, educational, and non-commercial use with attribution. See [LICENSE.md](LICENSE.md).

Please credit **PalSphere** with a link to [palsphere.app](https://palsphere.app). GitHub's "Cite this repository" button gives a ready-made citation.

Palworld and all related names and assets are the property of Pocketpair, Inc. This is an unofficial fan project and is not affiliated with or endorsed by Pocketpair.

## Corrections

Spotted a wrong value? Open an issue here or use the [corrections page](https://palsphere.app/corrections).
