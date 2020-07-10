Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456AAC433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 19:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11CF7206C3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 19:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Dc5a20YR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbgGJTka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 15:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbgGJTka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 15:40:30 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8DBC08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 12:40:30 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id b92so3036178pjc.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 12:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xViBTlv9cSoxxlcOtJ3GbtHVyweRCXfn0dWGulD2yKY=;
        b=Dc5a20YRN25bSCamOxJU2/YZhDhvasjQGjQvtSknIWDQDKYJ2FtYiWNrgDIdpGG/TN
         /eHR8897jGCDqVU03FQ5/YKPC14TYaupxdXsKb0oQeWwI+9y/tHaddKW6JgWJO1DxYiw
         FnWkoxj/E7r52WCaRng9QkkE0AUbYNTtaKQLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xViBTlv9cSoxxlcOtJ3GbtHVyweRCXfn0dWGulD2yKY=;
        b=lrKdUihh5XjnGnroS5J++ZMWWda3P4nionrJKbucn+fomrPrhn7qw8fDDzQMojqJjN
         cCM4U499JOiBQj8fzlMAkIBL4ZmQ0ACBAHfTcrI7B93WyosWGZr/LMO4mw0dRzw4i93M
         iT0ZTdhMc5LopV+5mNVzUbpryQ/uMe9rVCd+f+HvLosb9SsXCjs6/ayPvqSi8AgXM8d0
         +afJWlxytstzLNacWN561wworpu8WedWb6YWT3XQE0UOL9jKdTwgZcArHERxEFuwMYfQ
         Ppr31HrJU6ccSPGUbdfsPx/SHglM30dW+g+n+FdcLIo9nG/s5FPSGd063kGcgfBZI/R7
         Gf9Q==
X-Gm-Message-State: AOAM531XQMr1avc0HcJ3CgJljNyLKQF4Sw8hZKFF1zV+fgIHmy2pqG5B
        Fu2r0rt9B64OxwTwhjq2XJFzDqu0tAo=
X-Google-Smtp-Source: ABdhPJysro8RMzbm1UHy2FSuzcgSyEneB6jUV1oe7UEMoN+NfD3TN3IQvnDDzA7ff1n/8svfZJyq5A==
X-Received: by 2002:a17:902:6b45:: with SMTP id g5mr12137494plt.42.1594410029166;
        Fri, 10 Jul 2020 12:40:29 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([100.99.132.145])
        by smtp.gmail.com with ESMTPSA id m68sm6669845pje.24.2020.07.10.12.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 12:40:28 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     rajmohan.mani@intel.com,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH v2] platform/chrome: cros_ec_typec: USB4 support
Date:   Fri, 10 Jul 2020 12:40:17 -0700
Message-Id: <20200710194017.1126000-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

With USB4 mode the mux driver needs the Enter_USB Data
Object (EUDO) that was used when the USB mode was entered.
Though the object is not available in the driver, it is
possible to construct it from the information we have.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

This patch depends on latest usb-next from Greg KH, this commit in
particular:
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/commit/?h=usb-next&id=ad8db94d6813dc659bd4de0531a8a1150559eafb

Changes in v2:
- Removed EUDO bits for cable current and tunneling support.

 drivers/platform/chrome/cros_ec_typec.c | 33 ++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 0c041b79cbba..a9700275a851 100644
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
@@ -494,6 +495,34 @@ static int cros_typec_enable_dp(struct cros_typec_data *typec,
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
@@ -514,7 +543,9 @@ static int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
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
2.27.0.383.g050319c2ae-goog

