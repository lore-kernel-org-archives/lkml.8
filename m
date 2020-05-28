Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058ADC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 05:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E196120721
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 05:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbgE1FNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 01:13:41 -0400
Received: from mga09.intel.com ([134.134.136.24]:1646 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727896AbgE1FNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 01:13:38 -0400
IronPort-SDR: ImV7ws41MY1JqxolhFoZD72UmkhEpEPbFP1C9SUpv0x2nd9EymslzpcjHmkR3ZmphKapX3d0vJ
 ibcUBVo4lYEg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2020 22:13:37 -0700
IronPort-SDR: nrT4BrWIWNwvR5rQfELYTwjIrfw8uZM85wNV6TkXXfnvdZk5VQryfNlw4Mklxbwihq46FNka7n
 bdnUPUadj9yA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,443,1583222400"; 
   d="scan'208";a="345789079"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga001.jf.intel.com with ESMTP; 27 May 2020 22:13:33 -0700
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, miquel.raynal@bootlin.com
Cc:     richard@nod.at, vigneshr@ti.com, arnd@arndb.de,
        brendanhiggins@google.com, tglx@linutronix.de,
        boris.brezillon@collabora.com, anders.roxell@linaro.org,
        masonccyang@mxic.com.tw, robh+dt@kernel.org,
        linux-mips@vger.kernel.org, hauke.mehrtens@intel.com,
        andriy.shevchenko@intel.com, qi-ming.wu@intel.com,
        cheol.yong.kim@intel.com,
        "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v9 0/2] mtd: rawnand: Add NAND controller support on Intel LGM SoC
Date:   Thu, 28 May 2020 13:12:09 +0800
Message-Id: <20200528051211.3063-1-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the new IP of Nand Flash Controller(NFC) support
on Intel's Lightning Mountain(LGM) SoC.

DMA is used for burst data transfer operation, also DMA HW supports
aligned 32bit memory address and aligned data access by default.
DMA burst of 8 supported. Data register used to support the read/write
operation from/to device.

NAND controller also supports in-built HW ECC engine.

NAND controller driver implements ->exec_op() to replace legacy hooks,
these specific call-back method to execute NAND operations.

Thanks Boris, Andy, Arnd and Rob for the review comments and suggestions.
---
v9:
   No change 
v8:
  - fix the kbuild bot warnings
  - correct the typo's
v7:
  - indentation issue is fixed
  - add error check for retrieve the resource from dt
v6:
  - update EBU_ADDR_SELx register base value build it from DT
  - Add tabs in in Kconfig
v5:
  - replace by 'HSNAND_CLE_OFFS | HSNAND_CS_OFFS' to NAND_WRITE_CMD and NAND_WRITE_ADDR
  - remove the unused macros
  - update EBU_ADDR_MASK(x) macro
  - update the EBU_ADDR_SELx register values to be written
v4:
  - add ebu_nand_cs structure for multiple-CS support
  - mask/offset encoding for 0x51 value
  - update macro HSNAND_CTL_ENABLE_ECC
  - drop the op argument and un-used macros.
  - updated the datatype and macros
  - add function disable nand module
  - remove ebu_host->dma_rx = NULL;
  - rename MMIO address range variables to ebu and hsnand
  - implement ->setup_data_interface()
  - update label err_cleanup_nand and err_cleanup_dma
  - add return value check in the nand_remove function
  - add/remove tabs and spaces as per coding standard
  - encoded CS ids by reg property
v3:
  - Add depends on MACRO in Kconfig
  - file name update in Makefile
  - file name update to intel-nand-controller
  - modification of MACRO divided like EBU, HSNAND and NAND
  - add NAND_ALE_OFFS, NAND_CLE_OFFS and NAND_CS_OFFS
  - rename lgm_ to ebu_ and _va suffix is removed in the whole file
  - rename structure and varaibles as per review comments.
  - remove lgm_read_byte(), lgm_dev_ready() and cmd_ctrl() un-used function
  - update in exec_op() as per review comments
  - rename function lgm_dma_exit() by lgm_dma_cleanup()
  - hardcoded magic value  for base and offset replaced by MACRO defined
  - mtd_device_unregister() + nand_cleanup() instead of nand_release()
v2:
  - implement the ->exec_op() to replaces the legacy hook-up.
  - update the commit message
  - add MIPS maintainers and xway_nand driver author in CC

v1:
 - initial version

dt-bindings: mtd: Add Nand Flash Controller support for Intel LGM SoC
---
v9:
  - Rob's review comments address
  - dual licensed
  - compatible change
  - add reg-names
  - drop clock-names and clock-cells
  - correct typo's
v8:
  No change
v7:
  - Rob's review comments addressed
  - dt-schema build issue fixed with upgraded dt-schema
v6:
  - Rob's review comments addressed in YAML file
  - add addr_sel0 and addr_sel1 reg-names in YAML example
v5:
  - add the example in YAML file
v4:
  - No change
v3:
  - No change
v2:
  YAML compatible string update to intel, lgm-nand-controller
v1:
  - initial version

Ramuthevar Vadivel Murugan (2):
  dt-bindings: mtd: Add Nand Flash Controller support for Intel LGM SoC
  mtd: rawnand: Add NAND controller support on Intel LGM SoC

 .../devicetree/bindings/mtd/intel,lgm-nand.yaml    |  93 +++
 drivers/mtd/nand/raw/Kconfig                       |   8 +
 drivers/mtd/nand/raw/Makefile                      |   1 +
 drivers/mtd/nand/raw/intel-nand-controller.c       | 747 +++++++++++++++++++++
 4 files changed, 849 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/intel,lgm-nand.yaml
 create mode 100644 drivers/mtd/nand/raw/intel-nand-controller.c

-- 
2.11.0

