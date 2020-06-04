Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E33C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 20:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B19D207DA
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 20:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730174AbgFDUxI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 16:53:08 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:44427 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729582AbgFDUxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 16:53:08 -0400
Received: from mail-qk1-f169.google.com ([209.85.222.169]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MgNQd-1j2dA63ljL-00hzF2 for <linux-kernel@vger.kernel.org>; Thu, 04 Jun
 2020 22:53:06 +0200
Received: by mail-qk1-f169.google.com with SMTP id c12so7603094qkk.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 13:53:05 -0700 (PDT)
X-Gm-Message-State: AOAM532StBK2Zm2lxUafuw0Or7wn0yW2UAcenUR77dVnjoQmtMJ0c3vT
        kbadJAiYZv86XYJGv49sMeGEtTvSongAMzo441k=
X-Google-Smtp-Source: ABdhPJy9mySEfI214b3QlcUolR5aSGBJjDXuFIeTg8w9XbQTBnPWmFr4ZBlPmiKARgoHMDdZrjOglvnUHnm5EIRXWaA=
X-Received: by 2002:a37:9401:: with SMTP id w1mr6637118qkd.286.1591303984809;
 Thu, 04 Jun 2020 13:53:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a1dmaiYR5Oxkc0CQcxTm=rAHSx6R+xtf4Wup29JqXNZsA@mail.gmail.com>
 <CAK8P3a00L4n3b=X+PQXe1pxf9CHryZTes9L1MD5i2+0RLXprfw@mail.gmail.com>
In-Reply-To: <CAK8P3a00L4n3b=X+PQXe1pxf9CHryZTes9L1MD5i2+0RLXprfw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 4 Jun 2020 22:52:48 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3w4euZfDQPt7wqWg9w4uf7SM4NLeA2CyOMmgNGPAdQaQ@mail.gmail.com>
Message-ID: <CAK8P3a3w4euZfDQPt7wqWg9w4uf7SM4NLeA2CyOMmgNGPAdQaQ@mail.gmail.com>
Subject: [GIT PULL 2/4]ARM: defconfig updates for v5.8
List-Id: <soc.lore.kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:y8hdVlZ5Ra+bG7cGkxpSmSgZmj7qlicBB5KKg4r9SVb82XkMrm6
 NfnokiTHg+JiPVkwnpKapy6aLc3GRhD702aocE9f0UCLNdKa1jcqELgFo+F7u8SRFOxrlyL
 UuGigqH6XtyylaNtgVZoMPao7qoxLG6y3C1pWI1l8oo00wzYXFY13oJhKiWbNi2SqgmeJJ6
 kdQVf1ks4iUR5vgXujXmA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qhhqGsizZ08=:2NQV08164NvE26zB7Pkpg/
 d2BgCssWuRvMSIjuOsUoK3akYOkboLRSYWRT4xxQS20Rjw8Yn3cr1F7isoQ4rrawCUKUM3C2N
 qQBUpAUhQcnht9CAJBpCyBm966TvCA1pwG2OYwznL7nIxpKEyibfyKmqP6I1Yvxt7YdN5SfEE
 71HY7ywwddH/jBUD7lmZ7CzumRVxFlcSEO2CdXsbnZElam/1tZMHBgZS3JFl6q4QEFWsNklYK
 IiHua3cO7ZXQkE5QQP4RrlKmCp+x4JAc/mTZQXiYEq1egC36EW/9r4xB+0d/93Q4GYkpHpljx
 7O/fxiXjd3Lo/ARH7A1uXaBFW8uuDotQpjg5WLteLc/w+I2ICETsBd/bM4P1AXHFSn5hfk9gV
 7n0VFYOcD4kuEKTW9GkrlTrMJRcVW4Os7hiV3DNJWKZdjJdtFYkwtltii3HuT4F322WJ6Mh7e
 qC5eHvDvhKzkWUnZRPTZTw+9CTcz0pssVeanZPPPVguDfwDkSuqW1q/2ZHxmhT4pMyb3co+WY
 jcYuLO0q1fL8MipXiQhQaxYNQiE+bFOEdQoTq/7nQaBbid0GuTIArG7ShrueyqBrjpiAj6B5R
 7UZYwdzYYkO0lY7bPjgRXG2v0MgWQy1fxISZXNkN7wS5bNSrdbZoP2CtcrIMV3CSLdokDfFvk
 aba1Pr9o3qV1RJh5CApjntFzYBRg16dIu8M3X+bZYkclRF/ggN5AYqmaBY8pKrlqponLcXtS/
 WKN4EVtjlFtm++U67XuosX+B7QcPpuEpnAdwI7hfqifY9c4Qm/SSaAvyzS6ulnF2r+MhK8SRd
 ME7KcsxUxM0xgAxLjJ6UB7qciSMeAr/kn4z2IpMpYXSZzmH0zE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit b9bbe6ed63b2b9f2c9ee5cbd0f2c946a2723f4ce:

  Linux 5.7-rc6 (2020-05-17 16:48:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git
tags/arm-defconfig-5.8

for you to fetch changes up to f11d7cb47f157b6af61cea8e4c571c8f81d670b4:

  Merge tag 'imx-defconfig-5.8' of
git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into
arm/defconfig (2020-05-26 00:17:12 +0200)

----------------------------------------------------------------
ARM: defconfig updates for v5.8

These are the usual updates to arm/arm64 defconfig files,
enabling newly added drivers and addressing changes to Kconfig
files.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

----------------------------------------------------------------
Alex Elder (1):
      arm64: defconfig: enable Qualcomm IPA and RMNet modules

Andreas Kemnade (1):
      ARM: imx_v6_v7_defconfig: extend RN5T618 PMIC family support

Anson Huang (1):
      arm64: defconfig: Enable CONFIG_PINCTRL_IMX8DXL by default

Arnd Bergmann (12):
      Merge tag 'ux500-defconfig-v5.7' of
git://git.kernel.org/.../linusw/linux-stericsson into arm/defconfig
      Merge tag 'renesas-arm-defconfig-for-v5.8-tag1' of
git://git.kernel.org/.../geert/renesas-devel into arm/defconfig
      Merge tag 'arm-soc/for-5.8/defconfig' of
https://github.com/Broadcom/stblinux into arm/defconfig
      Merge tag 'samsung-defconfig-5.8' of
git://git.kernel.org/.../krzk/linux into arm/defconfig
      Merge tag 'renesas-arm-defconfig-for-v5.8-tag2' of
git://git.kernel.org/.../geert/renesas-devel into arm/defconfig
      Merge tag 'sunxi-config-for-5.8-1' of
git://git.kernel.org/.../sunxi/linux into arm/defconfig
      Merge tag 'at91-5.8-defconfig' of
git://git.kernel.org/.../at91/linux into arm/defconfig
      Merge tag 'qcom-arm64-defconfig-for-5.8' of
git://git.kernel.org/.../qcom/linux into arm/defconfig
      Merge tag 'amlogic-defconfig' of
git://git.kernel.org/.../khilman/linux-amlogic into arm/defconfig
      Merge tag 'hisi-arm64-defconfig-for-5.8' of
git://github.com/hisilicon/linux-hisi into arm/defconfig
      Merge tag 'arm64_defconfig_for_v5.8' of
git://git.kernel.org/.../dinguyen/linux into arm/defconfig
      Merge tag 'imx-defconfig-5.8' of
git://git.kernel.org/.../shawnguo/linux into arm/defconfig

Bjorn Andersson (2):
      arm64: defconfig: Remove QCOM_GLINK_SSR
      arm64: defconfig: Enable Qualcomm SC7180 pinctrl and gcc

Clément Péron (1):
      arm64: configs: Enable sun50i cpufreq nvmem

Corentin Labbe (1):
      ARM: configs: sunxi: Add sun8i analog codec

Dinh Nguyen (1):
      arm64: defconfig: Add LEDS_TRIGGER_TIMER

Florian Fainelli (1):
      Merge tag 'tags/bcm2835-defconfig-next-2020-03-27' into defconfig/next

Geert Uytterhoeven (1):
      ARM: shmobile: defconfig: Refresh for v5.7-rc1

Jerome Brunet (1):
      arm64: defconfig: enable meson gx audio as module

Lad Prabhakar (2):
      ARM: shmobile: defconfig: Enable r8a7742 SoC
      ARM: multi_v7_defconfig: Enable r8a7742 SoC

Linus Walleij (1):
      ARM: defconfig: u8500: Enable new drivers for ux500

Marek Szyprowski (2):
      ARM: exynos_defconfig: Enable serial bus and BCM HCIUART drivers
      ARM: exynos_defconfig: Compile MAC80211/CFG80211 as modules

Nicolas Saenz Julienne (1):
      ARM: bcm2835_defconfig: Enable fixed-regulator

Razvan Stefanescu (2):
      ARM: configs: at91: sama5: enable SAMA5D2_PIOBU
      ARM: configs: at91: sama5: enable MCP16502 regulator

Robert Foss (1):
      arm64: defconfig: Enable Qualcomm CAMCC, CAMSS and CCI drivers

Stephan Gerhold (1):
      ARM: defconfig: u8500: Enable new drivers for samsung-golden

Vinod Koul (1):
      arm64: defconfig: Enable SM8250 GCC driver

Zhou Wang (1):
      arm64: defconfig: Enable UACCE/PCI PASID/SEC2/HPRE configs

 arch/arm/configs/bcm2835_defconfig   |  1 +
 arch/arm/configs/exynos_defconfig    |  8 +++++---
 arch/arm/configs/imx_v6_v7_defconfig |  2 ++
 arch/arm/configs/multi_v7_defconfig  |  1 +
 arch/arm/configs/sama5_defconfig     |  2 ++
 arch/arm/configs/shmobile_defconfig  |  2 ++
 arch/arm/configs/sunxi_defconfig     |  1 +
 arch/arm/configs/u8500_defconfig     | 14 ++++++++++++++
 arch/arm64/configs/defconfig         | 18 +++++++++++++++++-
 9 files changed, 45 insertions(+), 4 deletions(-)
