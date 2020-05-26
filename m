Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D208C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 13:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CA5C2068D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 13:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731650AbgEZNkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 09:40:06 -0400
Received: from foss.arm.com ([217.140.110.172]:50872 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728048AbgEZNkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 09:40:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 761031FB;
        Tue, 26 May 2020 06:40:05 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.78.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 459F83F6C4;
        Tue, 26 May 2020 06:40:02 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     mark.rutland@arm.com,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V2] arm64/cpufeature: Add get_arm64_ftr_reg_nowarn()
Date:   Tue, 26 May 2020 19:09:13 +0530
Message-Id: <1590500353-28082-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no way to proceed when requested register could not be searched in
arm64_ftr_reg[]. Requesting for a non present register would be an error as
well. Hence lets just WARN_ON() when search fails in get_arm64_ftr_reg()
rather than checking for return value and doing a BUG_ON() instead in some
individual callers. But there are also caller instances that dont error out
when register search fails. Add a new helper get_arm64_ftr_reg_nowarn() for
such cases.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
Changes in V2:

- Added get_arm64_ftr_reg_nowarn() per Will
- read_sanitised_ftr_reg() returns 0 when register search fails per Catalin

Changes in V1: (https://patchwork.kernel.org/patch/11559083/)

 arch/arm64/kernel/cpufeature.c | 42 +++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index bc5048f152c1..f4555b9d145c 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -548,16 +548,16 @@ static int search_cmp_ftr_reg(const void *id, const void *regp)
 }
 
 /*
- * get_arm64_ftr_reg - Lookup a feature register entry using its
- * sys_reg() encoding. With the array arm64_ftr_regs sorted in the
- * ascending order of sys_id , we use binary search to find a matching
+ * get_arm64_ftr_reg_nowarn - Looks up a feature register entry using
+ * its sys_reg() encoding. With the array arm64_ftr_regs sorted in the
+ * ascending order of sys_id, we use binary search to find a matching
  * entry.
  *
  * returns - Upon success,  matching ftr_reg entry for id.
  *         - NULL on failure. It is upto the caller to decide
  *	     the impact of a failure.
  */
-static struct arm64_ftr_reg *get_arm64_ftr_reg(u32 sys_id)
+static struct arm64_ftr_reg *get_arm64_ftr_reg_nowarn(u32 sys_id)
 {
 	const struct __ftr_reg_entry *ret;
 
@@ -571,6 +571,28 @@ static struct arm64_ftr_reg *get_arm64_ftr_reg(u32 sys_id)
 	return NULL;
 }
 
+/*
+ * get_arm64_ftr_reg - Looks up a feature register entry using
+ * its sys_reg() encoding. This calls get_arm64_ftr_reg_nowarn().
+ *
+ * returns - Upon success,  matching ftr_reg entry for id.
+ *         - NULL on failure but with an WARN_ON().
+ */
+static struct arm64_ftr_reg *get_arm64_ftr_reg(u32 sys_id)
+{
+	struct arm64_ftr_reg *reg;
+
+	reg = get_arm64_ftr_reg_nowarn(sys_id);
+
+	/*
+	 * Can not really proceed when the search fails here.
+	 * Requesting for a non existent register search will
+	 * be an error. Warn but let it continue for now.
+	 */
+	WARN_ON(!reg);
+	return reg;
+}
+
 static u64 arm64_ftr_set_value(const struct arm64_ftr_bits *ftrp, s64 reg,
 			       s64 ftr_val)
 {
@@ -632,8 +654,6 @@ static void __init init_cpu_ftr_reg(u32 sys_reg, u64 new)
 	const struct arm64_ftr_bits *ftrp;
 	struct arm64_ftr_reg *reg = get_arm64_ftr_reg(sys_reg);
 
-	BUG_ON(!reg);
-
 	for (ftrp = reg->ftr_bits; ftrp->width; ftrp++) {
 		u64 ftr_mask = arm64_ftr_mask(ftrp);
 		s64 ftr_new = arm64_ftr_value(ftrp, new);
@@ -762,7 +782,6 @@ static int check_update_ftr_reg(u32 sys_id, int cpu, u64 val, u64 boot)
 {
 	struct arm64_ftr_reg *regp = get_arm64_ftr_reg(sys_id);
 
-	BUG_ON(!regp);
 	update_cpu_ftr_reg(regp, val);
 	if ((boot & regp->strict_mask) == (val & regp->strict_mask))
 		return 0;
@@ -776,9 +795,6 @@ static void relax_cpu_ftr_reg(u32 sys_id, int field)
 	const struct arm64_ftr_bits *ftrp;
 	struct arm64_ftr_reg *regp = get_arm64_ftr_reg(sys_id);
 
-	if (WARN_ON(!regp))
-		return;
-
 	for (ftrp = regp->ftr_bits; ftrp->width; ftrp++) {
 		if (ftrp->shift == field) {
 			regp->strict_mask &= ~arm64_ftr_mask(ftrp);
@@ -961,8 +977,8 @@ u64 read_sanitised_ftr_reg(u32 id)
 {
 	struct arm64_ftr_reg *regp = get_arm64_ftr_reg(id);
 
-	/* We shouldn't get a request for an unsupported register */
-	BUG_ON(!regp);
+	if (!regp)
+		return 0;
 	return regp->sys_val;
 }
 
@@ -2565,7 +2581,7 @@ static int emulate_sys_reg(u32 id, u64 *valp)
 	if (sys_reg_CRm(id) == 0)
 		return emulate_id_reg(id, valp);
 
-	regp = get_arm64_ftr_reg(id);
+	regp = get_arm64_ftr_reg_nowarn(id);
 	if (regp)
 		*valp = arm64_ftr_reg_user_value(regp);
 	else
-- 
2.20.1

