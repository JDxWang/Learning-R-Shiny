# Overview

I am learning to write R shiny visualisation apps in this project.

It also involves some basic HTML scraping with the package `rvest`.

You can find the current version here: https://jdxwang.shinyapps.io/ozbargain_tags/

The app runs a lot faster locally if you're from Australia. The one hosted at shinyapps.io takes a moment to load.

# Description

OzBargain is an Australian website that allows users to post "deals" (i.e. discounts, promotions, sales, etc.) from other websites or stores.

Each deal will have one or more associated tags. E.g. A deal of discounted laptops will have the tag "Computing".

The app in its current state will retrieve the first X pages of newest deals and present a pie chart of the frequency of each tag.

# Completed Features

1. The user can choose the number of pages, X, of deals to load (up to 10 to avoid potential issues with OzBargain's server).

# Roadmap

I am looking to add the following features:

1. Improve the visuals of the pie chart.
2. Have an interactive chart where the user can see the top deal (the deal with most user likes) of each tag.
3. The user can see all deals under each tag via external links to OzBargain.
4. Tables that list popular deals (OzBargain have this feature but the threshold for "popular" is rather high)

# Side project

Potentially I can write a notification bot that searches user input keywords and notifies them if a matching deal has been posted via a messaging platform of their choice.
