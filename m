Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BB6C2BA15
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 20:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DEB720719
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 20:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585860904;
	bh=xqTfDED/VvxjCZ3lGbHGjwczOaVsXF5tDHSF0MtAdFQ=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=XFcvn/1+hk1qGuh8ovFt8uC2TbYb7XQdYUteU/qbeO8J78YZsKpaTWkyieuJbxNqh
	 nHp9ribRaF/DPEsZs+FvHCmuSwsEqcwlL7R++mOWzsWPd4JWdWftRJ7T+lBuv9JRcM
	 01i0SXcZ5+1c2vF8r9Lzu+gsPIR5AMoywl7bPSeo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389449AbgDBUzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 16:55:03 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:45060 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbgDBUzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 16:55:02 -0400
Received: by mail-il1-f193.google.com with SMTP id x16so5043708ilp.12;
        Thu, 02 Apr 2020 13:55:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=DiKeiIdnUmkEaJccCmjzPtVbHDaiZEmIz37/OKI0+Ps=;
        b=k6EgLLQJRjb2wHtfI8xP7G+f/juitEPTBrkZXfYvpvpfTLn36xFiw+VjbHe4TcqjJJ
         7pvZFIfUciYNNgf/ZKEnWJq3ow8z2Y8HLY/OPC8iWATBYcG5GG0v13aL0xfFQl1O+a8B
         Hy1EVes8Z/G3xtfdMGc0N4lJgrN+yDduO/HwSmJo2kNl6UEl/6dNrmRTOau23IRU/t84
         Muxww+azFLtzAgWiWRTbxnUw2U2MmuCHbGvdlvxKzhq0mad+l5mVm5OSA70XbkmWJd8P
         DYWlkuUMP++LiFcA/hj2odjnv0xVYux2IiOGnG9lNABT0eja6HbSMhgF+Eh9rSJ9bHJf
         yChA==
X-Gm-Message-State: AGi0PubvB4dcxvDAucMAGg+NWLOsEMqAnmY/8SZrihx4GUA/hEFYnVo0
        /NPky6s8bJy3cLSYRzFhY4F6QWw=
X-Google-Smtp-Source: APiQypJIfqzgrSjBOw4VTWwlYJe0hpLhl4n4yzDDKNFODbHoFfrGJNEdaZbbhSPD6GSY34zNfhIviw==
X-Received: by 2002:a92:3d8c:: with SMTP id k12mr5231651ilf.7.1585860899204;
        Thu, 02 Apr 2020 13:54:59 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id y12sm2115954ilm.72.2020.04.02.13.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 13:54:58 -0700 (PDT)
Received: (nullmailer pid 9582 invoked by uid 1000);
        Thu, 02 Apr 2020 20:54:57 -0000
Date:   Thu, 2 Apr 2020 14:54:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Subject: [GIT PULL] Devicetree updates for v5.7
Message-ID: <20200402205457.GA7121@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull DT updates for v5.7. There's 2 conflicts in 
trivial-devices.yaml and .../bindings/usb/generic.txt. Both are just 
context and linux-next has the correct resolution.

Rob


