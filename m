Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04973C33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 10:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACB5C20716
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 10:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580292846;
	bh=RRrMmBA0yOH1xJRlvvF6sSeRf6+OzC8X1Jiexj1Ydgo=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Emhq8p5+E9PjhJ8KLKJojoWk0ewr8JkGN8EEkRuWrHXq+1in8RnIKpieT4IrVd3sP
	 DR51BZp7exr3fLMVsmLinA/TlBqf9tYkvxu1qPqOKLwWQaSns1Jlwz39w/e9BL1Glr
	 dyfyzkw5dASgr2H75cMYl5+RiBGUm0lBO7le+Jn4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgA2KOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 05:14:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:57276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbgA2KOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 05:14:05 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4200A20716;
        Wed, 29 Jan 2020 10:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580292843;
        bh=RRrMmBA0yOH1xJRlvvF6sSeRf6+OzC8X1Jiexj1Ydgo=;
        h=Date:From:To:Cc:Subject:From;
        b=OYRk/sNQCstpztVAvz6twrGSNjLLm3LzJvGaBYTMRV9hMAxJkopfF6OLYyMm94Nas
         n7Hcz36WfalJ5NQTB7adUAsRTm65Klt2mQ4rxFUFEDJhwYL2lySktPc2MEBVi6Pby6
         ZrKieJjplCAFOeRq571sWua5MjkY0cWxfIIRwQh0=
