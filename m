Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA76C2BA16
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 10:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6333206F5
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 10:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbgDDKEG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 06:04:06 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:53815 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgDDKEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 06:04:06 -0400
Received: from mail-qt1-f170.google.com ([209.85.160.170]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MWzXd-1jnU1O0JXl-00XOBQ for <linux-kernel@vger.kernel.org>; Sat, 04 Apr
 2020 12:03:59 +0200
Received: by mail-qt1-f170.google.com with SMTP id e14so8702928qts.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Apr 2020 03:03:58 -0700 (PDT)
X-Gm-Message-State: AGi0PuaWqzwdBUhCNMPTbs+RVfKTGnzu8Wqb4HioWMRGrXrks086xgHU
        jLrTCd9IfuF9Wlgl+cE1c2bvysD8QC9ysofVwnU=
X-Google-Smtp-Source: APiQypLo5ndiRECozXHsQ4tJqyn77XuNyITpYkO+gHgFDJX6jBaR+2koqEPb3RCoXKNKQfSOhvsjrTNtl0CBOBPZzyE=
X-Received: by 2002:aed:20e3:: with SMTP id 90mr12064805qtb.142.1585994637159;
 Sat, 04 Apr 2020 03:03:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a1aO+LUu6KsW+s8aZMNWt2yz7kqe=LARY=ifMKOqT9uNQ@mail.gmail.com>
 <CAK8P3a3iGtudeWTwufBYYM29jL5b_FRkqzU2QZiQRu0B2NhyZg@mail.gmail.com> <CAHk-=wiZHmvCmXmGNQmmwDOYXLqpg3X=-LLRZ=Yq9p6V3pSEig@mail.gmail.com>
In-Reply-To: <CAHk-=wiZHmvCmXmGNQmmwDOYXLqpg3X=-LLRZ=Yq9p6V3pSEig@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 4 Apr 2020 12:03:40 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2ZDvUxrZfiqk7dkZ_ZitvEBmaeyjBL5ZYD+nSUz0WNgA@mail.gmail.com>
Message-ID: <CAK8P3a2ZDvUxrZfiqk7dkZ_ZitvEBmaeyjBL5ZYD+nSUz0WNgA@mail.gmail.com>
Subject: Re: [GIT PULL 4/4] ARM: devicetree updates
To:     Linus Torvalds <torvalds@linux-foundation.org>
List-Id: <soc.lore.kernel.org>
Cc:     SoC Team <soc@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:ZaonQhe+ck07F6WcCWSHIKEFK/edkvEAKd+oNBP/0OR9/n90NOU
 n24OmkvhJha/FL1EOILzv97u4zwDnpWuar6C5qWVx/IAi8iKYNd2LvLcII1SiOQoDeyEaC5
 JI7xl1Rgast86CU4pUTgIz0VdGs6C4tv63PttGu+hr4rGDIM0hA0L0TqC4OWs9P/6u3Knpo
 cYWbrsjtrz/7WaVLGw/4g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8wgDwkQqDgA=:SlqEGR6TNT2kw/WeAdkO7x
 XjQFHhlD7YH9XkyRze0aZEApgeEQ7bDpghDqdYx85B3VnyMyvlryYfk9YEIjESqOFo1mJC7us
 Jz0u8hBNmcccLD1Oy2JiLRtGbf9xWuso4WrZqBvit3V+FP57wSJ0dum/nPgR46Byk8XBmiBo8
 qyNRjMWcxy6vXdb14OCmS2t0uWwhbxxzt8c/kA/4ZNQAC+T2WnNwrwD4Y112bR1FwuM7gb5u7
 ZMb227GKhyrXThQknDRjLE5hX2Br0ezZFHUWkzKyAfV1IRJnaJ363CcXCfDcUhfysreoeTgDw
 pfbY+6V4HDsYkgK4onKJyIZ+abLzlS7U8+Gint6QsxgVH3Ukcp6/blS95UsMQH5N5k7Ir1IlD
 umJkPdl0bKSxtyMQduetMmOZfwIfbTbdcNSXKXvAUDAn9VFoEJja48xTGsjCRB91LFOWmz3tU
 mQtzwSYvjNtEyHq/MYwW9AmvBT8HuWPL1mr1/cc2nkwe8Lu1xgFy+JyKB2cWkJQXkuJNpXVow
 SYm4ElgPZUKgaQGBzumvf9/3LbWzfcLUZLQDfSbGgacOjzMeUz2oKV2fSgx+6B59QZZ8wqsbh
 DynkaDxV7VIev2BGaV9GTFaixbjGU77bC3cNRpt7ZwtEx1MQsEx1d73G3FPs1gpTcyemjeJjU
 kX/Z2iL8QQtgWN0vBn+502lBBlaCMW5knD6AjMcUU3Y0/Go6FvBCCN+bFdpahNqcsSQxuVhPR
 m3ujN/tZV9Xm36Ph3Oi8q4uYomwCgahvR9PjsDCGtw7Cy14YL8ejlIzZQHq3NXx446ioiJOYo
 z5eEtUdG7ftomdyV0HcxrDjvEPClC8qsMSewexzamDNux+eghU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 4, 2020 at 12:28 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Apr 3, 2020 at 2:46 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > To spare you the 80kb of git-request-pull output, here is a very
> > abbreviated version
>
> So you didn't do a test-merge and generate the diffstat from that?
>
> That's just 567 lines and about 35kB, and I get
>
>  488 files changed, 18917 insertions(+), 4522 deletions(-)
>
> Anyway, it didn't cause any conflicts, and looks as expected for a DT
> update, but I generally like to have the ability to compare to what
> the sender thinks I should get..

I think there was some overlap with stuff that previously got merged
through the fixes branch, and some that was already in one of my
other branches. The total that git request-pull showed was

 506 files changed, 20094 insertions(+), 4929 deletions(-)

but most of the output was actually the shortlog, not the diffstat.

I did regenerate the shortlog for the arm-drivers-5.7 pull request, as
one of the downstream branches appears to have contained
a backmerge (I did not check where it came from), but for the dt
branch, the output seemed ok, just really long. Adding it below
for reference.

     Arnd

8<-----
The following changes since commit 98d54f81e36ba3bf92172791eba5ca5bd813989b:

  Linux 5.6-rc4 (2020-03-01 16:38:46 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/arm-dt-5.7

for you to fetch changes up to 8bdbf169084ec00833bff61cda0014b7fbdf15ac:

  Merge branch 'arm/late' into arm/dt (2020-04-03 22:45:37 +0200)

----------------------------------------------------------------
ARM: devicetree updates for v5.7

Most of the commits are for additional hardware support and minor fixes
for existing machines for all the usual platforms: qcom, amlogic, at91,
gemini, mediatek, ti, socfpga, i.mx, layerscape, uniphier, rockchip,
exynos, ux500, mvebu, tegra, stm32, renesas, sunxi, broadcom, omap,
and versatile.

The conversion of binding files to machine-readable yaml format
continues, along with fixes found during the validation.
Andre Przywara takes over maintainership for the old Calxeda Highbank
platform and provides a number of updates.

The OMAP2+ platforms see a continued move from platform data into
dts files, for many devices that relied on a mix of auxiliary data
in addition to the DT description

A moderate number of new SoCs and machines are added, here is a full
list:

- Two new Qualcomm SoCs with their evaluation boards: Snapdragon 865
  (SM8250) is the current high-end phone chip, and IPQ6018 is a new
  WiFi-6 router chip.

- Mediatek MT8516 application processor SoC for voice assistants, along
  with the "pumpkin" development board

- NXP i.MX8M Plus SoC, a variant of the popular i.MX8M, along with an
  evaluation board.

- Kontron "sl28" board family based on NXP LS1028A

- Eleven variations of the new i.MX6 TechNexion Pico board, combining
  the "dwarf", "hobbit", "nymph" and "pi" baseboards with i.MX6/i.MX7
  SoM carriers

- Three additional variants of the Toradex Colibri board family, all
  based on versions of the NXP i.MX7.

- The Pinebook Pro laptop based on Rockchip RK3399

- Samsung S7710 Galaxy Xcover 2, a 2013 vintage Android phone based on
  the ST-Ericsson u8500 platform

- DH Electronics DHCOM SoM and PDK2 rev. 400 carrier based on
  STMicroelectronics stm32mp157

- Renesas M3ULCB starter kit for R-Car M3-W+

- Hoperun HiHope development board with Renesas RZ/G2M

- Pine64 PineTab tablet and PinePhone phone, both based on Allwinner A64

- Linutronix Testbox v2 for the Lamobo R1 router, based on Allwinner A20

- PocketBook Touch Lux 3 ebook reader, based on Allwinner A13

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

----------------------------------------------------------------
Aapo Vienamo (1):
      ARM: mxs: Enable usbphy1 and usb1 on apx4devkit DTS

Adam Ford (1):
      arm64: dts: enable fspi in imx8mm dts

Ahmad Fatoum (1):
      ARM: dts: stm32: add cpu clock-frequency property on stm32mp15x

Alain Volmat (6):
      ARM: dts: stm32: set i2c4 bus freq to 400KHz on stm32mp157c-ed1
      ARM: dts: stm32: set i2c4 bus freq to 400KHz on stm32mp15 DK boards
      ARM: dts: stm32: add i2c4 sleep pinctrl on stm32mp15xx-dkx
      ARM: dts: stm32: add i2c2/i2c5 sleep pinctrl on stm32mp157c-ev1
      ARM: dts: stm32: add i2c4 sleep pinctrl on stm32mp157c-ed1
      ARM: dts: stm32: add wakeup-source in all I2C nodes of stm32mp157c

Alex Elder (1):
      arm64: dts: sdm845: add IPA information

Alexandre Belloni (2):
      ARM: dts: at91: sama5d2: use correct rtc compatible
      ARM: dts: at91: sama5d4: use correct rtc compatible

Alexandre Courbot (1):
      arm64: dts: qcom: add Venus firmware node on Cheza

Alexis Ballier (2):
      arm64: dts: rockchip: Add ethernet phy to rk3399-orangepi
      arm64: dts: rockchip: Explicitly pinmux the regulator
configuration GPIOs on rk3399-orangepi

Alifer Moraes (4):
      arm64: dts: imx8mq-phanbell: Add support for ethernet
      arm64: dts: imx8mm-evk: add phy-reset-gpios for fec1
      arm64: dts: imx8mq-evk: add phy-reset-gpios for fec1
      arm64: dts: imx8mq-phanbell: Fix Ethernet PHY post-reset duration

Amelie Delaunay (4):
      ARM: dts: stm32: add USB OTG full support on stm32mp151
      ARM: dts: stm32: add USB OTG pinctrl to stm32mp15
      ARM: dts: stm32: enable USB OTG Dual Role on stm32mp157c-ev1
      ARM: dts: stm32: add resets property on all DMA nodes on stm32mp151

Amit Kucheria (4):
      arm64: dts: qcom: msm8916:: Add qcom,tsens-v0_1 to msm8916.dtsi compatible
      arm64: dts: qcom: msm8996:: Add qcom,tsens-v2 to msm8996.dtsi compatible
      arm64: dts: qcom: msm8998: Fix cpu compatible
      arm64: dts: marvell: Fix cpu compatible for AP807-quad

Andre Przywara (8):
      arm64: dts: sun50i: H6: Add SPI controllers nodes and pinmuxes
      arm64: dts: allwinner: h6: Pine H64: Add SPI flash node
      dt-bindings: spi: sunxi: Document new compatible strings
      arm: dts: calxeda: Basic DT file fixes
      arm: dts: calxeda: Provide UART clock
      arm: dts: calxeda: Fix interrupt grouping
      arm: dts: calxeda: Group port-phys and sgpio-gpio items
      MAINTAINERS: Update Calxeda Highbank maintainership

Andrey Lebedev (1):
      ARM: dts: sun7i: Add LVDS panel support on A20

Andrey Smirnov (5):
      ARM: dts: vf610-zii-ssmb-spu3: Add voltage monitor DT node
      ARM: dts: vf610-zii-ssmb-dtu: Add voltage monitor DT node
      ARM: dts: vf610-zii-spb4: Add voltage monitor DT node
      ARM: dts: vf610-zii-dev: Add voltage monitor DT node
      ARM: dts: vf610-zii-cfu1: Add voltage monitor DT node

André Draszik (4):
      ARM: dts: imx7d: cl-som-imx7: update pfuze3000 max voltage
      ARM: dts: imx7s: add snvs clock to pwrkey
      arm64: dts: imx8mm: add snvs clock to pwrkey
      arm64: dts: imx8mq: add snvs clock to pwrkey

Andy Yan (4):
      arm64: dts: rockchip: remove dvs2 pinctrl for pmic on rk3399 evb
      arm64: dts: rockchip: Add pmic dt tree for rk3399 evb
      arm64: dts: rockchip: remove enable-gpio of backlight on rk3399 evb
      arm64: dts: rockchip: Enable eDP display on rk3399 evb

Angus Ainslie (Purism) (7):
      arm64: dts: librem5-devkit: add a vbus supply to usb0
      arm64: dts: librem5-devkit: add the sgtl5000 i2c audio codec
      arm64: dts: librem5-devkit: add the simcom 7100 modem and audio
      arm64: dts: librem5-devkit: allow modem to wake the system from suspend
      arm64: dts: librem5-devkit: add the regulators for DVFS
      arm64: dts: librem5-devkit: allow the redpine card to be removed
      arm64: dts: librem5-devkit: increase the VBUS current in the kernel

Anson Huang (30):
      dt-bindings: arm: imx: Add the i.MX8MP EVK board
      arm64: dts: freescale: Add i.MX8MP dtsi support
      arm64: dts: freescale: Add i.MX8MP EVK board support
      ARM: dts: imx: make gpt node name generic
      ARM: dts: imx: make kpp node name generic
      ARM: dts: imx: make clks node name generic
      ARM: dts: imx6sx: Improve UART pins macro defines
      ARM: dts: imx6sx: Add missing UART RTS/CTS pins mux
      ARM: dts: imx6sx-nitrogen6sx: Use new pin names with DCE/DTE for UART pins
      ARM: dts: imx6sx-sabreauto: Use new pin names with DCE/DTE for UART pins
      ARM: dts: imx6sx-sdb: Use new pin names with DCE/DTE for UART pins
      ARM: dts: imx6sx-softing-vining-2000: Use new pin names with
DCE/DTE for UART pins
      ARM: dts: imx6sx-udoo-neo: Use new pin names with DCE/DTE for UART pins
      arm64: dts: imx8mp-evk: Add GPIO LED support
      arm64: dts: imx8mp: Add system counter timer node
      ARM: dts: imx: make wdog node name generic
      ARM: dts: imx: Align ocotp node name
      arm64: dts: imx8mn: Adjust 1.2GHz OPP voltage to OD mode
      ARM: dts: imx: Make iomuxc node name generic
      arm64: dts: imx: add i.MX8QXP thermal support
      arm64: dts: imx8mq: Align iomuxc node name
      arm64: dts: imx8mp: Add src node
      arm64: dts: imx8mn-evk: Add i2c3 support
      arm64: dts: imx8mn-evk: Enable pca6416 on i2c3 bus
      arm64: dts: imx8mp-evk: Add i2c3 support
      arm64: dts: imx8mp-evk: Enable pca6416 on i2c3 bus
      arm64: dts: imx8mm: Add thermal zone support
      arm64: dts: imx8mn: Add CPU thermal zone support
      arm64: dts: imx8mn: Add snvs clock to powerkey
      arm64: dts: imx8mp: Add snvs clock to powerkey

Arnd Bergmann (38):
      Merge tag 'renesas-arm-dt-for-v5.7-tag1' of
git://git.kernel.org/.../geert/renesas-devel into arm/dt
      Merge tag 'renesas-arm64-dt-for-v5.7-tag1' of
git://git.kernel.org/.../geert/renesas-devel into arm/dt
      Merge tag 'versatile-dts-v5.7-1' of
git://git.kernel.org/.../linusw/linux-integrator into arm/dt
      Merge tag 'omap-for-v5.7/dt-signed' of
git://git.kernel.org/.../tmlind/linux-omap into arm/dt
      Merge tag 'arm-soc/for-5.7/devicetree' of
https://github.com/Broadcom/stblinux into arm/dt
      Merge tag 'sunxi-dt-for-5.7' of
git://git.kernel.org/.../sunxi/linux into arm/dt
      Merge tag 'renesas-arm-dt-for-v5.7-tag2' of
git://git.kernel.org/.../geert/renesas-devel into arm/dt
      Merge tag 'renesas-arm64-dt-for-v5.7-tag2' of
git://git.kernel.org/.../geert/renesas-devel into arm/dt
      Merge tag 'renesas-dt-bindings-for-v5.7-tag1' of
git://git.kernel.org/.../geert/renesas-devel into arm/dt
      Merge tag 'stm32-dt-for-v5.7-1' of
git://git.kernel.org/.../atorgue/stm32 into arm/dt
      Merge tag 'tegra-for-5.7-dt-bindings' of
git://git.kernel.org/.../tegra/linux into arm/dt
      Merge tag 'tegra-for-5.7-arm-dt' of
git://git.kernel.org/.../tegra/linux into arm/dt
      Merge tag 'tegra-for-5.7-arm64-dt' of
git://git.kernel.org/.../tegra/linux into arm/dt
      Merge tag 'mvebu-dt64-5.7-1' of
git://git.infradead.org/linux-mvebu into arm/dt
      Merge tag 'ux500-dts-v5.7' of
git://git.kernel.org/.../linusw/linux-stericsson into arm/dt
      Merge tag 'samsung-dt-5.7' of
git://git.kernel.org/.../krzk/linux into arm/dt
      Merge tag 'v5.7-rockchip-dts32-1' of
git://git.kernel.org/.../mmind/linux-rockchip into arm/dt
      Merge tag 'v5.7-rockchip-dts64-1' of
git://git.kernel.org/.../mmind/linux-rockchip into arm/dt
      Merge tag 'amlogic-dt64' of
git://git.kernel.org/.../khilman/linux-amlogic into arm/dt
      Merge tag 'uniphier-dt-v5.7' of
git://git.kernel.org/.../masahiroy/linux-uniphier into arm/dt
      Merge tag 'uniphier-dt64-v5.7' of
git://git.kernel.org/.../masahiroy/linux-uniphier into arm/dt
      Merge tag 'imx-bindings-5.7' of
git://git.kernel.org/.../shawnguo/linux into arm/dt
      Merge tag 'imx-dt-5.7' of
git://git.kernel.org/.../shawnguo/linux into arm/dt
      Merge tag 'imx-dt64-5.7' of
git://git.kernel.org/.../shawnguo/linux into arm/dt
      Merge tag 'socfpga_dts_update_for_v5.7' of
git://git.kernel.org/.../dinguyen/linux into arm/dt
      Merge tag 'ti-k3-soc-for-v5.7' of
git://git.kernel.org/.../kristo/linux into arm/dt
      Merge tag 'v5.6-next-dts64' of
git://git.kernel.org/.../matthias.bgg/linux into arm/dt
      Merge tag 'v5.6-next-dts32' of
git://git.kernel.org/.../matthias.bgg/linux into arm/dt
      Merge tag 'gemini-dts-v5.7' of
git://git.kernel.org/.../linusw/linux-nomadik into arm/dt
      Merge tag 'at91-5.7-dt' of git://git.kernel.org/.../at91/linux into arm/dt
      Merge tag 'amlogic-dt64-2' of
git://git.kernel.org/.../khilman/linux-amlogic into arm/dt
      Merge tag 'socfpga_dts_update_for_v5.7_part2' of
git://git.kernel.org/.../dinguyen/linux into arm/dt
      Merge tag 'qcom-dts-for-5.7' of
git://git.kernel.org/.../qcom/linux into arm/dt
      arm64: dts: Revert "specify console via command line"
      Merge tag 'omap-for-v5.7/ti-sysc-drop-pdata-signed' of
git://git.kernel.org/.../tmlind/linux-omap into arm/late
      Merge tag 'omap-for-v5.7/ti-sysc-drop-pdata-ti81xx-signed' of
git://git.kernel.org/.../tmlind/linux-omap into arm/late
      Merge tag 'qcom-arm64-for-5.7' of
git://git.kernel.org/.../qcom/linux into arm/late
      Merge branch 'arm/late' into arm/dt

Balakrishna Godavarthi (1):
      arm64: dts: qcom: sc7180: Add bluetooth node on SC7180 IDP board

Bastian Germann (2):
      dt-bindings: arm: sunxi: Add Linutronix Testbox
      ARM: dts: sun7i: Add Linutronix Testbox v2 board

Benjamin Gaignard (5):
      ARM: dts: stm32: remove useless properties in
stm32mp157a-avenger96 stmpic node
      ARM: dts: stm32: Correct stmfx node name on stm32746g-eval board
      ARM: dts: stm32: Correct stmfx node name on stm32mp157c-ev1 board
      ARM: dts: stm32: Rename stmfx joystick pins on stm32mp157c-ev1
      ARM: dts: stm32: Do clean up in stmpic nodes on stm32mp15 boards

Bjorn Andersson (8):
      arm64: dts: qcom: sdm845: Add first PCIe controller and PHY
      arm64: dts: qcom: sdm845: Add second PCIe PHY and controller
      arm64: dts: qcom: db845c: Enable PCIe controllers
      arm64: dts: qcom: sdm845-mtp: Add Truly display
      arm64: dts: qcom: msm8996: Define parent clocks for gcc
      arm64: dts: qcom: msm8996: Use generic QMP driver for UFS
      arm64: dts: qcom: msm8998-mtp: Disable funnel 4 and 5
      arm64: dts: qcom: sdm845-mtp: Relocate remoteproc firmware

Carlos de Paula (1):
      arm64: dts: rockchip: Add txpbl node for RK3399/RK3328

Chris Brandt (1):
      ARM: dts: r7s72100: Add SPIBSC clocks

Christian Hewitt (7):
      arm64: dts: meson: fix gxm-khadas-vim2 wifi
      arm64: dts: meson-gxbb-odroid-c2: add rc-odroid ir keymap
      arm64: dts: meson-gxl-s905x-p212: add bluetooth nodes
      arm64: dts: meson-gxbb-vega-s95: fix bluetooth node
      arm64: dts: meson-g12b: fix N2/VIM3 audio card model names
      arm64: dts: meson: khadas-vim3: move model to g12b-khadas-vim3 dtsi
      arm64: dts: meson: add thermal zones to meson gx devices

Christian Lamparter (2):
      ARM: dts: qcom: add gpio-ranges property
      ARM64: dts: qcom: add gpio-ranges property

Chunyan Zhang (1):
      arm64: dts: specify console via command line

Claudiu Manoil (2):
      arm64: dts: ls1028a: add node for Felix switch
      arm64: dts: ls1028a: enable switch PHYs on RDB

Cristian Birsan (1):
      ARM: dts: at91: sama5d27_wlsom1_ek: add USB device node

Dalon Westergreen (1):
      ARM: socfpga: arria10: Add ptp_ref clock to ethernet nodes

Dave Gerlach (3):
      ARM: dts: am33xx: Add idle_states for cpuidle
      ARM: dts: am4372: Add idle_states for cpuidle
      arm64: dts: ti: k3-am65: Add clocks to dwc3 nodes

David Dai (1):
      arm64: dts: sdm845: Redefine interconnect provider DT nodes

Dikshita Agarwal (2):
      arm64: dts: sc7180: Add Venus video codec DT node
      arm64: dts: sc7180: Add Venus firmware subnode

Douglas Anderson (6):
      arm64: dts: sc7180: Add the sleep_clk to gcc-sc7180 node
      arm64: dts: qcom: qcs404: Fix sdhci compat string
      arm64: dts: qcom: sdm845: Add the missing clocks on the dispcc
      arm64: dts: qcom: sdm845: Add missing clocks / fix names on the gpucc
      arm64: dts: qcom: sdm845: Add the missing clock on the videocc
      arm64: dts: sc7180: Add unit name to soc node

Emmanuel Vadot (2):
      arm64: dts: allwinner: a64: Add gpio bank supply for A64-Olinuxino
      dt-bindings: Add doc for Pine64 Pinebook Pro

Enric Balletbo i Serra (1):
      arm64: dts: rk3399: Remove extcon unit address and extcon-cells from Gru

Eugen Hristev (2):
      ARM: dts: at91: sam9x60: add watchdog node
      ARM: dts: at91: sam9x60ek: enable watchdog node

Fabien Parent (2):
      arm64: dts: mediatek: add dtsi for MT8516
      arm64: dts: mediatek: add pumpkin board dts

Fabio Estevam (7):
      ARM: dts: imx6ul-pico: Convert to DRM bindings
      ARM: dts: imx6sx-softing-vining-2000: Enable PCI support
      dt-bindings: arm: fsl: Add TechNexion boards
      ARM: dts: imx7d-pico: Add support for the dwarf baseboard
      ARM: dts: imx7d-pico: Add support for the nymph baseboard
      ARM: dts: imx6ul-pico: Add support for the dwarf baseboard
      ARM: dts: imx6qdl: Add imx6qdl-pico support

Fabrizio Castro (1):
      arm64: dts: renesas: Add HiHope RZ/G2M board with idk-1110wr display

Florian Fainelli (12):
      Merge tag 'tags/bcm2835-dt-next-2020-03-09' into devicetree/next
      dt-bindings: arm: bcm: Convert Cygnus to YAML
      dt-bindings: arm: bcm: Convert Hurricane 2 to YAML
      dt-bindings: arm: bcm: Convert Northstar Plus to YAML
      dt-bindings: arm: bcm: Convert Northstar 2 to YAML
      dt-bindings: arm: bcm: Convert Stingray to YAML
      dt-bindings: arm: bcm: Convert BCM21664 to YAML
      dt-bindings: arm: bcm: Convert BCM23550 to YAML
      dt-bindings: arm: bcm: Convert BCM4708 to YAML
      dt-bindings: arm: bcm: Convert BCM11351 to YAML
      dt-bindings: arm: bcm: Convert Vulcan to YAML
      dt-bindings: arm: Document Broadcom SoCs 'secondary-boot-reg'

Geert Uytterhoeven (11):
      ARM: dts: renesas: Group tuples in operating-points properties
      arm64: dts: renesas: rcar-gen3: Replace "vsps" by "renesas,vsps"
      arm64: dts: renesas: rcar-gen3: Add CCREE nodes
      arm64: dts: renesas: Remove use of ARCH_R8A7795
      arm64: dts: renesas: rcar-gen3: Add reset control properties for display
      arm64: dts: renesas: rzg2: Add reset control properties for display
      ARM: dts: r8a7745: Convert to new DU DT bindings
      ARM: dts: rcar-gen2: Add reset control properties for display
      ARM: dts: rzg1: Add reset control properties for display
      arm64: dts: renesas: r8a77961: Add thermal nodes
      arm64: dts: renesas: r8a77961: salvator-xs: Fix memory unit-address

Grygorii Strashko (2):
      arm64: dts: ti: k3-am65-mcu: add phy-gmii-sel node
      arm64: dts: ti: k3-j721e-mcu: add scm node and phy-gmii-sel nodes

Guido Günther (1):
      arm64: dts: imx8mq-librem5-devkit: Add proximity sensor

Harigovindan P (1):
      arm64: dts: sc7180: add display dt nodes

Heiko Stuebner (1):
      arm64: dts: rockchip: fix px30 lvds ports

Horia Geantă (8):
      dt-bindings: clock: imx8mn: add SNVS clock
      clk: imx8mn: add SNVS clock to clock tree
      arm64: dts: imx8mn: add clock for snvs rtc node
      arm64: dts: imx8mp: add crypto node
      ARM: dts: imx: align name for crypto node and child nodes
      dt-bindings: crypto: sahara: use generic node name
      dt-bindings: crypto: dcp: use generic node name
      dt-bindings: crypto: caam: use generic node name

Hou Zhiqiang (2):
      arm64: dts: lx2160a: Add PCIe controller DT nodes
      arm64: dts: layerscape: add iommu-map property to pci nodes

Hsin-Yi Wang (1):
      arm64: dts: mt8173: add arm,no-tick-in-suspend in timer

Icenowy Zheng (3):
      dt-bindings: arm: sunxi: add binding for PineTab tablet
      arm64: dts: allwinner: a64: add support for PineTab
      arm64: allwinner: a64: enable LCD-related hardware for Pinebook

Igor Opaniuk (3):
      ARM: dts: imx6: toradex: use SPDX-License-Identifier
      ARM: dts: imx7: toradex: use SPDX-License-Identifier
      ARM: dts: vf: toradex: SPDX tags and copyright cleanup

JC Kuo (3):
      arm64: tegra: Add XUSB and pad controller on Tegra194
      arm64: tegra: Enable XUSB host in P2972-0000 board
      dt-bindings: phy: tegra: Add Tegra194 support

Jagan Teki (3):
      ARM: dts: rockchip: Fix vcc10_lcd name and voltage for rk3288-vyasa
      ARM: dts: rockchip: Fix ddc-i2c-bus for rk3288-vyasa
      ARM: dts: rockchip: Add vcc50_hdmi for rk3288-vyasa

James Liao (1):
      arm64: dts: mt8183: Enable CPU idle-states

Jernej Skrabec (10):
      dt-bindings: interconnect: sunxi: Add A64 MBUS compatible
      arm64: dts: allwinner: a64: Add MBUS controller node
      media: dt-bindings: media: Add Allwinner A64 deinterlace compatible
      arm64: dts: allwinner: a64: Add deinterlace core node
      arm64: dts: allwinner: h6: orangepi-3: Add eMMC node
      arm64: dts: allwinner: h6: Move ext. oscillator to board DTs
      ARM: dts: sunxi: Fix DE2 clocks register range
      arm64: dts: allwinner: a64: Fix display clock register range
      ARM: dts: sun8i: a83t: Add device node for rotation core
      arm64: dts: allwinner: a64: add node for rotation core

Jerome Brunet (4):
      dt-bindings: clk: meson: add the gxl internal dac gate
      arm64: dts: meson: add pdm reset line
      arm64: dts: meson: s400: fix sound card codec nodes
      arm64: dts: meson: sei510: fix sound card codec node

Jianxin Pan (1):
      arm64: dts: meson: a1: add secure power domain controller

Johan Jonker (33):
      arm64: dts: rockchip: fix cpu compatible property for rk3308
      arm64: dts: remove g-use-dma from rockchip usb nodes
      ARM: dts: remove g-use-dma from rockchip usb nodes
      ARM: dts: rockchip: add sram to bus_intmem nodename for rv1108
      ARM: dts: rockchip: add sram to bus_intmem nodename for rk3036
      ARM: dts: rockchip: add sram to bus_intmem nodename for rk3288
      arm64: dts: rockchip: fix compatible property for Radxa ROCK Pi N10
      ARM: dts: rockchip: add missing model properties
      dt-bindings: arm: fix Rockchip Kylin board bindings
      dt-bindings: arm: add Rockchip rk3036-evb board
      arm64: dts: rockchip: fix compatible property for rk3399-evb
      arm64: dts: rockchip: remove max-freq from &spi1 node for Hugsun X99
      arm64: dts: rockchip: remove rockchip,grf from vop nodes for px30
      arm64: dts: remove no-emmc from mmc node for Rockchip PX5 EVB
      arm64: dts: rockchip: fix vqmmc-supply property name for rk3399 puma
      arm64: dts: rockchip: replace clock-freq-min-max by max-frequency
      ARM: dts: rockchip: fix vqmmc-supply property name for rk3188-bqedison2qc
      ARM: dts: rockchip: fix rockchip,default-sample-phase property names
      ARM: dts: rockchip: remove #dma-cells from dma client nodes for rv1108
      ARM: dts: add bus to rockchip amba nodenames
      arm64: dts: add bus to rockchip amba nodenames
      ARM: dts: rockchip: fix lvds-encoder ports subnode for rk3188-bqedison2qc
      ARM: dts: rockchip: rk3xxx: fix L2 cache-controller nodename
      ARM: dts: rockchip: fix vref-supply for &saradc node rk3288 firefly reload
      ARM: dts: rockchip: remove clock-frequency from saradc node rv1108
      ARM: dts: rockchip: swap clocks and clock-names values for spdif nodes
      ARM: dts: rockchip: remove clock-names property from 'generic-ehci' nodes
      ARM: dts: rockchip: remove clock-names property from 'generic-ohci' nodes
      ARM: dts: rockchip: swap clocks and clock-names values for i2s nodes
      ARM: dts: rockchip: remove #address-cells and #size-cells from i2s nodes
      arm64: dts: rockchip: remove properties from spdif node RK3399 Excavator
      arm64: dts: rockchip: remove clock-names property from
'generic-ehci' nodes
      arm64: dts: rockchip: remove clock-names property from
'generic-ohci' nodes

Jon Hunter (5):
      arm64: tegra: Fix Tegra194 PCIe compatible string
      arm64: tegra: Enable I2C controller for EEPROM
      arm64: tegra: Add EEPROM supplies
      arm64: tegra: Fix Tegra186 SOR supply
      arm64: tegra: Populate LP8557 backlight regulator

Jonathan Marek (2):
      ARM: dts: qcom: msm8974: add blsp2_uart10
      ARM: dts: qcom: msm8974-hammerhead: add support for bluetooth

Joshua Watt (1):
      ARM: dts: rockchip: Keep rk3288-tinker SD card IO powered during reboot

Joyce Ooi (1):
      arm64: dts: increase the QSPI reg address for Stratix10 and Agilex

Kamel Bouhara (3):
      ARM: dts: at91: sama5d3: add i2c gpio pinctrl
      ARM: dts: at91: sama5d4: add i2c gpio pinctrl
      ARM: dts: at91: sama5d2: add i2c gpio pinctrl

Katsuhiro Suzuki (1):
      ARM: dts: rockchip: use DMA channels for UARTs for RK3288

Kevin Hilman (1):
      Merge tag 'clk-meson-dt-v5.7-1' of
git://github.com/BayLibre/clk-meson into v5.7/dt64

Kieran Bingham (1):
      arm: dts: renesas: r8a77980: Remove r8a77970 DU compatible

Konrad Dybcio (1):
      ARM: dts: qcom: msm8974-honami: Add USB node.

Kuldeep Singh (2):
      arm64: dts: lx2160ardb: Update FSPI node properties
      arm64: dts: lx2160aqds: Add FSPI node properties

Kunihiko Hayashi (5):
      ARM: dts: uniphier: Add USB3 controller nodes for Pro5
      arm64: dts: uniphier: Enable spi node for PXs3 reference board
      arm64: dts: uniphier: Add nodes of thermal monitor and thermal
zone for PXs3
      ARM: dts: uniphier: Set SCSSI clock and reset IDs for each channel
      arm64: dts: uniphier: Set SCSSI clock and reset IDs for each channel

Ley Foon Tan (1):
      ARM: dts: socfpga: arria10: Increase boot partition size for NAND

Linus Walleij (13):
      ARM: dts: ux500: Fix up DSI controller nodes
      ARM: dts: Versatile: Use syscon as node name for IB2
      ARM: dts: RealView: Fix the name of the SoC node
      dt-bindings: arm: Add Integrator YAML schema
      dt-bindings: arm: Add Versatile YAML schema
      dt-bindings: arm: Add RealView YAML schema
      dt-bindings: arm: Add Versatile Express and Juno YAML schema
      dt-bindings: arm: Drop the non-YAML bindings
      ARM/arm64: dts: Rename SMB bus to just bus
      ARM: dts: Add devicetree for Samsung GT-S7710
      ARM: dts: gemini: Rename IDE nodes
      ARM: dts: gemini: Add thermal zone to DIR-685
      ARM: dts: ux500: Fix missing node renames

Loic Poulain (1):
      arm64: dts: qcom: apq8016-sbc: Remove wrong regulator supply

Lucas Stach (2):
      ARM: dts: imx6: RDU2: assign video PLL as input to LDB
      ARM: dts: imx51-zii-rdu1: set name prefix for TPA6130A2

Lukasz Luba (1):
      ARM: dts: exynos: Add dynamic-power-coefficient to Exynos5422 CPUs

Mans Rullgard (1):
      ARM: dts: sunxi: h3/h5: add r_pwm node

Marco Felsch (2):
      ARM: dts: imx6: phycore-som: explicit disable pmic watchdog during suspend
      ARM: dts: imx6: phycore-som: add da9062 gpio support

Marcus Cooper (2):
      arm64: dts: allwinner: h6: orangepi-one-plus: Enable ethernet
      arm64: dts: allwinner: h6: orangepi: Enable HDMI

Marek Szyprowski (8):
      ARM: dts: exynos: Fix broken reboot on some Odroid U2/X2/U3 boards
      ARM: dts: exynos: Add GPU thermal zone cooling maps for Odroid XU3/XU4/HC1
      ARM: dts: exynos: Fix MMC regulator on Arndale5250 board
      ARM: dts: exynos: Make fixed regulators always-on on Arndale5250
      ARM: dts: exynos: Fix memory on Artik5 evaluation boards
      ARM: dts: exynos: Fix G3D power domain supply on Odroid XU3/XU4/HC1 boards
      ARM: dts: exynos: Fix G3D power domain supply on Arndale Octa boards
      ARM: dts: exynos: Fix polarity of the LCD SPI bus on UniversalC210 board

Marek Vasut (7):
      ARM: dts: renesas: Add missing ethernet PHY reset GPIO on Gen2
reference boards
      ARM: dts: stm32: Add Ethernet0 RMII pins A pinmux entry on stm32mp1
      ARM: dts: stm32: Add SAI2A pins B pinmux entry on stm32mp1
      ARM: dts: stm32: Add USART3 pins A pinmux entry on stm32mp1
      ARM: dts: stm32: Add UART8 pins A pinmux entry on stm32mp1
      ARM: dts: stm32: Add missing ETHCK clock to ethernet node on stm32mp1
      ARM: dts: stm32: Add DH Electronics DHCOM STM32MP1 SoM and PDK2 board

Marian-Cristian Rotariu (2):
      ARM: dts: iwg22d-sodimm: Enable LCD panel
      ARM: dts: iwg22d-sodimm: Enable touchscreen

Martin Kaiser (2):
      ARM: dts: imx25-pinfunc: add another cspi3 config
      ARM: dts: imx25-pinfunc: add config for kpp rows 4 to 7

Martin Kepplinger (1):
      arm64: dts: librem5-devkit: add lsm9ds1 mount matrix

Masahiro Yamada (8):
      ARM: dts: uniphier: change SD/eMMC node names to follow json-schema
      ARM: dts: uniphier: rename aidet node names to follow json-schema
      ARM: dts: uniphier: rename NAND node names to follow json-schema
      ARM: dts: uniphier: rename cache controller nodes to follow json-schema
      arm64: dts: uniphier: change SD/eMMC node names to follow json-schema
      arm64: dts: uniphier: rename aidet node names to follow json-schema
      arm64: dts: uniphier: rename NAND node names to follow json-schema
      ARM: dts: uniphier: Add one more generic compatible string for I2C EEPROM

Mathieu Poirier (1):
      arm64: dts: msm8916: Properly deal with ETMv4 power management

Matthias Brugger (2):
      ARM: dts: mediatek: rename scpsys nodes to power-controller
      arm64: dts: mediatek: rename scpsys nodes to power-controller

Matthias Kaehlcke (1):
      arm64: dts: sc7180: Move venus node to the correct position

Maxime Ripard (4):
      ARM: dts: sunxi: Remove redundant assigned-clocks
      ARM: dts: sunxi: Remove redundant assigned-clocks
      arm64: dts: allwinner: h5: Fix PMU compatible
      arm64: dts: allwinner: h6: Fix PMU compatible

Michael Heimpold (1):
      ARM: dts: imx23: introduce mmc0_sck_cfg

Michael Walle (10):
      dt-bindings: arm: fsl: add LS1028A based boards
      dt-bindings: arm: fsl: add Kontron sl28 boards
      arm64: dts: freescale: add Kontron sl28 support
      arm64: dts: ls1028a: add missing SPI nodes
      arm64: dts: ls1028: sl28: explicitly enable network ports
      arm64: dts: freescale: sl28: add SPI flash
      arm64: dts: ls1028a: sl28: fix on-board EEPROMS
      arm64: dts: ls1028a: sl28: expose switch ports in KBox A-230-LS
      arm64: dts: ls1028a: sl28: add support for variant 2
      arm64: dts: ls1028a: disable the felix switch by default

Michal Vokáč (1):
      ARM: dts: imx6dl-yapp4: Specify USB overcurrent protection polarity

Mohammad Rasim (1):
      arm64: dts: amlogic: add rc-videostrong-kii-pro keymap

Nagarjuna Kristam (11):
      arm64: tegra: Update OTG port entries for Jetson TX1
      arm64: tegra: Update OTG port entries for Jetson TX2
      arm64: tegra: Add XUDC node for Tegra210
      arm64: tegra: Enable XUDC on Jetson TX1
      arm64: tegra: Add XUDC node for Tegra186
      arm64: tegra: Enable XUDC node on Jetson TX2
      arm64: tegra: Update OTG port entries for Jetson Nano
      arm64: tegra: Enable XUDC node on Jetson Nano
      dt-bindings: phy: tegra-xusb: Add usb-role-switch
      dt-bindings: usb: Add NVIDIA Tegra XUSB device mode controller binding
      ARM: tegra: Remove USB 2-0 port from Jetson TK1 padctl

Neil Armstrong (7):
      dt-bindings: clk: g12a-clkc: add SPICC SCLK Source clock IDs
      arm64: dts: g12-common: add parkmode_disable_ss_quirk on DWC3 controller
      arm64: dts: meson-g12-common: add spicc controller nodes
      arm64: dts: meson-g12: split emmc pins to select 4 or 8 bus width
      arm64: dts: meson-g12: add the SPIFC nodes
      arm64: dts: khadas-vim3: add SPIFC controller node
      arm64: dts: meson-g12b-odroid-n2: add SPIFC controller node

Nicolas Saenz Julienne (1):
      ARM: dts: bcm2711: Move emmc2 into its own bus

Odelu Kukatla (1):
      arm64: dts: sc7180: Add interconnect provider DT nodes

Oleksandr Suvorov (5):
      ARM: dts: imx7-colibri: add alias for RTC
      ARM: dts: imx7-colibri: fix muxing of usbc_det pin
      ARM: dts: imx7-colibri: Convert to SPDX license tags for Colibri iMX7
      ARM: dts: imx7-colibri: add support for Toradex Aster carrier board
      dt-bindings: arm: fsl: add nxp based toradex colibri-imx7 bindings

Oleksij Rempel (2):
      ARM: dts: imx6dl-riotboard: properly define rgmii PHY
      ARM: dts: imx6q-marsboard: properly define rgmii PHY

Ondrej Jirman (9):
      dt-bindings: arm: sunxi: Add PocketBook Touch Lux 3
      ARM: dts: sun5i: Add PocketBook Touch Lux 3 support
      arm64: dts: sun50i-h5-orange-pi-pc2: Add CPUX voltage regulator
      ARM: dts: sun8i-a83t-tbs-a711: Drop superfluous dr_mode
      ARM: dts: sun8i-h3: Add thermal trip points/cooling maps
      ARM: dts: sun8i-a83t: Add thermal trip points/cooling maps
      arm64: dts: sun50i-a64: Add i2c2 pins
      dt-bindings: arm: sunxi: Add PinePhone 1.0 and 1.1 bindings
      arm64: dts: allwinner: Add initial support for Pine64 PinePhone

Peng Fan (6):
      arm64: dts: imx8mn: Init rates and parents configs for clocks
      arm64: dts: freescale: s32v234: use generic name bus
      arm64: dts: imx8mm: drop redundant interrupt-parent
      ARM: dts: imx: use generic name bus
      ARM: dts: imx: add nvmem property for cpu0
      arm64: dts: imx8m: fix aips dts node

Peter Chen (1):
      ARM: dts: imx7ulp-evk: disable usbotg1 overcurrent function

Philipp Zabel (1):
      ARM: dts: imx51: add capture-subsystem device

Rabeeh Khoury (1):
      arm64: dts: lx2160a-cex7: add on-module eeproms

Rajendra Nayak (3):
      arm64: dts: qcom: sc7180: Add dynamic CPU power coefficients
      arm64: dts: qcom: sc7180: Add CPU capacity values
      arm64: dts: qcom: sc7180: Add CPU topology

Rajeshwari (1):
      arm64: dts: qcom: sc7180: Added critical trip point Thermal-zones node

Ran Bi (1):
      arm64: dts: add RTC nodes for MT2712

Rob Herring (3):
      ARM: dts: imx: Kill off "simple-panel" compatibles
      ARM: dts: integratorap: Remove top level dma-ranges
      ARM: dts: at91: Kill off "simple-panel" compatibles

Robert Jones (2):
      ARM: dts: imx: ventana: add fxos8700 on gateworks boards
      ARM: dts: imx6qdl-gw553x: add lsm9ds1 iio imu/magn support

Robin Murphy (1):
      arm64: dts: rockchip: Describe RK3328 GPIO_MUTE users

Roger Quadros (1):
      dt-bindings: bus: ti-sysc: Add support for PRUSS SYSC type

Russell King (4):
      ARM: dts: imx6qdl-sr-som-ti: indicate powering off wifi is safe
      arm64: dts: lx2160a-cex7: add support for ltc3882 regulator
      arm64: dts: clearfog-gt-8k: set gigabit PHY reset deassert delay
      arm64: dts: mcbin: support 2W SFP modules

Sai Prakash Ranjan (1):
      arm64: dts: qcom: sc7180: Add iommus property to QUP0 and QUP1

Sam Shih (1):
      ARM: dts: mediatek: add mt7629 pwm support

Samuel Holland (9):
      arm64: dts: allwinner: Enable button wakeup on Orange Pi PC2
      arm64: dts: allwinner: pinebook: Remove unused vcc3v3 regulator
      arm64: dts: allwinner: pinebook: Sort device tree nodes
      arm64: dts: allwinner: pinebook: Make simplefb more consistent
      arm64: dts: allwinner: pinebook: Document MMC0 CD pin name
      arm64: dts: allwinner: pinebook: Add GPIO port regulators
      arm64: dts: allwinner: pinebook: Fix backlight regulator
      arm64: dts: allwinner: pinebook: Fix 5v0 boost regulator
      arm64: dts: allwinner: pinebook: Remove unused AXP803 regulators

Sandeep Maheswaram (1):
      arm64: dts: qcom: sc7180: Correct qmp phy reset entries

Sibi Sankar (2):
      arm64: dts: qcom: sdm845: Add OSM L3 interconnect provider
      arm64: dts: qcom: sc7180: Add OSM L3 interconnect provider

Silvano di Ninno (1):
      arm64: dts: imx8mn: align name for crypto child nodes

Sivaprakash Murugesan (1):
      arm64: dts: ipq6018: Add a few device nodes

Sowjanya Komatineni (8):
      dt-bindings: clock: tegra: Add IDs for OSC clocks
      dt-bindings: tegra: Convert Tegra PMC bindings to YAML
      dt-bindings: soc: tegra-pmc: Add Tegra PMC clock bindings
      dt-bindings: soc: tegra-pmc: Add ID for Tegra PMC 32 kHz blink clock
      arm64: tegra: Add clock-cells property to Tegra PMC node
      arm64: tegra: smaug: Change clk_out_2 provider to PMC
      ARM: tegra: Add clock-cells property to PMC
      ARM: tegra: Update sound node clocks in device tree

Sricharan R (2):
      dt-bindings: qcom: Add ipq6018 bindings
      arm64: dts: Add ipq6018 SoC and CP01 board support

Srinivas Kandagatla (7):
      arm64: dts: qcom: db845c: add Low speed expansion i2c and spi nodes
      arm64: dts: msm8916: Add fastrpc node
      arm64: dts: qcom: sdm845: add slimbus nodes
      arm64: dts: qcom: sdm845: add apr nodes
      arm64: dts: qcom: c630: Enable audio support
      arm64: dts: qcom: sdm845: add pinctrl nodes for quat i2s
      arm64: dts: qcom: db845c: add analog audio support

Stanimir Varbanov (1):
      arm64: dts: sdm845: follow venus-sdm845v2 DT binding

Stefan Agner (1):
      ARM: dts: imx7-colibri: add gpio-line-names

Stefan Wahren (1):
      ARM: dts: bcm2711-rpi-4-b: Add SoC GPIO labels

Stephan Gerhold (1):
      arm64: dts: qcom: msm8916-samsung-a2015: Reserve Samsung firmware memory

Stephen Boyd (2):
      arm64: dts: qcom: sdm845: Disable pwrkey on Cheza
      arm64: dts: qcom: pm6150: Add label to pwrkey node

Suman Anna (7):
      ARM: OMAP2+: Drop hwmod data for am3 and am4 PRUSS
      ARM: OMAP2+: Drop legacy platform data for OMAP4 DSP
      ARM: OMAP4: hwmod_data: Remove OMAP4 IPU hwmod data
      bus: ti-sysc: Add support for PRUSS SYSC type
      ARM: dts: AM33xx-l4: Update PRUSS interconnect target-module node
      ARM: dts: AM4372: Add the PRU-ICSS interconnect target-module node
      ARM: dts: dra7: Add PRU-ICSS interconnect target-module nodes

Takeshi Kihara (2):
      arm64: dts: renesas: r8a77965: Add CPUIdle support for CA57 cores
      arm64: dts: renesas: r8a77990: Add CPUIdle support for CA53 cores

Taniya Das (1):
      arm64: dts: sc7180: Add clock controller nodes

Thierry Reding (3):
      Merge branch 'for-5.7/dt-bindings' into for-5.7/arm64/dt
      arm64: tegra: Add ethernet alias on Jetson TX1
      Merge branch 'for-5.7/dt-bindings' into for-5.7/arm/dt

Tim Harvey (1):
      ARM: dts: imx6qdl-gw5910: add CC1352 UART

Tobias Schramm (1):
      arm64: dts: rockchip: Add initial support for Pinebook Pro

Tomasz Maciej Nowak (3):
      arm64: dts: marvell: espressobin: add ethernet alias
      arm64: dts: marvell: espressobin: indicate dts version
      arm64: dts: marvell: build ESPRESSObin variants

Tony Lindgren (61):
      ARM: dts: Configure omap5 AESS
      drm/omap: Prepare DSS for probing without legacy platform data
      bus: ti-sysc: Rename clk related quirks to pre_reset and post_reset quirks
      bus: ti-sysc: Improve reset to work with modules with no sysconfig
      bus: ti-sysc: Consider non-existing registers too when matching quirks
      bus: ti-sysc: Don't warn about legacy property for nested ti-sysc devices
      bus: ti-sysc: Implement SoC revision handling
      bus: ti-sysc: Handle module unlock quirk needed for some RTC
      bus: ti-sysc: Detect display subsystem related devices
      bus: ti-sysc: Implement display subsystem reset quirk
      Merge branch 'omap-for-v5.7/dss-probe' into omap-for-v5.7/ti-sysc
      bus: ti-sysc: Fix wrong offset for display subsystem reset quirk
      bus: ti-sysc: Detect EDMA and set quirk flags for tptc
      ARM: dts: Configure interconnect target module for omap4 dss
      ARM: dts: Configure interconnect target module for omap4 dispc
      ARM: dts: Configure interconnect target module for omap4 rfbi
      ARM: dts: Configure interconnect target module for omap4 venc
      ARM: dts: Configure interconnect target module for omap4 dsi1
      ARM: dts: Configure interconnect target module for omap4 dsi2
      ARM: dts: Configure interconnect target module for omap4 hdmi
      ARM: dts: Configure interconnect target module for omap5 dss
      ARM: dts: Configure interconnect target module for omap5 dispc
      ARM: dts: Configure interconnect target module for omap5 rfbi
      ARM: dts: Configure interconnect target module for omap5 dsi1
      ARM: dts: Configure interconnect target module for omap5 dsi2
      ARM: dts: Configure interconnect target module for omap5 hdmi
      ARM: dts: Configure interconnect target module for dra7 dss
      ARM: dts: Configure interconnect target module for dra7 dispc
      ARM: dts: Configure interconnect target module for dra7 hdmi
      ARM: dts: Move am437x dss to the interconnect target module in l4
      ARM: dts: Configure interconnect target module for am437x dispc
      ARM: dts: Configure interconnect target module for am437x rfbi
      ARM: OMAP2+: Drop legacy platform data for omap4 dss
      ARM: OMAP2+: Drop legacy platform data for omap5 DSS
      ARM: OMAP2+: Drop legacy platform data for dra7 DSS
      ARM: OMAP2+: Drop legacy platform data for am437x DSS
      Merge branch 'omap-for-v5.7/accelerators' into
omap-for-v5.7/ti-sysc-drop-pdata
      ARM: dts: Configure interconnect target module for am3 tpcc
      ARM: dts: Configure interconnect target module for am3 tptc0
      ARM: dts: Configure interconnect target module for am3 tptc1
      ARM: dts: Configure interconnect target module for am3 tptc2
      ARM: dts: Configure interconnect target module for am4 tpcc
      ARM: dts: Configure interconnect target module for am4 tptc0
      ARM: dts: Configure interconnect target module for am4 tptc1
      ARM: dts: Configure interconnect target module for am4 tptc2
      ARM: dts: Configure interconnect target module for dra7 tpcc
      ARM: dts: Configure interconnect target module for dra7 tptc0
      ARM: dts: Configure interconnect target module for dra7 tptc1
      ARM: OMAP2+: Drop legacy platform data for am3 and am4 edma
      ARM: OMAP2+: Drop legacy platform data for dra7 edma
      clk: ti: Fix dm814x clkctrl for ethernet
      Merge tag 'omap-for-v5.7/ti-sysc-drop-pdata-signed' into ti81xx
      ARM: dts: Configure interconnect target module for dm814x cpsw
      ARM: OMAP2+: Drop legacy platform data for dm814x cpsw
      ARM: dts: Configure interconnect target module for dm814x tpcc
      ARM: dts: Configure interconnect target module for dm814x tptc0
      ARM: dts: Configure interconnect target module for dm814x tptc1
      ARM: dts: Configure interconnect target module for dm814x tptc2
      ARM: dts: Configure interconnect target module for dm814x tptc3
      ARM: dts: Configure interconnect target module for ti816x edma
      ARM: OMAP2+: Drop legacy platform data for ti81xx edma

Vadym Kochan (1):
      arm64: dts: marvell: fix non-existed cpu referrence in
armada-ap806-dual.dtsi

Veerabhadrarao Badiganti (3):
      arm64: dts: qcom: sc7180: Add nodes for eMMC and SD card
      arm64: dts: qcom: qcs404: Enable CQE support for eMMC
      arm64: dts: qcom: sc7180: Update reg names for SDHC

Venkata Narendra Kumar Gutta (1):
      arm64: dts: qcom: sm8250: Add sm8250 dts file

Vidya Sagar (2):
      arm64: tegra: Add PCIe endpoint controllers nodes for Tegra194
      arm64: tegra: Add support for PCIe endpoint mode in P2972-0000 platform

Vignesh Raghavendra (3):
      arm64: dts: ti: k3-j721e-mcu-wakeup: Add DMA entries for ADC
      arm64: dts: ti: k3-am65-main: Add DMA entries for main_spi0
      arm64: dts: ti: k3-am65-mcu: Add DMA entries for ADC

Vitor Massaru Iha (1):
      arm64: dts: imx8mq-phanbell: Add gpio-fan/thermal support

Vivek Unune (2):
      arm64: dts: rockchip: Add Hugsun X99 IR receiver
      arm64: dts: rockchip: Add Hugsun X99 power led

Vladimir Oltean (2):
      arm64: dts: ls1028a: delete extraneous #interrupt-cells for ENETC RCIE
      arm64: dts: ls1028a: disable all enetc ports by default

Xiaowei Bao (1):
      arm64: dts: ls1028a: Add PCIe controller DT nodes

Yangbo Lu (2):
      arm64: dts: ls1088a: support eMMC HS200 speed mode for RDB board
      arm64: dts: ls1028a: support external trigger timestamp fifo of PTP timer

Yangtao Li (1):
      ARM: dts: sun8i-r40: Add thermal sensor and thermal zones

Yann Gautier (3):
      ARM: dts: stm32: add cd-gpios properties for SD-cards on STM32MP1 boards
      ARM: dts: stm32: add disable-wp property for SD-card on STM32MP1 boards
      ARM: dts: stm32: use correct vqmmc regu for eMMC on stm32mp1
ED1/EV1 boards

Yuya Hamamachi (2):
      dt-bindings: arm: renesas: Add M3ULCB with R-Car M3-W+
      arm64: dts: renesas: Add support for M3ULCB with R-Car M3-W+

michael.kao (2):
      arm64: dts: mt8183: add/update dynamic power coefficients
      arm64: dts: mt8183: Add #cooling-cells to CPU nodes

yong.liang (1):
      amr64: dts: mt8183: Add watchdog node

 .../devicetree/bindings/arm/arm,integrator.yaml    |   86 ++
 .../devicetree/bindings/arm/arm,realview.yaml      |  123 +++
 .../devicetree/bindings/arm/arm,versatile.yaml     |   71 ++
 .../devicetree/bindings/arm/arm,vexpress-juno.yaml |  223 ++++
 Documentation/devicetree/bindings/arm/arm-boards   |  237 -----
 .../bindings/arm/bcm/brcm,bcm11351-cpu-method.txt  |   36 -
 .../devicetree/bindings/arm/bcm/brcm,bcm11351.txt  |   10 -
 .../devicetree/bindings/arm/bcm/brcm,bcm11351.yaml |   21 +
 .../devicetree/bindings/arm/bcm/brcm,bcm21664.txt  |   15 -
 .../devicetree/bindings/arm/bcm/brcm,bcm21664.yaml |   21 +
 .../bindings/arm/bcm/brcm,bcm23550-cpu-method.txt  |   36 -
 .../devicetree/bindings/arm/bcm/brcm,bcm23550.txt  |   15 -
 .../devicetree/bindings/arm/bcm/brcm,bcm23550.yaml |   21 +
 .../devicetree/bindings/arm/bcm/brcm,bcm4708.txt   |   15 -
 .../devicetree/bindings/arm/bcm/brcm,bcm4708.yaml  |   88 ++
 .../devicetree/bindings/arm/bcm/brcm,cygnus.txt    |   31 -
 .../devicetree/bindings/arm/bcm/brcm,cygnus.yaml   |   29 +
 .../devicetree/bindings/arm/bcm/brcm,hr2.txt       |   14 -
 .../devicetree/bindings/arm/bcm/brcm,hr2.yaml      |   28 +
 .../devicetree/bindings/arm/bcm/brcm,ns2.txt       |    9 -
 .../devicetree/bindings/arm/bcm/brcm,ns2.yaml      |   23 +
 .../bindings/arm/bcm/brcm,nsp-cpu-method.txt       |   39 -
 .../devicetree/bindings/arm/bcm/brcm,nsp.txt       |   34 -
 .../devicetree/bindings/arm/bcm/brcm,nsp.yaml      |   36 +
 .../devicetree/bindings/arm/bcm/brcm,stingray.txt  |   12 -
 .../devicetree/bindings/arm/bcm/brcm,stingray.yaml |   24 +
 .../bindings/arm/bcm/brcm,vulcan-soc.txt           |   10 -
 .../bindings/arm/bcm/brcm,vulcan-soc.yaml          |   22 +
 Documentation/devicetree/bindings/arm/cpus.yaml    |   33 +
 Documentation/devicetree/bindings/arm/fsl.yaml     |   69 ++
 Documentation/devicetree/bindings/arm/qcom.yaml    |    8 +
 Documentation/devicetree/bindings/arm/renesas.yaml |    1 +
 .../devicetree/bindings/arm/rockchip.yaml          |   12 +-
 Documentation/devicetree/bindings/arm/sunxi.yaml   |   26 +
 .../arm/sunxi/allwinner,sun4i-a10-mbus.yaml        |    1 +
 .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      |  300 ------
 .../bindings/arm/tegra/nvidia,tegra20-pmc.yaml     |  354 +++++++
 Documentation/devicetree/bindings/arm/vexpress.txt |  229 ----
 Documentation/devicetree/bindings/bus/ti-sysc.txt  |    1 +
 .../devicetree/bindings/crypto/fsl-dcp.txt         |    2 +-
 .../devicetree/bindings/crypto/fsl-imx-sahara.txt  |    2 +-
 .../devicetree/bindings/crypto/fsl-sec4.txt        |    2 +-
 .../media/allwinner,sun8i-h3-deinterlace.yaml      |    6 +-
 .../bindings/pci/nvidia,tegra194-pcie.txt          |    2 +-
 .../bindings/phy/nvidia,tegra124-xusb-padctl.txt   |   24 +
 .../bindings/spi/allwinner,sun6i-a31-spi.yaml      |   11 +-
 .../devicetree/bindings/usb/nvidia,tegra-xudc.yaml |  190 ++++
 MAINTAINERS                                        |    2 +-
 arch/arm/boot/dts/Makefile                         |   20 +-
 arch/arm/boot/dts/am33xx-l4.dtsi                   |   21 +-
 arch/arm/boot/dts/am33xx.dtsi                      |  133 ++-
 arch/arm/boot/dts/am4372.dtsi                      |  191 ++--
 arch/arm/boot/dts/am437x-l4.dtsi                   |   77 +-
 arch/arm/boot/dts/am57-pruss.dtsi                  |   50 +
 arch/arm/boot/dts/am5718.dtsi                      |    1 +
 arch/arm/boot/dts/am5728.dtsi                      |    1 +
 arch/arm/boot/dts/am5748.dtsi                      |    1 +
 arch/arm/boot/dts/arm-realview-pbx.dtsi            |    2 +-
 arch/arm/boot/dts/at91-dvk_su60_somc_lcm.dtsi      |    2 +-
 arch/arm/boot/dts/at91-sam9x60ek.dts               |    5 +
 arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts      |   12 +
 arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts          |   33 +-
 arch/arm/boot/dts/at91-sama5d2_xplained.dts        |   33 +-
 arch/arm/boot/dts/at91-sama5d4_ma5d4evk.dts        |    2 +-
 arch/arm/boot/dts/at91sam9n12ek.dts                |    2 +-
 arch/arm/boot/dts/at91sam9x5dm.dtsi                |    2 +-
 arch/arm/boot/dts/bcm2711-rpi-4-b.dts              |   74 ++
 arch/arm/boot/dts/bcm2711.dtsi                     |   25 +-
 arch/arm/boot/dts/dm814x-clocks.dtsi               |   14 +
 arch/arm/boot/dts/dm814x.dtsi                      |  260 +++--
 arch/arm/boot/dts/dm816x.dtsi                      |  148 ++-
 arch/arm/boot/dts/dra62x.dtsi                      |    6 +-
 arch/arm/boot/dts/dra7.dtsi                        |  219 ++--
 arch/arm/boot/dts/dra72x.dtsi                      |    6 +-
 arch/arm/boot/dts/dra74x.dtsi                      |   10 +-
 arch/arm/boot/dts/ecx-2000.dts                     |    6 +-
 arch/arm/boot/dts/ecx-common.dtsi                  |   17 +-
 arch/arm/boot/dts/exynos3250-artik5.dtsi           |    2 +-
 arch/arm/boot/dts/exynos4210-universal_c210.dts    |    4 +-
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |    9 +
 arch/arm/boot/dts/exynos5250-arndale.dts           |   10 +-
 arch/arm/boot/dts/exynos5420-arndale-octa.dts      |    2 +
 arch/arm/boot/dts/exynos5422-cpus.dtsi             |    8 +
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi      |    1 +
 arch/arm/boot/dts/exynos5422-odroidhc1.dts         |   30 +
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |   59 ++
 arch/arm/boot/dts/gemini-dlink-dir-685.dts         |   50 +-
 arch/arm/boot/dts/gemini-dlink-dns-313.dts         |    2 +-
 arch/arm/boot/dts/gemini-nas4220b.dts              |    4 +-
 arch/arm/boot/dts/gemini-sl93512r.dts              |    4 +-
 arch/arm/boot/dts/gemini-sq201.dts                 |    2 +-
 arch/arm/boot/dts/gemini.dtsi                      |    8 +-
 arch/arm/boot/dts/highbank.dts                     |   11 +-
 arch/arm/boot/dts/imx23-olinuxino.dts              |    2 +-
 arch/arm/boot/dts/imx23.dtsi                       |   10 +-
 arch/arm/boot/dts/imx25-pinfunc.h                  |    8 +
 arch/arm/boot/dts/imx25.dtsi                       |    4 +-
 arch/arm/boot/dts/imx27.dtsi                       |    2 +-
 arch/arm/boot/dts/imx28-apx4devkit.dts             |   10 +
 arch/arm/boot/dts/imx28.dtsi                       |    2 +-
 arch/arm/boot/dts/imx31.dtsi                       |    4 +-
 arch/arm/boot/dts/imx35.dtsi                       |    4 +-
 arch/arm/boot/dts/imx50.dtsi                       |    4 +-
 arch/arm/boot/dts/imx51-zii-rdu1.dts               |    5 +-
 arch/arm/boot/dts/imx51.dtsi                       |   17 +-
 arch/arm/boot/dts/imx53.dtsi                       |    4 +-
 arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts       |   40 +-
 arch/arm/boot/dts/imx6dl-pico-dwarf.dts            |   17 +
 arch/arm/boot/dts/imx6dl-pico-hobbit.dts           |   17 +
 arch/arm/boot/dts/imx6dl-pico-nymph.dts            |   17 +
 arch/arm/boot/dts/imx6dl-pico-pi.dts               |   17 +
 arch/arm/boot/dts/imx6dl-riotboard.dts             |   16 +-
 arch/arm/boot/dts/imx6dl-yapp4-common.dtsi         |    2 +
 arch/arm/boot/dts/imx6dl.dtsi                      |    8 +-
 arch/arm/boot/dts/imx6q-apalis-eval.dts            |   40 +-
 arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts      |   40 +-
 arch/arm/boot/dts/imx6q-apalis-ixora.dts           |   40 +-
 arch/arm/boot/dts/imx6q-marsboard.dts              |   16 +-
 arch/arm/boot/dts/imx6q-novena.dts                 |    2 +-
 arch/arm/boot/dts/imx6q-pico-dwarf.dts             |   17 +
 arch/arm/boot/dts/imx6q-pico-hobbit.dts            |   17 +
 arch/arm/boot/dts/imx6q-pico-nymph.dts             |   17 +
 arch/arm/boot/dts/imx6q-pico-pi.dts                |   17 +
 arch/arm/boot/dts/imx6q.dtsi                       |    6 +-
 arch/arm/boot/dts/imx6qdl-apalis.dtsi              |   40 +-
 arch/arm/boot/dts/imx6qdl-colibri.dtsi             |   40 +-
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi              |    5 +
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi              |    5 +
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi              |    5 +
 arch/arm/boot/dts/imx6qdl-gw553x.dtsi              |   31 +
 arch/arm/boot/dts/imx6qdl-gw5910.dtsi              |   25 +
 arch/arm/boot/dts/imx6qdl-phytec-phycore-som.dtsi  |    5 +-
 arch/arm/boot/dts/imx6qdl-pico-dwarf.dtsi          |   45 +
 arch/arm/boot/dts/imx6qdl-pico-hobbit.dtsi         |   37 +
 arch/arm/boot/dts/imx6qdl-pico-nymph.dtsi          |   54 +
 arch/arm/boot/dts/imx6qdl-pico-pi.dtsi             |   31 +
 arch/arm/boot/dts/imx6qdl-pico.dtsi                |  617 +++++++++++
 arch/arm/boot/dts/imx6qdl-sr-som-ti.dtsi           |    1 +
 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi            |    7 +
 arch/arm/boot/dts/imx6qdl.dtsi                     |   30 +-
 arch/arm/boot/dts/imx6qp.dtsi                      |    2 +-
 arch/arm/boot/dts/imx6sl.dtsi                      |   28 +-
 arch/arm/boot/dts/imx6sll.dtsi                     |   12 +-
 arch/arm/boot/dts/imx6sx-nitrogen6sx.dts           |   20 +-
 arch/arm/boot/dts/imx6sx-pinfunc.h                 |  286 +++--
 arch/arm/boot/dts/imx6sx-sabreauto.dts             |    4 +-
 arch/arm/boot/dts/imx6sx-sdb.dtsi                  |   12 +-
 arch/arm/boot/dts/imx6sx-softing-vining-2000.dts   |   22 +-
 arch/arm/boot/dts/imx6sx-udoo-neo.dtsi             |   28 +-
 arch/arm/boot/dts/imx6sx.dtsi                      |   34 +-
 arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts        |    2 +-
 arch/arm/boot/dts/imx6ul-pico-dwarf.dts            |   52 +
 arch/arm/boot/dts/imx6ul-pico.dtsi                 |   39 +-
 arch/arm/boot/dts/imx6ul.dtsi                      |   28 +-
 arch/arm/boot/dts/imx6ull.dtsi                     |    2 +-
 arch/arm/boot/dts/imx7-colibri-aster.dtsi          |  169 +++
 arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi        |   46 +-
 arch/arm/boot/dts/imx7-colibri.dtsi                |  230 +++-
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts            |    4 +-
 arch/arm/boot/dts/imx7d-colibri-aster.dts          |   20 +
 arch/arm/boot/dts/imx7d-colibri-emmc-aster.dts     |   20 +
 arch/arm/boot/dts/imx7d-colibri-emmc.dtsi          |   26 +
 arch/arm/boot/dts/imx7d-colibri-eval-v3.dts        |   41 +-
 arch/arm/boot/dts/imx7d-colibri.dtsi               |   41 +-
 arch/arm/boot/dts/imx7d-pico-dwarf.dts             |   87 ++
 arch/arm/boot/dts/imx7d-pico-nymph.dts             |   84 ++
 arch/arm/boot/dts/imx7s-colibri-aster.dts          |   15 +
 arch/arm/boot/dts/imx7s-colibri-eval-v3.dts        |   41 +-
 arch/arm/boot/dts/imx7s-colibri.dtsi               |   41 +-
 arch/arm/boot/dts/imx7s.dtsi                       |   38 +-
 arch/arm/boot/dts/imx7ulp-evk.dts                  |    3 +-
 arch/arm/boot/dts/imx7ulp.dtsi                     |    4 +-
 arch/arm/boot/dts/integratorap.dts                 |    1 -
 arch/arm/boot/dts/mt2701.dtsi                      |    2 +-
 arch/arm/boot/dts/mt7623.dtsi                      |    2 +-
 arch/arm/boot/dts/mt7629.dtsi                      |   16 +-
 arch/arm/boot/dts/omap4-l4.dtsi                    |    1 +
 arch/arm/boot/dts/omap4.dtsi                       |  279 +++--
 arch/arm/boot/dts/omap5-l4-abe.dtsi                |   16 +-
 arch/arm/boot/dts/omap5.dtsi                       |  241 +++--
 arch/arm/boot/dts/qcom-apq8064.dtsi                |    1 +
 arch/arm/boot/dts/qcom-apq8084.dtsi                |    1 +
 arch/arm/boot/dts/qcom-ipq4019.dtsi                |    1 +
 arch/arm/boot/dts/qcom-ipq8064.dtsi                |    1 +
 arch/arm/boot/dts/qcom-mdm9615.dtsi                |    1 +
 arch/arm/boot/dts/qcom-msm8660.dtsi                |    1 +
 arch/arm/boot/dts/qcom-msm8960.dtsi                |    1 +
 .../dts/qcom-msm8974-lge-nexus5-hammerhead.dts     |   71 ++
 .../boot/dts/qcom-msm8974-sony-xperia-honami.dts   |   25 +
 arch/arm/boot/dts/qcom-msm8974.dtsi                |   10 +
 arch/arm/boot/dts/r7s72100-gr-peach.dts            |    3 +
 arch/arm/boot/dts/r7s72100.dtsi                    |    5 +-
 arch/arm/boot/dts/r8a73a4-ape6evm.dts              |    7 +-
 arch/arm/boot/dts/r8a7743.dtsi                     |    5 +-
 arch/arm/boot/dts/r8a7744.dtsi                     |    5 +-
 .../arm/boot/dts/r8a7745-iwg22d-sodimm-dbhd-ca.dts |    6 +
 arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts        |   93 ++
 arch/arm/boot/dts/r8a7745.dtsi                     |    3 +-
 arch/arm/boot/dts/r8a77470.dtsi                    |    5 +-
 arch/arm/boot/dts/r8a7790-lager.dts                |    1 +
 arch/arm/boot/dts/r8a7790-stout.dts                |    1 +
 arch/arm/boot/dts/r8a7790.dtsi                     |    2 +
 arch/arm/boot/dts/r8a7791-koelsch.dts              |    1 +
 arch/arm/boot/dts/r8a7791-porter.dts               |    1 +
 arch/arm/boot/dts/r8a7791.dtsi                     |    5 +-
 arch/arm/boot/dts/r8a7792.dtsi                     |    5 +-
 arch/arm/boot/dts/r8a7793-gose.dts                 |    1 +
 arch/arm/boot/dts/r8a7793.dtsi                     |    5 +-
 arch/arm/boot/dts/r8a7794-alt.dts                  |    1 +
 arch/arm/boot/dts/r8a7794-silk.dts                 |    1 +
 arch/arm/boot/dts/r8a7794.dtsi                     |    2 +
 arch/arm/boot/dts/rk3036-kylin.dts                 |    2 +-
 arch/arm/boot/dts/rk3036.dtsi                      |    8 +-
 arch/arm/boot/dts/rk3066a.dtsi                     |   18 +-
 arch/arm/boot/dts/rk3188-bqedison2qc.dts           |   29 +-
 arch/arm/boot/dts/rk3188.dtsi                      |   10 +-
 arch/arm/boot/dts/rk322x.dtsi                      |   17 +-
 arch/arm/boot/dts/rk3288-evb-act8846.dts           |    1 +
 arch/arm/boot/dts/rk3288-evb-rk808.dts             |    1 +
 arch/arm/boot/dts/rk3288-firefly-reload.dts        |    1 +
 arch/arm/boot/dts/rk3288-r89.dts                   |    1 +
 arch/arm/boot/dts/rk3288-tinker.dtsi               |    1 +
 arch/arm/boot/dts/rk3288-vyasa.dts                 |   28 +-
 arch/arm/boot/dts/rk3288.dtsi                      |   26 +-
 arch/arm/boot/dts/rk3xxx.dtsi                      |    4 +-
 arch/arm/boot/dts/rv1108.dtsi                      |   12 +-
 arch/arm/boot/dts/sam9x60.dtsi                     |    8 +
 arch/arm/boot/dts/sama5d2.dtsi                     |    2 +-
 arch/arm/boot/dts/sama5d3.dtsi                     |   33 +-
 arch/arm/boot/dts/sama5d4.dtsi                     |   35 +-
 arch/arm/boot/dts/sh73a0-kzm9g.dts                 |    9 +-
 arch/arm/boot/dts/socfpga_arria10.dtsi             |   12 +-
 arch/arm/boot/dts/socfpga_arria10_socdk_nand.dts   |    4 +-
 arch/arm/boot/dts/ste-ab8500.dtsi                  |    6 +-
 arch/arm/boot/dts/ste-ab8505.dtsi                  |    6 +-
 arch/arm/boot/dts/ste-dbx5x0.dtsi                  |    6 +-
 arch/arm/boot/dts/ste-href-stuib.dtsi              |    2 +-
 arch/arm/boot/dts/ste-href-tvk1281618-r2.dtsi      |    2 +-
 arch/arm/boot/dts/ste-href-tvk1281618-r3.dtsi      |    2 +-
 arch/arm/boot/dts/ste-ux500-samsung-skomer.dts     |  581 +++++++++++
 arch/arm/boot/dts/stm32746g-eval.dts               |    2 +-
 arch/arm/boot/dts/stm32mp15-pinctrl.dtsi           |   93 ++
 arch/arm/boot/dts/stm32mp151.dtsi                  |   16 +-
 arch/arm/boot/dts/stm32mp153.dtsi                  |    1 +
 arch/arm/boot/dts/stm32mp157a-avenger96.dts        |   11 +-
 arch/arm/boot/dts/stm32mp157c-dhcom-pdk2.dts       |  265 +++++
 arch/arm/boot/dts/stm32mp157c-dhcom-som.dtsi       |  368 +++++++
 arch/arm/boot/dts/stm32mp157c-ed1.dts              |   16 +-
 arch/arm/boot/dts/stm32mp157c-ev1.dts              |   13 +-
 arch/arm/boot/dts/stm32mp15xx-dkx.dtsi             |   10 +-
 .../boot/dts/sun5i-a13-pocketbook-touch-lux-3.dts  |  257 +++++
 arch/arm/boot/dts/sun5i.dtsi                       |    3 -
 arch/arm/boot/dts/sun6i-a31.dtsi                   |   12 -
 .../boot/dts/sun7i-a20-linutronix-testbox-v2.dts   |   47 +
 arch/arm/boot/dts/sun7i-a20.dtsi                   |   25 +-
 arch/arm/boot/dts/sun8i-a23-a33.dtsi               |    3 -
 arch/arm/boot/dts/sun8i-a33.dtsi                   |    2 -
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts          |    1 -
 arch/arm/boot/dts/sun8i-a83t.dtsi                  |   73 +-
 arch/arm/boot/dts/sun8i-h3.dtsi                    |   25 +
 arch/arm/boot/dts/sun8i-r40.dtsi                   |   30 +-
 arch/arm/boot/dts/sun8i-v3s.dtsi                   |    2 +-
 arch/arm/boot/dts/sunxi-h3-h5.dtsi                 |   17 +-
 arch/arm/boot/dts/tegra114-dalmore.dts             |    8 +-
 arch/arm/boot/dts/tegra114.dtsi                    |    4 +-
 arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi        |    8 +-
 arch/arm/boot/dts/tegra124-apalis.dtsi             |    8 +-
 arch/arm/boot/dts/tegra124-jetson-tk1.dts          |   14 +-
 arch/arm/boot/dts/tegra124-nyan.dtsi               |    8 +-
 arch/arm/boot/dts/tegra124-venice2.dts             |    8 +-
 arch/arm/boot/dts/tegra124.dtsi                    |    4 +-
 arch/arm/boot/dts/tegra20.dtsi                     |    4 +-
 arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi         |    8 +-
 arch/arm/boot/dts/tegra30-apalis.dtsi              |    8 +-
 arch/arm/boot/dts/tegra30-beaver.dts               |    8 +-
 arch/arm/boot/dts/tegra30-cardhu.dtsi              |    8 +-
 arch/arm/boot/dts/tegra30-colibri.dtsi             |    8 +-
 arch/arm/boot/dts/tegra30.dtsi                     |    4 +-
 arch/arm/boot/dts/uniphier-ld4.dtsi                |   10 +-
 arch/arm/boot/dts/uniphier-pro4.dtsi               |   12 +-
 arch/arm/boot/dts/uniphier-pro5.dtsi               |  164 ++-
 arch/arm/boot/dts/uniphier-pxs2.dtsi               |   14 +-
 arch/arm/boot/dts/uniphier-ref-daughter.dtsi       |    2 +-
 arch/arm/boot/dts/uniphier-sld8.dtsi               |   10 +-
 arch/arm/boot/dts/versatile-ab-ib2.dts             |    2 +-
 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi            |    2 +-
 arch/arm/boot/dts/vexpress-v2m.dtsi                |    2 +-
 arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts        |    2 +-
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts         |    2 +-
 arch/arm/boot/dts/vexpress-v2p-ca5s.dts            |    2 +-
 arch/arm/boot/dts/vexpress-v2p-ca9.dts             |    2 +-
 arch/arm/boot/dts/vf-colibri-eval-v3.dtsi          |   40 +-
 arch/arm/boot/dts/vf-colibri.dtsi                  |   39 +-
 arch/arm/boot/dts/vf500-colibri-eval-v3.dts        |   40 +-
 arch/arm/boot/dts/vf500-colibri.dtsi               |   40 +-
 arch/arm/boot/dts/vf500.dtsi                       |    4 +-
 arch/arm/boot/dts/vf610-colibri-eval-v3.dts        |   40 +-
 arch/arm/boot/dts/vf610-colibri.dtsi               |   40 +-
 arch/arm/boot/dts/vf610-zii-cfu1.dts               |    8 +
 arch/arm/boot/dts/vf610-zii-dev.dtsi               |    8 +
 arch/arm/boot/dts/vf610-zii-spb4.dts               |    8 +
 arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts           |    8 +
 arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts          |    8 +
 arch/arm/boot/dts/vf610m4-colibri.dts              |   39 +-
 arch/arm/boot/dts/vfxxx.dtsi                       |    4 +-
 .../mach-omap2/omap_hwmod_33xx_43xx_common_data.h  |   10 -
 .../omap_hwmod_33xx_43xx_interconnect_data.c       |   40 -
 .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c |  115 --
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |   14 -
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c         |  114 --
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |  531 ----------
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c         |  288 -----
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          |  251 -----
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c         |  231 -----
 arch/arm/mach-omap2/pdata-quirks.c                 |    6 +
 arch/arm64/boot/dts/allwinner/Makefile             |    3 +
 .../boot/dts/allwinner/sun50i-a64-olinuxino.dts    |   17 +
 .../boot/dts/allwinner/sun50i-a64-pinebook.dts     |  170 +--
 .../dts/allwinner/sun50i-a64-pinephone-1.0.dts     |   11 +
 .../dts/allwinner/sun50i-a64-pinephone-1.1.dts     |   11 +
 .../boot/dts/allwinner/sun50i-a64-pinephone.dtsi   |  379 +++++++
 .../boot/dts/allwinner/sun50i-a64-pinetab.dts      |  460 ++++++++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      |   44 +-
 .../boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts  |   21 +
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi       |    3 +-
 .../boot/dts/allwinner/sun50i-h6-beelink-gs1.dts   |   11 +
 .../boot/dts/allwinner/sun50i-h6-orangepi-3.dts    |   20 +
 .../dts/allwinner/sun50i-h6-orangepi-one-plus.dts  |   33 +
 .../boot/dts/allwinner/sun50i-h6-orangepi.dtsi     |   37 +
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts      |   30 +
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi       |   66 +-
 .../boot/dts/altera/socfpga_stratix10_socdk.dts    |    6 +-
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi          |    6 +
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts     |    6 +-
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi  |  136 ++-
 arch/arm64/boot/dts/amlogic/meson-g12.dtsi         |    2 +
 arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts  |    4 +-
 arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts    |    2 +-
 arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts |    2 +-
 .../boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi   |    4 +-
 .../boot/dts/amlogic/meson-g12b-odroid-n2.dts      |   25 +-
 .../boot/dts/amlogic/meson-g12b-ugoos-am6.dts      |    2 +-
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi          |   52 +
 arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dts |    4 +
 .../arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts |    1 +
 .../boot/dts/amlogic/meson-gxbb-vega-s95.dtsi      |    3 +
 .../boot/dts/amlogic/meson-gxl-s905x-p212.dtsi     |    9 +-
 .../boot/dts/amlogic/meson-gxm-khadas-vim2.dts     |   89 +-
 arch/arm64/boot/dts/amlogic/meson-gxm.dtsi         |   28 +
 arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi |   24 +-
 arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts   |    2 +-
 arch/arm64/boot/dts/amlogic/meson-sm1.dtsi         |    1 +
 arch/arm64/boot/dts/arm/foundation-v8.dtsi         |    2 +-
 arch/arm64/boot/dts/arm/fvp-base-revc.dts          |    2 +-
 arch/arm64/boot/dts/arm/juno-base.dtsi             |    2 +-
 arch/arm64/boot/dts/arm/juno-motherboard.dtsi      |    2 +-
 arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts         |    2 +-
 .../boot/dts/arm/rtsm_ve-motherboard-rs2.dtsi      |    2 +-
 arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi   |    2 +-
 .../boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts      |    2 +-
 arch/arm64/boot/dts/freescale/Makefile             |    6 +
 .../fsl-ls1028a-kontron-kbox-a-230-ls.dts          |   91 ++
 .../freescale/fsl-ls1028a-kontron-sl28-var2.dts    |   72 ++
 .../fsl-ls1028a-kontron-sl28-var3-ads2.dts         |  117 +++
 .../freescale/fsl-ls1028a-kontron-sl28-var4.dts    |   51 +
 .../dts/freescale/fsl-ls1028a-kontron-sl28.dts     |  187 ++++
 arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts  |    1 +
 arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts  |   65 +-
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi     |  184 +++-
 arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts  |    1 +
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi     |    4 +
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi     |    4 +
 .../arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi |   37 +
 arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts  |   15 +
 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts  |    4 +-
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi     |  168 +++
 arch/arm64/boot/dts/freescale/imx8mm-evk.dts       |    2 +
 arch/arm64/boot/dts/freescale/imx8mm.dtsi          |   74 +-
 arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi      |   21 +
 arch/arm64/boot/dts/freescale/imx8mn.dtsi          |   81 +-
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts       |  270 +++++
 arch/arm64/boot/dts/freescale/imx8mp-pinfunc.h     |  931 +++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mp.dtsi          |  654 ++++++++++++
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts       |    2 +
 .../boot/dts/freescale/imx8mq-librem5-devkit.dts   |  148 ++-
 arch/arm64/boot/dts/freescale/imx8mq-phanbell.dts  |  104 ++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi          |   18 +-
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi         |   39 +
 arch/arm64/boot/dts/freescale/s32v234.dtsi         |    4 +-
 arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts |    6 +-
 arch/arm64/boot/dts/marvell/Makefile               |    3 +
 .../dts/marvell/armada-3720-espressobin-emmc.dts   |    2 +
 .../marvell/armada-3720-espressobin-v7-emmc.dts    |    2 +
 .../dts/marvell/armada-3720-espressobin-v7.dts     |    2 +
 .../boot/dts/marvell/armada-3720-espressobin.dtsi  |    8 +-
 .../dts/marvell/armada-8040-clearfog-gt-8k.dts     |    1 +
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi |    3 +
 arch/arm64/boot/dts/marvell/armada-ap806-dual.dtsi |    5 +
 arch/arm64/boot/dts/marvell/armada-ap807-quad.dtsi |    8 +-
 arch/arm64/boot/dts/mediatek/Makefile              |    1 +
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi          |    8 +-
 arch/arm64/boot/dts/mediatek/mt6797.dtsi           |    2 +-
 arch/arm64/boot/dts/mediatek/mt7622.dtsi           |    2 +-
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |    3 +-
 arch/arm64/boot/dts/mediatek/mt8183.dtsi           |   53 +
 arch/arm64/boot/dts/mediatek/mt8516-pinfunc.h      |  663 ++++++++++++
 arch/arm64/boot/dts/mediatek/mt8516-pumpkin.dts    |   20 +
 arch/arm64/boot/dts/mediatek/mt8516.dtsi           |  457 ++++++++
 arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi   |  221 ++++
 arch/arm64/boot/dts/nvidia/tegra132.dtsi           |    4 +-
 arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts |   26 +-
 arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi     |    1 +
 arch/arm64/boot/dts/nvidia/tegra186.dtsi           |   19 +
 arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi     |   36 +-
 arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts |   81 ++
 arch/arm64/boot/dts/nvidia/tegra194.dtsi           |  250 ++++-
 arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi     |    3 +
 arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts |    2 +
 arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi     |   45 +-
 arch/arm64/boot/dts/nvidia/tegra210-p3450-0000.dts |   24 +-
 arch/arm64/boot/dts/nvidia/tegra210-smaug.dts      |    2 +-
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           |   25 +-
 arch/arm64/boot/dts/qcom/Makefile                  |    2 +
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi          |    1 -
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi       |    6 -
 arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts       |   64 ++
 arch/arm64/boot/dts/qcom/ipq6018.dtsi              |  443 ++++++++
 arch/arm64/boot/dts/qcom/ipq8074.dtsi              |    1 +
 .../dts/qcom/msm8916-samsung-a2015-common.dtsi     |    8 +
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |   21 +-
 arch/arm64/boot/dts/qcom/msm8992.dtsi              |    1 +
 arch/arm64/boot/dts/qcom/msm8994.dtsi              |    1 +
 arch/arm64/boot/dts/qcom/msm8996.dtsi              |   33 +-
 arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi          |    8 +-
 arch/arm64/boot/dts/qcom/msm8998.dtsi              |   16 +-
 arch/arm64/boot/dts/qcom/pm6150.dtsi               |    2 +-
 arch/arm64/boot/dts/qcom/pm8998.dtsi               |    2 +-
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi           |    1 +
 arch/arm64/boot/dts/qcom/qcs404.dtsi               |    4 +-
 arch/arm64/boot/dts/qcom/sc7180-idp.dts            |   64 +-
 arch/arm64/boot/dts/qcom/sc7180.dtsi               |  605 ++++++++++-
 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi         |   15 +
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts         |  283 +++++
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts            |   89 ++
 arch/arm64/boot/dts/qcom/sdm845.dtsi               |  672 +++++++++++-
 .../boot/dts/qcom/sdm850-lenovo-yoga-c630.dts      |  114 ++
 arch/arm64/boot/dts/qcom/sm8250-mtp.dts            |   29 +
 arch/arm64/boot/dts/qcom/sm8250.dtsi               |  444 ++++++++
 arch/arm64/boot/dts/renesas/Makefile               |    6 +-
 .../r8a774a1-hihope-rzg2m-ex-idk-1110wr.dts        |   52 +
 arch/arm64/boot/dts/renesas/r8a774a1.dtsi          |    7 +-
 arch/arm64/boot/dts/renesas/r8a774b1.dtsi          |    7 +-
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi          |    8 +-
 arch/arm64/boot/dts/renesas/r8a77950.dtsi          |    2 +-
 arch/arm64/boot/dts/renesas/r8a77951.dtsi          |   11 +-
 arch/arm64/boot/dts/renesas/r8a77960.dtsi          |   16 +-
 .../boot/dts/renesas/r8a77961-salvator-xs.dts      |    2 +-
 arch/arm64/boot/dts/renesas/r8a77961-ulcb.dts      |   32 +
 arch/arm64/boot/dts/renesas/r8a77961.dtsi          |   89 ++
 arch/arm64/boot/dts/renesas/r8a77965.dtsi          |   31 +-
 arch/arm64/boot/dts/renesas/r8a77970.dtsi          |    4 +-
 arch/arm64/boot/dts/renesas/r8a77980.dtsi          |    7 +-
 arch/arm64/boot/dts/renesas/r8a77990.dtsi          |   29 +-
 arch/arm64/boot/dts/renesas/r8a77995.dtsi          |   14 +-
 arch/arm64/boot/dts/rockchip/Makefile              |    1 +
 arch/arm64/boot/dts/rockchip/px30.dtsi             |   32 +-
 arch/arm64/boot/dts/rockchip/rk3308.dtsi           |   10 +-
 arch/arm64/boot/dts/rockchip/rk3328-a1.dts         |    1 +
 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts     |    1 +
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           |    7 +-
 arch/arm64/boot/dts/rockchip/rk3368-px5-evb.dts    |    1 -
 arch/arm64/boot/dts/rockchip/rk3368.dtsi           |    3 +-
 arch/arm64/boot/dts/rockchip/rk3399-evb.dts        |  270 ++++-
 .../boot/dts/rockchip/rk3399-gru-chromebook.dtsi   |    4 +-
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi       |    4 +-
 arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts |   39 +-
 arch/arm64/boot/dts/rockchip/rk3399-orangepi.dts   |   43 +-
 .../boot/dts/rockchip/rk3399-pinebook-pro.dts      | 1096 ++++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi      |    2 +-
 arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi   |    2 +-
 .../dts/rockchip/rk3399-sapphire-excavator.dts     |    2 -
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           |   11 +-
 .../boot/dts/rockchip/rk3399pro-rock-pi-n10.dts    |    3 +-
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi   |   10 +-
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi   |   20 +-
 .../arm64/boot/dts/socionext/uniphier-pxs3-ref.dts |   10 +
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi   |   55 +-
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi           |    4 +
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi            |   12 +
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi    |   20 +
 drivers/bus/ti-sysc.c                              |  606 +++++++++--
 drivers/clk/imx/clk-imx8mn.c                       |    1 +
 drivers/clk/ti/clk-814x.c                          |    7 +-
 drivers/gpu/drm/omapdrm/dss/dss.c                  |   25 +-
 drivers/gpu/drm/omapdrm/dss/omapdss-boot-init.c    |   25 +-
 include/dt-bindings/bus/ti-sysc.h                  |    4 +
 include/dt-bindings/clock/dm814.h                  |    5 +
 include/dt-bindings/clock/g12a-clkc.h              |    2 +
 include/dt-bindings/clock/gxbb-clkc.h              |    1 +
 include/dt-bindings/clock/imx8mn-clock.h           |    4 +-
 include/dt-bindings/clock/tegra114-car.h           |    4 +-
 include/dt-bindings/clock/tegra124-car-common.h    |    4 +-
 include/dt-bindings/clock/tegra210-car.h           |    4 +-
 include/dt-bindings/clock/tegra30-car.h            |    4 +-
 include/dt-bindings/soc/tegra-pmc.h                |   16 +
 include/linux/platform_data/ti-sysc.h              |    5 +
 506 files changed, 20094 insertions(+), 4929 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/arm,integrator.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/arm,realview.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/arm,versatile.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/arm,vexpress-juno.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/arm-boards
 delete mode 100644
Documentation/devicetree/bindings/arm/bcm/brcm,bcm11351-cpu-method.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm11351.txt
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm11351.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm21664.txt
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm21664.yaml
 delete mode 100644
Documentation/devicetree/bindings/arm/bcm/brcm,bcm23550-cpu-method.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm23550.txt
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm23550.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.txt
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,cygnus.txt
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,cygnus.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,hr2.txt
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,hr2.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,ns2.txt
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,ns2.yaml
 delete mode 100644
Documentation/devicetree/bindings/arm/bcm/brcm,nsp-cpu-method.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,nsp.txt
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,nsp.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,stingray.txt
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,stingray.yaml
 delete mode 100644
Documentation/devicetree/bindings/arm/bcm/brcm,vulcan-soc.txt
 create mode 100644
Documentation/devicetree/bindings/arm/bcm/brcm,vulcan-soc.yaml
 delete mode 100644
Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
 create mode 100644
Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/vexpress.txt
 create mode 100644 Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml
 create mode 100644 arch/arm/boot/dts/am57-pruss.dtsi
 create mode 100644 arch/arm/boot/dts/imx6dl-pico-dwarf.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-pico-hobbit.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-pico-nymph.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-pico-pi.dts
 create mode 100644 arch/arm/boot/dts/imx6q-pico-dwarf.dts
 create mode 100644 arch/arm/boot/dts/imx6q-pico-hobbit.dts
 create mode 100644 arch/arm/boot/dts/imx6q-pico-nymph.dts
 create mode 100644 arch/arm/boot/dts/imx6q-pico-pi.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-pico-dwarf.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-pico-hobbit.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-pico-nymph.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-pico-pi.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-pico.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ul-pico-dwarf.dts
 create mode 100644 arch/arm/boot/dts/imx7-colibri-aster.dtsi
 create mode 100644 arch/arm/boot/dts/imx7d-colibri-aster.dts
 create mode 100644 arch/arm/boot/dts/imx7d-colibri-emmc-aster.dts
 create mode 100644 arch/arm/boot/dts/imx7d-pico-dwarf.dts
 create mode 100644 arch/arm/boot/dts/imx7d-pico-nymph.dts
 create mode 100644 arch/arm/boot/dts/imx7s-colibri-aster.dts
 create mode 100644 arch/arm/boot/dts/ste-ux500-samsung-skomer.dts
 create mode 100644 arch/arm/boot/dts/stm32mp157c-dhcom-pdk2.dts
 create mode 100644 arch/arm/boot/dts/stm32mp157c-dhcom-som.dtsi
 create mode 100644 arch/arm/boot/dts/sun5i-a13-pocketbook-touch-lux-3.dts
 create mode 100644 arch/arm/boot/dts/sun7i-a20-linutronix-testbox-v2.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.0.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.1.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts
 create mode 100644
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dts
 create mode 100644
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var2.dts
 create mode 100644
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts
 create mode 100644
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var4.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-evk.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-pinfunc.h
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8516-pinfunc.h
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8516-pumpkin.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8516.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts
 create mode 100644 arch/arm64/boot/dts/qcom/ipq6018.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sm8250-mtp.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sm8250.dtsi
 create mode 100644
arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-ex-idk-1110wr.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a77961-ulcb.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
 create mode 100644 include/dt-bindings/soc/tegra-pmc.h
