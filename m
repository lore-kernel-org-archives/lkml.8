Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD13C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 16:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 123C120760
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 16:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729597AbgFVQZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 12:25:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:49938 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729414AbgFVQZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 12:25:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DA327C22A;
        Mon, 22 Jun 2020 16:25:04 +0000 (UTC)
Date:   Mon, 22 Jun 2020 17:25:01 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        ????????? <jaewon31.kim@samsung.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jaewon31.kim@gmail.com" <jaewon31.kim@gmail.com>,
        ????????? <ytk.lee@samsung.com>,
        ????????? <cmlaika.kim@samsung.com>
Subject: Re: [PATCH v4] page_alloc: consider highatomic reserve in watermark
 fast
Message-ID: <20200622162501.GJ3129@suse.de>
References: <20200622091107.GC31426@dhcp22.suse.cz>
 <20200619235958.11283-1-jaewon31.kim@samsung.com>
 <CGME20200619055816epcas1p184da90b01aff559fe3cd690ebcd921ca@epcms1p6>
 <20200622094020epcms1p639cc33933fbb7a9d578adb16a6ea0734@epcms1p6>
 <20200622100439.GQ3183@techsingularity.net>
 <20200622142304.GD31426@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200622142304.GD31426@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 04:23:04PM +0200, Michal Hocko wrote:
> On Mon 22-06-20 11:04:39, Mel Gorman wrote:
> > On Mon, Jun 22, 2020 at 06:40:20PM +0900, ????????? wrote:
> > > >But more importantly, I have hard time to follow why we need both
> > > >zone_watermark_fast and zone_watermark_ok now. They should be
> > > >essentially the same for anything but order == 0. For order 0 the
> > > >only difference between the two is that zone_watermark_ok checks for
> > > >ALLOC_HIGH resp ALLOC_HARDER, ALLOC_OOM. So what is exactly fast about
> > > >the former and why do we need it these days?
> > > > 
> > > 
> > > I think the author, Mel, may ansewr. But I think the wmark_fast may
> > > fast by 1) not checking more condition about wmark and 2) using inline
> > > rather than function. According to description on commit 48ee5f3696f6,
> > > it seems to bring about 4% improvement.
> > > 
> > 
> > The original intent was that watermark checks were expensive as some of the
> > calculations are only necessary when a zone is relatively low on memory
> > and the check does not always have to be 100% accurate. This is probably
> > still true given that __zone_watermark_ok() makes a number of calculations
> > depending on alloc flags even if a zone is almost completely free.
> 
> OK, so we are talking about 
> 	if (alloc_flags & ALLOC_HIGH)
> 		min -= min / 2;
> 
> 	if (unlikely((alloc_flags & (ALLOC_HARDER|ALLOC_OOM))) {
> 		/*
> 		 * OOM victims can try even harder than normal ALLOC_HARDER
> 		 * users on the grounds that it's definitely going to be in
> 		 * the exit path shortly and free memory. Any allocation it
> 		 * makes during the free path will be small and short-lived.
> 		 */
> 		if (alloc_flags & ALLOC_OOM)
> 			min -= min / 2;
> 		else
> 			min -= min / 4;
> 	}
> 
> Is this something even measurable and something that would justify a
> complex code? If we really want to keep it even after these changes
> which are making the two closer in the cost then can we have it
> documented at least?

It was originally documented as being roughly 4% for a page allocator
micro-benchmark but that was 4 years ago and I do not even remember what
type of machine that was on. Chances are the relative cost is different
now but I haven't measured it as the microbenchmark in question doesn't
even compile with recent kernels. For many allocations, the bulk of the
allocation cost is zeroing the page so I have no particular objection
to zone_watermark_fast being removed if it makes the code easier to
read. While I have not looked recently, the cost of allocation in general
and the increasing scope of the zone->lock with larger NUMA nodes for
high-order allocations like THP are more of a concern than two branches
and potentially two minor calculations.

-- 
Mel Gorman
SUSE Labs
