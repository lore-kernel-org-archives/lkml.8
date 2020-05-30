Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4A1C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 23:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8C282067B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 23:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729589AbgE3XUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 19:20:39 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:51180 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729385AbgE3XUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 19:20:34 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 0A05327EFD; Sat, 30 May 2020 19:20:32 -0400 (EDT)
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Joshua Thompson <funaho@jurai.org>,
        linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Message-Id: <7720ffb559c334504e16b24d9c2f3b8973d2d674.1590880623.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1590880623.git.fthain@telegraphics.com.au>
References: <cover.1590880623.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 1/8] macintosh/adb-iop: Remove dead and redundant code
Date:   Sun, 31 May 2020 09:17:03 +1000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Joshua Thompson <funaho@jurai.org>
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/macintosh/adb-iop.c | 29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/drivers/macintosh/adb-iop.c b/drivers/macintosh/adb-iop.c
index fca31640e3ef..ce28ff40fb9c 100644
--- a/drivers/macintosh/adb-iop.c
+++ b/drivers/macintosh/adb-iop.c
@@ -18,24 +18,16 @@
 #include <linux/mm.h>
 #include <linux/delay.h>
 #include <linux/init.h>
-#include <linux/proc_fs.h>
 
 #include <asm/macintosh.h>
 #include <asm/macints.h>
 #include <asm/mac_iop.h>
-#include <asm/mac_oss.h>
 #include <asm/adb_iop.h>
 
 #include <linux/adb.h>
 
-/*#define DEBUG_ADB_IOP*/
-
 static struct adb_request *current_req;
 static struct adb_request *last_req;
-#if 0
-static unsigned char reply_buff[16];
-static unsigned char *reply_ptr;
-#endif
 
 static enum adb_iop_state {
 	idle,
@@ -104,22 +96,11 @@ static void adb_iop_listen(struct iop_msg *msg)
 	struct adb_iopmsg *amsg = (struct adb_iopmsg *)msg->message;
 	struct adb_request *req;
 	unsigned long flags;
-#ifdef DEBUG_ADB_IOP
-	int i;
-#endif
 
 	local_irq_save(flags);
 
 	req = current_req;
 
-#ifdef DEBUG_ADB_IOP
-	printk("adb_iop_listen %p: rcvd packet, %d bytes: %02X %02X", req,
-	       (uint)amsg->count + 2, (uint)amsg->flags, (uint)amsg->cmd);
-	for (i = 0; i < amsg->count; i++)
-		printk(" %02X", (uint)amsg->data[i]);
-	printk("\n");
-#endif
-
 	/* Handle a timeout. Timeout packets seem to occur even after */
 	/* we've gotten a valid reply to a TALK, so I'm assuming that */
 	/* a "timeout" is actually more like an "end-of-data" signal. */
@@ -163,9 +144,6 @@ static void adb_iop_start(void)
 	unsigned long flags;
 	struct adb_request *req;
 	struct adb_iopmsg amsg;
-#ifdef DEBUG_ADB_IOP
-	int i;
-#endif
 
 	/* get the packet to send */
 	req = current_req;
@@ -174,13 +152,6 @@ static void adb_iop_start(void)
 
 	local_irq_save(flags);
 
-#ifdef DEBUG_ADB_IOP
-	printk("adb_iop_start %p: sending packet, %d bytes:", req, req->nbytes);
-	for (i = 0; i < req->nbytes; i++)
-		printk(" %02X", (uint)req->data[i]);
-	printk("\n");
-#endif
-
 	/* The IOP takes MacII-style packets, so */
 	/* strip the initial ADB_PACKET byte.    */
 
-- 
2.26.2

