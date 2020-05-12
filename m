Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E725C54E8D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 01:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5475420746
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 01:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbgELB6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 21:58:07 -0400
Received: from foss.arm.com ([217.140.110.172]:44464 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726874AbgELB6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 21:58:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 17A5B1FB;
        Mon, 11 May 2020 18:58:06 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.73.104])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5F9DE3F71E;
        Mon, 11 May 2020 18:58:02 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
Subject: [PATCH V3] arm64/cpufeature: Validate hypervisor capabilities during CPU hotplug
Date:   Tue, 12 May 2020 07:27:27 +0530
Message-Id: <1589248647-22925-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This validates hypervisor capabilities like VMID width, IPA range for any
hot plug CPU against system finalized values. KVM's view of the IPA space
is used while allowing a given CPU to come up. While here, it factors out
get_vmid_bits() for general use.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: kvmarm@lists.cs.columbia.edu
Cc: linux-kernel@vger.kernel.org

Reviewed-by: Marc Zyngier <maz@kernel.org>
Suggested-by: Suzuki Poulose <suzuki.poulose@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
Changes in V3:

- Dropped "#ifdef CONFIG_KVM_ARM_HOST" per Marc
- Dropped ID_AA64MMFR0_PARANGE_MASK (for now)
- Updated the commit message per Marc

Changes in V2: (https://patchwork.kernel.org/patch/11535359/)

- Added is_hyp_mode_available() check per Marc
- Moved verify_kvm_capabilities() into cpufeature.c per Marc
- Added helper get_kvm_ipa_limit() to fetch kvm_ipa_limit per Marc
- Renamed kvm as hyp including the commit message per Marc

Changes in V1: (https://patchwork.kernel.org/patch/11532565/)

 arch/arm64/include/asm/cpufeature.h | 18 ++++++++++++++++
 arch/arm64/include/asm/kvm_mmu.h    |  2 +-
 arch/arm64/kernel/cpufeature.c      | 33 +++++++++++++++++++++++++++++
 arch/arm64/kvm/reset.c              |  5 +++++
 4 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index afe08251ff95..1291ad5a9ccb 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -745,6 +745,24 @@ static inline bool cpu_has_hw_af(void)
 extern bool cpu_has_amu_feat(int cpu);
 #endif
 
+static inline unsigned int get_vmid_bits(u64 mmfr1)
+{
+	int vmid_bits;
+
+	vmid_bits = cpuid_feature_extract_unsigned_field(mmfr1,
+						ID_AA64MMFR1_VMIDBITS_SHIFT);
+	if (vmid_bits == ID_AA64MMFR1_VMIDBITS_16)
+		return 16;
+
+	/*
+	 * Return the default here even if any reserved
+	 * value is fetched from the system register.
+	 */
+	return 8;
+}
+
+u32 get_kvm_ipa_limit(void);
+
 #endif /* __ASSEMBLY__ */
 
 #endif
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 30b0e8d6b895..a7137e144b97 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -416,7 +416,7 @@ static inline unsigned int kvm_get_vmid_bits(void)
 {
 	int reg = read_sanitised_ftr_reg(SYS_ID_AA64MMFR1_EL1);
 
-	return (cpuid_feature_extract_unsigned_field(reg, ID_AA64MMFR1_VMIDBITS_SHIFT) == 2) ? 16 : 8;
+	return get_vmid_bits(reg);
 }
 
 /*
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 9fac745aa7bb..30917fe7942a 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2181,6 +2181,36 @@ static void verify_sve_features(void)
 	/* Add checks on other ZCR bits here if necessary */
 }
 
+#ifdef CONFIG_KVM_ARM_HOST
+void verify_hyp_capabilities(void)
+{
+	u64 safe_mmfr1, mmfr0, mmfr1;
+	int parange, ipa_max;
+	unsigned int safe_vmid_bits, vmid_bits;
+
+	safe_mmfr1 = read_sanitised_ftr_reg(SYS_ID_AA64MMFR1_EL1);
+	mmfr0 = read_cpuid(ID_AA64MMFR0_EL1);
+	mmfr1 = read_cpuid(ID_AA64MMFR1_EL1);
+
+	/* Verify VMID bits */
+	safe_vmid_bits = get_vmid_bits(safe_mmfr1);
+	vmid_bits = get_vmid_bits(mmfr1);
+	if (vmid_bits < safe_vmid_bits) {
+		pr_crit("CPU%d: VMID width mismatch\n", smp_processor_id());
+		cpu_die_early();
+	}
+
+	/* Verify IPA range */
+	parange = mmfr0 & 0x7;
+	ipa_max = id_aa64mmfr0_parange_to_phys_shift(parange);
+	if (ipa_max < get_kvm_ipa_limit()) {
+		pr_crit("CPU%d: IPA range mismatch\n", smp_processor_id());
+		cpu_die_early();
+	}
+}
+#else	/* !CONFIG_KVM_ARM_HOST */
+static inline void verify_hyp_capabilities(void) { }
+#endif	/* CONFIG_KVM_ARM_HOST */
 
 /*
  * Run through the enabled system capabilities and enable() it on this CPU.
@@ -2206,6 +2236,9 @@ static void verify_local_cpu_capabilities(void)
 
 	if (system_supports_sve())
 		verify_sve_features();
+
+	if (is_hyp_mode_available())
+		verify_hyp_capabilities();
 }
 
 void check_local_cpu_capabilities(void)
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index 30b7ea680f66..841b492ff334 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -340,6 +340,11 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 	return ret;
 }
 
+u32 get_kvm_ipa_limit(void)
+{
+	return kvm_ipa_limit;
+}
+
 void kvm_set_ipa_limit(void)
 {
 	unsigned int ipa_max, pa_max, va_max, parange;
-- 
2.20.1

