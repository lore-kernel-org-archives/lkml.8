Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76729C10DCE
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 00:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 412DA20674
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 00:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="qmnOYPvb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgCHX7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 19:59:16 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39908 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbgCHX7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 19:59:16 -0400
Received: by mail-lf1-f65.google.com with SMTP id j15so6185873lfk.6
        for <linux-kernel@vger.kernel.org>; Sun, 08 Mar 2020 16:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=gpfW1kUuFhM7182RqjH19xKhw6BpdKRMuJE8branGb8=;
        b=qmnOYPvbLSFxeFDZg9tF8SXT03m1xMLOL8luWMan+ePCfC+LcCoZR4OKrAz7fvowVK
         eKKv8z/veXcdC3e7wW4uOne7gt6DA0HR/Z/MwOX/UsuBb383LEaNlFlR3BwFShRpurh5
         /5UMlgaj6ROwAUk3S6lB2o6h7+an3LUnA4Ppvf9n6DXEwFty59FEqCcwCEYZnDY+7QLu
         EyKBWADm2vy7G0Used1W70DSKNgHHAXUWui1Ns0Ce5LdwtZQII+IfA9G+ScMmInCV8KE
         qBwfs5f5Mw2FIwUzDFuctwuXrh1vp+ZFRrisyGx/MQFJuigTgIslNT4IQRkXpGGU8ezk
         ZPng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=gpfW1kUuFhM7182RqjH19xKhw6BpdKRMuJE8branGb8=;
        b=jN/kUf9CfvgPhM2u9Ix5obRocPDxQinnctt0LVrqF7yHaHJkIexu/nDkrt/mAdzX23
         LrDMKxb8FKRvdCH8cxufmLrhyrhPE80Fq6jG/++1E9CvGU2B6hEFFuUwSwgf1h0gVpt1
         71YMZ9RJXEDUUqnU0bn22HWx8m0BLYSDZdPOJvvI2y6oAUKc88gjmJWHPmFcE//dJjdg
         EmlSR6Z+twrJ3Evd/N39JFoSCKDYKeNTGLokH3+xjIBuI4SsAiIUaBMnEmbPQuqTgjmr
         9SBwQ6g+cMyhk831DMv1tG1005OhXsBk5M6Z+bLkvh5JhkNYrIZT/yEpKgrYW8uLSlgc
         pNTg==
X-Gm-Message-State: ANhLgQ0nPEPVJJLcLCxXEktH2zegqvoXPP8IVIqRlSZtM5yzed/pi67I
        bfPlgc/EswSsV4DFRcLsuKdMnw==
X-Google-Smtp-Source: ADFU+vtOl9nxzMfXncxrYriF9/aFjAXydSWXX5geSQ1Ta9p9xopwmbK9NSfQDRDWy5wpsuHEZS9wCQ==
X-Received: by 2002:ac2:4c15:: with SMTP id t21mr3584816lfq.117.1583711952334;
        Sun, 08 Mar 2020 16:59:12 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id r186sm6551310lff.66.2020.03.08.16.59.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 08 Mar 2020 16:59:10 -0700 (PDT)
Date:   Sun, 8 Mar 2020 16:58:42 -0700
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
List-Id: <soc.lore.kernel.org>
Cc:     olof@lixom.net, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, arm@kernel.org,
        soc@kernel.org
