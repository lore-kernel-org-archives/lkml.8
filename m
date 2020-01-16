Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7526C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 11:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9506A20730
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 11:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TI3FiTcA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgAPLDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 06:03:12 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:41926 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbgAPLDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 06:03:09 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00GB35JV016802;
        Thu, 16 Jan 2020 05:03:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1579172585;
        bh=MqZla7tigJ0drs2tZDFaTYUOu28UosLg2SCMO22LFTc=;
        h=From:To:CC:Subject:Date;
        b=TI3FiTcAZiekxgicijsnjj4jAsbGlXYaWOvFREiGh9EZdYc8W5X7y83gk7/O42Pw6
         l6iJyejBdhqLC8qK3LFFJAaVK+QtX6UKrU1V98/9htQzjaUHVOPNMVHJaK2zQ4yDk1
         2FQOO63mq5TaXWJmv4O2D1Be8kzKmH/yew+cpLZk=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00GB35hE108242
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 16 Jan 2020 05:03:05 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 16
 Jan 2020 05:03:05 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 16 Jan 2020 05:03:05 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00GB33xw058748;
        Thu, 16 Jan 2020 05:03:04 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] PHY: For 5.6
Date:   Thu, 16 Jan 2020 16:35:15 +0530
Message-ID: <20200116110515.20480-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please find the pull request for 5.6 merge window below.

PHY core now creates a device link between PHY consumer and PHY
provider required for suspend/resume ordering and also adds support
for DisplayPort controller to pass configuration parameters to PHY.

It includes new PHY drivers for TI's J721E SoC (PCIe and USB), eMMC
PHY driver for Intel's LGM SoC and USB PHY driver for Broadcom
SoC.

For the detailed list of changes, please see the tag message below.
All these changes have been in linux -next for a while now.
Consider merging this for the next merge window and let me know if I
have to change something.

Thanks
Kishon

The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git tags/phy-for-5.6

for you to fetch changes up to 28a263814638c3c63093e0bf682eec1e451054d9:

  dt-bindings: phy: Add PHY_TYPE_DP definition (2020-01-14 10:50:19 +0530)

----------------------------------------------------------------
phy: for 5.6

*) Add support in PHY core to create link between PHY consumer and PHY
   provider
*) Add DisplayPort PHY configuration set to be used for negotiating the
   configurations to be used between DisplayPort controller and
   DisplayPort PHY
*) Add PHY wrapper driver (configure inputs to Cadence Sierra PHY) for
   TI's J721E SoC and adapt Cadence Sierra PHY driver to be used for
   J721E SoC (Supports USB and PCIe)
*) Add PHY driver for eMMC PHY in Intel LGM SoC
*) Add PHY support for 7216 and 7211 Broadcom SoCs which uses the new
   Synopsys USB Controller
*) Add support for 16nm SATA PHY present in Broadcom 7216 SoC
*) Fix lost packet issue, fix MDIO from getting inaccessible, fix
   occasional transaction failures, fix USB driver from crashing in
   Broadcom USB PHY driver
*) Fix missing PCS SW reset in UFS PHY of Qualcomm SM8150
*) Use "struct phy_configure_opts_mipi_dphy" to pass parameters from
   display controller to rockchip-inno-dsidphy
*) Other cleanups including compile testing for some of the PHY drivers,
   fixing Kconfig indentation, duplicate writes in drivers etc.,

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

----------------------------------------------------------------
Al Cooper (13):
      phy: usb: EHCI DMA may lose a burst of DMA data for 7255xA0 family
      phy: usb: Get all drivers that use USB clks using correct enable/disable
      phy: usb: Put USB phys into IDDQ on suspend to save power in S2 mode
      phy: usb: Add "wake on" functionality
      phy: usb: Restructure in preparation for adding 7216 USB support
      dt-bindings: Add Broadcom STB USB PHY binding document
      phy: usb: Add support for new Synopsys USB controller on the 7216
      phy: usb: Add support for new Synopsys USB controller on the 7211b0
      phy: usb: fix driver to defer on clk_get defer
      phy: usb: PHY's MDIO registers not accessible without device installed
      phy: usb: bdc: Fix occasional failure with BDC on 7211
      phy: usb: USB driver is crashing during S3 resume on 7216
      phy: usb: Add support for wake and USB low power mode for 7211 S2/S5

