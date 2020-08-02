Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA03C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 11:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15F072075B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 11:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbgHBLP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 07:15:58 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:36712 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728303AbgHBLPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 07:15:51 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R291e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01419;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0U4T1Vgt_1596366945;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0U4T1Vgt_1596366945)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 02 Aug 2020 19:15:45 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     james.smart@broadcom.com, kbusch@kernel.org, axboe@fb.com,
        hch@lst.de, sagi@grimberg.me, jthumshirn@suse.de,
        james_p_freyensee@linux.intel.com
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        tianjia.zhang@alibaba.com
Subject: [PATCH] nvme-fc: Fix wrong return value in __nvme_fc_init_request()
Date:   Sun,  2 Aug 2020 19:15:45 +0800
Message-Id: <20200802111545.5566-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On an error exit path, a negative error code should be returned
instead of a positive return value.

Fixes: e399441de9115 ("nvme-fabrics: Add host support for FC transport")
Cc: James Smart <jsmart2021@gmail.com>
Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 drivers/nvme/host/fc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index e999a8c4b7e8..2e06f8f4cff1 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2075,7 +2075,7 @@ __nvme_fc_init_request(struct nvme_fc_ctrl *ctrl,
 	if (fc_dma_mapping_error(ctrl->lport->dev, op->fcp_req.cmddma)) {
 		dev_err(ctrl->dev,
 			"FCP Op failed - cmdiu dma mapping failed.\n");
-		ret = EFAULT;
+		ret = -EFAULT;
 		goto out_on_error;
 	}
 
@@ -2085,7 +2085,7 @@ __nvme_fc_init_request(struct nvme_fc_ctrl *ctrl,
 	if (fc_dma_mapping_error(ctrl->lport->dev, op->fcp_req.rspdma)) {
 		dev_err(ctrl->dev,
 			"FCP Op failed - rspiu dma mapping failed.\n");
-		ret = EFAULT;
+		ret = -EFAULT;
 	}
 
 	atomic_set(&op->state, FCPOP_STATE_IDLE);
-- 
2.26.2

