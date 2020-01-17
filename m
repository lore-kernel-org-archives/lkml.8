Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA912C33CAF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 03:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BBFD206D7
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 03:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="Zih8JThE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389186AbgAQDAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 22:00:53 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45430 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389072AbgAQDAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 22:00:53 -0500
Received: by mail-lj1-f195.google.com with SMTP id j26so24846450ljc.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 19:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=HryF0usTtZp2gFg2eq59o17S0qqTz/KJKOS371wsBMs=;
        b=Zih8JThEp0fTCaA//HvuxRgK7a0lL1TTiBuKX4yDZtnYgTIhTj28lnQhty+vs5W9JJ
         w9ODzcyBiGX0g3DWa8r8Zl1vuqTV4uW9KX2FS6COESkIn57OBcriyuUmPG7+LJylPYHI
         HsQCVCeaywpzsPB8MhPWsUzI8PdLejUwc258vVEW1P62Bm3ZCfLd+Llbu6coMvrCCkGz
         2x7dXwrrgwJ1bO8ZiTqkLWdRzAYbdborkatm+rsx0qOxBhD5U7E5b82R+d9bNZmhej4l
         VIIFZ7HixQ1uWTLMTwIG5nK9Aq5juo2ORzkCzHJzwBbKRbrlk+MMVc6XAknV9RbLg2Wu
         t9IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=HryF0usTtZp2gFg2eq59o17S0qqTz/KJKOS371wsBMs=;
        b=qLOsNbYi2WVHDTbJwD8mF4gkCUAU4YHF7pojWrzzRq7pUf34vDVt/CDUFD2uEfCHFX
         RVWSoWfyda07uPMp+EYi3Y2gnS3yEM7bkB2TItZSc9As01HCBT1prShCLJmHHNK6JesU
         2oQC0OdS+P2TTN+I+O8qi8tLDkYP2gTNJgkxn4Rm7XDHEcGNc4TDzNIJDVmbXHxZuSCU
         +n9EUXBxZCRDMXkr+qRwOqgHUT1scGW9btRP8dGxBLipN1Ln+npMsqiUK5vgut13PL1T
         FzVgWBLYbMxQQdruzvE8lRls2X8DZglSsCzHgUAkNQ4YIjB1rjoib/v67asvY634eybj
         +qCQ==
X-Gm-Message-State: APjAAAViZX5NykTURMhdk6zm8+YrRMhB0+Wk6zt/3xJ5fAixBravkemX
        ItDpmrje2V5JaEDwait1RUekYA==
X-Google-Smtp-Source: APXvYqw2hwTwWHAdrmowqh/nOKzARYTu/fVsFiQXCiY6bdE6DnOVbZ0KHX3+uJUSZxR6elJs5SHNuw==
X-Received: by 2002:a2e:9cd8:: with SMTP id g24mr4146941ljj.243.1579230050458;
        Thu, 16 Jan 2020 19:00:50 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id z7sm11639182lji.30.2020.01.16.19.00.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Jan 2020 19:00:48 -0800 (PST)
Date:   Thu, 16 Jan 2020 19:00:40 -0800
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     olof@lixom.net, arm@kernel.org, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: SoC fixes
Message-ID: <20200117030040.5m3qqibo5kn6x3le@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit ea200dec51285c82655e50ddb774fdb6b97e784d:

  Merge tag 'armsoc-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc (2019-12-16 16:43:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-fixes

for you to fetch changes up to 70db729fe1b30af89e798d16c1045846753e5448:

  MAINTAINERS: Add myself as the co-maintainer for Actions Semi platforms (2020-01-16 15:49:19 -0800)

----------------------------------------------------------------
ARM: SoC fixes

I've been sitting on these longer than I meant, so the patch count is
a bit higher than ideal for this part of the release. There's also some
reverts of double-applied patches that brings the diffstat up a bit.

With that said, the biggest changes are:

 - Revert of duplicate i2c device addition on two Aspeed (BMC) Devicetrees.
 - Move of two device nodes that got applied to the wrong part of the
   tree on ASpeed G6.
 - Regulator fix for Beaglebone X15 (adding 12/5V supplies)
 - Use interrupts for keys on Amlogic SM1 to avoid missed polls

