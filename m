Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F1B2C433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF2CB2065E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595259744;
	bh=KVERyIVniKZI9PZuy0pPdXHajTF/Ms0p1vqQa5OrA10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pqk5QIJvocwKhZ74asvbEEExffhUx2QUVpWWlxApEouGSAFBjCTcZ+gt4kza5Rm94
	 qO7HePIX2qxUg4pSZDH/nXOg6cp0/UQ+4ulDeOJaUCxb2/Ky9Ki+m3ftsDuJJscaaq
	 gN6xBhiRa/IfCKp5iJqlW2X8/I8qBQtwj7OgwqWg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730067AbgGTPmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:42:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:35128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730054AbgGTPmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:42:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E82E82065E;
        Mon, 20 Jul 2020 15:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595259739;
        bh=KVERyIVniKZI9PZuy0pPdXHajTF/Ms0p1vqQa5OrA10=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XASPxTJFIM5gEU7U/StW5RIi0W1AZwR64eSqecEv/qRusFpaDJPmZuE6GQQkY8May
         NTdCC4gTorGoFXk+GBrUsyt2p973/etDD4ojGpaMs2xdmcN5q4UTQTmgR6/HPwLEFC
         1KbJ6jkpRmc2iaSDK1AmQbPyeAtxKjWM3mSd1j+w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrey Konovalov <andreyknvl@google.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 61/86] usb: core: Add a helper function to check the validity of EP type in URB
Date:   Mon, 20 Jul 2020 17:36:57 +0200
Message-Id: <20200720152756.241710263@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152753.138974850@linuxfoundation.org>
References: <20200720152753.138974850@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit e901b9873876ca30a09253731bd3a6b00c44b5b0 upstream.

This patch adds a new helper function to perform a sanity check of the
given URB to see whether it contains a valid endpoint.  It's a light-
weight version of what usb_submit_urb() does, but without the kernel
warning followed by the stack trace, just returns an error code.

Especially for a driver that doesn't parse the descriptor but fills
the URB with the fixed endpoint (e.g. some quirks for non-compliant
devices), this kind of check is preferable at the probe phase before
actually submitting the urb.

Tested-by: Andrey Konovalov <andreyknvl@google.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/core/urb.c |   30 ++++++++++++++++++++++++++----
 include/linux/usb.h    |    2 ++
 2 files changed, 28 insertions(+), 4 deletions(-)

--- a/drivers/usb/core/urb.c
+++ b/drivers/usb/core/urb.c
@@ -183,6 +183,31 @@ EXPORT_SYMBOL_GPL(usb_unanchor_urb);
 
 /*-------------------------------------------------------------------*/
 
+static const int pipetypes[4] = {
+	PIPE_CONTROL, PIPE_ISOCHRONOUS, PIPE_BULK, PIPE_INTERRUPT
+};
+
+/**
+ * usb_urb_ep_type_check - sanity check of endpoint in the given urb
+ * @urb: urb to be checked
+ *
+ * This performs a light-weight sanity check for the endpoint in the
+ * given urb.  It returns 0 if the urb contains a valid endpoint, otherwise
+ * a negative error code.
+ */
+int usb_urb_ep_type_check(const struct urb *urb)
+{
+	const struct usb_host_endpoint *ep;
+
+	ep = usb_pipe_endpoint(urb->dev, urb->pipe);
+	if (!ep)
+		return -EINVAL;
+	if (usb_pipetype(urb->pipe) != pipetypes[usb_endpoint_type(&ep->desc)])
+		return -EINVAL;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(usb_urb_ep_type_check);
+
 /**
  * usb_submit_urb - issue an asynchronous transfer request for an endpoint
  * @urb: pointer to the urb describing the request
@@ -322,9 +347,6 @@ EXPORT_SYMBOL_GPL(usb_unanchor_urb);
  */
 int usb_submit_urb(struct urb *urb, gfp_t mem_flags)
 {
-	static int			pipetypes[4] = {
-		PIPE_CONTROL, PIPE_ISOCHRONOUS, PIPE_BULK, PIPE_INTERRUPT
-	};
 	int				xfertype, max;
 	struct usb_device		*dev;
 	struct usb_host_endpoint	*ep;
@@ -443,7 +465,7 @@ int usb_submit_urb(struct urb *urb, gfp_
 	 */
 
 	/* Check that the pipe's type matches the endpoint's type */
-	if (usb_pipetype(urb->pipe) != pipetypes[xfertype])
+	if (usb_urb_ep_type_check(urb))
 		dev_WARN(&dev->dev, "BOGUS urb xfer, pipe %x != type %x\n",
 			usb_pipetype(urb->pipe), pipetypes[xfertype]);
 
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -1655,6 +1655,8 @@ static inline int usb_urb_dir_out(struct
 	return (urb->transfer_flags & URB_DIR_MASK) == URB_DIR_OUT;
 }
 
+int usb_urb_ep_type_check(const struct urb *urb);
+
 void *usb_alloc_coherent(struct usb_device *dev, size_t size,
 	gfp_t mem_flags, dma_addr_t *dma);
 void usb_free_coherent(struct usb_device *dev, size_t size,


