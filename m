Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA75C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67F5D22522
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="XfszeKmi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730242AbgAYKob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 05:44:31 -0500
Received: from mail.skyhub.de ([5.9.137.197]:46462 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729094AbgAYKo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 05:44:26 -0500
Received: from zn.tnic (p200300EC2F1CE90069D6E0BC8F968F6D.dip0.t-ipconnect.de [IPv6:2003:ec:2f1c:e900:69d6:e0bc:8f96:8f6d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 452CF1EC068C;
        Sat, 25 Jan 2020 11:44:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1579949064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+iWR8PZlTMfvq/xJ/oAIrVZD9TCZjVaGPv5kWMky4Xs=;
        b=XfszeKmiykB8sqI+tIlljXrcPXdEYE5dmJW/2syHqiTTrrU5jSnFd+RNfuO8Dref+SPE1n
        rFdxtQbYnKoJpdhK2bUJYw5YCI/QrrABZtV/F7krLEEKgitVu+e78puNFOmdCDv2L68itg
        8FP5NZ5NsDn0ge1XX4duESVftzW00VY=
Date:   Sat, 25 Jan 2020 11:44:19 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v15] x86/split_lock: Enable split lock detection by kernel
Message-ID: <20200125104419.GA16136@zn.tnic>
References: <20200115225724.GA18268@linux.intel.com>
 <20200122185514.GA16010@agluck-desk2.amr.corp.intel.com>
 <20200122224245.GA2331824@rani.riverdale.lan>
 <3908561D78D1C84285E8C5FCA982C28F7F54887A@ORSMSX114.amr.corp.intel.com>
 <20200123004507.GA2403906@rani.riverdale.lan>
 <20200123035359.GA23659@agluck-desk2.amr.corp.intel.com>
 <20200123044514.GA2453000@rani.riverdale.lan>
 <20200123231652.GA4457@agluck-desk2.amr.corp.intel.com>
 <87h80kmta4.fsf@nanos.tec.linutronix.de>
 <20200125024727.GA32483@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200125024727.GA32483@agluck-desk2.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2020 at 06:47:27PM -0800, Luck, Tony wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> A split-lock occurs when an atomic instruction operates on data
> that spans two cache lines. In order to maintain atomicity the
> core takes a global bus lock.
> 
> This is typically >1000 cycles slower than an atomic operation
> within a cache line. It also disrupts performance on other cores
> (which must wait for the bus lock to be released before their
> memory operations can complete). For real-time systems this may
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
> 		  split lock, but allow it to continue
> 		  running.
> 	fatal	- Send SIGBUS to applications that cause split lock
> 
> On systems that support split lock detection the default is "warn". Note
> that if the kernel hits a split lock in any mode other than "off" it
> will OOPs.
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

I think this "wrinkle" needs to be written down somewhere more prominent
- not in the commit message only - so that people can find it when using
the thing and start seeing the multiple #ACs on the same insn.

> Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
> Co-developed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Tony Luck <tony.luck@intel.com>

checkpatch is bitching here:

WARNING: Co-developed-by: must be immediately followed by Signed-off-by:
#66: 
Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Co-developed-by: Tony Luck <tony.luck@intel.com>
WARNING: Co-developed-by and Signed-off-by: name/email do not match 
#67: 
Co-developed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>

> ---
> 
> tglx> Other than those details, I really like this approach.
> 
> Thanks for the review. Here is V15 with all your V14 comments addressed.
> 
> I did find something with a new test. Applications that hit a
> split lock warn as expected. But if they sleep before they hit
> a new split lock, we get another warning. This is may be because
> I messed up when fixing a PeterZ typo in the untested patch.
> But I think there may have been bigger problems.
> 
> Context switch in V14 code did: 
> 
>        if (tifp & _TIF_SLD)
>                switch_to_sld(prev_p);
> 
> void switch_to_sld(struct task_struct *prev)
> {
>        __sld_msr_set(true);
>        clear_tsk_thread_flag(prev, TIF_SLD);
> }
> 
> Which re-enables split lock checking for the next process to run. But
> mysteriously clears the TIF_SLD bit on the previous task.
> 
> I think we need to consider TIF_SLD state of both previous and next
> process when deciding what to do with the MSR. Three cases:
> 
> 1) If they are both the same, leave the MSR alone it is (probably) right (modulo
>    the other thread having messed with it).
> 2) Next process has _TIF_SLD set ... disable checking
> 3) Next process doesn't have _TIF_SLD set ... enable checking
> 
> So please look closely at the new version of switch_to_sld() which is
> now called unconditonally on every switch ... but commonly will do
> nothing.
> 
>  .../admin-guide/kernel-parameters.txt         |  18 ++
>  arch/x86/include/asm/cpu.h                    |  12 ++
>  arch/x86/include/asm/cpufeatures.h            |   2 +
>  arch/x86/include/asm/msr-index.h              |   9 +
>  arch/x86/include/asm/thread_info.h            |   6 +-
>  arch/x86/kernel/cpu/common.c                  |   2 +
>  arch/x86/kernel/cpu/intel.c                   | 177 ++++++++++++++++++
>  arch/x86/kernel/process.c                     |   2 +
>  arch/x86/kernel/traps.c                       |  24 ++-
>  9 files changed, 248 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 7f1e2f327e43..27f61d44a37f 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3207,6 +3207,24 @@
>  
>  	nosoftlockup	[KNL] Disable the soft-lockup detector.
>  
> +	split_lock_detect=

