Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE96C3F2CF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 08:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DC84246AA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 08:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgB1IeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 03:34:06 -0500
Received: from smtprelay0142.hostedemail.com ([216.40.44.142]:37464 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725877AbgB1IeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 03:34:04 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id D02FD837F27B;
        Fri, 28 Feb 2020 08:34:03 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: crib27_7ab1dcd5f4e1a
X-Filterd-Recvd-Size: 3478
Received: from joe-laptop.perches.com (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Feb 2020 08:34:03 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] parport: daisy: Convert DPRINTK to pr_debug
Date:   Fri, 28 Feb 2020 00:32:14 -0800
Message-Id: <51af1a19f2457e38642401639cd66788d6dee846.1582878394.git.joe@perches.com>
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
 drivers/parport/daisy.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/parport/daisy.c b/drivers/parport/daisy.c
index f87cc80..6d78ec 100644
--- a/drivers/parport/daisy.c
+++ b/drivers/parport/daisy.c
@@ -30,12 +30,6 @@
 
 #undef DEBUG
 
-#ifdef DEBUG
-#define DPRINTK(stuff...) printk(stuff)
-#else
-#define DPRINTK(stuff...)
-#endif
-
 static struct daisydev {
 	struct daisydev *next;
 	struct parport *port;
@@ -321,8 +315,7 @@ static int cpp_daisy(struct parport *port, int cmd)
 		  | PARPORT_STATUS_PAPEROUT
 		  | PARPORT_STATUS_SELECT
 		  | PARPORT_STATUS_ERROR)) {
-		DPRINTK(KERN_DEBUG "%s: cpp_daisy: aa5500ff(%02x)\n",
-			 port->name, s);
+		pr_debug("%s: cpp_daisy: aa5500ff(%02x)\n", port->name, s);
 		return -ENXIO;
 	}
 
@@ -332,8 +325,7 @@ static int cpp_daisy(struct parport *port, int cmd)
 					  | PARPORT_STATUS_SELECT
 					  | PARPORT_STATUS_ERROR);
 	if (s != (PARPORT_STATUS_SELECT | PARPORT_STATUS_ERROR)) {
-		DPRINTK(KERN_DEBUG "%s: cpp_daisy: aa5500ff87(%02x)\n",
-			 port->name, s);
+		pr_debug("%s: cpp_daisy: aa5500ff87(%02x)\n", port->name, s);
 		return -ENXIO;
 	}
 
@@ -368,7 +360,7 @@ static int cpp_mux(struct parport *port, int cmd)
 
 	s = parport_read_status(port);
 	if (!(s & PARPORT_STATUS_ACK)) {
-		DPRINTK(KERN_DEBUG "%s: cpp_mux: aa55f00f52ad%02x(%02x)\n",
+		pr_debug("%s: cpp_mux: aa55f00f52ad%02x(%02x)\n",
 			 port->name, cmd, s);
 		return -EIO;
 	}
@@ -454,8 +446,7 @@ static int assign_addrs(struct parport *port)
 		  | PARPORT_STATUS_PAPEROUT
 		  | PARPORT_STATUS_SELECT
 		  | PARPORT_STATUS_ERROR)) {
-		DPRINTK(KERN_DEBUG "%s: assign_addrs: aa5500ff(%02x)\n",
-			 port->name, s);
+		pr_debug("%s: assign_addrs: aa5500ff(%02x)\n", port->name, s);
 		return 0;
 	}
 
@@ -465,8 +456,7 @@ static int assign_addrs(struct parport *port)
 					  | PARPORT_STATUS_SELECT
 					  | PARPORT_STATUS_ERROR);
 	if (s != (PARPORT_STATUS_SELECT | PARPORT_STATUS_ERROR)) {
-		DPRINTK(KERN_DEBUG "%s: assign_addrs: aa5500ff87(%02x)\n",
-			 port->name, s);
+		pr_debug("%s: assign_addrs: aa5500ff87(%02x)\n", port->name, s);
 		return 0;
 	}
 
@@ -503,8 +493,7 @@ static int assign_addrs(struct parport *port)
 
 	parport_write_data(port, 0xff); udelay(2);
 	detected = numdevs - thisdev;
-	DPRINTK(KERN_DEBUG "%s: Found %d daisy-chained devices\n", port->name,
-		 detected);
+	pr_debug("%s: Found %d daisy-chained devices\n", port->name, detected);
 
 	/* Ask the new devices to introduce themselves. */
 	deviceid = kmalloc(1024, GFP_KERNEL);
-- 
2.24.0

