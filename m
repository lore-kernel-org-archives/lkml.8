Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C479C33CA9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 05:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C36FE2072B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 05:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbgANFzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 00:55:23 -0500
Received: from mga17.intel.com ([192.55.52.151]:2571 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbgANFzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 00:55:23 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jan 2020 21:55:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,431,1571727600"; 
   d="scan'208";a="217634641"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by orsmga008.jf.intel.com with ESMTP; 13 Jan 2020 21:55:21 -0800
Date:   Mon, 13 Jan 2020 21:55:21 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v11] x86/split_lock: Enable split lock detection by kernel
Message-ID: <20200114055521.GI14928@linux.intel.com>
References: <20191121060444.GA55272@gmail.com>
 <20191121130153.GS4097@hirez.programming.kicks-ass.net>
 <20191121171214.GD12042@gmail.com>
 <20191121173444.GA5581@agluck-desk2.amr.corp.intel.com>
 <20191122105141.GY4114@hirez.programming.kicks-ass.net>
 <20191122152715.GA1909@hirez.programming.kicks-ass.net>
 <20191123003056.GA28761@agluck-desk2.amr.corp.intel.com>
 <20191125161348.GA12178@linux.intel.com>
 <20191212085948.GS2827@hirez.programming.kicks-ass.net>
 <20200110192409.GA23315@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110192409.GA23315@agluck-desk2.amr.corp.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 11:24:09AM -0800, Luck, Tony wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> A split-lock occurs when an atomic instruction operates on data
> that spans two cache lines. In order to maintain atomicity the
> core takes a global bus lock.
> 
> This is typically >1000 cycles slower than an atomic operation
> within a cache line. It also disrupts performance on other cores
> (which must wait for the bus lock to be released before their
> memory operations can complete. For real-time systems this may
> mean missing deadlines. For other systems it may just be very
> annoying.
> 
> Some CPUs have the capability to raise an #AC trap when a
> split lock is attempted.
> 
> Provide a command line option to give the user choices on how
> to handle this. split_lock_detect=
> 	off	- not enabled (no traps for split locks)
> 	warn	- warn once when an application does a
> 		  split lock, bust allow it to continue
> 		  running.
> 	fatal	- Send SIGBUS to applications that cause split lock
> 
> Default is "warn". Note that if the kernel hits a split lock
> in any mode other than "off" it will OOPs.
> 
> One implementation wrinkle is that the MSR to control the
> split lock detection is per-core, not per thread. This might
> result in some short lived races on HT systems in "warn" mode
> if Linux tries to enable on one thread while disabling on
> the other. Race analysis by Sean Christopherson:
> 
>   - Toggling of split-lock is only done in "warn" mode.  Worst case
>     scenario of a race is that a misbehaving task will generate multiple
>     #AC exceptions on the same instruction.  And this race will only occur
>     if both siblings are running tasks that generate split-lock #ACs, e.g.
>     a race where sibling threads are writing different values will only
>     occur if CPUx is disabling split-lock after an #AC and CPUy is
>     re-enabling split-lock after *its* previous task generated an #AC.
>   - Transitioning between modes at runtime isn't supported and disabling
>     is tracked per task, so hardware will always reach a steady state that
>     matches the configured mode.  I.e. split-lock is guaranteed to be
>     enabled in hardware once all _TIF_SLD threads have been scheduled out.
> 
> Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>

Need Fenghua's SoB.

> Co-developed-by: Peter Zijlstra <peterz@infradead.org>

Co-developed-by for Peter not needed since he's the author (attributed
via From).

> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
> 
> I think all the known places where split locks occur in the kernel
> have already been patched, or the patches are queued for the upcoming
> merge window.  If we missed some, well this patch will help find them
> (for people with Icelake or Icelake Xeon systems). PeterZ didn't see
> any application level use of split locks in a few hours of runtime
> on his desktop. So likely little fallout there (default is just to
> warn for applications, so just console noise rather than failure).
> 
>  .../admin-guide/kernel-parameters.txt         |  18 ++
>  arch/x86/include/asm/cpu.h                    |  17 ++
>  arch/x86/include/asm/cpufeatures.h            |   2 +
>  arch/x86/include/asm/msr-index.h              |   8 +
>  arch/x86/include/asm/thread_info.h            |   6 +-
>  arch/x86/include/asm/traps.h                  |   1 +
>  arch/x86/kernel/cpu/common.c                  |   2 +
>  arch/x86/kernel/cpu/intel.c                   | 170 ++++++++++++++++++
>  arch/x86/kernel/process.c                     |   3 +
>  arch/x86/kernel/traps.c                       |  29 ++-
>  10 files changed, 252 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index ade4e6ec23e0..173c1acff5f0 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3181,6 +3181,24 @@
>  
>  	nosoftlockup	[KNL] Disable the soft-lockup detector.
>  
> +	split_lock_detect=

