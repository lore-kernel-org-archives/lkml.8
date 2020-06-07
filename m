Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 593CCC433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 13:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 120F320723
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 13:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591536430;
	bh=8lISju1yfcQM+jUgWgMC0gWkHsNZZHOzK8JT/2p7xUA=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=joIn9bAjMrXWGclG6o3zL8R6TZp/FC5NDTTh6amfxaasmGg9VUwUuCHAIzR/9tIWt
	 NdfOJ9HgJ/yFc67rI4NU6XgXtiCJaTKS90afxTbnDen7OJUFHpsoK9SPG1T5uCpYHu
	 uDHNu52MzM45rDSLrpwIorxzK21wWobuLrgfQ67E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgFGN1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 09:27:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:46450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726465AbgFGN1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 09:27:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A6B120723;
        Sun,  7 Jun 2020 13:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591536423;
        bh=8lISju1yfcQM+jUgWgMC0gWkHsNZZHOzK8JT/2p7xUA=;
        h=Date:From:To:Cc:Subject:From;
        b=YvfzCzUY4RnNNRnvZeu0Ys3lWDFMVAIeGgAPMG9WVyckLJsrWWyFEVXHbz9vt0fkC
         sKGzs59RCH+RXKDi87FnYB7HdPN0uOA3IqaEleJgPIHlv+IG5dc4Fo7hxksKe7uRfz
         3yLydSTe35N7zkAaqmpCDeqx7W4nkuU7VUGpQpBw=
