Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88D0C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 750D12468C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731672AbgANKRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:17:24 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42367 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732464AbgANKRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:17:06 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1irJFr-0007jH-IS; Tue, 14 Jan 2020 11:16:59 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 03F3E1C1931;
        Tue, 14 Jan 2020 11:16:56 +0100 (CET)
Date:   Tue, 14 Jan 2020 10:16:55 -0000
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/msr-index: Clean up bit defines for
 IA32_FEATURE_CONTROL MSR
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191221044513.21680-2-sean.j.christopherson@intel.com>
References: <20191221044513.21680-2-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Message-ID: <157899701582.1022.11191838421594151449.tip-bot2@tip-bot2>
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

Commit-ID:     32ad73db7fc5fe7eebafdab3b528f99ab8498e3f
Gitweb:        https://git.kernel.org/tip/32ad73db7fc5fe7eebafdab3b528f99ab8498e3f
Author:        Sean Christopherson <sean.j.christopherson@intel.com>
AuthorDate:    Fri, 20 Dec 2019 20:44:55 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 13 Jan 2020 17:23:08 +01:00

x86/msr-index: Clean up bit defines for IA32_FEATURE_CONTROL MSR

As pointed out by Boris, the defines for bits in IA32_FEATURE_CONTROL
are quite a mouthful, especially the VMX bits which must differentiate
between enabling VMX inside and outside SMX (TXT) operation.  Rename the
MSR and its bit defines to abbreviate FEATURE_CONTROL as FEAT_CTL to
make them a little friendlier on the eyes.

Arguably, the MSR itself should keep the full IA32_FEATURE_CONTROL name
to match Intel's SDM, but a future patch will add a dedicated Kconfig,
file and functions for the MSR. Using the full name for those assets is
rather unwieldy, so bite the bullet and use IA32_FEAT_CTL so that its
nomenclature is consistent throughout the kernel.

Opportunistically, fix a few other annoyances with the defines:

  - Relocate the bit defines so that they immediately follow the MSR
    define, e.g. aren't mistaken as belonging to MISC_FEATURE_CONTROL.
  - Add whitespace around the block of feature control defines to make
    it clear they're all related.
  - Use BIT() instead of manually encoding the bit shift.
  - Use "VMX" instead of "VMXON" to match the SDM.
  - Append "_ENABLED" to the LMCE (Local Machine Check Exception) bit to
    be consistent with the kernel's verbiage used for all other feature
    control bits.  Note, the SDM refers to the LMCE bit as LMCE_ON,
    likely to differentiate it from IA32_MCG_EXT_CTL.LMCE_EN.  Ignore
    the (literal) one-off usage of _ON, the SDM is simply "wrong".

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20191221044513.21680-2-sean.j.christopherson@intel.com
---
 arch/x86/include/asm/msr-index.h | 14 +++++----
 arch/x86/kernel/cpu/mce/intel.c  | 10 +++----
 arch/x86/kvm/vmx/nested.c        |  4 +--
 arch/x86/kvm/vmx/vmx.c           | 46 +++++++++++++++----------------
 arch/x86/kvm/vmx/vmx.h           |  2 +-
 arch/x86/kvm/x86.c               |  2 +-
 drivers/idle/intel_idle.c        |  2 +-
 7 files changed, 41 insertions(+), 39 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 084e98d..ebe1685 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -558,7 +558,14 @@
 #define MSR_IA32_EBL_CR_POWERON		0x0000002a
 #define MSR_EBC_FREQUENCY_ID		0x0000002c
 #define MSR_SMI_COUNT			0x00000034
-#define MSR_IA32_FEATURE_CONTROL        0x0000003a
+
+/* Referred to as IA32_FEATURE_CONTROL in Intel's SDM. */
+#define MSR_IA32_FEAT_CTL		0x0000003a
+#define FEAT_CTL_LOCKED				BIT(0)
+#define FEAT_CTL_VMX_ENABLED_INSIDE_SMX		BIT(1)
+#define FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX	BIT(2)
+#define FEAT_CTL_LMCE_ENABLED			BIT(20)
+
 #define MSR_IA32_TSC_ADJUST             0x0000003b
 #define MSR_IA32_BNDCFGS		0x00000d90
 
@@ -566,11 +573,6 @@
 
 #define MSR_IA32_XSS			0x00000da0
 
-#define FEATURE_CONTROL_LOCKED				(1<<0)
-#define FEATURE_CONTROL_VMXON_ENABLED_INSIDE_SMX	(1<<1)
-#define FEATURE_CONTROL_VMXON_ENABLED_OUTSIDE_SMX	(1<<2)
-#define FEATURE_CONTROL_LMCE				(1<<20)
-
 #define MSR_IA32_APICBASE		0x0000001b
 #define MSR_IA32_APICBASE_BSP		(1<<8)
 #define MSR_IA32_APICBASE_ENABLE	(1<<11)
diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index e270d07..c238518 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -115,12 +115,12 @@ static bool lmce_supported(void)
 
 	/*
 	 * BIOS should indicate support for LMCE by setting bit 20 in
-	 * IA32_FEATURE_CONTROL without which touching MCG_EXT_CTL will
-	 * generate a #GP fault.
+	 * IA32_FEAT_CTL without which touching MCG_EXT_CTL will generate a #GP
+	 * fault.
 	 */
