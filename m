Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B58C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 14:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 931A620739
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 14:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbgFPOED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 10:04:03 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6346 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729007AbgFPOEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 10:04:00 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id BDC26A55E90A4815332F;
        Tue, 16 Jun 2020 22:03:57 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Tue, 16 Jun 2020 22:03:51 +0800
From:   John Garry <john.garry@huawei.com>
To:     <will@kernel.org>, <robin.murphy@arm.com>
CC:     <joro@8bytes.org>, <trivial@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <maz@kernel.org>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH RFC v2 2/4] iommu/arm-smmu-v3: Calculate bits for prod and owner
Date:   Tue, 16 Jun 2020 21:59:51 +0800
Message-ID: <1592315993-164290-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1592315993-164290-1-git-send-email-john.garry@huawei.com>
References: <1592315993-164290-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the arm_smmu_ll_queue.prod will be for counting the "owner" value
and also HW prod pointer, calculate how many bits are available for and
used by each.

This is based on the number of possible CPUs in the system. And we require
that each CPU can issue a minimum of 2 commands per batch - 1 x CMD_SYNC
and at least 1 x other.

Ignoring limits of HW max_n_shift and HW cmdq memory allocation, approx 16K
is the max supported CPUs. For this, max_n_shift would be 14.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/iommu/arm-smmu-v3.c | 41 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index a8e814c652fe..c3562dc35d45 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -532,6 +532,8 @@ struct arm_smmu_ll_queue {
 		u8			__pad[SMP_CACHE_BYTES];
 	} ____cacheline_aligned_in_smp;
 	u32				max_n_shift;
+	u32				max_cmd_per_batch;
+	u32				owner_count_shift;
 };
 
 struct arm_smmu_queue {
@@ -1515,7 +1517,10 @@ static void arm_smmu_cmdq_batch_add(struct arm_smmu_device *smmu,
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
@@ -3141,8 +3146,26 @@ static int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 				   unsigned long cons_off,
 				   size_t dwords, const char *name)
 {
+	int cpus = num_possible_cpus();
 	size_t qsz;
 
+	/*
+	 * We can get the number of bits required for owner counting by
+	 * log2(nr possible cpus) + 1
+	 */
+	int bits_for_cmdq_owner = ilog2(cpus) + 1;
+	/*
+	 * 1-bit for overflow, 1-bit for wrap, 1-bit extra to ensure prod+wrap
+	 * does not overflow into CPU count.
+	 */
+	int bits_available_for_prod = 32 - 3 - bits_for_cmdq_owner;
+	int entries_for_prod;
+
+	if (bits_available_for_prod < 1) /* How many CPUs??? */
+		return -ENOMEM;
+
+	q->llq.max_n_shift = min_t(int, q->llq.max_n_shift,
+				   bits_available_for_prod);
 	do {
 		qsz = ((1 << q->llq.max_n_shift) * dwords) << 3;
 		q->base = dmam_alloc_coherent(smmu->dev, qsz, &q->base_dma,
@@ -3152,6 +3175,22 @@ static int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 
 		q->llq.max_n_shift--;
 	} while (1);
+	entries_for_prod = 1 << q->llq.max_n_shift;
+
+	/*
+	 * We need at least 2 commands in a batch (1 x CMD_SYNC and 1 x
+	 * whatever else).
+	 */
+	if (entries_for_prod < 2 * cpus)
+		return -ENOMEM;
+
+	/*
+	 * When finding max_cmd_per_batch, deduct 1 entry per batch to take
+	 * account CMD_SYNC
+	 */
+	q->llq.max_cmd_per_batch = min_t(u32, (entries_for_prod - cpus) / cpus,
+					 CMDQ_BATCH_ENTRIES);
+	q->llq.owner_count_shift = q->llq.max_n_shift + 2;
 
 	if (!q->base) {
 		dev_err(smmu->dev,
-- 
2.26.2

