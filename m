Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EEAC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA5DE2073B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mB7dcOfD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgEDSjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 14:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726922AbgEDSjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 14:39:42 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF37C061A0F
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 11:39:42 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id f7so5958037pfa.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 11:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HHGnpZDXNWtc2ZXHWoE7IBPfIfyF2Gp15hxd+mqQeac=;
        b=mB7dcOfDyF55SrkNkNtlzOieU6ntSsXUyd+v14qSbd3zmxepkW9G5VDRyTxpwOM80A
         eRuLihXk8JPDSRNHgd9Kz7UDwCTL2jCgZWpoCp2IzCWNV7aECVF+cxF700T0RD5QY96L
         x1J7M1xm9i55xSAbXwFYLQ7lGPlfNnV0LmaIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HHGnpZDXNWtc2ZXHWoE7IBPfIfyF2Gp15hxd+mqQeac=;
        b=hCJGlvxG5op5/rBVdZfbhnQACF/N1BajOzJFi1Z4RUWYve4Ux6xpPFESSUvrYFim/L
         kJuZZtJnve8T91z6613GF81QidA+nV3xTI9D1KxAWjv6S+P/ZRgTv7G+m5fNdAU3Lquk
         MXsR7lgDmB6wEE91h6kOwHNsQflsvoNb+sRd08aodySVIN9/f/o7ImLqr5k7BiwEKR1J
         JgP1I4JJTCnCbLjISyTMDcpvsYHEkcViaKytyyatSqfKDD2szXssF1renc09vzArt6rj
         boRLmxNasm0/3tx/EMi9YJ7dpuHGEulTkdthOwZopUmqqXc28YgiOcMbkpOaykcP3QMb
         ZIJw==
X-Gm-Message-State: AGi0PuYssM48xTERX4gT1WQJPWeK3hBUBaDBDZzOtY897jUh6UFtPUMJ
        doT6+VDqM40p5BMJo8lCqSFmOQ==
X-Google-Smtp-Source: APiQypJs8nsTUujsj4babKNvQjEo8f+wsLcou0d/bKL6C9JU2H/yCyCv3wdZi7GSaTNUpuhuwrZ7HQ==
X-Received: by 2002:aa7:9297:: with SMTP id j23mr18130809pfa.15.1588617581725;
        Mon, 04 May 2020 11:39:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z13sm162879pjz.42.2020.05.04.11.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 11:39:40 -0700 (PDT)
Date:   Mon, 4 May 2020 11:39:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Balbir Singh <sblbir@amazon.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        jpoimboe@redhat.com, tony.luck@intel.com, benh@kernel.crashing.org,
        x86@kernel.org, dave.hansen@intel.com, thomas.lendacky@amd.com
Subject: Re: [PATCH v5 5/6] Optionally flush L1D on context switch
Message-ID: <202005041135.764E9DD7@keescook>
References: <20200504041343.9651-1-sblbir@amazon.com>
 <20200504041343.9651-6-sblbir@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504041343.9651-6-sblbir@amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 04, 2020 at 02:13:42PM +1000, Balbir Singh wrote:
