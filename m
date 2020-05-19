Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775A9C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 09:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EA01207ED
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 09:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728788AbgESJmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 05:42:21 -0400
Received: from foss.arm.com ([217.140.110.172]:57570 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728773AbgESJmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 05:42:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3959F11D4;
        Tue, 19 May 2020 02:42:18 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.75.102])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B73B93F305;
        Tue, 19 May 2020 02:42:15 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        mark.rutland@arm.com, suzuki.poulose@arm.com,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 13/17] arm64/cpufeature: Add remaining feature bits in ID_AA64MMFR1 register
Date:   Tue, 19 May 2020 15:10:50 +0530
Message-Id: <1589881254-10082-14-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589881254-10082-1-git-send-email-anshuman.khandual@arm.com>
References: <1589881254-10082-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable ETS, TWED, XNX and SPECSEI features bits in ID_AA64MMFR1 register as
per ARM DDI 0487F.a specification.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/sysreg.h | 4 ++++
 arch/arm64/kernel/cpufeature.c  | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 95fdfc5e9bd0..f9dd2c5ab074 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -734,6 +734,10 @@
 #endif
 
 /* id_aa64mmfr1 */
+#define ID_AA64MMFR1_ETS_SHIFT		36
+#define ID_AA64MMFR1_TWED_SHIFT		32
+#define ID_AA64MMFR1_XNX_SHIFT		28
+#define ID_AA64MMFR1_SPECSEI_SHIFT	24
 #define ID_AA64MMFR1_PAN_SHIFT		20
 #define ID_AA64MMFR1_LOR_SHIFT		16
 #define ID_AA64MMFR1_HPD_SHIFT		12
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 7ce19f97ba73..1f10ff7df705 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -299,6 +299,10 @@ static const struct arm64_ftr_bits ftr_id_aa64mmfr0[] = {
 };
 
 static const struct arm64_ftr_bits ftr_id_aa64mmfr1[] = {
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR1_ETS_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR1_TWED_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR1_XNX_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR1_SPECSEI_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR1_PAN_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR1_LOR_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR1_HPD_SHIFT, 4, 0),
-- 
2.20.1

