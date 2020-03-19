Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CF6C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 00:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F6D720754
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 00:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbgCSAi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 20:38:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59175 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgCSAiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 20:38:55 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jEjCz-0005An-OZ; Thu, 19 Mar 2020 01:38:50 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id EA786103088; Thu, 19 Mar 2020 01:38:48 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Balbir Singh <sblbir@amazon.com>, linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Balbir Singh <sblbir@amazon.com>,
        keescook@chromium.org, benh@amazon.com
Subject: Re: [RFC PATCH] arch/x86: Optionally flush L1D on context switch
In-Reply-To: <20200313220415.856-1-sblbir@amazon.com>
References: <20200313220415.856-1-sblbir@amazon.com>
Date:   Thu, 19 Mar 2020 01:38:48 +0100
Message-ID: <87imj19o13.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir,

Balbir Singh <sblbir@amazon.com> writes:
> This patch is an RFC/PoC to start the discussion on optionally flushing
> L1D cache.  The goal is to allow tasks that are paranoid due to the recent
> snoop assisted data sampling vulnerabilites, to flush their L1D on being
> switched out.  This protects their data from being snooped or leaked via
> side channels after the task has context switched out.

What you mean is that L1D is flushed before another task which does not
belong to the same trust zone returns to user space or enters guest
mode.

> There are two scenarios we might want to protect against, a task leaving
> the CPU with data still in L1D (which is the main concern of this
> patch), the second scenario is a malicious task coming in (not so well
> trusted) for which we want to clean up the cache before it starts
> execution. The latter was proposed by benh and is not currently
> addressed by this patch, but can be easily accommodated by the same
> mechanism.

What's the point? The attack surface is the L1D content of the scheduled
out task. If the malicious task schedules out, then why would you care?

I might be missing something, but AFAICT this is beyond paranoia.

> The points of discussion/review are:
>
> 1. Discuss the use case and the right approach to address this

It might be the quick fix for the next not yet known variant of L1D
based horrors, so yes it's at least worth to discuss it.

> 2. Does an arch prctl allowing for opt-in flushing make sense, would other
>    arches care about something similar?

No idea, but I assume in the light of L1D based issues that might be the
case. Though that still is per architecture as the L1D flush mechanisms
are architecture specific. Aside of that I don't think that more than a
few will enable / support it.

> 3. There is a fallback software L1D load, similar to what L1TF does, but
>    we don't prefetch the TLB, is that sufficient?

If we go there, then the KVM L1D flush code wants to move into general
x86 code.

> 4. The atomics can be improved and we could use a static key like ibpb
>    does to optimize the code path

Yes to static key.

> 5. The code works with a special hack for 64 bit systems (TIF_L1D_FLUSH
>    is bit 32), we could generalize it with some effort

Why so? There are gaps in the TIF flags (18, 23, 26). Why do you want to
push that to 32?

> 6. Should we consider cleaning up the L1D on arrival of tasks?

That's the Ben idea, right? If so see above.

> +#define L1D_CACHE_ORDER 4
> +static void *l1d_flush_pages;
> +static DEFINE_MUTEX(l1d_flush_mutex);
> +
> +void enable_l1d_flush_for_task(struct task_struct *tsk)
> +{
> +	struct page *page;
> +
> +	if (static_cpu_has(X86_FEATURE_FLUSH_L1D))
> +		goto done;
> +
> +	mutex_lock(&l1d_flush_mutex);
> +	if (l1d_flush_pages)
> +		goto done;
> +	/*
> +	 * These pages are never freed, we use the same
> +	 * set of pages across multiple processes/contexts
> +	 */
> +	page = alloc_pages(GFP_KERNEL | __GFP_ZERO, L1D_CACHE_ORDER);
> +	if (!page)
> +		return;
> +
> +	l1d_flush_pages = page_address(page);
> +	/* I don't think we need to worry about KSM */

Why not? Even if it wouldn't be necessary why would we care as this is a
once per boot operation in fully preemptible code.

Aside of that why do we need another pointlessly different copy of what
we have in the VMX code?

> +done:
> +	set_ti_thread_flag(&tsk->thread_info, TIF_L1D_FLUSH);
> +	mutex_unlock(&l1d_flush_mutex);
> +}
> +
> +void disable_l1d_flush_for_task(struct task_struct *tsk)
> +{
> +	clear_ti_thread_flag(&tsk->thread_info, TIF_L1D_FLUSH);
> +	smp_mb__after_atomic();

Lacks an explanation / comment what this smp_mb is for and where the
counterpart lives.

Aside of that, this is pointless AFAICT. Disable/enable is really not a
concern of being perfect. If you want perfect protection, simply switch
off your computer.

> +/*
> + * Flush the L1D cache for this CPU. We want to this at switch mm time,
> + * this is a pessimistic security measure and an opt-in for those tasks
> + * that host sensitive information and there are concerns about spills
> + * from fill buffers.
> + */
> +static void l1d_flush(struct mm_struct *next, struct task_struct *tsk)
> +{
> +	struct mm_struct *real_prev = this_cpu_read(cpu_tlbstate.loaded_mm);
> +	int size = PAGE_SIZE << L1D_CACHE_ORDER;
> +
> +	if (this_cpu_read(cpu_tlbstate.last_user_mm_l1d_flush) == 0)
> +		goto check_next;
> +
> +	if (real_prev == next)
> +		return;
> +
> +	if (static_cpu_has(X86_FEATURE_FLUSH_L1D)) {
> +		wrmsrl(MSR_IA32_FLUSH_CMD, L1D_FLUSH);
> +		goto done;
> +	}
> +
> +	asm volatile(
> +		/* Fill the cache */
> +		"xorl	%%eax, %%eax\n"
> +		".Lfill_cache:\n"
> +		"movzbl	(%[flush_pages], %%" _ASM_AX "), %%ecx\n\t"
> +		"addl	$64, %%eax\n\t"
> +		"cmpl	%%eax, %[size]\n\t"
> +		"jne	.Lfill_cache\n\t"
> +		"lfence\n"
> +		:: [flush_pages] "r" (l1d_flush_pages),
> +		    [size] "r" (size)
> +		: "eax", "ecx");

Yet moar copied code slighlty different for no reason.

> +
> +done:
> +	this_cpu_write(cpu_tlbstate.last_user_mm_l1d_flush, 0);
> +	/* Make sure we clear the values before we set it again */
> +	barrier();
> +check_next:
> +	if (tsk == NULL)
> +		return;
> +
> +	/* Match the set/clear_bit barriers */
> +	smp_rmb();

What for again?

> +	/* We don't need stringent checks as we opt-in/opt-out */
> +	if (test_ti_thread_flag(&tsk->thread_info, TIF_L1D_FLUSH))
> +		this_cpu_write(cpu_tlbstate.last_user_mm_l1d_flush, 1);
> +}
> +
>  void switch_mm(struct mm_struct *prev, struct mm_struct *next,
>  	       struct task_struct *tsk)
>  {
> @@ -433,6 +519,8 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
>  		trace_tlb_flush_rcuidle(TLB_FLUSH_ON_TASK_SWITCH, 0);
>  	}
>  
> +	l1d_flush(next, tsk);

This is really the wrong place. You want to do that:

  1) Just before return to user space
  2) When entering a guest

and only when the previously running user space task was the one which
requested this massive protection.

While it's worth to discuss, I'm not yet convinced that this is worth
the trouble.

Thanks,

        tglx
