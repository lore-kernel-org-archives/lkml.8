Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591CAC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 21:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2755F206F6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 21:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbgDCVgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 17:36:42 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:39399 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbgDCVgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 17:36:41 -0400
Received: from mail-qv1-f46.google.com ([209.85.219.46]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1M4roN-1jIYa00sHH-002127 for <linux-kernel@vger.kernel.org>; Fri, 03 Apr
 2020 23:36:39 +0200
Received: by mail-qv1-f46.google.com with SMTP id bu9so4358936qvb.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 14:36:39 -0700 (PDT)
X-Gm-Message-State: AGi0PuZ+Urta0dcDhs3LvwLsLHeanN+uZlnokQhXHEoYezW0ZdqtFkhZ
        RrHkhvDWYOpFLxkap7Y198NFgWv/wzaq31oTiQY=
X-Google-Smtp-Source: APiQypJEJiFIbTi8fSzKFamqwrtiYtCRm/bgKdSwRNs8rNj5LPKegO4X8kEdGXNllyWPyp+7ypgNrf68jhQ+n80NIxI=
X-Received: by 2002:a0c:a602:: with SMTP id s2mr10712987qva.222.1585949798093;
 Fri, 03 Apr 2020 14:36:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a1aO+LUu6KsW+s8aZMNWt2yz7kqe=LARY=ifMKOqT9uNQ@mail.gmail.com>
In-Reply-To: <CAK8P3a1aO+LUu6KsW+s8aZMNWt2yz7kqe=LARY=ifMKOqT9uNQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 3 Apr 2020 23:36:22 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3OPgCzLxzd=7Ng=jregKB0HycLLrfA4xYd7-4Te-kHMA@mail.gmail.com>
Message-ID: <CAK8P3a3OPgCzLxzd=7Ng=jregKB0HycLLrfA4xYd7-4Te-kHMA@mail.gmail.com>
Subject: [GIT PULL 3/4] ARM: defconfig updates
To:     Linus Torvalds <torvalds@linux-foundation.org>
List-Id: <soc.lore.kernel.org>
Cc:     SoC Team <soc@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:8icLj8t8jTUkl+TzexUne7PvqkkhFt1ofgIcyBp6Zap3lj4FvB9
 lfiMfmqagt7LcMfNmXhvp4jVe7vH+iaZXxs0mGNCpDl7UwzcumXKKvY5idY66NDyuV4gyD8
 OZvAkDGZSddf4cB7IIB5TdAI1h637eweOl5Y11DEzSWM4hE+E1ixsaWjuG92HJ/PpdWZddU
 sllqXIv2R0EchTnjixGJA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OvWnUPge1RE=:Hy10OzuKPlsrc1VpRLlfeN
 gYPxoEhxC2JGZuhH3qWRTJlgw6VrzGjKE2eg9zUEuJtt9xeRhFhJXJWh2YKh+NpkI4wea2P9T
 ZmrgdJ3PxrROyTnQnCXhQV1gYzDcHPUji4dTgArTy5xwwfgB00gLACKgos6GZ3rRagSnBW5id
 gd/rIx1L+sVaBiaNgMMPOxrLhJ6m/eF2BZWaX1HcYc0Ow5u8yTFCbAtek+5miccscfvlddzx4
 Y/bZ9jIxrKojAwz2qdNgTp5Mnj5/XdSTbrhHJkW2lCi5i8NpN8MEgMtNBQl6xbm4SqJfRjm62
 prtW1mcGOpJIeLagZehKXBriwFq75/Zr2OmDnUMPrtuNC/g1G5snoe2QZdbNeuWmmvN2jKVpD
 LDFo7psmTJomEUJp000FUT3GAwMGc/IoOfEILbgcOtcJjH0jM3JPe16O9Frs2P0hXby/pzJ3S
 hpCDhUUK+vycbK5kbJBnPRZN5ZpT8w5970YSYjsWcRwKogqx+L7kkOLLwpzB1JV7C1FZAoX+A
 xBsse9oQWOrt+8c60CpKLV7M+cIyZ5s2PxLkebd0Smiv+26HRROYO/xFokC76r2EUh3mvOJes
 II7kVOBqrnB8pBjEGRzjdJnsuhXefyisf7qPoapdepDssZ5Cwu5ebPxUYnxD5TIQxB01xT9yX
 VXcvb8P+g95e9YVFcKFPnzgf6imgOmtRDUKG20uR7H8W8XURp0oKpQtuKC1ELbnUcCuysvSsm
 P4G6KV5+BuDwh51OTDL+NwDOE0BQy7ieCRzTh8wCzHssEIyAz0aLdopMIeVebMpGJ/3TEzxyJ
 VACAVD03ciOOfwndKhuLZ8qebtGcyI+aK01P+MueXOczKKdDgw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 98d54f81e36ba3bf92172791eba5ca5bd813989b:

  Linux 5.6-rc4 (2020-03-01 16:38:46 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git
tags/arm-defconfig-5.7

for you to fetch changes up to a0705d3c042ad39fb9c5609612bb39ef4bedd284:

  Merge tag 'at91-5.7-defconfig' of
git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux into
arm/config (2020-03-25 17:22:53 +0100)

----------------------------------------------------------------
ARM: defconfig updates

As usual, tons of new drivers and other options got merged and
are now enabled in the defconfig files, usually as loadable modules.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

----------------------------------------------------------------
Anson Huang (3):
      arm64: defconfig: Select CONFIG_PINCTRL_IMX8MP by default
      arm64: defconfig: add i.MX system controller thermal support
      arm64: defconfig: Enable CONFIG_IMX8MM_THERMAL as module

Arnd Bergmann (10):
      Merge tag 'renesas-arm64-defconfig-for-v5.7-tag1' of
git://git.kernel.org/.../geert/renesas-devel into arm/config
      Merge tag 'hisi-arm64-defconfig-for-5.7' of
git://github.com/hisilicon/linux-hisi into arm/config
      Merge tag 'arm-soc/for-5.7/defconfig' of
https://github.com/Broadcom/stblinux into arm/config
      Merge tag 'tegra-for-5.7-arm-defconfig' of
git://git.kernel.org/.../tegra/linux into arm/config
      Merge tag 'samsung-defconfig-5.7' of
git://git.kernel.org/.../krzk/linux into arm/config
      Merge tag 'qcom-arm64-defconfig-for-5.7' of
git://git.kernel.org/.../qcom/linux into arm/config
      Merge tag 'qcom-defconfig-for-5.7' of
git://git.kernel.org/.../qcom/linux into arm/config
      Merge tag 'imx-defconfig-5.7' of
git://git.kernel.org/.../shawnguo/linux into arm/config
      Merge tag 'omap-for-v5.7/defconfig-signed' of
git://git.kernel.org/.../tmlind/linux-omap into arm/config
      Merge tag 'at91-5.7-defconfig' of
git://git.kernel.org/.../at91/linux into arm/config

Bjorn Andersson (3):
      arm64: defconfig: Enable Qualcomm SDM845 display and gpu clocks
      arm64: defconfig: Enable Truly NT35597 WQXGA panel
      arm64: defconfig: Enable Qualcomm SDM845 audio configs

Brian Masney (1):
      ARM: qcom_defconfig: add Broadcom bluetooth options

Christian Gmeiner (1):
      ARM: multi_v7_defconfig: enable drm imx support

Dmitry Osipenko (2):
      ARM: multi_v7_defconfig: Enable Tegra cpuidle driver
      ARM: tegra: Enable Tegra cpuidle driver in tegra_defconfig

Eugen Hristev (1):
      ARM: configs: at91: enable sama5d4 compatible watchdog

Florian Fainelli (1):
      Merge tag 'tags/bcm2835-defconfig-next-2020-03-09' into defconfig/next

Geert Uytterhoeven (1):
      arm64: defconfig: Enable additional support for Renesas platforms

Hou Zhiqiang (1):
      arm64: defconfig: Enable CONFIG_PCIE_LAYERSCAPE_GEN4

John Garry (1):
      arm64: defconfig: Enable MEGARAID_SAS

Li Yang (15):
      arm64: defconfig: run through savedefconfig for ordering
      arm64: defconfig: Enable NXP flexcan driver
      arm64: defconfig: Enable QorIQ DPAA1 drivers
      arm64: defconfig: Enable QorIQ DPAA2 drivers
      arm64: defconfig: Enable ENETC Ethernet controller and FELIX switch
      arm64: defconfig: Enable NXP/FSL SPI controller drivers
      arm64: defconfig: Enable QorIQ cpufreq driver
      arm64: defconfig: Enable ARM SBSA watchdog driver
      arm64: defconfig: Enable QorIQ IFC NAND controller driver
      arm64: defconfig: Enable QorIQ GPIO driver
      arm64: defconfig: Enable ARM Mali display driver
      arm64: defconfig: Enable flash device drivers for QorIQ boards
      arm64: defconfig: Enable RTC devices for QorIQ boards
      arm64: defconfig: Enable PHY devices used on QorIQ boards
      arm64: defconfig: Enable e1000 device

Luca Weiss (1):
      ARM: qcom_defconfig: Enable QRTR

Lukasz Luba (1):
      ARM: exynos_defconfig: Enable SCHED_MC and ENERGY_MODEL

Marek Szyprowski (3):
      ARM: exynos_defconfig: Enable SquashFS and increase RAM block device size
      ARM: exynos_defconfig: Add more drivers for GalaxyS3/Trats2
      ARM: bcm2835_defconfig: add support for Raspberry Pi4

Oleksandr Suvorov (2):
      ARM: imx_v6_v7_defconfig: Enable TOUCHSCREEN_ATMEL_MXT
      ARM: imx_v6_v7_defconfig: Enable TOUCHSCREEN_AD7879

Sricharan R (1):
      arm64: defconfig: Enable qcom ipq6018 clock and pinctrl

Stephan Gerhold (1):
      arm64: defconfig: Enable Qualcomm PM8XXX vibrator support

Tony Lindgren (7):
      ARM: omap2plus_defconfig: Enable ext4 security for setcap
      ARM: omap2plus_defconfig: Enable simple-pm-bus
      ARM: omap2plus_defconfig: Enable zram as loadable modules
      ARM: omap2plus_defconfig: Enable more droid4 devices as loadable modules
      ARM: omap2plus_defconfig: Enable McPDM optional PMIC clock as modules
      ARM: omap2plus_defconfig: Enable ina2xx_adc as a loadable module
      ARM: omap2plus_defconfig: Update for moved and dropped options

 arch/arm/configs/at91_dt_defconfig   |   1 +
 arch/arm/configs/bcm2835_defconfig   |   5 ++
 arch/arm/configs/exynos_defconfig    |  11 +++-
 arch/arm/configs/imx_v6_v7_defconfig |   3 ++
 arch/arm/configs/multi_v7_defconfig  |   7 +++
 arch/arm/configs/omap2plus_defconfig |  18 +++++--
 arch/arm/configs/qcom_defconfig      |   6 +++
 arch/arm/configs/tegra_defconfig     |   1 +
 arch/arm64/configs/defconfig         | 100 +++++++++++++++++++++++++++++++----
 9 files changed, 136 insertions(+), 16 deletions(-)
