Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DAABC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 23:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 561FC20722
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 23:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729590AbgE3XQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 19:16:31 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:51092 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729565AbgE3XQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 19:16:29 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 0CE8A27F9B; Sat, 30 May 2020 19:16:28 -0400 (EDT)
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Joshua Thompson <funaho@jurai.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Message-Id: <317909d69244f06581973c5839382f5516cd9a1c.1590880333.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1590880333.git.fthain@telegraphics.com.au>
References: <cover.1590880333.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 4/4] m68k/mac: Improve IOP debug messages
Date:   Sun, 31 May 2020 09:12:13 +1000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Always dump the full message and reply. Avoid printing partial lines
as this output gets mixed up with the output from called functions.
Don't output the state of idle channels.

Cc: Joshua Thompson <funaho@jurai.org>
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 arch/m68k/mac/iop.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/m68k/mac/iop.c b/arch/m68k/mac/iop.c
index 8d6946edf2c8..373a74c99356 100644
--- a/arch/m68k/mac/iop.c
+++ b/arch/m68k/mac/iop.c
@@ -347,8 +347,8 @@ void iop_complete_message(struct iop_msg *msg)
 	int chan = msg->channel;
 	int i,offset;
 
-	iop_pr_debug("msg %p iop_num %d channel %d\n", msg, msg->iop_num,
-	             msg->channel);
+	iop_pr_debug("iop_num %d chan %d reply %*ph\n",
+	             msg->iop_num, msg->channel, IOP_MSG_LEN, msg->reply);
 
 	offset = IOP_ADDR_RECV_MSG + (msg->channel * IOP_MSG_LEN);
 
@@ -372,6 +372,9 @@ static void iop_do_send(struct iop_msg *msg)
 	volatile struct mac_iop *iop = iop_base[msg->iop_num];
 	int i,offset;
 
+	iop_pr_debug("iop_num %d chan %d message %*ph\n",
+	             msg->iop_num, msg->channel, IOP_MSG_LEN, msg->message);
+
 	offset = IOP_ADDR_SEND_MSG + (msg->channel * IOP_MSG_LEN);
 
 	for (i = 0 ; i < IOP_MSG_LEN ; i++, offset++) {
@@ -394,8 +397,6 @@ static void iop_handle_send(uint iop_num, uint chan)
 	struct iop_msg *msg;
 	int i,offset;
 
-	iop_pr_debug("iop_num %d chan %d\n", iop_num, chan);
-
 	iop_writeb(iop, IOP_ADDR_SEND_STATE + chan, IOP_MSG_IDLE);
 
 	if (!(msg = iop_send_queue[iop_num][chan])) return;
@@ -405,6 +406,9 @@ static void iop_handle_send(uint iop_num, uint chan)
 	for (i = 0 ; i < IOP_MSG_LEN ; i++, offset++) {
 		msg->reply[i] = iop_readb(iop, offset);
 	}
+	iop_pr_debug("iop_num %d chan %d reply %*ph\n",
+	             iop_num, chan, IOP_MSG_LEN, msg->reply);
+
 	if (msg->handler) (*msg->handler)(msg);
 	msg->status = IOP_MSGSTATUS_UNUSED;
 	msg = msg->next;
@@ -424,8 +428,6 @@ static void iop_handle_recv(uint iop_num, uint chan)
 	int i,offset;
 	struct iop_msg *msg;
 
-	iop_pr_debug("iop_num %d chan %d\n", iop_num, chan);
-
 	msg = iop_get_unused_msg();
 	msg->iop_num = iop_num;
 	msg->channel = chan;
@@ -437,6 +439,8 @@ static void iop_handle_recv(uint iop_num, uint chan)
 	for (i = 0 ; i < IOP_MSG_LEN ; i++, offset++) {
 		msg->message[i] = iop_readb(iop, offset);
 	}
+	iop_pr_debug("iop_num %d chan %d message %*ph\n",
+	             iop_num, chan, IOP_MSG_LEN, msg->message);
 
 	iop_writeb(iop, IOP_ADDR_RECV_STATE + chan, IOP_MSG_RCVD);
 
@@ -446,9 +450,6 @@ static void iop_handle_recv(uint iop_num, uint chan)
 	if (msg->handler) {
 		(*msg->handler)(msg);
 	} else {
-		iop_pr_debug("unclaimed message on iop_num %d chan %d\n",
-		             iop_num, chan);
-		iop_pr_debug("%*ph\n", IOP_MSG_LEN, msg->message);
 		memset(msg->reply, 0, IOP_MSG_LEN);
 		iop_complete_message(msg);
 	}
@@ -559,35 +560,34 @@ irqreturn_t iop_ism_irq(int irq, void *dev_id)
 	int i,state;
 	u8 events = iop->status_ctrl & (IOP_INT0 | IOP_INT1);
 
-	iop_pr_debug("status %02X\n", iop->status_ctrl);
-
 	do {
+		iop_pr_debug("iop_num %d status %02X\n", iop_num,
+		             iop->status_ctrl);
+
 		/* INT0 indicates state change on an outgoing message channel */
 		if (events & IOP_INT0) {
 			iop->status_ctrl = IOP_INT0 | IOP_RUN | IOP_AUTOINC;
-			iop_pr_debug("new status %02X, send states",
-			             iop->status_ctrl);
 			for (i = 0; i < NUM_IOP_CHAN; i++) {
 				state = iop_readb(iop, IOP_ADDR_SEND_STATE + i);
-				iop_pr_cont(" %02X", state);
 				if (state == IOP_MSG_COMPLETE)
 					iop_handle_send(iop_num, i);
+				else if (state != IOP_MSG_IDLE)
+					iop_pr_debug("chan %d send state %02X\n",
+					             i, state);
 			}
-			iop_pr_cont("\n");
 		}
 
 		/* INT1 for incoming messages */
 		if (events & IOP_INT1) {
 			iop->status_ctrl = IOP_INT1 | IOP_RUN | IOP_AUTOINC;
-			iop_pr_debug("new status %02X, recv states",
-			             iop->status_ctrl);
 			for (i = 0; i < NUM_IOP_CHAN; i++) {
 				state = iop_readb(iop, IOP_ADDR_RECV_STATE + i);
-				iop_pr_cont(" %02X", state);
 				if (state == IOP_MSG_NEW)
 					iop_handle_recv(iop_num, i);
+				else if (state != IOP_MSG_IDLE)
+					iop_pr_debug("chan %d recv state %02X\n",
+					             i, state);
 			}
-			iop_pr_cont("\n");
 		}
 
 		events = iop->status_ctrl & (IOP_INT0 | IOP_INT1);
-- 
2.26.2

