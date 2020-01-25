Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE63C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 22:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BBB82071A
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 22:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbgAYWHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 17:07:09 -0500
Received: from mga14.intel.com ([192.55.52.115]:11177 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726780AbgAYWHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 17:07:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jan 2020 14:07:07 -0800
X-IronPort-AV: E=Sophos;i="5.70,363,1574150400"; 
   d="scan'208";a="222918179"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jan 2020 14:07:07 -0800
Date:   Sat, 25 Jan 2020 14:07:06 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: [PATCH v16] x86/split_lock: Enable split lock detection by kernel
Message-ID: <20200125220706.GA18290@agluck-desk2.amr.corp.intel.com>
References: <20200122185514.GA16010@agluck-desk2.amr.corp.intel.com>
 <20200122224245.GA2331824@rani.riverdale.lan>
 <3908561D78D1C84285E8C5FCA982C28F7F54887A@ORSMSX114.amr.corp.intel.com>
 <20200123004507.GA2403906@rani.riverdale.lan>
 <20200123035359.GA23659@agluck-desk2.amr.corp.intel.com>
 <20200123044514.GA2453000@rani.riverdale.lan>
 <20200123231652.GA4457@agluck-desk2.amr.corp.intel.com>
 <87h80kmta4.fsf@nanos.tec.linutronix.de>
 <20200125024727.GA32483@agluck-desk2.amr.corp.intel.com>
 <875zgzmz5e.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875zgzmz5e.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Peter Zijlstra (Intel)" <peterz@infradead.org>

A split-lock occurs when an atomic instruction operates on data
that spans two cache lines. In order to maintain atomicity the
core takes a global bus lock.

This is typically >1000 cycles slower than an atomic operation
within a cache line. It also disrupts performance on other cores
(which must wait for the bus lock to be released before their
memory operations can complete). For real-time systems this may
mean missing deadlines. For other systems it may just be very
annoying.

Some CPUs have the capability to raise an #AC trap when a
split lock is attempted.

Provide a command line option to give the user choices on how
to handle this. split_lock_detect=
	off	- not enabled (no traps for split locks)
	warn	- warn once when an application does a
		  split lock, but allow it to continue
		  running.
	fatal	- Send SIGBUS to applications that cause split lock

On systems that support split lock detection the default is "warn". Note
that if the kernel hits a split lock in any mode other than "off" it
will OOPs.

One implementation wrinkle is that the MSR to control the
split lock detection is per-core, not per thread. This might
result in some short lived races on HT systems in "warn" mode
if Linux tries to enable on one thread while disabling on
the other. Race analysis by Sean Christopherson:

  - Toggling of split-lock is only done in "warn" mode.  Worst case
    scenario of a race is that a misbehaving task will generate multiple
    #AC exceptions on the same instruction.  And this race will only occur
    if both siblings are running tasks that generate split-lock #ACs, e.g.
    a race where sibling threads are writing different values will only
    occur if CPUx is disabling split-lock after an #AC and CPUy is
    re-enabling split-lock after *its* previous task generated an #AC.
  - Transitioning between modes at runtime isn't supported and disabling
    is tracked per task, so hardware will always reach a steady state that
    matches the configured mode.  I.e. split-lock is guaranteed to be
    enabled in hardware once all _TIF_SLD threads have been scheduled out.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Co-developed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---

V16:

Thomas: Rewrote the context switch as you suggested with XOR/AND
	to avoid the function call when TIF_SLD hasn't changed
Boris:	Fixed up all the bits from you comments (except the few
	that I listed in the reply to your e-mail). I think the
	only outstanding item is a followup patch to remove
	the duplicate match_option() inline function pasted from
	cpu/bugs.c ... we can bikeshed what to name it in another
	thread.

 .../admin-guide/kernel-parameters.txt         |  22 +++
 arch/x86/include/asm/cpu.h                    |  12 ++
 arch/x86/include/asm/cpufeatures.h            |   2 +
 arch/x86/include/asm/msr-index.h              |   9 +
 arch/x86/include/asm/thread_info.h            |   8 +-
 arch/x86/kernel/cpu/common.c                  |   2 +
 arch/x86/kernel/cpu/intel.c                   | 177 ++++++++++++++++++
 arch/x86/kernel/process.c                     |   3 +
 arch/x86/kernel/traps.c                       |  24 ++-
 9 files changed, 254 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 7f1e2f327e43..869afed16154 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4625,6 +4625,28 @@
 	spia_pedr=
 	spia_peddr=
 
+	split_lock_detect=
+			[X86] Enable split lock detection
+
+			When enabled (and if hardware support is present), atomic
+			instructions that access data across cache line
+			boundaries will result in an alignment check exception.
+
+			off	- not enabled
+
+			warn	- the kernel will emit rate limited warnings
+				  about applications triggering the #AC
+				  exception. This mode is the default on h/w
+				  that supports split lock detection.
+
+			fatal	- the kernel will send SIGBUS to applications
+				  that trigger the #AC exception.
+
+			If an #AC exception is hit in the kernel or in
+			firmware (i.e. not while executiing in user mode)
+			the the Linux will oops in either "warn" or "fatal"
+			mode.
+
 	srcutree.counter_wrap_check [KNL]
 			Specifies how frequently to check for
 			grace-period sequence counter wrap for the
diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index adc6cc86b062..ff6f3ca649b3 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -40,4 +40,16 @@ int mwait_usable(const struct cpuinfo_x86 *);
 unsigned int x86_family(unsigned int sig);
 unsigned int x86_model(unsigned int sig);
 unsigned int x86_stepping(unsigned int sig);
+#ifdef CONFIG_CPU_SUP_INTEL
+extern void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c);
+extern void switch_to_sld(unsigned long tifn);
+extern bool handle_user_split_lock(struct pt_regs *regs, long error_code);
+#else
+static inline void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c) {}
+static inline void switch_to_sld(unsigned long tifn) {}
+static inline bool handle_user_split_lock(struct pt_regs *regs, long error_code)
+{
+	return false;
+}
+#endif
 #endif /* _ASM_X86_CPU_H */
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index f3327cb56edf..cd56ad5d308e 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -285,6 +285,7 @@
 #define X86_FEATURE_CQM_MBM_LOCAL	(11*32+ 3) /* LLC Local MBM monitoring */
 #define X86_FEATURE_FENCE_SWAPGS_USER	(11*32+ 4) /* "" LFENCE in user entry SWAPGS path */
 #define X86_FEATURE_FENCE_SWAPGS_KERNEL	(11*32+ 5) /* "" LFENCE in kernel entry SWAPGS path */
