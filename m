Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E971BC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 15:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0550206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 15:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbgDTPnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 11:43:23 -0400
Received: from foss.arm.com ([217.140.110.172]:51306 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbgDTPnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 11:43:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9017F31B;
        Mon, 20 Apr 2020 08:43:22 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 74FBE3F73D;
        Mon, 20 Apr 2020 08:43:20 -0700 (PDT)
Date:   Mon, 20 Apr 2020 16:43:18 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yury Norov <yury.norov@gmail.com>,
        Paul Turner <pjt@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Josh Don <joshdon@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] cpumask: Make cpumask_any() truly random
Message-ID: <20200420154317.klwoztvdybmvykwe@e107158-lin.cambridge.arm.com>
References: <20200414150556.10920-1-qais.yousef@arm.com>
 <20200414150556.10920-3-qais.yousef@arm.com>
 <20200414121956.3687d6e9@gandalf.local.home>
 <20200415093617.GZ20730@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200415093617.GZ20730@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/15/20 11:36, Peter Zijlstra wrote:
> On Tue, Apr 14, 2020 at 12:19:56PM -0400, Steven Rostedt wrote:
> 
> > > +/**
> > > + * cpumask_any - pick a "random" cpu from *srcp
> > > + * @srcp: the input cpumask
> > > + *
> > > + * Returns >= nr_cpu_ids if no cpus set.
> > > + */
> > > +int cpumask_any(const struct cpumask *srcp)
> > > +{
> > > +	int next, prev;
> > > +
> > > +	/* NOTE: our first selection will skip 0. */
> > > +	prev = __this_cpu_read(distribute_cpu_mask_prev);
> > > +
> > > +	next = cpumask_next(prev, srcp);
> > > +	if (next >= nr_cpu_ids)
> > > +		next = cpumask_first(srcp);
> > > +
> > > +	if (next < nr_cpu_ids)
> > > +		__this_cpu_write(distribute_cpu_mask_prev, next);
> > 
> > Do we care if this gets preempted and migrated to a new CPU where we read
> > "prev" from one distribute_cpu_mask_prev on one CPU and write it to another
> > CPU?
> 
> I don't think we do; that just adds to the randomness ;-), but you do

Yep we don't care and it should enhance the randomness.

> raise a good point in that __this_cpu_*() ops assume preemption is
> already disabled, which is true of the one exiting
> cpumask_any_and_distribute() caller, but is no longer true after patch
> 1, and this patch repeats the mistake.
> 
> So either we need to disable preemption across the function or
> transition to this_cpu_*() ops.

Sorry wasn't aware about the preemption check in __this_cpu_write().

Transitioning to this_cpu_write() makes sense. Unless Josh comes back it'll
break something he noticed.

Thanks

--
Qais Yousef
