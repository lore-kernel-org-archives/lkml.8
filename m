Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D646C433E8
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 14:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D5C820717
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 14:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCFvKqDX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729709AbgGUOn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 10:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgGUOn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 10:43:56 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC644C061794;
        Tue, 21 Jul 2020 07:43:55 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 184so3168911wmb.0;
        Tue, 21 Jul 2020 07:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zFRW11/heyizj2QZJPL2QMgceFRIzgQa3xn1BGXBSyA=;
        b=bCFvKqDXVub2qkB9Bl6sG8ZzR78ncR9CNECo8vYQkXrHxMZH3OeyHKqVCpbUMUFKLm
         9UowELavNsk6T5L3BOoHYviyVJGNOmgup8IGUn1iFNSkNq/9iqIisTEp24cTFPt8/Iog
         XPX4Pd7Wtdw5gic7khwZA6DOU88c7nty9oYe/E7V8xUmFCVOrZzkG+JXWYvTejqVHg1i
         lSLhTMf8p7kEQqnBNZH4+B4z/mD4gM3eEgJYgZLZCkccmUnVsBYLHIvn+zoh7t3fRf/h
         dYWQfjVqahe0vqF2bv+LE45ZzouAa/WP0n5XTa2CaNcc++TshMa2DIHYj83fuCTs3JQ/
         eQHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zFRW11/heyizj2QZJPL2QMgceFRIzgQa3xn1BGXBSyA=;
        b=tZJDDBdel62KChC1vjRM8UlbZFUOymBB1TEcdBHp8qhvcJjIdiFItNrUxmejk6nIgO
         bhpwUZNKNmX+d/1a03TQPdncWoWo5Lc0lseObyQuc5Mt0fM/W2DhzOxug4vr8h0Oshkk
         jUGxBEOxAHby2M8lA4mgELn9kETku+qXxL7bgXeeM8NO/Ii1b4Jn7B5ZriooQ9IxtTxj
         FhTck3H1fFW3ZZT973lrEn+LVTvoEqVKguMdXvnTnOngu3FPwbJ6kEzuJ21rOwm+Bxaf
         wN+3tFO/nzydeCnJJQIzLz5oD4XFo1AGMd86lO5uw4YUufnR0jbHa8aKEiLyQrrdXNBI
         JPjA==
X-Gm-Message-State: AOAM532pgrrsRbr+02MXs0e+1I9QHdh65KPkhAaBYCb/ijnweoiUSRf2
        OVuaOCyp1xGvMdKThoeLIHifaEBh
X-Google-Smtp-Source: ABdhPJyPWyU+HIy+RMMgKGdFDUS/Q/Bd6/ZN1myGkbRDi3plbSMTupEBxagbCK9bEkZu9ed+TPqVzw==
X-Received: by 2002:a7b:ca52:: with SMTP id m18mr4349730wml.92.1595342634347;
        Tue, 21 Jul 2020 07:43:54 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id y6sm38043116wrr.74.2020.07.21.07.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 07:43:53 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sasi Kumar <sasi.kumar@broadcom.com>,
        Al Cooper <alcooperx@gmail.com>, devicetree@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 3/7] bdc: Fix bug causing crash after multiple disconnects
Date:   Tue, 21 Jul 2020 10:43:22 -0400
Message-Id: <20200721144326.7976-4-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200721144326.7976-1-alcooperx@gmail.com>
References: <20200721144326.7976-1-alcooperx@gmail.com>
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

Signed-off-by: Sasi Kumar <sasi.kumar@broadcom.com>
Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/usb/gadget/udc/bdc/bdc_core.c |  4 ++++
 drivers/usb/gadget/udc/bdc/bdc_ep.c   | 16 ++++++++++------
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/gadget/udc/bdc/bdc_core.c b/drivers/usb/gadget/udc/bdc/bdc_core.c
index 18d510fc02fb..b70b438efff4 100644
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

