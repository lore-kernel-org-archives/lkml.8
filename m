Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CBBC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 10:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C16B320578
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 10:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585565078;
	bh=0Y9ledfBr8GXgH2/hIFQuL9xwXTXA2qQZaxczTL2g+s=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Mifry8J90nYUF6xalqPw5pM2cWckjBMMYpscfaCR/LCMrNB8Mr805h/H55MhnALJV
	 ArrTndkZHgS/WaNQXM47gbJm8zB5SCybNUCG8fKinNeoMIePnBw0nkNd7en+NHmLZo
	 dUQkaNfz6+keJqvgHlxCWvIQHmV8wfWgI0RVOP5c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729409AbgC3Kog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 06:44:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:49392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728859AbgC3Kog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 06:44:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03BF3205ED;
        Mon, 30 Mar 2020 10:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585565073;
        bh=0Y9ledfBr8GXgH2/hIFQuL9xwXTXA2qQZaxczTL2g+s=;
        h=Date:From:To:Cc:Subject:From;
        b=vmHsJ7awAyuaeKtYd5mK4YioPWByHyYCsBnt9HjBEQVQAPlsFKaT+zfgESceiUVZY
         9JjpK1l8hpq6mVGCvzcFlnYARHefF8Q8ySnOKPPRlOi0TV2b1M5AYZw/40Bm3qkjj1
         nYy2i5oTFEY6mtxgqHcVy8qfS1uHy7GegK+ijYDk=
