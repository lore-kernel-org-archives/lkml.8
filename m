Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B771C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0298220678
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730004AbgANKRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:17:32 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42359 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732393AbgANKRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:17:03 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1irJFq-0007gk-WE; Tue, 14 Jan 2020 11:16:59 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9B2F01C1927;
        Tue, 14 Jan 2020 11:16:53 +0100 (CET)
Date:   Tue, 14 Jan 2020 10:16:53 -0000
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Detect VMX features on Intel, Centaur and
 Zhaoxin CPUs
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191221044513.21680-11-sean.j.christopherson@intel.com>
References: <20191221044513.21680-11-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Message-ID: <157899701345.1022.1254445437518147415.tip-bot2@tip-bot2>
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

Commit-ID:     b47ce1fed42eeb9ac8c07fcda6c795884826723d
Gitweb:        https://git.kernel.org/tip/b47ce1fed42eeb9ac8c07fcda6c795884826723d
Author:        Sean Christopherson <sean.j.christopherson@intel.com>
AuthorDate:    Fri, 20 Dec 2019 20:45:04 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 13 Jan 2020 18:02:53 +01:00

x86/cpu: Detect VMX features on Intel, Centaur and Zhaoxin CPUs

Add an entry in struct cpuinfo_x86 to track VMX capabilities and fill
the capabilities during IA32_FEAT_CTL MSR initialization.

Make the VMX capabilities dependent on IA32_FEAT_CTL and
X86_FEATURE_NAMES so as to avoid unnecessary overhead on CPUs that can't
possibly support VMX, or when /proc/cpuinfo is not available.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20191221044513.21680-11-sean.j.christopherson@intel.com
---
 arch/x86/Kconfig.cpu               |  4 ++-
 arch/x86/include/asm/processor.h   |  3 +-
 arch/x86/include/asm/vmxfeatures.h |  5 ++-
 arch/x86/kernel/cpu/common.c       |  3 +-
 arch/x86/kernel/cpu/feat_ctl.c     | 74 +++++++++++++++++++++++++++++-
 5 files changed, 89 insertions(+)

diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index 526425f..bc3a497 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -391,6 +391,10 @@ config IA32_FEAT_CTL
 	def_bool y
 	depends on CPU_SUP_INTEL || CPU_SUP_CENTAUR || CPU_SUP_ZHAOXIN
 
