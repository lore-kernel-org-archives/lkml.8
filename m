Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FAEAC54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 19:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 034162075A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 19:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cBxzoZPa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbgDWTTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 15:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbgDWTTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 15:19:52 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A6BC09B042
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 12:19:52 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d184so3460920pfd.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 12:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MN/PVJrF+f7yjrExIzo0JqWz7rF2lNQe+cbBsQkY73M=;
        b=cBxzoZPaGgmragWm3x/8f9CfLl0k/XfGiDr6IptktH8HXeVQUhS6Bh2yvFzEHxScMD
         vxQhA+VSnKcsc9Lx6yT6e7Mdq3kh08U8EkWMOtaKEUbL5ipJ6S4vJysXK/2ouMPce6Ce
         ZoiZldA11u5S5p25RLRA9Y2T1d51/RsKwE80o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MN/PVJrF+f7yjrExIzo0JqWz7rF2lNQe+cbBsQkY73M=;
        b=nrXLJ1noKVNA/ok53xEQqs1s1YyrO9C+OvVJfjQ19a8SLleFOppD7fT6BuSytrArdJ
         2TpSc5e1ohYVc2OwrWxPQrA6nUp2M7drmq4hhvir9zZY4zaHIKv/sfl6T1LG45o4ZoRU
         AeYY0Xcm5jMxUf0clwBnKMElp/nhMAJP2LHHO67k+Cl68eSEM0IUYZPBlolQVyGwUIg4
         ksmQZ1U6oI/5HbvnKAFG3WYbNxMOrhNbqjRMdDre3uM/r1SmEdr4CFRyEwmA+BCM8ltF
         sKDjGQwIiNMtOXHNHIAPidUxNBgboQvpU7CD/03+1FAxxSUdmeLUwl9H4Z36j029ieQx
         z8dA==
X-Gm-Message-State: AGi0PuYCJdtdc5p45aKrzG49oixGwG2ZM9UaJ/P4Fa41h9g6e8t+Qhbd
        B9r06IwasrnPWPi7fJgD6aozcg==
X-Google-Smtp-Source: APiQypJ7yElN8rUZrEF3HZr91nOyHNG81OsNKQotj3X76rsbOEgXOj26nedzcfHVMBdDDSZ9WKQEjg==
X-Received: by 2002:a63:4866:: with SMTP id x38mr5488115pgk.280.1587669592116;
        Thu, 23 Apr 2020 12:19:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w9sm3464782pff.101.2020.04.23.12.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 12:19:51 -0700 (PDT)
Date:   Thu, 23 Apr 2020 12:19:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Balbir Singh <sblbir@amazon.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        jpoimboe@redhat.com, tony.luck@intel.com, benh@kernel.crashing.org,
        x86@kernel.org, dave.hansen@intel.com
Subject: Re: [PATCH v4 5/6] Optionally flush L1D on context switch
Message-ID: <202004231219.9D614F5@keescook>
References: <20200423140125.7332-1-sblbir@amazon.com>
 <20200423140125.7332-6-sblbir@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423140125.7332-6-sblbir@amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 12:01:24AM +1000, Balbir Singh wrote:
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

