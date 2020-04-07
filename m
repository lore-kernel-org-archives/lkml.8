Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB938C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 12:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FB8720719
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 12:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="pVakwL8z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbgDGM3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 08:29:36 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:7949 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbgDGM3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 08:29:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1586262575; x=1617798575;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=8OHvKFojSgEFCTGWAhdU7SNu+dqnlwN7/WnZMvI74jc=;
  b=pVakwL8zyJ//+R0iuA4j74dQBrL8a8arIKy+h6sn45OBfxLVl7y1jGOb
   T/kHz+o6HBdLlFecg4O5SZhyR+AWovL3r2af/dLvfJO2DbYMzF1qgViVw
   Q7lhMo+oSQVW0i1snWbe/gLTTFLhcycVZzPmP0Z4PIAFjBOMkMoF+oiM8
   RPLXb2cK7rBhEDn2FZtoPfmOZHXKIXaD0qaIXk7nm0Kj1icHVE4ycgWTM
   QH7ClA55gyVyMyvDphyP7WhPD93QLUZoVG4V4GdtVLGHYGy1g9UAhrOgI
   cyKf/MaYppPwc2wgOZArWRmH0fR+GAGz3Iey9AP6rIN9nVwEo0KGOQofT
   g==;
IronPort-SDR: GwZBSIHIFfiCoXZbUHyuHr/b8kzx/lzfndBhSKU1syyWMLvo6vX3GISvsznv6MwZjk1VLm+mNQ
 yFxcC6hloe3Nsblo9YDBjsBjoSZkdGBS1k5KrqST8SVPWWlLMkQtEkw6TTukKxuELsleKWWpcX
 BeYrbgpYB2sfI4I+531nHXtfGa7A35/RH6K/goAWan4SEHG3o0X1bcENSHYHa7DhCmzBPX5k26
 Z937XmSZ5GIfHdEDrhjVm6apI/QkNKuY9idjQS3GmeS+A273NIgIhR+dny8b5D18e3aTQZEODY
 eKg=
X-IronPort-AV: E=Sophos;i="5.72,354,1580799600"; 
   d="scan'208";a="69643576"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Apr 2020 05:29:34 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 7 Apr 2020 05:29:46 -0700
Received: from cristi-P53.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Tue, 7 Apr 2020 05:29:32 -0700
From:   <cristian.birsan@microchip.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <nicolas.ferre@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 1/7] usb: gadget: udc: atmel: use of_find_matching_node_and_match
Date:   Tue, 7 Apr 2020 15:28:46 +0300
Message-ID: <20200407122852.19422-2-cristian.birsan@microchip.com>
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

Instead of trying to match every possible compatible use
of_find_matching_node_and_match() and pass the compatible array.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/usb/gadget/udc/atmel_usba_udc.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index 6e0432141c40..32e5b44d9fbd 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -2052,6 +2052,12 @@ static const struct of_device_id atmel_udc_dt_ids[] = {
 
 MODULE_DEVICE_TABLE(of, atmel_udc_dt_ids);
 
+static const struct of_device_id atmel_pmc_dt_ids[] = {
+	{ .compatible = "atmel,at91sam9g45-pmc" },
+	{ .compatible = "atmel,at91sam9rl-pmc" },
+	{ .compatible = "atmel,at91sam9x5-pmc" },
+};
+
 static struct usba_ep * atmel_udc_of_init(struct platform_device *pdev,
 						    struct usba_udc *udc)
 {
@@ -2067,13 +2073,17 @@ static struct usba_ep * atmel_udc_of_init(struct platform_device *pdev,
 		return ERR_PTR(-EINVAL);
 
 	udc->errata = match->data;
-	udc->pmc = syscon_regmap_lookup_by_compatible("atmel,at91sam9g45-pmc");
-	if (IS_ERR(udc->pmc))
-		udc->pmc = syscon_regmap_lookup_by_compatible("atmel,at91sam9rl-pmc");
-	if (IS_ERR(udc->pmc))
-		udc->pmc = syscon_regmap_lookup_by_compatible("atmel,at91sam9x5-pmc");
-	if (udc->errata && IS_ERR(udc->pmc))
-		return ERR_CAST(udc->pmc);
+	if (udc->errata) {
+		pp = of_find_matching_node_and_match(NULL, atmel_pmc_dt_ids,
+						     NULL);
+		if (!pp)
+			return ERR_PTR(-ENODEV);
+
+		udc->pmc = syscon_node_to_regmap(pp);
+		of_node_put(pp);
+		if (IS_ERR(udc->pmc))
+			return ERR_CAST(udc->pmc);
+	}
 
 	udc->num_ep = 0;
 
-- 
2.17.1

