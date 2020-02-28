Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E81C3F2CF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 08:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6449246A8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 08:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgB1IeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 03:34:22 -0500
Received: from smtprelay0074.hostedemail.com ([216.40.44.74]:52671 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725877AbgB1IeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 03:34:07 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id B02CA181D3025;
        Fri, 28 Feb 2020 08:34:06 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: coach43_7b1caf2ddb420
X-Filterd-Recvd-Size: 3660
Received: from joe-laptop.perches.com (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Feb 2020 08:34:05 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] parport_mfc3: Convert DPRINTK to pr_debug
Date:   Fri, 28 Feb 2020 00:32:16 -0800
Message-Id: <66cf3d4a9dbdb24bd3d299b71a2ae05e196ee207.1582878394.git.joe@perches.com>
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

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/parport/parport_mfc3.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/parport/parport_mfc3.c b/drivers/parport/parport_mfc3.c
index 3190ef0..d6bbe8 100644
--- a/drivers/parport/parport_mfc3.c
+++ b/drivers/parport/parport_mfc3.c
@@ -70,11 +70,6 @@
 #define MAX_MFC 5
 
 #undef DEBUG
-#ifdef DEBUG
-#define DPRINTK printk
-#else
-static inline int DPRINTK(void *nothing, ...) {return 0;}
-#endif
 
 static struct parport *this_port[MAX_MFC] = {NULL, };
 static volatile int dummy; /* for trigger readds */
@@ -84,7 +79,7 @@ static struct parport_operations pp_mfc3_ops;
 
 static void mfc3_write_data(struct parport *p, unsigned char data)
 {
-DPRINTK(KERN_DEBUG "write_data %c\n",data);
+	pr_debug("write_data %c\n", data);
 
 	dummy = pia(p)->pprb; /* clears irq bit */
 	/* Triggers also /STROBE.*/
@@ -128,13 +123,13 @@ static unsigned char control_mfc3_to_pc(unsigned char control)
 
 static void mfc3_write_control(struct parport *p, unsigned char control)
 {
-DPRINTK(KERN_DEBUG "write_control %02x\n",control);
+	pr_debug("write_control %02x\n", control);
 	pia(p)->ppra = (pia(p)->ppra & 0x1f) | control_pc_to_mfc3(control);
 }
 	
 static unsigned char mfc3_read_control( struct parport *p)
 {
-DPRINTK(KERN_DEBUG "read_control \n");
+	pr_debug("read_control\n");
 	return control_mfc3_to_pc(pia(p)->ppra & 0xe0);
 }
 
@@ -142,7 +137,7 @@ static unsigned char mfc3_frob_control( struct parport *p, unsigned char mask, u
 {
 	unsigned char old;
 
-DPRINTK(KERN_DEBUG "frob_control mask %02x, value %02x\n",mask,val);
+	pr_debug("frob_control mask %02x, value %02x\n", mask, val);
 	old = mfc3_read_control(p);
 	mfc3_write_control(p, (old & ~mask) ^ val);
 	return old;
@@ -171,7 +166,7 @@ static unsigned char mfc3_read_status(struct parport *p)
 	unsigned char status;
 
 	status = status_mfc3_to_pc(pia(p)->ppra & 0x1f);
-DPRINTK(KERN_DEBUG "read_status %02x\n", status);
+	pr_debug("read_status %02x\n", status);
 	return status;
 }
 
@@ -202,7 +197,7 @@ static void mfc3_disable_irq(struct parport *p)
 
 static void mfc3_data_forward(struct parport *p)
 {
-	DPRINTK(KERN_DEBUG "forward\n");
+	pr_debug("forward\n");
 	pia(p)->crb &= ~PIA_DDR; /* make data direction register visible */
 	pia(p)->pddrb = 255; /* all pins output */
 	pia(p)->crb |= PIA_DDR; /* make data register visible - default */
@@ -210,7 +205,7 @@ static void mfc3_data_forward(struct parport *p)
 
 static void mfc3_data_reverse(struct parport *p)
 {
-	DPRINTK(KERN_DEBUG "reverse\n");
+	pr_debug("reverse\n");
 	pia(p)->crb &= ~PIA_DDR; /* make data direction register visible */
 	pia(p)->pddrb = 0; /* all pins input */
 	pia(p)->crb |= PIA_DDR; /* make data register visible - default */
-- 
2.24.0

