Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76B4C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 04:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8824720720
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 04:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgHVEmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 00:42:21 -0400
Received: from mga11.intel.com ([192.55.52.93]:62114 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbgHVEmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 00:42:10 -0400
IronPort-SDR: fVSt6qW7t56PouEtv0eYWPHnAIHkYgoi42c4uz+g8J4wtYOC1Y2/BRIGDC+IvUTPTk+aFVuajK
 0vJg05kgX3Qg==
X-IronPort-AV: E=McAfee;i="6000,8403,9720"; a="153275287"
X-IronPort-AV: E=Sophos;i="5.76,339,1592895600"; 
   d="scan'208";a="153275287"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2020 21:42:01 -0700
IronPort-SDR: griWtDcJu82w9E+SGCJUbsLhzP1NJ6oVRQ6OMPvx3UflMk7vkzDwFSCtrgD8EdkjVUk+48o7Qq
 b0xXQG4a6W9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,339,1592895600"; 
   d="scan'208";a="327943130"
Received: from glacier.sc.intel.com ([10.3.62.63])
  by orsmga008.jf.intel.com with ESMTP; 21 Aug 2020 21:42:01 -0700
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
Cc:     pmalani@chromium.org, bleung@chromium.org,
        Rajmohan Mani <rajmohan.mani@intel.com>
Subject: [PATCH v2 3/3] usb: typec: intel_pmc_mux: Support for device role (UFP)
Date:   Fri, 21 Aug 2020 21:05:08 -0700
Message-Id: <20200822040508.23510-4-rajmohan.mani@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200822040508.23510-1-rajmohan.mani@intel.com>
References: <20200822040508.23510-1-rajmohan.mani@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

This adds support for device data role, and data role
swapping. The driver no longer relies on the cached role, as
it may not be valid (for example after bootup). Instead, the
role is always checked by readding the port status from IOM.

Note. After this, the orientation is always only cached, so
the driver does not support scenario where the role is set
before orientation. It means the typec drivers must always
set the orientation first before role.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Rajmohan Mani <rajmohan.mani@intel.com>
---
 drivers/usb/typec/mux/intel_pmc_mux.c | 67 ++++++++++++++-------------
 1 file changed, 34 insertions(+), 33 deletions(-)

diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
index c758d6113c41..d4ee7132227b 100644
--- a/drivers/usb/typec/mux/intel_pmc_mux.c
+++ b/drivers/usb/typec/mux/intel_pmc_mux.c
@@ -191,9 +191,6 @@ pmc_usb_mux_dp(struct pmc_usb_port *port, struct typec_mux_state *state)
 		return pmc_usb_mux_dp_hpd(port, state->data);
 	}
 
-	if (data->status & DP_STATUS_IRQ_HPD)
-		return pmc_usb_mux_dp_hpd(port, state->data);
-
 	req.usage = PMC_USB_ALT_MODE;
 	req.usage |= port->usb3_port << PMC_USB_MSG_USB3_PORT_SHIFT;
 	req.mode_type = PMC_USB_MODE_TYPE_DP << PMC_USB_MODE_TYPE_SHIFT;
@@ -312,39 +309,52 @@ static int pmc_usb_mux_safe_state(struct pmc_usb_port *port)
 	return pmc_usb_command(port, &msg, sizeof(msg));
 }
 
-static int pmc_usb_connect(struct pmc_usb_port *port)
+static int pmc_usb_disconnect(struct pmc_usb_port *port)
 {
+	struct typec_displayport_data data = { };
 	u8 msg[2];
 
-	if (port->iom_status & IOM_PORT_STATUS_CONNECTED)
+	if (!(port->iom_status & IOM_PORT_STATUS_CONNECTED))
 		return 0;
 
-	msg[0] = PMC_USB_CONNECT;
+	/* Clear DisplayPort HPD if it's still asserted. */
+	if (IOM_PORT_HPD_ASSERTED(port->iom_status))
+		pmc_usb_mux_dp_hpd(port, &data);
+
+	msg[0] = PMC_USB_DISCONNECT;
 	msg[0] |= port->usb3_port << PMC_USB_MSG_USB3_PORT_SHIFT;
 
 	msg[1] = port->usb2_port << PMC_USB_MSG_USB2_PORT_SHIFT;
-	msg[1] |= hsl_orientation(port) << PMC_USB_MSG_ORI_HSL_SHIFT;
-	msg[1] |= sbu_orientation(port) << PMC_USB_MSG_ORI_AUX_SHIFT;
 
 	return pmc_usb_command(port, msg, sizeof(msg));
 }
 
