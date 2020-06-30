Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89274C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77A7520724
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389206AbgF3RzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 13:55:08 -0400
Received: from foss.arm.com ([217.140.110.172]:50310 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgF3RzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 13:55:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3B2E1FB;
        Tue, 30 Jun 2020 10:55:06 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F16FC3F68F;
        Tue, 30 Jun 2020 10:55:04 -0700 (PDT)
Date:   Tue, 30 Jun 2020 18:55:02 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Chris Redpath <chris.redpath@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] sched/uclamp: Protect uclamp fast path code with
 static key
Message-ID: <20200630175502.otw4seymlynghje7@e107158-lin.cambridge.arm.com>
References: <20200630112123.12076-1-qais.yousef@arm.com>
 <20200630112123.12076-3-qais.yousef@arm.com>
 <20200630170751.GA4817@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200630170751.GA4817@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/30/20 19:07, Peter Zijlstra wrote:
> On Tue, Jun 30, 2020 at 12:21:23PM +0100, Qais Yousef wrote:
> > @@ -993,10 +1013,38 @@ static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
> >  
> >  	lockdep_assert_held(&rq->lock);
> >  
> > +	/*
> > +	 * If sched_uclamp_used was enabled after task @p was enqueued,
> > +	 * we could end up with unbalanced call to uclamp_rq_dec_id().
> > +	 *
> > +	 * In this case the uc_se->active flag should be false since no uclamp
> > +	 * accounting was performed at enqueue time and we can just return
> > +	 * here.
> > +	 *
> > +	 * Need to be careful of the following enqeueue/dequeue ordering
> > +	 * problem too
> > +	 *
> > +	 *	enqueue(taskA)
> > +	 *	// sched_uclamp_used gets enabled
> > +	 *	enqueue(taskB)
> > +	 *	dequeue(taskA)
> > +	 *	// Must not decrement bukcet->tasks here
> > +	 *	dequeue(taskB)
> > +	 *
> > +	 * where we could end up with stale data in uc_se and
> > +	 * bucket[uc_se->bucket_id].
> > +	 *
> > +	 * The following check here eliminates the possibility of such race.
> > +	 */
> > +	if (unlikely(!uc_se->active))
> > +		return;
> > +
> >  	bucket = &uc_rq->bucket[uc_se->bucket_id];
> > +
> >  	SCHED_WARN_ON(!bucket->tasks);
> >  	if (likely(bucket->tasks))
> >  		bucket->tasks--;
> > +
> >  	uc_se->active = false;
> >  
> >  	/*
> 
> > @@ -1221,6 +1289,8 @@ static void __setscheduler_uclamp(struct task_struct *p,
> >  	if (likely(!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)))
> >  		return;
> >  
> > +	static_branch_enable(&sched_uclamp_used);
> > +
> >  	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
> >  		uclamp_se_set(&p->uclamp_req[UCLAMP_MIN],
> >  			      attr->sched_util_min, true);
> > @@ -7387,6 +7457,8 @@ static ssize_t cpu_uclamp_write(struct kernfs_open_file *of, char *buf,
> >  	if (req.ret)
> >  		return req.ret;
> >  
> > +	static_branch_enable(&sched_uclamp_used);
> > +
> >  	mutex_lock(&uclamp_mutex);
> >  	rcu_read_lock();
> >  
> 
> There's a fun race described in 9107c89e269d ("perf: Fix race between
> event install and jump_labels"), are we sure this isn't also susceptible
> to something similar?
> 
> I suspect not, but I just wanted to make sure.

IIUC, the worry is that not all CPUs might have observed the change in the
static key state; hence could not be running the patched
enqueue/dequeue_task(), so we could end up with some CPUs accounting for
uclamp in the enqueue/dequeue path but not others?

I was hoping this synchronization is guaranteed by the static_branch_*() call.

aarch64_insn_patch_text_nosync() in arch/arm64/kernel/insn.c performs
__flush_icache_range() after writing the new instruction.

I need to dig into what __flush_icache_range() do, but I think it'll just
flush the icache of the calling CPU. Need to dig into upper layers too.

It'd be good to know if I got you correctly first.

Thanks

--
Qais Yousef
