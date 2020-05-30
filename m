Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58740C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 23:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3903320722
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 23:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729610AbgE3XQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 19:16:34 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:51056 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729517AbgE3XQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 19:16:29 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 9AD3427EFD; Sat, 30 May 2020 19:16:28 -0400 (EDT)
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Joshua Thompson <funaho@jurai.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Message-Id: <6d667c39e53865661fa5a48f16829d18ed8abe54.1590880333.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1590880333.git.fthain@telegraphics.com.au>
References: <cover.1590880333.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 1/4] m68k/mac: Don't send IOP message until channel is idle
Date:   Sun, 31 May 2020 09:12:13 +1000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the following sequence of calls, iop_do_send() gets called when the
"send" channel is not in the IOP_MSG_IDLE state:

iop_ism_irq()
        iop_handle_send()
                (msg->handler)()
                        iop_send_message()
                iop_do_send()

Avoid this by testing the channel state before calling iop_do_send().

When sending, and iop_send_queue is empty, call iop_do_send() because
the channel is idle. If iop_send_queue is not empty, iop_do_send() will
get called later by iop_handle_send().

Cc: Joshua Thompson <funaho@jurai.org>
Tested-by: Stan Johnson <userm57@yahoo.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 arch/m68k/mac/iop.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/m68k/mac/iop.c b/arch/m68k/mac/iop.c
index d99c7ea08d8c..22c4e2b8bdf2 100644
--- a/arch/m68k/mac/iop.c
+++ b/arch/m68k/mac/iop.c
@@ -415,7 +415,8 @@ static void iop_handle_send(uint iop_num, uint chan)
 	msg->status = IOP_MSGSTATUS_UNUSED;
 	msg = msg->next;
 	iop_send_queue[iop_num][chan] = msg;
-	if (msg) iop_do_send(msg);
+	if (msg && iop_readb(iop, IOP_ADDR_SEND_STATE + chan) == IOP_MSG_IDLE)
+		iop_do_send(msg);
 }
 
 /*
@@ -489,16 +490,12 @@ int iop_send_message(uint iop_num, uint chan, void *privdata,
 
 	if (!(q = iop_send_queue[iop_num][chan])) {
 		iop_send_queue[iop_num][chan] = msg;
+		iop_do_send(msg);
 	} else {
 		while (q->next) q = q->next;
 		q->next = msg;
 	}
 
-	if (iop_readb(iop_base[iop_num],
-	    IOP_ADDR_SEND_STATE + chan) == IOP_MSG_IDLE) {
-		iop_do_send(msg);
-	}
-
 	return 0;
 }
 
-- 
2.26.2

