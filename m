Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01E7C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 03:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7340720705
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 03:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="mDsP6kf6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgEDD7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 23:59:18 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:53887 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726404AbgEDD7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 23:59:18 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588564757; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=pZT4ZZHn7pXhJIWWhYwujielHVnvoqjN8CtvF+L9W78=; b=mDsP6kf65zRhPCLlo9aauR8wjSdzpmGTgw7bJYgsbvYPmyXK3Tuct1PmsIAU0FGNoAbx7F4+
 E9BtODduMHppImZ6x5yVD05v7Z+b/8GJJvLY6Z8RqeVGiHLaB5JQrYTwwNMWipv7Lxcz8Y+N
 JjRvmAlq1A9f6y5x81oeJBBEjc0=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eaf92fd.7f9c6d778500-smtp-out-n05;
 Mon, 04 May 2020 03:58:53 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A324FC4478F; Mon,  4 May 2020 03:58:51 +0000 (UTC)
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A1B3FC433D2;
        Mon,  4 May 2020 03:58:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A1B3FC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pkondeti@codeaurora.org
Date:   Mon, 4 May 2020 09:28:42 +0530
From:   Pavan Kondeti <pkondeti@codeaurora.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Wei Wang <wvw@google.com>, Quentin Perret <qperret@google.com>,
        Alessio Balsini <balsini@google.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] sched/deadline: Make DL capacity-aware
Message-ID: <20200504035842.GF19464@codeaurora.org>
References: <20200427083709.30262-1-dietmar.eggemann@arm.com>
 <20200427083709.30262-6-dietmar.eggemann@arm.com>
 <20200430131036.GE19464@codeaurora.org>
 <aa00aee6-2adb-569b-825b-781da12ad8d3@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa00aee6-2adb-569b-825b-781da12ad8d3@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 06:12:07PM +0200, Dietmar Eggemann wrote:
> On 30/04/2020 15:10, Pavan Kondeti wrote:
> > On Mon, Apr 27, 2020 at 10:37:08AM +0200, Dietmar Eggemann wrote:
> >> From: Luca Abeni <luca.abeni@santannapisa.it>
> 
> [...]
> 
> >> @@ -1653,10 +1654,19 @@ select_task_rq_dl(struct task_struct *p, int cpu, int sd_flag, int flags)
> >>  	 * other hand, if it has a shorter deadline, we
> >>  	 * try to make it stay here, it might be important.
> >>  	 */
> >> -	if (unlikely(dl_task(curr)) &&
> >> -	    (curr->nr_cpus_allowed < 2 ||
> >> -	     !dl_entity_preempt(&p->dl, &curr->dl)) &&
> >> -	    (p->nr_cpus_allowed > 1)) {
> >> +	select_rq = unlikely(dl_task(curr)) &&
> >> +		    (curr->nr_cpus_allowed < 2 ||
> >> +		     !dl_entity_preempt(&p->dl, &curr->dl)) &&
> >> +		    p->nr_cpus_allowed > 1;
> >> +
> >> +	/*
> >> +	 * Take the capacity of the CPU into account to
> >> +	 * ensure it fits the requirement of the task.
> >> +	 */
> >> +	if (static_branch_unlikely(&sched_asym_cpucapacity))
> >> +		select_rq |= !dl_task_fits_capacity(p, cpu);
> >> +
> >> +	if (select_rq) {
> >>  		int target = find_later_rq(p);
> > 
> > I see that find_later_rq() checks if the previous CPU is part of
> > later_mask and returns it immediately. So we don't migrate the
> > task in the case where there previous CPU can't fit the task and
> > there are no idle CPUs on which the task can fit. LGTM.
> 
> Hope I understand you here. I don't think that [patch 6/6] provides this
> already.
> 
> In case 'later_mask' has no fitting CPUs, 'max_cpu' is set in the
> otherwise empty 'later_mask'. But 'max_cpu' is not necessary task_cpu(p).
> 
> Example on Juno [L b b L L L] with thread0-0 (big task)
> 
>      cpudl_find [thread0-0 2117] orig later_mask=0,3-4 later_mask=0
>   find_later_rq [thread0-0 2117] task_cpu=2 later_mask=0
> 
> A tweak could be added favor task_cpu(p) in case it is amongst the CPUs
> with the maximum capacity in cpudl_find() for the !fit case.
> 

You are right. max_cpu can be other than task_cpu(p) in which case we
migrate the task though it won't fit on the new CPU. While introducing
capacity awareness in RT, Quais made the below change to avoid the
migration. We can do something similar here also.

commit b28bc1e002c2 (sched/rt: Re-instate old behavior in select_task_rq_rt())

> [...]
> 
> >> +/*
> >> + * Verify the fitness of task @p to run on @cpu taking into account the
> >> + * CPU original capacity and the runtime/deadline ratio of the task.
> >> + *
> >> + * The function will return true if the CPU original capacity of the
> >> + * @cpu scaled by SCHED_CAPACITY_SCALE >= runtime/deadline ratio of the
> >> + * task and false otherwise.
> >> + */
> >> +static inline bool dl_task_fits_capacity(struct task_struct *p, int cpu)
> >> +{
> >> +	unsigned long cap = arch_scale_cpu_capacity(cpu);
> >> +
> >> +	return cap_scale(p->dl.dl_deadline, cap) >= p->dl.dl_runtime;
> >> +}
> >> +
> > 
> > This is same as
> > 
> > return p->dl.dl_bw >> (BW_SHIFT - SCHED_CAPACITY_SHIFT) <= cap
> > 
> > Correct?  If yes, would it be better to use this?
> 
> We could use sched_dl_entity::dl_density (dl_runtime / dl_deadline) but
> then I would have to export BW_SHIFT.

Yeah, I meant dl_denstity not dl_bw. Thanks for correcting me. I see that
BW_SHIFT is defined in kernel/sched/sched.h

Thanks,
Pavan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
