Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B617C2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 11:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 148FD20674
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 11:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="RncP5xP0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbgBDLT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 06:19:27 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:14256 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbgBDLTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 06:19:25 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e3953030000>; Tue, 04 Feb 2020 03:18:27 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 04 Feb 2020 03:19:23 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 04 Feb 2020 03:19:23 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 4 Feb
 2020 11:19:23 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 4 Feb 2020 11:19:23 +0000
Received: from nkristam-ubuntu.nvidia.com (Not Verified[10.19.67.128]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e3953370001>; Tue, 04 Feb 2020 03:19:22 -0800
From:   Nagarjuna Kristam <nkristam@nvidia.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <kishon@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nagarjuna Kristam <nkristam@nvidia.com>
Subject: [Patch V4 08/19] usb: xhci-tegra: Add OTG support
Date:   Tue, 4 Feb 2020 16:46:54 +0530
Message-ID: <1580815025-10915-9-git-send-email-nkristam@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580815025-10915-1-git-send-email-nkristam@nvidia.com>
References: <1580815025-10915-1-git-send-email-nkristam@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580815107; bh=l49KwF/v0sBRX+Mo6lGCvGEVGIjz0jTqjounLUoYnhw=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=RncP5xP0Ps8nsssyogrAOj5UpnGVAnWpyqzQ8j1SntrGDvDfrpy/ewvwYV+zU2xyN
         6aI36/3v2ZX/36LwEva0+bgia5gNMfIK2LAhuAtXkNQTK+L6LnFXFyxoox5WnsRgNk
         x94Tyx1i4ygMqloN2Rw6S1FZfWZTHCoN7HMjSKbo46cOXYao4jOgI5LrXB77mpdW8f
         XxySisb0HD7LtfnNjI4FT2eSlR0WcBmwYl8APxSAzKNDY2S6H5k361S/DIG3/c4/Z3
         4zjGoIjFtbpG1o6jmNk7Wo4mUu8JY9PJxMAqriujduQl6FTcAyV6oLT0ZVv3q2TIwT
         GkMvKy/R4bR8g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get usb-phy's for availbale USB 2 phys. Register id notifiers for available
usb-phy's to receive role change notifications. Perform PP for the received
role change usb ports.

Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
V4:
 - Addressed nit comments from Thierry.
 - usb_phy_event is used to detect host mode instead of usb_role.
 - Added Acked-by info.
---
V3:
 - No changes in this version
---
V2:
 - Removed extra line before tegra_xusb_probe API.
---
 drivers/usb/host/xhci-tegra.c | 228 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 227 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
index 8163aef..32f630b 100644
--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -24,6 +24,9 @@
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
+#include <linux/usb/otg.h>
+#include <linux/usb/phy.h>
+#include <linux/usb/role.h>
 #include <soc/tegra/pmc.h>
 
 #include "xhci.h"
@@ -203,6 +206,7 @@ struct tegra_xusb_soc {
 
 	bool scale_ss_clock;
 	bool has_ipfs;
+	bool otg_reset_sspi;
 };
 
 struct tegra_xusb_context {
@@ -250,6 +254,14 @@ struct tegra_xusb {
 	struct phy **phys;
 	unsigned int num_phys;
 
+	struct usb_phy **usbphy;
+	unsigned int num_usb_phys;
+	int otg_usb2_port;
+	int otg_usb3_port;
+	bool host_mode;
+	struct notifier_block id_nb;
+	struct work_struct id_work;
+
 	/* Firmware loading related */
 	struct {
 		size_t size;
@@ -1081,6 +1093,205 @@ static int tegra_xusb_enable_firmware_messages(struct tegra_xusb *tegra)
 	return err;
 }
 
+static void tegra_xhci_set_port_power(struct tegra_xusb *tegra, bool main,
+						 bool set)
+{
+	struct xhci_hcd *xhci = hcd_to_xhci(tegra->hcd);
+	struct usb_hcd *hcd = main ?  xhci->main_hcd : xhci->shared_hcd;
+	unsigned int wait = (!main && !set) ? 1000 : 10;
+	u16 typeReq = set ? SetPortFeature : ClearPortFeature;
+	u16 wIndex = main ? tegra->otg_usb2_port + 1 : tegra->otg_usb3_port + 1;
+	u32 status;
+	u32 stat_power = main ? USB_PORT_STAT_POWER : USB_SS_PORT_STAT_POWER;
+	u32 status_val = set ? stat_power : 0;
+
+	dev_dbg(tegra->dev, "%s():%s %s port power\n", __func__,
+		set ? "set" : "clear", main ? "HS" : "SS");
+
+	hcd->driver->hub_control(hcd, typeReq, USB_PORT_FEAT_POWER, wIndex,
+				 NULL, 0);
+
+	do {
+		tegra_xhci_hc_driver.hub_control(hcd, GetPortStatus, 0, wIndex,
+					(char *) &status, sizeof(status));
+		if (status_val == (status & stat_power))
+			break;
+
+		if (!main && !set)
+			usleep_range(600, 700);
+		else
+			usleep_range(10, 20);
+	} while (--wait > 0);
+
+	if (status_val != (status & stat_power))
+		dev_info(tegra->dev, "failed to %s %s PP %d\n",
+						set ? "set" : "clear",
+						main ? "HS" : "SS", status);
+}
+
+static struct phy *tegra_xusb_get_phy(struct tegra_xusb *tegra, char *name,
+								int port)
+{
+	unsigned int i, phy_count = 0;
+
+	for (i = 0; i < tegra->soc->num_types; i++) {
+		if (!strncmp(tegra->soc->phy_types[i].name, "usb2",
+							    strlen(name)))
+			return tegra->phys[phy_count+port];
+
+		phy_count += tegra->soc->phy_types[i].num;
+	}
+
+	return NULL;
+}
+
+static void tegra_xhci_id_work(struct work_struct *work)
+{
+	struct tegra_xusb *tegra = container_of(work, struct tegra_xusb,
+						id_work);
+	struct xhci_hcd *xhci = hcd_to_xhci(tegra->hcd);
+	struct tegra_xusb_mbox_msg msg;
+	struct phy *phy = tegra_xusb_get_phy(tegra, "usb2",
+						    tegra->otg_usb2_port);
+	u32 status;
+	int ret;
+
+	dev_dbg(tegra->dev, "host mode %s\n", tegra->host_mode ? "on" : "off");
+
+	mutex_lock(&tegra->lock);
+
+	if (tegra->host_mode)
+		phy_set_mode_ext(phy, PHY_MODE_USB_OTG, USB_ROLE_HOST);
+	else
+		phy_set_mode_ext(phy, PHY_MODE_USB_OTG, USB_ROLE_NONE);
+
+	mutex_unlock(&tegra->lock);
+
+	if (tegra->host_mode) {
+		/* switch to host mode */
+		if (tegra->otg_usb3_port >= 0) {
+			if (tegra->soc->otg_reset_sspi) {
+				/* set PP=0 */
+				tegra_xhci_hc_driver.hub_control(
+					xhci->shared_hcd, GetPortStatus,
+					0, tegra->otg_usb3_port+1,
+					(char *) &status, sizeof(status));
+				if (status & USB_SS_PORT_STAT_POWER)
+					tegra_xhci_set_port_power(tegra, false,
+								  false);
+
+				/* reset OTG port SSPI */
+				msg.cmd = MBOX_CMD_RESET_SSPI;
+				msg.data = tegra->otg_usb3_port+1;
+
+				ret = tegra_xusb_mbox_send(tegra, &msg);
+				if (ret < 0) {
+					dev_info(tegra->dev,
+						"failed to RESET_SSPI %d\n",
+						ret);
+				}
+			}
+
+			tegra_xhci_set_port_power(tegra, false, true);
+		}
+
+		tegra_xhci_set_port_power(tegra, true, true);
+
+	} else {
+		if (tegra->otg_usb3_port >= 0)
+			tegra_xhci_set_port_power(tegra, false, false);
+
+		tegra_xhci_set_port_power(tegra, true, false);
+	}
+}
+
+static int tegra_xusb_get_usb2_port(struct tegra_xusb *tegra,
+					      struct usb_phy *usbphy)
+{
+	unsigned int i;
+
+	for (i = 0; i < tegra->num_usb_phys; i++) {
+		if (tegra->usbphy[i] && usbphy == tegra->usbphy[i])
+			return i;
+	}
+
+	return -1;
+}
+
+static int tegra_xhci_id_notify(struct notifier_block *nb,
+					 unsigned long action, void *data)
+{
+	struct tegra_xusb *tegra = container_of(nb, struct tegra_xusb,
+						    id_nb);
+	struct usb_phy *usbphy = (struct usb_phy *)data;
+
+	dev_dbg(tegra->dev, "%s(): action is %d", __func__, usbphy->last_event);
+
+	if ((tegra->host_mode && usbphy->last_event == USB_EVENT_ID) ||
+		(!tegra->host_mode && usbphy->last_event != USB_EVENT_ID)) {
+		dev_dbg(tegra->dev, "Same role(%d) received. Ignore",
+			tegra->host_mode);
+		return NOTIFY_OK;
+	}
+
+	tegra->otg_usb2_port = tegra_xusb_get_usb2_port(tegra, usbphy);
+	tegra->otg_usb3_port = tegra_xusb_padctl_get_usb3_companion(
+							tegra->padctl,
+							tegra->otg_usb2_port);
+
+	tegra->host_mode = (usbphy->last_event == USB_EVENT_ID) ? true : false;
+
+	schedule_work(&tegra->id_work);
+
+	return NOTIFY_OK;
+}
+
+static int tegra_xusb_init_usb_phy(struct tegra_xusb *tegra)
+{
+	unsigned int i;
+
+	tegra->usbphy = devm_kcalloc(tegra->dev, tegra->num_usb_phys,
+				   sizeof(*tegra->usbphy), GFP_KERNEL);
+	if (!tegra->usbphy)
+		return -ENOMEM;
+
+	INIT_WORK(&tegra->id_work, tegra_xhci_id_work);
+	tegra->id_nb.notifier_call = tegra_xhci_id_notify;
+
+	for (i = 0; i < tegra->num_usb_phys; i++) {
+		struct phy *phy = tegra_xusb_get_phy(tegra, "usb2", i);
+
+		if (!phy)
+			continue;
+
+		tegra->usbphy[i] = devm_usb_get_phy_by_node(tegra->dev,
+							phy->dev.of_node,
+							&tegra->id_nb);
+		if (!IS_ERR(tegra->usbphy[i])) {
+			dev_dbg(tegra->dev, "usbphy-%d registered", i);
+			otg_set_host(tegra->usbphy[i]->otg, &tegra->hcd->self);
+		} else {
+			/*
+			 * usb-phy is optional, continue if its not available.
+			 */
+			tegra->usbphy[i] = NULL;
+		}
+	}
+
+	return 0;
+}
+
+static void tegra_xusb_deinit_usb_phy(struct tegra_xusb *tegra)
+{
+	unsigned int i;
+
+	cancel_work_sync(&tegra->id_work);
+
+	for (i = 0; i < tegra->num_usb_phys; i++)
+		if (tegra->usbphy[i])
+			otg_set_host(tegra->usbphy[i]->otg, NULL);
+}
+
 static int tegra_xusb_probe(struct platform_device *pdev)
 {
 	struct tegra_xusb *tegra;
@@ -1254,8 +1465,11 @@ static int tegra_xusb_probe(struct platform_device *pdev)
 		goto put_powerdomains;
 	}
 
-	for (i = 0; i < tegra->soc->num_types; i++)
+	for (i = 0; i < tegra->soc->num_types; i++) {
+		if (!strncmp(tegra->soc->phy_types[i].name, "usb2", 4))
+			tegra->num_usb_phys = tegra->soc->phy_types[i].num;
 		tegra->num_phys += tegra->soc->phy_types[i].num;
+	}
 
 	tegra->phys = devm_kcalloc(&pdev->dev, tegra->num_phys,
 				   sizeof(*tegra->phys), GFP_KERNEL);
@@ -1384,6 +1598,12 @@ static int tegra_xusb_probe(struct platform_device *pdev)
 		goto remove_usb3;
 	}
 
+	err = tegra_xusb_init_usb_phy(tegra);
+	if (err < 0) {
+		dev_err(&pdev->dev, "failed to init USB PHY: %d\n", err);
+		goto remove_usb3;
+	}
+
 	return 0;
 
 remove_usb3:
@@ -1420,6 +1640,8 @@ static int tegra_xusb_remove(struct platform_device *pdev)
 	struct tegra_xusb *tegra = platform_get_drvdata(pdev);
 	struct xhci_hcd *xhci = hcd_to_xhci(tegra->hcd);
 
+	tegra_xusb_deinit_usb_phy(tegra);
+
 	usb_remove_hcd(xhci->shared_hcd);
 	usb_put_hcd(xhci->shared_hcd);
 	xhci->shared_hcd = NULL;
@@ -1694,6 +1916,7 @@ static const struct tegra_xusb_soc tegra124_soc = {
 	},
 	.scale_ss_clock = true,
 	.has_ipfs = true,
+	.otg_reset_sspi = false,
 	.mbox = {
 		.cmd = 0xe4,
 		.data_in = 0xe8,
@@ -1733,6 +1956,7 @@ static const struct tegra_xusb_soc tegra210_soc = {
 	},
 	.scale_ss_clock = false,
 	.has_ipfs = true,
+	.otg_reset_sspi = true,
 	.mbox = {
 		.cmd = 0xe4,
 		.data_in = 0xe8,
@@ -1773,6 +1997,7 @@ static const struct tegra_xusb_soc tegra186_soc = {
 	},
 	.scale_ss_clock = false,
 	.has_ipfs = false,
+	.otg_reset_sspi = false,
 	.mbox = {
 		.cmd = 0xe4,
 		.data_in = 0xe8,
@@ -1802,6 +2027,7 @@ static const struct tegra_xusb_soc tegra194_soc = {
 	},
 	.scale_ss_clock = false,
 	.has_ipfs = false,
+	.otg_reset_sspi = false,
 	.mbox = {
 		.cmd = 0x68,
 		.data_in = 0x6c,
-- 
2.7.4

