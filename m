Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0A0C433F1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 18:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BD422086A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 18:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="PNgaix/s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbgGWStZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 14:49:25 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:57925 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728245AbgGWStW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 14:49:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1595530162; x=1627066162;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SFBqPVx3z2oefl/XszBXa42k1QB4gR4AFJGweDDyRZ0=;
  b=PNgaix/sqTetFu2PMYWHEr/ktHbwKu3bJChBG9jmwPy9X+VZDhO75b/I
   zqoNrHixlEApL8ACnH7H9SGtb0FQ7N1b2sUwBB/pUnk3CqJUtnyvDtT65
   0tP2xaibisO5ue7Hkoeo+kq3Hj6RNPgyD1SCxBJ7gDif22rCnMF+QcnCH
   zwaHReu2E1eXLH2q5oSePl6RXRs8bIkf3C3n7raE1V7qTuYzSHqnNjq6W
   PkDisoh69Q9OxGfvv5+coWiNs9WJBDDm6aJg2Ch92uH8fvleL1hZNMss/
   SMSG/WuJbFHn5YqCtdl6+WvZvNrLo5Z71r0YRiU2HI57xXXLoatZEFamU
   g==;
IronPort-SDR: W3j+fOlYux1bqqgrwfYwhz1kYn2Sd2JfkKlwG5KMDpof5RbRS6EhGImHAbTeUWXccO/l+cTdYk
 XGuWJw0FVGfczDgX372ZzMnN9yiENJL4qdr/XpfsfAisTfpwIde2aObMJbTzFIf9mwyuAehDrI
 +Wpj3xXLUsswBL1coCCIh+f8Y2c3FAEyhk5WFY37ziqhJsYd6Y9jweUhhglpA0C4CbIQVjlOE5
 8Nzx6VwyNN8QotfEaKc2ffHSwjBAJpNA+F21oY1JAbz6L5XdAIafCyRnfYsNs5QqAvxqdUQFlR
 lSA=
X-IronPort-AV: E=Sophos;i="5.75,387,1589266800"; 
   d="scan'208";a="85153682"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Jul 2020 11:49:21 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 23 Jul 2020 11:48:41 -0700
Received: from cristi-P53.lan (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 23 Jul 2020 11:48:38 -0700
From:   <cristian.birsan@microchip.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Cristian Birsan <cristian.birsan@microchip.com>
Subject: [PATCH v4 3/6] usb: gadget: udc: atmel: simplify endpoint allocation
Date:   Thu, 23 Jul 2020 21:48:59 +0300
Message-ID: <20200723184902.416705-4-cristian.birsan@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200723184902.416705-1-cristian.birsan@microchip.com>
References: <20200723184902.416705-1-cristian.birsan@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 4281242b5f9a..10fa72ec8b79 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -1091,8 +1091,6 @@ static struct usb_ep *atmel_usba_match_ep(struct usb_gadget *gadget,
 				USBA_BF(EPT_SIZE, fls(ep->fifo_size - 1) - 3);
 
 		ep->ept_cfg |= USBA_BF(BK_NUMBER, ep->nr_banks);
-
-		ep->udc->configured_ep++;
 	}
 
 	return _ep;
@@ -1786,7 +1784,7 @@ static irqreturn_t usba_udc_irq(int irq, void *devid)
 
 	if (status & USBA_END_OF_RESET) {
 		struct usba_ep *ep0, *ep;
-		int i, n;
+		int i;
 
 		usba_writel(udc, INT_CLR,
 			USBA_END_OF_RESET|USBA_END_OF_RESUME
@@ -1834,13 +1832,14 @@ static irqreturn_t usba_udc_irq(int irq, void *devid)
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
 
@@ -2025,9 +2024,6 @@ static int atmel_usba_stop(struct usb_gadget *gadget)
 	if (udc->vbus_pin)
 		disable_irq(gpiod_to_irq(udc->vbus_pin));
 
-	if (fifo_mode == 0)
-		udc->configured_ep = 1;
-
 	udc->suspended = false;
 	usba_stop(udc);
 
@@ -2154,7 +2150,6 @@ static struct usba_ep * atmel_udc_of_init(struct platform_device *pdev,
 
 	if (fifo_mode == 0) {
 		udc->num_ep = udc_config->num_ep;
-		udc->configured_ep = 1;
 	} else {
 		udc->num_ep = usba_config_fifo_table(udc);
 	}
diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.h b/drivers/usb/gadget/udc/atmel_usba_udc.h
index 48e332439ed5..a9bf655eb513 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.h
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.h
@@ -336,7 +336,6 @@ struct usba_udc {
 	int irq;
 	struct gpio_desc *vbus_pin;
 	int num_ep;
-	int configured_ep;
 	struct usba_fifo_cfg *fifo_cfg;
 	struct clk *pclk;
 	struct clk *hclk;
-- 
2.25.1