Needs to be alphabetically sorted.

> +			[X86] Enable split lock detection
> +
> +			When enabled (and if hardware support is present), atomic
> +			instructions that access data across cache line
> +			boundaries will result in an alignment check exception.
> +
> +			off	- not enabled
> +
> +			warn	- the kernel will emit rate limited warnings
> +				  about applications triggering the #AC exception
> +
> +			fatal	- the kernel will SIGBUS applications that

"... the kernel will send a SIGBUG to applications..."

> +				  trigger the #AC exception.
> +
> +			For any more other than 'off' the kernel will die if
> +			it (or firmware) will trigger #AC.

Why would the kernel die in the "warn" case? It prints ratelimited
warnings only, if I'm reading this help text correctly. Commit mesage says

" Note that if the kernel hits a split lock in any mode other than
"off" it will OOPs."

but this text doesn't say why and leaves people scratching heads and
making them look at the code...

/me scrolls down

aaha, you mean this:

        if (!user_mode(regs))
                die("Split lock detected\n", regs, error_code);

so what you're trying to say is, "if an #AC exception is hit in the
kernel or the firmware - not in a user task - then we will oops."

Yes?

If so, pls extend so that it is clear what this means.

And the default setting is? I.e., put a short sentence after "warn"
saying so.

> +
>  	nosync		[HW,M68K] Disables sync negotiation for all devices.
>  
>  	nowatchdog	[KNL] Disable both lockup detectors, i.e.
> diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
> index adc6cc86b062..2dede2bbb7cf 100644
> --- a/arch/x86/include/asm/cpu.h
> +++ b/arch/x86/include/asm/cpu.h
> @@ -40,4 +40,16 @@ int mwait_usable(const struct cpuinfo_x86 *);
>  unsigned int x86_family(unsigned int sig);
>  unsigned int x86_model(unsigned int sig);
>  unsigned int x86_stepping(unsigned int sig);
> +#ifdef CONFIG_CPU_SUP_INTEL
> +extern void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c);
> +extern bool handle_user_split_lock(struct pt_regs *regs, long error_code);
> +extern void switch_to_sld(struct task_struct *, struct task_struct *);

WARNING: function definition argument 'struct task_struct *' should also have an identifier name
#160: FILE: arch/x86/include/asm/cpu.h:46:
+extern void switch_to_sld(struct task_struct *, struct task_struct *);

> +#else
> +static inline void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c) {}
> +static inline bool handle_user_split_lock(struct pt_regs *regs, long error_code)
> +{
> +	return false;
> +}
> +static inline void switch_to_sld(struct task_struct *prev, struct stack *next) {}
> +#endif
>  #endif /* _ASM_X86_CPU_H */
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index f3327cb56edf..cd56ad5d308e 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -285,6 +285,7 @@
>  #define X86_FEATURE_CQM_MBM_LOCAL	(11*32+ 3) /* LLC Local MBM monitoring */
>  #define X86_FEATURE_FENCE_SWAPGS_USER	(11*32+ 4) /* "" LFENCE in user entry SWAPGS path */
>  #define X86_FEATURE_FENCE_SWAPGS_KERNEL	(11*32+ 5) /* "" LFENCE in kernel entry SWAPGS path */
> +#define X86_FEATURE_SPLIT_LOCK_DETECT	(11*32+ 6) /* #AC for split lock */

Do you really want to have "split_lock_detect" in /proc/cpuinfo or
rather somethign shorter?

