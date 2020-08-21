Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34C7C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 13:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7A6E20720
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 13:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbgHUN6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 09:58:43 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10304 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727123AbgHUN60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 09:58:26 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1F74097332D8AA97487D;
        Fri, 21 Aug 2020 21:58:15 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Fri, 21 Aug 2020 21:58:04 +0800
From:   John Garry <john.garry@huawei.com>
To:     <will@kernel.org>, <robin.murphy@arm.com>
CC:     <joro@8bytes.org>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <maz@kernel.org>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v2 1/2] iommu/arm-smmu-v3: Calculate max commands per batch
Date:   Fri, 21 Aug 2020 21:54:21 +0800
Message-ID: <1598018062-175608-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1598018062-175608-1-git-send-email-john.garry@huawei.com>
References: <1598018062-175608-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calculate the batch size limit such that all CPUs in the system cannot
issue so many commands as to fill the command queue.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 46 +++++++++++++++++++--
 1 file changed, 42 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 7196207be7ea..a705fa3e18ea 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -532,6 +532,7 @@ struct arm_smmu_ll_queue {
 		u8			__pad[SMP_CACHE_BYTES];
 	} ____cacheline_aligned_in_smp;
 	u32				max_n_shift;
+	u32				max_cmd_per_batch;
 };
 
 struct arm_smmu_queue {
@@ -1515,7 +1516,10 @@ static void arm_smmu_cmdq_batch_add(struct arm_smmu_device *smmu,
 				    struct arm_smmu_cmdq_batch *cmds,
 				    struct arm_smmu_cmdq_ent *cmd)
 {
-	if (cmds->num == CMDQ_BATCH_ENTRIES) {
+	struct arm_smmu_cmdq *q = &smmu->cmdq;
+	struct arm_smmu_ll_queue *llq = &q->q.llq;
+
+	if (cmds->num == llq->max_cmd_per_batch) {
 		arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmds, cmds->num, false);
 		cmds->num = 0;
 	}
@@ -3177,6 +3181,41 @@ static int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 	return 0;
 }
 
+static int arm_smmu_init_cmd_queue(struct arm_smmu_device *smmu,
+				   struct arm_smmu_queue *q,
+				   unsigned long prod_off,
+				   unsigned long cons_off,
+				   size_t dwords)
+{
+	u32 cpus = num_possible_cpus(), entries_for_prod;
+	int ret;
+
+	ret = arm_smmu_init_one_queue(smmu, q, prod_off, cons_off, dwords,
+				      "cmdq");
+	if (ret)
+		return ret;
+
+	entries_for_prod = 1 << q->llq.max_n_shift;
+
+	/*
+	 * We need at least 2 commands in a batch (1 x CMD_SYNC and 1 x
+	 * whatever else).
+	 */
+	if (entries_for_prod < 2 * cpus) {
+		dev_err(smmu->dev, "command queue size too small, suggest reduce #CPUs\n");
+		return -ENXIO;
+	}
+
+	/*
+	 * When finding max_cmd_per_batch, deduct 1 entry per batch to take
+	 * account of a CMD_SYNC being issued also.
+	 */
+	q->llq.max_cmd_per_batch = min((entries_for_prod / cpus) - 1,
+				       (u32)CMDQ_BATCH_ENTRIES);
+
+	return 0;
+}
+
 static void arm_smmu_cmdq_free_bitmap(void *data)
 {
 	unsigned long *bitmap = data;
@@ -3210,9 +3249,8 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
 	int ret;
 
 	/* cmdq */
-	ret = arm_smmu_init_one_queue(smmu, &smmu->cmdq.q, ARM_SMMU_CMDQ_PROD,
-				      ARM_SMMU_CMDQ_CONS, CMDQ_ENT_DWORDS,
-				      "cmdq");
+	ret = arm_smmu_init_cmd_queue(smmu, &smmu->cmdq.q, ARM_SMMU_CMDQ_PROD,
+				      ARM_SMMU_CMDQ_CONS, CMDQ_ENT_DWORDS);
 	if (ret)
 		return ret;
 
-- 
2.26.2

