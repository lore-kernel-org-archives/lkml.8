Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41691C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 08:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13E1320874
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 08:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OAfQzlHd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390367AbgFXIJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 04:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388818AbgFXIJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 04:09:47 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B60C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 01:09:47 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id f3so1066183pgr.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 01:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lx3+rjSQbLbRJPU2K3t48ZInyGLE+ZxpuayNrn61Xdw=;
        b=OAfQzlHdtGcAdYG+BtkF6ilyGgwXF3ojFfUp2Dz7zHhHddqSyieZaeC8Lg727lcRRt
         xdGhSB6dAPxNw+r181i4E2wpmmhVMJxXz4bqeLJ+N+chgeK8qoyZBTnwmKrW24HmeLcF
         7gtP3RJw2HO5NZU5ZCiSz230WzT8bgD2O2O+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lx3+rjSQbLbRJPU2K3t48ZInyGLE+ZxpuayNrn61Xdw=;
        b=k1R8ckMFpDs8scKFwFL1ldcyFqR9nKnvgIhsXhxtF3+qyz5pAS6IYdlBeV5L+gUtqo
         xglYpb5MW8OrzLco+9WunkxkxYMAAmfIVmUzfj6BBvYAV1g1iYbD2zvgNJROMI+YVCoE
         2knWajJoHJNu39S91RZ0TyS3P0BqITA9fVgS6jA1/3eWzcK8ESRcNHXBuBE9H0+Q/KSm
         AOHsYaMpXE9kI1y0QKXbsyVs0alFsrhH6KN+zlx2J2EUXiCt7ZPnxXXYtofCbp0DVV2u
         cPQNSf1cbnKtx7+gadgKha7cPen6ZMFzFbdQhG8vYNwJbrYTAjmh9C0svDVlU7dPVtlV
         d61A==
X-Gm-Message-State: AOAM532kOe8AGstXBQ6VcNpjLh5Al0xkLMmdkBke5vjaHWy1M9/5bj1o
        t+Ejf7cY/khhI8Qfbr9bhEaHR2PGn3M=
X-Google-Smtp-Source: ABdhPJwUoL/Yfyg4P84ucl0lZGitaZNZEFC/juD9lSdSZjf0UcmkDbGcjvavUJ4bAgIbYMxto36WVQ==
X-Received: by 2002:a62:a20e:: with SMTP id m14mr27300666pff.249.1592986186674;
        Wed, 24 Jun 2020 01:09:46 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id r1sm4421684pjd.47.2020.06.24.01.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 01:09:46 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        Azhar Shaikh <azhar.shaikh@intel.com>,
        Casey Bowman <casey.g.bowman@intel.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Yicheng Li <yichengli@chromium.org>
Subject: [PATCH 2/2] platform/chrome: cros_ec_typec: Add TBT compat support
Date:   Wed, 24 Jun 2020 01:09:24 -0700
Message-Id: <20200624080926.165107-2-pmalani@chromium.org>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
In-Reply-To: <20200624080926.165107-1-pmalani@chromium.org>
References: <20200624080926.165107-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mux control support for Thunderbolt compatibility mode.

Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Co-developed-by: Azhar Shaikh <azhar.shaikh@intel.com>
Co-developed-by: Casey Bowman <casey.g.bowman@intel.com>
Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_ec_typec.c | 70 ++++++++++++++++++++++++-
 1 file changed, 69 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 1df1386f32e4..0c041b79cbba 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -17,6 +17,7 @@
 #include <linux/usb/typec_altmode.h>
 #include <linux/usb/typec_dp.h>
 #include <linux/usb/typec_mux.h>
+#include <linux/usb/typec_tbt.h>
 #include <linux/usb/role.h>
 
 #define DRV_NAME "cros-ec-typec"
@@ -24,6 +25,7 @@
 /* Supported alt modes. */
 enum {
 	CROS_EC_ALTMODE_DP = 0,
+	CROS_EC_ALTMODE_TBT,
 	CROS_EC_ALTMODE_MAX,
 };
 
