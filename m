Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34002C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B7862072D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbgHTXhx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 19:37:53 -0400
Received: from mga06.intel.com ([134.134.136.31]:59474 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728854AbgHTXhs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 19:37:48 -0400
IronPort-SDR: HK7u2J5wm8zR3LC62TZjAfO7iJxOE4oAdwUocI3rUqUaSl2nOFR+Y2j3clQ2ghh6O0SKtWPzSW
 uYaK2hoGx6FA==
X-IronPort-AV: E=McAfee;i="6000,8403,9719"; a="216963897"
X-IronPort-AV: E=Sophos;i="5.76,334,1592895600"; 
   d="scan'208";a="216963897"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2020 16:37:44 -0700
IronPort-SDR: doHUoYyOhoMzRmFwXXCrQEJbos+5pt+3OZ5VSq+f07sGziiAuEC8QizjqvLqSeK/lgnsJufp+3
 rtwc2FD01yBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,334,1592895600"; 
   d="scan'208";a="311275120"
Received: from otc-chromeosbuild-1.jf.intel.com ([10.54.30.83])
  by orsmga002.jf.intel.com with ESMTP; 20 Aug 2020 16:37:43 -0700
From:   Azhar Shaikh <azhar.shaikh@intel.com>
To:     bleung@chromium.org, enric.balletbo@collabora.com,
        groeck@chromium.org, heikki.krogerus@linux.intel.com,
        pmalani@chromium.org
Cc:     linux-kernel@vger.kernel.org, azhar.shaikh@intel.com,
        rajmohan.mani@intel.com, utkarsh.h.patel@intel.com,
        casey.g.bowman@intel.com
Subject: [PATCH v4 0/3] TypeC Connector Class driver improvements
Date:   Thu, 20 Aug 2020 16:38:29 -0700
Message-Id: <20200820233833.4551-1-azhar.shaikh@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


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

