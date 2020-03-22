Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F0ACC4332D
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 09:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A85220753
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 09:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbgCVJBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 05:01:24 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:42125 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgCVJBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 05:01:24 -0400
X-Originating-IP: 86.202.105.35
Received: from localhost (lfbn-lyo-1-9-35.w86-202.abo.wanadoo.fr [86.202.105.35])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 70DCAC0005;
        Sun, 22 Mar 2020 09:01:16 +0000 (UTC)
Date:   Sun, 22 Mar 2020 10:01:16 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
List-Id: <soc.lore.kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: at91: SoC for 5.7
Message-ID: <20200322090116.GA208895@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd, Olof,

A bigger update than usual, reworking the PM code to support sam9x60.
I've filled in the google doc as you requested.

The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux tags/at91-5.7-soc

for you to fetch changes up to bb1a0e87e1c54cd884e9b92b1cec06b186edc7a0:

  ARM: at91: pm: add quirk for sam9x60's ulp1 (2020-02-18 21:47:54 +0100)

----------------------------------------------------------------
AT91 SoC for 5.7

 - Rework PM to support sam9x60

----------------------------------------------------------------
Claudiu Beznea (8):
      ARM: at91: pm: use proper master clock register offset
      ARM: at91: pm: revert do not disable/enable PLLA for ULP modes
      ARM: at91: pm: add macros for plla disable/enable
      ARM: at91: pm: add pmc_version member to at91_pm_data
      ARM: at91: pm: s/sfr/sfrbu in pm_suspend.S
      clk: at91: move sam9x60's PLL register offsets to PMC header
      ARM: at91: pm: add plla disable/enable support for sam9x60
      ARM: at91: pm: add quirk for sam9x60's ulp1

Geert Uytterhoeven (1):
      ARM: at91: Drop unneeded select of COMMON_CLK

 arch/arm/mach-at91/Kconfig           |   1 -
 arch/arm/mach-at91/pm.c              |  35 ++++++-
 arch/arm/mach-at91/pm.h              |   2 +
 arch/arm/mach-at91/pm_data-offsets.c |   4 +
 arch/arm/mach-at91/pm_suspend.S      | 189 ++++++++++++++++++++++++++++++++---
 drivers/clk/at91/clk-sam9x60-pll.c   |  91 +++++++----------
 include/linux/clk/at91_pmc.h         |  23 +++++
 7 files changed, 270 insertions(+), 75 deletions(-)

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