@@ -165,6 +167,14 @@ static void cros_typec_register_port_altmodes(struct cros_typec_data *typec,
 	port->p_altmode[CROS_EC_ALTMODE_DP].svid = USB_TYPEC_DP_SID;
 	port->p_altmode[CROS_EC_ALTMODE_DP].mode = USB_TYPEC_DP_MODE;
 
+	/*
+	 * Register TBT compatibility alt mode. The EC will not enter the mode
+	 * if it doesn't support it, so it's safe to register it unconditionally
+	 * here for now.
+	 */
+	port->p_altmode[CROS_EC_ALTMODE_TBT].svid = USB_TYPEC_TBT_SID;
+	port->p_altmode[CROS_EC_ALTMODE_TBT].mode = TYPEC_ANY_MODE;
+
 	port->state.alt = NULL;
 	port->state.mode = TYPEC_STATE_USB;
 	port->state.data = NULL;
@@ -391,6 +401,62 @@ static int cros_typec_usb_safe_state(struct cros_typec_port *port)
 	return typec_mux_set(port->mux, &port->state);
 }
 
+/*
+ * Spoof the VDOs that were likely communicated by the partner for TBT alt
+ * mode.
+ */
+static int cros_typec_enable_tbt(struct cros_typec_data *typec,
+				 int port_num,
+				 struct ec_response_usb_pd_control_v2 *pd_ctrl)
+{
+	struct cros_typec_port *port = typec->ports[port_num];
+	struct typec_thunderbolt_data data;
+	int ret;
+
+	if (typec->pd_ctrl_ver < 2) {
+		dev_err(typec->dev,
+			"PD_CTRL version too old: %d\n", typec->pd_ctrl_ver);
+		return -ENOTSUPP;
+	}
+
+	/* Device Discover Mode VDO */
+	data.device_mode = TBT_MODE;
+
+	if (pd_ctrl->control_flags & USB_PD_CTRL_TBT_LEGACY_ADAPTER)
+		data.device_mode = TBT_SET_ADAPTER(TBT_ADAPTER_TBT3);
+
+	/* Cable Discover Mode VDO */
+	data.cable_mode = TBT_MODE;
+	data.cable_mode |= TBT_SET_CABLE_SPEED(pd_ctrl->cable_speed);
+
+	if (pd_ctrl->control_flags & USB_PD_CTRL_OPTICAL_CABLE)
+		data.cable_mode |= TBT_CABLE_OPTICAL;
+
+	if (pd_ctrl->control_flags & USB_PD_CTRL_ACTIVE_LINK_UNIDIR)
+		data.cable_mode |= TBT_CABLE_LINK_TRAINING;
+
+	if (pd_ctrl->cable_gen)
+		data.cable_mode |= TBT_CABLE_ROUNDED;
+
+	/* Enter Mode VDO */
+	data.enter_vdo = TBT_SET_CABLE_SPEED(pd_ctrl->cable_speed);
+
+	if (pd_ctrl->control_flags & USB_PD_CTRL_ACTIVE_CABLE)
+		data.enter_vdo |= TBT_ENTER_MODE_ACTIVE_CABLE;
+
+	if (!port->state.alt) {
+		port->state.alt = &port->p_altmode[CROS_EC_ALTMODE_TBT];
+		ret = cros_typec_usb_safe_state(port);
+		if (ret)
+			return ret;
+	}
+
+	port->state.data = &data;
+	port->state.mode = TYPEC_TBT_MODE;
+
+	return typec_mux_set(port->mux, &port->state);
+}
+
 /* Spoof the VDOs that were likely communicated by the partner. */
 static int cros_typec_enable_dp(struct cros_typec_data *typec,
 				int port_num,
@@ -448,7 +514,9 @@ static int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
 	if (ret)
 		return ret;
 
-	if (mux_flags & USB_PD_MUX_DP_ENABLED) {
+	if (mux_flags & USB_PD_MUX_TBT_COMPAT_ENABLED) {
+		ret = cros_typec_enable_tbt(typec, port_num, pd_ctrl);
+	} else if (mux_flags & USB_PD_MUX_DP_ENABLED) {
 		ret = cros_typec_enable_dp(typec, port_num, pd_ctrl);
 	} else if (mux_flags & USB_PD_MUX_SAFE_MODE) {
 		ret = cros_typec_usb_safe_state(port);
-- 
2.27.0.111.gc72c7da667-goog