Would it make sense to name this split_lock_ac?  To help clarify what the
param does and to future proof a bit in the event split lock detection is
able to signal some other form of fault/trap.

> +			[X86] Enable split lock detection
> +
> +			When enabled (and if hardware support is present), atomic
> +			instructions that access data across cache line
> +			boundaries will result in an alignment check exception.
> +
> +			off	- not enabled
> +
> +			warn	- the kernel will pr_alert about applications
> +				  triggering the #AC exception
> +
> +			fatal	- the kernel will SIGBUS applications that
> +				  trigger the #AC exception.
> +
> +			For any more other than 'off' the kernel will die if
> +			it (or firmware) will trigger #AC.
> +
>  	nosync		[HW,M68K] Disables sync negotiation for all devices.
>  
>  	nowatchdog	[KNL] Disable both lockup detectors, i.e.

...

> diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
> index d779366ce3f8..d23638a0525e 100644
> --- a/arch/x86/include/asm/thread_info.h
> +++ b/arch/x86/include/asm/thread_info.h
> @@ -92,6 +92,7 @@ struct thread_info {
>  #define TIF_NOCPUID		15	/* CPUID is not accessible in userland */
>  #define TIF_NOTSC		16	/* TSC is not accessible in userland */
>  #define TIF_IA32		17	/* IA32 compatibility process */
> +#define TIF_SLD			18	/* split_lock_detect */

A more informative name comment would be helpful since the flag is set when
SLD is disabled by the previous task.  Something like? 

#define TIF_NEED_SLD_RESTORE	18	/* Restore split lock detection on context switch */

>  #define TIF_NOHZ		19	/* in adaptive nohz mode */
>  #define TIF_MEMDIE		20	/* is terminating due to OOM killer */
>  #define TIF_POLLING_NRFLAG	21	/* idle is polling for TIF_NEED_RESCHED */
> @@ -122,6 +123,7 @@ struct thread_info {
>  #define _TIF_NOCPUID		(1 << TIF_NOCPUID)
>  #define _TIF_NOTSC		(1 << TIF_NOTSC)
>  #define _TIF_IA32		(1 << TIF_IA32)
> +#define _TIF_SLD		(1 << TIF_SLD)
>  #define _TIF_NOHZ		(1 << TIF_NOHZ)
>  #define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
>  #define _TIF_IO_BITMAP		(1 << TIF_IO_BITMAP)
> @@ -158,9 +160,9 @@ struct thread_info {
>  
>  #ifdef CONFIG_X86_IOPL_IOPERM
>  # define _TIF_WORK_CTXSW_PREV	(_TIF_WORK_CTXSW| _TIF_USER_RETURN_NOTIFY | \
> -				 _TIF_IO_BITMAP)
> +				 _TIF_IO_BITMAP | _TIF_SLD)
>  #else
> -# define _TIF_WORK_CTXSW_PREV	(_TIF_WORK_CTXSW| _TIF_USER_RETURN_NOTIFY)
> +# define _TIF_WORK_CTXSW_PREV	(_TIF_WORK_CTXSW| _TIF_USER_RETURN_NOTIFY | _TIF_SLD)
>  #endif
>  
>  #define _TIF_WORK_CTXSW_NEXT	(_TIF_WORK_CTXSW)
> diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
> index ffa0dc8a535e..6ceab60370f0 100644
> --- a/arch/x86/include/asm/traps.h
> +++ b/arch/x86/include/asm/traps.h
> @@ -175,4 +175,5 @@ enum x86_pf_error_code {
>  	X86_PF_INSTR	=		1 << 4,
>  	X86_PF_PK	=		1 << 5,
>  };
> +

Spurious whitespace.

>  #endif /* _ASM_X86_TRAPS_H */
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 2e4d90294fe6..39245f61fad0 100644

...

> +bool handle_split_lock(void)

This is a confusing name IMO, e.g. split_lock_detect_enabled() or similar
would be more intuitive.  It'd also avoid the weirdness of having different
semantics for the returns values of handle_split_lock() and
handle_user_split_lock().

> +{
> +	return sld_state != sld_off;
> +}
> +
> +bool handle_user_split_lock(struct pt_regs *regs, long error_code)
> +{
> +	if ((regs->flags & X86_EFLAGS_AC) || sld_state == sld_fatal)
> +		return false;

Maybe add "|| WARN_ON_ONCE(sld_state != sld_off)" to try to prevent the
kernel from going fully into the weeds if a spurious #AC occurs.

> +
> +	pr_alert("#AC: %s/%d took a split_lock trap at address: 0x%lx\n",

pr_warn_ratelimited since it's user controlled?

> +		 current->comm, current->pid, regs->ip);
> +
> +	__sld_msr_set(false);
> +	set_tsk_thread_flag(current, TIF_SLD);
> +	return true;
> +}
> +
> +void switch_sld(struct task_struct *prev)
> +{
> +	__sld_msr_set(true);
> +	clear_tsk_thread_flag(prev, TIF_SLD);
> +}
> +
> +#define SPLIT_LOCK_CPU(model) {X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY}
> +
> +/*
> + * The following processors have split lock detection feature. But since they
> + * don't have MSR IA32_CORE_CAPABILITIES, the feature cannot be enumerated by
> + * the MSR. So enumerate the feature by family and model on these processors.
> + */
> +static const struct x86_cpu_id split_lock_cpu_ids[] __initconst = {
> +	SPLIT_LOCK_CPU(INTEL_FAM6_ICELAKE_X),
> +	SPLIT_LOCK_CPU(INTEL_FAM6_ICELAKE_L),
> +	{}
> +};
> +
> +void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c)
> +{
> +	u64 ia32_core_caps = 0;
> +
> +	if (cpu_has(c, X86_FEATURE_CORE_CAPABILITIES)) {
> +		/* Enumerate features reported in IA32_CORE_CAPABILITIES MSR. */
> +		rdmsrl(MSR_IA32_CORE_CAPABILITIES, ia32_core_caps);
> +	} else if (!boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
> +		/* Enumerate split lock detection by family and model. */
> +		if (x86_match_cpu(split_lock_cpu_ids))
> +			ia32_core_caps |= MSR_IA32_CORE_CAPABILITIES_SPLIT_LOCK_DETECT;
> +	}
> +
> +	if (ia32_core_caps & MSR_IA32_CORE_CAPABILITIES_SPLIT_LOCK_DETECT)
> +		split_lock_setup();
> +}
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index 61e93a318983..55d205820f35 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -654,6 +654,9 @@ void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p)
>  		/* Enforce MSR update to ensure consistent state */
>  		__speculation_ctrl_update(~tifn, tifn);
>  	}
> +
> +	if (tifp & _TIF_SLD)
> +		switch_sld(prev_p);
>  }
>  
>  /*
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index 05da6b5b167b..a933a01f6e40 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -46,6 +46,7 @@
>  #include <asm/traps.h>
>  #include <asm/desc.h>
>  #include <asm/fpu/internal.h>
> +#include <asm/cpu.h>
>  #include <asm/cpu_entry_area.h>
>  #include <asm/mce.h>
>  #include <asm/fixmap.h>
> @@ -242,7 +243,6 @@ do_trap(int trapnr, int signr, char *str, struct pt_regs *regs,
>  {
>  	struct task_struct *tsk = current;
>  
> -

Whitespace.

>  	if (!do_trap_no_signal(tsk, trapnr, str, regs, error_code))
>  		return;
>  
> @@ -288,9 +288,34 @@ DO_ERROR(X86_TRAP_OLD_MF, SIGFPE,           0, NULL, "coprocessor segment overru
>  DO_ERROR(X86_TRAP_TS,     SIGSEGV,          0, NULL, "invalid TSS",         invalid_TSS)
>  DO_ERROR(X86_TRAP_NP,     SIGBUS,           0, NULL, "segment not present", segment_not_present)
>  DO_ERROR(X86_TRAP_SS,     SIGBUS,           0, NULL, "stack segment",       stack_segment)
> -DO_ERROR(X86_TRAP_AC,     SIGBUS,  BUS_ADRALN, NULL, "alignment check",     alignment_check)
>  #undef IP
>  
> +dotraplinkage void do_alignment_check(struct pt_regs *regs, long error_code)
> +{
> +	unsigned int trapnr = X86_TRAP_AC;
> +	char str[] = "alignment check";

const if you want to keep it.

> +	int signr = SIGBUS;

Don't see any reason for these, e.g. they're not used for do_trap().
trapnr and signr in particular do more harm than good.

> +	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
> +
> +	if (notify_die(DIE_TRAP, str, regs, error_code, trapnr, signr) == NOTIFY_STOP)
> +		return;
> +
> +	if (!handle_split_lock())
> +		return;
> +
> +	if (!user_mode(regs))
> +		die("Split lock detected\n", regs, error_code);
> +
> +	cond_local_irq_enable(regs);
> +
> +	if (handle_user_split_lock(regs, error_code))
> +		return;
> +
> +	do_trap(X86_TRAP_AC, SIGBUS, "alignment check", regs,
> +		error_code, BUS_ADRALN, NULL);
> +}
> +
>  #ifdef CONFIG_VMAP_STACK
>  __visible void __noreturn handle_stack_overflow(const char *message,
>  						struct pt_regs *regs,
> -- 
> 2.21.0
> 
