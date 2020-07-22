Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1F6C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 13:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C39532071A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 13:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="bL+X4ZI7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732497AbgGVNo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 09:44:29 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:34283 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732349AbgGVNo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 09:44:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1595425468; x=1626961468;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LJ5a5zW2HlzZmrctuphKUjLbHmULw+4CLiQ9IBxCDFc=;
  b=bL+X4ZI7uaOTVL4lGxIKlw3q8Qyul90y+t4xj0TnafOoLsoIqHPAVd3V
   B+5aKOHFhaRDUmkDC89GmXXHOsAyaaKW+241pxSPuKu/CdffwCesMo4Ns
   FkHAhhJcL6jeVGvoxJvEnGTrjxsMFu20eYn/6sf0yEgb4MpeUBKlxnNXa
   YKHNNHooL4E53u3VBvgI9qNFBlaoumVu316VGQ0uURs+/M8LnANr3OMgx
   GNeOWfz3BQnxr1kbgfLeNT87prTJAKXziWuMPhLRtJk6ihNvaPS8PnHA2
   L/wSEe6WWR+KXe4UfsB1NZCUSWotXDRwVAdA+7DaXR9ZGsFHgs1TKmoi1
   A==;
IronPort-SDR: c+T80368qAGQokoVoIRBT4mGga38vMwiY9veQa/e7thJA3szdFsuHMhRG579esd66j+IFIoof5
 nHQQ5/cUCTI2RPXNWLwabFzDN44pVPUgzLhTsq7dKf4el4MP5lcwqO6Mun23LB4Vgp5n3UmmLj
 zzcLlmtZINjEpaf6cBUBi2K1UOAIT99hSmlRknRlEoEFVMKjpii9ovI1ATh3TIdx3gFFJAK6KZ
 Ahf0YelzNbTHyq+nfry3oXVfnxJcJGz2LdKBmlgc/qhrHDVrYsUAW+11C3HFFX0mTxI6IeBm6P
 o2E=
X-IronPort-AV: E=Sophos;i="5.75,383,1589266800"; 
   d="scan'208";a="84955380"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Jul 2020 06:44:28 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 22 Jul 2020 06:44:28 -0700
Received: from cristi-P53.amer.actel.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 22 Jul 2020 06:43:46 -0700
From:   <cristian.birsan@microchip.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 1/6] usb: gadget: udc: atmel: use of_find_matching_node_and_match
Date:   Wed, 22 Jul 2020 16:44:16 +0300
Message-ID: <20200722134421.190741-2-cristian.birsan@microchip.com>
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

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Instead of trying to match every possible compatible use
of_find_matching_node_and_match() and pass the compatible array.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/usb/gadget/udc/atmel_usba_udc.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index c5128c229c52..ee2b550aa400 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -2112,6 +2112,13 @@ static const struct of_device_id atmel_udc_dt_ids[] = {
 
 MODULE_DEVICE_TABLE(of, atmel_udc_dt_ids);
 
+static const struct of_device_id atmel_pmc_dt_ids[] = {
+	{ .compatible = "atmel,at91sam9g45-pmc" },
+	{ .compatible = "atmel,at91sam9rl-pmc" },
+	{ .compatible = "atmel,at91sam9x5-pmc" },
+	{ /* sentinel */ }
+};
+
 static struct usba_ep * atmel_udc_of_init(struct platform_device *pdev,
 						    struct usba_udc *udc)
 {
@@ -2128,13 +2135,17 @@ static struct usba_ep * atmel_udc_of_init(struct platform_device *pdev,
 
 	udc_config = match->data;
 	udc->errata = udc_config->errata;
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
2.25.1

