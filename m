Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471DDC11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FBCB24691
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582815528;
	bh=P/U2Bu3ajfX45ROuq/sc+nFZoVQM4+gBCl98sod0OQI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=l0xJYAiHjA1oreHAOW7T5aQMzYvDCD2E9Wx1clX3qZ5xOzGxmkVWl2h2469dfaI+4
	 tOB3bdJaZl+q3+GW6l0H7Z16Q9/WG/rohnOhHcF8AeMTDcHzsvX1vBKnvEixmPfOFQ
	 uqXhUXjbwaJ7Eo5ySIhxfl5Skw/eJhwqpagUximM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387794AbgB0O6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:58:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:59432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729983AbgB0O6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:58:46 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 470CD2468A;
        Thu, 27 Feb 2020 14:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582815525;
        bh=P/U2Bu3ajfX45ROuq/sc+nFZoVQM4+gBCl98sod0OQI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Yhk/1XEHmrfr9DyXUZfulIk/GVCgIpz8kPUNYqB59yadSzjWii0raaMQwHva9LM0Z
         C/4OApJSeChAWGHn24L0dB6EJGB+amerqqrpWfUI8CvBBLr7syb/Yvtc/MCnx06tTP
         qnw/Rwhxc8EPP5rl8YzvLcHfLpQd9+Etem4g1L6g=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id E5FF53521A4D; Thu, 27 Feb 2020 06:58:44 -0800 (PST)
Date:   Thu, 27 Feb 2020 06:58:44 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     andreyknvl@google.com, glider@google.com, dvyukov@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kcsan: Add current->state to implicitly atomic accesses
Message-ID: <20200227145844.GH2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200225143258.97949-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225143258.97949-1-elver@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 03:32:58PM +0100, Marco Elver wrote:
> Add volatile current->state to list of implicitly atomic accesses. This
> is in preparation to eventually enable KCSAN on kernel/sched (which
> currently still has KCSAN_SANITIZE := n).
> 
> Since accesses that match the special check in atomic.h are rare, it
> makes more sense to move this check to the slow-path, avoiding the
> additional compare in the fast-path. With the microbenchmark, a speedup
> of ~6% is measured.
> 
> Signed-off-by: Marco Elver <elver@google.com>

Queued for review and testing, thank you!

							Thanx, Paul

