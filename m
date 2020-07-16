Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A9A8C433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 00:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 130382075B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 00:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgGPAuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 20:50:06 -0400
Received: from mga14.intel.com ([192.55.52.115]:57225 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727856AbgGPAuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 20:50:05 -0400
IronPort-SDR: Oh4q28FxyzNNi5BpJ4ctT+KLFc4H0rik+bF6HhmUMoM1q526SQXFmJachSUDwtbmvYpRkGDu8m
 OHDJm6jO9XwQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9683"; a="148445956"
X-IronPort-AV: E=Sophos;i="5.75,357,1589266800"; 
   d="scan'208";a="148445956"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2020 17:50:05 -0700
IronPort-SDR: R/+SrIlXs4XPEfzkb3vFXrAeuzpBokVDrbbxYbLF5J3PoZssdK4H1OpVscvaT948Zq4mdCM+KC
 ZDR/mIFT+SNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,357,1589266800"; 
   d="scan'208";a="316874123"
Received: from glacier.sc.intel.com ([10.3.62.63])
  by orsmga008.jf.intel.com with ESMTP; 15 Jul 2020 17:50:04 -0700
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
Subject: [PATCH 0/2] Add Intel Input Output Manager driver 
Date:   Wed, 15 Jul 2020 17:33:08 -0700
Message-Id: <20200716003310.26125-1-rajmohan.mani@intel.com>
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

This patch series has a dependency on the following 4 patches, that
are in Greg's usb-next branch.
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/tree/?h=usb-next

ffe82945d8eb usb: typec: intel_pmc_mux: Add support for USB4
cab9219d2af4 usb: typec: intel_pmc_mux: Definitions for response status bits
1a1be50b5ebd usb: typec: Add data structure for Enter_USB message
6701911bb1c1 usb: typec: Combine the definitions for Accessory and USB modes

Heikki Krogerus (1):
  usb: typec: intel_pmc_mux: Check the port status before connect

Rajmohan Mani (1):
  platform/x86: Add Intel Input Output Manager (IOM) driver

 drivers/platform/x86/Kconfig                |  16 +++
 drivers/platform/x86/Makefile               |   1 +
 drivers/platform/x86/intel_iom.c            | 133 ++++++++++++++++++++
 drivers/usb/typec/mux/Kconfig               |   1 +
 drivers/usb/typec/mux/intel_pmc_mux.c       |  73 +++++++++--
 include/linux/platform_data/x86/intel_iom.h |  62 +++++++++
 6 files changed, 276 insertions(+), 10 deletions(-)
 create mode 100644 drivers/platform/x86/intel_iom.c
 create mode 100644 include/linux/platform_data/x86/intel_iom.h

-- 
2.20.1

