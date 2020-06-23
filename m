Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C06C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 13:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3958720720
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 13:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exwGsBgv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732691AbgFWNZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 09:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732594AbgFWNZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 09:25:18 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC52AC061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 06:25:16 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ga6so1476029pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 06:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BWJQW3hcRxjehjaVGnWHvXOPUHWvfkKkyX5Owr7BYL0=;
        b=exwGsBgvJ7ouU0ikwqzoKFI3H1UVBZv4Cp6zxKnjk/N3BjLe/X437M9u8/TKltREbm
         PL0TsAn4Hn4s6U/xt12x1f9BTNuh0AUVPY4Dcdcd6ku4m2mieBXkoGIixdlbneaeK+yZ
         dsm7qa3SBUik6VwWXPrlqUaTPnGRBWiXlwjUDdiJBm8lnlmqVW62zMoFh/DiNVsQe7Xn
         HNQkKE6r2W7ezrzU8i3hs3E8nT23avAm2VGH/TPJv8GGD8Sby/qFVxpr6g7mzMvRDO5g
         dJR9HOlAdwizkd9B3xExgi6af7w26eyCmFWO9ColK2GzO07JBfwNrKQlyseGRyn+yyaf
         0u0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BWJQW3hcRxjehjaVGnWHvXOPUHWvfkKkyX5Owr7BYL0=;
        b=hCqSl7JS7ccApUHnqbO3kFcFgIDdqL4ZdHKwe/qllV1I//1ukZh2ZkFgyeT92/waXM
         sVRJ+073Vbwv6tNkanr4f65gUzZjc1fjxELZLaL3hQ2ek+1+9r6eNb5m7N+J0NBZhVRw
         nBCZ8/xuwxPl3GREofb2HaVSYtvc63TyLzmoM9lSPfX0ftK4sQbK/U+J4mrZ3iA89aPR
         wV2WEv8fUPs3T2R9R8pH3no2kugFKNlrYOmEIEDS3oZfAeF8YhaykIjtUf74pyh1Eod2
         a8eRkaYDYpjwn96Stcep8sxYmKfWtcF6A+awZ5f+zDcc8br4F/HHXoa6ZLJHwBd/Ye33
         xD7A==
X-Gm-Message-State: AOAM530g/IuEw0ddkLM10hwNxFvJ1HuvMhKJZRgp/JfVVzU9QAvR1fev
        Pu33EPdMWEGTuDZZZcbhf5V9U+wcQsJHpg==
X-Google-Smtp-Source: ABdhPJyCA6Z+qOstdjAQbxkt5a7gRhU2jqBXQcAVp+EqT0s5/af7cyehqMDdQTY84BcL/7qAK55A1w==
X-Received: by 2002:a17:90a:ce11:: with SMTP id f17mr23294071pju.123.1592918716202;
        Tue, 23 Jun 2020 06:25:16 -0700 (PDT)
Received: from aaronlu-desktop ([47.89.83.71])
        by smtp.gmail.com with ESMTPSA id v7sm16567820pfn.147.2020.06.23.06.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 06:25:15 -0700 (PDT)
Date:   Tue, 23 Jun 2020 21:25:07 +0800
From:   Aaron Lu <aaron.lwe@gmail.com>
To:     Peter Oskolkov <posk@posk.io>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Oskolkov <posk@google.com>, avagin@google.com,
        "pjt@google.com" <pjt@google.com>, Ben Segall <bsegall@google.com>
