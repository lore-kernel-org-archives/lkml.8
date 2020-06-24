Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3676C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 09:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 811C620738
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 09:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389187AbgFXJPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 05:15:25 -0400
Received: from mga04.intel.com ([192.55.52.120]:52019 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387970AbgFXJPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 05:15:25 -0400
IronPort-SDR: 12iyne6dxW6Ss3qjwX/hg0NDM4yRA3SgvXvIrpFmRmUiQMzcX+ZgIIcnhxy03VxKrvBaqdrN1B
 be4la8DIsaAw==
X-IronPort-AV: E=McAfee;i="6000,8403,9661"; a="141883766"
X-IronPort-AV: E=Sophos;i="5.75,274,1589266800"; 
   d="scan'208,223";a="141883766"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2020 02:15:24 -0700
IronPort-SDR: v4K5gxhB0HbT/g4cu7ffo4ednpsN1hsYHnHK+PLifJ8xB73RfCgOhqML3dG3/d207RcCm+BtXk
 4sfgHdHiUuCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,274,1589266800"; 
   d="scan'208,223";a="385117082"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 24 Jun 2020 02:15:20 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 24 Jun 2020 12:15:20 +0300
Date:   Wed, 24 Jun 2020 12:15:20 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Azhar Shaikh <azhar.shaikh@intel.com>,
        Casey Bowman <casey.g.bowman@intel.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Yicheng Li <yichengli@chromium.org>
Subject: Re: [PATCH 2/2] platform/chrome: cros_ec_typec: Add TBT compat
 support
Message-ID: <20200624091520.GA1487@kuha.fi.intel.com>
References: <20200624080926.165107-1-pmalani@chromium.org>
 <20200624080926.165107-2-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
In-Reply-To: <20200624080926.165107-2-pmalani@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 24, 2020 at 01:09:24AM -0700, Prashant Malani wrote:
> Add mux control support for Thunderbolt compatibility mode.
> 
> Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Co-developed-by: Azhar Shaikh <azhar.shaikh@intel.com>
> Co-developed-by: Casey Bowman <casey.g.bowman@intel.com>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---
>  drivers/platform/chrome/cros_ec_typec.c | 70 ++++++++++++++++++++++++-
>  1 file changed, 69 insertions(+), 1 deletion(-)

Cool! Can you guys test also USB4 with the attached patch (still work
in progress)? It should apply on top of these.

The mux driver is still missing USB4 support, but I'll send the
patches needed for that right now...


thanks,

-- 
heikki

--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-platform-chrome-typec-USB4-support.patch"

From cdc5d9528c4f751d856dfc1781f125a767a5de20 Mon Sep 17 00:00:00 2001
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Date: Tue, 23 Jun 2020 15:53:02 +0300
Subject: [PATCH] platform/chrome: typec: USB4 support

With USB4 the mux driver needs the Enter_USB VDO.
Constructing one from the information we have.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/platform/chrome/cros_ec_typec.c | 39 ++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 688d12efe9c42..c6448485ddfa3 100644
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
@@ -511,6 +512,40 @@ static int cros_typec_enable_tbt(struct cros_typec_data *typec,
         return typec_mux_set(port->mux, &port->state);
 }
 
+static int cros_typec_enable_usb4(struct cros_typec_data *typec,
+				int port_num,
+				struct ec_response_usb_pd_control_v2 *pd_ctrl)
+{
+	struct cros_typec_port *port = typec->ports[port_num];
+	u32 eudo;
+
+	eudo = EUDO_USB_MODE_USB4 << EUDO_USB_MODE_SHIFT;
+
+	/* Cable Speed */
+	eudo |= pd_ctrl->cable_speed << EUDO_CABLE_SPEED_SHIFT;
+
+	/* Cable Type */
+	if (pd_ctrl->control_flags & USB_PD_CTRL_OPTICAL_CABLE)
+		eudo |= EUDO_CABLE_TYPE_OPTICAL << EUDO_CABLE_TYPE_SHIFT;
+	else if (pd_ctrl->control_flags & USB_PD_CTRL_ACTIVE_CABLE)
+		eudo |= EUDO_CABLE_TYPE_RE_TIMER << EUDO_CABLE_TYPE_SHIFT;
+
+	/* FIXME: Cable Current */
+
+	/* REVISIT: Claiming unconditionally that all tunnels are supported. */
+	eudo |= EUDO_PCIE_SUPPORT;
+	eudo |= EUDO_DP_SUPPORT;
+
+	eudo |= EUDO_TBT_SUPPORT;
+	eudo |= EUDO_HOST_PRESENT;
+
+	port->state.alt = NULL;
+	port->state.data = &eudo;
+	port->state.mode = TYPEC_MODE_USB4;
+
+	return typec_mux_set(port->mux, &port->state);
+}
+
 int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
 			     struct ec_response_usb_pd_mux_info *resp,
 			     struct ec_response_usb_pd_control_v2 *pd_ctrl)
@@ -534,7 +569,9 @@ int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
 	port->state.alt = NULL;
 	port->state.mode = TYPEC_STATE_USB;
 
-	if (resp->flags & USB_PD_MUX_TBT_COMPAT_ENABLED)
+	if (resp->flags & USB_PD_MUX_USB4_ENABLED)
+		ret = cros_typec_enable_usb4(typec, port_num, pd_ctrl);
+	else if (resp->flags & USB_PD_MUX_TBT_COMPAT_ENABLED)
 		ret = cros_typec_enable_tbt(typec, port_num, pd_ctrl);
 	else if (resp->flags & USB_PD_MUX_DP_ENABLED)
 		ret = cros_typec_enable_dp(typec, port_num, pd_ctrl);
-- 
2.27.0


--YZ5djTAD1cGYuMQK--