-	rdmsrl(MSR_IA32_FEATURE_CONTROL, tmp);
-	if ((tmp & (FEATURE_CONTROL_LOCKED | FEATURE_CONTROL_LMCE)) ==
-		   (FEATURE_CONTROL_LOCKED | FEATURE_CONTROL_LMCE))
+	rdmsrl(MSR_IA32_FEAT_CTL, tmp);
+	if ((tmp & (FEAT_CTL_LOCKED | FEAT_CTL_LMCE_ENABLED)) ==
+		   (FEAT_CTL_LOCKED | FEAT_CTL_LMCE_ENABLED))
 		return true;
 
 	return false;
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 4aea7d3..6879966 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -4588,8 +4588,8 @@ static int handle_vmon(struct kvm_vcpu *vcpu)
 	gpa_t vmptr;
 	uint32_t revision;
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
-	const u64 VMXON_NEEDED_FEATURES = FEATURE_CONTROL_LOCKED
-		| FEATURE_CONTROL_VMXON_ENABLED_OUTSIDE_SMX;
+	const u64 VMXON_NEEDED_FEATURES = FEAT_CTL_LOCKED
+		| FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX;
 
 	/*
 	 * The Intel VMX Instruction Reference lists a bunch of bits that are
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index e3394c8..91b2517 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1839,11 +1839,11 @@ static int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_IA32_MCG_EXT_CTL:
 		if (!msr_info->host_initiated &&
 		    !(vmx->msr_ia32_feature_control &
-		      FEATURE_CONTROL_LMCE))
+		      FEAT_CTL_LMCE_ENABLED))
 			return 1;
 		msr_info->data = vcpu->arch.mcg_ext_ctl;
 		break;
-	case MSR_IA32_FEATURE_CONTROL:
+	case MSR_IA32_FEAT_CTL:
 		msr_info->data = vmx->msr_ia32_feature_control;
 		break;
 	case MSR_IA32_VMX_BASIC ... MSR_IA32_VMX_VMFUNC:
@@ -2074,15 +2074,15 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_IA32_MCG_EXT_CTL:
 		if ((!msr_info->host_initiated &&
 		     !(to_vmx(vcpu)->msr_ia32_feature_control &
-		       FEATURE_CONTROL_LMCE)) ||
+		       FEAT_CTL_LMCE_ENABLED)) ||
 		    (data & ~MCG_EXT_CTL_LMCE_EN))
 			return 1;
 		vcpu->arch.mcg_ext_ctl = data;
 		break;
-	case MSR_IA32_FEATURE_CONTROL:
+	case MSR_IA32_FEAT_CTL:
 		if (!vmx_feature_control_msr_valid(vcpu, data) ||
 		    (to_vmx(vcpu)->msr_ia32_feature_control &
-		     FEATURE_CONTROL_LOCKED && !msr_info->host_initiated))
+		     FEAT_CTL_LOCKED && !msr_info->host_initiated))
 			return 1;
 		vmx->msr_ia32_feature_control = data;
 		if (msr_info->host_initiated && data == 0)
@@ -2206,22 +2206,22 @@ static __init int vmx_disabled_by_bios(void)
 {
 	u64 msr;
 
-	rdmsrl(MSR_IA32_FEATURE_CONTROL, msr);
-	if (msr & FEATURE_CONTROL_LOCKED) {
+	rdmsrl(MSR_IA32_FEAT_CTL, msr);
+	if (msr & FEAT_CTL_LOCKED) {
 		/* launched w/ TXT and VMX disabled */
