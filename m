Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5DBC4CECC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 18:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 929FB216FD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 18:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oGDyz1c+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgD0S3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 14:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726189AbgD0S3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 14:29:35 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4807CC0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 11:29:35 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id a7so7790406pju.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 11:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2qE4d/Nn7LcSjt2dGhGVDwJZIEAYDq3ScmHna/w8xQ4=;
        b=oGDyz1c+s+tWX6/RMsoHbi0b6EyjYmwn5qfM9lnQFyv2Z8qwu7+uVpdqGDUUaXv24f
         7sZ3k0TEbipuPiCwR/bikfjcLweHr9EXmnvvXXPIYbe575NYW+yuPcqVpSrUPyXI+WAy
         TS2u1NDKcRLPGWxn3Am04K/j5ok17GhI6tm2xcDG7NC44xChJ0gHUtE7I77NCD77HxHb
         hdoP+kfGkiwmns7mBW1rW5ZJDGjEDz9TCkTR7tRm/ia3GkYULHCrUJE/tSyUb1sQNCrw
         JH1V6+zBLi2ojlgg5nLkRFI8TxNPyPbkzot2tjqZ5A59PIZGg0Ps77pZkmaehav3MOs9
         S1zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=2qE4d/Nn7LcSjt2dGhGVDwJZIEAYDq3ScmHna/w8xQ4=;
        b=SDtCDvUQwLrLA6X1iHa+vvj+8eGocpDEUBuHGeXQEAYjk7xFBUj59hK5OlzRm452F1
         SQF6b+tevEisNnBi+8xwWa9YnfDwEv/HNopGI2sFRtQWk74sEk+2OMd+YX29VWloCB7S
         AdPoRUKQn1/KcCMAdG4blWtprZAq6to1mgmWVFlZYsZ9lC3xphYw5vdU812TdtO3NCZ7
         w3z0bYRVq9aIgeYfn1ww4j9ZzJYGyMdxbRycTanRLajwLXpLWk6j9ZC/3pD9njvAp7Wv
         w8+Y6GDbDBRlAIc1PXsfd6CDteztYMf6tlNzuAG64WZzFGNnITMUKz38Dg+OFnKYjbTp
         dy5A==
X-Gm-Message-State: AGi0PuaRipaBwuO0YF+sDS7UnT/JtfHFtsTTA2/PYLqfuFW37B5aRs32
        Q2jYUXnfdF5xtpjHe/W9ISlY2w==
X-Google-Smtp-Source: APiQypISOuAeYU5BC2rzEWh/LR4TvfHrdbf5gOHN4ymrs75wid7zxH7TD3IuXw8iSN3WgmnCLPP61Q==
X-Received: by 2002:a17:902:ed13:: with SMTP id b19mr25093398pld.254.1588012174619;
        Mon, 27 Apr 2020 11:29:34 -0700 (PDT)
Received: from bsegall-glaptop.localhost (c-73-71-82-80.hsd1.ca.comcast.net. [73.71.82.80])
        by smtp.gmail.com with ESMTPSA id w11sm5600pjy.11.2020.04.27.11.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 11:29:32 -0700 (PDT)
From:   bsegall@google.com
To:     Huaixin Chang <changhuaixin@linux.alibaba.com>
Cc:     bsegall@google.com, chiluk+linux@indeed.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com, pauld@redhead.com,
        peterz@infradead.org, vincent.guittot@linaro.org
Subject: Re: [PATCH v2] sched: Defend cfs and rt bandwidth quota against overflow
References: <xm26k126kkma.fsf@google.com>
        <20200425105248.60093-1-changhuaixin@linux.alibaba.com>
Date:   Mon, 27 Apr 2020 11:29:30 -0700
In-Reply-To: <20200425105248.60093-1-changhuaixin@linux.alibaba.com> (Huaixin
        Chang's message of "Sat, 25 Apr 2020 18:52:48 +0800")
Message-ID: <xm26ftcolr3p.fsf@google.com>
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

Reviewed-by: Ben Segall <bsegall@google.com>

>
> Signed-off-by: Huaixin Chang <changhuaixin@linux.alibaba.com>
> ---
>  kernel/sched/core.c  |  8 ++++++++
>  kernel/sched/rt.c    | 12 +++++++++++-
>  kernel/sched/sched.h |  2 ++
>  3 files changed, 21 insertions(+), 1 deletion(-)
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
> index df11d88c9895..6d60ba21ed29 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -9,6 +9,8 @@
>  
>  int sched_rr_timeslice = RR_TIMESLICE;
>  int sysctl_sched_rr_timeslice = (MSEC_PER_SEC / HZ) * RR_TIMESLICE;
> +/* More than 4 hours if BW_SHIFT equals 20. */
> +static const u64 max_rt_runtime = MAX_BW;
>  
>  static int do_sched_rt_period_timer(struct rt_bandwidth *rt_b, int overrun);
>  
> @@ -2585,6 +2587,12 @@ static int tg_set_rt_bandwidth(struct task_group *tg,
>  	if (rt_period == 0)
>  		return -EINVAL;
>  
> +	/*
> +	 * Bound quota to defend quota against overflow during bandwidth shift.
> +	 */
> +	if (rt_runtime != RUNTIME_INF && rt_runtime > max_rt_runtime)
> +		return -EINVAL;
> +
>  	mutex_lock(&rt_constraints_mutex);
>  	err = __rt_schedulable(tg, rt_period, rt_runtime);
>  	if (err)
> @@ -2702,7 +2710,9 @@ static int sched_rt_global_validate(void)
>  		return -EINVAL;
>  
>  	if ((sysctl_sched_rt_runtime != RUNTIME_INF) &&
> -		(sysctl_sched_rt_runtime > sysctl_sched_rt_period))
> +		((sysctl_sched_rt_runtime > sysctl_sched_rt_period) ||
> +		 ((u64)sysctl_sched_rt_runtime *
> +			NSEC_PER_USEC > max_rt_runtime)))
>  		return -EINVAL;
>  
>  	return 0;
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
