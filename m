Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2BAC2BBC7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 09:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5ADD2064A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 09:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437934AbgDNJuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 05:50:23 -0400
Received: from foss.arm.com ([217.140.110.172]:51940 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437884AbgDNJth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 05:49:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E10261FB;
        Tue, 14 Apr 2020 02:49:36 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.1.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C7B673F6C4;
        Tue, 14 Apr 2020 02:49:33 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        maz@kernel.org, suzuki.poulose@arm.com,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 14/16] arm64/cpufeature: Add remaining feature bits in ID_AA64MMFR2 register
Date:   Tue, 14 Apr 2020 15:18:28 +0530
Message-Id: <1586857710-17154-15-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586857710-17154-1-git-send-email-anshuman.khandual@arm.com>
References: <1586857710-17154-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable EVT, BBM, TTL, IDS, ST, NV and CCIDX features bits in ID_AA64MMFR2
register as per ARM DDI 0487F.a specification.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/sysreg.h | 7 +++++++
 arch/arm64/kernel/cpufeature.c  | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 914fd6270f80..861983530970 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -743,8 +743,15 @@
 
 /* id_aa64mmfr2 */
 #define ID_AA64MMFR2_E0PD_SHIFT		60
+#define ID_AA64MMFR2_EVT_SHIFT		56
+#define ID_AA64MMFR2_BBM_SHIFT		52
+#define ID_AA64MMFR2_TTL_SHIFT		48
 #define ID_AA64MMFR2_FWB_SHIFT		40
+#define ID_AA64MMFR2_IDS_SHIFT		36
 #define ID_AA64MMFR2_AT_SHIFT		32
+#define ID_AA64MMFR2_ST_SHIFT		28
+#define ID_AA64MMFR2_NV_SHIFT		24
+#define ID_AA64MMFR2_CCIDX_SHIFT	20
 #define ID_AA64MMFR2_LVA_SHIFT		16
 #define ID_AA64MMFR2_IESB_SHIFT		12
 #define ID_AA64MMFR2_LSM_SHIFT		8
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index d0e1b525d2bf..7984eb236e7d 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -262,8 +262,15 @@ static const struct arm64_ftr_bits ftr_id_aa64mmfr1[] = {
 
 static const struct arm64_ftr_bits ftr_id_aa64mmfr2[] = {
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64MMFR2_E0PD_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR2_EVT_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR2_BBM_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR2_TTL_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR2_FWB_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR2_IDS_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR2_AT_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR2_ST_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR2_NV_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR2_CCIDX_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR2_LVA_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR2_IESB_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR2_LSM_SHIFT, 4, 0),
-- 
2.20.1

