Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E53DC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 07:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E1BD20738
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 07:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Xow5yLsI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgHXHvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 03:51:40 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39184 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgHXHvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 03:51:39 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 07O7pZsg081335;
        Mon, 24 Aug 2020 02:51:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1598255495;
        bh=Vr5DKf/DyvQbX8s1dnqZ7ImtrAtc0iRlV9Z5+Z4F+9A=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Xow5yLsICq+1nmjubgMzGJiWdD+71Sy4SofH5+GUzSJPxSg0ariODYi9PbaqUBmhn
         GpnJ0tjx62vpSe9Ybxigb8y3cTR9+LhubkkXXkhOr8XHyCPhbpcp4PyzvqYR3w8HAl
         dgPugE6tdhem0S9MRgGauX9uYT8BwWXhIJzHzcEo=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 07O7pZT9003908
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Aug 2020 02:51:35 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 24
 Aug 2020 02:51:35 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 24 Aug 2020 02:51:35 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07O7pTbb075283;
        Mon, 24 Aug 2020 02:51:33 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <kishon@ti.com>, <vkoul@kernel.org>
CC:     <nsekhar@ti.com>, <vigneshr@ti.com>, <jan.kiszka@siemens.com>,
        <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH v6 2/2] phy: omap-usb2-phy: fix coding style issues
Date:   Mon, 24 Aug 2020 10:51:27 +0300
Message-ID: <20200824075127.14902-3-rogerq@ti.com>
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

Fix checkpatch warnings and sort the include files alphabetically.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/phy/ti/phy-omap-usb2.c | 36 ++++++++++++++++------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/phy/ti/phy-omap-usb2.c b/drivers/phy/ti/phy-omap-usb2.c
index 507f79d14adb..4fec90d2624f 100644
--- a/drivers/phy/ti/phy-omap-usb2.c
+++ b/drivers/phy/ti/phy-omap-usb2.c
@@ -6,23 +6,23 @@
  * Author: Kishon Vijay Abraham I <kishon@ti.com>
  */
 
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/slab.h>
-#include <linux/of.h>
-#include <linux/io.h>
-#include <linux/phy/omap_usb.h>
-#include <linux/usb/phy_companion.h>
 #include <linux/clk.h>
-#include <linux/err.h>
-#include <linux/pm_runtime.h>
 #include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
 #include <linux/phy/omap_control_phy.h>
+#include <linux/phy/omap_usb.h>
 #include <linux/phy/phy.h>
-#include <linux/mfd/syscon.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
-#include <linux/of_platform.h>
+#include <linux/slab.h>
 #include <linux/sys_soc.h>
+#include <linux/usb/phy_companion.h>
 
 #define USB2PHY_ANA_CONFIG1		0x4c
 #define USB2PHY_DISCON_BYP_LATCH	BIT(31)
@@ -89,7 +89,7 @@ static inline void omap_usb_writel(void __iomem *addr, unsigned int offset,
 }
 
 /**
- * omap_usb2_set_comparator - links the comparator present in the sytem with
+ * omap_usb2_set_comparator - links the comparator present in the system with
  *	this phy
  * @comparator - the companion phy(comparator) for this phy
  *
@@ -142,7 +142,7 @@ static int omap_usb_set_host(struct usb_otg *otg, struct usb_bus *host)
 }
 
 static int omap_usb_set_peripheral(struct usb_otg *otg,
-		struct usb_gadget *gadget)
+				   struct usb_gadget *gadget)
 {
 	otg->gadget = gadget;
 	if (!gadget)
@@ -409,7 +409,7 @@ static int omap_usb2_probe(struct platform_device *pdev)
 		return PTR_ERR(phy->phy_base);
 
 	phy->syscon_phy_power = syscon_regmap_lookup_by_phandle(node,
-							"syscon-phy-power");
+								"syscon-phy-power");
 	if (IS_ERR(phy->syscon_phy_power)) {
 		dev_dbg(&pdev->dev,
 			"can't get syscon-phy-power, using control device\n");
@@ -438,7 +438,6 @@ static int omap_usb2_probe(struct platform_device *pdev)
 		}
 	}
 
-
 	phy->wkupclk = devm_clk_get(phy->dev, "wkupclk");
 	if (IS_ERR(phy->wkupclk)) {
 		if (PTR_ERR(phy->wkupclk) == -EPROBE_DEFER)
@@ -452,10 +451,10 @@ static int omap_usb2_probe(struct platform_device *pdev)
 			if (PTR_ERR(phy->wkupclk) != -EPROBE_DEFER)
 				dev_err(&pdev->dev, "unable to get usb_phy_cm_clk32k\n");
 			return PTR_ERR(phy->wkupclk);
-		} else {
-			dev_warn(&pdev->dev,
-				 "found usb_phy_cm_clk32k, please fix DTS\n");
 		}
+
+		dev_warn(&pdev->dev,
+			 "found usb_phy_cm_clk32k, please fix DTS\n");
 	}
 
 	phy->optclk = devm_clk_get(phy->dev, "refclk");
@@ -504,7 +503,6 @@ static int omap_usb2_probe(struct platform_device *pdev)
 		return PTR_ERR(phy_provider);
 	}
 
-
 	usb_add_phy_dev(&phy->phy);
 
 	return 0;
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

