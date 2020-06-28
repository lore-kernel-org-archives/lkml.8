Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D6F1C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 04:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 752582145D
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 04:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgF1EcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 00:32:16 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:34320 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbgF1Ebr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 00:31:47 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id B339B2970D; Sun, 28 Jun 2020 00:31:44 -0400 (EDT)
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Joshua Thompson <funaho@jurai.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Laurent Vivier <lvivier@redhat.com>,
        Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Message-Id: <779551219a11b19e574dfcd87e4ef60af08c4fc3.1593318192.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1593318192.git.fthain@telegraphics.com.au>
References: <cover.1593318192.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 6/9] macintosh/via-macii: Use bool type for reading_reply
 variable
Date:   Sun, 28 Jun 2020 14:23:12 +1000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/macintosh/via-macii.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/macintosh/via-macii.c b/drivers/macintosh/via-macii.c
index 8d5ef77b4a435..e143ddb81de34 100644
--- a/drivers/macintosh/via-macii.c
+++ b/drivers/macintosh/via-macii.c
@@ -116,7 +116,7 @@ static struct adb_request *current_req; /* first request struct in the queue */
 static struct adb_request *last_req;     /* last request struct in the queue */
 static unsigned char reply_buf[16];        /* storage for autopolled replies */
 static unsigned char *reply_ptr;     /* next byte in reply_buf or req->reply */
-static int reading_reply;        /* store reply in reply_buf else req->reply */
+static bool reading_reply;       /* store reply in reply_buf else req->reply */
 static int data_index;      /* index of the next byte to send from req->data */
 static int reply_len; /* number of bytes received in reply_buf or req->reply */
 static int status;          /* VIA's ADB status bits captured upon interrupt */
@@ -394,7 +394,7 @@ static irqreturn_t macii_interrupt(int irq, void *arg)
 		WARN_ON((status & ST_MASK) != ST_IDLE);
 
 		reply_ptr = reply_buf;
-		reading_reply = 0;
+		reading_reply = false;
 
 		bus_timeout = false;
 		srq_asserted = false;
@@ -442,7 +442,7 @@ static irqreturn_t macii_interrupt(int irq, void *arg)
 			 */
 			macii_state = reading;
 
-			reading_reply = 0;
+			reading_reply = false;
 			reply_ptr = reply_buf;
 			*reply_ptr = last_talk_cmd;
 			reply_len = 1;
@@ -456,7 +456,7 @@ static irqreturn_t macii_interrupt(int irq, void *arg)
 			if (req->reply_expected) {
 				macii_state = reading;
 
-				reading_reply = 1;
+				reading_reply = true;
 				reply_ptr = req->reply;
 				*reply_ptr = req->data[1];
 				reply_len = 1;
@@ -466,7 +466,7 @@ static irqreturn_t macii_interrupt(int irq, void *arg)
 			} else if ((req->data[1] & OP_MASK) == TALK) {
 				macii_state = reading;
 
-				reading_reply = 0;
+				reading_reply = false;
 				reply_ptr = reply_buf;
 				*reply_ptr = req->data[1];
 				reply_len = 1;
-- 
2.26.2

