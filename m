Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E040FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 19:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0B29206B2
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 19:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgHKThY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 15:37:24 -0400
Received: from mga17.intel.com ([192.55.52.151]:10832 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbgHKThT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 15:37:19 -0400
IronPort-SDR: 3ffj21LUB/y47I3tsOXT15u5bxWBW2/Sht5ItYlZ5kgJGKO3ZJMS9feFU0GKvtNs60fck6V2F9
 GhOn44a+hUEA==
X-IronPort-AV: E=McAfee;i="6000,8403,9710"; a="133871950"
X-IronPort-AV: E=Sophos;i="5.76,301,1592895600"; 
   d="scan'208";a="133871950"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2020 12:37:18 -0700
IronPort-SDR: CQh1Dn/HP2CnhPuVJQtflE5IsNlviNYhHhh5WfF/e+R6CaH/osTzWlP78XhKxrwmwpvcxHGh7a
 mkiNp6txRxog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,301,1592895600"; 
   d="scan'208";a="317840431"
Received: from otc-chromeosbuild-1.jf.intel.com ([10.54.30.83])
  by fmsmga004.fm.intel.com with ESMTP; 11 Aug 2020 12:37:17 -0700
From:   Azhar Shaikh <azhar.shaikh@intel.com>
To:     bleung@chromium.org, enric.balletbo@collabora.com,
        groeck@chromium.org, heikki.krogerus@linux.intel.com,
        pmalani@chromium.org
Cc:     linux-kernel@vger.kernel.org, azhar.shaikh@intel.com,
        rajmohan.mani@intel.com, utkarsh.h.patel@intel.com,
        casey.g.bowman@intel.com
Subject: [PATCH v3 1/3] platform/chrome: cros_ec_typec: Send enum values to usb_role_switch_set_role()
Date:   Tue, 11 Aug 2020 12:37:55 -0700
Message-Id: <20200811193757.45057-2-azhar.shaikh@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200811193757.45057-1-azhar.shaikh@intel.com>
References: <20200811193757.45057-1-azhar.shaikh@intel.com>
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
---
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

