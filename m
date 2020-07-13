Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F0F2C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 04:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E4112068F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 04:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgGMEji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 00:39:38 -0400
Received: from mga14.intel.com ([192.55.52.115]:25544 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbgGMEji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 00:39:38 -0400
IronPort-SDR: MT5C0MhwV3uduAbtOv2Zw9mW68OR80GkKURUIdHngVVbYWue6CFIEaQhoGoIpI+zWr+LeAHtf8
 XxrSJGgQj6GA==
X-IronPort-AV: E=McAfee;i="6000,8403,9680"; a="147671732"
X-IronPort-AV: E=Sophos;i="5.75,346,1589266800"; 
   d="scan'208";a="147671732"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2020 21:39:38 -0700
IronPort-SDR: gA1K4Zi8CVcUiigi9xLQkTqWOO4coqS7ecD2sYsgz4utlbynguOtxK3IGXKKjvqvU8x0IM1GOh
 rtTDtseP4Y2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,346,1589266800"; 
   d="scan'208";a="324130351"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Jul 2020 21:39:35 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, yilun.xu@intel.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com
Subject: [PATCH 0/2] add Intel Max10 BMC chip support
Date:   Mon, 13 Jul 2020 12:34:54 +0800
Message-Id: <1594614896-16606-1-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset add basic functions for Intel Max10 BMC chip.
Patch #1 implements the main feature.
Patch #2 is a fix for the HW issue lies in the "SPI Slave to Avalon Master
bridge" IP block, which is used for communication between host and the BMC
chip.

Matthew Gerlach (1):
  mfd: intel-m10-bmc: start with the last SOP on phy rx buffer parsing

Xu Yilun (1):
  mfd: intel-m10-bmc: add Max10 BMC chip support for Intel FPGA PAC

 .../ABI/testing/sysfs-driver-intel-m10-bmc         |  15 +
 drivers/mfd/Kconfig                                |  13 +
 drivers/mfd/Makefile                               |   3 +
 drivers/mfd/intel-m10-bmc-main.c                   | 176 ++++
 drivers/mfd/intel-spi-avmm.c                       | 904 +++++++++++++++++++++
 drivers/mfd/intel-spi-avmm.h                       |  35 +
 include/linux/mfd/intel-m10-bmc.h                  |  57 ++
 7 files changed, 1203 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
 create mode 100644 drivers/mfd/intel-m10-bmc-main.c
 create mode 100644 drivers/mfd/intel-spi-avmm.c
 create mode 100644 drivers/mfd/intel-spi-avmm.h
 create mode 100644 include/linux/mfd/intel-m10-bmc.h

-- 
2.7.4