Alexandre Torgue (1):
      phy: core: Add consumer device link support

Anil Varughese (1):
      phy: cadence: Sierra: Configure both lane cdb and common cdb registers for external SSC

Chuhong Yuan (1):
      phy: ti-pipe3: make clk operations symmetric in probe and remove

Colin Ian King (1):
      phy: cadence: Sierra: remove redundant initialization of pointer regmap

Florian Fainelli (2):
      dt-bindings: phy: Document BCM7216 SATA PHY compatible string
      phy: brcm-sata: Implement 7216 initialization sequence

Heiko Stuebner (2):
      dt-bindings: phy: drop #clock-cells from rockchip,px30-dsi-dphy
      phy/rockchip: inno-dsidphy: generalize parameter handling

Jyri Sarha (1):
      dt-bindings: phy: Add PHY_TYPE_DP definition

Kishon Vijay Abraham I (13):
      dt-bindings: phy: Sierra: Add bindings for Sierra in TI's J721E
      phy: cadence: Sierra: Make "phy_clk" and "sierra_apb" optional resources
      phy: cadence: Sierra: Use "regmap" for read and write to Sierra registers
      phy: cadence: Sierra: Add support for SERDES_16G used in J721E SoC
      phy: cadence: Sierra: Make cdns_sierra_phy_init() as phy_ops
      phy: cadence: Sierra: Modify register macro names to be in sync with Sierra user guide
      phy: cadence: Sierra: Get reset control "array" for each link
      phy: cadence: Sierra: Check for PLL lock during PHY power on
      phy: cadence: Sierra: Change MAX_LANES of Sierra to 16
      phy: cadence: Sierra: Set cmn_refclk_dig_div/cmn_refclk1_dig_div frequency to 25MHz
      phy: cadence: Sierra: Use correct dev pointer in cdns_sierra_phy_remove()
      dt-bindings: phy: Document WIZ (SERDES wrapper) bindings
      phy: ti: j721e-wiz: Add support for WIZ module present in TI J721E SoC

Krzysztof Kozlowski (3):
      phy: hisilicon: Fix Kconfig indentation
      phy: mediatek: Fix Kconfig indentation
      phy: Enable compile testing for some of drivers

Ma Feng (1):
      phy: lantiq: vrx200-pcie: Remove unneeded semicolon

Maxime Ripard (1):
      dt-bindings: usb: Convert Allwinner A80 USB PHY controller to a schema

Nathan Chancellor (1):
      phy: qualcomm: Adjust indentation in read_poll_timeout

Nishad Kamdar (1):
      phy: qcom-qmp: Use the correct style for SPDX License Identifier

Ramuthevar Vadivel Murugan (3):
      dt-bindings: phy: intel-emmc-phy: Add YAML schema for LGM eMMC PHY
      phy: intel-lgm-emmc: Add support for eMMC PHY
      phy: intel-lgm-emmc: Fix warning by adding missing MODULE_LICENSE

Roger Quadros (3):
      phy: cadence: Sierra: add phy_reset hook
      dt-bindings: phy: ti,phy-j721e-wiz: Add Type-C dir GPIO
      phy: ti: j721e-wiz: Manage typec-gpio-dir

Vinod Koul (4):
      phy: qcom-qmp: Use register defines
      phy: qcom-qmp: remove duplicate powerdown write
      phy: qcom-qmp: remove no_pcs_sw_reset for sm8150
      phy: qcom-qmp: Add SW reset register

Wei Yongjun (1):
      phy: ti: j721e-wiz: Fix return value check in wiz_probe()