Subject: Re: [RFC PATCH 1/3 v2] futex: introduce FUTEX_SWAP operation
Message-ID: <20200623132507.GA875@aaronlu-desktop>
References: <cf7c83d0b58aa4912b465392ce8e40a974f250bb.camel@posk.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf7c83d0b58aa4912b465392ce8e40a974f250bb.camel@posk.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 10:22:26AM -0700, Peter Oskolkov wrote:
>  static void futex_wait_queue_me(struct futex_hash_bucket *hb, struct futex_q *q,
> -				struct hrtimer_sleeper *timeout)
> +				struct hrtimer_sleeper *timeout,
> +				struct task_struct *next)
>  {
>  	/*
>  	 * The task state is guaranteed to be set before another task can
> @@ -2627,10 +2644,27 @@ static void futex_wait_queue_me(struct futex_hash_bucket *hb, struct futex_q *q,
>  		 * flagged for rescheduling. Only call schedule if there
>  		 * is no timeout, or if it has yet to expire.
>  		 */
> -		if (!timeout || timeout->task)
> +		if (!timeout || timeout->task) {
> +			if (next) {
> +				/*
> +				 * wake_up_process() below will be replaced
> +				 * in the next patch with
> +				 * wake_up_process_prefer_current_cpu().
> +				 */
> +				wake_up_process(next);
> +				put_task_struct(next);
> +				next = NULL;
> +			}

So in futex_swap case, the wake up occurs in futex_wait_queue_me(). I
personally think it's more natural to do the wakeup in futex_swap()
instead.

>  			freezable_schedule();
> +		}
>  	}
>  	__set_current_state(TASK_RUNNING);
> +
> +	if (next) {
> +		/* Maybe call wake_up_process_prefer_current_cpu()? */
> +		wake_up_process(next);
> +		put_task_struct(next);
> +	}
>  }
> 
>  /**

> +static int futex_swap(u32 __user *uaddr, unsigned int flags, u32 val,
> +		      ktime_t *abs_time, u32 __user *uaddr2)
> +{
> +	u32 bitset = FUTEX_BITSET_MATCH_ANY;
> +	struct task_struct *next = NULL;
> +	DEFINE_WAKE_Q(wake_q);
> +	int ret;
> +
> +	ret = prepare_wake_q(uaddr2, flags, 1, bitset, &wake_q);
> +	if (!wake_q_empty(&wake_q)) {
> +		/* Pull the first wakee out of the queue to swap into. */
> +		next = container_of(wake_q.first, struct task_struct, wake_q);
> +		wake_q.first = wake_q.first->next;
> +		next->wake_q.next = NULL;
> +		/*
> +		 * Note that wake_up_q does not touch wake_q.last, so we
> +		 * do not bother with it here.
> +		 */
> +		wake_up_q(&wake_q);

wake_up_q() doesn't seem to serve any purpose in that the above
assignment of wake_q.first shall make it an empty queue now?
Also, I don't see a need to touch wake_q.first either so I think we can
get rid of wake_q altogether here.

> +	}
> +	if (ret < 0)
> +		return ret;
> +
> +	return futex_wait(uaddr, flags, val, abs_time, bitset, next);
> +}

I've cooked the below diff, on top of your patchset. It survived your
self test and schbench. Feel free to ignore it if you don't like it, or
merge it into your patchset if you think it looks better.

do wake up in futex_swap()

---
 kernel/futex.c | 43 +++++++++++--------------------------------
 1 file changed, 11 insertions(+), 32 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index a426671e4bbb..995bc881059c 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -2618,8 +2618,7 @@ static int fixup_owner(u32 __user *uaddr, struct futex_q *q, int locked)
  *		prefer to execute it locally.
  */
 static void futex_wait_queue_me(struct futex_hash_bucket *hb, struct futex_q *q,
-				struct hrtimer_sleeper *timeout,
-				struct task_struct *next)
+				struct hrtimer_sleeper *timeout)
 {
 	/*
 	 * The task state is guaranteed to be set before another task can
@@ -2644,22 +2643,11 @@ static void futex_wait_queue_me(struct futex_hash_bucket *hb, struct futex_q *q,
 		 * flagged for rescheduling. Only call schedule if there
 		 * is no timeout, or if it has yet to expire.
 		 */
-		if (!timeout || timeout->task) {
-			if (next) {
-				wake_up_process_prefer_current_cpu(next);
-				put_task_struct(next);
-				next = NULL;
-			}
+		if (!timeout || timeout->task)
 			freezable_schedule();
-		}
 	}
