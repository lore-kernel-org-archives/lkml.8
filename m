Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CECC54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 629B32071E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587479384;
	bh=LrjuJODB+b4vgZl3OiZG3qomjA+lEJ+cv2JSlMbM668=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ow7pbxydYHRUhGV5ZutuSwV1K6IKEPCipKzpOPkP7oavHt13CqwDwShhRR7FIpNuh
	 xQ+FkNLUEucs9B/tSy5R1aal/3GLph+nrpeGDf9ovs+cipFhuLKSPvFIR2lswVLmBh
	 Dhug0HTEyFJ0BY1guQzIRxBApuFZ1nQmopI7mOCI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbgDUO3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 10:29:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:42384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729086AbgDUO3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 10:29:40 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16A81206B8;
        Tue, 21 Apr 2020 14:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587479380;
        bh=LrjuJODB+b4vgZl3OiZG3qomjA+lEJ+cv2JSlMbM668=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cfag7vOKhGuDQszuf8qcsuOkj854Qcq2K/wCIlMVJnG+ibupQKzTVpsS7jMgLYwnA
         PUsrItY2FEbfZ93JLjt31sN5Ag61fXnffxMrxgfbGqLF0HDCdTLgMZUMVcqHpTXeM5
         gS1BbQ41nHx/SFwanOk7rzdCd+1WSnTWAdCdvd10=
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
Subject: [PATCH v2 5/8] arm64: cpufeature: Factor out checking of AArch32 features
Date:   Tue, 21 Apr 2020 15:29:19 +0100
Message-Id: <20200421142922.18950-6-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200421142922.18950-1-will@kernel.org>
References: <20200421142922.18950-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

update_cpu_features() is pretty large, so split out the checking of the
AArch32 features into a separate function and call it after checking the
AArch64 features.

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Tested-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/cpufeature.c | 112 +++++++++++++++++++--------------
 1 file changed, 65 insertions(+), 47 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 7dfcdd9e75c1..6892b2440676 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -715,6 +715,65 @@ static int check_update_ftr_reg(u32 sys_id, int cpu, u64 val, u64 boot)
 	return 1;
 }
 
