Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE77C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 13:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4856720656
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 13:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbgCBNx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 08:53:57 -0500
Received: from mga11.intel.com ([192.55.52.93]:22884 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727083AbgCBNx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 08:53:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 05:53:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,507,1574150400"; 
   d="scan'208";a="351544499"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 02 Mar 2020 05:53:54 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH v3 0/9] usb: typec: Driver for Intel PMC Mux-Agent
Date:   Mon,  2 Mar 2020 16:53:44 +0300
Message-Id: <20200302135353.56659-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The statements were ended incorrectly with comma instead of semicolon
in drivers/usb/cdns3/core.c (PATCH 5/9) as pointed out by Peter. I've
fixed that in this version. There are no other changes.

v2 commit message:

I've unified the driver data handling in all drivers in patch 5/9 as
requested by Peter, and also now using consistently dev_set_drvdata()
in patch 4/9 as requested by Chunfeng Yun. Those were the only
changes in this version.

The original (v1) commit message:

The Intel PMC (Power Management Controller) microcontroller, which is
available on most SOCs from Intel, has a function called mux-agent.
The mux-agent, when visible to the operating system, makes it possible
to control the various USB muxes on the system.

In practice the mux-agent is a device that controls multiple muxes.
Unfortunately both the USB Type-C Class and the USB Role Class don't
have proper support for that kind of devices that handle multiple
muxes, which is why I had to tweak the APIs a bit.

On top of the API changes, and the driver of course, I'm adding a
header for the Thunderbolt 3 alt mode since the "mux-agent" supports
it.

thanks,


Heikki Krogerus (9):
  usb: typec: mux: Allow the muxes to be named
  usb: typec: mux: Add helpers for setting the mux state
  usb: typec: mux: Allow the mux handles to be requested with fwnode
  usb: roles: Leave the private driver data pointer to the drivers
  usb: roles: Provide the switch drivers handle to the switch in the API
  usb: roles: Allow the role switches to be named
  device property: Export fwnode_get_name()
  usb: typec: Add definitions for Thunderbolt 3 Alternate Mode
  usb: typec: driver for Intel PMC mux control

 drivers/base/property.c                       |   1 +
 drivers/usb/cdns3/core.c                      |  22 +-
 drivers/usb/chipidea/core.c                   |  10 +-
 drivers/usb/dwc3/dwc3-meson-g12a.c            |  10 +-
 drivers/usb/gadget/udc/renesas_usb3.c         |  26 +-
 drivers/usb/gadget/udc/tegra-xudc.c           |   8 +-
 drivers/usb/mtu3/mtu3_dr.c                    |   9 +-
 drivers/usb/musb/mediatek.c                   |  16 +-
 drivers/usb/roles/class.c                     |  29 +-
 .../usb/roles/intel-xhci-usb-role-switch.c    |  26 +-
 drivers/usb/typec/class.c                     |  10 +-
 drivers/usb/typec/mux.c                       |  47 +-
 drivers/usb/typec/mux/Kconfig                 |   9 +
 drivers/usb/typec/mux/Makefile                |   1 +
 drivers/usb/typec/mux/intel_pmc_mux.c         | 434 ++++++++++++++++++
 include/linux/usb/role.h                      |  23 +-
 include/linux/usb/typec_mux.h                 |  25 +-
 include/linux/usb/typec_tbt.h                 |  53 +++
 18 files changed, 677 insertions(+), 82 deletions(-)
 create mode 100644 drivers/usb/typec/mux/intel_pmc_mux.c
 create mode 100644 include/linux/usb/typec_tbt.h

-- 
2.25.0

