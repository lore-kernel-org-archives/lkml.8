Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63422C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 22:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4372D207BC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 22:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbgE2WYd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 18:24:33 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:35299 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgE2WYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 18:24:32 -0400
Received: from mail-qt1-f174.google.com ([209.85.160.174]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1M4rD7-1jgAjh3kQR-001vZF for <linux-kernel@vger.kernel.org>; Sat, 30 May
 2020 00:24:31 +0200
Received: by mail-qt1-f174.google.com with SMTP id i68so3307283qtb.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 15:24:30 -0700 (PDT)
X-Gm-Message-State: AOAM5332bxJrKdJlYvS7b7BquprbdLcJ5S5TPRo+k+G+edUSsMYMT8pA
        /kmO9RMFs5eqlu+pNLy3E7z86rTIBaVAkz/p/ZU=
X-Google-Smtp-Source: ABdhPJwcqeLLq3HaogVaSrvkE13vUIHWcmlBjBXWDRJMpwek2o/j8rzzevrqzfUrSzmsQZ4anE5t0eLoAMz/Vg9oI0A=
X-Received: by 2002:ac8:1844:: with SMTP id n4mr11016879qtk.142.1590791069803;
 Fri, 29 May 2020 15:24:29 -0700 (PDT)
MIME-Version: 1.0
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 30 May 2020 00:24:13 +0200
X-Gmail-Original-Message-ID: <CAK8P3a05i=j3xh6bGti+-pkQWFid5=Em_NCprz1J9Jp9TDmTeQ@mail.gmail.com>
Message-ID: <CAK8P3a05i=j3xh6bGti+-pkQWFid5=Em_NCprz1J9Jp9TDmTeQ@mail.gmail.com>
Subject: [GIT PULL] ARM: SoC fixes for v5.7
To:     Linus Torvalds <torvalds@linux-foundation.org>
List-Id: <soc.lore.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Tony Lindgren <tony@atomide.com>,
        Lubomir Rintel <lkundrak@v3.sk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:e/hoyP+h+U/MDqYvq6LctoazTbZjm/R1X2Rlys3lLdSyE24QnUe
 LJQw4JXFdXya2epu7i3kHesD0an1WjAyqC5+pglu/V04kIxPDs8Em3OvbcoILiXI524mL1E
 ylf82t58wPmS7hhEZVYN+/SmSsucVWSkc52epZamV4VmnfC5lHFLjfnFBur4WHSPLihx6FY
 a6ht0v6OEWg7QcHbkIB6g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nDhWS8WLJ7k=:Rq8HizHNp0GWqRSLSEDVg0
 hEzK1LVZrYyzoxXWyKf+mXVnkpWNa9sHat1OioLWLWr4QTnGRbEBVc+n/1wn2JM5tBHZWbcIz
 cFChdMzgIdyyeE0PyYKoeYb7DTrbc9BoX2dXOJ3N5j0J2j4bjfb31ixdsAztyGsTMa5/KaDiI
 5n3UpxYdOZ7z2Z9g9Rm28WDTi5i6AWJBGAx/NxZYMiMLI6v5n62jyIi36fhzIJuHFo2K9MUOc
 BzfZo11vHZvxT4VsPIdPzT3T/8G76F/EvQT25rw+Flez6fBi6rnc3FmhTpn96QBvCzBD5uZbA
 Jm3ed2yGHqtnLzaU+arh7SdFi3KHqpJbk4XzlgxTZACmnP+vWq2vEbgWPoyIw0wiyyK1UZ4mq
 jGDmQYoIZ69AikWOaSzLSdz5XJu3LHJGo1VTblbQCg+4Qq6evTfju04sOfNcb232VBDrto1G6
 UzpU7aEg1A9zxryu7xtB18FcgD+euKHJMf2OP+0yPZrxUueiS3fNjqBGeIowLZUSOW2X0Bvq2
 WhDp8XvEZZ9sQ5ZPGaHuOJx8HYuOBsrTsWmGDJx/89WUjkeVcmKLK7Ozj/TD9K90AwGMbdp5z
 rHbzAdsxH2augZVd0BGS870rmJi8LfqOi4j2I6rJAbLrHz1OqMkY9zK+PigWKcvLZuJzQx1T8
 PNoB1P/ixOB9NwO4ZUKhIKy6crhzCvDBncLoRyhlT2x6YwAePlxifjZ3bE4Z1bB299/84oWtL
 5gRf9+/x40FHWQzxk7HLiStW9LKSR3TsweUVYXzJ6MLKgBplngZuMOwpYBU5kQ/wiy8Era8Kq
 qu1az1Li5bLmuMOtrW0BAV5Ia4X0mqLYAydUvItTxeeNKo/IQA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit b9bbe6ed63b2b9f2c9ee5cbd0f2c946a2723f4ce:

  Linux 5.7-rc6 (2020-05-17 16:48:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git
tags/armsoc-fixes-v5.7

for you to fetch changes up to 99706d62fb50486eadb4441eaed311491fd7addf:

  Merge tag 'omap-for-v5.7/cpsw-fixes-signed' of
git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into
arm/fixes (2020-05-26 00:18:48 +0200)

----------------------------------------------------------------
ARM: SoC fixes for v5.7

This time there is one fix for the error path in the mediatek cmdq driver
(used by their video driver) and a couple of devicetree fixes, mostly
for 32-bit ARM, and fairly harmless:

- On OMAP2 there were a few regressions in the ethernet drivers,
  one of them leading to an external abort trap

- One Raspberry Pi version had a misconfigured LED

- Interrupts on Broadcom NSP were slightly misconfigured

- One i.MX6q board had issues with graphics mode setting

- On mmp3 there are some minor fixes that were submitted for
  v5.8 with a cc:stable tag, so I ended up picking them up
  here as well

- The Mediatek Video Codec needs to run at a higher frequency
  than configured originally

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

----------------------------------------------------------------
Arnd Bergmann (5):
      Merge branch 'mmp/fixes' into arm/fixes
      Merge tag 'imx-fixes-5.7-2' of
git://git.kernel.org/.../shawnguo/linux into arm/fixes
      Merge branch 'v5.7-fixes' of
git://git.kernel.org/.../matthias.bgg/linux into arm/fixes
      Merge tag 'arm-soc/for-5.7/devicetree-fixes-part2-v2' of
https://github.com/Broadcom/stblinux into arm/fixes
      Merge tag 'omap-for-v5.7/cpsw-fixes-signed' of
git://git.kernel.org/.../tmlind/linux-omap into arm/fixes

Dennis YC Hsieh (1):
      soc: mediatek: cmdq: return send msg error code

Grygorii Strashko (2):
      ARM: dts: am57xx: fix networking on boards with ksz9031 phy
      ARM: dts: am437x: fix networking on boards with ksz9031 phy

Hamish Martin (1):
      ARM: dts: bcm: HR2: Fix PPI interrupt types

Hsin-Yi Wang (1):
      arm64: dts: mt8173: fix vcodec-enc clock

Lubomir Rintel (3):
      ARM: dts: mmp3: Use the MMP3 compatible string for /clocks
      ARM: dts: mmp3-dell-ariel: Fix the SPI devices
      ARM: dts: mmp3: Drop usb-nop-xceiv from HSIC phy

Robert Beckett (1):
      ARM: dts/imx6q-bx50v3: Set display interface clock parents

Tony Lindgren (1):
      ARM: dts: Fix wrong mdio clock for dm814x

Vincent Stehlé (1):
      ARM: dts: bcm2835-rpi-zero-w: Fix led polarity

 arch/arm/boot/dts/am437x-gp-evm.dts             |  2 +-
 arch/arm/boot/dts/am437x-idk-evm.dts            |  2 +-
 arch/arm/boot/dts/am437x-sk-evm.dts             |  4 ++--
 arch/arm/boot/dts/am571x-idk.dts                |  4 ++--
 arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi |  4 ++--
 arch/arm/boot/dts/am57xx-idk-common.dtsi        |  4 ++--
 arch/arm/boot/dts/bcm-hr2.dtsi                  |  6 +++---
 arch/arm/boot/dts/bcm2835-rpi-zero-w.dts        |  2 +-
 arch/arm/boot/dts/dm814x.dtsi                   |  2 +-
 arch/arm/boot/dts/imx6q-b450v3.dts              |  7 -------
 arch/arm/boot/dts/imx6q-b650v3.dts              |  7 -------
 arch/arm/boot/dts/imx6q-b850v3.dts              | 11 -----------
 arch/arm/boot/dts/imx6q-bx50v3.dtsi             | 15 +++++++++++++++
 arch/arm/boot/dts/mmp3-dell-ariel.dts           | 12 ++++++------
 arch/arm/boot/dts/mmp3.dtsi                     |  8 +++-----
 arch/arm64/boot/dts/mediatek/mt8173.dtsi        |  4 ++--
 drivers/soc/mediatek/mtk-cmdq-helper.c          |  4 +++-
 17 files changed, 44 insertions(+), 54 deletions(-)
