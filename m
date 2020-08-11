Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0182CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 19:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2FE8206B2
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 19:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgHKThS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 15:37:18 -0400
Received: from mga17.intel.com ([192.55.52.151]:10832 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbgHKThS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 15:37:18 -0400
IronPort-SDR: pYSwJHTZT03fsT7lOnDoS4x6/+e3oaoMEQ/KSXCYjajPaNXEst4r5bC7tKWAxCFGbJG8PDWrjN
 T3dyKSWwdKpQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9710"; a="133871947"
X-IronPort-AV: E=Sophos;i="5.76,301,1592895600"; 
   d="scan'208";a="133871947"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2020 12:37:17 -0700
IronPort-SDR: 8dp6ogKGjaZ9hZBF5eB3L2TZ+asxk/iDSzyiSwW5utbRmSU6eJyU1kCB4AJuZ9Z3s4al+QBBKI
 XtJ2Qjaz23MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,301,1592895600"; 
   d="scan'208";a="317840428"
Received: from otc-chromeosbuild-1.jf.intel.com ([10.54.30.83])
  by fmsmga004.fm.intel.com with ESMTP; 11 Aug 2020 12:37:17 -0700
From:   Azhar Shaikh <azhar.shaikh@intel.com>
To:     bleung@chromium.org, enric.balletbo@collabora.com,
        groeck@chromium.org, heikki.krogerus@linux.intel.com,
        pmalani@chromium.org
Cc:     linux-kernel@vger.kernel.org, azhar.shaikh@intel.com,
        rajmohan.mani@intel.com, utkarsh.h.patel@intel.com,
        casey.g.bowman@intel.com
Subject: [PATCH v3 0/3] TypeC Connector Class driver improvements
Date:   Tue, 11 Aug 2020 12:37:54 -0700
Message-Id: <20200811193757.45057-1-azhar.shaikh@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

