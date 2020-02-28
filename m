Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20816C3F2CF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 08:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02FE5246A8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 08:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgB1IeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 03:34:11 -0500
Received: from smtprelay0226.hostedemail.com ([216.40.44.226]:49499 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726878AbgB1IeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 03:34:09 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 221B0100E7B44;
        Fri, 28 Feb 2020 08:34:08 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: brush18_7b52a4ec66d21
X-Filterd-Recvd-Size: 3144
Received: from joe-laptop.perches.com (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Feb 2020 08:34:07 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] parport_pc: Convert DPRINTK to pr_debug
Date:   Fri, 28 Feb 2020 00:32:17 -0800
Message-Id: <5b593b232ea1d152921a4fcace78b2ad9c4180b8.1582878394.git.joe@perches.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1582878393.git.joe@perches.com>
References: <cover.1582878393.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a more common logging style.

Miscellanea:

o One message converted from KERN_INFO to KERN_DEBUG

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/parport/parport_pc.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
index ab3b04f..aae03b 100644
--- a/drivers/parport/parport_pc.c
+++ b/drivers/parport/parport_pc.c
@@ -87,13 +87,6 @@
 
 #undef DEBUG
 
-#ifdef DEBUG
-#define DPRINTK  printk
-#else
-#define DPRINTK(stuff...)
-#endif
-
-
 #define NR_SUPERIOS 3
 static struct superio_struct {	/* For Super-IO chips autodetection */
 	int io;
@@ -118,8 +111,8 @@ static void frob_econtrol(struct parport *pb, unsigned char m,
 	if (m != 0xff)
 		ectr = inb(ECONTROL(pb));
 
-	DPRINTK(KERN_DEBUG "frob_econtrol(%02x,%02x): %02x -> %02x\n",
-		m, v, ectr, (ectr & ~m) ^ v);
+	pr_debug("frob_econtrol(%02x,%02x): %02x -> %02x\n",
+		 m, v, ectr, (ectr & ~m) ^ v);
 
 	outb((ectr & ~m) ^ v, ECONTROL(pb));
 }
@@ -142,7 +135,7 @@ static int change_mode(struct parport *p, int m)
 	unsigned char oecr;
 	int mode;
 
-	DPRINTK(KERN_INFO "parport change_mode ECP-ISA to mode 0x%02x\n", m);
+	pr_debug("parport change_mode ECP-ISA to mode 0x%02x\n", m);
 
 	if (!priv->ecr) {
 		printk(KERN_DEBUG "change_mode: but there's no ECR!\n");
@@ -2295,7 +2288,7 @@ static int sio_ite_8872_probe(struct pci_dev *pdev, int autoirq, int autodma,
 	int irq;
 	int i;
 
-	DPRINTK(KERN_DEBUG "sio_ite_8872_probe()\n");
+	pr_debug("sio_ite_8872_probe()\n");
 
 	/* make sure which one chip */
 	for (i = 0; i < 5; i++) {
@@ -2360,11 +2353,9 @@ static int sio_ite_8872_probe(struct pci_dev *pdev, int autoirq, int autodma,
 	pci_write_config_dword(pdev, 0x9c,
 				ite8872set | (ite8872_irq * 0x11111));
 
-	DPRINTK(KERN_DEBUG "ITE887x: The IRQ is %d.\n", ite8872_irq);
-	DPRINTK(KERN_DEBUG "ITE887x: The PARALLEL I/O port is 0x%x.\n",
-		 ite8872_lpt);
-	DPRINTK(KERN_DEBUG "ITE887x: The PARALLEL I/O porthi is 0x%x.\n",
-		 ite8872_lpthi);
+	pr_debug("ITE887x: The IRQ is %d\n", ite8872_irq);
+	pr_debug("ITE887x: The PARALLEL I/O port is 0x%x\n", ite8872_lpt);
+	pr_debug("ITE887x: The PARALLEL I/O porthi is 0x%x\n", ite8872_lpthi);
 
 	/* Let the user (or defaults) steer us away from interrupts */
 	irq = ite8872_irq;
-- 
2.24.0

