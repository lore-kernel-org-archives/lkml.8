Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E90C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 18:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0040F2073E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 18:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbgFKSq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 14:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbgFKSq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 14:46:57 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A58C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 11:46:57 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jjSE0-0003q5-CO; Thu, 11 Jun 2020 20:46:52 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id CF80C100D0B;
        Thu, 11 Jun 2020 20:46:51 +0200 (CEST)
Date:   Thu, 11 Jun 2020 18:46:23 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/urgent for v5.8
References: <159190118210.28418.16838792857524354792.tglx@nanos.tec.linutronix.de>
Message-ID: <159190118331.28418.15784482710329781943.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2020-06-11

up to:  7778d8417b74: x86/vdso: Unbreak paravirt VDSO clocks

A set of fixes and updates for x86:

  - Unbreak paravirt VDSO clocks. While the VDSO code was moved into lib
    for sharing a subtle check for the validity of paravirt clocks got
    replaced. While the replacement works perfectly fine for bare metal as
    the update of the VDSO clock mode is synchronous, it fails for paravirt
    clocks because the hypervisor can invalidate them asynchronous. Bring
    it back as an optional function so it does not inflict this on
    architectures which are free of PV damage.

  - Fix the jiffies to jiffies64 mapping on 64bit so it does not trigger
    an ODR violation on newer compilers

  - Three fixes for the SSBD and *IB* speculation mitigation maze to ensure
    consistency, not disabling of some *IB* variants wrongly and to prevent
    a rogue cross process shutdown of SSBD. All marked for stable.

  - Add yet more CPU models to the splitlock detection capable list !@#%$!

  - Bring the pr_info() back which tells that TSC deadline timer is enabled.

  - Reboot quirk for MacBook6,1

Thanks,

	tglx

------------------>
Anthony Steinhauser (3):
      x86/speculation: Avoid force-disabling IBPB based on STIBP and enhanced IBRS.
      x86/speculation: Prevent rogue cross-process SSBD shutdown
      x86/speculation: PR_SPEC_FORCE_DISABLE enforcement for indirect branches.

Bob Haarman (1):
      x86_64: Fix jiffies ODR violation

Borislav Petkov (1):
      x86/apic: Make TSC deadline timer detection message visible

Fenghua Yu (1):
      x86/split_lock: Add Icelake microserver and Tigerlake CPU models

Hill Ma (1):
      x86/reboot/quirks: Add MacBook6,1 reboot quirk

Thomas Gleixner (3):
      clocksource: Remove obsolete ifdef
      lib/vdso: Provide sanity check for cycles (again)
      x86/vdso: Unbreak paravirt VDSO clocks

Tony Luck (1):
      x86/cpu: Add Sapphire Rapids CPU model number


 arch/x86/include/asm/intel-family.h      |  2 +
 arch/x86/include/asm/vdso/gettimeofday.h | 18 +++++++
 arch/x86/kernel/apic/apic.c              |  2 +-
 arch/x86/kernel/cpu/bugs.c               | 92 +++++++++++++++++++-------------
 arch/x86/kernel/cpu/intel.c              |  3 ++
 arch/x86/kernel/process.c                | 28 ++++------
 arch/x86/kernel/reboot.c                 |  8 +++
 arch/x86/kernel/time.c                   |  4 --
 arch/x86/kernel/vmlinux.lds.S            |  4 +-
 kernel/time/clocksource.c                |  2 -
 lib/vdso/gettimeofday.c                  | 11 ++++
 11 files changed, 109 insertions(+), 65 deletions(-)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 8f1e94f29a16..a338a6deb950 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -89,6 +89,8 @@
 #define INTEL_FAM6_COMETLAKE		0xA5
 #define INTEL_FAM6_COMETLAKE_L		0xA6
 
+#define INTEL_FAM6_SAPPHIRERAPIDS_X	0x8F
+
 /* "Small Core" Processors (Atom) */
 
 #define INTEL_FAM6_ATOM_BONNELL		0x1C /* Diamondville, Pineview */
diff --git a/arch/x86/include/asm/vdso/gettimeofday.h b/arch/x86/include/asm/vdso/gettimeofday.h
index 9a6dc9b4ec99..fb81fea99093 100644
--- a/arch/x86/include/asm/vdso/gettimeofday.h
+++ b/arch/x86/include/asm/vdso/gettimeofday.h
@@ -271,6 +271,24 @@ static __always_inline const struct vdso_data *__arch_get_vdso_data(void)
 	return __vdso_data;
 }
 
