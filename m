Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D149C83000
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 01:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63B692082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 01:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ps/a2k5X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgD3BID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 21:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726684AbgD3BIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 21:08:01 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63912C035495
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 18:08:01 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 186so5887728ybq.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 18:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=bDQ0mN4+QtjESwDiT+8KEwDYky6Yk4tgT9MYtQqBwao=;
        b=ps/a2k5XkrO8WuE9Vf539ADlhvPlCtx0Cvhg4D+9gxFiZKc3Pb1SwuOYhc3kODEPBh
         8yASzLLmwDTyZt2/hwD6pbwhGMVbqp4bkI2j2AV/k6JDjXay1UD7PplihnvVtigFiuJF
         qUgI8KrgjeM5SjsHOpXmFkTiGFHKpI99Tx7cJmWyiNWoC4KG8pzwIqcLH5yb3TT8gRBZ
         HjrbhLk9uaaGGnxBhVjxlhBGfTkSqxdvM/IOCc+3Sl5rK+ChZiLmFxNN8pQl6NzZiRDN
         EUpA/898t7w6W6cqK7I4924GgQNPwuBLilX5VamXgfuvz54hhH11GsLNkV+IdZB5sDT3
         S/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=bDQ0mN4+QtjESwDiT+8KEwDYky6Yk4tgT9MYtQqBwao=;
        b=ge5rqZWbVSnax+h/KDIUVKptZpQm5CV/OABjKKDsPORQE630ecy2MwwL61FdSwJFyK
         Ar5+9ZfLgo2x8UPkrfyf+7a/7hHybEilujIAFFpb/VDQjFcfa6UM8F8MkagaoyErfBN+
         c/2cLjIsLuiAPAa5DJPFEP6zzyAHSQ0VJ/bWRB5e9N6sW9paAVKKKbJzgQo4DGGK3TMV
         yDZzksR3b83W+typvEu9epGhkq9fUQnzGP8BVto3ULVsxkIxNIKmpTrlCJFGxDB4Piox
         WkHsmbpTtJHc3hNqXBiHtRV08cBwIhig6aXdWXkS0YPIzupeVIHiujkRCo8kaUma1hPy
         GCRQ==
X-Gm-Message-State: AGi0PuaGzG/m/JJ2uDbfS2acsqPK5/M+jY2GVCkkCzvy8SwUfC4B2OCe
        sGi5r85rF+u1dGog0wH06BaB2gOqfIaoMbLt
X-Google-Smtp-Source: APiQypKNfsynmAFob/BZ61tu/G5Bb6u6uhP0nNjHZDHMY16ql0THzID2BDtPKiY1K+pv3tTBLfKFZGfF7nPkBXJE
X-Received: by 2002:a25:80cd:: with SMTP id c13mr1790473ybm.335.1588208880442;
 Wed, 29 Apr 2020 18:08:00 -0700 (PDT)
Date:   Thu, 30 Apr 2020 03:07:52 +0200
Message-Id: <68e7b62aa7439e3346742b1153d18f65f3e8e388.1588208726.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH USB] usb: raw-gadget: support stalling/halting/wedging endpoints
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Raw Gadget is currently unable to stall/halt/wedge gadget endpoints,
which is required for proper emulation of certain USB classes.

This patch adds a few more ioctls:

- USB_RAW_IOCTL_EP0_STALL allows to stall control endpoint #0 when
  there's a pending setup request for it.
- USB_RAW_IOCTL_SET/CLEAR_HALT/WEDGE allow to set/clear halt/wedge status
  on non-control non-isochronous endpoints.

Fixes: f2c2e717642c ("usb: gadget: add raw-gadget interface")
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---

This goes on top of:

[PATCH v2] usb: raw-gadget: fix gadget endpoint selection

which in turns goes on top of:

[PATCH USB v2 1/2] usb: raw-gadget: fix return value of ep read ioctls
[PATCH USB v2 2/2] usb: raw-gadget: fix typo in uapi headers

---
 Documentation/usb/raw-gadget.rst       |   2 -
 drivers/usb/gadget/legacy/raw_gadget.c | 131 ++++++++++++++++++++++++-
 include/uapi/linux/usb/raw_gadget.h    |  15 +++
 3 files changed, 144 insertions(+), 4 deletions(-)

