Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AEB6C7619F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E83DD2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="djcsP0XH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbgBQJLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 04:11:00 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:42694 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728272AbgBQJK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 04:10:59 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581930659; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=LflFX77MpWqHjBMkjGqMItAeXxvmu1fDKmf5K/EJeow=; b=djcsP0XHymByAeW4UDSojfOLZ0cAifWh76edniaHXzBcTiKYWY/ENVrf7pdiXxpcJtHOKZqG
 7xdwghXuGxlsLntCmxnwvXBxVMHMq3GCg5BFOeOqYLl+lcURfk3Sw6wYVN1/qRv8Np7hvSID
 fGjNq9w7Unh9enpWHh28YSBWmDU=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e4a589c.7fabdec96538-smtp-out-n01;
 Mon, 17 Feb 2020 09:10:52 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5A4A0C447A3; Mon, 17 Feb 2020 09:10:50 +0000 (UTC)
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 34576C447A0;
        Mon, 17 Feb 2020 09:10:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 34576C447A0
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pkondeti@codeaurora.org
Date:   Mon, 17 Feb 2020 14:40:42 +0530
From:   Pavan Kondeti <pkondeti@codeaurora.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] sched/rt: allow pulling unfitting task
Message-ID: <20200217091042.GB28029@codeaurora.org>
References: <20200214163949.27850-1-qais.yousef@arm.com>
 <20200214163949.27850-3-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214163949.27850-3-qais.yousef@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qais,

On Fri, Feb 14, 2020 at 04:39:48PM +0000, Qais Yousef wrote:
> When implemented RT Capacity Awareness; the logic was done such that if
> a task was running on a fitting CPU, then it was sticky and we would try
> our best to keep it there.
> 
> But as Steve suggested, to adhere to the strict priority rules of RT
> class; allow pulling an RT task to unfitting CPU to ensure it gets a
> chance to run ASAP. When doing so, mark the queue as overloaded to give
> the system a chance to push the task to a better fitting CPU when a
> chance arises.
> 
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> ---
>  kernel/sched/rt.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 4043abe45459..0c8bac134d3a 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1646,10 +1646,20 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
>  
>  static int pick_rt_task(struct rq *rq, struct task_struct *p, int cpu)
>  {
> -	if (!task_running(rq, p) &&
> -	    cpumask_test_cpu(cpu, p->cpus_ptr) &&
> -	    rt_task_fits_capacity(p, cpu))
> +	if (!task_running(rq, p) && cpumask_test_cpu(cpu, p->cpus_ptr)) {
> +
> +		/*
> +		 * If the CPU doesn't fit the task, allow pulling but mark the
> +		 * rq as overloaded so that we can push it again to a more
> +		 * suitable CPU ASAP.
> +		 */
> +		if (!rt_task_fits_capacity(p, cpu)) {
> +			rt_set_overload(rq);
> +			rq->rt.overloaded = 1;
> +		}
> +

Here rq is source rq from which the task is being pulled. I can't understand
how marking overload condition on source_rq help. Because overload condition
gets cleared in the task dequeue path. i.e dec_rt_tasks->dec_rt_migration->
update_rt_migration().

Also, the overload condition with nr_running=1 may not work as expected unless
we track this overload condition (due to unfit) separately. Because a task
can be pushed only when it is NOT running. So a task running on silver will
continue to run there until it wakes up next time or another high prio task
gets queued here (due to affinity).

btw, Are you testing this path by disabling RT_PUSH_IPI feature? I ask this
because, This feature gets turned on by default in our b.L platforms and
RT task migrations happens by the busy CPU pushing the tasks. Or are there
any cases where we can run into pick_rt_task() even when RT_PUSH_IPI is
enabled?

Thanks,
Pavan

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
