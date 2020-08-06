Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157C5C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 20:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14420221E2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 20:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgHFUND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 16:13:03 -0400
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:57592 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbgHFUND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 16:13:03 -0400
Received: from localhost.localdomain ([93.22.39.179])
        by mwinf5d39 with ME
        id CAzB2300Z3rvC1Z03AzC6E; Thu, 06 Aug 2020 12:59:13 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 06 Aug 2020 12:59:13 +0200
X-ME-IP: 93.22.39.179
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] tty: serial: icom: switch from 'pci_' to 'dma_' API
Date:   Thu,  6 Aug 2020 08:05:07 +0200
Message-Id: <20200806060507.730142-1-christophe.jaillet@wanadoo.fr>
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

When memory is allocated in 'get_port_memory()', GFP_KERNEL can be used
because it is only called from a probe function and no lock is acquired.
The call chain is:
   icom_probe				(the probe function)
      --> icom_load_ports
         --> get_port_memory


When memory is allocated in 'load_code()', GFP_KERNEL can be used because
it is only called from a .startup function.
   icom_open				(the .startup function of struct uart_ops)
      --> startup
         --> load_code
.startup functions are protected using a semaphore and no spinlock is
taken.

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
 drivers/tty/serial/icom.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/icom.c b/drivers/tty/serial/icom.c
index 624f3d541c68..94c8281ddb5f 100644
--- a/drivers/tty/serial/icom.c
+++ b/drivers/tty/serial/icom.c
@@ -138,24 +138,24 @@ static void free_port_memory(struct icom_port *icom_port)
 
 	trace(icom_port, "RET_PORT_MEM", 0);
 	if (icom_port->recv_buf) {
-		pci_free_consistent(dev, 4096, icom_port->recv_buf,
-				    icom_port->recv_buf_pci);
+		dma_free_coherent(&dev->dev, 4096, icom_port->recv_buf,
+				  icom_port->recv_buf_pci);
 		icom_port->recv_buf = NULL;
 	}
 	if (icom_port->xmit_buf) {
-		pci_free_consistent(dev, 4096, icom_port->xmit_buf,
-				    icom_port->xmit_buf_pci);
+		dma_free_coherent(&dev->dev, 4096, icom_port->xmit_buf,
+				  icom_port->xmit_buf_pci);
 		icom_port->xmit_buf = NULL;
 	}
 	if (icom_port->statStg) {
-		pci_free_consistent(dev, 4096, icom_port->statStg,
-				    icom_port->statStg_pci);
+		dma_free_coherent(&dev->dev, 4096, icom_port->statStg,
+				  icom_port->statStg_pci);
 		icom_port->statStg = NULL;
 	}
 
 	if (icom_port->xmitRestart) {
-		pci_free_consistent(dev, 4096, icom_port->xmitRestart,
-				    icom_port->xmitRestart_pci);
+		dma_free_coherent(&dev->dev, 4096, icom_port->xmitRestart,
+				  icom_port->xmitRestart_pci);
 		icom_port->xmitRestart = NULL;
 	}
 }
@@ -169,7 +169,8 @@ static int get_port_memory(struct icom_port *icom_port)
 	struct pci_dev *dev = icom_port->adapter->pci_dev;
 
 	icom_port->xmit_buf =
-	    pci_alloc_consistent(dev, 4096, &icom_port->xmit_buf_pci);
+	    dma_alloc_coherent(&dev->dev, 4096, &icom_port->xmit_buf_pci,
+			       GFP_KERNEL);
 	if (!icom_port->xmit_buf) {
 		dev_err(&dev->dev, "Can not allocate Transmit buffer\n");
 		return -ENOMEM;
@@ -179,7 +180,8 @@ static int get_port_memory(struct icom_port *icom_port)
 	      (unsigned long) icom_port->xmit_buf);
 
 	icom_port->recv_buf =
-	    pci_alloc_consistent(dev, 4096, &icom_port->recv_buf_pci);
+	    dma_alloc_coherent(&dev->dev, 4096, &icom_port->recv_buf_pci,
+			       GFP_KERNEL);
 	if (!icom_port->recv_buf) {
 		dev_err(&dev->dev, "Can not allocate Receive buffer\n");
 		free_port_memory(icom_port);
@@ -189,7 +191,8 @@ static int get_port_memory(struct icom_port *icom_port)
 	      (unsigned long) icom_port->recv_buf);
 
 	icom_port->statStg =
-	    pci_alloc_consistent(dev, 4096, &icom_port->statStg_pci);
+	    dma_alloc_coherent(&dev->dev, 4096, &icom_port->statStg_pci,
+			       GFP_KERNEL);
 	if (!icom_port->statStg) {
 		dev_err(&dev->dev, "Can not allocate Status buffer\n");
 		free_port_memory(icom_port);
@@ -199,7 +202,8 @@ static int get_port_memory(struct icom_port *icom_port)
 	      (unsigned long) icom_port->statStg);
 
 	icom_port->xmitRestart =
-	    pci_alloc_consistent(dev, 4096, &icom_port->xmitRestart_pci);
+	    dma_alloc_coherent(&dev->dev, 4096, &icom_port->xmitRestart_pci,
+			       GFP_KERNEL);
 	if (!icom_port->xmitRestart) {
 		dev_err(&dev->dev,
 			"Can not allocate xmit Restart buffer\n");
@@ -414,7 +418,7 @@ static void load_code(struct icom_port *icom_port)
 	/*Set up data in icom DRAM to indicate where personality
 	 *code is located and its length.
 	 */
-	new_page = pci_alloc_consistent(dev, 4096, &temp_pci);
+	new_page = dma_alloc_coherent(&dev->dev, 4096, &temp_pci, GFP_KERNEL);
 
 	if (!new_page) {
 		dev_err(&dev->dev, "Can not allocate DMA buffer\n");
@@ -494,7 +498,7 @@ static void load_code(struct icom_port *icom_port)
 	}
 
 	if (new_page != NULL)
-		pci_free_consistent(dev, 4096, new_page, temp_pci);
+		dma_free_coherent(&dev->dev, 4096, new_page, temp_pci);
 }
 
 static int startup(struct icom_port *icom_port)
-- 
2.25.1

