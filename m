Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5739C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 22:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9932120829
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 22:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730481AbgG3Wwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 18:52:31 -0400
Received: from mga14.intel.com ([192.55.52.115]:45264 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729995AbgG3Wwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 18:52:30 -0400
IronPort-SDR: uFtuHiCl+CTnE2/iaRYYDXOZZ4MHQODxJlXtuIzoKD20+0YvfTQmmaA9ul8YNPzt28iSc6bUz6
 +1q9aWRLTNiQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="150901952"
X-IronPort-AV: E=Sophos;i="5.75,415,1589266800"; 
   d="scan'208";a="150901952"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2020 15:52:29 -0700
IronPort-SDR: PKaCNUZl0mAhPLZfpP8lofzuq7CleIQxcu9QD4j2OpfWOPQzjU0CbqtZOVXH5zqZVd08NMTQCJ
 U2JXQLJzSJhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,415,1589266800"; 
   d="scan'208";a="323056395"
Received: from otc-chromeosbuild-1.jf.intel.com ([10.54.30.83])
  by fmsmga002.fm.intel.com with ESMTP; 30 Jul 2020 15:52:29 -0700
From:   Azhar Shaikh <azhar.shaikh@intel.com>
To:     bleung@chromium.org, enric.balletbo@collabora.com,
        groeck@chromium.org, pmalani@chromium.org,
        linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com, azhar.shaikh@intel.com,
        utkarsh.h.patel@intel.com, casey.g.bowman@intel.com,
        rajmohan.mani@intel.com
Subject: [PATCH v2 1/2] platform/chrome: cros_ec_typec: Send enum values to usb_role_switch_set_role()
Date:   Thu, 30 Jul 2020 15:52:56 -0700
Message-Id: <20200730225257.7208-2-azhar.shaikh@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200730225257.7208-1-azhar.shaikh@intel.com>
References: <20200730225257.7208-1-azhar.shaikh@intel.com>
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
---
 drivers/platform/chrome/cros_ec_typec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 3eae01f4c9f7..eb4713b7ae14 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -590,7 +590,8 @@ static int cros_typec_port_update(struct cros_typec_data *typec, int port_num)
 		dev_warn(typec->dev, "Configure muxes failed, err = %d\n", ret);
 
 	return usb_role_switch_set_role(typec->ports[port_num]->role_sw,
-					!!(resp.role & PD_CTRL_RESP_ROLE_DATA));
+				       resp.role & PD_CTRL_RESP_ROLE_DATA
+				       ? USB_ROLE_HOST : USB_ROLE_DEVICE);
 }
 
 static int cros_typec_get_cmd_version(struct cros_typec_data *typec)
-- 
2.17.1