+config X86_VMX_FEATURE_NAMES
+	def_bool y
+	depends on IA32_FEAT_CTL && X86_FEATURE_NAMES
+
 menuconfig PROCESSOR_SELECT
 	bool "Supported processor vendors" if EXPERT
 	---help---
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index b49b88b..6fb4870 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -86,6 +86,9 @@ struct cpuinfo_x86 {
 	/* Number of 4K pages in DTLB/ITLB combined(in pages): */
 	int			x86_tlbsize;
 #endif
+#ifdef CONFIG_X86_VMX_FEATURE_NAMES
+	__u32			vmx_capability[NVMXINTS];
+#endif
 	__u8			x86_virt_bits;
 	__u8			x86_phys_bits;
 	/* CPUID returned core id bits: */
diff --git a/arch/x86/include/asm/vmxfeatures.h b/arch/x86/include/asm/vmxfeatures.h
index 4c743ba..0d04d8b 100644
--- a/arch/x86/include/asm/vmxfeatures.h
+++ b/arch/x86/include/asm/vmxfeatures.h
@@ -3,6 +3,11 @@
 #define _ASM_X86_VMXFEATURES_H
 
 /*
+ * Defines VMX CPU feature bits
+ */
+#define NVMXINTS			3 /* N 32-bit words worth of info */
+
+/*
  * Note: If the comment begins with a quoted string, that string is used
  * in /proc/cpuinfo instead of the macro name.  If the string is "",
  * this feature bit is not displayed in /proc/cpuinfo at all.
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 2e4d902..a5c526e 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1449,6 +1449,9 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 #endif
 	c->x86_cache_alignment = c->x86_clflush_size;
 	memset(&c->x86_capability, 0, sizeof(c->x86_capability));
+#ifdef CONFIG_X86_VMX_FEATURE_NAMES
+	memset(&c->vmx_capability, 0, sizeof(c->vmx_capability));
+#endif
 
 	generic_identify(c);
 
diff --git a/arch/x86/kernel/cpu/feat_ctl.c b/arch/x86/kernel/cpu/feat_ctl.c
index a46c9e4..cbd8bfe 100644
--- a/arch/x86/kernel/cpu/feat_ctl.c
+++ b/arch/x86/kernel/cpu/feat_ctl.c
@@ -4,10 +4,80 @@
 #include <asm/cpufeature.h>
 #include <asm/msr-index.h>
 #include <asm/processor.h>
+#include <asm/vmx.h>
 
 #undef pr_fmt
 #define pr_fmt(fmt)	"x86/cpu: " fmt
 
+#ifdef CONFIG_X86_VMX_FEATURE_NAMES
+enum vmx_feature_leafs {
+	MISC_FEATURES = 0,
+	PRIMARY_CTLS,
+	SECONDARY_CTLS,
+	NR_VMX_FEATURE_WORDS,
+};
+
+#define VMX_F(x) BIT(VMX_FEATURE_##x & 0x1f)
+
+static void init_vmx_capabilities(struct cpuinfo_x86 *c)
+{
+	u32 supported, funcs, ept, vpid, ign;
+
+	BUILD_BUG_ON(NVMXINTS != NR_VMX_FEATURE_WORDS);
+
+	/*
+	 * The high bits contain the allowed-1 settings, i.e. features that can
+	 * be turned on.  The low bits contain the allowed-0 settings, i.e.
+	 * features that can be turned off.  Ignore the allowed-0 settings,
+	 * if a feature can be turned on then it's supported.
+	 *
+	 * Use raw rdmsr() for primary processor controls and pin controls MSRs
+	 * as they exist on any CPU that supports VMX, i.e. we want the WARN if
+	 * the RDMSR faults.
+	 */
+	rdmsr(MSR_IA32_VMX_PROCBASED_CTLS, ign, supported);
+	c->vmx_capability[PRIMARY_CTLS] = supported;
+
+	rdmsr_safe(MSR_IA32_VMX_PROCBASED_CTLS2, &ign, &supported);
+	c->vmx_capability[SECONDARY_CTLS] = supported;
+
+	rdmsr(MSR_IA32_VMX_PINBASED_CTLS, ign, supported);
+	rdmsr_safe(MSR_IA32_VMX_VMFUNC, &ign, &funcs);
+
+	/*
+	 * Except for EPT+VPID, which enumerates support for both in a single
+	 * MSR, low for EPT, high for VPID.
+	 */
+	rdmsr_safe(MSR_IA32_VMX_EPT_VPID_CAP, &ept, &vpid);
+
+	/* Pin, EPT, VPID and VM-Func are merged into a single word. */
+	WARN_ON_ONCE(supported >> 16);
+	WARN_ON_ONCE(funcs >> 4);
+	c->vmx_capability[MISC_FEATURES] = (supported & 0xffff) |
+					   ((vpid & 0x1) << 16) |
+					   ((funcs & 0xf) << 28);
+
+	/* EPT bits are full on scattered and must be manually handled. */
+	if (ept & VMX_EPT_EXECUTE_ONLY_BIT)
+		c->vmx_capability[MISC_FEATURES] |= VMX_F(EPT_EXECUTE_ONLY);
+	if (ept & VMX_EPT_AD_BIT)
+		c->vmx_capability[MISC_FEATURES] |= VMX_F(EPT_AD);
+	if (ept & VMX_EPT_1GB_PAGE_BIT)
+		c->vmx_capability[MISC_FEATURES] |= VMX_F(EPT_1GB);
+
+	/* Synthetic APIC features that are aggregates of multiple features. */
+	if ((c->vmx_capability[PRIMARY_CTLS] & VMX_F(VIRTUAL_TPR)) &&
+	    (c->vmx_capability[SECONDARY_CTLS] & VMX_F(VIRT_APIC_ACCESSES)))
+		c->vmx_capability[MISC_FEATURES] |= VMX_F(FLEXPRIORITY);
+
+	if ((c->vmx_capability[PRIMARY_CTLS] & VMX_F(VIRTUAL_TPR)) &&
+	    (c->vmx_capability[SECONDARY_CTLS] & VMX_F(APIC_REGISTER_VIRT)) &&
+	    (c->vmx_capability[SECONDARY_CTLS] & VMX_F(VIRT_INTR_DELIVERY)) &&
+	    (c->vmx_capability[MISC_FEATURES] & VMX_F(POSTED_INTR)))
+		c->vmx_capability[MISC_FEATURES] |= VMX_F(APICV);
+}
+#endif /* CONFIG_X86_VMX_FEATURE_NAMES */
+
 void init_ia32_feat_ctl(struct cpuinfo_x86 *c)
 {
 	bool tboot = tboot_enabled();
@@ -50,5 +120,9 @@ update_caps:
 		pr_err_once("VMX (%s TXT) disabled by BIOS\n",
 			    tboot ? "inside" : "outside");
 		clear_cpu_cap(c, X86_FEATURE_VMX);
+	} else {
+#ifdef CONFIG_X86_VMX_FEATURE_NAMES
+		init_vmx_capabilities(c);
+#endif
 	}
 }
