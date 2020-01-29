Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B348C35240
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 21:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50C1F20674
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 21:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580332060;
	bh=WuBr4j62R4RtqAJ7oEkkgLU+vr9WCHgo3tLNgX+j2B0=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=qSRo4UQHypq3xgC/3cctusHIfEwss+nLBtFT4LQ1twR9XnBgAl+WgIPxlhi6mzzeH
	 7Eham5HOhXFKuu6eG7ApNKK9EYQMjNCUpnP7amuHWUEgB269DgQ4/Ui6RTuc4vsfGn
	 BYRAyWedMeLuHPVLlxJDEG1Sx1A5lBb2BJxWeKOc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbgA2VHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 16:07:39 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34894 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727133AbgA2VHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 16:07:39 -0500
Received: by mail-ot1-f67.google.com with SMTP id r16so1034367otd.2;
        Wed, 29 Jan 2020 13:07:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=p/QFZqeSMnnTowT5k3YUkmhQis3pKtJi2blNdxSsGL0=;
        b=bTgvb9ijjqlauwtbwfYAf4J5isW/yeF/Tu9R+X91ZakHXnClQui8dOCvDrKRp28xIj
         nVXlTBncmycACUzjsli7BZKjwE7B67rAwQ41J90WD/yayZXF0V8Owpc8SMcwp8yRKZSJ
         trhP7FrwaTmiLlS19w6976orxMXzX0HtAz92YE9v4+Hij70e2ThIw7/W7DNpmBXn8R5r
         T14g1DOYN98iFNJbGC4Rp3CEDlwENDTCpL73U8NCzPm1CE/fB5qmmDe3cNed06Z7SqLW
         Re49j3GZSkbG0xn3L6zPjTcL32wa0SWqwJMK16asGp8hSDvgGUwnlddHkgNnbxaIg2AF
         SbcQ==
X-Gm-Message-State: APjAAAUC24i9N7ZyUAVRMC6UTd/ivntcRgLE1XeSXVj3frmmrcAKJXu/
        ugdLl7VF5B3umnT1X7xFVw==
X-Google-Smtp-Source: APXvYqy5YXZKY4FwiSK5gMZccrf5LZmUq6HZtRI01YBBvDo1CSJtYMF+WMPjDxcakYvX9KKtIM8gAw==
X-Received: by 2002:a9d:23b5:: with SMTP id t50mr975245otb.122.1580332057331;
        Wed, 29 Jan 2020 13:07:37 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m69sm1060402otc.78.2020.01.29.13.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 13:07:36 -0800 (PST)
Received: (nullmailer pid 32355 invoked by uid 1000);
        Wed, 29 Jan 2020 21:07:36 -0000
Date:   Wed, 29 Jan 2020 15:07:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Subject: [GIT PULL] Devicetree updates for v5.6
Message-ID: <20200129210736.GA29551@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull Devicetree updates for 5.6. Details below.

Rob


