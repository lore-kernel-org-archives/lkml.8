Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4121BC3B187
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 22:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 084BB2168B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 22:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="dkQC8+2v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbgBLWpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 17:45:52 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40972 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbgBLWpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 17:45:52 -0500
Received: by mail-qt1-f195.google.com with SMTP id l21so2934595qtr.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 14:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T+slR/8k3K/A7X8xhg/atl2wex+ILEvU5H0qgTq/uiA=;
        b=dkQC8+2vW0MKn8gVBNJpUJrYR/Niw5b8LKKDEH1uxhG3LW2qFFPCnK9tT+MilsA5wI
         6Q5OeVCfmV5xlGfPk01Jfg5zxA0KsK/PaIefvpQzyl+UyWLcl6vjATTeiC8TpWnUXHys
         5ARJuWH0Clin5QHLqBq4sm12UkY0w6e/Bx77o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T+slR/8k3K/A7X8xhg/atl2wex+ILEvU5H0qgTq/uiA=;
        b=kzxkYN4VXahiTjGZMjvzuzYIMHWgYexqzWktgUI1e7Wn+b82n706mXgsczhCu43lT4
         GupaCGN5eAlZO1KMibvxMw4mAemCX0OR56mOCynKPn/mqBAzjVSlUn9JmtKSDQ7kQHOP
         lB3/+GqR2AmDy8NdtYcFnjsJ+dUp1CFlLr3bOW5RqPtmk6GICMZ4igo0l0NkEI1FumvY
         95laKoWHHzpE3cY/a4wzF0r3stnAILATpnXYr8YJjl29m73XvZvTnkLi8JxQsp0GPVTQ
         McZfChAcpainXoGpSUY9KSpoIinP8bmp7z8nQSQeSbjZ+ELHqjTbx1SWwL38SH0PTuba
         IgAA==
X-Gm-Message-State: APjAAAXZuR2lVyd09bY0Qwu3+bldcb+qZ0GCLsX4BKva0WIqVhWOG/UA
        pi99pbq8VCsdRhRDkIs9rxcp0QCw0TYSEmk45w9BvIC7vpw=
X-Google-Smtp-Source: APXvYqwRl65WifNuXTGnHPbwUO0xN9H8/itBX7JfWkXDeJseg0fSadUZ4azXk/PWVJ/z3tDq914pv+i7/Nzwo2HUyAY=
X-Received: by 2002:ac8:7309:: with SMTP id x9mr13415375qto.338.1581547550249;
 Wed, 12 Feb 2020 14:45:50 -0800 (PST)
MIME-Version: 1.0
References: <CABWYdi1eOUD1DHORJxTsWPMT3BcZhz++xP1pXhT=x4SgxtgQZA@mail.gmail.com>
 <20200211101627.GJ3466@techsingularity.net>
In-Reply-To: <20200211101627.GJ3466@techsingularity.net>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Wed, 12 Feb 2020 14:45:39 -0800
Message-ID: <CABWYdi36O_Gd6=CVZkxY6RR8r4EKzEngScngT5VZc9-x4TB=3w@mail.gmail.com>
Subject: Re: Reclaim regression after 1c30844d2dfe
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     linux-mm@kvack.org, linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a typical graph: https://imgur.com/a/n03x5yH

* Green (numa0) and blue (numa1) for 4.19
* Yellow (numa0) and orange (numa1) for 5.4

These downward slopes on numa0 on 5.4 are somewhat typical to the
worst case scenario.

If I try to clean up data a bit from a bunch of machines, this is how
numa0 compares to numa1 with 1h average values of free memory above
5GiB:

* https://imgur.com/a/6T4rRzi

I think it's safe to say that numa0 is much much worse, but I cannot
be 100% sure that numa1 is free from adverse effects, they may be just
hiding in the noise caused by rolling reboots.