>  /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
>  #define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* AVX512 BFLOAT16 instructions */
> @@ -367,6 +368,7 @@
>  #define X86_FEATURE_INTEL_STIBP		(18*32+27) /* "" Single Thread Indirect Branch Predictors */
>  #define X86_FEATURE_FLUSH_L1D		(18*32+28) /* Flush L1D cache */
>  #define X86_FEATURE_ARCH_CAPABILITIES	(18*32+29) /* IA32_ARCH_CAPABILITIES MSR (Intel) */
> +#define X86_FEATURE_CORE_CAPABILITIES	(18*32+30) /* "" IA32_CORE_CAPABILITIES MSR */
>  #define X86_FEATURE_SPEC_CTRL_SSBD	(18*32+31) /* "" Speculative Store Bypass Disable */
>  
>  /*
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index ebe1685e92dd..8821697a7549 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -41,6 +41,10 @@
>  
>  /* Intel MSRs. Some also available on other CPUs */
>  
> +#define MSR_TEST_CTRL				0x00000033
> +#define MSR_TEST_CTRL_SPLIT_LOCK_DETECT_BIT	29
> +#define MSR_TEST_CTRL_SPLIT_LOCK_DETECT		BIT(MSR_TEST_CTRL_SPLIT_LOCK_DETECT_BIT)
> +
>  #define MSR_IA32_SPEC_CTRL		0x00000048 /* Speculation Control */
>  #define SPEC_CTRL_IBRS			BIT(0)	   /* Indirect Branch Restricted Speculation */
>  #define SPEC_CTRL_STIBP_SHIFT		1	   /* Single Thread Indirect Branch Predictor (STIBP) bit */
> @@ -70,6 +74,11 @@
>   */
>  #define MSR_IA32_UMWAIT_CONTROL_TIME_MASK	(~0x03U)
>  
> +/* Abbreviated from Intel SDM name IA32_CORE_CAPABILITIES */
> +#define MSR_IA32_CORE_CAPS			  0x000000cf
> +#define MSR_IA32_CORE_CAPS_SPLIT_LOCK_DETECT_BIT  5
> +#define MSR_IA32_CORE_CAPS_SPLIT_LOCK_DETECT	  BIT(MSR_IA32_CORE_CAPS_SPLIT_LOCK_DETECT_BIT)
> +
>  #define MSR_PKG_CST_CONFIG_CONTROL	0x000000e2
>  #define NHM_C3_AUTO_DEMOTE		(1UL << 25)
>  #define NHM_C1_AUTO_DEMOTE		(1UL << 26)
> diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
> index cf4327986e98..e0d12517f348 100644
> --- a/arch/x86/include/asm/thread_info.h
> +++ b/arch/x86/include/asm/thread_info.h
> @@ -92,6 +92,7 @@ struct thread_info {
>  #define TIF_NOCPUID		15	/* CPUID is not accessible in userland */
>  #define TIF_NOTSC		16	/* TSC is not accessible in userland */
>  #define TIF_IA32		17	/* IA32 compatibility process */
> +#define TIF_SLD			18	/* Restore split lock detection on context switch */
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

Can you fix those while at it pls:

ERROR: need consistent spacing around '|' (ctx:VxW)
#245: FILE: arch/x86/include/asm/thread_info.h:165:
+# define _TIF_WORK_CTXSW_PREV	(_TIF_WORK_CTXSW| _TIF_USER_RETURN_NOTIFY | _TIF_SLD)
                              	                ^
>  #endif
>  
>  #define _TIF_WORK_CTXSW_NEXT	(_TIF_WORK_CTXSW)
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 86b8241c8209..adb2f639f388 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -1242,6 +1242,8 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
>  
>  	cpu_set_bug_bits(c);
>  
> +	cpu_set_core_cap_bits(c);
> +
>  	fpu__init_system(c);
>  
>  #ifdef CONFIG_X86_32
> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> index 57473e2c0869..d9842c64e5af 100644
> --- a/arch/x86/kernel/cpu/intel.c
> +++ b/arch/x86/kernel/cpu/intel.c
> @@ -19,6 +19,8 @@
>  #include <asm/microcode_intel.h>
>  #include <asm/hwcap2.h>
>  #include <asm/elf.h>
> +#include <asm/cpu_device_id.h>
> +#include <asm/cmdline.h>
>  
>  #ifdef CONFIG_X86_64
>  #include <linux/topology.h>
> @@ -31,6 +33,20 @@
>  #include <asm/apic.h>
>  #endif
>  
> +enum split_lock_detect_state {
> +	sld_off = 0,
> +	sld_warn,
> +	sld_fatal,
> +};
> +
> +/*
> + * Default to sld_off because most systems do not support
> + * split lock detection. split_lock_setup() will switch this
> + * to sld_warn on systems that support split lock detect, and
> + * then check to see if there is a command line override.
> + */

That comment is shorter than 80 cols while others below aren't.

> +static enum split_lock_detect_state sld_state = sld_off;
> +
>  /*
>   * Just in case our CPU detection goes bad, or you have a weird system,
>   * allow a way to override the automatic disabling of MPX.
> @@ -606,6 +622,8 @@ static void init_intel_misc_features(struct cpuinfo_x86 *c)
>  	wrmsrl(MSR_MISC_FEATURES_ENABLES, msr);
>  }
>  
> +static void split_lock_init(void);
> +
>  static void init_intel(struct cpuinfo_x86 *c)
>  {
>  	early_init_intel(c);
> @@ -720,6 +738,8 @@ static void init_intel(struct cpuinfo_x86 *c)
>  		tsx_enable();
>  	if (tsx_ctrl_state == TSX_CTRL_DISABLE)
>  		tsx_disable();
> +
> +	split_lock_init();
>  }
>  
>  #ifdef CONFIG_X86_32
> @@ -981,3 +1001,160 @@ static const struct cpu_dev intel_cpu_dev = {
>  };
>  
>  cpu_dev_register(intel_cpu_dev);
> +
> +#undef pr_fmt
> +#define pr_fmt(fmt) "x86/split lock detection: " fmt
> +
> +static const struct {
> +	const char			*option;
> +	enum split_lock_detect_state	state;
> +} sld_options[] __initconst = {
> +	{ "off",	sld_off   },
> +	{ "warn",	sld_warn  },
> +	{ "fatal",	sld_fatal },
> +};
> +
> +static inline bool match_option(const char *arg, int arglen, const char *opt)
> +{
> +	int len = strlen(opt);
> +
> +	return len == arglen && !strncmp(arg, opt, len);
> +}

There's the same function in arch/x86/kernel/cpu/bugs.c. Why are you
duplicating it here?

Yeah, this whole chunk looks like it has been "influenced" by the sec
mitigations in bugs.c :-)

> +static void __init split_lock_setup(void)
> +{
> +	char arg[20];
> +	int i, ret;
> +
> +	sld_state = sld_warn;
> +	setup_force_cpu_cap(X86_FEATURE_SPLIT_LOCK_DETECT);
> +
> +	ret = cmdline_find_option(boot_command_line, "split_lock_detect",
> +				  arg, sizeof(arg));
> +	if (ret < 0)
> +		goto print;
> +
> +	for (i = 0; i < ARRAY_SIZE(sld_options); i++) {
> +		if (match_option(arg, ret, sld_options[i].option)) {
> +			sld_state = sld_options[i].state;
> +			break;
> +		}
> +	}
> +
> +print:
> +	switch(sld_state) {

ERROR: space required before the open parenthesis '('
#359: FILE: arch/x86/kernel/cpu/intel.c:1045:
+	switch(sld_state) {

> +	case sld_off:
> +		pr_info("disabled\n");
> +		break;
> +
> +	case sld_warn:
> +		pr_info("warning about user-space split_locks\n");
> +		break;
> +
> +	case sld_fatal:
> +		pr_info("sending SIGBUS on user-space split_locks\n");
> +		break;
> +	}
> +}
> +
> +/*
> + * Locking is not required at the moment because only bit 29 of this
> + * MSR is implemented and locking would not prevent that the operation
> + * of one thread is immediately undone by the sibling thread.
> + */
> +

^ Superfluous newline.

> +static bool __sld_msr_set(bool on)
> +{
> +	u64 test_ctrl_val;
> +
> +	if (rdmsrl_safe(MSR_TEST_CTRL, &test_ctrl_val))
> +		return false;
> +
> +	if (on)
> +		test_ctrl_val |= MSR_TEST_CTRL_SPLIT_LOCK_DETECT;
> +	else
> +		test_ctrl_val &= ~MSR_TEST_CTRL_SPLIT_LOCK_DETECT;
> +
> +	return !wrmsrl_safe(MSR_TEST_CTRL, test_ctrl_val);
> +}
> +
> +static void split_lock_init(void)
> +{
> +	if (sld_state == sld_off)
> +		return;
> +
> +	if (__sld_msr_set(true))
> +		return;
> +
> +	/*
> +	 * If this is anything other than the boot-cpu, you've done
> +	 * funny things and you get to keep whatever pieces.
> +	 */
> +	pr_warn("MSR fail -- disabled\n");

What's that for? Guests?

> +	__sld_msr_set(sld_off);
> +	sld_state = sld_off;
> +}
> +
> +bool handle_user_split_lock(struct pt_regs *regs, long error_code)
> +{
> +	if ((regs->flags & X86_EFLAGS_AC) || sld_state == sld_fatal)
> +		return false;
> +
> +	pr_warn_ratelimited("#AC: %s/%d took a split_lock trap at address: 0x%lx\n",
> +		 current->comm, current->pid, regs->ip);
> +
> +	/*
> +	 * Disable the split lock detection for this task so it can make
> +	 * progress and set TIF_SLD so the detection is reenabled via
> +	 * switch_to_sld() when the task is scheduled out.
> +	 */
> +	__sld_msr_set(false);
> +	set_tsk_thread_flag(current, TIF_SLD);
> +	return true;
> +}
> +
> +void switch_to_sld(struct task_struct *prev, struct task_struct *next)

This will get called on other vendors but let's just assume, for
simplicity's sake, TIF_SLD won't be set there so it is only a couple of
insns on a task switch going to waste.

> +{
> +	bool prevflag = test_tsk_thread_flag(prev, TIF_SLD);
> +	bool nextflag = test_tsk_thread_flag(next, TIF_SLD);
> +
> +	/*
> +	 * If we are switching between tasks that have the same
> +	 * need for split lock checking, then the MSR is (probably)
> +	 * right (modulo the other thread messing with it.
> +	 * Otherwise look at whether the new task needs split
> +	 * lock enabled.
> +	 */
> +	if (prevflag != nextflag)
> +		__sld_msr_set(nextflag);
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

So this gets called on other vendors too and even if they should not
have set X86_FEATURE_CORE_CAPABILITIES, a vendor check here would be
prudent for the future:

	if (c->x86_vendor != X86_VENDOR_INTEL)
		return;

> +
> +	if (cpu_has(c, X86_FEATURE_CORE_CAPABILITIES)) {
> +		/* Enumerate features reported in IA32_CORE_CAPABILITIES MSR. */
> +		rdmsrl(MSR_IA32_CORE_CAPS, ia32_core_caps);
> +	} else if (!boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
> +		/* Enumerate split lock detection by family and model. */
> +		if (x86_match_cpu(split_lock_cpu_ids))
> +			ia32_core_caps |= MSR_IA32_CORE_CAPS_SPLIT_LOCK_DETECT;
> +	}
> +
> +	if (ia32_core_caps & MSR_IA32_CORE_CAPS_SPLIT_LOCK_DETECT)
> +		split_lock_setup();
> +}
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index 839b5244e3b7..b34d359c4e39 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -650,6 +650,8 @@ void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p)
>  		/* Enforce MSR update to ensure consistent state */
>  		__speculation_ctrl_update(~tifn, tifn);
>  	}
> +
> +	switch_to_sld(prev_p, next_p);
>  }
>  
>  /*
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index 9e6f822922a3..884e8e59dafd 100644
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
> @@ -244,7 +245,6 @@ do_trap(int trapnr, int signr, char *str, struct pt_regs *regs,
>  {
>  	struct task_struct *tsk = current;
>  
> -
>  	if (!do_trap_no_signal(tsk, trapnr, str, regs, error_code))
>  		return;
>  
> @@ -290,9 +290,29 @@ DO_ERROR(X86_TRAP_OLD_MF, SIGFPE,           0, NULL, "coprocessor segment overru
>  DO_ERROR(X86_TRAP_TS,     SIGSEGV,          0, NULL, "invalid TSS",         invalid_TSS)
>  DO_ERROR(X86_TRAP_NP,     SIGBUS,           0, NULL, "segment not present", segment_not_present)
>  DO_ERROR(X86_TRAP_SS,     SIGBUS,           0, NULL, "stack segment",       stack_segment)
> -DO_ERROR(X86_TRAP_AC,     SIGBUS,  BUS_ADRALN, NULL, "alignment check",     alignment_check)
>  #undef IP
>  
> +dotraplinkage void do_alignment_check(struct pt_regs *regs, long error_code)
> +{
> +	const char str[] = "alignment check";

WARNING: const array should probably be static const
#517: FILE: arch/x86/kernel/traps.c:297:
+	const char str[] = "alignment check";

> +
> +	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
> +
> +	if (notify_die(DIE_TRAP, str, regs, error_code, X86_TRAP_AC, SIGBUS) == NOTIFY_STOP)
> +		return;
> +
> +	if (!user_mode(regs))
> +		die("Split lock detected\n", regs, error_code);
> +
> +	local_irq_enable();
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
> 2.21.1
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
