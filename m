Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C225C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 02:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E53192070C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 02:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgGCCty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 22:49:54 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:59355 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725937AbgGCCtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 22:49:53 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0U1XOWLP_1593744590;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0U1XOWLP_1593744590)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 03 Jul 2020 10:49:51 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc:     baolin.wang@linux.alibaba.com, baolin.wang7@gmail.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] nvme-pci: Use the consistent return type of nvme_pci_iod_alloc_size()
Date:   Fri,  3 Jul 2020 10:49:23 +0800
Message-Id: <f6a3c779f68ae170076ea37a721c9c06a9dc70f3.1593743937.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1593743937.git.baolin.wang@linux.alibaba.com>
References: <cover.1593743937.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1593743937.git.baolin.wang@linux.alibaba.com>
References: <cover.1593743937.git.baolin.wang@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nvme_pci_iod_alloc_size() should return 'size_t' type to keep
consistent.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 63bfb8b..235ba34 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -362,7 +362,7 @@ static int nvme_pci_npages_sgl(unsigned int num_seg)
 	return DIV_ROUND_UP(num_seg * sizeof(struct nvme_sgl_desc), PAGE_SIZE);
 }
 
-static unsigned int nvme_pci_iod_alloc_size(struct nvme_dev *dev,
+static size_t nvme_pci_iod_alloc_size(struct nvme_dev *dev,
 		unsigned int size, unsigned int nseg, bool use_sgl)
 {
 	size_t alloc_size;
-- 
1.8.3.1

