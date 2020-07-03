Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C254C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 08:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25AEB207FF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 08:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgGCIRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 04:17:06 -0400
Received: from mga09.intel.com ([134.134.136.24]:45092 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726779AbgGCIRG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 04:17:06 -0400
IronPort-SDR: eHSbjsiWDcn8zpdECIDehcpkMoqeQ44Bc0karUoFkZ/GvQ3BSNVY1SW2QIQ/Idm8nfzPU5TMhL
 2Y9WJv4cIdbw==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="148639022"
X-IronPort-AV: E=Sophos;i="5.75,307,1589266800"; 
   d="scan'208";a="148639022"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2020 01:17:05 -0700
IronPort-SDR: mmyVcPnKNhWPtdhKZHwUNRm45Eg3WXZX2TJ84kJ0fFf+zqHYi/0httrLcowvplyskKhwoRgyoQ
 6FNFe66QqMdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,307,1589266800"; 
   d="scan'208";a="387565433"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 03 Jul 2020 01:17:03 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        "Mani, Rajmohan" <rajmohan.mani@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] platform/chrome: cros_ec_typec: USB4 support
Date:   Fri,  3 Jul 2020 11:17:03 +0300
Message-Id: <20200703081703.87720-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With USB4 mode the mux driver needs the Enter_USB Data
Object (EUDO) that was used when the USB mode was entered.
Though the object is not available in the driver, it is
possible to construct it from the information we have.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
Hi,

This patch depends on latest usb-next from Greg KH, this commit in
particular:
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/commit/?h=usb-next&id=ad8db94d6813dc659bd4de0531a8a1150559eafb

Prashant, can you take over the development of this patch (in case it
still needs work)? I will take a few weeks vacation starting from next
week (July 6th). I was hoping to get this feature into v5.9 if that's
possible. But if you guys think there is no hurry, let's forget about
it. Then we can just wait for 5.9-rc1 and not worry about the
dependency on Greg's usb-next.

thanks,

---
 drivers/platform/chrome/cros_ec_typec.c | 42 ++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 0c041b79cbbac..c9713aab9b6b0 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -13,6 +13,7 @@
 #include <linux/platform_data/cros_ec_proto.h>
 #include <linux/platform_data/cros_usbpd_notify.h>
 #include <linux/platform_device.h>
+#include <linux/usb/pd.h>
 #include <linux/usb/typec.h>
 #include <linux/usb/typec_altmode.h>
 #include <linux/usb/typec_dp.h>
@@ -494,6 +495,43 @@ static int cros_typec_enable_dp(struct cros_typec_data *typec,
 	return typec_mux_set(port->mux, &port->state);
 }
 
+static int cros_typec_enable_usb4(struct cros_typec_data *typec,
+				  int port_num,
+				  struct ec_response_usb_pd_control_v2 *pd_ctrl)
+{
+	struct cros_typec_port *port = typec->ports[port_num];
+	struct enter_usb_data data;
+
+	data.eudo = EUDO_USB_MODE_USB4 << EUDO_USB_MODE_SHIFT;
+
+	/* Cable Speed */
+	data.eudo |= pd_ctrl->cable_speed << EUDO_CABLE_SPEED_SHIFT;
+
+	/* Cable Type */
+	if (pd_ctrl->control_flags & USB_PD_CTRL_OPTICAL_CABLE)
+		data.eudo |= EUDO_CABLE_TYPE_OPTICAL << EUDO_CABLE_TYPE_SHIFT;
+	else if (pd_ctrl->control_flags & USB_PD_CTRL_ACTIVE_CABLE)
+		data.eudo |= EUDO_CABLE_TYPE_RE_TIMER << EUDO_CABLE_TYPE_SHIFT;
+
+	/* REVISIT: Cable Current? */
+
+	/* REVISIT: Claiming unconditionally that all tunnels are supported. */
+	data.eudo |= EUDO_PCIE_SUPPORT;
+	data.eudo |= EUDO_DP_SUPPORT;
+
+	data.eudo |= EUDO_TBT_SUPPORT;
+	data.eudo |= EUDO_HOST_PRESENT;
+
+	data.active_link_training = !!(pd_ctrl->control_flags &
+				       USB_PD_CTRL_ACTIVE_LINK_UNIDIR);
+
+	port->state.alt = NULL;
+	port->state.data = &data;
+	port->state.mode = TYPEC_MODE_USB4;
+
+	return typec_mux_set(port->mux, &port->state);
+}
+
 static int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
 				uint8_t mux_flags,
 				struct ec_response_usb_pd_control_v2 *pd_ctrl)
@@ -514,7 +552,9 @@ static int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
 	if (ret)
 		return ret;
 
-	if (mux_flags & USB_PD_MUX_TBT_COMPAT_ENABLED) {
+	if (mux_flags & USB_PD_MUX_USB4_ENABLED) {
+		ret = cros_typec_enable_usb4(typec, port_num, pd_ctrl);
+	} else if (mux_flags & USB_PD_MUX_TBT_COMPAT_ENABLED) {
 		ret = cros_typec_enable_tbt(typec, port_num, pd_ctrl);
 	} else if (mux_flags & USB_PD_MUX_DP_ENABLED) {
 		ret = cros_typec_enable_dp(typec, port_num, pd_ctrl);
-- 
2.27.0