> ---
> 
> Example data race that was reported with KCSAN enabled on kernel/sched:
> 
> write to 0xffff9e42c4400050 of 8 bytes by task 311 on cpu 7:
>  ttwu_do_wakeup.isra.0+0x48/0x1f0 kernel/sched/core.c:2222
>  ttwu_remote kernel/sched/core.c:2286 [inline]
>  try_to_wake_up+0x9f8/0xbe0 kernel/sched/core.c:2585
>  wake_up_process+0x1e/0x30 kernel/sched/core.c:2669
>  __up.isra.0+0xb5/0xe0 kernel/locking/semaphore.c:261
>  ...
> 
> read to 0xffff9e42c4400050 of 8 bytes by task 310 on cpu 0:
>  sched_submit_work kernel/sched/core.c:4109 [inline]  <--- current->state read
>  schedule+0x3a/0x1a0 kernel/sched/core.c:4153
>  schedule_timeout+0x202/0x250 kernel/time/timer.c:1872
>  ...
> ---
>  kernel/kcsan/atomic.h  | 21 +++++++--------------
>  kernel/kcsan/core.c    | 22 +++++++++++++++-------
>  kernel/kcsan/debugfs.c | 27 ++++++++++++++++++---------
>  3 files changed, 40 insertions(+), 30 deletions(-)
> 
> diff --git a/kernel/kcsan/atomic.h b/kernel/kcsan/atomic.h
> index a9c1930534914..be9e625227f3b 100644
> --- a/kernel/kcsan/atomic.h
> +++ b/kernel/kcsan/atomic.h
> @@ -4,24 +4,17 @@
>  #define _KERNEL_KCSAN_ATOMIC_H
>  
>  #include <linux/jiffies.h>
> +#include <linux/sched.h>
>  
>  /*
> - * Helper that returns true if access to @ptr should be considered an atomic
> - * access, even though it is not explicitly atomic.
> - *
> - * List all volatile globals that have been observed in races, to suppress
> - * data race reports between accesses to these variables.
> - *
> - * For now, we assume that volatile accesses of globals are as strong as atomic
> - * accesses (READ_ONCE, WRITE_ONCE cast to volatile). The situation is still not
> - * entirely clear, as on some architectures (Alpha) READ_ONCE/WRITE_ONCE do more
> - * than cast to volatile. Eventually, we hope to be able to remove this
> - * function.
> + * Special rules for certain memory where concurrent conflicting accesses are
> + * common, however, the current convention is to not mark them; returns true if
> + * access to @ptr should be considered atomic. Called from slow-path.
>   */
> -static __always_inline bool kcsan_is_atomic(const volatile void *ptr)
> +static bool kcsan_is_atomic_special(const volatile void *ptr)
>  {
> -	/* only jiffies for now */
> -	return ptr == &jiffies;
> +	/* volatile globals that have been observed in data races. */
> +	return ptr == &jiffies || ptr == &current->state;
>  }
>  
>  #endif /* _KERNEL_KCSAN_ATOMIC_H */
> diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
> index 065615df88eaa..eb30ecdc8c009 100644
> --- a/kernel/kcsan/core.c
> +++ b/kernel/kcsan/core.c
> @@ -188,12 +188,13 @@ static __always_inline struct kcsan_ctx *get_ctx(void)
>  	return in_task() ? &current->kcsan_ctx : raw_cpu_ptr(&kcsan_cpu_ctx);
>  }
>  
> +/* Rules for generic atomic accesses. Called from fast-path. */
>  static __always_inline bool
>  is_atomic(const volatile void *ptr, size_t size, int type)
>  {
>  	struct kcsan_ctx *ctx;
>  
> -	if ((type & KCSAN_ACCESS_ATOMIC) != 0)
> +	if (type & KCSAN_ACCESS_ATOMIC)
>  		return true;
>  
>  	/*
> @@ -201,16 +202,16 @@ is_atomic(const volatile void *ptr, size_t size, int type)
>  	 * as atomic. This allows using them also in atomic regions, such as
>  	 * seqlocks, without implicitly changing their semantics.
>  	 */
> -	if ((type & KCSAN_ACCESS_ASSERT) != 0)
> +	if (type & KCSAN_ACCESS_ASSERT)
>  		return false;
>  
>  	if (IS_ENABLED(CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC) &&
> -	    (type & KCSAN_ACCESS_WRITE) != 0 && size <= sizeof(long) &&
> +	    (type & KCSAN_ACCESS_WRITE) && size <= sizeof(long) &&
>  	    IS_ALIGNED((unsigned long)ptr, size))
>  		return true; /* Assume aligned writes up to word size are atomic. */
>  
>  	ctx = get_ctx();
> -	if (unlikely(ctx->atomic_next > 0)) {
> +	if (ctx->atomic_next > 0) {
>  		/*
>  		 * Because we do not have separate contexts for nested
>  		 * interrupts, in case atomic_next is set, we simply assume that
> @@ -224,10 +225,8 @@ is_atomic(const volatile void *ptr, size_t size, int type)
>  			--ctx->atomic_next; /* in task, or outer interrupt */
>  		return true;
>  	}
> -	if (unlikely(ctx->atomic_nest_count > 0 || ctx->in_flat_atomic))
> -		return true;
>  
> -	return kcsan_is_atomic(ptr);
> +	return ctx->atomic_nest_count > 0 || ctx->in_flat_atomic;
>  }
>  
>  static __always_inline bool
> @@ -367,6 +366,15 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
>  	if (!kcsan_is_enabled())
>  		goto out;
>  
> +	/*
> +	 * Special atomic rules: unlikely to be true, so we check them here in
> +	 * the slow-path, and not in the fast-path in is_atomic(). Call after
> +	 * kcsan_is_enabled(), as we may access memory that is not yet
> +	 * initialized during early boot.
> +	 */
> +	if (!is_assert && kcsan_is_atomic_special(ptr))
> +		goto out;
> +
>  	if (!check_encodable((unsigned long)ptr, size)) {
>  		kcsan_counter_inc(KCSAN_COUNTER_UNENCODABLE_ACCESSES);
>  		goto out;
> diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
> index 2ff1961239778..72ee188ebc54a 100644
> --- a/kernel/kcsan/debugfs.c
> +++ b/kernel/kcsan/debugfs.c
> @@ -74,25 +74,34 @@ void kcsan_counter_dec(enum kcsan_counter_id id)
>   */
>  static noinline void microbenchmark(unsigned long iters)
>  {
> +	const struct kcsan_ctx ctx_save = current->kcsan_ctx;
> +	const bool was_enabled = READ_ONCE(kcsan_enabled);
>  	cycles_t cycles;
>  
> +	/* We may have been called from an atomic region; reset context. */
> +	memset(&current->kcsan_ctx, 0, sizeof(current->kcsan_ctx));
> +	/*
> +	 * Disable to benchmark fast-path for all accesses, and (expected
> +	 * negligible) call into slow-path, but never set up watchpoints.
> +	 */
> +	WRITE_ONCE(kcsan_enabled, false);
> +
>  	pr_info("KCSAN: %s begin | iters: %lu\n", __func__, iters);
>  
>  	cycles = get_cycles();
>  	while (iters--) {
> -		/*
> -		 * We can run this benchmark from multiple tasks; this address
> -		 * calculation increases likelyhood of some accesses
> -		 * overlapping. Make the access type an atomic read, to never
> -		 * set up watchpoints and test the fast-path only.
> -		 */
> -		unsigned long addr =
> -			iters % (CONFIG_KCSAN_NUM_WATCHPOINTS * PAGE_SIZE);
> -		__kcsan_check_access((void *)addr, sizeof(long), KCSAN_ACCESS_ATOMIC);
> +		unsigned long addr = iters & ((PAGE_SIZE << 8) - 1);
> +		int type = !(iters & 0x7f) ? KCSAN_ACCESS_ATOMIC :
> +				(!(iters & 0xf) ? KCSAN_ACCESS_WRITE : 0);
> +		__kcsan_check_access((void *)addr, sizeof(long), type);
>  	}
>  	cycles = get_cycles() - cycles;
>  
>  	pr_info("KCSAN: %s end   | cycles: %llu\n", __func__, cycles);
> +
> +	WRITE_ONCE(kcsan_enabled, was_enabled);
> +	/* restore context */
> +	current->kcsan_ctx = ctx_save;
>  }
>  
>  /*
> -- 
> 2.25.0.265.gbab2e86ba0-goog
> 
