Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92CCC433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 00:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91B3A2077D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 00:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgGBAL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 20:11:28 -0400
Received: from mga03.intel.com ([134.134.136.65]:60622 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727811AbgGBAL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 20:11:28 -0400
IronPort-SDR: mRC70VIOh709/gDQPktr5c5EVBeXWf8dIILww1G0TZT9B5vpebY9CFrOkGsJFMZHfI6VpcFRE6
 as10eNIKrH8A==
X-IronPort-AV: E=McAfee;i="6000,8403,9669"; a="146734362"
X-IronPort-AV: E=Sophos;i="5.75,302,1589266800"; 
   d="scan'208";a="146734362"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 17:11:27 -0700
IronPort-SDR: I/ump2lWM/lC/2qxq2przIm/+UyuIz8O7/sFbUWqEVbP8X8PekO6jQbH2ek8JNadEeCZAA6qv1
 oLwByjRZGpUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,302,1589266800"; 
   d="scan'208";a="313944369"
Received: from wwanmoha-ilbpg2.png.intel.com ([10.88.227.42])
  by fmsmga002.fm.intel.com with ESMTP; 01 Jul 2020 17:11:25 -0700
From:   Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org,
        andriy.shevchenko@intel.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        wan.ahmad.zainie.wan.mohamad@intel.com, sureshkumar.mp@intel.com,
        lakshmi.bai.raja.subramanian@intel.com
Subject: [PATCH v6 0/2] phy: intel: Add Keem Bay eMMC PHY support
Date:   Thu,  2 Jul 2020 08:09:32 +0800
Message-Id: <20200702000934.3258-1-wan.ahmad.zainie.wan.mohamad@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

The first part is to document DT bindings for Keem Bay eMMC PHY.

The second is the driver file, loosely based on phy-rockchip-emmc.c
and phy-intel-emmc.c. The latter is not being reused as there are
quite a number of differences i.e. registers offset, supported clock
rates, bitfield to set.

The patch was tested with Keem Bay evaluation module board.

Thank you.

Best regards,
Zainie

Changes since resend v5:
- In keembay_emmc_phy_power(), remove redundant return ret;.

Resend v5:
- Include missing changes done for phy-keembay-emmc.c (See Changes since
  v3)

Changes since v4:
- In Kconfig file, add depends on ARM64 || COMPILE_TEST and
  depends on OF && HAS_IOMEM.
- In Kconfig file, reword the help section to be more verbose.

Changes since v3:
- Exit keembay_emmc_phy_power() with return ret;.
- In keembay_emmc_phy_init(), use PTR_ERR_OR_ZERO(...).
- In keembay_emmc_phy_probe(), devm_regmap_init_mmio(...) in single
  line.

Changes since v2:
- Modify DT example to use single cell for address and size.

Changes since v1:
- Rework phy-keembay-emmc.c to make it similar to phy-intel-emmc.c.
- Use regmap_mmio, and remove reference to intel,syscon.
- Use node name phy@....
- Update license i.e. use dual license.


Wan Ahmad Zainie (2):
  dt-bindings: phy: intel: Add Keem Bay eMMC PHY bindings
  phy: intel: Add Keem Bay eMMC PHY support

 .../bindings/phy/intel,keembay-emmc-phy.yaml  |  44 +++
 drivers/phy/intel/Kconfig                     |  12 +
 drivers/phy/intel/Makefile                    |   1 +
 drivers/phy/intel/phy-keembay-emmc.c          | 314 ++++++++++++++++++
 4 files changed, 371 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/intel,keembay-emmc-phy.yaml
 create mode 100644 drivers/phy/intel/phy-keembay-emmc.c

-- 
2.17.1

