Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20644C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 20:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0393A206C3
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 20:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgF1UBM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 16:01:12 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:39209 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbgF1UBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 16:01:12 -0400
Received: from mail-qt1-f175.google.com ([209.85.160.175]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1M2OEq-1jp5WS05jK-003th0 for <linux-kernel@vger.kernel.org>; Sun, 28 Jun
 2020 22:01:10 +0200
Received: by mail-qt1-f175.google.com with SMTP id o38so11383440qtf.6
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 13:01:09 -0700 (PDT)
X-Gm-Message-State: AOAM532TT8ynnhUJk5nUMvCrhbe2DZyj3E4jnChbpWFaL+XKuwADnzmo
        RCSP20PAlO4tcNWHoFJGDq7udtEv8Uzks36nLP4=
X-Google-Smtp-Source: ABdhPJxD1de3Hn770zLammyZo+5pksfQKAR9kxHLaDEIAqEQm6jdIX1Mm4dkyvVb8hfkMJUNKLgq2nlTYMtwD3kDwEU=
X-Received: by 2002:ac8:7587:: with SMTP id s7mr12718225qtq.304.1593374468894;
 Sun, 28 Jun 2020 13:01:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a1rUGkoHanEGfc+o8bjgZO=T-40-e-wy+ECLxuU_pT97A@mail.gmail.com>
In-Reply-To: <CAK8P3a1rUGkoHanEGfc+o8bjgZO=T-40-e-wy+ECLxuU_pT97A@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 28 Jun 2020 22:00:53 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1pbjKE7EX5+UYZbzWMAZ9kjftodURZ+vgrCQ3Cn2vj+A@mail.gmail.com>
Message-ID: <CAK8P3a1pbjKE7EX5+UYZbzWMAZ9kjftodURZ+vgrCQ3Cn2vj+A@mail.gmail.com>
Subject: [GIT PULL 1/2] ARM: SoC fixes for v5.8
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:fLJThnJDbXRd3ize6dCi9rUPIj5V64Bh1pYQIcGbgMc5KZSSJcm
 DT2P5NN9Hdo6STP+a/0dzjIUrMUq1nZP0cXb8SjY3FVbZ5xqmeNjnmnNdPLhpIai7Yp1y4u
 F+SwxALtAmGp8KARQCpIdxuiO6flBLdduN/+B14HRmtXSU7oy1kqfzxIFbkfoFyDjiAZ2J/
 Tv7xpTfPISUnXM0NtkDXQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SixBkO9yak8=:4nyG2K+8Exzyn06g5+ZD/+
 KbSDEDPeiQt1pFd7es8/nbqI7ENzmHgkdMPrzhiQ+bTRKkZcNa96aH4uJyAYTdDnonyFrMJfm
 IdmQ9m1oA7xhJPMW7VDii694+cGSbM7yFKZd3cVk2k8HoHsFZy/7BUbwN5ZSAagOP0hXLm2W7
 PThN2g69FfQddcRhlCSbyx2aztyhuSNhabWE2LRLJm+N7j/0SGweWsFtQx4+9walWrXs04Mv3
 JjDK7R2d1NtMaZKfpjSbTo0Ep2OPdv4SweSfa5I3UfwbMMR9Ks0rAcUZlQhE/Q/ZxnZzZZZTE
 MURY+xn8u6nfpj3euPf06GZbI3IZywVgbKkiEjlp9emHPPMFnZRL4gwokAB2Wahdk84v7XdIi
 1JIP+Oc8ksVSmMMVnpwpZ4TwLnUI6cnZJGlGXaUVTsZJvq9RpJKZ0n45ECVCSkXnziB5QYOlY
 wsbDM7l3fnjX6aW0HRfGYRxtr6+ZwRNNZOnM8rRBrEmFyfs1aZb1rKo31J9I9c8AOaB1NLSlv
 8uY48z+6EPZxMffI/XCzAQUNNCSFASd7x35qRt3mIcqYKhHAQWcPczMp22xDWYCQac/AQwgLq
 SWZahfbns90I6XWsS/QpHQmqXFGsYg7Zz6hMj4T9PIGVC96bYYR25spbn6T18ONvBiSVidyq8
 LytqcxBE4uOnxx8bfHGvwL5YiqfaRojVBdopahsDyjmYdtoaccOHZ413tEEzO0DVEXDrLeGee
 eqrd1XcBk5Fc8hiaVDYuCnbI+wGDn6zSE6gnFe9yxfmIIJ0NkAIeS1Z7UuZjdxrQLaPze9PoM
 7lcqC1W70z83sMmlpKzmbHgSjcn0QFsbOgoYEISI2kR8cmR6W4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 48778464bb7d346b47157d21ffde2af6b2d39110:

  Linux 5.8-rc2 (2020-06-21 15:45:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/arm-fixes-5.8-1

for you to fetch changes up to 42d3f7e8da1bc55e3109f612c519c945f6587194:

  Merge tag 'imx-fixes-5.8' of
git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into
arm/fixes (2020-06-28 14:48:19 +0200)

----------------------------------------------------------------
ARM: SoC fixes for v5.8

Here are a couple of bug fixes, mostly for devicetree files

NXP i.MX:
  - Use correct voltage on some i.MX8M board device trees to
    avoid hardware damage
  - Code fixes for a compiler warning and incorrect reference
    counting, both harmless.
  - Fix the i.MX8M SoC driver to correctly identify imx8mp
  - Fix watchdog configuration in imx6ul-kontron device tree.

Broadcom:
  - A small regression fix for the Raspberry-Pi firmware driver
  - A Kconfig change to use the correct timer driver on Northstar
  - A DT fix for the Luxul XWC-2000 machine
  - Two more DT fixes for NSP SoCs

STmicroelectronics STI
  - Revert one broken patch for L2 cache configuration

ARM Versatile Express:
  - Fix a regression by reverting a broken DT cleanup

TEE drivers:
  - MAINTAINERS: change tee mailing list

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

----------------------------------------------------------------
Adam Ford (1):
      arm64: dts: imx8mm-beacon: Fix voltages on LDO1 and LDO2

Andre Przywara (1):
      arm: dts: vexpress: Move mcc node back into motherboard node

Andy Shevchenko (1):
      ARM: bcm2835: Fix integer overflow in
rpi_firmware_print_firmware_revision()

Anson Huang (1):
      soc: imx8m: Correct i.MX8MP UID fuse offset

Arnd Bergmann (6):
      Merge tag 'juno-fix-5.8' of
git://git.kernel.org/.../sudeep.holla/linux into arm/fixes
      Merge tag 'tee-ml-for-v5.8' of
git://git.linaro.org/people/jens.wiklander/linux-tee into arm/fixes
      Merge tag 'arm-soc/for-5.8/devicetree-fixes' of
https://github.com/Broadcom/stblinux into arm/fixes
      Merge tag 'arm-soc/for-5.8/soc-fixes' of
https://github.com/Broadcom/stblinux into arm/fixes
      Merge tag 'arm-soc/for-5.8/drivers-fixes' of
https://github.com/Broadcom/stblinux into arm/fixes
      Merge tag 'imx-fixes-5.8' of
git://git.kernel.org/.../shawnguo/linux into arm/fixes

Florian Fainelli (1):
      Merge tag 'tags/bcm2835-drivers-fixes-2020-0-17' into drivers/fixes

Frieder Schrempf (2):
      ARM: dts: imx6ul-kontron: Move watchdog from Kontron i.MX6UL/ULL
board to SoM
      ARM: dts: imx6ul-kontron: Change WDOG_ANY signal from push-pull
to open-drain

Jens Wiklander (1):
      MAINTAINERS: change tee mailing list

Matthew Hagan (3):
      ARM: bcm: Select ARM_TIMER_SP804 for ARCH_BCM_NSP
      ARM: dts: NSP: Disable PL330 by default, add dma-coherent property
      ARM: dts: NSP: Correct FA2 mailbox node

Patrice Chotard (1):
      Revert "ARM: sti: Implement dummy L2 cache's write_sec"

Peng Fan (1):
      soc: imx8m: fix build warning

Rafał Miłecki (1):
      ARM: dts: BCM5301X: Add missing memory "device_type" for Luxul XWC-2000

Robin Gong (2):
      arm64: dts: imx8mm-evk: correct ldo1/ldo2 voltage range
      arm64: dts: imx8mn-ddr4-evk: correct ldo1/ldo2 voltage range

yu kuai (2):
      ARM: imx5: add missing put_device() call in imx_suspend_alloc_ocram()
      ARM: imx6: add missing put_device() call in imx6q_suspend_init()

 MAINTAINERS                                        |   6 +-
 arch/arm/boot/dts/bcm-nsp.dtsi                     |  10 +-
 arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dts      |   1 +
 arch/arm/boot/dts/bcm958522er.dts                  |   4 +
 arch/arm/boot/dts/bcm958525er.dts                  |   4 +
 arch/arm/boot/dts/bcm958525xmc.dts                 |   4 +
 arch/arm/boot/dts/bcm958622hr.dts                  |   4 +
 arch/arm/boot/dts/bcm958623hr.dts                  |   4 +
 arch/arm/boot/dts/bcm958625hr.dts                  |   4 +
 arch/arm/boot/dts/bcm958625k.dts                   |   4 +
 arch/arm/boot/dts/imx6ul-kontron-n6x1x-s.dtsi      |  13 --
 .../boot/dts/imx6ul-kontron-n6x1x-som-common.dtsi  |  13 ++
 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi            | 146 ++++++++++-----------
 arch/arm/mach-bcm/Kconfig                          |   1 +
 arch/arm/mach-imx/pm-imx5.c                        |   6 +-
 arch/arm/mach-imx/pm-imx6.c                        |  10 +-
 arch/arm/mach-sti/board-dt.c                       |   9 --
 .../boot/dts/freescale/imx8mm-beacon-som.dtsi      |   4 +-
 arch/arm64/boot/dts/freescale/imx8mm-evk.dts       |   4 +-
 arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts  |   4 +-
 drivers/firmware/raspberrypi.c                     |   5 +-
 drivers/soc/imx/soc-imx8m.c                        |  10 +-
 22 files changed, 152 insertions(+), 118 deletions(-)
