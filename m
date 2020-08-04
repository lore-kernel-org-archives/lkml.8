Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A26C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 17:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48D9621744
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 17:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596562676;
	bh=sWOs1DD7UGMyvaZcJnqaK366dli8ROK5EKQPIWQTysQ=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Lnn5XDDeHYuhJq+pgCEjaP9qzqeMSss644+lLKd49u6kFpqO22z7hKas2H7/31AyG
	 0F/9KDpPC+raRtTLyGY+PWoX9YA8oY1Ia18/8GTsTi5MHelMpYJYafSEe6W7wdmWFn
	 R/iQXp7soiG79RhpnEvyYgzPKjyZobBSRDXav9oU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730120AbgHDRhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 13:37:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:40878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729703AbgHDRhy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 13:37:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C2D1207FC;
        Tue,  4 Aug 2020 17:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596562672;
        bh=sWOs1DD7UGMyvaZcJnqaK366dli8ROK5EKQPIWQTysQ=;
        h=Date:From:To:Cc:Subject:From;
        b=PLcAC/7oLDvjhNIOndKzm3OwaPlcUG9FlPI3gCFNYNpL1//e5M0BcuX0cmUIxbUXC
         aIcuGBS/cHjxKwEyuOtbm3I939JziTU4Tzx3pXoEacX5GJC/6P6Y2m9Y0uuehP9RpH
         4LyNC3o/pF24vC59vFsTDrhExo1cYfJRsEo4Q3Gc=
