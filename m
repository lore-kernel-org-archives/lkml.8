Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590E5C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 16:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3500C214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 16:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbgAMQQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 11:16:16 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:52863 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbgAMQQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 11:16:14 -0500
X-Originating-IP: 90.65.102.129
Received: from localhost (lfbn-lyo-1-1670-129.w90-65.abo.wanadoo.fr [90.65.102.129])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 362C7C0010;
        Mon, 13 Jan 2020 16:16:12 +0000 (UTC)
Date:   Mon, 13 Jan 2020 17:16:12 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: at91: SoC for 5.6
Message-ID: <20200113161612.GA1358903@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd, Olof,


The Kconfig option for sam9x60 is being separated from the other
at91sam9.

The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux tags/at91-5.6-soc

for you to fetch changes up to d9b8e21eae5d032a217c382520a72e5a51a08440:

  ARM: at91: Documentation: add sam9x60 product and datasheet (2020-01-10 23:40:31 +0100)

----------------------------------------------------------------
AT91 SoC for 5.5

 - Document new SoC: sam9x60
 - rework sam9x60 Kconfig option

----------------------------------------------------------------
Claudiu Beznea (9):
      ARM: at91: Kconfig: add sam9x60 pll config flag
      ARM: at91: Kconfig: add config flag for SAM9X60 SoC
      ARM: at91: pm: move SAM9X60's PM under its own SoC config flag
      drivers: soc: atmel: move sam9x60 under its own config flag
      power: reset: Kconfig: select POWER_RESET_AT91_RESET for sam9x60
      drivers: soc: atmel: select POWER_RESET_AT91_SAMA5D2_SHDWC for sam9x60
      ARM: debug-ll: select DEBUG_AT91_RM9200_DBGU for sam9x60
      ARM: at91: pm: use SAM9X60 PMC's compatible
      ARM: at91: pm: use of_device_id array to find the proper shdwc node

Nicolas Ferre (1):
      ARM: at91: Documentation: add sam9x60 product and datasheet

 Documentation/arm/microchip.rst |  6 ++++++
 arch/arm/Kconfig.debug          |  6 +++---
 arch/arm/mach-at91/Kconfig      | 24 ++++++++++++++++++++++--
 arch/arm/mach-at91/Makefile     |  1 +
 arch/arm/mach-at91/at91sam9.c   | 18 ------------------
 arch/arm/mach-at91/pm.c         | 11 +++++++++--
 arch/arm/mach-at91/sam9x60.c    | 34 ++++++++++++++++++++++++++++++++++
 drivers/power/reset/Kconfig     |  4 ++--
 drivers/soc/atmel/soc.c         |  5 +++--
 9 files changed, 80 insertions(+), 29 deletions(-)
 create mode 100644 arch/arm/mach-at91/sam9x60.c

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
