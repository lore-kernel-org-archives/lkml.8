Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC4EFC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 19:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 981A8206E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 19:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgGZTcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 15:32:10 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:56935 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbgGZTcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 15:32:10 -0400
Received: from localhost (lfbn-lyo-1-1932-79.w90-66.abo.wanadoo.fr [90.66.108.79])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id DCA17100004;
        Sun, 26 Jul 2020 19:32:07 +0000 (UTC)
Date:   Sun, 26 Jul 2020 21:32:07 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
List-Id: <soc.lore.kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: at91: DT for 5.9
Message-ID: <20200726193207.GA182066@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd, Olof,

Here is the DT pull request for AT91. It is mainly fixing audio nodes
for the evaluation board. It also introduces the RTT node for sama9x60.
Finally, it fixes Ethernet on the GMAC interface of sama5d3_xplained.

The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux tags/at91-dt-5.9

for you to fetch changes up to 7dbf4bbf1c320d82058878bd44805724d171e1e8:

  ARM: dts: at91: sama5d3_xplained: change phy-mode (2020-07-20 11:15:35 +0200)

----------------------------------------------------------------
AT91 DT for 5.9

 - ClassD pull down fixes
 - Enable RTT as RTC on sam9x60ek
 - Fix phy-mode for sama5d3_xplained

----------------------------------------------------------------
Alexandre Belloni (1):
      ARM: dts: at91: sama5d3_xplained: change phy-mode

Claudiu Beznea (2):
      dt-bindings: rtc: add microchip,sam9x60-rtt
      ARM: dts: sam9x60: add rtt

Codrin Ciubotariu (3):
      ARM: dts: at91: sama5d2_xplained: classd: pull-down the R1 and R3 lines
      ARM: dts: at91: sam9x60ek: classd: pull-down the L1 and L3 lines
      ARM: dts: at91: sama5d2_xplained: Remove pdmic node

 .../devicetree/bindings/rtc/atmel,at91sam9-rtc.txt |  4 ++-
 arch/arm/boot/dts/at91-sam9x60ek.dts               | 13 ++++++++--
 arch/arm/boot/dts/at91-sama5d2_xplained.dts        | 30 +++++++---------------
 arch/arm/boot/dts/at91-sama5d3_xplained.dts        |  2 +-
 arch/arm/boot/dts/sam9x60.dtsi                     |  7 +++++
 5 files changed, 31 insertions(+), 25 deletions(-)

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