+#define X86_FEATURE_SPLIT_LOCK_DETECT	(11*32+ 6) /* #AC for split lock */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
 #define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* AVX512 BFLOAT16 instructions */
@@ -367,6 +368,7 @@
 #define X86_FEATURE_INTEL_STIBP		(18*32+27) /* "" Single Thread Indirect Branch Predictors */
 #define X86_FEATURE_FLUSH_L1D		(18*32+28) /* Flush L1D cache */
 #define X86_FEATURE_ARCH_CAPABILITIES	(18*32+29) /* IA32_ARCH_CAPABILITIES MSR (Intel) */
+#define X86_FEATURE_CORE_CAPABILITIES	(18*32+30) /* "" IA32_CORE_CAPABILITIES MSR */
 #define X86_FEATURE_SPEC_CTRL_SSBD	(18*32+31) /* "" Speculative Store Bypass Disable */
 
 /*
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index ebe1685e92dd..8821697a7549 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -41,6 +41,10 @@
 
 /* Intel MSRs. Some also available on other CPUs */
 
+#define MSR_TEST_CTRL				0x00000033
+#define MSR_TEST_CTRL_SPLIT_LOCK_DETECT_BIT	29
+#define MSR_TEST_CTRL_SPLIT_LOCK_DETECT		BIT(MSR_TEST_CTRL_SPLIT_LOCK_DETECT_BIT)
+
 #define MSR_IA32_SPEC_CTRL		0x00000048 /* Speculation Control */
 #define SPEC_CTRL_IBRS			BIT(0)	   /* Indirect Branch Restricted Speculation */
 #define SPEC_CTRL_STIBP_SHIFT		1	   /* Single Thread Indirect Branch Predictor (STIBP) bit */
@@ -70,6 +74,11 @@
  */
 #define MSR_IA32_UMWAIT_CONTROL_TIME_MASK	(~0x03U)
 
