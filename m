Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FB6C2BB55
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 14:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AA4D2078A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 14:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RtXu6P/4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbgDGOO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 10:14:57 -0400
Received: from mail-wm1-f74.google.com ([209.85.128.74]:51346 "EHLO
        mail-wm1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728812AbgDGOO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 10:14:57 -0400
Received: by mail-wm1-f74.google.com with SMTP id o26so899657wmh.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 07:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=gOTUaqmgbGCsE0dVLTz9SOZ17zVq8RiTIkdhy3fA4uM=;
        b=RtXu6P/4U4fHkpq2NJTWopKO2cpCfiMN7O8tch7NptGBMwdtYdHqh/THbw9Ct12QaE
         kKT6cmNhVDe4hYgj2Cn/K30IGR+GPiJ8I2xavinT9NLHdgFbpBFJxfSPQVdkr3dhCw1U
         zEYRvhaOiibxKn0gNechJZYO6jEQo2Kw6jxCR5GJSJH15OB6iWadkswM+KgfkDGuNOdW
         wNCf4hgSTdOVE370FnCcOicjkT9irrs2APdaWKvl/m60kMT3YUxVLZ1M/tHUCe3lkAGJ
         7CwBS5zJNuLNY6Xg4JwQnVaVgv0pgLLNlhLMTniAQEIL20LyNMPe14QP52rQXi/JVnJw
         iWLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=gOTUaqmgbGCsE0dVLTz9SOZ17zVq8RiTIkdhy3fA4uM=;
        b=GGa1kEJ98PcTT1auYlrjbC2ciD0Wh72lbzzhifbDC70gOaVRwKvGfS2uop4CzZbNRk
         7WEUCcO6fzgBYbVbNP1UlcvlsmbGSqdk38crE+xc1krNFOHJOd5WkXm4+nZ2u94DzZhe
         ibLrDBqQNmYESJkL4XtJCZq3ZYUDtRZ3Yu7f4p4hvIIKgI92SXGHugwc7zK45d+wrTsx
         n8OIBwGXWeMvteZpqo8cuoOo/8zwYw0fcHq0cj4hgz7HNBMWWa72KuQoX5XtuHflgiIg
         946+Jrr8SscF7g/p/8Gh+4P+Hu2IjPlp4dw0xnKq0HqFBNKL6UYDIjWS9mKSUloSjOU/
         iXxw==
X-Gm-Message-State: AGi0PuZMWgZ1XKvRoGf9/kr8auZVSU2xZtTapCzDUlXOsH3qiXPGnPpF
        jGByKdECjLTOwBHcD7l0b1Ht96/RyYRQWyaT
X-Google-Smtp-Source: APiQypIuCxxkxv9G1eKVjmIVs2yLdCdb1+xcFVQyqd0Yt5LJUlM//Nn9s+vfGRkkadqLefDR/ZUjlgfZuz1rYxUV
X-Received: by 2002:adf:e691:: with SMTP id r17mr3023185wrm.421.1586268895116;
 Tue, 07 Apr 2020 07:14:55 -0700 (PDT)
Date:   Tue,  7 Apr 2020 16:14:50 +0200
Message-Id: <c4cedb13ee6159857ed7d9884e55718e4b1dede4.1586268809.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
Subject: [PATCH v2] usb: raw-gadget: fix raw_event_queue_fetch locking
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If queue->size check in raw_event_queue_fetch() fails (which normally
shouldn't happen, that check is a fail-safe), the function returns
without reenabling interrupts. This patch fixes that issue, along with
propagating the cause of failure to the function caller.

Fixes: f2c2e717642c ("usb: gadget: add raw-gadget interface"
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---

Changes in v2:
- Added a comment before the WARN_ON() call.

Greg, this should apply cleanly on top of Dan's "usb: raw-gadget: Fix
copy_to/from_user() checks" patch.

---
 drivers/usb/gadget/legacy/raw_gadget.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/legacy/raw_gadget.c
index e490ffa1f58b..85dfbcd461ac 100644
--- a/drivers/usb/gadget/legacy/raw_gadget.c
+++ b/drivers/usb/gadget/legacy/raw_gadget.c
@@ -81,6 +81,7 @@ static int raw_event_queue_add(struct raw_event_queue *queue,
 static struct usb_raw_event *raw_event_queue_fetch(
 				struct raw_event_queue *queue)
 {
+	int ret;
 	unsigned long flags;
 	struct usb_raw_event *event;
 
@@ -89,11 +90,18 @@ static struct usb_raw_event *raw_event_queue_fetch(
 	 * there's at least one event queued by decrementing the semaphore,
 	 * and then take the lock to protect queue struct fields.
 	 */
-	if (down_interruptible(&queue->sema))
-		return NULL;
+	ret = down_interruptible(&queue->sema);
+	if (ret)
+		return ERR_PTR(ret);
 	spin_lock_irqsave(&queue->lock, flags);
-	if (WARN_ON(!queue->size))
+	/*
+	 * queue->size must have the same value as queue->sema counter (before
+	 * the down_interruptible() call above), so this check is a fail-safe.
+	 */
+	if (WARN_ON(!queue->size)) {
+		spin_unlock_irqrestore(&queue->lock, flags);
 		return NULL;
+	}
 	event = queue->events[0];
 	queue->size--;
 	memmove(&queue->events[0], &queue->events[1],
@@ -522,10 +530,17 @@ static int raw_ioctl_event_fetch(struct raw_dev *dev, unsigned long value)
 	spin_unlock_irqrestore(&dev->lock, flags);
 
 	event = raw_event_queue_fetch(&dev->queue);
-	if (!event) {
+	if (PTR_ERR(event) == -EINTR) {
 		dev_dbg(&dev->gadget->dev, "event fetching interrupted\n");
 		return -EINTR;
 	}
+	if (IS_ERR_OR_NULL(event)) {
+		dev_err(&dev->gadget->dev, "failed to fetch event\n");
+		spin_lock_irqsave(&dev->lock, flags);
+		dev->state = STATE_DEV_FAILED;
+		spin_unlock_irqrestore(&dev->lock, flags);
+		return -ENODEV;
+	}
 	length = min(arg.length, event->length);
 	if (copy_to_user((void __user *)value, event, sizeof(*event) + length))
 		return -EFAULT;
-- 
2.26.0.292.g33ef6b2f38-goog

