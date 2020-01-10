Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64841C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 14:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BD74214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 14:42:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbgAJOmX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 09:42:23 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:49309 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727952AbgAJOmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 09:42:22 -0500
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id F40E6240011;
        Fri, 10 Jan 2020 14:42:19 +0000 (UTC)
Date:   Fri, 10 Jan 2020 15:42:18 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] mtd: Fixes for v5.5-rc6
Message-ID: <20200110154218.0b28309f@xps13>
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

This is the MTD fixes PR for v5.5-rc6.

Thanks,
Miquèl

The following changes since commit c79f46a282390e0f5b306007bf7b11a46d529538:

  Linux 5.5-rc5 (2020-01-05 14:23:27 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-5.5-rc6

for you to fetch changes up to 82de6a6fb67e16a30ec2f586b1f6976c2d7b4b62:

  mtd: spi-nor: Fix the writing of the Status Register on micron flashes (2020-01-09 20:11:34 +0100)

----------------------------------------------------------------
MTD:
* sm_ftl: Fix NULL pointer warning.

Raw NAND:
* Cadence: fix compile testing.
* STM32: Avoid locking.

Onenand:
* Fix several sparse/build warnings.

SPI-NOR:
* Add a flag to fix interaction with Micron parts.

----------------------------------------------------------------
Amir Mahdi Ghorbanian (1):
      mtd: onenand: omap2: Fix errors in style

Arnd Bergmann (1):
      mtd: sm_ftl: fix NULL pointer warning

Christophe Kerello (1):
      mtd: rawnand: stm32_fmc2: avoid to lock the CPU bus

Krzysztof Kozlowski (1):
      mtd: onenand: samsung: Fix iomem access with regular memcpy

Peter Ujfalusi (1):
      mtd: onenand: omap2: Pass correct flags for prep_dma_memcpy

Tudor Ambarus (1):
      mtd: spi-nor: Fix the writing of the Status Register on micron flashes

Vasyl Gomonovych (1):
      mtd: cadence: Fix cast to pointer from integer of different size warning

 drivers/mtd/nand/onenand/omap2.c               | 14 ++++++------
 drivers/mtd/nand/onenand/onenand_base.c        | 14 ++++++------
 drivers/mtd/nand/onenand/samsung_mtd.c         |  8 +++----
 drivers/mtd/nand/raw/cadence-nand-controller.c | 13 ++++++-----
 drivers/mtd/nand/raw/stm32_fmc2_nand.c         | 38 +++++++++++++++++++++++++++++++--
 drivers/mtd/sm_ftl.c                           |  3 ++-
 drivers/mtd/spi-nor/spi-nor.c                  |  1 +
 include/linux/mtd/flashchip.h                  |  2 +-
 8 files changed, 65 insertions(+), 28 deletions(-)
