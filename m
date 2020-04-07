Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAE3C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 12:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9BFA2078A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 12:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="LK30PICy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbgDGM3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 08:29:53 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:32823 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728784AbgDGM3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 08:29:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1586262591; x=1617798591;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=V1XGm8+lrs3ttcPc2wge9SGUo/478sGSJ11eiBPE2ok=;
  b=LK30PICyp+bgymBN0GWSd/r6pQt1TIdJSPYpdp3nTIxkt+SqzuJQjMpw
   Qvyfj/qtQMS0Fu61NLe5sRWz6v1aTdhC3rVQReBUXPbpk058HFBgGE9xW
   LYXhjk9CW9w3Tz0wITov0g+Cm5maIrSSr/ZDfUQf/OwOBEPhfyl1qFNTP
   zg1O6hWF4HQV0HArTBeRT7ZRZkMgAxYV17rMyJkBzVZb/cubsYsyfi1O3
   /5JbKKJkyYsl3Cm1OSFNmsjs78OnDUBL1yJm0vOpDe84KqlVmzlbQkJZ7
   1Or2ipB/hiwUJ2gNhD2THOHXSsbfUHOqOaShltjYpqHE6JyUC4Hp+PqZ/
   w==;
IronPort-SDR: ny0bsXupWmmLJSObKBLCIa7mRcQpCK/WsszZcDt9MkE1Ft+xygV0uI8zVBuae/W0ncSOuHVhuh
 brhDl7LVWjr7rWLr06nzZraSirFUjAD+9ln7AeDG1HuNI6nJmrIwb2WLlSNRzLUvVNIeNekc4+
 cFIYTsKrW4b4Z61q7ecXIg96pDSVoWEzEhu0ctrj0DkLYbAeoQti/i3OV9FflSbWKxfsunKpIH
 2gkQ7MpeePZITu8tZDbtF9d5yFQ8dCkR0CjwGKOX56nZDC8eUS6UnGsZ0B78+Vrf5eEjw4KkPS
 eAA=
X-IronPort-AV: E=Sophos;i="5.72,354,1580799600"; 
   d="scan'208";a="71684398"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Apr 2020 05:29:50 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 7 Apr 2020 05:29:49 -0700
Received: from cristi-P53.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Tue, 7 Apr 2020 05:29:47 -0700
From:   <cristian.birsan@microchip.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <nicolas.ferre@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        Cristian Birsan <cristian.birsan@microchip.com>
Subject: [PATCH 7/7] usb: gadget: udc: atmel: update endpoint allocation for sam9x60
Date:   Tue, 7 Apr 2020 15:28:52 +0300
Message-ID: <20200407122852.19422-8-cristian.birsan@microchip.com>
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
index dfe30913c76b..3eb715d4d786 100644
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

