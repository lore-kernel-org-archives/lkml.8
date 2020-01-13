Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA98C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 15:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8831D21556
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 15:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbgAMPy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 10:54:27 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:36421 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727286AbgAMPy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 10:54:26 -0500
X-Originating-IP: 90.65.102.129
Received: from localhost (lfbn-lyo-1-1670-129.w90-65.abo.wanadoo.fr [90.65.102.129])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 05650E000B;
        Mon, 13 Jan 2020 15:54:23 +0000 (UTC)
Date:   Mon, 13 Jan 2020 16:54:23 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: at91: DT for 5.6 #1
Message-ID: <20200113155423.GA1357189@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd, Olof,

Here is the first AT91 DT pull request for 5.6. A few new boards and not
so urgent fixes this cycle. I may have a second pull request by then end
of the week with the sam9x60 device tree.

The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux tags/at91-5.6-dt-1

for you to fetch changes up to a7e0f3fc01df4b1b7077df777c37feae8c9e8b6d:

  ARM: dts: at91: sama5d3: define clock rate range for tcb1 (2020-01-10 18:25:14 +0100)

----------------------------------------------------------------
AT91 DT for 5.6

 - Fix sama5d3 peripheral clock rate range
 - New boards: Overkiz Smartikz and Kizbox Mini, Microchip SAMA5D27
   wlsom1-ek
 - sama5d2 sdmcc fixes

----------------------------------------------------------------
Alexandre Belloni (3):
      ARM: dts: at91: nattis 2: remove unnecessary include
      ARM: dts: at91: sama5d3: fix maximum peripheral clock rates
      ARM: dts: at91: sama5d3: define clock rate range for tcb1

Andrei Stefanescu (1):
      ARM: dts: at91: sama5d2: mark secumod as a GPIO controller

Eugen Hristev (3):
      dt-bindings: ARM: at91: Document SAMA5D27 WLSOM1 and Evaluation Kit
      ARM: dts: at91: sama5d27_wlsom1: add SAMA5D27 wlsom1 and wlsom1-ek
      ARM: dts: at91: sama5d27_som1_ek: add i2c filters properties

Ingo van Lil (1):
      ARM: dts: at91: Reenable UART TX pull-ups

Kamel Bouhara (3):
      ARM: dts: at91: rearrange kizbox dts using aliases nodes
      dt-bindings: arm: at91: Document Kizboxmini and Smartkiz boards binding
      ARM: dts: at91: add smartkiz support and a common kizboxmini dtsi file

Ludovic Desroches (1):
      ARM: dts: at91: sama5d2: set the sdmmc gclk frequency

Nicolas Ferre (1):
      ARM: dts: at91: sama5d27_som1_ek: add the microchip,sdcal-inverted on sdmmc0

Razvan Stefanescu (1):
      ARM: dts: at91: sama5d2: disable pwm0 by default

 .../devicetree/bindings/arm/atmel-at91.yaml        |  25 ++
 arch/arm/boot/dts/Makefile                         |   6 +-
 arch/arm/boot/dts/at91-kizbox.dts                  | 172 ++++++------
 arch/arm/boot/dts/at91-kizboxmini-base.dts         |  24 ++
 ...-kizboxmini.dts => at91-kizboxmini-common.dtsi} | 163 ++++++-----
 arch/arm/boot/dts/at91-kizboxmini-mb.dts           |  26 ++
 arch/arm/boot/dts/at91-kizboxmini-rd.dts           |  49 ++++
 arch/arm/boot/dts/at91-nattis-2-natte-2.dts        |   1 -
 arch/arm/boot/dts/at91-sama5d27_som1.dtsi          |   4 +
 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts        |   6 +
 arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi        | 304 +++++++++++++++++++++
 arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts      | 270 ++++++++++++++++++
 arch/arm/boot/dts/at91-smartkiz.dts                | 109 ++++++++
 arch/arm/boot/dts/at91sam9260.dtsi                 |  16 +-
 arch/arm/boot/dts/at91sam9261.dtsi                 |   6 +-
 arch/arm/boot/dts/at91sam9263.dtsi                 |   6 +-
 arch/arm/boot/dts/at91sam9g45.dtsi                 |   8 +-
 arch/arm/boot/dts/at91sam9rl.dtsi                  |   8 +-
 arch/arm/boot/dts/sama5d2.dtsi                     |  10 +-
 arch/arm/boot/dts/sama5d3.dtsi                     |  28 +-
 arch/arm/boot/dts/sama5d3_can.dtsi                 |   4 +-
 arch/arm/boot/dts/sama5d3_tcb1.dtsi                |   1 +
 arch/arm/boot/dts/sama5d3_uart.dtsi                |   4 +-
 23 files changed, 1037 insertions(+), 213 deletions(-)
 create mode 100644 arch/arm/boot/dts/at91-kizboxmini-base.dts
 rename arch/arm/boot/dts/{at91-kizboxmini.dts => at91-kizboxmini-common.dtsi} (51%)
 create mode 100644 arch/arm/boot/dts/at91-kizboxmini-mb.dts
 create mode 100644 arch/arm/boot/dts/at91-kizboxmini-rd.dts
 create mode 100644 arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi
 create mode 100644 arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts
 create mode 100644 arch/arm/boot/dts/at91-smartkiz.dts

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
