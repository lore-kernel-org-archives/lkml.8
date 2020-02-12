Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DEDCC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 07:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB0D6206DB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 07:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbgBLHni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 02:43:38 -0500
Received: from outbound-smtp53.blacknight.com ([46.22.136.237]:43227 "EHLO
        outbound-smtp53.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727669AbgBLHni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 02:43:38 -0500
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp53.blacknight.com (Postfix) with ESMTPS id 55DD3FAE23
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 07:43:36 +0000 (GMT)
Received: (qmail 4764 invoked from network); 12 Feb 2020 07:43:36 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 12 Feb 2020 07:43:35 -0000
Date:   Wed, 12 Feb 2020 07:43:33 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, shakeelb@google.com,
        yang.shi@linux.alibaba.com
Subject: Re: [RFC Patch] mm/vmscan.c: not inherit classzone_idx from previous
 reclaim
Message-ID: <20200212074333.GM3466@techsingularity.net>
References: <20200209074145.31389-1-richardw.yang@linux.intel.com>
 <20200211104223.GL3466@techsingularity.net>
 <20200212022554.GA7855@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200212022554.GA7855@richard>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 10:25:55AM +0800, Wei Yang wrote:
> On Tue, Feb 11, 2020 at 10:42:23AM +0000, Mel Gorman wrote:
> >On Sun, Feb 09, 2020 at 03:41:45PM +0800, Wei Yang wrote:
> >> Before commit e716f2eb24de ("mm, vmscan: prevent kswapd sleeping
> >> prematurely due to mismatched classzone_idx"), classzone_idx could have
> >> two possibilities on a new loop based on whether there is a wakeup
> >> during reclaiming:
> >> 
> >>   * 0 if no wakeup
> >>   * the classzone_idx request by wakeup
> >> 
> >> As described in the changelog, this commit is willing to change the
> >> first case to (MAX_NR_ZONES - 1) to avoid some premature sleep. But it
> >> does not achieve the goal.
> >> 
> >> There are two versions of kswapd_classzone_idx() since this change:
> >> 
> >>   * commit e716f2eb24de ("mm, vmscan: prevent kswapd sleeping
> >>     prematurely due to mismatched classzone_idx")
> >>   * commit dffcac2cb88e ("mm/vmscan.c: prevent useless kswapd loops")
> >> 
> >> Both of them would return the classzone_idx we passed as the 2nd
> >> parameter when (pgdat->kswapd_classzone_idx == MAX_NR_ZONES). This
> >> means if there is no wakeup during reclaiming, we would use
> >> classzone_idx in previous round to sleep.
> >> 
> >
> >This is somewhat intended.
> >
> >> This patch fixes the logic by using (MAX_NR_ZONES - 1) for the first
> >> case.
> >> 
> >
> >Ok, what is the user-visible impact that is fixed by this patch or is
> >this based on code review only? Please describe the test case exactly
> >and the before and after results. I ask because this area is a magnet for
> >regressions and intuitive ideas often lead to counter-intuitive results.
> >
> 
> This is based on code review only. I know your concern. This is an area more
> like art then engineering :-)
> 

Then I'm afraid that until there is a corner case identified and a
description of the impact it's

Nacked-by: Mel Gorman <mgorman@techsingularity.net>

> Would you mind sharing some idea why we intend to inherit the classzone_idx?
> And for kswapd_order, we would restart at 0 if no wakeup during reclaim.
> 

Broadly speaking it was driven by cases whereby kswapd either a) fell
asleep prematurely and there were many stalls in direct reclaim before
kswapd recovered, b) stalls in direct reclaim immediately after kswapd went
to sleep or c) kswapd reclaimed for lower zones and went to sleep while
parallel tasks were direct reclaiming in higher zones or higher orders.

-- 
Mel Gorman
SUSE Labs