In addition to that, there is a collection of smaller DT fixes:

 - Power supply assignment fixes for i.MX6
 - Fix of interrupt line for magnetometer on i.MX8 Librem5 devkit
 - Build fixlets (selects) for davinci/omap2+
 - More interrupt number fixes for Stratix10, Amlogic SM1, etc.
 - ... and more similar fixes across different platforms

And some non-DT stuff:

 - optee fix to register multiple shared pages properly
 - Clock calculation fixes for MMP3
 - Clock fixes for OMAP as well

----------------------------------------------------------------
Adam Ford (1):
      arm64: dts: imx8mm: Change SDMA1 ahb clock for imx8mm

Alexandre Belloni (1):
      ARM: dts: imx6q-dhcom: fix rtc compatible

Angus Ainslie (Purism) (1):
      arm64: dts: imx8mq-librem5-devkit: use correct interrupt for the magnetometer

Anson Huang (4):
      ARM: dts: imx6qdl-sabresd: Remove incorrect power supply assignment
      ARM: dts: imx6sx-sdb: Remove incorrect power supply assignment
      ARM: dts: imx6sl-evk: Remove incorrect power supply assignment
      ARM: dts: imx6sll-evk: Remove incorrect power supply assignment

Arnd Bergmann (2):
      ARM: davinci: select CONFIG_RESET_CONTROLLER
      ARM: omap2plus: select RESET_CONTROLLER

Brandon Wyman (1):
      ARM: dts: aspeed: rainier: Fix fan fault and presence

Dave Gerlach (1):
      soc: ti: wkup_m3_ipc: Fix race condition with rproc_boot

Dinh Nguyen (1):
      arm64: dts: agilex/stratix10: fix pmu interrupt numbers

Guillaume La Roque (1):
      arm64: dts: meson-sm1-sei610: add gpio bluetooth interrupt

Jagan Teki (1):
      ARM: dts: imx6q-icore-mipi: Use 1.5 version of i.Core MX6DL

Joel Stanley (5):
      ARM: dts: aspeed-g6: Fix FSI master location
      ARM: dts: aspeed: tacoma: Fix fsi master node
      ARM: dts: aspeed: tacoma: Remove duplicate i2c busses
      ARM: dts: aspeed: tacoma: Remove duplicate flash nodes
      ARM: dts: aspeed: rainier: Remove duplicate i2c busses

Kevin Hilman (1):
      arm64: dts: meson-sm1-sei610: gpio-keys: switch to IRQs

Kishon Vijay Abraham I (3):
      ARM: dts: am57xx-beagle-x15/am57xx-idk: Remove "gpios" for  endpoint dt nodes
      ARM: dts: am571x-idk: Fix gpios property to have the correct  gpio number
      ARM: dts: beagle-x15-common: Model 5V0 regulator

Lubomir Rintel (3):
      ARM: mmp: do not divide the clock rate
      clk: mmp2: Fix the order of timer mux parents
      ARM: dts: mmp3: Fix the TWSI ranges

Manivannan Sadhasivam (1):
      MAINTAINERS: Add myself as the co-maintainer for Actions Semi platforms

Marcel Ziswiler (1):
      ARM: dts: imx7: Fix Toradex Colibri iMX7S 256MB NAND flash support

Marek Szyprowski (1):
      ARM: dts: sun8i: a83t: Correct USB3503 GPIOs polarity

Marek Vasut (1):
      ARM: dts: imx6q-dhcom: Fix SGTL5000 VDDIO regulator connection

Martin Blumenstingl (4):
      ARM: dts: meson8: fix the size of the PMU registers
      soc: amlogic: meson-ee-pwrc: propagate PD provider registration errors
      soc: amlogic: meson-ee-pwrc: propagate errors from pm_genpd_init()
      dt-bindings: reset: meson8b: fix duplicate reset IDs

