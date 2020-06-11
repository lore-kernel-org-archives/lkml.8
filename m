Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB047C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 02:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F0A0206A4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 02:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgFKCO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 22:14:27 -0400
Received: from mga12.intel.com ([192.55.52.136]:28347 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbgFKCO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 22:14:26 -0400
IronPort-SDR: oLLWgJIt85OGOUj4CExmiavyh1ZIsYGe+jPgr0NeIopBXKag9jKvctVmOieAG70h2FEuDKIEmR
 /GwxpD/J6OXQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2020 19:14:26 -0700
IronPort-SDR: NV61z8+oA59guK0bpc44VaaOOX7fOlYzb6LCnwK8mBClybZv9681lL9qxUuydUYF0GV3K5FTbO
 slZevB4k6q0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,498,1583222400"; 
   d="scan'208";a="289393199"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga002.jf.intel.com with ESMTP; 10 Jun 2020 19:14:23 -0700
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     linux-kernel@vger.kernel.org, balbi@kernel.org,
        p.zabel@pengutronix.de
Cc:     gregkh@linuxfoundation.org, robh@kernel.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com, yin1.li@intel.com,
        andriy.shevchenko@intel.com,
        "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v2 0/2] usb : phy: Add USB PHY support on Intel LGM SoC
Date:   Thu, 11 Jun 2020 10:12:44 +0800
Message-Id: <20200611021246.3250-1-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB PHY provides the optimized for low power dissipation while active, idle, or on standby.
Requires minimal external components, a single resistor, for best operation.
Supports 10/5-Gbps high-speed data transmission rates through 3-m USB 3.x cable 
---
v2:
  - Address Phillip's review comments
  - replace devm_reset_control_get() by devm_reset_control_get_exclusive()
  - re-design the assert and deassert fucntion calls as per review comments
  - address kbuild bot warnings
  - add the comments 
v1:
  - initial version

---
dt-bindings: usb: Add USB PHY support for Intel LGM SoC
v2:
  - No Change
v1:
  - initial version


Ramuthevar Vadivel Murugan (2):
  dt-bindings: usb: Add USB PHY support for Intel LGM SoC
  usb: phy: Add USB3 PHY support for Intel LGM SoC

 .../devicetree/bindings/usb/intel,lgm-usb-phy.yaml |  53 ++++
 drivers/usb/phy/Kconfig                            |  11 +
 drivers/usb/phy/Makefile                           |   1 +
 drivers/usb/phy/phy-lgm-usb.c                      | 280 +++++++++++++++++++++
 4 files changed, 345 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/intel,lgm-usb-phy.yaml
 create mode 100644 drivers/usb/phy/phy-lgm-usb.c

-- 
2.11.0

