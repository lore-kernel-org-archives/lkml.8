Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC10C2BB54
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 12:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D186B2078A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 12:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="vE2bus5D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbgDGM3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 08:29:50 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:16110 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728771AbgDGM3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 08:29:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1586262587; x=1617798587;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=EFXIwExObMHjh1goNYVJztAIzdQCu9r/PBJ7CO6BaHE=;
  b=vE2bus5D7NurWeY6PVm7d+3cDY4Lzw//TcguL1WgpZLHPqIpSJrHL9dQ
   6QOGkBckz2Yv7l4+pkcXqQnkQQOB71TvxVVvLJYZLfLCxhgECLXuHtCoj
   XioCFNsIFNxTWJRJlSK78nUfIuKszP2uPk2C9Qi4UAnLw/lzJI4TKwGrh
   zqk/8lcQN6aRAAW3Xr2YYQSPk2FtN8EA/qMWwImiH050Zu1ctkUQvVHJZ
   lLqZB36Rbgo7BvdLZqMow6prYp2be8bWRfuB4BbCrCr0euZbAgCP/GXCe
   BfLJhcEwCZtvaWcwynwo731IL4NSfM2sCv7MXucqgn5FFB9gi5Y205m2Q
   g==;
IronPort-SDR: Spjj5RbgFc3kEczZLkPqDcNWpJRu6HNsZOf6PzTOlB/qz6FI8ALxNbzNo+4gjKS6nB9xV8Mff7
 5QGWgjn6MoviJcWAkxTh58YcyMibB2m2dBYsNARPpI10XrgbTpcLN+/V2hEtuDvyqw1xv8jZCN
 +lc2qHEGkN/bMGEJMZhok1EPQvpXGiQf4/WSOh2inrrR+jdLa+4g1iiPIYFjsDPlCZ54arag9G
 4+gg0WZGOSIRfmVzhz2h0JydeCmpkev045bDlfxF043APpLkrdPujpgoxa+psTj0nzo8pQq2XN
 xwk=
X-IronPort-AV: E=Sophos;i="5.72,354,1580799600"; 
   d="scan'208";a="72565062"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Apr 2020 05:29:47 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 7 Apr 2020 05:29:46 -0700
Received: from cristi-P53.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Tue, 7 Apr 2020 05:29:44 -0700
From:   <cristian.birsan@microchip.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <nicolas.ferre@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        Cristian Birsan <cristian.birsan@microchip.com>
Subject: [PATCH 6/7] usb: gadget: udc: atmel: rename errata into caps
Date:   Tue, 7 Apr 2020 15:28:51 +0300
Message-ID: <20200407122852.19422-7-cristian.birsan@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200407122852.19422-1-cristian.birsan@microchip.com>
References: <20200407122852.19422-1-cristian.birsan@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cristian Birsan <cristian.birsan@microchip.com>

Rename errata structure into capabilities (caps). It will be used to add
capabilities for new SoCs. Get the pointer to PMC only for the SoCs that
need it to perform toggle_bias or pulse_bias.

Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
---
 drivers/usb/gadget/udc/atmel_usba_udc.c | 21 ++++++++++-----------
 drivers/usb/gadget/udc/atmel_usba_udc.h |  4 ++--
 2 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index 1e2194fe06cb..dfe30913c76b 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -389,8 +389,8 @@ static int vbus_is_present(struct usba_udc *udc)
 
 static void toggle_bias(struct usba_udc *udc, int is_on)
 {
-	if (udc->errata && udc->errata->toggle_bias)
-		udc->errata->toggle_bias(udc, is_on);
+	if (udc->caps && udc->caps->toggle_bias)
+		udc->caps->toggle_bias(udc, is_on);
 }
 
 static void generate_bias_pulse(struct usba_udc *udc)
@@ -398,8 +398,8 @@ static void generate_bias_pulse(struct usba_udc *udc)
 	if (!udc->bias_pulse_needed)
 		return;
 
-	if (udc->errata && udc->errata->pulse_bias)
-		udc->errata->pulse_bias(udc);
+	if (udc->caps && udc->caps->pulse_bias)
+		udc->caps->pulse_bias(udc);
 
 	udc->bias_pulse_needed = false;
 }
@@ -2032,17 +2032,17 @@ static void at91sam9g45_pulse_bias(struct usba_udc *udc)
 			   AT91_PMC_BIASEN);
 }
 
-static const struct usba_udc_errata at91sam9rl_errata = {
+static const struct usba_udc_caps at91sam9rl_caps = {
 	.toggle_bias = at91sam9rl_toggle_bias,
 };
 
-static const struct usba_udc_errata at91sam9g45_errata = {
+static const struct usba_udc_caps at91sam9g45_caps = {
 	.pulse_bias = at91sam9g45_pulse_bias,
 };
 
 static const struct of_device_id atmel_udc_dt_ids[] = {
-	{ .compatible = "atmel,at91sam9rl-udc", .data = &at91sam9rl_errata },
-	{ .compatible = "atmel,at91sam9g45-udc", .data = &at91sam9g45_errata },
+	{ .compatible = "atmel,at91sam9rl-udc", .data = &at91sam9rl_caps },
+	{ .compatible = "atmel,at91sam9g45-udc", .data = &at91sam9g45_caps },
 	{ .compatible = "atmel,sama5d3-udc" },
 	{ /* sentinel */ }
 };
@@ -2053,7 +2053,6 @@ static const struct of_device_id atmel_pmc_dt_ids[] = {
 	{ .compatible = "atmel,at91sam9g45-pmc" },
 	{ .compatible = "atmel,at91sam9rl-pmc" },
 	{ .compatible = "atmel,at91sam9x5-pmc" },
-	{ .compatible = "microchip,sam9x60-pmc" },
 	{ /* sentinel */ }
 };
 
@@ -2071,8 +2070,8 @@ static struct usba_ep * atmel_udc_of_init(struct platform_device *pdev,
 	if (!match)
 		return ERR_PTR(-EINVAL);
 
-	udc->errata = match->data;
-	if (udc->errata) {
+	udc->caps = match->data;
+	if (udc->caps && (udc->caps->pulse_bias || udc->caps->toggle_bias)) {
 		pp = of_find_matching_node_and_match(NULL, atmel_pmc_dt_ids,
 						     NULL);
 		if (!pp)
diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.h b/drivers/usb/gadget/udc/atmel_usba_udc.h
index 8de79356d31d..1a0f77bf8d4f 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.h
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.h
@@ -302,7 +302,7 @@ struct usba_request {
 	unsigned int				mapped:1;
 };
 
-struct usba_udc_errata {
+struct usba_udc_caps {
 	void (*toggle_bias)(struct usba_udc *udc, int is_on);
 	void (*pulse_bias)(struct usba_udc *udc);
 };
@@ -320,7 +320,7 @@ struct usba_udc {
 	struct usb_gadget gadget;
 	struct usb_gadget_driver *driver;
 	struct platform_device *pdev;
-	const struct usba_udc_errata *errata;
+	const struct usba_udc_caps *caps;
 	int irq;
 	struct gpio_desc *vbus_pin;
 	int num_ep;
-- 
2.17.1

