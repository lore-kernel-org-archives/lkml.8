Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BFEC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 21:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 288B0207CD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 21:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgHUVqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 17:46:37 -0400
Received: from mga17.intel.com ([192.55.52.151]:51124 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726570AbgHUVqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 17:46:36 -0400
IronPort-SDR: Iw9eGNyG1OrmBysRwkj34+RTdYRGid3PClXhrl4cjx83QZytmtu/EKLFAfohFTUtOLf6FwhrfI
 8L5B4Q5zu40g==
X-IronPort-AV: E=McAfee;i="6000,8403,9720"; a="135704246"
X-IronPort-AV: E=Sophos;i="5.76,338,1592895600"; 
   d="scan'208";a="135704246"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2020 14:46:34 -0700
IronPort-SDR: lToYYZPPROX6ANHr/RK7GD+c5UgwBXkkMivNh3FzdtOAHGyimuRtQQ/F5EJv82awIzLkmrc2Vc
 eBIzwUnaYdkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,338,1592895600"; 
   d="scan'208";a="372033687"
Received: from otc-chromeosbuild-1.jf.intel.com ([10.54.30.83])
  by orsmga001.jf.intel.com with ESMTP; 21 Aug 2020 14:46:34 -0700
From:   Azhar Shaikh <azhar.shaikh@intel.com>
To:     bleung@chromium.org, enric.balletbo@collabora.com,
        groeck@chromium.org, heikki.krogerus@linux.intel.com,
        pmalani@chromium.org
Cc:     linux-kernel@vger.kernel.org, azhar.shaikh@intel.com,
        rajmohan.mani@intel.com, utkarsh.h.patel@intel.com,
        casey.g.bowman@intel.com
Subject: [PATCH v5 1/3] platform/chrome: cros_ec_typec: Send enum values to usb_role_switch_set_role()
Date:   Fri, 21 Aug 2020 14:47:22 -0700
Message-Id: <20200821214724.20056-2-azhar.shaikh@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200821214724.20056-1-azhar.shaikh@intel.com>
References: <20200821214724.20056-1-azhar.shaikh@intel.com>
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
Changes in v5:
 - Rebased on top of https://lkml.org/lkml/2020/7/10/1063

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
index 585f27e2b362..739a1c846949 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -622,7 +622,8 @@ static int cros_typec_port_update(struct cros_typec_data *typec, int port_num)
 		dev_warn(typec->dev, "Configure muxes failed, err = %d\n", ret);
 
 	return usb_role_switch_set_role(typec->ports[port_num]->role_sw,
-					!!(resp.role & PD_CTRL_RESP_ROLE_DATA));
+					resp.role & PD_CTRL_RESP_ROLE_DATA
+					? USB_ROLE_HOST : USB_ROLE_DEVICE);
 }
 
 static int cros_typec_get_cmd_version(struct cros_typec_data *typec)
-- 
2.17.1

