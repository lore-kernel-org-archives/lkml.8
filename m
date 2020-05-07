Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBF8C54E49
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 15:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C01BD2083B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 15:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgEGPJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 11:09:10 -0400
Received: from mga09.intel.com ([134.134.136.24]:51959 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727833AbgEGPJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 11:09:08 -0400
IronPort-SDR: pCxfU4fUfFb/ZnA8LrxMWOadiMJSYbt1zgDkCBweq2LriFqlwiOY8aULzVwRrfBqThVQk0iCZA
 clmVwrvaTJsw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2020 08:09:07 -0700
IronPort-SDR: vqZo7as03LfCIUCXjkULgUVHfl7jY6XAFnHJfcq6GOZaYujfYLbUj5yEa69jZEdJay4XqPSU6e
 NxgktWHZ5WZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,364,1583222400"; 
   d="scan'208";a="370143316"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 May 2020 08:09:05 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH 2/4] usb: typec: mux: intel_pmc_mux: Support for static SBU/HSL orientation
Date:   Thu,  7 May 2020 18:08:58 +0300
Message-Id: <20200507150900.12102-3-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200507150900.12102-1-heikki.krogerus@linux.intel.com>
References: <20200507150900.12102-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SBU and HSL orientation may be fixed/static from the mux
PoW. Apparently the retimer may take care of the orientation
of these lines. Handling the static SBU (AUX) and HSL
orientation with device properties.

If the SBU orientation is static, a device property
"sbu-orintation" can be used. When the property exists, the
driver always sets the SBU orientation according to the
property value, and when it's not set, the driver uses the
cable plug orientation with SBU.

And with static HSL orientation, "hsl-orientation" device
property can be used in the same way.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/mux/intel_pmc_mux.c | 42 +++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
index f5c5e0aef66f..1aac218099f3 100644
--- a/drivers/usb/typec/mux/intel_pmc_mux.c
+++ b/drivers/usb/typec/mux/intel_pmc_mux.c
@@ -91,6 +91,9 @@ struct pmc_usb_port {
 
 	u8 usb2_port;
 	u8 usb3_port;
+
+	enum typec_orientation sbu_orientation;
+	enum typec_orientation hsl_orientation;
 };
 
 struct pmc_usb {
@@ -99,6 +102,22 @@ struct pmc_usb {
 	struct pmc_usb_port *port;
 };
 
+static int sbu_orientation(struct pmc_usb_port *port)
+{
+	if (port->sbu_orientation)
+		return port->sbu_orientation - 1;
+
+	return port->orientation - 1;
+}
+
+static int hsl_orientation(struct pmc_usb_port *port)
+{
+	if (port->hsl_orientation)
+		return port->hsl_orientation - 1;
+
+	return port->orientation - 1;
+}
+
 static int pmc_usb_command(struct pmc_usb_port *port, u8 *msg, u32 len)
 {
 	u8 response[4];
@@ -151,8 +170,9 @@ pmc_usb_mux_dp(struct pmc_usb_port *port, struct typec_mux_state *state)
 
 	req.mode_data = (port->orientation - 1) << PMC_USB_ALTMODE_ORI_SHIFT;
 	req.mode_data |= (port->role - 1) << PMC_USB_ALTMODE_UFP_SHIFT;
-	req.mode_data |= (port->orientation - 1) << PMC_USB_ALTMODE_ORI_AUX_SHIFT;
-	req.mode_data |= (port->orientation - 1) << PMC_USB_ALTMODE_ORI_HSL_SHIFT;
+
+	req.mode_data |= sbu_orientation(port) << PMC_USB_ALTMODE_ORI_AUX_SHIFT;
+	req.mode_data |= hsl_orientation(port) << PMC_USB_ALTMODE_ORI_HSL_SHIFT;
 
 	req.mode_data |= (state->mode - TYPEC_STATE_MODAL) <<
 			 PMC_USB_ALTMODE_DP_MODE_SHIFT;
@@ -173,8 +193,9 @@ pmc_usb_mux_tbt(struct pmc_usb_port *port, struct typec_mux_state *state)
 
 	req.mode_data = (port->orientation - 1) << PMC_USB_ALTMODE_ORI_SHIFT;
 	req.mode_data |= (port->role - 1) << PMC_USB_ALTMODE_UFP_SHIFT;
-	req.mode_data |= (port->orientation - 1) << PMC_USB_ALTMODE_ORI_AUX_SHIFT;
-	req.mode_data |= (port->orientation - 1) << PMC_USB_ALTMODE_ORI_HSL_SHIFT;
+
+	req.mode_data |= sbu_orientation(port) << PMC_USB_ALTMODE_ORI_AUX_SHIFT;
+	req.mode_data |= hsl_orientation(port) << PMC_USB_ALTMODE_ORI_HSL_SHIFT;
 
 	if (TBT_ADAPTER(data->device_mode) == TBT_ADAPTER_TBT3)
 		req.mode_data |= PMC_USB_ALTMODE_TBT_TYPE;
@@ -211,8 +232,8 @@ static int pmc_usb_connect(struct pmc_usb_port *port)
 	msg[0] |= port->usb3_port << PMC_USB_MSG_USB3_PORT_SHIFT;
 
 	msg[1] = port->usb2_port << PMC_USB_MSG_USB2_PORT_SHIFT;
-	msg[1] |= (port->orientation - 1) << PMC_USB_MSG_ORI_HSL_SHIFT;
-	msg[1] |= (port->orientation - 1) << PMC_USB_MSG_ORI_AUX_SHIFT;
+	msg[1] |= hsl_orientation(port) << PMC_USB_MSG_ORI_HSL_SHIFT;
+	msg[1] |= sbu_orientation(port) << PMC_USB_MSG_ORI_AUX_SHIFT;
 
 	return pmc_usb_command(port, msg, sizeof(msg));
 }
@@ -296,6 +317,7 @@ static int pmc_usb_register_port(struct pmc_usb *pmc, int index,
 	struct usb_role_switch_desc desc = { };
 	struct typec_switch_desc sw_desc = { };
 	struct typec_mux_desc mux_desc = { };
+	const char *str;
 	int ret;
 
 	ret = fwnode_property_read_u8(fwnode, "usb2-port", &port->usb2_port);
@@ -306,6 +328,14 @@ static int pmc_usb_register_port(struct pmc_usb *pmc, int index,
 	if (ret)
 		return ret;
 
+	ret = fwnode_property_read_string(fwnode, "sbu-orientation", &str);
+	if (!ret)
+		port->sbu_orientation = typec_find_orientation(str);
+
+	ret = fwnode_property_read_string(fwnode, "hsl-orientation", &str);
+	if (!ret)
+		port->hsl_orientation = typec_find_orientation(str);
+
 	port->num = index;
 	port->pmc = pmc;
 
-- 
2.26.2