-		if (!(msr & FEATURE_CONTROL_VMXON_ENABLED_INSIDE_SMX)
+		if (!(msr & FEAT_CTL_VMX_ENABLED_INSIDE_SMX)
 			&& tboot_enabled())
 			return 1;
 		/* launched w/o TXT and VMX only enabled w/ TXT */
-		if (!(msr & FEATURE_CONTROL_VMXON_ENABLED_OUTSIDE_SMX)
-			&& (msr & FEATURE_CONTROL_VMXON_ENABLED_INSIDE_SMX)
+		if (!(msr & FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX)
+			&& (msr & FEAT_CTL_VMX_ENABLED_INSIDE_SMX)
 			&& !tboot_enabled()) {
 			printk(KERN_WARNING "kvm: disable TXT in the BIOS or "
 				"activate TXT before enabling KVM\n");
 			return 1;
 		}
 		/* launched w/o TXT and VMX disabled */
-		if (!(msr & FEATURE_CONTROL_VMXON_ENABLED_OUTSIDE_SMX)
+		if (!(msr & FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX)
 			&& !tboot_enabled())
 			return 1;
 	}
@@ -2269,16 +2269,16 @@ static int hardware_enable(void)
 	 */
 	crash_enable_local_vmclear(cpu);
 
-	rdmsrl(MSR_IA32_FEATURE_CONTROL, old);
+	rdmsrl(MSR_IA32_FEAT_CTL, old);
 
-	test_bits = FEATURE_CONTROL_LOCKED;
-	test_bits |= FEATURE_CONTROL_VMXON_ENABLED_OUTSIDE_SMX;
+	test_bits = FEAT_CTL_LOCKED;
+	test_bits |= FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX;
 	if (tboot_enabled())
-		test_bits |= FEATURE_CONTROL_VMXON_ENABLED_INSIDE_SMX;
+		test_bits |= FEAT_CTL_VMX_ENABLED_INSIDE_SMX;
 
 	if ((old & test_bits) != test_bits) {
 		/* enable and lock */
-		wrmsrl(MSR_IA32_FEATURE_CONTROL, old | test_bits);
+		wrmsrl(MSR_IA32_FEAT_CTL, old | test_bits);
 	}
 	kvm_cpu_vmxon(phys_addr);
 	if (enable_ept)
@@ -6801,7 +6801,7 @@ static struct kvm_vcpu *vmx_create_vcpu(struct kvm *kvm, unsigned int id)
 	vmx->nested.posted_intr_nv = -1;
 	vmx->nested.current_vmptr = -1ull;
 
-	vmx->msr_ia32_feature_control_valid_bits = FEATURE_CONTROL_LOCKED;
+	vmx->msr_ia32_feature_control_valid_bits = FEAT_CTL_LOCKED;
 
 	/*
 	 * Enforce invariant: pi_desc.nv is always either POSTED_INTR_VECTOR
@@ -7099,12 +7099,12 @@ static void vmx_cpuid_update(struct kvm_vcpu *vcpu)
 
 	if (nested_vmx_allowed(vcpu))
 		to_vmx(vcpu)->msr_ia32_feature_control_valid_bits |=
-			FEATURE_CONTROL_VMXON_ENABLED_INSIDE_SMX |
-			FEATURE_CONTROL_VMXON_ENABLED_OUTSIDE_SMX;
+			FEAT_CTL_VMX_ENABLED_INSIDE_SMX |
+			FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX;
 	else
 		to_vmx(vcpu)->msr_ia32_feature_control_valid_bits &=
-			~(FEATURE_CONTROL_VMXON_ENABLED_INSIDE_SMX |
-			  FEATURE_CONTROL_VMXON_ENABLED_OUTSIDE_SMX);
+			~(FEAT_CTL_VMX_ENABLED_INSIDE_SMX |
+			  FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX);
 
 	if (nested_vmx_allowed(vcpu)) {
 		nested_vmx_cr_fixed1_bits_update(vcpu);
@@ -7523,10 +7523,10 @@ static void vmx_setup_mce(struct kvm_vcpu *vcpu)
 {
 	if (vcpu->arch.mcg_cap & MCG_LMCE_P)
 		to_vmx(vcpu)->msr_ia32_feature_control_valid_bits |=
-			FEATURE_CONTROL_LMCE;
+			FEAT_CTL_LMCE_ENABLED;
 	else
 		to_vmx(vcpu)->msr_ia32_feature_control_valid_bits &=
-			~FEATURE_CONTROL_LMCE;
+			~FEAT_CTL_LMCE_ENABLED;
 }
 
 static int vmx_smi_allowed(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index a4f7f73..7f42cf3 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -289,7 +289,7 @@ struct vcpu_vmx {
 
 	/*
 	 * Only bits masked by msr_ia32_feature_control_valid_bits can be set in
-	 * msr_ia32_feature_control. FEATURE_CONTROL_LOCKED is always included
+	 * msr_ia32_feature_control. FEAT_CTL_LOCKED is always included
 	 * in msr_ia32_feature_control_valid_bits.
 	 */
 	u64 msr_ia32_feature_control;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index cf91713..740d3ee 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1142,7 +1142,7 @@ static const u32 msrs_to_save_all[] = {
 	MSR_CSTAR, MSR_KERNEL_GS_BASE, MSR_SYSCALL_MASK, MSR_LSTAR,
 #endif
 	MSR_IA32_TSC, MSR_IA32_CR_PAT, MSR_VM_HSAVE_PA,
-	MSR_IA32_FEATURE_CONTROL, MSR_IA32_BNDCFGS, MSR_TSC_AUX,
+	MSR_IA32_FEAT_CTL, MSR_IA32_BNDCFGS, MSR_TSC_AUX,
 	MSR_IA32_SPEC_CTRL,
 	MSR_IA32_RTIT_CTL, MSR_IA32_RTIT_STATUS, MSR_IA32_RTIT_CR3_MATCH,
 	MSR_IA32_RTIT_OUTPUT_BASE, MSR_IA32_RTIT_OUTPUT_MASK,
diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 75fd2a7..5a44cd8 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1284,7 +1284,7 @@ static void sklh_idle_state_table_update(void)
 	/* if SGX is present */
 	if (ebx & (1 << 2)) {
 
-		rdmsrl(MSR_IA32_FEATURE_CONTROL, msr);
+		rdmsrl(MSR_IA32_FEAT_CTL, msr);
 
 		/* if SGX is enabled */
 		if (msr & (1 << 18))
