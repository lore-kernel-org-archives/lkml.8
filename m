Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B6AC47254
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E700208D6
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588339579;
	bh=NVWrPhJfnyt59n+JxxM935SAPZawW9c0/ULMAUsj5oM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ExS9DrP9Yd9fBokDx7n271aM8WNyOcB+ALYmHpzdC9jRVsAGSJds6s+BhUsP5+TGv
	 e78CIj7xf5YkxJbwEAt3pwznDm1z3FtRXHKoDKvi+baO0ngCNaR4kO6db+rUONHMH9
	 rukdYQulXA6ree4tSHUzZmIvg1Cg5SH7LY45UXMU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729217AbgEAN0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:26:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:47720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729197AbgEAN0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:26:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7587C208D6;
        Fri,  1 May 2020 13:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588339573;
        bh=NVWrPhJfnyt59n+JxxM935SAPZawW9c0/ULMAUsj5oM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2njpnFuZA2CHhnolHZ4Im/Hj613UWvvP1TY1aIsKTzBss7ie1QuS+r75M7vf9suVO
         nKn/iPNWrbAYTnNwdXwE7NONZ2Rr83kv5L0mUKIBwWA5a9Zv4MWY5M4H/x/E4V4Ldt
         d2C2uTKsWrpxFHHMZani6SBfdPeBXeW6I8GK9uIE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        David Mosberger <davidm@egauge.net>
Subject: [PATCH 4.4 33/70] drivers: usb: core: Minimize irq disabling in usb_sg_cancel()
Date:   Fri,  1 May 2020 15:21:21 +0200
Message-Id: <20200501131524.490779383@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131513.302599262@linuxfoundation.org>
References: <20200501131513.302599262@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Mosberger <davidm@egauge.net>

commit 5f2e5fb873e269fcb806165715d237f0de4ecf1d upstream.

Restructure usb_sg_cancel() so we don't have to disable interrupts
while cancelling the URBs.

Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: David Mosberger <davidm@egauge.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/core/message.c |   37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -581,31 +581,28 @@ EXPORT_SYMBOL_GPL(usb_sg_wait);
 void usb_sg_cancel(struct usb_sg_request *io)
 {
 	unsigned long flags;
+	int i, retval;
 
 	spin_lock_irqsave(&io->lock, flags);
+	if (io->status) {
+		spin_unlock_irqrestore(&io->lock, flags);
+		return;
+	}
+	/* shut everything down */
+	io->status = -ECONNRESET;
+	spin_unlock_irqrestore(&io->lock, flags);
 
-	/* shut everything down, if it didn't already */
-	if (!io->status) {
-		int i;
-
-		io->status = -ECONNRESET;
-		spin_unlock(&io->lock);
-		for (i = 0; i < io->entries; i++) {
-			int retval;
-
-			usb_block_urb(io->urbs[i]);
+	for (i = io->entries - 1; i >= 0; --i) {
+		usb_block_urb(io->urbs[i]);
 
-			retval = usb_unlink_urb(io->urbs[i]);
-			if (retval != -EINPROGRESS
-					&& retval != -ENODEV
-					&& retval != -EBUSY
-					&& retval != -EIDRM)
-				dev_warn(&io->dev->dev, "%s, unlink --> %d\n",
-					__func__, retval);
-		}
-		spin_lock(&io->lock);
+		retval = usb_unlink_urb(io->urbs[i]);
+		if (retval != -EINPROGRESS
+		    && retval != -ENODEV
+		    && retval != -EBUSY
+		    && retval != -EIDRM)
+			dev_warn(&io->dev->dev, "%s, unlink --> %d\n",
+				 __func__, retval);
 	}
-	spin_unlock_irqrestore(&io->lock, flags);
 }
 EXPORT_SYMBOL_GPL(usb_sg_cancel);
 


