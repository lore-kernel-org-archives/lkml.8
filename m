Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE6CC54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 20:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7993F20728
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 20:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sm3n1yn1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbgDWUdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 16:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgDWUdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 16:33:39 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC684C09B042
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 13:33:37 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id n16so3446446pgb.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 13:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=WqMcHBrQL5Hrx/5UPlvgx3z4tpcct1oI0fprZGVyhow=;
        b=sm3n1yn1FEv8KlppYnJA3szSMesRSg+OEYPnihsFc2ITcWOXMlhTGDwdfSRy2OUMTu
         WD6Pf5xk6bydVlTjzR+2xJZ//sYi0mBGJoID6eJmV8YCgjbXKOaLI0PsFjRPQ7kxziG1
         iGqTHbnmqrHdempnnkY3rDxrvTXc55MvLIlU0ZAx5+BLQHxz68U0XcuyAJWchpO4X4lb
         zx4Dy1CHk4lpIbeY84XVqDfINyVycVreY+5vvnEkf71VzPP+OA0hfoP+aDUnZDuB4XEy
         Qp/Of4Tj2E3WMiEOqJvvx8tzK+PpGA7QyBG+o/X0PguA6mcYP3v+M3UZng/zxgNMBFNx
         nJYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=WqMcHBrQL5Hrx/5UPlvgx3z4tpcct1oI0fprZGVyhow=;
        b=CRzHIiQm1ZNDrqrLfVNx72k/sRI7v5zEQsg9Ix1kGmxRmISzdPI/c56gLT+7oIIu/G
         IzTH5ypNs689Kl5tKS+2atEvVlNXFQtUTXFxBjaNDnwGWrZyrExu2RlWtQ853YS6Sy5+
         STIYGUAXaqsuidEDTc6gUrI/YV8rmV9xptkugBebvYTIhRPOTGKT3Q1ohjG8EuoTb1n0
         U5z1SUNWjnBs8ruHM+3918kd+0ehZX0UcC3v1uMty5kky+ubnU6KNs1q7eFyWdzbtNDs
         iRYdnULZbfYsZ9pTa/g85TLIalv/FelNyy3Mrs7WHKyDPQcbhDfhUiE0eHRN4L3aqwVT
         UOMQ==
X-Gm-Message-State: AGi0PuaPkGqaEPzvJXXuNgm6IownU6qEVVJsi3kiD2VDlToBPFFXpoBw
        8H1CLGK9OqlrzVDaLjwKLLXIAQ==
X-Google-Smtp-Source: APiQypLNIoAWytupjwFrf+mjTSan1lvG0IjxLhTQdyYYTq2V/sufCnzkIjSsou9MFnqjvUvvPYOO7Q==
X-Received: by 2002:a63:1a0b:: with SMTP id a11mr5278109pga.29.1587674016957;
        Thu, 23 Apr 2020 13:33:36 -0700 (PDT)
Received: from bsegall-glaptop.localhost (c-73-71-82-80.hsd1.ca.comcast.net. [73.71.82.80])
        by smtp.gmail.com with ESMTPSA id o11sm2832171pgd.58.2020.04.23.13.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 13:33:35 -0700 (PDT)
From:   bsegall@google.com
To:     Huaixin Chang <changhuaixin@linux.alibaba.com>
Cc:     bsegall@google.com, chiluk+linux@indeed.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com, pauld@redhead.com,
        peterz@infradead.org, vincent.guittot@linaro.org
Subject: Re: [PATCH] sched: Defend cfs and rt bandwidth quota against overflow
References: <xm261roim4hi.fsf@google.com>
        <20200423133752.12787-1-changhuaixin@linux.alibaba.com>
