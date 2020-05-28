Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBD2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 11:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 302FD20888
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 11:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IxfUZLLN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388466AbgE1LhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 07:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388380AbgE1LhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 07:37:05 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB7CC05BD1E
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 04:37:04 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id ci21so3093602pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 04:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cQR/AFADvKzFQ5zPDPrctZCZvisL2dMY80QDnYNsBdk=;
        b=IxfUZLLN7yTXpR2xpyScrmgu8PBrWurDghpgDGf1tCMGldMx8ko2GCQhzpoVSdh2uZ
         7wCeyuRkYXn/LStXErarw7F24qtO+waR/JUaNk15cbhzzHjYUHoV/qOrfzOoK9lzHrQ/
         ML3DhunUtiU216SHX/1jYL6nSmCUWIGC2spe0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cQR/AFADvKzFQ5zPDPrctZCZvisL2dMY80QDnYNsBdk=;
        b=QhuyqQlfTYrFJA5zy/30x16brdM8m+xiyQKhCbImbJCqiLsGn4naoTiGh/MmN/k34O
         m96x7icnjADjU7k95nZxt80V2EseCJS/WGCKKsyK46DRULhm3c0gbzEIBirXeI6D5RJd
         QP4pZ4T9drQmh0Gd+Gy+XiUFX16rIDoeu7JpAX7VkHPe/SYXWL3a241AwsjU5qcyHVaH
         vz2/UZPTKY/xpxkss3Xrbh3Tio0fmFCNiFvE03OxE6IOCJRoTjpF5lgF5e/cVXyFWnzR
         +4xeP9qtr4wQbv7rfx1VuIOOqucKmET9OzX5Ms6EhrIkOQJgTF0I+Wm1iPoeI+1xw3uB
         BPNQ==
X-Gm-Message-State: AOAM5325SELMLu35llfhy34Iwgys11P2c/kdmf5e/x/EI4m0O3yVv3J8
        1w5YYuEHxFnQJFIwscugsb2C6xz9ERY=
X-Google-Smtp-Source: ABdhPJzJXz4P4ya4RnXHQgQmgzU5LVDQtiQKQhNbj+Ak1xLwCJVnQr64MWpZ4T7ZwMgQcgFc/Q8gJQ==
X-Received: by 2002:a17:902:7203:: with SMTP id ba3mr2992897plb.202.1590665823859;
        Thu, 28 May 2020 04:37:03 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id g7sm4519961pjs.48.2020.05.28.04.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 04:37:03 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH 3/4] platform/chrome: typec: Add USB mux control
Date:   Thu, 28 May 2020 04:36:07 -0700
Message-Id: <20200528113607.120841-4-pmalani@chromium.org>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
In-Reply-To: <20200528113607.120841-1-pmalani@chromium.org>
References: <20200528113607.120841-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to configure various Type C switches appropriately using the
Type C connector class API, when the Chrome OS EC informs the AP that
the USB operating mode has been entered.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_ec_typec.c | 100 +++++++++++++++++++++++-
 1 file changed, 97 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index d69a88464cef..9ebf9abed16f 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -14,6 +14,7 @@
 #include <linux/platform_data/cros_usbpd_notify.h>
 #include <linux/platform_device.h>
 #include <linux/usb/typec.h>
+#include <linux/usb/typec_altmode.h>
 #include <linux/usb/typec_mux.h>
 #include <linux/usb/role.h>
 
@@ -30,6 +31,10 @@ struct cros_typec_port {
 	struct typec_switch *ori_sw;
 	struct typec_mux *mux;
 	struct usb_role_switch *role_sw;
+
+	/* Variables keeping track of switch state. */
+	struct typec_mux_state state;
+	uint8_t mux_flags;
 };
 
 /* Platform-specific data for the Chrome OS EC Type C controller. */
@@ -264,6 +269,23 @@ static int cros_typec_add_partner(struct cros_typec_data *typec, int port_num,
 	return ret;
 }
 
