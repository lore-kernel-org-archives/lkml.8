Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0031C433FB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 18:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D5E420737
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 18:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="1X2weSL9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbgGWStd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 14:49:33 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:4920 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbgGWSt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 14:49:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1595530168; x=1627066168;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hVDaVBYeK4hiHue2uCcOKHrWDPhrT7DNvz7pYE1XNno=;
  b=1X2weSL9pz0Ik0kslZUuDeRPp9bFatZO6FrPCoDBHVQ0UkpGLhF1SDE9
   sQgNiJPrfoOSAVlAP/NqrpzIcRc+hA8ZyTSzPoeuIxuvklkz3Jq+H1Jq1
   7hjGFEHE1VS6ETbUem9svRfxunfROJYfuX1fapchPnxAuGg9WM+KINyNu
   xojirtFd5Fz8Wd5uEDYVRzUi8n6UD46ylDenwj1hVstDs1+xM3W5r9w8K
   mbGAkulvOfFPRgWXCYqxsSvVyDUcvlbQi2E1TYQIr3/q+grxgXslmxgYz
   aYoJqLjLTK8Q7zlIoGfYioYuiem4uN0ZrxUF3ssAwYYmpi8GSY0WW+YdR
   Q==;
IronPort-SDR: oLhhq9/CjdGL6l9gEaoiY1XHoOk0y2MSqqKLK6rukFlW4lBYIrSX4pfHQh8Za2OLGrwjx1anZn
 bk1dj2HGkmNughqykXxVSlksTFUqwhOSvxzhNtaCeVBJ7gfpzgXuGRuvuPJbWwf9wctpQTpHIk
 TdSucH5S9fnnWTdk38GPAe08WB1isOjBj+lrdIUac/nvjCPROHAA5Aytov9rBMFKvsr1mEiev8
 kTyynnlKdiruNAEjzMMOktUk/UD7ZAzWPJNL/WA5MKo2n9o9NCjIJAzpCVeP8bZBcP8UZsk5Jg
 qpc=
X-IronPort-AV: E=Sophos;i="5.75,387,1589266800"; 
   d="scan'208";a="88872127"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Jul 2020 11:49:27 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 23 Jul 2020 11:49:28 -0700
Received: from cristi-P53.lan (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 23 Jul 2020 11:48:45 -0700
From:   <cristian.birsan@microchip.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Cristian Birsan <cristian.birsan@microchip.com>
Subject: [PATCH v4 5/6] usb: gadget: udc: atmel: update endpoint allocation for sam9x60
Date:   Thu, 23 Jul 2020 21:49:01 +0300
Message-ID: <20200723184902.416705-6-cristian.birsan@microchip.com>
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

The DPRAM memory from the USB High Speed Device Port (UDPHS) hardware
block was increased. This patch updates the endpoint allocation for sam9x60
to take advantage of this larger memory. At the same time the
constraint to allocate the endpoints in order was lifted. To handle old
and new hardware in the same driver the ep_prealloc was added.

Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
---
 drivers/usb/gadget/udc/atmel_usba_udc.c | 20 +++++++++++++++++---
 drivers/usb/gadget/udc/atmel_usba_udc.h |  2 ++
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index 59b200e32784..80a96aceb219 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -1061,12 +1061,14 @@ static struct usb_ep *atmel_usba_match_ep(struct usb_gadget *gadget,
 
 		case USB_ENDPOINT_XFER_ISOC:
 			ep->fifo_size = 1024;
-			ep->nr_banks = 2;
+			if (ep->udc->ep_prealloc)
+				ep->nr_banks = 2;
 			break;
 
 		case USB_ENDPOINT_XFER_BULK:
 			ep->fifo_size = 512;
-			ep->nr_banks = 1;
+			if (ep->udc->ep_prealloc)
+				ep->nr_banks = 1;
 			break;
 
 		case USB_ENDPOINT_XFER_INT:
@@ -1076,7 +1078,8 @@ static struct usb_ep *atmel_usba_match_ep(struct usb_gadget *gadget,
 			else
 				ep->fifo_size =
 				    roundup_pow_of_two(le16_to_cpu(desc->wMaxPacketSize));
-			ep->nr_banks = 1;
+			if (ep->udc->ep_prealloc)
+				ep->nr_banks = 1;
 			break;
 		}
 
@@ -2087,23 +2090,33 @@ static const struct usba_udc_config udc_at91sam9rl_cfg = {
 	.errata = &at91sam9rl_errata,
 	.config = ep_config_sam9,
 	.num_ep = ARRAY_SIZE(ep_config_sam9),
+	.ep_prealloc = true,
 };
 
 static const struct usba_udc_config udc_at91sam9g45_cfg = {
 	.errata = &at91sam9g45_errata,
 	.config = ep_config_sam9,
 	.num_ep = ARRAY_SIZE(ep_config_sam9),
+	.ep_prealloc = true,
 };
 
 static const struct usba_udc_config udc_sama5d3_cfg = {
 	.config = ep_config_sama5,
 	.num_ep = ARRAY_SIZE(ep_config_sama5),
+	.ep_prealloc = true,
+};
+
+static const struct usba_udc_config udc_sam9x60_cfg = {
+	.num_ep = ARRAY_SIZE(ep_config_sam9),
+	.config = ep_config_sam9,
+	.ep_prealloc = false,
 };
 
 static const struct of_device_id atmel_udc_dt_ids[] = {
 	{ .compatible = "atmel,at91sam9rl-udc", .data = &udc_at91sam9rl_cfg },
 	{ .compatible = "atmel,at91sam9g45-udc", .data = &udc_at91sam9g45_cfg },
 	{ .compatible = "atmel,sama5d3-udc", .data = &udc_sama5d3_cfg },
+	{ .compatible = "microchip,sam9x60-udc", .data = &udc_sam9x60_cfg },
 	{ /* sentinel */ }
 };
 
@@ -2131,6 +2144,7 @@ static struct usba_ep * atmel_udc_of_init(struct platform_device *pdev,
 		return ERR_PTR(-EINVAL);
 
 	udc_config = match->data;
+	udc->ep_prealloc = udc_config->ep_prealloc;
 	udc->errata = udc_config->errata;
 	if (udc->errata) {
 		pp = of_find_matching_node_and_match(NULL, atmel_pmc_dt_ids,
diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.h b/drivers/usb/gadget/udc/atmel_usba_udc.h
index a9bf655eb513..620472f218bc 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.h
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.h
@@ -317,6 +317,7 @@ struct usba_udc_config {
 	const struct usba_udc_errata *errata;
 	const struct usba_ep_config *config;
 	const int num_ep;
+	const bool ep_prealloc;
 };
 
 struct usba_udc {
@@ -343,6 +344,7 @@ struct usba_udc {
 	bool bias_pulse_needed;
 	bool clocked;
 	bool suspended;
+	bool ep_prealloc;
 
 	u16 devstatus;
 
-- 
2.25.1