Date:   Thu, 23 Apr 2020 13:33:33 -0700
In-Reply-To: <20200423133752.12787-1-changhuaixin@linux.alibaba.com> (Huaixin
        Chang's message of "Thu, 23 Apr 2020 21:37:52 +0800")
Message-ID: <xm26k126kkma.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Huaixin Chang <changhuaixin@linux.alibaba.com> writes:

> When users write some huge number into cpu.cfs_quota_us or
> cpu.rt_runtime_us, overflow might happen during to_ratio() shifts of
> schedulable checks.
>
> to_ratio() could be altered to avoid unnecessary internal overflow, but
> min_cfs_quota_period is less than 1 << BW_SHIFT, so a cutoff would still
> be needed. Set a cap MAX_BW for cfs_quota_us and rt_runtime_us to
> prevent overflow.
>
> Signed-off-by: Huaixin Chang <changhuaixin@linux.alibaba.com>
> ---
>  kernel/sched/core.c  | 8 ++++++++
>  kernel/sched/rt.c    | 9 +++++++++
>  kernel/sched/sched.h | 2 ++
>  3 files changed, 19 insertions(+)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 3a61a3b8eaa9..0be1782e15c9 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7390,6 +7390,8 @@ static DEFINE_MUTEX(cfs_constraints_mutex);
>  
>  const u64 max_cfs_quota_period = 1 * NSEC_PER_SEC; /* 1s */
>  static const u64 min_cfs_quota_period = 1 * NSEC_PER_MSEC; /* 1ms */
> +/* More than 203 days if BW_SHIFT equals 20. */
> +static const u64 max_cfs_runtime = MAX_BW * NSEC_PER_USEC;
>  
>  static int __cfs_schedulable(struct task_group *tg, u64 period, u64 runtime);
>  
> @@ -7417,6 +7419,12 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota)
>  	if (period > max_cfs_quota_period)
>  		return -EINVAL;
>  
> +	/*
> +	 * Bound quota to defend quota against overflow during bandwidth shift.
> +	 */
> +	if (quota != RUNTIME_INF && quota > max_cfs_runtime)
> +		return -EINVAL;
> +
>  	/*
>  	 * Prevent race between setting of cfs_rq->runtime_enabled and
>  	 * unthrottle_offline_cfs_rqs().
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index df11d88c9895..7ba49625cdbd 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -2569,6 +2569,9 @@ static int __rt_schedulable(struct task_group *tg, u64 period, u64 runtime)
>  	return ret;
>  }
>  
> +/* More than 4 hours if BW_SHIFT equals 20. */
> +static const u64 max_rt_runtime = MAX_BW;
> +
>  static int tg_set_rt_bandwidth(struct task_group *tg,
>  		u64 rt_period, u64 rt_runtime)
>  {
> @@ -2585,6 +2588,12 @@ static int tg_set_rt_bandwidth(struct task_group *tg,
>  	if (rt_period == 0)
>  		return -EINVAL;
>  
> +	/*
> +	 * Bound quota to defend quota against overflow during bandwidth shift.
> +	 */
> +	if (rt_runtime != RUNTIME_INF && rt_runtime > max_rt_runtime)
> +		return -EINVAL;
> +

We probably _do_ also want this in sched_rt_global_validate now that I
think of it. Other than missing that, it looks good.

>  	mutex_lock(&rt_constraints_mutex);
>  	err = __rt_schedulable(tg, rt_period, rt_runtime);
>  	if (err)
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index db3a57675ccf..1f58677a8f23 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1918,6 +1918,8 @@ extern void init_dl_inactive_task_timer(struct sched_dl_entity *dl_se);
>  #define BW_SHIFT		20
>  #define BW_UNIT			(1 << BW_SHIFT)
>  #define RATIO_SHIFT		8
> +#define MAX_BW_BITS		(64 - BW_SHIFT)
> +#define MAX_BW			((1ULL << MAX_BW_BITS) - 1)
>  unsigned long to_ratio(u64 period, u64 runtime);
>  
>  extern void init_entity_runnable_average(struct sched_entity *se);
