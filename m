Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A08C54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 13:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C847620767
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 13:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PdCZQPxF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgDXNUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 09:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbgDXNU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 09:20:29 -0400
Received: from mail-ua1-x949.google.com (mail-ua1-x949.google.com [IPv6:2607:f8b0:4864:20::949])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34356C09B045
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 06:20:29 -0700 (PDT)
Received: by mail-ua1-x949.google.com with SMTP id t26so4997081uar.14
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 06:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=iVEHdoFtCdFpiBaH+7lTMwaiCbL5fq6YQc2JbTG34i0=;
        b=PdCZQPxFLh4X4g5Ge3zd7n/ltxri3640RXfDg8wJyfnyqccwK4dNf6XCxJUoDtGfHi
         NCZXLr0l23ePq/mUzsBAqQgrJwLnifk7PHlnEWjWovbaGsSQK+rGwyCMiyvwBJDRWN0H
         49TzMZBzZPVhBD5vBJ1BJohRFK0Z9L+dEYCyOBNPAN7eDKYKYwXXiFQUeiiRlwsis2m2
         iaKg+XOwjGAF0atcmVy/kJh3248oEYro+CDniEPaSy46WuLqmZymFJqhrkdMb+XaWCu1
         syFtzCej7wE791ewsv/Pgujzbyp43R1Rw9h/+xWUqIqo9pJLLB1VCbBOiDUYK79B0AEv
         Qqbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iVEHdoFtCdFpiBaH+7lTMwaiCbL5fq6YQc2JbTG34i0=;
        b=frWFhH82+92/52WehtujkmswVP8KXcwLKwAGTKwErgbXw5vnJzyzBMr5cRsOBPg3DC
         1YB9ruYYUPeUy8oYZIteVpyLGBYy/N9K/DylAFX9Rn+2Mbb4tnnGWteb16/lEEww0UIv
         L9u36R1Lq5HeLcAPVzPM65/QoGWNvQ9mw0vCeXUBAN4BhSF+44+4j34P/S5M2JcdsncA
         ZitdjqaynOGLOE9TTBFvLe0ZRpfEtJeBIPNFG9ism2kiySNiH8vWXg8oTuOfjX0OaLXV
         ZSrhUMruaY9DCe6myzH4V5q6IJG40Gp0ZRt9kNSX4MpLBp1itoacH+o8tf1cekbTMeBv
         pFPg==
X-Gm-Message-State: AGi0PuYYlD/yOm/2kTdDpuiC5BnhCKUmOlDiux/NvQy7zJdVckKRc0fc
        JW3N7+eqsYTTlOi1u7rVZiHhh7rVNB3xTMat
X-Google-Smtp-Source: APiQypKBNnbfnbdI4IQDk1HiBGDGCEt6LytLKochQyMW8Chmj4ToVQPSf3IEhYa2CEKPn1r93OojRJbC1kl5TjKi
X-Received: by 2002:a1f:ff11:: with SMTP id p17mr7604647vki.25.1587734428386;
 Fri, 24 Apr 2020 06:20:28 -0700 (PDT)
Date:   Fri, 24 Apr 2020 15:20:20 +0200
In-Reply-To: <9c99c508da044822baf53db5e3fccd4f21b0f8d3.1587734346.git.andreyknvl@google.com>
Message-Id: <635f48fcb4bb99c70ab9d7f0dfe84d1ec7dc540e.1587734346.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <9c99c508da044822baf53db5e3fccd4f21b0f8d3.1587734346.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH USB v2 2/2] usb: raw-gadget: fix typo in uapi headers
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

Change "trasferred" into "transferred".

Change-Id: I2d8d1dcc9ba6aacafc03f4b76caca7409a6da1a6
---

Changes in v2:

- Updated commit message.

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