-static int pmc_usb_disconnect(struct pmc_usb_port *port)
+static int pmc_usb_connect(struct pmc_usb_port *port, enum usb_role role)
 {
-	struct typec_displayport_data data = { };
+	u8 ufp = role == USB_ROLE_DEVICE ? 1 : 0;
 	u8 msg[2];
+	int ret;
 
-	if (!(port->iom_status & IOM_PORT_STATUS_CONNECTED))
-		return 0;
+	if (port->orientation == TYPEC_ORIENTATION_NONE)
+		return -EINVAL;
 
-	/* Clear DisplayPort HPD if it's still asserted. */
-	if (IOM_PORT_HPD_ASSERTED(port->iom_status))
-		pmc_usb_mux_dp_hpd(port, &data);
+	if (port->iom_status & IOM_PORT_STATUS_CONNECTED) {
+		if (port->role == role || port->role == USB_ROLE_NONE)
+			return 0;
 
-	msg[0] = PMC_USB_DISCONNECT;
+		/* Role swap */
+		ret = pmc_usb_disconnect(port);
+		if (ret)
+			return ret;
+	}
+
+	msg[0] = PMC_USB_CONNECT;
 	msg[0] |= port->usb3_port << PMC_USB_MSG_USB3_PORT_SHIFT;
 
 	msg[1] = port->usb2_port << PMC_USB_MSG_USB2_PORT_SHIFT;
+	msg[1] |= ufp << PMC_USB_MSG_UFP_SHIFT;
+	msg[1] |= hsl_orientation(port) << PMC_USB_MSG_ORI_HSL_SHIFT;
+	msg[1] |= sbu_orientation(port) << PMC_USB_MSG_ORI_AUX_SHIFT;
 
 	return pmc_usb_command(port, msg, sizeof(msg));
 }
@@ -365,7 +375,7 @@ pmc_usb_mux_set(struct typec_mux *mux, struct typec_mux_state *state)
 	if (state->mode == TYPEC_STATE_SAFE)
 		return pmc_usb_mux_safe_state(port);
 	if (state->mode == TYPEC_STATE_USB)
-		return pmc_usb_connect(port);
+		return pmc_usb_connect(port, port->role);
 
 	if (state->alt) {
 		switch (state->alt->svid) {
@@ -380,7 +390,7 @@ pmc_usb_mux_set(struct typec_mux *mux, struct typec_mux_state *state)
 			/* REVISIT: Try with usb3_port set to 0? */
 			break;
 		case TYPEC_MODE_USB3:
-			return pmc_usb_connect(port);
+			return pmc_usb_connect(port, port->role);
 		case TYPEC_MODE_USB4:
 			return pmc_usb_mux_usb4(port, state);
 		}
@@ -401,13 +411,6 @@ static int pmc_usb_set_orientation(struct typec_switch *sw,
 
 	port->orientation = orientation;
 
-	if (port->role) {
-		if (orientation == TYPEC_ORIENTATION_NONE)
-			return pmc_usb_disconnect(port);
-		else
-			return pmc_usb_connect(port);
-	}
-
 	return 0;
 }
 
@@ -420,16 +423,14 @@ static int pmc_usb_set_role(struct usb_role_switch *sw, enum usb_role role)
 	if (ret)
 		return ret;
 
-	port->role = role;
+	if (role == USB_ROLE_NONE)
+		ret = pmc_usb_disconnect(port);
+	else
+		ret = pmc_usb_connect(port, role);
 
-	if (port->orientation) {
-		if (role == USB_ROLE_NONE)
-			return pmc_usb_disconnect(port);
-		else
-			return pmc_usb_connect(port);
-	}
+	port->role = role;
 
-	return 0;
+	return ret;
 }
 
 static int pmc_usb_register_port(struct pmc_usb *pmc, int index,
-- 
2.20.1

