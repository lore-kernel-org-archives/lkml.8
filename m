Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A8AC2BA1B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 16:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBACE2496D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 16:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hTqD+W5O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729654AbgDFQl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 12:41:59 -0400
Received: from mail-wr1-f73.google.com ([209.85.221.73]:48648 "EHLO
        mail-wr1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729617AbgDFQl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 12:41:56 -0400
Received: by mail-wr1-f73.google.com with SMTP id d1so81817wru.15
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 09:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=MRjytoTEBKrt8aQLsMYC6tlVfTx2Uch92ldjURsQQQI=;
        b=hTqD+W5OPhE0YOBWh6tJD21i4lK36j0CqvGr/4l2eL71mqbpXSi0D4mVaqQcXRHciM
         cxGCEy9S9WafkNQT7BIcKBpjaXBvkX/UZCRPcgcFmGmd+vOBYh4DRHk3drpoyX/58VoU
         O2gfzNHVjK022wBaAU2iic6LoqsqtlOeZ99UuaVToQi170Zg61P6e3rptmLqx0wPZd3M
         NF5A5ZCFtmcsO/lehpJS48UpcVwbxqLvbi7qJpWs9pZ8bsz9Zl63jNPFF2sqrcb79oHY
         35zN7CPfk1oTM/i6dL4jLh/jYfTErgpudqBKk569mSng4b/orWxdZIjcImcO+AtiOIxz
         aRdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=MRjytoTEBKrt8aQLsMYC6tlVfTx2Uch92ldjURsQQQI=;
        b=UL7JVxJaNE1qZyRKqFCnptnCoYbhzf9Ct4/Dt+SmLWje13jZHPhJmX0vN46y78S3Cw
         LdDA4rpr7rgnPiaKbTbyBo28AcETev+AeFNz1ED/kzy3C6UyPH0lkpodYdJLdtlZgWDE
         2jDpNFMcGAeFvRZUmVXLcXMY3PzTtw97xsxdOQYftqnsRh1Zbgk3UEy+Hn9L46LIlOEE
         alnNT9OglvikQij4RarX07yeaucAXET8ngbR0SMmsqx/+ZSI6Jn9y1TurhXu11OM/A/o
         +AbtLSjYwHsik+6aEh4AmCeDvWhmVUiE3v9uVN6VRVsSMHzq1hW7hP84+wNKPeDZY7fB
         h2Zw==
X-Gm-Message-State: AGi0Pubml5VFqvjh4pQX076WyL6Cq9D3wJfCgQwL/2M/IjFboNkVTFYr
        HTmrN8izVrmnLQFcTNNYApnQQhatqmRtIKdP
X-Google-Smtp-Source: APiQypIeFTvKOe10+l4Jx6e6TStaYbpWIpj4TLTkuc3VbMP4026hAOnsx5axG05+zGwYzFQLTenvn/KS5NoqcIkB
X-Received: by 2002:a5d:6a47:: with SMTP id t7mr54263wrw.131.1586191312456;
 Mon, 06 Apr 2020 09:41:52 -0700 (PDT)
Date:   Mon,  6 Apr 2020 18:41:44 +0200
Message-Id: <178e01023f2e6664908f7c9660fa6527a55a22d6.1586191134.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
Subject: [PATCH] usb: raw-gadget: fix raw_event_queue_fetch locking
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

Greg, this should apply cleanly on top of Dan's "usb: raw-gadget: Fix
copy_to/from_user() checks" patch.

---
 drivers/usb/gadget/legacy/raw_gadget.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/legacy/raw_gadget.c
index e490ffa1f58b..1582521ec774 100644
--- a/drivers/usb/gadget/legacy/raw_gadget.c
+++ b/drivers/usb/gadget/legacy/raw_gadget.c
@@ -81,6 +81,7 @@ static int raw_event_queue_add(struct raw_event_queue *queue,
 static struct usb_raw_event *raw_event_queue_fetch(
 				struct raw_event_queue *queue)
 {
+	int ret;
 	unsigned long flags;
 	struct usb_raw_event *event;
 
@@ -89,11 +90,14 @@ static struct usb_raw_event *raw_event_queue_fetch(
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
+	if (WARN_ON(!queue->size)) {
+		spin_unlock_irqrestore(&queue->lock, flags);
 		return NULL;
+	}
 	event = queue->events[0];
 	queue->size--;
 	memmove(&queue->events[0], &queue->events[1],
@@ -522,10 +526,17 @@ static int raw_ioctl_event_fetch(struct raw_dev *dev, unsigned long value)
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

