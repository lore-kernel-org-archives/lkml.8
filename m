Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B39C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 13:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F40D222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 13:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730073AbgBMNYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 08:24:46 -0500
Received: from mga06.intel.com ([134.134.136.31]:44559 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730056AbgBMNYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 08:24:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2020 05:24:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,436,1574150400"; 
   d="scan'208";a="347728501"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 13 Feb 2020 05:24:39 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH 5/9] usb: roles: Provide the switch drivers handle to the switch in the API
Date:   Thu, 13 Feb 2020 16:24:24 +0300
Message-Id: <20200213132428.53374-6-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213132428.53374-1-heikki.krogerus@linux.intel.com>
References: <20200213132428.53374-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB role callback functions had a parameter pointing to
the parent device (struct device) of the switch. The
assumption was that the switch parent is always the
controller. Firstly, that may not be true in every case, and
secondly, it prevents us from supporting devices that supply
multiple muxes.

Changing the first parameter of usb_role_switch_set_t and
usb_role_switch_get_t from struct device to struct
usb_role_switch.

Cc: Peter Chen <Peter.Chen@nxp.com>
Cc: Felipe Balbi <balbi@kernel.org>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: Bin Liu <b-liu@ti.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/cdns3/core.c                      | 10 ++++---
 drivers/usb/chipidea/core.c                   | 10 ++++---
 drivers/usb/dwc3/dwc3-meson-g12a.c            | 10 ++++---
 drivers/usb/gadget/udc/renesas_usb3.c         | 26 ++++++++++---------
 drivers/usb/gadget/udc/tegra-xudc.c           |  8 +++---
 drivers/usb/mtu3/mtu3_dr.c                    |  9 ++++---
 drivers/usb/musb/mediatek.c                   |  9 ++++---
 drivers/usb/roles/class.c                     |  4 +--
 .../usb/roles/intel-xhci-usb-role-switch.c    | 26 +++++++++++--------
 include/linux/usb/role.h                      |  5 ++--
 10 files changed, 67 insertions(+), 50 deletions(-)

diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
index c2123ef8d8a3..a7a7cb9a2a48 100644
--- a/drivers/usb/cdns3/core.c
+++ b/drivers/usb/cdns3/core.c
@@ -330,9 +330,9 @@ int cdns3_hw_role_switch(struct cdns3 *cdns)
  *
  * Returns role
  */
-static enum usb_role cdns3_role_get(struct device *dev)
+static enum usb_role cdns3_role_get(struct usb_role_switch *sw)
 {
-	struct cdns3 *cdns = dev_get_drvdata(dev);
+	struct cdns3 *cdns = usb_role_switch_get_drvdata(sw);
 
 	return cdns->role;
 }
@@ -346,9 +346,9 @@ static enum usb_role cdns3_role_get(struct device *dev)
  * - Role switch for dual-role devices
  * - USB_ROLE_GADGET <--> USB_ROLE_NONE for peripheral-only devices
  */
-static int cdns3_role_set(struct device *dev, enum usb_role role)
+static int cdns3_role_set(struct usb_role_switch *sw, enum usb_role role)
 {
-	struct cdns3 *cdns = dev_get_drvdata(dev);
+	struct cdns3 *cdns = usb_role_switch_get_drvdata(sw);
 	int ret = 0;
 
 	pm_runtime_get_sync(cdns->dev);
@@ -536,6 +536,8 @@ static int cdns3_probe(struct platform_device *pdev)
 		goto err4;
 	}
 
+	usb_role_switch_set_drvdata(cdns->role_sw, cdns);
+
 	ret = cdns3_drd_init(cdns);
 	if (ret)
 		goto err5;
diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 52139c2a9924..ae0bdc036464 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -600,9 +600,9 @@ static int ci_cable_notifier(struct notifier_block *nb, unsigned long event,
 	return NOTIFY_DONE;
 }
 
-static enum usb_role ci_usb_role_switch_get(struct device *dev)
+static enum usb_role ci_usb_role_switch_get(struct usb_role_switch *sw)
 {
-	struct ci_hdrc *ci = dev_get_drvdata(dev);
+	struct ci_hdrc *ci = usb_role_switch_get_drvdata(sw);
 	enum usb_role role;
 	unsigned long flags;
 
@@ -613,9 +613,10 @@ static enum usb_role ci_usb_role_switch_get(struct device *dev)
 	return role;
 }
 
