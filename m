Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489EDC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 23:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D43F2068D
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 23:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729580AbgE3XUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 19:20:38 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:51192 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729314AbgE3XUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 19:20:33 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 5FCE927F1F; Sat, 30 May 2020 19:20:33 -0400 (EDT)
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Joshua Thompson <funaho@jurai.org>,
        linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Message-Id: <996f835d2f3d90baaaf9ee954e252d06e8886c6f.1590880623.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1590880623.git.fthain@telegraphics.com.au>
References: <cover.1590880623.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 2/8] macintosh/adb-iop: Correct comment text
Date:   Sun, 31 May 2020 09:17:03 +1000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch improves comment style and corrects some misunderstandings
in the text.

Cc: Joshua Thompson <funaho@jurai.org>
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/macintosh/adb-iop.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/macintosh/adb-iop.c b/drivers/macintosh/adb-iop.c
index ce28ff40fb9c..ca3b411b0742 100644
--- a/drivers/macintosh/adb-iop.c
+++ b/drivers/macintosh/adb-iop.c
@@ -101,11 +101,10 @@ static void adb_iop_listen(struct iop_msg *msg)
 
 	req = current_req;
 
-	/* Handle a timeout. Timeout packets seem to occur even after */
-	/* we've gotten a valid reply to a TALK, so I'm assuming that */
-	/* a "timeout" is actually more like an "end-of-data" signal. */
-	/* We need to send back a timeout packet to the IOP to shut   */
-	/* it up, plus complete the current request, if any.          */
+	/* Handle a timeout. Timeout packets seem to occur even after
+	 * we've gotten a valid reply to a TALK, presumably because of
+	 * autopolling.
+	 */
 
 	if (amsg->flags & ADB_IOP_TIMEOUT) {
 		msg->reply[0] = ADB_IOP_TIMEOUT | ADB_IOP_AUTOPOLL;
@@ -115,9 +114,6 @@ static void adb_iop_listen(struct iop_msg *msg)
 			adb_iop_end_req(req, idle);
 		}
 	} else {
-		/* TODO: is it possible for more than one chunk of data  */
-		/*       to arrive before the timeout? If so we need to */
-		/*       use reply_ptr here like the other drivers do.  */
 		if ((adb_iop_state == awaiting_reply) &&
 		    (amsg->flags & ADB_IOP_EXPLICIT)) {
 			req->reply_len = amsg->count + 1;
@@ -152,23 +148,24 @@ static void adb_iop_start(void)
 
 	local_irq_save(flags);
 
-	/* The IOP takes MacII-style packets, so */
-	/* strip the initial ADB_PACKET byte.    */
-
+	/* The IOP takes MacII-style packets, so strip the initial
+	 * ADB_PACKET byte.
+	 */
 	amsg.flags = ADB_IOP_EXPLICIT;
 	amsg.count = req->nbytes - 2;
 
-	/* amsg.data immediately follows amsg.cmd, effectively making */
-	/* amsg.cmd a pointer to the beginning of a full ADB packet.  */
+	/* amsg.data immediately follows amsg.cmd, effectively making
+	 * &amsg.cmd a pointer to the beginning of a full ADB packet.
+	 */
 	memcpy(&amsg.cmd, req->data + 1, req->nbytes - 1);
 
 	req->sent = 1;
 	adb_iop_state = sending;
 	local_irq_restore(flags);
 
-	/* Now send it. The IOP manager will call adb_iop_complete */
-	/* when the packet has been sent.                          */
-
+	/* Now send it. The IOP manager will call adb_iop_complete
+	 * when the message has been sent.
+	 */
 	iop_send_message(ADB_IOP, ADB_CHAN, req, sizeof(amsg), (__u8 *)&amsg,
 			 adb_iop_complete);
 }
-- 
2.26.2

