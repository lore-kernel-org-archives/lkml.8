Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62C0C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 14:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F9DE208B8
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 14:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729104AbgFPOkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 10:40:05 -0400
Received: from mga12.intel.com ([192.55.52.136]:9594 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbgFPOkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 10:40:04 -0400
IronPort-SDR: Eh5kA+o2xbY0wtWa/eh79FFl1p1Q8YSCjHyrfaHPkWR6BrmoNg6tNC+b7BY37MqEvXPAnmR39w
 uOxG8c0GghcA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 07:40:04 -0700
IronPort-SDR: z7dBksaaYDsk21RJFSkKqJAibFIbM7IpdX8WhoSz9ZcjNKcX1ZLy7owA7POZf0ABhwhnXggPHo
 d3XSruSzD4VA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,518,1583222400"; 
   d="scan'208";a="317238494"
Received: from wwanmoha-ilbpg2.png.intel.com ([10.88.227.42])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Jun 2020 07:40:01 -0700
From:   Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com, adrian.hunter@intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com
Subject: [PATCH v5 0/2] phy: intel: Add Keem Bay eMMC PHY support
Date:   Tue, 16 Jun 2020 22:38:16 +0800
Message-Id: <20200616143818.13579-1-wan.ahmad.zainie.wan.mohamad@intel.com>
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

 .../bindings/phy/intel,keembay-emmc-phy.yaml  |  45 +++
 drivers/phy/intel/Kconfig                     |  12 +
 drivers/phy/intel/Makefile                    |   1 +
 drivers/phy/intel/phy-keembay-emmc.c          | 316 ++++++++++++++++++
 4 files changed, 374 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/intel,keembay-emmc-phy.yaml
 create mode 100644 drivers/phy/intel/phy-keembay-emmc.c

-- 
2.17.1