I'm not a huge fan of __weak (I like CONFIGs better), but that's no
enough to NAK this. ;) Thanks for the prctl() change!

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

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
> index da5c94286c7d..7778560760e6 100644
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
> @@ -33,11 +34,12 @@
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
>   * We get here when we do something requiring a TLB invalidation
> @@ -152,6 +154,35 @@ void leave_mm(int cpu)
>  }
>  EXPORT_SYMBOL_GPL(leave_mm);
>  
> +static int enable_l1d_flush_for_task(struct task_struct *tsk)
> +{
> +	int ret = l1d_flush_init_once();
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	set_ti_thread_flag(&tsk->thread_info, TIF_SPEC_FLUSH_L1D);
> +	return ret;
> +}
> +
> +static int disable_l1d_flush_for_task(struct task_struct *tsk)
> +{
> +	clear_ti_thread_flag(&tsk->thread_info, TIF_SPEC_FLUSH_L1D);
> +	return 0;
> +}
> +
> +int arch_prctl_l1d_flush_get(struct task_struct *tsk)
> +{
> +	return test_ti_thread_flag(&tsk->thread_info, TIF_SPEC_FLUSH_L1D);
> +}
> +
> +int arch_prctl_l1d_flush_set(struct task_struct *tsk, unsigned long enable)
> +{
> +	if (enable)
> +		return enable_l1d_flush_for_task(tsk);
> +	return disable_l1d_flush_for_task(tsk);
> +}
> +
>  void switch_mm(struct mm_struct *prev, struct mm_struct *next,
>  	       struct task_struct *tsk)
>  {
> @@ -268,6 +299,9 @@ static void cond_mitigation(struct task_struct *next)
>  			indirect_branch_prediction_barrier();
>  	}
>  
> +	if (prev_mm & LAST_USER_MM_L1D_FLUSH)
> +		arch_l1d_flush(0); /* Just flush, don't populate the TLB */
> +
>  	this_cpu_write(cpu_tlbstate.last_user_mm_spec, next_mm);
>  }
>  
> @@ -502,6 +536,12 @@ void initialize_tlbstate_and_flush(void)
>  	write_cr3(build_cr3(mm->pgd, 0));
>  
>  	/* Reinitialize tlbstate. */
> +
> +	/*
> +	 * Leave last_user_mm_spec at LAST_USER_MM_IBPB, we don't
> +	 * want to set LAST_USER_MM_L1D_FLUSH and force a flush before
> +	 * we've allocated the flush pages.
> +	 */
>  	this_cpu_write(cpu_tlbstate.last_user_mm_spec, LAST_USER_MM_IBPB);
>  	this_cpu_write(cpu_tlbstate.loaded_mm_asid, 0);
>  	this_cpu_write(cpu_tlbstate.next_asid, 1);
> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> index 07b4f8131e36..42cb3038c81a 100644
> --- a/include/uapi/linux/prctl.h
> +++ b/include/uapi/linux/prctl.h
> @@ -238,4 +238,8 @@ struct prctl_mm_map {
>  #define PR_SET_IO_FLUSHER		57
>  #define PR_GET_IO_FLUSHER		58
>  
> +/* Flush L1D on context switch (mm) */
> +#define PR_SET_L1D_FLUSH		59
> +#define PR_GET_L1D_FLUSH		60
> +
>  #endif /* _LINUX_PRCTL_H */
> diff --git a/kernel/sys.c b/kernel/sys.c
> index d325f3ab624a..578aa8b6d87e 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2262,6 +2262,16 @@ int __weak arch_prctl_spec_ctrl_set(struct task_struct *t, unsigned long which,
>  	return -EINVAL;
>  }
>  
> +int __weak arch_prctl_l1d_flush_set(struct task_struct *tsk, unsigned long enable)
> +{
> +	return -EINVAL;
> +}
> +
> +int __weak arch_prctl_l1d_flush_get(struct task_struct *t)
> +{
> +	return -EINVAL;
> +}
> +
>  #define PR_IO_FLUSHER (PF_MEMALLOC_NOIO | PF_LESS_THROTTLE)
>  
>  SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
> @@ -2514,6 +2524,16 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>  
>  		error = (current->flags & PR_IO_FLUSHER) == PR_IO_FLUSHER;
>  		break;
> +	case PR_SET_L1D_FLUSH:
> +		if (arg3 || arg4 || arg5)
> +			return -EINVAL;
> +		error = arch_prctl_l1d_flush_set(me, arg2);
> +		break;
> +	case PR_GET_L1D_FLUSH:
> +		if (arg2 || arg3 || arg4 || arg5)
> +			return -EINVAL;
> +		error = arch_prctl_l1d_flush_get(me);
> +		break;
>  	default:
>  		error = -EINVAL;
>  		break;
> -- 
> 2.17.1
> 

-- 
Kees Cook
