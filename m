Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF8DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 17:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBCC420656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 17:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIu0IhIm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbgHURIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 13:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728219AbgHUQSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:18:03 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11945C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 09:18:02 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id d6so2960090ejr.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 09:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ptn3HzexirT3XdAWduQkOmakKONtwiNCxuYSboBYnto=;
        b=RIu0IhImYyZb+DCQMBwkJ+3WPSis6jTVueamCSe5QQipks9UerbYdyD8Sq4CLTzzNk
         XTVnXAq/vHXlH/jKZsfTBdR8qbQzJxrWAomXDLBlKiNGK3tYbaNSdTTRiIRetwiTZ3Q9
         a+sQ0FP2pAqHggqQFBJNTPDLS7XiuUSb8nNxkchFktftLWgLOqvuvwi9+VDrRfM8Td9W
         Jt6kAy3v6P4EOnxQEbw96hCMvOUQMKkXa2VOts+BmZ4Ov7+MrlVefcMGlH08eDTAV7zk
         2HckMpr7tM+UN4J4i//sprE9bCobWntwzz6+4jCT2kWtV+893cVCvC3PAN2kX6yVst0T
         7t5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ptn3HzexirT3XdAWduQkOmakKONtwiNCxuYSboBYnto=;
        b=NHBV+e6vMOt5oN2M7gUT1KE+yWRN41sQDWFsiMX/+HFetZQdfrVZ+7tVHe0QRFFpdf
         26zkCuO+s+VTQ1BwElAe7GJvZtEEGieSyScKYckDdwomzSSQSMIWgKamh2IvqawIUfbT
         O8+6R5xkNmRsxfkLIFPAtgpZutX2focPEVypulJynX3JMvAqkSQprUmQkZ2/d2B644hp
         KTzl047LBUosOyaNJYL3RcjUwzVKuTyRVZEDKW50y194R7olsM2yKxZtUQnxSxZ0Lw8x
         0BBeQSGqOP6hBrOmo1dtyhkCdSaCPTd1G17DEW+u7d6cQQgvEJ9KBuruaarLXS6RDKuA
         s6BA==
X-Gm-Message-State: AOAM533kGj8fA3Ji+NC2p5cLPZ8JYv8eTtmv7rA77EbARkuasW0FWdEh
        XK80MnYXLEI2toaMGK8oxTDSoigHr4KilI9D9C/n0z73uWs=
X-Google-Smtp-Source: ABdhPJy/1qSCgmfbU6wNHXKkCpa9LF5ZYhy1PGrzlWHfEx/m/36FbJHC3jvEjhB6QmM0PEA786bXcBLr3cl9AK28q7Y=
X-Received: by 2002:a17:906:84e1:: with SMTP id zp1mr3253699ejb.499.1598026680604;
 Fri, 21 Aug 2020 09:18:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200818184122.29C415DF@viggo.jf.intel.com> <20200818184131.C972AFCC@viggo.jf.intel.com>
 <87lfi9wxk9.fsf@yhuang-dev.intel.com> <6a378a57-a453-0318-924b-05dfa0a10c1f@intel.com>
 <CAHbLzkrjxm38VV+ibQxoQkC4nW7F13aJcL5RypUchX30rqUstA@mail.gmail.com> <87v9hcvmr5.fsf@yhuang-dev.intel.com>
In-Reply-To: <87v9hcvmr5.fsf@yhuang-dev.intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 21 Aug 2020 09:17:48 -0700
Message-ID: <CAHbLzkpnCSgRa1TGKk8zih7-h2bAh1N6X==rsLpSPY-n90F-ww@mail.gmail.com>
Subject: Re: [RFC][PATCH 5/9] mm/migrate: demote pages during reclaim
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 5:57 PM Huang, Ying <ying.huang@intel.com> wrote:
>
> Yang Shi <shy828301@gmail.com> writes:
>
> > On Thu, Aug 20, 2020 at 8:22 AM Dave Hansen <dave.hansen@intel.com> wrote:
> >>
> >> On 8/20/20 1:06 AM, Huang, Ying wrote:
> >> >> +    /* Migrate pages selected for demotion */
> >> >> +    nr_reclaimed += demote_page_list(&ret_pages, &demote_pages, pgdat, sc);
> >> >> +
> >> >>      pgactivate = stat->nr_activate[0] + stat->nr_activate[1];
> >> >>
> >> >>      mem_cgroup_uncharge_list(&free_pages);
> >> >> _
> >> > Generally, it's good to batch the page migration.  But one side effect
> >> > is that, if the pages are failed to be migrated, they will be placed
> >> > back to the LRU list instead of falling back to be reclaimed really.
> >> > This may cause some issue in some situation.  For example, if there's no
> >> > enough space in the PMEM (slow) node, so the page migration fails, OOM
> >> > may be triggered, because the direct reclaiming on the DRAM (fast) node
> >> > may make no progress, while it can reclaim some pages really before.
> >>
> >> Yes, agreed.
> >
> > Kind of. But I think that should be transient and very rare. The
> > kswapd on pmem nodes will be waken up to drop pages when we try to
> > allocate migration target pages. It should be very rare that there is
> > not reclaimable page on pmem nodes.
> >
> >>
> >> There are a couple of ways we could fix this.  Instead of splicing
> >> 'demote_pages' back into 'ret_pages', we could try to get them back on
> >> 'page_list' and goto the beginning on shrink_page_list().  This will
> >> probably yield the best behavior, but might be a bit ugly.
> >>
> >> We could also add a field to 'struct scan_control' and just stop trying
> >> to migrate after it has failed one or more times.  The trick will be
> >> picking a threshold that doesn't mess with either the normal reclaim
> >> rate or the migration rate.
> >
> > In my patchset I implemented a fallback mechanism via adding a new
> > PGDAT_CONTENDED node flag. Please check this out:
> > https://patchwork.kernel.org/patch/10993839/.
> >
> > Basically the PGDAT_CONTENDED flag will be set once migrate_pages()
> > return -ENOMEM which indicates the target pmem node is under memory
> > pressure, then it would fallback to regular reclaim path. The flag
> > would be cleared by clear_pgdat_congested() once the pmem node memory
> > pressure is gone.
>
> There may be some races between the flag set and clear.  For example,
>
> - try to migrate some pages from DRAM node to PMEM node
>
> - no enough free pages on the PMEM node, so wakeup kswapd
>
> - kswapd on PMEM node reclaimed some page and try to clear
>   PGDAT_CONTENDED on DRAM node
>
> - set PGDAT_CONTENDED on DRAM node

Yes, the race is true. Someone else may set PGDAT_CONTENDED, but pmem
node's kswapd already went to sleep, so the flag might be not be able
to be cleared for a while.

I think this can be solved easily. We can just move the flag set to
kswapd. Once kswapd is waken up we know there is kind of memory
pressure on that node, then set the flag, clear the flag when kswapd
goes to sleep. kswapd is single threaded and just set/clear its own
node's flag, so there should be no race if I don't miss something.

>
> This may be resolvable.  But I still prefer to fallback to real page
> reclaiming directly for the pages failed to be migrated.  That looks
> more robust.
>
> Best Regards,
> Huang, Ying
>
> > We already use node flags to indicate the state of node in reclaim
> > code, i.e. PGDAT_WRITEBACK, PGDAT_DIRTY, etc. So, adding a new flag
> > sounds more straightforward to me IMHO.
> >
> >>
> >> This is on my list to fix up next.
> >>
