Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36EE1C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1996F2072D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbgHTXiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 19:38:03 -0400
Received: from mga06.intel.com ([134.134.136.31]:59474 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728746AbgHTXhq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 19:37:46 -0400
IronPort-SDR: uU9m5kKIsPMCZRF/Lta/XAlUe/YHRCxV9R1x3Ibsp7FhLBl2aXb7l7NtNhDbvzYej7kkBkFAiE
 27GYFqJrbHUg==
X-IronPort-AV: E=McAfee;i="6000,8403,9719"; a="216963900"
X-IronPort-AV: E=Sophos;i="5.76,334,1592895600"; 
   d="scan'208";a="216963900"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2020 16:37:44 -0700
IronPort-SDR: izaF4LLl5iO42fLOiOU0A4e7BaZu1TtfwqflaPJwyBEKCIVe9wyxGxZNqouCcWpoJLdUPuy4NG
 k6fIQxdkKmvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,334,1592895600"; 
   d="scan'208";a="311275125"
Received: from otc-chromeosbuild-1.jf.intel.com ([10.54.30.83])
  by orsmga002.jf.intel.com with ESMTP; 20 Aug 2020 16:37:43 -0700
From:   Azhar Shaikh <azhar.shaikh@intel.com>
To:     bleung@chromium.org, enric.balletbo@collabora.com,
        groeck@chromium.org, heikki.krogerus@linux.intel.com,
        pmalani@chromium.org
Cc:     linux-kernel@vger.kernel.org, azhar.shaikh@intel.com,
        rajmohan.mani@intel.com, utkarsh.h.patel@intel.com,
        casey.g.bowman@intel.com
Subject: [PATCH v4 2/3] platform/chrome: cros_ec_typec: Avoid setting usb role twice during disconnect
Date:   Thu, 20 Aug 2020 16:38:31 -0700
Message-Id: <20200820233833.4551-3-azhar.shaikh@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200820233833.4551-1-azhar.shaikh@intel.com>
References: <20200820233833.4551-1-azhar.shaikh@intel.com>
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
---
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
index 06108212ee94..2b43e1176e73 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -533,7 +533,12 @@ static int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
 		ret = -ENOTSUPP;
 	}
 
-	return ret;
+	if (ret)
+		return ret;
+
+	return usb_role_switch_set_role(typec->ports[port_num]->role_sw,
+				       pd_ctrl->role & PD_CTRL_RESP_ROLE_DATA
+				       ? USB_ROLE_HOST : USB_ROLE_DEVICE);
 }
 
 static int cros_typec_port_update(struct cros_typec_data *typec, int port_num)
@@ -590,9 +595,7 @@ static int cros_typec_port_update(struct cros_typec_data *typec, int port_num)
 	if (ret)
 		dev_warn(typec->dev, "Configure muxes failed, err = %d\n", ret);
 
-	return usb_role_switch_set_role(typec->ports[port_num]->role_sw,
-				       resp.role & PD_CTRL_RESP_ROLE_DATA
-				       ? USB_ROLE_HOST : USB_ROLE_DEVICE);
+	return ret;
 }
 
 static int cros_typec_get_cmd_version(struct cros_typec_data *typec)
-- 
2.17.1

