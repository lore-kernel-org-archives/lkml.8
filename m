Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00A1C43459
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 17:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCE24207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 17:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSEyjz5F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732175AbgGVRIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 13:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731727AbgGVRIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 13:08:07 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052ECC0619DC;
        Wed, 22 Jul 2020 10:08:07 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f2so2611241wrp.7;
        Wed, 22 Jul 2020 10:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g18P77ClrSoGOpqfcLBFSJDl+A/gIGkG8Ir+N9NqqJw=;
        b=nSEyjz5FP/U+3rmYDhvNeGv7oE2TAUFPpMYKEBEmYFv7YvpZbB96/2oYZSWpZzbgmF
         a9sBl3Az7/+kF4q2OFNcc8CTry/kHR+qUuyfXqQBesRCoX1Rh9Q/jYTWwZ9ZGzF1Y2rx
         /OD6+6sx1nKOw3+/SgwIaSqRH99k80P7c4OPlMLyvEPpbFvKTRiGi7l7sovLAsgPnOXF
         k+vqIObCRrVtgW6ZUc0EmnPo8oU9OXOHlS1Kvs813azo5FFDKphSGjn8vpQixKahbS6m
         JKvoCaqwnfGy4O1n4qM9/f5+fuGF/zYBMbHcNqe9RM2SidMy4QmKpVGiRA8fJhM/Va+G
         ZFxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g18P77ClrSoGOpqfcLBFSJDl+A/gIGkG8Ir+N9NqqJw=;
        b=aP0zCj65/4+2kBVZW/oLdlqMsGSoMJAnC5yp2TW1c6C+ubdyuJCAU+CM8zpftZjvWh
         txAOQ+74C4yOt7gJnJpzNj8JL2Zg/aIGAAgsofB+FX2hLdYWKHvxyYlCedthryqQQtUP
         MQl+Deb5na3RwQCiHyustjNgaeSLWSTPwtVtQHgDBY9N/KrjmetyFgDxyGKd87xASB/E
         zpV/39xCZFwMRlMBQ1DSygmRcu+vgt2/3nLlHkl+PAZ8SpfgHKODQQ6kBa4B8tPvmXRO
         KRSIEloi9bxRqrI/5lc8Ic6UU4gUclEQFmEDd65uGW4pnCPyvrvMmnpwUHaqTMuMQoQ6
         P8Ig==
X-Gm-Message-State: AOAM532yJV7BcGc1vZnApxH8GGFQQNlYS5w/OiP86I4k9dJsKoN6X7ao
        OOCXeJbu3qLTrhsIh1Hwafo3X51M
X-Google-Smtp-Source: ABdhPJwNOnt5j+JGoemLnlgVcofZEpLjrNQT62U75VZfBKcwSQq7gfmYEVyi/AGpDhE1zGszalESmQ==
X-Received: by 2002:a5d:4144:: with SMTP id c4mr492145wrq.200.1595437685393;
        Wed, 22 Jul 2020 10:08:05 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id 133sm392960wme.5.2020.07.22.10.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 10:08:04 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sasi Kumar <sasi.kumar@broadcom.com>,
        Al Cooper <alcooperx@gmail.com>, devicetree@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v3 3/7] bdc: Fix bug causing crash after multiple disconnects
Date:   Wed, 22 Jul 2020 13:07:42 -0400
Message-Id: <20200722170746.5222-4-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722170746.5222-1-alcooperx@gmail.com>
References: <20200722170746.5222-1-alcooperx@gmail.com>
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
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
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

