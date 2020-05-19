Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67AFBC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 09:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 467602086A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 09:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbgESJmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 05:42:33 -0400
Received: from foss.arm.com ([217.140.110.172]:57616 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728818AbgESJmb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 05:42:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5AD4A11D4;
        Tue, 19 May 2020 02:42:30 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.75.102])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D98563F305;
        Tue, 19 May 2020 02:42:27 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        mark.rutland@arm.com, suzuki.poulose@arm.com,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 17/17] arm64/cpuinfo: Add ID_MMFR4_EL1 into the cpuinfo_arm64 context
Date:   Tue, 19 May 2020 15:10:54 +0530
Message-Id: <1589881254-10082-18-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589881254-10082-1-git-send-email-anshuman.khandual@arm.com>
References: <1589881254-10082-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ID_MMFR4_EL1 has been missing in the CPU context (i.e cpuinfo_arm64). This
just adds the register along with other required changes.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/cpu.h   | 1 +
 arch/arm64/kernel/cpufeature.c | 4 ++++
 arch/arm64/kernel/cpuinfo.c    | 1 +
 3 files changed, 6 insertions(+)

diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
index e1f5ef437671..7faae6ff3ab4 100644
--- a/arch/arm64/include/asm/cpu.h
+++ b/arch/arm64/include/asm/cpu.h
@@ -45,6 +45,7 @@ struct cpuinfo_arm64 {
 	u32		reg_id_mmfr1;
 	u32		reg_id_mmfr2;
 	u32		reg_id_mmfr3;
+	u32		reg_id_mmfr4;
 	u32		reg_id_mmfr5;
 	u32		reg_id_pfr0;
 	u32		reg_id_pfr1;
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 70c3b49aac11..42990188fb6c 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -785,6 +785,7 @@ void __init init_cpu_features(struct cpuinfo_arm64 *info)
 		init_cpu_ftr_reg(SYS_ID_MMFR1_EL1, info->reg_id_mmfr1);
 		init_cpu_ftr_reg(SYS_ID_MMFR2_EL1, info->reg_id_mmfr2);
 		init_cpu_ftr_reg(SYS_ID_MMFR3_EL1, info->reg_id_mmfr3);
+		init_cpu_ftr_reg(SYS_ID_MMFR4_EL1, info->reg_id_mmfr4);
 		init_cpu_ftr_reg(SYS_ID_MMFR5_EL1, info->reg_id_mmfr5);
 		init_cpu_ftr_reg(SYS_ID_PFR0_EL1, info->reg_id_pfr0);
 		init_cpu_ftr_reg(SYS_ID_PFR1_EL1, info->reg_id_pfr1);
@@ -920,6 +921,8 @@ static int update_32bit_cpu_features(int cpu, struct cpuinfo_arm64 *info,
 				      info->reg_id_mmfr2, boot->reg_id_mmfr2);
 	taint |= check_update_ftr_reg(SYS_ID_MMFR3_EL1, cpu,
 				      info->reg_id_mmfr3, boot->reg_id_mmfr3);
+	taint |= check_update_ftr_reg(SYS_ID_MMFR4_EL1, cpu,
+				      info->reg_id_mmfr4, boot->reg_id_mmfr4);
 	taint |= check_update_ftr_reg(SYS_ID_MMFR5_EL1, cpu,
 				      info->reg_id_mmfr5, boot->reg_id_mmfr5);
 	taint |= check_update_ftr_reg(SYS_ID_PFR0_EL1, cpu,
@@ -1062,6 +1065,7 @@ static u64 __read_sysreg_by_encoding(u32 sys_id)
 	read_sysreg_case(SYS_ID_MMFR1_EL1);
 	read_sysreg_case(SYS_ID_MMFR2_EL1);
 	read_sysreg_case(SYS_ID_MMFR3_EL1);
+	read_sysreg_case(SYS_ID_MMFR4_EL1);
 	read_sysreg_case(SYS_ID_MMFR5_EL1);
 	read_sysreg_case(SYS_ID_ISAR0_EL1);
 	read_sysreg_case(SYS_ID_ISAR1_EL1);
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 54579bf08f74..465ef72f061a 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -374,6 +374,7 @@ static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
 		info->reg_id_mmfr1 = read_cpuid(ID_MMFR1_EL1);
 		info->reg_id_mmfr2 = read_cpuid(ID_MMFR2_EL1);
 		info->reg_id_mmfr3 = read_cpuid(ID_MMFR3_EL1);
+		info->reg_id_mmfr4 = read_cpuid(ID_MMFR4_EL1);
 		info->reg_id_mmfr5 = read_cpuid(ID_MMFR5_EL1);
 		info->reg_id_pfr0 = read_cpuid(ID_PFR0_EL1);
 		info->reg_id_pfr1 = read_cpuid(ID_PFR1_EL1);
-- 
2.20.1

