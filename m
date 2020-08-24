Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572C3C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 07:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3105120738
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 07:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lVLieB7C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgHXHvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 03:51:42 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:56584 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbgHXHvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 03:51:40 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 07O7pXuj111689;
        Mon, 24 Aug 2020 02:51:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1598255493;
        bh=8Jta3Bp9cq4m2FfO726+xsC8BtC6zHNnZDI6UyPOm3Q=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=lVLieB7CKir2iZA/NSxKeSaHa4dUHqAWIFhALt3Gwvi82NSj3fVBwy1qbIvTJ48vw
         DwZ+7xVivjroRB1xPAnufBolCG2rwezbq1MoCZMf2gglZjV+f+nmoE6Yg1tpUC3QJj
         Zvtu7UvinFiPe39i8eCNrncTypUPgz7YSxI8MIn4=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 07O7pXUv115331
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Aug 2020 02:51:33 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 24
 Aug 2020 02:51:33 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 24 Aug 2020 02:51:33 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07O7pTba075283;
        Mon, 24 Aug 2020 02:51:31 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <kishon@ti.com>, <vkoul@kernel.org>
CC:     <nsekhar@ti.com>, <vigneshr@ti.com>, <jan.kiszka@siemens.com>,
        <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH v6 1/2] phy: omap-usb2-phy: disable PHY charger detect
Date:   Mon, 24 Aug 2020 10:51:26 +0300
Message-ID: <20200824075127.14902-2-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200824075127.14902-1-rogerq@ti.com>
References: <20200824075127.14902-1-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AM654x PG1.0 has a silicon bug that D+ is pulled high after POR, which
could cause enumeration failure with some USB hubs.  Disabling the
USB2_PHY Charger Detect function will put D+ into the normal state.

This addresses Silicon Errata:
i2075 - "USB2PHY: USB2PHY Charger Detect is Enabled by Default Without VBUS
Presence"

Signed-off-by: Roger Quadros <rogerq@ti.com>
Tested-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/phy/ti/phy-omap-usb2.c | 47 +++++++++++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 7 deletions(-)

diff --git a/drivers/phy/ti/phy-omap-usb2.c b/drivers/phy/ti/phy-omap-usb2.c
index cb2dd3230fa7..507f79d14adb 100644
--- a/drivers/phy/ti/phy-omap-usb2.c
+++ b/drivers/phy/ti/phy-omap-usb2.c
@@ -22,10 +22,15 @@
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
 #include <linux/of_platform.h>
+#include <linux/sys_soc.h>
 
 #define USB2PHY_ANA_CONFIG1		0x4c
 #define USB2PHY_DISCON_BYP_LATCH	BIT(31)
 
+#define USB2PHY_CHRG_DET			0x14
+#define USB2PHY_CHRG_DET_USE_CHG_DET_REG	BIT(29)
+#define USB2PHY_CHRG_DET_DIS_CHG_DET		BIT(28)
+
 /* SoC Specific USB2_OTG register definitions */
 #define AM654_USB2_OTG_PD		BIT(8)
 #define AM654_USB2_VBUS_DET_EN		BIT(5)
@@ -43,6 +48,7 @@
 #define OMAP_USB2_HAS_START_SRP			BIT(0)
 #define OMAP_USB2_HAS_SET_VBUS			BIT(1)
 #define OMAP_USB2_CALIBRATE_FALSE_DISCONNECT	BIT(2)
+#define OMAP_USB2_DISABLE_CHRG_DET		BIT(3)
 
 struct omap_usb {
 	struct usb_phy		phy;
@@ -236,6 +242,13 @@ static int omap_usb_init(struct phy *x)
 		omap_usb_writel(phy->phy_base, USB2PHY_ANA_CONFIG1, val);
 	}
 
+	if (phy->flags & OMAP_USB2_DISABLE_CHRG_DET) {
+		val = omap_usb_readl(phy->phy_base, USB2PHY_CHRG_DET);
+		val |= USB2PHY_CHRG_DET_USE_CHG_DET_REG |
+		       USB2PHY_CHRG_DET_DIS_CHG_DET;
+		omap_usb_writel(phy->phy_base, USB2PHY_CHRG_DET, val);
+	}
+
 	return 0;
 }
 
@@ -329,6 +342,26 @@ static const struct of_device_id omap_usb2_id_table[] = {
 };
 MODULE_DEVICE_TABLE(of, omap_usb2_id_table);
 
+static void omap_usb2_init_errata(struct omap_usb *phy)
+{
+	static const struct soc_device_attribute am65x_sr10_soc_devices[] = {
+		{ .family = "AM65X", .revision = "SR1.0" },
+		{ /* sentinel */ }
+	};
+
+	/*
+	 * Errata i2075: USB2PHY: USB2PHY Charger Detect is Enabled by
+	 * Default Without VBUS Presence.
+	 *
+	 * AM654x SR1.0 has a silicon bug due to which D+ is pulled high after
+	 * POR, which could cause enumeration failure with some USB hubs.
+	 * Disabling the USB2_PHY Charger Detect function will put D+
+	 * into the normal state.
+	 */
+	if (soc_device_match(am65x_sr10_soc_devices))
+		phy->flags |= OMAP_USB2_DISABLE_CHRG_DET;
+}
+
 static int omap_usb2_probe(struct platform_device *pdev)
 {
 	struct omap_usb	*phy;
@@ -366,14 +399,14 @@ static int omap_usb2_probe(struct platform_device *pdev)
 	phy->mask		= phy_data->mask;
 	phy->power_on		= phy_data->power_on;
 	phy->power_off		= phy_data->power_off;
+	phy->flags		= phy_data->flags;
 
-	if (phy_data->flags & OMAP_USB2_CALIBRATE_FALSE_DISCONNECT) {
-		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-		phy->phy_base = devm_ioremap_resource(&pdev->dev, res);
-		if (IS_ERR(phy->phy_base))
-			return PTR_ERR(phy->phy_base);
-		phy->flags |= OMAP_USB2_CALIBRATE_FALSE_DISCONNECT;
-	}
+	omap_usb2_init_errata(phy);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	phy->phy_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(phy->phy_base))
+		return PTR_ERR(phy->phy_base);
 
 	phy->syscon_phy_power = syscon_regmap_lookup_by_phandle(node,
 							"syscon-phy-power");
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

