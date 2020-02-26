Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2827DC4BA0B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 09:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E91ED20732
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 09:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582707940;
	bh=5UnL/bzmrjTe68ZlG0jkHBY+NvySZdaCq2G4D5mwArE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=X2pcCzv8FsPqgPq2yo7cTUxOPNAprM6swzcYc7/G6i1l3Uf/GytNYckXotg1IdGAH
	 GBjtEoZbFu2jo10rYdjRLuSCzZtSTLhv4Z2ZUBjB7DDcRH2tgl91BzfAATrBTVA2Zm
	 3XKw+IYUhcd0F7F1olUN14YzoUELucJSnes9DOBI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbgBZJFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 04:05:38 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33605 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbgBZJFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 04:05:38 -0500
Received: by mail-wm1-f65.google.com with SMTP id m10so4054547wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 01:05:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cgXOsvSprrXNpkjiGvq5ypY6eo3840ugFMQzHtJ8dnM=;
        b=AyuwFlqNHhnhkf7J+BkGf/dPJt0W4EqkV4zIOzmHAPWMc2iO91/d3y1kp+lwkPfSAh
         pz/tLWhwj2oPTdzvy/wYrMRL0TpzW2maCAPa68bGhQGFThi5InLhUGWK3fSXKKgp/6LN
         4NjwvrcNrRt+ICWZsVdHukpfyfkgYrB4TX2lSMYOWi+Fbgvn6tIXmI2sYBqum6jAVNv+
         X+pwVkI4ME3DW63OticIVGzBRwTUF22tZXos+yttUvK+l7nciNLtbhe6lB0QDmV3rAQq
         /+XK0mZaP54e4omxeq0fztyTkWRbg3ApswKGCgsUY1SaG3PCLLCVIn+6OzKajQGGgVJC
         axQA==
X-Gm-Message-State: APjAAAWVTVDpgryxng20rhNvlG/EB88AY8Fpt6ORp25OGsE2FqpZYFYp
        jwyFcADvm5pF+Ujkb9hep1U=
X-Google-Smtp-Source: APXvYqywFRzm7/vdaFBY3bRNj7mV2is2B2ICj8CuibIK0VbqZZGuIcKVmgEwvhkA9ULyxwFfR4RJig==
X-Received: by 2002:a1c:a789:: with SMTP id q131mr4354880wme.127.1582707936188;
        Wed, 26 Feb 2020 01:05:36 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id a198sm2130536wme.12.2020.02.26.01.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 01:05:35 -0800 (PST)
Date:   Wed, 26 Feb 2020 10:05:34 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Sultan Alsawaf <sultan@kerneltoast.com>
Cc:     Mel Gorman <mgorman@suse.de>, Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH] mm: Stop kswapd early when nothing's waiting for it to
 free pages
Message-ID: <20200226090534.GB3771@dhcp22.suse.cz>
References: <20200219200527.GF11847@dhcp22.suse.cz>
 <20200219204220.GA3488@sultan-book.localdomain>
 <20200219214513.GL3420@suse.de>
 <20200219224231.GA5190@sultan-book.localdomain>
 <20200220101945.GN3420@suse.de>
 <20200221042232.GA2197@sultan-book.localdomain>
 <20200221080737.GK20509@dhcp22.suse.cz>
 <20200221210824.GA3605@sultan-book.localdomain>
 <20200225090945.GJ22443@dhcp22.suse.cz>
 <20200225171242.GA496421@sultan-box.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225171242.GA496421@sultan-box.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 25-02-20 09:12:42, Sultan Alsawaf wrote:
> On Tue, Feb 25, 2020 at 10:09:45AM +0100, Michal Hocko wrote:
> > On Fri 21-02-20 13:08:24, Sultan Alsawaf wrote:
> > [...]
> > > Both of these logs are attached in a tarball.
> > 
> > Thanks! First of all
> > $ grep pswp vmstat.1582318979
> > pswpin 0
> > pswpout 0
> > 
> > suggests that you do not have any swap storage, right?
> 
> Correct. I'm not using any swap (and it should not be necessary to make Linux mm
> work of course).

