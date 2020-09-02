Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC0FC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 11:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 305912078E
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 11:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599044537;
	bh=E1iutx9WJV6ikxgtXBWCaYP7b/Z6blJgiTOA58pOvyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T8zyBUo0IndAiyTrDmZEwYht64roz4Ddk2Rg0xdRpq2WSRWreL9OeMJ7DXD5AOaAb
	 qIo/G4x9y19XE9te0mwIj++88CR1GBLy/pyqXNlRC+A742wmFfLdWFQ+Bs+mzsdJAi
	 nM/ak1CbkQ2UJryBzWsU7ZyB9padvxpgu2BdV7B0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgIBLCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 07:02:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:45744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbgIBLBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 07:01:13 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0C0B214D8;
        Wed,  2 Sep 2020 11:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599044472;
        bh=E1iutx9WJV6ikxgtXBWCaYP7b/Z6blJgiTOA58pOvyk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gt3NCBHKSdY2RjF68I/q2GKRHZrk3JtGCfRWwDIR9aFOSwqPHhPYgFrw/MEL43Huz
         CHE4lelNoCwVT4310VKgByrBGxUphAUvZfDjn0OLhQ7Vf7R1/jJ8ahgR0xBzFwuBT8
         D1HiUdB2YP2oYhW5TzFInNrihD1IWDfwn3VfTq8A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     himadrispandya@gmail.com, dvyukov@google.com,
        linux-usb@vger.kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, stern@rowland.harvard.ed,
        linux-kernel@vger.kernel.org, marcel@holtmann.org,
        johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 02/10] USB: add usb_control_msg_send() and usb_control_msg_recv()
Date:   Wed,  2 Sep 2020 13:01:04 +0200
Message-Id: <20200902110115.1994491-3-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200902110115.1994491-1-gregkh@linuxfoundation.org>
References: <20200902110115.1994491-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New core functions to make sending/receiving USB control messages easier
and saner.

In discussions, it turns out that the large majority of users of
usb_control_msg() do so in potentially incorrect ways.  The most common
issue is where a "short" message is received, yet never detected
properly due to "incorrect" error handling.

Handle all of this in the USB core with two new functions to try to make
working with USB control messages simpler.

No more need for dynamic data, messages can be on the stack, and only
"complete" send/receive will work without causing an error.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/core/message.c | 133 +++++++++++++++++++++++++++++++++++++
 include/linux/usb.h        |   6 ++
 2 files changed, 139 insertions(+)

diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
index 6197938dcc2d..6aa49b237717 100644
--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -162,6 +162,139 @@ int usb_control_msg(struct usb_device *dev, unsigned int pipe, __u8 request,
 }
 EXPORT_SYMBOL_GPL(usb_control_msg);
 
