Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D229C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 22:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30536207ED
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 22:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591308307;
	bh=Mmwhlvmbke6m9u8S5Nmxjc7494LIdTm1JbbPcXvOP68=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=rbw6giZpZz4IUR9IPQP/vLwkQqbi1/2Wmg753sZmAlkbvSirPSyBgd79wtgLfxzmJ
	 VQUpMRP15gNd69qSG+4LJaTpraDRRa5LaySLRzpS4Myn8op7RvBv5CemfXS2E5ndLu
	 bg0a8Y45vtio5u0iDHZ9toBSDAUrAx9HnYSKhWPU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbgFDWFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 18:05:06 -0400
Received: from mail-io1-f53.google.com ([209.85.166.53]:41341 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbgFDWFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 18:05:05 -0400
Received: by mail-io1-f53.google.com with SMTP id o5so8093464iow.8;
        Thu, 04 Jun 2020 15:05:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=Qgx/58NREGpl3pmSA9lKCXYV4qQ06xQZjM9wI/0pp/M=;
        b=qgB9miiKOQfL69Fw9KiHk4tAYfbNWko2FvACTuivvUg2Em6obZm2/zCVumEyWpFPcl
         7LfvbZuNQejQZj9OHy/YZsBDOrdhsZpNKObRca8Hfxu+MDyVnRq6/UYTVYTEj9zOfWQ3
         U6xXv+FTKafktOR/JTh3XI7/V4L8hKaLSj4WgwXwHkwLymZaCxRnvL9mkGqdfu6kt27B
         X+8tdXxM55t8qsyFxauBdSJb4Uliq6UmqPEKnNsVZ8TQ05LDFhi+W00qr2+D74tyVadA
         7+Kz+M0G81JRkyafSb7YEMtrbDeWaFb+GQK1JwDqV1sHNPJjQ61dmNJeKlXbuzqU4bfU
         HiSQ==
X-Gm-Message-State: AOAM530/tKdj6TeYRA1DmoInGTKJ++obJJszCzDNM794V7jVrbGd8vAz
        jUPLZnsZVQmEhgiJ7w73UQ==
X-Google-Smtp-Source: ABdhPJx3FqPepRb3vhJUZbAwr1+zByWgtDNVJneQMNquskasLDUQoeGTtYn9Xai8NgdVRqX28hv3Ew==
X-Received: by 2002:a5e:d903:: with SMTP id n3mr5646632iop.93.1591308301134;
        Thu, 04 Jun 2020 15:05:01 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id v17sm1965890iln.67.2020.06.04.15.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 15:05:00 -0700 (PDT)
Received: (nullmailer pid 4124676 invoked by uid 1000);
        Thu, 04 Jun 2020 22:04:59 -0000
Date:   Thu, 4 Jun 2020 16:04:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Subject: [GIT PULL] Devicetree updates for v5.8
Message-ID: <20200604220459.GA4123489@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull DT updates for v5.8.

There's a couple of conflicts with your tree. renesas,wdt.txt can just 
be deleted, my tree already has the necessary changes. For 
qcom,ipa.yaml, take 'reg' property from my tree and 'iommus' from 
yours(net). linux-next has the correct resolutions. Note that there's a 
couple of other similar conflicts you can expect in linux-next.

Rob


The following changes since commit 4bc77b2d211e107fa54b1f39cd0d7dac5537b8cb:

  dt-bindings: phy: qcom-qusb2: Fix defaults (2020-04-24 17:53:57 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-5.8

for you to fetch changes up to 8211d1e83aded34631aa87fa37f97d7bb712e925:

  dt-bindings: clock: Add documentation for X1830 bindings. (2020-06-03 15:59:40 -0600)

----------------------------------------------------------------
Devicetree updates for v5.8:

- Convert various DT (non-binding) doc files to ReST

- Various improvements to device link code

- Fix __of_attach_node_sysfs refcounting bug

- Add support for 'memory-region-names' with reserved-memory binding

- Vendor prefixes for Protonic Holland, BeagleBoard.org, Alps, Check
  Point, Würth Elektronik, U-Boot, Vaisala, Baikal Electronics, Shanghai
  Awinic Technology Co., MikroTik, Silex Insight

- A bunch more binding conversions to DT schema. Only 3K to go.

- Add a minimum version check for schema tools

- Treewide dropping of 'allOf' usage with schema references. Not needed
  in new json-schema spec.

- Some formatting clean-ups of schemas

----------------------------------------------------------------
Akash Asthana (3):
      dt-bindings: geni-se: Convert QUP geni-se bindings to YAML
      dt-bindings: geni-se: Add interconnect binding for GENI QUP
      dt-bindings: serial: Add binding for UART pin swap

Alain Volmat (1):
      dt-bindings: i2c: i2c-stm32f7: add st,stm32mp15-i2c compatible

Andre Przywara (11):
      dt-bindings: clock: Convert Calxeda clock bindings to json-schema
      dt-bindings: sata: Convert Calxeda SATA controller to json-schema
      dt-bindings: net: Convert Calxeda Ethernet binding to json-schema
      dt-bindings: phy: Convert Calxeda ComboPHY binding to json-schema
      dt-bindings: arm: Convert Calxeda L2 cache controller to json-schema
      dt-bindings: memory-controllers: Convert Calxeda DDR to json-schema
      dt-bindings: ipmi: Convert IPMI-SMIC bindings to json-schema
      dt-bindings: arm: Add Calxeda system registers json-schema binding
      dt-bindings: arm: gic: Allow combining arm,gic-400 compatible strings
      dt-bindings: mali-midgard: Allow dma-coherent
      dt-bindings: ehci/ohci: Allow iommus property

Anson Huang (37):
      dt-bindings: thermal: Convert i.MX8MM to json-schema
      dt-bindings: gpio: Convert i.MX to json-schema
      dt-bindings: nvmem: Convert i.MX OCOTP to json-schema
      dt-bindings: nvmem: Convert i.MX IIM to json-schema
      dt-bindings: nvmem: Convert MXS OCOTP to json-schema
      dt-bindings: watchdog: Convert i.MX to json-schema
      dt-bindings: watchdog: Convert i.MX7ULP to json-schema
      dt-bindings: clock: Convert i.MX6Q clock to json-schema
      dt-bindings: clock: Convert i.MX6SX clock to json-schema
      dt-bindings: clock: Convert i.MX6SL clock to json-schema
      dt-bindings: clock: Convert i.MX6SLL clock to json-schema
      dt-bindings: clock: Convert i.MX6UL clock to json-schema
      dt-bindings: rtc: Convert MXC RTC to json-schema
      dt-bindings: rtc: Convert MXC RTC V2 to json-schema
      dt-bindings: pwm: Convert imx pwm to json-schema
      dt-bindings: pwm: Convert imx tpm pwm to json-schema
      dt-bindings: pwm: Convert mxs pwm to json-schema
      dt-bindings: interrupt-controller: Convert imx irqsteer to json-schema
      dt-bindings: clock: Convert i.MX7D clock to json-schema
      dt-bindings: timer: Convert i.MX TPM to json-schema
      dt-bindings: timer: Convert i.MX SYSCTR to json-schema
      dt-bindings: gpio: Convert mxs to json-schema
      dt-bindings: thermal: Convert i.MX to json-schema
      dt-bindings: clock: Convert i.MX5 clock to json-schema
      dt-bindings: clock: Convert i.MX35 clock to json-schema
      dt-bindings: clock: Convert i.MX31 clock to json-schema
      dt-bindings: clock: Convert i.MX28 clock to json-schema
      dt-bindings: clock: Convert i.MX23 clock to json-schema
      dt-bindings: clock: Convert i.MX27 clock to json-schema
      dt-bindings: clock: Convert i.MX25 clock to json-schema
      dt-bindings: clock: Convert i.MX21 clock to json-schema
      dt-bindings: clock: Convert i.MX1 clock to json-schema
      dt-bindings: timer: Convert i.MX GPT to json-schema
      dt-bindings: clock: Convert i.MX8QXP LPCG to json-schema
      dt-bindings: power: Convert imx gpc to json-schema
      dt-bindings: power: Convert imx gpcv2 to json-schema
      dt-bindings: mailbox: Convert imx mu to json-schema

Charles Keepax (12):
      hwmon: lochnagar: Move binding over to dtschema
      ASoC: lochnagar: Move binding over to dtschema
      pinctrl: lochnagar: Move binding over to dtschema
      clk: lochnagar: Move binding over to dtschema
      mfd: lochnagar: Move binding over to dtschema
      regulator: arizona-regulator: Move binding over to dtschema
      extcon: arizona: Move binding over to dtschema
      ASoC: arizona: Move binding over to dtschema
      mfd: arizona: Move binding over to dtschema
      ASoC: madera: Move binding over to dtschema
      pinctrl: madera: Move binding over to dtschema
      mfd: madera: Move binding over to dtschema

Christophe Roullier (2):
      dt-bindings: net: dwmac: increase 'maxItems' for 'clocks', 'clock-names' properties
      dt-bindings: net: dwmac: Convert stm32 dwmac to DT schema

Dan Carpenter (1):
      of: Fix a refcounting bug in __of_attach_node_sysfs()

Ding Xiang (1):
      of: of_detach_node() remove unneeded local return variable

Drew Fustini (1):
      dt-bindings: Add vendor prefix for BeagleBoard.org

Etienne Carriere (1):
      dt-bindings: nvmem: stm32: new property for data access

Frank Rowand (1):
      of: Documentation: change overlay example to use current syntax

Geert Uytterhoeven (16):
      dt-bindings: usb: generic-ehci: Document power-domains property
      dt-bindings: usb: generic-ohci: Document power-domains property
      dt-bindings: gpio: rcar: Convert to json-schema
      dt-bindings: watchdog: renesas-wdt: Convert to json-schema
      dt-bindings: timer: renesas: ostm: Convert to json-schema
      dt-bindings: eeprom: at24: Fix list of page sizes for writing
      dt-bindings: auxdisplay: hd44780: Convert to json-schema
      dt-bindings: serial: renesas,scifa: Remove part numbers from comments
      dt-bindings: media: Add missing clock domain description
      dt-bindings: rtc: rtc-sh: Add missing power-domains property
      ASoC: fsi: Add missing properties to DT bindings
      dt-bindings: interrupt-controller: arm,gic: Document resets property
      dt-bindings: memory-controllers: renesas,dbsc: Convert to json-schema
      dt-bindings: serial: Add renesas,em-uart bindings
      dt-bindings: timer: renesas: mtu2: Convert to json-schema
      dt-bindings: timer: renesas: cmt: Convert to json-schema

Johan Jonker (4):
      dt-bindings: sram: convert rockchip-pmu-sram bindings to yaml
      dt-bindings: gpu: add power-domains #cooling-cells to arm,mali-bifrost.yaml
      dt-bindings: usb: dwc2: add power-domains property
      dt-bindings: input: touchscreen: edt-ft5x06: change reg property

Jonathan Albrieux (1):
      dt-bindings: iio: imu: bmi160: convert format to yaml, add maintainer

Jonathan McDowell (1):
      dt-bindings: vendor-prefixes: Add MikroTik

Joseph Lo (1):
      dt-bindings: memory: tegra: Add external memory controller binding for Tegra210

Kangmin Park (1):
      docs/devicetree/i2c: brcm,bcm2835: fix node id in example

Krzysztof Kozlowski (1):
      dt-bindings: memory-controllers: exynos-srom: Remove unneeded type for reg-io-width

Kunihiko Hayashi (5):
      dt-bindings: phy: Convert UniPhier PCIe-PHY controller to json-schema
      dt-bindings: phy: Convert UniPhier USB2-PHY controller to json-schema
      dt-bindings: phy: Convert UniPhier USB3-PHY conroller to json-schema
      dt-bindings: thermal: Convert UniPhier thermal monitor to json-schema
      dt-bindings: watchdog: Convert UniPhier watchdog timer to json-schema

Lad Prabhakar (19):
      dt-bindings: sh_eth: Sort compatible string in increasing number of the SoC
      dt-bindings: irqchip: renesas-irqc: Document r8a7742 bindings
      dt-bindings: serial: renesas,scif: Document r8a7742 bindings
      dt-bindings: serial: renesas,scifb: Document r8a7742 bindings
      dt-bindings: serial: renesas,hscif: Document r8a7742 bindings
      dt-bindings: watchdog: renesas,wdt: Document r8a7742 support
      dt-bindings: serial: renesas,scifa: Document r8a7742 bindings
      dt-bindings: i2c: renesas, i2c: Document r8a7742 support
      dt-bindings: i2c: renesas, iic: Document r8a7742 support
      dt-bindings: ata: renesas,rcar-sata: Add r8a7742 support
      dt-bindings: net: renesas, ravb: Add support for r8a7742 SoC
      dt-bindings: net: renesas,ether: Document R8A7742 SoC
      dt-bindings: power: renesas,apmu: Document r8a7742 support
      dt-bindings: gpio: renesas, rcar-gpio: Add r8a7742 (RZ/G1H) support
      dt-bindings: phy: rcar-gen2: Add r8a7742 support
      dt-bindings: PCI: pci-rcar-gen2: Add device tree support for r8a7742
      dt-bindings: usb: renesas,usbhs: Add support for r8a7742
      dt-bindings: usb: usb-xhci: Document r8a7742 support
      dt-bindings: thermal: rcar-thermal: Add device tree support for r8a7742

Lubomir Rintel (5):
      dt-bindings: serial: Move Marvell compatible string to 8250 binding doc
      dt-bindings: serial: Convert 8250 to json-schema
      dt-bindings: media: Convert marvell,mmp2-ccic to json-schema
      dt-bindings: spi: Convert spi-pxa2xx to json-schema
      dt-bindings: usb: Convert ehci-mv to json-schema

Martin Blumenstingl (1):
      dt-bindings: gpu: mali-utgard: Add the #cooling-cells property

Masahiro Yamada (1):
      dt-bindings: at24: add microchip, 24lc[0-9]+ to the compatible pattern

Matthias Brugger (1):
      dt-bindings: dma: uart: mtk: fix example

Mauro Carvalho Chehab (10):
      docs: dt: add an index.rst file for devicetree
      docs: dt: convert usage-model.txt to ReST
      docs: dt: usage_model.rst: fix link for DT usage
      docs: dt: convert changesets to ReST
      docs: dt: convert dynamic-resolution-notes.txt to ReST
      docs: dt: convert of_unittest.txt to ReST
      docs: dt: convert overlay-notes.txt to ReST format
      docs: dt: convert ABI.txt to ReST format
      docs: dt: convert submitting-patches.txt to ReST format
      docs: dt: convert writing-bindings.txt to ReST

Michal Simek (1):
      dt-bindings: vendor-prefixes: Add U-Boot bootloader prefix

Neil Armstrong (1):
      dt-bindings: sram: Add Amlogic SCP SRAM compatibles

Nick Reitemeyer (1):
      dt-bindings: vendor-prefixes: Add Alps

Nicolas Saenz Julienne (2):
      of: property: Fix create device links for all child-supplier dependencies
      of: property: Do not link to disabled devices

Nikita Travkin (1):
      dt-bindings: vendor-prefixes: Add Shanghai Awinic Technology Co., Ltd.

Niklas Söderlund (1):
      dt-bindings: thermal: rcar-gen3-thermal: Convert bindings to json-schema

Nobuhiro Iwamatsu (3):
      dt-bindings: i2c: cadence: Migrate i2c-cadence documentation to YAML
      dt-bindings: i2c: xiic: Migrate i2c-xiic documentation to YAML
      dt-bindings: timer: cadence_ttc: Migrate timer-cadence-ttc documentation to YAML

Oleksij Rempel (2):
      dt-bindings: vendor-prefixes: Add an entry for Protonic Holland
      dt-bindings: serial: qca,ar9330-uart: Convert to json-schema

Olivier Sobrie (1):
      dt-bindings: vendor-prefixes: Add Silex Insight vendor prefix

Paul Cercueil (11):
      dt-bindings: timer: Convert ingenic,tcu.txt to YAML
      dt-bindings: mmc: Convert jz4740-mmc doc to YAML
      dt-bindings: dma: Convert jz4740-dma doc to YAML
      dt-bindings: usb: ingenic,musb: Add usb-role-switch property
      dt-bindings: MIPS: Require SoC compatible string after board string
      dt-bindings: clock: Convert ingenic,cgu.txt to YAML
      dt-bindings: intc: Convert ingenic,intc.txt to YAML
      dt-bindings: i2c: Convert i2c-jz4780.txt to YAML
      dt-bindings: serial: Convert ingenic,uart.txt to YAML
      dt-bindings: memory: Convert ingenic,jz4780-nemc.txt to YAML
      dt-bindings: mtd: Convert ingenic,jz4780-nand.txt to YAML

Pawel Dembicki (1):
      dt-bindings: vendor-prefixes: Add Check Point

Peng Fan (1):
      dt-bindings: mailbox: imx-mu: correct example

Qi Zheng (2):
      dt/platform: Fix comment in of_dev_lookup()
      of/fdt: Remove redundant kbasename function call

Ricardo Cañuelo (2):
      dt-bindings: nvmem: Convert rockchip-efuse bindings to yaml
      dt-bindings: display: anx7814.txt: convert to yaml

Rob Herring (12):
      dt-bindings: input: Convert gpio-keys bindings to schema
      dt-bindings: Clean-up schema indentation formatting
      Merge branch 'dt/linus' into dt/next
      dt-bindings: iio: adi,ltc2983: Add missing quotes on dependencies
      Merge branch 'dt/linus' into 'dt/next'
      dt-bindings: Add a minimum version check for dtschema
      dt-bindings: Remove cases of 'allOf' containing a '$ref'
      spi: dt-bindings: sifive: Add missing 2nd register region
      dt-bindings: usb: ehci: Add missing 2nd register region
      dt-bindings: ufs: ti: Fix address properties handling
      dt-bindings: ufs: ti: Add missing 'additionalProperties: false'
      dt-bindings: Fix incorrect 'reg' property sizes

Samuel Holland (1):
      dt-bindings: timer: Document allwinner,erratum-unknown1 property

Sandeep Maheswaram (3):
      dt-bindings: usb: qcom,dwc3: Convert USB DWC3 bindings
      dt-bindings: usb: qcom,dwc3: Add compatible for SC7180
      dt-bindings: usb: qcom,dwc3: Introduce interconnect properties for Qualcomm DWC3 driver

Saravana Kannan (2):
      of: property: Add device link support for extcon
      of: property: Don't retry device_link_add() upon failure

Saravanan Sekar (1):
      dt-bindings: Add an entry for Würth Elektronik, we

Serge Semin (1):
      dt-bindings: Add vendor prefix for Baikal Electronics, JSC

Thierry Reding (2):
      dt-bindings: reserved-memory: Introduce memory-region-names
      dt-bindings: Merge gpio-usb-b-connector with usb-connector

Vesa Jääskeläinen (1):
      dt-bindings: vendor-prefixes: Add Vaisala

Yoshihiro Kaneko (1):
      dt-bindings: irqchip: renesas-intc-irqpin: Convert to json-schema

Yoshihiro Shimoda (1):
      dt-bindings: iommu: renesas,ipmmu-vmsa: convert to json-schema

chenqiwu (1):
      drivers/of: keep description of function consistent with function name

tangjianqiang (1):
      of: fix the warnings from command line.

周琰杰 (Zhou Yanjie) (1):
      dt-bindings: clock: Add documentation for X1830 bindings.

 Documentation/arm/microchip.rst                    |   2 +-
 .../devicetree/bindings/{ABI.txt => ABI.rst}       |   5 +-
 Documentation/devicetree/bindings/Makefile         |  14 +-
 Documentation/devicetree/bindings/arm/altera.yaml  |   6 +-
 Documentation/devicetree/bindings/arm/amlogic.yaml |   2 +-
 .../arm/amlogic/amlogic,meson-gx-ao-secure.yaml    |   2 +-
 .../devicetree/bindings/arm/arm,vexpress-juno.yaml |  34 +-
 Documentation/devicetree/bindings/arm/bitmain.yaml |   2 +-
 .../devicetree/bindings/arm/calxeda/hb-sregs.yaml  |  49 +++
 .../devicetree/bindings/arm/calxeda/l2ecc.txt      |  15 -
 .../devicetree/bindings/arm/calxeda/l2ecc.yaml     |  42 +++
 .../devicetree/bindings/arm/coresight-cti.yaml     |  20 +-
 Documentation/devicetree/bindings/arm/cpus.yaml    |  85 +++--
 Documentation/devicetree/bindings/arm/l2c2x0.yaml  |  87 +++--
 .../devicetree/bindings/arm/nxp/lpc32xx.yaml       |   9 +-
 Documentation/devicetree/bindings/arm/psci.yaml    |  16 +-
 .../devicetree/bindings/arm/renesas,prr.yaml       |   2 +-
 .../bindings/arm/samsung/exynos-chipid.yaml        |   5 +-
 .../bindings/arm/socionext/uniphier.yaml           |  26 +-
 .../devicetree/bindings/arm/stm32/st,mlahb.yaml    |   2 +-
 .../bindings/arm/stm32/st,stm32-syscon.yaml        |   6 +-
 Documentation/devicetree/bindings/arm/syna.txt     |   2 +-
 .../bindings/arm/tegra/nvidia,tegra20-pmc.yaml     |   2 +-
 .../devicetree/bindings/ata/faraday,ftide010.yaml  |   4 +-
 .../devicetree/bindings/ata/renesas,rcar-sata.yaml |   1 +
 .../devicetree/bindings/ata/sata_highbank.txt      |  44 ---
 .../devicetree/bindings/ata/sata_highbank.yaml     |  95 ++++++
 .../devicetree/bindings/auxdisplay/hit,hd44780.txt |  45 ---
 .../bindings/auxdisplay/hit,hd44780.yaml           |  96 ++++++
 .../bindings/bus/allwinner,sun50i-a64-de2.yaml     |   5 +-
 .../bindings/bus/allwinner,sun8i-a23-rsb.yaml      |   4 +-
 .../clock/allwinner,sun4i-a10-gates-clk.yaml       |   8 +-
 .../bindings/clock/bitmain,bm1880-clk.yaml         |   2 +-
 .../devicetree/bindings/clock/calxeda.txt          |  17 -
 .../devicetree/bindings/clock/calxeda.yaml         |  82 +++++
 .../devicetree/bindings/clock/cirrus,lochnagar.txt |  94 ------
 .../bindings/clock/cirrus,lochnagar.yaml           |  78 +++++
 .../bindings/clock/fixed-factor-clock.yaml         |   5 +-
 .../devicetree/bindings/clock/fsl,plldig.yaml      |  19 +-
 .../devicetree/bindings/clock/imx1-clock.txt       |  26 --
 .../devicetree/bindings/clock/imx1-clock.yaml      |  51 +++
 .../devicetree/bindings/clock/imx21-clock.txt      |  27 --
 .../devicetree/bindings/clock/imx21-clock.yaml     |  51 +++
 .../devicetree/bindings/clock/imx23-clock.txt      |  70 ----
 .../devicetree/bindings/clock/imx23-clock.yaml     |  92 ++++++
 .../devicetree/bindings/clock/imx25-clock.txt      | 160 ----------
 .../devicetree/bindings/clock/imx25-clock.yaml     | 186 +++++++++++
 .../devicetree/bindings/clock/imx27-clock.txt      |  27 --
 .../devicetree/bindings/clock/imx27-clock.yaml     |  55 ++++
 .../devicetree/bindings/clock/imx28-clock.txt      |  93 ------
 .../devicetree/bindings/clock/imx28-clock.yaml     | 115 +++++++
 .../devicetree/bindings/clock/imx31-clock.txt      |  90 ------
 .../devicetree/bindings/clock/imx31-clock.yaml     | 120 +++++++
 .../devicetree/bindings/clock/imx35-clock.txt      | 114 -------
 .../devicetree/bindings/clock/imx35-clock.yaml     | 139 ++++++++
 .../devicetree/bindings/clock/imx5-clock.txt       |  28 --
 .../devicetree/bindings/clock/imx5-clock.yaml      |  65 ++++
 .../devicetree/bindings/clock/imx6q-clock.txt      |  41 ---
 .../devicetree/bindings/clock/imx6q-clock.yaml     |  72 +++++
 .../devicetree/bindings/clock/imx6sl-clock.txt     |  10 -
 .../devicetree/bindings/clock/imx6sl-clock.yaml    |  48 +++
 .../devicetree/bindings/clock/imx6sll-clock.txt    |  36 ---
 .../devicetree/bindings/clock/imx6sll-clock.yaml   |  66 ++++
 .../devicetree/bindings/clock/imx6sx-clock.txt     |  13 -
 .../devicetree/bindings/clock/imx6sx-clock.yaml    |  70 ++++
 .../devicetree/bindings/clock/imx6ul-clock.txt     |  13 -
 .../devicetree/bindings/clock/imx6ul-clock.yaml    |  66 ++++
 .../devicetree/bindings/clock/imx7d-clock.txt      |  13 -
 .../devicetree/bindings/clock/imx7d-clock.yaml     |  65 ++++
 .../devicetree/bindings/clock/imx8qxp-lpcg.txt     |  51 ---
 .../devicetree/bindings/clock/imx8qxp-lpcg.yaml    |  73 +++++
 .../devicetree/bindings/clock/ingenic,cgu.txt      |  57 ----
 .../devicetree/bindings/clock/ingenic,cgu.yaml     | 124 ++++++++
 .../devicetree/bindings/clock/qcom,gcc-sc7180.yaml |   2 +-
 .../devicetree/bindings/clock/qcom,gcc-sm8150.yaml |   2 +-
 .../devicetree/bindings/clock/qcom,gcc-sm8250.yaml |   2 +-
 .../devicetree/bindings/clock/qcom,mmcc.yaml       |  16 +-
 .../bindings/clock/qcom,sc7180-dispcc.yaml         |   2 +-
 .../bindings/clock/qcom,sc7180-gpucc.yaml          |   2 +-
 .../devicetree/bindings/clock/qcom,sc7180-mss.yaml |   2 +-
 .../bindings/clock/qcom,sc7180-videocc.yaml        |   2 +-
 .../bindings/clock/qcom,sdm845-dispcc.yaml         |   2 +-
 .../bindings/clock/qcom,sdm845-gpucc.yaml          |   2 +-
 .../bindings/clock/qcom,sdm845-videocc.yaml        |   2 +-
 .../bindings/clock/sprd,sc9863a-clk.yaml           |  29 +-
 .../bindings/connector/usb-connector.yaml          |  73 +++--
 .../crypto/allwinner,sun4i-a10-crypto.yaml         |  14 +-
 .../bindings/crypto/allwinner,sun8i-ce.yaml        |  16 +-
 .../bindings/crypto/amlogic,gxl-crypto.yaml        |   4 +-
 .../devicetree/bindings/crypto/st,stm32-hash.yaml  |   9 +-
 .../allwinner,sun4i-a10-display-engine.yaml        |   7 +-
 .../bindings/display/allwinner,sun4i-a10-hdmi.yaml |  40 +--
 .../bindings/display/allwinner,sun4i-a10-tcon.yaml |  63 ++--
 .../display/allwinner,sun6i-a31-mipi-dsi.yaml      |  28 +-
 .../display/allwinner,sun8i-a83t-dw-hdmi.yaml      |  10 +-
 .../bindings/display/bridge/analogix,anx7814.yaml  | 119 +++++++
 .../devicetree/bindings/display/bridge/anx7814.txt |  42 ---
 .../bindings/display/bridge/lvds-codec.yaml        |  18 +-
 .../bindings/display/panel/panel-common.yaml       |  11 +-
 .../bindings/display/panel/panel-timing.yaml       | 120 ++++---
 .../bindings/display/panel/sony,acx424akp.yaml     |   2 +-
 .../bindings/display/panel/xinpeng,xpp055c272.yaml |   4 +-
 .../devicetree/bindings/display/renesas,cmm.yaml   |  18 +-
 .../bindings/display/ti/ti,am65x-dss.yaml          |  19 +-
 .../bindings/display/ti/ti,j721e-dss.yaml          |  34 +-
 .../devicetree/bindings/dma/dma-common.yaml        |   3 +-
 .../devicetree/bindings/dma/ingenic,dma.yaml       |  80 +++++
 .../devicetree/bindings/dma/jz4780-dma.txt         |  64 ----
 .../devicetree/bindings/dma/mtk-uart-apdma.txt     |   3 +-
 .../bindings/dma/sifive,fu540-c000-pdma.yaml       |   2 +-
 .../devicetree/bindings/dma/ti/k3-udma.yaml        |  29 +-
 Documentation/devicetree/bindings/eeprom/at24.yaml |  13 +-
 .../devicetree/bindings/example-schema.yaml        |  17 +-
 .../devicetree/bindings/extcon/extcon-arizona.txt  |  76 -----
 .../bindings/extcon/extcon-usbc-cros-ec.yaml       |   3 +-
 .../devicetree/bindings/extcon/wlf,arizona.yaml    | 125 ++++++++
 .../bindings/gpio/brcm,xgs-iproc-gpio.yaml         |   2 +-
 .../devicetree/bindings/gpio/fsl-imx-gpio.txt      |  35 --
 .../devicetree/bindings/gpio/fsl-imx-gpio.yaml     |  68 ++++
 .../devicetree/bindings/gpio/gpio-mxs.txt          |  88 ------
 .../devicetree/bindings/gpio/gpio-mxs.yaml         | 136 ++++++++
 .../devicetree/bindings/gpio/renesas,gpio-rcar.txt |  94 ------
 .../bindings/gpio/renesas,rcar-gpio.yaml           | 144 +++++++++
 .../devicetree/bindings/gpio/sifive,gpio.yaml      |   2 +-
 .../devicetree/bindings/gpu/arm,mali-bifrost.yaml  |   6 +
 .../devicetree/bindings/gpu/arm,mali-midgard.yaml  |  20 +-
 .../devicetree/bindings/gpu/arm,mali-utgard.yaml   |   4 +
 .../devicetree/bindings/gpu/vivante,gc.yaml        |   2 +-
 .../bindings/hwmon/adi,axi-fan-control.yaml        |   3 +-
 .../devicetree/bindings/hwmon/adi,ltc2947.yaml     |  32 +-
 .../devicetree/bindings/hwmon/adt7475.yaml         |  18 +-
 .../devicetree/bindings/hwmon/cirrus,lochnagar.txt |  26 --
 .../bindings/hwmon/cirrus,lochnagar.yaml           |  35 ++
 .../devicetree/bindings/hwmon/ti,tmp513.yaml       |  21 +-
 .../devicetree/bindings/i2c/brcm,bcm2835-i2c.txt   |   2 +-
 .../devicetree/bindings/i2c/cdns,i2c-r1p10.yaml    |  58 ++++
 .../devicetree/bindings/i2c/i2c-cadence.txt        |  28 --
 .../devicetree/bindings/i2c/i2c-jz4780.txt         |  33 --
 .../devicetree/bindings/i2c/i2c-rk3x.yaml          |  10 +-
 Documentation/devicetree/bindings/i2c/i2c-xiic.txt |  25 --
 .../devicetree/bindings/i2c/ingenic,i2c.yaml       |  88 ++++++
 .../devicetree/bindings/i2c/renesas,i2c.txt        |   1 +
 .../devicetree/bindings/i2c/renesas,iic.txt        |   1 +
 .../devicetree/bindings/i2c/st,stm32-i2c.yaml      |  15 +-
 .../bindings/i2c/xlnx,xps-iic-2.00.a.yaml          |  49 +++
 .../devicetree/bindings/iio/adc/adi,ad7124.yaml    |   9 +-
 .../devicetree/bindings/iio/adc/lltc,ltc2496.yaml  |   9 +-
 .../bindings/iio/adc/microchip,mcp3911.yaml        |   7 +-
 .../devicetree/bindings/iio/adc/st,stm32-adc.yaml  |  35 +-
 .../bindings/iio/adc/st,stm32-dfsdm-adc.yaml       |  27 +-
 .../devicetree/bindings/iio/imu/bmi160.txt         |  37 ---
 .../devicetree/bindings/iio/imu/bosch,bmi160.yaml  |  75 +++++
 .../devicetree/bindings/iio/light/tsl2772.yaml     |  13 +-
 .../bindings/iio/temperature/adi,ltc2983.yaml      |  60 ++--
 Documentation/devicetree/bindings/index.rst        |  12 +
 .../input/allwinner,sun4i-a10-lradc-keys.yaml      |   9 +-
 .../devicetree/bindings/input/gpio-keys-polled.txt |  45 ---
 .../devicetree/bindings/input/gpio-keys.txt        |  58 ----
 .../devicetree/bindings/input/gpio-keys.yaml       | 149 +++++++++
 Documentation/devicetree/bindings/input/input.yaml |   9 +-
 .../devicetree/bindings/input/iqs62x-keys.yaml     |   7 +-
 .../bindings/input/touchscreen/edt-ft5x06.yaml     |  30 +-
 .../bindings/input/touchscreen/goodix.yaml         |   2 +-
 .../bindings/interconnect/qcom,msm8916.yaml        |   4 +-
 .../bindings/interconnect/qcom,msm8974.yaml        |   4 +-
 .../bindings/interconnect/qcom,qcs404.yaml         |   4 +-
 .../bindings/interconnect/qcom,sc7180.yaml         |   6 +-
 .../bindings/interconnect/qcom,sdm845.yaml         |   4 +-
 .../allwinner,sun7i-a20-sc-nmi.yaml                |  12 +-
 .../bindings/interrupt-controller/arm,gic-v3.yaml  |  39 +--
 .../bindings/interrupt-controller/arm,gic.yaml     |   9 +
 .../bindings/interrupt-controller/fsl,irqsteer.txt |  35 --
 .../interrupt-controller/fsl,irqsteer.yaml         |  89 ++++++
 .../bindings/interrupt-controller/ingenic,intc.txt |  28 --
 .../interrupt-controller/ingenic,intc.yaml         |  63 ++++
 .../intel,ixp4xx-interrupt.yaml                    |   8 +-
 .../interrupt-controller/loongson,liointc.yaml     |   8 +-
 .../interrupt-controller/renesas,intc-irqpin.txt   |  62 ----
 .../interrupt-controller/renesas,intc-irqpin.yaml  | 107 +++++++
 .../interrupt-controller/renesas,irqc.yaml         |   3 +-
 .../interrupt-controller/st,stm32-exti.yaml        |  12 +-
 .../devicetree/bindings/iommu/arm,smmu.yaml        |   3 +-
 .../bindings/iommu/renesas,ipmmu-vmsa.txt          |  73 -----
 .../bindings/iommu/renesas,ipmmu-vmsa.yaml         |  98 ++++++
 .../devicetree/bindings/iommu/samsung,sysmmu.yaml  |  10 +-
 .../devicetree/bindings/ipmi/ipmi-smic.txt         |  25 --
 .../devicetree/bindings/ipmi/ipmi-smic.yaml        |  63 ++++
 Documentation/devicetree/bindings/leds/common.yaml |  13 +-
 .../devicetree/bindings/leds/leds-gpio.yaml        |   3 +-
 .../bindings/leds/rohm,bd71828-leds.yaml           |   9 +-
 .../devicetree/bindings/mailbox/fsl,mu.txt         |  58 ----
 .../devicetree/bindings/mailbox/fsl,mu.yaml        |  91 ++++++
 .../devicetree/bindings/mailbox/st,stm32-ipcc.yaml |   7 +-
 .../bindings/media/allwinner,sun4i-a10-csi.yaml    |  28 +-
 .../devicetree/bindings/media/amlogic,gx-vdec.yaml |  20 +-
 .../bindings/media/amlogic,meson-gx-ao-cec.yaml    |   5 +-
 .../devicetree/bindings/media/i2c/imx219.yaml      |   3 +-
 .../bindings/media/marvell,mmp2-ccic.txt           |  50 ---
 .../bindings/media/marvell,mmp2-ccic.yaml          |  99 ++++++
 .../bindings/media/qcom,sc7180-venus.yaml          |   2 +-
 .../bindings/media/qcom,sdm845-venus-v2.yaml       |   2 +-
 .../bindings/media/qcom,sdm845-venus.yaml          |   2 +-
 Documentation/devicetree/bindings/media/rc.yaml    | 265 ++++++++--------
 .../devicetree/bindings/media/renesas,ceu.yaml     |  39 ++-
 .../devicetree/bindings/media/renesas,csi2.yaml    |   2 +-
 .../devicetree/bindings/media/renesas,vin.yaml     |  21 +-
 .../devicetree/bindings/media/ti,vpe.yaml          |   2 +-
 .../memory-controllers/calxeda-ddr-ctrlr.txt       |  16 -
 .../memory-controllers/calxeda-ddr-ctrlr.yaml      |  42 +++
 .../bindings/memory-controllers/exynos-srom.yaml   |  13 +-
 .../memory-controllers/fsl/imx8m-ddrc.yaml         |   6 +-
 .../memory-controllers/ingenic,jz4780-nemc.txt     |  76 -----
 .../bindings/memory-controllers/ingenic,nemc.yaml  | 126 ++++++++
 .../memory-controllers/nvidia,tegra124-emc.yaml    |  13 +-
 .../memory-controllers/nvidia,tegra124-mc.yaml     |   5 +-
 .../memory-controllers/nvidia,tegra210-emc.yaml    |  82 +++++
 .../memory-controllers/nvidia,tegra30-emc.yaml     |   9 +-
 .../memory-controllers/nvidia,tegra30-mc.yaml      |   3 +-
 .../bindings/memory-controllers/renesas,dbsc.txt   |  44 ---
 .../bindings/memory-controllers/renesas,dbsc.yaml  |  56 ++++
 .../bindings/mfd/allwinner,sun4i-a10-ts.yaml       |  20 +-
 Documentation/devicetree/bindings/mfd/arizona.txt  | 101 ------
 .../devicetree/bindings/mfd/cirrus,lochnagar.txt   |  85 -----
 .../devicetree/bindings/mfd/cirrus,lochnagar.yaml  | 352 +++++++++++++++++++++
 .../devicetree/bindings/mfd/cirrus,madera.yaml     | 299 +++++++++++++++++
 Documentation/devicetree/bindings/mfd/madera.txt   | 114 -------
 .../devicetree/bindings/mfd/st,stm32-lptimer.yaml  |   4 +-
 .../devicetree/bindings/mfd/st,stm32-timers.yaml   |  37 ++-
 .../devicetree/bindings/mfd/st,stpmic1.yaml        |   9 +-
 Documentation/devicetree/bindings/mfd/syscon.yaml  |  17 +-
 .../devicetree/bindings/mfd/wlf,arizona.yaml       | 280 ++++++++++++++++
 .../devicetree/bindings/mips/ingenic/devices.yaml  |   4 +
 .../devicetree/bindings/mmc/aspeed,sdhci.yaml      |   4 +-
 .../devicetree/bindings/mmc/cdns,sdhci.yaml        |  79 ++---
 .../devicetree/bindings/mmc/ingenic,mmc.yaml       |  79 +++++
 Documentation/devicetree/bindings/mmc/jz4740.txt   |  41 ---
 .../devicetree/bindings/mmc/mmc-controller.yaml    |  37 +--
 Documentation/devicetree/bindings/mmc/owl-mmc.yaml |   2 +-
 .../devicetree/bindings/mmc/rockchip-dw-mshc.yaml  |  24 +-
 .../bindings/mmc/socionext,uniphier-sd.yaml        |  14 +-
 .../bindings/mmc/synopsys-dw-mshc-common.yaml      |  14 +-
 .../bindings/mtd/allwinner,sun4i-a10-nand.yaml     |  13 +-
 .../devicetree/bindings/mtd/denali,nand.yaml       |   4 +-
 .../bindings/mtd/ingenic,jz4780-nand.txt           |  92 ------
 .../devicetree/bindings/mtd/ingenic,nand.yaml      | 132 ++++++++
 .../devicetree/bindings/mtd/nand-controller.yaml   |  27 +-
 .../bindings/net/allwinner,sun8i-a83t-emac.yaml    |   4 +-
 .../devicetree/bindings/net/calxeda-xgmac.txt      |  18 --
 .../devicetree/bindings/net/calxeda-xgmac.yaml     |  49 +++
 .../devicetree/bindings/net/can/bosch,m_can.yaml   | 111 ++++---
 .../bindings/net/ethernet-controller.yaml          |  34 +-
 .../devicetree/bindings/net/qca,ar803x.yaml        |  17 +-
 .../devicetree/bindings/net/qcom,ipa.yaml          |  12 +-
 .../devicetree/bindings/net/renesas,ether.yaml     |   9 +-
 .../devicetree/bindings/net/renesas,ravb.txt       |   1 +
 .../devicetree/bindings/net/snps,dwmac.yaml        |  30 +-
 .../devicetree/bindings/net/stm32-dwmac.txt        |  44 ---
 .../devicetree/bindings/net/stm32-dwmac.yaml       | 148 +++++++++
 .../devicetree/bindings/net/ti,cpsw-switch.yaml    |  18 +-
 .../devicetree/bindings/net/ti,davinci-mdio.yaml   |  34 +-
 .../bindings/net/ti,k3-am654-cpsw-nuss.yaml        |  98 +++---
 .../devicetree/bindings/nvmem/imx-iim.txt          |  22 --
 .../devicetree/bindings/nvmem/imx-iim.yaml         |  57 ++++
 .../devicetree/bindings/nvmem/imx-ocotp.txt        |  50 ---
 .../devicetree/bindings/nvmem/imx-ocotp.yaml       |  95 ++++++
 .../devicetree/bindings/nvmem/mxs-ocotp.txt        |  24 --
 .../devicetree/bindings/nvmem/mxs-ocotp.yaml       |  50 +++
 Documentation/devicetree/bindings/nvmem/nvmem.yaml |   2 -
 .../devicetree/bindings/nvmem/rockchip-efuse.txt   |  54 ----
 .../devicetree/bindings/nvmem/rockchip-efuse.yaml  |  70 ++++
 .../devicetree/bindings/nvmem/st,stm32-romem.yaml  |  17 +
 .../devicetree/bindings/pci/cdns-pcie-host.yaml    |   3 +-
 .../devicetree/bindings/pci/cdns-pcie.yaml         |   3 +-
 .../devicetree/bindings/pci/intel-gw-pcie.yaml     |   7 +-
 Documentation/devicetree/bindings/pci/pci-ep.yaml  |   9 +-
 .../devicetree/bindings/pci/pci-rcar-gen2.txt      |   3 +-
 .../phy/amlogic,meson-axg-mipi-pcie-analog.yaml    |   2 +-
 .../bindings/phy/amlogic,meson-axg-pcie.yaml       |   2 +-
 .../devicetree/bindings/phy/calxeda-combophy.txt   |  17 -
 .../devicetree/bindings/phy/calxeda-combophy.yaml  |  51 +++
 .../bindings/phy/intel,lgm-emmc-phy.yaml           |   2 +-
 .../bindings/phy/phy-cadence-torrent.yaml          |  59 ++--
 .../devicetree/bindings/phy/qcom,qusb2-phy.yaml    |  65 ++--
 .../devicetree/bindings/phy/rcar-gen2-phy.txt      |   3 +-
 .../bindings/phy/rockchip,px30-dsi-dphy.yaml       |   2 +-
 .../bindings/phy/socionext,uniphier-pcie-phy.yaml  |  77 +++++
 .../bindings/phy/socionext,uniphier-usb2-phy.yaml  |  85 +++++
 .../phy/socionext,uniphier-usb3hs-phy.yaml         | 103 ++++++
 .../phy/socionext,uniphier-usb3ss-phy.yaml         |  96 ++++++
 .../devicetree/bindings/phy/uniphier-pcie-phy.txt  |  36 ---
 .../devicetree/bindings/phy/uniphier-usb2-phy.txt  |  45 ---
 .../bindings/phy/uniphier-usb3-hsphy.txt           |  69 ----
 .../bindings/phy/uniphier-usb3-ssphy.txt           |  58 ----
 .../pinctrl/allwinner,sun4i-a10-pinctrl.yaml       |  12 +-
 .../bindings/pinctrl/aspeed,ast2400-pinctrl.yaml   |  37 +--
 .../bindings/pinctrl/aspeed,ast2500-pinctrl.yaml   |  46 ++-
 .../bindings/pinctrl/aspeed,ast2600-pinctrl.yaml   | 108 +++----
 .../bindings/pinctrl/cirrus,lochnagar.txt          | 141 ---------
 .../bindings/pinctrl/cirrus,lochnagar.yaml         | 190 +++++++++++
 .../bindings/pinctrl/cirrus,madera-pinctrl.txt     |  99 ------
 .../devicetree/bindings/pinctrl/cirrus,madera.yaml | 122 +++++++
 .../bindings/pinctrl/fsl,imx8mm-pinctrl.yaml       |  31 +-
 .../bindings/pinctrl/fsl,imx8mn-pinctrl.yaml       |  31 +-
 .../bindings/pinctrl/fsl,imx8mp-pinctrl.yaml       |  31 +-
 .../bindings/pinctrl/fsl,imx8mq-pinctrl.yaml       |  31 +-
 .../devicetree/bindings/pinctrl/intel,lgm-io.yaml  |   4 +-
 .../devicetree/bindings/pinctrl/pinmux-node.yaml   |   3 +-
 .../bindings/pinctrl/qcom,ipq6018-pinctrl.yaml     |   3 +-
 .../bindings/pinctrl/st,stm32-pinctrl.yaml         |  54 ++--
 .../bindings/power/amlogic,meson-ee-pwrc.yaml      |   3 +-
 .../devicetree/bindings/power/fsl,imx-gpc.txt      |  91 ------
 .../devicetree/bindings/power/fsl,imx-gpc.yaml     | 124 ++++++++
 .../devicetree/bindings/power/fsl,imx-gpcv2.txt    |  77 -----
 .../devicetree/bindings/power/fsl,imx-gpcv2.yaml   | 108 +++++++
 .../devicetree/bindings/power/renesas,apmu.yaml    |   1 +
 Documentation/devicetree/bindings/pwm/imx-pwm.txt  |  27 --
 Documentation/devicetree/bindings/pwm/imx-pwm.yaml |  66 ++++
 .../devicetree/bindings/pwm/imx-tpm-pwm.txt        |  22 --
 .../devicetree/bindings/pwm/imx-tpm-pwm.yaml       |  55 ++++
 Documentation/devicetree/bindings/pwm/mxs-pwm.txt  |  17 -
 Documentation/devicetree/bindings/pwm/mxs-pwm.yaml |  43 +++
 .../devicetree/bindings/pwm/pwm-samsung.yaml       |  27 +-
 .../devicetree/bindings/pwm/renesas,pwm-rcar.yaml  |   2 +-
 .../bindings/regulator/arizona-regulator.txt       |  18 --
 .../bindings/regulator/cirrus,lochnagar.txt        |  82 -----
 .../bindings/regulator/gpio-regulator.yaml         |  35 +-
 .../devicetree/bindings/regulator/mps,mp5416.yaml  |   6 +-
 .../devicetree/bindings/regulator/mps,mpq7920.yaml |  28 +-
 .../devicetree/bindings/regulator/regulator.yaml   |   5 +-
 .../bindings/regulator/rohm,bd71828-regulator.yaml |  34 +-
 .../bindings/regulator/rohm,bd71837-regulator.yaml |  27 +-
 .../bindings/regulator/st,stm32-booster.yaml       |   3 +-
 .../bindings/regulator/st,stm32mp1-pwr-reg.yaml    |   3 +-
 .../devicetree/bindings/regulator/wlf,arizona.yaml |  37 +++
 .../bindings/remoteproc/st,stm32-rproc.yaml        |  11 +-
 .../bindings/reserved-memory/reserved-memory.txt   |   2 +
 .../reset/brcm,bcm7216-pcie-sata-rescal.yaml       |   4 +-
 .../devicetree/bindings/reset/intel,rcu-gw.yaml    |   3 +-
 Documentation/devicetree/bindings/riscv/cpus.yaml  |  20 +-
 .../devicetree/bindings/rtc/renesas,sh-rtc.yaml    |   5 +
 Documentation/devicetree/bindings/rtc/rtc-mxc.txt  |  26 --
 Documentation/devicetree/bindings/rtc/rtc-mxc.yaml |  57 ++++
 .../devicetree/bindings/rtc/rtc-mxc_v2.txt         |  17 -
 .../devicetree/bindings/rtc/rtc-mxc_v2.yaml        |  46 +++
 .../devicetree/bindings/rtc/st,stm32-rtc.yaml      |  47 ++-
 Documentation/devicetree/bindings/serial/8250.txt  | 100 ------
 Documentation/devicetree/bindings/serial/8250.yaml | 233 ++++++++++++++
 .../bindings/serial/amlogic,meson-uart.yaml        |  16 +-
 .../devicetree/bindings/serial/ingenic,uart.txt    |  28 --
 .../devicetree/bindings/serial/ingenic,uart.yaml   |  94 ++++++
 .../devicetree/bindings/serial/mrvl-serial.txt     |   4 -
 .../devicetree/bindings/serial/pl011.yaml          |  10 +-
 .../devicetree/bindings/serial/qca,ar9330-uart.txt |  31 --
 .../bindings/serial/qca,ar9330-uart.yaml           |  50 +++
 .../bindings/serial/renesas,em-uart.yaml           |  49 +++
 .../devicetree/bindings/serial/renesas,hscif.yaml  |   1 +
 .../devicetree/bindings/serial/renesas,scif.yaml   |   1 +
 .../devicetree/bindings/serial/renesas,scifa.yaml  |  15 +-
 .../devicetree/bindings/serial/renesas,scifb.yaml  |   1 +
 .../devicetree/bindings/serial/rs485.yaml          |  43 ++-
 .../devicetree/bindings/serial/samsung_uart.yaml   |   5 +-
 .../devicetree/bindings/serial/serial.yaml         |   8 +
 .../devicetree/bindings/serial/sifive-serial.yaml  |   2 +-
 .../bindings/soc/amlogic/amlogic,canvas.yaml       |  10 +-
 .../devicetree/bindings/soc/qcom/qcom,geni-se.txt  |  94 ------
 .../devicetree/bindings/soc/qcom/qcom,geni-se.yaml | 225 +++++++++++++
 .../devicetree/bindings/sound/adi,adau7118.yaml    |  20 +-
 .../bindings/sound/allwinner,sun4i-a10-codec.yaml  |  51 ++-
 .../devicetree/bindings/sound/amlogic,aiu.yaml     |   3 +-
 .../bindings/sound/amlogic,g12a-toacodec.yaml      |   2 +-
 .../devicetree/bindings/sound/amlogic,t9015.yaml   |   3 +-
 .../devicetree/bindings/sound/cirrus,lochnagar.txt |  39 ---
 .../bindings/sound/cirrus,lochnagar.yaml           |  52 +++
 .../devicetree/bindings/sound/cirrus,madera.yaml   | 113 +++++++
 Documentation/devicetree/bindings/sound/madera.txt |  67 ----
 .../devicetree/bindings/sound/qcom,wcd934x.yaml    |   3 +-
 .../devicetree/bindings/sound/renesas,fsi.yaml     |  41 ++-
 .../devicetree/bindings/sound/rockchip-i2s.yaml    |   6 +-
 .../devicetree/bindings/sound/tlv320adcx140.yaml   |  10 +-
 .../devicetree/bindings/sound/wlf,arizona.txt      |  53 ----
 .../devicetree/bindings/sound/wlf,arizona.yaml     | 114 +++++++
 .../devicetree/bindings/spi/marvell,mmp2-ssp.yaml  |  58 ++++
 .../bindings/spi/qcom,spi-qcom-qspi.yaml           |  10 +-
 .../devicetree/bindings/spi/renesas,hspi.yaml      |   4 +-
 .../devicetree/bindings/spi/renesas,sh-msiof.yaml  |  44 ++-
 .../devicetree/bindings/spi/spi-controller.yaml    |  14 +-
 .../devicetree/bindings/spi/spi-pl022.yaml         |  57 ++--
 .../devicetree/bindings/spi/spi-pxa2xx.txt         |  27 --
 .../devicetree/bindings/spi/spi-sifive.yaml        |  25 +-
 .../devicetree/bindings/spi/st,stm32-qspi.yaml     |   4 +-
 .../sram/allwinner,sun4i-a10-system-control.yaml   |  64 ++--
 .../devicetree/bindings/sram/rockchip-pmu-sram.txt |  16 -
 Documentation/devicetree/bindings/sram/sram.yaml   |  28 +-
 ...bmitting-patches.txt => submitting-patches.rst} |  12 +-
 .../bindings/thermal/amlogic,thermal.yaml          |  10 +-
 .../devicetree/bindings/thermal/imx-thermal.txt    |  61 ----
 .../devicetree/bindings/thermal/imx-thermal.yaml   | 102 ++++++
 .../devicetree/bindings/thermal/imx8mm-thermal.txt |  15 -
 .../bindings/thermal/imx8mm-thermal.yaml           |  58 ++++
 .../devicetree/bindings/thermal/qcom-tsens.yaml    |   7 +-
 .../bindings/thermal/rcar-gen3-thermal.txt         |  60 ----
 .../bindings/thermal/rcar-gen3-thermal.yaml        |  99 ++++++
 .../devicetree/bindings/thermal/rcar-thermal.yaml  |   7 +-
 .../thermal/socionext,uniphier-thermal.yaml        |  59 ++++
 .../devicetree/bindings/thermal/sprd-thermal.yaml  |   2 +-
 .../bindings/thermal/uniphier-thermal.txt          |  65 ----
 .../devicetree/bindings/timer/arm,arch_timer.yaml  |  10 +-
 .../bindings/timer/arm,arch_timer_mmio.yaml        |  11 +-
 .../bindings/timer/cadence,ttc-timer.txt           |  21 --
 .../devicetree/bindings/timer/cdns,ttc.yaml        |  48 +++
 .../devicetree/bindings/timer/fsl,imxgpt.txt       |  45 ---
 .../devicetree/bindings/timer/fsl,imxgpt.yaml      |  72 +++++
 .../devicetree/bindings/timer/ingenic,tcu.txt      | 138 --------
 .../devicetree/bindings/timer/ingenic,tcu.yaml     | 280 ++++++++++++++++
 .../devicetree/bindings/timer/nxp,sysctr-timer.txt |  25 --
 .../bindings/timer/nxp,sysctr-timer.yaml           |  54 ++++
 .../devicetree/bindings/timer/nxp,tpm-timer.txt    |  28 --
 .../devicetree/bindings/timer/nxp,tpm-timer.yaml   |  61 ++++
 .../devicetree/bindings/timer/renesas,cmt.txt      | 110 -------
 .../devicetree/bindings/timer/renesas,cmt.yaml     | 182 +++++++++++
 .../devicetree/bindings/timer/renesas,mtu2.txt     |  42 ---
 .../devicetree/bindings/timer/renesas,mtu2.yaml    |  76 +++++
 .../devicetree/bindings/timer/renesas,ostm.txt     |  31 --
 .../devicetree/bindings/timer/renesas,ostm.yaml    |  59 ++++
 .../devicetree/bindings/ufs/ti,j721e-ufs.yaml      |  65 ++--
 .../bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml  |   3 +-
 .../devicetree/bindings/usb/aspeed,usb-vhub.yaml   |  18 +-
 Documentation/devicetree/bindings/usb/dwc2.yaml    |  11 +-
 Documentation/devicetree/bindings/usb/ehci-mv.txt  |  23 --
 .../devicetree/bindings/usb/generic-ehci.yaml      |  27 +-
 .../devicetree/bindings/usb/generic-ohci.yaml      |   6 +
 .../devicetree/bindings/usb/ingenic,musb.yaml      |   3 +
 .../bindings/usb/marvell,pxau2o-ehci.yaml          |  62 ++++
 .../devicetree/bindings/usb/nvidia,tegra-xudc.yaml |   6 +-
 .../devicetree/bindings/usb/qcom,dwc3.txt          | 104 ------
 .../devicetree/bindings/usb/qcom,dwc3.yaml         | 174 ++++++++++
 .../devicetree/bindings/usb/renesas,usb3-peri.yaml |   2 +-
 .../devicetree/bindings/usb/renesas,usbhs.yaml     |   3 +-
 .../devicetree/bindings/usb/ti,j721e-usb.yaml      |  54 ++--
 .../devicetree/bindings/usb/usb-conn-gpio.txt      |  30 --
 Documentation/devicetree/bindings/usb/usb-xhci.txt |   1 +
 .../devicetree/bindings/vendor-prefixes.yaml       |  22 ++
 .../devicetree/bindings/watchdog/fsl-imx-wdt.txt   |  24 --
 .../devicetree/bindings/watchdog/fsl-imx-wdt.yaml  |  54 ++++
 .../bindings/watchdog/fsl-imx7ulp-wdt.txt          |  22 --
 .../bindings/watchdog/fsl-imx7ulp-wdt.yaml         |  60 ++++
 .../devicetree/bindings/watchdog/renesas,wdt.txt   |  50 ---
 .../devicetree/bindings/watchdog/renesas,wdt.yaml  | 101 ++++++
 .../bindings/watchdog/socionext,uniphier-wdt.yaml  |  36 +++
 .../devicetree/bindings/watchdog/ti,rti-wdt.yaml   |   2 +-
 .../devicetree/bindings/watchdog/uniphier-wdt.txt  |  20 --
 .../{writing-bindings.txt => writing-bindings.rst} |   9 +-
 .../devicetree/{changesets.txt => changesets.rst}  |  24 +-
 ...tion-notes.txt => dynamic-resolution-notes.rst} |   5 +-
 Documentation/devicetree/index.rst                 |  17 +
 .../{of_unittest.txt => of_unittest.rst}           | 192 +++++------
 .../{overlay-notes.txt => overlay-notes.rst}       | 119 ++++---
 .../{usage-model.txt => usage-model.rst}           |  35 +-
 Documentation/index.rst                            |   3 +
 Documentation/process/submitting-patches.rst       |   2 +-
 .../it_IT/process/submitting-patches.rst           |   2 +-
 MAINTAINERS                                        |  33 +-
 drivers/of/dynamic.c                               |   3 +-
 drivers/of/fdt.c                                   |   8 +-
 drivers/of/kobj.c                                  |   3 +-
 drivers/of/of_reserved_mem.c                       |  10 +-
 drivers/of/platform.c                              |   2 +-
 drivers/of/property.c                              |  20 +-
 include/linux/mfd/core.h                           |   2 +-
 scripts/checkpatch.pl                              |   2 +-
 470 files changed, 11822 insertions(+), 7433 deletions(-)
 rename Documentation/devicetree/bindings/{ABI.txt => ABI.rst} (94%)
 create mode 100644 Documentation/devicetree/bindings/arm/calxeda/hb-sregs.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/calxeda/l2ecc.txt
 create mode 100644 Documentation/devicetree/bindings/arm/calxeda/l2ecc.yaml
 delete mode 100644 Documentation/devicetree/bindings/ata/sata_highbank.txt
 create mode 100644 Documentation/devicetree/bindings/ata/sata_highbank.yaml
 delete mode 100644 Documentation/devicetree/bindings/auxdisplay/hit,hd44780.txt
 create mode 100644 Documentation/devicetree/bindings/auxdisplay/hit,hd44780.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/calxeda.txt
 create mode 100644 Documentation/devicetree/bindings/clock/calxeda.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/cirrus,lochnagar.txt
 create mode 100644 Documentation/devicetree/bindings/clock/cirrus,lochnagar.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/imx1-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/imx1-clock.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/imx21-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/imx21-clock.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/imx23-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/imx23-clock.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/imx25-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/imx25-clock.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/imx27-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/imx27-clock.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/imx28-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/imx28-clock.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/imx31-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/imx31-clock.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/imx35-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/imx35-clock.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/imx5-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/imx5-clock.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/imx6q-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/imx6q-clock.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/imx6sl-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/imx6sl-clock.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/imx6sll-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/imx6sll-clock.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/imx6sx-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/imx6sx-clock.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/imx6ul-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/imx6ul-clock.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/imx7d-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/imx7d-clock.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/imx8qxp-lpcg.txt
 create mode 100644 Documentation/devicetree/bindings/clock/imx8qxp-lpcg.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/ingenic,cgu.txt
 create mode 100644 Documentation/devicetree/bindings/clock/ingenic,cgu.yaml
 create mode 100644 Documentation/devicetree/bindings/display/bridge/analogix,anx7814.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/bridge/anx7814.txt
 create mode 100644 Documentation/devicetree/bindings/dma/ingenic,dma.yaml
 delete mode 100644 Documentation/devicetree/bindings/dma/jz4780-dma.txt
 delete mode 100644 Documentation/devicetree/bindings/extcon/extcon-arizona.txt
 create mode 100644 Documentation/devicetree/bindings/extcon/wlf,arizona.yaml
 delete mode 100644 Documentation/devicetree/bindings/gpio/fsl-imx-gpio.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml
 delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-mxs.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-mxs.yaml
 delete mode 100644 Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/renesas,rcar-gpio.yaml
 delete mode 100644 Documentation/devicetree/bindings/hwmon/cirrus,lochnagar.txt
 create mode 100644 Documentation/devicetree/bindings/hwmon/cirrus,lochnagar.yaml
 create mode 100644 Documentation/devicetree/bindings/i2c/cdns,i2c-r1p10.yaml
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-cadence.txt
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-jz4780.txt
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-xiic.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/ingenic,i2c.yaml
 create mode 100644 Documentation/devicetree/bindings/i2c/xlnx,xps-iic-2.00.a.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/imu/bmi160.txt
 create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,bmi160.yaml
 create mode 100644 Documentation/devicetree/bindings/index.rst
 delete mode 100644 Documentation/devicetree/bindings/input/gpio-keys-polled.txt
 delete mode 100644 Documentation/devicetree/bindings/input/gpio-keys.txt
 create mode 100644 Documentation/devicetree/bindings/input/gpio-keys.yaml
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.yaml
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/ingenic,intc.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/ingenic,intc.yaml
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,intc-irqpin.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,intc-irqpin.yaml
 delete mode 100644 Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt
 create mode 100644 Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml
 delete mode 100644 Documentation/devicetree/bindings/ipmi/ipmi-smic.txt
 create mode 100644 Documentation/devicetree/bindings/ipmi/ipmi-smic.yaml
 delete mode 100644 Documentation/devicetree/bindings/mailbox/fsl,mu.txt
 create mode 100644 Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
 delete mode 100644 Documentation/devicetree/bindings/media/marvell,mmp2-ccic.txt
 create mode 100644 Documentation/devicetree/bindings/media/marvell,mmp2-ccic.yaml
 delete mode 100644 Documentation/devicetree/bindings/memory-controllers/calxeda-ddr-ctrlr.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/calxeda-ddr-ctrlr.yaml
 delete mode 100644 Documentation/devicetree/bindings/memory-controllers/ingenic,jz4780-nemc.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/ingenic,nemc.yaml
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra210-emc.yaml
 delete mode 100644 Documentation/devicetree/bindings/memory-controllers/renesas,dbsc.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/renesas,dbsc.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/arizona.txt
 delete mode 100644 Documentation/devicetree/bindings/mfd/cirrus,lochnagar.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/cirrus,lochnagar.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/cirrus,madera.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/madera.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/wlf,arizona.yaml
 create mode 100644 Documentation/devicetree/bindings/mmc/ingenic,mmc.yaml
 delete mode 100644 Documentation/devicetree/bindings/mmc/jz4740.txt
 delete mode 100644 Documentation/devicetree/bindings/mtd/ingenic,jz4780-nand.txt
 create mode 100644 Documentation/devicetree/bindings/mtd/ingenic,nand.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/calxeda-xgmac.txt
 create mode 100644 Documentation/devicetree/bindings/net/calxeda-xgmac.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/stm32-dwmac.txt
 create mode 100644 Documentation/devicetree/bindings/net/stm32-dwmac.yaml
 delete mode 100644 Documentation/devicetree/bindings/nvmem/imx-iim.txt
 create mode 100644 Documentation/devicetree/bindings/nvmem/imx-iim.yaml
 delete mode 100644 Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
 create mode 100644 Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
 delete mode 100644 Documentation/devicetree/bindings/nvmem/mxs-ocotp.txt
 create mode 100644 Documentation/devicetree/bindings/nvmem/mxs-ocotp.yaml
 delete mode 100644 Documentation/devicetree/bindings/nvmem/rockchip-efuse.txt
 create mode 100644 Documentation/devicetree/bindings/nvmem/rockchip-efuse.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/calxeda-combophy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/calxeda-combophy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/socionext,uniphier-pcie-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/socionext,uniphier-usb2-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/socionext,uniphier-usb3hs-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/socionext,uniphier-usb3ss-phy.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/uniphier-pcie-phy.txt
 delete mode 100644 Documentation/devicetree/bindings/phy/uniphier-usb2-phy.txt
 delete mode 100644 Documentation/devicetree/bindings/phy/uniphier-usb3-hsphy.txt
 delete mode 100644 Documentation/devicetree/bindings/phy/uniphier-usb3-ssphy.txt
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/cirrus,lochnagar.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/cirrus,lochnagar.yaml
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/cirrus,madera-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/cirrus,madera.yaml
 delete mode 100644 Documentation/devicetree/bindings/power/fsl,imx-gpc.txt
 create mode 100644 Documentation/devicetree/bindings/power/fsl,imx-gpc.yaml
 delete mode 100644 Documentation/devicetree/bindings/power/fsl,imx-gpcv2.txt
 create mode 100644 Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml
 delete mode 100644 Documentation/devicetree/bindings/pwm/imx-pwm.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/imx-pwm.yaml
 delete mode 100644 Documentation/devicetree/bindings/pwm/imx-tpm-pwm.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/imx-tpm-pwm.yaml
 delete mode 100644 Documentation/devicetree/bindings/pwm/mxs-pwm.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/mxs-pwm.yaml
 delete mode 100644 Documentation/devicetree/bindings/regulator/arizona-regulator.txt
 delete mode 100644 Documentation/devicetree/bindings/regulator/cirrus,lochnagar.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/wlf,arizona.yaml
 delete mode 100644 Documentation/devicetree/bindings/rtc/rtc-mxc.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-mxc.yaml
 delete mode 100644 Documentation/devicetree/bindings/rtc/rtc-mxc_v2.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-mxc_v2.yaml
 delete mode 100644 Documentation/devicetree/bindings/serial/8250.txt
 create mode 100644 Documentation/devicetree/bindings/serial/8250.yaml
 delete mode 100644 Documentation/devicetree/bindings/serial/ingenic,uart.txt
 create mode 100644 Documentation/devicetree/bindings/serial/ingenic,uart.yaml
 delete mode 100644 Documentation/devicetree/bindings/serial/mrvl-serial.txt
 delete mode 100644 Documentation/devicetree/bindings/serial/qca,ar9330-uart.txt
 create mode 100644 Documentation/devicetree/bindings/serial/qca,ar9330-uart.yaml
 create mode 100644 Documentation/devicetree/bindings/serial/renesas,em-uart.yaml
 delete mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/cirrus,lochnagar.txt
 create mode 100644 Documentation/devicetree/bindings/sound/cirrus,lochnagar.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/cirrus,madera.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/madera.txt
 delete mode 100644 Documentation/devicetree/bindings/sound/wlf,arizona.txt
 create mode 100644 Documentation/devicetree/bindings/sound/wlf,arizona.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/marvell,mmp2-ssp.yaml
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-pxa2xx.txt
 delete mode 100644 Documentation/devicetree/bindings/sram/rockchip-pmu-sram.txt
 rename Documentation/devicetree/bindings/{submitting-patches.txt => submitting-patches.rst} (92%)
 delete mode 100644 Documentation/devicetree/bindings/thermal/imx-thermal.txt
 create mode 100644 Documentation/devicetree/bindings/thermal/imx-thermal.yaml
 delete mode 100644 Documentation/devicetree/bindings/thermal/imx8mm-thermal.txt
 create mode 100644 Documentation/devicetree/bindings/thermal/imx8mm-thermal.yaml
 delete mode 100644 Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.txt
 create mode 100644 Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml
 create mode 100644 Documentation/devicetree/bindings/thermal/socionext,uniphier-thermal.yaml
 delete mode 100644 Documentation/devicetree/bindings/thermal/uniphier-thermal.txt
 delete mode 100644 Documentation/devicetree/bindings/timer/cadence,ttc-timer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/cdns,ttc.yaml
 delete mode 100644 Documentation/devicetree/bindings/timer/fsl,imxgpt.txt
 create mode 100644 Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
 delete mode 100644 Documentation/devicetree/bindings/timer/ingenic,tcu.txt
 create mode 100644 Documentation/devicetree/bindings/timer/ingenic,tcu.yaml
 delete mode 100644 Documentation/devicetree/bindings/timer/nxp,sysctr-timer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/nxp,sysctr-timer.yaml
 delete mode 100644 Documentation/devicetree/bindings/timer/nxp,tpm-timer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/nxp,tpm-timer.yaml
 delete mode 100644 Documentation/devicetree/bindings/timer/renesas,cmt.txt
 create mode 100644 Documentation/devicetree/bindings/timer/renesas,cmt.yaml
 delete mode 100644 Documentation/devicetree/bindings/timer/renesas,mtu2.txt
 create mode 100644 Documentation/devicetree/bindings/timer/renesas,mtu2.yaml
 delete mode 100644 Documentation/devicetree/bindings/timer/renesas,ostm.txt
 create mode 100644 Documentation/devicetree/bindings/timer/renesas,ostm.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/ehci-mv.txt
 create mode 100644 Documentation/devicetree/bindings/usb/marvell,pxau2o-ehci.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/qcom,dwc3.txt
 create mode 100644 Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/usb-conn-gpio.txt
 delete mode 100644 Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.yaml
 delete mode 100644 Documentation/devicetree/bindings/watchdog/fsl-imx7ulp-wdt.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/fsl-imx7ulp-wdt.yaml
 delete mode 100644 Documentation/devicetree/bindings/watchdog/renesas,wdt.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
 create mode 100644 Documentation/devicetree/bindings/watchdog/socionext,uniphier-wdt.yaml
 delete mode 100644 Documentation/devicetree/bindings/watchdog/uniphier-wdt.txt
 rename Documentation/devicetree/bindings/{writing-bindings.txt => writing-bindings.rst} (89%)
 rename Documentation/devicetree/{changesets.txt => changesets.rst} (59%)
 rename Documentation/devicetree/{dynamic-resolution-notes.txt => dynamic-resolution-notes.rst} (90%)
 create mode 100644 Documentation/devicetree/index.rst
 rename Documentation/devicetree/{of_unittest.txt => of_unittest.rst} (54%)
 rename Documentation/devicetree/{overlay-notes.txt => overlay-notes.rst} (50%)
 rename Documentation/devicetree/{usage-model.txt => usage-model.rst} (97%)
