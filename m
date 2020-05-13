Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA32CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F53320753
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732414AbgEMJEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 05:04:42 -0400
Received: from foss.arm.com ([217.140.110.172]:40692 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730617AbgEMJEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 05:04:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57D351FB;
        Wed, 13 May 2020 02:04:41 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.73.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B7BE93F305;
        Wed, 13 May 2020 02:04:37 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     mark.rutland@arm.com,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
Subject: [PATCH V2] arm64/cpufeature: Drop open encodings while extracting parange
Date:   Wed, 13 May 2020 14:33:34 +0530
Message-Id: <1589360614-1164-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there are multiple instances of parange feature width mask open
encodings while fetching it's value. Even the width mask value (0x7) itself
is not accurate. It should be (0xf) per ID_AA64MMFR0_EL1.PARange[3:0] as in
ARM ARM (0487F.a). Replace them with cpuid_feature_extract_unsigned_field()
which can extract given standard feature (4 bits width i.e 0xf mask) field.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: James Morse <james.morse@arm.com>
Cc: kvmarm@lists.cs.columbia.edu
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
Changes in V2:

- Used cpuid_feature_extract_unsigned_field() per Mark

Changes in V1: (https://patchwork.kernel.org/patch/11541913/)

 arch/arm64/kernel/cpufeature.c |  3 ++-
 arch/arm64/kvm/reset.c         | 11 ++++++++---
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 30917fe7942a..958a96947c2c 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2201,7 +2201,8 @@ void verify_hyp_capabilities(void)
 	}
 
 	/* Verify IPA range */
-	parange = mmfr0 & 0x7;
+	parange = cpuid_feature_extract_unsigned_field(mmfr0,
+				ID_AA64MMFR0_PARANGE_SHIFT);
 	ipa_max = id_aa64mmfr0_parange_to_phys_shift(parange);
 	if (ipa_max < get_kvm_ipa_limit()) {
 		pr_crit("CPU%d: IPA range mismatch\n", smp_processor_id());
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index 841b492ff334..bd9f66a81e1e 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -348,8 +348,11 @@ u32 get_kvm_ipa_limit(void)
 void kvm_set_ipa_limit(void)
 {
 	unsigned int ipa_max, pa_max, va_max, parange;
+	u64 mmfr0;
 
-	parange = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1) & 0x7;
+	mmfr0 = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
+	parange = cpuid_feature_extract_unsigned_field(mmfr0,
+				ID_AA64MMFR0_PARANGE_SHIFT);
 	pa_max = id_aa64mmfr0_parange_to_phys_shift(parange);
 
 	/* Clamp the IPA limit to the PA size supported by the kernel */
@@ -395,7 +398,7 @@ void kvm_set_ipa_limit(void)
  */
 int kvm_arm_setup_stage2(struct kvm *kvm, unsigned long type)
 {
-	u64 vtcr = VTCR_EL2_FLAGS;
+	u64 vtcr = VTCR_EL2_FLAGS, mmfr0;
 	u32 parange, phys_shift;
 	u8 lvls;
 
@@ -411,7 +414,9 @@ int kvm_arm_setup_stage2(struct kvm *kvm, unsigned long type)
 		phys_shift = KVM_PHYS_SHIFT;
 	}
 
-	parange = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1) & 7;
+	mmfr0 = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
+	parange = cpuid_feature_extract_unsigned_field(mmfr0,
+				ID_AA64MMFR0_PARANGE_SHIFT);
 	if (parange > ID_AA64MMFR0_PARANGE_MAX)
 		parange = ID_AA64MMFR0_PARANGE_MAX;
 	vtcr |= parange << VTCR_EL2_PS_SHIFT;
-- 
2.20.1