+/**
+ * usb_control_msg_send - Builds a control "send" message, sends it off and waits for completion
+ * @dev: pointer to the usb device to send the message to
+ * @endpoint: endpoint to send the message to
+ * @request: USB message request value
+ * @requesttype: USB message request type value
+ * @value: USB message value
+ * @index: USB message index value
+ * @driver_data: pointer to the data to send
+ * @size: length in bytes of the data to send
+ * @timeout: time in msecs to wait for the message to complete before timing
+ *	out (if 0 the wait is forever)
+ *
+ * Context: !in_interrupt ()
+ *
+ * This function sends a control message to a specified endpoint that is not
+ * expected to fill in a response (i.e. a "send message") and waits for the
+ * message to complete, or timeout.
+ *
+ * Do not use this function from within an interrupt context. If you need
+ * an asynchronous message, or need to send a message from within interrupt
+ * context, use usb_submit_urb(). If a thread in your driver uses this call,
+ * make sure your disconnect() method can wait for it to complete. Since you
+ * don't have a handle on the URB used, you can't cancel the request.
+ *
+ * The data pointer can be made to a reference on the stack, or anywhere else,
+ * as it will not be modified at all.  This does not have the restriction that
+ * usb_control_msg() has where the data pointer must be to dynamically allocated
+ * memory (i.e. memory that can be successfully DMAed to a device).
+ *
+ * Return: If successful, 0 is returned, Otherwise, a negative error number.
+ */
+int usb_control_msg_send(struct usb_device *dev, __u8 endpoint, __u8 request,
+			 __u8 requesttype, __u16 value, __u16 index,
+			 const void *driver_data, __u16 size, int timeout)
+{
+	unsigned int pipe = usb_sndctrlpipe(dev, endpoint);
+	int ret;
+	u8 *data = NULL;
+
+	if (usb_pipe_type_check(dev, pipe))
+		return -EINVAL;
+
+	if (size) {
+		data = kmemdup(driver_data, size, GFP_KERNEL);
+		if (!data)
+			return -ENOMEM;
+	}
+
+	ret = usb_control_msg(dev, pipe, request, requesttype, value, index,
+			      data, size, timeout);
+	kfree(data);
+
+	if (ret < 0)
+		return ret;
+	if (ret == size)
+		return 0;
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(usb_control_msg_send);
+
+/**
+ * usb_control_msg_recv - Builds a control "receive" message, sends it off and waits for completion
+ * @dev: pointer to the usb device to send the message to
+ * @endpoint: endpoint to send the message to
+ * @request: USB message request value
+ * @requesttype: USB message request type value
+ * @value: USB message value
+ * @index: USB message index value
+ * @driver_data: pointer to the data to be filled in by the message
+ * @size: length in bytes of the data to be received
+ * @timeout: time in msecs to wait for the message to complete before timing
+ *	out (if 0 the wait is forever)
+ *
+ * Context: !in_interrupt ()
+ *
+ * This function sends a control message to a specified endpoint that is
+ * expected to fill in a response (i.e. a "receive message") and waits for the
+ * message to complete, or timeout.
+ *
+ * Do not use this function from within an interrupt context. If you need
+ * an asynchronous message, or need to send a message from within interrupt
+ * context, use usb_submit_urb(). If a thread in your driver uses this call,
+ * make sure your disconnect() method can wait for it to complete. Since you
+ * don't have a handle on the URB used, you can't cancel the request.
+ *
+ * The data pointer can be made to a reference on the stack, or anywhere else
+ * that can be successfully written to.  This function does not have the
+ * restriction that usb_control_msg() has where the data pointer must be to
+ * dynamically allocated memory (i.e. memory that can be successfully DMAed to a
+ * device).
+ *
+ * The "whole" message must be properly received from the device in order for
+ * this function to be successful.  If a device returns less than the expected
+ * amount of data, then the function will fail.  Do not use this for messages
+ * where a variable amount of data might be returned.
+ *
+ * Return: If successful, 0 is returned, Otherwise, a negative error number.
+ */
+int usb_control_msg_recv(struct usb_device *dev, __u8 endpoint, __u8 request,
+			 __u8 requesttype, __u16 value, __u16 index,
+			 void *driver_data, __u16 size, int timeout)
+{
+	unsigned int pipe = usb_rcvctrlpipe(dev, endpoint);
+	int ret;
+	u8 *data;
+
+	if (!size || !driver_data || usb_pipe_type_check(dev, pipe))
+		return -EINVAL;
+
+	data = kmalloc(size, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	ret = usb_control_msg(dev, pipe, request, requesttype, value, index,
+			      data, size, timeout);
+
+	if (ret < 0)
+		goto exit;
+
+	if (ret == size) {
+		memcpy(driver_data, data, size);
+		ret = 0;
+	} else {
+		ret = -EINVAL;
+	}
+
+exit:
+	kfree(data);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(usb_control_msg_recv);
+
 /**
  * usb_interrupt_msg - Builds an interrupt urb, sends it off and waits for completion
  * @usb_dev: pointer to the usb device to send the message to
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 0b3963d7ec38..a5460f08126e 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -1802,6 +1802,12 @@ extern int usb_bulk_msg(struct usb_device *usb_dev, unsigned int pipe,
 	int timeout);
 
 /* wrappers around usb_control_msg() for the most common standard requests */
+int usb_control_msg_send(struct usb_device *dev, __u8 endpoint, __u8 request,
+			 __u8 requesttype, __u16 value, __u16 index,
+			 const void *data, __u16 size, int timeout);
+int usb_control_msg_recv(struct usb_device *dev, __u8 endpoint, __u8 request,
+			 __u8 requesttype, __u16 value, __u16 index,
+			 void *data, __u16 size, int timeout);
 extern int usb_get_descriptor(struct usb_device *dev, unsigned char desctype,
 	unsigned char descindex, void *buf, int size);
 extern int usb_get_status(struct usb_device *dev,
-- 
2.28.0