Date:   Tue, 4 Aug 2020 19:38:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB/Thunderbolt patches for 5.9-rc1
Message-ID: <20200804173811.GA513846@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 92ed301919932f777713b9172e525674157e983d:

  Linux 5.8-rc7 (2020-07-26 14:14:06 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.9-rc1

for you to fetch changes up to e3ee0e740c3887d2293e8d54a8707218d70d86ca:

  usb: common: usb-conn-gpio: Register charger (2020-07-30 08:45:24 +0200)

----------------------------------------------------------------
USB/Thunderbolt patches for 5.9-rc1

Here is the large set of USB and Thunderbolt patches for 5.9-rc1.

Nothing really magic/major in here, just lots of little changes and
updates:
	- clean up language usages in USB core and some drivers
	- Thunderbolt driver updates and additions
	- USB Gadget driver updates
	- dwc3 driver updates (like always...)
	- build with "W=1" warning fixups
	- mtu3 driver updates
	- usb-serial driver updates and device ids
	- typec additions and updates for new hardware
	- xhci debug code updates for future platforms
	- cdns3 driver updates
	- lots of other minor driver updates and fixes and cleanups

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Al Cooper (4):
      dt-bindings: usb: bdc: Update compatible strings
      usb: bdc: Add compatible string for new style USB DT nodes
      usb: bdc: Adb shows offline after resuming from S2
      usb: bdc: driver runs out of buffer descriptors on large ADB transfers

Alexander A. Klimov (9):
      USB: storage: replace HTTP links with HTTPS ones
      USB: ohci: Replace HTTP links with HTTPS ones
      usb: typec: Replace HTTP links with HTTPS ones
      usb: host: xhci-plat: Replace HTTP links with HTTPS ones
      usb: dwc3: Replace HTTP links with HTTPS ones
      tools: usb: usbip: Replace HTTP links with HTTPS ones
      usb: phy: Replace HTTP links with HTTPS ones
      usb: gadget: Replace HTTP links with HTTPS ones
      USB: Replace HTTP links with HTTPS ones

Amelie Delaunay (2):
      usb: dwc2: override PHY input signals with usb role switch support
      usb: dwc2: don't use ID/Vbus detection if usb-role-switch on STM32MP15 SoCs

Andy Shevchenko (1):
      usb: hcd: Try MSI interrupts on PCI devices

Antonio Borneo (3):
      usbip: tools: fix build error for multiple definition
      usbip: tools: fix module name in man page
      usbip: tools: add in man page how to load the client's module

Badhri Jagan Sridharan (3):
      usb: typec: tcpm: Support bist test data mode for compliance
      usb: typec: tcpci: Support BIST test data mode for compliance.
      usb: typec: tcpm: Stay in BIST mode till hardreset or unattached

Bastien Nocera (1):
      USB: Simplify USB ID table match

Bixuan Cui (1):
      usb: usbtest: reduce stack usage in test_queue

Brant Merryman (2):
      USB: serial: cp210x: enable usb generic throttle/unthrottle
      USB: serial: cp210x: re-enable auto-RTS on open

Changming Liu (2):
      USB: sisusbvga: change char to u8 for sisusb_copy_memory
      USB: sisusbvga: Fix a potential UB casued by left shifting a negative value

Christoph Hellwig (1):
      usb: usbfs: stop using compat_alloc_user_space

Chunfeng Yun (19):
      usb: gadget: bdc: use readl_poll_timeout() to simplify code
      usb: mtu3: convert to devm_platform_ioremap_resource_byname
      usb: phy: am335x: convert to devm_platform_ioremap_resource_byname
      usb: cdns3: convert to devm_platform_ioremap_resource_byname
      usb: dwc3: convert to devm_platform_ioremap_resource_byname
      usb: gadget: r8a66597: convert to devm_platform_ioremap_resource_byname
      usb: gadget: tegra-xudc: convert to devm_platform_ioremap_resource_byname
      usb: musb: convert to devm_platform_ioremap_resource_byname
      usb: mtu3: remove unnecessary pointer checks
      usb: mtu3: fix macro for maximum number of packets
      usb: mtu3: reinitialize CSR registers
      usb: mtu3: clear interrupts status when disable interrupts
      usb: mtu3: introduce a funtion to check maximum speed
      usb: mtu3: add ->udc_set_speed()
      usb: mtu3: remove repeated error log
      usb: mtu3: remove useless member @busy in mtu3_ep struct
      usb: mtu3: use MTU3_EP_WEDGE flag
      usb: mtu3: clear dual mode of u3port when disable device
      usb: mtu3: simplify mtu3_req_complete()

Colin Ian King (2):
      usb: xhci: fix spelling mistake in Kconfig "firwmare" -> "firmware"
      thunderbolt: Ensure left shift of 512 does not overflow a 32 bit int

Colton Lewis (1):
      usb: correct kernel-doc inconsistency

Dan Robertson (1):
      usb: dwc3: meson-g12a: fix shared reset control use

Danesh Petigara (1):
      usb: bdc: Halt controller on suspend

Erik Ekman (1):
      USB: serial: qcserial: add EM7305 QDL product ID

Evgeny Novikov (2):
      usb: gadget: net2272: skip BAR1 on error handling paths in probe
      usb: gadget: net2280: fix memory leak on probe error handling paths

Fabio Estevam (1):
      Documentation: ABI: usb: chipidea: Update Li Jun's e-mail

Florian Fainelli (1):
      usb: bdc: Use devm_clk_get_optional()

Forest Crossman (2):
      usb: xhci: define IDs for various ASMedia host controllers
      usb: xhci: Fix ASMedia ASM1142 DMA addressing

Geert Uytterhoeven (1):
      thunderbolt: Improve USB4 config symbol help text

Greg Kroah-Hartman (23):
      USB: rename USB quirk to USB_QUIRK_ENDPOINT_IGNORE
      USB: rename USB OTG hub configuration option
      USB: OHCI: remove obsolete FIXME comment
      USB: serial: qcserial: fix up wording in a comment
      USB: serial: sierra: unify quirk handling logic
      USB: storage: fix wording in error message
      USB: storage: scsi: fix up comment to be more specific
      USB: OTG: rename product list of devices
      USB: ch9: add "USB_" prefix in front of TEST defines
      Merge 5.8-rc3 into usb-next
      USB: Fix up terminology
      USB: Fix up terminology in include files
      USB: phy: fsl-usb: remove sysfs abuse
      USB: phy: fsl-usb: remove character device usage
      Merge 5.8-rc6 into usb-next
      Merge tag 'thunderbolt-for-v5.9' of git://git.kernel.org/.../westeri/thunderbolt into usb-next
      Merge 5.8-rc7 into usb-next
      Merge tag 'usb-for-v5.9' of git://git.kernel.org/.../balbi/usb into usb-next
      USB: iowarrior: fix up report size handling for some devices
      Revert "usb: dwc2: don't use ID/Vbus detection if usb-role-switch on STM32MP15 SoCs"
      Revert "usb: dwc2: override PHY input signals with usb role switch support"
      Merge tag 'usb-serial-5.9-rc1' of https://git.kernel.org/.../johan/usb-serial into usb-next
      Merge tag 'usb-ci-v5.9-rc1' of git://git.kernel.org/.../peter.chen/usb into usb-next

Gustavo A. R. Silva (8):
      usb: sisusb_con: Use array_size() helper in memcpy()
      USB: serial: use fallthrough pseudo-keyword
      usbip: Use fallthrough pseudo-keyword
      usb: phy: Use fallthrough pseudo-keyword
      usb: Use fallthrough pseudo-keyword
      USB: OHCI: Use fallthrough pseudo-keyword
      usb: host: Use fallthrough pseudo-keyword
      usb: gadget: Use fallthrough pseudo-keyword

Hans de Goede (6):
      usb: typec: tcpm: Move mod_delayed_work(&port->vdm_state_machine) call into tcpm_queue_vdm()
      usb: typec: tcpm: Add tcpm_queue_vdm_unlocked() helper
      usb: typec: tcpm: Refactor tcpm_handle_vdm_request payload handling
      usb: typec: tcpm: Refactor tcpm_handle_vdm_request
      usb: typec: tcpm: Fix AB BA lock inversion between tcpm code and the alt-mode drivers
      usb: typec: tcpm: Add WARN_ON ensure we are not trying to send 2 VDM packets at the same time

Heikki Krogerus (4):
      usb: typec: Combine the definitions for Accessory and USB modes
      usb: typec: Add data structure for Enter_USB message
      usb: typec: intel_pmc_mux: Definitions for response status bits
      usb: typec: intel_pmc_mux: Add support for USB4

Jisheng Zhang (1):
      usb: dwc2: use well defined macros for power_down

Johan Hovold (24):
      USB: serial: ch341: add min and max line-speed macros
      USB: serial: garmin_gps: don't compile unused packet definitions
      USB: serial: iuu_phoenix: drop unused URB submission results
      USB: serial: keyspan_pda: drop unused firmware reset status
      USB: serial: kobil_sct: log failure to update line settings
      USB: serial: quatech2: drop two stub functions
      USB: serial: console: add support for flow control
      USB: serial: ftdi_sio: make process-packet buffer unsigned
      USB: serial: ftdi_sio: clean up receive processing
      USB: serial: ftdi_sio: fix break and sysrq handling
      USB: serial: only set sysrq timestamp for consoles
      USB: serial: only process sysrq when enabled
      USB: serial: inline sysrq dummy function
      USB: serial: add sysrq break-handler dummy
      USB: serial: drop unnecessary sysrq include
      USB: serial: drop extern keyword from function declarations
      USB: serial: drop redundant transfer-buffer casts
      USB: serial: cp210x: disable interface on errors in open
      USB: serial: cp210x: add support for line-status events
      USB: serial: cp210x: add support for TIOCGICOUNT
      USB: serial: cp210x: drop unnecessary packed attributes
      USB: serial: cp210x: use in-kernel types in port data
      USB: serial: sierra: clean up special-interface handling
      USB: serial: iuu_phoenix: fix led-activity helpers

Kai-Heng Feng (1):
      xhci: Make debug message consistent with bus and port number

Kars Mulder (1):
      usb: core: fix quirks_param_set() writing to a const pointer

Kieran Bingham (1):
      drivers: usb: Fix trivial spelling

Kranthi Kuntala (1):
      thunderbolt: Add support for on-board retimers

Kyle Tso (2):
      usb: typec: Comment correction for typec_partner_register_altmode
      usb: typec: tcpm: Error handling for tcpm_register_partner_altmodes

Lee Jones (91):
      usb: phy: phy: Fix-up a whole bunch of formatting issues
      usb: host: pci-quirks: Demote function header from kerneldoc to comment block
      usb: common: debug: Demote comment blocks which are obviously not kerneldoc
      usb: common: usb-conn-gpio: Demote comment block which is clearly not kerneldoc
      usb: dwc3: drd: File headers are not doc headers
      usb: dwc3: ulpi: File headers are not doc headers
      usb: common: ulpi: Fix a few kerneldoc related issues
      usb: dwc3: dwc3-omap: Do not read DMA status
      usb: host: ehci-omap: Provide documentation for ehci_hcd_omap_probe()'s arg 'pdev'
      usb: cdns3: core: Fix incorrect formatting and misspelled function arg docs
      usb: cdns3: ep0: Fix a bunch of kerneldoc issues
      usb: dwc3: dwc3-haps: Function headers are not suitable for kerneldoc
      usb: cdns3: gadget: Fix a bunch of kernel doc issues
      usb: dwc3: dwc3-of-simple: Function headers are not good candidates for kerneldoc
      usb: host: isp1362: Mark the many unused ISP1362_REG entries as __maybe_unused
      usb: host: ohci-at91: Demote kerneldoc headers down to basic comment blocks
      usb: host: ohci: Mark cc_to_error as __maybe_unused
      usb: cdns3: ep0: Move 'zlp' description to appropriate function header
      usb: mtu3: mtu3_core: Demote obvious misuse of kerneldoc to standard comment block
      usb: c67x00: c67x00-ll-hpi: Demote obvious misuse of kerneldoc to standard comment blocks
      usb: class: usbtmc: File headers are not good candidates for kerneldoc
      usb: c67x00: c67x00-sched: Demote obvious misuse of kerneldoc to standard comment blocks
      usb: host: oxu210hp-hcd: Move declaration of 'qtd' into 'ifdef OXU_URB_TRACE'
      usb: dwc2: gadget: Remove assigned but never used 'maxsize'
      usb: mtu3: mtu3_debug: Add forward declaration of 'struct ssusb_mtk'
      usb: host: ohci-s3c2410: Demote obvious misuse of kerneldoc to standard comment block
      usb: core: ledtrig-usbport: Demote obvious misuse of kerneldoc to standard comment blocks
      usb: atm: ueagle-atm: Demote obvious misuse of kerneldoc to standard comment blocks
      usb: misc: adutux: Demote obvious misuse of kerneldoc to standard comment blocks
      usb: chipidea: core: Document hw_port_test_set()'s missing 'ci' argument
      usb: gadget: udc: core: Fix a bunch of kerneldoc misdemeanours
      usb: chipidea: otg: Fix kerneldoc issues relating to description of 'ci'
      usb: chipidea: debug: Demote obvious misuse of kerneldoc to standard comment blocks
      usb: chipidea: udc: Add missing descriptions for function arg 'ci'
      usb: chipidea: udc: Help out kerneldoc headers that have tried, demote the others
      usb: host: xhci: Demote obvious misuse of kerneldoc to standard comment block
      usb: host: xhci-mem: Demote obvious misuse of kerneldoc to standard comment block
      usb: host: xhci-dbgcap: File headers are not good candidates for kerneldoc
      usb: host: xhci-dbgtty: File headers are not good candidates for kerneldoc
      usb: chipidea: udc: Fix a few kerneldoc issues
      usb: host: xhci-debugfs: Use 'gnu_printf' format notation
      usb: storage: alauda: Remove set but unchecked variable
      usb: typec: altmodes: displayport: File headers are not good candidates for kerneldoc
      usb: typec: altmodes: displayport: Supply missing displayport.h include file
      usb: typec: tcpm: fusb302: Use 'gnu_printf' format notation
      usb: chipidea: usbmisc_imx: Demote obvious misuse of kerneldoc to standard comment block
      usb: misc: iowarrior: Fix odd corruption issue in the file header
      usb: misc: iowarrior: Demote obvious misuse of kerneldoc to standard comment blocks
      usb: gadget: function: u_serial: Repair misdocumented function argument
      usb: misc: ldusb: Demote obvious misuse of kerneldoc to standard comment blocks
      usb: musb: musb_dsps: Demote obvious misuse of kerneldoc to standard comment blocks
      usb: gadget: udc: dummy_hcd: Repair misspelled function argument 'dummy_hcd'
      usb: misc: legousbtower: Demote obvious misuse of kerneldoc to standard comment blocks
      usb: chipidea: ci_hdrc_pci: Fix improper use of kerneldoc format
      usb: gadget: legacy: printer: Remove unused variable 'driver_desc'
      usb: gadget: udc: amd5536udc_pci: Remove unused variable 'mod_desc'
      usb: gadget: function: u_ether: Downgrade kerneldoc headers which to not make the mark
      usb: gadget: udc: pxa27x_udc: Fix a bunch of kerneldoc issues
      usb: misc: legousbtower: Demote function header which is clearly not kerneldoc
      usb: gadget: udc: atmel_usba_udc: Remove set but unused variable 'pp'
      usb: gadget: legacy: nokia: Remove unused static variable 'product_nokia'
      usb: gadget: function: f_fs: Demote function header which is clearly not kerneldoc
      usb: gadget: udc: lpc32xx_udc: Staticify 2 local functions
      usb: host: r8a66597-hcd: Remove set, then over-written, but never used variable 'tmp'
      usb: gadget: udc: mv_udc_core: Remove unused static const variable 'driver_desc'
      usb: gadget: udc: pch_udc: Fix a plethora of function documentation related issues
      usb: host: imx21-hcd: Demote function header which is clearly not kerneldoc
      usb: host: ehci-fsl: Fix incorrectly named function argument
      usb: host: fotg210-hcd: Remove unused variable 'hcc_params'
      usb: gadget: function: u_uac1_legacy: Demote obvious misuse of kerneldoc to standard comment blocks
      usb: host: bcma-hcd: Demote obvious misuse of kerneldoc to standard comment blocks
      usb: host: fotg210-hcd: Demote obvious misuse of kerneldoc to standard comment blocks
      usb: gadget: udc: mv_u3d_core: Remove unused static const 'driver_desc'
      usb: gadget: udc: max3420_udc: Remove set, but never checked variable 'addr'
      usb: typec: ucsi: ucsi: Staticify and stop export of ucsi_init()
      usb: early: ehci-dbgp: Remove set but never checked variable 'ret'
      usb: early: xhci-dbc: Supply missing 'xhci-dbgp.h' headerfile
      usb: early: xhci-dbc: File headers are not good candidates for kerneldoc
      usb: host: ehci-platform: Do not define 'struct acpi_device_id' when !CONFIG_ACPI
      usb: dwc3: dwc3-qcom: Do not define 'struct acpi_device_id' when !CONFIG_ACPI
      usb: host: fhci-tds: Remove unused variables 'buf' and 'extra_data'
      usb: host: fhci-sched: Remove unused variable 'td'
      usb: host: xhci-plat: Do not define 'struct acpi_device_id' when !CONFIG_ACPI
      usb: dwc2: gadget: Make use of GINTMSK2
      usb: dwc2: gadget: Avoid pointless read of EP control register
      usb: mtu3: mtu3_trace: Function headers are not suitable for kerneldoc
      usb: mtu3: mtu3_trace: Supply missing mtu3_debug.h include file
      usb: class: cdc-wdm: Provide description for usb_cdc_wdm_register()'s manage_power arg
      usb: c67x00: c67x00-hcd: Demote obvious misuse of kerneldoc to standard comment blocks
      usb: misc: sisusbvga: sisusb_init: Remove genunine unused static const arrays
      usb: misc: sisusbvga: Move static const tables out to different include file

Linus Walleij (3):
      usb: ehci-omap: Drop surplus include
      usb: ohci-omap: Create private state container
      usb: ohci-omap: Convert to use GPIO descriptors

Macpaul Lin (2):
      usb: gadget: u_serial.h: increase MAX_U_SERIAL_PORTS to 8
      USB: replace hardcode maximum usb string length by definition

Marek Szyprowski (2):
      usb: gadget: udc: Flush pending work also in error path
      usb: dwc2: Fix error path in gadget registration

Mario Limonciello (2):
      thunderbolt: Add support for separating the flush to SPI and authenticate
      thunderbolt: Add support for authenticate on disconnect

Mathias Nyman (26):
      xhci: dbc: Don't use generic xhci inc_deq() function for dbc
      xhci: Don't pass struct xhci_hcd pointer to xhci_link_seg()
      xhci: dbc: Don't use generic xhci erst allocation and free functions
      xhci: dbc: Remove dbc_dma_alloc_coherent() wrapper
      xhci: dbc: Remove dbc_dma_free_coherent() wrapper
      xhci: dbc: Add device pointer to dbc structure
      xhci: dbc: Use dev_info() and similar instead of xhci_info()
      xhci: dbc: Don't use xhci_write_64() as it takes xhci as a parameter
      xhci: dbc: Don't pass the xhci pointer as a parameter to xhci_dbc_init_context()
      xhci: dbc: Get the device pointer from dbc structure in dbc_ep_do_queue()
      xhci: dbc: Pass dbc pointer to endpoint init and exit functions.
      xhci: dbc: Change to pass dbc pointer to xhci_do_dbc_stop()
      xhci: dbc: Pass dbc pointer to dbc_handle_xfer_event() instead of xhci_hcd pointer
      xhci: dbgtty: Pass dbc pointer when registering a dbctty device
      xhci: dbc: Pass dbc pointer to get_in/out_ep() helper functions to get endpoints
      xhci: dbc: Use dbc structure in the request completion instead of xhci_hcd
      xhci: dbc: Don't use generic xhci context allocation for dbc
      xhci: dbc: don't use generic xhci ring allocation functions for dbc.
      xhci: dbc: Pass dbc pointer to dbc memory init and cleanup functions
      xhci: dbc: Pass dbc pointer to dbc start and stop functions.
      xhci: dbc: simplify dbc requests allocation and queueing
      xhci: dbc: remove endpoint pointers from dbc_port structure
      xhci: dbctty: split dbc tty driver registration and unregistration functions.
      xhci: dbc: Add a operations structure to access driver functions
      xhci: dbgcap: remove dbc dependency on dbctty specific flag
      xhci: dbc: remove tty specific port structure from struct xhci_dbc

Michael Grzeschik (2):
      usb: dwc3: gadget: add frame number mask
      usb: dwc3: gadget: when the started list is empty stop the active xfer

Michael Hanselmann (3):
      USB: serial: ch341: name prescaler, divisor registers
      USB: serial: ch341: simulate break condition if not supported
      USB: serial: ch341: fix missing simulated-break margin

Michael Olbrich (1):
      usb: dwc3: gadget: make starting isoc transfers more robust

Michał Mirosław (1):
      usb: gadget: udc: atmel: implement .pullup callback

Mika Westerberg (25):
      thunderbolt: Build initial XDomain property block upon first connect
      thunderbolt: No need to warn if NHI hop_count != 12 or hop_count != 32
      thunderbolt: NHI can use HopIDs 1-7
      thunderbolt: Get rid of E2E workaround
      thunderbolt: Fix path indices used in USB3 tunnel discovery
      thunderbolt: Make tb_next_port_on_path() work with tree topologies
      thunderbolt: Make tb_path_alloc() work with tree topologies
      thunderbolt: Check that both ports are reachable when allocating path
      thunderbolt: Handle incomplete PCIe/USB3 paths correctly in discovery
      thunderbolt: Increase path length in discovery
      thunderbolt: Add KUnit tests for path walking
      thunderbolt: Add DP IN resources for all routers
      thunderbolt: Do not tunnel USB3 if link is not USB4
      thunderbolt: Make usb4_switch_map_usb3_down() also return enabled ports
      thunderbolt: Make usb4_switch_map_pcie_down() also return enabled ports
      thunderbolt: Report consumed bandwidth in both directions
      thunderbolt: Increase DP DPRX wait timeout
      thunderbolt: Implement USB3 bandwidth negotiation routines
      thunderbolt: Make tb_port_get_link_speed() available to other files
      thunderbolt: Add USB3 bandwidth management
      thunderbolt: Add KUnit tests for tunneling
      thunderbolt: Add Intel USB-IF ID to the NVM upgrade supported list
      thunderbolt: Split common NVM functionality into a separate file
      thunderbolt: Generalize usb4_switch_do_[read|write]_data()
      thunderbolt: Retry USB4 block read operation

Nicolas Boichat (1):
      usb: cdns3: gadget: Replace trace_printk by dev_dbg

Paul Cercueil (1):
      usb: common: usb-conn-gpio: Register charger

Pawel Laszczak (9):
      usb: cdns3: core: removed cdns3_get_current_role_driver function
      usb: cdns3: drd: removed not needed variables initialization
      usb: cnds3: drd: deleted !=
      usb: cdns3: drd: return IRQ_NONE explicitly.
      usb: cdns3: drd: changed return type from int to bool
      usb: cdns3: Added CDNS3_ID_PERIPHERAL and CDNS3_ID_HOST
      usb: cdns3: core: removed 'goto not_otg'
      usb: cdns3: core: removed overwriting some error code
      usb: cdns3: drd: simplify *switch_gadet and *switch_host

Peter Chen (10):
      usb: chipidea: udc: fix the ENDIAN issue
      usb: cdns3: ep0: delete the duplicate code
      usb: cdns3: gadget: unsigned int is dereferenced as a wider unsigned long
      usb: cdns3: gadget: use unsigned int for 32-bit number
      MAINTAINERS: add freescale USB PHY driver entry
      usb: cdns3: gadget: improve the set_configuration handling
      usb: cdns3: ep0: delete the unnecessary operation
      usb: cdns3: gadget: always zeroed TRB buffer when enable endpoint
      usb: chipidea: add query_available_role interface
      usb: chipidea: imx: get available runtime dr mode for wakeup setting

Prashant Malani (1):
      usb: typec: intel_pmc_mux: Avoid connect request on disconnect

Rajmohan Mani (1):
      thunderbolt: Implement USB4 port sideband operations for retimer access

Randy Dunlap (6):
      usb: fix kernel-doc warnings and formatting in <linux/usb.h>
      Documentation/driver-api: usb/URB: drop doubled word
      usb: linux/usb.h: drop duplicated word in comment
      usb: linux/usb/pd_vdo.h: drop duplicated word in comment
      usb: linux/usb/serial.h: drop duplicated word in comment
      usb: linux/usb/gadget.h: fix duplicated word in comment

Rob Gill (1):
      USB: core: additional Device Classes to debug/usb/devices

Roger Quadros (1):
      dt-bindings: usb: ti,keystone-dwc3.yaml: Improve schema

Ruslan Bilovol (1):
      usb: gadget: f_uac2: fix AC Interface Header Descriptor wTotalLength

Sasi Kumar (1):
      bdc: Fix bug causing crash after multiple disconnects

Suraj Upadhyay (1):
      USB: Remove pci-dma-compat wrapper APIs.

Thierry Reding (1):
      usb: xhci: tegra: Remove PLL power supplies

Wei Yongjun (4):
      thunderbolt: Fix old style declaration warning
      udc: lpc32xx: make symbol 'lpc32xx_usbddata' static
      xhci: dbc: Make function xhci_dbc_ring_alloc() static
      xhci: dbgtty: Make some functions static

Xu Wang (1):
      usb: appledisplay: remove needless check before usb_free_coherent()

YueHaibing (1):
      USB: musb: Remove unused inline function

Zqiang (1):
      usb: gadget: function: printer: Interface is disabled and returns error

周琰杰 (Zhou Yanjie) (4):
      dt-bindings: USB: Add bindings for new Ingenic SoCs.
      USB: PHY: JZ4770: Unify code style and simplify code.
      USB: PHY: JZ4770: Add support for new Ingenic SoCs.
      USB: PHY: JZ4770: Reformat the code to align it.

 Documentation/ABI/testing/sysfs-bus-thunderbolt    |   57 +-
 Documentation/admin-guide/thunderbolt.rst          |   11 +-
 Documentation/devicetree/bindings/usb/brcm,bdc.txt |    4 +-
 .../bindings/usb/ingenic,jz4770-phy.yaml           |    6 +-
 .../devicetree/bindings/usb/ti,keystone-dwc3.yaml  |   51 +-
 Documentation/driver-api/usb/URB.rst               |    2 +-
 Documentation/usb/gadget_hid.rst                   |    2 +-
 Documentation/usb/gadget_multi.rst                 |   10 +-
 Documentation/usb/linux.inf                        |    2 +-
 MAINTAINERS                                        |    7 +
 arch/arm/mach-omap1/board-osk.c                    |   17 +
 arch/mips/configs/fuloong2e_defconfig              |    2 +-
 arch/mips/configs/gcw0_defconfig                   |    2 +-
 arch/mips/configs/lemote2f_defconfig               |    2 +-
 drivers/net/thunderbolt.c                          |    4 +-
 drivers/thunderbolt/Kconfig                        |    9 +-
 drivers/thunderbolt/Makefile                       |    3 +
 drivers/thunderbolt/domain.c                       |    2 +-
 drivers/thunderbolt/eeprom.c                       |    1 +
 drivers/thunderbolt/lc.c                           |   14 +
 drivers/thunderbolt/nhi.c                          |   30 +-
 drivers/thunderbolt/nvm.c                          |  170 ++
 drivers/thunderbolt/path.c                         |   38 +-
 drivers/thunderbolt/quirks.c                       |   42 +
 drivers/thunderbolt/retimer.c                      |  485 ++++++
 drivers/thunderbolt/sb_regs.h                      |   33 +
 drivers/thunderbolt/switch.c                       |  232 ++-
 drivers/thunderbolt/tb.c                           |  388 ++++-
 drivers/thunderbolt/tb.h                           |  131 +-
 drivers/thunderbolt/tb_regs.h                      |   31 +
 drivers/thunderbolt/test.c                         | 1626 ++++++++++++++++++++
 drivers/thunderbolt/tunnel.c                       |  314 +++-
 drivers/thunderbolt/tunnel.h                       |   37 +-
 drivers/thunderbolt/usb4.c                         |  874 ++++++++++-
 drivers/thunderbolt/xdomain.c                      |   94 +-
 drivers/usb/atm/cxacru.c                           |    4 +-
 drivers/usb/atm/ueagle-atm.c                       |    4 +-
 drivers/usb/c67x00/c67x00-hcd.c                    |    6 +-
 drivers/usb/c67x00/c67x00-ll-hpi.c                 |    6 +-
 drivers/usb/c67x00/c67x00-sched.c                  |   26 +-
 drivers/usb/cdns3/cdns3-ti.c                       |    2 +-
 drivers/usb/cdns3/core.c                           |   50 +-
 drivers/usb/cdns3/drd.c                            |  165 +-
 drivers/usb/cdns3/drd.h                            |   13 +-
 drivers/usb/cdns3/ep0.c                            |   40 +-
 drivers/usb/cdns3/gadget.c                         |   33 +-
 drivers/usb/cdns3/host.c                           |    4 +-
 drivers/usb/chipidea/ci_hdrc_imx.c                 |    4 +
 drivers/usb/chipidea/ci_hdrc_imx.h                 |    1 +
 drivers/usb/chipidea/ci_hdrc_pci.c                 |    2 +-
 drivers/usb/chipidea/core.c                        |   28 +
 drivers/usb/chipidea/debug.c                       |   10 +-
 drivers/usb/chipidea/otg.c                         |    6 +-
 drivers/usb/chipidea/udc.c                         |   67 +-
 drivers/usb/chipidea/usbmisc_imx.c                 |    6 +-
 drivers/usb/class/cdc-wdm.c                        |    3 +-
 drivers/usb/class/usbtmc.c                         |    4 +-
 drivers/usb/common/Kconfig                         |    1 +
 drivers/usb/common/debug.c                         |   16 +-
 drivers/usb/common/ulpi.c                          |    5 +-
 drivers/usb/common/usb-conn-gpio.c                 |   47 +-
 drivers/usb/core/Kconfig                           |    8 +-
 drivers/usb/core/config.c                          |   10 +-
 drivers/usb/core/devices.c                         |    4 +
 drivers/usb/core/devio.c                           |  126 +-
 drivers/usb/core/generic.c                         |    2 -
 drivers/usb/core/hcd-pci.c                         |   14 +-
 drivers/usb/core/hcd.c                             |    8 +-
 drivers/usb/core/hub.c                             |    8 +-
 drivers/usb/core/ledtrig-usbport.c                 |    6 +-
 drivers/usb/core/of.c                              |    2 +-
 .../core/{otg_whitelist.h => otg_productlist.h}    |   14 +-
 drivers/usb/core/quirks.c                          |   34 +-
 drivers/usb/core/urb.c                             |    4 +-
 drivers/usb/core/usb.c                             |    5 +-
 drivers/usb/core/usb.h                             |    2 +-
 drivers/usb/dwc2/core.h                            |    2 +-
 drivers/usb/dwc2/debugfs.c                         |   20 +-
 drivers/usb/dwc2/gadget.c                          |   16 +-
 drivers/usb/dwc2/hcd.c                             |    4 +-
 drivers/usb/dwc2/params.c                          |   12 +-
 drivers/usb/dwc2/platform.c                        |    4 +-
 drivers/usb/dwc3/core.c                            |    2 +-
 drivers/usb/dwc3/core.h                            |    2 +-
 drivers/usb/dwc3/debug.h                           |    2 +-
 drivers/usb/dwc3/debugfs.c                         |   22 +-
 drivers/usb/dwc3/drd.c                             |    4 +-
 drivers/usb/dwc3/dwc3-haps.c                       |    2 +-
 drivers/usb/dwc3/dwc3-keystone.c                   |    2 +-
 drivers/usb/dwc3/dwc3-meson-g12a.c                 |   15 +-
 drivers/usb/dwc3/dwc3-of-simple.c                  |    4 +-
 drivers/usb/dwc3/dwc3-omap.c                       |    9 +-
 drivers/usb/dwc3/dwc3-pci.c                        |    2 +-
 drivers/usb/dwc3/dwc3-qcom.c                       |   22 +-
 drivers/usb/dwc3/dwc3-st.c                         |    4 +-
 drivers/usb/dwc3/ep0.c                             |   12 +-
 drivers/usb/dwc3/gadget.c                          |   42 +-
 drivers/usb/dwc3/gadget.h                          |    4 +-
 drivers/usb/dwc3/host.c                            |    2 +-
 drivers/usb/dwc3/io.h                              |    2 +-
 drivers/usb/dwc3/trace.c                           |    2 +-
 drivers/usb/dwc3/trace.h                           |    2 +-
 drivers/usb/dwc3/ulpi.c                            |    2 +-
 drivers/usb/early/ehci-dbgp.c                      |    6 +-
 drivers/usb/early/xhci-dbc.c                       |    3 +-
 drivers/usb/gadget/Kconfig                         |    4 +-
 drivers/usb/gadget/composite.c                     |   20 +-
 drivers/usb/gadget/configfs.c                      |    2 +-
 drivers/usb/gadget/function/f_fs.c                 |    4 +-
 drivers/usb/gadget/function/f_hid.c                |    2 +-
 drivers/usb/gadget/function/f_mass_storage.c       |    2 +-
 drivers/usb/gadget/function/f_phonet.c             |    4 +-
 drivers/usb/gadget/function/f_printer.c            |   42 +-
 drivers/usb/gadget/function/f_rndis.c              |    2 +-
 drivers/usb/gadget/function/f_tcm.c                |    2 +-
 drivers/usb/gadget/function/f_uac2.c               |    7 +-
 drivers/usb/gadget/function/u_ether.c              |    8 +-
 drivers/usb/gadget/function/u_serial.c             |    8 +-
 drivers/usb/gadget/function/u_serial.h             |    2 +-
 drivers/usb/gadget/function/u_uac1_legacy.c        |   14 +-
 drivers/usb/gadget/legacy/inode.c                  |    7 +-
 drivers/usb/gadget/legacy/nokia.c                  |    1 -
 drivers/usb/gadget/legacy/printer.c                |    1 -
 drivers/usb/gadget/legacy/zero.c                   |    4 +-
 drivers/usb/gadget/udc/Kconfig                     |    2 +-
 drivers/usb/gadget/udc/amd5536udc.h                |    2 +-
 drivers/usb/gadget/udc/amd5536udc_pci.c            |    3 +-
 drivers/usb/gadget/udc/atmel_usba_udc.c            |   23 +-
 drivers/usb/gadget/udc/bcm63xx_udc.c               |   16 +-
 drivers/usb/gadget/udc/bdc/bdc.h                   |    2 +-
 drivers/usb/gadget/udc/bdc/bdc_core.c              |   53 +-
 drivers/usb/gadget/udc/bdc/bdc_ep.c                |   26 +-
 drivers/usb/gadget/udc/core.c                      |   21 +-
 drivers/usb/gadget/udc/dummy_hcd.c                 |   34 +-
 drivers/usb/gadget/udc/goku_udc.c                  |    9 +-
 drivers/usb/gadget/udc/gr_udc.c                    |    6 +-
 drivers/usb/gadget/udc/gr_udc.h                    |    2 +-
 drivers/usb/gadget/udc/lpc32xx_udc.c               |    6 +-
 drivers/usb/gadget/udc/max3420_udc.c               |    5 +-
 drivers/usb/gadget/udc/mv_u3d_core.c               |    1 -
 drivers/usb/gadget/udc/mv_udc_core.c               |    3 +-
 drivers/usb/gadget/udc/net2272.c                   |    4 +-
 drivers/usb/gadget/udc/net2272.h                   |    5 -
 drivers/usb/gadget/udc/net2280.c                   |    4 +-
 drivers/usb/gadget/udc/omap_udc.c                  |    4 +-
 drivers/usb/gadget/udc/pch_udc.c                   |   36 +-
 drivers/usb/gadget/udc/pxa27x_udc.c                |   15 +-
 drivers/usb/gadget/udc/r8a66597-udc.c              |    6 +-
 drivers/usb/gadget/udc/s3c2410_udc.c               |    4 +-
 drivers/usb/gadget/udc/snps_udc_core.c             |    2 +-
 drivers/usb/gadget/udc/tegra-xudc.c                |    9 +-
 drivers/usb/gadget/udc/udc-xilinx.c                |    4 +-
 drivers/usb/gadget/usbstring.c                     |    4 +-
 drivers/usb/host/Kconfig                           |    4 +-
 drivers/usb/host/bcma-hcd.c                        |    4 +-
 drivers/usb/host/ehci-dbg.c                        |    2 +-
 drivers/usb/host/ehci-fsl.c                        |    6 +-
 drivers/usb/host/ehci-hcd.c                        |    4 +-
 drivers/usb/host/ehci-omap.c                       |    2 +-
 drivers/usb/host/ehci-pci.c                        |    3 +-
 drivers/usb/host/ehci-platform.c                   |    2 +
 drivers/usb/host/ehci-q.c                          |    2 +-
 drivers/usb/host/ehci-sched.c                      |    2 +-
 drivers/usb/host/fhci-sched.c                      |   19 +-
 drivers/usb/host/fhci-tds.c                        |   11 +-
 drivers/usb/host/fotg210-hcd.c                     |   15 +-
 drivers/usb/host/imx21-hcd.c                       |    2 +-
 drivers/usb/host/isp1362-hcd.c                     |    2 +-
 drivers/usb/host/isp1362.h                         |    2 +-
 drivers/usb/host/max3421-hcd.c                     |   12 +-
 drivers/usb/host/ohci-at91.c                       |    5 +-
 drivers/usb/host/ohci-hcd.c                        |    6 +-
 drivers/usb/host/ohci-hub.c                        |    2 +-
 drivers/usb/host/ohci-omap.c                       |  144 +-
 drivers/usb/host/ohci-pci.c                        |    4 -
 drivers/usb/host/ohci-q.c                          |    6 +-
 drivers/usb/host/ohci-s3c2410.c                    |    2 +-
 drivers/usb/host/ohci-tmio.c                       |    6 +-
 drivers/usb/host/ohci.h                            |    2 +-
 drivers/usb/host/oxu210hp-hcd.c                    |   15 +-
 drivers/usb/host/pci-quirks.c                      |    2 +-
 drivers/usb/host/r8a66597-hcd.c                    |    8 +-
 drivers/usb/host/xhci-dbgcap.c                     |  393 +++--
 drivers/usb/host/xhci-dbgcap.h                     |   69 +-
 drivers/usb/host/xhci-dbgtty.c                     |  221 ++-
 drivers/usb/host/xhci-debugfs.c                    |    1 +
 drivers/usb/host/xhci-hub.c                        |   48 +-
 drivers/usb/host/xhci-mem.c                        |   37 +-
 drivers/usb/host/xhci-pci.c                        |   10 +-
 drivers/usb/host/xhci-plat.c                       |    4 +-
 drivers/usb/host/xhci-tegra.c                      |    8 -
 drivers/usb/host/xhci.c                            |    2 +-
 drivers/usb/host/xhci.h                            |    2 +
 drivers/usb/image/mdc800.c                         |    2 +-
 drivers/usb/isp1760/isp1760-hcd.c                  |    4 +-
 drivers/usb/misc/Kconfig                           |    4 +-
 drivers/usb/misc/adutux.c                          |    6 +-
 drivers/usb/misc/appledisplay.c                    |    5 +-
 drivers/usb/misc/ehset.c                           |    8 +-
 drivers/usb/misc/iowarrior.c                       |   51 +-
 drivers/usb/misc/ldusb.c                           |   24 +-
 drivers/usb/misc/legousbtower.c                    |   26 +-
 drivers/usb/misc/sisusbvga/sisusb.c                |    8 +-
 drivers/usb/misc/sisusbvga/sisusb_con.c            |   12 +-
 drivers/usb/misc/sisusbvga/sisusb_init.c           |    1 +
 drivers/usb/misc/sisusbvga/sisusb_init.h           |  664 +-------
 drivers/usb/misc/sisusbvga/sisusb_tables.h         |  688 +++++++++
 drivers/usb/misc/usbtest.c                         |   18 +-
 drivers/usb/misc/yurex.c                           |    2 +-
 drivers/usb/mtu3/mtu3.h                            |    6 +-
 drivers/usb/mtu3/mtu3_core.c                       |  208 +--
 drivers/usb/mtu3/mtu3_debug.h                      |    2 +
 drivers/usb/mtu3/mtu3_gadget.c                     |   79 +-
 drivers/usb/mtu3/mtu3_gadget_ep0.c                 |   18 +-
 drivers/usb/mtu3/mtu3_hw_regs.h                    |    4 +-
 drivers/usb/mtu3/mtu3_plat.c                       |    4 +-
 drivers/usb/mtu3/mtu3_trace.c                      |    3 +-
 drivers/usb/musb/Kconfig                           |    2 +-
 drivers/usb/musb/musb_core.c                       |    4 +-
 drivers/usb/musb/musb_dsps.c                       |   12 +-
 drivers/usb/musb/musb_gadget_ep0.c                 |   20 +-
 drivers/usb/musb/musb_host.h                       |    1 -
 drivers/usb/musb/musb_virthub.c                    |   20 +-
 drivers/usb/phy/Kconfig                            |    4 +-
 drivers/usb/phy/phy-ab8500-usb.c                   |   12 +-
 drivers/usb/phy/phy-am335x-control.c               |    7 +-
 drivers/usb/phy/phy-fsl-usb.c                      |  166 +-
 drivers/usb/phy/phy-fsl-usb.h                      |   14 -
 drivers/usb/phy/phy-isp1301-omap.c                 |   14 +-
 drivers/usb/phy/phy-jz4770.c                       |  284 +++-
 drivers/usb/phy/phy-keystone.c                     |    2 +-
 drivers/usb/phy/phy-mv-usb.c                       |    2 +-
 drivers/usb/phy/phy-twl6030-usb.c                  |    2 +-
 drivers/usb/phy/phy.c                              |   49 +-
 drivers/usb/renesas_usbhs/mod_gadget.c             |    2 +-
 drivers/usb/renesas_usbhs/pipe.c                   |    2 +-
 drivers/usb/serial/aircable.c                      |    2 +-
 drivers/usb/serial/ch341.c                         |  127 +-
 drivers/usb/serial/console.c                       |    5 +-
 drivers/usb/serial/cp210x.c                        |  228 ++-
 drivers/usb/serial/cypress_m8.c                    |    4 +-
 drivers/usb/serial/f81232.c                        |    4 +-
 drivers/usb/serial/f81534.c                        |    2 +-
 drivers/usb/serial/ftdi_sio.c                      |   59 +-
 drivers/usb/serial/ftdi_sio.h                      |    4 +-
 drivers/usb/serial/garmin_gps.c                    |   13 +-
 drivers/usb/serial/generic.c                       |   22 +-
 drivers/usb/serial/io_edgeport.c                   |    4 +-
 drivers/usb/serial/iuu_phoenix.c                   |   26 +-
 drivers/usb/serial/keyspan_pda.c                   |    3 +-
 drivers/usb/serial/kobil_sct.c                     |    6 +-
 drivers/usb/serial/mxuport.c                       |    6 +-
 drivers/usb/serial/option.c                        |    3 +-
 drivers/usb/serial/pl2303.c                        |    2 +-
 drivers/usb/serial/qcserial.c                      |    6 +-
 drivers/usb/serial/quatech2.c                      |   18 +-
 drivers/usb/serial/sierra.c                        |   88 +-
 drivers/usb/serial/ssu100.c                        |    7 +-
 drivers/usb/serial/upd78f0730.c                    |    2 +-
 drivers/usb/storage/Kconfig                        |    2 +-
 drivers/usb/storage/alauda.c                       |    3 +-
 drivers/usb/storage/freecom.c                      |    2 +-
 drivers/usb/storage/scsiglue.c                     |    2 +-
 drivers/usb/storage/uas-detect.h                   |    2 +-
 drivers/usb/storage/unusual_devs.h                 |    2 +-
 drivers/usb/typec/altmodes/displayport.c           |    3 +-
 drivers/usb/typec/class.c                          |    2 +-
 drivers/usb/typec/mux/intel_pmc_mux.c              |   74 +-
 drivers/usb/typec/tcpm/fusb302.c                   |    1 +
 drivers/usb/typec/tcpm/tcpci.c                     |    9 +
 drivers/usb/typec/tcpm/tcpci.h                     |    1 +
 drivers/usb/typec/tcpm/tcpm.c                      |  212 ++-
 drivers/usb/typec/tps6598x.c                       |    2 +-
 drivers/usb/typec/ucsi/Kconfig                     |    2 +-
 drivers/usb/typec/ucsi/ucsi.c                      |    3 +-
 drivers/usb/usbip/stub_rx.c                        |    2 +-
 drivers/usb/usbip/vhci_hcd.c                       |    7 +-
 drivers/usb/usbip/vhci_rx.c                        |    2 +-
 drivers/usb/usbip/vudc_transfer.c                  |    4 +-
 include/linux/thunderbolt.h                        |    2 -
 include/linux/usb.h                                |   14 +-
 include/linux/usb/ch9.h                            |    8 +-
 include/linux/usb/chipidea.h                       |    2 +
 include/linux/usb/gadget.h                         |    9 +-
 include/linux/usb/pd.h                             |    1 +
 include/linux/usb/pd_vdo.h                         |    2 +-
 include/linux/usb/phy_companion.h                  |    2 +-
 include/linux/usb/quirks.h                         |    4 +-
 include/linux/usb/serial.h                         |   97 +-
 include/linux/usb/tcpm.h                           |    2 +
 include/linux/usb/typec.h                          |   14 +
 include/linux/usb/typec_altmode.h                  |   14 +-
 include/uapi/linux/usb/ch9.h                       |   17 +-
 tools/usb/usbip/doc/usbip.8                        |    4 +-
 tools/usb/usbip/doc/usbipd.8                       |    2 +-
 tools/usb/usbip/libsrc/usbip_host_common.c         |    2 +-
 tools/usb/usbip/vudc/vudc_server_example.sh        |    2 +-
 297 files changed, 7849 insertions(+), 3091 deletions(-)
 create mode 100644 drivers/thunderbolt/nvm.c
 create mode 100644 drivers/thunderbolt/quirks.c
 create mode 100644 drivers/thunderbolt/retimer.c
 create mode 100644 drivers/thunderbolt/sb_regs.h
 create mode 100644 drivers/thunderbolt/test.c
 rename drivers/usb/core/{otg_whitelist.h => otg_productlist.h} (90%)
 create mode 100644 drivers/usb/misc/sisusbvga/sisusb_tables.h
