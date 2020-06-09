Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC483C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 20:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 941232076A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 20:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbgFIUiq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 16:38:46 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:43874 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbgFIUio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 16:38:44 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 76EDB6074010;
        Tue,  9 Jun 2020 22:38:37 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id dlN20zN6EkqL; Tue,  9 Jun 2020 22:38:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 36597607400D;
        Tue,  9 Jun 2020 22:38:36 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Ktn8la4I_6Jo; Tue,  9 Jun 2020 22:38:36 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id D38D06074010;
        Tue,  9 Jun 2020 22:38:35 +0200 (CEST)
Date:   Tue, 9 Jun 2020 22:38:35 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds <torvalds@linux-foundation.org>
Cc:     miquel.raynal@bootlin.com, vigneshr@ti.com,
        Tudor.Ambarus@microchip.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>
Message-ID: <996261112.163.1591735115611.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] mtd: Changes for 5.8
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF68 (Linux)/8.8.12_GA_3809)
Thread-Index: 26s2d4iZ1u6PZBbIlzX1y5JP52HbHA==
Thread-Topic: Changes for 5.8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 3d77e6a8804abcc0504c904bd6e5cdf3a5cf8162:

  Linux 5.7 (2020-05-31 16:49:15 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-5.8

for you to fetch changes up to 5788ccf3c84f5587418a80128a3653aa35abf00b:

  mtd: clear cache_state to avoid writing to bad blocks repeatedly (2020-06-05 10:16:14 +0200)

----------------------------------------------------------------
MTD core changes:

* partition parser: Support MTD names containing one or more colons.
* mtdblock: clear cache_state to avoid writing to bad blocks repeatedly.

Raw NAND core changes:

* Stop using nand_release(), patched all drivers.
* Give more information about the ECC weakness when not matching the
  chip's requirement.
* MAINTAINERS updates.
* Support emulated SLC mode on MLC NANDs.
* Support "constrained" controllers, adapt the core and ONFI/JEDEC
  table parsing and Micron's code.
* Take check_only into account.
* Add an invalid ECC mode to discriminate with valid ones.
* Return an enum from of_get_nand_ecc_algo().
* Drop OOB_FIRST placement scheme.
* Introduce nand_extract_bits().
* Ensure a consistent bitflips numbering.
* BCH lib:
  - Allow easy bit swapping.
  - Rework a little bit the exported function names.
* Fix nand_gpio_waitrdy().
* Propage CS selection to sub operations.
* Add a NAND_NO_BBM_QUIRK flag.
* Give the possibility to verify a read operation is supported.
* Add a helper to check supported operations.
* Avoid indirect access to ->data_buf().
* Rename the use_bufpoi variables.
* Fix comments about the use of bufpoi.
* Rename a NAND chip option.
* Reorder the nand_chip->options flags.
* Translate obscure bitfields into readable macros.
* Timings:
  - Fix default values.
  - Add mode information to the timings structure.

Raw NAND controller driver changes:

* Fixed many error paths.
* Arasan
  - New driver
* Au1550nd:
  - Various cleanups
  - Migration to ->exec_op()
* brcmnand:
  - Misc cleanup.
  - Support v2.1-v2.2 controllers.
  - Remove unused including <linux/version.h>.
  - Correctly verify erased pages.
  - Fix Hamming OOB layout.
* Cadence
  - Make cadence_nand_attach_chip static.
* Cafe:
  - Set the NAND_NO_BBM_QUIRK flag
* cmx270:
  - Remove this controller driver.
* cs553x:
  - Misc cleanup
  - Migration to ->exec_op()
* Davinci:
  - Misc cleanup.
  - Migration to ->exec_op()
* Denali:
  - Add more delays before latching incoming data
* Diskonchip:
   - Misc cleanup
   - Migration to ->exec_op()
* Fsmc:
  - Change to non-atomic bit operations.
* GPMI:
  - Use nand_extract_bits()
  - Fix runtime PM imbalance.
* Ingenic:
  - Migration to exec_op()
  - Fix the RB gpio active-high property on qi, lb60
  - Make qi_lb60_ooblayout_ops static.
* Marvell:
   - Misc cleanup and small fixes
* Nandsim:
  - Fix the error paths, driver wide.
* Omap_elm:
  - Fix runtime PM imbalance.
* STM32_FMC2:
  - Misc cleanups (error cases, comments, timeout valus, cosmetic
    changes).

SPI NOR core changes:

* Add, update support and fix few flashes.
* Prepare BFPT parsing for JESD216 rev D.
* Kernel doc fixes.

CFI changes:

* Support the absence of protection registers for Intel CFI flashes.
* Replace zero-length array with flexible-arrays.

----------------------------------------------------------------
Boris Brezillon (35):
      mtd: rawnand: Take check_only into account
      mtd: rawnand: au1550nd: Stop using IO_ADDR_{R, W} in au_{read, write}_buf[16]()
      mtd: rawnand: au1550nd: Implement exec_op()
      mtd: rawnand: au1550nd: Get rid of the legacy interface implementation
      mtd: rawnand: au1550nd: Patch the read/write buf helper prototypes
      mtd: rawnand: cs553x: Declare controllers instead of NAND chips
      mtd: rawnand: cs553x: Stop using chip->legacy.IO_ADDR_{R, W}
      mtd: rawnand: cs553x: Implement exec_op()
      mtd: rawnand: cs553x: Get rid of the legacy interface implementation
      mtd: rawnand: toshiba: Add a specific init for TC58TEG5DCLTA00
      mtd: rawnand: Define the "distance 3" MLC pairing scheme
      mtd: rawnand: toshiba: Set the pairing scheme for TC58TEG5DCLTA00
      mtd: Add support for emulated SLC mode on MLC NANDs
      dt-bindings: mtd: partition: Document the slc-mode property
      mtd: partitions: ofpart: Parse the slc-mode property
      mtd: cmdlinepart: Add an slc option to use SLC mode on a part
      ubi: Relax the 'no MLC' rule and allow MLCs operating in SLC mode
      mtd: rawnand: Add a NAND_NO_BBM_QUIRK flag
      mtd: rawnand: cafe: Set the NAND_NO_BBM_QUIRK flag
      mtd: rawnand: diskonchip: Set the NAND_NO_BBM_QUIRK flag
      mtd: rawnand: diskonchip: Make sure doc2001plus_readbuf() works for single byte reads
      mtd: rawnand: diskonchip: Get rid of doc2000_readbuf_dword()
      mtd: rawnand: diskonchip: Inherit from nand_controller
      mtd: rawnand: diskonchip: Implement exec_op()
      mtd: rawnand: diskonchip: Get rid of the legacy interface implementation
      mtd: rawnand: Propage CS selection to sub operations
      mtd: rawnand: davinci: Inherit from nand_controller
      mtd: rawnand: davinci: Stop using nand_chip.legacy.IO_ADDR_{R, W}
      mtd: rawnand: davinci: Implement exec_op()
      mtd: rawnand: davinci: Get rid of the legacy interface implementation
      mtd: rawnand: Fix nand_gpio_waitrdy()
      mtd: rawnand: Remove the cmx270 NAND controller driver
      mtd: rawnand: ingenic: Fix the RB gpio active-high property on qi, lb60
      mtd: rawnand: ingenic: Convert the driver to exec_op()
      mtd: parser: cmdline: Support MTD names containing one or more colons

Christophe Kerello (5):
      mtd: rawnand: stm32_fmc2: manage all errors cases at probe time
      mtd: rawnand: stm32_fmc2: remove useless inline comments
      mtd: rawnand: stm32_fmc2: use FMC2_TIMEOUT_MS for timeouts
      mtd: rawnand: stm32_fmc2: cosmetic change to use nfc instead of fmc2 where relevant
      mtd: rawnand: stm32_fmc2: use FIELD_PREP/FIELD_GET macros

Dinghao Liu (3):
      mtd: rawnand: gpmi: Fix runtime PM imbalance on error
      mtd: rawnand: gpmi: Fix runtime PM imbalance in gpmi_nand_probe
      mtd: rawnand: omap_elm: Fix runtime PM imbalance on error

Fenghua Yu (1):
      mtd: rawnand: fsmc: Change to non-atomic bit operations

Gustavo A. R. Silva (1):
      mtd: Replace zero-length array with flexible-array

Jason Yan (1):
      mtd: physmap_of_gemini: remove defined but not used symbol 'syscon_match'

Jean-Philippe Brucker (1):
      mtd: cfi_cmdset_0001: Support the absence of protection registers

Jungseung Lee (1):
      mtd: spi-nor: micron-st: Enable locking for n25q00

Mantas Pucka (1):
      mtd: spi-nor: winbond: Fix 4-byte opcode support for w25q256

Masahiro Yamada (1):
      mtd: rawnand: denali: add more delays before latching incoming data

Mason Yang (2):
      mtd: spi-nor: macronix: Add support for mx25l51245g
      mtd: spi-nor: macronix: Add support for mx25u51245g

Miquel Raynal (124):
      mtd: rawnand: Give more information about the ECC weakness
      mtd: rawnand: marvell: Fix the condition on a return code
      mtd: rawnand: marvell: Use devm_platform_ioremap_res()
      mtd: rawnand: marvell: Use nand_cleanup() when the device is not yet registered
      mtd: rawnand: marvell: Fix probe error path
      mtd: rawnand: marvell: Rename a function to clarify
      mtd: rawnand: marvell: Rename the ->correct() function
      mtd: rawnand: timings: Add mode information to the timings structure
      mtd: rawnand: timings: Fix default tR_max and tCCS_min timings
      mtd: rawnand: onfi: Fix redundancy detection check
      mtd: rawnand: onfi: Use intermediate variables to improve readability
      mtd: rawnand: onfi: Define the number of parameter pages
      mtd: rawnand: onfi: Avoid doing a copy of the parameter page
      mtd: rawnand: onfi: Drop a useless parameter page read
      mtd: rawnand: jedec: Define the number of parameter pages
      mtd: rawnand: jedec: Use intermediate variables to improve readability
      mtd: rawnand: Translate obscure bitfields into readable macros
      mtd: rawnand: Reorder the nand_chip->options flags
      mtd: rawnand: Rename a NAND chip option
      mtd: rawnand: Fix comments about the use of bufpoi
      mtd: rawnand: Rename the use_bufpoi variables
      mtd: rawnand: Avoid indirect access to ->data_buf()
      mtd: rawnand: Add a helper to check supported operations
      mtd: rawnand: Give the possibility to verify a read operation is supported
      mtd: rawnand: onfi: Adapt the parameter page read to constraint controllers
      mtd: rawnand: jedec: Adapt the parameter page read to constraint controllers
      mtd: rawnand: Expose monolithic read/write_page_raw() helpers
      mtd: rawnand: Allow controllers to overload soft ECC hooks
      mtd: rawnand: micron: Allow controllers to overload raw accessors
      MAINTAINERS: Remove Piotr Sroka and mark Cadence NFC as orphaned
      MAINTAINERS: Remove Xiaolei Li and mark MTK NFC as orphaned
      mtd: rawnand: micron: Adapt the PAGE READ flow to constraint controllers
      lib/bch: Rework a little bit the exported function names
      lib/bch: Allow easy bit swapping
      mtd: rawnand: Ensure the number of bitflips is consistent
      mtd: rawnand: Add nand_extract_bits()
      MAINTAINERS: Add Arasan NAND controller and bindings
      dt-bindings: mtd: Document ARASAN NAND bindings
      mtd: rawnand: arasan: Add new Arasan NAND controller
      mtd: rawnand: arasan: Support the hardware BCH ECC engine
      mtd: rawnand: ams-delta: Stop using nand_release()
      mtd: rawnand: au1550nd: Stop using nand_release()
      mtd: rawnand: bcm47xx: Stop using nand_release()
      mtd: rawnand: brcmnand: Stop using nand_release()
      mtd: rawnand: cadence: Stop using nand_release()
      mtd: rawnand: cafe: Stop using nand_release()
      mtd: rawnand: cs553x: Stop using nand_release()
      mtd: rawnand: davinci: Stop using nand_release()
      mtd: rawnand: denali: Delete items from the list in the _remove() path
      mtd: rawnand: denali: Stop using nand_release()
      mtd: rawnand: diskonchip: Fix the probe error path
      mtd: rawnand: diskonchip: Stop using nand_release()
      mtd: rawnand: fsl_elbc: Stop using nand_release()
      mtd: rawnand: fsl_ifc: Stop using nand_release()
      mtd: rawnand: fsl_upm: Stop using nand_release()
      mtd: rawnand: fsmc: Stop using nand_release()
      mtd: rawnand: gpio: Stop using nand_release()
      mtd: rawnand: gpmi: Stop using nand_release()
      mtd: rawnand: hisi504: Stop using nand_release()
      mtd: rawnand: ingenic: Fix the probe error path
      mtd: rawnand: ingenic: Stop using nand_release()
      mtd: rawnand: lpc32xx_mlc: Stop using nand_release()
      mtd: rawnand: lpc32xx_slc: Stop using nand_release()
      mtd: rawnand: marvell: Stop using nand_release()
      mtd: rawnand: mpc5121: Stop using nand_release()
      mtd: rawnand: mtk: Fix the probe error path
      mtd: rawnand: mtk: Stop using nand_release()
      mtd: rawnand: mxc: Stop using nand_release()
      mtd: rawnand: mxic: Stop using nand_release()
      mtd: rawnand: ndfc: Stop using nand_release()
      mtd: rawnand: omap2: Stop using nand_release()
      mtd: rawnand: orion: Fix the probe error path
      mtd: rawnand: orion: Stop using nand_release()
      mtd: rawnand: oxnas: Keep track of registered devices
      mtd: rawnand: oxnas: Fix the probe error path
      mtd: rawnand: oxnas: Unregister all devices on error
      mtd: rawnand: oxnas: Release all devices in the _remove() path
      mtd: rawnand: oxnas: Stop using nand_release()
      mtd: rawnand: pasemi: Fix the probe error path
      mtd: rawnand: pasemi: Stop using nand_release()
      mtd: rawnand: plat_nand: Fix the probe error path
      mtd: rawnand: plat_nand: Stop using nand_release()
      mtd: rawnand: qcom: Stop using nand_release()
      mtd: rawnand: r852: Stop using nand_release()
      mtd: rawnand: s3c2410: Stop using nand_release()
      mtd: rawnand: sh_flctl: Stop using nand_release()
      mtd: rawnand: sharpsl: Fix the probe error path
      mtd: rawnand: sharpsl: Stop using nand_release()
      mtd: rawnand: socrates: Fix the probe error path
      mtd: rawnand: socrates: Stop using nand_release()
      mtd: rawnand: stm32_fmc2: Stop using nand_release()
      mtd: rawnand: sunxi: Fix the probe error path
      mtd: rawnand: sunxi: Stop using nand_release()
      mtd: rawnand: tango: Stop using nand_release()
      mtd: rawnand: tmio: Fix the probe error path
      mtd: rawnand: tmio: Stop using nand_release()
      mtd: rawnand: txx9ndfmc: Stop using nand_release()
      mtd: rawnand: vf610: Stop using nand_release()
      mtd: rawnand: xway: Fix the probe error path
      mtd: rawnand: xway: Stop using nand_release()
      mtd: rawnand: gpmi: Use nand_extract_bits()
      mtd: rawnand: nandsim: Consistent use of 'ns' instead of 'dev'
      mtd: rawnand: nandsim: Use octal permissions
      mtd: rawnand: nandsim: Use a consistent ns_ prefix for all functions
      mtd: rawnand: nandsim: Clean error handling
      mtd: rawnand: nandsim: Keep track of the created debugfs entries
      mtd: rawnand: nandsim: Remove debugfs entries at unload time
      mtd: rawnand: nandsim: Fix the two ns_alloc_device() error paths
      mtd: rawnand: nandsim: Free partition names on error in ns_init()
      mtd: rawnand: nandsim: Free the allocated device on error in ns_init()
      mtd: rawnand: nandsim: Free the partition names in ns_free()
      mtd: rawnand: nandsim: Stop using nand_release()
      mtd: rawnand: nandsim: Use an additional label when freeing the nandsim object
      mtd: rawnand: nandsim: Free erase_block_wear on error
      mtd: rawnand: nandsim: Fix the label pointing on nand_cleanup()
      mtd: rawnand: nandsim: Manage lists on error in ns_init_module()
      mtd: rawnand: nandsim: Rename a label in ns_init_module()
      mtd: rawnand: nandsim: Reorganize ns_cleanup_module()
      mtd: rawnand: Stop using nand_release()
      mtd: Fix typo in mtd_ooblayout_set_databytes() description
      mtd: rawnand: Avoid a typedef
      mtd: rawnand: Drop OOB_FIRST placement scheme
      mtd: rawnand: Return an enum from of_get_nand_ecc_algo()
      mtd: rawnand: Add an invalid ECC mode to discriminate with valid ones

Pratyush Yadav (2):
      mtd: spi-nor: sfdp: default to addr_width of 3 for configurable widths
      mtd: spi-nor: sfdp: prepare BFPT parsing for JESD216 rev D

Richard Weinberger (3):
      Merge tag 'nand/for-5.8' of git://git.kernel.org/.../mtd/linux into mtd/next
      Merge tag 'spi-nor/for-5.8' of git://git.kernel.org/.../mtd/linux into mtd/next
      Merge tag 'cfi/for-5.8' of gitolite.kernel.org:pub/scm/linux/kernel/git/mtd/linux into mtd/next

Sascha Hauer (1):
      mtd: spi-nor: Add support for Cypress cy15x104q

Sergei Shtylyov (10):
      mtd: spi-nor: move #define SPINOR_OP_WRDI
      mtd: spi-nor: fix kernel-doc for 'struct spi_nor'
      mtd: spi-nor: fix kernel-doc for spi_nor::mtd
      mtd: spi-nor: fix kernel-doc for spi_nor::reg_proto
      mtd: spi-nor: fix kernel-doc for spi_nor::info
      mtd: spi-nor: fix kernel-doc for spi_nor::spimem
      mtd: spi-nor: core: fix kernel-doc typo for spi_nor_manufacturer_init_params()
      mtd: spi-nor: core: fix kernel-doc typo for spi_nor_[{info|sfdp}_]init_params()
      mtd: spi-nor: spansion: fix writes on S25FS512S
      mtd: spi-nor: sfdp: add/use local variable in spi_nor_parse_bfpt()

Takahiro Kuwano (1):
      mtd: spi-nor: spansion: Enable dual and quad read for s25fl256s0

Tudor Ambarus (4):
      mtd: spi-nor: Uniformize the return value in spi_nor_*_ready()
      mtd: spi-nor: Fix description of the sr_ready() return value
      mtd: spi-nor: spansion: Differentiate between s25fl256s and s25fs256s
      mtd: spi-nor: Fix SPI NOR acronym

Xiang Chen (1):
      mtd: spi-nor: Enable locking for n25q128a11

Xiaoming Ni (1):
      mtd: clear cache_state to avoid writing to bad blocks repeatedly

Yicong Yang (1):
      mtd: spi-nor: Add support for s25fs128s1

YueHaibing (3):
      mtd: rawnand: ingenic: Make qi_lb60_ooblayout_ops static
      mtd: rawnand: cadence: Make cadence_nand_attach_chip static
      mtd: rawnand: brcmnand: Remove unused including <linux/version.h>

Álvaro Fernández Rojas (8):
      mtd: rawnand: brcmnand: fix hamming oob layout
      mtd: rawnand: brcmnand: improve hamming oob layout
      mtd: rawnand: brcmnand: correctly verify erased pages
      mtd: rawnand: brcmnand: rename v4 registers
      mtd: rawnand: brcmnand: fix CS0 layout
      mtd: rawnand: brcmnand: rename page sizes
      dt-bindings: mtd: brcmnand: add v2.1 and v2.2 support
      mtd: rawnand: brcmnand: support v2.1-v2.2 controllers

 .../bindings/mtd/arasan,nand-controller.yaml       |   63 +
 .../devicetree/bindings/mtd/brcm,brcmnand.txt      |    2 +
 .../devicetree/bindings/mtd/partition.txt          |    3 +
 Documentation/driver-api/mtdnand.rst               |    6 +-
 MAINTAINERS                                        |   13 +-
 drivers/mtd/chips/cfi_cmdset_0001.c                |   13 +-
 drivers/mtd/devices/docg3.c                        |   10 +-
 drivers/mtd/maps/physmap-gemini.c                  |    5 -
 drivers/mtd/mtdblock.c                             |   11 +-
 drivers/mtd/mtdcore.c                              |  191 ++-
 drivers/mtd/mtdpart.c                              |   54 +-
 drivers/mtd/nand/raw/Kconfig                       |   12 +-
 drivers/mtd/nand/raw/Makefile                      |    2 +-
 drivers/mtd/nand/raw/ams-delta.c                   |    5 +-
 drivers/mtd/nand/raw/arasan-nand-controller.c      | 1297 ++++++++++++++++++++
 drivers/mtd/nand/raw/atmel/nand-controller.c       |    2 +-
 drivers/mtd/nand/raw/au1550nd.c                    |  403 ++----
 drivers/mtd/nand/raw/bcm47xxnflash/main.c          |    6 +-
 drivers/mtd/nand/raw/brcmnand/brcmnand.c           |  164 ++-
 drivers/mtd/nand/raw/cadence-nand-controller.c     |   17 +-
 drivers/mtd/nand/raw/cafe_nand.c                   |   16 +-
 drivers/mtd/nand/raw/cmx270_nand.c                 |  236 ----
 drivers/mtd/nand/raw/cs553x_nand.c                 |  199 ++-
 drivers/mtd/nand/raw/davinci_nand.c                |  312 +++--
 drivers/mtd/nand/raw/denali.c                      |   60 +-
 drivers/mtd/nand/raw/diskonchip.c                  |  487 +++-----
 drivers/mtd/nand/raw/fsl_elbc_nand.c               |    7 +-
 drivers/mtd/nand/raw/fsl_ifc_nand.c                |    7 +-
 drivers/mtd/nand/raw/fsl_upm.c                     |    9 +-
 drivers/mtd/nand/raw/fsmc_nand.c                   |   19 +-
 drivers/mtd/nand/raw/gpio.c                        |    6 +-
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c         |  189 +--
 drivers/mtd/nand/raw/hisi504_nand.c                |    6 +-
 drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c    |  170 ++-
 drivers/mtd/nand/raw/internals.h                   |   12 +
 drivers/mtd/nand/raw/lpc32xx_mlc.c                 |    7 +-
 drivers/mtd/nand/raw/lpc32xx_slc.c                 |    6 +-
 drivers/mtd/nand/raw/marvell_nand.c                |   68 +-
 drivers/mtd/nand/raw/meson_nand.c                  |    5 +-
 drivers/mtd/nand/raw/mpc5121_nfc.c                 |    5 +-
 drivers/mtd/nand/raw/mtk_nand.c                    |   19 +-
 drivers/mtd/nand/raw/mxc_nand.c                    |    6 +-
 drivers/mtd/nand/raw/mxic_nand.c                   |   10 +-
 drivers/mtd/nand/raw/nand_base.c                   |  445 ++++---
 drivers/mtd/nand/raw/nand_bch.c                    |   10 +-
 drivers/mtd/nand/raw/nand_jedec.c                  |   32 +-
 drivers/mtd/nand/raw/nand_legacy.c                 |    8 +-
 drivers/mtd/nand/raw/nand_micron.c                 |   65 +-
 drivers/mtd/nand/raw/nand_onfi.c                   |   71 +-
 drivers/mtd/nand/raw/nand_timings.c                |   11 +-
 drivers/mtd/nand/raw/nand_toshiba.c                |   14 +
 drivers/mtd/nand/raw/nandsim.c                     |  438 ++++---
 drivers/mtd/nand/raw/ndfc.c                        |    8 +-
 drivers/mtd/nand/raw/omap2.c                       |    8 +-
 drivers/mtd/nand/raw/omap_elm.c                    |    1 +
 drivers/mtd/nand/raw/orion_nand.c                  |    8 +-
 drivers/mtd/nand/raw/oxnas_nand.c                  |   33 +-
 drivers/mtd/nand/raw/pasemi_nand.c                 |    9 +-
 drivers/mtd/nand/raw/plat_nand.c                   |    8 +-
 drivers/mtd/nand/raw/qcom_nandc.c                  |   13 +-
 drivers/mtd/nand/raw/r852.c                        |    6 +-
 drivers/mtd/nand/raw/s3c2410.c                     |    3 +-
 drivers/mtd/nand/raw/sh_flctl.c                    |    6 +-
 drivers/mtd/nand/raw/sharpsl.c                     |   14 +-
 drivers/mtd/nand/raw/socrates_nand.c               |    8 +-
 drivers/mtd/nand/raw/stm32_fmc2_nand.c             | 1067 ++++++++--------
 drivers/mtd/nand/raw/sunxi_nand.c                  |   16 +-
 drivers/mtd/nand/raw/tango_nand.c                  |   13 +-
 drivers/mtd/nand/raw/tegra_nand.c                  |    6 +-
 drivers/mtd/nand/raw/tmio_nand.c                   |    8 +-
 drivers/mtd/nand/raw/txx9ndfmc.c                   |    6 +-
 drivers/mtd/nand/raw/vf610_nfc.c                   |   10 +-
 drivers/mtd/nand/raw/xway_nand.c                   |    8 +-
 drivers/mtd/parsers/cmdlinepart.c                  |   35 +-
 drivers/mtd/parsers/ofpart.c                       |    3 +
 drivers/mtd/spi-nor/Kconfig                        |    4 +-
 drivers/mtd/spi-nor/controllers/Kconfig            |    4 +-
 drivers/mtd/spi-nor/controllers/aspeed-smc.c       |    2 +-
 drivers/mtd/spi-nor/controllers/hisi-sfc.c         |    2 +-
 drivers/mtd/spi-nor/controllers/nxp-spifi.c        |    2 +-
 drivers/mtd/spi-nor/core.c                         |   22 +-
 drivers/mtd/spi-nor/macronix.c                     |    6 +
 drivers/mtd/spi-nor/micron-st.c                    |    6 +-
 drivers/mtd/spi-nor/sfdp.c                         |   34 +-
 drivers/mtd/spi-nor/sfdp.h                         |   11 +-
 drivers/mtd/spi-nor/spansion.c                     |   44 +-
 drivers/mtd/spi-nor/winbond.c                      |   29 +-
 drivers/mtd/ubi/build.c                            |    5 +-
 include/linux/bch.h                                |   11 +-
 include/linux/mtd/bbm.h                            |    2 +-
 include/linux/mtd/cfi.h                            |    6 +-
 include/linux/mtd/mtd.h                            |    7 +-
 include/linux/mtd/partitions.h                     |    2 +
 include/linux/mtd/qinfo.h                          |    2 +-
 include/linux/mtd/rawnand.h                        |  131 +-
 include/linux/mtd/spi-nor.h                        |   24 +-
 include/linux/platform_data/mtd-davinci.h          |    2 +-
 include/linux/platform_data/mtd-nand-s3c2410.h     |    2 +-
 include/uapi/mtd/mtd-abi.h                         |    1 +
 lib/bch.c                                          |  152 ++-
 100 files changed, 4431 insertions(+), 2613 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/arasan,nand-controller.yaml
 create mode 100644 drivers/mtd/nand/raw/arasan-nand-controller.c
 delete mode 100644 drivers/mtd/nand/raw/cmx270_nand.c
