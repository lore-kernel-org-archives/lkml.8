Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02E6C35DF8
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 06:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7429C20CC7
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 06:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="kixsm2uf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbgBYGyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 01:54:21 -0500
Received: from mail27.static.mailgun.info ([104.130.122.27]:24833 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728999AbgBYGyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 01:54:20 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1582613660; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=Bqe+MxgOQ4v79iRaAWRObexhBHZ0qeaHVcuiw7V5q7U=; b=kixsm2uf5EmYcEHr+6IttXmcLhRg8fcxOf4RPiQXybvGNYgaS05y7kN7ZCmepRMnu8YnZTQK
 b8to8Zl57pyCmuSjV7dIrmqLK2vPvnKI0f/X97aUvDS5yrnCBHcDGYQtynw/sXGLXMv5ytWU
 WkNzMeFjh9ox+2DOwqr5hth8YY8=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e54c49b.7fe789c660a0-smtp-out-n03;
 Tue, 25 Feb 2020 06:54:19 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A342DC4479F; Tue, 25 Feb 2020 06:54:19 +0000 (UTC)
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DC475C43383;
        Tue, 25 Feb 2020 06:54:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DC475C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pkondeti@codeaurora.org
Date:   Tue, 25 Feb 2020 12:24:09 +0530
From:   Pavan Kondeti <pkondeti@codeaurora.org>
To:     Parth Shah <parth@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, qais.yousef@arm.com,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net,
        valentin.schneider@arm.com, David.Laight@ACULAB.COM,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org,
        dhaval.giani@oracle.com, qperret@google.com,
        tim.c.chen@linux.intel.com
Subject: Re: [PATCH v4 3/4] sched: Allow sched_{get,set}attr to change
 latency_nice of the task
Message-ID: <20200225065409.GK28029@codeaurora.org>
References: <20200224085918.16955-1-parth@linux.ibm.com>
 <20200224085918.16955-4-parth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224085918.16955-4-parth@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 02:29:17PM +0530, Parth Shah wrote:

[...]

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 65b6c00d6dac..e1dc536d4ca3 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4723,6 +4723,8 @@ static void __setscheduler_params(struct task_struct *p,
>  	p->rt_priority = attr->sched_priority;
>  	p->normal_prio = normal_prio(p);
>  	set_load_weight(p, true);
> +
> +	p->latency_nice = attr->sched_latency_nice;
>  }

We don't want this when SCHED_FLAG_LATENCY_NICE is not set in
attr->flags.

The user may pass SCHED_FLAG_KEEP_PARAMS | SCHED_FLAG_LATENCY_NICE to
change only latency nice value. So we have to update latency_nice
outside __setscheduler_params(), I think.

>  
>  /* Actually do priority change: must hold pi & rq lock. */
> @@ -4880,6 +4882,13 @@ static int __sched_setscheduler(struct task_struct *p,
>  			return retval;
>  	}
>  
> +	if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE) {
> +		if (attr->sched_latency_nice > MAX_LATENCY_NICE)
> +			return -EINVAL;
> +		if (attr->sched_latency_nice < MIN_LATENCY_NICE)
> +			return -EINVAL;
> +	}
> +
>  	if (pi)
>  		cpuset_read_lock();
>  
> @@ -4914,6 +4923,9 @@ static int __sched_setscheduler(struct task_struct *p,
>  			goto change;
>  		if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)
>  			goto change;
> +		if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE &&
> +		    attr->sched_latency_nice != p->latency_nice)
> +			goto change;
>  
>  		p->sched_reset_on_fork = reset_on_fork;
>  		retval = 0;
> @@ -5162,6 +5174,9 @@ static int sched_copy_attr(struct sched_attr __user *uattr, struct sched_attr *a
>  	    size < SCHED_ATTR_SIZE_VER1)
>  		return -EINVAL;
>  
> +	if ((attr->sched_flags & SCHED_FLAG_LATENCY_NICE) &&
> +	    size < SCHED_ATTR_SIZE_VER2)
> +		return -EINVAL;
>  	/*
>  	 * XXX: Do we want to be lenient like existing syscalls; or do we want
>  	 * to be strict and return an error on out-of-bounds values?
> @@ -5391,6 +5406,8 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
>  	else
>  		kattr.sched_nice = task_nice(p);
>  
> +	kattr.sched_latency_nice = p->latency_nice;
> +

Can you consider printing latency_nice value in proc_sched_show_task() in this
patch/series?

Thanks,
Pavan

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
