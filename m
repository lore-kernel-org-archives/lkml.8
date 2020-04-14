Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F23AC2BB86
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 02:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E0252072D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 02:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404092AbgDNCZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 22:25:18 -0400
Received: from mga05.intel.com ([192.55.52.43]:4035 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404081AbgDNCZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 22:25:15 -0400
IronPort-SDR: 33dO5Bt+XDujo5bJXhqRatLL3O31/0+Wzts8/9zyrDAkQwPnC9/ioXiwBJBGcQadm9jOMReCqz
 cHPKGPJwo0Jw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 19:25:15 -0700
IronPort-SDR: dqdmEndsmHXjNRHANhAXzK2Z0OQkAl13IJCxhoZYB/4HyCWPhbAsl8raFfJB8wh2A3ZXzOn65j
 hz20aOP6TW8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,381,1580803200"; 
   d="scan'208";a="243694824"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by fmsmga007.fm.intel.com with ESMTP; 13 Apr 2020 19:25:11 -0700
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org
Cc:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        arnd@arndb.de, brendanhiggins@google.com, tglx@linutronix.de,
        boris.brezillon@collabora.com, anders.roxell@linaro.org,
        masonccyang@mxic.com.tw, piotrs@cadence.com, robh+dt@kernel.org,
        andriy.shevchenko@intel.com, qi-ming.wu@intel.com,
        cheol.yong.kim@intel.com,
        "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v1 0/2]  mtd: rawnand: Add NAND controller support on Intel LGM SoC
Date:   Tue, 14 Apr 2020 10:24:31 +0800
Message-Id: <20200414022433.36622-1-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the new IP of NAND Flash Controller support on Intel's
Lightning Mountain(LGM) SoC.

DMA is used for burst data transfer operation, also DMA HW supports
aligned 32bit memory address and aligned data access by default.
DMA burst of 8 supported,Data register used to support the read/write
operation from/to device.

The NAND controller Subsystem consisting of LGM + ECC-NAND controller supports:
NAND Flash Features :
-16/8-bit data bus
  Page + OOB Bytes
- 512  + (2 - 13) bytes per page page
- 2048 + (7 - 210) bytes per page
- 4096 + (13 - 420) bytes per page
- 8192 + (26 - 840) bytes per page

- Support 32/64/128/256/512/1024/2048/4096/8192/16384/32768 Mbytes flash device
- ECC calculation/generation and verification on-the-fly

Ramuthevar Vadivel Murugan (2):
  dt-bindings: mtd: Add YAML for Nand Flash Controller support
  mtd: rawnand: Add NAND controller support on Intel LGM SoC

 .../devicetree/bindings/mtd/intel,lgm-nand.yaml    |  61 ++
 drivers/mtd/nand/raw/Kconfig                       |   7 +
 drivers/mtd/nand/raw/Makefile                      |   1 +
 drivers/mtd/nand/raw/intel_lgm_nand.c              | 678 +++++++++++++++++++++
 4 files changed, 747 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/intel,lgm-nand.yaml
 create mode 100644 drivers/mtd/nand/raw/intel_lgm_nand.c

-- 
2.11.0

