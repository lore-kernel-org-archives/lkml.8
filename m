Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3CEC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 03:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FD2A207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 03:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731205AbgG2DCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 23:02:36 -0400
Received: from mga01.intel.com ([192.55.52.88]:18920 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728401AbgG2DCf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 23:02:35 -0400
IronPort-SDR: FcnsaFVPk4kzYaLB0DkBg3SozuYCsyh2j5tGL+6955wQBIXv+WeVMQ1JciDfh5mIsF3Ipofcg1
 2tY+bBWQikFQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9696"; a="169468581"
X-IronPort-AV: E=Sophos;i="5.75,408,1589266800"; 
   d="scan'208";a="169468581"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2020 20:02:33 -0700
IronPort-SDR: d1XWzYmBlujawiw+bZSG0GuCvZH7j6LgHMdcuBWwJ++JKMZIipBhA39hx8IZf/2KW+2fvAxrAe
 6vWfJkmyc42g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,408,1589266800"; 
   d="scan'208";a="330266755"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.152])
  by orsmga007.jf.intel.com with ESMTP; 28 Jul 2020 20:02:32 -0700
Date:   Tue, 28 Jul 2020 20:02:32 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>, H Peter Anvin <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] x86/bus_lock: Enable bus lock detection
Message-ID: <20200729030232.GE5583@linux.intel.com>
References: <1595021700-68460-1-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595021700-68460-1-git-send-email-fenghua.yu@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 02:35:00PM -0700, Fenghua Yu wrote:
> A bus lock [1] is acquired either through split locked access to writeback (WB)
> memory or by using locks to uncacheable (UC) memory (e.g. direct device

Does SLD not detect the lock to UC memory?

> assignment). This is typically >1000 cycles slower than an atomic operation
> within a cache line. It also disrupts performance on other cores.
> 
> Although split lock can be detected by #AC trap, the trap is triggered
> before the instruction acquires bus lock. This makes it difficult to
> mitigate bus lock (e.g. throttle the user application).

Mitigate _in a non-fatal way_.  The #AC makes it very easy to mitigate split
locks, it just has the side effect of SIGBUGS or killing the KVM guest.

> Some CPUs have ability to notify the kernel by an #DB trap after the
> instruction acquires a bus lock and is executed. This allows the kernel
> to enforce user application throttling or mitigations and also provides
> a better environment to debug kernel split lock issues since the kernel
> can continue instead of crashing.
> 
> #DB for bus lock detect fixes all issues in #AC for split lock detect:

Fixes "all" issues... and creates some new ones, e.g. there are use cases
where preventing the split lock from happening in the first place is
strongly desired.  It's why that train wreck exists.

> 1) It's architectural ... just need to look at one CPUID bit to know it
>    exists
> 2) The IA32_DEBUGCTL MSR, which reports bus lock in #DB, is per-thread.
>    So each process or guest can have different behavior.
> 3) It has support for VMM/guests (new VMEXIT codes, etc).
> 
> Use the existing kernel command line option "split_lock_detect=" to handle
> #DB for bus lock:

Are SLD and BLD mutually exclusive?  Can we even guarantee that given the
track record of SLD?  If not, we'll likely want to allow the user to choose
between SDL and BLD via split_lock_detect.

> split_lock_detect=
> 		#AC for split lock		#DB for bus lock
> 
> off		Do nothing			Do nothing
> 
> warn		Kernel OOPs			Kernel warns rate limited
> 		Warn once per task and		and continues to run.
> 		disable future checking 	Warn once per task and
> 						and continue to run.
> 						When both features are
> 						supported, warn in #DB
> 
> fatal		Kernel OOPs			Kernel warn rate limited

Unless the lock to UC #DB is new behavior, why would we revert to allowing
split locks in the kernel?

> 		Send SIGBUS to user		Send SIGBUS to user
> 		When both features are
> 		supported, fatal in #AC.
> 
> ratelimit:N	Do nothing			Kernel warns rate limited

This should be more than "Do nothing" for #AC, e.g. fall back to warn or
at least print a loud error.

