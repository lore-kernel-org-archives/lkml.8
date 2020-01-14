Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F918C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6F1520678
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731091AbgANKRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:17:44 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42356 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732372AbgANKRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:17:02 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1irJFq-0007iQ-Jt; Tue, 14 Jan 2020 11:16:58 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 41B231C192E;
        Tue, 14 Jan 2020 11:16:55 +0100 (CET)
Date:   Tue, 14 Jan 2020 10:16:55 -0000
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/intel: Initialize IA32_FEAT_CTL MSR at boot
Cc:     Borislav Petkov <bp@suse.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191221044513.21680-5-sean.j.christopherson@intel.com>
References: <20191221044513.21680-5-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Message-ID: <157899701511.1022.2964277695773063539.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     1db2a6e1e29ff994443a9eef7cf3d26104c777a7
Gitweb:        https://git.kernel.org/tip/1db2a6e1e29ff994443a9eef7cf3d26104c777a7
Author:        Sean Christopherson <sean.j.christopherson@intel.com>
AuthorDate:    Fri, 20 Dec 2019 20:44:58 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 13 Jan 2020 17:45:45 +01:00

x86/intel: Initialize IA32_FEAT_CTL MSR at boot

Opportunistically initialize IA32_FEAT_CTL to enable VMX when the MSR is
left unlocked by BIOS.  Configuring feature control at boot time paves
the way for similar enabling of other features, e.g. Software Guard
Extensions (SGX).

Temporarily leave equivalent KVM code in place in order to avoid
introducing a regression on Centaur and Zhaoxin CPUs, e.g. removing
KVM's code would leave the MSR unlocked on those CPUs and would break
existing functionality if people are loading kvm_intel on Centaur and/or
Zhaoxin.  Defer enablement of the boot-time configuration on Centaur and
Zhaoxin to future patches to aid bisection.

Note, Local Machine Check Exceptions (LMCE) are also supported by the
kernel and enabled via feature control, but the kernel currently uses
LMCE if and only if the feature is explicitly enabled by BIOS.  Keep
the current behavior to avoid introducing bugs, future patches can opt
in to opportunistic enabling if it's deemed desirable to do so.

Always lock IA32_FEAT_CTL if it exists, even if the CPU doesn't support
VMX, so that other existing and future kernel code that queries the MSR
can assume it's locked.

Start from a clean slate when constructing the value to write to
IA32_FEAT_CTL, i.e. ignore whatever value BIOS left in the MSR so as not
to enable random features or fault on the WRMSR.

Suggested-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20191221044513.21680-5-sean.j.christopherson@intel.com
---
 arch/x86/Kconfig.cpu           |  4 ++++-
 arch/x86/kernel/cpu/Makefile   |  1 +-
 arch/x86/kernel/cpu/cpu.h      |  4 ++++-
 arch/x86/kernel/cpu/feat_ctl.c | 37 +++++++++++++++++++++++++++++++++-
 arch/x86/kernel/cpu/intel.c    |  2 ++-
 5 files changed, 48 insertions(+)
 create mode 100644 arch/x86/kernel/cpu/feat_ctl.c

diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index af9c967..98be76f 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -387,6 +387,10 @@ config X86_DEBUGCTLMSR
 	def_bool y
 	depends on !(MK6 || MWINCHIPC6 || MWINCHIP3D || MCYRIXIII || M586MMX || M586TSC || M586 || M486SX || M486) && !UML
 
+config IA32_FEAT_CTL
+	def_bool y
+	depends on CPU_SUP_INTEL
+
 menuconfig PROCESSOR_SELECT
 	bool "Supported processor vendors" if EXPERT
 	---help---
diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index 890f600..57652c6 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -29,6 +29,7 @@ obj-y			+= umwait.o
 obj-$(CONFIG_PROC_FS)	+= proc.o
 obj-$(CONFIG_X86_FEATURE_NAMES) += capflags.o powerflags.o
 
+obj-$(CONFIG_IA32_FEAT_CTL) += feat_ctl.o
 ifdef CONFIG_CPU_SUP_INTEL
 obj-y			+= intel.o intel_pconfig.o tsx.o
 obj-$(CONFIG_PM)	+= intel_epb.o
diff --git a/arch/x86/kernel/cpu/cpu.h b/arch/x86/kernel/cpu/cpu.h
index 38ab6e1..37fdefd 100644
--- a/arch/x86/kernel/cpu/cpu.h
+++ b/arch/x86/kernel/cpu/cpu.h
@@ -80,4 +80,8 @@ extern void x86_spec_ctrl_setup_ap(void);
 
 extern u64 x86_read_arch_cap_msr(void);
 
+#ifdef CONFIG_IA32_FEAT_CTL
+void init_ia32_feat_ctl(struct cpuinfo_x86 *c);
+#endif
+
 #endif /* ARCH_X86_CPU_H */
diff --git a/arch/x86/kernel/cpu/feat_ctl.c b/arch/x86/kernel/cpu/feat_ctl.c
new file mode 100644
index 0000000..c4f8f76
--- /dev/null
+++ b/arch/x86/kernel/cpu/feat_ctl.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/tboot.h>
+
+#include <asm/cpufeature.h>
+#include <asm/msr-index.h>
+#include <asm/processor.h>
+
+void init_ia32_feat_ctl(struct cpuinfo_x86 *c)
+{
+	u64 msr;
+
+	if (rdmsrl_safe(MSR_IA32_FEAT_CTL, &msr))
+		return;
+
+	if (msr & FEAT_CTL_LOCKED)
+		return;
+
+	/*
+	 * Ignore whatever value BIOS left in the MSR to avoid enabling random
+	 * features or faulting on the WRMSR.
+	 */
+	msr = FEAT_CTL_LOCKED;
+
+	/*
+	 * Enable VMX if and only if the kernel may do VMXON at some point,
+	 * i.e. KVM is enabled, to avoid unnecessarily adding an attack vector
+	 * for the kernel, e.g. using VMX to hide malicious code.
+	 */
+	if (cpu_has(c, X86_FEATURE_VMX) && IS_ENABLED(CONFIG_KVM_INTEL)) {
+		msr |= FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX;
+
+		if (tboot_enabled())
+			msr |= FEAT_CTL_VMX_ENABLED_INSIDE_SMX;
+	}
+
+	wrmsrl(MSR_IA32_FEAT_CTL, msr);
+}
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 4a90080..9129c17 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -755,6 +755,8 @@ static void init_intel(struct cpuinfo_x86 *c)
 	/* Work around errata */
 	srat_detect_node(c);
 
+	init_ia32_feat_ctl(c);
+
 	if (cpu_has(c, X86_FEATURE_VMX))
 		detect_vmx_virtcap(c);
 
