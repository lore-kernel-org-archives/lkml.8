Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25228C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4C7B20678
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729361AbgANKRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:17:39 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42355 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732273AbgANKRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:17:02 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1irJFq-0007gR-Bj; Tue, 14 Jan 2020 11:16:58 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 115BE1C03A9;
        Tue, 14 Jan 2020 11:16:53 +0100 (CET)
Date:   Tue, 14 Jan 2020 10:16:52 -0000
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Set synthetic VMX cpufeatures during
 init_ia32_feat_ctl()
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191221044513.21680-13-sean.j.christopherson@intel.com>
References: <20191221044513.21680-13-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Message-ID: <157899701284.1022.4425607244827344075.tip-bot2@tip-bot2>
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

Commit-ID:     167a4894c113ebe6a1f8b24fa6f9fca849c77f8a
Gitweb:        https://git.kernel.org/tip/167a4894c113ebe6a1f8b24fa6f9fca849c77f8a
Author:        Sean Christopherson <sean.j.christopherson@intel.com>
AuthorDate:    Fri, 20 Dec 2019 20:45:06 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 13 Jan 2020 18:43:19 +01:00

x86/cpu: Set synthetic VMX cpufeatures during init_ia32_feat_ctl()

Set the synthetic VMX cpufeatures, which need to be kept to preserve
/proc/cpuinfo's ABI, in the common IA32_FEAT_CTL initialization code.
Remove the vendor code that manually sets the synthetic flags.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20191221044513.21680-13-sean.j.christopherson@intel.com
---
 arch/x86/kernel/cpu/centaur.c  | 35 +------------------------
 arch/x86/kernel/cpu/feat_ctl.c | 14 +++++++++-
 arch/x86/kernel/cpu/intel.c    | 49 +---------------------------------
 arch/x86/kernel/cpu/zhaoxin.c  | 35 +------------------------
 4 files changed, 14 insertions(+), 119 deletions(-)

diff --git a/arch/x86/kernel/cpu/centaur.c b/arch/x86/kernel/cpu/centaur.c
index 084f604..02d99fe 100644
--- a/arch/x86/kernel/cpu/centaur.c
+++ b/arch/x86/kernel/cpu/centaur.c
@@ -18,13 +18,6 @@
 #define RNG_ENABLED	(1 << 3)
 #define RNG_ENABLE	(1 << 6)	/* MSR_VIA_RNG */
 
-#define X86_VMX_FEATURE_PROC_CTLS_TPR_SHADOW	0x00200000
-#define X86_VMX_FEATURE_PROC_CTLS_VNMI		0x00400000
-#define X86_VMX_FEATURE_PROC_CTLS_2ND_CTLS	0x80000000
-#define X86_VMX_FEATURE_PROC_CTLS2_VIRT_APIC	0x00000001
-#define X86_VMX_FEATURE_PROC_CTLS2_EPT		0x00000002
-#define X86_VMX_FEATURE_PROC_CTLS2_VPID		0x00000020
-
 static void init_c3(struct cpuinfo_x86 *c)
 {
 	u32  lo, hi;
@@ -119,31 +112,6 @@ static void early_init_centaur(struct cpuinfo_x86 *c)
 	}
 }
 
-static void centaur_detect_vmx_virtcap(struct cpuinfo_x86 *c)
-{
-	u32 vmx_msr_low, vmx_msr_high, msr_ctl, msr_ctl2;
-
-	rdmsr(MSR_IA32_VMX_PROCBASED_CTLS, vmx_msr_low, vmx_msr_high);
-	msr_ctl = vmx_msr_high | vmx_msr_low;
-
-	if (msr_ctl & X86_VMX_FEATURE_PROC_CTLS_TPR_SHADOW)
-		set_cpu_cap(c, X86_FEATURE_TPR_SHADOW);
-	if (msr_ctl & X86_VMX_FEATURE_PROC_CTLS_VNMI)
-		set_cpu_cap(c, X86_FEATURE_VNMI);
-	if (msr_ctl & X86_VMX_FEATURE_PROC_CTLS_2ND_CTLS) {
-		rdmsr(MSR_IA32_VMX_PROCBASED_CTLS2,
-		      vmx_msr_low, vmx_msr_high);
-		msr_ctl2 = vmx_msr_high | vmx_msr_low;
-		if ((msr_ctl2 & X86_VMX_FEATURE_PROC_CTLS2_VIRT_APIC) &&
-		    (msr_ctl & X86_VMX_FEATURE_PROC_CTLS_TPR_SHADOW))
-			set_cpu_cap(c, X86_FEATURE_FLEXPRIORITY);
-		if (msr_ctl2 & X86_VMX_FEATURE_PROC_CTLS2_EPT)
-			set_cpu_cap(c, X86_FEATURE_EPT);
-		if (msr_ctl2 & X86_VMX_FEATURE_PROC_CTLS2_VPID)
-			set_cpu_cap(c, X86_FEATURE_VPID);
-	}
-}
-
 static void init_centaur(struct cpuinfo_x86 *c)
 {
 #ifdef CONFIG_X86_32
@@ -251,9 +219,6 @@ static void init_centaur(struct cpuinfo_x86 *c)
 #endif
 
 	init_ia32_feat_ctl(c);
-
-	if (cpu_has(c, X86_FEATURE_VMX))
-		centaur_detect_vmx_virtcap(c);
 }
 
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/kernel/cpu/feat_ctl.c b/arch/x86/kernel/cpu/feat_ctl.c
index cbd8bfe..fcbb355 100644
--- a/arch/x86/kernel/cpu/feat_ctl.c
+++ b/arch/x86/kernel/cpu/feat_ctl.c
@@ -75,6 +75,20 @@ static void init_vmx_capabilities(struct cpuinfo_x86 *c)
 	    (c->vmx_capability[SECONDARY_CTLS] & VMX_F(VIRT_INTR_DELIVERY)) &&
 	    (c->vmx_capability[MISC_FEATURES] & VMX_F(POSTED_INTR)))
 		c->vmx_capability[MISC_FEATURES] |= VMX_F(APICV);
