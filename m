Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE68BC352A2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 07:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88B0520838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 07:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgBFHJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 02:09:45 -0500
Received: from mga04.intel.com ([192.55.52.120]:56103 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728028AbgBFHJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 02:09:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2020 23:09:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,408,1574150400"; 
   d="scan'208";a="231957288"
Received: from lxy-dell.sh.intel.com ([10.239.13.109])
  by orsmga003.jf.intel.com with ESMTP; 05 Feb 2020 23:09:37 -0800
From:   Xiaoyao Li <xiaoyao.li@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        hpa@zytor.com, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andy Lutomirski <luto@kernel.org>, tony.luck@intel.com
Cc:     peterz@infradead.org, fenghua.yu@intel.com, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH v3 7/8] kvm: x86: Emulate MSR IA32_CORE_CAPABILITIES
Date:   Thu,  6 Feb 2020 15:04:11 +0800
Message-Id: <20200206070412.17400-8-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200206070412.17400-1-xiaoyao.li@intel.com>
References: <20200206070412.17400-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Emulate MSR_IA32_CORE_CAPABILITIES in software and unconditionally
advertise its support to userspace. Like MSR_IA32_ARCH_CAPABILITIES, it
is a feature-enumerating MSR and can be fully emulated regardless of
hardware support. Existence of CORE_CAPABILITIES is enumerated via
CPUID.(EAX=7H,ECX=0):EDX[30].

Note, support for individual features enumerated via CORE_CAPABILITIES,
e.g., split lock detection, will be added in future patches.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/cpuid.c            |  5 +++--
 arch/x86/kvm/x86.c              | 22 ++++++++++++++++++++++
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 329d01c689b7..dc231240102f 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -591,6 +591,7 @@ struct kvm_vcpu_arch {
 	u64 ia32_xss;
 	u64 microcode_version;
 	u64 arch_capabilities;
+	u64 core_capabilities;
 
 	/*
 	 * Paging state of the vcpu
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index b1c469446b07..7282d04f3a6b 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -409,10 +409,11 @@ static inline void do_cpuid_7_mask(struct kvm_cpuid_entry2 *entry, int index)
 		    boot_cpu_has(X86_FEATURE_AMD_SSBD))
 			entry->edx |= F(SPEC_CTRL_SSBD);
 		/*
-		 * We emulate ARCH_CAPABILITIES in software even
-		 * if the host doesn't support it.
+		 * ARCH_CAPABILITIES and CORE_CAPABILITIES are emulated in
+		 * software regardless of host support.
 		 */
 		entry->edx |= F(ARCH_CAPABILITIES);
+		entry->edx |= F(CORE_CAPABILITIES);
 		break;
 	case 1:
 		entry->eax &= kvm_cpuid_7_1_eax_x86_features;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index fab4d25575bf..ed16644289a3 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1222,6 +1222,7 @@ static const u32 emulated_msrs_all[] = {
 	MSR_IA32_TSC_ADJUST,
 	MSR_IA32_TSCDEADLINE,
 	MSR_IA32_ARCH_CAPABILITIES,
+	MSR_IA32_CORE_CAPS,
 	MSR_IA32_MISC_ENABLE,
 	MSR_IA32_MCG_STATUS,
 	MSR_IA32_MCG_CTL,
@@ -1288,6 +1289,7 @@ static const u32 msr_based_features_all[] = {
 	MSR_F10H_DECFG,
 	MSR_IA32_UCODE_REV,
 	MSR_IA32_ARCH_CAPABILITIES,
+	MSR_IA32_CORE_CAPS,
 };
 
 static u32 msr_based_features[ARRAY_SIZE(msr_based_features_all)];
@@ -1341,12 +1343,20 @@ static u64 kvm_get_arch_capabilities(void)
 	return data;
 }
 
+static u64 kvm_get_core_capabilities(void)
+{
+	return 0;
+}
+
 static int kvm_get_msr_feature(struct kvm_msr_entry *msr)
 {
 	switch (msr->index) {
 	case MSR_IA32_ARCH_CAPABILITIES:
 		msr->data = kvm_get_arch_capabilities();
 		break;
+	case MSR_IA32_CORE_CAPS:
+		msr->data = kvm_get_core_capabilities();
+		break;
 	case MSR_IA32_UCODE_REV:
 		rdmsrl_safe(msr->index, &msr->data);
 		break;
@@ -2716,6 +2726,11 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			return 1;
 		vcpu->arch.arch_capabilities = data;
 		break;
+	case MSR_IA32_CORE_CAPS:
+		if (!msr_info->host_initiated)
+			return 1;
+		vcpu->arch.core_capabilities = data;
+		break;
 	case MSR_EFER:
 		return set_efer(vcpu, msr_info);
 	case MSR_K7_HWCR:
@@ -3044,6 +3059,12 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			return 1;
 		msr_info->data = vcpu->arch.arch_capabilities;
 		break;
+	case MSR_IA32_CORE_CAPS:
+		if (!msr_info->host_initiated &&
+		    !guest_cpuid_has(vcpu, X86_FEATURE_CORE_CAPABILITIES))
+			return 1;
+		msr_info->data = vcpu->arch.core_capabilities;
+		break;
 	case MSR_IA32_POWER_CTL:
 		msr_info->data = vcpu->arch.msr_ia32_power_ctl;
 		break;
@@ -9282,6 +9303,7 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 		goto free_guest_fpu;
 
 	vcpu->arch.arch_capabilities = kvm_get_arch_capabilities();
+	vcpu->arch.core_capabilities = kvm_get_core_capabilities();
 	vcpu->arch.msr_platform_info = MSR_PLATFORM_INFO_CPUID_FAULT;
 	kvm_vcpu_mtrr_init(vcpu);
 	vcpu_load(vcpu);
-- 
2.23.0

