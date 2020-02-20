Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CF9C11D00
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 23:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 662D0206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 23:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jNYTcbtZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729301AbgBTXRe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 18:17:34 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42684 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbgBTXRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 18:17:33 -0500
Received: by mail-pl1-f194.google.com with SMTP id e8so31911plt.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 15:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=GxESY9cCCgLTkgGkKtzbp5bRQNlNB9O8BeLFIt6JfkM=;
        b=jNYTcbtZxZtro9NYnn/bar7mqcFDmLILk22NZtPHeKBmVkLarUSJXOhjFOxOF6tyUf
         6KlpZtdlXbDvs1f4RxdOpLwM9T+XaTf4WEhdTmpXym0VdUBuH/GnKq+ngPuV5gQm1LXT
         eTaFdVN4LMcQxMtw9NuILYsFBoc4eSBAHgM8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=GxESY9cCCgLTkgGkKtzbp5bRQNlNB9O8BeLFIt6JfkM=;
        b=P0RB19ENrMBvf8c8CtIR6OovJUD08zkK4zzpPa8DFakVrBYyXQKDYiTwIztcoCyCwr
         x6XEtH+AdxoEjCj9DadfAiyDsVhomerDcHtmvhIaYtk1O+S5ML9nEdPjR2/9QLUO/d/V
         /V/7ZZ29me4fdjqr9aQUQUc4Wn2cBT7yTyvZO+RNGzZ3nwZIpxIZ+C1SBIN6O1skzXFv
         O2RR+b6Yks0ehlyxk7UDXvvVYvynM5k2QlK6qLlUvOHZSoSvTd62R+C5QW6MJlH+5qSv
         /xGiXcbeMdyZS+NQNvNgMoNvD5CMbmz+9i9npQKnK1zoq+/TXORr7bgIUvXGp8w0X5aS
         1gDw==
X-Gm-Message-State: APjAAAW+hTK7j2owKR/pRY8pIODy0pkHrUSbfeD+ZBpIHkUrHqpq5fOY
        6bVhcPs5sXwWIvu62nl6zAL7Dw==
X-Google-Smtp-Source: APXvYqzYHzVzO1NxF0/OjwGSwpPdhPVcHaNQ5DSsLOYOqB9xBA033dslL2vLrPnMHfdvIxc7s5gkEA==
X-Received: by 2002:a17:90a:cb0f:: with SMTP id z15mr6337151pjt.67.1582240653042;
        Thu, 20 Feb 2020 15:17:33 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d14sm647534pfq.117.2020.02.20.15.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 15:17:32 -0800 (PST)
Date:   Thu, 20 Feb 2020 15:17:30 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Alexander Potapenko <glider@google.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] usb: gadget: net2280: Distribute switch variables for
 initialization
Message-ID: <202002201515.DFC51CF@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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
v2: put everything in function body (Alan Stern)
v1: https://lore.kernel.org/lkml/20200220062315.69253-1-keescook@chromium.org
---
 drivers/usb/gadget/udc/net2280.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/udc/net2280.c b/drivers/usb/gadget/udc/net2280.c
index 1fd1b9186e46..8e24d1c724be 100644
--- a/drivers/usb/gadget/udc/net2280.c
+++ b/drivers/usb/gadget/udc/net2280.c
@@ -2861,6 +2861,8 @@ static void ep_clear_seqnum(struct net2280_ep *ep)
 static void handle_stat0_irqs_superspeed(struct net2280 *dev,
 		struct net2280_ep *ep, struct usb_ctrlrequest r)
 {
+	struct net2280_ep *e;
+	u16 status;
 	int tmp = 0;
 
 #define	w_value		le16_to_cpu(r.wValue)
@@ -2868,9 +2870,6 @@ static void handle_stat0_irqs_superspeed(struct net2280 *dev,
 #define	w_length	le16_to_cpu(r.wLength)
 
 	switch (r.bRequest) {
-		struct net2280_ep *e;
-		u16 status;
-
 	case USB_REQ_SET_CONFIGURATION:
 		dev->addressed_state = !w_value;
 		goto usb3_delegate;
-- 
2.20.1


-- 
Kees Cook