Date:   Wed, 29 Jan 2020 11:14:01 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB/Thunderbolt/PHY patches for 5.6-rc1
Message-ID: <20200129101401.GA3858221@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit def9d2780727cec3313ed3522d0123158d87224d:

  Linux 5.5-rc7 (2020-01-19 16:02:49 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.6-rc1

for you to fetch changes up to eaa519983fd9e53c2a62a1e56777e1fb461865a9:

  Merge tag 'usb-serial-5.6-rc1' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-next (2020-01-27 10:21:22 +0100)

----------------------------------------------------------------
USB/Thunderbolt/PHY driver updates for 5.6-rc1

Here is the big USB and Thunderbolt and PHY driver updates for 5.6-rc1.

With the advent of USB4, "Thunderbolt" has really become USB4, so the
renaming of the Kconfig option and starting to share subsystem code has
begun, hence both subsystems coming in through the same tree here.

PHY driver updates also touched USB drivers, so that is coming in
through here as well.

Major stuff included in here are:
	- USB 4 initial support added (i.e. Thunderbolt)
	- musb driver updates
	- USB gadget driver updates
	- PHY driver updates
	- USB PHY driver updates
	- lots of USB serial stuff fixed up
	- USB typec updates
	- USB-IP fixes
	- lots of other smaller USB driver updates

All of these have been in linux-next for a while now (the usb-serial
tree is already tested in linux-next on its own before merged into
here), with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Ajay Gupta (1):
      usb: typec: ucsi: add support for separate DP altmode devices

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

Alan Stern (1):
      USB: usbfs: Always unlink URBs in reverse order

Alexandre Torgue (1):
      phy: core: Add consumer device link support

Alexandru M Stan (1):
      usb: dwc2: Fix NULL qh in dwc2_queue_transaction

Anil Varughese (1):
      phy: cadence: Sierra: Configure both lane cdb and common cdb registers for external SSC

Arnd Bergmann (1):
      usb: host: oxu210hp-hcd: fix gcc warning

Ben Dooks (Codethink) (1):
      USB: musb: fix __iomem in trace functions

Bin Liu (2):
      usb: dwc3: turn off VBUS when leaving host mode
      usb: musb: remove dummy driver musb_am335x.c

Bryan O'Donoghue (3):
      dt-bindings: connector: Improve the english of the initial description
      usb: gadget: f_ncm: Use atomic_t to track in-flight request
      usb: gadget: f_ecm: Use atomic_t to track in-flight request

Chuhong Yuan (1):
      phy: ti-pipe3: make clk operations symmetric in probe and remove

Colin Ian King (6):
      usb: typec: ucsi: fix spelling mistake "connetor" -> "connector"
      phy: cadence: Sierra: remove redundant initialization of pointer regmap
      thunderbolt: fix memory leak of object sw
      usb: musb: fix spelling mistake: "periperal" -> "peripheral"
      USB: serial: cyberjack: fix spelling mistake "To" -> "Too"
      usb: cdns3: fix spelling mistake and rework grammar in text

Dejin Zheng (1):
      usb: gadget: udc: core: Warn about failed to find udc

Dmitry Osipenko (20):
      dt-binding: usb: ci-hdrc-usb2: Document NVIDIA Tegra support
      usb: host: ehci-tegra: Correct teardown order of driver's removal
      usb: phy: tegra: Clean up ulpi_phy_power_off
      usb: phy: tegra: Keep track of power on-off state
      usb: phy: tegra: Hook up init/shutdown callbacks
      usb: phy: tegra: Perform general clean up of the code
      usb: phy: tegra: Clean up included headers
      usb: phy: tegra: Use relaxed versions of readl/writel
      usb: phy: tegra: Use generic stub for a missing VBUS regulator
      usb: ulpi: Add resource-managed variant of otg_ulpi_create()
      usb: phy: tegra: Use devm_otg_ulpi_create()
      usb: phy: tegra: Use u32 for hardware register variables
      usb: phy: tegra: Use device-tree notion of reset-GPIO's active-state
      usb: phy: tegra: Disable VBUS regulator on tegra_usb_phy_init failure
      usb: phy: tegra: Move utmip_pad_count checking under lock
      usb: phy: tegra: Keep CPU interrupts enabled
      usb: chipidea: tegra: Stop managing PHY's power
      usb: chipidea: tegra: Add USB_TEGRA_PHY to driver's dependencies
      usb: host: ehci-tegra: Stop managing PHY's power
      usb: host: ehci-tegra: Remove unused fields from tegra_ehci_hcd

Florian Fainelli (2):
      dt-bindings: phy: Document BCM7216 SATA PHY compatible string
      phy: brcm-sata: Implement 7216 initialization sequence

Geert Uytterhoeven (1):
      usb: host: ehci-sh: Remove unused platform data support

Greg Kroah-Hartman (6):
      Merge 5.5-rc2 into usb-next
      Merge 5.5-rc3 into usb-next
      Merge 5.5-rc6 into usb-next
      Merge tag 'phy-for-5.6_v2' of git://git.kernel.org/.../kishon/linux-phy into usb-next
      Merge 5.5-rc7 into usb-next
      Merge tag 'usb-serial-5.6-rc1' of https://git.kernel.org/.../johan/usb-serial into usb-next

Gustavo A. R. Silva (1):
      USB: serial: garmin_gps: Use flexible-array member

Heikki Krogerus (12):
      usb: typec: ucsi: Store the notification mask
      usb: typec: ucsi: Actually enable all the interface notifications
      usb: typec: Block mode entry if the port has the mode disabled
      usb: typec: Add parameter for the VDO to typec_altmode_enter()
      usb: typec: More API for cable handling
      usb: pd: Add definitions for the Enter_USB message
      usb: pd: Add definition for DFP and UFP1 VDOs
      usb: typec: Add the Product Type VDOs to struct usb_pd_identity
      usb: typec: Add definitions for the latest specification releases
      usb: typec: Give the mux drivers all the details regarding the port state
      usb: typec: Provide definitions for the USB modes
      usb: dwc3: pci: add ID for the Intel Comet Lake -V variant

Heiko Stuebner (2):
      dt-bindings: phy: drop #clock-cells from rockchip,px30-dsi-dphy
      phy/rockchip: inno-dsidphy: generalize parameter handling

Hongbo Yao (1):
      phy: ti: j721e-wiz: Fix build error without CONFIG_OF_ADDRESS

Jayshri Pawar (1):
      usb: cdns3: Add streams support to cadence USB3 DRD driver

Jia-Ju Bai (1):
      usb: gadget: udc: fix possible sleep-in-atomic-context bugs in gr_probe()

Johan Hovold (7):
      USB: serial: opticon: add chars_in_buffer() implementation
      USB: serial: opticon: stop all I/O on close()
      USB: serial: ir-usb: add missing endpoint sanity check
      USB: serial: ir-usb: fix link-speed handling
      USB: serial: ir-usb: fix IrLAP framing
      USB: serial: ir-usb: make set_termios synchronous
      USB: serial: ir-usb: simplify endpoint check

John Keeping (3):
      usb: dwc2: Fix IN FIFO allocation
      usb: dwc2: fix debugfs FIFO count
      usb: gadget: f_uac2: fix packet size calculation

Julia Lawall (2):
      usb: gadget: udc: atmel: constify copied structure
      USB: omap_udc: use resource_size

Jun Li (3):
      usb: chipidea: handle single role for usb role class
      usb: chipidea: add inline for ci_hdrc_host_driver_init if host is not defined
      usb: typec: tcpci: mask event interrupts when remove driver

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

Krzysztof Kozlowski (9):
      phy: hisilicon: Fix Kconfig indentation
      usb: host: Enable compile testing for some of drivers
      usb: phy: Enable compile testing for some of drivers
      usb: host: Do not compile test deprecated USB_OCTEON_EHCI
      phy: Enable compile testing for some of drivers
      usb: ehci-mv: Fix missing iomem in cast
      usb: exynos: Rename Samsung and Exynos to lowercase
      phy: mediatek: Fix Kconfig indentation
      phy: Enable compile testing for some of drivers

Linus Walleij (5):
      usb: renesas_usbhs: Switch to GPIO descriptor
      usb: usb3503: Convert to use GPIO descriptors
      usb: phy-generic: Delete unused platform data
      usb: musb: davinci: Convert to use GPIO descriptor
      usb: phy: phy-gpio-vbus-usb: Convert to GPIO descriptors

Lubomir Rintel (3):
      USB: EHCI: ehci-mv: make the PHY optional
      USB: EHCI: ehci-mv: drop pxa_ehci_type and some device IDs
      USB: EHCI: ehci-mv: add HSIC support

Lukas Wunner (1):
      usb: dwc2: Drop unlock/lock upon queueing a work item

Ma Feng (1):
      phy: lantiq: vrx200-pcie: Remove unneeded semicolon

Magnus Damm (1):
      tools: usb: usbip: Get rid of driver name printout in README

Mans Rullgard (1):
      usb: musb: sunxi: propagate devicetree node to glue pdev

Marek Szyprowski (1):
      ARM: dts: qcom: Correct USB3503 GPIOs polarity

Masahiro Yamada (1):
      usb: gadget: move choice ... endchoice to legacy/Kconfig

Maxime Ripard (1):
      dt-bindings: usb: Convert Allwinner A80 USB PHY controller to a schema

Mika Westerberg (8):
      thunderbolt: Make tb_find_port() available to other files
      thunderbolt: Call tb_eeprom_get_drom_offset() from tb_eeprom_read_n()
      thunderbolt: Populate PG field in hot plug acknowledgment packet
      thunderbolt: Add initial support for USB4
      thunderbolt: Update Kconfig entries to USB4
      thunderbolt: Update documentation with the USB4 information
      thunderbolt: Fix xhci check in usb4_switch_setup()
      MAINTAINERS: Use linux-usb mailing list for Thunderbolt and USB4 patches

Min Guo (5):
      dt-bindings: usb: musb: Add support for MediaTek musb controller
      usb: musb: Add get/set toggle hooks
      usb: musb: Add noirq type of dma create interface
      usb: musb: Add musb_clearb/w() interface
      usb: musb: Add support for MediaTek musb controller

Minas Harutyunyan (1):
      usb: dwc2: Fix Stalling a Non-Isochronous OUT EP

Nathan Chancellor (1):
      phy: qualcomm: Adjust indentation in read_poll_timeout

Nishad Kamdar (1):
      phy: qcom-qmp: Use the correct style for SPDX License Identifier

Paul Cercueil (7):
      usb: musb: jz4740: Drop dependency on NOP_USB_XCEIV
      usb: musb: jz4740: Suppress useless field in priv structure
      usb: musb: jz4740: Add local dev variable to clean up probe
      usb: musb: jz4740: Constify jz4740_musb_pdata struct
      usb: musb: jz4740: Rename platform_device field in priv struct
      usb: musb: jz4740: Comments fix
      usb: musb: jz4740: Whitespace and indentation fixes

Peter Chen (4):
      usb: gadget: f_fs: set req->num_sgs as 0 for non-sg transfer
      usb: cdns3: add NXP imx8qm glue layer
      usb: phy: show USB charger type for user
      Doc: ABI: add usb charger uevent

Peter Robinson (1):
      usb: host: xhci-tegra: set MODULE_FIRMWARE for tegra186

Peter Ujfalusi (1):
      usb: musb/ux500: Use dma_request_chan() instead dma_request_slave_channel()

Rajmohan Mani (3):
      thunderbolt: Make tb_switch_find_cap() available to other files
      thunderbolt: Add support for Time Management Unit
      thunderbolt: Add support for USB 3.x tunnels

Ramuthevar Vadivel Murugan (3):
      dt-bindings: phy: intel-emmc-phy: Add YAML schema for LGM eMMC PHY
      phy: intel-lgm-emmc: Add support for eMMC PHY
      phy: intel-lgm-emmc: Fix warning by adding missing MODULE_LICENSE

Randy Dunlap (2):
      usb: drop comment about 2 uhci drivers
      usb: typec: fix non-kernel-doc comments

Roger Quadros (4):
      phy: cadence: Sierra: add phy_reset hook
      dt-bindings: phy: ti,phy-j721e-wiz: Add Type-C dir GPIO
      phy: ti: j721e-wiz: Manage typec-gpio-dir
      usb: gadget: legacy: set max_speed to super-speed

Saurav Girepunje (1):
      usb: musb: core: Update the function description

Shuah Khan (1):
      usbip: Fix unsafe unaligned pointer usage

Stephan Gerhold (1):
      usb: phy: ab8500-usb: Keep PHY turned on in UART mode

Takashi Iwai (2):
      usb: gadget: u_audio: Use managed buffer allocation
      usb: gadget: u_audio: Drop superfluous ioctl PCM ops

Thierry Reding (10):
      usb: host: xhci-tegra: Fix "tega" -> "tegra" typo
      usb: host: xhci-tegra: Separate firmware request and load
      usb: host: xhci-tegra: Avoid a fixed duration sleep
      usb: host: xhci-tegra: Use CNR as firmware ready indicator
      usb: host: xhci-tegra: Extract firmware enable helper
      usb: host: xhci-tegra: Reuse stored register base address
      usb: host: xhci-tegra: Enable runtime PM as late as possible
      usb: host: xhci-tegra: Add support for XUSB context save/restore
      usb: host: xhci-tegra: Add XUSB controller context
      usb: host: xhci-tegra: Implement basic ELPG support

Thinh Nguyen (7):
      usb: dwc3: gadget: Don't send unintended link state change
      usb: dwc3: gadget: Set link state to RX_Detect on disconnect
      usb: dwc3: gadget: Clear DCTL.ULSTCHNGREQ before set
      usb: gadget: configfs: Add max_speed setting
      usb: dwc3: gadget: Check END_TRANSFER completion
      usb: dwc3: gadget: Delay starting transfer
      usb: dwc3: gadget: Remove END_TRANSFER delay

Thomas Hebb (2):
      usb: typec: wcove: fix "op-sink-microwatt" default that was in mW
      usb: typec: fusb302: fix "op-sink-microwatt" default that was in mW

Tomasz Figa (1):
      usb: mtk-xhci: Do not explicitly set the DMA mask

Tony Lindgren (7):
      usb: musb: omap2430: Get rid of musb .set_vbus for omap2430 glue
      usb: musb: omap2430: Wait on enable to avoid babble
      usb: musb: omap2430: Handle multiple ID ground interrupts
      usb: musb: Add musb_set_host and peripheral and use them for omap2430
      usb: musb: omap2430: Clean up enable and remove devctl tinkering
      usb: musb: omap2430: Idle musb on init
      usb: musb: Get rid of omap2430_musb_set_vbus()

Vinod Koul (4):
      phy: qcom-qmp: Use register defines
      phy: qcom-qmp: remove duplicate powerdown write
      phy: qcom-qmp: remove no_pcs_sw_reset for sm8150
      phy: qcom-qmp: Add SW reset register

Wei Yongjun (1):
      phy: ti: j721e-wiz: Fix return value check in wiz_probe()

Xu Wang (1):
      usb: cdns3: gadget: Remove unneeded variable ret

Yuti Amonkar (1):
      phy: Add DisplayPort configuration options

 Documentation/ABI/testing/configfs-usb-gadget      |   4 +
 Documentation/ABI/testing/usb-charger-uevent       |  46 +
 Documentation/admin-guide/thunderbolt.rst          |  30 +-
 .../bindings/connector/usb-connector.txt           |   4 +-
 .../bindings/phy/allwinner,sun9i-a80-usb-phy.yaml  | 135 +++
 .../bindings/phy/brcm,brcmstb-usb-phy.txt          |  69 +-
 .../devicetree/bindings/phy/brcm-sata-phy.txt      |   1 +
 .../bindings/phy/intel,lgm-emmc-phy.yaml           |  56 ++
 .../devicetree/bindings/phy/phy-cadence-sierra.txt |  13 +-
 .../bindings/phy/rockchip,px30-dsi-dphy.yaml       |   5 -
 .../devicetree/bindings/phy/sun9i-usb-phy.txt      |  37 -
 .../devicetree/bindings/phy/ti,phy-j721e-wiz.yaml  | 221 +++++
 .../devicetree/bindings/usb/ci-hdrc-usb2.txt       |   4 +
 .../devicetree/bindings/usb/mediatek,musb.txt      |  57 ++
 MAINTAINERS                                        |   1 +
 .../boot/dts/qcom-mdm9615-wp8548-mangoh-green.dts  |   2 +-
 arch/arm/mach-davinci/board-dm644x-evm.c           |  12 +
 arch/arm/mach-pxa/colibri-pxa320.c                 |  16 +-
 arch/arm/mach-pxa/eseries.c                        |  40 +-
 arch/arm/mach-pxa/gumstix.c                        |  18 +-
 arch/arm/mach-pxa/hx4700.c                         |  22 +-
 arch/arm/mach-pxa/magician.c                       |  22 +-
 arch/arm/mach-pxa/mioa701.c                        |  15 +-
 arch/arm/mach-pxa/palm27x.c                        |  34 +-
 arch/arm/mach-pxa/palmt5.c                         |   1 -
 arch/arm/mach-pxa/palmtc.c                         |  18 +-
 arch/arm/mach-pxa/palmte2.c                        |  18 +-
 arch/arm/mach-pxa/palmtx.c                         |   1 -
 arch/arm/mach-pxa/palmz72.c                        |   1 -
 arch/arm/mach-pxa/tosa.c                           |  18 +-
 arch/arm/mach-pxa/vpac270.c                        |  15 +-
 arch/arm/mach-s3c64xx/mach-smartq.c                |  13 +-
 drivers/Makefile                                   |   2 +-
 drivers/net/Kconfig                                |  10 +-
 drivers/net/Makefile                               |   2 +-
 drivers/phy/Kconfig                                |   1 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/allwinner/Kconfig                      |   3 +-
 drivers/phy/broadcom/Kconfig                       |   4 +-
 drivers/phy/broadcom/Makefile                      |   2 +-
 drivers/phy/broadcom/phy-brcm-sata.c               | 120 +++
 drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c  | 414 +++++++++
 drivers/phy/broadcom/phy-brcm-usb-init.c           | 226 ++---
 drivers/phy/broadcom/phy-brcm-usb-init.h           | 148 +++-
 drivers/phy/broadcom/phy-brcm-usb.c                | 269 ++++--
 drivers/phy/cadence/phy-cadence-sierra.c           | 709 ++++++++++++---
 drivers/phy/hisilicon/Kconfig                      |  16 +-
 drivers/phy/intel/Kconfig                          |   9 +
 drivers/phy/intel/Makefile                         |   2 +
 drivers/phy/intel/phy-intel-emmc.c                 | 284 ++++++
 drivers/phy/lantiq/phy-lantiq-vrx200-pcie.c        |   2 +-
 drivers/phy/marvell/Kconfig                        |   8 +-
 drivers/phy/mediatek/Kconfig                       |  25 +-
 drivers/phy/phy-core.c                             |  49 +-
 drivers/phy/qualcomm/phy-qcom-apq8064-sata.c       |   2 +-
 drivers/phy/qualcomm/phy-qcom-qmp.c                |   7 +-
 drivers/phy/qualcomm/phy-qcom-qmp.h                |   2 +-
 drivers/phy/rockchip/Kconfig                       |   1 +
 drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c   | 319 +++----
 drivers/phy/samsung/Kconfig                        |   8 +-
 drivers/phy/ti/Kconfig                             |  20 +-
 drivers/phy/ti/Makefile                            |   1 +
 drivers/phy/ti/phy-j721e-wiz.c                     | 959 +++++++++++++++++++++
 drivers/phy/ti/phy-ti-pipe3.c                      |  18 +-
 drivers/thunderbolt/Kconfig                        |  11 +-
 drivers/thunderbolt/Makefile                       |   4 +-
 drivers/thunderbolt/cap.c                          |  11 +-
 drivers/thunderbolt/ctl.c                          |  19 +-
 drivers/thunderbolt/ctl.h                          |   3 +-
 drivers/thunderbolt/eeprom.c                       | 137 +--
 drivers/thunderbolt/nhi.c                          |   3 +
 drivers/thunderbolt/nhi.h                          |   2 +
 drivers/thunderbolt/switch.c                       | 441 +++++++---
 drivers/thunderbolt/tb.c                           | 227 +++--
 drivers/thunderbolt/tb.h                           | 101 +++
 drivers/thunderbolt/tb_msgs.h                      |   6 +-
 drivers/thunderbolt/tb_regs.h                      |  65 +-
 drivers/thunderbolt/tmu.c                          | 383 ++++++++
 drivers/thunderbolt/tunnel.c                       | 169 +++-
 drivers/thunderbolt/tunnel.h                       |   9 +
 drivers/thunderbolt/usb4.c                         | 764 ++++++++++++++++
 drivers/thunderbolt/xdomain.c                      |   6 +
 drivers/usb/cdns3/Kconfig                          |  10 +
 drivers/usb/cdns3/Makefile                         |   1 +
 drivers/usb/cdns3/cdns3-imx.c                      | 216 +++++
 drivers/usb/cdns3/debug.h                          |   2 +-
 drivers/usb/cdns3/gadget.c                         | 536 +++++++++++-
 drivers/usb/cdns3/gadget.h                         |  26 +-
 drivers/usb/cdns3/trace.h                          |  93 +-
 drivers/usb/chipidea/Kconfig                       |   1 +
 drivers/usb/chipidea/ci.h                          |  10 +
 drivers/usb/chipidea/ci_hdrc_tegra.c               |   9 -
 drivers/usb/chipidea/core.c                        |   4 +-
 drivers/usb/chipidea/host.h                        |   2 +-
 drivers/usb/core/devio.c                           |   4 +-
 drivers/usb/dwc2/core_intr.c                       |   7 +-
 drivers/usb/dwc2/debugfs.c                         |   3 +-
 drivers/usb/dwc2/gadget.c                          |  25 +-
 drivers/usb/dwc2/hcd.c                             |   2 +-
 drivers/usb/dwc3/core.c                            |   3 +
 drivers/usb/dwc3/core.h                            |   2 +
 drivers/usb/dwc3/dwc3-exynos.c                     |   4 +-
 drivers/usb/dwc3/dwc3-pci.c                        |   4 +
 drivers/usb/dwc3/ep0.c                             |   4 +-
 drivers/usb/dwc3/gadget.c                          |  56 +-
 drivers/usb/dwc3/gadget.h                          |  14 +
 drivers/usb/gadget/Kconfig                         |  28 -
 drivers/usb/gadget/configfs.c                      |  43 +
 drivers/usb/gadget/function/f_ecm.c                |  16 +-
 drivers/usb/gadget/function/f_fs.c                 |   2 +
 drivers/usb/gadget/function/f_ncm.c                |  17 +-
 drivers/usb/gadget/function/u_audio.c              |  29 +-
 drivers/usb/gadget/legacy/Kconfig                  |  28 +
 drivers/usb/gadget/legacy/cdc2.c                   |   2 +-
 drivers/usb/gadget/legacy/g_ffs.c                  |   2 +-
 drivers/usb/gadget/legacy/multi.c                  |   2 +-
 drivers/usb/gadget/legacy/ncm.c                    |   2 +-
 drivers/usb/gadget/udc/atmel_usba_udc.c            |   2 +-
 drivers/usb/gadget/udc/core.c                      |   2 +
 drivers/usb/gadget/udc/gr_udc.c                    |  16 +-
 drivers/usb/gadget/udc/omap_udc.c                  |   6 +-
 drivers/usb/host/Kconfig                           |  56 +-
 drivers/usb/host/ehci-exynos.c                     |   4 +-
 drivers/usb/host/ehci-mv.c                         |  21 +-
 drivers/usb/host/ehci-sh.c                         |   7 -
 drivers/usb/host/ehci-tegra.c                      |  16 +-
 drivers/usb/host/ohci-exynos.c                     |   2 +-
 drivers/usb/host/oxu210hp-hcd.c                    |  14 +-
 drivers/usb/host/xhci-mtk.c                        |   5 -
 drivers/usb/host/xhci-tegra.c                      | 440 ++++++++--
 drivers/usb/misc/usb3503.c                         |  94 +-
 drivers/usb/musb/Kconfig                           |  12 +-
 drivers/usb/musb/Makefile                          |   4 +-
 drivers/usb/musb/davinci.c                         |  57 +-
 drivers/usb/musb/jz4740.c                          |  75 +-
 drivers/usb/musb/mediatek.c                        | 582 +++++++++++++
 drivers/usb/musb/musb_am335x.c                     |  44 -
 drivers/usb/musb/musb_core.c                       | 188 +++-
 drivers/usb/musb/musb_core.h                       |  20 +-
 drivers/usb/musb/musb_dma.h                        |   9 +
 drivers/usb/musb/musb_host.c                       |  46 +-
 drivers/usb/musb/musb_io.h                         |  18 +-
 drivers/usb/musb/musb_trace.h                      |  33 +-
 drivers/usb/musb/musbhsdma.c                       |  56 +-
 drivers/usb/musb/omap2430.c                        | 164 +---
 drivers/usb/musb/sunxi.c                           |   6 +-
 drivers/usb/musb/tusb6010.c                        |   2 +-
 drivers/usb/musb/ux500_dma.c                       |   4 +-
 drivers/usb/phy/Kconfig                            |   4 +-
 drivers/usb/phy/phy-ab8500-usb.c                   |  26 +-
 drivers/usb/phy/phy-am335x.c                       |   2 +-
 drivers/usb/phy/phy-generic.c                      |  39 +-
 drivers/usb/phy/phy-generic.h                      |   3 +-
 drivers/usb/phy/phy-gpio-vbus-usb.c                |  96 +--
 drivers/usb/phy/phy-keystone.c                     |   2 +-
 drivers/usb/phy/phy-tegra-usb.c                    | 896 ++++++++++---------
 drivers/usb/phy/phy-ulpi.c                         |  48 +-
 drivers/usb/phy/phy.c                              |  13 +-
 drivers/usb/renesas_usbhs/common.c                 |  22 +-
 drivers/usb/renesas_usbhs/rcar2.c                  |   4 +-
 drivers/usb/renesas_usbhs/rza2.c                   |   2 +-
 drivers/usb/serial/Kconfig                         |   3 -
 drivers/usb/serial/cyberjack.c                     |   2 +-
 drivers/usb/serial/garmin_gps.c                    |   2 +-
 drivers/usb/serial/ir-usb.c                        | 185 ++--
 drivers/usb/serial/opticon.c                       |  61 +-
 drivers/usb/typec/altmodes/displayport.c           |   5 +-
 drivers/usb/typec/bus.c                            |  42 +-
 drivers/usb/typec/class.c                          |  52 +-
 drivers/usb/typec/mux.c                            |   2 +-
 drivers/usb/typec/mux/pi3usb30532.c                |   5 +-
 drivers/usb/typec/tcpm/fusb302.c                   |   2 +-
 drivers/usb/typec/tcpm/tcpci.c                     |   6 +
 drivers/usb/typec/tcpm/tcpm.c                      |   6 +-
 drivers/usb/typec/tcpm/wcove.c                     |   2 +-
 drivers/usb/typec/ucsi/displayport.c               |   2 +-
 drivers/usb/typec/ucsi/ucsi.c                      |  95 +-
 drivers/usb/typec/ucsi/ucsi.h                      |  14 +
 drivers/usb/typec/ucsi/ucsi_ccg.c                  | 191 +++-
 include/dt-bindings/phy/phy.h                      |   1 +
 include/linux/phy/phy-dp.h                         |  95 ++
 include/linux/phy/phy.h                            |  14 +-
 include/linux/platform_data/ehci-sh.h              |  16 -
 include/linux/platform_data/mv_usb.h               |   8 -
 include/linux/platform_data/usb3503.h              |   3 -
 include/linux/usb/gpio_vbus.h                      |  33 -
 include/linux/usb/irda.h                           |  13 +-
 include/linux/usb/pd.h                             |  33 +-
 include/linux/usb/pd_vdo.h                         |  32 +
 include/linux/usb/renesas_usbhs.h                  |   2 -
 include/linux/usb/tegra_usb_phy.h                  |   4 +-
 include/linux/usb/typec.h                          |   9 +
 include/linux/usb/typec_altmode.h                  |  20 +-
 include/linux/usb/typec_mux.h                      |  10 +-
 include/linux/usb/ulpi.h                           |  11 +
 include/linux/usb/usb_phy_generic.h                |  12 -
 tools/usb/usbip/README                             |  22 +-
 tools/usb/usbip/src/usbip_network.c                |  40 +-
 tools/usb/usbip/src/usbip_network.h                |  12 +-
 199 files changed, 9924 insertions(+), 2467 deletions(-)
 create mode 100644 Documentation/ABI/testing/usb-charger-uevent
 create mode 100644 Documentation/devicetree/bindings/phy/allwinner,sun9i-a80-usb-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/sun9i-usb-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/mediatek,musb.txt
 create mode 100644 drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c
 create mode 100644 drivers/phy/intel/Kconfig
 create mode 100644 drivers/phy/intel/Makefile
 create mode 100644 drivers/phy/intel/phy-intel-emmc.c
 create mode 100644 drivers/phy/ti/phy-j721e-wiz.c
 create mode 100644 drivers/thunderbolt/tmu.c
 create mode 100644 drivers/thunderbolt/usb4.c
 create mode 100644 drivers/usb/cdns3/cdns3-imx.c
 create mode 100644 drivers/usb/musb/mediatek.c
 delete mode 100644 drivers/usb/musb/musb_am335x.c
 create mode 100644 include/linux/phy/phy-dp.h
 delete mode 100644 include/linux/platform_data/ehci-sh.h
 delete mode 100644 include/linux/usb/gpio_vbus.h
