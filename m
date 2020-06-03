Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36F2C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 09:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD90C205CB
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 09:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgFCJA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 05:00:59 -0400
Received: from atl4mhfb01.myregisteredsite.com ([209.17.115.55]:43986 "EHLO
        atl4mhfb01.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726243AbgFCJA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 05:00:58 -0400
Received: from jax4mhob16.registeredsite.com (jax4mhob16.registeredsite.com [64.69.218.104])
        by atl4mhfb01.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id 05390t0a004589
        for <linux-kernel@vger.kernel.org>; Wed, 3 Jun 2020 05:00:55 -0400
Received: from mailpod.hostingplatform.com ([10.30.71.203])
        by jax4mhob16.registeredsite.com (8.14.4/8.14.4) with ESMTP id 05390r2h002062
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Wed, 3 Jun 2020 05:00:53 -0400
Received: (qmail 1338 invoked by uid 0); 3 Jun 2020 09:00:53 -0000
X-TCPREMOTEIP: 83.128.90.119
X-Authenticated-UID: mike@milosoftware.com
Received: from unknown (HELO phenom.domain?not?set.invalid) (mike@milosoftware.com@83.128.90.119)
  by 0 with ESMTPA; 3 Jun 2020 09:00:53 -0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     linux-usb@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, robh+dt@kernel.org, balbi@kernel.org,
        Mike Looijmans <mike.looijmans@topic.nl>
Subject: [PATCH] usb: dwc3: Add support for VBUS power control
Date:   Wed,  3 Jun 2020 10:59:32 +0200
Message-Id: <20200603085932.31746-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support VBUS power control using regulator framework. Enables the regulator
while the port is in host mode.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---
 .../devicetree/bindings/usb/dwc3.txt          |  1 +
 drivers/usb/dwc3/core.c                       | 30 ++++++++++++++-----
 drivers/usb/dwc3/core.h                       |  4 +++
 drivers/usb/dwc3/drd.c                        |  6 ++--
 4 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentation/devicetree/bindings/usb/dwc3.txt
index 9946ff9ba735..56bc3f238e2d 100644
--- a/Documentation/devicetree/bindings/usb/dwc3.txt
+++ b/Documentation/devicetree/bindings/usb/dwc3.txt
@@ -37,6 +37,7 @@ Optional properties:
  - phys: from the *Generic PHY* bindings
  - phy-names: from the *Generic PHY* bindings; supported names are "usb2-phy"
 	or "usb3-phy".
+ - vbus-supply: Regulator handle that provides the VBUS power.
  - resets: set of phandle and reset specifier pairs
  - snps,usb2-lpm-disable: indicate if we don't want to enable USB2 HW LPM
  - snps,usb3_lpm_capable: determines if platform is USB3 LPM capable
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index edc17155cb2b..a9e58a301446 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -25,6 +25,7 @@
 #include <linux/of.h>
 #include <linux/acpi.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 
 #include <linux/usb/ch9.h>
@@ -112,6 +113,23 @@ void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode)
 	dwc->current_dr_role = mode;
 }
 
+void dwc3_set_vbus(struct dwc3 *dwc, bool enable)
+{
+	int ret;
+
+	if (enable != dwc->vbus_reg_enabled) {
+		if (enable)
+			ret = regulator_enable(dwc->vbus_reg);
+		else
+			ret = regulator_disable(dwc->vbus_reg);
+		if (!ret)
+			dwc->vbus_reg_enabled = enable;
+	}
+
+	if (dwc->usb2_phy)
+		otg_set_vbus(dwc->usb2_phy->otg, enable);
+}
+
 static void __dwc3_set_mode(struct work_struct *work)
 {
 	struct dwc3 *dwc = work_to_dwc(work);
@@ -164,8 +182,7 @@ static void __dwc3_set_mode(struct work_struct *work)
 		if (ret) {
 			dev_err(dwc->dev, "failed to initialize host\n");
 		} else {
-			if (dwc->usb2_phy)
-				otg_set_vbus(dwc->usb2_phy->otg, true);
+			dwc3_set_vbus(dwc, true);
 			phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_HOST);
 			phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_HOST);
 		}
@@ -173,8 +190,7 @@ static void __dwc3_set_mode(struct work_struct *work)
 	case DWC3_GCTL_PRTCAP_DEVICE:
 		dwc3_event_buffers_setup(dwc);
 
-		if (dwc->usb2_phy)
-			otg_set_vbus(dwc->usb2_phy->otg, false);
+		dwc3_set_vbus(dwc, false);
 		phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_DEVICE);
 		phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_DEVICE);
 
@@ -1183,8 +1199,7 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 	case USB_DR_MODE_PERIPHERAL:
 		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE);
 
-		if (dwc->usb2_phy)
-			otg_set_vbus(dwc->usb2_phy->otg, false);
+		dwc3_set_vbus(dwc, false);
 		phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_DEVICE);
 		phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_DEVICE);
 
@@ -1198,8 +1213,7 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 	case USB_DR_MODE_HOST:
 		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST);
 
-		if (dwc->usb2_phy)
-			otg_set_vbus(dwc->usb2_phy->otg, true);
+		dwc3_set_vbus(dwc, true);
 		phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_HOST);
 		phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_HOST);
 
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 4c171a8e215f..cee2574d7bf4 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1085,6 +1085,9 @@ struct dwc3 {
 
 	bool			phys_ready;
 
+	struct regulator	*vbus_reg;
+	bool			vbus_reg_enabled;
+
 	struct ulpi		*ulpi;
 	bool			ulpi_ready;
 
@@ -1397,6 +1400,7 @@ struct dwc3_gadget_ep_cmd_params {
 
 /* prototypes */
 void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode);
+void dwc3_set_vbus(struct dwc3 *dwc, bool enable);
 void dwc3_set_mode(struct dwc3 *dwc, u32 mode);
 u32 dwc3_core_fifo_space(struct dwc3_ep *dep, u8 type);
 
diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
index 7db1ffc92bbd..45fdec2d128d 100644
--- a/drivers/usb/dwc3/drd.c
+++ b/drivers/usb/dwc3/drd.c
@@ -384,8 +384,7 @@ void dwc3_otg_update(struct dwc3 *dwc, bool ignore_idstatus)
 		if (ret) {
 			dev_err(dwc->dev, "failed to initialize host\n");
 		} else {
-			if (dwc->usb2_phy)
-				otg_set_vbus(dwc->usb2_phy->otg, true);
+			dwc3_set_vbus(dwc, true);
 			if (dwc->usb2_generic_phy)
 				phy_set_mode(dwc->usb2_generic_phy,
 					     PHY_MODE_USB_HOST);
@@ -398,8 +397,7 @@ void dwc3_otg_update(struct dwc3 *dwc, bool ignore_idstatus)
 		dwc3_event_buffers_setup(dwc);
 		spin_unlock_irqrestore(&dwc->lock, flags);
 
-		if (dwc->usb2_phy)
-			otg_set_vbus(dwc->usb2_phy->otg, false);
+		dwc3_set_vbus(dwc, false);
 		if (dwc->usb2_generic_phy)
 			phy_set_mode(dwc->usb2_generic_phy,
 				     PHY_MODE_USB_DEVICE);
-- 
2.17.1

