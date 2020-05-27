Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7180C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 03:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AD4A207CB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 03:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387442AbgE0DEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 23:04:55 -0400
Received: from foss.arm.com ([217.140.110.172]:59820 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbgE0DEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 23:04:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7471130E;
        Tue, 26 May 2020 20:04:53 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.76.100])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4A51A3F6C4;
        Tue, 26 May 2020 20:04:49 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        suzuki.poulose@arm.com,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH V5 4/4] arm64/cpufeature: Replace all open bits shift encodings with macros
Date:   Wed, 27 May 2020 08:33:39 +0530
Message-Id: <1590548619-3441-5-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590548619-3441-1-git-send-email-anshuman.khandual@arm.com>
References: <1590548619-3441-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are many open bits shift encodings for various CPU ID registers that
are scattered across cpufeature. This replaces them with register specific
sensible macro definitions. This should not have any functional change.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/sysreg.h | 28 +++++++++++++++++
 arch/arm64/kernel/cpufeature.c  | 53 +++++++++++++++++----------------
 2 files changed, 55 insertions(+), 26 deletions(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 9add104d4762..6a956b2cfb93 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -763,6 +763,7 @@
 #define ID_AA64MMFR2_CNP_SHIFT		0
 
 /* id_aa64dfr0 */
+#define ID_AA64DFR0_DOUBLELOCK_SHIFT	36
 #define ID_AA64DFR0_PMSVER_SHIFT	32
 #define ID_AA64DFR0_CTX_CMPS_SHIFT	28
 #define ID_AA64DFR0_WRPS_SHIFT		20
@@ -815,18 +816,40 @@
 #define ID_ISAR6_DP_SHIFT		4
 #define ID_ISAR6_JSCVT_SHIFT		0
 
+#define ID_MMFR0_INNERSHR_SHIFT		28
+#define ID_MMFR0_FCSE_SHIFT		24
+#define ID_MMFR0_AUXREG_SHIFT		20
+#define ID_MMFR0_TCM_SHIFT		16
+#define ID_MMFR0_SHARELVL_SHIFT		12
+#define ID_MMFR0_OUTERSHR_SHIFT		8
+#define ID_MMFR0_PMSA_SHIFT		4
+#define ID_MMFR0_VMSA_SHIFT		0
+
 #define ID_MMFR4_EVT_SHIFT		28
 #define ID_MMFR4_CCIDX_SHIFT		24
 #define ID_MMFR4_LSM_SHIFT		20
 #define ID_MMFR4_HPDS_SHIFT		16
 #define ID_MMFR4_CNP_SHIFT		12
 #define ID_MMFR4_XNX_SHIFT		8
+#define ID_MMFR4_AC2_SHIFT		4
 #define ID_MMFR4_SPECSEI_SHIFT		0
 
 #define ID_MMFR5_ETS_SHIFT		0
 
 #define ID_PFR0_DIT_SHIFT		24
 #define ID_PFR0_CSV2_SHIFT		16
+#define ID_PFR0_STATE3_SHIFT		12
+#define ID_PFR0_STATE2_SHIFT		8
+#define ID_PFR0_STATE1_SHIFT		4
+#define ID_PFR0_STATE0_SHIFT		0
+
+#define ID_DFR0_PERFMON_SHIFT		24
+#define ID_DFR0_MPROFDBG_SHIFT		20
+#define ID_DFR0_MMAPTRC_SHIFT		16
+#define ID_DFR0_COPTRC_SHIFT		12
+#define ID_DFR0_MMAPDBG_SHIFT		8
+#define ID_DFR0_COPSDBG_SHIFT		4
+#define ID_DFR0_COPDBG_SHIFT		0
 
 #define ID_PFR2_SSBS_SHIFT		4
 #define ID_PFR2_CSV3_SHIFT		0
@@ -869,6 +892,11 @@
 #define ID_AA64MMFR0_TGRAN_SUPPORTED	ID_AA64MMFR0_TGRAN64_SUPPORTED
 #endif
 
+#define MVFR2_FPMISC_SHIFT		4
+#define MVFR2_SIMDMISC_SHIFT		0
+
+#define DCZID_DZP_SHIFT			4
+#define DCZID_BS_SHIFT			0
 
 /*
  * The ZCR_ELx_LEN_* definitions intentionally include bits [8:4] which
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 45eb1fa57f2a..452f6265eda3 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -339,7 +339,7 @@ static const struct arm64_ftr_bits ftr_ctr[] = {
 	 * make use of *minLine.
 	 * If we have differing I-cache policies, report it as the weakest - VIPT.
 	 */
-	ARM64_FTR_BITS(FTR_VISIBLE, FTR_NONSTRICT, FTR_EXACT, 14, 2, ICACHE_POLICY_VIPT),	/* L1Ip */
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_NONSTRICT, FTR_EXACT, CTR_L1IP_SHIFT, 2, ICACHE_POLICY_VIPT),	/* L1Ip */
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, CTR_IMINLINE_SHIFT, 4, 0),
 	ARM64_FTR_END,
 };
