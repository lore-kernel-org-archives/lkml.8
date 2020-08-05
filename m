Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218EEC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 08:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA2892177B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 08:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbgHEIHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 04:07:50 -0400
Received: from mga12.intel.com ([192.55.52.136]:42077 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728100AbgHEIE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 04:04:56 -0400
IronPort-SDR: AY+rpR2uExoxvqdwLDB1NkTRq9+eJ6zThy2ChhATXHJd1nPrNfbbXSZc5bFDGFRaul8M7TzR/z
 KPdqPHU1F+Bg==
X-IronPort-AV: E=McAfee;i="6000,8403,9703"; a="132047844"
X-IronPort-AV: E=Sophos;i="5.75,436,1589266800"; 
   d="scan'208";a="132047844"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2020 01:04:28 -0700
IronPort-SDR: Cmz6H9ly3BCbIttEcFkN/ZpHxZwZGPvPr2ey/n92BTcFz0CmGv1nm+ESen6FJaTyIjP7IdLnDD
 PFOWZe3BHnDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,436,1589266800"; 
   d="scan'208";a="492742148"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by fmsmga006.fm.intel.com with ESMTP; 05 Aug 2020 01:04:26 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     broonie@kernel.org, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, yilun.xu@intel.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, hao.wu@intel.com
Subject: [PATCH v3 0/2] add regmap-spi-avmm & Intel Max10 BMC chip support
Date:   Wed,  5 Aug 2020 16:00:54 +0800
Message-Id: <1596614456-20182-1-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds the regmap-spi-avmm to support the Intel SPI Slave to
AVMM Bus Bridge (spi-avmm) IP block. It also implements the usercase - the
driver of Intel Max10 BMC chip which integrates this IP block.

Patch #1 implements the regmap-spi-avmm.
Patch #2 implements the mfd driver of Intel Max10 BMC chip.

Main changes from v1:
- Split out the regmap-spi-avmm module out of intel-m10-bmc module.

Main changes from v2:
- Refactor the code of regmap-spi-avmm.
   - Rewrites the rx flow and simplifies the implementation, collapse some
     function calls.
   - Add bounds checking every time we fill trans_buf & phy_buf.
   - Try to configure spi mode on regmap init
   - delete regmap_bus.reg_write/reg_read callbacks.
   - Squash the bug fixing patch.
- Add the sub devices in mfd_cell for Max10 bmc driver.
- Improve comments and some minor fixes.

Xu Yilun (2):
  regmap: add Intel SPI Slave to AVMM Bus Bridge support
  mfd: intel-m10-bmc: add Max10 BMC chip support for Intel FPGA PAC

 .../ABI/testing/sysfs-driver-intel-m10-bmc         |  15 +
 drivers/base/regmap/Kconfig                        |   6 +-
 drivers/base/regmap/Makefile                       |   1 +
 drivers/base/regmap/regmap-spi-avmm.c              | 735 +++++++++++++++++++++
 drivers/mfd/Kconfig                                |  13 +
 drivers/mfd/Makefile                               |   2 +
 drivers/mfd/intel-m10-bmc.c                        | 169 +++++
 include/linux/mfd/intel-m10-bmc.h                  |  57 ++
 include/linux/regmap.h                             |  36 +
 9 files changed, 1033 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
 create mode 100644 drivers/base/regmap/regmap-spi-avmm.c
 create mode 100644 drivers/mfd/intel-m10-bmc.c
 create mode 100644 include/linux/mfd/intel-m10-bmc.h

-- 
2.7.4