+static void cros_typec_remove_partner(struct cros_typec_data *typec,
+				     int port_num)
+{
+	struct cros_typec_port *port = typec->ports[port_num];
+
+	port->state.alt = NULL;
+	port->state.mode = TYPEC_STATE_USB;
+	port->state.data = NULL;
+
+	usb_role_switch_set_role(port->role_sw, USB_ROLE_NONE);
+	typec_switch_set(port->ori_sw, TYPEC_ORIENTATION_NONE);
+	typec_mux_set(port->mux, &port->state);
+
+	typec_unregister_partner(port->partner);
+	port->partner = NULL;
+}
+
 static void cros_typec_set_port_params_v0(struct cros_typec_data *typec,
 		int port_num, struct ec_response_usb_pd_control *resp)
 {
@@ -317,16 +339,69 @@ static void cros_typec_set_port_params_v1(struct cros_typec_data *typec,
 	} else {
 		if (!typec->ports[port_num]->partner)
 			return;
+		cros_typec_remove_partner(typec, port_num);
+	}
+}
+
+static int cros_typec_get_mux_info(struct cros_typec_data *typec, int port_num,
+				   struct ec_response_usb_pd_mux_info *resp)
+{
+	struct ec_params_usb_pd_mux_info req = {
+		.port = port_num,
+	};
+
+	return cros_typec_ec_command(typec, 0, EC_CMD_USB_PD_MUX_INFO, &req,
+				     sizeof(req), resp, sizeof(*resp));
+}
+
+static int cros_typec_usb_safe_state(struct cros_typec_port *port)
+{
+	port->state.mode = TYPEC_STATE_SAFE;
+
+	return typec_mux_set(port->mux, &port->state);
+}
 
-		typec_unregister_partner(typec->ports[port_num]->partner);
-		typec->ports[port_num]->partner = NULL;
+int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
+			     uint8_t mux_flags)
+{
+	struct cros_typec_port *port = typec->ports[port_num];
+	enum typec_orientation orientation;
+	int ret;
+
+	if (!port->partner)
+		return 0;
+
+	if (mux_flags & USB_PD_MUX_POLARITY_INVERTED)
+		orientation = TYPEC_ORIENTATION_REVERSE;
+	else
+		orientation = TYPEC_ORIENTATION_NORMAL;
+
+	ret = typec_switch_set(port->ori_sw, orientation);
+	if (ret)
+		return ret;
+
+	port->state.alt = NULL;
+	port->state.mode = TYPEC_STATE_USB;
+
+	if (mux_flags & USB_PD_MUX_SAFE_MODE)
+		ret = cros_typec_usb_safe_state(port);
+	else if (mux_flags & USB_PD_MUX_USB_ENABLED)
+		ret = typec_mux_set(port->mux, &port->state);
+	else {
+		dev_info(typec->dev,
+			 "Unsupported mode requested, mux flags: %x\n",
+			 mux_flags);
+		ret = -ENOTSUPP;
 	}
+
+	return ret;
 }
 
 static int cros_typec_port_update(struct cros_typec_data *typec, int port_num)
 {
 	struct ec_params_usb_pd_control req;
 	struct ec_response_usb_pd_control_v1 resp;
+	struct ec_response_usb_pd_mux_info mux_resp;
 	int ret;
 
 	if (port_num < 0 || port_num >= typec->num_ports) {
@@ -357,7 +432,26 @@ static int cros_typec_port_update(struct cros_typec_data *typec, int port_num)
 		cros_typec_set_port_params_v0(typec, port_num,
 			(struct ec_response_usb_pd_control *) &resp);
 
-	return 0;
+	/* Update the switches if they exist, according to requested state */
+	ret = cros_typec_get_mux_info(typec, port_num, &mux_resp);
+	if (ret < 0) {
+		dev_warn(typec->dev,
+			 "Failed to get mux info for port: %d, err = %d\n",
+			 port_num, ret);
+		return 0;
+	}
+
+	/* No change needs to be made, let's exit early. */
+	if (typec->ports[port_num]->mux_flags == mux_resp.flags)
+		return 0;
+
+	typec->ports[port_num]->mux_flags = mux_resp.flags;
+	ret = cros_typec_configure_mux(typec, port_num, mux_resp.flags);
+	if (ret)
+		dev_warn(typec->dev, "Configure muxes failed, err = %d\n", ret);
+
+	return usb_role_switch_set_role(typec->ports[port_num]->role_sw,
+					!!(resp.role & PD_CTRL_RESP_ROLE_DATA));
 }
 
 static int cros_typec_get_cmd_version(struct cros_typec_data *typec)
-- 
2.27.0.rc0.183.gde8f92d652-goog

