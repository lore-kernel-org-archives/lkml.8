Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9A5C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 10:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 427B720771
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 10:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbgF1KfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 06:35:02 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:41201 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725921AbgF1KfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 06:35:02 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R531e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07484;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0U0v-6Et_1593340497;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U0v-6Et_1593340497)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 28 Jun 2020 18:34:57 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc:     baolin.wang@linux.alibaba.com, baolin.wang7@gmail.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] nvme-pci: Move the sg table allocation/free into init/exit_request
Date:   Sun, 28 Jun 2020 18:34:46 +0800
Message-Id: <4eedad1efab91f4529de19e14ba374da405aea3f.1593340208.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the sg table allocation and free into the init_request() and
exit_request(), instead of allocating sg table when queuing requests,
which can benefit the IO performance.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 drivers/nvme/host/pci.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b1d18f0..cf7c997 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -410,9 +410,25 @@ static int nvme_init_request(struct blk_mq_tag_set *set, struct request *req,
 	iod->nvmeq = nvmeq;
 
 	nvme_req(req)->ctrl = &dev->ctrl;
+
+	iod->sg = mempool_alloc(dev->iod_mempool, GFP_ATOMIC);
+	if (!iod->sg)
+		return -ENOMEM;
+
+	sg_init_table(iod->sg, NVME_MAX_SEGS);
 	return 0;
 }
 
+static void nvme_exit_request(struct blk_mq_tag_set *set, struct request *req,
+			      unsigned int hctx_idx)
+{
+	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+	struct nvme_dev *dev = set->driver_data;
+
+	mempool_free(iod->sg, dev->iod_mempool);
+	iod->sg = NULL;
+}
+
 static int queue_irq_offset(struct nvme_dev *dev)
 {
 	/* if we have more than 1 vec, admin queue offsets us by 1 */
@@ -557,8 +573,6 @@ static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
 		dma_pool_free(dev->prp_page_pool, addr, dma_addr);
 		dma_addr = next_dma_addr;
 	}
-
-	mempool_free(iod->sg, dev->iod_mempool);
 }
 
 static void nvme_print_sgl(struct scatterlist *sgl, int nents)
@@ -808,10 +822,6 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 	}
 
 	iod->dma_len = 0;
-	iod->sg = mempool_alloc(dev->iod_mempool, GFP_ATOMIC);
-	if (!iod->sg)
-		return BLK_STS_RESOURCE;
-	sg_init_table(iod->sg, blk_rq_nr_phys_segments(req));
 	iod->nents = blk_rq_map_sg(req->q, req, iod->sg);
 	if (!iod->nents)
 		goto out;
@@ -1557,6 +1567,7 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid, bool polled)
 	.complete	= nvme_pci_complete_rq,
 	.init_hctx	= nvme_admin_init_hctx,
 	.init_request	= nvme_init_request,
+	.exit_request	= nvme_exit_request,
 	.timeout	= nvme_timeout,
 };
 
@@ -1566,6 +1577,7 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid, bool polled)
 	.commit_rqs	= nvme_commit_rqs,
 	.init_hctx	= nvme_init_hctx,
 	.init_request	= nvme_init_request,
+	.exit_request	= nvme_exit_request,
 	.map_queues	= nvme_pci_map_queues,
 	.timeout	= nvme_timeout,
 	.poll		= nvme_poll,
-- 
1.8.3.1

