Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FE6C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 08:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49B12207ED
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 08:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgEQIyl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 04:54:41 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:34473 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbgEQIyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 04:54:40 -0400
Received: from mail-qt1-f180.google.com ([209.85.160.180]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1Mjjzx-1jCgUh0tid-00lGop for <linux-kernel@vger.kernel.org>; Sun, 17 May
 2020 10:54:36 +0200
Received: by mail-qt1-f180.google.com with SMTP id n22so3249793qtv.12
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 01:54:36 -0700 (PDT)
X-Gm-Message-State: AOAM533yiCOru9bKmEdXNgjn7IBVtNaOc72a44oO3CGAUc2LTpFvWHNE
        +/E2cUOqbBlOKwrPtF3WTd5dbfIYSbABQvLJ9fU=
X-Google-Smtp-Source: ABdhPJymVuawcceMEnHFnHBO2m4tu2gT4iqVrjbsiF1BtH82Tj45RD7vlGhpNyz19km6fv7c2pcNO23JI2qLwxeH9BA=
X-Received: by 2002:aed:2441:: with SMTP id s1mr11288265qtc.304.1589705674937;
 Sun, 17 May 2020 01:54:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a1L6R+tomzXsdhXY3vfctS+2t9sD4+uDmJShUX98W=hKg@mail.gmail.com>
In-Reply-To: <CAK8P3a1L6R+tomzXsdhXY3vfctS+2t9sD4+uDmJShUX98W=hKg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 17 May 2020 10:54:18 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3AHbHrGdTLbodRpn2qfOzY7D175cTCaTDPwfPfn10MHQ@mail.gmail.com>
Message-ID: <CAK8P3a3AHbHrGdTLbodRpn2qfOzY7D175cTCaTDPwfPfn10MHQ@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: SoC/DT fixes for v5.7
To:     Linus Torvalds <torvalds@linux-foundation.org>
List-Id: <soc.lore.kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Heiko Stuebner <mmind@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Thierry Reding <treding@nvidia.com>,
        Chen-Yu Tsai <wens@csie.org>, SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:XrO/+Mx1R0sY2ZYWUCbj5+pGWSpmRD6+wHHW881/XXZw9c1JXk0
 0bZt7JZk4tDD27bJ/L34Ta26yufVNstCHIRG0Vho3mQYRXTLEggYl8vWY7RtRHnZoNDzGuw
 SDDSnI7/Q0vhD88f0ngI8gJ0ikoGBYATOq+Yta59R/asWsXgWBDsef7XhO30qAjGLyQTtV7
 vztlUED9K134Wq5XCIIUA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:074cQt2+HjU=:xiYv/YmyGjmNOYTN2TiyF9
 Di9l09+qli+8E3FgD4tby6XOnWiICr7MoUd/wmKt22P1oaQozsEWuL/qKJ/WLCiM8Kp8/4tM3
 o6r0X5qfW8yA23HsgH7JJHXrqpM3qx3ntBbnwvVF4kZbfjxTz21FMZrRErh0z+sTeSKp8AOdQ
 cVtPBokjr8Xr9+/JZ91XBrz7W02c5Iz2eIoNz6uBIq00yYTwSYaTI5rlFPBRMzXbs9I9paQYK
 LHgPkK7jE35x41keqiN6rHnDqY7y9DyurnzU+vgLWLuxnxFerm0FsJzOk6arInRnh7lnjhJsl
 LgQxZ/cgFceSGFooJZFCRQ30XzBBWd36URSIFMKZbeX0CkdPLT53U8P1dWJgpBxN7p11/QkVe
 sIkn1R+EY4wvCJbDoZ76dcWCFVBQE+028vZLf4ceKfDYlwRgjcWoqPTJA/Ux/YQ9scMf6Mp9Y
 YdssMJ9YneyL2J+fZbFtPytEdxbCVyBR/hoaP6PBHB9Zy6qXm16sQzQgyQW0jGD78Nj82b+yV
 FQjCA86CQ7nlTOjPz5kvrNHdTTXQ/EEprPEgIgnZ7q4NTI1F0Ze1W/GeDZjs2UwhGaHXhlats
 TFlQqZ8viWzMPm3cTrAgO/88jYjeFEihDq54hK5OkSU9Sze56ni7oWotjU55Fgpseoxj2CNBA
 bJh1x0xsNCgaIzkywVX/8b4QT1ubR9NSmnGmm2HzWjMBjGylUx1zABf5XSX3xspx8dutg3o9m
 KWVlLOTWZyyF7i9KyrQEK5dpA4cvRPDCCtCqT16mPnHhMPNq5MtuLwawgkGMr8+MVoSqgwLIN
 mR4sBXg6aU9EnRf9c4aycnPdpbyrx6YCppDmg1utdfmSSs/ygI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus pointed out I missed the usual Cc to the mailing lists. It's
already merged,
but for reference here is the pull request I sent.

       Arnd

On Fri, May 15, 2020 at 11:59 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> The following changes since commit 0e698dfa282211e414076f9dc7e83c1c288314fd:
>
>   Linux 5.7-rc4 (2020-05-03 14:56:04 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git
> tags/arm-soc-fixes-5.7
>
> for you to fetch changes up to d5fef88ccbd3a2d3674e6cc868804a519ef9e5b6:
>
>   Merge tag 'renesas-fixes-for-v5.7-tag2' of
> git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel into
> arm/fixes (2020-05-15 23:14:36 +0200)
>
> ----------------------------------------------------------------
> ARM: SoC/dt fixes for v5.7
>
> This round of fixes is almost exclusively device tree changes,
> with trivial defconfig fixes and one compiler warning fix
> added in.
>
> A number of patches are to fix dtc warnings, in particular on
> Amlogic, i.MX and Rockchips.
>
> Other notable changes include:
>
> Renesas:
>  - Fix a wrong clock configuration on R-Mobile A1,
>  - Fix IOMMU support on R-Car V3H
>
> Allwinner
>  - Multiple audio fixes
>
> Qualcomm
>  - Use a safe CPU voltage on MSM8996
>  - Fixes to match a late audio driver change
>
> Rockchip:
>  - Some fixes for the newly added Pinebook Pro
>
> NXP i.MX:
>  - Fix I2C1 pinctrl configuration for i.MX27 phytec-phycard board.
>  - Fix imx6dl-yapp4-ursa board Ethernet connection.
>
> OMAP:
>  - A regression fix for non-existing can device on am534x-idk
>  - Fix flakey wlan on droid4 where some devices would not connect
>    at all because of internal pull being used with an external pull
>  - Fix occasional missed wake-up events on droid4 modem uart
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> ----------------------------------------------------------------
> Adam Ford (1):
>       arm64: dts: imx8mn: Change SDMA1 ahb clock for imx8mn
>
> Ahmad Fatoum (1):
>       ARM: imx: provide v7_cpu_resume() only on ARM_CPU_SUSPEND=y
>
> Arnd Bergmann (10):
>       Merge tag 'qcom-arm64-fixes-for-5.7' of
> git://git.kernel.org/.../qcom/linux into arm/fixes
>       Merge tag 'imx-fixes-5.7' of
> git://git.kernel.org/.../shawnguo/linux into arm/fixes
>       Merge tag 'renesas-fixes-for-v5.7-tag1' of
> git://git.kernel.org/.../geert/renesas-devel into arm/fixes
>       Merge tag 'tegra-for-5.7-arm64-defconfig-fixes' of
> git://git.kernel.org/.../tegra/linux into arm/fixes
>       Merge tag 'v5.7-rockchip-dtsfixes1' of
> git://git.kernel.org/.../mmind/linux-rockchip into arm/fixes
>       Merge tag 'omap-for-v5.6/fixes-rc4' of
> git://git.kernel.org/.../tmlind/linux-omap into arm/fixes
>       Merge tag 'amlogic-fixes' of
> git://git.kernel.org/.../khilman/linux-amlogic into arm/fixes
>       Merge tag 'arm-soc-fixes-for-5.7' of
> git://git.kernel.org/.../narmstrong/linux-oxnas into arm/fixes
>       Merge tag 'sunxi-fixes-for-5.7-1' of
> git://git.kernel.org/.../sunxi/linux into arm/fixes
>       Merge tag 'renesas-fixes-for-v5.7-tag2' of
> git://git.kernel.org/.../geert/renesas-devel into arm/fixes
>
> Bjorn Andersson (1):
>       arm64: dts: qcom: msm8996: Reduce vdd_apc voltage
>
> Chen-Yu Tsai (5):
>       arm64: dts: rockchip: Replace RK805 PMIC node name with "pmic"
> on rk3328 boards
>       arm64: dts: rockchip: drop non-existent gmac2phy pinmux options
> from rk3328
>       arm64: dts: rockchip: drop #address-cells, #size-cells from
> rk3328 grf node
>       arm64: dts: rockchip: drop #address-cells, #size-cells from
> rk3399 pmugrf node
>       arm64: dts: rockchip: Rename dwc3 device nodes on rk3399 to make dtc happy
>
> Fabio Estevam (2):
>       ARM: dts: imx27-phytec-phycard-s-rdk: Fix the I2C1 pinctrl entries
>       arm64: dts: imx8m: Fix AIPS reg properties
>
> Faiz Abbas (1):
>       ARM: dts: am574x-idk: Disable m_can node
>
> Geert Uytterhoeven (3):
>       ARM: dts: r8a73a4: Add missing CMT1 interrupts
>       ARM: dts: r7s9210: Remove bogus clock-names from OSTM nodes
>       ARM: dts: r8a7740: Add missing extal2 to CPG node
>
> Johan Jonker (7):
>       ARM: dts: rockchip: fix phy nodename for rk3228-evb
>       ARM: dts: rockchip: fix phy nodename for rk3229-xms6
>       arm64: dts: rockchip: remove extra assigned-clocks property from
> &gmac2phy node in rk3328-evb.dts
>       arm64: dts: rockchip: fix status for &gmac2phy in rk3328-evb.dts
>       arm64: dts: rockchip: swap interrupts interrupt-names rk3399 gpu node
>       ARM: dts: rockchip: swap clock-names of gpu nodes
>       ARM: dts: rockchip: fix pinctrl sub nodename for spi in rk322x.dtsi
>
> Jon Hunter (1):
>       arm64: defconfig: Re-enable Tegra PCIe host driver
>
> Kishon Vijay Abraham I (1):
>       ARM: dts: dra7: Fix bus_dma_limit for PCIe
>
> Ma Feng (1):
>       ARM: oxnas: make ox820_boot_secondary static
>
> Max Krummenacher (4):
>       arm64: defconfig: DRM_DUMB_VGA_DAC: follow changed config symbol name
>       arm64: defconfig: add DRM_DISPLAY_CONNECTOR
>       arm64: defconfig: ARCH_R8A7795: follow changed config symbol name
>       arm64: defconfig: add MEDIA_PLATFORM_SUPPORT
>
> Michael Walle (2):
>       dt-bindings: dma: fsl-edma: fix ls1028a-edma compatible
>       arm64: dts: ls1028a: add "fsl,vf610-edma" compatible
>
> Michal Vokáč (1):
>       ARM: dts: imx6dl-yapp4: Fix Ursa board Ethernet connection
>
> Neil Armstrong (4):
>       arm64: dts: meson-g12b-ugoos-am6: fix usb vbus-supply
>       arm64: dts: meson-g12-common: fix dwc2 clock names
>       arm64: dts: meson-g12b-khadas-vim3: add missing frddr_a status property
>       arm64: dts: meson-g12: remove spurious blank line
>
> Ricardo Cañuelo (3):
>       arm64: dts: renesas: Make hdmi encoder nodes compliant with DT bindings
>       ARM: dts: renesas: Make hdmi encoder nodes compliant with DT bindings
>       ARM: dts: iwg20d-q7-dbcm-ca: Remove unneeded properties in hdmi@39
>
> Robin Murphy (2):
>       arm64: dts: rockchip: Correct PMU compatibles for PX30 and RK3308
>       arm64: dts: rockchip: Fix Pinebook Pro FUSB302 interrupt
>
> Samuel Holland (2):
>       arm64: dts: allwinner: a64: pinetab: Fix cpvdd supply name
>       arm64: dts: allwinner: a64: Remove unused SPDIF sound card
>
> Shengjiu Wang (1):
>       arm64: dts: freescale: imx8mp: update input_val for AUDIOMIX_BIT_STREAM
>
> Srinivas Kandagatla (3):
>       arm64: qcom: c630: fix asm dai setup
>       arm64: dts: qcom: db845c: fix asm dai setup
>       arm64: dts: qcom: db820c: fix audio configuration
>
> Tobias Schramm (2):
>       arm64: dts: rockchip: fix inverted headphone detection on Pinebook Pro
>       arm64: dts: rockchip: enable DC charger detection pullup on Pinebook Pro
>
> Tony Lindgren (3):
>       Merge branch 'fixes-v5.7' into fixes
>       ARM: dts: omap4-droid4: Fix flakey wlan by disabling internal
> pull for gpio
>       ARM: dts: omap4-droid4: Fix occasional lost wakeirq for uart1
>
> Yoshihiro Shimoda (1):
>       arm64: dts: renesas: r8a77980: Fix IPMMU VIP[01] nodes
>
>  Documentation/devicetree/bindings/dma/fsl-edma.txt |  3 +-
>  arch/arm/boot/dts/am574x-idk.dts                   |  4 ++
>  arch/arm/boot/dts/dra7.dtsi                        |  4 +-
>  arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts   |  4 +-
>  arch/arm/boot/dts/imx6dl-yapp4-ursa.dts            |  2 +-
>  arch/arm/boot/dts/iwg20d-q7-dbcm-ca.dtsi           |  2 -
>  arch/arm/boot/dts/motorola-mapphone-common.dtsi    | 43 ++++++++++++++++++--
>  arch/arm/boot/dts/r7s9210.dtsi                     |  3 --
>  arch/arm/boot/dts/r8a73a4.dtsi                     |  9 ++++-
>  arch/arm/boot/dts/r8a7740.dtsi                     |  2 +-
>  .../arm/boot/dts/r8a7745-iwg22d-sodimm-dbhd-ca.dts |  2 -
>  arch/arm/boot/dts/r8a7790-lager.dts                |  2 -
>  arch/arm/boot/dts/r8a7790-stout.dts                |  2 -
>  arch/arm/boot/dts/r8a7791-koelsch.dts              |  2 -
>  arch/arm/boot/dts/r8a7791-porter.dts               |  2 -
>  arch/arm/boot/dts/r8a7792-blanche.dts              |  2 -
>  arch/arm/boot/dts/r8a7792-wheat.dts                | 12 ++----
>  arch/arm/boot/dts/r8a7793-gose.dts                 |  2 -
>  arch/arm/boot/dts/r8a7794-silk.dts                 |  2 -
>  arch/arm/boot/dts/rk3036.dtsi                      |  2 +-
>  arch/arm/boot/dts/rk3228-evb.dts                   |  2 +-
>  arch/arm/boot/dts/rk3229-xms6.dts                  |  2 +-
>  arch/arm/boot/dts/rk322x.dtsi                      |  6 +--
>  arch/arm/boot/dts/rk3xxx.dtsi                      |  2 +-
>  arch/arm/mach-oxnas/platsmp.c                      |  3 +-
>  .../boot/dts/allwinner/sun50i-a64-pinetab.dts      |  2 +-
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      | 18 ---------
>  arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi  |  2 +-
>  arch/arm64/boot/dts/amlogic/meson-g12.dtsi         |  1 -
>  .../boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi   |  4 ++
>  .../boot/dts/amlogic/meson-g12b-ugoos-am6.dts      |  2 +-
>  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi     |  2 +-
>  arch/arm64/boot/dts/freescale/imx8mm.dtsi          |  8 ++--
>  arch/arm64/boot/dts/freescale/imx8mn.dtsi          | 10 ++---
>  arch/arm64/boot/dts/freescale/imx8mp-pinfunc.h     | 46 +++++++++++-----------
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi          |  6 +--
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi          |  8 ++--
>  arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi       | 23 +++++++++--
>  arch/arm64/boot/dts/qcom/msm8996.dtsi              |  2 +
>  arch/arm64/boot/dts/qcom/sdm845-db845c.dts         |  3 --
>  .../boot/dts/qcom/sdm850-lenovo-yoga-c630.dts      |  2 -
>  arch/arm64/boot/dts/renesas/r8a77970-eagle.dts     |  2 -
>  arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts     |  2 -
>  arch/arm64/boot/dts/renesas/r8a77980-condor.dts    |  2 -
>  arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts     |  2 -
>  arch/arm64/boot/dts/renesas/r8a77980.dtsi          |  2 +
>  arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts     |  2 -
>  arch/arm64/boot/dts/renesas/r8a77995-draak.dts     |  6 +--
>  arch/arm64/boot/dts/rockchip/px30.dtsi             |  2 +-
>  arch/arm64/boot/dts/rockchip/rk3308.dtsi           |  2 +-
>  arch/arm64/boot/dts/rockchip/rk3328-evb.dts        |  5 +--
>  arch/arm64/boot/dts/rockchip/rk3328-rock64.dts     |  2 +-
>  arch/arm64/boot/dts/rockchip/rk3328.dtsi           | 18 ---------
>  .../boot/dts/rockchip/rk3399-pinebook-pro.dts      |  9 +++--
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi           | 14 +++----
>  arch/arm64/configs/defconfig                       |  9 +++--
>  56 files changed, 168 insertions(+), 171 deletions(-)
