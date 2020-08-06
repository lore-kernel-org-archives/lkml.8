Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B4FC43463
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ECAB23128
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbgHFFoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 01:44:11 -0400
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:51712 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726093AbgHFFoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 01:44:11 -0400
Received: from localhost.localdomain ([93.22.39.163])
        by mwinf5d76 with ME
        id C5k62300S3XCSdH035k7mn; Thu, 06 Aug 2020 07:44:07 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 06 Aug 2020 07:44:07 +0200
X-ME-IP: 93.22.39.163
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] tty: synclink_gt: switch from 'pci_' to 'dma_' API
Date:   Thu,  6 Aug 2020 07:44:04 +0200
Message-Id: <20200806054404.728854-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The wrappers in include/linux/pci-dma-compat.h should go away.

The patch has been generated with the coccinelle script below and has been
hand modified to replace GFP_ with a correct flag.
It has been compile tested.

When memory is allocated in 'alloc_desc()' and 'alloc_bufs()', GFP_KERNEL
can be used because it is only called from a probe function and no lock is
acquired.
The call chain is:
   init_one                    (the probe function)
      --> device_init
         --> alloc_dma_bufs
            --> alloc_desc
            --> alloc_bufs

@@
@@
-    PCI_DMA_BIDIRECTIONAL
+    DMA_BIDIRECTIONAL

@@
@@
-    PCI_DMA_TODEVICE
+    DMA_TO_DEVICE

@@
@@
-    PCI_DMA_FROMDEVICE
+    DMA_FROM_DEVICE

@@
@@
-    PCI_DMA_NONE
+    DMA_NONE

@@
expression e1, e2, e3;
@@
-    pci_alloc_consistent(e1, e2, e3)
+    dma_alloc_coherent(&e1->dev, e2, e3, GFP_)

@@
expression e1, e2, e3;
@@
-    pci_zalloc_consistent(e1, e2, e3)
+    dma_alloc_coherent(&e1->dev, e2, e3, GFP_)

@@
expression e1, e2, e3, e4;
@@
-    pci_free_consistent(e1, e2, e3, e4)
+    dma_free_coherent(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_map_single(e1, e2, e3, e4)
+    dma_map_single(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_unmap_single(e1, e2, e3, e4)
+    dma_unmap_single(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4, e5;
@@
-    pci_map_page(e1, e2, e3, e4, e5)
+    dma_map_page(&e1->dev, e2, e3, e4, e5)

@@
expression e1, e2, e3, e4;
@@
-    pci_unmap_page(e1, e2, e3, e4)
+    dma_unmap_page(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_map_sg(e1, e2, e3, e4)
+    dma_map_sg(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_unmap_sg(e1, e2, e3, e4)
+    dma_unmap_sg(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_dma_sync_single_for_cpu(e1, e2, e3, e4)
+    dma_sync_single_for_cpu(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_dma_sync_single_for_device(e1, e2, e3, e4)
+    dma_sync_single_for_device(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_dma_sync_sg_for_cpu(e1, e2, e3, e4)
+    dma_sync_sg_for_cpu(&e1->dev, e2, e3, e4)

@@
expression e1, e2, e3, e4;
@@
-    pci_dma_sync_sg_for_device(e1, e2, e3, e4)
+    dma_sync_sg_for_device(&e1->dev, e2, e3, e4)

@@
expression e1, e2;
@@
-    pci_dma_mapping_error(e1, e2)
+    dma_mapping_error(&e1->dev, e2)

@@
expression e1, e2;
@@
-    pci_set_dma_mask(e1, e2)
+    dma_set_mask(&e1->dev, e2)

@@
expression e1, e2;
@@
-    pci_set_consistent_dma_mask(e1, e2)
+    dma_set_coherent_mask(&e1->dev, e2)

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
If needed, see post from Christoph Hellwig on the kernel-janitors ML:
   https://marc.info/?l=kernel-janitors&m=158745678307186&w=4
---
 drivers/tty/synclink_gt.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
index b794177ccfb9..1edf06653148 100644
--- a/drivers/tty/synclink_gt.c
+++ b/drivers/tty/synclink_gt.c
@@ -3341,8 +3341,8 @@ static int alloc_desc(struct slgt_info *info)
 	unsigned int pbufs;
 
 	/* allocate memory to hold descriptor lists */
-	info->bufs = pci_zalloc_consistent(info->pdev, DESC_LIST_SIZE,
-					   &info->bufs_dma_addr);
+	info->bufs = dma_alloc_coherent(&info->pdev->dev, DESC_LIST_SIZE,
+					&info->bufs_dma_addr, GFP_KERNEL);
 	if (info->bufs == NULL)
 		return -ENOMEM;
 
@@ -3384,7 +3384,8 @@ static int alloc_desc(struct slgt_info *info)
 static void free_desc(struct slgt_info *info)
 {
 	if (info->bufs != NULL) {
-		pci_free_consistent(info->pdev, DESC_LIST_SIZE, info->bufs, info->bufs_dma_addr);
+		dma_free_coherent(&info->pdev->dev, DESC_LIST_SIZE,
+				  info->bufs, info->bufs_dma_addr);
 		info->bufs  = NULL;
 		info->rbufs = NULL;
 		info->tbufs = NULL;
@@ -3395,7 +3396,9 @@ static int alloc_bufs(struct slgt_info *info, struct slgt_desc *bufs, int count)
 {
 	int i;
 	for (i=0; i < count; i++) {
-		if ((bufs[i].buf = pci_alloc_consistent(info->pdev, DMABUFSIZE, &bufs[i].buf_dma_addr)) == NULL)
+		bufs[i].buf = dma_alloc_coherent(&info->pdev->dev, DMABUFSIZE,
+						 &bufs[i].buf_dma_addr, GFP_KERNEL);
+		if (!bufs[i].buf)
 			return -ENOMEM;
 		bufs[i].pbuf  = cpu_to_le32((unsigned int)bufs[i].buf_dma_addr);
 	}
@@ -3408,7 +3411,8 @@ static void free_bufs(struct slgt_info *info, struct slgt_desc *bufs, int count)
 	for (i=0; i < count; i++) {
 		if (bufs[i].buf == NULL)
 			continue;
-		pci_free_consistent(info->pdev, DMABUFSIZE, bufs[i].buf, bufs[i].buf_dma_addr);
+		dma_free_coherent(&info->pdev->dev, DMABUFSIZE, bufs[i].buf,
+				  bufs[i].buf_dma_addr);
 		bufs[i].buf = NULL;
 	}
 }
-- 
2.25.1

