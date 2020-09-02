Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42699C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 185F72078E
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WtuBLD4f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbgIBOM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 10:12:28 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:51498 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbgIBN6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 09:58:24 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 082DZt8g126157;
        Wed, 2 Sep 2020 08:35:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599053755;
        bh=3APtkbHYrt+xP2S/hKgF189ShFm5BX6uKlppIWy5V58=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=WtuBLD4fKjgY2P82xYenl2yEBVg4t2Sv4+r1Jv5l0NqHri9sTB+AnyEVM++TWsvKb
         37UjX7pi/YCqY1IOGnjYeZm8G+xJGamLK9pRX4M2OsEnatHgFs2fiVSdaDgMf50a6u
         eMLAXdwmKVt2lnWJ8iACDAxbVdKwGPmLPCSAhTOI=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 082DZtbg043439
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Sep 2020 08:35:55 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 2 Sep
 2020 08:35:54 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 2 Sep 2020 08:35:54 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 082DZiGC065816;
        Wed, 2 Sep 2020 08:35:52 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <balbi@kernel.org>
CC:     <pawell@cadence.com>, <kurahul@cadence.com>, <nsekhar@ti.com>,
        <vigneshr@ti.com>, <robh+dt@kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 3/3] usb: cdns3: Enable workaround for USB2.0 PHY Rx compliance test PHY lockup
Date:   Wed, 2 Sep 2020 16:35:43 +0300
Message-ID: <20200902133543.17222-4-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200902133543.17222-1-rogerq@ti.com>
References: <20200902133543.17222-1-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pawel Laszczak <pawell@cadence.com>

USB2.0 PHY hangs in Rx Compliance test when the incoming packet
amplitude is varied below and above the Squelch Level of
Receiver during the active packet multiple times.

Version 1 of the controller allows PHY to be reset when RX fail condition
is detected to work around the above issue. This feature is
disabled by default and needs to be enabled using a bit from
the newly added PHYRST_CFG register. This patch enables the workaround.

There is no way to know controller version before device controller
is started and the workaround needs to be applied for both host and
device modes, so we rely on a DT property do decide when to
apply the workaround.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/cdns3/core.c |  2 ++
 drivers/usb/cdns3/core.h |  1 +
 drivers/usb/cdns3/drd.c  | 12 ++++++++++++
 drivers/usb/cdns3/drd.h  |  5 ++++-
 4 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
index 5c1586ec7824..34b36487682b 100644
--- a/drivers/usb/cdns3/core.c
+++ b/drivers/usb/cdns3/core.c
@@ -443,6 +443,8 @@ static int cdns3_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
+	cdns->phyrst_a_enable = device_property_read_bool(dev, "cdns,phyrst-a-enable");
+
 	cdns->otg_res = *res;
 
 	mutex_init(&cdns->mutex);
diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
index 1ad1f1fe61e9..24cf0f1b5726 100644
--- a/drivers/usb/cdns3/core.h
+++ b/drivers/usb/cdns3/core.h
@@ -76,6 +76,7 @@ struct cdns3 {
 #define CDNS3_CONTROLLER_V0	0
 #define CDNS3_CONTROLLER_V1	1
 	u32				version;
+	bool				phyrst_a_enable;
 
 	int				otg_irq;
 	int				dev_irq;
diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
index 6234bcd6158a..b74803e9703d 100644
--- a/drivers/usb/cdns3/drd.c
+++ b/drivers/usb/cdns3/drd.c
@@ -42,6 +42,18 @@ int cdns3_set_mode(struct cdns3 *cdns, enum usb_dr_mode mode)
 			reg = readl(&cdns->otg_v1_regs->override);
 			reg |= OVERRIDE_IDPULLUP;
 			writel(reg, &cdns->otg_v1_regs->override);
+
+			/*
+			 * Enable work around feature built into the
+			 * controller to address issue with RX Sensitivity
+			 * est (EL_17) for USB2 PHY. The issue only occures
+			 * for 0x0002450D controller version.
+			 */
+			if (cdns->phyrst_a_enable) {
+				reg = readl(&cdns->otg_v1_regs->phyrst_cfg);
+				reg |= PHYRST_CFG_PHYRST_A_ENABLE;
+				writel(reg, &cdns->otg_v1_regs->phyrst_cfg);
+			}
 		} else {
 			reg = readl(&cdns->otg_v0_regs->ctrl1);
 			reg |= OVERRIDE_IDPULLUP_V0;
diff --git a/drivers/usb/cdns3/drd.h b/drivers/usb/cdns3/drd.h
index 7e7cf7fa2dd3..f1ccae285a16 100644
--- a/drivers/usb/cdns3/drd.h
+++ b/drivers/usb/cdns3/drd.h
@@ -31,7 +31,7 @@ struct cdns3_otg_regs {
 	__le32 simulate;
 	__le32 override;
 	__le32 susp_ctrl;
-	__le32 reserved4;
+	__le32 phyrst_cfg;
 	__le32 anasts;
 	__le32 adp_ramp_time;
 	__le32 ctrl1;
@@ -153,6 +153,9 @@ struct cdns3_otg_common_regs {
 /* Only for CDNS3_CONTROLLER_V0 version */
 #define OVERRIDE_IDPULLUP_V0		BIT(24)
 
+/* PHYRST_CFG - bitmasks */
+#define PHYRST_CFG_PHYRST_A_ENABLE     BIT(0)
+
 #define CDNS3_ID_PERIPHERAL		1
 #define CDNS3_ID_HOST			0
 
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