> 						and continue to run.
> 						Limit bus lock rate to
> 						N per second in the
> 						current non root user.
> 
> On systems that support #DB for bus lock detection the default is "warn".
> 
> [1] Chapter 8 https://software.intel.com/sites/default/files/managed/c5/15/architecture-instruction-set-extensions-programming-reference.pdf
> 
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  48 +++++-
>  arch/x86/include/asm/cpu.h                    |  16 +-
>  arch/x86/include/asm/cpufeatures.h            |   1 +
>  arch/x86/include/asm/msr-index.h              |   1 +
>  arch/x86/include/uapi/asm/debugreg.h          |   3 +-
>  arch/x86/kernel/cpu/common.c                  |   2 +-
>  arch/x86/kernel/cpu/intel.c                   | 156 +++++++++++++++---
>  arch/x86/kernel/traps.c                       |  10 ++
>  include/linux/sched/user.h                    |   4 +-
>  kernel/user.c                                 |   7 +
>  10 files changed, 214 insertions(+), 34 deletions(-)

Maybe it's just me, but it'd be nice to break this into multiple patches
so that the SLD refactoring is separate from the introduction of BLD.  As
is, I find it hard to review as I can't easily distinguish refactoring from
new functionality.

> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index fb95fad81c79..7a1cb6fe8b8e 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4816,27 +4816,59 @@
>  	spia_peddr=
>  
>  	split_lock_detect=
> -			[X86] Enable split lock detection
> +			[X86] Enable split lock detection or bus lock detection
>  
>  			When enabled (and if hardware support is present), atomic
>  			instructions that access data across cache line
> -			boundaries will result in an alignment check exception.
> +			boundaries will result in an alignment check exception
> +			for split lock detection or an debug exception for
> +			bus lock detection.
>  
>  			off	- not enabled
>  
> -			warn	- the kernel will emit rate limited warnings
> -				  about applications triggering the #AC
> -				  exception. This mode is the default on CPUs
> -				  that supports split lock detection.
> +			warn	- Default mode.
>  
> -			fatal	- the kernel will send SIGBUS to applications
> -				  that trigger the #AC exception.
> +				  If split lock detection is enabled in
> +				  hardware, the kernel will emit rate limited
> +				  warnings about applications triggering the #AC
> +				  exception.
> +
> +				  If bus lock detection is enabled in hardware,
> +				  the kernel will emit rate limited warnings
> +				  about applications triggering the #D

s/#D/#DB

> +				  exception.
> +
> +				  Default behavior is from bus lock detection
> +				  if both features are enabled in hardware.
> +
> +			fatal	- If split lock detection is enabled in
> +				  hardware, the kernel will send SIGBUS to
> +				  applications that trigger the #AC exception.
> +
> +				  If bus lock detection is enabled in hardware,
> +				  the kernel will send SIGBUS to application
> +				  that trigger the #DB exception.
> +
> +				  Default behavior is from split lock detection
> +				  if both are enabled in hardware.
> +
> +			ratelimit:N
> +				  Set rate limit to N bus locks per second
> +				  for bus lock detection. 0 < N <= HZ/2 and
> +				  N is approximate. Not applied to root user
> +				  and the kernel. Only applied to non root user.
> +
> +				  N/A for split lock detection.
>  
>  			If an #AC exception is hit in the kernel or in
>  			firmware (i.e. not while executing in user mode)
>  			the kernel will oops in either "warn" or "fatal"
>  			mode.
>  
> +			If an #DB exception is hit in the kernel or in
> +			firmware, the kernel will warn in either "warn" or
> +			"fatal" mode.
> +
>  	srbds=		[X86,INTEL]
>  			Control the Special Register Buffer Data Sampling
>  			(SRBDS) mitigation.

...

> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> index 0ab48f1cdf84..f498472990af 100644
> --- a/arch/x86/kernel/cpu/intel.c
> +++ b/arch/x86/kernel/cpu/intel.c
> @@ -10,6 +10,9 @@
>  #include <linux/thread_info.h>
>  #include <linux/init.h>
>  #include <linux/uaccess.h>
> +#include <linux/cred.h>
> +#include <linux/delay.h>
> +#include <linux/sched/user.h>
>  
>  #include <asm/cpufeature.h>
>  #include <asm/msr.h>
> @@ -39,15 +42,20 @@ enum split_lock_detect_state {
>  	sld_off = 0,
>  	sld_warn,
>  	sld_fatal,
> +	sld_ratelimit,
>  };
>  
>  /*
>   * Default to sld_off because most systems do not support split lock detection
> - * split_lock_setup() will switch this to sld_warn on systems that support
> - * split lock detect, unless there is a command line override.
> + * sld_state_setup() will switch this to sld_warn on systems that support
> + * split lock/bus lock detect, unless there is a command line override.
>   */
>  static enum split_lock_detect_state sld_state __ro_after_init = sld_off;
>  static u64 msr_test_ctrl_cache __ro_after_init;
> +/* Split lock detection is enabled if it's true. */
> +static bool sld;
> +/* Bus lock detection is enabled if it's true. */
> +static bool bld;