diff --git a/Documentation/usb/raw-gadget.rst b/Documentation/usb/raw-gadget.rst
index 42bd446d72b2..f70aa635e11d 100644
--- a/Documentation/usb/raw-gadget.rst
+++ b/Documentation/usb/raw-gadget.rst
@@ -49,8 +49,6 @@ The typical usage of Raw Gadget looks like:
 Potential future improvements
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- Implement ioctl's for setting/clearing halt status on endpoints.
-
 - Reporting more events (suspend, resume, etc.) through
   USB_RAW_IOCTL_EVENT_FETCH.
 
diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/legacy/raw_gadget.c
index e6abbc15341a..9ceeecac5ee0 100644
--- a/drivers/usb/gadget/legacy/raw_gadget.c
+++ b/drivers/usb/gadget/legacy/raw_gadget.c
@@ -204,7 +204,7 @@ static void dev_free(struct kref *kref)
 	}
 	raw_event_queue_destroy(&dev->queue);
 	for (i = 0; i < dev->eps_num; i++) {
-		if (dev->eps[i].state != STATE_EP_ENABLED)
+		if (dev->eps[i].state == STATE_EP_DISABLED)
 			continue;
 		usb_ep_disable(dev->eps[i].ep);
 		usb_ep_free_request(dev->eps[i].ep, dev->eps[i].req);
@@ -704,6 +704,50 @@ static int raw_ioctl_ep0_read(struct raw_dev *dev, unsigned long value)
 	return ret;
 }
 