-	__set_current_state(TASK_RUNNING);
 
-	if (next) {
-		/* Maybe call wake_up_process_prefer_current_cpu()? */
-		wake_up_process(next);
-		put_task_struct(next);
-	}
+	__set_current_state(TASK_RUNNING);
 }
 
 /**
@@ -2739,7 +2727,7 @@ static int futex_wait_setup(u32 __user *uaddr, u32 val, unsigned int flags,
 }
 
 static int futex_wait(u32 __user *uaddr, unsigned int flags, u32 val,
-		      ktime_t *abs_time, u32 bitset, struct task_struct *next)
+		      ktime_t *abs_time, u32 bitset)
 {
 	struct hrtimer_sleeper timeout, *to;
 	struct restart_block *restart;
@@ -2763,8 +2751,7 @@ static int futex_wait(u32 __user *uaddr, unsigned int flags, u32 val,
 		goto out;
 
 	/* queue_me and wait for wakeup, timeout, or a signal. */
-	futex_wait_queue_me(hb, &q, to, next);
-	next = NULL;
+	futex_wait_queue_me(hb, &q, to);
 
 	/* If we were woken (and unqueued), we succeeded, whatever. */
 	ret = 0;
@@ -2797,10 +2784,6 @@ static int futex_wait(u32 __user *uaddr, unsigned int flags, u32 val,
 	ret = -ERESTART_RESTARTBLOCK;
 
 out:
-	if (next) {
-		wake_up_process(next);
-		put_task_struct(next);
-	}
 	if (to) {
 		hrtimer_cancel(&to->timer);
 		destroy_hrtimer_on_stack(&to->timer);
@@ -2820,7 +2803,7 @@ static long futex_wait_restart(struct restart_block *restart)
 	restart->fn = do_no_restart_syscall;
 
 	return (long)futex_wait(uaddr, restart->futex.flags, restart->futex.val,
-				tp, restart->futex.bitset, NULL);
+				tp, restart->futex.bitset);
 }
 
 static int futex_swap(u32 __user *uaddr, unsigned int flags, u32 val,
@@ -2835,18 +2818,14 @@ static int futex_swap(u32 __user *uaddr, unsigned int flags, u32 val,
 	if (!wake_q_empty(&wake_q)) {
 		/* Pull the first wakee out of the queue to swap into. */
 		next = container_of(wake_q.first, struct task_struct, wake_q);
-		wake_q.first = wake_q.first->next;
 		next->wake_q.next = NULL;
-		/*
-		 * Note that wake_up_q does not touch wake_q.last, so we
-		 * do not bother with it here.
-		 */
-		wake_up_q(&wake_q);
+		wake_up_process_prefer_current_cpu(next);
+		put_task_struct(next);
 	}
 	if (ret < 0)
 		return ret;
 
-	return futex_wait(uaddr, flags, val, abs_time, bitset, next);
+	return futex_wait(uaddr, flags, val, abs_time, bitset);
 }
 
 /*
@@ -3333,7 +3312,7 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 	}
 
 	/* Queue the futex_q, drop the hb lock, wait for wakeup. */
-	futex_wait_queue_me(hb, &q, to, NULL);
+	futex_wait_queue_me(hb, &q, to);
 
 	spin_lock(&hb->lock);
 	ret = handle_early_requeue_pi_wakeup(hb, &q, &key2, to);
@@ -3863,7 +3842,7 @@ long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 		val3 = FUTEX_BITSET_MATCH_ANY;
 		/* fall through */
 	case FUTEX_WAIT_BITSET:
-		return futex_wait(uaddr, flags, val, timeout, val3, NULL);
+		return futex_wait(uaddr, flags, val, timeout, val3);
 	case FUTEX_WAKE:
 		val3 = FUTEX_BITSET_MATCH_ANY;
 		/* fall through */
-- 
2.26.2

