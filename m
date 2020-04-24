Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5F2C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 01:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 355C02074F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 01:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k362AasE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbgDXBKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 21:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725888AbgDXBKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 21:10:09 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E74C09B042
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 18:10:08 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id a3so3884999wro.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 18:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2lczKYi6eXKIqEV5vZ3OKNN42MIcg9ncaA29fA6tV5c=;
        b=k362AasEOyB1hZyiKYyn7oJMpt7MhEmnTnZLwIwrtZPUbV81EfZN0mHvpywWsDlJAo
         YHETS/awxfTsyeOqruwu/O4eIbUQY5m7jWvgb4y0UZgYDoLzJJcV948J7zapkKI3MRcl
         nIeSFiDHYHCmRl9VxwlQHFAxE+FEBqGi7c+6Wey7PjvsHSwc6zbc3Pq1sULGU4XBdSyi
         QIxEzDBjILr0vXJHF0T0+u1QzY/TmnacZUiuwQmeXBeCVKg8R8lJeufELyAsKdbMmQC6
         6fG7pmzh4jlMEj0ruR94njKSvOqPIxDRmMFoSd8MonQCtYCz5AXdJ7ICvWpcEWnf7XPu
         DPQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2lczKYi6eXKIqEV5vZ3OKNN42MIcg9ncaA29fA6tV5c=;
        b=Vg4Pwxudcdb147lUhaSUmPf0u0j4ybhMhAKKOLHRKVTmtgXxtw6R7H7pI6gy1EqUkW
         9tv2FoXkD/t3A8+Ne9dcWym3ZXychMwmWTsnw4j+fKykkoBKav1h4uc7d+F0XNzsZh5f
         cUaQAg0Y+SV2VpsyvA+BY04KO0v2Pdrq6yZjkS6hvFQSXKNIVfNKj/HQiVmbgNubRpzU
         SoxW8pWZy4r0QrKLcfONtvqrQYH8NgAuDQtZm96Ptnk4sWW8u0+Mia9y83tD7l50Xb9g
         Gv/eF0Kwa3NgQ0yVEDRGD+huPD+brXtxEqr2NavNp3pRa7yts8glsIUZsZQ94ByhZHZx
         PQDA==
X-Gm-Message-State: AGi0PuakO4h2ina2YUP3W3bZmaaRzI9+fgaQwZ7zzNUqioHi9PLP9I/8
        gf3K+3Ev6/6Y9dTEQ3M/kXFZperUyMbr/xVM
X-Google-Smtp-Source: APiQypIHd9N1IA6FkupTM7be7kBBWctFdnyZM1y7pXkX8lojIIfJy0f+oMp7IR1LlAdk96j7s54eBmX3cuA3wJ2y
X-Received: by 2002:adf:f146:: with SMTP id y6mr8493146wro.132.1587690607372;
 Thu, 23 Apr 2020 18:10:07 -0700 (PDT)
Date:   Fri, 24 Apr 2020 03:09:59 +0200
In-Reply-To: <ca6b79b47313aa7ee9d8c24c5a7f595772764171.1587690539.git.andreyknvl@google.com>
Message-Id: <059e7e0ff26cc7d6e85275f764e31d85db867c4b.1587690539.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <ca6b79b47313aa7ee9d8c24c5a7f595772764171.1587690539.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH USB 2/2] usb: raw-gadget: fix typo in uapi headers
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

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/uapi/linux/usb/raw_gadget.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/usb/raw_gadget.h b/include/uapi/linux/usb/raw_gadget.h
index ea375082b3ac..8544802b25bd 100644
--- a/include/uapi/linux/usb/raw_gadget.h
+++ b/include/uapi/linux/usb/raw_gadget.h
@@ -119,7 +119,7 @@ struct usb_raw_ep_io {
  * received on endpoint 0, provided that was an IN (OUT for READ) request and
  * waits until the urb is completed. Copies received data to user for READ.
  * Accepts a pointer to the usb_raw_ep_io struct as an argument.
- * Returns length of trasferred data on success or negative error code on
+ * Returns length of transferred data on success or negative error code on
  * failure.
  */
 #define USB_RAW_IOCTL_EP0_WRITE		_IOW('U', 3, struct usb_raw_ep_io)
@@ -145,7 +145,7 @@ struct usb_raw_ep_io {
  * request and waits until the urb is completed. Copies received data to user
  * for READ.
  * Accepts a pointer to the usb_raw_ep_io struct as an argument.
- * Returns length of trasferred data on success or negative error code on
+ * Returns length of transferred data on success or negative error code on
  * failure.
  */
 #define USB_RAW_IOCTL_EP_WRITE		_IOW('U', 7, struct usb_raw_ep_io)
-- 
2.26.2.303.gf8c07b1a785-goog

