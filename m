Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8606FC4345A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 23:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BF82214DB
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 23:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbgGPXJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 19:09:45 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:34356 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728006AbgGPXJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 19:09:22 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 554288012DFCE76CF193;
        Fri, 17 Jul 2020 07:09:19 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.203.111) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Fri, 17 Jul 2020 07:09:12 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <robin.murphy@arm.com>, <will@kernel.org>, <joro@8bytes.org>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Prime Zeng <prime.zeng@hisilicon.com>
Subject: [PATCH] iommu/arm-smmu-v3: remove the approach of MSI polling for CMD SYNC
Date:   Fri, 17 Jul 2020 11:07:09 +1200
Message-ID: <20200716230709.32820-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.203.111]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before commit 587e6c10a7ce ("iommu/arm-smmu-v3: Reduce contention during
command-queue insertion"), msi polling perhaps performed better since
it could run outside the spin_lock_irqsave() while the code polling cons
reg was running in the lock.

But after the great reorganization of smmu queue, neither of these two
polling methods are running in a spinlock. And real tests show polling
cons reg via sev means smaller latency. It is probably because polling
by msi will ask hardware to write memory but sev polling depends on the
update of register only.

Using 16 threads to run netperf on hns3 100G NIC with UDP packet size
in 32768bytes and set iommu to strict, TX throughput can improve from
25227.74Mbps to 27145.59Mbps by this patch. In this case, SMMU is super
busy as hns3 sends map/unmap requests extremely frequently.

Cc: Prime Zeng <prime.zeng@hisilicon.com>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 drivers/iommu/arm-smmu-v3.c | 46 +------------------------------------
 1 file changed, 1 insertion(+), 45 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index f578677a5c41..e55282a636c8 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -964,12 +964,7 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 		cmd[1] |= FIELD_PREP(CMDQ_PRI_1_RESP, ent->pri.resp);
 		break;
 	case CMDQ_OP_CMD_SYNC:
-		if (ent->sync.msiaddr) {
-			cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_IRQ);
-			cmd[1] |= ent->sync.msiaddr & CMDQ_SYNC_1_MSIADDR_MASK;
-		} else {
-			cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_SEV);
-		}
+		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_SEV);
 		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSH, ARM_SMMU_SH_ISH);
 		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_MSIATTR, ARM_SMMU_MEMATTR_OIWB);
 		break;
@@ -983,21 +978,10 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 static void arm_smmu_cmdq_build_sync_cmd(u64 *cmd, struct arm_smmu_device *smmu,
 					 u32 prod)
 {
-	struct arm_smmu_queue *q = &smmu->cmdq.q;
 	struct arm_smmu_cmdq_ent ent = {
 		.opcode = CMDQ_OP_CMD_SYNC,
 	};
 
-	/*
-	 * Beware that Hi16xx adds an extra 32 bits of goodness to its MSI
-	 * payload, so the write will zero the entire command on that platform.
-	 */
-	if (smmu->features & ARM_SMMU_FEAT_MSI &&
-	    smmu->features & ARM_SMMU_FEAT_COHERENCY) {
-		ent.sync.msiaddr = q->base_dma + Q_IDX(&q->llq, prod) *
-				   q->ent_dwords * 8;
-	}
-
 	arm_smmu_cmdq_build_cmd(cmd, &ent);
 }
 
@@ -1251,30 +1235,6 @@ static int arm_smmu_cmdq_poll_until_not_full(struct arm_smmu_device *smmu,
 	return ret;
 }
 
-/*
- * Wait until the SMMU signals a CMD_SYNC completion MSI.
- * Must be called with the cmdq lock held in some capacity.
- */
-static int __arm_smmu_cmdq_poll_until_msi(struct arm_smmu_device *smmu,
-					  struct arm_smmu_ll_queue *llq)
-{
-	int ret = 0;
-	struct arm_smmu_queue_poll qp;
-	struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
-	u32 *cmd = (u32 *)(Q_ENT(&cmdq->q, llq->prod));
-
-	queue_poll_init(smmu, &qp);
-
-	/*
-	 * The MSI won't generate an event, since it's being written back
-	 * into the command queue.
-	 */
-	qp.wfe = false;
-	smp_cond_load_relaxed(cmd, !VAL || (ret = queue_poll(&qp)));
-	llq->cons = ret ? llq->prod : queue_inc_prod_n(llq, 1);
-	return ret;
-}
-
 /*
  * Wait until the SMMU cons index passes llq->prod.
  * Must be called with the cmdq lock held in some capacity.
@@ -1332,10 +1292,6 @@ static int __arm_smmu_cmdq_poll_until_consumed(struct arm_smmu_device *smmu,
 static int arm_smmu_cmdq_poll_until_sync(struct arm_smmu_device *smmu,
 					 struct arm_smmu_ll_queue *llq)
 {
-	if (smmu->features & ARM_SMMU_FEAT_MSI &&
-	    smmu->features & ARM_SMMU_FEAT_COHERENCY)
-		return __arm_smmu_cmdq_poll_until_msi(smmu, llq);
-
 	return __arm_smmu_cmdq_poll_until_consumed(smmu, llq);
 }
 
-- 
2.27.0


