Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE463C47257
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 13:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3EDA2496E
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 13:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbgEBNe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 09:34:58 -0400
Received: from foss.arm.com ([217.140.110.172]:52300 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728025AbgEBNe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 09:34:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71EC1C14;
        Sat,  2 May 2020 06:34:57 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.71.130])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2D7CD3F68F;
        Sat,  2 May 2020 06:34:54 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 01/16] arm64/cpufeature: Add explicit ftr_id_isar0[] for ID_ISAR0 register
Date:   Sat,  2 May 2020 19:03:50 +0530
Message-Id: <1588426445-24344-2-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588426445-24344-1-git-send-email-anshuman.khandual@arm.com>
References: <1588426445-24344-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ID_ISAR0[31..28] bits are RES0 in ARMv8, Reserved/UNK in ARMv7. Currently
these bits get exposed through generic_id_ftr32[] which is not desirable.
Hence define an explicit ftr_id_isar0[] array for ID_ISAR0 register where
those bits can be hidden.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/sysreg.h |  8 ++++++++
 arch/arm64/kernel/cpufeature.c  | 14 ++++++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 2dd3f4ca9780..e5317a6367b6 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -762,6 +762,14 @@
 #define ID_ISAR4_WITHSHIFTS_SHIFT	4
 #define ID_ISAR4_UNPRIV_SHIFT		0
 
+#define ID_ISAR0_DIVIDE_SHIFT		24
+#define ID_ISAR0_DEBUG_SHIFT		20
+#define ID_ISAR0_COPROC_SHIFT		16
+#define ID_ISAR0_CMPBRANCH_SHIFT	12
+#define ID_ISAR0_BITFIELD_SHIFT		8
+#define ID_ISAR0_BITCOUNT_SHIFT		4
+#define ID_ISAR0_SWAP_SHIFT		0
+
 #define ID_ISAR5_RDM_SHIFT		24
 #define ID_ISAR5_CRC32_SHIFT		16
 #define ID_ISAR5_SHA2_SHIFT		12
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index c1d44d127baa..6d032fbe416f 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -365,6 +365,16 @@ static const struct arm64_ftr_bits ftr_dczid[] = {
 	ARM64_FTR_END,
 };
 
+static const struct arm64_ftr_bits ftr_id_isar0[] = {
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_ISAR0_DIVIDE_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_ISAR0_DEBUG_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_ISAR0_COPROC_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_ISAR0_CMPBRANCH_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_ISAR0_BITFIELD_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_ISAR0_BITCOUNT_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_ISAR0_SWAP_SHIFT, 4, 0),
+	ARM64_FTR_END,
+};
 
 static const struct arm64_ftr_bits ftr_id_isar5[] = {
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_ISAR5_RDM_SHIFT, 4, 0),
@@ -446,7 +456,7 @@ static const struct arm64_ftr_bits ftr_zcr[] = {
  * Common ftr bits for a 32bit register with all hidden, strict
  * attributes, with 4bit feature fields and a default safe value of
  * 0. Covers the following 32bit registers:
- * id_isar[0-4], id_mmfr[1-3], id_pfr1, mvfr[0-1]
+ * id_isar[1-4], id_mmfr[1-3], id_pfr1, mvfr[0-1]
  */
 static const struct arm64_ftr_bits ftr_generic_32bits[] = {
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 28, 4, 0),
@@ -492,7 +502,7 @@ static const struct __ftr_reg_entry {
 	ARM64_FTR_REG(SYS_ID_MMFR3_EL1, ftr_generic_32bits),
 
 	/* Op1 = 0, CRn = 0, CRm = 2 */
-	ARM64_FTR_REG(SYS_ID_ISAR0_EL1, ftr_generic_32bits),
+	ARM64_FTR_REG(SYS_ID_ISAR0_EL1, ftr_id_isar0),
 	ARM64_FTR_REG(SYS_ID_ISAR1_EL1, ftr_generic_32bits),
 	ARM64_FTR_REG(SYS_ID_ISAR2_EL1, ftr_generic_32bits),
 	ARM64_FTR_REG(SYS_ID_ISAR3_EL1, ftr_generic_32bits),
-- 
2.20.1

