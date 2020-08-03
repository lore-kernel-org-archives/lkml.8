Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE29C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 937DA207FC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbgHCVgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 17:36:35 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:32893 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgHCVgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 17:36:35 -0400
Received: from mail-qk1-f172.google.com ([209.85.222.172]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MV6G0-1kDGUh2NPC-00S89y for <linux-kernel@vger.kernel.org>; Mon, 03 Aug
 2020 23:36:33 +0200
Received: by mail-qk1-f172.google.com with SMTP id b14so34894305qkn.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 14:36:33 -0700 (PDT)
X-Gm-Message-State: AOAM5331Odkw1aWVIitvJNjyUkcrXoyZmzXnj1GCZXfI/66N26MVf8SP
        3r/vhhiAgFtPAw7mAOgX+BNWX0MbHYXrjgyFXV0=
X-Google-Smtp-Source: ABdhPJwwQzHRTgG+FJpA6sFno1jB8t626xp9An63ocmks4a0IgTGS0AaeC1ZasdOqb4o/OfIU5J5fBcFbgsZ0EBw8P8=
X-Received: by 2002:a37:9004:: with SMTP id s4mr18010613qkd.286.1596490592445;
 Mon, 03 Aug 2020 14:36:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a1vFJ+uUGPGifZGhECXvxA=2u745WrGNZb08s1nHkZQ9g@mail.gmail.com>
In-Reply-To: <CAK8P3a1vFJ+uUGPGifZGhECXvxA=2u745WrGNZb08s1nHkZQ9g@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 3 Aug 2020 23:36:16 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2o1ZkxPvua9_s5W2YiHzNxzV59zb1sHjjRqrpteotw2Q@mail.gmail.com>
Message-ID: <CAK8P3a2o1ZkxPvua9_s5W2YiHzNxzV59zb1sHjjRqrpteotw2Q@mail.gmail.com>
Subject: [GIT PULL 1/5] ARM: defconfig updates for v5.9
To:     Linus Torvalds <torvalds@linux-foundation.org>
List-Id: <soc.lore.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:wD2fks2qGe+5jDBLC8wO0p761lZTlqsHH8scHh7pu/Bm8863OfQ
 X0mbUbuOfMb/piDBbF3WWjQsmd84C8YKeG+oAnzYavpf6tlHvjUkOKypHwgdG78DJmJb3Yw
 rjoFdWK2J9gcLCFFEgINhGpkcvmMzKKUcpaympGZigeIGmp/EKTmEvK0DEfp8rlg2WainUt
 0ZL1wOZdLDOu4qVSaf/8w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:h/xTUhgmz+8=:rKGFhqs7Ji4hrPpM2t/LU1
 OyKhN8rSN4g9qri5CNTDSUMr26+FB+n+qOMc16wvhU3EOyrlo4WL6i7nuyy569pWyQ6vMWR7D
 qi7XY+cALmnX64cctkIp0+LfeQHNFC2Jlus2+2y5ZPgTJp9BwdD/Y3DVMm8YDA+5ON2GSNW4v
 6aT2x/vpUfCNE/VUHnMF3qElHjfxz6BGx8SRlXlqv8P5W5veJ2nTaTKWxy4BoBtEGpLwB1YAX
 SeR3OMLq/RQT5Tj7FqfJhsNQel6K7JFGGcq5crJEKs8G4VGivgMabAEytOZ2261p/hMrm6VhG
 Cy6zngYwNe3mNY3Db1fgzJJIbBM0TiQVcsQsULRwKY36pXH03OCSU1aR//6FQ8mfz9rYOL/eA
 zbnyCK/mncBFGt/XyWx4KnG+YeZu/KUi+oZd1+hcFcCFTZl4PE5HoSbXBesr0n66bTiAa8f4/
 +Vsrh8VUhAJx1/6S4njaov8SDNWh0y4NNc2Fx/eVC3+Mj2jDo4TnKos04na+ynqb0eWoFaSR5
 chUqt9YmpvUptxaWnBmf1DiFCsMSQD3HH0H4W2TMkYb6MdPyCjDxv6Y7deHPwYo+kmAT6WD15
 pZKTWaw6vm+/Zp1U6x5q7dmoMKFbqdyUyf1dJ1MDp5yFZpMz1mHwq/xc1y4zdW8KcywZQ073y
 kF+N+2EPuA0d4ErkGSDo10NCs1zAKX+VDdlp6E4LiCIw+/irq90HQ51PfOQPB48RzdFID4T1j
 ZKgNcSPCm13q3CHcKu7PGibdO1DvRYhs2C/XNBFEYNJPcd6sF3mGH81hLwHFglGfXlK0rSHzO
 BJxNvqs7F9YQP9+vvQ+6nfvqFGd2sStxqNOHDzltkvQoxmcE3mj/kXdEruEGbFNLSTR8cvCIY
 HJSZg4et2K3zlSBrgCBq4WY+Qg+4JbQfai8NQn+06eiTWsKlNFqtYC0h1FAbYW975mj7sWOhH
 wE24o5LuHcU9kbL5JtWCC0KuRkjrNswSUCCvmamImqCHWR9ytd6pc
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 48778464bb7d346b47157d21ffde2af6b2d39110:

  Linux 5.8-rc2 (2020-06-21 15:45:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git
tags/arm-defconfig-5.9

for you to fetch changes up to 66d3037898efc84ee241f593ffba244591bca328:

  Merge tag 'at91-defconfig-5.9' of
git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux into
arm/defconfig (2020-07-27 14:35:28 +0200)

----------------------------------------------------------------
ARM: defconfig updates for 5.9

These are the usual updates to arm/arm64 defconfig files,
enabling newly added drivers and addressing changes to Kconfig
files.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

----------------------------------------------------------------
Arnd Bergmann (7):
      Merge tag 'renesas-arm-defconfig-for-v5.9-tag1' of
git://git.kernel.org/.../geert/renesas-devel into arm/defconfig
      Merge tag 'tegra-for-5.9-arm-defconfig' of
git://git.kernel.org/.../tegra/linux into arm/defconfig
      Merge tag 'sunxi-config-for-5.9-1' of
git://git.kernel.org/.../sunxi/linux into arm/defconfig
      Merge tag 'qcom-arm64-defconfig-for-5.9' of
git://git.kernel.org/.../qcom/linux into arm/defconfig
      Merge tag 'imx-defconfig-5.9' of
git://git.kernel.org/.../shawnguo/linux into arm/defconfig
      Merge tag 'ti-k3-config-for-v5.9' of
git://git.kernel.org/.../kristo/linux into arm/defconfig
      Merge tag 'at91-defconfig-5.9' of
git://git.kernel.org/.../at91/linux into arm/defconfig

Bjorn Andersson (2):
      arm64: defconfig: Enable Qualcomm SM8250 pinctrl driver
      arm64: defconfig: Enable Qualcomm IPCC driver

Codrin Ciubotariu (1):
      ARM: configs: at91: sama5: Enable CLASSD

Cristian Birsan (1):
      ARM: configs: at91: sama5: enable CAN PLATFORM driver

Dmitry Osipenko (1):
      ARM: tegra_defconfig: Enable options useful for Nexus 7 and Acer A500

Enric Balletbo i Serra (1):
      arm/arm64: defconfig: Update configs to use the new CROS_EC options

Faiz Abbas (1):
      arm64: defconfig: Enable AM654x SDHCI controller

Geert Uytterhoeven (9):
      ARM: shmobile: defconfig: Refresh for v5.8-rc1
      ARM: shmobile: defconfig: Enable DA9063 ONKEY support
      ARM: shmobile: defconfig: Enable CAT9554 support
      ARM: shmobile: defconfig: Enable RZ/A watchdog support
      ARM: shmobile: defconfig: Enable RZ/A1 CEU support
      ARM: shmobile: defconfig: Enable ADV7612 CEC support
      ARM: shmobile: defconfig: Enable RZ/A1H RTC support
      ARM: multi_v7_defconfig: Enable additional support for Renesas platforms
      arm64: defconfig: Enable additional support for Renesas platforms

Georgi Djakov (1):
      arm64: defconfig: Enable the PM8xxx RTC driver

Grygorii Strashko (1):
      arm64: arch_k3: enable chipid driver

Jeffrey Hugo (1):
      arm64: defconfig: Add CONFIG_QCOM_RPMPD

Jon Hunter (1):
      ARM: tegra: Enable CPUFREQ userspace governor

Maxime Ripard (10):
      ARM: configs: sunxi: Run savedefconfig
      ARM: configs: sunxi: Enable the CSI drivers
      ARM: configs: sunxi: Enable the deinterlace and rotation engines
      ARM: configs: sunxi: Enable Cedrus
      ARM: configs: sunxi: Enable ASoC options
      ARM: configs: sunxi: Add DRM output-related options
      ARM: configs: sunxi: Enable Lima
      ARM: configs: sunxi: Enable the PS/2 controller
      ARM: sunxi: configs: Enable the Mailbox driver
      ARM: configs: sunxi: Enable crypto related options

Michael Walle (3):
      arm64: defconfig: enable RTC and audio support on Kontron sl28 boards
      arm64: defconfig: enable TSN features for ENETC and similiar hardware
      arm64: defconfig: enable CONFIG_FSL_ENETC_QOS

Peng Fan (1):
      ARM: imx_v6_v7_defconfig: Support i.MX8MM

Razvan Stefanescu (2):
      ARM: configs: at91: sama5: add support for KSZ ethernet switches
      ARM: configs: at91: sama5: enable bridge and VLAN filtering

Robin Gong (1):
      arm64: defconfig: add pca9450 pmic driver

Stanimir Varbanov (1):
      arm64: defconfig: Enable SDM845 video clock controller

 arch/arm/configs/exynos_defconfig    |  4 ++-
 arch/arm/configs/imx_v6_v7_defconfig |  3 +++
 arch/arm/configs/multi_v7_defconfig  | 11 ++++++++-
 arch/arm/configs/pxa_defconfig       |  4 ++-
 arch/arm/configs/sama5_defconfig     |  8 ++++++
 arch/arm/configs/shmobile_defconfig  | 13 ++++++----
 arch/arm/configs/sunxi_defconfig     | 48 +++++++++++++++++++++++++-----------
 arch/arm/configs/tegra_defconfig     | 45 ++++++++++++++++++++++++++++++++-
 arch/arm64/Kconfig.platforms         |  1 +
 arch/arm64/configs/defconfig         | 33 ++++++++++++++++++++++++-
 10 files changed, 145 insertions(+), 25 deletions(-)
