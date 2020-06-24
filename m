Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7582BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 09:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5681320857
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 09:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389239AbgFXJUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 05:20:47 -0400
Received: from mga02.intel.com ([134.134.136.20]:20906 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728637AbgFXJUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 05:20:46 -0400
IronPort-SDR: gTSKpv00C6KSu45ypFmOdHL0MZA5oONdXSiEtvMT38ffUaFbWJCZNzBV+iytFLDKMepWoir+Fk
 hLb0OvuepXWw==
X-IronPort-AV: E=McAfee;i="6000,8403,9661"; a="132819135"
X-IronPort-AV: E=Sophos;i="5.75,274,1589266800"; 
   d="scan'208,223";a="132819135"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2020 02:20:45 -0700
IronPort-SDR: mQTPffgumZt0McCPjrEFlfUOIcQxs8UXtJg2owJ4DEFyBoiBwIdSGJitmygUMxfd3P2PgQZFbA
 Uxe+sWC86IWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,274,1589266800"; 
   d="scan'208,223";a="385118010"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 24 Jun 2020 02:20:41 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 24 Jun 2020 12:20:40 +0300
Date:   Wed, 24 Jun 2020 12:20:40 +0300
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
Message-ID: <20200624092040.GB1487@kuha.fi.intel.com>
References: <20200624080926.165107-1-pmalani@chromium.org>
 <20200624080926.165107-2-pmalani@chromium.org>
 <20200624091520.GA1487@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="O5XBE6gyVG5Rl6Rj"
Content-Disposition: inline
In-Reply-To: <20200624091520.GA1487@kuha.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--O5XBE6gyVG5Rl6Rj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 24, 2020 at 12:15:20PM +0300, Heikki Krogerus wrote:
> On Wed, Jun 24, 2020 at 01:09:24AM -0700, Prashant Malani wrote:
> > Add mux control support for Thunderbolt compatibility mode.
> > 
> > Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > Co-developed-by: Azhar Shaikh <azhar.shaikh@intel.com>
> > Co-developed-by: Casey Bowman <casey.g.bowman@intel.com>
> > Signed-off-by: Prashant Malani <pmalani@chromium.org>
> > ---
> >  drivers/platform/chrome/cros_ec_typec.c | 70 ++++++++++++++++++++++++-
> >  1 file changed, 69 insertions(+), 1 deletion(-)
> 
> Cool! Can you guys test also USB4 with the attached patch (still work
> in progress)? It should apply on top of these.
> 
> The mux driver is still missing USB4 support, but I'll send the
> patches needed for that right now...

Actually, I'll just attach that one here as well. Let me know if you
guys can test these.

thanks,

-- 
heikki

--O5XBE6gyVG5Rl6Rj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-usb-typec-intel_pmc_mux-Add-support-for-USB4.patch"

From 396bd399ac815165ec4992739d45d52ecf234acc Mon Sep 17 00:00:00 2001
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Date: Wed, 3 Jun 2020 17:00:14 +0300
Subject: [PATCH] usb: typec: intel_pmc_mux: Add support for USB4

The PMC mux-agent can be used also when Enter_USB is used in
order to enter USB4 mode. The mux-agent does not have USB4
specific message, but instead needs to be put into TBT
alternate mode also with USB4. That is OK as the controller
is in any case the same with TBT3 and USB4.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/mux/intel_pmc_mux.c | 65 +++++++++++++++++++++++----
 1 file changed, 56 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
index 70ddc9d6d49e4..6d223bd360b8e 100644
--- a/drivers/usb/typec/mux/intel_pmc_mux.c
+++ b/drivers/usb/typec/mux/intel_pmc_mux.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
+#include <linux/usb/pd.h>
 #include <linux/usb/role.h>
 #include <linux/usb/typec_mux.h>
 #include <linux/usb/typec_dp.h>
@@ -227,6 +228,41 @@ pmc_usb_mux_tbt(struct pmc_usb_port *port, struct typec_mux_state *state)
 	return pmc_usb_command(port, (void *)&req, sizeof(req));
 }
 
+static int
+pmc_usb_mux_usb4(struct pmc_usb_port *port, struct typec_mux_state *state)
+{
+	u32 eudo = *(u32 *)state->data;
+	struct altmode_req req = { };
+	u8 cable_speed;
+
+	req.usage = PMC_USB_ALT_MODE;
+	req.usage |= port->usb3_port << PMC_USB_MSG_USB3_PORT_SHIFT;
+	req.mode_type = PMC_USB_MODE_TYPE_TBT << PMC_USB_MODE_TYPE_SHIFT;
+
+	/* USB4 Mode */
+	req.mode_data = PMC_USB_ALTMODE_FORCE_LSR;
+	req.mode_data |= PMC_USB_ALTMODE_ACTIVE_LINK;
+
+	req.mode_data |= (port->orientation - 1) << PMC_USB_ALTMODE_ORI_SHIFT;
+	req.mode_data |= (port->role - 1) << PMC_USB_ALTMODE_UFP_SHIFT;
+
+	switch ((eudo & EUDO_CABLE_TYPE_MASK) >> EUDO_CABLE_TYPE_SHIFT) {
+	case EUDO_CABLE_TYPE_PASSIVE:
+		break;
+	case EUDO_CABLE_TYPE_OPTICAL:
+		req.mode_data |= PMC_USB_ALTMODE_CABLE_TYPE;
+		/* fall through */
+	default:
+		req.mode_data |= PMC_USB_ALTMODE_ACTIVE_CABLE;
+		break;
+	}
+
+	cable_speed = (eudo & EUDO_CABLE_SPEED_MASK) >> EUDO_CABLE_SPEED_SHIFT;
+	req.mode_data |= PMC_USB_ALTMODE_CABLE_SPD(cable_speed);
+
+	return pmc_usb_command(port, (void *)&req, sizeof(req));
+}
+
 static int pmc_usb_mux_safe_state(struct pmc_usb_port *port)
 {
 	u8 msg;
@@ -268,17 +304,28 @@ pmc_usb_mux_set(struct typec_mux *mux, struct typec_mux_state *state)
 {
 	struct pmc_usb_port *port = typec_mux_get_drvdata(mux);
 
-	if (!state->alt)
-		return 0;
-
 	if (state->mode == TYPEC_STATE_SAFE)
 		return pmc_usb_mux_safe_state(port);
-
-	switch (state->alt->svid) {
-	case USB_TYPEC_TBT_SID:
-		return pmc_usb_mux_tbt(port, state);
-	case USB_TYPEC_DP_SID:
-		return pmc_usb_mux_dp(port, state);
+	if (state->mode == TYPEC_STATE_USB)
+		return pmc_usb_connect(port);
+
+	if (state->alt) {
+		switch (state->alt->svid) {
+		case USB_TYPEC_TBT_SID:
+			return pmc_usb_mux_tbt(port, state);
+		case USB_TYPEC_DP_SID:
+			return pmc_usb_mux_dp(port, state);
+		}
+	} else {
+		switch (state->mode) {
+		case TYPEC_MODE_USB2:
+			/* REVISIT: Try with usb3_port set to 0? */
+			break;
+		case TYPEC_MODE_USB3:
+			return pmc_usb_connect(port);
+		case TYPEC_MODE_USB4:
+			return pmc_usb_mux_usb4(port, state);
+		}
 	}
 
 	return -EOPNOTSUPP;
-- 
2.27.0


--O5XBE6gyVG5Rl6Rj--
