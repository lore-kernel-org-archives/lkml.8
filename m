Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C41AC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 20:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B9AB2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 20:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbgA3UU6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 15:20:58 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:34007 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgA3UU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 15:20:57 -0500
X-Originating-IP: 93.23.196.10
Received: from xps13 (10.196.23.93.rev.sfr.net [93.23.196.10])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 166BB1C0002;
        Thu, 30 Jan 2020 20:20:53 +0000 (UTC)
Date:   Thu, 30 Jan 2020 21:20:52 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] mtd: Changes for 5.6
Message-ID: <20200130212052.11ca8719@xps13>
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

This is the MTD PR for 5.6.

Thanks,
Miquèl

The following changes since commit b3a987b0264d3ddbb24293ebff10eddfc472f653:

  Linux 5.5-rc6 (2020-01-12 16:55:08 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/for-5.6

for you to fetch changes up to 4575243c5c173f8adbc08a5c6ea2269742ea2b47:

  Merge tag 'nand/for-5.6' into mtd/next (2020-01-27 17:49:15 +0100)

----------------------------------------------------------------
MTD core
* block2mtd: page index should use pgoff_t
* maps: physmap: minimal Runtime PM support
* maps: pcmciamtd: avoid possible sleep-in-atomic-context bugs
* concat: Fix a comment referring to an unknown symbol

Raw NAND
* Macronix: Use match_string() helper
* Atmel: switch to using devm_fwnode_gpiod_get()
* Denali: rework the SKIP_BYTES feature and add reset controlling
* Brcmnand: set appropriate DMA mask
* Cadence: add unspecified HAS_IOMEM dependency
* Various cleanup.

Onenand
* Rename Samsung and Omap2 drivers to avoid possible build warnings
* Enable compile testing
* Various build issues
* Kconfig cleanup

SPI-NAND
* Support for Toshiba TC58CVG2S0HRAIJ

SPI-NOR:
- Add support for TB selection using SR bit 6,
- Add support for few flashes.

----------------------------------------------------------------
Brendan Higgins (1):
      mtd: rawnand: add unspecified HAS_IOMEM dependency

Chen Wandun (1):
      mtd: onenand: samsung: remove set but not used variable

David Bauer (1):
      mtd: spi-nor: Add support for mx25r3235f

Dmitry Torokhov (1):
      mtd: rawnand: atmel: switch to using devm_fwnode_gpiod_get()

Florian Fainelli (1):
      mtd: rawnand: brcmnand: Set appropriate DMA mask

Geert Uytterhoeven (1):
      mtd: maps: physmap: Add minimal Runtime PM support

Jerome Brunet (1):
      mtd: spi-nor: add Gigadevice gd25lq128d support

Jia-Ju Bai (1):
      mtd: maps: pcmciamtd: fix possible sleep-in-atomic-context bugs in pcmciamtd_set_vpp()

John Garry (1):
      mtd: spi-nor: hisi-sfc: Try to provide some clarity on which SFC we are

Joseph Kust (1):
      mtd: spi-nor: Add support for sst26vf016b

Jungseung Lee (4):
      mtd: spi-nor: fix typo of "JESB216" in comment
      mtd: spi-nor: Rename SR_TB to indicate the bit used
      mtd: spi-nor: Support TB selection using SR bit 6
      mtd: spi-nor: Fix wrong TB selection of GD25Q256

Krzysztof Kozlowski (4):
      mtd: onenand: Fix Kconfig indentation
      mtd: onenand: samsung: Fix pointer cast -Wpointer-to-int-cast warnings on 64 bit
      mtd: onenand: samsung: Fix printing format for size_t on 64-bit
      mtd: onenand: Enable compile testing of OMAP and Samsung drivers

Liu Song (1):
      mtd: block2mtd: page index should use pgoff_t

Marek Vasut (1):
      mtd: rawnand: denali_dt: Add support for configuring SPARE_AREA_SKIP_BYTES

Masahiro Yamada (4):
      mtd: rawnand: denali_dt: error out if platform has no associated data
      dt-bindings: mtd: denali_dt: document reset property
      mtd: rawnand: denali_dt: add reset controlling
      mtd: rawnand: denali: remove hard-coded DENALI_DEFAULT_OOB_SKIP_BYTES

Michael Walle (3):
      mtd: spi-nor: remove unused enum spi_nor_ops
      mtd: spi-nor: Add support for w25q32jwm
      mtd: spi-nor: Add support for at25sl321

Mika Westerberg (2):
      mtd: spi-nor: intel-spi: Add support for Intel Jasper Lake SPI serial flash
      mtd: spi-nor: intel-spi: Add support for Intel Comet Lake-V SPI serial flash

Miquel Raynal (5):
      mtd: onenand: Use a better name for samsung driver
      mtd: onenand: Rename omap2 driver to avoid a build warning
      mtd: concat: Fix a comment referring to an unknown symbol
      Merge tag 'spi-nor/for-5.6' into mtd/next
      Merge tag 'nand/for-5.6' into mtd/next

Nathan Chancellor (1):
      mtd: onenand_base: Adjust indentation in onenand_read_ops_nolock

Robert Marko (2):
      mtd: spi-nor: Add 4B_OPCODES flag to w25q256
      mtd: spinand: add support for Toshiba TC58CVG2S0HRAIJ

Vignesh Raghavendra (3):
      mtd: spi-nor: Split mt25qu512a (n25q512a) entry into two
      mtd: spi-nor: Add entries for mt25q variants
      mtd: spi-nor: Add USE_FSR flag for n25q* entries

YueHaibing (2):
      mtd: sharpslpart: Fix unsigned comparison to zero
      mtd: rawnand: macronix: Use match_string() helper to simplify the code

zhengbin (1):
      mtd: rawnand: mpc5121: Remove unneeded semicolon

 Documentation/devicetree/bindings/mtd/denali-nand.txt   |   7 ++
 drivers/mtd/devices/block2mtd.c                         |   8 +-
 drivers/mtd/maps/pcmciamtd.c                            |   7 +-
 drivers/mtd/maps/physmap-core.c                         |  20 +++-
 drivers/mtd/mtdconcat.c                                 |   5 +-
 drivers/mtd/nand/onenand/Kconfig                        |  14 +--
 drivers/mtd/nand/onenand/Makefile                       |   4 +-
 drivers/mtd/nand/onenand/onenand_base.c                 |  82 +++++++--------
 drivers/mtd/nand/onenand/{omap2.c => onenand_omap2.c}   |   0
 .../nand/onenand/{samsung_mtd.c => onenand_samsung.c}   |   9 +-
 drivers/mtd/nand/raw/Kconfig                            |   2 +-
 drivers/mtd/nand/raw/atmel/nand-controller.c            |  20 ++--
 drivers/mtd/nand/raw/brcmnand/brcmnand.c                |  10 ++
 drivers/mtd/nand/raw/denali.c                           |  14 +--
 drivers/mtd/nand/raw/denali_dt.c                        |  56 ++++++++--
 drivers/mtd/nand/raw/mpc5121_nfc.c                      |   2 +-
 drivers/mtd/nand/raw/nand_macronix.c                    |  11 +-
 drivers/mtd/nand/spi/toshiba.c                          |  10 ++
 drivers/mtd/parsers/sharpslpart.c                       |   4 +-
 drivers/mtd/spi-nor/Kconfig                             |   4 +-
 drivers/mtd/spi-nor/aspeed-smc.c                        |   4 +-
 drivers/mtd/spi-nor/cadence-quadspi.c                   |   4 +-
 drivers/mtd/spi-nor/hisi-sfc.c                          |   6 +-
 drivers/mtd/spi-nor/intel-spi-pci.c                     |   2 +
 drivers/mtd/spi-nor/spi-nor.c                           | 127 ++++++++++++++++-------
 include/linux/mtd/spi-nor.h                             |  16 +--
 26 files changed, 286 insertions(+), 162 deletions(-)
 rename drivers/mtd/nand/onenand/{omap2.c => onenand_omap2.c} (100%)
 rename drivers/mtd/nand/onenand/{samsung_mtd.c => onenand_samsung.c} (99%)
