Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC8DC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 22:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E31E206C0
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 22:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbgHHWfC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 18:35:02 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:41229 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgHHWfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 18:35:02 -0400
X-Originating-IP: 90.76.251.31
Received: from xps13 (lfbn-tou-1-1195-31.w90-76.abo.wanadoo.fr [90.76.251.31])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 4572740002;
        Sat,  8 Aug 2020 22:34:55 +0000 (UTC)
Date:   Sun, 9 Aug 2020 00:34:53 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] mtd: Changes for 5.9
Message-ID: <20200809003453.79673eb3@xps13>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

This is the MTD PR for 5.9.

Thanks,
Miquèl

The following changes since commit dcb7fd82c75ee2d6e6f9d8cc71c52519ed52e258:

  Linux 5.8-rc4 (2020-07-05 16:20:22 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-5.9

for you to fetch changes up to 6a1380271b75e0d9a961e192e56b733fedf7a23a:

  Merge tag 'nand/for-5.9' of git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux into mtd/next (2020-08-07 08:54:16 +0200)

----------------------------------------------------------------
MTD core changes:
* Spelling
* http to https updates

NAND core changes:
* Drop useless 'depends on' in Kconfig
* Add an extra level in the Kconfig hierarchy
* Trivial spellings
* Dynamic allocation of the interface configurations
* Dropping the default ONFI timing mode
* Various cleanup (types, structures, naming, comments)
* Hide the chip->data_interface indirection
* Add the generic rb-gpios property
* Add the ->choose_interface_config() hook
* Introduce nand_choose_best_sdr_timings()
* Use default values for tPROG_max and tBERS_max
* Avoid redefining tR_max and tCCS_min
* Add a helper to find the closest ONFI mode
* bcm63xx MTD parsers: simplify CFE detection

Raw NAND controller drivers changes:
* fsl-upm: Deprecation of specific DT properties
* fsl_upm: Driver rework and cleanup in favor of ->exec_op()
* Ingenic: Cleanup ARRAY_SIZE() vs sizeof() use
* brcmnand: ECC error handling on EDU transfers
* brcmnand: Don't default to EDU transfers
* qcom: Set BAM mode only if not set already
* qcom: Avoid write to unavailable register
* gpio: Driver rework in favor of ->exec_op()
* tango: ->exec_op() conversion
* mtk: ->exec_op() conversion

Raw NAND chip drivers changes:
* toshiba: Implement ->choose_interface_config() for TH58NVG2S3HBAI4
* toshiba: Implement ->choose_interface_config() for TC58NVG0S3E
* toshiba: Implement ->choose_interface_config() for TC58TEG5DCLTA00
* hynix: Implement ->choose_interface_config() for H27UCG8T2ATR-BC

SPI NOR core changes:
* Disable Quad Mode in spi_nor_restore().
* Don't abort BFPT parsing when QER reserved value is used.
* Add support/update capabilities for few flashes.
* Drop s70fl01gs flash: it does not support RDSR(05h) which
  is critical for erase/write.
* Merge the SPIMEM DTR bits in spi-nor/next to avoid conflicts
  during the release cycle.

SPI NOR controller drivers changes:
* Move the cadence-quadspi driver to spi-mem. The series was
  taken through the SPI tree. Merge it also in spi-nor/next
  to avoid conflicts during the release cycle.
* intel-spi:
   - Add new PCI IDs.
   - Ignore the Write Disable command, the controller doesn't
     support it.
   - Fix performance regression.

----------------------------------------------------------------
Alexander A. Klimov (3):
      mtd: hyperbus: Replace HTTP links with HTTPS ones
      mtd: Replace HTTP links with HTTPS ones
      mtd: rawnand: omap_elm: Replace HTTP links with HTTPS ones

Alexander Sverdlin (1):
      mtd: spi-nor: intel-spi: Simulate WRDI command

Boris Brezillon (16):
      mtd: rawnand: mtk: Convert the driver to exec_op()
      mtd: rawnand: tango: Convert the driver to exec_op()
      dt-bindings: mtd: nand: Document the generic rb-gpios property
      mtd: rawnand: fsl_upm: Remove unused mtd var
      mtd: rawnand: fsl_upm: Get rid of the unused fsl_upm_nand.parts field
      mtd: rawnand: fsl_upm: Allocate the fsl_upm_nand object using devm_kzalloc()
      mtd: rawnand: fsl_upm: Use devm_kasprintf() to allocate the MTD name
      mtd: rawnand: fsl_upm: Use platform_get_resource() + devm_ioremap_resource()
      mtd: rawnand: fsl_upm: Use gpio descriptors
      mtd: rawnand: fsl_upm: Inherit from nand_controller
      mtd: rawnand: fsl_upm: Implement exec_op()
      mtd: rawnand: fsl_upm: Get rid of the legacy interface implementation
      mtd: rawnand: gpio: Inherit from nand_controller
      mtd: rawnand: gpio: Implement exec_op()
      mtd: rawnand: gpio: Get rid of the legacy interface implementation
      dt-bindings: mtd: fsl-upm-nand: Deprecate chip-delay and fsl, upm-wait-flags

Christophe Kerello (6):
      mtd: rawnand: stm32_fmc2: do not display errors if the driver is deferred
      dt-bindings: mtd: update STM32 FMC2 NAND controller documentation
      dt-bindings: memory-controller: add STM32 FMC2 EBI controller documentation
      memory: stm32-fmc2-ebi: add STM32 FMC2 EBI controller driver
      mtd: rawnand: stm32_fmc2: use regmap APIs
      mtd: rawnand: stm32_fmc2: get resources from parent node

Dan Carpenter (1):
      mtd: rawnand: ingenic: cleanup ARRAY_SIZE() vs sizeof() use

David Clear (2):
      mtd: spi-nor: macronix: Add support for mx66u2g45g
      mtd: spi-nor: micron: Add SPI_NOR_DUAL_READ flag on mt25qu02g

Frieder Schrempf (1):
      mtd: spi-nor: macronix: Add support for MX25R1635F

Kamal Dasu (2):
      mtd: rawnand: brcmnand: Don't default to edu transfer
      mtd: rawnand: brcmnand: ECC error handling on EDU transfers

Kieran Bingham (1):
      mtd: rawnand: trivial spelling

Luis Alberto Herrera (1):
      mtd: revert "spi-nor: intel: provide a range for poll_timout"

Mika Westerberg (2):
      mtd: spi-nor: intel-spi: Add support for Intel Emmitsburg SPI serial flash
      mtd: spi-nor: intel-spi: Add support for Intel Tiger Lake-H SPI serial flash

Miquel Raynal (31):
      mtd: nand: Move nand_device forward declaration to the top
      mtd: nand: Add an extra level in the Kconfig hierarchy
      mtd: nand: Drop useless 'depends on' in Kconfig
      mtd: nand: Rename a core structure
      mtd: rawnand: Use unsigned types for nand_chip unsigned values
      mtd: rawnand: Only use u8 instead of uint8_t in nand_chip structure
      mtd: rawnand: Create a nand_chip operations structure
      mtd: rawnand: Rename the manufacturer structure
      mtd: rawnand: Declare the nand_manufacturer structure out of nand_chip
      mtd: rawnand: Reorganize the nand_chip structure
      mtd: rawnand: Compare the actual timing values
      mtd: rawnand: Use the data interface mode entry when relevant
      mtd: rawnand: Rename nand_has_setup_data_iface()
      mtd: rawnand: Fix nand_setup_data_interface() description
      mtd: rawnand: Rename nand_init_data_interface()
      mtd: rawnand: timings: Update onfi_fill_data_interface() kernel doc
      mtd: rawnand: timings: Provide onfi_fill_data_interface() with a data interface
      mtd: rawnand: timings: onfi_fill_data_interface timing mode is unsigned
      mtd: rawnand: timings: Add a helper to find the closest ONFI mode
      mtd: rawnand: timings: Avoid redefining tR_max and tCCS_min
      mtd: rawnand: timings: Use default values for tPROG_max and tBERS_max
      mtd: rawnand: Hide the chip->data_interface indirection
      mtd: rawnand: s/data_interface/interface_config/
      mtd: rawnand: timings: Make onfi_fill_interface_config() a void helper
      mtd: rawnand: Introduce nand_choose_best_sdr_timings()
      mtd: rawnand: Add the ->choose_interface_config() hook
      mtd: rawnand: toshiba: Implement ->choose_interface_config() for TC58TEG5DCLTA00
      mtd: rawnand: toshiba: Implement ->choose_interface_config() for TC58NVG0S3E
      mtd: rawnand: hynix: Implement ->choose_interface_config() for H27UCG8T2ATR-BC
      mtd: rawnand: Get rid of the default ONFI timing mode
      mtd: rawnand: Allocate the interface configurations dynamically

Pratyush Yadav (5):
      mtd: spi-nor: sfdp: do not make invalid quad enable fatal
      spi: spi-mem: allow specifying whether an op is DTR or not
      spi: spi-mem: allow specifying a command's extension
      spi: atmel-quadspi: reject DTR ops
      spi: spi-mtk-nor: reject DTR ops

Ramuthevar Vadivel Murugan (2):
      mtd: spi-nor: Convert cadence-quadspi to use spi-mem framework
      spi: Move cadence-quadspi driver to drivers/spi/

Randy Dunlap (2):
      MTD: mtd-abi.h: drop a duplicated word
      MTD: pfow.h: drop a duplicated word

Rayagonda Kokatanur (1):
      mtd: spi-nor: update read capabilities for w25q64 and s25fl064k

Richard Weinberger (2):
      Merge tag 'spi-nor/for-5.9' of https://git.kernel.org/.../mtd/linux into mtd/next
      Merge tag 'nand/for-5.9' of git://git.kernel.org/.../mtd/linux into mtd/next

Rickard x Andersson (1):
      mtd: rawnand: toshiba: Choose the interface configuration for TH58NVG2S3HBAI4

Sivaprakash Murugesan (2):
      mtd: rawnand: qcom: avoid write to unavailable register
      mtd: rawnand: qcom: set BAM mode only if not set already

Sven Van Asbroeck (1):
      mtd: spi-nor: winbond: Add support for w25q64jvm

Takahiro Kuwano (1):
      mtd: spi-nor: spansion: Remove s70fl01gs from flash_info

Tudor Ambarus (2):
      Merge tag 'cadence-mtd-spi-move' into spi-nor/next
      Merge tag 'spi-mem-dtr' into spi-nor/next

Vignesh Raghavendra (6):
      mtd: spi-nor: cadence-quadspi: Make driver independent of flash geometry
      mtd: spi-nor: cadence-quadspi: Provide a way to disable DAC mode
      mtd: spi-nor: cadence-quadspi: Don't initialize rx_dma_complete on failure
      mtd: spi-nor: cadence-quadspi: Fix error path on failure to acquire reset lines
      mtd: spi-nor: cadence-quadspi: Handle probe deferral while requesting DMA channel
      mtd: spi-nor: cadence-quadspi: Drop redundant WREN in erase path

Yicong Yang (2):
      mtd: spi-nor: Add capability to disable flash quad mode
      mtd: spi-nor: Disable the flash quad mode in spi_nor_restore()

Álvaro Fernández Rojas (1):
      mtd: parsers: bcm63xx: simplify CFE detection

 Documentation/devicetree/bindings/memory-controllers/st,stm32-fmc2-ebi.yaml      |  252 ++++++++++++++++++
 Documentation/devicetree/bindings/mtd/davinci-nand.txt                           |    4 +-
 Documentation/devicetree/bindings/mtd/fsl-upm-nand.txt                           |   10 +-
 Documentation/devicetree/bindings/mtd/nand-controller.yaml                       |    7 +
 Documentation/devicetree/bindings/mtd/st,stm32-fmc2-nand.yaml                    |   83 ++++--
 drivers/memory/Kconfig                                                           |   10 +
 drivers/memory/Makefile                                                          |    1 +
 drivers/memory/stm32-fmc2-ebi.c                                                  | 1206 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/mtd/chips/Kconfig                                                        |    2 +-
 drivers/mtd/hyperbus/hbmc-am654.c                                                |    2 +-
 drivers/mtd/hyperbus/hyperbus-core.c                                             |    2 +-
 drivers/mtd/maps/Kconfig                                                         |    2 +-
 drivers/mtd/maps/sc520cdp.c                                                      |    2 +-
 drivers/mtd/nand/Kconfig                                                         |    5 +
 drivers/mtd/nand/onenand/Kconfig                                                 |    1 -
 drivers/mtd/nand/raw/Kconfig                                                     |    2 +-
 drivers/mtd/nand/raw/ams-delta.c                                                 |    6 +-
 drivers/mtd/nand/raw/arasan-nand-controller.c                                    |    6 +-
 drivers/mtd/nand/raw/atmel/nand-controller.c                                     |   34 +--
 drivers/mtd/nand/raw/brcmnand/brcmnand.c                                         |   31 ++-
 drivers/mtd/nand/raw/cadence-nand-controller.c                                   |    6 +-
 drivers/mtd/nand/raw/denali.c                                                    |    8 +-
 drivers/mtd/nand/raw/fsl_upm.c                                                   |  311 ++++++++--------------
 drivers/mtd/nand/raw/fsmc_nand.c                                                 |    6 +-
 drivers/mtd/nand/raw/gpio.c                                                      |  112 ++++++--
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c                                       |    6 +-
 drivers/mtd/nand/raw/ingenic/jz4740_ecc.c                                        |    4 +-
 drivers/mtd/nand/raw/internals.h                                                 |   23 +-
 drivers/mtd/nand/raw/marvell_nand.c                                              |   18 +-
 drivers/mtd/nand/raw/meson_nand.c                                                |   14 +-
 drivers/mtd/nand/raw/mtk_nand.c                                                  |  122 +++++----
 drivers/mtd/nand/raw/mxc_nand.c                                                  |   22 +-
 drivers/mtd/nand/raw/mxic_nand.c                                                 |    6 +-
 drivers/mtd/nand/raw/nand_base.c                                                 |  279 +++++++++++---------
 drivers/mtd/nand/raw/nand_bbt.c                                                  |    2 +-
 drivers/mtd/nand/raw/nand_hynix.c                                                |   16 +-
 drivers/mtd/nand/raw/nand_ids.c                                                  |   24 +-
 drivers/mtd/nand/raw/nand_legacy.c                                               |    7 +-
 drivers/mtd/nand/raw/nand_macronix.c                                             |   10 +-
 drivers/mtd/nand/raw/nand_micron.c                                               |    2 +-
 drivers/mtd/nand/raw/nand_timings.c                                              |  116 ++++++---
 drivers/mtd/nand/raw/nand_toshiba.c                                              |   72 +++++-
 drivers/mtd/nand/raw/omap_elm.c                                                  |    2 +-
 drivers/mtd/nand/raw/qcom_nandc.c                                                |   18 +-
 drivers/mtd/nand/raw/s3c2410.c                                                   |    6 +-
 drivers/mtd/nand/raw/stm32_fmc2_nand.c                                           |  319 ++++++++++++-----------
 drivers/mtd/nand/raw/sunxi_nand.c                                                |    6 +-
 drivers/mtd/nand/raw/tango_nand.c                                                |  149 ++++++-----
 drivers/mtd/nand/raw/tegra_nand.c                                                |    6 +-
 drivers/mtd/parsers/bcm63xxpart.c                                                |   32 +--
 drivers/mtd/spi-nor/controllers/Kconfig                                          |   11 -
 drivers/mtd/spi-nor/controllers/Makefile                                         |    1 -
 drivers/mtd/spi-nor/controllers/intel-spi-pci.c                                  |    2 +
 drivers/mtd/spi-nor/controllers/intel-spi.c                                      |   13 +-
 drivers/mtd/spi-nor/core.c                                                       |   57 +++--
 drivers/mtd/spi-nor/core.h                                                       |   10 +-
 drivers/mtd/spi-nor/macronix.c                                                   |    6 +
 drivers/mtd/spi-nor/micron-st.c                                                  |    4 +-
 drivers/mtd/spi-nor/sfdp.c                                                       |    3 +-
 drivers/mtd/spi-nor/spansion.c                                                   |    4 +-
 drivers/mtd/spi-nor/winbond.c                                                    |    4 +-
 drivers/spi/Kconfig                                                              |   11 +
 drivers/spi/Makefile                                                             |    1 +
 drivers/spi/atmel-quadspi.c                                                      |    6 +
 drivers/{mtd/spi-nor/controllers/cadence-quadspi.c => spi/spi-cadence-quadspi.c} |  541 +++++++++++++++------------------------
 drivers/spi/spi-mem.c                                                            |   16 +-
 drivers/spi/spi-mtk-nor.c                                                        |   10 +-
 drivers/spi/spi-mxic.c                                                           |    3 +-
 drivers/spi/spi-zynq-qspi.c                                                      |   11 +-
 include/linux/mtd/hyperbus.h                                                     |    2 +-
 include/linux/mtd/nand.h                                                         |   12 +-
 include/linux/mtd/pfow.h                                                         |    2 +-
 include/linux/mtd/rawnand.h                                                      |  267 +++++++++----------
 include/linux/mtd/spinand.h                                                      |    2 +-
 include/linux/spi/spi-mem.h                                                      |   14 +-
 include/uapi/mtd/mtd-abi.h                                                       |    2 +-
 76 files changed, 3069 insertions(+), 1338 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/st,stm32-fmc2-ebi.yaml
 create mode 100644 drivers/memory/stm32-fmc2-ebi.c
 rename drivers/{mtd/spi-nor/controllers/cadence-quadspi.c => spi/spi-cadence-quadspi.c} (74%)