On Tue, Feb 11, 2020 at 2:16 AM Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Fri, Feb 07, 2020 at 02:54:43PM -0800, Ivan Babrou wrote:
> > This change from 5.5 times:
> >
> > * https://github.com/torvalds/linux/commit/1c30844d2dfe
> >
> > > mm: reclaim small amounts of memory when an external fragmentation event occurs
> >
> > Introduced undesired effects in our environment.
> >
> > * NUMA with 2 x CPU
> > * 128GB of RAM
> > * THP disabled
> > * Upgraded from 4.19 to 5.4
> >
> > Before we saw free memory hover at around 1.4GB with no spikes. After
> > the upgrade we saw some machines decide that they need a lot more than
> > that, with frequent spikes above 10GB, often only on a single numa
> > node.
> >
> > We can see kswapd quite active in balance_pgdat (it didn't look like
> > it slept at all):
> >
> > $ ps uax | fgrep kswapd
> > root       1850 23.0  0.0      0     0 ?        R    Jan30 1902:24 [kswapd0]
> > root       1851  1.8  0.0      0     0 ?        S    Jan30 152:16 [kswapd1]
> >
> > This in turn massively increased pressure on page cache, which did not
> > go well to services that depend on having a quick response from a
> > local cache backed by solid storage.
> >
> > Here's how it looked like when I zeroed vm.watermark_boost_factor:
> >
> > * https://imgur.com/a/6IZWicU
> >
> > IO subsided from 100% busy in page cache population at 300MB/s on a
> > single SATA drive down to under 100MB/s.
> >
> > This sort of regression doesn't seem like a good thing.
>
> It is not a good thing, so thanks for the report. Obviously I have not
> seen something similar or least not severe enough to show up on my radar.
> I'd seen some increases with reclaim activity affecting benchmarks that
> rely on use-twice data remaining resident but nothing severe enough to
> warrant action.
>
> Can you tell me if it is *always* node 0 that shows crazy activity? I
> ask because some conditions would have to be met for the boost to always
> apply. It's already a per-zone attribute but it is treated indirectly as a
> pgdat property. What I'm thinking is that on node 0, the DMA32 or DMA zone
> gets boosted but vmscan then reclaims from higher zones until the boost is
> removed. That would excessively reclaim memory but be specific to node 0.
>
> I've cc'd Rik as he says he saw something similar even on single node
> systems. The boost applying to lower zones would still affect single
> node systems but NUMA machines always getting impacted by boost would
> show that the boost really needs to be a per-node flag. Sure, we *could*
> apply the reclaim to just the lower zones but that potentially means a
> *lot* of scan activity -- potentially 124G of pages before a lower zone
> page is found on Ivan's machine. That might be the very situation being
> encountered here.
>
> An alternative is that boosting is only ever applied to the highest
> populated zone in a system. The intent of the patch was primarily about
> THP which can use any zone to reduce their allocaation latency. While
> it's possible that there are cases where the latency of other orders
> matter *and* they require lower zones, I think it's unlikely and that
> this would be a safer option overall.
>
> However, overall I think the simpliest is to abort the boosting if
> reclaim is reaching higher priorities without being able to clear
> the boost. The boost is best-effort to reduce allocation latency in
> the future. This approach still has some overhead as there is a reclaim
> pass but kswapd will abort and go to sleep if the normal watermarks
> are met.
>
> This is build tested only. Ideally someone on the cc has a test case
> that can reproduce this specific problem of excessive kswapd activity.
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 572fb17c6273..71dd47172cef 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -3462,6 +3462,25 @@ static bool pgdat_balanced(pg_data_t *pgdat, int order, int classzone_idx)
>         return false;
>  }
>
> +static void acct_boosted_reclaim(pg_data_t *pgdat, int classzone_idx,
> +                               unsigned long *zone_boosts)
> +{
> +       struct zone *zone;
> +       unsigned long flags;
> +       int i;
> +
> +       for (i = 0; i <= classzone_idx; i++) {
> +               if (!zone_boosts[i])
> +                       continue;
> +
> +               /* Increments are under the zone lock */
> +               zone = pgdat->node_zones + i;
> +               spin_lock_irqsave(&zone->lock, flags);
> +               zone->watermark_boost -= min(zone->watermark_boost, zone_boosts[i]);
> +               spin_unlock_irqrestore(&zone->lock, flags);
> +       }
> +}
> +
>  /* Clear pgdat state for congested, dirty or under writeback. */
>  static void clear_pgdat_congested(pg_data_t *pgdat)
>  {
> @@ -3654,9 +3673,17 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int classzone_idx)
>                 if (!nr_boost_reclaim && balanced)
>                         goto out;
>
> -               /* Limit the priority of boosting to avoid reclaim writeback */
> -               if (nr_boost_reclaim && sc.priority == DEF_PRIORITY - 2)
> -                       raise_priority = false;
> +               /*
> +                * Abort boosting if reclaiming at higher priority is not
> +                * working to avoid excessive reclaim due to lower zones
> +                * being boosted.
> +                */
> +               if (nr_boost_reclaim && sc.priority == DEF_PRIORITY - 2) {
> +                       acct_boosted_reclaim(pgdat, classzone_idx, zone_boosts);
> +                       boosted = false;
> +                       nr_boost_reclaim = 0;
> +                       goto restart;
> +               }
>
>                 /*
>                  * Do not writeback or swap pages for boosted reclaim. The
> @@ -3738,18 +3765,7 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int classzone_idx)
>  out:
>         /* If reclaim was boosted, account for the reclaim done in this pass */
>         if (boosted) {
> -               unsigned long flags;
> -
> -               for (i = 0; i <= classzone_idx; i++) {
> -                       if (!zone_boosts[i])
> -                               continue;
> -
> -                       /* Increments are under the zone lock */
> -                       zone = pgdat->node_zones + i;
> -                       spin_lock_irqsave(&zone->lock, flags);
> -                       zone->watermark_boost -= min(zone->watermark_boost, zone_boosts[i]);
> -                       spin_unlock_irqrestore(&zone->lock, flags);
> -               }
> +               acct_boosted_reclaim(pgdat, classzone_idx, zone_boosts);
>
>                 /*
>                  * As there is now likely space, wakeup kcompact to defragment