+static int update_32bit_cpu_features(int cpu, struct cpuinfo_arm64 *info,
+				     struct cpuinfo_arm64 *boot)
+{
+	int taint = 0;
+	u64 pfr0 = read_sanitised_ftr_reg(SYS_ID_AA64PFR0_EL1);
+
+	/*
+	 * If we don't have AArch32 at all then skip the checks entirely
+	 * as the register values may be UNKNOWN and we're not going to be
+	 * using them for anything.
+	 */
+	if (!id_aa64pfr0_32bit_el0(pfr0))
+		return taint;
+
+	taint |= check_update_ftr_reg(SYS_ID_DFR0_EL1, cpu,
+				      info->reg_id_dfr0, boot->reg_id_dfr0);
+	taint |= check_update_ftr_reg(SYS_ID_ISAR0_EL1, cpu,
+				      info->reg_id_isar0, boot->reg_id_isar0);
+	taint |= check_update_ftr_reg(SYS_ID_ISAR1_EL1, cpu,
+				      info->reg_id_isar1, boot->reg_id_isar1);
+	taint |= check_update_ftr_reg(SYS_ID_ISAR2_EL1, cpu,
+				      info->reg_id_isar2, boot->reg_id_isar2);
+	taint |= check_update_ftr_reg(SYS_ID_ISAR3_EL1, cpu,
+				      info->reg_id_isar3, boot->reg_id_isar3);
+	taint |= check_update_ftr_reg(SYS_ID_ISAR4_EL1, cpu,
+				      info->reg_id_isar4, boot->reg_id_isar4);
+	taint |= check_update_ftr_reg(SYS_ID_ISAR5_EL1, cpu,
+				      info->reg_id_isar5, boot->reg_id_isar5);
+	taint |= check_update_ftr_reg(SYS_ID_ISAR6_EL1, cpu,
+				      info->reg_id_isar6, boot->reg_id_isar6);
+
+	/*
+	 * Regardless of the value of the AuxReg field, the AIFSR, ADFSR, and
+	 * ACTLR formats could differ across CPUs and therefore would have to
+	 * be trapped for virtualization anyway.
+	 */
+	taint |= check_update_ftr_reg(SYS_ID_MMFR0_EL1, cpu,
+				      info->reg_id_mmfr0, boot->reg_id_mmfr0);
+	taint |= check_update_ftr_reg(SYS_ID_MMFR1_EL1, cpu,
+				      info->reg_id_mmfr1, boot->reg_id_mmfr1);
+	taint |= check_update_ftr_reg(SYS_ID_MMFR2_EL1, cpu,
+				      info->reg_id_mmfr2, boot->reg_id_mmfr2);
+	taint |= check_update_ftr_reg(SYS_ID_MMFR3_EL1, cpu,
+				      info->reg_id_mmfr3, boot->reg_id_mmfr3);
+	taint |= check_update_ftr_reg(SYS_ID_PFR0_EL1, cpu,
+				      info->reg_id_pfr0, boot->reg_id_pfr0);
+	taint |= check_update_ftr_reg(SYS_ID_PFR1_EL1, cpu,
+				      info->reg_id_pfr1, boot->reg_id_pfr1);
+	taint |= check_update_ftr_reg(SYS_MVFR0_EL1, cpu,
+				      info->reg_mvfr0, boot->reg_mvfr0);
+	taint |= check_update_ftr_reg(SYS_MVFR1_EL1, cpu,
+				      info->reg_mvfr1, boot->reg_mvfr1);
+	taint |= check_update_ftr_reg(SYS_MVFR2_EL1, cpu,
+				      info->reg_mvfr2, boot->reg_mvfr2);
+
+	return taint;
+}
+
+
 /*
  * Update system wide CPU feature registers with the values from a
  * non-boot CPU. Also performs SANITY checks to make sure that there
@@ -788,53 +847,6 @@ void update_cpu_features(int cpu,
 	taint |= check_update_ftr_reg(SYS_ID_AA64ZFR0_EL1, cpu,
 				      info->reg_id_aa64zfr0, boot->reg_id_aa64zfr0);
 
-	/*
-	 * If we have AArch32, we care about 32-bit features for compat.
-	 * If the system doesn't support AArch32, don't update them.
-	 */
-	if (id_aa64pfr0_32bit_el0(read_sanitised_ftr_reg(SYS_ID_AA64PFR0_EL1))) {
-		taint |= check_update_ftr_reg(SYS_ID_DFR0_EL1, cpu,
-					info->reg_id_dfr0, boot->reg_id_dfr0);
-		taint |= check_update_ftr_reg(SYS_ID_ISAR0_EL1, cpu,
-					info->reg_id_isar0, boot->reg_id_isar0);
-		taint |= check_update_ftr_reg(SYS_ID_ISAR1_EL1, cpu,
-					info->reg_id_isar1, boot->reg_id_isar1);
-		taint |= check_update_ftr_reg(SYS_ID_ISAR2_EL1, cpu,
-					info->reg_id_isar2, boot->reg_id_isar2);
-		taint |= check_update_ftr_reg(SYS_ID_ISAR3_EL1, cpu,
-					info->reg_id_isar3, boot->reg_id_isar3);
-		taint |= check_update_ftr_reg(SYS_ID_ISAR4_EL1, cpu,
-					info->reg_id_isar4, boot->reg_id_isar4);
-		taint |= check_update_ftr_reg(SYS_ID_ISAR5_EL1, cpu,
-					info->reg_id_isar5, boot->reg_id_isar5);
-		taint |= check_update_ftr_reg(SYS_ID_ISAR6_EL1, cpu,
-					info->reg_id_isar6, boot->reg_id_isar6);
-
-		/*
-		 * Regardless of the value of the AuxReg field, the AIFSR, ADFSR, and
-		 * ACTLR formats could differ across CPUs and therefore would have to
-		 * be trapped for virtualization anyway.
-		 */
-		taint |= check_update_ftr_reg(SYS_ID_MMFR0_EL1, cpu,
-					info->reg_id_mmfr0, boot->reg_id_mmfr0);
-		taint |= check_update_ftr_reg(SYS_ID_MMFR1_EL1, cpu,
-					info->reg_id_mmfr1, boot->reg_id_mmfr1);
-		taint |= check_update_ftr_reg(SYS_ID_MMFR2_EL1, cpu,
-					info->reg_id_mmfr2, boot->reg_id_mmfr2);
-		taint |= check_update_ftr_reg(SYS_ID_MMFR3_EL1, cpu,
-					info->reg_id_mmfr3, boot->reg_id_mmfr3);
-		taint |= check_update_ftr_reg(SYS_ID_PFR0_EL1, cpu,
-					info->reg_id_pfr0, boot->reg_id_pfr0);
-		taint |= check_update_ftr_reg(SYS_ID_PFR1_EL1, cpu,
-					info->reg_id_pfr1, boot->reg_id_pfr1);
-		taint |= check_update_ftr_reg(SYS_MVFR0_EL1, cpu,
-					info->reg_mvfr0, boot->reg_mvfr0);
-		taint |= check_update_ftr_reg(SYS_MVFR1_EL1, cpu,
-					info->reg_mvfr1, boot->reg_mvfr1);
-		taint |= check_update_ftr_reg(SYS_MVFR2_EL1, cpu,
-					info->reg_mvfr2, boot->reg_mvfr2);
-	}
-
 	if (id_aa64pfr0_sve(info->reg_id_aa64pfr0)) {
 		taint |= check_update_ftr_reg(SYS_ZCR_EL1, cpu,
 					info->reg_zcr, boot->reg_zcr);
@@ -845,6 +857,12 @@ void update_cpu_features(int cpu,
 			sve_update_vq_map();
 	}
 
+	/*
+	 * This relies on a sanitised view of the AArch64 ID registers
+	 * (e.g. SYS_ID_AA64PFR0_EL1), so we call it last.
+	 */
+	taint |= update_32bit_cpu_features(cpu, info, boot);
+
 	/*
 	 * Mismatched CPU features are a recipe for disaster. Don't even
 	 * pretend to support them.
-- 
2.26.1.301.g55bc3eb7cb9-goog

