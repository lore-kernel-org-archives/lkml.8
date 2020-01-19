Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_RHS_DOB autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20689C33CAF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 23:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC05B206B7
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 23:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbgASXrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 18:47:10 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:46325 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728841AbgASXrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 18:47:10 -0500
X-Originating-IP: 90.65.92.102
Received: from localhost (lfbn-lyo-1-1913-102.w90-65.abo.wanadoo.fr [90.65.92.102])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id D95D41C0004;
        Sun, 19 Jan 2020 23:47:07 +0000 (UTC)
Date:   Mon, 20 Jan 2020 00:47:07 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: at91: DT for 5.6 #2
Message-ID: <20200119234707.GA90094@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd, Olof,

Here is the second DT pull request for AT91 with mostly DT compatible
documentation and the sam9x60 SoC dtsi and evaluation kit dts. This
builds fine and is very unlikely to cause any issue.

The following changes since commit a7e0f3fc01df4b1b7077df777c37feae8c9e8b6d:

  ARM: dts: at91: sama5d3: define clock rate range for tcb1 (2020-01-10 18:25:14 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux tags/at91-5.6-dt-2

for you to fetch changes up to 1e5f532c273714abf4275df930b2c77aa1b63b51:

  ARM: dts: at91: sam9x60: add device tree for soc and board (2020-01-16 14:51:40 +0100)

----------------------------------------------------------------
AT91 DT for 5.6 #2

 - Add sam9x60 dtsi
 - New board sam9x60 Evaluation Kit

----------------------------------------------------------------
Claudiu Beznea (11):
      dt-bindings: at_xdmac: remove wildcard
      dt-bindings: at_xdmac: add microchip,sam9x60-dma
      dt-bindings: atmel-can: add microchip,sam9x60-can
      dt-bindings: atmel-isi: add microchip,sam9x60-isi
      dt-bindings: at91-sama5d2_adc: add microchip,sam9x60-adc
      dt-bindings: atmel-matrix: add microchip,sam9x60-matrix
      dt-bindings: atmel-nand: add microchip,sam9x60-pmecc
      dt-bindings: atmel-sysreg: add microchip,sam9x60-ddramc
      dt-bindings: atmel-smc: add microchip,sam9x60-smc
      dt-bindings: atmel-gpbr: add microchip,sam9x60-gpbr
      dt-bindings: arm: add sam9x60-ek board

Sandeep Sheriker Mallikarjun (1):
      ARM: dts: at91: sam9x60: add device tree for soc and board

 .../devicetree/bindings/arm/atmel-at91.yaml        |   6 +
 .../devicetree/bindings/arm/atmel-sysregs.txt      |   1 +
 .../devicetree/bindings/dma/atmel-xdma.txt         |   4 +-
 .../bindings/iio/adc/at91-sama5d2_adc.txt          |   2 +-
 .../devicetree/bindings/media/atmel-isi.txt        |   2 +-
 .../devicetree/bindings/mfd/atmel-gpbr.txt         |   4 +-
 .../devicetree/bindings/mfd/atmel-matrix.txt       |   1 +
 .../devicetree/bindings/mfd/atmel-smc.txt          |   1 +
 .../devicetree/bindings/mtd/atmel-nand.txt         |   1 +
 .../devicetree/bindings/net/can/atmel-can.txt      |   3 +-
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/at91-sam9x60ek.dts               | 647 +++++++++++++++++++
 arch/arm/boot/dts/sam9x60.dtsi                     | 691 +++++++++++++++++++++
 13 files changed, 1358 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/boot/dts/at91-sam9x60ek.dts
 create mode 100644 arch/arm/boot/dts/sam9x60.dtsi

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
