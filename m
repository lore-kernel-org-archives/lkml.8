Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0284C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 17:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A10F22073E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 17:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EYPhvjCC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbgCZR2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 13:28:06 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:50735 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727889AbgCZR2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 13:28:06 -0400
Received: by mail-pj1-f67.google.com with SMTP id v13so2759908pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 10:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=D0/COPPGR5pb1BR3H03WQvoeG9Sl2jWxjAzThIYaXiU=;
        b=EYPhvjCCQaUdd5QO0PGwDwWJyqK6MoHmiV6e4PerQpMgN9GsI1tT3LFFZ2dJ0doV+0
         SBZlrqNEw/0YlclYl800HXHJOlcq0ak/PaeaKCXy1b/wK7/fW9lcglKQGUVCHUajFfF8
         MtD6N3IujSm0MH8gPZEZ9kcO13GM3OyYQtEJdWowPvpWJXzvz4WwblN9cBnXAyIL/m9A
         Tj3zLkSNVpz9MNnqpCYQ/f526+IfnM69wZemQ69crGUWKMQuKoHUj9XZLfIgCOa9kSlA
         qfzVSlV4j3rYcAxgQY7JFP2kFnWgJ5Z6pvzXh42VqEGOtJrmR9HxSUn7ZsOgER7FE8Fb
         IP/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=D0/COPPGR5pb1BR3H03WQvoeG9Sl2jWxjAzThIYaXiU=;
        b=Jkw3G0xm1MW1tULWJArW0Fc5fRQZCqRZ3MSLyP9D47OSVP3TJ4QUa6S33rtmzN6T7e
         rTt7P5DmEzuKNQkeC9G/YcMHz0HsFpHHsRts2LO0UGmNgMeudr+xiLqy3ipRmMrE/FSB
         1ZCxlpvdz+BiWgyuusza5U6WkWaHlchhiOtCNnLP06iNY/9vGLyBaxdC2mYQEv1RFBOP
         gajGeV4hPZZAiFE6YWhmJowah+bAkNZDw8p2XHLqEhDipF9KvU8IZsn3OGVYl/HkzSyl
         OnNwATbrLJpVk1iRh1hIUxz7cQpqebc5lCF9CkFpNDhSkNmg/VUr1La6suuDd+2Jztnk
         tuGQ==
X-Gm-Message-State: ANhLgQ0pFmpVbAkJpR653RgUenu6pQA3zo/jEzmk1FiTnmXJ60yebBd1
        mErIZ0IrklV035IJVYrWW8Uvnw==
X-Google-Smtp-Source: ADFU+vsGUV+u72QL3wvgmlf/0qF3uTbOK0AGnHQp1wLenHfJudPEtBeh7qETUWSHWBOUlfHBAmNGNA==
X-Received: by 2002:a17:902:8546:: with SMTP id d6mr9174931plo.193.1585243683102;
        Thu, 26 Mar 2020 10:28:03 -0700 (PDT)
Received: from bsegall-glaptop.localhost (c-73-71-82-80.hsd1.ca.comcast.net. [73.71.82.80])
        by smtp.gmail.com with ESMTPSA id u18sm2150070pfl.40.2020.03.26.10.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 10:28:01 -0700 (PDT)
From:   bsegall@google.com
To:     Huaixin Chang <changhuaixin@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, shanpeic@linux.alibaba.com,
        yun.wang@linux.alibaba.com, xlpang@linux.alibaba.com,
        peterz@infradead.org, mingo@redhat.com, bsegall@google.com,
        chiluk+linux@indeed.com, vincent.guittot@linaro.org
Subject: Re: [PATCH v2] sched: Fix race between runtime distribution and assignment
References: <20200325092602.22471-1-changhuaixin@linux.alibaba.com>
        <20200326065606.19193-1-changhuaixin@linux.alibaba.com>