Subject: [GIT PULL] ARM: SoC fixes
Message-ID: <20200308235842.gjmjv5ag4yma4exc@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 98d54f81e36ba3bf92172791eba5ca5bd813989b:

  Linux 5.6-rc4 (2020-03-01 16:38:46 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-fixes

for you to fetch changes up to d4d89e25fc7b4225211c217491e5525b00cf3961:

  Merge tag 'socfpga_defconfig_fix_for_v5.6' of git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux into arm/fixes (2020-03-04 08:51:55 -0800)

----------------------------------------------------------------
ARM: SoC fixes

We've been accruing these for a couple of weeks, so the batch is a bit
bigger than usual.

Largest delta is due to a led-bl driver that is added -- there was
a miscommunication before the merge window and the driver didn't make it
in. Due to this, the platforms needing it regressed. At this point, it
seemed easier to add the new driver than unwind the changes.

Besides that, there are a handful of various fixes:

 - AMD tee memory leak fix

 - A handful of fixlets for i.MX SCU communication

 - A few maintainers woke up and realized DEBUG_FS had been missing for
   a while, so a few updates of that.

 ... and the usual collection of smaller fixes to various platforms.

----------------------------------------------------------------
Ahmad Fatoum (1):
      ARM: imx: build v7_cpu_resume() unconditionally

Brendan Higgins (2):
      reset: brcmstb-rescal: add unspecified HAS_IOMEM dependency
      reset: intel: add unspecified HAS_IOMEM dependency

Christian Hewitt (1):
      arm64: dts: meson: fix gxm-khadas-vim2 wifi

Dan Carpenter (1):
      tee: amdtee: fix memory leak in amdtee_open_session()

Dinh Nguyen (1):
      ARM: socfpga_defconfig: Add back DEBUG_FS

Fabio Estevam (1):
      arm64: dts: imx8qxp-mek: Remove unexisting Ethernet PHY

Faiz Abbas (1):
      arm: dts: dra76x: Fix mmc3 max-frequency

Geert Uytterhoeven (3):
      arm64: defconfig: Replace ARCH_R8A7796 by ARCH_R8A77960
      ARM: dts: r8a7779: Remove deprecated "renesas, rcar-sata" compatible value
      ARM: meson: Drop unneeded select of COMMON_CLK

Grygorii Strashko (1):
      ARM: dts: dra7-l4: mark timer13-16 as pwm capable

Guillaume La Roque (1):
      arm64: dts: meson-sm1-sei610: add missing interrupt-names

Johan Hovold (1):
      ARM: dts: imx6dl-colibri-eval-v3: fix sram compatible properties

Kishon Vijay Abraham I (1):
      ARM: dts: dra7: Add "dma-ranges" property to PCIe RC DT nodes

Leonard Crestez (5):
      firmware: imx: scu: Ensure sequential TX
      firmware: imx: misc: Align imx sc msg structs to 4
      firmware: imx: scu-pd: Align imx sc msg structs to 4
      firmware: imx: Align imx_sc_msg_req_cpu_start to 4
      soc: imx-scu: Align imx sc msg structs to 4

Ley Foon Tan (1):
      arm64: dts: socfpga: agilex: Fix gmac compatible

Lukas Bulwahn (1):
      MAINTAINERS: fix style in RESET CONTROLLER FRAMEWORK

Marco Felsch (1):
      ARM: dts: imx6: phycore-som: fix emmc supply

Nicolas Saenz Julienne (1):
      ARM: dts: bcm2711: Add pcie0 alias

Oleksandr Suvorov (1):
      ARM: dts: imx7-colibri: Fix frequency for sd/mmc

Olof Johansson (11):
      Merge tag 'reset-fixes-for-v5.6' of git://git.pengutronix.de/git/pza/linux into arm/fixes
      Merge tag 'omap-for-v5.6/droid4-lcd-fix-signed' of git://git.kernel.org/.../tmlind/linux-omap into arm/fixes
      Merge tag 'imx-fixes-5.6' of git://git.kernel.org/.../shawnguo/linux into arm/fixes
      Merge tag 'renesas-fixes-for-v5.6-tag1' of git://git.kernel.org/.../geert/renesas-devel into arm/fixes
      Merge tag 'tee-amdtee-fix-for-5.6' of https://git.linaro.org/people/jens.wiklander/linux-tee into arm/fixes
      Merge tag 'omap-for-v5.6/fixes-rc3-signed' of git://git.kernel.org/.../tmlind/linux-omap into arm/fixes
      Merge tag 'arm-soc/for-5.6/devicetree-fixes' of https://github.com/Broadcom/stblinux into arm/fixes
      Merge tag 'amlogic-fixes' of https://git.kernel.org/.../khilman/linux-amlogic into arm/fixes
      Merge tag 'arm-soc/for-5.6/defconfig-fixes' of https://github.com/Broadcom/stblinux into arm/fixes
      Merge tag 'socfpga_dts_fix_for_v5.6_v2' of git://git.kernel.org/.../dinguyen/linux into arm/fixes
      Merge tag 'socfpga_defconfig_fix_for_v5.6' of git://git.kernel.org/.../dinguyen/linux into arm/fixes

Peng Fan (1):
      ARM: dts: imx7d: fix opp-supported-hw

Peter Ujfalusi (1):
      ARM: dts: dra7-evm: Rename evm_3v3 regulator to vsys_3v3

Rob Herring (1):
      dt-bindings: reset: intel,rcu-gw: Fix intel,global-reset schema

Stefan Wahren (2):
      ARM: dts: bcm283x: Add missing properties to the PWR LED
      ARM: bcm2835_defconfig: Explicitly restore CONFIG_DEBUG_FS

Suman Anna (2):
      ARM: dts: am437x-idk-evm: Fix incorrect OPP node names
      ARM: dts: dra7xx-clocks: Fixup IPU1 mux clock parent source

Tomi Valkeinen (1):
      backlight: add led-backlight driver

Tony Lindgren (4):
      ARM: dts: droid4: Configure LED backlight for lm3532
      bus: ti-sysc: Fix 1-wire reset quirk
      Merge tag 'hdq-fix' into omap-for-v5.6/fixes-rc2
      ARM: OMAP2+: Fix compile if CONFIG_HAVE_ARM_SMCCC is not set

Vladimir Oltean (1):
      ARM: dts: ls1021a: Restore MDIO compatible to gianfar

 .../devicetree/bindings/reset/intel,rcu-gw.yaml    |   6 +-
 MAINTAINERS                                        |   2 +-
 arch/arm/boot/dts/am437x-idk-evm.dts               |   4 +-
 arch/arm/boot/dts/bcm2711-rpi-4-b.dts              |   3 +
 arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts         |   2 +
 arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts         |   2 +
 arch/arm/boot/dts/dra7-evm.dts                     |   4 +-
 arch/arm/boot/dts/dra7-l4.dtsi                     |   4 +
 arch/arm/boot/dts/dra7.dtsi                        |   2 +
 arch/arm/boot/dts/dra76x.dtsi                      |   5 +
 arch/arm/boot/dts/dra7xx-clocks.dtsi               |  12 +-
 arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts       |   4 +-
 arch/arm/boot/dts/imx6qdl-phytec-phycore-som.dtsi  |   1 -
 arch/arm/boot/dts/imx7-colibri.dtsi                |   1 -
 arch/arm/boot/dts/imx7d.dtsi                       |   6 +-
 arch/arm/boot/dts/ls1021a.dtsi                     |   4 +-
 arch/arm/boot/dts/motorola-mapphone-common.dtsi    |  13 +-
 arch/arm/boot/dts/r8a7779.dtsi                     |   2 +-
 arch/arm/configs/bcm2835_defconfig                 |   1 +
 arch/arm/configs/omap2plus_defconfig               |   1 +
 arch/arm/configs/socfpga_defconfig                 |   1 +
 arch/arm/mach-imx/Makefile                         |   2 +
 arch/arm/mach-imx/common.h                         |   4 +-
 arch/arm/mach-imx/resume-imx6.S                    |  24 ++
 arch/arm/mach-imx/suspend-imx6.S                   |  14 --
 arch/arm/mach-meson/Kconfig                        |   1 -
 arch/arm/mach-omap2/Makefile                       |   2 +-
 arch/arm/mach-omap2/io.c                           |   2 -
 .../boot/dts/amlogic/meson-gxm-khadas-vim2.dts     |   2 +-
 arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts   |   1 +
 arch/arm64/boot/dts/freescale/imx8qxp-mek.dts      |   5 -
 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi      |   6 +-
 arch/arm64/configs/defconfig                       |   2 +-
 drivers/bus/ti-sysc.c                              |   4 +-
 drivers/firmware/imx/imx-scu.c                     |  27 +++
 drivers/firmware/imx/misc.c                        |   8 +-
 drivers/firmware/imx/scu-pd.c                      |   2 +-
 drivers/reset/Kconfig                              |   3 +-
 drivers/soc/imx/soc-imx-scu.c                      |   2 +-
 drivers/tee/amdtee/core.c                          |  48 ++--
 drivers/video/backlight/Kconfig                    |   7 +
 drivers/video/backlight/Makefile                   |   1 +
 drivers/video/backlight/led_bl.c                   | 260 +++++++++++++++++++++
 43 files changed, 416 insertions(+), 91 deletions(-)
 create mode 100644 arch/arm/mach-imx/resume-imx6.S
 create mode 100644 drivers/video/backlight/led_bl.c
