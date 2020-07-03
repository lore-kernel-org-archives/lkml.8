Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33313C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 02:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E2282070C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 02:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgGCCt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 22:49:58 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:62876 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725937AbgGCCt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 22:49:56 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0U1XOWK8_1593744584;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U1XOWK8_1593744584)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 03 Jul 2020 10:49:44 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc:     baolin.wang@linux.alibaba.com, baolin.wang7@gmail.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] nvme-pci: Add a blank line after declarations
Date:   Fri,  3 Jul 2020 10:49:21 +0800
Message-Id: <dbb9c52aeb4030387a17342ca9e76fd09d84a0ed.1593743937.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1593743937.git.baolin.wang@linux.alibaba.com>
References: <cover.1593743937.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1593743937.git.baolin.wang@linux.alibaba.com>
References: <cover.1593743937.git.baolin.wang@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a blank line after declarations to make code more readable.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 drivers/nvme/host/pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a3d0c86..d0e9bbf 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1019,6 +1019,7 @@ static irqreturn_t nvme_irq(int irq, void *data)
 static irqreturn_t nvme_irq_check(int irq, void *data)
 {
 	struct nvme_queue *nvmeq = data;
+
 	if (nvme_cqe_pending(nvmeq))
 		return IRQ_WAKE_THREAD;
 	return IRQ_NONE;
@@ -1401,6 +1402,7 @@ static int nvme_cmb_qdepth(struct nvme_dev *dev, int nr_io_queues,
 
 	if (q_size_aligned * nr_io_queues > dev->cmb_size) {
 		u64 mem_per_q = div_u64(dev->cmb_size, nr_io_queues);
+
 		mem_per_q = round_down(mem_per_q, dev->ctrl.page_size);
 		q_depth = div_u64(mem_per_q, entry_size);
 
@@ -2875,6 +2877,7 @@ static void nvme_reset_done(struct pci_dev *pdev)
 static void nvme_shutdown(struct pci_dev *pdev)
 {
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
+
 	nvme_disable_prepare_reset(dev, true);
 }
 
@@ -3005,6 +3008,7 @@ static int nvme_suspend(struct device *dev)
 static int nvme_simple_suspend(struct device *dev)
 {
 	struct nvme_dev *ndev = pci_get_drvdata(to_pci_dev(dev));
+
 	return nvme_disable_prepare_reset(ndev, true);
 }
 
-- 
1.8.3.1

