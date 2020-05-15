Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5AFAC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 11:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9012C2074D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 11:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="N1SE3qlK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgEOLQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 07:16:47 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:13940 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbgEOLQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 07:16:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1589541400; x=1621077400;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=sVqWsLz1y8fsk5DdLudMe2Mg6uiTLwYXDVejGU3d/cs=;
  b=N1SE3qlKQy64WcnpUmc7YwLm/mVOCipxNoH5shCmY+xDgYBo8lbB+T/8
   pSAPrnfazvlu26siV4qLoR8VYPYbX+QVhP48A6X1lkjXXTsV54Xvwooze
   cu21kEX0P+xkH2rT2KbGQW3P6sEKO7UHyftzXyUHCBcR7CjMhHo7CLlnX
   +7t0Y+COkVU6G/aYlo/Anl95KTSrecI6CScFQcY142Lp48lgrBTWCz5oy
   DLGwBD9Yb8ZJQthqVswXJuE+VQ3Yb6SBbhpO9RJsWG/9MnCms4Kn5x12/
   2XaWVZV7W8IwsMlDdgRsWjm3k0aCwHOpaES+81+vVaJgn2qJrYz2Br5bF
   g==;
IronPort-SDR: fWQCjc6jhWyyAwjXpD3T2ZttWIy031vnoDgobbQQ55/8JQYyIN+5k5IB4xjaKm9uUESM8Sj5KB
 ibNBDPEkbVjcABQwUDeEr4BMuyF7zJ6O6aiNMe42XloQ9DNlaUFfuYaW1aEiP/VJw6SzVJ5+29
 /D+7pBvvBqCGzJXHpvnO1oGdyjoarsjpUxpQOlKxxmnYZhLL5iOEReSw60sffxuNaXiFPCCveJ
 mM/PWe1raXMubak4WpKfi7JNuKhyffDlXSVCIImMWDFp4PpPrWEwCaKUCNktAM5jJTUj+IEcj7
 0bQ=
X-IronPort-AV: E=Sophos;i="5.73,395,1583218800"; 
   d="scan'208";a="79770138"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 May 2020 04:16:39 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 15 May 2020 04:16:39 -0700
Received: from cristi-P53.lan (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 15 May 2020 04:16:36 -0700
From:   <cristian.birsan@microchip.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Cristian Birsan <cristian.birsan@microchip.com>
Subject: [PATCH v2 5/7] usb: gadget: udc: atmel: rename errata into caps
Date:   Fri, 15 May 2020 14:16:29 +0300
Message-ID: <20200515111631.31210-6-cristian.birsan@microchip.com>
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

Rename errata structure into capabilities (caps). It will be used to add
capabilities for new SoCs. Get the pointer to PMC only for the SoCs that
need it to perform toggle_bias or pulse_bias.

Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
---
 drivers/usb/gadget/udc/atmel_usba_udc.c | 20 ++++++++++----------
 drivers/usb/gadget/udc/atmel_usba_udc.h |  4 ++--
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index a73b0e78a357..2b1a0b6df0fe 100644
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
@@ -2070,8 +2070,8 @@ static struct usba_ep * atmel_udc_of_init(struct platform_device *pdev,
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

