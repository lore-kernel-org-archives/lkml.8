Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_RHS_DOB autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3130DC33CAF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 23:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 050722053B
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 23:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbgASXw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 18:52:27 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:54123 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728841AbgASXw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 18:52:26 -0500
Received: from localhost (lfbn-lyo-1-1913-102.w90-65.abo.wanadoo.fr [90.65.92.102])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 3E10E100002;
        Sun, 19 Jan 2020 23:52:24 +0000 (UTC)
Date:   Mon, 20 Jan 2020 00:52:23 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: at91: defconfig for 5.6 #2
Message-ID: <20200119235223.GA92283@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd, Olof,

A single patch adding pit64 (the sam9x60 clocksource) and SDHCI support
in at91_dt_defconfig so it can generate kernels that will boot on the
sam9x60ek.

The following changes since commit f013dbe4e7205b44ce057ef6aab8853d1c63513d:

  ARM: configs: at91: enable config flags for sam9x60 SoC (2020-01-10 23:40:03 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux tags/at91-5.6-defconfig-2

for you to fetch changes up to 82720a53472db7e4313342bb778a6e6fd910c6c6:

  ARM: configs: at91: enable MMC_SDHCI_OF_AT91 and MICROCHIP_PIT64B (2020-01-20 00:48:33 +0100)

----------------------------------------------------------------
AT91 defconfig for 5.6 #2

 - Add pit64 and sdhci support for at91_dt

----------------------------------------------------------------
Claudiu Beznea (1):
      ARM: configs: at91: enable MMC_SDHCI_OF_AT91 and MICROCHIP_PIT64B

 arch/arm/configs/at91_dt_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
