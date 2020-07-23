Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451D2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 18:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FC52208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 18:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="JZOtQsNw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbgGWStR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 14:49:17 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:10065 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbgGWStQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 14:49:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1595530155; x=1627066155;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OP/6x1FWBOWYFD0Vizy3q/OtdHKjms+2XnvxpxgJNsU=;
  b=JZOtQsNwOr302K4pVrdRALCpGruzDTw5bPLTwp2wnE/lf4qc5EzQUR2G
   mRQbBSbXPb4YeDn3vREG6sZssgmiM/Q3vvqQrSvMWkdotG0Bi36gSxYsr
   qeT9fb5OF4boAA22Ey/CT1s21lN7fOVZtLCzHMLVBWxYsEtHC+nnn9PLO
   1EI/oW61SxulnhaR1tFenYLVTdmEaUTgtlU22RqFisxBMtRf2nPyVhnar
   NDIgXcrx2C00fsLxn1gnj89toODJbC/E7POCzqGs03nARfBa04ub00Cvw
   mcTh4RYRZBwAaTF2jo5PIN/FdiqPVkFC3MXw8HT1PyTjeodlXCeFP/Ux3
   Q==;
IronPort-SDR: sapuqCwlsZIVzl004MwFqSN4O56pfFH31ChOcjpIggQrPyfV+d2c9nkyaNlp3kYvggHpVRuIHu
 4mIAUUnt2NJUWCgYvmyU3ibOiN+na9VLgnLWkeLIPSh2YfFyZYFcQ3mpgdfLCYFBDZWx+4zdCf
 WBJnohVFfP8J2QgWK57owwaqCoHnkaXPDJF9BTqCWbRRucYv2tValNG0KmMiWckxG3zvlmMytK
 dn9zF0GeUDxN4CFh5bpP9Dyd6cZC24DzFhV7XKwOWQ848RtlqT8GY0uLxM+wXZvuZTq0aNX8qU
 vjo=
X-IronPort-AV: E=Sophos;i="5.75,387,1589266800"; 
   d="scan'208";a="20343895"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Jul 2020 11:49:14 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 23 Jul 2020 11:49:15 -0700
Received: from cristi-P53.lan (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 23 Jul 2020 11:48:32 -0700
From:   <cristian.birsan@microchip.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v4 1/6] usb: gadget: udc: atmel: use of_find_matching_node_and_match
Date:   Thu, 23 Jul 2020 21:48:57 +0300
Message-ID: <20200723184902.416705-2-cristian.birsan@microchip.com>
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

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Instead of trying to match every possible compatible use
of_find_matching_node_and_match() and pass the compatible array.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
---
 drivers/usb/gadget/udc/atmel_usba_udc.c | 26 ++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index fa6793065c7c..4281242b5f9a 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -2112,11 +2112,19 @@ static const struct of_device_id atmel_udc_dt_ids[] = {
 
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
 	struct device_node *np = pdev->dev.of_node;
 	const struct of_device_id *match;
+	struct device_node *pp;
 	int i, ret;
 	struct usba_ep *eps, *ep;
 	const struct usba_udc_config *udc_config;
@@ -2127,13 +2135,17 @@ static struct usba_ep * atmel_udc_of_init(struct platform_device *pdev,
 
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

