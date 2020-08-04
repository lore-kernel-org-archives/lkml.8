Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA783C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 20:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD2E9207FC
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 20:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgHDUTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 16:19:30 -0400
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:58736 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727064AbgHDUT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 16:19:29 -0400
Received: from localhost.localdomain ([93.23.13.33])
        by mwinf5d72 with ME
        id BYKS230060in9Tx03YKStB; Tue, 04 Aug 2020 22:19:27 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 04 Aug 2020 22:19:27 +0200
X-ME-IP: 93.23.13.33
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     kevin.curtis@farsite.co.uk, davem@davemloft.net, kuba@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] farsync: switch from 'pci_' to 'dma_' API
Date:   Tue,  4 Aug 2020 22:19:24 +0200
Message-Id: <20200804201924.717142-1-christophe.jaillet@wanadoo.fr>
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

When memory is allocated in 'fst_add_one()', GFP_KERNEL can be used
because it is a probe function and no lock is acquired.


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
 drivers/net/wan/farsync.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wan/farsync.c b/drivers/net/wan/farsync.c
index 5ff249b76525..b50cf11d197d 100644
--- a/drivers/net/wan/farsync.c
+++ b/drivers/net/wan/farsync.c
@@ -2553,16 +2553,16 @@ fst_add_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		 * Allocate a dma buffer for transmit and receives
 		 */
 		card->rx_dma_handle_host =
-		    pci_alloc_consistent(card->device, FST_MAX_MTU,
-					 &card->rx_dma_handle_card);
+		    dma_alloc_coherent(&card->device->dev, FST_MAX_MTU,
+				       &card->rx_dma_handle_card, GFP_KERNEL);
 		if (card->rx_dma_handle_host == NULL) {
 			pr_err("Could not allocate rx dma buffer\n");
 			err = -ENOMEM;
 			goto rx_dma_fail;
 		}
 		card->tx_dma_handle_host =
-		    pci_alloc_consistent(card->device, FST_MAX_MTU,
-					 &card->tx_dma_handle_card);
+		    dma_alloc_coherent(&card->device->dev, FST_MAX_MTU,
+				       &card->tx_dma_handle_card, GFP_KERNEL);
 		if (card->tx_dma_handle_host == NULL) {
 			pr_err("Could not allocate tx dma buffer\n");
 			err = -ENOMEM;
@@ -2572,9 +2572,8 @@ fst_add_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	return 0;		/* Success */
 
 tx_dma_fail:
-	pci_free_consistent(card->device, FST_MAX_MTU,
-			    card->rx_dma_handle_host,
-			    card->rx_dma_handle_card);
+	dma_free_coherent(&card->device->dev, FST_MAX_MTU,
+			  card->rx_dma_handle_host, card->rx_dma_handle_card);
 rx_dma_fail:
 	fst_disable_intr(card);
 	for (i = 0 ; i < card->nports ; i++)
@@ -2625,12 +2624,12 @@ fst_remove_one(struct pci_dev *pdev)
 		/*
 		 * Free dma buffers
 		 */
-		pci_free_consistent(card->device, FST_MAX_MTU,
-				    card->rx_dma_handle_host,
-				    card->rx_dma_handle_card);
-		pci_free_consistent(card->device, FST_MAX_MTU,
-				    card->tx_dma_handle_host,
-				    card->tx_dma_handle_card);
+		dma_free_coherent(&card->device->dev, FST_MAX_MTU,
+				  card->rx_dma_handle_host,
+				  card->rx_dma_handle_card);
+		dma_free_coherent(&card->device->dev, FST_MAX_MTU,
+				  card->tx_dma_handle_host,
+				  card->tx_dma_handle_card);
 	}
 	fst_card_array[card->card_no] = NULL;
 }
-- 
2.25.1

