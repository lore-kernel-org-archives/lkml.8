Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7930BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EA092073E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgGGOXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:23:49 -0400
Received: from foss.arm.com ([217.140.110.172]:52988 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726805AbgGGOXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:23:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31C50C0A;
        Tue,  7 Jul 2020 07:23:48 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.86.118])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1AEDE3F68F;
        Tue,  7 Jul 2020 07:23:44 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3] arm64/cpufeature: Validate feature bits spacing in arm64_ftr_regs[]
Date:   Tue,  7 Jul 2020 19:53:13 +0530
Message-Id: <1594131793-9498-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arm64_feature_bits for a register in arm64_ftr_regs[] are in a descending
order as per their shift values. Validate that these features bits are
defined correctly and do not overlap with each other. This check protects
against any inadvertent erroneous changes to the register definitions.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
Applies on 5.8-rc4.

Changes in V3:

- Moved around some local variables per Suzuki

Changes in V2: (https://patchwork.kernel.org/patch/11635395/)

- Replaced WARN_ON() with WARN() dropping the conditional block per Suzuki

Changes in V1: (https://patchwork.kernel.org/patch/11606285/)

 arch/arm64/kernel/cpufeature.c | 47 +++++++++++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 9fae0efc80c1..ddca88c660f6 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -697,11 +697,52 @@ static s64 arm64_ftr_safe_value(const struct arm64_ftr_bits *ftrp, s64 new,
 
 static void __init sort_ftr_regs(void)
 {
-	int i;
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(arm64_ftr_regs); i++) {
+		const struct arm64_ftr_reg *ftr_reg = arm64_ftr_regs[i].reg;
+		const struct arm64_ftr_bits *ftr_bits = ftr_reg->ftr_bits;
+		unsigned int j = 0;
+
+		/*
+		 * Features here must be sorted in descending order with respect
+		 * to their shift values and should not overlap with each other.
+		 */
+		for (; ftr_bits->width != 0; ftr_bits++, j++) {
+			unsigned int width = ftr_reg->ftr_bits[j].width;
+			unsigned int shift = ftr_reg->ftr_bits[j].shift;
+			unsigned int prev_shift;
+
+			WARN((shift  + width) > 64,
+				"%s has invalid feature at shift %d\n",
+				ftr_reg->name, shift);
+
+			/*
+			 * Skip the first feature. There is nothing to
+			 * compare against for now.
+			 */
+			if (j == 0)
+				continue;
 
-	/* Check that the array is sorted so that we can do the binary search */
-	for (i = 1; i < ARRAY_SIZE(arm64_ftr_regs); i++)
+			prev_shift = ftr_reg->ftr_bits[j - 1].shift;
+			WARN((shift + width) > prev_shift,
+				"%s has feature overlap at shift %d\n",
+				ftr_reg->name, shift);
+		}
+
+		/*
+		 * Skip the first register. There is nothing to
+		 * compare against for now.
+		 */
+		if (i == 0)
+			continue;
+		/*
+		 * Registers here must be sorted in ascending order with respect
+		 * to sys_id for subsequent binary search in get_arm64_ftr_reg()
+		 * to work correctly.
+		 */
 		BUG_ON(arm64_ftr_regs[i].sys_id < arm64_ftr_regs[i - 1].sys_id);
+	}
 }
 
 /*
-- 
2.20.1

