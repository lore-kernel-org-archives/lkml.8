Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2038C433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 13:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFAD12071A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 13:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="MZG7qzpW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732508AbgGVNoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 09:44:39 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:61799 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbgGVNoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 09:44:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1595425479; x=1626961479;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fZFijBDp+zC7Kvsv+QSpK47JNGdPCmrZsJ0YhaqC5bc=;
  b=MZG7qzpWnpLtI8jZbHBdUeLT6QMmpw60FeSTljCeKL8xX03ec+jqTz9/
   UNStYDAN+FpiSvHQKKWJ9nqn3Oo2WahvfnCTzfLXsdKCr8cPDU133V1zp
   yrmt3vb4KAoTk7ohiv3x15I1+Lr4Vrm/NiywYOvg1/048EHki5eKQKYvx
   G13triMWRonRL1cV+ZzQ3+3zYLxv6DEq7by8caRVTnnB1aKjw/SD+EMfA
   xOHzVTkaKyTZ8rcVrHFxcU2Dt29eydlcJbdtskNt/DSJBBNDRSqWWgBJj
   u8Ip4lcOeMlp7iQgEuAN2pjQYxkycPHWueTADg8WXWDpRHJdrR4XkoEC0
   A==;
IronPort-SDR: +uya+0eoE4FTv1+6lxDOJXYwlB8UV05G5dGZkZes8Q4SIHHgXYJxW/eg19WdtKD+MuITlDfcL+
 GFhtlpz7vhW5cDDyhaj2rXOX2MrbTnbrXCC24pe66ewJBP0hmd1I3HnBBtSiHp9l0AS4oeIMTY
 W3HsZEkDBibIGveNQRyeBfILi3g4ekw+0Iwe9T8UPDqsm9Ax30IvwnmxDSydiaE29Jb3Y5BQ7b
 K/3DoYfJSmbfsubW9e0tnqaOWdYT66aD03Yu18NI3+tnnrVi+WSZFkyF0XExU9JE1z0FLJ7gf7
 Xe0=
X-IronPort-AV: E=Sophos;i="5.75,383,1589266800"; 
   d="scan'208";a="84198378"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Jul 2020 06:44:39 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 22 Jul 2020 06:44:37 -0700
Received: from cristi-P53.amer.actel.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 22 Jul 2020 06:43:56 -0700
From:   <cristian.birsan@microchip.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Cristian Birsan <cristian.birsan@microchip.com>
Subject: [PATCH v3 4/6] usb: gadget: udc: atmel: use 1 bank endpoints for control transfers
Date:   Wed, 22 Jul 2020 16:44:19 +0300
Message-ID: <20200722134421.190741-5-cristian.birsan@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200722134421.190741-1-cristian.birsan@microchip.com>
References: <20200722134421.190741-1-cristian.birsan@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cristian Birsan <cristian.birsan@microchip.com>

Use 1 bank endpoints for control transfers

Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
---
 drivers/usb/gadget/udc/atmel_usba_udc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index f767708598a4..843ba525d277 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -1056,6 +1056,7 @@ static struct usb_ep *atmel_usba_match_ep(struct usb_gadget *gadget,
 
 		switch (usb_endpoint_type(desc)) {
 		case USB_ENDPOINT_XFER_CONTROL:
+			ep->nr_banks = 1;
 			break;
 
 		case USB_ENDPOINT_XFER_ISOC:
-- 
2.25.1

