Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DF1C38A2A
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 02:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96F4D217BA
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 02:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="pbGfnK/V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbgEICjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 22:39:25 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:17184 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728158AbgEICjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 22:39:25 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588991964; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=JJ9AKZ/PmehK3UlrXKD3f/suIB/gF43b9Bgi6O+K0fU=; b=pbGfnK/V32zaw4Cfh98PyIdUeL7G1sdYWeQEVTHIaKjQMvze3cu3+yni8TYtT5wt18fMJm2d
 YgKvl0w7USOchZie0x2lmq8DDZKeg/l4qYfWNMwbRG73dEARDk+bp2i3LCt2NtfbtHKTo+WL
 G10JfXMSpDCAUrRuggup7u2TRdA=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb617da.7fc1940492d0-smtp-out-n02;
 Sat, 09 May 2020 02:39:22 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id ADB16C433D2; Sat,  9 May 2020 02:39:22 +0000 (UTC)
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 905A2C433F2;
        Sat,  9 May 2020 02:39:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 905A2C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pkondeti@codeaurora.org
Date:   Sat, 9 May 2020 08:09:15 +0530
From:   Pavan Kondeti <pkondeti@codeaurora.org>
To:     Parth Shah <parth@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, qais.yousef@arm.com,
        chris.hyser@oracle.com, valentin.schneider@arm.com,
        rjw@rjwysocki.net
Subject: Re: [RFC 2/4] sched/core: Set nr_lat_sensitive counter at various
 scheduler entry/exit points
Message-ID: <20200509023915.GN19464@codeaurora.org>
References: <20200507133723.18325-1-parth@linux.ibm.com>
 <20200507133723.18325-3-parth@linux.ibm.com>
 <20200508083308.GI19464@codeaurora.org>
 <73506bba-7bcb-fd40-6866-d5d88d436fbf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73506bba-7bcb-fd40-6866-d5d88d436fbf@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 04:45:16PM +0530, Parth Shah wrote:
> Hi Pavan,
> 
> Thanks for going through this patch-set.
> 
> On 5/8/20 2:03 PM, Pavan Kondeti wrote:
> > Hi Parth,
> > 
> > On Thu, May 07, 2020 at 07:07:21PM +0530, Parth Shah wrote:
> >> Monitor tasks at:
> >> 1. wake_up_new_task() - forked tasks
> >>
> >> 2. set_task_cpu() - task migrations, Load balancer
> >>
> >> 3. __sched_setscheduler() - set/unset latency_nice value
> >> Increment the nr_lat_sensitive count on the CPU with task marked with
> >> latency_nice == -20.
> >> Similarly, decrement the nr_lat_sensitive counter upon re-marking the task
> >> with >-20 latency_nice task.
> >>
> >> 4. finish_task_switch() - dying task
> >>
> > 
> > 
> >> Signed-off-by: Parth Shah <parth@linux.ibm.com>
> >> ---
> >>  kernel/sched/core.c  | 30 ++++++++++++++++++++++++++++--
> >>  kernel/sched/sched.h |  5 +++++
> >>  2 files changed, 33 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> >> index 2d8b76f41d61..ad396c36eba6 100644
> >> --- a/kernel/sched/core.c
> >> +++ b/kernel/sched/core.c
> >> @@ -1744,6 +1744,11 @@ void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
> >>  	trace_sched_migrate_task(p, new_cpu);
> >>  
> >>  	if (task_cpu(p) != new_cpu) {
> >> +		if (task_is_lat_sensitive(p)) {
> >> +			per_cpu(nr_lat_sensitive, task_cpu(p))--;
> >> +			per_cpu(nr_lat_sensitive, new_cpu)++;
> >> +		}
> >> +
> > 
> > Since we can come here without rq locks, there is a possibility
> > of a race and incorrect updates can happen. Since the counters
> > are used to prevent C-states, we don't want that to happen.
> 
> I did tried using task_lock(p) wherever we do change refcount and when
> latency_nice value is set. There I was using nr_lat_sensitive with atomic_t
> type.
> 
> After lots of thinking to optimize it and thinking that we anyways hold rq
> lock, I thought of not using any lock here and see if scheduler community
> has well known solution for this :-)
> 
> But in brief, using atomic_t nr_lat_sensitive and task_lock(p) when changin
> refcount should solve problem, right?
> 
> If you or anyone have solution for this kind of pattern, then that surely
> will be helpful.
> 
I am not sure if task_lock() can help here, because we are operating the
counter on per CPU basis here. May be cmpxchg based loop works here to make
sure that increment/decrement operation happens atomically here.

> > 
> >>  		if (p->sched_class->migrate_task_rq)
> >>  			p->sched_class->migrate_task_rq(p, new_cpu);
> >>  		p->se.nr_migrations++;

[...]

> >> @@ -4732,8 +4749,17 @@ static void __setscheduler_params(struct task_struct *p,
> >>  	p->normal_prio = normal_prio(p);
> >>  	set_load_weight(p, true);
> >>  
> >> -	if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE)
> >> +	if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE) {
> >> +		if (p->state != TASK_DEAD &&
> >> +		    attr->sched_latency_nice != p->latency_nice) {
> >> +			if (attr->sched_latency_nice == MIN_LATENCY_NICE)
> >> +				per_cpu(nr_lat_sensitive, task_cpu(p))++;
> >> +			else if (task_is_lat_sensitive(p))
> >> +				per_cpu(nr_lat_sensitive, task_cpu(p))--;
> >> +		}
> >> +
> >>  		p->latency_nice = attr->sched_latency_nice;
> >> +	}
> >>  }
> > 
> > There is a potential race here due to which we can mess up the refcount.
> > 
> > - A latency sensitive task is marked TASK_DEAD
> > <snip>
> > - sched_setattr() called on the task to clear the latency nice. Since
> > we check the task state here, we skip the decrement.
> > - The task is finally context switched out and we skip the decrement again
> > since it is not a latency senstivie task.
> 
> if task is already marked TASK_DEAD then we should have already decremented
> its refcount in finish_task_switch().
> am I missing something?

There is a window (context switch and dropping rq lock) between
marking a task DEAD (in do_task_dead()) and dropping the ref counter
(in finish_task_switch()) during which we can run into here and skip
the checking because task is marked as DEAD.

Thanks,
Pavan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
