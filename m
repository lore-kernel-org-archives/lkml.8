Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E59C2D0B1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 06:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0E46214AF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 06:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgBGGwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 01:52:23 -0500
Received: from mga05.intel.com ([192.55.52.43]:11942 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726136AbgBGGwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 01:52:23 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 22:52:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,412,1574150400"; 
   d="scan'208";a="225471974"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 06 Feb 2020 22:52:21 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1izxUz-0004Yg-6o; Fri, 07 Feb 2020 14:52:21 +0800
Date:   Fri, 7 Feb 2020 14:52:00 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        heikki.krogerus@intel.com, enric.balletbo@collabora.com,
        bleung@chromium.org, Prashant Malani <pmalani@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: [RFC PATCH] platform/chrome: cros_typec_parse_port_props() can be
 static
Message-ID: <20200207065200.eevscpn4h7d7ocvr@f53c9c00458a>
References: <20200205205954.84503-2-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205205954.84503-2-pmalani@chromium.org>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 2adbeaafa10e ("platform/chrome: Add Type C connector class driver")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 cros_ec_typec.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index fe5659171c2a85..9b83aa4d5456d4 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -25,9 +25,9 @@ struct cros_typec_data {
 	struct typec_port *ports[EC_USB_PD_MAX_PORTS];
 };
 
-int cros_typec_parse_port_props(struct typec_capability *cap,
-				struct fwnode_handle *fwnode,
-				struct device *dev)
+static int cros_typec_parse_port_props(struct typec_capability *cap,
+				       struct fwnode_handle *fwnode,
+				       struct device *dev)
 {
 	const char *buf;
 	int ret;