+static int raw_ioctl_ep0_stall(struct raw_dev *dev, unsigned long value)
+{
+	int ret = 0;
+	unsigned long flags;
+
+	if (value)
+		return -EINVAL;
+	spin_lock_irqsave(&dev->lock, flags);
+	if (dev->state != STATE_DEV_RUNNING) {
+		dev_dbg(dev->dev, "fail, device is not running\n");
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+	if (!dev->gadget) {
+		dev_dbg(dev->dev, "fail, gadget is not bound\n");
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+	if (dev->ep0_urb_queued) {
+		dev_dbg(&dev->gadget->dev, "fail, urb already queued\n");
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+	if (!dev->ep0_in_pending && !dev->ep0_out_pending) {
+		dev_dbg(&dev->gadget->dev, "fail, no request pending\n");
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+
+	ret = usb_ep_set_halt(dev->gadget->ep0);
+	if (ret < 0)
+		dev_err(&dev->gadget->dev,
+				"fail, usb_ep_set_halt returned %d\n", ret);
+
+	if (dev->ep0_in_pending)
+		dev->ep0_in_pending = false;
+	else
+		dev->ep0_out_pending = false;
+
+out_unlock:
+	spin_unlock_irqrestore(&dev->lock, flags);
+	return ret;
+}
+
 static int raw_ioctl_ep_enable(struct raw_dev *dev, unsigned long value)
 {
 	int ret = 0, i;
@@ -810,7 +854,7 @@ static int raw_ioctl_ep_disable(struct raw_dev *dev, unsigned long value)
 		ret = -EBUSY;
 		goto out_unlock;
 	}
-	if (dev->eps[i].state != STATE_EP_ENABLED) {
+	if (dev->eps[i].state == STATE_EP_DISABLED) {
 		dev_dbg(&dev->gadget->dev, "fail, endpoint is not enabled\n");
 		ret = -EINVAL;
 		goto out_unlock;
@@ -848,6 +892,74 @@ static int raw_ioctl_ep_disable(struct raw_dev *dev, unsigned long value)
 	return ret;
 }
 
+static int raw_ioctl_ep_set_clear_halt_wedge(struct raw_dev *dev,
+		unsigned long value, bool set, bool halt)
+{
+	int ret = 0, i = value;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dev->lock, flags);
+	if (dev->state != STATE_DEV_RUNNING) {
+		dev_dbg(dev->dev, "fail, device is not running\n");
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+	if (!dev->gadget) {
+		dev_dbg(dev->dev, "fail, gadget is not bound\n");
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+	if (i < 0 || i >= dev->eps_num) {
+		dev_dbg(dev->dev, "fail, invalid endpoint\n");
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+	if (dev->eps[i].state == STATE_EP_DISABLED) {
+		dev_dbg(&dev->gadget->dev, "fail, endpoint is not enabled\n");
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+	if (dev->eps[i].disabling) {
+		dev_dbg(&dev->gadget->dev,
+				"fail, disable is in progress\n");
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+	if (dev->eps[i].urb_queued) {
+		dev_dbg(&dev->gadget->dev,
+				"fail, waiting for urb completion\n");
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+	if (usb_endpoint_xfer_isoc(dev->eps[i].ep->desc)) {
+		dev_dbg(&dev->gadget->dev,
+				"fail, can't halt/wedge ISO endpoint\n");
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	if (set && halt) {
+		ret = usb_ep_set_halt(dev->eps[i].ep);
+		if (ret < 0)
+			dev_err(&dev->gadget->dev,
+				"fail, usb_ep_set_halt returned %d\n", ret);
+	} else if (!set && halt) {
+		ret = usb_ep_clear_halt(dev->eps[i].ep);
+		if (ret < 0)
+			dev_err(&dev->gadget->dev,
+				"fail, usb_ep_clear_halt returned %d\n", ret);
+	} else if (set && !halt) {
+		ret = usb_ep_set_wedge(dev->eps[i].ep);
+		if (ret < 0)
+			dev_err(&dev->gadget->dev,
+				"fail, usb_ep_set_wedge returned %d\n", ret);
+	}
+
+out_unlock:
+	spin_unlock_irqrestore(&dev->lock, flags);
+	return ret;
+}
+
 static void gadget_ep_complete(struct usb_ep *ep, struct usb_request *req)
 {
 	struct raw_ep *r_ep = (struct raw_ep *)ep->driver_data;
@@ -1144,6 +1256,21 @@ static long raw_ioctl(struct file *fd, unsigned int cmd, unsigned long value)
 	case USB_RAW_IOCTL_EPS_INFO:
 		ret = raw_ioctl_eps_info(dev, value);
 		break;
+	case USB_RAW_IOCTL_EP0_STALL:
+		ret = raw_ioctl_ep0_stall(dev, value);
+		break;
+	case USB_RAW_IOCTL_EP_SET_HALT:
+		ret = raw_ioctl_ep_set_clear_halt_wedge(
+					dev, value, true, true);
+		break;
+	case USB_RAW_IOCTL_EP_CLEAR_HALT:
+		ret = raw_ioctl_ep_set_clear_halt_wedge(
+					dev, value, false, true);
+		break;
+	case USB_RAW_IOCTL_EP_SET_WEDGE:
+		ret = raw_ioctl_ep_set_clear_halt_wedge(
+					dev, value, true, false);
+		break;
 	default:
 		ret = -EINVAL;
 	}
diff --git a/include/uapi/linux/usb/raw_gadget.h b/include/uapi/linux/usb/raw_gadget.h
index 722124fff290..12ed9fa9ad97 100644
--- a/include/uapi/linux/usb/raw_gadget.h
+++ b/include/uapi/linux/usb/raw_gadget.h
@@ -244,4 +244,19 @@ struct usb_raw_eps_info {
  */
 #define USB_RAW_IOCTL_EPS_INFO		_IOR('U', 11, struct usb_raw_eps_info)
 
+/*
+ * Stalls a pending control request on endpoint 0.
+ * Returns 0 on success or negative error code on failure.
+ */
+#define USB_RAW_IOCTL_EP0_STALL		_IO('U', 12)
+
+/*
+ * Sets or clears halt or wedge status of the endpoint.
+ * Accepts endpoint handle as an argument.
+ * Returns 0 on success or negative error code on failure.
+ */
+#define USB_RAW_IOCTL_EP_SET_HALT	_IOW('U', 12, __u32)
+#define USB_RAW_IOCTL_EP_CLEAR_HALT	_IOW('U', 13, __u32)
+#define USB_RAW_IOCTL_EP_SET_WEDGE	_IOW('U', 14, __u32)
+
 #endif /* _UAPI__LINUX_USB_RAW_GADGET_H */
-- 
2.26.2.303.gf8c07b1a785-goog

