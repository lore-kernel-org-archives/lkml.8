Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBA8C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 02:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4266E208FE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 02:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgGCCto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 22:49:44 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:53954 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725937AbgGCCto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 22:49:44 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0U1XNlnV_1593744580;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U1XNlnV_1593744580)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 03 Jul 2020 10:49:41 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc:     baolin.wang@linux.alibaba.com, baolin.wang7@gmail.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] nvme-pci: Fix some comments issues
Date:   Fri,  3 Jul 2020 10:49:20 +0800
Message-Id: <3820a0fc3c74f9a70a8856172d499de4dee3c2b7.1593743937.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1593743937.git.baolin.wang@linux.alibaba.com>
References: <cover.1593743937.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1593743937.git.baolin.wang@linux.alibaba.com>
References: <cover.1593743937.git.baolin.wang@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix comments' typo and remove whitespaces before tabs to cleanup
checkpatch errors.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 drivers/nvme/host/pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c283e8d..a3d0c86 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1260,9 +1260,9 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	}
 
 	/*
- 	 * Shutdown the controller immediately and schedule a reset if the
- 	 * command was already aborted once before and still hasn't been
- 	 * returned to the driver, or if this is the admin queue.
+	 * Shutdown the controller immediately and schedule a reset if the
+	 * command was already aborted once before and still hasn't been
+	 * returned to the driver, or if this is the admin queue.
 	 */
 	if (!nvmeq->qid || iod->aborted) {
 		dev_warn(dev->ctrl.device,
@@ -2002,7 +2002,7 @@ static void nvme_calc_irq_sets(struct irq_affinity *affd, unsigned int nrirqs)
 	unsigned int nr_read_queues, nr_write_queues = dev->nr_write_queues;
 
 	/*
-	 * If there is no interupt available for queues, ensure that
+	 * If there is no interrupt available for queues, ensure that
 	 * the default queue is set to 1. The affinity set size is
 	 * also set to one, but the irq core ignores it for this case.
 	 *
-- 
1.8.3.1