Date:   Sun, 7 Jun 2020 15:27:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB/PHY driver update for 5.8-rc1
Message-ID: <20200607132701.GA168046@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit b9bbe6ed63b2b9f2c9ee5cbd0f2c946a2723f4ce:

  Linux 5.7-rc6 (2020-05-17 16:48:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.8-rc1

for you to fetch changes up to 347052e3bf1b62a25c11f7a673acfbaf554d67a1:

  usb: dwc3: meson-g12a: fix USB2 PHY initialization on G12A and A1 SoCs (2020-05-29 12:21:26 +0200)

----------------------------------------------------------------
USB/PHY driver updates for 5.8-rc1

Here are the large set of USB and PHY driver updates for 5.8-rc1.

Nothing huge, just lots of little things:
	- USB gadget fixes and additions all over the place
	- new PHY drivers
	- PHY driver fixes and updates
	- XHCI driver updates
	- musb driver updates
	- more USB-serial driver ids added
	- various USB quirks added
	- thunderbolt minor updates and fixes
	- typec updates and additions

Full details are in the shortlog.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Al Cooper (4):
      dt-bindings: Add Broadcom STB USB support
      usb: xhci: xhci-plat: Add support for Broadcom STB SoC's
      usb: ehci: Add new EHCI driver for Broadcom STB SoC's
      usb: host: Add ability to build new Broadcom STB USB drivers

Alan Stern (1):
      USB: core: Replace an empty statement with a debug message

Andrey Konovalov (1):
      USB: dummy-hcd: use configurable endpoint naming scheme

Bharat Gooty (1):
      drivers: phy: sr-usb: do not use internal fsm for USB2 phy init

Bin Liu (3):
      USB: serial: usb_wwan: do not resubmit rx urb on fatal errors
      usb: musb: return -ESHUTDOWN in urb when three-strikes error happened
      usb: musb: start session in resume for host port

Bjorn Andersson (2):
      phy: qcom: qmp: Add SM8250 UFS PHY
      phy: qcom-qmp: Ensure register indirection arrays initialized

Bryan O'Donoghue (6):
      usb: chipidea: Enable user-space triggered role-switching
      usb: roles: Switch on role-switch uevent reporting
      dt-bindings: usb: Add TI tps6598x device tree binding documentation
      usb: typec: tps6598x: Add OF probe binding
      usb: typec: tps6598x: Add USB role switching logic
      usb: typec: Ensure USB_ROLE_SWITCH is set as a dependency for tps6598x

Christian Lamparter (1):
      usb: renesas-xhci: Add the renesas xhci driver

Christophe JAILLET (3):
      usb: phy: jz4770: Add a missing '\n' in a log message
      phy: cpcap-usb: Remove some useless code
      usb: gadget: max3420: Add a missing '\n' in a log message

Colin Ian King (3):
      USB: EHCI: ehci-mv: fix less than zero comparison of an unsigned int
      usb: gadget: function: remove redundant assignment to variable 'status'
      usb: gadget: lpc32xx_udc: don't dereference ep pointer before null check

Daniele Palmas (1):
      USB: serial: option: add Telit LE910C1-EUX compositions

David Manouchehri (1):
      thunderbolt: Update Kconfig to allow building on other architectures.

Dilip Kota (3):
      dt-bindings: phy: Add PHY_TYPE_XPCS definition
      dt-bindings: phy: Add YAML schemas for Intel ComboPhy
      phy: intel: Add driver support for ComboPhy

Dinghao Liu (2):
      usb: cdns3: Fix runtime PM imbalance on error
      usb: musb: Fix runtime PM imbalance on error

Fabrice Gasnier (4):
      usb: dwc2: gadget: move gadget resume after the core is in L0 state
      usb: gadget: u_serial: add suspend resume callbacks
      usb: gadget: f_serial: add suspend resume callbacks
      usb: gadget: f_acm: add suspend resume callbacks

Geert Uytterhoeven (1):
      phy: intel-lgm-emmc: Add architecture dependency

Greg Kroah-Hartman (12):
      Merge 5.7-rc3 into usb-next
      Merge 5.7-rc5 into usb-next
      Merge 5.7-rc6 into usb-next
      Merge tag 'phy-for-5.8' of git://git.kernel.org/.../phy/linux-phy into usb-next
      Merge tag 'usb-for-v5.8' of git://git.kernel.org/.../balbi/usb into usb-next
      Merge tag 'usb-ci-v5.8-rc1' of git://git.kernel.org/.../peter.chen/usb into usb-next
      Merge tag 'thunderbolt-for-v5.8' of git://git.kernel.org/.../westeri/thunderbolt into usb-next
      Merge tag 'usb-serial-5.8-rc1' of https://git.kernel.org/.../johan/usb-serial into usb-next
      Revert "dt-bindings: usb: qcom,dwc3: Introduce interconnect properties for Qualcomm DWC3 driver"
      Revert "dt-bindings: usb: qcom,dwc3: Add compatible for SC7180"
      Revert "dt-bindings: usb: qcom,dwc3: Convert USB DWC3 bindings"
      Merge tag 'usb-serial-5.8-rc1-2' of https://git.kernel.org/.../johan/usb-serial into usb-next

Gregory CLEMENT (3):
      usb: gadget: udc: atmel: Don't use DT to configure end point
      dt-bindings: usb: atmel: Mark EP child node as deprecated
      ARM: dts: at91: Remove the USB EP child node

Gustavo A. R. Silva (1):
      thunderbolt: Replace zero-length array with flexible-array

Hannes Reinecke (1):
      sierra-ms: do not call scsi_get_host_dev()

Heikki Krogerus (5):
      usb: typec: ucsi: Fix the stub for ucsi_register_port_psy()
      usb: typec: Add typec_find_orientation()
      usb: typec: mux: intel_pmc_mux: Support for static SBU/HSL orientation
      usb: typec: Add firmware documentation for the Intel PMC mux control
      MAINTAINERS: Add entry for Intel PMC mux driver

Jack Pham (1):
      phy: qcom-qmp: Add SM8150 QMP USB3 PHY support

Jason Yan (13):
      usb: cdns3: gadget: make a bunch of functions static
      usb/early: remove unused including <linux/version.h>
      usb: pci-quirks: use true,false for bool variables
      usb: gadget: udc: remove unused 'driver_desc'
      usb: core: hub: use true,false for bool variable
      usb: chipidea: usb2: remove unneeded semicolon
      usb: gadget: udc: remove unused 'driver_desc'
      usb: gadget: f_fs: remove unneeded semicolon in __ffs_data_got_descs()
      usb: dwc3: use true,false for dwc->otg_restart_host
      usb: gadget: net2272: use false for 'use_dma'
      usb: gadget: udc: remove comparison to bool in mv_u3d_core.c
      usb: gadget: omap_udc: remove unneeded semicolon
      usb: musb: use true for 'use_dma'

Johan Hovold (1):
      USB: serial: ch341: fix lockup of devices with limited prescaler

Jonathan Bakker (1):
      phy: samsung: s5pv210-usb2: Add delay after reset

Jules Irenge (2):
      usb: gadget: Add missing annotation for xudc_handle_setup()
      USB: dummy-hcd: Add missing annotation for set_link_state()

Jun Li (1):
      usb: chipidea: introduce imx7d USB charger detection

Jyri Sarha (1):
      phy: ti: j721e-wiz: Implement DisplayPort mode to the wiz driver

K V, Abhilash (5):
      usb: typec: ucsi: Workaround for missed op_mode change
      usb: typec: ucsi: replace magic numbers
      usb: typec: ucsi: Correct bit-mask for CCI
      usb: typec: ucsi: save power data objects in PD mode
      usb: typec: ucsi: register with power_supply class

Linus Walleij (1):
      usb: fusb302: Convert to use GPIO descriptors

Macpaul Lin (1):
      usb: musb: mediatek: add reset FADDR to zero in reset interrupt handle

Madhuparna Bhowmik (1):
      usb: host: u132-hcd: Remove u132_static_list and list head u132_list

Martin Blumenstingl (12):
      dt-bindings: phy: meson8b-usb2: Convert to json-schema
      dt-bindings: phy: meson8b-usb2: Add compatible string for Meson8m2
      phy: amlogic: meson8b-usb2: Use a MMIO regmap
      phy: amlogic: meson8b-usb2: Don't set REG_ADP_BC_ACA_ENABLE on Meson8
      phy: amlogic: meson8b-usb2: unset the IDDQ bit during PHY power-on
      phy: amlogic: meson8b-usb2: Add a compatible string for Meson8m2
      arm64: dts: amlogic: use the new USB control driver for GXL and GXM
      phy: amlogic: meson-gxl-usb3: remove code for non-existing PHY
      usb: dwc3: of-simple: remove Amlogic GXL and AXG compatibles
      dt-bindings: usb: dwc3: remove old DWC3 wrapper
      usb: dwc3: meson-g12a: fix error path when fetching the reset line fails
      usb: dwc3: meson-g12a: fix USB2 PHY initialization on G12A and A1 SoCs

Martin Kepplinger (1):
      usb: dwc3: support continuous runtime PM with dual role

Masahiro Yamada (1):
      usb: gadget: legacy: fix redundant initialization warnings from cppcheck

Matt Jolly (1):
      USB: serial: qcserial: add DW5816e QDL support

Maxim Levitsky (1):
      thunderbolt: Add trivial .shutdown

Mayank Rana (1):
      usb: typec: ucsi: set USB data role when partner type is power cable/ufp

Michael Grzeschik (1):
      usb: gadget: uvc_video: add worker to handle the frame pumping

Michael Hanselmann (1):
      USB: serial: ch341: add basis for quirk detection

Michał Mirosław (5):
      usb: chipidea: usb2: constify zynq_pdata
      usb: chipidea: usb2: fix formatting
      usb: chipidea: usb2: make clock optional
      usb: chipidea: usb2: absorb zevio glue driver
      usb: chipidea: allow disabling glue drivers if EMBEDDED

Mika Westerberg (1):
      thunderbolt: Add support for Intel Tiger Lake

Minas Harutyunyan (1):
      usb: dwc2: Update Core Reset programming flow.

Nagarjuna Kristam (4):
      usb: gadget: tegra-xudc: Add vbus_draw support
      dt-bindings: usb: tegra-xudc: Add Tegra194 XUSB controller support
      usb: gadget: tegra-xudc: Add Tegra194 support
      usb: gadget: tegra-xudc: add port_speed_quirk

Nathan Chancellor (1):
      USB: gadget: udc: s3c2410_udc: Remove pointless NULL check in s3c2410_udc_nuke

Neil Armstrong (10):
      dt-bindings: usb: amlogic,meson-g12a-usb-ctrl: add the Amlogic GXL and GXM Families USB Glue Bindings
      usb: dwc3: meson-g12a: specify phy names in soc data
      usb: dwc3: meson-g12a: handle the phy and glue registers separately
      usb: dwc3: meson-g12a: get the reset as shared
      usb: dwc3: meson-g12a: check return of dwc3_meson_g12a_usb_init
      usb: dwc3: meson-g12a: refactor usb2 phy init
      usb: dwc3: meson-g12a: refactor usb init
      usb: dwc3: meson-g12a: support the GXL/GXM DWC3 host phy disconnect
      usb: dwc3: meson-g12a: add support for GXL and GXM SoCs
      doc: dt: bindings: usb: dwc3: remove amlogic compatible entries

Nicholas Johnson (1):
      Revert "thunderbolt: Prevent crash if non-active NVMem file is read"

Nishad Kamdar (18):
      USB: core: Use the correct style for SPDX License Identifier
      USB: early: Use the correct style for SPDX License Identifier
      USB: host: Use the correct style for SPDX License Identifier
      USB: isp1760: Use the correct style for SPDX License Identifier
      USB: misc: Use the correct style for SPDX License Identifier
      USB: musb: Use the correct style for SPDX License Identifier
      USB: mtu3: Use the correct style for SPDX License Identifier
      USB: dwc2: Use the correct style for SPDX License Identifier
      USB: serial: Use the correct style for SPDX License Identifier
      USB: typec: Use the correct style for SPDX License Identifier
      USB: Storage: Use the correct style for SPDX License Identifier
      usb: renesas_usbhs: Use the correct style for SPDX License Identifier
      USB: phy: Use the correct style for SPDX License Identifier
      USB: gadget: Use the correct style for SPDX License Identifier
      USB: dwc3: Use the correct style for SPDX License Identifier
      USB: dwc2: Use the correct style for SPDX License Identifier
      USB: mtu3: Use the correct style for SPDX License Identifier
      usb: renesas_usbhs: Use the correct style for SPDX License Identifier

Oliver Neukum (2):
      usblp: poison URBs upon disconnect
      CDC-ACM: heed quirk also in error handling

Paul Cercueil (1):
      usb: musb: jz4740: Prevent lockup when CONFIG_SMP is set

Pawel Laszczak (1):
      usb: gadget: Fix issue with config_ep_by_speed function

Peter Chen (21):
      usb: chipidea: udc: fix the kernel doc for udc.h
      usb: chipidea: core: refine the description for this driver
      usb: chipidea: core: show the real pointer value for register
      usb: cdns3: core: get role switch node from firmware
      usb: cdns3: delete role_override
      usb: cdns3: change "cdsn3" to"cdns3"
      usb: cdns3: change dev_info to dev_dbg for debug message
      usb: chipidea: introduce CI_HDRC_CONTROLLER_VBUS_EVENT glue layer use
      usb: chipidea: pull down dp for possible charger detection operation
      usb: chipidea: usbmisc_imx: using different ops for imx7d and imx7ulp
      usb: chipidea: udc: add software sg list support
      doc: dt-binding: cdns-salvo-phy: add binding doc
      phy: cadence: salvo: add salvo phy driver
      phy: phy-cadence-salvo: add phy .init API
      usb: cdns3: core: get role switch node from firmware
      usb: cdns3: delete role_override
      usb: cdns3: change "cdsn3" to"cdns3"
      usb: cdns3: change dev_info to dev_dbg for debug message
      usb: gadget: core: sync interrupt before unbind the udc
      usb: cdns3: gadget: assign interrupt number to USB gadget structure
      usb: cdns3: ep0: delete the redundant status stage

Qais Yousef (3):
      usb/ohci-platform: Fix a warning when hibernating
      usb/xhci-plat: Set PM runtime as active on resume
      usb/ehci-platform: Set PM runtime as active on resume

Qiushi Wu (1):
      usb: gadget: fix potential double-free in m66592_probe.

Rikard Falkeborn (3):
      phy: sr-usb: Constify phy_ops
      phy: phy-brcm-usb: Constify static structs
      phy: phy-bcm-ns2-usbdrd: Constify phy_ops

Robert Marko (2):
      phy: add driver for Qualcomm IPQ40xx USB PHY
      dt-bindings: phy-qcom-ipq4019-usb: add binding document

Roger Quadros (6):
      phy: omap-usb2: Clean up exported header
      phy: ti: am654: show up in regmap debugfs
      phy: ti: am654: add support for USB super-speed
      dt-bindings: usb: convert keystone-usb.txt to YAML
      dt-bindings: usb: ti,keystone-dwc3.yaml: Add USB3.0 PHY property
      usb: dwc3: keystone: Turn on USB3 PHY before controller

Sandeep Maheswaram (9):
      dt-bindings: usb: qcom,dwc3: Convert USB DWC3 bindings
      dt-bindings: usb: qcom,dwc3: Add compatible for SC7180
      dt-bindings: phy: qcom,qmp: Convert QMP PHY bindings to yaml
      dt-bindings: phy: qcom,qmp-usb3-dp: Add dt bindings for USB3 DP PHY
      dt-bindings: phy: qcom,qmp-usb3-dp: Add support for SC7180
      phy: qcom-qmp: Add QMP V3 USB3 PHY support for SC7180
      dt-bindings: usb: qcom,dwc3: Introduce interconnect properties for Qualcomm DWC3 driver
      arm64: dts: qcom: sdm845: Add interconnect properties for USB
      arm64: dts: qcom: sc7180: Add interconnect properties for USB

Sanket Parmar (1):
      phy: cadence: sierra: Fix for USB3 U1/U2 state

Tang Bin (6):
      usb: host: ehci-tegra: Remove superfluous dev_err() message
      USB: host: ehci-mxc: Use the defined variable to simplify code
      USB: EHCI: ehci-mv: Fix unused assignment in mv_ehci_probe()
      USB: EHCI: ehci-mv: fix error handling in mv_ehci_probe()
      USB: host: ehci-mxc: Add error handling in ehci_mxc_drv_probe()
      usb: gadget: fsl: Fix a wrong judgment in fsl_udc_probe()

Tao Ren (7):
      usb: gadget: aspeed: improve vhub port irq handling
      usb: gadget: aspeed: support multiple language strings
      usb: gadget: add "usb_validate_langid" function
      usb: gadget: aspeed: allow to set usb strings in device tree
      usb: gadget: aspeed: allow to set device IDs in device tree
      usb: gadget: aspeed: fixup usb1 device descriptor at init time
      dt-bindings: usb: document aspeed vhub device ID/string properties

Thinh Nguyen (24):
      usb: dwc3: gadget: Properly handle ClearFeature(halt)
      usb: dwc3: gadget: Give back staled requests
      usb: dwc3: gadget: Remove unnecessary checks
      usb: dwc3: gadget: Refactor dwc3_gadget_ep_dequeue
      usb: dwc3: drd: Don't free non-existing irq
      usb: dwc3: core: Use role-switch default dr_mode
      usb: dwc3: gadget: Properly handle failed kick_transfer
      usb: dwc3: gadget: Store resource index of start cmd
      usb: dwc3: gadget: Issue END_TRANSFER to retry isoc transfer
      usb: dwc3: gadget: WARN on no-resource status
      usb: dwc3: gadget: Continue to process pending requests
      usb: dwc3: Add support for DWC_usb32 IP
      usb: dwc3: Get MDWIDTH for DWC_usb32
      usb: gadget: Introduce usb_request->is_last
      usb: gadget: f_tcm: Inform last stream request
      usb: dwc3: gadget: Check for in-progress END_TRANSFER
      usb: dwc3: gadget: Refactor TRB completion handler
      usb: dwc3: gadget: Enable XferComplete event
      usb: dwc3: gadget: Handle XferComplete for streams
      usb: dwc3: gadget: Wait for transfer completion
      usb: dwc3: gadget: Don't prepare beyond a transfer
      usb: dwc3: gadget: Handle stream transfers
      usb: dwc3: gadget: Use SET_EP_PRIME for NoStream
      usb: dwc3: gadget: Check for prepared TRBs

Vinod Koul (6):
      usb: hci: add hc_driver as argument for usb_hcd_pci_probe
      usb: xhci: Add support for Renesas controller with memory
      usb: renesas-xhci: Add ROM loader for uPD720201
      usb: renesas-xhci: include correct header for get_unaligned_le16()
      usb: xhci: fix USB_XHCI_PCI depends
      usb: xhci: make symbols static

Wei Yongjun (3):
      phy: ti: j721e-wiz: Fix some error return code in wiz_probe()
      USB: ohci-sm501: fix error return code in ohci_hcd_sm501_drv_probe()
      usb: gadget: mass_storage: use module_usb_composite_driver to simplify the code

Wesley Cheng (5):
      dt-bindings: phy: Add binding for qcom,usb-snps-femto-v2
      phy: qcom-snps: Add SNPS USB PHY driver for QCOM based SOCs
      phy: qcom-qmp: Use proper PWRDOWN offset for sm8150 USB
      phy: qcom-qmp: Rename UFS PCS QMP v4 registers
      dt-bindings: phy: usb-snps-femto-v2: Add regulator entries to example

Yoshihiro Shimoda (4):
      dt-bindings: phy: renesas: usb2-phy: convert bindings to json-schema
      dt-bindings: phy: renesas: usb2-phy: add r8a77961 support
      dt-bindings: phy: renesas: usb3-phy: convert bindings to json-schema
      dt-bindings: phy: renesas: usb3-phy: add r8a77961 support

Yu Chen (1):
      usb: dwc3: Increase timeout for CmdAct cleared by device controller

kbuild test robot (1):
      usb: cdns3: mark local functions static

 .../bindings/phy/amlogic,meson8b-usb2-phy.yaml     |  64 ++
 .../devicetree/bindings/phy/cdns,salvo-phy.yaml    |  52 ++
 .../devicetree/bindings/phy/intel,combo-phy.yaml   | 101 ++++
 .../devicetree/bindings/phy/meson-gxl-usb3-phy.txt |  31 -
 .../devicetree/bindings/phy/meson8b-usb2-phy.txt   |  28 -
 .../devicetree/bindings/phy/qcom,qmp-phy.yaml      | 313 ++++++++++
 .../bindings/phy/qcom,qmp-usb3-dp-phy.yaml         | 136 +++++
 .../bindings/phy/qcom,usb-snps-femto-v2.yaml       |  80 +++
 .../devicetree/bindings/phy/qcom-qmp-phy.txt       | 242 --------
 .../bindings/phy/qcom-usb-ipq4019-phy.yaml         |  50 ++
 .../devicetree/bindings/phy/rcar-gen3-phy-usb2.txt |  70 ---
 .../devicetree/bindings/phy/rcar-gen3-phy-usb3.txt |  52 --
 .../devicetree/bindings/phy/renesas,usb2-phy.yaml  | 117 ++++
 .../devicetree/bindings/phy/renesas,usb3-phy.yaml  |  79 +++
 .../devicetree/bindings/usb/amlogic,dwc3.txt       |  42 --
 .../bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml  |  73 ++-
 .../devicetree/bindings/usb/aspeed,usb-vhub.yaml   |  68 +++
 .../devicetree/bindings/usb/atmel-usb.txt          |  56 +-
 .../devicetree/bindings/usb/brcm,bcm7445-ehci.yaml |  59 ++
 Documentation/devicetree/bindings/usb/dwc3.txt     |   2 -
 .../devicetree/bindings/usb/keystone-usb.txt       |  56 --
 .../devicetree/bindings/usb/nvidia,tegra-xudc.yaml |   2 +
 .../devicetree/bindings/usb/ti,keystone-dwc3.yaml  |  77 +++
 .../devicetree/bindings/usb/ti,tps6598x.yaml       |  64 ++
 Documentation/devicetree/bindings/usb/usb-xhci.txt |   1 +
 .../firmware-guide/acpi/intel-pmc-mux.rst          | 153 +++++
 MAINTAINERS                                        |  15 +
 arch/arm/boot/dts/at91sam9g45.dtsi                 |  54 --
 arch/arm/boot/dts/at91sam9rl.dtsi                  |  54 --
 arch/arm/boot/dts/at91sam9x5.dtsi                  |  54 --
 arch/arm/boot/dts/sama5d2.dtsi                     | 120 ----
 arch/arm/boot/dts/sama5d3.dtsi                     | 107 ----
 arch/arm/boot/dts/sama5d4.dtsi                     | 120 ----
 .../boot/dts/amlogic/meson-gx-libretech-pc.dtsi    |   3 +-
 .../arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi |   3 +-
 .../dts/amlogic/meson-gxl-s805x-libretech-ac.dts   |   3 +-
 .../boot/dts/amlogic/meson-gxl-s805x-p241.dts      |   3 +-
 .../dts/amlogic/meson-gxl-s905d-phicomm-n1.dts     |   4 +
 .../boot/dts/amlogic/meson-gxl-s905w-p281.dts      |   4 +
 .../boot/dts/amlogic/meson-gxl-s905w-tx3-mini.dts  |   4 +
 .../dts/amlogic/meson-gxl-s905x-khadas-vim.dts     |   4 +
 .../dts/amlogic/meson-gxl-s905x-libretech-cc.dts   |   3 +-
 .../dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts    |   3 +-
 .../boot/dts/amlogic/meson-gxl-s905x-p212.dtsi     |   3 +-
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi         |  45 +-
 .../boot/dts/amlogic/meson-gxm-khadas-vim2.dts     |   3 +-
 .../arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts |   3 +-
 arch/arm64/boot/dts/amlogic/meson-gxm-vega-s96.dts |   4 +
 arch/arm64/boot/dts/amlogic/meson-gxm.dtsi         |   7 +-
 arch/arm64/boot/dts/qcom/sc7180.dtsi               |   4 +
 arch/arm64/boot/dts/qcom/sdm845.dtsi               |   8 +
 drivers/gpio/gpiolib-of.c                          |  21 +
 drivers/phy/amlogic/Kconfig                        |  15 +-
 drivers/phy/amlogic/Makefile                       |   1 -
 drivers/phy/amlogic/phy-meson-gxl-usb3.c           | 283 ---------
 drivers/phy/amlogic/phy-meson8b-usb2.c             | 149 +++--
 drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c          |   2 +-
 drivers/phy/broadcom/phy-bcm-sr-usb.c              |  57 +-
 drivers/phy/broadcom/phy-brcm-usb.c                |  16 +-
 drivers/phy/cadence/Kconfig                        |   9 +
 drivers/phy/cadence/Makefile                       |   1 +
 drivers/phy/cadence/phy-cadence-salvo.c            | 325 +++++++++++
 drivers/phy/cadence/phy-cadence-sierra.c           |  27 +-
 drivers/phy/intel/Kconfig                          |  15 +
 drivers/phy/intel/Makefile                         |   1 +
 drivers/phy/intel/phy-intel-combo.c                | 632 ++++++++++++++++++++
 drivers/phy/motorola/phy-cpcap-usb.c               |   2 -
 drivers/phy/qualcomm/Kconfig                       |  17 +
 drivers/phy/qualcomm/Makefile                      |   2 +
 drivers/phy/qualcomm/phy-qcom-ipq4019-usb.c        | 148 +++++
 drivers/phy/qualcomm/phy-qcom-qmp.c                | 254 +++++++-
 drivers/phy/qualcomm/phy-qcom-qmp.h                | 238 +++++++-
 drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c      | 287 +++++++++
 drivers/phy/samsung/phy-s5pv210-usb2.c             |   4 +
 drivers/phy/ti/phy-am654-serdes.c                  | 104 +++-
 drivers/phy/ti/phy-j721e-wiz.c                     |  65 ++-
 drivers/phy/ti/phy-omap-usb2.c                     |  60 +-
 drivers/thunderbolt/Kconfig                        |   1 -
 drivers/thunderbolt/icm.c                          |  22 +
 drivers/thunderbolt/nhi.c                          |   5 +
 drivers/thunderbolt/nhi.h                          |   2 +
 drivers/thunderbolt/switch.c                       |   7 -
 drivers/usb/cdns3/cdns3-ti.c                       |   3 +-
 drivers/usb/cdns3/core.c                           |  47 +-
 drivers/usb/cdns3/core.h                           |   2 -
 drivers/usb/cdns3/drd.c                            |   4 +-
 drivers/usb/cdns3/ep0.c                            |   7 -
 drivers/usb/cdns3/gadget.c                         |  15 +-
 drivers/usb/chipidea/Kconfig                       |  37 +-
 drivers/usb/chipidea/Makefile                      |  13 +-
 drivers/usb/chipidea/ci.h                          |   1 +
 drivers/usb/chipidea/ci_hdrc_imx.c                 |  13 +-
 drivers/usb/chipidea/ci_hdrc_imx.h                 |   2 +
 drivers/usb/chipidea/ci_hdrc_usb2.c                |  30 +-
 drivers/usb/chipidea/ci_hdrc_zevio.c               |  67 ---
 drivers/usb/chipidea/core.c                        |  48 +-
 drivers/usb/chipidea/udc.c                         | 170 ++++--
 drivers/usb/chipidea/udc.h                         |   6 +-
 drivers/usb/chipidea/usbmisc_imx.c                 | 334 ++++++++++-
 drivers/usb/class/cdc-acm.c                        |   2 +-
 drivers/usb/class/usblp.c                          |   5 +-
 drivers/usb/core/hcd-pci.c                         |   7 +-
 drivers/usb/core/hub.c                             |   2 +-
 drivers/usb/core/hub.h                             |   2 +-
 drivers/usb/core/otg_whitelist.h                   |   2 +-
 drivers/usb/core/sysfs.c                           |   6 +-
 drivers/usb/core/usb.h                             |   2 +-
 drivers/usb/dwc2/core.c                            |  23 +-
 drivers/usb/dwc2/core.h                            |   6 +-
 drivers/usb/dwc2/core_intr.c                       |   7 +-
 drivers/usb/dwc2/debug.h                           |   2 +-
 drivers/usb/dwc2/hcd.h                             |   2 +-
 drivers/usb/dwc2/hw.h                              |   3 +-
 drivers/usb/dwc2/params.c                          |  19 -
 drivers/usb/dwc2/platform.c                        |  39 ++
 drivers/usb/dwc3/core.c                            |  62 +-
 drivers/usb/dwc3/core.h                            |  83 ++-
 drivers/usb/dwc3/debug.h                           |   4 +-
 drivers/usb/dwc3/debugfs.c                         |  14 +-
 drivers/usb/dwc3/drd.c                             |   6 +-
 drivers/usb/dwc3/dwc3-keystone.c                   |  41 +-
 drivers/usb/dwc3/dwc3-meson-g12a.c                 | 422 +++++++++++---
 drivers/usb/dwc3/dwc3-of-simple.c                  |  30 +-
 drivers/usb/dwc3/gadget.c                          | 469 +++++++++++----
 drivers/usb/dwc3/gadget.h                          |   2 +-
 drivers/usb/dwc3/host.c                            |   2 +-
 drivers/usb/dwc3/io.h                              |   2 +-
 drivers/usb/dwc3/trace.h                           |   2 +-
 drivers/usb/early/xhci-dbc.c                       |   1 -
 drivers/usb/early/xhci-dbc.h                       |   2 +-
 drivers/usb/gadget/composite.c                     |  78 ++-
 drivers/usb/gadget/configfs.c                      |  14 +-
 drivers/usb/gadget/function/f_acm.c                |  16 +
 drivers/usb/gadget/function/f_eem.c                |   2 -
 drivers/usb/gadget/function/f_fs.c                 |   2 +-
 drivers/usb/gadget/function/f_serial.c             |  16 +
 drivers/usb/gadget/function/f_tcm.c                |   3 +
 drivers/usb/gadget/function/f_uvc.h                |   2 +-
 drivers/usb/gadget/function/rndis.h                |   2 +-
 drivers/usb/gadget/function/u_audio.h              |   2 +-
 drivers/usb/gadget/function/u_ecm.h                |   2 +-
 drivers/usb/gadget/function/u_eem.h                |   2 +-
 drivers/usb/gadget/function/u_ether.h              |   2 +-
 drivers/usb/gadget/function/u_ether_configfs.h     |   2 +-
 drivers/usb/gadget/function/u_fs.h                 |   2 +-
 drivers/usb/gadget/function/u_gether.h             |   2 +-
 drivers/usb/gadget/function/u_hid.h                |   2 +-
 drivers/usb/gadget/function/u_midi.h               |   2 +-
 drivers/usb/gadget/function/u_ncm.h                |   2 +-
 drivers/usb/gadget/function/u_phonet.h             |   2 +-
 drivers/usb/gadget/function/u_printer.h            |   2 +-
 drivers/usb/gadget/function/u_rndis.h              |   2 +-
 drivers/usb/gadget/function/u_serial.c             |  57 +-
 drivers/usb/gadget/function/u_serial.h             |   4 +-
 drivers/usb/gadget/function/u_tcm.h                |   2 +-
 drivers/usb/gadget/function/u_uac1.h               |   2 +-
 drivers/usb/gadget/function/u_uac1_legacy.h        |   2 +-
 drivers/usb/gadget/function/u_uac2.h               |   2 +-
 drivers/usb/gadget/function/u_uvc.h                |   2 +-
 drivers/usb/gadget/function/uvc.h                  |   4 +-
 drivers/usb/gadget/function/uvc_configfs.h         |   2 +-
 drivers/usb/gadget/function/uvc_v4l2.c             |   4 +-
 drivers/usb/gadget/function/uvc_v4l2.h             |   2 +-
 drivers/usb/gadget/function/uvc_video.c            |  76 +--
 drivers/usb/gadget/function/uvc_video.h            |   4 +-
 drivers/usb/gadget/legacy/mass_storage.c           |  14 +-
 drivers/usb/gadget/udc/aspeed-vhub/core.c          |  16 +-
 drivers/usb/gadget/udc/aspeed-vhub/hub.c           | 236 +++++++-
 drivers/usb/gadget/udc/aspeed-vhub/vhub.h          |  12 +-
 drivers/usb/gadget/udc/atmel_usba_udc.c            | 112 ++--
 drivers/usb/gadget/udc/atmel_usba_udc.h            |  12 +
 drivers/usb/gadget/udc/core.c                      |   2 +
 drivers/usb/gadget/udc/dummy_hcd.c                 |  27 +-
 drivers/usb/gadget/udc/fsl_udc_core.c              |   4 +-
 drivers/usb/gadget/udc/gr_udc.c                    |   1 -
 drivers/usb/gadget/udc/lpc32xx_udc.c               |  11 +-
 drivers/usb/gadget/udc/m66592-udc.c                |   2 +-
 drivers/usb/gadget/udc/max3420_udc.c               |   2 +-
 drivers/usb/gadget/udc/mv_u3d_core.c               |   2 +-
 drivers/usb/gadget/udc/net2272.c                   |   2 +-
 drivers/usb/gadget/udc/omap_udc.c                  |   2 +-
 drivers/usb/gadget/udc/s3c2410_udc.c               |   4 -
 drivers/usb/gadget/udc/tegra-xudc.c                | 140 +++++
 drivers/usb/gadget/udc/udc-xilinx.c                |   1 +
 drivers/usb/gadget/usbstring.c                     |  24 +
 drivers/usb/host/Kconfig                           |  29 +
 drivers/usb/host/Makefile                          |   2 +
 drivers/usb/host/ehci-brcm.c                       | 280 +++++++++
 drivers/usb/host/ehci-fsl.h                        |   2 +-
 drivers/usb/host/ehci-mv.c                         |  12 +-
 drivers/usb/host/ehci-mxc.c                        |  15 +-
 drivers/usb/host/ehci-pci.c                        |   6 +-
 drivers/usb/host/ehci-platform.c                   |   4 +
 drivers/usb/host/ehci-tegra.c                      |   1 -
 drivers/usb/host/ehci.h                            |   2 +-
 drivers/usb/host/fhci.h                            |   2 +-
 drivers/usb/host/imx21-hcd.h                       |   2 +-
 drivers/usb/host/ohci-pci.c                        |   9 +-
 drivers/usb/host/ohci-platform.c                   |   5 +
 drivers/usb/host/ohci-sm501.c                      |   7 +-
 drivers/usb/host/ohci.h                            |   2 +-
 drivers/usb/host/pci-quirks.c                      |   8 +-
 drivers/usb/host/r8a66597.h                        |   2 +-
 drivers/usb/host/u132-hcd.c                        |  10 -
 drivers/usb/host/uhci-pci.c                        |   8 +-
 drivers/usb/host/xhci-debugfs.h                    |   2 +-
 drivers/usb/host/xhci-ext-caps.h                   |   2 +-
 drivers/usb/host/xhci-mtk.h                        |   2 +-
 drivers/usb/host/xhci-mvebu.h                      |   2 +-
 drivers/usb/host/xhci-pci-renesas.c                | 645 +++++++++++++++++++++
 drivers/usb/host/xhci-pci.c                        |  47 +-
 drivers/usb/host/xhci-pci.h                        |  28 +
 drivers/usb/host/xhci-plat.c                       |  20 +-
 drivers/usb/host/xhci-plat.h                       |   2 +-
 drivers/usb/host/xhci-rcar.h                       |   2 +-
 drivers/usb/host/xhci-trace.h                      |   2 +-
 drivers/usb/host/xhci.h                            |   3 +-
 drivers/usb/isp1760/isp1760-core.h                 |   2 +-
 drivers/usb/isp1760/isp1760-regs.h                 |   2 +-
 drivers/usb/isp1760/isp1760-udc.h                  |   2 +-
 drivers/usb/misc/sisusbvga/sisusb.h                |   2 +-
 drivers/usb/misc/sisusbvga/sisusb_init.h           |   2 +-
 drivers/usb/misc/sisusbvga/sisusb_struct.h         |   2 +-
 drivers/usb/misc/usb_u132.h                        |   2 +-
 drivers/usb/mtu3/mtu3.h                            |   2 +-
 drivers/usb/mtu3/mtu3_debug.h                      |   2 +-
 drivers/usb/mtu3/mtu3_dr.h                         |   2 +-
 drivers/usb/mtu3/mtu3_hw_regs.h                    |   2 +-
 drivers/usb/mtu3/mtu3_qmu.h                        |   2 +-
 drivers/usb/mtu3/mtu3_trace.h                      |   2 +-
 drivers/usb/musb/davinci.h                         |   2 +-
 drivers/usb/musb/jz4740.c                          |   4 +-
 drivers/usb/musb/mediatek.c                        |   6 +
 drivers/usb/musb/musb_core.c                       |   9 +-
 drivers/usb/musb/musb_core.h                       |   2 +-
 drivers/usb/musb/musb_debug.h                      |   2 +-
 drivers/usb/musb/musb_debugfs.c                    |  10 +-
 drivers/usb/musb/musb_dma.h                        |   2 +-
 drivers/usb/musb/musb_gadget.h                     |   2 +-
 drivers/usb/musb/musb_host.c                       |  10 +-
 drivers/usb/musb/musb_host.h                       |   2 +-
 drivers/usb/musb/musb_io.h                         |   2 +-
 drivers/usb/musb/musb_regs.h                       |   2 +-
 drivers/usb/musb/musb_trace.h                      |   2 +-
 drivers/usb/musb/omap2430.h                        |   2 +-
 drivers/usb/musb/tusb6010.h                        |   2 +-
 drivers/usb/phy/phy-fsl-usb.h                      |   2 +-
 drivers/usb/phy/phy-jz4770.c                       |  12 +-
 drivers/usb/phy/phy-mv-usb.h                       |   2 +-
 drivers/usb/renesas_usbhs/common.h                 |   2 +-
 drivers/usb/renesas_usbhs/fifo.h                   |   2 +-
 drivers/usb/renesas_usbhs/mod.h                    |   2 +-
 drivers/usb/renesas_usbhs/pipe.h                   |   2 +-
 drivers/usb/renesas_usbhs/rcar2.h                  |   2 +-
 drivers/usb/renesas_usbhs/rcar3.h                  |   2 +-
 drivers/usb/renesas_usbhs/rza.h                    |   2 +-
 drivers/usb/roles/class.c                          |   4 +-
 drivers/usb/serial/belkin_sa.h                     |   2 +-
 drivers/usb/serial/ch341.c                         |  68 ++-
 drivers/usb/serial/io_16654.h                      |   2 +-
 drivers/usb/serial/io_edgeport.h                   |   2 +-
 drivers/usb/serial/io_ionsp.h                      |   2 +-
 drivers/usb/serial/io_ti.h                         |   2 +-
 drivers/usb/serial/io_usbvend.h                    |   2 +-
 drivers/usb/serial/iuu_phoenix.h                   |   2 +-
 drivers/usb/serial/mct_u232.h                      |   2 +-
 drivers/usb/serial/option.c                        |   4 +
 drivers/usb/serial/oti6858.h                       |   2 +-
 drivers/usb/serial/pl2303.h                        |   2 +-
 drivers/usb/serial/qcserial.c                      |   1 +
 drivers/usb/serial/usb_wwan.c                      |   4 +
 drivers/usb/serial/visor.h                         |   2 +-
 drivers/usb/serial/whiteheat.h                     |   2 +-
 drivers/usb/storage/debug.h                        |   2 +-
 drivers/usb/storage/initializers.h                 |   2 +-
 drivers/usb/storage/protocol.h                     |   2 +-
 drivers/usb/storage/scsiglue.h                     |   2 +-
 drivers/usb/storage/sierra_ms.c                    |   4 -
 drivers/usb/storage/transport.h                    |   2 +-
 drivers/usb/storage/unusual_alauda.h               |   2 +-
 drivers/usb/storage/unusual_cypress.h              |   2 +-
 drivers/usb/storage/unusual_datafab.h              |   2 +-
 drivers/usb/storage/unusual_devs.h                 |   2 +-
 drivers/usb/storage/unusual_ene_ub6250.h           |   2 +-
 drivers/usb/storage/unusual_freecom.h              |   2 +-
 drivers/usb/storage/unusual_isd200.h               |   2 +-
 drivers/usb/storage/unusual_jumpshot.h             |   2 +-
 drivers/usb/storage/unusual_karma.h                |   2 +-
 drivers/usb/storage/unusual_onetouch.h             |   2 +-
 drivers/usb/storage/unusual_realtek.h              |   2 +-
 drivers/usb/storage/unusual_sddr09.h               |   2 +-
 drivers/usb/storage/unusual_sddr55.h               |   2 +-
 drivers/usb/storage/unusual_uas.h                  |   2 +-
 drivers/usb/storage/unusual_usbat.h                |   2 +-
 drivers/usb/storage/usb.h                          |   2 +-
 drivers/usb/typec/Kconfig                          |   3 +-
 drivers/usb/typec/class.c                          |  36 +-
 drivers/usb/typec/mux/intel_pmc_mux.c              |  42 +-
 drivers/usb/typec/tcpm/fusb302.c                   |  32 +-
 drivers/usb/typec/tcpm/fusb302_reg.h               |   2 +-
 drivers/usb/typec/tps6598x.c                       |  64 +-
 drivers/usb/typec/ucsi/Makefile                    |   4 +
 drivers/usb/typec/ucsi/psy.c                       | 241 ++++++++
 drivers/usb/typec/ucsi/trace.c                     |  10 +-
 drivers/usb/typec/ucsi/ucsi.c                      |  41 +-
 drivers/usb/typec/ucsi/ucsi.h                      |  26 +-
 include/dt-bindings/phy/phy.h                      |   1 +
 include/linux/phy/omap_usb.h                       |  69 +--
 include/linux/thunderbolt.h                        |   2 +-
 include/linux/usb/chipidea.h                       |   1 +
 include/linux/usb/composite.h                      |   3 +
 include/linux/usb/gadget.h                         |   8 +
 include/linux/usb/hcd.h                            |   3 +-
 include/linux/usb/typec.h                          |   1 +
 314 files changed, 7812 insertions(+), 2705 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/amlogic,meson8b-usb2-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/cdns,salvo-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/intel,combo-phy.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/meson-gxl-usb3-phy.txt
 delete mode 100644 Documentation/devicetree/bindings/phy/meson8b-usb2-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/qcom-usb-ipq4019-phy.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt
 delete mode 100644 Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb3.txt
 create mode 100644 Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/renesas,usb3-phy.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/amlogic,dwc3.txt
 create mode 100644 Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/keystone-usb.txt
 create mode 100644 Documentation/devicetree/bindings/usb/ti,keystone-dwc3.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
 create mode 100644 Documentation/firmware-guide/acpi/intel-pmc-mux.rst
 delete mode 100644 drivers/phy/amlogic/phy-meson-gxl-usb3.c
 create mode 100644 drivers/phy/cadence/phy-cadence-salvo.c
 create mode 100644 drivers/phy/intel/phy-intel-combo.c
 create mode 100644 drivers/phy/qualcomm/phy-qcom-ipq4019-usb.c
 create mode 100644 drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
 delete mode 100644 drivers/usb/chipidea/ci_hdrc_zevio.c
 create mode 100644 drivers/usb/host/ehci-brcm.c
 create mode 100644 drivers/usb/host/xhci-pci-renesas.c
 create mode 100644 drivers/usb/host/xhci-pci.h
 create mode 100644 drivers/usb/typec/ucsi/psy.c
