Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423A2CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 226D4206CC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kAkiwK4g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733239AbgEMNHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 09:07:25 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:48950 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733182AbgEMNHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 09:07:22 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04DD7Kf1043033;
        Wed, 13 May 2020 08:07:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589375240;
        bh=5K+SEGQeU5EpeWcccdRNrdDbsnRedKCXOuo8mbwS6a8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=kAkiwK4gmsI3IObS1d0pMN20fNxEMri/JnVKQUZSxRrdRJ4Ti26pmFqU36POHxXfo
         E8KFX8wHpOT8VkNt17Pken/mDV67dsN8bgkfsI1kux/BxfHZ7zxBqda8mrOzX+Bu4x
         y9UHvlME7SVHJTPIKTb2Faly+ukq9GeaTUglQA+E=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04DD7KLm068039;
        Wed, 13 May 2020 08:07:20 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 13
 May 2020 08:07:20 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 13 May 2020 08:07:20 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04DD7B2T074071;
        Wed, 13 May 2020 08:07:18 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <balbi@kernel.org>
CC:     <robh+dt@kernel.org>, <vigneshr@ti.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH 3/3] usb: dwc3: keystone: Turn on USB3 PHY before controller
Date:   Wed, 13 May 2020 16:07:09 +0300
Message-ID: <20200513130709.10239-4-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200513130709.10239-1-rogerq@ti.com>
References: <20200513130709.10239-1-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Local Power Sleep Controller (LPSC) dependency on AM65
requires SERDES0 to be powered on before USB.

We need to power up SERDES0 power domain and hold it on
throughout the reset, init, power on sequence.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/dwc3/dwc3-keystone.c | 47 +++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-keystone.c b/drivers/usb/dwc3/dwc3-keystone.c
index 1e14a6f4884b..46d46f3507fc 100644
--- a/drivers/usb/dwc3/dwc3-keystone.c
+++ b/drivers/usb/dwc3/dwc3-keystone.c
@@ -14,6 +14,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/io.h>
 #include <linux/of_platform.h>
+#include <linux/phy/phy.h>
 #include <linux/pm_runtime.h>
 
 /* USBSS register offsets */
@@ -34,6 +35,7 @@
 struct dwc3_keystone {
 	struct device			*dev;
 	void __iomem			*usbss;
+	struct phy			*usb3_phy;
 };
 
 static inline u32 kdwc3_readl(void __iomem *base, u32 offset)
@@ -95,8 +97,44 @@ static int kdwc3_probe(struct platform_device *pdev)
 	if (IS_ERR(kdwc->usbss))
 		return PTR_ERR(kdwc->usbss);
 
-	pm_runtime_enable(kdwc->dev);
+	/* PSC dependency on AM65 needs SERDES0 to be powered before USB0 */
+	kdwc->usb3_phy = devm_phy_get(dev, "usb3-phy");
+	if (IS_ERR(kdwc->usb3_phy)) {
+		error = PTR_ERR(kdwc->usb3_phy);
+		if (error == -ENOSYS || error == -ENODEV) {
+			kdwc->usb3_phy = NULL;
+		} else {
+			if (error != -EPROBE_DEFER) {
+				dev_err(dev, "couldn't get usb3 phy: %d\n",
+					error);
+			}
+
+			return error;
+		}
+	}
+
+	phy_pm_runtime_get_sync(kdwc->usb3_phy);
+
+	error = phy_reset(kdwc->usb3_phy);
+	if (error < 0) {
+		dev_err(dev, "usb3 phy reset failed: %d\n", error);
+		return error;
+	}
+
+	error = phy_init(kdwc->usb3_phy);
+	if (error < 0) {
+		dev_err(dev, "usb3 phy init failed: %d\n", error);
+		return error;
+	}
 
+	error = phy_power_on(kdwc->usb3_phy);
+	if (error < 0) {
+		dev_err(dev, "usb3 phy power on failed: %d\n", error);
+		phy_exit(kdwc->usb3_phy);
+		return error;
+	}
+
+	pm_runtime_enable(kdwc->dev);
 	error = pm_runtime_get_sync(kdwc->dev);
 	if (error < 0) {
 		dev_err(kdwc->dev, "pm_runtime_get_sync failed, error %d\n",
@@ -138,6 +176,9 @@ static int kdwc3_probe(struct platform_device *pdev)
 err_irq:
 	pm_runtime_put_sync(kdwc->dev);
 	pm_runtime_disable(kdwc->dev);
+	phy_power_off(kdwc->usb3_phy);
+	phy_exit(kdwc->usb3_phy);
+	phy_pm_runtime_put_sync(kdwc->usb3_phy);
 
 	return error;
 }
@@ -163,6 +204,10 @@ static int kdwc3_remove(struct platform_device *pdev)
 	pm_runtime_put_sync(kdwc->dev);
 	pm_runtime_disable(kdwc->dev);
 
+	phy_power_off(kdwc->usb3_phy);
+	phy_exit(kdwc->usb3_phy);
+	phy_pm_runtime_put_sync(kdwc->usb3_phy);
+
 	platform_set_drvdata(pdev, NULL);
 
 	return 0;
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

