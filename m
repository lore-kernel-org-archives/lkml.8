Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602C2C2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 12:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33E1320753
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 12:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="YW3QOAis"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgDJMPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 08:15:03 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:64003 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgDJMPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 08:15:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1586520903; x=1618056903;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=m3FWoK6Y8xDM6L0eq8fCEFhglfBFC6g0jRlmV8SpRiU=;
  b=YW3QOAisIdMHzH8iryuuZnmsbsDI0Z38NM7ABSpwc7YIh6V/sIho0M+H
   TEsdpUPx3V4u60JgqikX+P9t9VSDge8ueT5LTpQSLd5wDApqBHGlNqlW8
   ZshP8jC6g42L3LDJkaSZUL5V+1r0BaO1gV7zgHjZe5xCYW3mWfkvGA7+6
   0EyCTsjRIUTIMuZ5UdTrUlrUNUN6BewpBFxk5hxxe8Ep8Zn5Lgk7Sws8P
   95Dorffcaj1fVSMMG1U3x0rRL5KgglS3jzq5HPyhPOEZSS9h/XJ2yAwaZ
   XjYInK09/jKAw+g1dWDNkdpovSSDtuOuQOvqGFWFmrWeGHkLlg+DnFuy+
   Q==;
IronPort-SDR: +QBiI5KtTx7JSKCxD7BcPwmhf/jbu/DMnznp8zok4NxcHFGSENic4IlEYzGNmYi7LSH3pINaU6
 M1CZ6kcXFblX7IUucXlW6XZX69nJ+eX26TnwsRQcd4rxTV1e7TYsYjwPJRZw46+Eoj/ZLF+U/V
 1iRnNnbuhxiaKEl9bx0i6TOLdfIV3ZsmCTE9tBOWrTGWYjtZLkUQTzi6EKzRnCyLIYx8wU69A0
 D7BT8CJx766PTvWrZY87oGwqzgFBIkSAvnLvLzpl/oWphgkmBwON0K83FzWrWYhKNhzR8RSNVb
 67g=
X-IronPort-AV: E=Sophos;i="5.72,366,1580799600"; 
   d="scan'208";a="75482373"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Apr 2020 05:15:02 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 10 Apr 2020 05:14:57 -0700
Received: from cristi-P53.amer.actel.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Fri, 10 Apr 2020 05:15:00 -0700
From:   <cristian.birsan@microchip.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <nicolas.ferre@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        Cristian Birsan <cristian.birsan@microchip.com>
Subject: [PATCH] usb: gadget: udc: atmel: Fix vbus disconnect handling
Date:   Fri, 10 Apr 2020 15:14:52 +0300
Message-ID: <20200410121452.17642-1-cristian.birsan@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cristian Birsan <cristian.birsan@microchip.com>

A DMA transfer can be in progress while vbus is lost due to a cable
disconnect. For endpoints that use DMA, this condition can lead to
peripheral hang. The patch ensures that endpoints are disabled before
the clocks are stopped to prevent this issue.

Fixes: a64ef71ddc13 ("usb: gadget: atmel_usba_udc: condition clocks to vbus state")
Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
---
 drivers/usb/gadget/udc/atmel_usba_udc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index 6e0432141c40..22200341c8ec 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -1951,10 +1951,10 @@ static irqreturn_t usba_vbus_irq_thread(int irq, void *devid)
 			usba_start(udc);
 		} else {
 			udc->suspended = false;
-			usba_stop(udc);
-
 			if (udc->driver->disconnect)
 				udc->driver->disconnect(&udc->gadget);
+
+			usba_stop(udc);
 		}
 		udc->vbus_prev = vbus;
 	}
-- 
2.17.1