Why can't these be tracked/reflected in X86_FEATURE_*?

>  /*
>   * With a name like MSR_TEST_CTL it should go without saying, but don't touch
> @@ -601,6 +609,7 @@ static void init_intel_misc_features(struct cpuinfo_x86 *c)
>  }
>  
>  static void split_lock_init(void);
> +static void bus_lock_init(void);
>  
>  static void init_intel(struct cpuinfo_x86 *c)
>  {
> @@ -717,6 +726,7 @@ static void init_intel(struct cpuinfo_x86 *c)
>  	if (tsx_ctrl_state == TSX_CTRL_DISABLE)
>  		tsx_disable();
>  
> +	bus_lock_init();
>  	split_lock_init();
>  }
>  
> @@ -991,13 +1001,25 @@ static const struct {
>  	{ "off",	sld_off   },
>  	{ "warn",	sld_warn  },
>  	{ "fatal",	sld_fatal },
> +	{ "ratelimit:", sld_ratelimit },
>  };
>  
>  static inline bool match_option(const char *arg, int arglen, const char *opt)
>  {
> -	int len = strlen(opt);
>  
> -	return len == arglen && !strncmp(arg, opt, len);
> +	int len = strlen(opt), ratelimit;
> +
> +	if (strncmp(arg, opt, len))
> +		return false;
> +
> +	if (sscanf(arg, "ratelimit:%d", &ratelimit) == 1 && ratelimit > 0 &&
> +	    ratelimit_bl <= HZ / 2) {
> +		ratelimit_bl = ratelimit;
> +
> +		return true;
> +	}
> +
> +	return len == arglen;
>  }
>  
>  static bool split_lock_verify_msr(bool on)
> @@ -1016,16 +1038,15 @@ static bool split_lock_verify_msr(bool on)
>  	return ctrl == tmp;
>  }
>  
> -static void __init split_lock_setup(void)
> +static void __init sld_state_setup(void)
>  {
>  	enum split_lock_detect_state state = sld_warn;
>  	char arg[20];
>  	int i, ret;
>  
> -	if (!split_lock_verify_msr(false)) {
> -		pr_info("MSR access failed: Disabled\n");
> +	if (!static_cpu_has(X86_FEATURE_SPLIT_LOCK_DETECT) &&
> +	    !static_cpu_has(X86_FEATURE_BUS_LOCK_DETECT))

Pretty sure static_cpu_has() in an __init function is a waste.

>  		return;
> -	}
>  
>  	ret = cmdline_find_option(boot_command_line, "split_lock_detect",
>  				  arg, sizeof(arg));
> @@ -1037,17 +1058,14 @@ static void __init split_lock_setup(void)
>  			}
>  		}
>  	}
> +	sld_state = state;
> +}
>  
> -	switch (state) {
> -	case sld_off:
> -		pr_info("disabled\n");
> +static void __init _split_lock_setup(void)
> +{
> +	if (!split_lock_verify_msr(false)) {
> +		pr_info("MSR access failed: Disabled\n");
>  		return;
> -	case sld_warn:
> -		pr_info("warning about user-space split_locks\n");
> -		break;
> -	case sld_fatal:
> -		pr_info("sending SIGBUS on user-space split_locks\n");
> -		break;
>  	}
>  
>  	rdmsrl(MSR_TEST_CTRL, msr_test_ctrl_cache);
> @@ -1057,8 +1075,11 @@ static void __init split_lock_setup(void)
>  		return;
>  	}
>  
> -	sld_state = state;
> +	/* Restore the MSR to its cached value. */
> +	wrmsrl(MSR_TEST_CTRL, msr_test_ctrl_cache);
> +
>  	setup_force_cpu_cap(X86_FEATURE_SPLIT_LOCK_DETECT);
> +	sld = true;
>  }
>  
>  /*
> @@ -1078,6 +1099,10 @@ static void sld_update_msr(bool on)
>  
>  static void split_lock_init(void)
>  {
> +	/* If supported, #DB for bus lock will handle warn and ratelimit. */
> +	if (bld && (sld_state == sld_warn || sld_state == sld_ratelimit))
> +		return;
> +
>  	if (cpu_model_supports_sld)
>  		split_lock_verify_msr(sld_state != sld_off);
>  }
> @@ -1114,14 +1139,58 @@ bool handle_guest_split_lock(unsigned long ip)
>  }
>  EXPORT_SYMBOL_GPL(handle_guest_split_lock);
>  
> +static void bus_lock_init(void)
> +{
> +	u64 val;
> +
> +	if (!bld)
> +		return;
> +
> +	/* If supported, #AC for split lock will handle fatal. */
> +	if (sld && sld_state == sld_fatal)
> +		return;
> +
> +	rdmsrl(MSR_IA32_DEBUGCTLMSR, val);
> +	val |= DEBUGCTLMSR_BUS_LOCK_DETECT;

Uh, doesn't this enable BLD even if sld_state == sld_off?

> +	wrmsrl(MSR_IA32_DEBUGCTLMSR, val);
> +}
> +
>  bool handle_user_split_lock(struct pt_regs *regs, long error_code)
>  {
> -	if ((regs->flags & X86_EFLAGS_AC) || sld_state == sld_fatal)
> +	if ((regs->flags & X86_EFLAGS_AC) || !sld || sld_state == sld_fatal ||
> +	    sld_state == sld_ratelimit)
>  		return false;
>  	split_lock_warn(regs->ip);
>  	return true;
>  }
>  
> +bool handle_user_bus_lock(struct pt_regs *regs)
> +{
> +	if (!bld)
> +		return false;
> +
> +	pr_warn_ratelimited("#DB: %s/%d took a bus_lock trap at address: 0x%lx\n",
> +			    current->comm, current->pid, regs->ip);
> +
> +	if (sld_state == sld_ratelimit) {
> +		while (!__ratelimit(&get_current_user()->ratelimit_bl))
> +			msleep(1000 / ratelimit_bl);
> +	}
> +
> +	return true;
> +}
> +
> +bool handle_kernel_bus_lock(struct pt_regs *regs)
> +{
> +	if (!bld)
> +		return false;
> +
> +	pr_warn_ratelimited("#DB: %s/%d took a bus_lock trap at address: 0x%lx\n",
> +			    current->comm, current->pid, regs->ip);
> +
> +	return true;
> +}
> +
>  /*
>   * This function is called only when switching between tasks with
>   * different split-lock detection modes. It sets the MSR for the
> @@ -1159,7 +1228,7 @@ static const struct x86_cpu_id split_lock_cpu_ids[] __initconst = {
>  	{}
>  };
>  
> -void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c)
> +static void __init split_lock_setup(struct cpuinfo_x86 *c)
>  {
>  	const struct x86_cpu_id *m;
>  	u64 ia32_core_caps;
> @@ -1186,5 +1255,50 @@ void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c)
>  	}
>  
>  	cpu_model_supports_sld = true;
> -	split_lock_setup();
> +	_split_lock_setup();
> +}
> +
> +static void sld_state_show(void)
> +{
> +	if (!bld && !sld)
> +		return;
> +
> +	switch (sld_state) {
> +	case sld_off:
> +		pr_info("disabled\n");
> +		break;
> +
> +	case sld_warn:
> +		if (bld)
> +			pr_info("#DB: warning about kernel and user-space bus_locks\n");
> +		else
> +			pr_info("#AC: crashing the kernel about kernel split_locks and warning about user-space split_locks\n");
> +		break;
> +
> +	case sld_fatal:
> +		if (sld)
> +			pr_info("#AC: crashing the kernel on kernel split_locks and sending SIGBUS on user-space split_locks\n");
> +		else
> +			pr_info("#DB: warning about kernel bus_locks and sending SIGBUS on user-space bus_locks\n");
> +		break;
> +
> +	case sld_ratelimit:
> +		if (bld)
> +			pr_info("#DB: warning about kernel bus_locks and setting silent rate limit to %d/sec per user on non root user-space bus_locks\n", ratelimit_bl);
> +		break;
> +	}
> +}
> +
> +static void __init bus_lock_setup(void)
> +{
> +	if (static_cpu_has(X86_FEATURE_BUS_LOCK_DETECT) && sld_state != sld_off)

More overkill.

> +		bld = true;
> +}
> +
> +void __init sld_setup(struct cpuinfo_x86 *c)

This wrapper probably should call out that it configures both sld and bld.

> +{
> +	sld_state_setup();
> +	split_lock_setup(c);
> +	bus_lock_setup();
> +	sld_state_show();
>  }
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index b038695f36c5..58725567da39 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -812,6 +812,16 @@ static void handle_debug(struct pt_regs *regs, unsigned long dr6, bool user)
>  	if (!user && !dr6)
>  		return;
>  
> +	/* Handle bus lock. */
> +	if (!(dr6 & DR_BUS_LOCK)) {
> +		cond_local_irq_enable(regs);
> +		if (user)
> +			handle_user_bus_lock(regs);
> +		else
> +			handle_kernel_bus_lock(regs);
> +		goto out;
> +	}
> +
>  	/*
>  	 * If dr6 has no reason to give us about the origin of this trap,
>  	 * then it's very likely the result of an icebp/int01 trap.
> diff --git a/include/linux/sched/user.h b/include/linux/sched/user.h
> index 917d88edb7b9..fc757ec6c19f 100644
> --- a/include/linux/sched/user.h
> +++ b/include/linux/sched/user.h
> @@ -37,8 +37,9 @@ struct user_struct {
>  	atomic_long_t locked_vm;
>  #endif
>  
> -	/* Miscellaneous per-user rate limit */
> +	/* Miscellaneous per-user rate limits */
>  	struct ratelimit_state ratelimit;
> +	struct ratelimit_state ratelimit_bl;