In your particular situation you simply overcommit the memory way too
much AFAICS. Look at the vmstat data
vmstat.1582318758
nr_free_pages 16292
nr_page_table_pages 2822
nr_inactive_anon 8171
nr_active_anon 134168
nr_inactive_file 729
nr_active_file 508
nr_unevictable 51984
nr_slab_reclaimable 10919
nr_slab_unreclaimable 19766

This is roughly memory that we have clear accounting for (well except
for hugetlb pages but you do not seem to be using those). This is
82% of the memory. The rest is used by different kernel subsystems.
Of that only 47MB is reclaimable without invoking the OOM killer (if we
include nr_slab_reclaimable which might be quite hard to reclaim
effectively). I can imagine that could work only if the page cache
footprint was negligible but that doesn't seem to be the case here.
If you add swap storage then the math is completely different so yes the
swap is likely going to make a difference here.

> If I were to divide my RAM in half and use one half as swap,
> do you think the results would be different? IMO they shouldn't be.

That really depends on what is the swap backed memory footprint.

> > The amount of anonymous memory is not really high (~560MB) but file LRU
> > is _really_ low (~3MB), unevictable list is at ~200MB. That gets us to
> > ~760M of memory which is 74% of the memory. Please note that your mem=2G
> > setup gives you only 1G of memory in fact (based on the zone_info you
> > have posted). That is not something unusual but the amount of the page
> > cache is worrying because I would expect a heavy trashing because most
> > of the executables are going to require major faults. Anonymous memory
> > is not swapped out obviously so there is no other option than to refault
> > constantly.
> 
> I noticed that only 1G was available as well.

This is because of your physical memory layout. mem=2G doesn't restrict
the amount of the memory to 2G but rather the top physical address to
2G. If you have holes in the memory layout you are likely to get much
less memory.

> Perhaps direct reclaim wasn't
> attempted due to the zone_reclaimable_pages() check, though I don't think direct
> reclaim would've been particularly helpful in this case (see below).

there are reclaimable pages so zone_reclaimable_pages shouldn't really
stop DR for the zone Normal.

> > kswapd has some feedback mechanism to back off when the zone is hopless
> > from the reclaim point of view AFAIR but it seems it has failed in this
> > particular situation. It should have relied on the direct reclaim and
> > eventually trigger the OOM killer. Your patch has worked around this by
> > bailing out from the kswapd reclaim too early so a part of the page
> > cache required for the code to move on would stay resident and move
> > further.
> > 
> > The proper fix should, however, check the amount of reclaimable pages
> > and back off if they cannot meet the target IMO. We cannot rely on the
> > general reclaimability here because that could really be thrashing.
> 
> Yes, my guess was that thrashing out pages used by the running programs was the
> cause for my freezes, but I didn't think of making kswapd back off a different
> way.
> 
> Right now I don't see any such back-off mechanism in kswapd.

There is pgdat->kswapd_failures >= MAX_RECLAIM_RETRIES check in prepare_kswapd_sleep
but this is not helping really, quite contrary, because kswapd is able
to reclaim page cache. The problem is that we even try to reclaim that
page cache I believe. If we have a signal that all the reclaimed memory
is essentially refaulted then we should backoff.

A simpler and probably much more subtle solution would be to back off
kswapd when zone_reclaimable_pages() < high_wmark_pages. This would push
out the work to the direct reclaim which itself is changing the overall
timing as the reclaim would be more bound to the memory demand.

> Also, if we add
> this into kswapd, we would need to plug it into the direct reclaim path as well,
> no? I don't think direct reclaim would help with the situation I've run into;
> although it wouldn't be as bad as letting kswapd evict pages to the high
> watermark, it would still cause page thrashing that would just be capped to the
> amount of pages a direct reclaimer is looking to steal.

And more importantly it would be bound to the allocating context so the
feedback mechanism would be more bound to the workload.

> Considering that my patch remedies this issue for me without invoking the OOM
> killer, a proper solution should produce the same or better results. I don't
> think the OOM killer should have been triggered in this case.

Your system is likely struggling already, it is just less visible
because kswapd reclaim is essentially faster than paging in so a single
access might trigger several refaults.
-- 
Michal Hocko
SUSE Labs
