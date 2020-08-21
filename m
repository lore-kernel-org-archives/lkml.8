Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A720C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 21:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39533207DA
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 21:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgHUVqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 17:46:43 -0400
Received: from mga17.intel.com ([192.55.52.151]:51124 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726758AbgHUVqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 17:46:37 -0400
IronPort-SDR: 3Ehl7cpTqDqGxosZnfueHHurIaaxSPkRJh+yZQo4y1MIjMdzYV2a6RYSteBJf/d6R+JnAY5ps7
 Q+FY9cOQLDWg==
X-IronPort-AV: E=McAfee;i="6000,8403,9720"; a="135704251"
X-IronPort-AV: E=Sophos;i="5.76,338,1592895600"; 
   d="scan'208";a="135704251"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2020 14:46:35 -0700
IronPort-SDR: UwR2SCqP0EkmvCTIPu9gVUEdzYnbMbKyGn3M2NLX44Eg8oGLr26MXgLmmtR7Q/uplAvahpu5p4
 vtQy75L/ilkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,338,1592895600"; 
   d="scan'208";a="372033692"
Received: from otc-chromeosbuild-1.jf.intel.com ([10.54.30.83])
  by orsmga001.jf.intel.com with ESMTP; 21 Aug 2020 14:46:34 -0700
From:   Azhar Shaikh <azhar.shaikh@intel.com>
To:     bleung@chromium.org, enric.balletbo@collabora.com,
        groeck@chromium.org, heikki.krogerus@linux.intel.com,
        pmalani@chromium.org
Cc:     linux-kernel@vger.kernel.org, azhar.shaikh@intel.com,
        rajmohan.mani@intel.com, utkarsh.h.patel@intel.com,
        casey.g.bowman@intel.com
Subject: [PATCH v5 3/3] platform/chrome: cros_ec_typec: Re-order connector configuration steps
Date:   Fri, 21 Aug 2020 14:47:24 -0700
Message-Id: <20200821214724.20056-4-azhar.shaikh@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200821214724.20056-1-azhar.shaikh@intel.com>
References: <20200821214724.20056-1-azhar.shaikh@intel.com>
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
Reviewed-by: Prashant Malani <pmalani@chromium.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
Changes in v5:
 - Rebased on top of https://lkml.org/lkml/2020/7/10/1063
 - Added Reviewed-by from v4

Changes in v4:
 - No change

Changes in v3:
 - New patch added

 drivers/platform/chrome/cros_ec_typec.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 39989069decf..31be31161350 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -545,6 +545,12 @@ static int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
 	if (ret)
 		return ret;
 
+	ret = usb_role_switch_set_role(typec->ports[port_num]->role_sw,
+					pd_ctrl->role & PD_CTRL_RESP_ROLE_DATA
+					? USB_ROLE_HOST : USB_ROLE_DEVICE);
+	if (ret)
+		return ret;
+
 	if (mux_flags & USB_PD_MUX_USB4_ENABLED) {
 		ret = cros_typec_enable_usb4(typec, port_num, pd_ctrl);
 	} else if (mux_flags & USB_PD_MUX_TBT_COMPAT_ENABLED) {
@@ -564,12 +570,7 @@ static int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
 		ret = -ENOTSUPP;
 	}
 
-	if (ret)
-		return ret;
-
-	return usb_role_switch_set_role(typec->ports[port_num]->role_sw,
-					pd_ctrl->role & PD_CTRL_RESP_ROLE_DATA
-					? USB_ROLE_HOST : USB_ROLE_DEVICE);
+	return ret;
 }
 
 static int cros_typec_port_update(struct cros_typec_data *typec, int port_num)
-- 
2.17.1

