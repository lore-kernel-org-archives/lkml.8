Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ECEAC3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 09:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C12021741
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 09:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583315889;
	bh=oxAtT37t/QUW55WYFQJAXgnKHOjMiX3jaKwrTE01Ujg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yKEZwHWBmUcABXOHViHoGDfUT55NsAKHYF2YOrZsLsHgH5pUq8bwbzk7yjJMoodG5
	 JReeUVF9agGvknG64Uo+j8AvTwsywzqDDV9ft1kQu8L6siW24OGm5BZswZH//pExQy
	 HfrSGcZcviPhM4YFCBjAYC8mUCLXaLXlSGUp4yfM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbgCDJ6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 04:58:07 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39919 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727734AbgCDJ6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 04:58:07 -0500
Received: by mail-wm1-f66.google.com with SMTP id j1so1174373wmi.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 01:58:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tGkuJq9p7Ujsv2LZVWZ4XnLUpkAhIf+I1//fbYjfoC4=;
        b=cfvfojxWJtnKVaUfOyUm8P8JazMxIi+4+nTl7dyKaYJLzITn7HHkNuwIxC5fB7FIj1
         iJQCe/GPz8oiUpifOLWe0nE3YnmPcq8m+Ud5q+Rwvm4Eyx4+6Ym9s6la0JONQWNzvLMP
         ccNu4U8b2JhbF/M09omaAnmbXO3sQQ8jmrvIrp1H9/voYQ8K6uw7fUTIjPmzZUyBAter
         d/NjRB+3Rfjh2nmlFEiOczKY/gx94Ud4EePl0jq8rpprD4g2gg25qPDbBjCzd9wmhf6a
         Kp3UtXmPJmAiFszRwZMNdGZmBvkopXtKOs698xkUQPW1ElgriheyqLBvmPlU+dAFn+CN
         oU+Q==
X-Gm-Message-State: ANhLgQ2jCQ35C/qU5r6KPEOMP2BUOlIZN2a41iOdRK1EkAAB64Oiuu0I
        t2gBI6M1ASprLP25T4QyQEo=
X-Google-Smtp-Source: ADFU+vuFxdLBbgqv3WPYMXE5mn7YP+bwIMqE1mGl64ybhaFXG9feJd6vOS3+/Qrgylc2g8UEVXyS2g==
X-Received: by 2002:a1c:2701:: with SMTP id n1mr531963wmn.180.1583315884003;
        Wed, 04 Mar 2020 01:58:04 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id u17sm13594305wrq.74.2020.03.04.01.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 01:58:03 -0800 (PST)
Date:   Wed, 4 Mar 2020 10:58:02 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Mel Gorman <mgorman@suse.de>, David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Alexander Duyck <alexander.duyck@gmail.com>
Subject: Re: [RFC 0/3] mm: Discard lazily freed pages when migrating
Message-ID: <20200304095802.GE16139@dhcp22.suse.cz>
References: <edae2736-3239-0bdc-499c-560fc234c974@redhat.com>
 <871rqf850z.fsf@yhuang-dev.intel.com>
 <20200228094954.GB3772@suse.de>
 <87h7z76lwf.fsf@yhuang-dev.intel.com>
 <20200302151607.GC3772@suse.de>
 <87zhcy5hoj.fsf@yhuang-dev.intel.com>
 <20200303080945.GX4380@dhcp22.suse.cz>
 <87o8td4yf9.fsf@yhuang-dev.intel.com>
 <20200303085805.GB4380@dhcp22.suse.cz>
 <87ftep4pzy.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ftep4pzy.fsf@yhuang-dev.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 03-03-20 19:49:53, Huang, Ying wrote:
