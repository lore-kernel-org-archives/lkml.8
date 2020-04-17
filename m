Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AB1C352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 12:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBEA720644
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 12:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbgDQMQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 08:16:46 -0400
Received: from outbound-smtp54.blacknight.com ([46.22.136.238]:51915 "EHLO
        outbound-smtp54.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728071AbgDQMQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 08:16:45 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp54.blacknight.com (Postfix) with ESMTPS id 705E1FAB1D
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 13:16:43 +0100 (IST)
Received: (qmail 20170 invoked from network); 17 Apr 2020 12:16:43 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 17 Apr 2020 12:16:43 -0000
Date:   Fri, 17 Apr 2020 13:16:29 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     SeongJae Park <sjpark@amazon.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Huang, Ying" <ying.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Rik van Riel <riel@surriel.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Tejun Heo <tj@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Aubrey Li <aubrey.li@intel.com>
Subject: Re: Re: Re: [RFC] autonuma: Support to scan page table asynchronously
Message-ID: <20200417121629.GA3758@techsingularity.net>
References: <20200417100417.GT20730@hirez.programming.kicks-ass.net>
 <20200417102129.23399-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200417102129.23399-1-sjpark@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 12:21:29PM +0200, SeongJae Park wrote:
> On Fri, 17 Apr 2020 12:04:17 +0200 Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Fri, Apr 17, 2020 at 09:05:08AM +0200, SeongJae Park wrote:
> > > I think the main idea of DAMON[1] might be able to applied here.  Have you
> > > considered it?
> > > 
> > > [1] https://lore.kernel.org/linux-mm/20200406130938.14066-1-sjpark@amazon.com/
> > 
> > I've ignored that entire thing after you said the information it
> > provides was already available through the PMU.
> 
> Sorry if my answer made you confused.  What I wanted to say was that the
> fundamental access checking mechanism that DAMON depends on is PTE Accessed bit
> for now, but it could be modified to use PMU or other features instead. 

I would not be inclined to lean towards either approach for NUMA
balancing. Fiddling with the accessed bit can have consequences for page
aging and residency -- fine for debugging a problem, not to fine for
normal usage. I would expect the PMU approach would have high overhead
as well as taking over a PMU counter that userspace debugging may expect
to be available.

-- 
Mel Gorman
SUSE Labs