The following changes since commit d2334a91a3b01dce4f290b4536fcfa4b9e923a3d:

  dt-bindings: arm: Fixup the DT bindings for hierarchical PSCI states (2020-03-06 12:12:21 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-5.7

for you to fetch changes up to 8967918e7cee84d8b781feec38286c7d3c1c05da:

  MAINTAINERS: drop an old reference to stm32 pwm timers doc (2020-04-01 10:47:11 -0600)

----------------------------------------------------------------
Devicetree updates for v5.7:

- Unit test for overlays with GPIO hogs

- Improve dma-ranges parsing to handle dma-ranges with multiple entries

- Update dtc to upstream version v1.6.0-2-g87a656ae5ff9

- Improve overlay error reporting

- Device link support for power-domains and hwlocks bindings

- Add vendor prefixes for Beacon, Topwise, ENE, Dell, SG Micro, Elida,
  PocketBook, Xiaomi, Linutronix, OzzMaker, Waveshare Electronics, and
  ITE Tech

- Add deprecated Marvell vendor prefix 'mrvl'

- A bunch of binding conversions to DT schema continues. Of note, the
  common serial and USB connector bindings are converted.

- Add more Arm CPU compatibles

- Drop Mark Rutland as DT maintainer :(

----------------------------------------------------------------
Adam Ford (1):
      dt-bindings: vendor-prefixes: Add Beacon vendor prefix

Akash Asthana (2):
      dt-bindings: spi: Convert QSPI bindings to YAML
      dt-bindings: spi: Add interconnect binding for QSPI

Alexey Minnekhanov (2):
      dt-bindings: Add vendor prefix for Xiaomi
      dt-bindings: arm: Add kryo260 compatible

Amelie Delaunay (1):
      dt-bindings: usb: dwc2: add support for STM32MP15 SoCs USB OTG HS and FS

Amit Kucheria (1):
      dt-bindings: arm: cpus: Add kryo280 compatible

Bastian Germann (1):
      dt-bindings: Add vendor prefix for Linutronix

Benjamin Gaignard (4):
      dt-bindings: display: Convert etnaviv to json-schema
      dt-bindinsg: net: can: Convert can-transceiver to json-schema
      dt-bindings: net: can: Convert M_CAN to json-schema
      dt-bindings: mfd: Convert stpmic1 bindings to json-schema

Bin Meng (1):
      dt-bindings: interrupt-controller: msi: Correct msi-controller@c's reg

Frank Rowand (5):
      of: unittest: add overlay gpio test to catch gpio hog problem
      of: unittest: annotate warnings triggered by unittest
      of: unittest: make gpio overlay test dependent on CONFIG_OF_GPIO
      of: gpio unittest kfree() wrong object
      of: some unittest overlays not untracked

Geert Uytterhoeven (10):
      dt-bindings: example-schema: Drop double quotes around URLs
      dt-bindings: ata: rcar-sata: Convert to json-schema
      dt-bindings: reset: rcar-rst: Convert to json-schema
      dt-bindings: power: rcar-sysc: Convert to json-schema
      dt-bindings: power: apmu: Convert to json-schema
      dt-bindings: serial: Convert generic bindings to json-schema
      dt-bindings: serial: Convert slave-device bindings to json-schema
      dt-bindings: pwm: renesas-tpu: Document more R-Car Gen2 support
      dt-bindings: serial: Document serialN aliases
      dt-bindings: serial: sh-sci: Convert to json-schema

Giulio Benetti (1):
      dt-bindings: clk: fix example for single-output provider

Gustavo A. R. Silva (1):
      of: of_private.h: Replace zero-length array with flexible-array member

Heiko Stuebner (1):
      dt-bindings: Add vendor prefix for Elida

Johan Jonker (8):
      dt-bindings: serial: snps-dw-apb-uart: add compatible property for rk3308 uart
      dt-bindings: i2c: convert rockchip i2c bindings to yaml
      dt-bindings: i2c: i2c-rk3x: add description for rk3036
      dt-bindings: i2c: i2c-rk3x: add description for rk3368
      dt-bindings: i2c: i2c-rk3x: add description for rk3308
      dt-bindings: i2c: i2c-rk3x: add description for px30
      dt-bindings: leds: common: fix example for gpio-leds
      dt-bindings: phy: convert phy-rockchip-inno-usb2 bindings to yaml

Kamlesh Gurudasani (1):
      dt-bindings: add vendor prefix for OzzMaker and Waveshare Electronics

Krzysztof Kozlowski (1):
      dt-bindings: usb: exynos-usb: Document clock names for DWC3 bindings

Lubomir Rintel (6):
      dt-bindings: Add vendor prefix for Dell Inc.
      dt-bindings: Add vendor prefix for ENE
      dt-bindings: arm: l2x0: Tauros 3 is PL310 compatible
      dt-bindings: arm: mrvl: Add missing compatible strings
      dt-bindings: Add "mrvl", a legacy vendor prefix for Marvell
      dt-bindings: phy: Convert phy-mmp3-usb to json-schema

Luca Ceresoli (1):
      of: overlay: log the error cause on resolver failure

Luca Weiss (1):
      dt-bindings: Add vendor prefix for SG Micro Corp

Marek Vasut (1):
      dt-bindings: Add ITE Tech prefix

Mark Rutland (1):
      MAINTAINERS: remove myself from DT bindings entry

Martin Blumenstingl (1):
      dt-bindings: display: meson-vpu: fix indentation of reg-names' "items"

Masahiro Yamada (15):
      dt-bindings: serial: Convert UniPhier UART to json-schema
      dt-bindings: i2c: Convert UniPhier I2C controller to json-schema
      dt-bindings: i2c: Convert UniPhier FI2C controller to json-schema
      dt-bindings: arm: Convert UniPhier board/SoC bindings to json-schema
      dt-bindings: gpio: Convert UniPhier GPIO to json-schema
      dt-bindings: pinctrl: Convert UniPhier pin controller to json-schema
      dt-bindings: bus: Convert UniPhier System Bus to json-schema
      dt-bindings: interrupt-controller: Convert UniPhier AIDET to json-schema
      dt-bindings: dma: Convert UniPhier MIO DMA controller to json-schema
      dt-bindings: mmc: Convert UniPhier SD controller to json-schema
      dt-bindings: mtd: Convert Denali NAND controller to json-schema
      dt-bindings: mmc: Convert Cadence SD/SDIO/eMMC controller to json-schema
      dt-bindings: clock: Convert UniPhier clock to json-schema
      dt-bindings: arm: Convert UniPhier System Cache to json-schema
      dt-bindings: uniphier-system-bus: fix warning in the example

Mauro Carvalho Chehab (5):
      docs: dt: fix references to m_can.txt file
      docs: dt: fix references to ap806-system-controller.txt
      docs: dt: fix a broken reference to input.yaml
      MAINTAINERS: dt: update etnaviv file reference
      MAINTAINERS: drop an old reference to stm32 pwm timers doc

Neil Armstrong (1):
      dt-bindings: usb: dwc2: fix bindings for amlogic, meson-gxbb-usb

Niklas Söderlund (2):
      dt-bindings: rcar-vin: Convert bindings to json-schema
      dt-bindings: thermal: rcar-thermal: Convert bindings to json-schema

Nícolas F. R. A. Prado (1):
      dt-bindings: rng: Convert BCM2835 to DT schema

Ondrej Jirman (1):
      dt-bindings: vendor-prefixes: Add prefix for PocketBook International SA

Pascal Roeleven (1):
      dt-bindings: vendor-prefixes: Add Topwise

Patrick Daly (1):
      of: of_reserved_mem: Increase limit on number of reserved regions

Peng Fan (1):
      dt-bindings: soc: imx: add binding doc for aips bus

Prashant Malani (2):
      dt-bindings: Convert usb-connector to YAML format.
      dt-bindings: Add cros-ec Type C port driver

Rob Herring (19):
      of/address: Move range parser code out of CONFIG_PCI
      microblaze: Drop using struct of_pci_range.pci_space field
      powerpc: Drop using struct of_pci_range.pci_space field
      of: Drop struct of_pci_range.pci_space field
      of/address: Rework of_pci_range parsing for non-PCI buses
      of/address: use range parser for of_dma_get_range
      of/address: Support multiple 'dma-ranges' entries
      Merge branch 'dt/ranges-rework' into dt/next
      Merge branch 'dt/linus' into dt/next
      scripts/dtc: Remove unused makefile fragments
      scripts/dtc: Update to upstream version v1.6.0-2-g87a656ae5ff9
      ARM: dts: sunxi: Fix dtc 'dma-ranges' warnings
      dt-bindings: iio/accel: Drop duplicate adi,adxl345/6 from trivial-devices.yaml
      dt-bindings: sram: qcom: Clean-up 'ranges' and child node names
      dt-bindings: Clean-up schema errors due to missing 'addtionalProperties: false'
      dt-bindings: Add missing 'additionalProperties: false'
      dt-bindings: thermal: tsens: Fix nvmem-cell-names schema
      dt-bindings: thermal: tsens: Set 'additionalProperties: false'
      dt-bindings: iio: Fix adi, ltc2983 uint64-matrix schema constraints

Robin Murphy (3):
      dt-bindings: ARM: Add recent Cortex/Neoverse CPUs
      dt-bindings: ARM: Add recent Cortex/Neoverse PMUs
      dt-bindings: ARM: Clean up PMU compatible list

Sam Shih (1):
      dt-bindings: pwm: Update bindings for MT7629 SoC

Saravana Kannan (1):
      of: property: Add device link support for power-domains and hwlocks

Ulf Hansson (2):
      dt-bindings: arm: Add some constraints for PSCI nodes
      dt-bindings: power: Fix example for power-domain

 .../bindings/arm/altera/socfpga-clk-manager.yaml   |   2 +
 .../arm/amlogic/amlogic,meson-gx-ao-secure.yaml    |   2 +
 Documentation/devicetree/bindings/arm/cpus.yaml    |  11 +
 .../devicetree/bindings/arm/freescale/fsl,scu.txt  |   2 +-
 Documentation/devicetree/bindings/arm/l2c2x0.yaml  |  45 +-
 .../devicetree/bindings/arm/mrvl/mrvl.yaml         |   5 +-
 .../devicetree/bindings/arm/msm/qcom,llcc.yaml     |   2 +
 Documentation/devicetree/bindings/arm/pmu.yaml     |  41 +-
 Documentation/devicetree/bindings/arm/psci.yaml    |   5 +
 .../devicetree/bindings/arm/renesas,prr.yaml       |   2 +
 .../bindings/arm/samsung/exynos-chipid.yaml        |   2 +
 .../devicetree/bindings/arm/samsung/pmu.yaml       |   2 +
 .../arm/samsung/samsung-secure-firmware.yaml       |   2 +
 .../bindings/arm/socionext/cache-uniphier.txt      |  60 --
 .../socionext/socionext,uniphier-system-cache.yaml | 102 ++++
 .../devicetree/bindings/arm/socionext/uniphier.txt |  47 --
 .../bindings/arm/socionext/uniphier.yaml           |  61 ++
 .../bindings/arm/stm32/st,stm32-syscon.yaml        |   2 +
 .../devicetree/bindings/ata/renesas,rcar-sata.yaml |  71 +++
 .../devicetree/bindings/ata/sata_rcar.txt          |  36 --
 .../bus/socionext,uniphier-system-bus.yaml         |  96 +++
 .../bindings/bus/uniphier-system-bus.txt           |  66 --
 .../bindings/chrome/google,cros-ec-typec.yaml      |  54 ++
 .../devicetree/bindings/clock/clock-bindings.txt   |   2 +-
 .../devicetree/bindings/clock/fsl,plldig.yaml      |   5 +
 .../devicetree/bindings/clock/imx8mn-clock.yaml    |   2 +
 .../devicetree/bindings/clock/imx8mp-clock.yaml    |   2 +
 .../devicetree/bindings/clock/milbeaut-clock.yaml  |   2 +
 .../bindings/clock/qcom,gcc-apq8064.yaml           |   2 +
 .../bindings/clock/qcom,gcc-ipq8074.yaml           |   2 +
 .../bindings/clock/qcom,gcc-msm8996.yaml           |   2 +
 .../bindings/clock/qcom,gcc-msm8998.yaml           |   2 +
 .../devicetree/bindings/clock/qcom,gcc-qcs404.yaml |   2 +
 .../devicetree/bindings/clock/qcom,gcc-sc7180.yaml |   2 +
 .../devicetree/bindings/clock/qcom,gcc-sm8150.yaml |   2 +
 .../devicetree/bindings/clock/qcom,gcc.yaml        |   2 +
 .../devicetree/bindings/clock/qcom,mmcc.yaml       |   2 +
 .../bindings/clock/qcom,msm8998-gpucc.yaml         |   2 +
 .../devicetree/bindings/clock/qcom,rpmhcc.yaml     |   2 +
 .../bindings/clock/qcom,sc7180-dispcc.yaml         |   2 +
 .../bindings/clock/qcom,sc7180-gpucc.yaml          |   2 +
 .../bindings/clock/qcom,sc7180-videocc.yaml        |   2 +
 .../bindings/clock/qcom,sdm845-dispcc.yaml         |   2 +
 .../bindings/clock/qcom,sdm845-gpucc.yaml          |   2 +
 .../bindings/clock/qcom,sdm845-videocc.yaml        |   2 +
 .../bindings/clock/socionext,uniphier-clock.yaml   |  94 +++
 .../devicetree/bindings/clock/uniphier-clock.txt   | 132 ----
 .../connector/samsung,usb-connector-11pin.txt      |   2 +-
 .../bindings/connector/usb-connector.txt           | 135 -----
 .../bindings/connector/usb-connector.yaml          | 206 +++++++
 .../bindings/display/amlogic,meson-vpu.yaml        |   8 +-
 .../bindings/display/etnaviv/etnaviv-drm.txt       |  36 --
 .../bindings/dma/sifive,fu540-c000-pdma.yaml       |   2 +
 .../bindings/dma/socionext,uniphier-mio-dmac.yaml  |  63 ++
 .../devicetree/bindings/dma/uniphier-mio-dmac.txt  |  25 -
 Documentation/devicetree/bindings/dsp/fsl,dsp.yaml |   2 +
 Documentation/devicetree/bindings/eeprom/at24.yaml |   2 +
 .../devicetree/bindings/example-schema.yaml        |   4 +-
 .../intel,ixp4xx-network-processing-engine.yaml    |   3 +
 Documentation/devicetree/bindings/gnss/gnss.txt    |   2 +-
 .../bindings/gpio/brcm,xgs-iproc-gpio.yaml         |   2 +
 .../devicetree/bindings/gpio/gpio-mvebu.txt        |   2 +-
 .../devicetree/bindings/gpio/gpio-uniphier.txt     |  51 --
 .../bindings/gpio/socionext,uniphier-gpio.yaml     |  94 +++
 .../bindings/gpio/xylon,logicvc-gpio.yaml          |   2 +
 .../devicetree/bindings/gpu/arm,mali-bifrost.yaml  |   8 +-
 .../devicetree/bindings/gpu/arm,mali-midgard.yaml  |   5 +
 .../devicetree/bindings/gpu/arm,mali-utgard.yaml   |   2 +
 .../devicetree/bindings/gpu/samsung-rotator.yaml   |   2 +
 .../devicetree/bindings/gpu/vivante,gc.yaml        |  69 +++
 .../devicetree/bindings/hwmon/adi,adm1177.yaml     |   2 +
 .../devicetree/bindings/hwmon/adi,ltc2947.yaml     |   2 +
 .../bindings/hwmon/pmbus/ti,ucd90320.yaml          |   2 +
 .../devicetree/bindings/hwmon/ti,tmp513.yaml       |   2 +
 Documentation/devicetree/bindings/i2c/i2c-rk3x.txt |  68 ---
 .../devicetree/bindings/i2c/i2c-rk3x.yaml          | 136 +++++
 .../devicetree/bindings/i2c/i2c-uniphier-f.txt     |  25 -
 .../devicetree/bindings/i2c/i2c-uniphier.txt       |  25 -
 .../bindings/i2c/socionext,uniphier-fi2c.yaml      |  50 ++
 .../bindings/i2c/socionext,uniphier-i2c.yaml       |  50 ++
 .../devicetree/bindings/iio/accel/adi,adxl345.yaml |  10 +-
 .../bindings/iio/accel/bosch,bma400.yaml           |   2 +
 .../devicetree/bindings/iio/adc/adi,ad7192.yaml    |   1 -
 .../devicetree/bindings/iio/adc/adi,ad7780.yaml    |   2 +
 .../devicetree/bindings/iio/adc/avia-hx711.yaml    |   2 +
 .../devicetree/bindings/iio/adc/lltc,ltc2496.yaml  |   2 +
 .../bindings/iio/adc/microchip,mcp3911.yaml        |   2 +
 .../bindings/iio/adc/st,stm32-dfsdm-adc.yaml       |   2 +
 .../bindings/iio/chemical/plantower,pms7003.yaml   |   2 +
 .../bindings/iio/chemical/sensirion,sps30.yaml     |   2 +
 .../devicetree/bindings/iio/dac/lltc,ltc1660.yaml  |   2 +
 .../devicetree/bindings/iio/light/adux1020.yaml    |   2 +
 .../devicetree/bindings/iio/light/bh1750.yaml      |   2 +
 .../devicetree/bindings/iio/light/isl29018.yaml    |   2 +
 .../devicetree/bindings/iio/light/noa1305.yaml     |   2 +
 .../devicetree/bindings/iio/light/stk33xx.yaml     |   2 +
 .../devicetree/bindings/iio/light/tsl2583.yaml     |   2 +
 .../devicetree/bindings/iio/light/tsl2772.yaml     |   2 +
 .../devicetree/bindings/iio/light/veml6030.yaml    |   2 +
 .../bindings/iio/pressure/asc,dlhl60d.yaml         |   2 +
 .../devicetree/bindings/iio/pressure/bmp085.yaml   |   5 +
 .../bindings/iio/proximity/devantech-srf04.yaml    |   2 +
 .../bindings/iio/proximity/parallax-ping.yaml      |   2 +
 .../bindings/iio/temperature/adi,ltc2983.yaml      |  40 +-
 .../devicetree/bindings/input/gpio-vibrator.yaml   |   2 +
 .../devicetree/bindings/input/max77650-onkey.yaml  |   3 +
 .../devicetree/bindings/input/st,stpmic1-onkey.txt |  28 -
 .../intel,ixp4xx-interrupt.yaml                    |   2 +
 .../bindings/interrupt-controller/msi.txt          |   2 +-
 .../socionext,uniphier-aidet.txt                   |  32 -
 .../socionext,uniphier-aidet.yaml                  |  61 ++
 .../devicetree/bindings/iommu/samsung,sysmmu.yaml  |   2 +
 Documentation/devicetree/bindings/leds/common.yaml |   4 +-
 .../devicetree/bindings/leds/leds-max77650.yaml    |   3 +
 .../bindings/leds/rohm,bd71828-leds.yaml           |   3 +
 .../bindings/mailbox/amlogic,meson-gxbb-mhu.yaml   |   2 +
 .../devicetree/bindings/media/amlogic,gx-vdec.yaml |   2 +
 .../bindings/media/amlogic,meson-gx-ao-cec.yaml    |  11 +-
 .../devicetree/bindings/media/renesas,ceu.yaml     |   2 +
 .../devicetree/bindings/media/renesas,vin.txt      | 217 -------
 .../devicetree/bindings/media/renesas,vin.yaml     | 402 +++++++++++++
 .../devicetree/bindings/mfd/max77650.yaml          |   2 +
 .../devicetree/bindings/mfd/rohm,bd71828-pmic.yaml |   5 +
 .../devicetree/bindings/mfd/st,stpmic1.txt         |  61 --
 .../devicetree/bindings/mfd/st,stpmic1.yaml        | 339 +++++++++++
 .../misc/intel,ixp4xx-ahb-queue-manager.yaml       |   2 +
 .../devicetree/bindings/mmc/cdns,sdhci.yaml        | 143 +++++
 .../devicetree/bindings/mmc/sdhci-cadence.txt      |  80 ---
 .../bindings/mmc/socionext,uniphier-sd.yaml        |  99 +++
 .../devicetree/bindings/mmc/uniphier-sd.txt        |  55 --
 .../devicetree/bindings/mtd/denali,nand.yaml       | 148 +++++
 .../devicetree/bindings/mtd/denali-nand.txt        |  61 --
 .../devicetree/bindings/net/broadcom-bluetooth.txt |   2 +-
 .../devicetree/bindings/net/can/bosch,m_can.yaml   | 144 +++++
 .../bindings/net/can/can-transceiver.txt           |  24 -
 .../bindings/net/can/can-transceiver.yaml          |  18 +
 .../devicetree/bindings/net/can/m_can.txt          |  75 ---
 .../devicetree/bindings/net/can/tcan4x5x.txt       |   2 +-
 .../devicetree/bindings/net/mediatek-bluetooth.txt |   2 +-
 .../devicetree/bindings/net/qca,qca7000.txt        |   2 +-
 .../devicetree/bindings/net/ti,cpsw-switch.yaml    |  25 +-
 .../devicetree/bindings/net/ti-bluetooth.txt       |   3 +-
 .../bindings/phy/allwinner,sun50i-h6-usb3-phy.yaml |   2 +
 .../phy/amlogic,meson-g12a-usb3-pcie-phy.yaml      |   2 +
 .../bindings/phy/intel,lgm-emmc-phy.yaml           |   2 +
 .../bindings/phy/marvell,mmp3-hsic-phy.yaml        |   2 +
 .../bindings/phy/marvell,mmp3-usb-phy.yaml         |  42 ++
 .../devicetree/bindings/phy/phy-mmp3-usb.txt       |  13 -
 .../bindings/phy/phy-rockchip-inno-usb2.txt        |  81 ---
 .../bindings/phy/phy-rockchip-inno-usb2.yaml       | 155 +++++
 .../devicetree/bindings/phy/ti,phy-j721e-wiz.yaml  |   2 +
 .../bindings/pinctrl/aspeed,ast2400-pinctrl.yaml   |   2 +
 .../bindings/pinctrl/aspeed,ast2500-pinctrl.yaml   |   2 +
 .../bindings/pinctrl/aspeed,ast2600-pinctrl.yaml   |   2 +
 .../pinctrl/socionext,uniphier-pinctrl.txt         |  27 -
 .../pinctrl/socionext,uniphier-pinctrl.yaml        |  42 ++
 .../bindings/pinctrl/st,stm32-pinctrl.yaml         |   2 +
 .../bindings/power/amlogic,meson-ee-pwrc.yaml      |   2 +
 .../devicetree/bindings/power/power-domain.yaml    |  28 +-
 .../devicetree/bindings/power/renesas,apmu.txt     |  35 --
 .../devicetree/bindings/power/renesas,apmu.yaml    |  55 ++
 .../bindings/power/renesas,rcar-sysc.txt           |  62 --
 .../bindings/power/renesas,rcar-sysc.yaml          |  73 +++
 .../bindings/power/reset/syscon-poweroff.yaml      |   2 +
 .../bindings/power/reset/syscon-reboot.yaml        |   2 +
 .../bindings/power/supply/max77650-charger.yaml    |   3 +
 .../devicetree/bindings/ptp/ptp-idtcm.yaml         |   2 +
 .../devicetree/bindings/pwm/pwm-mediatek.txt       |   5 +
 .../devicetree/bindings/pwm/renesas,tpu-pwm.yaml   |   4 +
 .../bindings/regulator/max77650-regulator.yaml     |   5 +-
 .../bindings/regulator/st,stpmic1-regulator.txt    |  64 --
 .../bindings/reset/amlogic,meson-reset.yaml        |   2 +
 .../reset/brcm,bcm7216-pcie-sata-rescal.yaml       |   2 +
 .../devicetree/bindings/reset/renesas,rst.txt      |  48 --
 .../devicetree/bindings/reset/renesas,rst.yaml     |  63 ++
 .../devicetree/bindings/rng/amlogic,meson-rng.yaml |   2 +
 .../devicetree/bindings/rng/brcm,bcm2835.txt       |  40 --
 .../devicetree/bindings/rng/brcm,bcm2835.yaml      |  61 ++
 .../devicetree/bindings/rtc/renesas,sh-rtc.yaml    |   2 +
 .../devicetree/bindings/rtc/st,stm32-rtc.yaml      |   2 +
 .../bindings/serial/amlogic,meson-uart.yaml        |   2 +
 .../devicetree/bindings/serial/fsl-imx-uart.txt    |   2 +-
 .../devicetree/bindings/serial/renesas,hscif.yaml  | 135 +++++
 .../bindings/serial/renesas,sci-serial.txt         | 150 -----
 .../devicetree/bindings/serial/renesas,sci.yaml    |  69 +++
 .../devicetree/bindings/serial/renesas,scif.yaml   | 172 ++++++
 .../devicetree/bindings/serial/renesas,scifa.yaml  | 107 ++++
 .../devicetree/bindings/serial/renesas,scifb.yaml  |  98 +++
 .../devicetree/bindings/serial/serial.txt          |  56 --
 .../devicetree/bindings/serial/serial.yaml         | 131 ++++
 .../devicetree/bindings/serial/slave-device.txt    |  45 --
 .../bindings/serial/snps-dw-apb-uart.yaml          |   1 +
 .../bindings/serial/socionext,uniphier-uart.yaml   |  46 ++
 .../devicetree/bindings/serial/uniphier-uart.txt   |  22 -
 .../bindings/soc/amlogic/amlogic,canvas.yaml       |   2 +
 .../devicetree/bindings/soc/imx/fsl,aips-bus.yaml  |  47 ++
 .../devicetree/bindings/sound/adi,adau7118.yaml    |   2 +
 .../devicetree/bindings/sound/qcom,wcd934x.yaml    |   2 +
 .../devicetree/bindings/sound/renesas,fsi.yaml     |   2 +
 .../devicetree/bindings/sound/samsung,odroid.yaml  |   2 +
 .../devicetree/bindings/sound/samsung-i2s.yaml     |   2 +
 .../devicetree/bindings/spi/qcom,spi-qcom-qspi.txt |  36 --
 .../bindings/spi/qcom,spi-qcom-qspi.yaml           |  88 +++
 .../devicetree/bindings/sram/qcom,ocmem.yaml       |  14 +-
 .../bindings/thermal/amlogic,thermal.yaml          |   4 +
 .../devicetree/bindings/thermal/armada-thermal.txt |   2 +-
 .../devicetree/bindings/thermal/qcom-tsens.yaml    |  37 +-
 .../devicetree/bindings/thermal/rcar-thermal.txt   |  78 ---
 .../devicetree/bindings/thermal/rcar-thermal.yaml  | 139 +++++
 .../devicetree/bindings/timer/arm,arch_timer.yaml  |   2 +
 .../bindings/timer/arm,arch_timer_mmio.yaml        |   4 +
 .../bindings/timer/arm,global_timer.yaml           |   2 +
 .../bindings/timer/intel,ixp4xx-timer.yaml         |   2 +
 .../bindings/timer/samsung,exynos4210-mct.yaml     |   2 +
 .../devicetree/bindings/trivial-devices.yaml       |   6 +-
 Documentation/devicetree/bindings/usb/dwc2.yaml    |  19 +-
 .../devicetree/bindings/usb/exynos-usb.txt         |   9 +-
 .../devicetree/bindings/usb/fcs,fusb302.txt        |   2 +-
 Documentation/devicetree/bindings/usb/generic.txt  |   2 +-
 .../devicetree/bindings/usb/mediatek,mtu3.txt      |   2 +-
 .../devicetree/bindings/usb/mediatek,musb.txt      |   2 +-
 .../devicetree/bindings/usb/richtek,rt1711h.txt    |   2 +-
 .../devicetree/bindings/usb/ti,hd3ss3220.txt       |   2 +-
 .../devicetree/bindings/usb/typec-tcpci.txt        |   2 +-
 .../devicetree/bindings/usb/usb-conn-gpio.txt      |   4 +-
 .../devicetree/bindings/vendor-prefixes.yaml       |  27 +
 .../bindings/watchdog/st,stpmic1-wdt.txt           |  11 -
 MAINTAINERS                                        |  18 +-
 arch/arm/boot/dts/sun5i.dtsi                       |   2 +
 arch/arm/boot/dts/sun8i-r40.dtsi                   |   2 +
 arch/arm/boot/dts/sunxi-h3-h5.dtsi                 |   2 +
 arch/microblaze/pci/pci-common.c                   |   7 +-
 arch/powerpc/kernel/pci-common.c                   |   2 +-
 drivers/of/address.c                               | 273 +++++----
 drivers/of/of_private.h                            |   2 +-
 drivers/of/of_reserved_mem.c                       |   2 +-
 drivers/of/property.c                              |   4 +
 drivers/of/resolver.c                              |   5 +-
 drivers/of/unittest-data/Makefile                  |   8 +-
 drivers/of/unittest-data/overlay_gpio_01.dts       |  23 +
 drivers/of/unittest-data/overlay_gpio_02a.dts      |  16 +
 drivers/of/unittest-data/overlay_gpio_02b.dts      |  16 +
 drivers/of/unittest-data/overlay_gpio_03.dts       |  23 +
 drivers/of/unittest-data/overlay_gpio_04a.dts      |  16 +
 drivers/of/unittest-data/overlay_gpio_04b.dts      |  16 +
 drivers/of/unittest.c                              | 669 +++++++++++++++++++--
 include/linux/of_address.h                         |  13 +-
 scripts/dtc/Makefile.dtc                           |  23 -
 scripts/dtc/checks.c                               |  25 +-
 scripts/dtc/dtc-lexer.l                            |   1 -
 scripts/dtc/libfdt/Makefile.libfdt                 |  18 -
 scripts/dtc/libfdt/fdt.c                           |  99 +--
 scripts/dtc/libfdt/fdt_ro.c                        | 143 ++---
 scripts/dtc/libfdt/fdt_rw.c                        |  42 +-
 scripts/dtc/libfdt/fdt_sw.c                        |  19 +-
 scripts/dtc/libfdt/libfdt.h                        |   9 +-
 scripts/dtc/libfdt/libfdt_internal.h               | 122 ++++
 scripts/dtc/update-dtc-source.sh                   |   4 +-
 scripts/dtc/version_gen.h                          |   2 +-
 259 files changed, 5749 insertions(+), 2660 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/socionext/cache-uniphier.txt
 create mode 100644 Documentation/devicetree/bindings/arm/socionext/socionext,uniphier-system-cache.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/socionext/uniphier.txt
 create mode 100644 Documentation/devicetree/bindings/arm/socionext/uniphier.yaml
 create mode 100644 Documentation/devicetree/bindings/ata/renesas,rcar-sata.yaml
 delete mode 100644 Documentation/devicetree/bindings/ata/sata_rcar.txt
 create mode 100644 Documentation/devicetree/bindings/bus/socionext,uniphier-system-bus.yaml
 delete mode 100644 Documentation/devicetree/bindings/bus/uniphier-system-bus.txt
 create mode 100644 Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/socionext,uniphier-clock.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/uniphier-clock.txt
 delete mode 100644 Documentation/devicetree/bindings/connector/usb-connector.txt
 create mode 100644 Documentation/devicetree/bindings/connector/usb-connector.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/etnaviv/etnaviv-drm.txt
 create mode 100644 Documentation/devicetree/bindings/dma/socionext,uniphier-mio-dmac.yaml
 delete mode 100644 Documentation/devicetree/bindings/dma/uniphier-mio-dmac.txt
 delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-uniphier.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/socionext,uniphier-gpio.yaml
 create mode 100644 Documentation/devicetree/bindings/gpu/vivante,gc.yaml
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-rk3x.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-rk3x.yaml
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-uniphier-f.txt
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-uniphier.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/socionext,uniphier-fi2c.yaml
 create mode 100644 Documentation/devicetree/bindings/i2c/socionext,uniphier-i2c.yaml
 delete mode 100644 Documentation/devicetree/bindings/input/st,stpmic1-onkey.txt
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/socionext,uniphier-aidet.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/socionext,uniphier-aidet.yaml
 delete mode 100644 Documentation/devicetree/bindings/media/renesas,vin.txt
 create mode 100644 Documentation/devicetree/bindings/media/renesas,vin.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/st,stpmic1.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/st,stpmic1.yaml
 create mode 100644 Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
 delete mode 100644 Documentation/devicetree/bindings/mmc/sdhci-cadence.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/socionext,uniphier-sd.yaml
 delete mode 100644 Documentation/devicetree/bindings/mmc/uniphier-sd.txt
 create mode 100644 Documentation/devicetree/bindings/mtd/denali,nand.yaml
 delete mode 100644 Documentation/devicetree/bindings/mtd/denali-nand.txt
 create mode 100644 Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/can/can-transceiver.txt
 create mode 100644 Documentation/devicetree/bindings/net/can/can-transceiver.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/can/m_can.txt
 create mode 100644 Documentation/devicetree/bindings/phy/marvell,mmp3-usb-phy.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/phy-mmp3-usb.txt
 delete mode 100644 Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt
 create mode 100644 Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/socionext,uniphier-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/socionext,uniphier-pinctrl.yaml
 delete mode 100644 Documentation/devicetree/bindings/power/renesas,apmu.txt
 create mode 100644 Documentation/devicetree/bindings/power/renesas,apmu.yaml
 delete mode 100644 Documentation/devicetree/bindings/power/renesas,rcar-sysc.txt
 create mode 100644 Documentation/devicetree/bindings/power/renesas,rcar-sysc.yaml
 delete mode 100644 Documentation/devicetree/bindings/regulator/st,stpmic1-regulator.txt
 delete mode 100644 Documentation/devicetree/bindings/reset/renesas,rst.txt
 create mode 100644 Documentation/devicetree/bindings/reset/renesas,rst.yaml
 delete mode 100644 Documentation/devicetree/bindings/rng/brcm,bcm2835.txt
 create mode 100644 Documentation/devicetree/bindings/rng/brcm,bcm2835.yaml
 create mode 100644 Documentation/devicetree/bindings/serial/renesas,hscif.yaml
 delete mode 100644 Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
 create mode 100644 Documentation/devicetree/bindings/serial/renesas,sci.yaml
 create mode 100644 Documentation/devicetree/bindings/serial/renesas,scif.yaml
 create mode 100644 Documentation/devicetree/bindings/serial/renesas,scifa.yaml
 create mode 100644 Documentation/devicetree/bindings/serial/renesas,scifb.yaml
 delete mode 100644 Documentation/devicetree/bindings/serial/serial.txt
 create mode 100644 Documentation/devicetree/bindings/serial/serial.yaml
 delete mode 100644 Documentation/devicetree/bindings/serial/slave-device.txt
 create mode 100644 Documentation/devicetree/bindings/serial/socionext,uniphier-uart.yaml
 delete mode 100644 Documentation/devicetree/bindings/serial/uniphier-uart.txt
 create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,aips-bus.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.txt
 create mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml
 delete mode 100644 Documentation/devicetree/bindings/thermal/rcar-thermal.txt
 create mode 100644 Documentation/devicetree/bindings/thermal/rcar-thermal.yaml
 delete mode 100644 Documentation/devicetree/bindings/watchdog/st,stpmic1-wdt.txt
 create mode 100644 drivers/of/unittest-data/overlay_gpio_01.dts
 create mode 100644 drivers/of/unittest-data/overlay_gpio_02a.dts
 create mode 100644 drivers/of/unittest-data/overlay_gpio_02b.dts
 create mode 100644 drivers/of/unittest-data/overlay_gpio_03.dts
 create mode 100644 drivers/of/unittest-data/overlay_gpio_04a.dts
 create mode 100644 drivers/of/unittest-data/overlay_gpio_04b.dts
 delete mode 100644 scripts/dtc/Makefile.dtc
 delete mode 100644 scripts/dtc/libfdt/Makefile.libfdt