Yuti Amonkar (1):
      phy: Add DisplayPort configuration options

 Documentation/devicetree/bindings/phy/allwinner,sun9i-a80-usb-phy.yaml | 135 ++++++++++++++++++
 Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-phy.txt         |  69 +++++++--
 Documentation/devicetree/bindings/phy/brcm-sata-phy.txt                |   1 +
 Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml          |  56 ++++++++
 Documentation/devicetree/bindings/phy/phy-cadence-sierra.txt           |  13 +-
 Documentation/devicetree/bindings/phy/rockchip,px30-dsi-dphy.yaml      |   5 -
 Documentation/devicetree/bindings/phy/sun9i-usb-phy.txt                |  37 -----
 Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml            | 221 +++++++++++++++++++++++++++++
 drivers/phy/Kconfig                                                    |   1 +
 drivers/phy/Makefile                                                   |   1 +
 drivers/phy/allwinner/Kconfig                                          |   3 +-
 drivers/phy/broadcom/Kconfig                                           |   4 +-
 drivers/phy/broadcom/Makefile                                          |   2 +-
 drivers/phy/broadcom/phy-brcm-sata.c                                   | 120 ++++++++++++++++
 drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c                      | 414 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/phy/broadcom/phy-brcm-usb-init.c                               | 226 +++++++++++++++---------------
 drivers/phy/broadcom/phy-brcm-usb-init.h                               | 148 ++++++++++++++++++--
 drivers/phy/broadcom/phy-brcm-usb.c                                    | 269 ++++++++++++++++++++++++++++-------
 drivers/phy/cadence/phy-cadence-sierra.c                               | 709 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------
 drivers/phy/hisilicon/Kconfig                                          |  16 +--
 drivers/phy/intel/Kconfig                                              |   9 ++
 drivers/phy/intel/Makefile                                             |   2 +
 drivers/phy/intel/phy-intel-emmc.c                                     | 284 +++++++++++++++++++++++++++++++++++++
 drivers/phy/lantiq/phy-lantiq-vrx200-pcie.c                            |   2 +-
 drivers/phy/marvell/Kconfig                                            |   8 +-
 drivers/phy/mediatek/Kconfig                                           |  25 ++--
 drivers/phy/phy-core.c                                                 |  49 ++++++-
 drivers/phy/qualcomm/phy-qcom-apq8064-sata.c                           |   2 +-
 drivers/phy/qualcomm/phy-qcom-qmp.c                                    |   7 +-
 drivers/phy/qualcomm/phy-qcom-qmp.h                                    |   2 +-
 drivers/phy/rockchip/Kconfig                                           |   1 +
 drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c                       | 319 +++++++++++++-----------------------------
 drivers/phy/samsung/Kconfig                                            |   8 +-
 drivers/phy/ti/Kconfig                                                 |  19 ++-
 drivers/phy/ti/Makefile                                                |   1 +
 drivers/phy/ti/phy-j721e-wiz.c                                         | 959 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/phy/ti/phy-ti-pipe3.c                                          |  18 +--
 drivers/usb/renesas_usbhs/rcar2.c                                      |   2 +-
 drivers/usb/renesas_usbhs/rza2.c                                       |   2 +-
 include/dt-bindings/phy/phy.h                                          |   1 +
 include/linux/phy/phy-dp.h                                             |  95 +++++++++++++
 include/linux/phy/phy.h                                                |  14 +-
 42 files changed, 3635 insertions(+), 644 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/allwinner,sun9i-a80-usb-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/sun9i-usb-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
 create mode 100644 drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c
 create mode 100644 drivers/phy/intel/Kconfig
 create mode 100644 drivers/phy/intel/Makefile
 create mode 100644 drivers/phy/intel/phy-intel-emmc.c
 create mode 100644 drivers/phy/ti/phy-j721e-wiz.c
 create mode 100644 include/linux/phy/phy-dp.h
