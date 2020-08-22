Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89C0C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 04:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8945F21734
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 04:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgHVEmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 00:42:03 -0400
Received: from mga11.intel.com ([192.55.52.93]:62111 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbgHVEmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 00:42:02 -0400
IronPort-SDR: L5cWrMKeTLKA+Ql7C8AaxVuaFgEuQJe2/QT6SFAkOg5BTHZzkciTnp/ykw8j2GoZofVgWD9vsC
 Ob758+GcXEEw==
X-IronPort-AV: E=McAfee;i="6000,8403,9720"; a="153275278"
X-IronPort-AV: E=Sophos;i="5.76,339,1592895600"; 
   d="scan'208";a="153275278"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2020 21:42:00 -0700
IronPort-SDR: /wRozzR/+pHnFL1sLFEhDuh29wmyHAaIIjcALqJySqFz31V/w+W3Lh2NcT1oZa6hhrPaDMdhMM
 grwt4A3mgmHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,339,1592895600"; 
   d="scan'208";a="327943115"
Received: from glacier.sc.intel.com ([10.3.62.63])
  by orsmga008.jf.intel.com with ESMTP; 21 Aug 2020 21:42:00 -0700
From:   Rajmohan Mani <rajmohan.mani@intel.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Jithu Joseph <jithu.joseph@intel.com>,
        =?UTF-8?q?Bla=C5=BE=20Hrastnik?= <blaz@mxxn.io>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     pmalani@chromium.org, bleung@chromium.org,
        Rajmohan Mani <rajmohan.mani@intel.com>
Subject: [PATCH v2 0/3] Add Intel Input Output Manager driver 
Date:   Fri, 21 Aug 2020 21:05:05 -0700
Message-Id: <20200822040508.23510-1-rajmohan.mani@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch series add support for Intel Input Output Manager (IOM)
driver, which is leveraged by the Intel PMC USB mux control driver.

changes from v1:
- Included device role (UFP) support patch from Heikki to this series.
- Addressed Greg's comments on v1 with below changes
- Used per-instance variable for struct intel_iom
- Removed struct device *dev inside probe function
- Removed dev_set_drvdata() inside probe function
- Added NULL pointer check on struct intel_iom * as well as members
  dev and regbar, inside intel_iom_port_status(), to protect against
  calls to this API before driver gets probed.
- Limit support to only one IOM device
- Removed intel_iom_get()/intel_iom_put() calls, as the dependency through
  Kconfig is enough to prevent the IOM driver from unloading, when used
  by callers.

Heikki Krogerus (2):
  usb: typec: intel_pmc_mux: Check the port status before connect
  usb: typec: intel_pmc_mux: Support for device role (UFP)

Rajmohan Mani (1):
  platform/x86: Add Intel Input Output Manager (IOM) driver

 drivers/platform/x86/Kconfig                |  16 +++
 drivers/platform/x86/Makefile               |   1 +
 drivers/platform/x86/intel_iom.c            |  95 +++++++++++++++
 drivers/usb/typec/mux/Kconfig               |   1 +
 drivers/usb/typec/mux/intel_pmc_mux.c       | 124 ++++++++++++++------
 include/linux/platform_data/x86/intel_iom.h |  49 ++++++++
 6 files changed, 251 insertions(+), 35 deletions(-)
 create mode 100644 drivers/platform/x86/intel_iom.c
 create mode 100644 include/linux/platform_data/x86/intel_iom.h

-- 
2.20.1