+
+	/* Set the synthetic cpufeatures to preserve /proc/cpuinfo's ABI. */
+	if (c->vmx_capability[PRIMARY_CTLS] & VMX_F(VIRTUAL_TPR))
+		set_cpu_cap(c, X86_FEATURE_TPR_SHADOW);
+	if (c->vmx_capability[MISC_FEATURES] & VMX_F(FLEXPRIORITY))
+		set_cpu_cap(c, X86_FEATURE_FLEXPRIORITY);
+	if (c->vmx_capability[MISC_FEATURES] & VMX_F(VIRTUAL_NMIS))
+		set_cpu_cap(c, X86_FEATURE_VNMI);
+	if (c->vmx_capability[SECONDARY_CTLS] & VMX_F(EPT))
+		set_cpu_cap(c, X86_FEATURE_EPT);
+	if (c->vmx_capability[MISC_FEATURES] & VMX_F(EPT_AD))
+		set_cpu_cap(c, X86_FEATURE_EPT_AD);
+	if (c->vmx_capability[MISC_FEATURES] & VMX_F(VPID))
+		set_cpu_cap(c, X86_FEATURE_VPID);
 }
 #endif /* CONFIG_X86_VMX_FEATURE_NAMES */
 
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 9129c17..57473e2 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -494,52 +494,6 @@ static void srat_detect_node(struct cpuinfo_x86 *c)
 #endif
 }
 
-static void detect_vmx_virtcap(struct cpuinfo_x86 *c)
-{
-	/* Intel VMX MSR indicated features */
-#define X86_VMX_FEATURE_PROC_CTLS_TPR_SHADOW	0x00200000
-#define X86_VMX_FEATURE_PROC_CTLS_VNMI		0x00400000
-#define X86_VMX_FEATURE_PROC_CTLS_2ND_CTLS	0x80000000
-#define X86_VMX_FEATURE_PROC_CTLS2_VIRT_APIC	0x00000001
-#define X86_VMX_FEATURE_PROC_CTLS2_EPT		0x00000002
-#define X86_VMX_FEATURE_PROC_CTLS2_VPID		0x00000020
-#define x86_VMX_FEATURE_EPT_CAP_AD		0x00200000
-
-	u32 vmx_msr_low, vmx_msr_high, msr_ctl, msr_ctl2;
-	u32 msr_vpid_cap, msr_ept_cap;
-
-	clear_cpu_cap(c, X86_FEATURE_TPR_SHADOW);
-	clear_cpu_cap(c, X86_FEATURE_VNMI);
-	clear_cpu_cap(c, X86_FEATURE_FLEXPRIORITY);
-	clear_cpu_cap(c, X86_FEATURE_EPT);
-	clear_cpu_cap(c, X86_FEATURE_VPID);
-	clear_cpu_cap(c, X86_FEATURE_EPT_AD);
-
-	rdmsr(MSR_IA32_VMX_PROCBASED_CTLS, vmx_msr_low, vmx_msr_high);
-	msr_ctl = vmx_msr_high | vmx_msr_low;
-	if (msr_ctl & X86_VMX_FEATURE_PROC_CTLS_TPR_SHADOW)
-		set_cpu_cap(c, X86_FEATURE_TPR_SHADOW);
-	if (msr_ctl & X86_VMX_FEATURE_PROC_CTLS_VNMI)
-		set_cpu_cap(c, X86_FEATURE_VNMI);
-	if (msr_ctl & X86_VMX_FEATURE_PROC_CTLS_2ND_CTLS) {
-		rdmsr(MSR_IA32_VMX_PROCBASED_CTLS2,
-		      vmx_msr_low, vmx_msr_high);
-		msr_ctl2 = vmx_msr_high | vmx_msr_low;
-		if ((msr_ctl2 & X86_VMX_FEATURE_PROC_CTLS2_VIRT_APIC) &&
-		    (msr_ctl & X86_VMX_FEATURE_PROC_CTLS_TPR_SHADOW))
-			set_cpu_cap(c, X86_FEATURE_FLEXPRIORITY);
-		if (msr_ctl2 & X86_VMX_FEATURE_PROC_CTLS2_EPT) {
-			set_cpu_cap(c, X86_FEATURE_EPT);
-			rdmsr(MSR_IA32_VMX_EPT_VPID_CAP,
-			      msr_ept_cap, msr_vpid_cap);
-			if (msr_ept_cap & x86_VMX_FEATURE_EPT_CAP_AD)
-				set_cpu_cap(c, X86_FEATURE_EPT_AD);
-		}
-		if (msr_ctl2 & X86_VMX_FEATURE_PROC_CTLS2_VPID)
-			set_cpu_cap(c, X86_FEATURE_VPID);
-	}
-}
-
 #define MSR_IA32_TME_ACTIVATE		0x982
 
 /* Helpers to access TME_ACTIVATE MSR */
