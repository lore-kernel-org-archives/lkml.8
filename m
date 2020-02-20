Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F03C11D42
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 06:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F4BD2465D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 06:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GtMY8VRr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbgBTGX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 01:23:27 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45678 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbgBTGXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 01:23:20 -0500
Received: by mail-pg1-f194.google.com with SMTP id b9so1379489pgk.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 22:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r7W1IeYO5luNyCIfOI+KTpss0yVfj4B4P/bY+7anUj4=;
        b=GtMY8VRryc4tgEAZGFnHgZwifnQLW90Ls2V3FbDv7DGB/HQqIksqO+WTqzfYGx9yL/
         v0WMmt16AUT4OP+0CDmzqdVSg4knv8RD+RRV7JrC9tnF63W+hQyCQSJJLTvGjBPKR6AS
         dgWP+eUZvmip3PM89KktbrcAIjM7V+++IHS2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r7W1IeYO5luNyCIfOI+KTpss0yVfj4B4P/bY+7anUj4=;
        b=D2g3PT9oiglM3r0dNjq0i8XWjEJCLWdu39CA6uNhmWvBLa0q0V8C3jzoA1qIm3a+wG
         KEiYXuBBGifzbySCJ0uSh8bH7FLvMxL+vK/sDKV1JkPlhdndnwwLtuge2K14JNa2gEK9
         bFOng3hsqCbH46a9LKIv9Jl0QPUumFF0dXaHEYlqW2YtB843AAVoC2PBgMC+FABOLuVV
         m4cR+vsJKw2+h5rXxuTBbOTjnpx+b9aUuZX4xK+wUVl+soru6Lj9Dr14cx2MHE5nGWM+
         0J4ufuEIPJRXUUBo7TnFlWZT87YEKhP5t81nw44TPOrsT/xrbMFmFLJcjFQxXocg+w72
         DdZw==
X-Gm-Message-State: APjAAAXMRk4xGr8l0h65qu8Js1KcagdGmla2p+qs1yscuSKCnm/roYkK
        a61uFluTArme4najDRjZLYnAwA==
X-Google-Smtp-Source: APXvYqzyLQqVUdbOMVTIixpgCSWP3Hc4yP/kWSP5g3dy+5aQAi9rqzpohQ6OfqeemMzgq/kJqNBUFg==
X-Received: by 2002:a62:7696:: with SMTP id r144mr30710610pfc.177.1582179799553;
        Wed, 19 Feb 2020 22:23:19 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x6sm1701090pfi.83.2020.02.19.22.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 22:23:18 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@chromium.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: gadget: net2280: Distribute switch variables for initialization
Date:   Wed, 19 Feb 2020 22:23:15 -0800
Message-Id: <20200220062315.69253-1-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variables declared in a switch statement before any case statements
cannot be automatically initialized with compiler instrumentation (as
they are not part of any execution flow). With GCC's proposed automatic
stack variable initialization feature, this triggers a warning (and they
don't get initialized). Clang's automatic stack variable initialization
(via CONFIG_INIT_STACK_ALL=y) doesn't throw a warning, but it also
doesn't initialize such variables[1]. Note that these warnings (or silent
skipping) happen before the dead-store elimination optimization phase,
so even when the automatic initializations are later elided in favor of
direct initializations, the warnings remain.

To avoid these problems, move such variables into the "case" where
they're used or lift them up into the main function body.

drivers/usb/gadget/udc/net2280.c: In function ‘handle_stat0_irqs_superspeed’:
drivers/usb/gadget/udc/net2280.c:2871:22: warning: statement will never be executed [-Wswitch-unreachable]
 2871 |   struct net2280_ep *e;
      |                      ^

[1] https://bugs.llvm.org/show_bug.cgi?id=44916

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/usb/gadget/udc/net2280.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/udc/net2280.c b/drivers/usb/gadget/udc/net2280.c
index 1fd1b9186e46..cc5869363298 100644
--- a/drivers/usb/gadget/udc/net2280.c
+++ b/drivers/usb/gadget/udc/net2280.c
@@ -2861,6 +2861,7 @@ static void ep_clear_seqnum(struct net2280_ep *ep)
 static void handle_stat0_irqs_superspeed(struct net2280 *dev,
 		struct net2280_ep *ep, struct usb_ctrlrequest r)
 {
+	struct net2280_ep *e;
 	int tmp = 0;
 
 #define	w_value		le16_to_cpu(r.wValue)
@@ -2868,14 +2869,13 @@ static void handle_stat0_irqs_superspeed(struct net2280 *dev,
 #define	w_length	le16_to_cpu(r.wLength)
 
 	switch (r.bRequest) {
-		struct net2280_ep *e;
-		u16 status;
-
 	case USB_REQ_SET_CONFIGURATION:
 		dev->addressed_state = !w_value;
 		goto usb3_delegate;
 
-	case USB_REQ_GET_STATUS:
+	case USB_REQ_GET_STATUS: {
+		u16 status;
+
 		switch (r.bRequestType) {
 		case (USB_DIR_IN | USB_TYPE_STANDARD | USB_RECIP_DEVICE):
 			status = dev->wakeup_enable ? 0x02 : 0x00;
@@ -2905,7 +2905,7 @@ static void handle_stat0_irqs_superspeed(struct net2280 *dev,
 			goto usb3_delegate;
 		}
 		break;
-
+	}
 	case USB_REQ_CLEAR_FEATURE:
 		switch (r.bRequestType) {
 		case (USB_DIR_OUT | USB_TYPE_STANDARD | USB_RECIP_DEVICE):

