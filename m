Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9E8C2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 18:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81B7C2063A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 18:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KK0PCNsz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgDGS0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 14:26:10 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36839 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbgDGS0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 14:26:09 -0400
Received: by mail-pl1-f195.google.com with SMTP id g2so1556672plo.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 11:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9BFJKwIvnbFLCnynBhvEwstaoKJTrUkAwJ/w89yCvj8=;
        b=KK0PCNsz4wUac6mZDEeC7/7ntMm4B+edFgWKlZgOwv8bqe2rlO7Hv9DgA5a68xx/oA
         AAw4Eb0BoFWqaurobmElvnzy2t60lxAl4MewZ/LqGvuLbvsuMRzMrL+GtqKGcnAJtamq
         uVIAvAoUgPiiGUNTXAg4plvaRKtz0SN75NgGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9BFJKwIvnbFLCnynBhvEwstaoKJTrUkAwJ/w89yCvj8=;
        b=VJ1zLKHAXyXP4UrKxZwb2r1AxXHtZY6nQf5+bASyMz/t3sBDXeXLQHaNFBtjSHjJdh
         2JDOYg86cKglVH2Y4KT56yDffjL+NC420Of7zBj9puupAhehmFTRoKmNUYN2ZOd2g0f/
         DydeKOFh3o5id8gTEQBytZCer8ni18FKN2BtmJ7D+GnGsQrdMax4VdiG8YLcg43QpWpO
         F2mm0HfjZJ9JemiaFaKh+6713s4SYxB9hM7gqxROFgIE6tuPtILRGIOdy2nuL7Mjk9pP
         tlApCMrpfeZeGr6b4GDuwE+oWoqoTBzJG7W8V3GDBe8iyL+alfVi+x/mLhfYvcF5uAEQ
         9gAQ==
X-Gm-Message-State: AGi0PuZO2hysF09E4zshgACyXuunY+1SMnit4Fr7nZfcUbkFiIUY84qg
        KfT+H6EAU/OAt2btTR5FDg/LzlL5vqE=
X-Google-Smtp-Source: APiQypL5+ZPEMSFkEX0VN9M0mH8cJLGGJnppkVGBLIzg0pm0bktdJcUTn5rPSbwxIiFVNQxj2T2F8w==
X-Received: by 2002:a17:90b:4c8f:: with SMTP id my15mr670422pjb.63.1586283968200;
        Tue, 07 Apr 2020 11:26:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a18sm2238797pjh.25.2020.04.07.11.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 11:26:07 -0700 (PDT)
Date:   Tue, 7 Apr 2020 11:26:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Balbir Singh <sblbir@amazon.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        jpoimboe@redhat.com, tony.luck@intel.com, benh@kernel.crashing.org,
        x86@kernel.org, dave.hansen@intel.com
Subject: Re: [PATCH v2 3/4] arch/x86: Optionally flush L1D on context switch
Message-ID: <202004071125.605F665@keescook>
References: <20200406031946.11815-1-sblbir@amazon.com>
 <20200406031946.11815-4-sblbir@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406031946.11815-4-sblbir@amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 01:19:45PM +1000, Balbir Singh wrote:
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
> Add arch specific prctl()'s to opt-in to the L1D cache on context switch
> out, the existing mechanisms of tracking prev_mm via cpu_tlbstate is
> reused. cond_ibpb() is refactored and renamed into cond_mitigation().

I still think this should be a generic prctl(). If there is a strong
reason not to do this, can it be described in the commit log here?

-Kees

