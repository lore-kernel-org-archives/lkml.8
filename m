Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5AF3C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 03:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B68920848
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 03:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgH1DSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 23:18:36 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:39978 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727926AbgH1DSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 23:18:35 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 353D0A606CB6908B1DDD;
        Fri, 28 Aug 2020 11:18:31 +0800 (CST)
Received: from use12-sp2.huawei.com (10.67.189.174) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Fri, 28 Aug 2020 11:18:24 +0800
From:   Xiaoming Ni <nixiaoming@huawei.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <mark.rutland@arm.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>, <maz@kernel.org>,
        <julien.thierry.kdev@gmail.com>, <suzuki.poulose@arm.com>
CC:     <nixiaoming@huawei.com>, <wangle6@huawei.com>
Subject: [PATCH] arm64: fix some spelling mistakes in the comments by codespell
Date:   Fri, 28 Aug 2020 11:18:22 +0800
Message-ID: <20200828031822.35928-1-nixiaoming@huawei.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.189.174]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/arm64/include/asm/cpu_ops.h:24: necesary ==> necessary
arch/arm64/include/asm/kvm_arm.h:69: maintainance ==> maintenance
arch/arm64/include/asm/cpufeature.h:361: capabilties ==> capabilities
arch/arm64/kernel/perf_regs.c:19: compatability ==> compatibility
arch/arm64/kernel/smp_spin_table.c:86: endianess ==> endianness
arch/arm64/kernel/smp_spin_table.c:88: endianess ==> endianness
arch/arm64/kvm/vgic/vgic-mmio-v3.c:1004: targetting ==> targeting
arch/arm64/kvm/vgic/vgic-mmio-v3.c:1005: targetting ==> targeting

Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
---
 arch/arm64/include/asm/cpu_ops.h    | 2 +-
 arch/arm64/include/asm/cpufeature.h | 2 +-
 arch/arm64/include/asm/kvm_arm.h    | 2 +-
 arch/arm64/kernel/perf_regs.c       | 2 +-
 arch/arm64/kernel/smp_spin_table.c  | 4 ++--
 arch/arm64/kvm/vgic/vgic-mmio-v3.c  | 4 ++--
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/cpu_ops.h b/arch/arm64/include/asm/cpu_ops.h
index d28e8f37d3b4..e95c4df83911 100644
--- a/arch/arm64/include/asm/cpu_ops.h
+++ b/arch/arm64/include/asm/cpu_ops.h
@@ -21,7 +21,7 @@
  *		mechanism for doing so, tests whether it is possible to boot
  *		the given CPU.
  * @cpu_boot:	Boots a cpu into the kernel.
- * @cpu_postboot: Optionally, perform any post-boot cleanup or necesary
+ * @cpu_postboot: Optionally, perform any post-boot cleanup or necessary
  *		synchronisation. Called from the cpu being booted.
  * @cpu_can_disable: Determines whether a CPU can be disabled based on
  *		mechanism-specific information.
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 89b4f0142c28..3a42dc8e697c 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -358,7 +358,7 @@ static inline int cpucap_default_scope(const struct arm64_cpu_capabilities *cap)
 }
 
 /*
- * Generic helper for handling capabilties with multiple (match,enable) pairs
+ * Generic helper for handling capabilities with multiple (match,enable) pairs
  * of call backs, sharing the same capability bit.
  * Iterate over each entry to see if at least one matches.
  */
diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index 51c1d9918999..21f91aebc052 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -66,7 +66,7 @@
  * TWI:		Trap WFI
  * TIDCP:	Trap L2CTLR/L2ECTLR
  * BSU_IS:	Upgrade barriers to the inner shareable domain
- * FB:		Force broadcast of all maintainance operations
+ * FB:		Force broadcast of all maintenance operations
  * AMO:		Override CPSR.A and enable signaling with VA
  * IMO:		Override CPSR.I and enable signaling with VI
  * FMO:		Override CPSR.F and enable signaling with VF
diff --git a/arch/arm64/kernel/perf_regs.c b/arch/arm64/kernel/perf_regs.c
index 666b225aeb3a..94e8718e7229 100644
--- a/arch/arm64/kernel/perf_regs.c
+++ b/arch/arm64/kernel/perf_regs.c
@@ -16,7 +16,7 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
 
 	/*
 	 * Our handling of compat tasks (PERF_SAMPLE_REGS_ABI_32) is weird, but
-	 * we're stuck with it for ABI compatability reasons.
+	 * we're stuck with it for ABI compatibility reasons.
 	 *
 	 * For a 32-bit consumer inspecting a 32-bit task, then it will look at
 	 * the first 16 registers (see arch/arm/include/uapi/asm/perf_regs.h).
diff --git a/arch/arm64/kernel/smp_spin_table.c b/arch/arm64/kernel/smp_spin_table.c
index c8a3fee00c11..5892e79fa429 100644
--- a/arch/arm64/kernel/smp_spin_table.c
+++ b/arch/arm64/kernel/smp_spin_table.c
@@ -83,9 +83,9 @@ static int smp_spin_table_cpu_prepare(unsigned int cpu)
 
 	/*
 	 * We write the release address as LE regardless of the native
-	 * endianess of the kernel. Therefore, any boot-loaders that
+	 * endianness of the kernel. Therefore, any boot-loaders that
 	 * read this address need to convert this address to the
-	 * boot-loader's endianess before jumping. This is mandated by
+	 * boot-loader's endianness before jumping. This is mandated by
 	 * the boot protocol.
 	 */
 	writeq_relaxed(__pa_symbol(secondary_holding_pen), release_addr);
diff --git a/arch/arm64/kvm/vgic/vgic-mmio-v3.c b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
index 5c786b915cd3..52d6f24f65dc 100644
--- a/arch/arm64/kvm/vgic/vgic-mmio-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
@@ -1001,8 +1001,8 @@ void vgic_v3_dispatch_sgi(struct kvm_vcpu *vcpu, u64 reg, bool allow_group1)
 		raw_spin_lock_irqsave(&irq->irq_lock, flags);
 
 		/*
-		 * An access targetting Group0 SGIs can only generate
-		 * those, while an access targetting Group1 SGIs can
+		 * An access targeting Group0 SGIs can only generate
+		 * those, while an access targeting Group1 SGIs can
 		 * generate interrupts of either group.
 		 */
 		if (!irq->group || allow_group1) {
-- 
2.27.0

