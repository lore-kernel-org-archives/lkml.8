Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03066C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 11:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C697F204EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 11:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="0j0v6Tv1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgEOLQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 07:16:42 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:49123 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgEOLQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 07:16:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1589541397; x=1621077397;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=fQTNhgyNE/Ii16r6bBKjezIrqfpVvQZb1l6/3n2gUnA=;
  b=0j0v6Tv1MeaHkwedAqHhlh7RXl789Rp/WdgKc4g/W6+ucrTZX5BPRGTj
   KEcAsdFbAAoJ1x9q2eRmf08LezKpE+m5O4e5h4p9MJAmB0e6SvremvL2J
   IBUJYuzBE1/FySdwXtLKLTyle6st7a1rCaREQkoUDRGZcnZw8vw+lz58x
   trzSWTnMQXdBDL1+2i6ELfUPAceXcTxCigGu5JR/TiO1pQd+qWomo2HeJ
   lqrauvKnAJ/PY1DfbF1/jjGo/Z5nx+Ow1vfN0ECb0qGtLuGYMWRYk7uBR
   GhN6Dz7eZ/Kao444p6kke4FqfF27RU112XRG1jhZ17j9R0If92ONLeY/b
   Q==;
IronPort-SDR: cV8yZUQw+SbL/upJAS4T328t6SW/J4sycLqrzx7HejvDppIACraQhcL1eWJ7L+OBfbTEBSZzhR
 /YW36yGSBdkhlrtwEXjDdZETzTQKgODGkUg5VkEB25qSpRkRNaKwh3bwgiW4ei5h80XP4k8Ws6
 WthDcCIuyO2lYdzlw6srRJNlmrFMCmRoRcdJdq5vss9WDtwmtL9RQdB1suz4G5ZZYb/30CKpZ9
 cQq82JpG94m/YE6B1Qa7G1UJo8Yiqv5iAojuzGHwRFNSjsHQjUB3BURCJv8SzP8uGBKi1fc3FN
 Q1Q=
X-IronPort-AV: E=Sophos;i="5.73,395,1583218800"; 
   d="scan'208";a="12492405"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 May 2020 04:16:36 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 15 May 2020 04:16:36 -0700
Received: from cristi-P53.lan (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 15 May 2020 04:16:33 -0700
From:   <cristian.birsan@microchip.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Cristian Birsan <cristian.birsan@microchip.com>
Subject: [PATCH v2 4/7] usb: gadget: udc: atmel: use 1 bank endpoints for control transfers
Date:   Fri, 15 May 2020 14:16:28 +0300
Message-ID: <20200515111631.31210-5-cristian.birsan@microchip.com>
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

Use 1 bank endpoints for control transfers

Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
---
 drivers/usb/gadget/udc/atmel_usba_udc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index beb7246935a8..a73b0e78a357 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -1061,6 +1061,7 @@ static struct usb_ep *atmel_usba_match_ep(struct usb_gadget *gadget,
 
 		switch (usb_endpoint_type(desc)) {
 		case USB_ENDPOINT_XFER_CONTROL:
+			ep->nr_banks = 1;
 			break;
 
 		case USB_ENDPOINT_XFER_ISOC:
-- 
2.17.1

