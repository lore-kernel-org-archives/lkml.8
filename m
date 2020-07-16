Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB39C433E7
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 00:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D41620658
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 00:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbgGPAuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 20:50:14 -0400
Received: from mga14.intel.com ([192.55.52.115]:57225 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727906AbgGPAuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 20:50:10 -0400
IronPort-SDR: iv80tgvSY1KB1bmMeTTTtoILCC0jVW7Ay8bmzuJ6UfAKIo47WDzwgmbCOZE4bhMh6wxMu7CRbV
 +kavISjahyvg==
X-IronPort-AV: E=McAfee;i="6000,8403,9683"; a="148445963"
X-IronPort-AV: E=Sophos;i="5.75,357,1589266800"; 
   d="scan'208";a="148445963"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2020 17:50:05 -0700
IronPort-SDR: gbECWBVW9YAlTseyflmb4Carimxx5ju0QLQUUH4W33jnqjRW4qI1WPDJplbYIG3Yaw0lZMEk96
 w1ik/sd9re+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,357,1589266800"; 
   d="scan'208";a="316874134"
Received: from glacier.sc.intel.com ([10.3.62.63])
  by orsmga008.jf.intel.com with ESMTP; 15 Jul 2020 17:50:05 -0700
From:   Rajmohan Mani <rajmohan.mani@intel.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Jithu Joseph <jithu.joseph@intel.com>,
        =?UTF-8?q?Bla=C5=BE=20Hrastnik?= <blaz@mxxn.io>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     pmalani@chromium.org, bleung@chromium.org
Subject: [PATCH 2/2] usb: typec: intel_pmc_mux: Check the port status before connect
Date:   Wed, 15 Jul 2020 17:33:10 -0700
Message-Id: <20200716003310.26125-3-rajmohan.mani@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200716003310.26125-1-rajmohan.mani@intel.com>
References: <20200716003310.26125-1-rajmohan.mani@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

The PMC microcontroller that we use for configuration, does
not supply any status information back. For port status we
need to talk to another controller on the board called IOM
(I/O manager).

By checking the port status before configuring the muxes, we
can make sure that we do not reconfigure the port after
bootup when the system firmware (for example BIOS) has
already configured it.

Using the status information also to check if DisplayPort
HPD is still asserted when the cable plug is disconnected,
and clearing it if it is.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/mux/Kconfig         |  1 +
 drivers/usb/typec/mux/intel_pmc_mux.c | 73 +++++++++++++++++++++++----
 2 files changed, 64 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/typec/mux/Kconfig b/drivers/usb/typec/mux/Kconfig
index a4dbd11f8ee2..46f5512de63d 100644
--- a/drivers/usb/typec/mux/Kconfig
+++ b/drivers/usb/typec/mux/Kconfig
@@ -12,6 +12,7 @@ config TYPEC_MUX_PI3USB30532
 config TYPEC_MUX_INTEL_PMC
 	tristate "Intel PMC mux control"
 	depends on INTEL_SCU_IPC
+	depends on INTEL_IOM
 	select USB_ROLE_SWITCH
 	help
 	  Driver for USB muxes controlled by Intel PMC FW. Intel PMC FW can
diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
index 2aba07c7b221..84101fb99934 100644
--- a/drivers/usb/typec/mux/intel_pmc_mux.c
+++ b/drivers/usb/typec/mux/intel_pmc_mux.c
@@ -9,6 +9,7 @@
 #include <linux/acpi.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/platform_data/x86/intel_iom.h>
 #include <linux/property.h>
 #include <linux/usb/pd.h>
 #include <linux/usb/role.h>
@@ -83,10 +84,17 @@ enum {
 #define PMC_USB_DP_HPD_LVL		BIT(4)
 #define PMC_USB_DP_HPD_IRQ		BIT(5)
 
+/* IOM Port Status */
+#define IOM_PORT_ACTIVITY_IS(_status_, _type_)				\
+	((((_status_) & IOM_PORT_STATUS_ACTIVITY_TYPE_MASK) >>		\
+	  IOM_PORT_STATUS_ACTIVITY_TYPE_SHIFT) ==			\
+	 (IOM_PORT_STATUS_ACTIVITY_TYPE_##_type_))
+
 struct pmc_usb;
 
 struct pmc_usb_port {
 	int num;
+	u32 iom_status;
 	struct pmc_usb *pmc;
 	struct typec_mux *typec_mux;
 	struct typec_switch *typec_sw;
@@ -105,6 +113,7 @@ struct pmc_usb_port {
 struct pmc_usb {
 	u8 num_ports;
 	struct device *dev;
+	struct intel_iom *iom;
 	struct intel_scu_ipc_dev *ipc;
 	struct pmc_usb_port *port;
 };
@@ -145,18 +154,17 @@ static int pmc_usb_command(struct pmc_usb_port *port, u8 *msg, u32 len)
 }
 
 static int
-pmc_usb_mux_dp_hpd(struct pmc_usb_port *port, struct typec_mux_state *state)
+pmc_usb_mux_dp_hpd(struct pmc_usb_port *port, struct typec_displayport_data *dp)
 {
-	struct typec_displayport_data *data = state->data;
 	u8 msg[2] = { };
 
 	msg[0] = PMC_USB_DP_HPD;
 	msg[0] |= port->usb3_port << PMC_USB_MSG_USB3_PORT_SHIFT;
 
-	if (data->status & DP_STATUS_IRQ_HPD)
+	if (dp->status & DP_STATUS_IRQ_HPD)
 		msg[1] = PMC_USB_DP_HPD_IRQ;
 
-	if (data->status & DP_STATUS_HPD_STATE)
+	if (dp->status & DP_STATUS_HPD_STATE)
 		msg[1] |= PMC_USB_DP_HPD_LVL;
 
 	return pmc_usb_command(port, msg, sizeof(msg));
@@ -169,8 +177,12 @@ pmc_usb_mux_dp(struct pmc_usb_port *port, struct typec_mux_state *state)
 	struct altmode_req req = { };
 	int ret;
 
+	if (IOM_PORT_ACTIVITY_IS(port->iom_status, DP) ||
+	    IOM_PORT_ACTIVITY_IS(port->iom_status, DP_MFD))
+		return 0;
+
 	if (data->status & DP_STATUS_IRQ_HPD)
-		return pmc_usb_mux_dp_hpd(port, state);
+		return pmc_usb_mux_dp_hpd(port, state->data);
 
 	req.usage = PMC_USB_ALT_MODE;
 	req.usage |= port->usb3_port << PMC_USB_MSG_USB3_PORT_SHIFT;
@@ -193,7 +205,7 @@ pmc_usb_mux_dp(struct pmc_usb_port *port, struct typec_mux_state *state)
 		return ret;
 
 	if (data->status & DP_STATUS_HPD_STATE)
-		return pmc_usb_mux_dp_hpd(port, state);
+		return pmc_usb_mux_dp_hpd(port, state->data);
 
 	return 0;
 }
@@ -205,6 +217,10 @@ pmc_usb_mux_tbt(struct pmc_usb_port *port, struct typec_mux_state *state)
 	u8 cable_speed = TBT_CABLE_SPEED(data->cable_mode);
 	struct altmode_req req = { };
 
+	if (IOM_PORT_ACTIVITY_IS(port->iom_status, TBT) ||
+	    IOM_PORT_ACTIVITY_IS(port->iom_status, ALT_MODE_TBT_USB))
+		return 0;
+
 	req.usage = PMC_USB_ALT_MODE;
 	req.usage |= port->usb3_port << PMC_USB_MSG_USB3_PORT_SHIFT;
 	req.mode_type = PMC_USB_MODE_TYPE_TBT << PMC_USB_MODE_TYPE_SHIFT;
@@ -239,6 +255,10 @@ pmc_usb_mux_usb4(struct pmc_usb_port *port, struct typec_mux_state *state)
 	struct altmode_req req = { };
 	u8 cable_speed;
 
+	if (IOM_PORT_ACTIVITY_IS(port->iom_status, TBT) ||
+	    IOM_PORT_ACTIVITY_IS(port->iom_status, ALT_MODE_TBT_USB))
+		return 0;
+
 	req.usage = PMC_USB_ALT_MODE;
 	req.usage |= port->usb3_port << PMC_USB_MSG_USB3_PORT_SHIFT;
 	req.mode_type = PMC_USB_MODE_TYPE_TBT << PMC_USB_MODE_TYPE_SHIFT;
@@ -273,6 +293,9 @@ static int pmc_usb_mux_safe_state(struct pmc_usb_port *port)
 {
 	u8 msg;
 
+	if (IOM_PORT_ACTIVITY_IS(port->iom_status, SAFE_MODE))
+		return 0;
+
 	msg = PMC_USB_SAFE_MODE;
 	msg |= port->usb3_port << PMC_USB_MSG_USB3_PORT_SHIFT;
 
@@ -283,6 +306,9 @@ static int pmc_usb_connect(struct pmc_usb_port *port)
 {
 	u8 msg[2];
 
+	if (port->iom_status & IOM_PORT_STATUS_CONNECTED)
+		return 0;
+
 	msg[0] = PMC_USB_CONNECT;
 	msg[0] |= port->usb3_port << PMC_USB_MSG_USB3_PORT_SHIFT;
 
@@ -295,8 +321,18 @@ static int pmc_usb_connect(struct pmc_usb_port *port)
 
 static int pmc_usb_disconnect(struct pmc_usb_port *port)
 {
+	struct typec_displayport_data data = { };
 	u8 msg[2];
 
+	if (!(port->iom_status & IOM_PORT_STATUS_CONNECTED))
+		return 0;
+
+	/* Clear DisplayPort HPD if it's still asserted. */
+	if (((port->iom_status & IOM_PORT_STATUS_DHPD_HPD_STATUS_MASK) >>
+	     IOM_PORT_STATUS_DHPD_HPD_STATUS_SHIFT) &
+	    IOM_PORT_STATUS_DHPD_HPD_STATUS_ASSERT)
+		pmc_usb_mux_dp_hpd(port, &data);
+
 	msg[0] = PMC_USB_DISCONNECT;
 	msg[0] |= port->usb3_port << PMC_USB_MSG_USB3_PORT_SHIFT;
 
@@ -309,6 +345,11 @@ static int
 pmc_usb_mux_set(struct typec_mux *mux, struct typec_mux_state *state)
 {
 	struct pmc_usb_port *port = typec_mux_get_drvdata(mux);
+	int ret;
+
+	ret = intel_iom_port_status(port->pmc->iom, port->num, &port->iom_status);
+	if (ret)
+		return ret;
 
 	if (state->mode == TYPEC_STATE_SAFE)
 		return pmc_usb_mux_safe_state(port);
@@ -341,9 +382,11 @@ static int pmc_usb_set_orientation(struct typec_switch *sw,
 				   enum typec_orientation orientation)
 {
 	struct pmc_usb_port *port = typec_switch_get_drvdata(sw);
+	int ret;
 
-	if (port->orientation == orientation)
-		return 0;
+	ret = intel_iom_port_status(port->pmc->iom, port->num, &port->iom_status);
+	if (ret)
+		return ret;
 
 	port->orientation = orientation;
 
@@ -360,9 +403,11 @@ static int pmc_usb_set_orientation(struct typec_switch *sw,
 static int pmc_usb_set_role(struct usb_role_switch *sw, enum usb_role role)
 {
 	struct pmc_usb_port *port = usb_role_switch_get_drvdata(sw);
+	int ret;
 
-	if (port->role == role)
-		return 0;
+	ret = intel_iom_port_status(port->pmc->iom, port->num, &port->iom_status);
+	if (ret)
+		return ret;
 
 	port->role = role;
 
@@ -472,6 +517,10 @@ static int pmc_usb_probe(struct platform_device *pdev)
 
 	pmc->dev = &pdev->dev;
 
+	pmc->iom = intel_iom_get();
+	if (IS_ERR(pmc->iom))
+		return PTR_ERR(pmc->iom);
+
 	/*
 	 * For every physical USB connector (USB2 and USB3 combo) there is a
 	 * child ACPI device node under the PMC mux ACPI device object.
@@ -496,6 +545,8 @@ static int pmc_usb_probe(struct platform_device *pdev)
 		typec_mux_unregister(pmc->port[i].typec_mux);
 	}
 
+	intel_iom_put(pmc->iom);
+
 	return ret;
 }
 
@@ -509,6 +560,8 @@ static int pmc_usb_remove(struct platform_device *pdev)
 		typec_mux_unregister(pmc->port[i].typec_mux);
 	}
 
+	intel_iom_put(pmc->iom);
+
 	return 0;
 }
 
-- 
2.20.1