+/* Abbreviated from Intel SDM name IA32_CORE_CAPABILITIES */
+#define MSR_IA32_CORE_CAPS			  0x000000cf
+#define MSR_IA32_CORE_CAPS_SPLIT_LOCK_DETECT_BIT  5
+#define MSR_IA32_CORE_CAPS_SPLIT_LOCK_DETECT	  BIT(MSR_IA32_CORE_CAPS_SPLIT_LOCK_DETECT_BIT)
+
 #define MSR_PKG_CST_CONFIG_CONTROL	0x000000e2
 #define NHM_C3_AUTO_DEMOTE		(1UL << 25)
 #define NHM_C1_AUTO_DEMOTE		(1UL << 26)
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index cf4327986e98..e399dcefc2a7 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -92,6 +92,7 @@ struct thread_info {
 #define TIF_NOCPUID		15	/* CPUID is not accessible in userland */
 #define TIF_NOTSC		16	/* TSC is not accessible in userland */
 #define TIF_IA32		17	/* IA32 compatibility process */
+#define TIF_SLD			18	/* Restore split lock detection on context switch */
 #define TIF_NOHZ		19	/* in adaptive nohz mode */
 #define TIF_MEMDIE		20	/* is terminating due to OOM killer */
 #define TIF_POLLING_NRFLAG	21	/* idle is polling for TIF_NEED_RESCHED */
@@ -122,6 +123,7 @@ struct thread_info {
 #define _TIF_NOCPUID		(1 << TIF_NOCPUID)
 #define _TIF_NOTSC		(1 << TIF_NOTSC)
 #define _TIF_IA32		(1 << TIF_IA32)
+#define _TIF_SLD		(1 << TIF_SLD)
 #define _TIF_NOHZ		(1 << TIF_NOHZ)
 #define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
 #define _TIF_IO_BITMAP		(1 << TIF_IO_BITMAP)
@@ -157,10 +159,10 @@ struct thread_info {
 #endif
 
 #ifdef CONFIG_X86_IOPL_IOPERM
-# define _TIF_WORK_CTXSW_PREV	(_TIF_WORK_CTXSW| _TIF_USER_RETURN_NOTIFY | \
-				 _TIF_IO_BITMAP)
+# define _TIF_WORK_CTXSW_PREV	(_TIF_WORK_CTXSW | _TIF_USER_RETURN_NOTIFY | \
+				 _TIF_IO_BITMAP | _TIF_SLD)
 #else
-# define _TIF_WORK_CTXSW_PREV	(_TIF_WORK_CTXSW| _TIF_USER_RETURN_NOTIFY)
+# define _TIF_WORK_CTXSW_PREV	(_TIF_WORK_CTXSW | _TIF_USER_RETURN_NOTIFY | _TIF_SLD)
 #endif
 
 #define _TIF_WORK_CTXSW_NEXT	(_TIF_WORK_CTXSW)
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 86b8241c8209..adb2f639f388 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1242,6 +1242,8 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 
 	cpu_set_bug_bits(c);
 
+	cpu_set_core_cap_bits(c);
+
 	fpu__init_system(c);
 
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 57473e2c0869..a84de224ffb0 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -19,6 +19,8 @@
 #include <asm/microcode_intel.h>
 #include <asm/hwcap2.h>
 #include <asm/elf.h>
+#include <asm/cpu_device_id.h>
+#include <asm/cmdline.h>
 
 #ifdef CONFIG_X86_64
 #include <linux/topology.h>
@@ -31,6 +33,19 @@
 #include <asm/apic.h>
 #endif
 
+enum split_lock_detect_state {
+	sld_off = 0,
+	sld_warn,
+	sld_fatal,
+};
+
+/*
+ * Default to sld_off because most systems do not support split lock detection
+ * split_lock_setup() will switch this to sld_warn on systems that support
+ * split lock detect, and then check to see if there is a command line override.
+ */
+static enum split_lock_detect_state sld_state = sld_off;
+
 /*
  * Just in case our CPU detection goes bad, or you have a weird system,
  * allow a way to override the automatic disabling of MPX.
@@ -606,6 +621,8 @@ static void init_intel_misc_features(struct cpuinfo_x86 *c)
 	wrmsrl(MSR_MISC_FEATURES_ENABLES, msr);
 }
 
+static void split_lock_init(void);
+
 static void init_intel(struct cpuinfo_x86 *c)
 {
 	early_init_intel(c);
@@ -720,6 +737,8 @@ static void init_intel(struct cpuinfo_x86 *c)
 		tsx_enable();
 	if (tsx_ctrl_state == TSX_CTRL_DISABLE)
 		tsx_disable();
+
+	split_lock_init();
 }
 
 #ifdef CONFIG_X86_32
@@ -981,3 +1000,161 @@ static const struct cpu_dev intel_cpu_dev = {
 };
 
 cpu_dev_register(intel_cpu_dev);
+
+#undef pr_fmt
+#define pr_fmt(fmt) "x86/split lock detection: " fmt
+
+static const struct {
+	const char			*option;
+	enum split_lock_detect_state	state;
+} sld_options[] __initconst = {
+	{ "off",	sld_off   },
+	{ "warn",	sld_warn  },
+	{ "fatal",	sld_fatal },
+};
+
+static inline bool match_option(const char *arg, int arglen, const char *opt)
+{
+	int len = strlen(opt);
+
+	return len == arglen && !strncmp(arg, opt, len);
+}
+
+static void __init split_lock_setup(void)
+{
+	char arg[20];
+	int i, ret;
+
+	sld_state = sld_warn;
+	setup_force_cpu_cap(X86_FEATURE_SPLIT_LOCK_DETECT);
+
+	ret = cmdline_find_option(boot_command_line, "split_lock_detect",
+				  arg, sizeof(arg));
+	if (ret < 0)
+		goto print;
+
+	for (i = 0; i < ARRAY_SIZE(sld_options); i++) {
+		if (match_option(arg, ret, sld_options[i].option)) {
+			sld_state = sld_options[i].state;
+			break;
+		}
+	}
+
+print:
+	switch (sld_state) {
+	case sld_off:
+		pr_info("disabled\n");
+		break;
+
+	case sld_warn:
+		pr_info("warning about user-space split_locks\n");
+		break;
+
+	case sld_fatal:
+		pr_info("sending SIGBUS on user-space split_locks\n");
+		break;
+	}
+}
+
+/*
+ * Locking is not required at the moment because only bit 29 of this
+ * MSR is implemented and locking would not prevent that the operation
+ * of one thread is immediately undone by the sibling thread.
+ * Use the "safe" versions of rdmsr/wrmsr here because although code
+ * checks CPUID and MSR bits to make sure the TEST_CTRL MSR should
+ * exist, there may be glitches in virtualization that leave a guest
+ * with an incorrect view of real h/w capabilities.
+ */
+static bool __sld_msr_set(bool on)
+{
+	u64 test_ctrl_val;
+
+	if (rdmsrl_safe(MSR_TEST_CTRL, &test_ctrl_val))
+		return false;
+
+	if (on)
+		test_ctrl_val |= MSR_TEST_CTRL_SPLIT_LOCK_DETECT;
+	else
+		test_ctrl_val &= ~MSR_TEST_CTRL_SPLIT_LOCK_DETECT;
+
+	return !wrmsrl_safe(MSR_TEST_CTRL, test_ctrl_val);
+}
+
+static void split_lock_init(void)
+{
+	if (sld_state == sld_off)
+		return;
+
+	if (__sld_msr_set(true))
+		return;
+
+	/*
+	 * If this is anything other than the boot-cpu, you've done
+	 * funny things and you get to keep whatever pieces.
+	 */
+	pr_warn("MSR fail -- disabled\n");
+	__sld_msr_set(sld_off);
+	sld_state = sld_off;
+}
+
+bool handle_user_split_lock(struct pt_regs *regs, long error_code)
+{
+	if ((regs->flags & X86_EFLAGS_AC) || sld_state == sld_fatal)
+		return false;
+
+	pr_warn_ratelimited("#AC: %s/%d took a split_lock trap at address: 0x%lx\n",
+			    current->comm, current->pid, regs->ip);
+
+	/*
+	 * Disable the split lock detection for this task so it can make
+	 * progress and set TIF_SLD so the detection is re-enabled via
+	 * switch_to_sld() when the task is scheduled out.
+	 */
+	__sld_msr_set(false);
+	set_tsk_thread_flag(current, TIF_SLD);
+	return true;
+}
+
+/*
+ * This function is called only when switching between tasks with
+ * different split-lock detection modes. It sets the MSR for the
+ * mode of the new task. This is right most of the time, but since
+ * the MSR is shared by hyperthreads on a physical core there can
+ * be glitches when the two threads need different modes.
+ */
+void switch_to_sld(unsigned long tifn)
+{
+	__sld_msr_set(tifn & _TIF_SLD);
+}
+
+#define SPLIT_LOCK_CPU(model) {X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY}
+
+/*
+ * The following processors have split lock detection feature. But since they
+ * don't have MSR IA32_CORE_CAPABILITIES, the feature cannot be enumerated by
+ * the MSR. So enumerate the feature by family and model on these processors.
+ */
+static const struct x86_cpu_id split_lock_cpu_ids[] __initconst = {
+	SPLIT_LOCK_CPU(INTEL_FAM6_ICELAKE_X),
+	SPLIT_LOCK_CPU(INTEL_FAM6_ICELAKE_L),
+	{}
+};
+
+void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c)
+{
+	u64 ia32_core_caps = 0;
+
+	if (c->x86_vendor != X86_VENDOR_INTEL)
+		return;
+	if (cpu_has(c, X86_FEATURE_CORE_CAPABILITIES)) {
+		/* Enumerate features reported in IA32_CORE_CAPABILITIES MSR. */
+		rdmsrl(MSR_IA32_CORE_CAPS, ia32_core_caps);
+	} else if (!boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
+		/* Enumerate split lock detection by family and model. */
+		if (x86_match_cpu(split_lock_cpu_ids))
+			ia32_core_caps |= MSR_IA32_CORE_CAPS_SPLIT_LOCK_DETECT;
+	}
+
+	if (ia32_core_caps & MSR_IA32_CORE_CAPS_SPLIT_LOCK_DETECT)
+		split_lock_setup();
+}
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 839b5244e3b7..a43c32868c3c 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -650,6 +650,9 @@ void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p)
 		/* Enforce MSR update to ensure consistent state */
 		__speculation_ctrl_update(~tifn, tifn);
 	}
