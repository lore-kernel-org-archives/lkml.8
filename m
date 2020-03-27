Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A399EC2D0EE
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 20:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D2FA2074A
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 20:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgC0UeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 16:34:12 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:57845 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727423AbgC0UeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 16:34:11 -0400
Received: from mail-qt1-f181.google.com ([209.85.160.181]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MQeDw-1iuEOl0bmY-00Nmcc for <linux-kernel@vger.kernel.org>; Fri, 27 Mar
 2020 21:34:09 +0100
Received: by mail-qt1-f181.google.com with SMTP id x16so9753226qts.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 13:34:08 -0700 (PDT)
X-Gm-Message-State: ANhLgQ2d2BoA7HczeuggqAMhgVERWikPuS2m1J8pgYNYug7OrZX1U1Fm
        1xLpsseHaHNPq8pKhLzoSF4fEJ5VmSVfRJyLesw=
X-Google-Smtp-Source: ADFU+vv7Rw+/QBCn1L8d+JbTZ0HVXHcl8cGk4kzuGTmkzWF+Fc1hPyRqtOULGDAlVLQhnOGCFzblSsaMWefekU12lmI=
X-Received: by 2002:ac8:45ce:: with SMTP id e14mr1123406qto.304.1585341247948;
 Fri, 27 Mar 2020 13:34:07 -0700 (PDT)
MIME-Version: 1.0
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 27 Mar 2020 21:33:51 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1j=uNUWvb7Req3H88FmUH4GNA6RcD3Zderrj-UstfiWA@mail.gmail.com>
Message-ID: <CAK8P3a1j=uNUWvb7Req3H88FmUH4GNA6RcD3Zderrj-UstfiWA@mail.gmail.com>
Subject: [GIT PULL] ARM: DT and driver fixes for v5.6
To:     Linus Torvalds <torvalds@linux-foundation.org>
List-Id: <soc.lore.kernel.org>
Cc:     Tony Lindgren <tony@atomide.com>, Chen-Yu Tsai <wens@csie.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        SoC Team <soc@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:awCM7tAnTs7s0fBLXz7mw0XZ0Y/sCP/7HhFXtMhiWol9oP8C/OI
 ZO9v/8lrydRVKs7/QNe6Y8WB3XaVH+ardCykEfEpZ2omKB7qZfIcL+Seq1Lh479a67qOcfL
 a2La+1uPLj/OpL7wO8JsgatwW+5R9HLcKGhbpelBPgOB0Fy6wsO3JqCm/1ErB0iI+eI6w6z
 TlOipaZTBXmR+IDdMRF3Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PyscuORpOpE=:XIW3XMrSACc6zYsR0RzxOW
 3VPkF3euQ0UtIydnNamDTd9gNm0u73TLxg+5XL4pUPaHqdoi06ynjhHPSjXqJ5EJCnqP/yNkJ
 +9NOR2nF0b2OWeBnShhihgBTU+0Cik/8h6uAZ8ENH1VlJUM8qDd/+EU2/GQ0b0UIEiQLGGhla
 mIT6vxf9PHVR9wVDbcGvP1qqUzxT+FEMormTpdZMq/vyfAIqLZL0PC27MTfQtZvCey/8RID2w
 LSMDTousRElskqyH7wdluhlW039BbUD8i2qkZIvBY5tdpt5FtadhFCdORgh3rWonF9NjpJdft
 BbTT35srxonJ/4Ox+cXRoCMzVEeuGgiIyYRwJgFoThlJzaPr9mG+IlnCKMx6qe0CiRWf962A3
 rdgOLJQJxlX0gL+rVlyHkY2gKs5Jf96dSIPrfAS3tMYdK53SVwMSqXzYBRrIa+LsAM0PiqCEY
 0ONdR8lwunOjqmvkA7fBgLR1PN99CVf6OcflId+e3pTtl9VI92tGsbhrToSViyKjWaeUSvOZz
 8ZdFUvUT5sg7u9CaQd/2muKn/XN8rfmydARz4QNInZl/XMGFPHZmZPlTdHSIeOEToObwcSPTQ
 zqVeTjm+ybqXpiLXD0VDe/n9QmdRPFwj9hV10eelcwcKdxARXipO+eLZnXdLlH9EqFgHgWKmF
 GUxtOmCqg5tygWtYr1RQUl35/wpwyIQ8irfbqLytMYEBKMGoQ56tDM+KN2knSR3knNFwAbIEd
 SlBp7l80i3Q9yuqt/az5x7t6w0PkttvmvszCdfsjsWVvaN8tO2yAqYCAzY/s77dOTMhn7bZjf
 zJavZp5IGJnNC001eamGbvjbi3q7NRsksZz3DRYnBN99zZkEQ8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 2c523b344dfa65a3738e7039832044aa133c75fb:

  Linux 5.6-rc5 (2020-03-08 17:44:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git
tags/arm-soc-fixes-5.6

for you to fetch changes up to c8042d1e5cb3e654b47447229ace3cd092a8fc27:

  soc: samsung: chipid: Fix return value on non-Exynos platforms
(2020-03-25 14:27:27 +0100)

----------------------------------------------------------------
ARM: DT and driver fixes for v5.6

For the devicetree files, there are a total of 20 patches, almost
entirely for 32-bit machines:

- The Allwinner/sun9i r40 SoC dtsi file contains a number of issues,
  both for correctness and for style that are addressed in separate
  patches. This causes most of the changed lines of the DT updates
  this time.

- More Allwinner updates fixing the identification of the security
  system on sun8i/A33, a recent regression of the A83t ethernet, and a
  few board specific issues on the TBS-A711 macine.

- Several bug fixes for OMAP dts files, most notably fixing the timings
  for the NAND flash on the Nokia N900 that regressed a while ago after
  the move to configuring them from DT.  Some other OMAPs now set the
  correct dma limits on the L3 bus, and a regression fix addresses lost
  Ethernet on dm814x

- One incorrect setting in the newly added Raspberry Pi Zero W that
  may cause issues with the SD card controller.

- A missing property on the bcm2835 firmware node caused incorrect
  DMA settings.

- An old bug on the oxnas platform causing spurious interrupts is
  finally addressed.

- A regression on the Exynos Midas board broke the OLED panel
  power supply.

- The i.MX6 phycore SoM specified the wrong voltage for the SoC,
  this is now set to the values from the datasheet.

- Some 64-bit machines use a deprecated string to identify the PSCI
  firmware.

There are also several small code fixes addressing mostly serious
issues:

- Fix the sunxi rsb bus access to no longer return incorrect data when
  mixing 8 and 16 bit I/O.

- Fix a suspend/resume regression on the OMAP2+ lcdc from a missing
  quirk in the ti-sysc driver

- Fix a NULL pointer access from a race in the fsl dpio driver

- Fix a v5.5 regression in the exynos-chipid driver that caused an
  invalid error code probing the device on non-exynos platforms

- Fix an out-of-bounds access in the AMD TEE driver

----------------------------------------------------------------
Arnd Bergmann (8):
      Merge tag 'soc-fsl-fix-v5.6' of
git://git.kernel.org/.../leo/linux into arm/fixes
      Merge tag 'sunxi-fixes-for-5.6' of
git://git.kernel.org/.../sunxi/linux into arm/fixes
      Merge tag 'sunxi-fixes-for-5.6-2' of
git://git.kernel.org/.../sunxi/linux into arm/fixes
      Merge tag 'imx-fixes-5.6-2' of
git://git.kernel.org/.../shawnguo/linux into arm/fixes
      Merge tag 'omap-for-v5.6/fixes-rc6-signed' of
git://git.kernel.org/.../tmlind/linux-omap into arm/fixes
      Merge tag 'arm-soc/for-5.6/devicetree-fixes-part2' of
https://github.com/Broadcom/stblinux into arm/fixes
      Merge tag 'oxnas-arm-soc-dt-fixes-for-5.6' of
git://git.kernel.org/.../narmstrong/linux-oxnas into arm/fixes
      Merge tag 'tee-amdtee-fix2-for-5.6' of
https://git.linaro.org/people/jens.wiklander/linux-tee into arm/fixes

Arthur Demchenkov (1):
      ARM: dts: N900: fix onenand timings

Chen-Yu Tsai (4):
      ARM: dts: sun8i: a83t: Fix incorrect clk and reset macros for EMAC device
      ARM: dts: sun8i: r40: Move AHCI device node based on address order
      ARM: dts: sun8i: r40: Fix register base address for SPI2 and SPI3
      ARM: dts: sun8i: r40: Move SPI device nodes based on address order

Corentin Labbe (2):
      dt-bindings: crypto: add new compatible for A33 SS
      ARM: dts: sun8i: a33: add the new SS compatible

Dan Carpenter (1):
      tee: amdtee: out of bounds read in find_session()

Grigore Popescu (1):
      soc: fsl: dpio: register dpio irq handlers after dpio create

Linus Walleij (1):
      arm64: dts: Fix leftover entry-methods for PSCI

Marco Felsch (1):
      ARM: dts: imx6: phycore-som: fix arm and soc minimum voltage

Marek Szyprowski (2):
      ARM: dts: exynos: Fix regulator node aliasing on Midas-based boards
      soc: samsung: chipid: Fix return value on non-Exynos platforms

Nick Hudson (1):
      ARM: bcm2835-rpi-zero-w: Add missing pinctrl name

Nicolas Saenz Julienne (1):
      ARM: dts: bcm283x: Fix vc4's firmware bus DMA limitations

Ondrej Jirman (3):
      ARM: dts: sun8i-a83t-tbs-a711: HM5065 doesn't like such a high voltage
      ARM: dts: sun8i-a83t-tbs-a711: Fix USB OTG mode detection
      bus: sunxi-rsb: Return correct data when mixing 16-bit and 8-bit reads

Roger Quadros (2):
      ARM: dts: dra7: Add bus_dma_limit for L3 bus
      ARM: dts: omap5: Add bus_dma_limit for L3 bus

Sungbo Eo (1):
      ARM: dts: oxnas: Fix clear-mask property

Tony Lindgren (6):
      Merge branch 'omap-for-v5.6/fixes-rc2' into fixes
      Merge branch 'omap-for-v5.6/fixes-rc3' into fixes
      ARM: dts: Fix dm814x Ethernet by changing to use rgmii-id mode
      bus: ti-sysc: Fix quirk flags for lcdc on am335x
      Merge branch 'fix-lcdc-quirk' into fixes
      ARM: dts: omap4-droid4: Fix lost touchscreen interrupts

 .../crypto/allwinner,sun4i-a10-crypto.yaml         |   2 +
 arch/arm/boot/dts/bcm2835-rpi-zero-w.dts           |   1 +
 arch/arm/boot/dts/bcm2835-rpi.dtsi                 |   1 +
 arch/arm/boot/dts/dm8148-evm.dts                   |   4 +-
 arch/arm/boot/dts/dm8148-t410.dts                  |   4 +-
 arch/arm/boot/dts/dra62x-j5eco-evm.dts             |   4 +-
 arch/arm/boot/dts/dra7.dtsi                        |   1 +
 arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi        |   4 +-
 arch/arm/boot/dts/exynos4412-n710x.dts             |   2 +-
 arch/arm/boot/dts/imx6qdl-phytec-phycore-som.dtsi  |   4 +-
 arch/arm/boot/dts/motorola-mapphone-common.dtsi    |   2 +-
 arch/arm/boot/dts/omap3-n900.dts                   |  44 +++++---
 arch/arm/boot/dts/omap5.dtsi                       |   1 +
 arch/arm/boot/dts/ox810se.dtsi                     |   4 +-
 arch/arm/boot/dts/ox820.dtsi                       |   4 +-
 arch/arm/boot/dts/sun8i-a33.dtsi                   |   2 +-
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts          |   7 +-
 arch/arm/boot/dts/sun8i-a83t.dtsi                  |   6 +-
 arch/arm/boot/dts/sun8i-r40.dtsi                   | 125 ++++++++++-----------
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi     |   2 +-
 arch/arm64/boot/dts/sprd/sc9863a.dtsi              |   2 +-
 drivers/bus/sunxi-rsb.c                            |   2 +-
 drivers/bus/ti-sysc.c                              |   3 +-
 drivers/soc/fsl/dpio/dpio-driver.c                 |   8 +-
 drivers/soc/samsung/exynos-chipid.c                |   2 +-
 drivers/tee/amdtee/core.c                          |   3 +
 26 files changed, 133 insertions(+), 111 deletions(-)