Olof Johansson (8):
      Merge tag 'socfpga_dts_fix_for_v5.5' of git://git.kernel.org/.../dinguyen/linux into arm/fixes
      Merge tag 'tee-optee-fix-for-5.5' of git://git.linaro.org:/people/jens.wiklander/linux-tee into arm/fixes
      Merge tag 'omap-for-v5.5/fixes-rc5' of git://git.kernel.org/.../tmlind/linux-omap into arm/fixes
      Merge tag 'aspeed-5.5-devicetree-fixes' of git://git.kernel.org/.../joel/aspeed into arm/fixes
      Merge tag 'amlogic-fixes' of https://git.kernel.org/.../khilman/linux-amlogic into arm/fixes
      Merge tag 'imx-fixes-5.5-2' of git://git.kernel.org/.../shawnguo/linux into arm/fixes
      Merge tag 'sunxi-fixes-for-5.5' of https://git.kernel.org/.../sunxi/linux into arm/fixes
      Merge tag 'v5.5-rockchip-dtsfixes' of git://git.kernel.org/.../mmind/linux-rockchip into arm/fixes

Peng Fan (1):
      ARM: dts: imx7ulp: fix reg of cpu node

Robin Murphy (1):
      arm64: dts: rockchip: Fix IR on Beelink A1

Stefan Mavrodiev (2):
      arm64: dts: allwinner: a64: olinuxino: Fix eMMC supply regulator
      arm64: dts: allwinner: a64: olinuxino: Fix SDIO supply regulator

Sumit Garg (1):
      optee: Fix multi page dynamic shm pool alloc

Tony Lindgren (2):
      ARM: OMAP2+: Fix ti_sysc_find_one_clockdomain to check for to_clk_hw_omap
      bus: ti-sysc: Fix iterating over clocks

Yinbo Zhu (1):
      arm64: dts: ls1028a: fix endian setting for dcfg

 MAINTAINERS                                        |   2 +-
 arch/arm/boot/dts/am571x-idk.dts                   |   6 +-
 arch/arm/boot/dts/am572x-idk-common.dtsi           |   4 -
 arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi    |  25 +-
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts       | 369 +------------------
 arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts        | 403 +--------------------
 arch/arm/boot/dts/aspeed-g6.dtsi                   |  39 +-
 arch/arm/boot/dts/imx6dl-icore-mipi.dts            |   2 +-
 arch/arm/boot/dts/imx6q-dhcom-pdk2.dts             |   2 +-
 arch/arm/boot/dts/imx6q-dhcom-som.dtsi             |   2 +-
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi             |   4 -
 arch/arm/boot/dts/imx6sl-evk.dts                   |   4 -
 arch/arm/boot/dts/imx6sll-evk.dts                  |   4 -
 arch/arm/boot/dts/imx6sx-sdb-reva.dts              |   4 -
 arch/arm/boot/dts/imx6sx-sdb.dts                   |   4 -
 arch/arm/boot/dts/imx7s-colibri.dtsi               |   4 +
 arch/arm/boot/dts/imx7ulp.dtsi                     |   4 +-
 arch/arm/boot/dts/meson8.dtsi                      |   2 +-
 arch/arm/boot/dts/mmp3.dtsi                        |  12 +-
 arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts   |   2 +-
 arch/arm/mach-davinci/Kconfig                      |   1 +
 arch/arm/mach-mmp/time.c                           |   2 +-
 arch/arm/mach-omap2/Kconfig                        |   3 +-
 arch/arm/mach-omap2/pdata-quirks.c                 |   6 +-
 .../dts/allwinner/sun50i-a64-olinuxino-emmc.dts    |   2 +-
 .../boot/dts/allwinner/sun50i-a64-olinuxino.dts    |   2 +-
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi  |   8 +-
 arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts   |  28 +-
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi     |   2 +-
 arch/arm64/boot/dts/freescale/imx8mm.dtsi          |   2 +-
 .../boot/dts/freescale/imx8mq-librem5-devkit.dts   |   2 +-
 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi      |   8 +-
 arch/arm64/boot/dts/rockchip/rk3328-a1.dts         |   3 +-
 drivers/bus/ti-sysc.c                              |  10 +-
 drivers/clk/mmp/clk-of-mmp2.c                      |   2 +-
 drivers/soc/amlogic/meson-ee-pwrc.c                |  24 +-
 drivers/soc/ti/wkup_m3_ipc.c                       |   4 +-
 drivers/tee/optee/shm_pool.c                       |  15 +-
 include/dt-bindings/reset/amlogic,meson8b-reset.h  |   6 +-
 39 files changed, 159 insertions(+), 869 deletions(-)
