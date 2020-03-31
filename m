Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CACAC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 18:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23E2020784
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 18:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgCaSex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 14:34:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33565 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbgCaSew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 14:34:52 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jJLif-0007CD-Ed; Tue, 31 Mar 2020 20:34:37 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 9FB371040D2; Tue, 31 Mar 2020 20:34:36 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Balbir Singh <sblbir@amazon.com>, linux-kernel@vger.kernel.org
Cc:     tony.luck@intel.com, keescook@chromium.org, x86@kernel.org,
        benh@kernel.crashing.org, dave.hansen@intel.com,
        Balbir Singh <sblbir@amazon.com>
Subject: Re: [RFC PATCH v2 3/4] arch/x86: Optionally flush L1D on context switch
In-Reply-To: <20200325071101.29556-4-sblbir@amazon.com>
References: <20200325071101.29556-1-sblbir@amazon.com> <20200325071101.29556-4-sblbir@amazon.com>
Date:   Tue, 31 Mar 2020 20:34:36 +0200
Message-ID: <87r1x8v0eb.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh <sblbir@amazon.com> writes:

> This patch implements a mechanisn to selectively flush the L1D cache.

git grep 'This patch' Documentation/process/

> diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
> index 6f66d841262d..1d535059b358 100644
> --- a/arch/x86/include/asm/tlbflush.h
> +++ b/arch/x86/include/asm/tlbflush.h
> @@ -219,6 +219,12 @@ struct tlb_state {
>  	 */
>  	unsigned long cr4;
>  
> +	/*
> +	 * Flush the L1D cache on switch_mm_irqs_off() for a
> +	 * task getting off the CPU, if it opted in to do so
> +	 */
> +	bool last_user_mm_l1d_flush;

...

> +/*
> + * Flush the L1D cache for this CPU. We want to this at switch mm time,
> + * this is a pessimistic security measure and an opt-in for those tasks
> + * that host sensitive information and there are concerns about spills
> + * from fill buffers.

Color me confused, but how is L1D flush mitigating fill buffer spills
(MFBDS)? The MDS family is mitigated by MD_CLEAR, i.e VERW.

> + */
> +static void l1d_flush(struct mm_struct *next, struct task_struct *tsk)
> +{
> +	struct mm_struct *real_prev = this_cpu_read(cpu_tlbstate.loaded_mm);
> +
> +	/*
> +	 * If we are not really switching mm's, we can just return
> +	 */
> +	if (real_prev == next)
> +		return;

Instead of having the same check here, please stick the call into the
corresponding path in switch_mm_irqs_off(), i.e. where we already have
the cond_ibpb() invocation.

> +	/*
> +	 * Do we need flushing for by the previous task

  for by? Perhaps:

  Did the previous task request L1D flush when it scheduled in?

> +	 */
> +	if (this_cpu_read(cpu_tlbstate.last_user_mm_l1d_flush) != 0) {

This is a bool, so != 0 is pointless.

> +		if (!flush_l1d_cache_hw())
> +			flush_l1d_cache_sw(l1d_flush_pages);
> +		this_cpu_write(cpu_tlbstate.last_user_mm_l1d_flush, 0);

s/0/false/

> +		/* Make sure we clear the values before we set it again */
> +		barrier();
> +	}
> +
> +	if (tsk == NULL)
> +		return;
> +
> +	/* We don't need stringent checks as we opt-in/opt-out */
> +	if (test_ti_thread_flag(&tsk->thread_info, TIF_L1D_FLUSH))
> +		this_cpu_write(cpu_tlbstate.last_user_mm_l1d_flush, 1);

s/1/true/

That aside looking at the gazillion of conditionals here. That's 4 in
the worst case. So how about extending cond_ibpb() like the below?

Thanks,

        tglx

8<---------------------

--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -84,7 +84,7 @@ struct thread_info {
 #define TIF_SYSCALL_AUDIT	7	/* syscall auditing active */
 #define TIF_SECCOMP		8	/* secure computing */
 #define TIF_SPEC_IB		9	/* Indirect branch speculation mitigation */
-#define TIF_SPEC_FORCE_UPDATE	10	/* Force speculation MSR update in context switch */
+#define TIF_SPEC_FLUSH_L1D	10	/* L1D Flush in switch_mm() */
 #define TIF_USER_RETURN_NOTIFY	11	/* notify kernel of userspace return */
 #define TIF_UPROBE		12	/* breakpointed or singlestepping */
 #define TIF_PATCH_PENDING	13	/* pending live patching update */
@@ -96,6 +96,7 @@ struct thread_info {
 #define TIF_MEMDIE		20	/* is terminating due to OOM killer */
 #define TIF_POLLING_NRFLAG	21	/* idle is polling for TIF_NEED_RESCHED */
 #define TIF_IO_BITMAP		22	/* uses I/O bitmap */
+#define TIF_SPEC_FORCE_UPDATE	23	/* Force speculation MSR update in context switch */
 #define TIF_FORCED_TF		24	/* true if TF in eflags artificially */
 #define TIF_BLOCKSTEP		25	/* set when we want DEBUGCTLMSR_BTF */
 #define TIF_LAZY_MMU_UPDATES	27	/* task is updating the mmu lazily */
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -172,7 +172,7 @@ struct tlb_state {
 	/* Last user mm for optimizing IBPB */
 	union {
 		struct mm_struct	*last_user_mm;
-		unsigned long		last_user_mm_ibpb;
+		unsigned long		last_user_mm_spec;
 	};
 
 	u16 loaded_mm_asid;
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -33,10 +33,13 @@
  */
 
 /*
- * Use bit 0 to mangle the TIF_SPEC_IB state into the mm pointer which is
- * stored in cpu_tlb_state.last_user_mm_ibpb.
+ * Bits mangle the TIF_SPEC_* state into the mm pointer which is
+ * stored in cpu_tlb_state.last_user_mm_spec.
  */
 #define LAST_USER_MM_IBPB	0x1UL
+#define LAST_USER_MM_FLUSH_L1D	0x2UL
+
+#define LAST_USER_MM_SPEC_MASK	(LAST_USER_MM_IBPB | LAST_USER_MM_FLUSH_L1D)
 
 /*
  * We get here when we do something requiring a TLB invalidation
@@ -189,18 +192,22 @@ static void sync_current_stack_to_mm(str
 	}
 }
 
-static inline unsigned long mm_mangle_tif_spec_ib(struct task_struct *next)
+static inline unsigned long mm_mangle_tif_spec(struct task_struct *next)
 {
 	unsigned long next_tif = task_thread_info(next)->flags;
-	unsigned long ibpb = (next_tif >> TIF_SPEC_IB) & LAST_USER_MM_IBPB;
+	unsigned long bits = (next_tif >> TIF_SPEC_IB) & LAST_USER_MM_SPEC_MASK;
+
+	BUILD_BUG_ON(TIF_SPEC_FLUSH_L1D != TIF_SPEC_IB + 1);
 
-	return (unsigned long)next->mm | ibpb;
+	return (unsigned long)next->mm | bits;
 }
 
-static void cond_ibpb(struct task_struct *next)
+static void cond_mitigations(struct task_struct *next)
 {
-	if (!next || !next->mm)
-		return;
+	unsigned long prev_mm, next_mm;
+
+	prev_mm = this_cpu_read(cpu_tlbstate.last_user_mm_spec);
+	next_mm = mm_mangle_tif_spec(next);
 
 	/*
 	 * Both, the conditional and the always IBPB mode use the mm
@@ -212,8 +219,6 @@ static void cond_ibpb(struct task_struct
 	 * exposed data is not really interesting.
 	 */
 	if (static_branch_likely(&switch_mm_cond_ibpb)) {
-		unsigned long prev_mm, next_mm;
-
 		/*
 		 * This is a bit more complex than the always mode because
 		 * it has to handle two cases:
@@ -243,20 +248,14 @@ static void cond_ibpb(struct task_struct
 		 * Optimize this with reasonably small overhead for the
 		 * above cases. Mangle the TIF_SPEC_IB bit into the mm
 		 * pointer of the incoming task which is stored in
-		 * cpu_tlbstate.last_user_mm_ibpb for comparison.
-		 */
-		next_mm = mm_mangle_tif_spec_ib(next);
-		prev_mm = this_cpu_read(cpu_tlbstate.last_user_mm_ibpb);
-
-		/*
+		 * cpu_tlbstate.last_user_mm_spec for comparison.
+		 *
 		 * Issue IBPB only if the mm's are different and one or
 		 * both have the IBPB bit set.
 		 */
 		if (next_mm != prev_mm &&
 		    (next_mm | prev_mm) & LAST_USER_MM_IBPB)
 			indirect_branch_prediction_barrier();
-
-		this_cpu_write(cpu_tlbstate.last_user_mm_ibpb, next_mm);
 	}
 
 	if (static_branch_unlikely(&switch_mm_always_ibpb)) {
@@ -265,11 +264,15 @@ static void cond_ibpb(struct task_struct
 		 * different context than the user space task which ran
 		 * last on this CPU.
 		 */
-		if (this_cpu_read(cpu_tlbstate.last_user_mm) != next->mm) {
+		if ((prev_mm & ~LAST_USER_MM_SPEC_MASK) !=
+		    (unsigned long)next->mm)
 			indirect_branch_prediction_barrier();
-			this_cpu_write(cpu_tlbstate.last_user_mm, next->mm);
-		}
 	}
+
+	if (prev_mm & LAST_USER_MM_FLUSH_L1D)
+		flush_l1d();
+
+	this_cpu_write(cpu_tlbstate.last_user_mm_spec, next_mm);
 }
 
 void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
@@ -371,11 +374,10 @@ void switch_mm_irqs_off(struct mm_struct
 		need_flush = true;
 	} else {
 		/*
-		 * Avoid user/user BTB poisoning by flushing the branch
-		 * predictor when switching between processes. This stops
-		 * one process from doing Spectre-v2 attacks on another.
+		 * Speculation vulnerability mitigations when switching
+		 * to a different user space process.
 		 */
-		cond_ibpb(tsk);
+		cond_mitigations(tsk);
 
 		if (IS_ENABLED(CONFIG_VMAP_STACK)) {
 			/*
@@ -501,7 +503,7 @@ void initialize_tlbstate_and_flush(void)
 	write_cr3(build_cr3(mm->pgd, 0));
 
 	/* Reinitialize tlbstate. */
-	this_cpu_write(cpu_tlbstate.last_user_mm_ibpb, LAST_USER_MM_IBPB);
+	this_cpu_write(cpu_tlbstate.last_user_mm_spec, LAST_USER_MM_SPEC_MASK);
 	this_cpu_write(cpu_tlbstate.loaded_mm_asid, 0);
 	this_cpu_write(cpu_tlbstate.next_asid, 1);
 	this_cpu_write(cpu_tlbstate.ctxs[0].ctx_id, mm->context.ctx_id);
