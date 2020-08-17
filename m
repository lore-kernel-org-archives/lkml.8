Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129A3C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE8F22072D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgHQHFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 03:05:21 -0400
Received: from mga12.intel.com ([192.55.52.136]:6525 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725765AbgHQHFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 03:05:20 -0400
IronPort-SDR: a8E/4O27K/ASNH2R1A79fMAmVNtpg797iAnbmfOvtvYwQnFblwE6cNJXzheVBuj/rgEHmfI+5F
 zTm/pfMYojzQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9715"; a="134163581"
X-IronPort-AV: E=Sophos;i="5.76,322,1592895600"; 
   d="scan'208";a="134163581"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 00:05:19 -0700
IronPort-SDR: s0MG4m6ZM9usM9rVp3MfyGdXmrHOZHwX1E0VxiuJ3+cG2oW6SWq0tKD0ch10HjYVF2Q5VKe6FP
 gomxAz0fxz+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,322,1592895600"; 
   d="scan'208";a="279049329"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by fmsmga008.fm.intel.com with ESMTP; 17 Aug 2020 00:05:17 -0700
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     linux-kernel@vger.kernel.org, kishon@ti.com, vkoul@kernel.org,
        devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org,
        p.zabel@pengutronix.de, balbi@kernel.org,
        andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, yin1.li@intel.com,
        "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [RESEND PATCH v8 0/2] phy: Add USB PHY support on Intel LGM SoC
Date:   Mon, 17 Aug 2020 15:05:11 +0800
Message-Id: <20200817070513.34376-1-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB PHY provides the optimized for low power dissipation while active, idle, or on standby.
Requires minimal external components, a single resistor, for best operation.
Supports 10/5-Gbps high-speed data transmission rates through 3-m USB 3.x cable
---
v8-resend:
 - Correct the typo error in my previous patch
v8:
  - Rebase to V5.9-rc1
v7:
  - No Change
v6:
  - No Change
v5:
  - As per Felipe and Greg's suggestion usb phy driver reviewed patches
    changed the folder from drivers/usb/phy to drivers/phy
  - Reviewed-By tag added in commit message
v4:
  - Andy's review comments addressed
  - drop the excess error debug prints
  - error check optimized
  - merge the split line to one line
v3:
  - Andy's review comments update
  - hardcode return value changed to actual return value from the callee
  - add error check is fixed according to the above
  - correct the assignment in redundant
  - combine the split line into one line
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
v8-resend:
  - No change
v8:
  - No Change
v7:
  - Fixed the bot issue: usb-phy@e7e00000: '#phy-cells' is a required property
v6:
  - Fixed the bot issue.
  - replace node-name by usb-phy@ in example
v5:
  - Reviewed-By tag added
v4:
  - No Change
v3:
  - No Change
v2:
  - No Change
v1:
  - initial version


Ramuthevar Vadivel Murugan (2):
  dt-bindings: phy: Add USB PHY support for Intel LGM SoC
  phy: Add USB3 PHY support for Intel LGM SoC

 .../devicetree/bindings/phy/intel,lgm-usb-phy.yaml |  58 +++++
 drivers/phy/Kconfig                                |  11 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/phy-lgm-usb.c                          | 278 +++++++++++++++++++++
 4 files changed, 348 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/intel,lgm-usb-phy.yaml
 create mode 100644 drivers/phy/phy-lgm-usb.c

-- 
2.11.0

