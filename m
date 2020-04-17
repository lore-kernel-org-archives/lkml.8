Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985F0C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 14:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 798FE2076A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 14:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgDQOqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 10:46:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:43294 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726707AbgDQOqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 10:46:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 22DA4AB64;
        Fri, 17 Apr 2020 14:46:29 +0000 (UTC)
Date:   Fri, 17 Apr 2020 15:46:26 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     SeongJae Park <sjpark@amazon.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        "Huang, Ying" <ying.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Tejun Heo <tj@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Aubrey Li <aubrey.li@intel.com>
Subject: Re: Re: Re: Re: [RFC] autonuma: Support to scan page table
 asynchronously
Message-ID: <20200417144626.GA3711@suse.de>
References: <20200417121629.GA3758@techsingularity.net>
 <20200417124437.25445-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200417124437.25445-1-sjpark@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 02:44:37PM +0200, SeongJae Park wrote:
> On Fri, 17 Apr 2020 13:16:29 +0100 Mel Gorman <mgorman@techsingularity.net> wrote:
> 
> > On Fri, Apr 17, 2020 at 12:21:29PM +0200, SeongJae Park wrote:
> > > On Fri, 17 Apr 2020 12:04:17 +0200 Peter Zijlstra <peterz@infradead.org> wrote:
> > > 
> > > > On Fri, Apr 17, 2020 at 09:05:08AM +0200, SeongJae Park wrote:
> > > > > I think the main idea of DAMON[1] might be able to applied here.  Have you
> > > > > considered it?
> > > > > 
> > > > > [1] https://lore.kernel.org/linux-mm/20200406130938.14066-1-sjpark@amazon.com/
> > > > 
> > > > I've ignored that entire thing after you said the information it
> > > > provides was already available through the PMU.
> > > 
> > > Sorry if my answer made you confused.  What I wanted to say was that the
> > > fundamental access checking mechanism that DAMON depends on is PTE Accessed bit
> > > for now, but it could be modified to use PMU or other features instead. 
> > 
> > I would not be inclined to lean towards either approach for NUMA
> > balancing. Fiddling with the accessed bit can have consequences for page
> > aging and residency -- fine for debugging a problem, not to fine for
> > normal usage. I would expect the PMU approach would have high overhead
> > as well as taking over a PMU counter that userspace debugging may expect
> > to be available.
> 
> Good point.  But, isn't it ok to use Accessed bit as long as PG_Idle and
> PG_Young is adjusted properly?  Current DAMON implementation does so, as
> idle_page_tracking also does.
> 

PG_idle and PG_young are page flags that are used by idle tracking. The
accessed bit I'm thinking of is in the PTE bit and it's the PTE that
is changed by page_referenced() during reclaim. So it's not clear how
adjusting the page bits help avoid page aging problems during reclaim.

Maybe your suggestion was to move NUMA balancing to use the PG_idle and
PG_young bits from idle tracking but I'm not sure what that gains us.
This may be because I did not look too closely at DAMON as for debugging
and analysis, the PMU sounded more suitable.

It's not clear to me how looking at the page or pte bit handling of
DAMON helps us reduce the scanning cost of numa balancing. There may
be some benefit in splitting the address space and rescanning sections
that were referenced but it has similar pitfalls to simply tracking the
highest/lowest address that trapped a NUMA hinting fault.

-- 
Mel Gorman
SUSE Labs