@@ -350,19 +350,19 @@ struct arm64_ftr_reg arm64_ftr_reg_ctrel0 = {
 };
 
 static const struct arm64_ftr_bits ftr_id_mmfr0[] = {
-	S_ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 28, 4, 0xf),	/* InnerShr */
-	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 24, 4, 0),	/* FCSE */
-	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, 20, 4, 0),	/* AuxReg */
-	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 16, 4, 0),	/* TCM */
-	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 12, 4, 0),	/* ShareLvl */
-	S_ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 8, 4, 0xf),	/* OuterShr */
-	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 4, 4, 0),	/* PMSA */
-	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 0, 4, 0),	/* VMSA */
+	S_ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_MMFR0_INNERSHR_SHIFT, 4, 0xf),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_MMFR0_FCSE_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_MMFR0_AUXREG_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_MMFR0_TCM_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_MMFR0_SHARELVL_SHIFT, 4, 0),
+	S_ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_MMFR0_OUTERSHR_SHIFT, 4, 0xf),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_MMFR0_PMSA_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_MMFR0_VMSA_SHIFT, 4, 0),
 	ARM64_FTR_END,
 };
 
 static const struct arm64_ftr_bits ftr_id_aa64dfr0[] = {
-	S_ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 36, 4, 0),
+	S_ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_DOUBLELOCK_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64DFR0_PMSVER_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_CTX_CMPS_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_WRPS_SHIFT, 4, 0),
@@ -378,14 +378,14 @@ static const struct arm64_ftr_bits ftr_id_aa64dfr0[] = {
 };
 
 static const struct arm64_ftr_bits ftr_mvfr2[] = {
-	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 4, 4, 0),		/* FPMisc */
-	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 0, 4, 0),		/* SIMDMisc */
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, MVFR2_FPMISC_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, MVFR2_SIMDMISC_SHIFT, 4, 0),
 	ARM64_FTR_END,
 };
 
 static const struct arm64_ftr_bits ftr_dczid[] = {
-	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_EXACT, 4, 1, 1),		/* DZP */
-	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, 0, 4, 0),	/* BS */
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_EXACT, DCZID_DZP_SHIFT, 1, 1),
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, DCZID_BS_SHIFT, 4, 0),
 	ARM64_FTR_END,
 };
 
@@ -417,7 +417,8 @@ static const struct arm64_ftr_bits ftr_id_mmfr4[] = {
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_MMFR4_HPDS_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_MMFR4_CNP_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_MMFR4_XNX_SHIFT, 4, 0),
-	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 4, 4, 0),	/* ac2 */
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_MMFR4_AC2_SHIFT, 4, 0),
+
 	/*
 	 * SpecSEI = 1 indicates that the PE might generate an SError on an
 	 * external abort on speculative read. It is safe to assume that an
@@ -459,10 +460,10 @@ static const struct arm64_ftr_bits ftr_id_isar6[] = {
 static const struct arm64_ftr_bits ftr_id_pfr0[] = {
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_PFR0_DIT_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_PFR0_CSV2_SHIFT, 4, 0),
-	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 12, 4, 0),		/* State3 */
-	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 8, 4, 0),		/* State2 */
-	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 4, 4, 0),		/* State1 */
-	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 0, 4, 0),		/* State0 */
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_PFR0_STATE3_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_PFR0_STATE2_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_PFR0_STATE1_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_PFR0_STATE0_SHIFT, 4, 0),
 	ARM64_FTR_END,
 };
 
@@ -486,13 +487,13 @@ static const struct arm64_ftr_bits ftr_id_pfr2[] = {
 
 static const struct arm64_ftr_bits ftr_id_dfr0[] = {
 	/* [31:28] TraceFilt */
-	S_ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 24, 4, 0xf),	/* PerfMon */
-	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 20, 4, 0),
-	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 16, 4, 0),
-	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 12, 4, 0),
-	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 8, 4, 0),
-	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 4, 4, 0),
-	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 0, 4, 0),
+	S_ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_DFR0_PERFMON_SHIFT, 4, 0xf),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_DFR0_MPROFDBG_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_DFR0_MMAPTRC_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_DFR0_COPTRC_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_DFR0_MMAPDBG_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_DFR0_COPSDBG_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_DFR0_COPDBG_SHIFT, 4, 0),
 	ARM64_FTR_END,
 };
 
-- 
2.20.1

