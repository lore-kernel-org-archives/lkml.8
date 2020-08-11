Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2536CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 19:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B88C206B2
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 19:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgHKThW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 15:37:22 -0400
Received: from mga17.intel.com ([192.55.52.151]:10833 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbgHKThT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 15:37:19 -0400
IronPort-SDR: K/xLrFbCJl5agK5O8D84RsLdFDX50S1eYTWHKtnqfLvbwh/tRL3S3vfl3L/mRprEFQBQoTMW+M
 /QzkojzoqlZg==
X-IronPort-AV: E=McAfee;i="6000,8403,9710"; a="133871957"
X-IronPort-AV: E=Sophos;i="5.76,301,1592895600"; 
   d="scan'208";a="133871957"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2020 12:37:19 -0700
IronPort-SDR: QQrvg9dp/N7BoRqNakMO+bwbI3GI1uZ6zc8arZy8bUf5hIGdOfA79/z7ewGaCyRTZkRPEeltKQ
 U9JUeAf9t4uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,301,1592895600"; 
   d="scan'208";a="317840443"
Received: from otc-chromeosbuild-1.jf.intel.com ([10.54.30.83])
  by fmsmga004.fm.intel.com with ESMTP; 11 Aug 2020 12:37:18 -0700
From:   Azhar Shaikh <azhar.shaikh@intel.com>
To:     bleung@chromium.org, enric.balletbo@collabora.com,
        groeck@chromium.org, heikki.krogerus@linux.intel.com,
        pmalani@chromium.org
Cc:     linux-kernel@vger.kernel.org, azhar.shaikh@intel.com,
        rajmohan.mani@intel.com, utkarsh.h.patel@intel.com,
        casey.g.bowman@intel.com
Subject: [PATCH v3 3/3] platform/chrome: cros_ec_typec: Re-order connector configuration steps
Date:   Tue, 11 Aug 2020 12:37:57 -0700
Message-Id: <20200811193757.45057-4-azhar.shaikh@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200811193757.45057-1-azhar.shaikh@intel.com>
References: <20200811193757.45057-1-azhar.shaikh@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per USB Type-C Spec R2.0 section 4.5.1.2 (Connecting Sources and Sinks)
and section 4.5.2.2 (Connection State Machine Requirements), the typical
flow for configuring a device connected to a typeC port is as below:

1. Source/sink detection
2. Orientation
3. Data role
4. VCONN
5. VBUS (USB Type-C currents)
6. The connector is now configured. We can start the PD communication
   that should lead into configuration of the mux if we enter a mode.

But in existing code data role was set after the connector and mux are
already configured. So fix this by following the spec to set the data
role before the connector and mux are configured.

Signed-off-by: Azhar Shaikh <azhar.shaikh@intel.com>
---
Changes in v3:
 - New patch added

 drivers/platform/chrome/cros_ec_typec.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 2b43e1176e73..9e4fad9ca59e 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -516,6 +516,12 @@ static int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
 	if (ret)
 		return ret;
 
+	ret = usb_role_switch_set_role(typec->ports[port_num]->role_sw,
+				       pd_ctrl->role & PD_CTRL_RESP_ROLE_DATA
+				       ? USB_ROLE_HOST : USB_ROLE_DEVICE);
+	if (ret)
+		return ret;
+
 	if (mux_flags & USB_PD_MUX_TBT_COMPAT_ENABLED) {
 		ret = cros_typec_enable_tbt(typec, port_num, pd_ctrl);
 	} else if (mux_flags & USB_PD_MUX_DP_ENABLED) {
@@ -533,12 +539,7 @@ static int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
 		ret = -ENOTSUPP;
 	}
 
-	if (ret)
-		return ret;
-
-	return usb_role_switch_set_role(typec->ports[port_num]->role_sw,
-				       pd_ctrl->role & PD_CTRL_RESP_ROLE_DATA
-				       ? USB_ROLE_HOST : USB_ROLE_DEVICE);
+	return ret;
 }
 
 static int cros_typec_port_update(struct cros_typec_data *typec, int port_num)
-- 
2.17.1

