Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CEFC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 16:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB3DE206F6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 16:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389828AbgDBQ2R convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 12:28:17 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:26793 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728225AbgDBQ2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 12:28:17 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 093AA24000C;
        Thu,  2 Apr 2020 16:28:12 +0000 (UTC)
Date:   Thu, 2 Apr 2020 18:28:11 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] mtd: Changes for 5.7
Message-ID: <20200402182811.457e9220@xps13>
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

This is the MTD PR for 5.7.

Thanks,
Miquèl

The following changes since commit 98d54f81e36ba3bf92172791eba5ca5bd813989b:

  Linux 5.6-rc4 (2020-03-01 16:38:46 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-5.7

for you to fetch changes up to 025a06c1104cd8995646b761d117816b5f28c873:

  mtd: Convert fallthrough comments into statements (2020-03-30 10:14:54 +0200)

----------------------------------------------------------------
MTD core changes:
* Fix issue where write_cached_data() fails but write() still returns success
* maps: sa1100-flash: Replace zero-length array with flexible-array member
* phram: Fix a double free issue in error path
* Convert fallthrough comments into statements
* MAINTAINERS: Add the IRC channel to the MTD related subsystems

Raw NAND core changes:
* Add support for manufacturer specific suspend/resume operation
* Add support for manufacturer specific lock/unlock operation
* Replace zero-length array with flexible-array member
* Fix a typo ("manufecturer")
* Ensure nand_soft_waitrdy wait period is enough

Raw NAND controller driver changes:
* Brcmnand:
  - Add support for flash-edu for dma transfers (+ bindings)
* Cadence:
  - Reinit completion before executing a new command
  - Change bad block marker size
  - Fix the calculation of the avaialble OOB size
  - Get meta data size from registers
* Qualcom:
  - Use dma_request_chan() instead dma_request_slave_channel()
  - Release resources on failure within qcom_nandc_alloc()
* Allwinner:
  - Use dma_request_chan() instead dma_request_slave_channel()
* Marvell:
  - Use dma_request_chan() instead dma_request_slave_channel()
  - Release DMA channel on error
* Freescale:
  - Use dma_request_chan() instead dma_request_slave_channel()
* Macronix:
  - Add support for Macronix NAND randomizer (+ bindings)
* Ams-delta:
  - Rename structures and functions to gpio_nand*
  - Make the driver custom I/O ready
  - Drop useless local variable
  - Support custom driver initialisation
  - Add module device tables
  - Handle more GPIO pins as optional
  - Make read pulses optional
  - Don't hardcode read/write pulse widths
  - Push inversion handling to gpiolib
  - Enable OF partition info support
  - Drop board specific partition info
  - Use struct gpio_nand_platdata
  - Write protect device during probe
* Ingenic:
  - Use devm_platform_ioremap_resource()
  - Add dependency on MIPS || COMPILE_TEST
* Denali:
  - Deassert write protect pin
* ST:
  - Use dma_request_chan() instead dma_request_slave_channel()

Raw NAND chip driver changes:
* Toshiba:
  - Support reading the number of bitflips for BENAND (Built-in ECC NAND)
* Macronix:
  - Add support for deep power down mode
  - Add support for block protection

SPI-NAND core changes:
* Do not erase the block before writing a bad block marker
* Explicitly use MTD_OPS_RAW to write the bad block marker to OOB
* Stop using spinand->oobbuf for buffering bad block markers
* Rework detect procedure for different READ_ID operation

SPI-NAND driver changes:
* Toshiba:
  - Support for new Kioxia Serial NAND
  - Rename function name to change suffix and prefix (8Gbit)
  - Add comment about Kioxia ID
* Micron:
  - Add new Micron SPI NAND devices with multiple dies
  - Add M70A series Micron SPI NAND devices
  - identify SPI NAND device with Continuous Read mode
  - Add new Micron SPI NAND devices
  - Describe the SPI NAND device MT29F2G01ABAGD
  - Generalize the OOB layout structure and function names

SPI NOR core changes:
* Move all the manufacturer specific quirks/code out of the core,
  to make the core logic more readable and thus ease maintenance.
* Move the SFDP logic out of the core, it provides a better
  separation between the SFDP parsing and core logic.
* Trim what is exposed in spi-nor.h. The SPI NOR controllers drivers
  must not be able to use structures that are meant just for the
  SPI NOR core.
* Use the spi-mem direct mapping API to let advanced controllers
  optimize the read/write operations when they support direct mapping.
* Add generic formula for the Status Register block protection
  handling. It fixes some long standing locking limitations and eases
  the addition of the 4bit block protection support.
* Add block protection support for flashes with 4 block protection
  bits in the Status Register.

SPI NOR controller drivers changes:
* The mtk-quadspi driver is replaced by the new spi-mem spi-mtk-nor
  driver.
* Merge tag 'mtk-mtd-spi-move' into spi-nor/next to avoid conflicts.

HyperBus changes:
* Print error msg when compatible is wrong or missing
* Move mapping of direct access window from core to individual drivers

----------------------------------------------------------------
Boris Brezillon (21):
      mtd: spi-nor: Stop prefixing generic functions with a manufacturer name
      mtd: spi-nor: Prepare core / manufacturer code split
      mtd: spi-nor: Expose stuctures and functions to manufacturer drivers
      mtd: spi-nor: Add the concept of SPI NOR manufacturer driver
      mtd: spi-nor: Move Atmel bits out of core.c
      mtd: spi-nor: Move Eon bits out of core.c
      mtd: spi-nor: Move ESMT bits out of core.c
      mtd: spi-nor: Move Everspin bits out of core.c
      mtd: spi-nor: Move Fujitsu bits out of core.c
      mtd: spi-nor: Move GigaDevice bits out of core.c
      mtd: spi-nor: Move Intel bits out of core.c
      mtd: spi-nor: Move ISSI bits out of core.c
      mtd: spi-nor: Move Macronix bits out of core.c
      mtd: spi-nor: Move Micron/ST bits out of core.c
      mtd: spi-nor: Move Spansion bits out of core.c
      mtd: spi-nor: Move SST bits out of core.c
      mtd: spi-nor: Move Winbond bits out of core.c
      mtd: spi-nor: Move Catalyst bits out of core.c
      mtd: spi-nor: Move Xilinx bits out of core.c
      mtd: spi-nor: Move XMC bits out of core.c
      mtd: spi-nor: Get rid of the now empty spi_nor_ids[] table

Christophe Kerello (1):
      mtd: rawnand: free the nand_device object

Chuanhong Guo (5):
      mtd: spinand: rework detect procedure for different READ_ID operation
      spi: make spi-max-frequency optional
      spi: add support for mediatek spi-nor controller
      dt-bindings: convert mtk-quadspi binding doc for spi-mtk-nor
      mtd: spi-nor: remove mtk-quadspi driver

Colin Ian King (1):
      mtd: fix spelling mistake "BlockMultiplerBits" -> "BlockMultiplierBits"

Dan Carpenter (1):
      mtd: lpddr: Fix a double free in probe()

Dirk Behme (1):
      mtd: hyperbus: Add proper error message for missing compatible

Frieder Schrempf (3):
      mtd: spinand: Stop using spinand->oobbuf for buffering bad block markers
      mtd: spinand: Explicitly use MTD_OPS_RAW to write the bad block marker to OOB
      mtd: spinand: Do not erase the block before writing a bad block marker

Gustavo A. R. Silva (3):
      mtd: rawnand: Replace zero-length array with flexible-array member
      mtd: spi-nor: controllers: aspeed-smc: Replace zero-length array with flexible-array member
      mtd: maps: sa1100-flash: Replace zero-length array with flexible-array member

Janusz Krzysztofik (14):
      mtd: rawnand: ams-delta: Write protect device during probe
      mtd: rawnand: ams-delta: Use struct gpio_nand_platdata
      ARM: OMAP1: ams-delta: Provide board specific partition info
      mtd: rawnand: ams-delta: Drop board specific partition info
      mtd: rawnand: ams-delta: Enable OF partition info support
      mtd: rawnand: ams-delta: Push inversion handling to gpiolib
      mtd: rawnand: ams-delta: Don't hardcode read/write pulse widths
      mtd: rawnand: ams-delta: Make read pulses optional
      mtd: rawnand: ams-delta: Handle more GPIO pins as optional
      mtd: rawnand: ams-delta: Add module device tables
      mtd: rawnand: ams-delta: Support custom driver initialisation
      mtd: rawnand: ams-delta: Drop useless local variable
      mtd: rawnand: ams-delta: Make the driver custom I/O ready
      mtd: rawnand: ams-delta: Rename structures and functions to gpio_nand*

Jonathan Neuschäfer (2):
      mtd: spi-nor: Refactor spi_nor_read_id()
      mtd: rawnand: Fix a typo ("manufecturer")

Jungseung Lee (4):
      mtd: spi-nor: introduce SR_BP_SHIFT define
      mtd: spi-nor: Add generic formula for SR block protection handling
      mtd: spi-nor: Add SR 4bit block protection support
      mtd: spi-nor: Enable locking for n25q512ax3/n25q512a

Kamal Dasu (3):
      dt: bindings: brcmnand: Add support for flash-edu
      arch: mips: brcm: Add 7425 flash-edu support
      mtd: rawnand: brcmnand: Add support for flash-edu for dma transfers

Lukas Bulwahn (1):
      MAINTAINERS: update entry after SPI NOR controller move

Martin Devera (1):
      mtd: rawnand: Ensure nand_soft_waitrdy wait period is enough

Masahiro Yamada (1):
      mtd: rawnand: denali: deassert write protect pin

Mason Yang (6):
      mtd: rawnand: Add support for Macronix NAND randomizer
      dt-bindings: mtd: Document Macronix NAND device bindings
      mtd: rawnand: Add support for manufacturer specific lock/unlock operation
      mtd: rawnand: Macronix: Add support for block protection
      mtd: rawnand: Add support for manufacturer specific suspend/resume operation
      mtd: rawnand: macronix: Add support for deep power down mode

Miquel Raynal (5):
      mtd: implement proper partition handling
      Merge tag 'cfi/for-5.7' into mtd/next
      Merge tag 'spi-nor/for-5.7' into mtd/next
      Merge tag 'nand/for-5.7' into mtd/next
      mtd: Convert fallthrough comments into statements

Paul Cercueil (2):
      mtd: rawnand: ingenic: Use devm_platform_ioremap_resource()
      mtd: rawnand: ingenic: Add dependency on MIPS || COMPILE_TEST

Peter Ujfalusi (7):
      mtd: rawnand: gpmi: Use dma_request_chan() instead dma_request_slave_channel()
      mtd: rawnand: marvell: Release DMA channel on error
      mtd: rawnand: marvell: Use dma_request_chan() instead dma_request_slave_channel()
      mtd: rawnand: sunxi: Use dma_request_chan() instead dma_request_slave_channel()
      mtd: rawnand: qcom: Release resources on failure within qcom_nandc_alloc()
      mtd: rawnand: qcom: Use dma_request_chan() instead dma_request_slave_channel()
      mtd: rawnand: stm32_fmc2: Use dma_request_chan() instead dma_request_slave_channel()

Piotr Sroka (4):
      mtd: rawnand: cadence: get meta data size from registers
      mtd: rawnand: cadence: fix the calculation of the avaialble OOB size
      mtd: rawnand: cadence: change bad block marker size
      mtd: rawnand: cadence: reinit completion before executing a new command

Sergei Shtylyov (4):
      mtd: spi-nor: use le32_to_cpu_array()
      mtd: spi-nor: split spi_nor_spimem_xfer_data()
      mtd: spi-nor: use spi-mem dirmap API
      mtd: hyperbus: move direct mapping setup to AM654 HBMC driver

Shivamurthy Shastri (6):
      mtd: spinand: micron: Generalize the OOB layout structure and function names
      mtd: spinand: micron: Describe the SPI NAND device MT29F2G01ABAGD
      mtd: spinand: micron: Add new Micron SPI NAND devices
      mtd: spinand: micron: identify SPI NAND device with Continuous Read mode
      mtd: spinand: micron: Add M70A series Micron SPI NAND devices
      mtd: spinand: micron: Add new Micron SPI NAND devices with multiple dies

Tudor Ambarus (8):
      Merge tag 'mtk-mtd-spi-move' into spi-nor/next
      mtd: spi-nor: Emphasise which is the generic set_4byte_addr_mode() method
      mtd: spi-nor: Move SFDP logic out of the core
      mtd: spi-nor: Drop the MFR definitions
      mtd: spi-nor: Trim what is exposed in spi-nor.h
      mtd: spi-nor: Clear WEL bit when erase or program errors occur
      mtd: spi-nor: Set all BP bits to one when lock_len == mtd->size
      MAINTAINERS: Add the IRC channel to the MTD related subsystems

Vignesh Raghavendra (1):
      MAINTAINERS: Add staging branch for HyperBus

Wen Yang (1):
      mtd: phram: fix a double free issue in error path

Xiaoming Ni (1):
      mtd: Fix issue where write_cached_data() fails but write() still returns success

Yoshio Furuyama (4):
      mtd: spinand: toshiba: Add comment about Kioxia ID
      mtd: spinand: toshiba: Rename function name to change suffix and prefix (8Gbit)
      mtd: spinand: toshiba: Support for new Kioxia Serial NAND
      mtd: rawnand: toshiba: Support reading the number of bitflips for BENAND (Built-in ECC NAND)

 Documentation/devicetree/bindings/mtd/brcm,brcmnand.txt                        |   10 +-
 Documentation/devicetree/bindings/mtd/nand-macronix.txt                        |   27 +
 Documentation/devicetree/bindings/{mtd/mtk-quadspi.txt => spi/spi-mtk-nor.txt} |   15 +-
 MAINTAINERS                                                                    |    8 +-
 arch/arm/mach-omap1/board-ams-delta.c                                          |   47 +-
 arch/mips/boot/dts/brcm/bcm7425.dtsi                                           |    4 +-
 drivers/mtd/chips/cfi_cmdset_0001.c                                            |    4 +-
 drivers/mtd/chips/cfi_cmdset_0002.c                                            |    5 +-
 drivers/mtd/chips/cfi_cmdset_0020.c                                            |   17 +-
 drivers/mtd/chips/cfi_util.c                                                   |   12 +-
 drivers/mtd/devices/block2mtd.c                                                |    4 +-
 drivers/mtd/devices/phram.c                                                    |   19 +-
 drivers/mtd/hyperbus/hbmc-am654.c                                              |   12 +
 drivers/mtd/hyperbus/hyperbus-core.c                                           |   15 +-
 drivers/mtd/inftlmount.c                                                       |    2 +-
 drivers/mtd/lpddr/lpddr_cmds.c                                                 |    4 +-
 drivers/mtd/maps/sa1100-flash.c                                                |    5 +-
 drivers/mtd/mtdblock.c                                                         |    5 +-
 drivers/mtd/mtdchar.c                                                          |   12 +-
 drivers/mtd/mtdcore.c                                                          |  250 +-
 drivers/mtd/mtdpart.c                                                          |  697 ++---
 drivers/mtd/nand/onenand/onenand_base.c                                        |    2 +-
 drivers/mtd/nand/raw/ams-delta.c                                               |  243 +-
 drivers/mtd/nand/raw/brcmnand/brcmnand.c                                       |  293 ++-
 drivers/mtd/nand/raw/cadence-nand-controller.c                                 |   34 +-
 drivers/mtd/nand/raw/denali.c                                                  |    1 +
 drivers/mtd/nand/raw/denali.h                                                  |    2 +-
 drivers/mtd/nand/raw/diskonchip.c                                              |    4 +-
 drivers/mtd/nand/raw/fsl_elbc_nand.c                                           |    3 +-
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c                                     |   21 +-
 drivers/mtd/nand/raw/ingenic/Kconfig                                           |    1 +
 drivers/mtd/nand/raw/ingenic/ingenic_ecc.c                                     |    4 +-
 drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c                                |    2 +-
 drivers/mtd/nand/raw/ingenic/jz4725b_bch.c                                     |    4 +-
 drivers/mtd/nand/raw/ingenic/jz4780_bch.c                                      |    4 +-
 drivers/mtd/nand/raw/internals.h                                               |    1 +
 drivers/mtd/nand/raw/marvell_nand.c                                            |   40 +-
 drivers/mtd/nand/raw/meson_nand.c                                              |    2 +-
 drivers/mtd/nand/raw/mtk_nand.c                                                |    2 +-
 drivers/mtd/nand/raw/nand_base.c                                               |   71 +-
 drivers/mtd/nand/raw/nand_hynix.c                                              |    2 +-
 drivers/mtd/nand/raw/nand_legacy.c                                             |    6 +-
 drivers/mtd/nand/raw/nand_macronix.c                                           |  227 ++
 drivers/mtd/nand/raw/nand_toshiba.c                                            |   58 +-
 drivers/mtd/nand/raw/nandsim.c                                                 |    4 +-
 drivers/mtd/nand/raw/omap_elm.c                                                |    8 +-
 drivers/mtd/nand/raw/qcom_nandc.c                                              |  105 +-
 drivers/mtd/nand/raw/stm32_fmc2_nand.c                                         |   44 +-
 drivers/mtd/nand/raw/sunxi_nand.c                                              |   17 +-
 drivers/mtd/nand/spi/core.c                                                    |  104 +-
 drivers/mtd/nand/spi/gigadevice.c                                              |   45 +-
 drivers/mtd/nand/spi/macronix.c                                                |   30 +-
 drivers/mtd/nand/spi/micron.c                                                  |  172 +-
 drivers/mtd/nand/spi/paragon.c                                                 |   28 +-
 drivers/mtd/nand/spi/toshiba.c                                                 |  208 +-
 drivers/mtd/nand/spi/winbond.c                                                 |   34 +-
 drivers/mtd/spi-nor/Kconfig                                                    |   83 +-
 drivers/mtd/spi-nor/Makefile                                                   |   26 +-
 drivers/mtd/spi-nor/atmel.c                                                    |   46 +
 drivers/mtd/spi-nor/catalyst.c                                                 |   29 +
 drivers/mtd/spi-nor/controllers/Kconfig                                        |   75 +
 drivers/mtd/spi-nor/controllers/Makefile                                       |    8 +
 drivers/mtd/spi-nor/{ => controllers}/aspeed-smc.c                             |    4 +-
 drivers/mtd/spi-nor/{ => controllers}/cadence-quadspi.c                        |    0
 drivers/mtd/spi-nor/{ => controllers}/hisi-sfc.c                               |    0
 drivers/mtd/spi-nor/{ => controllers}/intel-spi-pci.c                          |    0
 drivers/mtd/spi-nor/{ => controllers}/intel-spi-platform.c                     |    0
 drivers/mtd/spi-nor/{ => controllers}/intel-spi.c                              |    0
 drivers/mtd/spi-nor/{ => controllers}/intel-spi.h                              |    0
 drivers/mtd/spi-nor/{ => controllers}/nxp-spifi.c                              |    0
 drivers/mtd/spi-nor/core.c                                                     | 3466 +++++++++++++++++++++++++
 drivers/mtd/spi-nor/core.h                                                     |  441 ++++
 drivers/mtd/spi-nor/eon.c                                                      |   34 +
 drivers/mtd/spi-nor/esmt.c                                                     |   25 +
 drivers/mtd/spi-nor/everspin.c                                                 |   27 +
 drivers/mtd/spi-nor/fujitsu.c                                                  |   20 +
 drivers/mtd/spi-nor/gigadevice.c                                               |   59 +
 drivers/mtd/spi-nor/intel.c                                                    |   32 +
 drivers/mtd/spi-nor/issi.c                                                     |   83 +
 drivers/mtd/spi-nor/macronix.c                                                 |   98 +
 drivers/mtd/spi-nor/micron-st.c                                                |  157 ++
 drivers/mtd/spi-nor/mtk-quadspi.c                                              |  565 ----
 drivers/mtd/spi-nor/sfdp.c                                                     | 1204 +++++++++
 drivers/mtd/spi-nor/sfdp.h                                                     |   98 +
 drivers/mtd/spi-nor/spansion.c                                                 |   95 +
 drivers/mtd/spi-nor/spi-nor.c                                                  | 5434 ---------------------------------------
 drivers/mtd/spi-nor/sst.c                                                      |  151 ++
 drivers/mtd/spi-nor/winbond.c                                                  |  112 +
 drivers/mtd/spi-nor/xilinx.c                                                   |   94 +
 drivers/mtd/spi-nor/xmc.c                                                      |   23 +
 drivers/mtd/ubi/attach.c                                                       |    2 +-
 drivers/mtd/ubi/build.c                                                        |    4 +-
 drivers/spi/Kconfig                                                            |   10 +
 drivers/spi/Makefile                                                           |    1 +
 drivers/spi/spi-mtk-nor.c                                                      |  689 +++++
 drivers/spi/spi.c                                                              |    9 +-
 include/linux/mtd/mtd.h                                                        |  125 +-
 include/linux/mtd/partitions.h                                                 |    1 -
 include/linux/mtd/rawnand.h                                                    |   11 +-
 include/linux/mtd/spi-nor.h                                                    |  285 +-
 include/linux/mtd/spinand.h                                                    |   67 +-
 101 files changed, 9167 insertions(+), 7526 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/nand-macronix.txt
 rename Documentation/devicetree/bindings/{mtd/mtk-quadspi.txt => spi/spi-mtk-nor.txt} (75%)
 create mode 100644 drivers/mtd/spi-nor/atmel.c
 create mode 100644 drivers/mtd/spi-nor/catalyst.c
 create mode 100644 drivers/mtd/spi-nor/controllers/Kconfig
 create mode 100644 drivers/mtd/spi-nor/controllers/Makefile
 rename drivers/mtd/spi-nor/{ => controllers}/aspeed-smc.c (99%)
 rename drivers/mtd/spi-nor/{ => controllers}/cadence-quadspi.c (100%)
 rename drivers/mtd/spi-nor/{ => controllers}/hisi-sfc.c (100%)
 rename drivers/mtd/spi-nor/{ => controllers}/intel-spi-pci.c (100%)
 rename drivers/mtd/spi-nor/{ => controllers}/intel-spi-platform.c (100%)
 rename drivers/mtd/spi-nor/{ => controllers}/intel-spi.c (100%)
 rename drivers/mtd/spi-nor/{ => controllers}/intel-spi.h (100%)
 rename drivers/mtd/spi-nor/{ => controllers}/nxp-spifi.c (100%)
 create mode 100644 drivers/mtd/spi-nor/core.c
 create mode 100644 drivers/mtd/spi-nor/core.h
 create mode 100644 drivers/mtd/spi-nor/eon.c
 create mode 100644 drivers/mtd/spi-nor/esmt.c
 create mode 100644 drivers/mtd/spi-nor/everspin.c
 create mode 100644 drivers/mtd/spi-nor/fujitsu.c
 create mode 100644 drivers/mtd/spi-nor/gigadevice.c
 create mode 100644 drivers/mtd/spi-nor/intel.c
 create mode 100644 drivers/mtd/spi-nor/issi.c
 create mode 100644 drivers/mtd/spi-nor/macronix.c
 create mode 100644 drivers/mtd/spi-nor/micron-st.c
 delete mode 100644 drivers/mtd/spi-nor/mtk-quadspi.c
 create mode 100644 drivers/mtd/spi-nor/sfdp.c
 create mode 100644 drivers/mtd/spi-nor/sfdp.h
 create mode 100644 drivers/mtd/spi-nor/spansion.c
 delete mode 100644 drivers/mtd/spi-nor/spi-nor.c
 create mode 100644 drivers/mtd/spi-nor/sst.c
 create mode 100644 drivers/mtd/spi-nor/winbond.c
 create mode 100644 drivers/mtd/spi-nor/xilinx.c
 create mode 100644 drivers/mtd/spi-nor/xmc.c
 create mode 100644 drivers/spi/spi-mtk-nor.c
