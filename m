Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5296C55184
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C665B206F4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587479379;
	bh=Z3SAyJ+K8U4voELx90j49yg6ENkNXXLr7yM/HxwV9GE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kodVS8UsZT6wIKczfTzIyL/oOXDXe1xuORLlSB2BzJRHSfhN8RBVY8UO22+gmArCi
	 xJ7WxkUp18m1MUUqfZOXgzLjrQHVjO/blPdP0y/id9UKRBkNh6bls1dvZdxXr7mrDy
	 JfuNJuV6aigrtXvFQv4HLyWV85uG69Eoozq80wEI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbgDUO3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 10:29:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:42234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729013AbgDUO3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 10:29:36 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42D182071E;
        Tue, 21 Apr 2020 14:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587479375;
        bh=Z3SAyJ+K8U4voELx90j49yg6ENkNXXLr7yM/HxwV9GE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=liFNkhlrc/hJrKIJbUUoN7Ue1AtOwo1n5VfyN6dUy+hT75/hsnHyQi2py2EUoX8sG
         zdRRSc+PTeJ6DHr7lSuwv++G2yFF4LqAeYUBNVj9H5oRqFZRg18PIEAqZp3QXMx5FG
         xmPfwT8kZfT53ePitklgmBeg8gfHlbsZ+iLxEVCY=
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>, kernel-team@android.com
Subject: [PATCH v2 3/8] arm64: cpufeature: Add CPU capability for AArch32 EL1 support
Date:   Tue, 21 Apr 2020 15:29:17 +0100
Message-Id: <20200421142922.18950-4-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200421142922.18950-1-will@kernel.org>
References: <20200421142922.18950-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although we emit a "SANITY CHECK" warning and taint the kernel if we
detect a CPU mismatch for AArch32 support at EL1, we still online the
CPU with disastrous consequences for any running 32-bit VMs.

Introduce a capability for AArch32 support at EL1 so that late onlining
of incompatible CPUs is forbidden.

Acked-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Tested-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/cpucaps.h |  3 ++-
 arch/arm64/include/asm/sysreg.h  |  1 +
 arch/arm64/kernel/cpufeature.c   | 12 ++++++++++++
 arch/arm64/kvm/reset.c           | 12 ++----------
 4 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index 8eb5a088ae65..c54c674e6c21 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -61,7 +61,8 @@
 #define ARM64_HAS_AMU_EXTN			51
 #define ARM64_HAS_ADDRESS_AUTH			52
 #define ARM64_HAS_GENERIC_AUTH			53
+#define ARM64_HAS_32BIT_EL1			54
 
-#define ARM64_NCAPS				54
+#define ARM64_NCAPS				55
 
 #endif /* __ASM_CPUCAPS_H */
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index d7181972d28d..c4e896bf77f3 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -655,6 +655,7 @@
 #define ID_AA64PFR0_ASIMD_NI		0xf
 #define ID_AA64PFR0_ASIMD_SUPPORTED	0x0
 #define ID_AA64PFR0_EL1_64BIT_ONLY	0x1
+#define ID_AA64PFR0_EL1_32BIT_64BIT	0x2
 #define ID_AA64PFR0_EL0_64BIT_ONLY	0x1
 #define ID_AA64PFR0_EL0_32BIT_64BIT	0x2
 
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index b143f8bc6c52..838fe5cc8d7e 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1535,6 +1535,18 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.field_pos = ID_AA64PFR0_EL0_SHIFT,
 		.min_field_value = ID_AA64PFR0_EL0_32BIT_64BIT,
 	},
+#ifdef CONFIG_KVM
+	{
+		.desc = "32-bit EL1 Support",
+		.capability = ARM64_HAS_32BIT_EL1,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
+		.matches = has_cpuid_feature,
+		.sys_reg = SYS_ID_AA64PFR0_EL1,
+		.sign = FTR_UNSIGNED,
+		.field_pos = ID_AA64PFR0_EL1_SHIFT,
+		.min_field_value = ID_AA64PFR0_EL1_32BIT_64BIT,
+	},
+#endif
 	{
 		.desc = "Kernel page table isolation (KPTI)",
 		.capability = ARM64_UNMAP_KERNEL_AT_EL0,
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index 30b7ea680f66..102e5c4e01a0 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -46,14 +46,6 @@ static const struct kvm_regs default_regs_reset32 = {
 			PSR_AA32_I_BIT | PSR_AA32_F_BIT),
 };
 
-static bool cpu_has_32bit_el1(void)
-{
-	u64 pfr0;
-
-	pfr0 = read_sanitised_ftr_reg(SYS_ID_AA64PFR0_EL1);
-	return !!(pfr0 & 0x20);
-}
-
 /**
  * kvm_arch_vm_ioctl_check_extension
  *
@@ -66,7 +58,7 @@ int kvm_arch_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 
 	switch (ext) {
 	case KVM_CAP_ARM_EL1_32BIT:
-		r = cpu_has_32bit_el1();
+		r = cpus_have_const_cap(ARM64_HAS_32BIT_EL1);
 		break;
 	case KVM_CAP_GUEST_DEBUG_HW_BPS:
 		r = get_num_brps();
@@ -288,7 +280,7 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 	switch (vcpu->arch.target) {
 	default:
 		if (test_bit(KVM_ARM_VCPU_EL1_32BIT, vcpu->arch.features)) {
-			if (!cpu_has_32bit_el1())
+			if (!cpus_have_const_cap(ARM64_HAS_32BIT_EL1))
 				goto out;
 			cpu_reset = &default_regs_reset32;
 		} else {
-- 
2.26.1.301.g55bc3eb7cb9-goog

