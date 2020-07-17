Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF1EC433EA
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 15:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6845220775
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 15:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXYF5hMJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgGQPXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 11:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbgGQPXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 11:23:48 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9DAC0619D3;
        Fri, 17 Jul 2020 08:23:48 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id j18so15437259wmi.3;
        Fri, 17 Jul 2020 08:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uVV0eDyjWU3YA5bSVqcooIQZQct69gff1izMlpB8JwA=;
        b=MXYF5hMJ8bkRyAJgNAWmRblYjjqv5UX4iYbz0IreIbDwQtu5lzJ/l9jY/pKUgCo1lo
         hyfspuBWY7iCGiv3TzcHp3N2FWNuS6x2A/b+N1vH8HMCj09mqF90ozreZpKQmQnuAteo
         g4s/9YhDgWEzhBrX97R+t9iZZxkvUs3EJWJdMBm1Xn6izG/nW+Jaj3n5uJ7bPanuyT0f
         qO/yLQMAuzOtcSOirs6UCAcunnSIugjVsLktrqOitH91Iug44E5j+uB7eUTTxQNZRQLa
         NnQ4UPgLdbgebzRqj8NEjdBLUjCmsLhOfyAiW8w0nGyl/Zjd3XwM67eCrAMIk05jIr6G
         Uqog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uVV0eDyjWU3YA5bSVqcooIQZQct69gff1izMlpB8JwA=;
        b=ltXcmR3z7DyenX1plDvi+mzJuD8j269IYg8GYeM0lW8SRnzK4Dv4JlOjgDlhoe3qz+
         DaKZ06Pl/IDZKxIXFKdJU7XfF7va3PQLdhPbLs5Ww8H6O7spC3FVYXEU1CZSq5d6Eyem
         mZKrH53Ii9KBDIox2qIY4mJQHxudZcJcCKs2H+9PY3euP2oVe7G9HTW5C5to19NEFwjr
         wPpAgH1Qr1jBehRGGQb6hz1y1iapGRXhJV/XyoOHrg9y6FpguvpTAt9Jcvdj2w8qb8ur
         PeGAJoVzc4RHmmkTrfSzvZGb5hNHhxYFnSHb06zhRpHked1N8awMQ6fko2nkDVGCO5z0
         te7w==
X-Gm-Message-State: AOAM533PssDcdWxNY2rgkvACfwo7bjiGVDF89r/lS4ENMQQl/v55VHcH
        cWqY1mqwi6PS/mrrYYxQcff05C0J
X-Google-Smtp-Source: ABdhPJwWVnrCMcqmo8PSCXZkDMSE7TSUKK398AYg32tovCq/agVLtkb+arut0uVPkZHauXwUq4wCqA==
X-Received: by 2002:a1c:81c8:: with SMTP id c191mr9712938wmd.23.1594999426393;
        Fri, 17 Jul 2020 08:23:46 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id a22sm13431051wmb.4.2020.07.17.08.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 08:23:46 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sasi Kumar <sasi.kumar@broadcom.com>,
        Al Cooper <alcooperx@gmail.com>, devicetree@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 3/7] bdc: Fix bug causing crash after multiple disconnects
Date:   Fri, 17 Jul 2020 11:23:03 -0400
Message-Id: <20200717152307.36705-4-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200717152307.36705-1-alcooperx@gmail.com>
References: <20200717152307.36705-1-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sasi Kumar <sasi.kumar@broadcom.com>

Multiple connects/disconnects can cause a crash on the second
disconnect. The driver had a problem where it would try to send
endpoint commands after it was disconnected which is not allowed
by the hardware. The fix is to only allow the endpoint commands
when the endpoint is connected. This will also fix issues that
showed up when using configfs to create gadgets.

refs #SWLINUX-5477

Signed-off-by: Sasi Kumar <sasi.kumar@broadcom.com>
Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/usb/gadget/udc/bdc/bdc_core.c |  4 ++++
 drivers/usb/gadget/udc/bdc/bdc_ep.c   | 16 ++++++++++------
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/gadget/udc/bdc/bdc_core.c b/drivers/usb/gadget/udc/bdc/bdc_core.c
index 436a734ea0bc..be833d9e9db2 100644
--- a/drivers/usb/gadget/udc/bdc/bdc_core.c
+++ b/drivers/usb/gadget/udc/bdc/bdc_core.c
@@ -282,6 +282,7 @@ static void bdc_mem_init(struct bdc *bdc, bool reinit)
 	 * in that case reinit is passed as 1
 	 */
 	if (reinit) {
+		int i;
 		/* Enable interrupts */
 		temp = bdc_readl(bdc->regs, BDC_BDCSC);
 		temp |= BDC_GIE;
@@ -291,6 +292,9 @@ static void bdc_mem_init(struct bdc *bdc, bool reinit)
 		/* Initialize SRR to 0 */
 		memset(bdc->srr.sr_bds, 0,
 					NUM_SR_ENTRIES * sizeof(struct bdc_bd));
+		/* clear ep flags to avoid post disconnect stops/deconfigs */
+		for (i = 1; i < bdc->num_eps; ++i)
+			bdc->bdc_ep_array[i]->flags = 0;
 	} else {
 		/* One time initiaization only */
 		/* Enable status report function pointers */
diff --git a/drivers/usb/gadget/udc/bdc/bdc_ep.c b/drivers/usb/gadget/udc/bdc/bdc_ep.c
index d49c6dc1082d..9ddc0b4e92c9 100644
--- a/drivers/usb/gadget/udc/bdc/bdc_ep.c
+++ b/drivers/usb/gadget/udc/bdc/bdc_ep.c
@@ -615,7 +615,6 @@ int bdc_ep_enable(struct bdc_ep *ep)
 	}
 	bdc_dbg_bd_list(bdc, ep);
 	/* only for ep0: config ep is called for ep0 from connect event */
-	ep->flags |= BDC_EP_ENABLED;
 	if (ep->ep_num == 1)
 		return ret;
 
@@ -759,10 +758,13 @@ static int ep_dequeue(struct bdc_ep *ep, struct bdc_req *req)
 					__func__, ep->name, start_bdi, end_bdi);
 	dev_dbg(bdc->dev, "ep_dequeue ep=%p ep->desc=%p\n",
 						ep, (void *)ep->usb_ep.desc);
-	/* Stop the ep to see where the HW is ? */
-	ret = bdc_stop_ep(bdc, ep->ep_num);
-	/* if there is an issue with stopping ep, then no need to go further */
-	if (ret)
+	/* if still connected, stop the ep to see where the HW is ? */
+	if (!(bdc_readl(bdc->regs, BDC_USPC) & BDC_PST_MASK)) {
+		ret = bdc_stop_ep(bdc, ep->ep_num);
+		/* if there is an issue, then no need to go further */
+		if (ret)
+			return 0;
+	} else
 		return 0;
 
 	/*
@@ -1911,7 +1913,9 @@ static int bdc_gadget_ep_disable(struct usb_ep *_ep)
 		__func__, ep->name, ep->flags);
 
 	if (!(ep->flags & BDC_EP_ENABLED)) {
-		dev_warn(bdc->dev, "%s is already disabled\n", ep->name);
+		if (bdc->gadget.speed != USB_SPEED_UNKNOWN)
+			dev_warn(bdc->dev, "%s is already disabled\n",
+				 ep->name);
 		return 0;
 	}
 	spin_lock_irqsave(&bdc->lock, flags);
-- 
2.17.1

