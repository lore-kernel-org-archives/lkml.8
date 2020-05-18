Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5FAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 12:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6923020643
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 12:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgERMMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 08:12:22 -0400
Received: from foss.arm.com ([217.140.110.172]:39268 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726682AbgERMMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 08:12:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 985E4106F;
        Mon, 18 May 2020 05:12:20 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0201D3F305;
        Mon, 18 May 2020 05:12:17 -0700 (PDT)
Date:   Mon, 18 May 2020 13:12:10 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@am.com>,
        Jann Horn <jannh@google.com>, Ard Biesheuvel <ardb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@android.com
Subject: Re: [PATCH 4/6] scs: Move scs_overflow_check() out of architecture
 code
Message-ID: <20200518121210.GD1957@C02TD0UTHF1T.local>
References: <20200515172756.27185-1-will@kernel.org>
 <20200515172756.27185-5-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515172756.27185-5-will@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 06:27:54PM +0100, Will Deacon wrote:
> There is nothing architecture-specific about scs_overflow_check() as
> it's just a trivial wrapper around scs_corrupted().
> 
> For parity with task_stack_end_corrupted(), rename scs_corrupted() to
> task_scs_end_corrupted() and call it from schedule_debug() when
> CONFIG_SCHED_STACK_END_CHECK_is enabled. Finally, remove the unused
> scs_overflow_check() function entirely.
> 
> This has absolutely no impact on architectures that do not support SCS
> (currently arm64 only).
> 
> Signed-off-by: Will Deacon <will@kernel.org>

Pulling this out of arch code seems sane to me, and the arch-specific
chanes look sound. However, I have a concern with the changes within the
scheduler context-switch.

> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index a35d3318492c..56be4cbf771f 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -52,7 +52,6 @@
>  #include <asm/mmu_context.h>
>  #include <asm/processor.h>
>  #include <asm/pointer_auth.h>
> -#include <asm/scs.h>
>  #include <asm/stacktrace.h>
>  
>  #if defined(CONFIG_STACKPROTECTOR) && !defined(CONFIG_STACKPROTECTOR_PER_TASK)
> @@ -516,7 +515,6 @@ __notrace_funcgraph struct task_struct *__switch_to(struct task_struct *prev,
>  	entry_task_switch(next);
>  	uao_thread_switch(next);
>  	ssbs_thread_switch(next);
> -	scs_overflow_check(next);

Prior to this patch, we'd never switch to a task whose SCS had already
been corrupted.

With this patch, we only check that when switching away from a task, and
only when CONFIG_SCHED_STACK_END_CHECK is selected, which at first
glance seems to weaken that.

Arguably:

* If the next task's SCS was corrupted by that task while it was
  running, we had already lost at that point.

* If the next task's SCS was corrupted by another task, then that could
  also happen immediately after the check (though timing to avoid the
  check but affect the process could be harder).

... and a VMAP'd SCS would be much nicer in this regard.

Do we think this is weakening the check, or do we think it wasn't all
that helpful to begin with?

Mark.

>  
>  	/*
>  	 * Complete any pending TLB or cache maintenance on this CPU in case
> diff --git a/arch/arm64/kernel/scs.c b/arch/arm64/kernel/scs.c
> index adc97f826fab..955875dff9e1 100644
> --- a/arch/arm64/kernel/scs.c
> +++ b/arch/arm64/kernel/scs.c
> @@ -6,7 +6,7 @@
>   */
>  
>  #include <linux/percpu.h>
> -#include <asm/scs.h>
> +#include <linux/scs.h>
>  
>  /* Allocate a static per-CPU shadow stack */
>  #define DEFINE_SCS(name)						\
> diff --git a/include/linux/scs.h b/include/linux/scs.h
> index 0eb2485ef832..2fd3df50e93e 100644
> --- a/include/linux/scs.h
> +++ b/include/linux/scs.h
> @@ -47,7 +47,7 @@ static inline unsigned long *__scs_magic(void *s)
>  	return (unsigned long *)(s + SCS_SIZE) - 1;
>  }
>  
> -static inline bool scs_corrupted(struct task_struct *tsk)
> +static inline bool task_scs_end_corrupted(struct task_struct *tsk)
>  {
>  	unsigned long *magic = __scs_magic(task_scs(tsk));
>  	unsigned long sz = task_scs_sp(tsk) - task_scs(tsk);
> @@ -60,8 +60,8 @@ static inline bool scs_corrupted(struct task_struct *tsk)
>  static inline void scs_init(void) {}
>  static inline void scs_task_reset(struct task_struct *tsk) {}
>  static inline int scs_prepare(struct task_struct *tsk, int node) { return 0; }
> -static inline bool scs_corrupted(struct task_struct *tsk) { return false; }
>  static inline void scs_release(struct task_struct *tsk) {}
> +static inline bool task_scs_end_corrupted(struct task_struct *tsk) { return false; }
>  
>  #endif /* CONFIG_SHADOW_CALL_STACK */
>  
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 934e03cfaec7..a1d815a11b90 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3878,6 +3878,9 @@ static inline void schedule_debug(struct task_struct *prev, bool preempt)
>  #ifdef CONFIG_SCHED_STACK_END_CHECK
>  	if (task_stack_end_corrupted(prev))
>  		panic("corrupted stack end detected inside scheduler\n");
> +
> +	if (task_scs_end_corrupted(prev))
> +		panic("corrupted shadow stack detected inside scheduler\n");
>  #endif
>  
>  #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
> diff --git a/kernel/scs.c b/kernel/scs.c
> index aea841cd7586..faf0ecd7b893 100644
> --- a/kernel/scs.c
> +++ b/kernel/scs.c
> @@ -98,7 +98,8 @@ void scs_release(struct task_struct *tsk)
>  	if (!s)
>  		return;
>  
> -	WARN(scs_corrupted(tsk), "corrupted shadow stack detected when freeing task\n");
> +	WARN(task_scs_end_corrupted(tsk),
> +	     "corrupted shadow stack detected when freeing task\n");
>  	scs_check_usage(tsk);
>  	scs_free(s);
>  }
> -- 
> 2.26.2.761.g0e0b3e54be-goog
> 