@@ -757,9 +711,6 @@ static void init_intel(struct cpuinfo_x86 *c)
 
 	init_ia32_feat_ctl(c);
 
-	if (cpu_has(c, X86_FEATURE_VMX))
-		detect_vmx_virtcap(c);
-
 	if (cpu_has(c, X86_FEATURE_TME))
 		detect_tme(c);
 
diff --git a/arch/x86/kernel/cpu/zhaoxin.c b/arch/x86/kernel/cpu/zhaoxin.c
index 630a145..6b2d3b0 100644
--- a/arch/x86/kernel/cpu/zhaoxin.c
+++ b/arch/x86/kernel/cpu/zhaoxin.c
@@ -16,13 +16,6 @@
 #define RNG_ENABLED	(1 << 3)
 #define RNG_ENABLE	(1 << 8)	/* MSR_ZHAOXIN_RNG */
 
-#define X86_VMX_FEATURE_PROC_CTLS_TPR_SHADOW	0x00200000
-#define X86_VMX_FEATURE_PROC_CTLS_VNMI		0x00400000
-#define X86_VMX_FEATURE_PROC_CTLS_2ND_CTLS	0x80000000
-#define X86_VMX_FEATURE_PROC_CTLS2_VIRT_APIC	0x00000001
-#define X86_VMX_FEATURE_PROC_CTLS2_EPT		0x00000002
-#define X86_VMX_FEATURE_PROC_CTLS2_VPID		0x00000020
-
 static void init_zhaoxin_cap(struct cpuinfo_x86 *c)
 {
 	u32  lo, hi;
@@ -89,31 +82,6 @@ static void early_init_zhaoxin(struct cpuinfo_x86 *c)
 
 }
 
-static void zhaoxin_detect_vmx_virtcap(struct cpuinfo_x86 *c)
-{
-	u32 vmx_msr_low, vmx_msr_high, msr_ctl, msr_ctl2;
-
-	rdmsr(MSR_IA32_VMX_PROCBASED_CTLS, vmx_msr_low, vmx_msr_high);
-	msr_ctl = vmx_msr_high | vmx_msr_low;
-
-	if (msr_ctl & X86_VMX_FEATURE_PROC_CTLS_TPR_SHADOW)
-		set_cpu_cap(c, X86_FEATURE_TPR_SHADOW);
-	if (msr_ctl & X86_VMX_FEATURE_PROC_CTLS_VNMI)
-		set_cpu_cap(c, X86_FEATURE_VNMI);
-	if (msr_ctl & X86_VMX_FEATURE_PROC_CTLS_2ND_CTLS) {
-		rdmsr(MSR_IA32_VMX_PROCBASED_CTLS2,
-		      vmx_msr_low, vmx_msr_high);
-		msr_ctl2 = vmx_msr_high | vmx_msr_low;
-		if ((msr_ctl2 & X86_VMX_FEATURE_PROC_CTLS2_VIRT_APIC) &&
-		    (msr_ctl & X86_VMX_FEATURE_PROC_CTLS_TPR_SHADOW))
-			set_cpu_cap(c, X86_FEATURE_FLEXPRIORITY);
-		if (msr_ctl2 & X86_VMX_FEATURE_PROC_CTLS2_EPT)
-			set_cpu_cap(c, X86_FEATURE_EPT);
-		if (msr_ctl2 & X86_VMX_FEATURE_PROC_CTLS2_VPID)
-			set_cpu_cap(c, X86_FEATURE_VPID);
-	}
-}
-
 static void init_zhaoxin(struct cpuinfo_x86 *c)
 {
 	early_init_zhaoxin(c);
@@ -142,9 +110,6 @@ static void init_zhaoxin(struct cpuinfo_x86 *c)
 #endif
 
 	init_ia32_feat_ctl(c);
-
-	if (cpu_has(c, X86_FEATURE_VMX))
-		zhaoxin_detect_vmx_virtcap(c);
 }
 
 #ifdef CONFIG_X86_32
