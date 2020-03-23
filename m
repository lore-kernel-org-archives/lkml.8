Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04C7C4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 13:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ED3C2072D
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 13:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbgCWNzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 09:55:49 -0400
Received: from outbound-smtp20.blacknight.com ([46.22.139.247]:39937 "EHLO
        outbound-smtp20.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728423AbgCWNzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 09:55:49 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp20.blacknight.com (Postfix) with ESMTPS id C1D381C39EB
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 13:55:46 +0000 (GMT)
Received: (qmail 6084 invoked from network); 23 Mar 2020 13:55:46 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 23 Mar 2020 13:55:46 -0000
Date:   Mon, 23 Mar 2020 13:55:44 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Phil Auld <pauld@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] sched/fair: Track efficiency of select_idle_sibling
Message-ID: <20200323135544.GG3818@techsingularity.net>
References: <20200320151245.21152-1-mgorman@techsingularity.net>
 <20200320151245.21152-2-mgorman@techsingularity.net>
 <jhj369zmc65.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <jhj369zmc65.mognet@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 01:30:10PM +0000, Valentin Schneider wrote:
> 
> Hi Mel,
> 
> On Fri, Mar 20 2020, Mel Gorman wrote:
> > SIS Search: Number of calls to select_idle_sibling
> >
> > SIS Domain Search: Number of times the domain was searched because the
> >       fast path failed.
> >
> > SIS Scanned: Generally the number of runqueues scanned but the fast
> >       path counts as 1 regardless of the values for target, prev
> >       and recent.
> >
> > SIS Domain Scanned: Number of runqueues scanned during a search of the
> >       LLC domain.
> >
> > SIS Failures: Number of SIS calls that failed to find an idle CPU
> >
> 
> Let me put my changelog pedant hat on; it would be nice to explicitely
> separate the 'raw' stats (i.e. those that you are adding to sis()) to
> the downstream ones.
> 
> AIUI the ones above here are the 'raw' stats (except "SIS Domain
> Scanned", I'm not sure I get where this one comes from?), and the ones
> below are the downstream, post-processed ones.
> 

I can fix that up.

> > SIS Search Efficiency: A ratio expressed as a percentage of runqueues
> >       scanned versus idle CPUs found. A 100% efficiency indicates that
> >       the target, prev or recent CPU of a task was idle at wakeup. The
> >       lower the efficiency, the more runqueues were scanned before an
> >       idle CPU was found.
> >
> > SIS Domain Search Efficiency: Similar, except only for the slower SIS
> >       patch.
> >
> > SIS Fast Success Rate: Percentage of SIS that used target, prev or
> >       recent CPUs.
> >
> > SIS Success rate: Percentage of scans that found an idle CPU.
> >
> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> 
> With the nits taken into account:
> 
> Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
> 
> > ---
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 1dea8554ead0..9d32a81ece08 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -6150,6 +6153,15 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
> >       struct sched_domain *sd;
> >       int i, recent_used_cpu;
> >
> > +	schedstat_inc(this_rq()->sis_search);
> > +
> > +	/*
> > +	 * Checking if prev, target and recent is treated as one scan. A
> > +	 * perfect hit on one of those is considered 100% efficiency.
> > +	 * Further scanning impairs efficiency.
> > +	 */
> > +	schedstat_inc(this_rq()->sis_scanned);
> > +
> 
> You may want to move that sis_scanned increment to below the 'symmetric'
> label. Also, you should instrument select_idle_capacity() with
> sis_scanned increments, if only for the sake of completeness.
> 

Yes, that would make more sense. Instrumenting select_idle_capacity is
trivial so I'll fix that up too. 

> One last thing: each of the new schedstat_inc() callsites use this_rq();
> IIRC because of the RELOC_HIDE() hiding underneath there's very little
> chance of the compiler caching this. However, this depends on schedstat,
> so I suppose that is fine.
> 

It's a deliberate choice so that when schedstat is disabled there is no
cost. While some schedstat sites lookup the current runqueue, not all of
them do. This might be a little wasteful when schedstats are enabled but
at least it's consistent.

Thanks

-- 
Mel Gorman
SUSE Labs
