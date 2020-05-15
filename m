Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD652C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 11:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F8A3204EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 11:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ZfqEIxeY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgEOLQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 07:16:39 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:19631 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbgEOLQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 07:16:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1589541394; x=1621077394;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=48f8UXh3qWiOzkNfswTmXKjjifYhI2PibhsXx6ECPRU=;
  b=ZfqEIxeYj86coDiyTP+CJXyFgF2R5oBcC/Ecuwih5Pa9yIAsqCVFEM9f
   KQj/g+Apj+j0pBgwIzvj8srWKOL/UUIF0XhYGQDz45R1boTt0Dc566dSm
   tzO1dD65Dk+D5GEKOgRWcFnRhQ8CzLKBkqxWnJJKKxt+MGGIb7s/Ijp0t
   ikLHM26whTDry2whUDzd17D/0n+r8rr2Jh/NfPBEOYTC/8nANe4YCHkl6
   DBVhXnOQITdJVr9nsShgm3dCNiUdpRJZyvOWrIuvttAZJ63TrICOAkhLD
   gRuzwEePwdvoTp4FyxjB/2WPFbmHvNp5Svjau2IEQ4EJq4bVWuMWEDqtw
   A==;
IronPort-SDR: WtV8k9mwn9EwVgbTjvZiooWtrdOfPcQ1xYy4NVnm/GLtBuQ1JnJVWSM6LBHFYjqP2zqPS9gVJQ
 CYARsmsJFeTSiy16Ei/T7fGRnIMK/5uzTW+BFrE9m+Pbe60b1PsOit58o6HCvrYGLBwIn9Iasd
 8t/+C9/ScTjPIk0DKRS419A5C7proO5THHFLppNpF/d63c/FlwZVctmOFXwzq69t81+y+MlWsc
 8meFew2h6dOzgnlBm0JpcPkGujRIiBVj8x4uxJCnZmnT+VzJFZdOHVSmZHuW07wCRQ0agNWQxI
 /PM=
X-IronPort-AV: E=Sophos;i="5.73,395,1583218800"; 
   d="scan'208";a="73566887"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 May 2020 04:16:33 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 15 May 2020 04:16:33 -0700
Received: from cristi-P53.lan (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 15 May 2020 04:16:30 -0700
From:   <cristian.birsan@microchip.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Cristian Birsan <cristian.birsan@microchip.com>
Subject: [PATCH v2 3/7] usb: gadget: udc: atmel: simplify endpoint allocation
Date:   Fri, 15 May 2020 14:16:27 +0300
Message-ID: <20200515111631.31210-4-cristian.birsan@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200515111631.31210-1-cristian.birsan@microchip.com>
References: <20200515111631.31210-1-cristian.birsan@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cristian Birsan <cristian.birsan@microchip.com>

Simplify the endpoint allocation and cleanup the code.

Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
---
 drivers/usb/gadget/udc/atmel_usba_udc.c | 21 ++++++++-------------
 drivers/usb/gadget/udc/atmel_usba_udc.h |  1 -
 2 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index 2b154085dc6a..beb7246935a8 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -1097,7 +1097,6 @@ static struct usb_ep *atmel_usba_match_ep(struct usb_gadget *gadget,
 
 		ep->ept_cfg |= USBA_BF(BK_NUMBER, ep->nr_banks);
 
-		ep->udc->configured_ep++;
 	}
 
 	return _ep;
@@ -1790,7 +1789,7 @@ static irqreturn_t usba_udc_irq(int irq, void *devid)
 
 	if (status & USBA_END_OF_RESET) {
 		struct usba_ep *ep0, *ep;
-		int i, n;
+		int i;
 
 		usba_writel(udc, INT_CLR,
 			USBA_END_OF_RESET|USBA_END_OF_RESUME
@@ -1838,13 +1837,14 @@ static irqreturn_t usba_udc_irq(int irq, void *devid)
 				"ODD: EP0 configuration is invalid!\n");
 
 		/* Preallocate other endpoints */
-		n = fifo_mode ? udc->num_ep : udc->configured_ep;
-		for (i = 1; i < n; i++) {
+		for (i = 1; i < udc->num_ep; i++) {
 			ep = &udc->usba_ep[i];
-			usba_ep_writel(ep, CFG, ep->ept_cfg);
-			if (!(usba_ep_readl(ep, CFG) & USBA_EPT_MAPPED))
-				dev_err(&udc->pdev->dev,
-					"ODD: EP%d configuration is invalid!\n", i);
+			if (ep->ep.claimed) {
+				usba_ep_writel(ep, CFG, ep->ept_cfg);
+				if (!(usba_ep_readl(ep, CFG) & USBA_EPT_MAPPED))
+					dev_err(&udc->pdev->dev,
+						"ODD: EP%d configuration is invalid!\n", i);
+			}
 		}
 	}
 
@@ -2011,10 +2011,6 @@ static int atmel_usba_stop(struct usb_gadget *gadget)
 	if (udc->vbus_pin)
 		disable_irq(gpiod_to_irq(udc->vbus_pin));
 
-	if (fifo_mode == 0)
-		udc->configured_ep = 1;
-
-	udc->suspended = false;
 	usba_stop(udc);
 
 	udc->driver = NULL;
@@ -2095,7 +2091,6 @@ static struct usba_ep * atmel_udc_of_init(struct platform_device *pdev,
 		pp = NULL;
 		while ((pp = of_get_next_child(np, pp)))
 			udc->num_ep++;
-		udc->configured_ep = 1;
 	} else {
 		udc->num_ep = usba_config_fifo_table(udc);
 	}
diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.h b/drivers/usb/gadget/udc/atmel_usba_udc.h
index a0225e4543d4..8de79356d31d 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.h
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.h
@@ -324,7 +324,6 @@ struct usba_udc {
 	int irq;
 	struct gpio_desc *vbus_pin;
 	int num_ep;
-	int configured_ep;
 	struct usba_fifo_cfg *fifo_cfg;
 	struct clk *pclk;
 	struct clk *hclk;
-- 
2.17.1

