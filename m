Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95E6C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 21:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA7C0207DA
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 21:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgHUVqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 17:46:36 -0400
Received: from mga17.intel.com ([192.55.52.151]:51124 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726433AbgHUVqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 17:46:35 -0400
IronPort-SDR: LQO+orxU8Qw4NjKCsjGxlPQzc+gCVpJX5izQIdO/ZtSgmq1e22aU3ddDwQQOcIMR6kMfJKZFik
 MZlEkUthL1/g==
X-IronPort-AV: E=McAfee;i="6000,8403,9720"; a="135704243"
X-IronPort-AV: E=Sophos;i="5.76,338,1592895600"; 
   d="scan'208";a="135704243"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2020 14:46:34 -0700
IronPort-SDR: ZxZtS3zpvyVjxPKG+rWe6VqY6Rd2qHsMBaRBX/gYnp/j6ujYbhqlvzWJOcO6WKckjbImRTI03R
 r/gTj0tJgS+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,338,1592895600"; 
   d="scan'208";a="372033684"
Received: from otc-chromeosbuild-1.jf.intel.com ([10.54.30.83])
  by orsmga001.jf.intel.com with ESMTP; 21 Aug 2020 14:46:34 -0700
From:   Azhar Shaikh <azhar.shaikh@intel.com>
To:     bleung@chromium.org, enric.balletbo@collabora.com,
        groeck@chromium.org, heikki.krogerus@linux.intel.com,
        pmalani@chromium.org
Cc:     linux-kernel@vger.kernel.org, azhar.shaikh@intel.com,
        rajmohan.mani@intel.com, utkarsh.h.patel@intel.com,
        casey.g.bowman@intel.com
Subject: [PATCH v5 0/3] TypeC Connector Class driver improvements
Date:   Fri, 21 Aug 2020 14:47:21 -0700
Message-Id: <20200821214724.20056-1-azhar.shaikh@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v5:

* Patch 1: "platform/chrome: cros_ec_typec: Send enum values to
            usb_role_switch_set_role()"
  - Rebased on top of https://lkml.org/lkml/2020/7/10/1063

* Patch 2: "platform/chrome: cros_ec_typec: Avoid setting usb role twice
            during disconnect"
  - Rebased on top of https://lkml.org/lkml/2020/7/10/1063
  - Added Reviewed-by from v4

* Patch 3: "platform/chrome: cros_ec_typec: Re-order connector
            configuration steps"
  - Rebased on top of https://lkml.org/lkml/2020/7/10/1063
  - Added Reviewed-by from v4

Changes in v4:
* Patch 1: "platform/chrome: cros_ec_typec: Send enum values to
            usb_role_switch_set_role()"
  - Remove extra line between Fixes and Signed-off tag.
  - Added Reviewed-by and Cc tags from v1 and v2.

* Patch 2: "platform/chrome: cros_ec_typec: Avoid setting usb role twice
            during disconnect"
  - Added Suggested-by from v2.

* Patch 3: "platform/chrome: cros_ec_typec: Re-order connector
            configuration steps"
  - No change

Changes in v3:
* Patch 1: "platform/chrome: cros_ec_typec: Send enum values to
            usb_role_switch_set_role()"
 - No change

* Patch 2: "platform/chrome: cros_ec_typec: Avoid setting usb role twice
            during disconnect"
 - Move the location of calling usb_role_switch_set_role() to
   end of function in cros_typec_configure_mux() to avoid any change
   in code flow.

* Patch 3: "platform/chrome: cros_ec_typec: Re-order connector
            configuration steps"
 - New patch added

Changes in v2:
* Patch 1: "platform/chrome: cros_ec_typec: Send enum values to
            usb_role_switch_set_role()"
  - Update the commit message to change 'USB_ROLE_HOST in case of
    UFP.'  to 'USB_ROLE_HOST in case of DFP.'

* Patch 2: "platform/chrome: cros_ec_typec: Avoid setting usb role twice
            during disconnect"
  - New patch added.

Azhar Shaikh (3):
  platform/chrome: cros_ec_typec: Send enum values to
    usb_role_switch_set_role()
  platform/chrome: cros_ec_typec: Avoid setting usb role twice during
    disconnect
  platform/chrome: cros_ec_typec: Re-order connector configuration steps

 drivers/platform/chrome/cros_ec_typec.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

-- 
2.17.1

