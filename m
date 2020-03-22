Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DE8C4332D
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 08:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 128BE20753
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 08:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgCVI7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 04:59:39 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:56471 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgCVI7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 04:59:39 -0400
Received: from localhost (lfbn-lyo-1-9-35.w86-202.abo.wanadoo.fr [86.202.105.35])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 26DDB24000B;
        Sun, 22 Mar 2020 08:59:32 +0000 (UTC)
Date:   Sun, 22 Mar 2020 09:59:31 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
List-Id: <soc.lore.kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: at91: DT for 5.7
Message-ID: <20200322085931.GA208770@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd, Olof,

Very few DT updates this cycle. I've filled in the google doc as you
requested.

The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux tags/at91-5.7-dt

for you to fetch changes up to b8c2c052de210d23d83eb178fa030b541ca51842:

  ARM: dts: at91: sama5d27_wlsom1_ek: add USB device node (2020-03-20 23:58:14 +0100)

----------------------------------------------------------------
AT91 DT for 5.7

 - Enable watchdog on sam9x60
 - Correct sama5d4/2 RTC compatibles
 - Add i2c gpio pinctrl to allow i2c recovery

----------------------------------------------------------------
Alexandre Belloni (2):
      ARM: dts: at91: sama5d2: use correct rtc compatible
      ARM: dts: at91: sama5d4: use correct rtc compatible

Cristian Birsan (1):
      ARM: dts: at91: sama5d27_wlsom1_ek: add USB device node

Eugen Hristev (2):
      ARM: dts: at91: sam9x60: add watchdog node
      ARM: dts: at91: sam9x60ek: enable watchdog node

Kamel Bouhara (3):
      ARM: dts: at91: sama5d3: add i2c gpio pinctrl
      ARM: dts: at91: sama5d4: add i2c gpio pinctrl
      ARM: dts: at91: sama5d2: add i2c gpio pinctrl

Rob Herring (1):
      ARM: dts: at91: Kill off "simple-panel" compatibles

 arch/arm/boot/dts/at91-dvk_su60_somc_lcm.dtsi |  2 +-
 arch/arm/boot/dts/at91-sam9x60ek.dts          |  5 ++++
 arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts | 12 +++++++++
 arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts     | 33 ++++++++++++++++++++++---
 arch/arm/boot/dts/at91-sama5d2_xplained.dts   | 33 ++++++++++++++++++++++---
 arch/arm/boot/dts/at91-sama5d4_ma5d4evk.dts   |  2 +-
 arch/arm/boot/dts/at91sam9n12ek.dts           |  2 +-
 arch/arm/boot/dts/at91sam9x5dm.dtsi           |  2 +-
 arch/arm/boot/dts/sam9x60.dtsi                |  8 ++++++
 arch/arm/boot/dts/sama5d2.dtsi                |  2 +-
 arch/arm/boot/dts/sama5d3.dtsi                | 33 ++++++++++++++++++++++---
 arch/arm/boot/dts/sama5d4.dtsi                | 35 ++++++++++++++++++++++++---
 12 files changed, 151 insertions(+), 18 deletions(-)

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
