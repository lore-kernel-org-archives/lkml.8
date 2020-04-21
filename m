Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 698C8C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45A51206F4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flMZsWYi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbgDUNbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 09:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728519AbgDUNa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 09:30:57 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3453C061A10;
        Tue, 21 Apr 2020 06:30:56 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id z26so13962624ljz.11;
        Tue, 21 Apr 2020 06:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cKi1vwd8TDkp6yZ/l+k5hTd15uIQcb/ARTJ7duG8o9E=;
        b=flMZsWYinLBNCrY3VWYVkg+KyZJ63syZ2CVkRvaea0H7WE1w0cToZoYLR2Olmw1Qrd
         DBz2gOaUbEO9Icu4MSbMDpU3MfNpfWrRae4DNaeNVkAHBUC6FwjhFrJQyUWWWui3DRxm
         ddEEw5Sh7NSgAOUmp5e/ghy4P2ZPZyryVVNgCV8/PVXUYH+Yb+T0WzynymJvZU6VewJy
         BxGtj7OZlIPeSs5JH3K/NoA323Mu9KcelImINQVUauEkooGWJ3BBORXQ+MaJEqp1o/JH
         GzQRq8SGitwAMrZJpytvwibKbgEUIt+ZjHfydryp0nFUlRxSFMa/KXh3je1QFbguuQMw
         KpGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cKi1vwd8TDkp6yZ/l+k5hTd15uIQcb/ARTJ7duG8o9E=;
        b=jmTHvXRxps4tYrnj0OzMnhIBCDenvnAKBz0uxHrF6b91lHS6rcSYA0qJpu/CWo1/25
         /u+ywlG2iklJBjYmcwD9MbvsJZMg+VlOzOVeQTB6MS03Lz4SZSfHOKna7SZ5xgNwAavF
         3tBz/oyjfYMt2AqqqzJ5W1AY33hCbg3GokyfCmsg2gRGk/302WiR8ETFWAsWUj1vHt5k
         qn66FESJcTmj2g13Nnxv/hsvVAlRlp/ugJxneE+2hhAtkC+nMhQvv+SDJ/qXI84mxr99
         32P/wBnQsDSajJzPVQ/o8ivgH+T6IgMOBcvWIzquyqRduNfXObNPxvqzFvNZ9dxbobWX
         71bw==
X-Gm-Message-State: AGi0PubLsgJ6vt8B6OZ1i62q2pG1wvjgKmzJyYgOadmNcmpfb5qzhWw8
        RuCd+ai/VU3vJ8UJ5Q+Ka+XE462f/Ts=
X-Google-Smtp-Source: APiQypK8K+pZUOc0ZEPuinKt0MrQw2PDuexmyj+vN7dJu67ZWQfJM9NntRg2s7EFxzh5zG3DUO/mlQ==
X-Received: by 2002:a2e:99cc:: with SMTP id l12mr13517533ljj.290.1587475855187;
        Tue, 21 Apr 2020 06:30:55 -0700 (PDT)
Received: from oak.local ([188.123.231.141])
        by smtp.gmail.com with ESMTPSA id v17sm2031456lfi.49.2020.04.21.06.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 06:30:54 -0700 (PDT)
From:   matwey.kornilov@gmail.com
To:     stern@rowland.harvard.edu, Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org (open list:MUSB MULTIPOINT HIGH SPEED
        DUAL-ROLE CONTROLLER), linux-kernel@vger.kernel.org (open list)
Cc:     "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        linux-usb@vger.kernel.org (open list:MUSB MULTIPOINT HIGH SPEED
        DUAL-ROLE CONTROLLER), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 3/6] usb: musb: Introduce musb_qh_free() helper function
Date:   Tue, 21 Apr 2020 16:30:16 +0300
Message-Id: <20200421133019.27167-4-matwey.kornilov@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200421133019.27167-1-matwey.kornilov@gmail.com>
References: <20200421133019.27167-1-matwey.kornilov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matwey V. Kornilov" <matwey@sai.msu.ru>

