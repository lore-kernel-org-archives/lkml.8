Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE91BC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC7842072D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728866AbgHTXht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 19:37:49 -0400
Received: from mga06.intel.com ([134.134.136.31]:59474 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728498AbgHTXho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 19:37:44 -0400
IronPort-SDR: wJN7o5fsn5e1IR35057zxjc/9TOG5ZRO+Nw0n/E7SzVgVKaFbJsjPOBk4tgSYGMh2oy+k8lUce
 6ekzn6pXJ7gg==
X-IronPort-AV: E=McAfee;i="6000,8403,9719"; a="216963899"
X-IronPort-AV: E=Sophos;i="5.76,334,1592895600"; 
   d="scan'208";a="216963899"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2020 16:37:44 -0700
IronPort-SDR: 6sEYBI0Xq78caTmeJQmAz9wAev8Lh3d7UN/5Iv8VoqCosZPTAa7M+TlfLg1P2DyN+mTLwGim3y
 kCpRWo/jlLRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,334,1592895600"; 
   d="scan'208";a="311275127"
Received: from otc-chromeosbuild-1.jf.intel.com ([10.54.30.83])
  by orsmga002.jf.intel.com with ESMTP; 20 Aug 2020 16:37:43 -0700
From:   Azhar Shaikh <azhar.shaikh@intel.com>
To:     bleung@chromium.org, enric.balletbo@collabora.com,
        groeck@chromium.org, heikki.krogerus@linux.intel.com,
        pmalani@chromium.org
Cc:     linux-kernel@vger.kernel.org, azhar.shaikh@intel.com,
        rajmohan.mani@intel.com, utkarsh.h.patel@intel.com,
        casey.g.bowman@intel.com
Subject: [PATCH v4 3/3] platform/chrome: cros_ec_typec: Re-order connector configuration steps
Date:   Thu, 20 Aug 2020 16:38:32 -0700
Message-Id: <20200820233833.4551-4-azhar.shaikh@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200820233833.4551-1-azhar.shaikh@intel.com>
References: <20200820233833.4551-1-azhar.shaikh@intel.com>
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
Changes in v4:
 - No change

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

