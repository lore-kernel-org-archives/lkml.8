Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52B8C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 01:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A190020756
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 01:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgETBXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 21:23:40 -0400
Received: from foss.arm.com ([217.140.110.172]:44940 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbgETBXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 21:23:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CE9A31B;
        Tue, 19 May 2020 18:23:39 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.75.101])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9F9473F68F;
        Tue, 19 May 2020 18:23:36 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     mark.rutland@arm.com,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/cpufeature: Move BUG_ON() inside get_arm64_ftr_reg()
Date:   Wed, 20 May 2020 06:52:54 +0530
Message-Id: <1589937774-20479-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no way to proceed when requested register could not be searched in
arm64_ftr_reg[]. Requesting for a non present register would be an error as
well. Hence lets just BUG_ON() when the search fails in get_arm64_ftr_reg()
rather than checking for return value and doing the same in some individual
callers.

But there are some callers that dont BUG_ON() upon search failure. It adds
an argument 'failsafe' that provides required switch between callers based
on whether they could proceed or not.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
Applies on next-20200518 that has recent cpufeature changes from Will.

 arch/arm64/kernel/cpufeature.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index bc5048f152c1..62767cc540c3 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -557,7 +557,7 @@ static int search_cmp_ftr_reg(const void *id, const void *regp)
  *         - NULL on failure. It is upto the caller to decide
  *	     the impact of a failure.
  */
-static struct arm64_ftr_reg *get_arm64_ftr_reg(u32 sys_id)
+static struct arm64_ftr_reg *get_arm64_ftr_reg(u32 sys_id, bool failsafe)
 {
 	const struct __ftr_reg_entry *ret;
 
@@ -568,6 +568,13 @@ static struct arm64_ftr_reg *get_arm64_ftr_reg(u32 sys_id)
 			search_cmp_ftr_reg);
 	if (ret)
 		return ret->reg;
+	/*
+	 * This can not really proceed when the search fails.
+	 * Requesting for a non existent register search will
+	 * also be an error in itself. Error out when not
+	 * called with fail safe request.
+	 */
+	BUG_ON(!failsafe);
 	return NULL;
 }
 
@@ -630,9 +637,7 @@ static void __init init_cpu_ftr_reg(u32 sys_reg, u64 new)
 	u64 valid_mask = 0;
 
 	const struct arm64_ftr_bits *ftrp;
-	struct arm64_ftr_reg *reg = get_arm64_ftr_reg(sys_reg);
-
-	BUG_ON(!reg);
+	struct arm64_ftr_reg *reg = get_arm64_ftr_reg(sys_reg, false);
 
 	for (ftrp = reg->ftr_bits; ftrp->width; ftrp++) {
 		u64 ftr_mask = arm64_ftr_mask(ftrp);
@@ -760,9 +765,8 @@ static void update_cpu_ftr_reg(struct arm64_ftr_reg *reg, u64 new)
 
 static int check_update_ftr_reg(u32 sys_id, int cpu, u64 val, u64 boot)
 {
-	struct arm64_ftr_reg *regp = get_arm64_ftr_reg(sys_id);
+	struct arm64_ftr_reg *regp = get_arm64_ftr_reg(sys_id, false);
 
-	BUG_ON(!regp);
 	update_cpu_ftr_reg(regp, val);
 	if ((boot & regp->strict_mask) == (val & regp->strict_mask))
 		return 0;
@@ -774,10 +778,7 @@ static int check_update_ftr_reg(u32 sys_id, int cpu, u64 val, u64 boot)
 static void relax_cpu_ftr_reg(u32 sys_id, int field)
 {
 	const struct arm64_ftr_bits *ftrp;
-	struct arm64_ftr_reg *regp = get_arm64_ftr_reg(sys_id);
-
-	if (WARN_ON(!regp))
-		return;
+	struct arm64_ftr_reg *regp = get_arm64_ftr_reg(sys_id, false);
 
 	for (ftrp = regp->ftr_bits; ftrp->width; ftrp++) {
 		if (ftrp->shift == field) {
@@ -959,10 +960,9 @@ void update_cpu_features(int cpu,
 
 u64 read_sanitised_ftr_reg(u32 id)
 {
-	struct arm64_ftr_reg *regp = get_arm64_ftr_reg(id);
+	struct arm64_ftr_reg *regp = get_arm64_ftr_reg(id, false);
 
 	/* We shouldn't get a request for an unsupported register */
-	BUG_ON(!regp);
 	return regp->sys_val;
 }
 
@@ -2565,7 +2565,7 @@ static int emulate_sys_reg(u32 id, u64 *valp)
 	if (sys_reg_CRm(id) == 0)
 		return emulate_id_reg(id, valp);
 
-	regp = get_arm64_ftr_reg(id);
+	regp = get_arm64_ftr_reg(id, true);
 	if (regp)
 		*valp = arm64_ftr_reg_user_value(regp);
 	else
-- 
2.20.1