> 
> A new thread_info flag TIF_SPEC_FLUSH_L1D is added to track tasks which
> opt-into L1D flushing. cpu_tlbstate.last_user_mm_ibpb is renamed to
> cpu_tlbstate.last_user_mm_spec, this is used to convert the TIF flags
> into mm state (per cpu via last_user_mm_spec) in cond_mitigation(),
> which then used to do decide when to call flush_l1d().
> 
> The current version benefited from discussions with Kees and Thomas.
> Thomas suggested and provided the code snippet for refactoring the
> existing cond_ibpb() code.
> 
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Balbir Singh <sblbir@amazon.com>
> ---
>  arch/x86/include/asm/thread_info.h |  6 +-
>  arch/x86/include/asm/tlbflush.h    |  2 +-
>  arch/x86/include/uapi/asm/prctl.h  |  3 +
>  arch/x86/kernel/process_64.c       | 10 +++-
>  arch/x86/mm/tlb.c                  | 94 +++++++++++++++++++++++-------
>  5 files changed, 91 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
> index 8de8ceccb8bc..5cb250872643 100644
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
> @@ -239,6 +241,8 @@ extern void arch_task_cache_init(void);
>  extern int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
>  extern void arch_release_task_struct(struct task_struct *tsk);
>  extern void arch_setup_new_exec(void);
> +extern int enable_l1d_flush_for_task(struct task_struct *tsk);
> +extern int disable_l1d_flush_for_task(struct task_struct *tsk);
>  #define arch_setup_new_exec arch_setup_new_exec
>  #endif	/* !__ASSEMBLY__ */
>  
> diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
> index 6f66d841262d..69e6ea20679c 100644
> --- a/arch/x86/include/asm/tlbflush.h
> +++ b/arch/x86/include/asm/tlbflush.h
> @@ -172,7 +172,7 @@ struct tlb_state {
>  	/* Last user mm for optimizing IBPB */
>  	union {
>  		struct mm_struct	*last_user_mm;
> -		unsigned long		last_user_mm_ibpb;
> +		unsigned long		last_user_mm_spec;
>  	};
>  
>  	u16 loaded_mm_asid;
> diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
> index 5a6aac9fa41f..1361e5e25791 100644
> --- a/arch/x86/include/uapi/asm/prctl.h
> +++ b/arch/x86/include/uapi/asm/prctl.h
> @@ -14,4 +14,7 @@
>  #define ARCH_MAP_VDSO_32	0x2002
>  #define ARCH_MAP_VDSO_64	0x2003
>  
> +#define ARCH_SET_L1D_FLUSH	0x3001
> +#define ARCH_GET_L1D_FLUSH	0x3002
> +
>  #endif /* _ASM_X86_PRCTL_H */
> diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
> index 5ef9d8f25b0e..ecf542f13572 100644
> --- a/arch/x86/kernel/process_64.c
> +++ b/arch/x86/kernel/process_64.c
> @@ -699,7 +699,15 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
>  	case ARCH_MAP_VDSO_64:
>  		return prctl_map_vdso(&vdso_image_64, arg2);
>  #endif
> -
> +	case ARCH_GET_L1D_FLUSH:
> +		return test_ti_thread_flag(&task->thread_info, TIF_SPEC_FLUSH_L1D);
> +	case ARCH_SET_L1D_FLUSH: {
> +		if (arg2 >= 1)
> +			return enable_l1d_flush_for_task(task);
> +		else
> +			return disable_l1d_flush_for_task(task);
> +		break;
> +	}
>  	default:
>  		ret = -EINVAL;
>  		break;
> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index 66f96f21a7b6..71ef9fb941b8 100644
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
> @@ -33,10 +34,12 @@
>   */
>  
>  /*
> - * Use bit 0 to mangle the TIF_SPEC_IB state into the mm pointer which is
> - * stored in cpu_tlb_state.last_user_mm_ibpb.
> + * Bits to mangle the TIF_SPEC_* state into the mm pointer which is
> + * stored in cpu_tlb_state.last_user_mm_spec.
>   */
>  #define LAST_USER_MM_IBPB	0x1UL
> +#define LAST_USER_MM_FLUSH_L1D	0x2UL
> +#define LAST_USER_MM_SPEC_MASK	(LAST_USER_MM_IBPB | LAST_USER_MM_FLUSH_L1D)
>  
>  /*
>   * We get here when we do something requiring a TLB invalidation
> @@ -151,6 +154,52 @@ void leave_mm(int cpu)
>  }
>  EXPORT_SYMBOL_GPL(leave_mm);
>  
> +static void *l1d_flush_pages;
> +static DEFINE_MUTEX(l1d_flush_mutex);
> +
> +int enable_l1d_flush_for_task(struct task_struct *tsk)
> +{
> +	struct page *page;
> +	int ret = 0;
> +
> +	if (static_cpu_has(X86_FEATURE_FLUSH_L1D))
> +		goto done;
> +
> +	page = READ_ONCE(l1d_flush_pages);
> +	if (unlikely(!page)) {
> +		mutex_lock(&l1d_flush_mutex);
> +		if (!l1d_flush_pages) {
> +			l1d_flush_pages = alloc_l1d_flush_pages();
> +			if (!l1d_flush_pages) {
> +				mutex_unlock(&l1d_flush_mutex);
> +				return -ENOMEM;
> +			}
> +		}
> +		mutex_unlock(&l1d_flush_mutex);
> +	}
> +	/* I don't think we need to worry about KSM */
> +done:
> +	set_ti_thread_flag(&tsk->thread_info, TIF_SPEC_FLUSH_L1D);
> +	return ret;
> +}
> +
> +int disable_l1d_flush_for_task(struct task_struct *tsk)
> +{
> +	clear_ti_thread_flag(&tsk->thread_info, TIF_SPEC_FLUSH_L1D);
> +	return 0;
> +}
> +
> +/*
> + * Flush the L1D cache for this CPU. We want to this at switch mm time,
> + * this is a pessimistic security measure and an opt-in for those tasks
> + * that host sensitive information.
> + */
> +static void flush_l1d(void)
> +{
> +	if (!flush_l1d_cache_hw())
> +		flush_l1d_cache_sw(l1d_flush_pages);
> +}
> +
>  void switch_mm(struct mm_struct *prev, struct mm_struct *next,
>  	       struct task_struct *tsk)
>  {
> @@ -189,19 +238,26 @@ static void sync_current_stack_to_mm(struct mm_struct *mm)
>  	}
>  }
>  
> -static inline unsigned long mm_mangle_tif_spec_ib(struct task_struct *next)
> +static inline unsigned long mm_mangle_tif_spec_bits(struct task_struct *next)
>  {
>  	unsigned long next_tif = task_thread_info(next)->flags;
> -	unsigned long ibpb = (next_tif >> TIF_SPEC_IB) & LAST_USER_MM_IBPB;
> +	unsigned long spec_bits = (next_tif >> TIF_SPEC_IB) & LAST_USER_MM_SPEC_MASK;
> +
> +	BUILD_BUG_ON(TIF_SPEC_FLUSH_L1D != TIF_SPEC_IB + 1);
>  
> -	return (unsigned long)next->mm | ibpb;
> +	return (unsigned long)next->mm | spec_bits;
>  }
>  
> -static void cond_ibpb(struct task_struct *next)
> +static void cond_mitigation(struct task_struct *next)
>  {
> +	unsigned long prev_mm, next_mm;
> +
>  	if (!next || !next->mm)
>  		return;
>  
> +	next_mm = mm_mangle_tif_spec_bits(next);
> +	prev_mm = this_cpu_read(cpu_tlbstate.last_user_mm_spec);
> +
>  	/*
>  	 * Both, the conditional and the always IBPB mode use the mm
>  	 * pointer to avoid the IBPB when switching between tasks of the
> @@ -212,8 +268,6 @@ static void cond_ibpb(struct task_struct *next)
>  	 * exposed data is not really interesting.
>  	 */
>  	if (static_branch_likely(&switch_mm_cond_ibpb)) {
> -		unsigned long prev_mm, next_mm;
> -
>  		/*
>  		 * This is a bit more complex than the always mode because
>  		 * it has to handle two cases:
> @@ -243,20 +297,14 @@ static void cond_ibpb(struct task_struct *next)
>  		 * Optimize this with reasonably small overhead for the
>  		 * above cases. Mangle the TIF_SPEC_IB bit into the mm
>  		 * pointer of the incoming task which is stored in
> -		 * cpu_tlbstate.last_user_mm_ibpb for comparison.
> -		 */
> -		next_mm = mm_mangle_tif_spec_ib(next);
> -		prev_mm = this_cpu_read(cpu_tlbstate.last_user_mm_ibpb);
> -
> -		/*
> +		 * cpu_tlbstate.last_user_mm_spec for comparison.
> +		 *
>  		 * Issue IBPB only if the mm's are different and one or
>  		 * both have the IBPB bit set.
>  		 */
>  		if (next_mm != prev_mm &&
>  		    (next_mm | prev_mm) & LAST_USER_MM_IBPB)
>  			indirect_branch_prediction_barrier();
> -
> -		this_cpu_write(cpu_tlbstate.last_user_mm_ibpb, next_mm);
>  	}
>  
>  	if (static_branch_unlikely(&switch_mm_always_ibpb)) {
> @@ -265,11 +313,15 @@ static void cond_ibpb(struct task_struct *next)
>  		 * different context than the user space task which ran
>  		 * last on this CPU.
>  		 */
> -		if (this_cpu_read(cpu_tlbstate.last_user_mm) != next->mm) {
> +		if ((prev_mm & ~LAST_USER_MM_SPEC_MASK) !=
> +					(unsigned long)next->mm)
>  			indirect_branch_prediction_barrier();
> -			this_cpu_write(cpu_tlbstate.last_user_mm, next->mm);
> -		}
>  	}
> +
> +	if (prev_mm & LAST_USER_MM_FLUSH_L1D)
> +		flush_l1d();
> +
> +	this_cpu_write(cpu_tlbstate.last_user_mm_spec, next_mm);
>  }
>  
>  void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
> @@ -375,7 +427,7 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
>  		 * predictor when switching between processes. This stops
>  		 * one process from doing Spectre-v2 attacks on another.
>  		 */
> -		cond_ibpb(tsk);
> +		cond_mitigation(tsk);
>  
>  		if (IS_ENABLED(CONFIG_VMAP_STACK)) {
>  			/*
> @@ -501,7 +553,7 @@ void initialize_tlbstate_and_flush(void)
>  	write_cr3(build_cr3(mm->pgd, 0));
>  
>  	/* Reinitialize tlbstate. */
> -	this_cpu_write(cpu_tlbstate.last_user_mm_ibpb, LAST_USER_MM_IBPB);
> +	this_cpu_write(cpu_tlbstate.last_user_mm_spec, LAST_USER_MM_IBPB);
>  	this_cpu_write(cpu_tlbstate.loaded_mm_asid, 0);
>  	this_cpu_write(cpu_tlbstate.next_asid, 1);
>  	this_cpu_write(cpu_tlbstate.ctxs[0].ctx_id, mm->context.ctx_id);
> -- 
> 2.17.1
> 

-- 
Kees Cook
