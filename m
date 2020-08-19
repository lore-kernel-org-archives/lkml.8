Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A72FFC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 07:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BAB4206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 07:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgHSHjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 03:39:00 -0400
Received: from mga09.intel.com ([134.134.136.24]:60300 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726685AbgHSHi6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 03:38:58 -0400
IronPort-SDR: hwf4pIztlAGDGIklmYXjrBJ4w8RdapmbUvCpWAye8oTYQHfzNfqjn7P+4b4VEojDWnViPZW8/W
 K1fr6gI4fBag==
X-IronPort-AV: E=McAfee;i="6000,8403,9717"; a="156134590"
X-IronPort-AV: E=Sophos;i="5.76,330,1592895600"; 
   d="scan'208";a="156134590"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 00:38:50 -0700
IronPort-SDR: 8iAcyLY+YR37E3XBgFHQHLv+I5UxVWpcX3kq8aOLjra+YbyU02yh5/eQqUzttYVAJ/kaZ283kb
 dszAj1GKo2NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,330,1592895600"; 
   d="scan'208";a="441513782"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by orsmga004.jf.intel.com with ESMTP; 19 Aug 2020 00:38:48 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     broonie@kernel.org, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, yilun.xu@intel.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, hao.wu@intel.com
Subject: [PATCH v4 0/2] add regmap-spi-avmm & Intel Max10 BMC chip support
Date:   Wed, 19 Aug 2020 15:34:55 +0800
Message-Id: <1597822497-25107-1-git-send-email-yilun.xu@intel.com>
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

Main changes from v3:
- Rebased to 5.9-rc1.
- Collapse the phy buf padding code in br_pkt_phy_tx_prepare().

Xu Yilun (2):
  regmap: add Intel SPI Slave to AVMM Bus Bridge support
  mfd: intel-m10-bmc: add Max10 BMC chip support for Intel FPGA PAC

 .../ABI/testing/sysfs-driver-intel-m10-bmc         |  15 +
 drivers/base/regmap/Kconfig                        |   6 +-
 drivers/base/regmap/Makefile                       |   1 +
 drivers/base/regmap/regmap-spi-avmm.c              | 719 +++++++++++++++++++++
 drivers/mfd/Kconfig                                |  13 +
 drivers/mfd/Makefile                               |   2 +
 drivers/mfd/intel-m10-bmc.c                        | 169 +++++
 include/linux/mfd/intel-m10-bmc.h                  |  57 ++
 include/linux/regmap.h                             |  36 ++
 9 files changed, 1017 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
 create mode 100644 drivers/base/regmap/regmap-spi-avmm.c
 create mode 100644 drivers/mfd/intel-m10-bmc.c
 create mode 100644 include/linux/mfd/intel-m10-bmc.h

-- 
2.7.4