Date:   Mon, 30 Mar 2020 12:44:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB/PHY patches for 5.7-rc1
Message-ID: <20200330104431.GA739262@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 16fbf79b0f83bc752cee8589279f1ebfe57b3b6e:

  Linux 5.6-rc7 (2020-03-22 18:31:56 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.7-rc1

for you to fetch changes up to 62d65bdd9d05158aa2547f8ef72375535f3bc6e3:

  USB: cdc-acm: restore capability check order (2020-03-27 16:24:16 +0100)

----------------------------------------------------------------
USB / PHY patches for 5.7-rc1

Here are the big set of USB and PHY driver patches for 5.7-rc1.

Nothing huge here, some new PHY drivers, loads of USB gadget fixes and
updates, xhci updates, usb-serial driver updates and new device ids, and
other minor things.  Full details in the shortlog.

All have been in linux-next for a while with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Ajay Gupta (3):
      usb: typec: ucsi: register DP only for NVIDIA DP VDO
      usb: ucsi: ccg: disable runtime pm during fw flashing
      usb: typec: ucsi_ccg: workaround for NVIDIA test device

Alexandre Belloni (2):
      usb: gadget: amd5536udc: fix spelling mistake "reserverd" -> "reserved"
      usb: gadget: amd5536udc: fix spelling mistake "reserverd" -> "reserved"

Amelie Delaunay (1):
      usb: dwc2: add support for STM32MP15 SoCs USB OTG HS and FS

Anand Moon (1):
      usb: dwc3: exynos: Add support for Exynos5422 suspend clk

Andrey Konovalov (2):
      usb: gadget: add raw-gadget interface
      usb: raw_gadget: fix compilation warnings in uapi headers

Andy Shevchenko (5):
      usb: core: Make use of acpi_evaluate_object() status
      usb: core: Use ACPI_SUCCESS() at appropriate places
      usb: dwc3: Add ACPI support for xHCI ports
      usb: dwc3: Remove kernel doc annotation where it's not needed
      usb: core: Add ACPI support for USB interface devices

Azhar Shaikh (1):
      usb: typec: Correct the documentation for typec_cable_put()

Badhri Jagan Sridharan (1):
      usb: typec: Add sysfs node to show cc orientation

Bastien Nocera (6):
      USB: Export generic USB device driver functions
      USB: Make it possible to "subclass" usb_device_driver
      USB: Implement usb_device_match_id()
      USB: Select better matching USB drivers when available
      USB: Fallback to generic driver when specific driver fails
      USB: Add driver to control USB fast charge for iOS devices

Bjorn Andersson (5):
      dt-bindings: phy-qcom-qmp: Add SDM845 PCIe to binding
      phy: qcom: qmp: Add SDM845 PCIe QMP PHY support
      phy: qcom: qmp: Add SDM845 QHP PCIe PHY
      phy: qcom-qmp: Add MSM8996 UFS QMP support
      phy: qcom: qmp: Use power_on/off ops for PCIe

Christoph Muellner (1):
      phy: rk-inno-usb2: Decrease verbosity of repeating log.

Chunfeng Yun (10):
      dt-bindings: phy-mtk-tphy: add two optional properties for u2phy
      dt-bindings: phy-mtk-tphy: make the ref clock optional
      dt-bindings: phy-mtk-tphy: remove unused u3phya_ref clock
      dt-bindings: phy-mtk-tphy: add a new reference clock
      dt-bindings: phy-mtk-tphy: add the properties about address mapping
      phy: phy-mtk-tphy: add a property for disconnect threshold
      phy: phy-mtk-tphy: add a property for internal resistance
      phy: phy-mtk-tphy: make the ref clock optional
      phy: phy-mtk-tphy: remove unused u3phya_ref clock
      phy: phy-mtk-tphy: add a new reference clock

Colin Ian King (9):
      USB: serial: digi_acceleport: remove redundant assignment to pointer priv
      usb: typec: ucsi: remove redundant assignment to variable num
      usb: gadget: remove redundant assignment to variable status
      usb: cdns3: remove redundant assignment to pointer trb
      usb: gadget: remove redundant assignment to variable status
      usb: cdns3: remove redundant assignment to pointer trb
      usb: musb: remove redundant assignment to variable ret
      usb: cdns3: fix spelling mistake "wrapperr" -> "wrapper"
      usb: cdns3: make signed 1 bit bitfields unsigned

Corentin Labbe (21):
      usb: gadget: legacy: gmidi: remove useless cast for driver.name
      usb: gadget: legacy: inode: remove useless cast for driver.name
      usb: gadget: udc: amd5536udc_pci: remove useless cast for driver.name
      usb: gadget: at91_udc: remove useless cast for driver.name
      usb: gadget: dummy_hcd: remove useless cast for driver.name
      usb: gadget: fotg210-udc: remove useless cast for driver.name
      usb: gadget: fusb300_udc: remove useless cast for driver.name
      usb: gadget: goku_udc: remove useless cast for driver.name
      usb: gadget: lpc32xx_udc: remove useless cast for driver.name
      usb: gadget: m66592-udc: remove useless cast for driver.name
      usb: gadget: net2280: remove useless cast for driver.name
      usb: gadget: omap_udc: remove useless cast for driver.name
      usb: gadget: r8a66597-udc: remove useless cast for driver.name
      usb: gadget: renesas_usb3: remove useless cast for driver.name
      usb: host: ehci-pci: remove useless cast for driver.name
      usb: host: ohci-pci: remove useless cast for driver.name
      usb: host: sl811-hcd: remove useless cast for driver.name
      usb: host: uhci-pci: remove useless cast for driver.name
      usb: host: xhci-pci: remove useless cast for driver.name
      usb: musb: core: remove useless cast for driver.name
      phy: tegra: Select USB_PHY

Dejin Zheng (5):
      drivers: provide devm_platform_get_and_ioremap_resource()
      usb: host: xhci-plat: convert to devm_platform_get_and_ioremap_resource
      usb: host: hisilicon: convert to devm_platform_get_and_ioremap_resource
      usb: dwc2: convert to devm_platform_get_and_ioremap_resource
      driver core: platform: Reimplement devm_platform_ioremap_resource

Felipe Balbi (1):
      usb: dwc3: trace: print enqueue/dequeue pointers too

Geert Uytterhoeven (2):
      usb: dwc3: qcom: Replace <linux/clk-provider.h> by <linux/of_clk.h>
      usb: dwc3: qcom: Replace <linux/clk-provider.h> by <linux/of_clk.h>

Greg Kroah-Hartman (9):
      Merge 5.6-rc3 into usb-next
      Merge 5.6-rc5 into usb-next
      Merge tag 'usb-for-v5.7' of git://git.kernel.org/.../balbi/usb into usb-next
      Merge tag 'thunderbolt-for-v5.7' of git://git.kernel.org/.../westeri/thunderbolt into usb-next
      Merge tag 'usb-ci-v5.7-rc1' of git://git.kernel.org/.../peter.chen/usb into usb-next
      Merge tag 'tegra-for-5.7-usb-v2' of git://git.kernel.org/.../tegra/linux into usb-next
      Merge tag 'phy-for-5.7' of git://git.kernel.org/.../kishon/linux-phy into usb-next
      Merge 5.6-rc7 into usb-next
      Merge tag 'usb-serial-5.7-rc1' of https://git.kernel.org/.../johan/usb-serial into usb-next

Grygorii Strashko (2):
      dt-bindings: phy: ti: gmii-sel: add support for am654x/j721e soc
      phy: ti: gmii-sel: add support for am654x/j721e soc

Gustavo A. R. Silva (7):
      USB: atm: Replace zero-length array with flexible-array member
      thunderbolt: eeprom: Replace zero-length array with flexible-array member
      thunderbolt: icm: Replace zero-length array with flexible-array member
      USB: musb: Replace zero-length array with flexible-array member
      usb: gadget: f_phonet: Replace zero-length array with flexible-array member
      USB: Replace zero-length array with flexible-array member
      usb: gadget: f_phonet: Replace zero-length array with flexible-array member

Hanjie Lin (4):
      dt-bindings: usb: dwc3: Add the Amlogic A1 Family DWC3 Glue Bindings
      usb: dwc3: Add Amlogic A1 DWC3 glue
      dt-bindings: phy: Add Amlogic A1 USB2 PHY Bindings
      phy: amlogic: Add Amlogic A1 USB2 PHY Driver

Heikki Krogerus (15):
      usb: typec: Make the attributes read-only when writing is not possible
      usb: typec: Hide the port_type attribute when it's not supported
      usb: typec: Allow power role swapping even without USB PD
      usb: typec: Fix the description of struct typec_capability
      usb: typec: altmode: Remove the notification chain
      usb: typec: mux: Drop support for device name matching
      usb: typec: mux: Allow the muxes to be named
      usb: typec: mux: Add helpers for setting the mux state
      usb: typec: mux: Allow the mux handles to be requested with fwnode
      usb: roles: Leave the private driver data pointer to the drivers
      usb: roles: Provide the switch drivers handle to the switch in the API
      usb: roles: Allow the role switches to be named
      device property: Export fwnode_get_name()
      usb: typec: Add definitions for Thunderbolt 3 Alternate Mode
      usb: typec: driver for Intel PMC mux control

JC Kuo (3):
      usb: host: xhci-tegra: Tegra186/Tegra194 LPM
      phy: tegra: xusb: Protect Tegra186 soc with config
      phy: tegra: xusb: Add Tegra194 support

Jassi Brar (2):
      dt-bindings: max3421-udc: add dt bindings for MAX3420 UDC
      usb: gadget: add udc driver for max3420

Ji-Ze Hong (Peter Hong) (6):
      USB: serial: f81232: extract LSR handler
      USB: serial: f81232: add tx_empty function
      USB: serial: f81232: use devm_kzalloc for port data
      USB: serial: f81232: add F81534A support
      USB: serial: f81232: set F81534A serial port with RS232 mode
      USB: serial: f81232: add control driver for F81534A

Joe Perches (2):
      usb-storage: Use const to reduce object data size
      phy: amlogic: G12A: Fix misuse of GENMASK macro

Johan Hovold (3):
      USB: serial: relax unthrottle memory barrier
      USB: serial: clean up carrier-detect helper
      USB: serial: fix tty cleanup-op kernel-doc

Johan Jonker (2):
      dt-bindings: usb: dwc2: add compatible property for rk3328 usb
      dt-bindings: usb: dwc2: add compatible property for rk3368 usb

John Keeping (1):
      usb: dwc2: Implement set_selfpowered()

John Stultz (5):
      dt-bindings: usb: generic: Add role-switch-default-mode binding
      usb: dwc3: Add support for role-switch-default-mode binding
      dt-bindings: usb: dwc3: Allow clock list & resets to be more flexible
      usb: dwc3: Rework clock initialization to be more flexible
      usb: dwc3: Rework resets initialization to be more flexible

Jon Hunter (1):
      phy: tegra: xusb: Don't warn on probe defer

Jorge Ramirez-Ortiz (3):
      dt-bindings: phy: remove qcom-dwc3-usb-phy
      dt-bindings: Add Qualcomm USB SuperSpeed PHY bindings
      phy: qualcomm: usb: Add SuperSpeed PHY driver

Jules Irenge (2):
      xhci: Add missing annotation for xhci_set_port_power()
      xhci: Add missing annotation for xhci_enter_test_mode

Kai-Heng Feng (2):
      xhci: Ensure link state is U3 after setting USB_SS_PORT_LS_U3
      xhci: Wait until link state trainsits to U0 after setting USB_SS_PORT_LS_U0

Kees Cook (1):
      usb: gadget: net2280: Distribute switch variables for initialization

Krzysztof Kozlowski (1):
      usb: phy: tegra: Include proper GPIO consumer header to fix compile testing

Kunihiko Hayashi (7):
      phy: socionext: Use devm_platform_ioremap_resource()
      dt-bindings: phy: socionext: Add Pro5 support and remove Pro4 from usb3-hsphy
      phy: uniphier-usb3ss: Add Pro5 support
      phy: uniphier-usb3hs: Add legacy SoC support for Pro5
      phy: uniphier-usb3hs: Change Rx sync mode to avoid communication failure
      phy: uniphier-pcie: Add legacy SoC support for Pro5
      phy: uniphier-pcie: Add SoC-dependent phy-mode function support

Li Jun (3):
      usb: typec: tcpm: set correct data role for non-DRD
      usb: typec: tcpm: move to SNK_UNATTACHED if sink removed for DRP
      usb: dwc3: core: don't do suspend for device mode if already suspended

Lubomir Rintel (2):
      USB: EHCI: ehci-mv: switch the HSIC HCI to HSIC mode
      USB: EHCI: ehci-mv: use a unique bus name

Macpaul Lin (1):
      usb: musb: tusb6010: fix a possible missing data type replacement

Mans Rullgard (1):
      usb: musb: fix crash with highmen PIO and usbmon

Marek Szyprowski (3):
      udc: s3c-hsudc: Silence warning about supplies during deferred probe
      usb: dwc2: Silence warning about supplies during deferred probe
      udc: s3c-hsudc: Silence warning about supplies during deferred probe

Masahiro Yamada (1):
      usb: get rid of 'choice' for legacy gadget drivers

Mathias Nyman (4):
      xhci: bail out early if driver can't accress host in resume
      xhci: Add a separate debug message for split transaction errors.
      xhci: Show host status when watchdog triggers and host is assumed dead.
      xhci: Finetune host initiated USB3 rootport link suspend and resume

Matthias Reichl (1):
      USB: cdc-acm: restore capability check order

Mika Westerberg (2):
      thunderbolt: Add missing kernel-doc parameter descriptions
      xhci-pci: Allow host runtime PM as default for Intel Tiger Lake xHCI

Nagarjuna Kristam (10):
      phy: tegra: xusb: Add usb-role-switch support
      phy: tegra: xusb: Add usb-phy support
      phy: tegra: xusb: Add support to get companion USB 3 port
      phy: tegra: xusb: Add set_mode support for USB 2 phy on Tegra210
      phy: tegra: xusb: Add set_mode support for UTMI phy on Tegra186
      usb: xhci-tegra: Add OTG support
      usb: gadget: tegra-xudc: Remove usb-role-switch support
      usb: gadget: tegra-xudc: Add usb-phy support
      usb: gadget: tegra-xudc: Use phy_set_mode() to set/unset device mode
      usb: gadget: tegra-xudc: Support multiple device modes

Nathan Chancellor (1):
      usb: dwc3: meson-g12a: Don't use ret uninitialized in dwc3_meson_g12a_otg_init

Neil Armstrong (2):
      doc: dt: bindings: usb: dwc3: Update entries for disabling SS instances in park mode
      usb: dwc3: core: add support for disabling SS instances in park mode

Nicolas Saenz Julienne (1):
      usb: xhci: Enable LPM for VIA LABS VL805

Nishad Kamdar (3):
      USB: chipidea: Use the correct style for SPDX License Identifier
      USB: atm: Use the correct style for SPDX License Identifier
      USB: c67x00: Use the correct style for SPDX License Identifier

Oliver Neukum (1):
      USB: apple-mfi-fastcharge: fix endianess issue in probe

Paul Cercueil (7):
      dt-bindings: Document JZ4770 PHY bindings
      usb: phy: Add driver for the Ingenic JZ4770 USB transceiver
      dt-bindings: usb: Convert jz4740-musb doc to YAML
      usb: musb: jz4740: Add support for DMA
      usb: musb: jz4740: Register USB role switch
      usb: musb: jz4740: Unconditionally depend on devicetree
      usb: musb: jz4740: Add support for the JZ4770

Pawel Dembicki (3):
      USB: serial: option: add support for ASKEY WWHC050
      USB: serial: option: add BroadMobi BM806U
      USB: serial: option: add Wistron Neweb D19Q1

Peter Chen (2):
      usb: chipidea: udc: using structure ci_hdrc device for runtime PM
      usb: chipidea: otg: handling vbus disconnect event occurred during system suspend

Qiujun Huang (1):
      USB: serial: io_edgeport: fix slab-out-of-bounds read in edge_interrupt_callback

Rasmus Villemoes (1):
      usb: host: fhci-hcd: annotate PIPE_CONTROL switch case with fallthrough

Sandeep Maheswaram (6):
      dt-bindings: phy: qcom,qusb2: Convert QUSB2 phy bindings to yaml
      dt-bindings: phy: qcom,qusb2: Add compatibles for QUSB2 V2 phy and SC7180
      phy: qcom-qusb2: Add generic QUSB2 V2 PHY support
      dt-bindings: phy: qcom-qusb2: Add support for overriding Phy tuning parameters
      phy: qcom-qusb2: Add support for overriding tuning parameters in QUSB2 V2 PHY
      phy: qcom-qusb2: Add new overriding tuning parameters in QUSB2 V2 PHY

Shawn Guo (1):
      phy: qualcomm: Add Synopsys 28nm Hi-Speed USB PHY driver

Sriharsha Allenki (2):
      dt-bindings: phy: Add Qualcomm Synopsys Hi-Speed USB PHY binding
      usb: gadget: f_fs: Fix use after free issue as part of queue failure

Stephen Rothwell (1):
      usb: dwc3: fix up for role switch API change

Steven Rostedt (VMware) (1):
      xhci: Do not open code __print_symbolic() in xhci trace events

Swapnil Jakhade (10):
      phy: cadence-torrent: Adopt Torrent nomenclature
      phy: cadence-torrent: Add wrapper for PHY register access
      phy: cadence-torrent: Add wrapper for DPTX register access
      phy: cadence-torrent: Refactor code for reusability
      phy: cadence-torrent: Add 19.2 MHz reference clock support
      phy: cadence-torrent: Implement PHY configure APIs
      phy: cadence-torrent: Use regmap to read and write Torrent PHY registers
      phy: cadence-torrent: Use regmap to read and write DPTX PHY registers
      phy: cadence-torrent: Add platform dependent initialization structure
      phy: cadence-torrent: Add support for subnode bindings

Takashi Iwai (2):
      thunderbolt: Use scnprintf() for avoiding potential buffer overflow
      USB: mon: Use scnprintf() for avoiding potential buffer overflow

Tao Ren (7):
      usb: gadget: aspeed: support per-vhub usb descriptors
      usb: gadget: aspeed: read vhub properties from device tree
      usb: gadget: aspeed: add ast2600 vhub support
      ARM: dts: aspeed-g6: add usb functions
      ARM: dts: aspeed-g5: add vhub port and endpoint properties
      ARM: dts: aspeed-g4: add vhub port and endpoint properties
      dt-bindings: usb: add documentation for aspeed usb-vhub

Thierry Reding (4):
      phy: tegra: Print -EPROBE_DEFER error message at debug level
      phy: tegra: Fix regulator leak
      phy: tegra: Don't use device-managed API to allocate ports
      Merge branch 'for-5.7/phy' into for-5.7/usb

Thinh Nguyen (3):
      usb: dwc3: gadget: Don't clear flags before transfer ended
      usb: dwc3: gadget: Wrap around when skip TRBs
      usb: gadget: composite: Inform controller driver of self-powered

Yoshihiro Shimoda (1):
      usb: host: ehci-platform: add a quirk to avoid stuck

Yu Chen (1):
      usb: dwc3: Registering a role switch in the DRD code.

YueHaibing (2):
      usb: gadget: xudc: Remove redundant platform_get_irq error message
      usb: gadget: fsl: remove unused variable 'driver_desc'

Yuti Amonkar (3):
      dt-bindings: phy: Remove Cadence MHDP PHY dt binding
      dt-bindings: phy: Add Cadence MHDP PHY bindings in YAML format.
      phy: cadence-dp: Rename to phy-cadence-torrent

chenqiwu (1):
      usb: use kobj_to_dev() API

 Documentation/ABI/testing/sysfs-class-typec        |   23 +-
 .../bindings/phy/amlogic,meson-g12a-usb2-phy.yaml  |   14 +
 .../devicetree/bindings/phy/phy-cadence-dp.txt     |   30 -
 .../bindings/phy/phy-cadence-torrent.yaml          |  143 ++
 .../devicetree/bindings/phy/phy-mtk-tphy.txt       |   32 +-
 .../devicetree/bindings/phy/qcom,qusb2-phy.yaml    |  185 ++
 .../devicetree/bindings/phy/qcom,usb-hs-28nm.yaml  |   90 +
 .../devicetree/bindings/phy/qcom,usb-ss.yaml       |   83 +
 .../devicetree/bindings/phy/qcom-dwc3-usb-phy.txt  |   37 -
 .../devicetree/bindings/phy/qcom-qmp-phy.txt       |   15 +
 .../devicetree/bindings/phy/qcom-qusb2-phy.txt     |   68 -
 .../devicetree/bindings/phy/ti-phy-gmii-sel.txt    |    1 +
 .../devicetree/bindings/phy/uniphier-pcie-phy.txt  |   13 +-
 .../bindings/phy/uniphier-usb3-hsphy.txt           |    6 +-
 .../bindings/phy/uniphier-usb3-ssphy.txt           |    5 +-
 .../bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml  |   23 +
 .../devicetree/bindings/usb/aspeed,usb-vhub.yaml   |   77 +
 Documentation/devicetree/bindings/usb/dwc2.yaml    |   30 +-
 Documentation/devicetree/bindings/usb/dwc3.txt     |    7 +-
 Documentation/devicetree/bindings/usb/generic.txt  |    6 +
 .../bindings/usb/ingenic,jz4740-musb.txt           |   32 -
 .../bindings/usb/ingenic,jz4770-phy.yaml           |   52 +
 .../devicetree/bindings/usb/ingenic,musb.yaml      |   76 +
 .../devicetree/bindings/usb/maxim,max3420-udc.yaml |   69 +
 Documentation/driver-api/usb/typec_bus.rst         |   22 +-
 Documentation/usb/index.rst                        |    1 +
 Documentation/usb/raw-gadget.rst                   |   61 +
 MAINTAINERS                                        |    6 +
 arch/arm/boot/dts/aspeed-g4.dtsi                   |    2 +
 arch/arm/boot/dts/aspeed-g5.dtsi                   |    2 +
 arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi           |   25 +
 arch/arm/boot/dts/aspeed-g6.dtsi                   |   45 +
 drivers/base/platform.c                            |   27 +-
 drivers/base/property.c                            |    1 +
 drivers/phy/amlogic/phy-meson-g12a-usb2.c          |   87 +-
 drivers/phy/cadence/Kconfig                        |    6 +-
 drivers/phy/cadence/Makefile                       |    2 +-
 drivers/phy/cadence/phy-cadence-dp.c               |  541 ------
 drivers/phy/cadence/phy-cadence-torrent.c          | 1944 ++++++++++++++++++++
 drivers/phy/mediatek/phy-mtk-tphy.c                |   64 +-
 drivers/phy/qualcomm/Kconfig                       |   20 +
 drivers/phy/qualcomm/Makefile                      |    2 +
 drivers/phy/qualcomm/phy-qcom-qmp.c                |  425 ++++-
 drivers/phy/qualcomm/phy-qcom-qmp.h                |  114 ++
 drivers/phy/qualcomm/phy-qcom-qusb2.c              |  144 +-
 drivers/phy/qualcomm/phy-qcom-usb-hs-28nm.c        |  415 +++++
 drivers/phy/qualcomm/phy-qcom-usb-ss.c             |  246 +++
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c      |    2 +-
 drivers/phy/socionext/phy-uniphier-pcie.c          |  102 +-
 drivers/phy/socionext/phy-uniphier-usb3hs.c        |   92 +-
 drivers/phy/socionext/phy-uniphier-usb3ss.c        |    8 +-
 drivers/phy/tegra/Kconfig                          |    2 +
 drivers/phy/tegra/Makefile                         |    1 +
 drivers/phy/tegra/xusb-tegra124.c                  |    6 +
 drivers/phy/tegra/xusb-tegra186.c                  |  265 ++-
 drivers/phy/tegra/xusb-tegra210.c                  |  136 +-
 drivers/phy/tegra/xusb.c                           |  263 ++-
 drivers/phy/tegra/xusb.h                           |   25 +
 drivers/phy/ti/phy-gmii-sel.c                      |   19 +
 drivers/thunderbolt/domain.c                       |    4 +-
 drivers/thunderbolt/eeprom.c                       |    2 +-
 drivers/thunderbolt/icm.c                          |    2 +-
 drivers/thunderbolt/usb4.c                         |    4 +
 drivers/usb/atm/ueagle-atm.c                       |    2 +-
 drivers/usb/atm/usbatm.h                           |    4 +-
 drivers/usb/c67x00/c67x00-hcd.h                    |    2 +-
 drivers/usb/c67x00/c67x00.h                        |    2 +-
 drivers/usb/cdns3/cdns3-pci-wrap.c                 |    2 +-
 drivers/usb/cdns3/cdns3-ti.c                       |    4 +-
 drivers/usb/cdns3/core.c                           |   22 +-
 drivers/usb/cdns3/gadget.c                         |    2 +-
 drivers/usb/cdns3/gadget.h                         |    6 +-
 drivers/usb/chipidea/bits.h                        |    2 +-
 drivers/usb/chipidea/ci.h                          |    2 +-
 drivers/usb/chipidea/ci_hdrc_imx.h                 |    2 +-
 drivers/usb/chipidea/core.c                        |   10 +-
 drivers/usb/chipidea/otg.c                         |    7 +
 drivers/usb/chipidea/otg.h                         |    2 +-
 drivers/usb/chipidea/otg_fsm.h                     |    2 +-
 drivers/usb/chipidea/udc.c                         |   13 +-
 drivers/usb/chipidea/udc.h                         |    2 +-
 drivers/usb/class/cdc-acm.c                        |   18 +-
 drivers/usb/core/driver.c                          |   58 +-
 drivers/usb/core/generic.c                         |   48 +-
 drivers/usb/core/message.c                         |    2 +
 drivers/usb/core/sysfs.c                           |    6 +-
 drivers/usb/core/usb-acpi.c                        |   11 +-
 drivers/usb/core/usb.h                             |    8 +
 drivers/usb/dwc2/core.h                            |    8 +
 drivers/usb/dwc2/gadget.c                          |   24 +-
 drivers/usb/dwc2/hcd.h                             |    2 +-
 drivers/usb/dwc2/hw.h                              |    8 +
 drivers/usb/dwc2/params.c                          |   33 +
 drivers/usb/dwc2/platform.c                        |  101 +-
 drivers/usb/dwc3/core.c                            |   29 +-
 drivers/usb/dwc3/core.h                            |   10 +
 drivers/usb/dwc3/drd.c                             |   98 +-
 drivers/usb/dwc3/dwc3-exynos.c                     |    9 +
 drivers/usb/dwc3/dwc3-meson-g12a.c                 |  182 +-
 drivers/usb/dwc3/dwc3-qcom.c                       |    2 +-
 drivers/usb/dwc3/gadget.c                          |    6 +-
 drivers/usb/dwc3/host.c                            |    4 +-
 drivers/usb/dwc3/trace.h                           |    9 +-
 drivers/usb/gadget/composite.c                     |    9 +
 drivers/usb/gadget/function/f_fs.c                 |    1 +
 drivers/usb/gadget/function/f_phonet.c             |    2 +-
 drivers/usb/gadget/function/f_uac1_legacy.c        |    2 -
 drivers/usb/gadget/legacy/Kconfig                  |   59 +-
 drivers/usb/gadget/legacy/Makefile                 |    1 +
 drivers/usb/gadget/legacy/gmidi.c                  |    2 +-
 drivers/usb/gadget/legacy/inode.c                  |    2 +-
 drivers/usb/gadget/legacy/raw_gadget.c             | 1078 +++++++++++
 drivers/usb/gadget/udc/Kconfig                     |   11 +-
 drivers/usb/gadget/udc/Makefile                    |    1 +
 drivers/usb/gadget/udc/amd5536udc.h                |    2 +-
 drivers/usb/gadget/udc/amd5536udc_pci.c            |    2 +-
 drivers/usb/gadget/udc/aspeed-vhub/Kconfig         |    4 +-
 drivers/usb/gadget/udc/aspeed-vhub/core.c          |   71 +-
 drivers/usb/gadget/udc/aspeed-vhub/dev.c           |   30 +-
 drivers/usb/gadget/udc/aspeed-vhub/epn.c           |    4 +-
 drivers/usb/gadget/udc/aspeed-vhub/hub.c           |   58 +-
 drivers/usb/gadget/udc/aspeed-vhub/vhub.h          |   43 +-
 drivers/usb/gadget/udc/at91_udc.c                  |    2 +-
 drivers/usb/gadget/udc/dummy_hcd.c                 |    4 +-
 drivers/usb/gadget/udc/fotg210-udc.c               |    2 +-
 drivers/usb/gadget/udc/fsl_udc_core.c              |    1 -
 drivers/usb/gadget/udc/fusb300_udc.c               |    2 +-
 drivers/usb/gadget/udc/goku_udc.c                  |    2 +-
 drivers/usb/gadget/udc/lpc32xx_udc.c               |    2 +-
 drivers/usb/gadget/udc/m66592-udc.c                |    2 +-
 drivers/usb/gadget/udc/max3420_udc.c               | 1331 ++++++++++++++
 drivers/usb/gadget/udc/net2280.c                   |    7 +-
 drivers/usb/gadget/udc/omap_udc.c                  |    2 +-
 drivers/usb/gadget/udc/r8a66597-udc.c              |    2 +-
 drivers/usb/gadget/udc/renesas_usb3.c              |   28 +-
 drivers/usb/gadget/udc/s3c-hsudc.c                 |    3 +-
 drivers/usb/gadget/udc/tegra-xudc.c                |  278 ++-
 drivers/usb/host/ehci-mv.c                         |   11 +-
 drivers/usb/host/ehci-pci.c                        |    2 +-
 drivers/usb/host/ehci-platform.c                   |  127 ++
 drivers/usb/host/ehci-tegra.c                      |    2 +-
 drivers/usb/host/ehci.h                            |    4 +-
 drivers/usb/host/fhci-hcd.c                        |    1 +
 drivers/usb/host/fotg210.h                         |    2 +-
 drivers/usb/host/ohci-pci.c                        |    2 +-
 drivers/usb/host/ohci.h                            |    4 +-
 drivers/usb/host/sl811-hcd.c                       |    2 +-
 drivers/usb/host/uhci-pci.c                        |    2 +-
 drivers/usb/host/xhci-histb.c                      |    3 +-
 drivers/usb/host/xhci-hub.c                        |   63 +-
 drivers/usb/host/xhci-mem.c                        |    1 +
 drivers/usb/host/xhci-mtk.h                        |    2 +-
 drivers/usb/host/xhci-pci.c                        |    9 +-
 drivers/usb/host/xhci-plat.c                       |    3 +-
 drivers/usb/host/xhci-ring.c                       |    9 +
 drivers/usb/host/xhci-tegra.c                      |  235 ++-
 drivers/usb/host/xhci.c                            |    4 +-
 drivers/usb/host/xhci.h                            |   34 +-
 drivers/usb/misc/Kconfig                           |   10 +
 drivers/usb/misc/Makefile                          |    1 +
 drivers/usb/misc/apple-mfi-fastcharge.c            |  237 +++
 drivers/usb/mon/mon_text.c                         |   36 +-
 drivers/usb/mtu3/mtu3_dr.c                         |    9 +-
 drivers/usb/musb/Kconfig                           |    4 +-
 drivers/usb/musb/jz4740.c                          |  110 +-
 drivers/usb/musb/mediatek.c                        |   18 +-
 drivers/usb/musb/musb_core.c                       |    2 +-
 drivers/usb/musb/musb_host.c                       |   19 +-
 drivers/usb/musb/tusb6010.c                        |    2 +-
 drivers/usb/phy/Kconfig                            |    8 +
 drivers/usb/phy/Makefile                           |    1 +
 drivers/usb/phy/phy-jz4770.c                       |  243 +++
 drivers/usb/phy/phy-tegra-usb.c                    |    3 +-
 drivers/usb/roles/class.c                          |   31 +-
 drivers/usb/roles/intel-xhci-usb-role-switch.c     |   26 +-
 drivers/usb/serial/digi_acceleport.c               |    2 +-
 drivers/usb/serial/f81232.c                        |  354 +++-
 drivers/usb/serial/generic.c                       |   12 +-
 drivers/usb/serial/io_edgeport.c                   |    2 +-
 drivers/usb/serial/io_usbvend.h                    |    4 +-
 drivers/usb/serial/option.c                        |    6 +
 drivers/usb/serial/ti_usb_3410_5052.c              |    4 +-
 drivers/usb/serial/usb-serial.c                    |    2 +-
 drivers/usb/storage/usb.c                          |   10 +-
 drivers/usb/storage/usb.h                          |    5 +-
 drivers/usb/storage/usual-tables.c                 |    6 +-
 drivers/usb/typec/bus.c                            |   12 +-
 drivers/usb/typec/bus.h                            |    2 -
 drivers/usb/typec/class.c                          |  175 +-
 drivers/usb/typec/mux.c                            |   72 +-
 drivers/usb/typec/mux/Kconfig                      |    9 +
 drivers/usb/typec/mux/Makefile                     |    1 +
 drivers/usb/typec/mux/intel_pmc_mux.c              |  434 +++++
 drivers/usb/typec/tcpm/tcpm.c                      |   62 +-
 drivers/usb/typec/ucsi/ucsi.c                      |   14 +-
 drivers/usb/typec/ucsi/ucsi.h                      |    9 +
 drivers/usb/typec/ucsi/ucsi_ccg.c                  |   57 +-
 include/linux/phy/tegra/xusb.h                     |    2 +
 include/linux/platform_device.h                    |    3 +
 include/linux/usb.h                                |   11 +-
 include/linux/usb/audio-v2.h                       |    2 +-
 include/linux/usb/audio-v3.h                       |    2 +-
 include/linux/usb/ehci_def.h                       |    2 +-
 include/linux/usb/gadget.h                         |    2 +-
 include/linux/usb/hcd.h                            |    2 +-
 include/linux/usb/role.h                           |   23 +-
 include/linux/usb/typec.h                          |    3 +-
 include/linux/usb/typec_altmode.h                  |    7 -
 include/linux/usb/typec_mux.h                      |   25 +-
 include/linux/usb/typec_tbt.h                      |   53 +
 include/linux/usb_usual.h                          |    2 +-
 include/linux/usbdevice_fs.h                       |    2 +-
 include/uapi/linux/usb/raw_gadget.h                |  167 ++
 213 files changed, 11168 insertions(+), 1742 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/phy/phy-cadence-dp.txt
 create mode 100644 Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,usb-hs-28nm.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,usb-ss.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/qcom-dwc3-usb-phy.txt
 delete mode 100644 Documentation/devicetree/bindings/phy/qcom-qusb2-phy.txt
 create mode 100644 Documentation/devicetree/bindings/usb/aspeed,usb-vhub.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/ingenic,jz4740-musb.txt
 create mode 100644 Documentation/devicetree/bindings/usb/ingenic,jz4770-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/ingenic,musb.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/maxim,max3420-udc.yaml
 create mode 100644 Documentation/usb/raw-gadget.rst
 delete mode 100644 drivers/phy/cadence/phy-cadence-dp.c
 create mode 100644 drivers/phy/cadence/phy-cadence-torrent.c
 create mode 100644 drivers/phy/qualcomm/phy-qcom-usb-hs-28nm.c
 create mode 100644 drivers/phy/qualcomm/phy-qcom-usb-ss.c
 create mode 100644 drivers/usb/gadget/legacy/raw_gadget.c
 create mode 100644 drivers/usb/gadget/udc/max3420_udc.c
 create mode 100644 drivers/usb/misc/apple-mfi-fastcharge.c
 create mode 100644 drivers/usb/phy/phy-jz4770.c
 create mode 100644 drivers/usb/typec/mux/intel_pmc_mux.c
 create mode 100644 include/linux/usb/typec_tbt.h
 create mode 100644 include/uapi/linux/usb/raw_gadget.h
