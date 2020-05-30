Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AAA0C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 23:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2F1E2068D
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 23:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729629AbgE3XUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 19:20:54 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:51248 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729565AbgE3XUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 19:20:35 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id A668428009; Sat, 30 May 2020 19:20:34 -0400 (EDT)
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Joshua Thompson <funaho@jurai.org>,
        linux-m68k@lists.linux-m68k.org,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <0fb7fdcd99d7820bb27faf1f27f7f6f1923914ef.1590880623.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1590880623.git.fthain@telegraphics.com.au>
References: <cover.1590880623.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 8/8] macintosh/adb-iop: Implement SRQ autopolling
Date:   Sun, 31 May 2020 09:17:03 +1000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The adb_driver.autopoll method is needed during ADB bus scan and device
address assignment. Implement this method so that the IOP's list of
device addresses can be updated. When the list is empty, disable SRQ
autopolling.

Cc: Joshua Thompson <funaho@jurai.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 arch/m68k/include/asm/adb_iop.h |  1 +
 drivers/macintosh/adb-iop.c     | 32 ++++++++++++++++++++++++++------
 2 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/arch/m68k/include/asm/adb_iop.h b/arch/m68k/include/asm/adb_iop.h
index 195d7fb1268c..6aecd020e2fc 100644
--- a/arch/m68k/include/asm/adb_iop.h
+++ b/arch/m68k/include/asm/adb_iop.h
@@ -29,6 +29,7 @@
 
 #define ADB_IOP_EXPLICIT	0x80	/* nonzero if explicit command */
 #define ADB_IOP_AUTOPOLL	0x40	/* auto/SRQ polling enabled    */
+#define ADB_IOP_SET_AUTOPOLL	0x20	/* set autopoll device list    */
 #define ADB_IOP_SRQ		0x04	/* SRQ detected                */
 #define ADB_IOP_TIMEOUT		0x02	/* nonzero if timeout          */
 
diff --git a/drivers/macintosh/adb-iop.c b/drivers/macintosh/adb-iop.c
index 8594e4f9a830..f3d1a460fbce 100644
--- a/drivers/macintosh/adb-iop.c
+++ b/drivers/macintosh/adb-iop.c
@@ -7,10 +7,6 @@
  * 1999-07-01 (jmt) - First implementation for new driver architecture.
  *
  * 1999-07-31 (jmt) - First working version.
- *
- * TODO:
- *
- * o Implement SRQ handling.
  */
 
 #include <linux/types.h>
@@ -28,6 +24,7 @@
 
 static struct adb_request *current_req;
 static struct adb_request *last_req;
+static unsigned int autopoll_devs;
 
 static enum adb_iop_state {
 	idle,
@@ -123,7 +120,7 @@ static void adb_iop_listen(struct iop_msg *msg)
 			  amsg->flags & ADB_IOP_AUTOPOLL);
 	}
 
-	msg->reply[0] = ADB_IOP_AUTOPOLL;
+	msg->reply[0] = autopoll_devs ? ADB_IOP_AUTOPOLL : 0;
 	iop_complete_message(msg);
 
 	if (req_done)
@@ -231,9 +228,32 @@ static int adb_iop_write(struct adb_request *req)
 	return 0;
 }
 
+static void adb_iop_set_ap_complete(struct iop_msg *msg)
+{
+	struct adb_iopmsg *amsg = (struct adb_iopmsg *)msg->message;
+
+	autopoll_devs = (amsg->data[1] << 8) | amsg->data[0];
+}
+
 static int adb_iop_autopoll(int devs)
 {
-	/* TODO: how do we enable/disable autopoll? */
+	struct adb_iopmsg amsg;
+	unsigned long flags;
+	unsigned int mask = (unsigned int)devs & 0xFFFE;
+
+	local_irq_save(flags);
+
+	amsg.flags = ADB_IOP_SET_AUTOPOLL | (mask ? ADB_IOP_AUTOPOLL : 0);
+	amsg.count = 2;
+	amsg.cmd = 0;
+	amsg.data[0] = mask & 0xFF;
+	amsg.data[1] = (mask >> 8) & 0xFF;
+
+	iop_send_message(ADB_IOP, ADB_CHAN, NULL, sizeof(amsg), (__u8 *)&amsg,
+			 adb_iop_set_ap_complete);
+
+	local_irq_restore(flags);
+
 	return 0;
 }
 
-- 
2.26.2

