Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D85C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 21:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 401B52074D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 21:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586899913;
	bh=Xk4Dzyrvzg+6voYU9PvJ6jInwCMPY3MsfrI1SnpHnqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0HFLDU7WEDXFaCMC8p51rbev/7dwjm1Iyt8v5a8dn1r06RhJ5WfuIFTZRueuzPGAE
	 8NmAmZflIoULtwYAIGnfBLTX6VB8of0it/+Fw3CL143581QOxN1dI7g/mkG5Y4KQ4K
	 Ut6cIbYPkfKo6RPMimJvB4czdytxmZsvflWg/6/Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633867AbgDNVbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 17:31:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:39930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2633840AbgDNVb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 17:31:29 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFA6D20774;
        Tue, 14 Apr 2020 21:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586899889;
        bh=Xk4Dzyrvzg+6voYU9PvJ6jInwCMPY3MsfrI1SnpHnqo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JRNwHetm+tt8cNG/6HkMLbgKTRUNkd1Hms2P0bjZ1Ci4WkxUp8T1t2/HBK263Zxcj
         4GyRd5cCLwOox3XXg0+jppknDwvOuH3mq7I3t6o31Iik35nBu8/+wvDNYpL0+VJfm8
         EJQ2eTsZVkgSBJ6UcF7dJf84x/GyogMQ3QVJWtLE=
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
Subject: [PATCH 2/8] arm64: cpufeature: Spell out register fields for ID_ISAR4 and ID_PFR1
Date:   Tue, 14 Apr 2020 22:31:08 +0100
Message-Id: <20200414213114.2378-3-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200414213114.2378-1-will@kernel.org>
References: <20200414213114.2378-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for runtime updates to the strictness of some AArch32
features, spell out the register fields for ID_ISAR4 and ID_PFR1 to make
things clearer to read. Note that this isn't functionally necessary, as
the feature arrays themselves are not modified dynamically and remain
'const'.

Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/sysreg.h | 17 +++++++++++++++++
 arch/arm64/kernel/cpufeature.c  | 28 ++++++++++++++++++++++++++--
 2 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index ebc622432831..139cd24c181b 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -750,6 +750,15 @@
 
 #define ID_DFR0_PERFMON_8_1		0x4
 
+#define ID_ISAR4_SWP_FRAC_SHIFT		28
+#define ID_ISAR4_PSR_M_SHIFT		24
+#define ID_ISAR4_SYNCH_PRIM_FRAC_SHIFT	20
+#define ID_ISAR4_BARRIER_SHIFT		16
+#define ID_ISAR4_SMC_SHIFT		12
+#define ID_ISAR4_WRITEBACK_SHIFT	8
+#define ID_ISAR4_WITHSHIFTS_SHIFT	4
+#define ID_ISAR4_UNPRIV_SHIFT		0
+
 #define ID_ISAR5_RDM_SHIFT		24
 #define ID_ISAR5_CRC32_SHIFT		16
 #define ID_ISAR5_SHA2_SHIFT		12
@@ -783,6 +792,14 @@
 #define MVFR1_FPDNAN_SHIFT		4
 #define MVFR1_FPFTZ_SHIFT		0
 
+#define ID_PFR1_GIC_SHIFT		28
+#define ID_PFR1_VIRT_FRAC_SHIFT		24
+#define ID_PFR1_SEC_FRAC_SHIFT		20
+#define ID_PFR1_GENTIMER_SHIFT		16
+#define ID_PFR1_VIRTUALIZATION_SHIFT	12
+#define ID_PFR1_MPROGMOD_SHIFT		8
+#define ID_PFR1_SECURITY_SHIFT		4
+#define ID_PFR1_PROGMOD_SHIFT		0
 
 #define ID_AA64MMFR0_TGRAN4_SHIFT	28
 #define ID_AA64MMFR0_TGRAN64_SHIFT	24
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 63df28e6a425..b143f8bc6c52 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -332,6 +332,18 @@ static const struct arm64_ftr_bits ftr_id_mmfr4[] = {
 	ARM64_FTR_END,
 };
 
+static const struct arm64_ftr_bits ftr_id_isar4[] = {
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_ISAR4_SWP_FRAC_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_ISAR4_PSR_M_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_ISAR4_SYNCH_PRIM_FRAC_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_ISAR4_BARRIER_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_ISAR4_SMC_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_ISAR4_WRITEBACK_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_ISAR4_WITHSHIFTS_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_ISAR4_UNPRIV_SHIFT, 4, 0),
+	ARM64_FTR_END,
+};
+
 static const struct arm64_ftr_bits ftr_id_isar6[] = {
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_ISAR6_I8MM_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_ISAR6_BF16_SHIFT, 4, 0),
@@ -351,6 +363,18 @@ static const struct arm64_ftr_bits ftr_id_pfr0[] = {
 	ARM64_FTR_END,
 };
 
+static const struct arm64_ftr_bits ftr_id_pfr1[] = {
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_PFR1_GIC_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_PFR1_VIRT_FRAC_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_PFR1_SEC_FRAC_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_PFR1_GENTIMER_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_PFR1_VIRTUALIZATION_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_PFR1_MPROGMOD_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_PFR1_SECURITY_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_PFR1_PROGMOD_SHIFT, 4, 0),
+	ARM64_FTR_END,
+};
+
 static const struct arm64_ftr_bits ftr_id_dfr0[] = {
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 28, 4, 0),
 	S_ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 24, 4, 0xf),	/* PerfMon */
@@ -411,7 +435,7 @@ static const struct __ftr_reg_entry {
 
 	/* Op1 = 0, CRn = 0, CRm = 1 */
 	ARM64_FTR_REG(SYS_ID_PFR0_EL1, ftr_id_pfr0),
-	ARM64_FTR_REG(SYS_ID_PFR1_EL1, ftr_generic_32bits),
+	ARM64_FTR_REG(SYS_ID_PFR1_EL1, ftr_id_pfr1),
 	ARM64_FTR_REG(SYS_ID_DFR0_EL1, ftr_id_dfr0),
 	ARM64_FTR_REG(SYS_ID_MMFR0_EL1, ftr_id_mmfr0),
 	ARM64_FTR_REG(SYS_ID_MMFR1_EL1, ftr_generic_32bits),
@@ -423,7 +447,7 @@ static const struct __ftr_reg_entry {
 	ARM64_FTR_REG(SYS_ID_ISAR1_EL1, ftr_generic_32bits),
 	ARM64_FTR_REG(SYS_ID_ISAR2_EL1, ftr_generic_32bits),
 	ARM64_FTR_REG(SYS_ID_ISAR3_EL1, ftr_generic_32bits),
-	ARM64_FTR_REG(SYS_ID_ISAR4_EL1, ftr_generic_32bits),
+	ARM64_FTR_REG(SYS_ID_ISAR4_EL1, ftr_id_isar4),
 	ARM64_FTR_REG(SYS_ID_ISAR5_EL1, ftr_id_isar5),
 	ARM64_FTR_REG(SYS_ID_MMFR4_EL1, ftr_id_mmfr4),
 	ARM64_FTR_REG(SYS_ID_ISAR6_EL1, ftr_id_isar6),
-- 
2.26.0.110.g2183baf09c-goog