The following changes since commit d1eef1c619749b2a57e514a3fa67d9a516ffa919:

  Linux 5.5-rc2 (2019-12-15 15:16:08 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-5.6

for you to fetch changes up to e9a3bfe38e393e1d8bd74986cdc9b99b8f9d1efc:

  scripts/dtc: Revert "yamltree: Ensure consistent bracketing of properties with phandles" (2020-01-28 10:21:47 -0600)

----------------------------------------------------------------
Devicetree updates for v5.6:

- Update dtc to upstream v1.5.1-22-gc40aeb60b47a (plus 1 revert)

- Fix for DMA coherent devices on Power

- Rework and simplify the DT phandle cache code

- DT schema conversions for LEDS, gpio-leds, STM32 dfsdm, STM32 UART,
  STM32 ROMEM, STM32 watchdog, STM32 DMAs, STM32 mlahb, STM32 RTC,
  STM32 RCC, STM32 syscon, rs485, Renesas rCar CSI2, Faraday FTIDE010,
  DWC2, Arm idle-states, Allwinner legacy resets, PRCM and clocks,
  Allwinner H6 OPP, Allwinner AHCI, Allwinner MBUS, Allwinner A31 CSI,
  Allwinner h/w codec, Allwinner A10 system ctrl, Allwinner SRAM,
  Allwinner USB PHY, Renesas CEU, generic PCI host, Arm Versatile PCI

- New binding schemas for SATA and PATA controllers, TI and Infineon VR
  controllers, MAX31730

- New compatible strings for i.MX8QM, WCN3991, renesas,r8a77961-wdt,
  renesas,etheravb-r8a77961

- Add USB 'super-speed-plus' as a documented speed

- Vendor prefixes for broadmobi, calaosystems, kam, and mps

- Clean-up the multiple flavors of ST-Ericsson vendor prefixes

----------------------------------------------------------------
Alexandre Torgue (1):
      dt-bindings: arm: stm32: Convert stm32-syscon to json-schema

Angus Ainslie (Purism) (1):
      dt-bindings: vendor-prefixes: Add a broadmobi entry

Arnaud Pouliquen (1):
      dt-bindings: stm32: convert mlahb to json-schema

Beniamin Bia (1):
      dt-bindings: iio: adc: ad7606: Fix wrong maxItems value

Benjamin Gaignard (10):
      dt-bindings: rtc: Convert stm32 rtc bindings to json-schema
      dt-bindings: dma: Convert stm32 DMA bindings to json-schema
      dt-bindings: dma: Convert stm32 MDMA bindings to json-schema
      dt-bindings: dma: Convert stm32 DMAMUX bindings to json-schema
      dt-bindings: watchdog: Convert stm32 watchdog bindings to json-schema
      dt-bindings: usb: amlogic, meson-g12a-usb-ctrl: fix clock names
      dt-bindings: nvmem: Convert STM32 ROMEM to json-schema
      dt-bindings: usb: Convert DWC2 bindings to json-schema
      dt-bindings: serial: Convert rs485 bindings to json-schema
      dt-bindings: serial: Convert STM32 UART to json-schema

Bruno Thomsen (1):
      dt: bindings: add vendor prefix for Kamstrup A/S

Dong Aisheng (3):
      dt-bindings: mmc: fsl-imx-esdhc: add imx8qm compatible string
      dt-bindings: serial: lpuart: add imx8qm compatible string
      dt-bindings: i2c: lpi2c: add imx8qm compatible string

Douglas Anderson (1):
      dt-bindings: timer: Use non-empty ranges in example

Gabriel Fernandez (1):
      dt-bindings: rcc: Convert stm32mp1 rcc bindings to json-schema

Geert Uytterhoeven (3):
      dt-bindings: net: ravb: Document r8a77961 support
      dt-bindings: watchdog: renesas-wdt: Document r8a77961 support
      of: overlay: Remove blank line between assignment and check

Guenter Roeck (1):
      dt-bindings: Add MAX31730 as trivial device

JC Kuo (1):
      dt-binding: usb: add "super-speed-plus"

Jacopo Mondi (1):
      dt-bindings: media: renesas,ceu: Convert to yaml

Johan Jonker (2):
      dt-bindings: mmc: remove identical phrase in disable-wp text
      dt-bindings: mmc: clarify disable-wp text

Krzysztof Kozlowski (1):
      dt-bindings: Rename Exynos to lowercase

Linus Walleij (4):
      dt-bindings: Create DT bindings for SATA controllers
      dt-bindings: Create DT bindings for PATA controllers
      dt-bindings: Convert Faraday FTIDE010 to DT schema
      dt-bindings: Be explicit about installing deps

Markus Reichl (1):
      dt-bindings: add vendor Monolithic Power Systems

Matthias Kaehlcke (1):
      dt-bindings: net: bluetooth: Add compatible string for WCN3991

Maxime Ripard (13):
      dt-bindings: usb: Convert Allwinner USB PHY controller to a schema
      dt-bindings: sram: Allow for the childs nodes to be called sections
      dt-bindings: sram: Allow for more specific compatibles
      dt-bindings: sram: Add Allwinner SRAM compatibles
      dt-bindings: sram: Convert Allwinner A10 system controller to a schema
      dt-bindings: media: Convert Allwinner hardware codec to a schema
      dt-bindings: media: Convert Allwinner A31 CSI to a schema
      dt-bindings: interconnect: Convert Allwinner MBUS controller to a schema
      dt-bindings: ata: Convert Allwinner AHCI controller to a schema
      dt-bindings: opp: Convert Allwinner H6 OPP to a schema
      dt-bindings: clocks: Convert Allwinner legacy clocks to schemas
      dt-bindings: mfd: Convert Allwinner legacy PRCM bindings to schemas
      dt-bindings: resets: Convert Allwinner legacy resets to schemas

Michael Ellerman (1):
      of: Add OF_DMA_DEFAULT_COHERENT & select it on powerpc

Miquel Raynal (1):
      dt-bindings: phy: Fix the PX30 DSI PHY compatible in the example

Mohana Datta Yelugoti (1):
      Documentation: spi-ir-led: fix spelling mistake "balue"->"value"

Niklas Söderlund (1):
      dt-bindings: rcar-csi2: Convert bindings to json-schema

Olivier Moysan (1):
      dt-bindings: stm32: convert dfsdm to json-schema

Peng Fan (1):
      dt-bindings: arm-boards: typo fix

Rob Herring (10):
      dt-bindings: Add missing 'properties' keyword enclosing 'snps,tso'
      of: Rework and simplify phandle cache to use a fixed size
      scripts/dtc: Update to upstream version v1.5.1-22-gc40aeb60b47a
      dt-bindings: arm: Convert arm,idle-state binding to DT schema
      Merge branch 'dt/linus' into dt/next
      dt-bindings: PCI: Convert Arm Versatile binding to DT schema
      dt-bindings: PCI: Convert generic host binding to DT schema
      dt-bindings: leds: Convert common LED binding to schema
      dt-bindings: leds: Convert gpio-leds to DT schema
      scripts/dtc: Revert "yamltree: Ensure consistent bracketing of properties with phandles"

Stephan Gerhold (3):
      dt-bindings: vendor-prefixes: Add yet another for ST-Ericsson
      dt-bindings: vendor-prefixes: Deprecate "ste" and "st-ericsson"
      dt-bindings: vendor-prefixes: Add "calaosystems" for CALAO Systems SAS

Vadim Pasternak (1):
      dt-bindings: Add TI and Infineon VR Controllers as trivial devices

 Documentation/devicetree/bindings/arm/arm-boards   |   2 +-
 .../devicetree/bindings/arm/idle-states.txt        | 706 ---------------------
 .../devicetree/bindings/arm/idle-states.yaml       | 661 +++++++++++++++++++
 .../devicetree/bindings/arm/stm32/mlahb.txt        |  37 --
 .../devicetree/bindings/arm/stm32/st,mlahb.yaml    |  70 ++
 .../bindings/arm/stm32/st,stm32-syscon.yaml        |  41 ++
 .../devicetree/bindings/arm/stm32/stm32-syscon.txt |  16 -
 .../arm/sunxi/allwinner,sun4i-a10-mbus.yaml        |  65 ++
 .../devicetree/bindings/arm/sunxi/sunxi-mbus.txt   |  37 --
 .../devicetree/bindings/ata/ahci-platform.txt      |  12 -
 .../bindings/ata/allwinner,sun4i-a10-ahci.yaml     |  47 ++
 .../bindings/ata/allwinner,sun8i-r40-ahci.yaml     |  67 ++
 .../devicetree/bindings/ata/faraday,ftide010.txt   |  38 --
 .../devicetree/bindings/ata/faraday,ftide010.yaml  |  89 +++
 .../devicetree/bindings/ata/pata-common.yaml       |  50 ++
 .../devicetree/bindings/ata/sata-common.yaml       |  50 ++
 .../clock/allwinner,sun4i-a10-ahb-clk.yaml         | 108 ++++
 .../clock/allwinner,sun4i-a10-apb0-clk.yaml        |  50 ++
 .../clock/allwinner,sun4i-a10-apb1-clk.yaml        |  52 ++
 .../clock/allwinner,sun4i-a10-axi-clk.yaml         |  61 ++
 .../clock/allwinner,sun4i-a10-cpu-clk.yaml         |  52 ++
 .../clock/allwinner,sun4i-a10-display-clk.yaml     |  57 ++
 .../clock/allwinner,sun4i-a10-gates-clk.yaml       | 152 +++++
 .../clock/allwinner,sun4i-a10-mbus-clk.yaml        |  63 ++
 .../clock/allwinner,sun4i-a10-mmc-clk.yaml         |  87 +++
 .../clock/allwinner,sun4i-a10-mod0-clk.yaml        |  80 +++
 .../clock/allwinner,sun4i-a10-mod1-clk.yaml        |  57 ++
 .../clock/allwinner,sun4i-a10-osc-clk.yaml         |  51 ++
 .../clock/allwinner,sun4i-a10-pll1-clk.yaml        |  71 +++
 .../clock/allwinner,sun4i-a10-pll3-clk.yaml        |  50 ++
 .../clock/allwinner,sun4i-a10-pll5-clk.yaml        |  53 ++
 .../clock/allwinner,sun4i-a10-pll6-clk.yaml        |  53 ++
 .../clock/allwinner,sun4i-a10-tcon-ch0-clk.yaml    |  77 +++
 .../clock/allwinner,sun4i-a10-usb-clk.yaml         | 166 +++++
 .../bindings/clock/allwinner,sun4i-a10-ve-clk.yaml |  55 ++
 .../clock/allwinner,sun5i-a13-ahb-clk.yaml         |  52 ++
 .../clock/allwinner,sun6i-a31-pll6-clk.yaml        |  53 ++
 .../clock/allwinner,sun7i-a20-gmac-clk.yaml        |  51 ++
 .../clock/allwinner,sun7i-a20-out-clk.yaml         |  52 ++
 .../clock/allwinner,sun8i-h3-bus-gates-clk.yaml    | 103 +++
 .../clock/allwinner,sun9i-a80-ahb-clk.yaml         |  52 ++
 .../clock/allwinner,sun9i-a80-apb0-clk.yaml        |  63 ++
 .../clock/allwinner,sun9i-a80-cpus-clk.yaml        |  52 ++
 .../bindings/clock/allwinner,sun9i-a80-gt-clk.yaml |  52 ++
 .../clock/allwinner,sun9i-a80-mmc-config-clk.yaml  |  68 ++
 .../clock/allwinner,sun9i-a80-pll4-clk.yaml        |  50 ++
 .../clock/allwinner,sun9i-a80-usb-mod-clk.yaml     |  60 ++
 .../clock/allwinner,sun9i-a80-usb-phy-clk.yaml     |  60 ++
 .../devicetree/bindings/clock/st,stm32mp1-rcc.txt  |  60 --
 .../devicetree/bindings/clock/st,stm32mp1-rcc.yaml |  79 +++
 Documentation/devicetree/bindings/clock/sunxi.txt  | 225 -------
 .../devicetree/bindings/dma/st,stm32-dma.yaml      | 102 +++
 .../devicetree/bindings/dma/st,stm32-dmamux.yaml   |  52 ++
 .../devicetree/bindings/dma/st,stm32-mdma.yaml     | 105 +++
 .../devicetree/bindings/dma/stm32-dma.txt          |  83 ---
 .../devicetree/bindings/dma/stm32-dmamux.txt       |  84 ---
 .../devicetree/bindings/dma/stm32-mdma.txt         |  94 ---
 .../devicetree/bindings/i2c/i2c-imx-lpi2c.txt      |   1 +
 .../devicetree/bindings/iio/adc/adi,ad7606.yaml    |   8 +-
 .../bindings/iio/adc/st,stm32-dfsdm-adc.txt        | 135 ----
 .../bindings/iio/adc/st,stm32-dfsdm-adc.yaml       | 332 ++++++++++
 Documentation/devicetree/bindings/leds/common.txt  | 174 +----
 Documentation/devicetree/bindings/leds/common.yaml | 228 +++++++
 .../devicetree/bindings/leds/irled/spi-ir-led.txt  |   2 +-
 .../devicetree/bindings/leds/leds-gpio.txt         |  75 ---
 .../devicetree/bindings/leds/leds-gpio.yaml        |  86 +++
 .../devicetree/bindings/leds/trigger-source.yaml   |  24 +
 .../media/allwinner,sun4i-a10-video-engine.yaml    |  83 +++
 .../bindings/media/allwinner,sun6i-a31-csi.yaml    | 115 ++++
 Documentation/devicetree/bindings/media/cedrus.txt |  57 --
 .../bindings/media/exynos-jpeg-codec.txt           |   2 +-
 .../devicetree/bindings/media/exynos5-gsc.txt      |   2 +-
 .../devicetree/bindings/media/renesas,ceu.txt      |  86 ---
 .../devicetree/bindings/media/renesas,ceu.yaml     |  78 +++
 .../devicetree/bindings/media/renesas,csi2.txt     | 107 ----
 .../devicetree/bindings/media/renesas,csi2.yaml    | 198 ++++++
 .../devicetree/bindings/media/samsung-fimc.txt     |   2 +-
 .../bindings/media/samsung-mipi-csis.txt           |   2 +-
 .../devicetree/bindings/media/sun6i-csi.txt        |  61 --
 .../bindings/mfd/allwinner,sun6i-a31-prcm.yaml     | 219 +++++++
 .../bindings/mfd/allwinner,sun8i-a23-prcm.yaml     | 200 ++++++
 .../devicetree/bindings/mfd/sun6i-prcm.txt         |  59 --
 .../devicetree/bindings/mmc/fsl-imx-esdhc.txt      |   1 +
 .../devicetree/bindings/mmc/mmc-controller.yaml    |   5 +-
 .../devicetree/bindings/net/qualcomm-bluetooth.txt |   1 +
 .../devicetree/bindings/net/renesas,ravb.txt       |   7 +-
 .../devicetree/bindings/net/snps,dwmac.yaml        |   1 +
 .../devicetree/bindings/nvmem/st,stm32-romem.txt   |  31 -
 .../devicetree/bindings/nvmem/st,stm32-romem.yaml  |  46 ++
 .../opp/allwinner,sun50i-h6-operating-points.yaml  | 129 ++++
 .../bindings/opp/sun50i-nvmem-cpufreq.txt          | 167 -----
 .../devicetree/bindings/pci/arm,juno-r1-pcie.txt   |  10 -
 .../bindings/pci/designware-pcie-ecam.txt          |  42 --
 .../devicetree/bindings/pci/hisilicon-pcie.txt     |  42 --
 .../devicetree/bindings/pci/host-generic-pci.txt   | 101 ---
 .../devicetree/bindings/pci/host-generic-pci.yaml  | 172 +++++
 .../devicetree/bindings/pci/pci-thunder-ecam.txt   |  30 -
 .../devicetree/bindings/pci/pci-thunder-pem.txt    |  43 --
 .../bindings/pci/plda,xpressrich3-axi.txt          |  12 -
 .../devicetree/bindings/pci/versatile.txt          |  59 --
 .../devicetree/bindings/pci/versatile.yaml         |  92 +++
 .../bindings/phy/allwinner,sun4i-a10-usb-phy.yaml  | 105 +++
 .../bindings/phy/allwinner,sun50i-a64-usb-phy.yaml | 106 ++++
 .../bindings/phy/allwinner,sun50i-h6-usb-phy.yaml  | 105 +++
 .../bindings/phy/allwinner,sun5i-a13-usb-phy.yaml  |  93 +++
 .../bindings/phy/allwinner,sun6i-a31-usb-phy.yaml  | 119 ++++
 .../bindings/phy/allwinner,sun8i-a23-usb-phy.yaml  | 102 +++
 .../bindings/phy/allwinner,sun8i-a83t-usb-phy.yaml | 122 ++++
 .../bindings/phy/allwinner,sun8i-h3-usb-phy.yaml   | 137 ++++
 .../bindings/phy/allwinner,sun8i-r40-usb-phy.yaml  | 119 ++++
 .../bindings/phy/allwinner,sun8i-v3s-usb-phy.yaml  |  86 +++
 .../bindings/phy/rockchip,px30-dsi-dphy.yaml       |   2 +-
 .../devicetree/bindings/phy/samsung-phy.txt        |   6 +-
 .../devicetree/bindings/phy/sun4i-usb-phy.txt      |  68 --
 .../reset/allwinner,sun6i-a31-clock-reset.yaml     |  68 ++
 .../bindings/reset/allwinner,sunxi-clock-reset.txt |  21 -
 .../devicetree/bindings/rtc/st,stm32-rtc.txt       |  61 --
 .../devicetree/bindings/rtc/st,stm32-rtc.yaml      | 139 ++++
 .../devicetree/bindings/serial/fsl-lpuart.txt      |   2 +
 Documentation/devicetree/bindings/serial/rs485.txt |  32 +-
 .../devicetree/bindings/serial/rs485.yaml          |  45 ++
 .../devicetree/bindings/serial/st,stm32-uart.yaml  |  80 +++
 .../devicetree/bindings/serial/st,stm32-usart.txt  |  57 --
 .../sram/allwinner,sun4i-a10-system-control.yaml   | 140 ++++
 Documentation/devicetree/bindings/sram/sram.yaml   |  25 +-
 .../devicetree/bindings/sram/sunxi-sram.txt        | 113 ----
 .../bindings/timer/arm,arch_timer_mmio.yaml        |  12 +-
 .../devicetree/bindings/trivial-devices.yaml       |  10 +
 .../bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml  |   2 +-
 Documentation/devicetree/bindings/usb/dwc2.txt     |  64 --
 Documentation/devicetree/bindings/usb/dwc2.yaml    | 151 +++++
 Documentation/devicetree/bindings/usb/generic.txt  |   9 +-
 .../devicetree/bindings/vendor-prefixes.yaml       |  12 +
 .../devicetree/bindings/watchdog/renesas,wdt.txt   |   1 +
 .../devicetree/bindings/watchdog/st,stm32-iwdg.txt |  26 -
 .../bindings/watchdog/st,stm32-iwdg.yaml           |  57 ++
 Documentation/devicetree/writing-schema.rst        |   8 +-
 MAINTAINERS                                        |   8 +-
 arch/powerpc/Kconfig                               |   1 +
 drivers/of/Kconfig                                 |   4 +
 drivers/of/address.c                               |   6 +-
 drivers/of/base.c                                  | 130 +---
 drivers/of/dynamic.c                               |   2 +-
 drivers/of/of_private.h                            |   6 +-
 drivers/of/overlay.c                               |  11 -
 scripts/dtc/checks.c                               |   5 +
 scripts/dtc/dtc-parser.y                           |   4 +
 scripts/dtc/fstree.c                               |   2 +-
 scripts/dtc/libfdt/fdt.c                           |   9 +-
 scripts/dtc/libfdt/fdt_addresses.c                 |   8 +-
 scripts/dtc/libfdt/fdt_overlay.c                   |  28 +-
 scripts/dtc/libfdt/fdt_ro.c                        |  11 +-
 scripts/dtc/libfdt/libfdt.h                        |   4 +-
 scripts/dtc/libfdt/libfdt_internal.h               |  12 +-
 scripts/dtc/livetree.c                             |   3 +-
 scripts/dtc/util.c                                 |   3 +-
 scripts/dtc/util.h                                 |   4 +
 scripts/dtc/version_gen.h                          |   2 +-
 158 files changed, 7603 insertions(+), 3327 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/idle-states.txt
 create mode 100644 Documentation/devicetree/bindings/arm/idle-states.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/stm32/mlahb.txt
 create mode 100644 Documentation/devicetree/bindings/arm/stm32/st,mlahb.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/stm32/st,stm32-syscon.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/stm32/stm32-syscon.txt
 create mode 100644 Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/sunxi/sunxi-mbus.txt
 create mode 100644 Documentation/devicetree/bindings/ata/allwinner,sun4i-a10-ahci.yaml
 create mode 100644 Documentation/devicetree/bindings/ata/allwinner,sun8i-r40-ahci.yaml
 delete mode 100644 Documentation/devicetree/bindings/ata/faraday,ftide010.txt
 create mode 100644 Documentation/devicetree/bindings/ata/faraday,ftide010.yaml
 create mode 100644 Documentation/devicetree/bindings/ata/pata-common.yaml
 create mode 100644 Documentation/devicetree/bindings/ata/sata-common.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ahb-clk.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-apb0-clk.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-apb1-clk.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-axi-clk.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-cpu-clk.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-display-clk.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-gates-clk.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-mbus-clk.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-mmc-clk.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-mod0-clk.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-mod1-clk.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-osc-clk.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-pll1-clk.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-pll3-clk.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-pll5-clk.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-pll6-clk.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-tcon-ch0-clk.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-usb-clk.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ve-clk.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun5i-a13-ahb-clk.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun6i-a31-pll6-clk.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun7i-a20-gmac-clk.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun7i-a20-out-clk.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun8i-h3-bus-gates-clk.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun9i-a80-ahb-clk.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun9i-a80-apb0-clk.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun9i-a80-cpus-clk.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun9i-a80-gt-clk.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun9i-a80-mmc-config-clk.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun9i-a80-pll4-clk.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun9i-a80-usb-mod-clk.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun9i-a80-usb-phy-clk.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.txt
 create mode 100644 Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/sunxi.txt
 create mode 100644 Documentation/devicetree/bindings/dma/st,stm32-dma.yaml
 create mode 100644 Documentation/devicetree/bindings/dma/st,stm32-dmamux.yaml
 create mode 100644 Documentation/devicetree/bindings/dma/st,stm32-mdma.yaml
 delete mode 100644 Documentation/devicetree/bindings/dma/stm32-dma.txt
 delete mode 100644 Documentation/devicetree/bindings/dma/stm32-dmamux.txt
 delete mode 100644 Documentation/devicetree/bindings/dma/stm32-mdma.txt
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml
 create mode 100644 Documentation/devicetree/bindings/leds/common.yaml
 delete mode 100644 Documentation/devicetree/bindings/leds/leds-gpio.txt
 create mode 100644 Documentation/devicetree/bindings/leds/leds-gpio.yaml
 create mode 100644 Documentation/devicetree/bindings/leds/trigger-source.yaml
 create mode 100644 Documentation/devicetree/bindings/media/allwinner,sun4i-a10-video-engine.yaml
 create mode 100644 Documentation/devicetree/bindings/media/allwinner,sun6i-a31-csi.yaml
 delete mode 100644 Documentation/devicetree/bindings/media/cedrus.txt
 delete mode 100644 Documentation/devicetree/bindings/media/renesas,ceu.txt
 create mode 100644 Documentation/devicetree/bindings/media/renesas,ceu.yaml
 delete mode 100644 Documentation/devicetree/bindings/media/renesas,csi2.txt
 create mode 100644 Documentation/devicetree/bindings/media/renesas,csi2.yaml
 delete mode 100644 Documentation/devicetree/bindings/media/sun6i-csi.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/allwinner,sun6i-a31-prcm.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/allwinner,sun8i-a23-prcm.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/sun6i-prcm.txt
 delete mode 100644 Documentation/devicetree/bindings/nvmem/st,stm32-romem.txt
 create mode 100644 Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml
 create mode 100644 Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml
 delete mode 100644 Documentation/devicetree/bindings/opp/sun50i-nvmem-cpufreq.txt
 delete mode 100644 Documentation/devicetree/bindings/pci/arm,juno-r1-pcie.txt
 delete mode 100644 Documentation/devicetree/bindings/pci/designware-pcie-ecam.txt
 delete mode 100644 Documentation/devicetree/bindings/pci/host-generic-pci.txt
 create mode 100644 Documentation/devicetree/bindings/pci/host-generic-pci.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/pci-thunder-ecam.txt
 delete mode 100644 Documentation/devicetree/bindings/pci/pci-thunder-pem.txt
 delete mode 100644 Documentation/devicetree/bindings/pci/plda,xpressrich3-axi.txt
 delete mode 100644 Documentation/devicetree/bindings/pci/versatile.txt
 create mode 100644 Documentation/devicetree/bindings/pci/versatile.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/allwinner,sun4i-a10-usb-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/allwinner,sun50i-a64-usb-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/allwinner,sun50i-h6-usb-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/allwinner,sun5i-a13-usb-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-usb-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/allwinner,sun8i-a23-usb-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/allwinner,sun8i-a83t-usb-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/allwinner,sun8i-h3-usb-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/allwinner,sun8i-r40-usb-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/allwinner,sun8i-v3s-usb-phy.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt
 create mode 100644 Documentation/devicetree/bindings/reset/allwinner,sun6i-a31-clock-reset.yaml
 delete mode 100644 Documentation/devicetree/bindings/reset/allwinner,sunxi-clock-reset.txt
 delete mode 100644 Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/st,stm32-rtc.yaml
 create mode 100644 Documentation/devicetree/bindings/serial/rs485.yaml
 create mode 100644 Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
 delete mode 100644 Documentation/devicetree/bindings/serial/st,stm32-usart.txt
 create mode 100644 Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml
 delete mode 100644 Documentation/devicetree/bindings/sram/sunxi-sram.txt
 delete mode 100644 Documentation/devicetree/bindings/usb/dwc2.txt
 create mode 100644 Documentation/devicetree/bindings/usb/dwc2.yaml
 delete mode 100644 Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.yaml
