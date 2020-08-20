Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892D8C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F69E2072D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbgHTXiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 19:38:01 -0400
Received: from mga06.intel.com ([134.134.136.31]:59476 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728761AbgHTXhq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 19:37:46 -0400
IronPort-SDR: FY38Mt9ZZSISzRtbGh0ZqXcpcXyvYgHo2Fks5Wqj1VNU7cX610rZ3xn4fK4GQi5IcM3/JnZTnS
 3T0sfQkCDD1A==
X-IronPort-AV: E=McAfee;i="6000,8403,9719"; a="216963898"
X-IronPort-AV: E=Sophos;i="5.76,334,1592895600"; 
   d="scan'208";a="216963898"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2020 16:37:44 -0700
IronPort-SDR: E/OLbsukOGGNQKkhW06fqQ4S/Og05jVnbfJVu8hyLlorE5efD7Qw0Mj/q5TeMdTMDG8S3VQuAy
 p61FQTFmvsvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,334,1592895600"; 
   d="scan'208";a="311275122"
Received: from otc-chromeosbuild-1.jf.intel.com ([10.54.30.83])
  by orsmga002.jf.intel.com with ESMTP; 20 Aug 2020 16:37:43 -0700
From:   Azhar Shaikh <azhar.shaikh@intel.com>
To:     bleung@chromium.org, enric.balletbo@collabora.com,
        groeck@chromium.org, heikki.krogerus@linux.intel.com,
        pmalani@chromium.org
Cc:     linux-kernel@vger.kernel.org, azhar.shaikh@intel.com,
        rajmohan.mani@intel.com, utkarsh.h.patel@intel.com,
        casey.g.bowman@intel.com
Subject: [PATCH v4 1/3] platform/chrome: cros_ec_typec: Send enum values to usb_role_switch_set_role()
Date:   Thu, 20 Aug 2020 16:38:30 -0700
Message-Id: <20200820233833.4551-2-azhar.shaikh@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200820233833.4551-1-azhar.shaikh@intel.com>
References: <20200820233833.4551-1-azhar.shaikh@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

usb_role_switch_set_role() has the second argument as enum for usb_role.
Currently depending upon the data role i.e. UFP(0) or DFP(1) is sent.
This eventually translates to USB_ROLE_NONE in case of UFP and
USB_ROLE_DEVICE in case of DFP. Correct this by sending correct enum
values as USB_ROLE_DEVICE in case of UFP and USB_ROLE_HOST in case of
DFP.

Fixes: 7e7def15fa4b ("platform/chrome: cros_ec_typec: Add USB mux control")
Signed-off-by: Azhar Shaikh <azhar.shaikh@intel.com>
Cc: Prashant Malani <pmalani@chromium.org>
Reviewed-by: Prashant Malani <pmalani@chromium.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
Changes in v4:
 - Remove extra line between Fixes and Signed-off tag.
 - Added Reviewed-by and Cc tags from v1 and v2.

Changes in v3:
 - No changes

Changes in v2:
 - Update the commit message to change 'USB_ROLE_HOST in case of
    UFP.'  to 'USB_ROLE_HOST in case of DFP.'

 drivers/platform/chrome/cros_ec_typec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 3fcd27ec9ad8..06108212ee94 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -591,7 +591,8 @@ static int cros_typec_port_update(struct cros_typec_data *typec, int port_num)
 		dev_warn(typec->dev, "Configure muxes failed, err = %d\n", ret);
 
 	return usb_role_switch_set_role(typec->ports[port_num]->role_sw,
-					!!(resp.role & PD_CTRL_RESP_ROLE_DATA));
+				       resp.role & PD_CTRL_RESP_ROLE_DATA
+				       ? USB_ROLE_HOST : USB_ROLE_DEVICE);
 }
 
 static int cros_typec_get_cmd_version(struct cros_typec_data *typec)
-- 
2.17.1