Reduce the following similar snippets by using musb_qh_free().

    qh->hep->hcpriv = NULL;
    list_del(&qh->ring);
    kfree(qh);

Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
---
 drivers/usb/musb/musb_host.c | 66 +++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 34 deletions(-)

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index af906f072cb3..28d6576b6d8d 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -85,6 +85,21 @@ static bool musb_qh_empty(struct musb_qh *qh)
 	return list_empty(&qh->hep->urb_list);
 }
 
+static void musb_qh_unlink_hep(struct musb_qh *qh)
+{
+	if (!qh->hep)
+		return;
+
+	qh->hep->hcpriv = NULL;
+}
+
+static void musb_qh_free(struct musb_qh *qh)
+{
+	musb_qh_unlink_hep(qh);
+	list_del(&qh->ring);
+	kfree(qh);
+}
+
 /*
  * Clear TX fifo. Needed to avoid BABBLE errors.
  */
@@ -330,7 +345,7 @@ static void musb_advance_schedule(struct musb *musb, struct urb *urb,
 	 * invalidate qh as soon as list_empty(&hep->urb_list)
 	 */
 	if (musb_qh_empty(qh)) {
-		struct list_head	*head;
+		struct list_head	*head = NULL;
 		struct dma_controller	*dma = musb->dma_controller;
 
 		if (is_in) {
@@ -349,34 +364,22 @@ static void musb_advance_schedule(struct musb *musb, struct urb *urb,
 
 		/* Clobber old pointers to this qh */
 		musb_ep_set_qh(ep, is_in, NULL);
-		qh->hep->hcpriv = NULL;
 
-		switch (qh->type) {
+		/* USB_ENDPOINT_XFER_CONTROL and USB_ENDPOINT_XFER_BULK: fifo
+		 * policy for these lists, except that NAKing should rotate
+		 * a qh to the end (for fairness).
+		 * USB_ENDPOINT_XFER_ISOC and USB_ENDPOINT_XFER_INT: this is
+		 * where periodic bandwidth should be de-allocated if it's
+		 * tracked and allocated; and where we'd update the schedule
+		 * tree...
+		 */
+		if (qh->mux == 1
+		    && (qh->type == USB_ENDPOINT_XFER_CONTROL || qh->type == USB_ENDPOINT_XFER_BULK))
+			head = qh->ring.prev;
 
-		case USB_ENDPOINT_XFER_CONTROL:
-		case USB_ENDPOINT_XFER_BULK:
-			/* fifo policy for these lists, except that NAKing
-			 * should rotate a qh to the end (for fairness).
-			 */
-			if (qh->mux == 1) {
-				head = qh->ring.prev;
-				list_del(&qh->ring);
-				kfree(qh);
-				qh = first_qh(head);
-				break;
-			}
-			/* fall through */
+		musb_qh_free(qh);
 
-		case USB_ENDPOINT_XFER_ISOC:
-		case USB_ENDPOINT_XFER_INT:
-			/* this is where periodic bandwidth should be
-			 * de-allocated if it's tracked and allocated;
-			 * and where we'd update the schedule tree...
-			 */
-			kfree(qh);
-			qh = NULL;
-			break;
-		}
+		qh = head ? first_qh(head) : NULL;
 	}
 
 	if (qh != NULL && qh->is_ready) {
@@ -2402,11 +2405,8 @@ static int musb_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 		/* If nothing else (usually musb_giveback) is using it
 		 * and its URB list has emptied, recycle this qh.
 		 */
-		if (ready && musb_qh_empty(qh)) {
-			qh->hep->hcpriv = NULL;
-			list_del(&qh->ring);
-			kfree(qh);
-		}
+		if (ready && musb_qh_empty(qh))
+			musb_qh_free(qh);
 	} else
 		ret = musb_cleanup_urb(urb, qh);
 done:
@@ -2460,9 +2460,7 @@ musb_h_disable(struct usb_hcd *hcd, struct usb_host_endpoint *hep)
 		while (!musb_qh_empty(qh))
 			musb_giveback(musb, next_urb(qh), -ESHUTDOWN);
 
-		hep->hcpriv = NULL;
-		list_del(&qh->ring);
-		kfree(qh);
+		musb_qh_free(qh);
 	}
 exit:
 	spin_unlock_irqrestore(&musb->lock, flags);
-- 
2.25.0

