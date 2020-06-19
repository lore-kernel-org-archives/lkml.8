Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FC8C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 17:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93FD021531
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 17:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393652AbgFSRxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 13:53:06 -0400
Received: from foss.arm.com ([217.140.110.172]:51680 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731445AbgFSRxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 13:53:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C02972B;
        Fri, 19 Jun 2020 10:53:04 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A8623F73C;
        Fri, 19 Jun 2020 10:53:03 -0700 (PDT)
Date:   Fri, 19 Jun 2020 18:53:00 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Chris Redpath <chrid.redpath@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] sched/uclamp: Protect uclamp fast path code with
 static key
Message-ID: <20200619175300.sqqdeu6qug3ilnfd@e107158-lin.cambridge.arm.com>
References: <20200618195525.7889-1-qais.yousef@arm.com>
 <20200618195525.7889-3-qais.yousef@arm.com>
 <20200619174510.GB576888@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200619174510.GB576888@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/19/20 19:45, Peter Zijlstra wrote:
> On Thu, Jun 18, 2020 at 08:55:25PM +0100, Qais Yousef wrote:
> 
> > +/*
> > + * This static key is used to reduce the uclamp overhead in the fast path. It
> > + * only disables the call to uclamp_rq_{inc, dec}() in enqueue/dequeue_task().
> > + *
> > + * This allows users to continue to enable uclamp in their kernel config with
> > + * minimum uclamp overhead in the fast path.
> > + *
> > + * As soon as userspace modifies any of the uclamp knobs, the static key is
> > + * disabled, since we have an actual users that make use of uclamp
> > + * functionality.
> > + *
> > + * The knobs that would disable this static key are:
> > + *
> > + *   * A task modifying its uclamp value with sched_setattr().
> > + *   * An admin modifying the sysctl_sched_uclamp_{min, max} via procfs.
> > + *   * An admin modifying the cgroup cpu.uclamp.{min, max}
> > + */
> > +DEFINE_STATIC_KEY_TRUE(sched_uclamp_unused);
> 
> Maybe call the thing: 'sched_uclamp_users', instead?
> 
> 
> > +		if (static_branch_unlikely(&sched_uclamp_unused))
> > +			static_branch_disable(&sched_uclamp_unused);
> 
> 
> > +	if (static_branch_unlikely(&sched_uclamp_unused))
> > +		static_branch_disable(&sched_uclamp_unused);
> 
> 
> > +	if (static_branch_unlikely(&sched_uclamp_unused))
> > +		static_branch_disable(&sched_uclamp_unused);
> 
> That's an anti-pattern... just static_branch_disable(), or _enable()
> with a 'better' name is sufficient.

I misread the code. I saw there's a WAN_ON_ONCE() but that only triggers if the
atomic variable has a value that is ! in (0, 1) range.

So yes we can call it unconditionally.

Thanks

--
Qais Yousef