+static inline bool arch_vdso_clocksource_ok(const struct vdso_data *vd)
+{
+	return true;
+}
+#define vdso_clocksource_ok arch_vdso_clocksource_ok
+
+/*
+ * Clocksource read value validation to handle PV and HyperV clocksources
+ * which can be invalidated asynchronously and indicate invalidation by
+ * returning U64_MAX, which can be effectively tested by checking for a
+ * negative value after casting it to s64.
+ */
+static inline bool arch_vdso_cycles_ok(u64 cycles)
+{
+	return (s64)cycles >= 0;
+}
+#define vdso_cycles_ok arch_vdso_cycles_ok
+
 /*
  * x86 specific delta calculation.
  *
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index e53dda210cd7..21d2f1de1057 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2093,7 +2093,7 @@ void __init init_apic_mappings(void)
 	unsigned int new_apicid;
 
 	if (apic_validate_deadline_timer())
-		pr_debug("TSC deadline timer available\n");
+		pr_info("TSC deadline timer available\n");
 
 	if (x2apic_mode) {
 		boot_cpu_physical_apicid = read_apic_id();
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index ed54b3b21c39..56f573aa764f 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -495,7 +495,9 @@ early_param("nospectre_v1", nospectre_v1_cmdline);
 static enum spectre_v2_mitigation spectre_v2_enabled __ro_after_init =
 	SPECTRE_V2_NONE;
 
-static enum spectre_v2_user_mitigation spectre_v2_user __ro_after_init =
+static enum spectre_v2_user_mitigation spectre_v2_user_stibp __ro_after_init =
+	SPECTRE_V2_USER_NONE;
+static enum spectre_v2_user_mitigation spectre_v2_user_ibpb __ro_after_init =
 	SPECTRE_V2_USER_NONE;
 
 #ifdef CONFIG_RETPOLINE
@@ -641,15 +643,6 @@ spectre_v2_user_select_mitigation(enum spectre_v2_mitigation_cmd v2_cmd)
 		break;
 	}
 
-	/*
-	 * At this point, an STIBP mode other than "off" has been set.
-	 * If STIBP support is not being forced, check if STIBP always-on
-	 * is preferred.
-	 */
-	if (mode != SPECTRE_V2_USER_STRICT &&
-	    boot_cpu_has(X86_FEATURE_AMD_STIBP_ALWAYS_ON))
-		mode = SPECTRE_V2_USER_STRICT_PREFERRED;
-
 	/* Initialize Indirect Branch Prediction Barrier */
 	if (boot_cpu_has(X86_FEATURE_IBPB)) {
 		setup_force_cpu_cap(X86_FEATURE_USE_IBPB);
@@ -672,23 +665,36 @@ spectre_v2_user_select_mitigation(enum spectre_v2_mitigation_cmd v2_cmd)
 		pr_info("mitigation: Enabling %s Indirect Branch Prediction Barrier\n",
 			static_key_enabled(&switch_mm_always_ibpb) ?
 			"always-on" : "conditional");
+
+		spectre_v2_user_ibpb = mode;
 	}
 
-	/* If enhanced IBRS is enabled no STIBP required */
-	if (spectre_v2_enabled == SPECTRE_V2_IBRS_ENHANCED)
+	/*
+	 * If enhanced IBRS is enabled or SMT impossible, STIBP is not
+	 * required.
+	 */
+	if (!smt_possible || spectre_v2_enabled == SPECTRE_V2_IBRS_ENHANCED)
 		return;
 
 	/*
-	 * If SMT is not possible or STIBP is not available clear the STIBP
-	 * mode.
+	 * At this point, an STIBP mode other than "off" has been set.
+	 * If STIBP support is not being forced, check if STIBP always-on
+	 * is preferred.
 	 */
-	if (!smt_possible || !boot_cpu_has(X86_FEATURE_STIBP))
+	if (mode != SPECTRE_V2_USER_STRICT &&
+	    boot_cpu_has(X86_FEATURE_AMD_STIBP_ALWAYS_ON))
+		mode = SPECTRE_V2_USER_STRICT_PREFERRED;
+
+	/*
+	 * If STIBP is not available, clear the STIBP mode.
+	 */
+	if (!boot_cpu_has(X86_FEATURE_STIBP))
 		mode = SPECTRE_V2_USER_NONE;
