Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CC4C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 11:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F9FA206D4
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 11:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="qlabrFSB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgEOLQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 07:16:58 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:13950 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgEOLQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 07:16:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1589541403; x=1621077403;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=M8yQNnHZuVdT9r1/rS/M/SeMts6Jhu8mlf3UsJER9oM=;
  b=qlabrFSBbBXQCPb9TeEVcHWcvyyb1dzLmUHYSiXWw02rlqsHzKX/F5Vv
   XmqpIKIDDwWox9FAKmF9B34u+jczI2/VzHP0clzCsVHLg53rbA+r963OR
   GGe1BdLynwOT27MVdiZ0/twDA+VYJ6MsbTJEE62f/iMnxXFeakorTdr6/
   8f3kmruqeui7i0NlBbYXwoSLbfm2XG7sDcgOwHMVymxUvIYkaOmScHXk/
   ujf/rZTTEPoj5W3hXZllVLwLH3Z1RC1yk77JtvHygQpYTqWlKVvpRwl+O
   i94zi4DnSZ4BO9j1lbhPHHYG3AGIEtrvA+s37dx6VXC+CB4AEHnQJLptj
   A==;
IronPort-SDR: sxRN6AYyixy98jYK0pJgpAbKE0SS6Fq4rWaqrtp1X5uWuw7wugQBo9ITcaXDwvjShVQhh3PAjL
 aS7CX5Wlx/jlihLj3nnIcJlogL0NgUS6y2iN4bQGoVoHFwHZ5Z8Tx6pL13AUCg/EYCOobp9aMJ
 AJqeAp+34Qw4KFzokv6jYsDQjJGM6gowSfK85lzmyoS5p2QLP1Vfzhu9UziRbbx1EmVAhr/RB8
 1F4Lzdtm/DWizK5dptepd2kRxw9pkmUNXWVJtipleE/abtsZmKZ/5pTcKYGozFAxkA28YPUp/f
 zPU=
X-IronPort-AV: E=Sophos;i="5.73,395,1583218800"; 
   d="scan'208";a="79770140"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 May 2020 04:16:42 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 15 May 2020 04:16:42 -0700
Received: from cristi-P53.lan (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 15 May 2020 04:16:39 -0700
From:   <cristian.birsan@microchip.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Cristian Birsan <cristian.birsan@microchip.com>
Subject: [PATCH v2 6/7] usb: gadget: udc: atmel: update endpoint allocation for sam9x60
Date:   Fri, 15 May 2020 14:16:30 +0300
Message-ID: <20200515111631.31210-7-cristian.birsan@microchip.com>
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

The DPRAM memory from the USB High Speed Device Port (UDPHS) hardware
block was increased. This patch updates the endpoint allocation for sam9x60
to take advantage of this larger memory. At the same time the
constraint to allocate the endpoints in order was lifted. To handle old
and new hardware in the same driver the capabilities (caps) structure
was extended.

Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
---
 drivers/usb/gadget/udc/atmel_usba_udc.c | 22 ++++++++++++++++++----
 drivers/usb/gadget/udc/atmel_usba_udc.h |  1 +
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index 2b1a0b6df0fe..ecd0fa9823bb 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -1066,12 +1066,14 @@ static struct usb_ep *atmel_usba_match_ep(struct usb_gadget *gadget,
 
 		case USB_ENDPOINT_XFER_ISOC:
 			ep->fifo_size = 1024;
-			ep->nr_banks = 2;
+			if (ep->udc->caps->ep_prealloc)
+				ep->nr_banks = 2;
 			break;
 
 		case USB_ENDPOINT_XFER_BULK:
 			ep->fifo_size = 512;
-			ep->nr_banks = 1;
+			if (ep->udc->caps->ep_prealloc)
+				ep->nr_banks = 1;
 			break;
 
 		case USB_ENDPOINT_XFER_INT:
@@ -1081,7 +1083,8 @@ static struct usb_ep *atmel_usba_match_ep(struct usb_gadget *gadget,
 			else
 				ep->fifo_size =
 				    roundup_pow_of_two(le16_to_cpu(desc->wMaxPacketSize));
-			ep->nr_banks = 1;
+			if (ep->udc->caps->ep_prealloc)
+				ep->nr_banks = 1;
 			break;
 		}
 
@@ -2034,16 +2037,27 @@ static void at91sam9g45_pulse_bias(struct usba_udc *udc)
 
 static const struct usba_udc_caps at91sam9rl_caps = {
 	.toggle_bias = at91sam9rl_toggle_bias,
+	.ep_prealloc = true,
 };
 
 static const struct usba_udc_caps at91sam9g45_caps = {
 	.pulse_bias = at91sam9g45_pulse_bias,
+	.ep_prealloc = true,
+};
+
+static const struct usba_udc_caps sama5d3_caps = {
+	.ep_prealloc = true,
+};
+
+static const struct usba_udc_caps at91sam9x60_caps = {
+	.ep_prealloc = false,
 };
 
 static const struct of_device_id atmel_udc_dt_ids[] = {
 	{ .compatible = "atmel,at91sam9rl-udc", .data = &at91sam9rl_caps },
 	{ .compatible = "atmel,at91sam9g45-udc", .data = &at91sam9g45_caps },
-	{ .compatible = "atmel,sama5d3-udc" },
+	{ .compatible = "atmel,sama5d3-udc", .data = &sama5d3_caps },
+	{ .compatible = "microchip,sam9x60-udc", .data = &at91sam9x60_caps },
 	{ /* sentinel */ }
 };
 
diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.h b/drivers/usb/gadget/udc/atmel_usba_udc.h
index 1a0f77bf8d4f..f9239e200e7a 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.h
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.h
@@ -305,6 +305,7 @@ struct usba_request {
 struct usba_udc_caps {
 	void (*toggle_bias)(struct usba_udc *udc, int is_on);
 	void (*pulse_bias)(struct usba_udc *udc);
+	bool ep_prealloc;
 };
 
 struct usba_udc {
-- 
2.17.1

