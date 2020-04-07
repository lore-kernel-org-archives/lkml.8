Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30A5C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 12:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4C4520731
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 12:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="vJPB6SKl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbgDGM3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 08:29:39 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:26852 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbgDGM3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 08:29:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1586262577; x=1617798577;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=RRSV6rYP6IiNnoNhQap/FmU0DmkdgZjsIA231yL8M+Y=;
  b=vJPB6SKlTYrdvXd73CaZOt1ID1UVFxU5tIOGo3MzBBosiYuIwBk8oMSq
   YIQShkx/Nfnk+HXq+hPbv+Qe6R8I9UyriE75W+cv35Q4f3Z3jOOGXTJna
   Qcu31/R/dXa1TZ31lS+iyutTRiJwDSeXCh8OR1e0oLi5msMzmoL/7mTJN
   8CU4WAR45KCg97YOK74FNQcohGX0yOJL0FuVMLFPpB8AuqXSsdjKz5j8S
   Il7mfwpwB0/ABSjObZCafq6sQadcfTeCCKJgm8cefY6n5ahifhc6NTtqI
   Ufz8qvy1+NlfYeOgU/5HJpeunhUPiOBI17+WsPhGFhZCqiGots+V4whfm
   A==;
IronPort-SDR: mUWa5jbx10NY5DqQQ9TYyHOl/G1UJsCCuhwjyfqQ82Q7NIxvXssrUX/12MpNsAZ6JzMd9qZ8WG
 G0D6MP2oywTTgTT0GKE39ec18Qm4q45GSWCbLwf2eFMSkOJqpmQ4mn5stUZgtQIiwJyDmJ6g58
 YysAtzTFnuPNYfuU/U/JRVAuaMHHDdkzM0M3tYzy4QdshqPJhGl/INpBtiMcnTlQr+K8KHb6Qi
 2lxa9l8JJCK911Dk6RKOV2oAQdXzXxSC7DEV0jaR/RWw+6TcNsr8SNfyM5EvR9icSjmdQ1MkT0
 ne0=
X-IronPort-AV: E=Sophos;i="5.72,354,1580799600"; 
   d="scan'208";a="75013414"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Apr 2020 05:29:37 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 7 Apr 2020 05:29:48 -0700
Received: from cristi-P53.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Tue, 7 Apr 2020 05:29:34 -0700
From:   <cristian.birsan@microchip.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <nicolas.ferre@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 2/7] usb: gadget: udc: atmel: add compatible for SAM9X60's PMC
Date:   Tue, 7 Apr 2020 15:28:47 +0300
Message-ID: <20200407122852.19422-3-cristian.birsan@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200407122852.19422-1-cristian.birsan@microchip.com>
References: <20200407122852.19422-1-cristian.birsan@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Add compatible for SAM9X60's PMC.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
[cristian.birsan@microchip.com Add sentinel at the end of the array]
Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
---
 drivers/usb/gadget/udc/atmel_usba_udc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index 32e5b44d9fbd..c50902b91a96 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -2056,6 +2056,8 @@ static const struct of_device_id atmel_pmc_dt_ids[] = {
 	{ .compatible = "atmel,at91sam9g45-pmc" },
 	{ .compatible = "atmel,at91sam9rl-pmc" },
 	{ .compatible = "atmel,at91sam9x5-pmc" },
+	{ .compatible = "microchip,sam9x60-pmc" },
+	{ /* sentinel */ }
 };
 
 static struct usba_ep * atmel_udc_of_init(struct platform_device *pdev,
-- 
2.17.1

