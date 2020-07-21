Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951F0C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 07:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7522522C9C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 07:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbgGUHAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 03:00:39 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:2776 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726510AbgGUHAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 03:00:38 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01358;MF=shile.zhang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0U3O7OTC_1595314816;
Received: from e18g09479.et15sqa.tbsite.net(mailfrom:shile.zhang@linux.alibaba.com fp:SMTPD_---0U3O7OTC_1595314816)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Jul 2020 15:00:22 +0800
From:   Shile Zhang <shile.zhang@linux.alibaba.com>
To:     "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        kernel test robot <lkp@intel.com>,
        Jiang Liu <liuj97@gmail.com>
Subject: [PATCH v2] virtio_ring: use alloc_pages_node for NUMA-aware allocation
Date:   Tue, 21 Jul 2020 15:00:13 +0800
Message-Id: <20200721070013.62894-1-shile.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use alloc_pages_node() allocate memory for vring queue with proper
NUMA affinity.

Reported-by: kernel test robot <lkp@intel.com>
Suggested-by: Jiang Liu <liuj97@gmail.com>
Signed-off-by: Shile Zhang <shile.zhang@linux.alibaba.com>
---
Changelog
v1 -> v2:
- fixed compile warning reported by LKP.
---
 drivers/virtio/virtio_ring.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 58b96baa8d48..d38fd6872c8c 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -276,9 +276,11 @@ static void *vring_alloc_queue(struct virtio_device *vdev, size_t size,
 		return dma_alloc_coherent(vdev->dev.parent, size,
 					  dma_handle, flag);
 	} else {
-		void *queue = alloc_pages_exact(PAGE_ALIGN(size), flag);
-
-		if (queue) {
+		void *queue = NULL;
+		struct page *page = alloc_pages_node(dev_to_node(vdev->dev.parent),
+						     flag, get_order(size));
+		if (page) {
+			queue = page_address(page);
 			phys_addr_t phys_addr = virt_to_phys(queue);
 			*dma_handle = (dma_addr_t)phys_addr;
 
@@ -308,7 +310,7 @@ static void vring_free_queue(struct virtio_device *vdev, size_t size,
 	if (vring_use_dma_api(vdev))
 		dma_free_coherent(vdev->dev.parent, size, queue, dma_handle);
 	else
-		free_pages_exact(queue, PAGE_ALIGN(size));
+		free_pages((unsigned long)queue, get_order(size));
 }
 
 /*
-- 
2.24.0.rc2

