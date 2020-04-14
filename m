Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB22C2BBC7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 09:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94F6E2074D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 09:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437865AbgDNJt1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 05:49:27 -0400
Received: from foss.arm.com ([217.140.110.172]:51868 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437847AbgDNJtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 05:49:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A7711FB;
        Tue, 14 Apr 2020 02:49:12 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.1.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1DD733F6C4;
        Tue, 14 Apr 2020 02:49:09 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        maz@kernel.org, suzuki.poulose@arm.com,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 07/16] arm64/cpufeature: Add remaining feature bits in ID_PFR0 register
Date:   Tue, 14 Apr 2020 15:18:21 +0530
Message-Id: <1586857710-17154-8-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586857710-17154-1-git-send-email-anshuman.khandual@arm.com>
References: <1586857710-17154-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable DIT and CSV2 feature bits in ID_PFR0 register as per ARM DDI 0487F.a
specification. Except RAS and AMU, all other feature bits are now enabled.

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
 arch/arm64/include/asm/sysreg.h | 3 +++
 arch/arm64/kernel/cpufeature.c  | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 88b3a16defbb..32b7539b965f 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -780,6 +780,9 @@
 
 #define ID_MMFR5_ETS_SHIFT		0
 
+#define ID_PFR0_DIT_SHIFT		24
+#define ID_PFR0_CSV2_SHIFT		16
+
 #define ID_PFR2_SSBS_SHIFT		4
 #define ID_PFR2_CSV3_SHIFT		0
 
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 233adc32b842..8b289a6815eb 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -359,6 +359,8 @@ static const struct arm64_ftr_bits ftr_id_isar6[] = {
 };
 
 static const struct arm64_ftr_bits ftr_id_pfr0[] = {
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_PFR0_DIT_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_PFR0_CSV2_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 12, 4, 0),		/* State3 */
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 8, 4, 0),		/* State2 */
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 4, 4, 0),		/* State1 */
-- 
2.20.1