Why not spell out ratelimit_bus_lock?  There's no way someone looking at
this code in isolation is going to have any clue what "bl" means.

>  };
>  
>  extern int uids_sysfs_init(void);
> @@ -48,6 +49,7 @@ extern struct user_struct *find_user(kuid_t);
>  extern struct user_struct root_user;
>  #define INIT_USER (&root_user)
>  
> +extern int ratelimit_bl;
>  
>  /* per-UID process charging. */
>  extern struct user_struct * alloc_uid(kuid_t);
> diff --git a/kernel/user.c b/kernel/user.c
> index b1635d94a1f2..023dad617625 100644
> --- a/kernel/user.c
> +++ b/kernel/user.c
> @@ -103,6 +103,7 @@ struct user_struct root_user = {
>  	.locked_shm     = 0,
>  	.uid		= GLOBAL_ROOT_UID,
>  	.ratelimit	= RATELIMIT_STATE_INIT(root_user.ratelimit, 0, 0),
> +	.ratelimit_bl	= RATELIMIT_STATE_INIT(root_user.ratelimit_bl, 0, 0),
>  };
>  
>  /*
> @@ -172,6 +173,9 @@ void free_uid(struct user_struct *up)
>  		free_user(up, flags);
>  }
>  
> +/* Architectures (e.g. X86) may set this for rate limited bus locks. */
> +int ratelimit_bl;
> +
>  struct user_struct *alloc_uid(kuid_t uid)
>  {
>  	struct hlist_head *hashent = uidhashentry(uid);
> @@ -190,6 +194,9 @@ struct user_struct *alloc_uid(kuid_t uid)
>  		refcount_set(&new->__count, 1);
>  		ratelimit_state_init(&new->ratelimit, HZ, 100);
>  		ratelimit_set_flags(&new->ratelimit, RATELIMIT_MSG_ON_RELEASE);
> +		ratelimit_state_init(&new->ratelimit_bl, HZ, ratelimit_bl);
> +		ratelimit_set_flags(&new->ratelimit_bl,
> +				    RATELIMIT_MSG_ON_RELEASE);
>  
>  		/*
>  		 * Before adding this, check whether we raced
> -- 
> 2.19.1
> 
