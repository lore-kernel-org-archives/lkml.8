Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9ACBC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C06D820722
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgHCVsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 17:48:14 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:59415 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728038AbgHCVsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 17:48:13 -0400
Received: from mail-qk1-f180.google.com ([209.85.222.180]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MNKuK-1kN9fd3MXS-00OslT for <linux-kernel@vger.kernel.org>; Mon, 03 Aug
 2020 23:48:12 +0200
Received: by mail-qk1-f180.google.com with SMTP id x69so36663210qkb.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 14:48:11 -0700 (PDT)
X-Gm-Message-State: AOAM531tMTCk0PBZ+THIME2ry5h8FoKkL8YmB0uxC+CyTAItNmBLv4WM
        2tY2T6ac4hfXqNz7D6/RSddWV13iu24lpXkLMKU=
X-Google-Smtp-Source: ABdhPJw9ZEQK44UlwYRsKw2xvd+xTXk7tiwVBBuVW80gze2O2uwkpyhXWeiTwUN0Mo+Q3XBnfVd9g/9wSMXez0c5UyE=
X-Received: by 2002:a37:385:: with SMTP id 127mr17213487qkd.3.1596491290681;
 Mon, 03 Aug 2020 14:48:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a1vFJ+uUGPGifZGhECXvxA=2u745WrGNZb08s1nHkZQ9g@mail.gmail.com>
In-Reply-To: <CAK8P3a1vFJ+uUGPGifZGhECXvxA=2u745WrGNZb08s1nHkZQ9g@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 3 Aug 2020 23:47:54 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2B5cxE512R0-ni6BJOnkgR7kGueqd3AU9E2PXh0unsmg@mail.gmail.com>
Message-ID: <CAK8P3a2B5cxE512R0-ni6BJOnkgR7kGueqd3AU9E2PXh0unsmg@mail.gmail.com>
Subject: [GIT PULL 3/5] ARM: SoC changes for v5.9
To:     Linus Torvalds <torvalds@linux-foundation.org>
List-Id: <soc.lore.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:kdYsnBSh32VSMYsZhnnGg6gwxlnz6DhecU0A8nRePha0cAB8Efb
 iT3zSaOQ5MI+FUyLjVpPG98PWoOZ64fBFSFjp4vpyaboglv7FE6r9p9j0oCJ/GqPK9RBFtE
 yjnTjKjXhQ1G/8qr60Okp0vxNs6uRO9jh0rtCJt90i0RRMS/unOoxfxUYUtpmgbtdn1DjSj
 p83COC22FdUbsJWo5qQmw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xWgMo5AiF4g=:q7QzhccC4KwLrB9DrrHlK5
 z2pps3G88rGVpKl7t48FYHLIpvCJ1EFwG+wkfUhL51iIKl+QLPcYzT4cVApKbPnNeWGRM7KST
 P8c+HR+cqr0hNv9Qp0A81h6FYNpVVKTfbRg1QvkkmQ6aStJtL09GMGiJfZRE+tRduYfGjV+Wt
 VXO0KXuouTDmEQOyUDLj1f89GGPg1+cxry3DLEuo5gcWRpuumA5saKENZKa6KPGaijHNrfIoB
 mb3FBElTn83sGqqo2gRJWRg33w7aEGn4q+jwNJa7QP9edXv7ifmk7xhRAn8tAZVghb4MotkaX
 OxNESOtuAV94MWZpst/gdFUSLq4EhvgAzM57jSA4lZSMGGwUbjK77FkNQ2mClMTYA+IDpbPSY
 hJAkyJ5ZtLyb4CzpNXu3fK/n90fYhtdoqxQRYei62inWrDZuhpM6jsr/ImLK28NPhoTaZJCxH
 qFvH+3hVNAc9R0bnMWxRq/jy+3KALsXPHioF8/aX0TMkHsnOLih0n5zqrfHnC+l1LYD8eoZk+
 FmCwtBaiamk2hogBEz9c8usJQDC1E5Xdi6amtWcO1VGcdAI6wZxXzXVaAaSxmx1HUEZt1gnR1
 H4UUdf86q831FlRPaRLcNdY6DyfTKmypcjz12ESp4T4p6Vr440BqwpvCvUPMhAKi96ObGbx6m
 v+04l95uEFcUuA8LihAMaX3htDxh9UPz7hqZQBrQx5p+u7NFVv+YKQ1zCOKjlhUC0W3IKYerv
 GaXjQFqOBp3Un4UXOfzXiYFUOLV0p065YpRQBBuxmYtSSJXlTkbG+CvmObGohEd7mkTNZTDpL
 H+YLYgoVbnlBRjnHGC3qVxZJgphkEpP0976LlO/weq6orrdCgyepHi5KbV0l7zAipGyEct5ed
 w4C4TgtIqtRok0bHIZIBysPGm89diC8OmltJ+zBtICp+lk2ohb+Fm7dk32xDyCDRiVa7IYMy3
 ofJlZ/WsFm1voc3lTbmBqmvRbHjRxHVuFL9cP74SL80rpN17kkQBx
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 812f5501161151f3c3f4e15f7ef250fc1c3af6a4:

  ARM: dts: socfpga: add the temperature sensor to the Arria10 devkit
(2020-07-18 20:12:07 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/arm-soc-5.9

for you to fetch changes up to a04e84c57e9c5a98ba541f37961174ffe3abeb57:

  Merge tag 'socfpga_update_for_v5.9' of
git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux into
arm/soc (2020-07-31 10:11:58 +0200)

----------------------------------------------------------------
ARM: SoC changes for v5.9

These are mostly cosmetic changes and minor bugfixes for the SoC
specific code, across the 32-bit at91, mvebu, davinci, samsung, and
omap platforms.

The main notable changes are for the Samsung s3c platform, which
sees a rewrite of gpio handling and a change to restore and adds
a workaround for a problem with cpuidle support.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

----------------------------------------------------------------
Alexander A. Klimov (4):
      ARM: OMAP: Replace HTTP links with HTTPS ones
      ARM: at91: Replace HTTP links with HTTPS ones
      ARM: s3c24xx: Replace HTTP links with HTTPS ones
      ARM: davinci: Replace HTTP links with HTTPS ones

Andy Shevchenko (1):
      ARM: orion/gpio: Make use of for_each_requested_gpio()

Arnd Bergmann (7):
      udc: lpc32xx: mark local function static
      Merge tag 'omap-for-v5.9/soc-signed' of
git://git.kernel.org/.../tmlind/linux-omap into arm/soc
      Merge tag 'samsung-soc-5.9' of
git://git.kernel.org/.../krzk/linux into arm/soc
      Merge tag 'davinci-for-v5.9/soc' of
git://git.kernel.org/.../nsekhar/linux-davinci into arm/soc
      Merge tag 'mvebu-arm-5.9-1' of
git://git.kernel.org/.../gclement/mvebu into arm/soc
      Merge tag 'at91-soc-5.9' of git://git.kernel.org/.../at91/linux
into arm/soc
      Merge tag 'socfpga_update_for_v5.9' of
git://git.kernel.org/.../dinguyen/linux into arm/soc

Christophe JAILLET (1):
      ARM: davinci: dm646x-evm: Simplify error handling in 'evm_sw_setup()'

Guillaume Tucker (1):
      ARM: exynos: clear L310_AUX_CTRL_FULL_LINE_ZERO in default l2c_aux_val

Kevin Hilman (1):
      MAINTAINERS: arm/amlogic: add designated reviewers

Kieran Bingham (1):
      ARM: davinci: Fix trivial spelling

Linus Walleij (1):
      ARM: s3c24xx: leds: Convert to use GPIO descriptors

Marek Szyprowski (1):
      ARM: exynos: MCPM: Restore big.LITTLE cpuidle support

Paul Schulz (1):
      ARM: rpc: Change blacklist to quirklist in ecode.c file

Yu Kuai (1):
      ARM: socfpga: PM: add missing put_device() call in
socfpga_setup_ocram_self_refresh()

yu kuai (1):
      ARM: at91: pm: add missing put_device() call in at91_pm_sram_init()

 MAINTAINERS                                        |  3 +
 arch/arm/mach-at91/Makefile.boot                   |  2 +-
 arch/arm/mach-at91/pm.c                            | 11 ++-
 arch/arm/mach-davinci/Kconfig                      |  4 +-
 arch/arm/mach-davinci/board-da830-evm.c            |  2 +-
 arch/arm/mach-davinci/board-da850-evm.c            |  2 +-
 arch/arm/mach-davinci/board-dm646x-evm.c           | 13 ++--
 arch/arm/mach-davinci/board-mityomapl138.c         |  2 +-
 arch/arm/mach-davinci/board-neuros-osd2.c          |  2 +-
 arch/arm/mach-davinci/board-omapl138-hawk.c        |  2 +-
 arch/arm/mach-davinci/cpuidle.c                    |  2 +-
 arch/arm/mach-davinci/cpuidle.h                    |  2 +-
 arch/arm/mach-davinci/da850.c                      |  2 +-
 arch/arm/mach-davinci/da8xx-dt.c                   |  2 +-
 arch/arm/mach-davinci/include/mach/pm.h            |  2 +-
 arch/arm/mach-davinci/pm.c                         |  2 +-
 arch/arm/mach-davinci/sleep.S                      |  2 +-
 arch/arm/mach-exynos/exynos.c                      |  2 +-
 arch/arm/mach-exynos/mcpm-exynos.c                 | 10 ++-
 arch/arm/mach-omap1/Kconfig                        |  2 +-
 arch/arm/mach-omap1/dma.c                          |  2 +-
 arch/arm/mach-omap1/gpio15xx.c                     |  2 +-
 arch/arm/mach-omap1/gpio16xx.c                     |  2 +-
 arch/arm/mach-omap1/gpio7xx.c                      |  2 +-
 arch/arm/mach-omap1/timer.c                        |  2 +-
 arch/arm/mach-rpc/ecard.c                          | 18 ++---
 arch/arm/mach-s3c24xx/Kconfig                      |  2 +-
 arch/arm/mach-s3c24xx/common-smdk.c                | 67 ++++++++++++------
 arch/arm/mach-s3c24xx/mach-h1940.c                 |  2 +-
 arch/arm/mach-s3c24xx/mach-mini2440.c              | 65 +++++++++++++++---
 arch/arm/mach-s3c24xx/mach-n30.c                   | 56 +++++++++++++--
 arch/arm/mach-s3c24xx/mach-qt2410.c                | 12 +++-
 arch/arm/mach-s3c24xx/mach-rx3715.c                |  2 +-
 arch/arm/mach-s3c24xx/mach-vr1000.c                | 38 ++++++++++-
 arch/arm/mach-socfpga/pm.c                         |  8 ++-
 arch/arm/plat-omap/dma.c                           |  2 +-
 arch/arm/plat-orion/gpio.c                         |  8 +--
 drivers/leds/leds-s3c24xx.c                        | 36 ++--------
 drivers/usb/gadget/udc/lpc32xx_udc.c               |  4 +-
 include/linux/platform_data/leds-s3c24xx.h         |  6 --
 47 files changed, 365 insertions(+), 142 deletions(-)
