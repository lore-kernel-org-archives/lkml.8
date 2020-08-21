Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB12C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 21:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74FED207DA
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 21:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgHUVqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 17:46:37 -0400
Received: from mga17.intel.com ([192.55.52.151]:51130 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726641AbgHUVqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 17:46:36 -0400
IronPort-SDR: vn/WIBI9j4uCHLWPukKYsbdqHRg+VCMOLCh0EuxvFrvMftSzPfhLKM1t0TVqMT/0/LLunJRz3+
 29LU1NtgbH+Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9720"; a="135704248"
X-IronPort-AV: E=Sophos;i="5.76,338,1592895600"; 
   d="scan'208";a="135704248"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2020 14:46:34 -0700
IronPort-SDR: g2ub0X1JAGBxki1ddxvSzZhwsXKCJjWnlEVGiJGQ9AtCeeIk8OSC8haVnIONqg/SeEIp09W7EN
 Jn2jB7EqRicw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,338,1592895600"; 
   d="scan'208";a="372033689"
Received: from otc-chromeosbuild-1.jf.intel.com ([10.54.30.83])
  by orsmga001.jf.intel.com with ESMTP; 21 Aug 2020 14:46:34 -0700
From:   Azhar Shaikh <azhar.shaikh@intel.com>
To:     bleung@chromium.org, enric.balletbo@collabora.com,
        groeck@chromium.org, heikki.krogerus@linux.intel.com,
        pmalani@chromium.org
Cc:     linux-kernel@vger.kernel.org, azhar.shaikh@intel.com,
        rajmohan.mani@intel.com, utkarsh.h.patel@intel.com,
        casey.g.bowman@intel.com
Subject: [PATCH v5 2/3] platform/chrome: cros_ec_typec: Avoid setting usb role twice during disconnect
Date:   Fri, 21 Aug 2020 14:47:23 -0700
Message-Id: <20200821214724.20056-3-azhar.shaikh@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200821214724.20056-1-azhar.shaikh@intel.com>
References: <20200821214724.20056-1-azhar.shaikh@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On disconnect port partner is removed and usb role is set to NONE.
But then in cros_typec_port_update() the role is set again.
Avoid this by moving usb_role_switch_set_role() to
cros_typec_configure_mux().

Suggested-by: Prashant Malani <pmalani@chromium.org>
Signed-off-by: Azhar Shaikh <azhar.shaikh@intel.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
Changes in v5:
 - Rebased on top of https://lkml.org/lkml/2020/7/10/1063
 - Added Reviewed-by from v4

Changes in v4:
 - Added Suggested-by from v2.

Changes in v3:
 - Move the location of calling usb_role_switch_set_role() to
   end of function in cros_typec_configure_mux() to avoid any change
   in code flow.

Changes in v2:
 - New patch added
 drivers/platform/chrome/cros_ec_typec.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 739a1c846949..39989069decf 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -564,7 +564,12 @@ static int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
 		ret = -ENOTSUPP;
 	}
 
-	return ret;
+	if (ret)
+		return ret;
+
+	return usb_role_switch_set_role(typec->ports[port_num]->role_sw,
+					pd_ctrl->role & PD_CTRL_RESP_ROLE_DATA
+					? USB_ROLE_HOST : USB_ROLE_DEVICE);
 }
 
 static int cros_typec_port_update(struct cros_typec_data *typec, int port_num)
@@ -621,9 +626,7 @@ static int cros_typec_port_update(struct cros_typec_data *typec, int port_num)
 	if (ret)
 		dev_warn(typec->dev, "Configure muxes failed, err = %d\n", ret);
 
-	return usb_role_switch_set_role(typec->ports[port_num]->role_sw,
-					resp.role & PD_CTRL_RESP_ROLE_DATA
-					? USB_ROLE_HOST : USB_ROLE_DEVICE);
+	return ret;
 }
 
 static int cros_typec_get_cmd_version(struct cros_typec_data *typec)
-- 
2.17.1

