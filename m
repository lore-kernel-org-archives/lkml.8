Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 137ACC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 04:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2E1E20679
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 04:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgFQEAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 00:00:14 -0400
Received: from mga17.intel.com ([192.55.52.151]:6256 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbgFQEAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 00:00:14 -0400
IronPort-SDR: QYsxM9WkPp3YQof9RyZjPIbLqtqTlwgtVZgBVZDqO1EEj5H5pu2MtbDvbqstmM0EBs6H4koDfV
 pFSd71/Hgkbw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 21:00:12 -0700
IronPort-SDR: P7JJITls+VcK+ReROrNmm5B8xeFakBdTNJba/+p5kSYiQ8bhLUnumWMWQPn7PtjJqWlQSCJ9vS
 8SNXjQn/doww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,521,1583222400"; 
   d="scan'208";a="273382466"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga003.jf.intel.com with ESMTP; 16 Jun 2020 21:00:09 -0700
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     linux-kernel@vger.kernel.org, balbi@kernel.org, robh@kernel.org,
        p.zabel@pengutronix.de
Cc:     gregkh@linuxfoundation.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, yin1.li@intel.com,
        andriy.shevchenko@intel.com,
        "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v4 0/2]usb : phy: Add USB PHY support on Intel LGM SoC
Date:   Wed, 17 Jun 2020 11:58:16 +0800
Message-Id: <20200617035818.54110-1-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB PHY provides the optimized for low power dissipation while active, idle, or on standby.
Requires minimal external components, a single resistor, for best operation.
Supports 10/5-Gbps high-speed data transmission rates through 3-m USB 3.x cable
---
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
v4:
  - No Change
v3:
  - No Change
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
 drivers/usb/phy/phy-lgm-usb.c                      | 275 +++++++++++++++++++++
 4 files changed, 340 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/intel,lgm-usb-phy.yaml
 create mode 100644 drivers/usb/phy/phy-lgm-usb.c

-- 
2.11.0

