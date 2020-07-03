Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2118C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 02:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2E44208FE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 02:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgGCCuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 22:50:01 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:53731 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726323AbgGCCt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 22:49:59 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0U1XFpVY_1593744595;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U1XFpVY_1593744595)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 03 Jul 2020 10:49:56 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc:     baolin.wang@linux.alibaba.com, baolin.wang7@gmail.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] nvme-pci: Use standard block status macro
Date:   Fri,  3 Jul 2020 10:49:24 +0800
Message-Id: <a14bca482584d912d72209c6edab6b77b1a924f2.1593743937.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1593743937.git.baolin.wang@linux.alibaba.com>
References: <cover.1593743937.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1593743937.git.baolin.wang@linux.alibaba.com>
References: <cover.1593743937.git.baolin.wang@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use standard block status macro.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 drivers/nvme/host/pci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 235ba34..616163a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -762,7 +762,7 @@ static blk_status_t nvme_setup_prp_simple(struct nvme_dev *dev,
 	cmnd->dptr.prp1 = cpu_to_le64(iod->first_dma);
 	if (bv->bv_len > first_prp_len)
 		cmnd->dptr.prp2 = cpu_to_le64(iod->first_dma + first_prp_len);
-	return 0;
+	return BLK_STS_OK;
 }
 
 static blk_status_t nvme_setup_sgl_simple(struct nvme_dev *dev,
@@ -780,7 +780,7 @@ static blk_status_t nvme_setup_sgl_simple(struct nvme_dev *dev,
 	cmnd->dptr.sgl.addr = cpu_to_le64(iod->first_dma);
 	cmnd->dptr.sgl.length = cpu_to_le32(iod->dma_len);
 	cmnd->dptr.sgl.type = NVME_SGL_FMT_DATA_DESC << 4;
-	return 0;
+	return BLK_STS_OK;
 }
 
 static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
@@ -844,7 +844,7 @@ static blk_status_t nvme_map_metadata(struct nvme_dev *dev, struct request *req,
 	if (dma_mapping_error(dev->dev, iod->meta_dma))
 		return BLK_STS_IOERR;
 	cmnd->rw.metadata = cpu_to_le64(iod->meta_dma);
-	return 0;
+	return BLK_STS_OK;
 }
 
 /*
-- 
1.8.3.1