> Michal Hocko <mhocko@kernel.org> writes:
> 
> > On Tue 03-03-20 16:47:54, Huang, Ying wrote:
> >> Michal Hocko <mhocko@kernel.org> writes:
> >> 
> >> > On Tue 03-03-20 09:51:56, Huang, Ying wrote:
> >> >> Mel Gorman <mgorman@suse.de> writes:
> >> >> > On Mon, Mar 02, 2020 at 07:23:12PM +0800, Huang, Ying wrote:
> >> >> >> If some applications cannot tolerate the latency incurred by the memory
> >> >> >> allocation and zeroing.  Then we cannot discard instead of migrate
> >> >> >> always.  While in some situations, less memory pressure can help.  So
> >> >> >> it's better to let the administrator and the application choose the
> >> >> >> right behavior in the specific situation?
> >> >> >> 
> >> >> >
> >> >> > Is there an application you have in mind that benefits from discarding
> >> >> > MADV_FREE pages instead of migrating them?
> >> >> >
> >> >> > Allowing the administrator or application to tune this would be very
> >> >> > problematic. An application would require an update to the system call
> >> >> > to take advantage of it and then detect if the running kernel supports
> >> >> > it. An administrator would have to detect that MADV_FREE pages are being
> >> >> > prematurely discarded leading to a slowdown and that is hard to detect.
> >> >> > It could be inferred from monitoring compaction stats and checking
> >> >> > if compaction activity is correlated with higher minor faults in the
> >> >> > target application. Proving the correlation would require using the perf
> >> >> > software event PERF_COUNT_SW_PAGE_FAULTS_MIN and matching the addresses
> >> >> > to MADV_FREE regions that were freed prematurely. That is not an obvious
> >> >> > debugging step to take when an application detects latency spikes.
> >> >> >
> >> >> > Now, you could add a counter specifically for MADV_FREE pages freed for
> >> >> > reasons other than memory pressure and hope the administrator knows about
> >> >> > the counter and what it means. That type of knowledge could take a long
> >> >> > time to spread so it's really very important that there is evidence of
> >> >> > an application that suffers due to the current MADV_FREE and migration
> >> >> > behaviour.
> >> >> 
> >> >> OK.  I understand that this patchset isn't a universal win, so we need
> >> >> some way to justify it.  I will try to find some application for that.
> >> >> 
> >> >> Another thought, as proposed by David Hildenbrand, it's may be a
> >> >> universal win to discard clean MADV_FREE pages when migrating if there are
> >> >> already memory pressure on the target node.  For example, if the free
> >> >> memory on the target node is lower than high watermark?
> >> >
> >> > This is already happening because if the target node is short on memory
> >> > it will start to reclaim and if MADV_FREE pages are at the tail of
> >> > inactive file LRU list then they will be dropped. Please note how that
> >> > follows proper aging and doesn't introduce any special casing. Really
> >> > MADV_FREE is an inactive cache for anonymous memory and we treat it like
> >> > inactive page cache. This is not carved in stone of course but it really
> >> > requires very good justification to change.
> >> 
> >> If my understanding were correct, the newly migrated clean MADV_FREE
> >> pages will be put at the head of inactive file LRU list instead of the
> >> tail.  So it's possible that some useful file cache pages will be
> >> reclaimed.
> >
> > This is the case also when you migrate other pages, right? We simply
> > cannot preserve the aging.
> 
> So you consider the priority of the clean MADV_FREE pages is same as
> that of page cache pages?

This is how MADV_FREE has been implemented, yes. See f7ad2a6cb9f7 ("mm:
move MADV_FREE pages into LRU_INACTIVE_FILE list") for the
justification.

> Because the penalty difference is so large, I
> think it may be a good idea to always put clean MADV_FREE pages at the
> tail of the inactive file LRU list?

You are again making assumptions without giving any actual real
examples. Reconstructing MADV_FREE pages cost can differ a lot. This
really depends on the specific usecase. Moving pages to the tail of LRU
would make them the primary candidate for the reclaim with a strange
LIFO semantic. Adding them to the head might be not the universal win
but it will at least provide a reasonable FIFO semantic. I also find
it much more easier to reason about MADV_FREE as an inactive cache.
-- 
Michal Hocko
SUSE Labs