+
+	spectre_v2_user_stibp = mode;
+
 set_mode:
-	spectre_v2_user = mode;
-	/* Only print the STIBP mode when SMT possible */
-	if (smt_possible)
-		pr_info("%s\n", spectre_v2_user_strings[mode]);
+	pr_info("%s\n", spectre_v2_user_strings[mode]);
 }
 
 static const char * const spectre_v2_strings[] = {
@@ -921,7 +927,7 @@ void cpu_bugs_smt_update(void)
 {
 	mutex_lock(&spec_ctrl_mutex);
 
-	switch (spectre_v2_user) {
+	switch (spectre_v2_user_stibp) {
 	case SPECTRE_V2_USER_NONE:
 		break;
 	case SPECTRE_V2_USER_STRICT:
@@ -1164,14 +1170,19 @@ static int ib_prctl_set(struct task_struct *task, unsigned long ctrl)
 {
 	switch (ctrl) {
 	case PR_SPEC_ENABLE:
-		if (spectre_v2_user == SPECTRE_V2_USER_NONE)
+		if (spectre_v2_user_ibpb == SPECTRE_V2_USER_NONE &&
+		    spectre_v2_user_stibp == SPECTRE_V2_USER_NONE)
 			return 0;
 		/*
 		 * Indirect branch speculation is always disabled in strict
-		 * mode.
+		 * mode. It can neither be enabled if it was force-disabled
+		 * by a  previous prctl call.
+
 		 */
-		if (spectre_v2_user == SPECTRE_V2_USER_STRICT ||
-		    spectre_v2_user == SPECTRE_V2_USER_STRICT_PREFERRED)
+		if (spectre_v2_user_ibpb == SPECTRE_V2_USER_STRICT ||
+		    spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT ||
+		    spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT_PREFERRED ||
+		    task_spec_ib_force_disable(task))
 			return -EPERM;
 		task_clear_spec_ib_disable(task);
 		task_update_spec_tif(task);
@@ -1182,10 +1193,12 @@ static int ib_prctl_set(struct task_struct *task, unsigned long ctrl)
 		 * Indirect branch speculation is always allowed when
 		 * mitigation is force disabled.
 		 */
-		if (spectre_v2_user == SPECTRE_V2_USER_NONE)
+		if (spectre_v2_user_ibpb == SPECTRE_V2_USER_NONE &&
+		    spectre_v2_user_stibp == SPECTRE_V2_USER_NONE)
 			return -EPERM;
-		if (spectre_v2_user == SPECTRE_V2_USER_STRICT ||
-		    spectre_v2_user == SPECTRE_V2_USER_STRICT_PREFERRED)
+		if (spectre_v2_user_ibpb == SPECTRE_V2_USER_STRICT ||
+		    spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT ||
+		    spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT_PREFERRED)
 			return 0;
 		task_set_spec_ib_disable(task);
 		if (ctrl == PR_SPEC_FORCE_DISABLE)
@@ -1216,7 +1229,8 @@ void arch_seccomp_spec_mitigate(struct task_struct *task)
 {
 	if (ssb_mode == SPEC_STORE_BYPASS_SECCOMP)
 		ssb_prctl_set(task, PR_SPEC_FORCE_DISABLE);
-	if (spectre_v2_user == SPECTRE_V2_USER_SECCOMP)
+	if (spectre_v2_user_ibpb == SPECTRE_V2_USER_SECCOMP ||
+	    spectre_v2_user_stibp == SPECTRE_V2_USER_SECCOMP)
 		ib_prctl_set(task, PR_SPEC_FORCE_DISABLE);
 }
 #endif
@@ -1247,22 +1261,24 @@ static int ib_prctl_get(struct task_struct *task)
 	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V2))
 		return PR_SPEC_NOT_AFFECTED;
 
-	switch (spectre_v2_user) {
-	case SPECTRE_V2_USER_NONE:
+	if (spectre_v2_user_ibpb == SPECTRE_V2_USER_NONE &&
+	    spectre_v2_user_stibp == SPECTRE_V2_USER_NONE)
 		return PR_SPEC_ENABLE;
-	case SPECTRE_V2_USER_PRCTL:
-	case SPECTRE_V2_USER_SECCOMP:
+	else if (spectre_v2_user_ibpb == SPECTRE_V2_USER_STRICT ||
+	    spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT ||
+	    spectre_v2_user_stibp == SPECTRE_V2_USER_STRICT_PREFERRED)
+		return PR_SPEC_DISABLE;
+	else if (spectre_v2_user_ibpb == SPECTRE_V2_USER_PRCTL ||
+	    spectre_v2_user_ibpb == SPECTRE_V2_USER_SECCOMP ||
+	    spectre_v2_user_stibp == SPECTRE_V2_USER_PRCTL ||
+	    spectre_v2_user_stibp == SPECTRE_V2_USER_SECCOMP) {
 		if (task_spec_ib_force_disable(task))
 			return PR_SPEC_PRCTL | PR_SPEC_FORCE_DISABLE;
 		if (task_spec_ib_disable(task))
 			return PR_SPEC_PRCTL | PR_SPEC_DISABLE;
 		return PR_SPEC_PRCTL | PR_SPEC_ENABLE;
-	case SPECTRE_V2_USER_STRICT:
-	case SPECTRE_V2_USER_STRICT_PREFERRED:
-		return PR_SPEC_DISABLE;
-	default:
+	} else
 		return PR_SPEC_NOT_AFFECTED;
-	}
 }
 
 int arch_prctl_spec_ctrl_get(struct task_struct *task, unsigned long which)
@@ -1501,7 +1517,7 @@ static char *stibp_state(void)
 	if (spectre_v2_enabled == SPECTRE_V2_IBRS_ENHANCED)
 		return "";
 
-	switch (spectre_v2_user) {
+	switch (spectre_v2_user_stibp) {
 	case SPECTRE_V2_USER_NONE:
 		return ", STIBP: disabled";
 	case SPECTRE_V2_USER_STRICT:
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index a19a680542ce..6abbcc774b82 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -1135,9 +1135,12 @@ void switch_to_sld(unsigned long tifn)
 static const struct x86_cpu_id split_lock_cpu_ids[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,		0),
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L,		0),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_D,		0),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT,	1),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	1),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_L,	1),
+	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L,		1),
+	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE,		1),
 	{}
 };
 
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 35638f1c5791..8f4533c1a4ec 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -545,28 +545,20 @@ static __always_inline void __speculation_ctrl_update(unsigned long tifp,
 
 	lockdep_assert_irqs_disabled();
 
-	/*
-	 * If TIF_SSBD is different, select the proper mitigation
-	 * method. Note that if SSBD mitigation is disabled or permanentely
-	 * enabled this branch can't be taken because nothing can set
-	 * TIF_SSBD.
-	 */
-	if (tif_diff & _TIF_SSBD) {
-		if (static_cpu_has(X86_FEATURE_VIRT_SSBD)) {
+	/* Handle change of TIF_SSBD depending on the mitigation method. */
+	if (static_cpu_has(X86_FEATURE_VIRT_SSBD)) {
+		if (tif_diff & _TIF_SSBD)
 			amd_set_ssb_virt_state(tifn);
-		} else if (static_cpu_has(X86_FEATURE_LS_CFG_SSBD)) {
+	} else if (static_cpu_has(X86_FEATURE_LS_CFG_SSBD)) {
+		if (tif_diff & _TIF_SSBD)
 			amd_set_core_ssb_state(tifn);
-		} else if (static_cpu_has(X86_FEATURE_SPEC_CTRL_SSBD) ||
-			   static_cpu_has(X86_FEATURE_AMD_SSBD)) {
-			msr |= ssbd_tif_to_spec_ctrl(tifn);
-			updmsr  = true;
-		}
+	} else if (static_cpu_has(X86_FEATURE_SPEC_CTRL_SSBD) ||
+		   static_cpu_has(X86_FEATURE_AMD_SSBD)) {
+		updmsr |= !!(tif_diff & _TIF_SSBD);
+		msr |= ssbd_tif_to_spec_ctrl(tifn);
 	}
 
-	/*
-	 * Only evaluate TIF_SPEC_IB if conditional STIBP is enabled,
-	 * otherwise avoid the MSR write.
-	 */
+	/* Only evaluate TIF_SPEC_IB if conditional STIBP is enabled. */
 	if (IS_ENABLED(CONFIG_SMP) &&
 	    static_branch_unlikely(&switch_to_cond_stibp)) {
 		updmsr |= !!(tif_diff & _TIF_SPEC_IB);
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 3ca43be4f9cf..8b8cebfd3298 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -197,6 +197,14 @@ static const struct dmi_system_id reboot_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "MacBook5"),
 		},
 	},
