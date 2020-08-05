Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F090AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 06:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D450F2245C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 06:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgHEG1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 02:27:05 -0400
Received: from atl4mhfb04.myregisteredsite.com ([209.17.115.120]:50078 "EHLO
        atl4mhfb04.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725904AbgHEG1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 02:27:04 -0400
X-Greylist: delayed 548 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Aug 2020 02:27:02 EDT
Received: from jax4mhob08.myregisteredsite.com (jax4mhob08.myregisteredsite.com [64.69.218.88])
        by atl4mhfb04.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id 0756Hp2J012836
        for <linux-kernel@vger.kernel.org>; Wed, 5 Aug 2020 02:17:51 -0400
Received: from mailpod.hostingplatform.com (atl4qobmail04pod0.registeredsite.com [10.30.71.206])
        by jax4mhob08.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id 0756HnkU032363
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Wed, 5 Aug 2020 02:17:49 -0400
Received: (qmail 3705 invoked by uid 0); 5 Aug 2020 06:17:49 -0000
X-TCPREMOTEIP: 83.128.90.119
X-Authenticated-UID: mike@milosoftware.com
Received: from unknown (HELO phenom.domain?not?set.invalid) (mike@milosoftware.com@83.128.90.119)
  by 0 with ESMTPA; 5 Aug 2020 06:17:48 -0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, vincent.whitchurch@axis.com,
        balbi@kernel.org, gregkh@linuxfoundation.org, lgirdwood@gmail.com,
        Mike Looijmans <mike.looijmans@topic.nl>
Subject: [PATCH v4] usb: dwc3: Add support for VBUS power control
Date:   Wed,  5 Aug 2020 08:17:44 +0200
Message-Id: <20200805061744.20404-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support VBUS power control using regulator framework. Enables the regulator
while the port is in host mode.

The "vbus-supply" property can be provided using a usb-connector child node
and standard devicetree bindings.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---
v2: Add missing devm_regulator_get call which got lost during rebase
v3: Remove devicetree binding, use standard usb-connector
    Fix probe fail when vbus-supply is not present
v4: Use devm_regulator_get (without "optional")

 drivers/usb/dwc3/core.c | 34 ++++++++++++++++++++++++++--------
 drivers/usb/dwc3/core.h |  4 ++++
 drivers/usb/dwc3/drd.c  |  6 ++----
 3 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index edc17155cb2b..abfd043bae21 100644
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
 
@@ -1470,6 +1484,10 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	dwc3_get_properties(dwc);
 
+	dwc->vbus_reg = devm_regulator_get(dev, "vbus");
+	if (IS_ERR(dwc->vbus_reg))
+		return PTR_ERR(dwc->vbus_reg);
+
 	dwc->reset = devm_reset_control_array_get(dev, true, true);
 	if (IS_ERR(dwc->reset))
 		return PTR_ERR(dwc->reset);
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