-static int ci_usb_role_switch_set(struct device *dev, enum usb_role role)
+static int ci_usb_role_switch_set(struct usb_role_switch *sw,
+				  enum usb_role role)
 {
-	struct ci_hdrc *ci = dev_get_drvdata(dev);
+	struct ci_hdrc *ci = usb_role_switch_get_drvdata(sw);
 	struct ci_hdrc_cable *cable = NULL;
 	enum usb_role current_role = ci_role_to_usb_role(ci);
 	enum ci_role ci_role = usb_role_to_ci_role(role);
@@ -1118,6 +1119,7 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 	}
 
 	if (ci_role_switch.fwnode) {
+		ci_role_switch.driver_data = ci;
 		ci->role_switch = usb_role_switch_register(dev,
 					&ci_role_switch);
 		if (IS_ERR(ci->role_switch)) {
diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
index 8a3ec1a951fe..3309ce90ca14 100644
--- a/drivers/usb/dwc3/dwc3-meson-g12a.c
+++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
@@ -321,9 +321,10 @@ static int dwc3_meson_g12a_otg_mode_set(struct dwc3_meson_g12a *priv,
 	return 0;
 }
 
-static int dwc3_meson_g12a_role_set(struct device *dev, enum usb_role role)
+static int dwc3_meson_g12a_role_set(struct usb_role_switch *sw,
+				    enum usb_role role)
 {
-	struct dwc3_meson_g12a *priv = dev_get_drvdata(dev);
+	struct dwc3_meson_g12a *priv = usb_role_switch_get_drvdata(sw);
 	enum phy_mode mode;
 
 	if (role == USB_ROLE_NONE)
@@ -338,9 +339,9 @@ static int dwc3_meson_g12a_role_set(struct device *dev, enum usb_role role)
 	return dwc3_meson_g12a_otg_mode_set(priv, mode);
 }
 
-static enum usb_role dwc3_meson_g12a_role_get(struct device *dev)
+static enum usb_role dwc3_meson_g12a_role_get(struct usb_role_switch *sw)
 {
-	struct dwc3_meson_g12a *priv = dev_get_drvdata(dev);
+	struct dwc3_meson_g12a *priv = usb_role_switch_get_drvdata(sw);
 
 	return priv->otg_phy_mode == PHY_MODE_USB_HOST ?
 		USB_ROLE_HOST : USB_ROLE_DEVICE;
@@ -499,6 +500,7 @@ static int dwc3_meson_g12a_probe(struct platform_device *pdev)
 	priv->switch_desc.allow_userspace_control = true;
 	priv->switch_desc.set = dwc3_meson_g12a_role_set;
 	priv->switch_desc.get = dwc3_meson_g12a_role_get;
+	priv->switch_desc.driver_data = priv;
 
 	priv->role_switch = usb_role_switch_register(dev, &priv->switch_desc);
 	if (IS_ERR(priv->role_switch))
diff --git a/drivers/usb/gadget/udc/renesas_usb3.c b/drivers/usb/gadget/udc/renesas_usb3.c
index c5c3c14df67a..4da90160b400 100644
--- a/drivers/usb/gadget/udc/renesas_usb3.c
+++ b/drivers/usb/gadget/udc/renesas_usb3.c
@@ -2355,14 +2355,14 @@ static const struct usb_gadget_ops renesas_usb3_gadget_ops = {
 	.set_selfpowered	= renesas_usb3_set_selfpowered,
 };
 
-static enum usb_role renesas_usb3_role_switch_get(struct device *dev)
+static enum usb_role renesas_usb3_role_switch_get(struct usb_role_switch *sw)
 {
-	struct renesas_usb3 *usb3 = dev_get_drvdata(dev);
+	struct renesas_usb3 *usb3 = usb_role_switch_get_drvdata(sw);
 	enum usb_role cur_role;
 
-	pm_runtime_get_sync(dev);
+	pm_runtime_get_sync(usb3_to_dev(usb3));
 	cur_role = usb3_is_host(usb3) ? USB_ROLE_HOST : USB_ROLE_DEVICE;
-	pm_runtime_put(dev);
+	pm_runtime_put(usb3_to_dev(usb3));
 
 	return cur_role;
 }
@@ -2372,7 +2372,7 @@ static void handle_ext_role_switch_states(struct device *dev,
 {
 	struct renesas_usb3 *usb3 = dev_get_drvdata(dev);
 	struct device *host = usb3->host_dev;
-	enum usb_role cur_role = renesas_usb3_role_switch_get(dev);
+	enum usb_role cur_role = renesas_usb3_role_switch_get(usb3->role_sw);
 
 	switch (role) {
 	case USB_ROLE_NONE:
@@ -2424,7 +2424,7 @@ static void handle_role_switch_states(struct device *dev,
 {
 	struct renesas_usb3 *usb3 = dev_get_drvdata(dev);
 	struct device *host = usb3->host_dev;
-	enum usb_role cur_role = renesas_usb3_role_switch_get(dev);
+	enum usb_role cur_role = renesas_usb3_role_switch_get(usb3->role_sw);
 
 	if (cur_role == USB_ROLE_HOST && role == USB_ROLE_DEVICE) {
 		device_release_driver(host);
@@ -2438,19 +2438,19 @@ static void handle_role_switch_states(struct device *dev,
 	}
 }
 
-static int renesas_usb3_role_switch_set(struct device *dev,
+static int renesas_usb3_role_switch_set(struct usb_role_switch *sw,
 					enum usb_role role)
 {
-	struct renesas_usb3 *usb3 = dev_get_drvdata(dev);
+	struct renesas_usb3 *usb3 = usb_role_switch_get_drvdata(sw);
 
-	pm_runtime_get_sync(dev);
+	pm_runtime_get_sync(usb3_to_dev(usb3));
 
 	if (usb3->role_sw_by_connector)
-		handle_ext_role_switch_states(dev, role);
+		handle_ext_role_switch_states(usb3_to_dev(usb3), role);
 	else
-		handle_role_switch_states(dev, role);
+		handle_role_switch_states(usb3_to_dev(usb3), role);
 
-	pm_runtime_put(dev);
+	pm_runtime_put(usb3_to_dev(usb3));
 
 	return 0;
 }
@@ -2831,6 +2831,8 @@ static int renesas_usb3_probe(struct platform_device *pdev)
 		renesas_usb3_role_switch_desc.fwnode = dev_fwnode(&pdev->dev);
 	}
 
+	renesas_usb3_role_switch_desc.driver_data = usb3;
+
 	INIT_WORK(&usb3->role_work, renesas_usb3_role_work);
 	usb3->role_sw = usb_role_switch_register(&pdev->dev,
 					&renesas_usb3_role_switch_desc);
diff --git a/drivers/usb/gadget/udc/tegra-xudc.c b/drivers/usb/gadget/udc/tegra-xudc.c
index 634c2c19a176..b9df6369d56d 100644
--- a/drivers/usb/gadget/udc/tegra-xudc.c
+++ b/drivers/usb/gadget/udc/tegra-xudc.c
@@ -676,12 +676,13 @@ static void tegra_xudc_usb_role_sw_work(struct work_struct *work)
 
 }
 
-static int tegra_xudc_usb_role_sw_set(struct device *dev, enum usb_role role)
+static int tegra_xudc_usb_role_sw_set(struct usb_role_switch *sw,
+				      enum usb_role role)
 {
-	struct tegra_xudc *xudc = dev_get_drvdata(dev);
+	struct tegra_xudc *xudc = usb_role_switch_get_drvdata(sw);
 	unsigned long flags;
 
-	dev_dbg(dev, "%s role is %d\n", __func__, role);
+	dev_dbg(xudc->dev, "%s role is %d\n", __func__, role);
 
 	spin_lock_irqsave(&xudc->lock, flags);
 
@@ -3590,6 +3591,7 @@ static int tegra_xudc_probe(struct platform_device *pdev)
 	if (of_property_read_bool(xudc->dev->of_node, "usb-role-switch")) {
 		role_sx_desc.set = tegra_xudc_usb_role_sw_set;
 		role_sx_desc.fwnode = dev_fwnode(xudc->dev);
+		role_sx_desc.driver_data = xudc;
 
 		xudc->usb_role_sw = usb_role_switch_register(xudc->dev,
 							&role_sx_desc);
diff --git a/drivers/usb/mtu3/mtu3_dr.c b/drivers/usb/mtu3/mtu3_dr.c
index 08e18448e8b8..04f666e85731 100644
--- a/drivers/usb/mtu3/mtu3_dr.c
+++ b/drivers/usb/mtu3/mtu3_dr.c
@@ -320,9 +320,9 @@ void ssusb_set_force_mode(struct ssusb_mtk *ssusb,
 	mtu3_writel(ssusb->ippc_base, SSUSB_U2_CTRL(0), value);
 }
 
-static int ssusb_role_sw_set(struct device *dev, enum usb_role role)
+static int ssusb_role_sw_set(struct usb_role_switch *sw, enum usb_role role)
 {
-	struct ssusb_mtk *ssusb = dev_get_drvdata(dev);
+	struct ssusb_mtk *ssusb = usb_role_switch_get_drvdata(sw);
 	bool to_host = false;
 
 	if (role == USB_ROLE_HOST)
@@ -334,9 +334,9 @@ static int ssusb_role_sw_set(struct device *dev, enum usb_role role)
 	return 0;
 }
 
-static enum usb_role ssusb_role_sw_get(struct device *dev)
+static enum usb_role ssusb_role_sw_get(struct usb_role_switch *sw)
 {
-	struct ssusb_mtk *ssusb = dev_get_drvdata(dev);
+	struct ssusb_mtk *ssusb = usb_role_switch_get_drvdata(sw);
 	enum usb_role role;
 
 	role = ssusb->is_host ? USB_ROLE_HOST : USB_ROLE_DEVICE;
@@ -356,6 +356,7 @@ static int ssusb_role_sw_register(struct otg_switch_mtk *otg_sx)
 	role_sx_desc.set = ssusb_role_sw_set;
 	role_sx_desc.get = ssusb_role_sw_get;
 	role_sx_desc.fwnode = dev_fwnode(ssusb->dev);
+	role_sx_desc.driver_data = ssusb;
 	otg_sx->role_sw = usb_role_switch_register(ssusb->dev, &role_sx_desc);
 
 	return PTR_ERR_OR_ZERO(otg_sx->role_sw);
diff --git a/drivers/usb/musb/mediatek.c b/drivers/usb/musb/mediatek.c
index 6b88c2f5d970..703b98d71180 100644
--- a/drivers/usb/musb/mediatek.c
+++ b/drivers/usb/musb/mediatek.c
@@ -115,9 +115,9 @@ static void mtk_musb_clks_disable(struct mtk_glue *glue)
 	clk_disable_unprepare(glue->main);
 }
 
-static int musb_usb_role_sx_set(struct device *dev, enum usb_role role)
+static int musb_usb_role_sx_set(struct usb_role_switch *sw, enum usb_role role)
 {
-	struct mtk_glue *glue = dev_get_drvdata(dev);
+	struct mtk_glue *glue = usb_role_switch_get_drvdata(sw);
 	struct musb *musb = glue->musb;
 	u8 devctl = readb(musb->mregs + MUSB_DEVCTL);
 	enum usb_role new_role;
@@ -168,9 +168,9 @@ static int musb_usb_role_sx_set(struct device *dev, enum usb_role role)
 	return 0;
 }
 
-static enum usb_role musb_usb_role_sx_get(struct device *dev)
+static enum usb_role musb_usb_role_sx_get(struct usb_role_switch *sw)
 {
-	struct mtk_glue *glue = dev_get_drvdata(dev);
+	struct mtk_glue *glue = usb_role_switch_get_drvdata(sw);
 
 	return glue->role;
 }
@@ -182,6 +182,7 @@ static int mtk_otg_switch_init(struct mtk_glue *glue)
 	role_sx_desc.set = musb_usb_role_sx_set;
 	role_sx_desc.get = musb_usb_role_sx_get;
 	role_sx_desc.fwnode = dev_fwnode(glue->dev);
+	role_sx_desc.driver_data = glue;
 	glue->role_sw = usb_role_switch_register(glue->dev, &role_sx_desc);
 
 	return PTR_ERR_OR_ZERO(glue->role_sw);
diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c
index f3132d231599..d5e57d26c31f 100644
--- a/drivers/usb/roles/class.c
+++ b/drivers/usb/roles/class.c
@@ -48,7 +48,7 @@ int usb_role_switch_set_role(struct usb_role_switch *sw, enum usb_role role)
 
 	mutex_lock(&sw->lock);
 
-	ret = sw->set(sw->dev.parent, role);
+	ret = sw->set(sw, role);
 	if (!ret)
 		sw->role = role;
 
@@ -75,7 +75,7 @@ enum usb_role usb_role_switch_get_role(struct usb_role_switch *sw)
 	mutex_lock(&sw->lock);
 
 	if (sw->get)
-		role = sw->get(sw->dev.parent);
+		role = sw->get(sw);
 	else
 		role = sw->role;
 
diff --git a/drivers/usb/roles/intel-xhci-usb-role-switch.c b/drivers/usb/roles/intel-xhci-usb-role-switch.c
index 80d6559bbcb2..5c96e929acea 100644
--- a/drivers/usb/roles/intel-xhci-usb-role-switch.c
+++ b/drivers/usb/roles/intel-xhci-usb-role-switch.c
@@ -42,6 +42,7 @@
 #define DRV_NAME			"intel_xhci_usb_sw"
 
 struct intel_xhci_usb_data {
+	struct device *dev;
 	struct usb_role_switch *role_sw;
 	void __iomem *base;
 	bool enable_sw_switch;
@@ -51,9 +52,10 @@ static const struct software_node intel_xhci_usb_node = {
 	"intel-xhci-usb-sw",
 };
 
-static int intel_xhci_usb_set_role(struct device *dev, enum usb_role role)
+static int intel_xhci_usb_set_role(struct usb_role_switch *sw,
+				   enum usb_role role)
 {
-	struct intel_xhci_usb_data *data = dev_get_drvdata(dev);
+	struct intel_xhci_usb_data *data = usb_role_switch_get_drvdata(sw);
 	unsigned long timeout;
 	acpi_status status;
 	u32 glk, val;
@@ -66,11 +68,11 @@ static int intel_xhci_usb_set_role(struct device *dev, enum usb_role role)
 	 */
 	status = acpi_acquire_global_lock(ACPI_WAIT_FOREVER, &glk);
 	if (ACPI_FAILURE(status) && status != AE_NOT_CONFIGURED) {
-		dev_err(dev, "Error could not acquire lock\n");
+		dev_err(data->dev, "Error could not acquire lock\n");
 		return -EIO;
 	}
 
-	pm_runtime_get_sync(dev);
+	pm_runtime_get_sync(data->dev);
 
 	/*
 	 * Set idpin value as requested.
@@ -112,7 +114,7 @@ static int intel_xhci_usb_set_role(struct device *dev, enum usb_role role)
 	do {
 		val = readl(data->base + DUAL_ROLE_CFG1);
 		if (!!(val & HOST_MODE) == (role == USB_ROLE_HOST)) {
-			pm_runtime_put(dev);
+			pm_runtime_put(data->dev);
 			return 0;
 		}
 
@@ -120,21 +122,21 @@ static int intel_xhci_usb_set_role(struct device *dev, enum usb_role role)
 		usleep_range(5000, 10000);
 	} while (time_before(jiffies, timeout));
 
-	pm_runtime_put(dev);
+	pm_runtime_put(data->dev);
 
-	dev_warn(dev, "Timeout waiting for role-switch\n");
+	dev_warn(data->dev, "Timeout waiting for role-switch\n");
 	return -ETIMEDOUT;
 }
 
-static enum usb_role intel_xhci_usb_get_role(struct device *dev)
+static enum usb_role intel_xhci_usb_get_role(struct usb_role_switch *sw)
 {
-	struct intel_xhci_usb_data *data = dev_get_drvdata(dev);
+	struct intel_xhci_usb_data *data = usb_role_switch_get_drvdata(sw);
 	enum usb_role role;
 	u32 val;
 
-	pm_runtime_get_sync(dev);
+	pm_runtime_get_sync(data->dev);
 	val = readl(data->base + DUAL_ROLE_CFG0);
-	pm_runtime_put(dev);
+	pm_runtime_put(data->dev);
 
 	if (!(val & SW_IDPIN))
 		role = USB_ROLE_HOST;
@@ -175,7 +177,9 @@ static int intel_xhci_usb_probe(struct platform_device *pdev)
 	sw_desc.get = intel_xhci_usb_get_role,
 	sw_desc.allow_userspace_control = true,
 	sw_desc.fwnode = software_node_fwnode(&intel_xhci_usb_node);
+	sw_desc.driver_data = data;
 
+	data->dev = dev;
 	data->enable_sw_switch = !device_property_read_bool(dev,
 						"sw_switch_disable");
 
diff --git a/include/linux/usb/role.h b/include/linux/usb/role.h
index 02dae936cebd..c028ba8029ad 100644
--- a/include/linux/usb/role.h
+++ b/include/linux/usb/role.h
@@ -13,8 +13,9 @@ enum usb_role {
 	USB_ROLE_DEVICE,
 };
 
-typedef int (*usb_role_switch_set_t)(struct device *dev, enum usb_role role);
-typedef enum usb_role (*usb_role_switch_get_t)(struct device *dev);
+typedef int (*usb_role_switch_set_t)(struct usb_role_switch *sw,
+				     enum usb_role role);
+typedef enum usb_role (*usb_role_switch_get_t)(struct usb_role_switch *sw);
 
 /**
  * struct usb_role_switch_desc - USB Role Switch Descriptor
-- 
2.25.0

