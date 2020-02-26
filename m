Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76EC3C4BA0A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 08:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5249521D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 08:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbgBZIEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 03:04:40 -0500
Received: from outbound-smtp27.blacknight.com ([81.17.249.195]:49168 "EHLO
        outbound-smtp27.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727223AbgBZIEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 03:04:39 -0500
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp27.blacknight.com (Postfix) with ESMTPS id 47A4ACAC76
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 08:04:36 +0000 (GMT)
Received: (qmail 14671 invoked from network); 26 Feb 2020 08:04:36 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 26 Feb 2020 08:04:36 -0000
Date:   Wed, 26 Feb 2020 08:04:26 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
        Ivan Babrou <ivan@cloudflare.com>,
        Rik van Riel <riel@surriel.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] Limit runaway reclaim due to watermark boosting
Message-ID: <20200226080426.GA3818@techsingularity.net>
References: <20200225141534.5044-1-mgorman@techsingularity.net>
 <20200225185130.6a32a8a6920d11b4c098e90e@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200225185130.6a32a8a6920d11b4c098e90e@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 06:51:30PM -0800, Andrew Morton wrote:
> On Tue, 25 Feb 2020 14:15:31 +0000 Mel Gorman <mgorman@techsingularity.net> wrote:
> 
> > Ivan Babrou reported the following
> 
> http://lkml.kernel.org/r/CABWYdi1eOUD1DHORJxTsWPMT3BcZhz++xP1pXhT=x4SgxtgQZA@mail.gmail.com
> is helpful.
> 

Noted for future reference.

> > 	Commit 1c30844d2dfe ("mm: reclaim small amounts of memory when
> > 	an external fragmentation event occurs") introduced undesired
> > 	effects in our environment.
> > 
> > 	  * NUMA with 2 x CPU
> > 	  * 128GB of RAM
> > 	  * THP disabled
> > 	  * Upgraded from 4.19 to 5.4
> > 
> > 	Before we saw free memory hover at around 1.4GB with no
> > 	spikes. After the upgrade we saw some machines decide that they
> > 	need a lot more than that, with frequent spikes above 10GB,
> > 	often only on a single numa node.
> > 
> > There have been a few reports recently that might be watermark boost
> > related. Unfortunately, finding someone that can reproduce the problem
> > and test a patch has been problematic.  This series intends to limit
> > potential damage only.
> 
> It's problematic that we don't understand what's happening.  And these
> palliatives can only reduce our ability to do that.
> 

Not for certain no, but we do know that there are conditions whereby
node 0 can end up reclaiming excessively for extended periods of time.
The available evidence does match a pattern whereby a lower zone on node
0 is getting stuck in a boosted state.

> Rik seems to have the means to reproduce this (or something similar)
> and it seems Ivan can test patches three weeks hence. 

If Rik can reproduce it great but I have a strong feeling that Ivan may
never be able to test this if it requires a production machine which is
why I did not wait the three weeks.

> So how about a
> debug patch which will help figure out what's going on in there?

A debug patch would not help much in this case given that we
have tracepoints. An ftrace containing mm_page_alloc_extfrag,
mm_vmscan_kswapd_wake, mm_vmscan_wakeup_kswapd and
mm_vmscan_node_reclaim_begin would be a big help for 30 seconds while the
problem is occurring would work. Ideally mm_vmscan_lru_shrink_inactive
would also be included to capture the priority but the size of the trace
is what's going to be problematic.

mm_page_alloc_extfrag would be correlated with the conditions that boost
the watermarks and the others would track what kswapd is doing to see if
it's persistently reclaiming. If they are, mm_vmscan_lru_shrink_inactive
would tell if it's persistently reclaiming at priority DEF_PRIORITY - 2
which would prove the patch would at least mitigate the problem.

It would be more preferable to have a description of a testcase that
reproduces the problem and I'll capture/analyse the trace myself.
It would also be something I could slot into a test grid to catch the
problem happening again in the future.

-- 
Mel Gorman
SUSE Labs