+	{	/* Handle problems with rebooting on Apple MacBook6,1 */
+		.callback = set_pci_reboot,
+		.ident = "Apple MacBook6,1",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "MacBook6,1"),
+		},
+	},
 	{	/* Handle problems with rebooting on Apple MacBookPro5 */
 		.callback = set_pci_reboot,
 		.ident = "Apple MacBookPro5",
diff --git a/arch/x86/kernel/time.c b/arch/x86/kernel/time.c
index 106e7f87f534..f39572982635 100644
--- a/arch/x86/kernel/time.c
+++ b/arch/x86/kernel/time.c
@@ -25,10 +25,6 @@
 #include <asm/hpet.h>
 #include <asm/time.h>
 
-#ifdef CONFIG_X86_64
-__visible volatile unsigned long jiffies __cacheline_aligned_in_smp = INITIAL_JIFFIES;
-#endif
-
 unsigned long profile_pc(struct pt_regs *regs)
 {
 	unsigned long pc = instruction_pointer(regs);
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 1bf7e312361f..7c35556c7827 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -40,13 +40,13 @@ OUTPUT_FORMAT(CONFIG_OUTPUT_FORMAT)
 #ifdef CONFIG_X86_32
 OUTPUT_ARCH(i386)
 ENTRY(phys_startup_32)
-jiffies = jiffies_64;
 #else
 OUTPUT_ARCH(i386:x86-64)
 ENTRY(phys_startup_64)
-jiffies_64 = jiffies;
 #endif
 
+jiffies = jiffies_64;
+
 #if defined(CONFIG_X86_64)
 /*
  * On 64-bit, align RODATA to 2MB so we retain large page mappings for
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 7cb09c4cf21c..02441ead3c3b 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -928,14 +928,12 @@ int __clocksource_register_scale(struct clocksource *cs, u32 scale, u32 freq)
 
 	clocksource_arch_init(cs);
 
-#ifdef CONFIG_GENERIC_VDSO_CLOCK_MODE
 	if (cs->vdso_clock_mode < 0 ||
 	    cs->vdso_clock_mode >= VDSO_CLOCKMODE_MAX) {
 		pr_warn("clocksource %s registered with invalid VDSO mode %d. Disabling VDSO support.\n",
 			cs->name, cs->vdso_clock_mode);
 		cs->vdso_clock_mode = VDSO_CLOCKMODE_NONE;
 	}
-#endif
 
 	/* Initialize mult/shift and max_idle_ns */
 	__clocksource_update_freq_scale(cs, scale, freq);
diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index a2909af4b924..3bb82a6cc5aa 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -38,6 +38,13 @@ static inline bool vdso_clocksource_ok(const struct vdso_data *vd)
 }
 #endif
 
+#ifndef vdso_cycles_ok
+static inline bool vdso_cycles_ok(u64 cycles)
+{
+	return true;
+}
+#endif
+
 #ifdef CONFIG_TIME_NS
 static int do_hres_timens(const struct vdso_data *vdns, clockid_t clk,
 			  struct __kernel_timespec *ts)
@@ -62,6 +69,8 @@ static int do_hres_timens(const struct vdso_data *vdns, clockid_t clk,
 			return -1;
 
 		cycles = __arch_get_hw_counter(vd->clock_mode);
+		if (unlikely(!vdso_cycles_ok(cycles)))
+			return -1;
 		ns = vdso_ts->nsec;
 		last = vd->cycle_last;
 		ns += vdso_calc_delta(cycles, last, vd->mask, vd->mult);
@@ -130,6 +139,8 @@ static __always_inline int do_hres(const struct vdso_data *vd, clockid_t clk,
 			return -1;
 
 		cycles = __arch_get_hw_counter(vd->clock_mode);
+		if (unlikely(!vdso_cycles_ok(cycles)))
+			return -1;
 		ns = vdso_ts->nsec;
 		last = vd->cycle_last;
 		ns += vdso_calc_delta(cycles, last, vd->mask, vd->mult);