> Implement a mechanism to selectively flush the L1D cache. The goal is to
> allow tasks that are paranoid due to the recent snoop assisted data sampling
> vulnerabilites, to flush their L1D on being switched out.  This protects
> their data from being snooped or leaked via side channels after the task
> has context switched out.
> 
> There are two scenarios we might want to protect against, a task leaving
> the CPU with data still in L1D (which is the main concern of this patch),
> the second scenario is a malicious task coming in (not so well trusted)
> for which we want to clean up the cache before it starts. Only the case
> for the former is addressed.
> 
> A new thread_info flag TIF_SPEC_FLUSH_L1D is added to track tasks which
> opt-into L1D flushing. cpu_tlbstate.last_user_mm_spec is used to convert
> the TIF flags into mm state (per cpu via last_user_mm_spec) in
> cond_mitigation(), which then used to do decide when to call flush_l1d().
> 
> Add prctl()'s to opt-in to the L1D cache on context switch out, the
> existing mechanisms of tracking prev_mm via cpu_tlbstate is
> reused to track state of the tasks and to flush the L1D cache.
> The prctl interface is generic and can be ported over to other
> architectures.
> 
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Balbir Singh <sblbir@amazon.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/x86/include/asm/thread_info.h |  7 ++++-
>  arch/x86/mm/tlb.c                  | 44 ++++++++++++++++++++++++++++--
>  include/uapi/linux/prctl.h         |  4 +++
>  kernel/sys.c                       | 20 ++++++++++++++
>  4 files changed, 72 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
> index 8de8ceccb8bc..67de693d9ba1 100644
> --- a/arch/x86/include/asm/thread_info.h
> +++ b/arch/x86/include/asm/thread_info.h
> @@ -84,7 +84,7 @@ struct thread_info {
>  #define TIF_SYSCALL_AUDIT	7	/* syscall auditing active */
>  #define TIF_SECCOMP		8	/* secure computing */
>  #define TIF_SPEC_IB		9	/* Indirect branch speculation mitigation */
> -#define TIF_SPEC_FORCE_UPDATE	10	/* Force speculation MSR update in context switch */
> +#define TIF_SPEC_FLUSH_L1D	10	/* Flush L1D on mm switches (processes) */
>  #define TIF_USER_RETURN_NOTIFY	11	/* notify kernel of userspace return */
>  #define TIF_UPROBE		12	/* breakpointed or singlestepping */
>  #define TIF_PATCH_PENDING	13	/* pending live patching update */
> @@ -96,6 +96,7 @@ struct thread_info {
>  #define TIF_MEMDIE		20	/* is terminating due to OOM killer */
>  #define TIF_POLLING_NRFLAG	21	/* idle is polling for TIF_NEED_RESCHED */
>  #define TIF_IO_BITMAP		22	/* uses I/O bitmap */
> +#define TIF_SPEC_FORCE_UPDATE	23	/* Force speculation MSR update in context switch */
>  #define TIF_FORCED_TF		24	/* true if TF in eflags artificially */
>  #define TIF_BLOCKSTEP		25	/* set when we want DEBUGCTLMSR_BTF */
>  #define TIF_LAZY_MMU_UPDATES	27	/* task is updating the mmu lazily */
> @@ -132,6 +133,7 @@ struct thread_info {
>  #define _TIF_ADDR32		(1 << TIF_ADDR32)
>  #define _TIF_X32		(1 << TIF_X32)
>  #define _TIF_FSCHECK		(1 << TIF_FSCHECK)
> +#define _TIF_SPEC_FLUSH_L1D	(1 << TIF_SPEC_FLUSH_L1D)
>  
>  /* Work to do before invoking the actual syscall. */
>  #define _TIF_WORK_SYSCALL_ENTRY	\
> @@ -235,6 +237,9 @@ static inline int arch_within_stack_frames(const void * const stack,
>  			   current_thread_info()->status & TS_COMPAT)
>  #endif
>  
> +extern int arch_prctl_l1d_flush_set(struct task_struct *tsk, unsigned long enable);
> +extern int arch_prctl_l1d_flush_get(struct task_struct *tsk);
> +
>  extern void arch_task_cache_init(void);
>  extern int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
>  extern void arch_release_task_struct(struct task_struct *tsk);
> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index 10056b8d8f01..7ea9bc9e089f 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -13,6 +13,7 @@
>  #include <asm/mmu_context.h>
>  #include <asm/nospec-branch.h>
>  #include <asm/cache.h>
> +#include <asm/cacheflush.h>
>  #include <asm/apic.h>
>  #include <asm/uv/uv.h>
>  
> @@ -43,11 +44,12 @@
>   */
>  
>  /*
> - * Bits to mangle the TIF_SPEC_IB state into the mm pointer which is
> + * Bits to mangle the TIF_SPEC_* state into the mm pointer which is
>   * stored in cpu_tlb_state.last_user_mm_spec.
>   */
>  #define LAST_USER_MM_IBPB	0x1UL
> -#define LAST_USER_MM_SPEC_MASK	(LAST_USER_MM_IBPB)
> +#define LAST_USER_MM_L1D_FLUSH	0x2UL
> +#define LAST_USER_MM_SPEC_MASK	(LAST_USER_MM_IBPB | LAST_USER_MM_L1D_FLUSH)
>  
>  /*
>   * The x86 feature is called PCID (Process Context IDentifier). It is similar
> @@ -308,6 +310,35 @@ void leave_mm(int cpu)
>  }
>  EXPORT_SYMBOL_GPL(leave_mm);
>  
> +static int enable_l1d_flush_for_task(struct task_struct *tsk)
> +{
> +	int ret = l1d_flush_init_once();
> +
> +	if (ret < 0)
> +		return ret;

Am I reading correctly (in the v5 delta) that with l1d_flush_init_once()
now testing for Intel CPUs, it means processes on non-Intel x86 CPUs
can't use the prctl() feature as a defense-in-depth to potential future
L1D cache side-channel flaws?

Why can't the L1D_CACHE_ORDER just get set dynamically based on CPU?

> +
> +	set_ti_thread_flag(&tsk->thread_info, TIF_SPEC_FLUSH_L1D);
> +	return ret;
> +}

-- 
Kees Cook