Date:   Thu, 26 Mar 2020 10:27:59 -0700
In-Reply-To: <20200326065606.19193-1-changhuaixin@linux.alibaba.com> (Huaixin
        Chang's message of "Thu, 26 Mar 2020 14:56:06 +0800")
Message-ID: <xm26v9mrni00.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Huaixin Chang <changhuaixin@linux.alibaba.com> writes:

> Currently, there is a potential race between distribute_cfs_runtime()
> and assign_cfs_rq_runtime(). Race happens when cfs_b->runtime is read,
> distributes without holding lock and finds out there is not enough
> runtime to charge against after distribution. Because
> assign_cfs_rq_runtime() might be called during distribution, and use
> cfs_b->runtime at the same time.
>
> Fibtest is the tool to test this race. Assume all gcfs_rq is throttled
> and cfs period timer runs, slow threads might run and sleep, returning
> unused cfs_rq runtime and keeping min_cfs_rq_runtime in their local
> pool. If all this happens sufficiently quickly, cfs_b->runtime will drop
> a lot. If runtime distributed is large too, over-use of runtime happens.
>
> A runtime over-using by about 70 percent of quota is seen when we
> test fibtest on a 96-core machine. We run fibtest with 1 fast thread and
> 95 slow threads in test group, configure 10ms quota for this group and
> see the CPU usage of fibtest is 17.0%, which is far more than the
> expected 10%.
>
> On a smaller machine with 32 cores, we also run fibtest with 96
> threads. CPU usage is more than 12%, which is also more than expected
> 10%. This shows that on similar workloads, this race do affect CPU
> bandwidth control.
>
> Solve this by holding lock inside distribute_cfs_runtime().

Some minor requests below, other than that

Reviewed-by: Ben Segall <bsegall@google.com>

>
> Fixes: c06f04c70489 ("sched: Fix potential near-infinite distribute_cfs_runtime() loop")
> Signed-off-by: Huaixin Chang <changhuaixin@linux.alibaba.com>
> ---
> v2: fix spelling, initialize variable rumaining in distribute_cfs_runtime()
> ---
>  kernel/sched/fair.c | 31 ++++++++++++-------------------
>  1 file changed, 12 insertions(+), 19 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index c1217bfe5e81..fd30e06a7ffc 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4629,11 +4629,11 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
>  		resched_curr(rq);
>  }
>  
> -static u64 distribute_cfs_runtime(struct cfs_bandwidth *cfs_b, u64 remaining)
> +static void distribute_cfs_runtime(struct cfs_bandwidth *cfs_b)
>  {
>  	struct cfs_rq *cfs_rq;
> -	u64 runtime;
> -	u64 starting_runtime = remaining;
> +	u64 runtime, remaining = 1;
> +	unsigned long flags;
>  
>  	rcu_read_lock();
>  	list_for_each_entry_rcu(cfs_rq, &cfs_b->throttled_cfs_rq,
> @@ -4648,10 +4648,13 @@ static u64 distribute_cfs_runtime(struct cfs_bandwidth *cfs_b, u64 remaining)
>  		/* By the above check, this should never be true */
>  		SCHED_WARN_ON(cfs_rq->runtime_remaining > 0);
>  
> +		raw_spin_lock_irqsave(&cfs_b->lock, flags);

No need for _irqsave/_irqrestore, the rqlock already did.

>  		runtime = -cfs_rq->runtime_remaining + 1;
> -		if (runtime > remaining)
> -			runtime = remaining;
> -		remaining -= runtime;
> +		if (runtime > cfs_b->runtime)
> +			runtime = cfs_b->runtime;
> +		cfs_b->runtime -= runtime;
> +		remaining = cfs_b->runtime;
> +		raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
>  
>  		cfs_rq->runtime_remaining += runtime;
>  
> @@ -4666,8 +4669,6 @@ static u64 distribute_cfs_runtime(struct cfs_bandwidth *cfs_b, u64 remaining)
>  			break;
>  	}
>  	rcu_read_unlock();
> -
> -	return starting_runtime - remaining;
>  }
>  
>  /*
> @@ -4678,7 +4679,6 @@ static u64 distribute_cfs_runtime(struct cfs_bandwidth *cfs_b, u64 remaining)
>   */
>  static int do_sched_cfs_period_timer(struct cfs_bandwidth *cfs_b, int overrun, unsigned long flags)
>  {
> -	u64 runtime;
>  	int throttled;
>  
>  	/* no need to continue the timer with no bandwidth constraint */
> @@ -4708,23 +4708,17 @@ static int do_sched_cfs_period_timer(struct cfs_bandwidth *cfs_b, int overrun, u
>  
>  	/*
>  	 * This check is repeated as we are holding onto the new bandwidth while
> -	 * we unthrottle. This can potentially race with an unthrottled group
> -	 * trying to acquire new bandwidth from the global pool. This can result
> -	 * in us over-using our runtime if it is all used during this loop, but
> -	 * only by limited amounts in that extreme case.
> +	 * we unthrottle.

"This check is repeated as we release cfs_b->lock while we unthrottle."
or something like that. This code is no longer even holding onto the new
bandwidth on its own.

>  	 */
>  	while (throttled && cfs_b->runtime > 0 && !cfs_b->distribute_running) {
> -		runtime = cfs_b->runtime;
>  		cfs_b->distribute_running = 1;
>  		raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
>  		/* we can't nest cfs_b->lock while distributing bandwidth */
> -		runtime = distribute_cfs_runtime(cfs_b, runtime);
> +		distribute_cfs_runtime(cfs_b);
>  		raw_spin_lock_irqsave(&cfs_b->lock, flags);
>  
>  		cfs_b->distribute_running = 0;
>  		throttled = !list_empty(&cfs_b->throttled_cfs_rq);
> -
> -		lsub_positive(&cfs_b->runtime, runtime);
>  	}
>  
>  	/*
> @@ -4858,10 +4852,9 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
>  	if (!runtime)
>  		return;
>  
> -	runtime = distribute_cfs_runtime(cfs_b, runtime);
> +	distribute_cfs_runtime(cfs_b);
>  
>  	raw_spin_lock_irqsave(&cfs_b->lock, flags);
> -	lsub_positive(&cfs_b->runtime, runtime);
>  	cfs_b->distribute_running = 0;
>  	raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
>  }
