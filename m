Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC6CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 22:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80F672083B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 22:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730624AbgG3Wzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 18:55:49 -0400
Received: from mga14.intel.com ([192.55.52.115]:45564 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729995AbgG3Wzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 18:55:42 -0400
IronPort-SDR: uAJkNBziQkcgufPec5JC2DybvGwYBcGVAhi8XKuOsxsQR9ES0xq+UmdMMoHc5uPqsdi3kX/fOC
 Eg36bcmcdPwg==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="150902159"
X-IronPort-AV: E=Sophos;i="5.75,415,1589266800"; 
   d="scan'208";a="150902159"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2020 15:55:41 -0700
IronPort-SDR: nQTTPm5nWtMCFgfj9n++aLnBNQV58b/0mlVTTCbzvPA3MC3WUoQcbmEfcMbfim4mcxDGfVCUdS
 pxbKNKV2kWyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,415,1589266800"; 
   d="scan'208";a="273056534"
Received: from otc-chromeosbuild-1.jf.intel.com ([10.54.30.83])
  by fmsmga007.fm.intel.com with ESMTP; 30 Jul 2020 15:55:41 -0700
From:   Azhar Shaikh <azhar.shaikh@intel.com>
To:     bleung@chromium.org, enric.balletbo@collabora.com,
        groeck@chromium.org, pmalani@chromium.org,
        linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com, azhar.shaikh@intel.com,
        utkarsh.h.patel@intel.com, casey.g.bowman@intel.com,
        rajmohan.mani@intel.com
Subject: [PATCH v2 2/2] platform/chrome: cros_ec_typec: Avoid setting usb role  during disconnect
Date:   Thu, 30 Jul 2020 15:56:09 -0700
Message-Id: <20200730225609.7395-3-azhar.shaikh@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200730225609.7395-1-azhar.shaikh@intel.com>
References: <20200730225609.7395-1-azhar.shaikh@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On disconnect port partner is removed and usb role is set to NONE.
But then in cros_typec_port_update() the role is set again.
Avoid this by moving usb_role_switch_set_role() to
cros_typec_configure_mux().

Signed-off-by: Azhar Shaikh <azhar.shaikh@intel.com>
Suggested-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_ec_typec.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index eb4713b7ae14..df97431b2275 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -515,6 +515,12 @@ static int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
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
@@ -589,9 +595,7 @@ static int cros_typec_port_update(struct cros_typec_data *typec, int port_num)
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