+
+	if ((tifp ^ tifn) & _TIF_SLD)
+		switch_to_sld(tifn);
 }
 
 /*
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 9e6f822922a3..9f42f0a32185 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -46,6 +46,7 @@
 #include <asm/traps.h>
 #include <asm/desc.h>
 #include <asm/fpu/internal.h>
+#include <asm/cpu.h>
 #include <asm/cpu_entry_area.h>
 #include <asm/mce.h>
 #include <asm/fixmap.h>
@@ -244,7 +245,6 @@ do_trap(int trapnr, int signr, char *str, struct pt_regs *regs,
 {
 	struct task_struct *tsk = current;
 
-
 	if (!do_trap_no_signal(tsk, trapnr, str, regs, error_code))
 		return;
 
@@ -290,9 +290,29 @@ DO_ERROR(X86_TRAP_OLD_MF, SIGFPE,           0, NULL, "coprocessor segment overru
 DO_ERROR(X86_TRAP_TS,     SIGSEGV,          0, NULL, "invalid TSS",         invalid_TSS)
 DO_ERROR(X86_TRAP_NP,     SIGBUS,           0, NULL, "segment not present", segment_not_present)
 DO_ERROR(X86_TRAP_SS,     SIGBUS,           0, NULL, "stack segment",       stack_segment)
-DO_ERROR(X86_TRAP_AC,     SIGBUS,  BUS_ADRALN, NULL, "alignment check",     alignment_check)
 #undef IP
 
+dotraplinkage void do_alignment_check(struct pt_regs *regs, long error_code)
+{
+	char *str = "alignment check";
+
+	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
+
+	if (notify_die(DIE_TRAP, str, regs, error_code, X86_TRAP_AC, SIGBUS) == NOTIFY_STOP)
+		return;
+
+	if (!user_mode(regs))
+		die("Split lock detected\n", regs, error_code);
+
+	local_irq_enable();
+
+	if (handle_user_split_lock(regs, error_code))
+		return;
+
+	do_trap(X86_TRAP_AC, SIGBUS, "alignment check", regs,
+		error_code, BUS_ADRALN, NULL);
+}
+
 #ifdef CONFIG_VMAP_STACK
 __visible void __noreturn handle_stack_overflow(const char *message,
 						struct pt_regs *regs,
-- 
2.21.1

