Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F062C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 10:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74B1B20760
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 10:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbgGPKqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 06:46:07 -0400
Received: from mga01.intel.com ([192.55.52.88]:61506 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726898AbgGPKqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 06:46:06 -0400
IronPort-SDR: ZC6HnhuuyPVL+Dk4R7+jeyWhQ1H/PNerlosqhl44YjAnse97g15IpbhS37yQcj7LYbtZt4UjF/
 3ACp/J67pCRw==
X-IronPort-AV: E=McAfee;i="6000,8403,9683"; a="167486273"
X-IronPort-AV: E=Sophos;i="5.75,359,1589266800"; 
   d="scan'208";a="167486273"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 03:46:06 -0700
IronPort-SDR: jOpF8xt5jklfDwyrNAM+rkI0fUYGOEDMQ95PgmQS+RWCMfh8X8t+5LYaETZfIE+ZWbAiI++SuL
 YN4Lkn269h/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,359,1589266800"; 
   d="scan'208";a="300207141"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by orsmga002.jf.intel.com with ESMTP; 16 Jul 2020 03:46:04 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     broonie@kernel.org, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, yilun.xu@intel.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, hao.wu@intel.com
Subject: [PATCH v2 0/3] add regmap-spi-avmm & Intel Max10 BMC chip support
Date:   Thu, 16 Jul 2020 18:42:51 +0800
Message-Id: <1594896174-18826-1-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds the regmap-spi-avmm to support the Intel SPI Slave to
AVMM Bus Bridge (spi-avmm) IP block. It also implements the usercase - the
driver of Intel Max10 BMC chip which integrates this IP block.

Patch #1 implements the main part of regmap-spi-avmm.
Patch #2 is a fix of the HW issue in spi-avmm IP block.
Patch #3 implements the mfd driver of Intel Max10 BMC chip.

Main changes from v1:
- Split out the regmap-spi-avmm module out of intel-m10-bmc module. 

Matthew Gerlach (1):
  regmap: spi-avmm: start with the last SOP on phy rx buffer parsing

Xu Yilun (2):
  regmap: add Intel SPI Slave to AVMM Bus Bridge support
  mfd: intel-m10-bmc: add Max10 BMC chip support for Intel FPGA PAC

 .../ABI/testing/sysfs-driver-intel-m10-bmc         |  15 +
 drivers/base/regmap/Kconfig                        |   6 +-
 drivers/base/regmap/Makefile                       |   1 +
 drivers/base/regmap/regmap-spi-avmm.c              | 932 +++++++++++++++++++++
 drivers/mfd/Kconfig                                |  13 +
 drivers/mfd/Makefile                               |   2 +
 drivers/mfd/intel-m10-bmc.c                        | 174 ++++
 include/linux/mfd/intel-m10-bmc.h                  |  57 ++
 include/linux/regmap.h                             |  36 +
 9 files changed, 1235 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
 create mode 100644 drivers/base/regmap/regmap-spi-avmm.c
 create mode 100644 drivers/mfd/intel-m10-bmc.c
 create mode 100644 include/linux/mfd/intel-m10-bmc.h

-- 
2.7.4

