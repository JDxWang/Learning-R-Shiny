# Overview

I am learning to write R shiny visualisation apps in this project.

It also involves some basic HTML scraping with the package `rvest`.

You can find the current version here: https://jdxwang.shinyapps.io/ozbargain_tags/

The app runs a lot faster locally if you're from Australia. The one hosted at shinyapps.io takes a moment to load.

# Description

OzBargain is an Australian website that allows users to post "deals" (i.e. discounts, promotions, sales, etc.) from other websites or stores.

Each deal will have one or more associated tags. E.g. A deal of discounted laptops will have the tag "Computing".

The app in its current state will retrieve the first X pages of newest deals and present a bar chart of the frequency of each tag.

# Example Chart

# Completed Features

1. The user can choose the number of pages, X, of deals to load (up to 10 to avoid potential issues with OzBargain's server).
2. The app reads other relevant post information.
3. Plot constructed with `ggplot`.

# Roadmap

I am looking to add the following features:

1. Have an interactive chart where the user can see the top deal (the deal with most user likes) of each tag.
2. The user can see all deals under each tag via external links to OzBargain.
3. Tables that list popular deals (OzBargain have this feature but the threshold for "popular" is rather high)

# Issues

The ordering of frequency required some inefficient workaround and I have no clue how to improve yet.

# Side project

1. Potentially I can write a notification bot that searches user input keywords and notifies them if a matching deal has been posted via a messaging platform of their choice.
2. A machine learning project where I predict the tag based on the title text.
