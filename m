Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60718C2BB55
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 13:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 338CD207FF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 13:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+PKm/GO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403994AbgDCNoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 09:44:13 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35590 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390977AbgDCNnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 09:43:42 -0400
Received: by mail-wm1-f67.google.com with SMTP id i19so7791210wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 06:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BfI+j+OMPwnvX+tZGnV9Qob9U8JYQpm4qpc+j/7ff6Q=;
        b=A+PKm/GOAXCurfDaCAmsDeH/N1qSdsq7k37m4IUx8fpOhX8MBLSKn4w0LcfnZtJu+h
         4trnJ3fKnJPoMml9teRjgAA3vmDe2eeT3nXkwP/rIaxX8p8+1WhfmTldf5FVNKR2HjC5
         /XBWyqKxhB3kV2GmWcFjg60PzRoZB0qDI3z6MJmwDfvHTAdg2IJNuP6m5RHp/fxtd1TZ
         cWo/KxlWyEfo6lqiK/rPRKW5peENiS06Enfj0oYt7VgvvC3Wd3+f7XZfEa9Qr7YHaGlV
         j22X62gzDR7yT23V4Ir5Har1FahnLa8GiCQwptgNNOTcq1K95vix9if44ybew/fsVYxZ
         9K1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BfI+j+OMPwnvX+tZGnV9Qob9U8JYQpm4qpc+j/7ff6Q=;
        b=H3OE9tw25U+BA4EtTQK5p3TnTCT1jApu5CUtUZlTJTVSfIj2PLGV+j4idC4YJuKO0q
         JeeUqnsGoWyDFLTITUCTrLJC+pEWDc246gDhsB6unXUhtwgVM9K6Ph+4ttqIXr1eCeZP
         kGbC1heBNQcvKFpjXQNrCNhOOnZIo7kHt03PoubxPGc0JQ/JjcqEmGYJpua/G0+305nU
         5aJFgGZ5KXrdVFH9aT2nu9Xkw3y7Mla9Re0sR1/YqUXyS/Rxwr51YzAI7esxX5260Z/3
         9Hjyayh2SlRIfRcem86HpDGfXig9GYVfqZEAdXsNlPs+j1ZqLAeTEdgPxcu4BazKB6G3
         uE+A==
X-Gm-Message-State: AGi0PuYvKYKkOJ+EPD+ZljdfvLpB/ZVcy/1fPy6iUd+uOSt+nXDvPKs2
        dHUHhtxGVX+K7rVRZ7taa/o=
X-Google-Smtp-Source: APiQypIv64YNx28cwjixWZvZozH0YCj+V2aY0cXuwqnrUTFuL3qsEfLUgixdyonWPumjMQ/tHPhBHw==
X-Received: by 2002:a1c:ed1a:: with SMTP id l26mr8787137wmh.175.1585921421483;
        Fri, 03 Apr 2020 06:43:41 -0700 (PDT)
Received: from debian.lan (host-84-13-17-86.opaltelecom.net. [84.13.17.86])
        by smtp.gmail.com with ESMTPSA id f12sm12081232wrm.94.2020.04.03.06.43.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2020 06:43:40 -0700 (PDT)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 07/11] parport_pc: Convert DPRINTK to pr_debug
Date:   Fri,  3 Apr 2020 14:43:21 +0100
Message-Id: <20200403134325.11523-7-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200403134325.11523-1-sudipm.mukherjee@gmail.com>
References: <20200403134325.11523-1-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joe Perches <joe@perches.com>

Use a more common logging style.

Miscellanea:

o One message converted from KERN_INFO to KERN_DEBUG

Signed-off-by: Joe Perches <joe@perches.com>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/parport/parport_pc.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
index ab3b04f32815..aae03b59564f 100644
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
2.11.0

