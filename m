Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2AC9C38A30
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 17:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE4A220B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 17:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lmT9mwt1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgDTRuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 13:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725784AbgDTRuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 13:50:05 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0ABC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 10:50:05 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id np9so181116pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 10:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=LXSdkPjnzxTUAQ2gmzdrAwjLKwSSmeYYBYUwSx1ieH8=;
        b=lmT9mwt19o9bRnq/+rGFfn4Y8RQtjYF4nfIuoML3AUmvyePPygh5CeUvHaBc1vwxbh
         KyOX4Ul7i//EI+I0Jlv/C72Dn+anYH/lbklFTI0T9WFcax7VByCyCzoSFT/Yjq6FaCmd
         R0jkcPc4X6opkn+C/I+a8iamdst7cuMQJyuvoh1fr47adsJfSfEzPruSB/lscoNzkpy+
         nBqV3LvL3IliWEXzJoLHf6r7thppt8Dxx13RpUh/XBHvDOgivqmbd6fOMQK+cij0Ux70
         hJQzJ4o+YqaHfl3L4RI+SEHNxxDbnQV025Az9Bm+HLYxABIJ6gUOq8xgTXYe+q+5jYHB
         BKag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=LXSdkPjnzxTUAQ2gmzdrAwjLKwSSmeYYBYUwSx1ieH8=;
        b=XdZKfgsQwlm11rc4/tx233lx1F3DKgXr1LTmRqQqk7pUpE77+L3xAm0dG6ZS/p0tko
         iLOj7pgM/KtK+hkMgZMKQBAS2I0BMRM9ZzfMfCWY1V3L2s/ejn65qtuqg10BcjgL99eN
         xGXK7Y1rBR1K3lnejH1oJH35wwCeiOcMFYV0+L+uniJR494wjjRjWqf7nukBlxG8iC1d
         kWzP4J14zRrWeQ4GarhtIC0lZ4qGKyBL1Hy9bDtiCTLdRc4Cyv7FWtfPRauv2hnL3PLC
         dZvB59Jany8npj+A7dbwTRAccbNmlQc1br5htscE+5dDnw7hPvYgZVnoA5Vzgvd2UbhO
         h5gg==
X-Gm-Message-State: AGi0PuZZD29Gacynml1DwMozFlDBaAskhlvJJiz/hZnz9jhn8FqXDx7a
        eJMv+RUQpKnvVLabtAFMJRLp2A==
X-Google-Smtp-Source: APiQypIl8kHy0vJTSgDHO3NDFuVTWIshHMvzxHXxZrmdtN+gbYl77AXGCCx7BFvBIpJU8kB7GnmXpA==
X-Received: by 2002:a17:90a:30e7:: with SMTP id h94mr584950pjb.186.1587405004347;
        Mon, 20 Apr 2020 10:50:04 -0700 (PDT)
Received: from bsegall-glaptop.localhost (c-73-71-82-80.hsd1.ca.comcast.net. [73.71.82.80])
        by smtp.gmail.com with ESMTPSA id j23sm256941pjz.13.2020.04.20.10.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 10:50:03 -0700 (PDT)
From:   bsegall@google.com
To:     Huaixin Chang <changhuaixin@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, bsegall@google.com, chiluk+linux@indeed.com,
        vincent.guittot@linaro.org, pauld@redhead.com
Subject: Re: [PATCH 1/2] sched: Defend cfs and rt bandwidth quota against overflow
References: <20200420024421.22442-1-changhuaixin@linux.alibaba.com>
        <20200420024421.22442-2-changhuaixin@linux.alibaba.com>
Date:   Mon, 20 Apr 2020 10:50:01 -0700
In-Reply-To: <20200420024421.22442-2-changhuaixin@linux.alibaba.com> (Huaixin
        Chang's message of "Mon, 20 Apr 2020 10:44:20 +0800")
Message-ID: <xm261roim4hi.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Huaixin Chang <changhuaixin@linux.alibaba.com> writes:

> Kernel limitation on cpu.cfs_quota_us is insufficient. Some large
> numbers might cause overflow in to_ratio() calculation and produce
> unexpected results.
>
> For example, if we make two cpu cgroups and then write a reasonable
> value and a large value into child's and parent's cpu.cfs_quota_us. This
> will cause a write error.
>
> 	cd /sys/fs/cgroup/cpu
> 	mkdir parent; mkdir parent/child
> 	echo 8000 > parent/child/cpu.cfs_quota_us
> 	# 17592186044416 is (1UL << 44)
> 	echo 17592186044416 > parent/cpu.cfs_quota_us
>
> In this case, quota will overflow and thus fail the __cfs_schedulable
> check. Similar overflow also affects rt bandwidth.

More to the point is that I think doing

echo 17592186044416 > parent/cpu.cfs_quota_us
echo 8000 > parent/child/cpu.cfs_quota_us

will only fail on the second write, while with this patch it will fail
on the first, which should be more understandable.


to_ratio could be altered to avoid unnecessary internal overflow, but
min_cfs_quota_period is less than 1<<BW_SHIFT, so a cutoff would still
be needed.

Also tg_rt_schedulable sums a bunch of to_ratio(), and doesn't check for
overflow on that sum, so if we consider preventing weirdness around
schedulable checks and max quotas relevant we should probably fix that too.

>
> Signed-off-by: Huaixin Chang <changhuaixin@linux.alibaba.com>
> ---
>  kernel/sched/core.c  | 8 ++++++++
>  kernel/sched/rt.c    | 9 +++++++++
>  kernel/sched/sched.h | 2 ++
>  3 files changed, 19 insertions(+)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 3a61a3b8eaa9..f0a74e35c3f0 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7390,6 +7390,8 @@ static DEFINE_MUTEX(cfs_constraints_mutex);
>  
>  const u64 max_cfs_quota_period = 1 * NSEC_PER_SEC; /* 1s */
>  static const u64 min_cfs_quota_period = 1 * NSEC_PER_MSEC; /* 1ms */
> +/* More than 203 days if BW_SHIFT equals 20. */
> +static const u64 max_cfs_runtime = MAX_BW_USEC * NSEC_PER_USEC;
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
> index df11d88c9895..f5eea19d68c4 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -2569,6 +2569,9 @@ static int __rt_schedulable(struct task_group *tg, u64 period, u64 runtime)
>  	return ret;
>  }
>  
> +/* More than 203 days if BW_SHIFT equals 20. */
> +static const u64 max_rt_runtime = MAX_BW_USEC * NSEC_PER_USEC;

It looks to me like __rt_schedulable doesn't divide by NSEC_PER_USEC, so
to_ratio is operating on nsec, and the limit is in nsec, and MAX_BW_USEC
should probably not be named USEC then as well.

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
>  	mutex_lock(&rt_constraints_mutex);
>  	err = __rt_schedulable(tg, rt_period, rt_runtime);
>  	if (err)
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index db3a57675ccf..6f6b7f545557 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1918,6 +1918,8 @@ extern void init_dl_inactive_task_timer(struct sched_dl_entity *dl_se);
>  #define BW_SHIFT		20
>  #define BW_UNIT			(1 << BW_SHIFT)
>  #define RATIO_SHIFT		8
> +#define MAX_BW_BITS		(64 - BW_SHIFT)
> +#define MAX_BW_USEC		((1UL << MAX_BW_BITS) - 1)
>  unsigned long to_ratio(u64 period, u64 runtime);
>  
>  extern void init_entity_runnable_average(struct sched_entity *se);
