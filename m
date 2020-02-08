Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FEAC35254
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 21:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80D4D22522
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 21:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="gYGTa2wG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbgBHVZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 16:25:48 -0500
Received: from mail-pl1-f170.google.com ([209.85.214.170]:38305 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbgBHVZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 16:25:46 -0500
Received: by mail-pl1-f170.google.com with SMTP id t6so1204802plj.5
        for <linux-kernel@vger.kernel.org>; Sat, 08 Feb 2020 13:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sEITlmDy/4o6tZMR8LiO0qzavZn1UzRoMJqCSc87iLQ=;
        b=gYGTa2wG5r3J2q8Vf3AqLwHqy+Q+bXFXTjd5xfF74dC2t1ersFOCNFFrJ89K6NVLAh
         WaJEP17OH3EO0cTIYgEkd849JT6fX2rqI1EP+zfYr5xm2gvMmJ6GQj+z//TKP4Nhoiy3
         G6kFhIcTYT6jaN/Q48i4sOt48trfF4lT0zQuQDjv0BK1Qs+XRAXJTw4fNHA5IseEzoxn
         j2jyVUB/mmvIb8GXDjqE0ZcKviZ7rnh66+F5YNFZbQyRn6izug/kKXQaxj1TSM9dSecv
         98JJkBJZvUwETG/8+7smuTcvwjZMm9ilCisIqP4I0vI+S+2M26d6mDSvQTfJTXiTIQk3
         v7Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sEITlmDy/4o6tZMR8LiO0qzavZn1UzRoMJqCSc87iLQ=;
        b=kUrqp6l9mPEiVHSnMZGk/AnmAl8LHv7RrDE30OayUVF5RBp43KPp6c1TNitMcGRBmc
         9CTfb7BPFtsYzuufrMWRt4AQX/fUm/5Aqz9PiTjDyWVrM1E5J93iIbFCb1pFWYV6u8JL
         CYfsJDxdQ19bL1w1vIdI6eolp3yM8TMhDgt5Be3G7LeCZOLP9ZRDSQv76UHRhQXo5B1x
         9NYeeeMOACqsuqcS7mD+Wmh+htNtxxu1ikkkxy6cWdzP3tAlZx9Evp9wJ5N69qcnMQBj
         ArpyFHwisNrC6COy9aSoKKJJcprraCINnBtSqgCTRYoyy0/RSgt62XH514SAaXhg0i02
         vnRw==
X-Gm-Message-State: APjAAAXK8DgDBee6BM8NUsfFfmOsMCWavfPf2qNW38nLRJqgYG9qZBCH
        BRM3r50CAj2Q/QHmhrw5nTI1tIqmKmoEVA==
X-Google-Smtp-Source: APXvYqwoxJgseXQOYJTXCGxQslEdfUlD9mclhWf7SFpXeBwUGEc31s4Itupqx/T5E8P77e3rwS3wuA==
X-Received: by 2002:a17:902:a701:: with SMTP id w1mr5149375plq.165.1581197142812;
        Sat, 08 Feb 2020 13:25:42 -0800 (PST)
Received: from localhost.localdomain (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id a21sm7126831pgd.12.2020.02.08.13.25.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Feb 2020 13:25:41 -0800 (PST)
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        arm@kernel.org, soc@kernel.org, Olof Johansson <olof@lixom.net>
Subject: [GIT PULL 2/5 v2] ARM: Device-tree updates
Date:   Sat,  8 Feb 2020 13:25:30 -0800
Message-Id: <20200208212533.30744-3-olof@lixom.net>
X-Mailer: git-send-email 2.22.GIT
In-Reply-To: <20200208212533.30744-1-olof@lixom.net>
References: <20200208112018.29819-1-olof@lixom.net>
 <20200208212533.30744-1-olof@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New SoCs:

- Atmel/Microchip SAM9X60 (ARM926 SoC)

- OMAP 37xx gets split into AM3703/AM3715/DM3725, who are all variants
of it with different GPU/media IP configurations.

- ST stm32mp15 SoCs (1-2 Cortex-A7, CAN, GPU depending on SKU)

- ST Ericsson ab8505 (variant of ab8500) and db8520 (variant of db8500)

- Unisoc SC9863A SoC (8x Cortex-A55 mobile chipset w/ GPU, modem)

- Qualcomm SC7180 (8-core 64bit SoC, unnamed CPU class)

New boards:

- Allwinner
+ Emlid Neutis SoM (H3 variant)
+ Libre Computer ALL-H3-IT
+ PineH64 Model B

- Amlogic
+ Libretech Amlogic GX PC (s905d and s912-based variants)

- Atmel/Microchip:
+ Kizboxmini, sam9x60 EK, sama5d27 Wireless SOM (wlsom1)

- Marvell:
+ Armada 385-based SolidRun Clearfog GTR

- NXP:
+ Gateworks GW59xx boards based on i.MX6/6Q/6QDL
+ Tolino Shine 3 eBook reader (i.MX6sl)
+ Embedded Artists COM (i.MX7ULP)
+ SolidRun CLearfog CX/ITX and HoneyComb (LX2160A-based systems)
+ Google Coral Edge TPU (i.MX8MQ)

- Rockchip
+ Radxa Dalang Carrier (supports rk3288 and rk3399 SOMs)
+ Radxa Rock Pi N10 (RK3399Pro-based)
+ VMARC RK3399Pro SOM

- ST
+ Reference boards for stm32mp15

- ST Ericsson
+ Samsung Galaxy S III mini (GT-I8190)
+ HREF520 reference board for DB8520

- TI OMAP
+ Gen1 Amazon Echo (OMAP3630-based)

- Qualcomm
+ Inforce 6640 Single Board Computer (msm8996-based)
+ SC7180 IDP (SC7180-based)

----------------------------------------------------------------

The following changes since commit 60fe30d21d469a37ce79bba477c7d49bc93b93f9:

  Merge tag 'armsoc-soc' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-dt

for you to fetch changes up to d030a0dd01306d45569c6a4449dee603f994744a:

  Merge tag 'ti-k3-soc-for-v5.6-part2' of git://git.kernel.org/pub/scm/linux/kernel/git/kristo/linux into arm/dt

----------------------------------------------------------------

Abhishek Pandit-Subedi (1):
      ARM: dts: rockchip: Add brcm bluetooth for rk3288-veyron

Adam Ford (2):
      ARM: dts: imx6q-logicpd: Enable ili2117a Touchscreen
      arm64: dts: imx8mm: Add Crypto CAAM support

Alexandre Belloni (3):
      ARM: dts: at91: nattis 2: remove unnecessary include
      ARM: dts: at91: sama5d3: fix maximum peripheral clock rates
      ARM: dts: at91: sama5d3: define clock rate range for tcb1

Alexandre Torgue (6):
      ARM: dts: stm32: Adapt stm32mp157 pinctrl to manage STM32MP15xx SOCs family
      ARM: dts: stm32: Update stm32mp157 pinctrl files
      ARM: dts: stm32: Introduce new STM32MP15 SOCs: STM32MP151 and STM32MP153
      ARM: dts: stm32: Manage security diversity for STM32M15x SOCs
      ARM: dts: stm32: Adapt STM32MP157 DK boards to stm32 DT diversity
      ARM: dts: stm32: Adapt STM32MP157C ED1 board to STM32 DT diversity

Amelie Delaunay (5):
      ARM: dts: stm32: enable USBPHYC on stm32mp15 DKx boards
      ARM: dts: stm32: enable USB Host (USBH) EHCI controller on stm32mp15 DKx
      ARM: dts: stm32: enable USB OTG HS on stm32mp15 DKx boards
      ARM: dts: stm32: add phy-names to usbotg_hs on stm32mp157c-ev1
      ARM: multi_v7_defconfig: enable STM32 PWR regulator

Amit Kucheria (4):
      arm64: dts: sdm845: thermal: Add critical interrupt support
      arm64: dts: msm8916: thermal: Add interrupt support
      arm64: dts: msm8996: thermal: Add critical interrupt support
      arm64: dts: msm8998: thermal: Add critical interrupt support

Anand Moon (1):
      arm64: dts: rockchip: Add regulators for pcie on rk3399-rock960

Andre Heider (1):
      arm64: dts: allwinner: orange-pi-3: Enable IR receiver

Andre Przywara (6):
      arm64: dts: allwinner: H6: Add PMU mode
      arm64: dts: allwinner: H5: Add PMU node
      arm: dts: allwinner: H3: Add PMU node
      ARM: dts: sun8i: R40: Upgrade GICC reg size to 8K
      ARM: dts: sun8i: R40: Add PMU node
      ARM: dts: sun8i: R40: Add SPI controllers nodes and pinmuxes

Andreas Kemnade (4):
      dt-bindings: arm: fsl: add compatible string for Tolino Shine 3
      ARM: dts: add devicetree entry for Tolino Shine 3
      media: dt-bindings: media: fsl-pxp: add missing imx6sll
      ARM: dts: imx6sll: add PXP module

Andrei Stefanescu (1):
      ARM: dts: at91: sama5d2: mark secumod as a GPIO controller

Andrew Jeffery (13):
      dt-bindings: pinctrl: aspeed: Add reg property as a hint
      dt-bindings: misc: Document reg for aspeed, p2a-ctrl nodes
      ARM: dts: aspeed-g5: Move EDAC node to APB
      ARM: dts: aspeed-g5: Use recommended generic node name for SDMC
      ARM: dts: vesnin: Add unit address for memory node
      ARM: dts: fp5280g2: Cleanup gpio-keys-polled properties
      ARM: dts: swift: Cleanup gpio-keys-polled properties
      ARM: dts: witherspoon: Cleanup gpio-keys-polled properties
      ARM: dts: aspeed: Cleanup lpc-ctrl and snoop regs
      ARM: dts: aspeed: Add reg hints to syscon children
      ARM: dts: aspeed-g5: Sort LPC child nodes by unit address
      ARM: dts: aspeed-g6: Cleanup watchdog unit address
      ARM: dts: ibm-power9-dual: Add a unit address for OCC nodes

Andrey Smirnov (6):
      ARM: dts: imx6: rdu2: Add node for UCS1002 USB charger chip
      ARM: dts: imx6: rdu2: Disable WP for USDHC2 and USDHC3
      ARM: dts: imx6: rdu2: Limit USBH1 to Full Speed
      ARM: dts: vf610-zii-dev-rev-b: Drop redundant I2C properties
      ARM: dts: vf610-zii-scu4-aib: Use generic names for DT nodes
      ARM: dts: vf610-zii-scu4-aib: Add node for switch watchdog

André Hentschel (2):
      ARM: dts: Add dtsi files for AM3703, AM3715 and DM3725
      ARM: dts: Add omap3-echo

AngeloGioacchino Del Regno (1):
      arm64: dts: pm8004: Add SPMI regulator and add phandles to lsids

Anson Huang (8):
      dt-bindings: arm: imx: Add the i.MX6SX-SDB Rev-A board
      dt-bindings: arm: imx: Add the i.MX7D-SDB Rev-A board
      ARM: dts: imx6sx-sdb-reva: Add revision in board compatible string
      ARM: dts: imx7d-sdb-reva: Add revision in board compatible string
      arm64: dts: imx8qxp: Remove unnecessary "interrupt-parent" property
      ARM: dts: imx6sl-tolino-shine3: Remove incorrect power supply assignment
      arm64: dts: imx8mm: Memory node should be in board DT
      arm64: dts: imx8mn: Memory node should be in board DT

Anurag Kumar Vulisha (1):
      arm64: zynqmp: Add dr_mode property to usb node

Arnaud Pouliquen (1):
      ARM: dts: stm32: update mlahb node according to the bindings on stm32mp15

Ashish Kumar (4):
      arm64: dts: ls1028a: Add FlexSPI support
      arm64: dts: ls1046a: Update QSPI node properties of ls1046ardb
      arm64: dts: ls208x: Remove non-compatible driver device from qspi node
      arm64: dts: ls1088a: Add QSPI support for NXP LS1088

Bartlomiej Zolnierkiewicz (1):
      ARM: dts: exynos: Add missing CPU frequencies for Exynos5422/5800

Baruch Siach (7):
      ARM: dts: mvebu: add support for SolidRun Clearfog GTR
      ARM: armada-38x-solidrun-microsom: move i2c0 to SOM DT
      ARM: dts: armada-38x-solidrun-microsom: add eeprom
      ARM: dts: armada-388-clearfog: add eeprom
      arm64: dts: marvell: clearfog-gt-8k: fix switch cpu port node
      arm64: dts: imx8mq-sr-som: add eeprom description
      arm64: dts: imx8mq-hummingboard-pulse: add eeprom description

Benjamin Gaignard (12):
      ARM: dts: stm32: remove unused rng interrupt on stm32f429
      ARM: dts: stm32: remove "@" and "_" from stm32f4 pinmux groups
      ARM: dts: stm32: remove "@" and "_" from stm32f7 pinmux groups
      ARM: dts: stm32: remove useless clock-names from RTC node on stm32f429
      ARM: dts: stm32: remove useless clock-names from RTC node on stm32f746
      ARM: dts: stm32: fix dma controller node name on stm32f746
      ARM: dts: stm32: fix dma controller node name on stm32f743
      ARM: dts: stm32: fix dma controller node name on stm32mp157c
      ARM: dts: stm32: change nvmem node name on stm32f429
      ARM: dts: stm32: change nvmem node name on stm32mp1
      ARM: dts: stm32: Add power-supply for DSI panel on stm32f469-disco
      ARM: dts: stm32: Add power-supply for RGB panel on stm32429i-eval

Benoit Parrot (2):
      arm64: dts: ti: k3-am65-main Add CAL node
      arm64: dts: ti: k3-am654-base-board: Add CSI2 OV5640 camera

Bibby Hsieh (1):
      arm64: dts: add gce node for mt8183

Biju Das (1):
      dt-bindings: timer: renesas: tmu: Document r8a774b1 bindings

Bjorn Andersson (18):
      ARM: dts: msm8974: Introduce the wcnss remoteproc node
      ARM: dts: msm8974: Add modem remoteproc node
      ARM: dts: msm8974: Move ADSP smd edge to ADSP PIL
      arm64: dts: qcom: db845c: Enable ath10k 8bit host-cap quirk
      arm64: dts: qcom: db820c: Move non-soc entries out of /soc
      arm64: dts: qcom: msm8996: Use node references in db820c
      arm64: dts: qcom: msm8996: Move regulator consumers to db820c
      arm64: dts: qcom: msm8996: Move regulators to db820c
      arm64: dts: qcom: db820c: Group root nodes
      arm64: dts: qcom: db820c: Sort all nodes
      arm64: dts: qcom: db820c: Remove pin specific files
      arm64: dts: qcom: msm8996: Pad addresses
      arm64: dts: qcom: msm8996: Sort all nodes in msm8996.dtsi
      arm64: dts: qcom: db820c: Use regulator names from schematics
      arm64: dts: qcom: msm8996: Introduce IFC6640
      arm64: dts: qcom: db845c: Move remoteproc firmware to sdm845
      arm64: dts: qcom: msm8998-mtp: Add alias for blsp1_uart3
      arm64: dts: qcom: sm8150: Hard code rpmhpd constants

Brian Masney (2):
      ARM: dts: qcom: msm8974: add ocmem node
      ARM: dts: qcom: msm8974: add interconnect nodes

Chen-Yu Tsai (8):
      ARM: dts: sun8i: r40: Add I2C pinmux options
      ARM: dts: sunxi: Add Libre Computer ALL-H3-IT H5 board
      ARM: dts: sun4i: Add CSI1 controller and pinmux options
      ARM: dts: sun7i: Add CSI1 controller and pinmux options
      ARM: dts: sun8i: r40: Add device node for CSI0
      arm64: dts: allwinner: h5: Add Libre Computer ALL-H5-CC H5 board
      ARM: dts: sunxi: Use macros for references to CCU clocks
      arm64: dts: allwinner: sun50i-a64: Use macros for newly exported clocks

Christoph Fritz (1):
      ARM: dts: phycore-imx6: set buck regulator modes explicitly

Christophe Roullier (3):
      ARM: dts: stm32: remove syscfg clock on stm32mp15 ethernet
      ARM: dts: stm32: adjust slew rate for Ethernet on stm32mp15
      ARM: dts: stm32: Enable MAC TX clock gating during TX low-power mode on stm32mp15

Chunyan Zhang (2):
      arm64: dts: Add Unisoc's SC9863A SoC support
      dt-bindings: arm: move sprd board file to vendor directory

Claudiu Beznea (11):
      dt-bindings: at_xdmac: remove wildcard
      dt-bindings: at_xdmac: add microchip,sam9x60-dma
      dt-bindings: atmel-can: add microchip,sam9x60-can
      dt-bindings: atmel-isi: add microchip,sam9x60-isi
      dt-bindings: at91-sama5d2_adc: add microchip,sam9x60-adc
      dt-bindings: atmel-matrix: add microchip,sam9x60-matrix
      dt-bindings: atmel-nand: add microchip,sam9x60-pmecc
      dt-bindings: atmel-sysreg: add microchip,sam9x60-ddramc
      dt-bindings: atmel-smc: add microchip,sam9x60-smc
      dt-bindings: atmel-gpbr: add microchip,sam9x60-gpbr
      dt-bindings: arm: add sam9x60-ek board

Clément Péron (5):
      arm64: dts: allwinner: h6: Enable USB 3.0 host for Beelink GS1 and Tanix TX6
      arm64: dts: allwiner: Fix typo in dual licensed SPDX identifier
      arm64: dts: allwinner: Fix wrong license header
      arm64: dts: allwinner: Convert license to SPDX identifier
      arm64: dts: allwinner: unify header comment style

Colin Ian King (1):
      dmaengine: ti: omap-dma: don't allow a null od->plat pointer to be dereferenced

Corentin Labbe (2):
      arm64: dts: allwinner: sun50i-h6-pine-h64: state that the DT supports the modelA
      arm64: dts: allwinner: add pineh64 model B

Dafna Hirschfeld (1):
      dt-bindings: fix compilation error of the example in marvell,mmp3-hsic-phy.yaml

Damir Franusic (1):
      ARM: dts: qcom: Add nodes for SMP boot in IPQ40xx

Dinh Nguyen (2):
      arm64: dts: agilex: add NAND IP to base dts
      arm64: dts: add NAND board files for Stratix10 and Agilex

Dmitry Osipenko (1):
      ARM: dts: tegra20: paz00: Add memory timings

Douglas Anderson (9):
      arm64: dts: sc7180: Fix indentation/ordering of qspi nodes in sc7180-idp
      arm64: dts: sc7180: Add a comment to i2c7 about external pullup
      arm64: dts: qcom: sc7180: Add SoC name to compatible
      arm64: dts: qcom: sc7180: Rename gic-its node to msi-controller
      arm64: dts: qcom: sc7180: Add "#clock-cells" property to usb_1_ssphy
      arm64: dts: qcom: pm6150: Remove macro from unit name of adc-chan
      arm64: dts: qcom: sc7180: Avoid "phy" for USB QMP PHY wrapper
      arm64: dts: qcom: sc7180: Fix I2C/UART numbers 2, 4, 7, and 9
      arm64: dts: qcom: sdm845: Rename gic-its node to msi-controller

Eddie James (1):
      ARM: dts: aspeed: rainier: Switch PSUs to unknown version

Eugen Hristev (3):
      dt-bindings: ARM: at91: Document SAMA5D27 WLSOM1 and Evaluation Kit
      ARM: dts: at91: sama5d27_wlsom1: add SAMA5D27 wlsom1 and wlsom1-ek
      ARM: dts: at91: sama5d27_som1_ek: add i2c filters properties

Fabio Estevam (7):
      ARM: dts: e60k02: Pass the memory unit address
      dt-bindings: arm: fsl: Document i.MX7ULP Embedded Artists COM board
      ARM: dts: imx7ulp-com: Add initial support for i.MX7UP COM board
      ARM: dts: imx51-babbage: Fix the DVI output description
      ARM: dts: imx7: Unify temp-grade and speed-grade nodes
      ARM: dts: imx7d-pico: Add LCD support
      ARM: dts: imx6ul-14x14-evk: Pass the "broken-cd" property

Fabrice Gasnier (7):
      ARM: dts: stm32: add pwm sleep pin muxing for stm32mp157c-ev1
      ARM: dts: stm32: add pwm pin muxing for stm32mp157a-dk1
      ARM: dts: stm32: add pwm sleep pins to stm32mp157c-ev1
      ARM: dts: stm32: add support for PWM on stm32mp157a-dk1
      ARM: dts: stm32: add timers counter support on stm32mp157c
      ARM: dts: stm32: add ADC pins used for stm32mp157c-ed1
      ARM: dts: stm32: add ADC support to stm32mp157c-ed1

Fabrizio Castro (4):
      ARM: dts: iwg20d-q7-common: Add LCD support
      dt-bindings: can: rcar_can: document r8a774b1 support
      dt-bindings: can: rcar_canfd: document r8a774b1 support
      arm64: dts: renesas: Add EK874 board with idk-2121wr display support

Fancy Fang (2):
      arm64: dts: imx8mm: remove "simple-bus" for anatop
      arm64: dts: imx8mn: remove "simple-bus" for anatop

Florian Fainelli (2):
      ARM: dts: NSP: Use hardware I2C for BCM958625HR
      Merge tag 'tags/bcm2835-dt-next-2020-01-07' into devicetree/next

Frieder Schrempf (1):
      arm64: dts: imx8mm: Add missing mux options for UART1 and UART2 signals

Geert Uytterhoeven (26):
      arm64: dts: renesas: Remove use of ARCH_R8A7796
      arm64: dts: renesas: Rename r8a7796* to r8a77960*
      ARM: dts: sh73a0: Rename twd clock to periph clock
      ARM: dts: sh73a0: Add device node for ARM global timer
      ARM: dts: r8a7779: Add device node for ARM global timer
      ARM: dts: renesas: Group tuples in regulator-gpio states properties
      ARM: dts: renesas: Group tuples in interrupt properties
      ARM: dts: renesas: Group tuples in pci ranges and dma-ranges properties
      arm64: dts: renesas: Group tuples in regulator-gpio states properties
      arm64: dts: renesas: Group tuples in interrupt properties
      arm64: dts: renesas: Group tuples in pci ranges and dma-ranges properties
      arm64: dts: renesas: r8a77970: Group tuples in thermal reg property
      arm64: dts: renesas: r8a77961: Add RWDT node
      arm64: dts: renesas: r8a77961: Add GPIO nodes
      arm64: dts: renesas: r8a77961: Add RAVB node
      arm64: dts: renesas: r8a77961: Add SYS-DMAC nodes
      arm64: dts: renesas: r8a77961: Add I2C nodes
      arm64: dts: renesas: r8a77961: Add SDHI nodes
      arm64: dts: renesas: Rename r8a7795{-es1,}* to r8a7795[01]*
      arm64: dts: renesas: Drop redundant SoC prefixes from ULCB DTS file names
      arm64: dts: renesas: Sort DTBs in Makefile
      arm64: dts: renesas: Prepare for split of ARCH_R8A7795 into ARCH_R8A7795[01]
      ARM: dts: rcar-gen2: Fix PCI high address in interrupt-map-mask
      ARM: dts: rcar-gen2: Add missing mmio-sram bus properties
      ARM: dts: r8a7778: Add missing clock-frequency for fixed clocks
      ARM: dts: sh73a0: Add missing clock-frequency for fixed clocks

Georgii Staroselskii (3):
      ARM: dts: allwinner: Split out non-SoC specific parts of Neutis N5
      ARM: dts: sunxi: Add Neutis N5H3 support
      dt-bindings: arm: sunxi: add Neutis N5H3

Grygorii Strashko (2):
      ARM: dts: omap3: name mdio node properly
      arm64: dts: ti: k3-am65-mcu: add system control module node

Guido Günther (2):
      arm64: dts: imx8mq: Add eLCDIF controller
      dt-bindings: mxsfb: Add compatible for iMX8MQ

Heiko Stuebner (8):
      arm64: dts: rockchip: remove 408MHz operating point from px30
      arm64: dts: rockchip: add thermal infrastructure to px30
      arm64: dts: rockchip: enable tsadc on px30-evb
      dt-bindings: gpu: mali-bifrost: Add Rockchip PX30
      arm64: dts: rockchip: add the gpu for px30
      arm64: dts: rockchip: enable the gpu on px30-evb
      arm64: dts: rockchip: add dsi controller for px30
      arm64: dts: rockchip: hook up the px30-evb dsi display

Horia Geantă (1):
      arm64: dts: imx8mn: add crypto node

Hsin-Yi Wang (1):
      arm64: dts: mt8173: add Mediatek JPEG Codec

Ingo van Lil (1):
      ARM: dts: at91: Reenable UART TX pull-ups

Ioana Ciornei (2):
      arm64: dts: lx2160a: add emdio1 node
      arm64: dts: lx2160a: add RGMII phy nodes

Ivan Mikhaylov (1):
      ARM: dts: aspeed: Add SD card for Vesnin

JC Kuo (1):
      arm64: tegra: Add fuse/apbmisc node on Tegra194

Jack Chen (1):
      ARM: dts: rockchip: Add missing cpu operating points for rk3288-tinker

Jagan Teki (6):
      dt-bindings: arm: rockchip: Add Rock Pi N10 binding
      arm64: dts: rockchip: Add VMARC RK3399Pro SOM initial support
      ARM: dts: rockchip: Add Radxa Dalang Carrier board
      arm64: dts: rockchip: Add Radxa Rock Pi N10 initial support
      arm64: dts: allwinner: a64: Add MIPI DSI pipeline
      ARM: dts: sun8i: r40: Use tcon top clock index macros

Jeffrey Hugo (6):
      arm64: dts: qcom: msm8998: Add anoc2 smmu node
      arm64: dts: qcom: msm8998: Add wifi node
      arm64: dts: qcom: msm8998: Fix tcsr syscon size
      arm64: dts: qcom: msm8998: Add gpucc node
      arm64: dts: qcom: msm8998: Fixup uart3 gpio config for bluetooth
      arm64: dts: msm8998-clamshell: Add pm8005_s1 regulator

Jernej Skrabec (5):
      media: dt-bindings: media: add new rc map name
      arm64: dts: allwinner: h6: tanix-tx6: Add IR remote mapping
      ARM: dts: sun8i: h3: Add rc map for Beelink X2
      dt-bindings: pwm: allwinner: Add H6 PWM description
      arm64: dts: allwinner: h6: Add PWM node

Jerome Brunet (4):
      arm64: dts: meson: gxl: add i2c C pins
      dt-bindings: arm: amlogic: add libretech-pc bindings
      arm64: dts: meson: add libretech-pc boards support
      arm64: dts: meson: add audio fifo depths

Jim Wright (1):
      ARM: dts: aspeed: rainier: Add UCD90320 power sequencer

Joel Stanley (1):
      ARM: dts: aspeed: AST2400 disables hw checksum

Johan Jonker (9):
      arm64: dts: rockchip: remove identical &uart0 node from rk3368-lion-haikou
      arm64: dts: rockchip: rk3399-firefly: remove num-slots from &sdio0 node
      arm64: dts: rockchip: rk3399-hugsun-x99: remove supports-sd and supports-emmc options
      arm64: dts: rockchip: fix dwmmc clock name for px30
      arm64: dts: rockchip: fix dwmmc clock name for rk3308
      arm64: dts: rockchip: add reg property to brcmf sub-nodes
      ARM: dts: rockchip: add reg property to brcmf sub node for rk3188-bqedison2qc
      ARM: dts: rockchip: rename dwmmc node names to mmc
      arm64: dts: rockchip: rename dwmmc node names to mmc

Jorge Ramirez-Ortiz (4):
      arm64: dts: qcom: msm8916: Add the clocks for the APCS mux/divider
      arm64: dts: qcom: qcs404: Add HFPLL node
      arm64: dts: qcom: qcs404: Add the clocks for APCS mux/divider
      arm64: dts: qcom: qcs404: Add DVFS support

Jyri Sarha (3):
      ARM: dts: am335x-evm: Use drm simple-panel instead of tilcdc-panel
      ARM: dts: am335x-evmsk: Use drm simple-panel instead of tilcdc-panel
      ARM: dts: am335x-icev2: Add support for OSD9616P0899-10 at i2c0

Kamel Bouhara (3):
      ARM: dts: at91: rearrange kizbox dts using aliases nodes
      dt-bindings: arm: at91: Document Kizboxmini and Smartkiz boards binding
      ARM: dts: at91: add smartkiz support and a common kizboxmini dtsi file

Katsuhiro Suzuki (1):
      arm64: dts: rockchip: split rk3399-rockpro64 for v2 and v2.1 boards

Kever Yang (1):
      arm64: dts: rockchip: Fix min voltage for rk3399-firefly vdd_log

Kevin Hilman (1):
      Merge tag 'clk-meson-dt-v5.6-1' of https://github.com/BayLibre/clk-meson into v5.6/dt

Kiran Gunda (3):
      arm64: dts: qcom: sc7180: Add SPMI PMIC arbiter device
      arm64: dts: qcom: pm6150: Add PM6150/PM6150L PMIC peripherals
      arm64: dts: qcom: sc7180-idp: Add RPMh regulators

Krzysztof Kozlowski (3):
      ARM: dts: exynos: Rename children of SysRAM node to "sram"
      ARM: dts: samsung: Rename Samsung and Exynos to lowercase
      arm64: dts: exynos: Rename Samsung and Exynos to lowercase

Kuldeep Singh (2):
      arm64: dts: ls1046a: Add QSPI node for ls1046afrwy
      arm64: dts: ls208xa: Update qspi node properties for LS2088ARDB

Kuninori Morimoto (1):
      arm64: dts: renesas: r8a77990: ebisu: Remove clkout-lr-synchronous from sound

Laurent Pinchart (1):
      arm64: dts: zynqmp: Use decimal values for drm-clock properties

Leonard Crestez (1):
      arm64: dts: imx8m: Add ddr controller nodes

Li Jun (2):
      arm64: dts: imx8mn: Remove setting for IMX8MN_CLK_USB_CORE_REF
      arm64: dts: imx8mn-evk: enable usb1 and typec support

Lina Iyer (2):
      arm64: dts: qcom: add PDC interrupt controller for SDM845
      arm64: dts: qcom: setup PDC as the wakeup parent for TLMM on SDM845

Linus Walleij (5):
      ARM: dts: ux500: declare GPADC IIO ADC channels
      ARM: dts: ux500: Drop pulls on I2C buses
      ARM: dts: ux500: Break out DB8500 DTSI
      ARM: dts: ux500: Split TVK DTSI files in two
      ARM: dts: ux500: Add devicetree for HREF520

Loic Poulain (2):
      arm: dts: qcom: db410c: Enable USB OTG support
      arm64: dts: apq8096-db820c: Fix VDD core voltage

Lokesh Vutla (1):
      arm64: dts: ti: k3-j721e-main: Add missing power-domains for smmu

Lubomir Rintel (5):
      dt-bindings: marvell,mmp2: Add clock ids for the HSIC clocks
      clk: mmp2: Add HSIC clocks
      dt-bindings: phy: Add binding for marvell,mmp3-hsic-phy
      ARM: dts: mmp3: Add HSIC controllers
      ARM: dts: mmp3-dell-ariel: Enable the HSIC

Luca Weiss (1):
      ARM: dts: msm8974-FP2: Introduce the wcnss remoteproc node

Lucas Stach (1):
      arm64: dts: imx8mq: add missing SAI nodes

Ludovic Desroches (1):
      ARM: dts: at91: sama5d2: set the sdmmc gclk frequency

Manish Narani (1):
      arm64: zynqmp: Add ZynqMP SDHCI compatible string

Manivannan Sadhasivam (4):
      arm64: dts: freescale: Add devicetree support for Thor96 board
      dt-bindings: arm: Add devicetree binding for Thor96 Board
      arm64: dts: bitmain: Add clock controller support for BM1880 SoC
      arm64: dts: bitmain: Source common clock for UART controllers

Manu Gautam (1):
      arm64: dts: qcom: msm8996: Disable USB2 PHY suspend by core

Marco Antonio Franchi (2):
      dt-bindings: arm: Add Google Coral Edge TPU entry
      arm64: dts: freescale: add initial support for Google i.MX 8MQ Phanbell

Marco Felsch (1):
      ARM: dts: imx6: phycore-som: add pmic onkey device

Marek Szyprowski (4):
      ARM: dts: exynos: Add initial data for coupled regulators for Exynos5422/5800
      ARM: dts: exynos: Correct USB3503 GPIOs polarity
      ARM: dts: exynos: Move Exynos5420 bus related OPPs to the Odroid boards DTS
      ARM: dts: exynos: Adjust bus related OPPs to the values correct for Exynos5422 Odroids

Marian Mihailescu (1):
      ARM: dts: exynos: Add Mali/GPU node on Exynos5420 and enable it on Odroid XU3/4

Markus Reichl (11):
      arm64: dts: rockchip: Add node for gpu on rk3399-roc-pc
      arm64: dts: rockchip: Add regulators for pcie on rk3399-roc-pc
      arm64: dts: rockchip: Enable HDMI Sound on rk3399-roc-pc
      arm64: dts: rockchip: Disable HS400 for mmc on rk3399-roc-pc
      arm64: dts: rockchip: Fix vdd_log on rk3399-roc-pc
      arm64: dts: rockchip: Use correct pin for lcd-reset pinctrl on rk3399-roc-pc
      arm64: dts: rockchip: Add SDR104 mode to SD-card I/F on rk3399-roc-pc
      arm64: dts: rockchip: Enable MTD Flash on rk3399-roc-pc
      arm64: dts: rockchip: Remove always-on properties from regulator nodes on rk3399-roc-pc.
      arm64: dts: rockchip: Enable mp8859 regulator on rk3399-roc-pc
      arm64: dts: rockchip: Enable sdio0 and uart0 on rk3399-roc-pc-mezzanine

Martin Blumenstingl (6):
      ARM: dts: meson: provide the XTAL clock using a fixed-clock
      ARM: dts: meson8: add the DDR clock controller
      ARM: dts: meson8b: add the DDR clock controller
      ARM: dts: meson8b: fix the clock controller compatible string
      ARM: dts: meson8: use the actual frequency for the GPU's 182.1MHz OPP
      ARM: dts: meson8b: use the actual frequency for the GPU's 364MHz OPP

Martin Kepplinger (1):
      arm64: dts: imx8mq-librem5-devkit: add accelerometer and gyro sensor

Masahiro Yamada (3):
      ARM: dts: uniphier: add pinmux nodes for I2C ch5, ch6
      ARM: dts: uniphier: add reset-names to NAND controller node
      arm64: dts: uniphier: add reset-names to NAND controller node

Matthias Kaehlcke (3):
      arm64: dts: qcom: sc7180: Fix node order
      ARM: dts: rockchip: Use ABI name for write protect pin on veyron fievel/tiger
      ARM: dts: rockchip: Use ABI name for recovery mode pin on veyron fievel/tiger

Matwey V. Kornilov (2):
      arm64: dts: rockchip: Enable PCIe for Radxa Rock Pi 4 board
      arm64: dts: rockchip: Add regulators for PCIe for Radxa Rock Pi 4 board

Maulik Shah (4):
      arm64: dts: qcom: sc7180: Add cmd_db reserved area
      arm64: dts: qcom: sc7180: Add rpmh-rsc node
      arm64: dts: qcom: sc7180: Add pdc interrupt controller
      arm64: dts: qcom: sc7180: Add wakeup parent for TLMM

Maxime Jourdan (1):
      arm64: dts: meson-g12-common: add video decoder node

Maxime Ripard (9):
      dt-bindings: clocks: Convert Allwinner DE2 clocks to a schema
      dt-bindings: clocks: Convert Allwinner A80 USB clocks to a schema
      dt-bindings: clocks: Convert Allwinner A80 DE clocks to a schema
      ARM: dts: sun9i: Make sure the USB PHY resources are in the same order
      ARM: dts: sun8i: v3s: Remove redundant assigned-clocks
      ARM: dts: sunxi: Add missing dmas properties to TCON
      ARM: dts: sun8i: nanopi-duo2: Fix GPIO regulator state array
      ARM: dts: sun9i: Remove useless reset and clock names
      ARM: dts: sunxi: Add missing LVDS resets and clocks

Michael Grzeschik (2):
      ARM: dts: imx25: consolidate properties of usbhost1 in dtsi file
      ARM: dts: imx25: describe maximum speed of internal usbhost port1 phy

Michael Trimarchi (2):
      ARM: dts: imx6qdl-icore-1.5: Remove duplicate phy reset methods
      ARM: dts: imx6qdl-icore: Add fec phy-handle

Michael Walle (2):
      arm64: dts: ls1028a: add missing sai nodes
      arm64: dts: ls1028a: put SAIs into async mode

Michal Simek (14):
      arm64: zynqmp: Use ethernet-phy as node name for ethernet phys
      arm64: zynqmp: Remove addition number in node name
      arm64: zynqmp: Fix address for tca6416_u97 chip on zcu104
      arm64: zynqmp: Turn comment to gpio-line-names
      arm64: zynqmp: Setup clock-output-names for si570 chips
      arm64: zynqmp: Remove broken-cd from zcu100-revC
      arm64: zynqmp: Setup default number of chipselects for zcu100
      arm64: zynqmp: Enable iio-hwmon for ina226 on zcu100
      arm64: zynqmp: Enable iio-hwmon for ina226 on zcu111
      arm64: zynqmp: Add label property to all ina226 on zcu111
      arm64: zynqmp: Enable iio-hwmon for ina226 on zcu102
      arm64: zynqmp: Add label property to all ina226 on zcu102
      arm64: zynqmp: Enable iio-hwmon for ina226 on zcu106
      arm64: zynqmp: Add label property to all ina226 on zcu106

Miquel Raynal (2):
      arm64: dts: rockchip: Add PX30 DSI DPHY
      arm64: dts: rockchip: Add PX30 LVDS

Mohammad Rasim (3):
      dt-bindings: Add vendor prefix for Videostrong
      dt-bindings: arm: amlogic: add Videostrong KII Pro bindings
      arm64: dts: meson-gxbb: add support for Videostrong KII Pro

Neil Armstrong (1):
      arm64: dts: meson-sm1: add video decoder compatible

Nicolas Ferre (1):
      ARM: dts: at91: sama5d27_som1_ek: add the microchip,sdcal-inverted on sdmmc0

Nicolas Saenz Julienne (2):
      ARM: dts: bcm283x: Unify CMA configuration
      ARM: dts: bcm2711: Enable PCIe controller

Niklas Cassel (2):
      arm64: dts: qcom: qcs404: Add CPR and populate OPP table
      arm64: dts: qcom: qcs404-evb: Set vdd_apc regulator in high power mode

Olof Johansson (48):
      Merge tag 'samsung-dt-5.5-2' of https://git.kernel.org/.../krzk/linux into arm/dt
      Merge tag 'socfpga_dts_updates_for_v5.5_part2' of git://git.kernel.org/.../dinguyen/linux into arm/dt
      Merge tag 'ux500-armsoc-v5.6-1' of git://git.kernel.org/.../linusw/linux-stericsson into arm/dt
      Merge tag 'ux500-armsoc-v5.6-2' of git://git.kernel.org/.../linusw/linux-stericsson into arm/dt
      Merge tag 'renesas-arm-dt-for-v5.6-tag1' of git://git.kernel.org/.../geert/renesas-devel into arm/dt
      Merge tag 'renesas-arm64-dt-for-v5.6-tag1' of git://git.kernel.org/.../geert/renesas-devel into arm/dt
      Merge tag 'renesas-dt-bindings-for-v5.6-tag1' of git://git.kernel.org/.../geert/renesas-devel into arm/dt
      Merge branch 'mmp/hsic' into arm/dt
      ARM: dts: mmp3: Fix typos
      Merge branch 'mmp/hsic' into arm/dt
      Merge tag 'omap-for-v5.6/dt-signed' of git://git.kernel.org/.../tmlind/linux-omap into arm/dt
      Merge tag 'omap-for-v5.6/ti-sysc-dt-signed' of git://git.kernel.org/.../tmlind/linux-omap into arm/dt
      Merge branch 'omap/soc' into arm/dt
      Merge tag 'omap-for-v5.6/ti-sysc-drop-pdata-signed' of git://git.kernel.org/.../tmlind/linux-omap into arm/dt
      Merge tag 'arm-soc/for-5.6/devicetree' of https://github.com/Broadcom/stblinux into arm/dt
      Merge tag 'hisi-arm64-dt-for-5.6' of git://github.com/hisilicon/linux-hisi into arm/dt
      Merge tag 'stm32-dt-for-v5.6-1' of git://git.kernel.org/.../atorgue/stm32 into arm/dt
      Merge tag 'v5.6-rockchip-dts32-1' of git://git.kernel.org/.../mmind/linux-rockchip into arm/dt
      Merge tag 'v5.6-rockchip-dts64-1' of git://git.kernel.org/.../mmind/linux-rockchip into arm/dt
      Merge tag 'samsung-dt-5.6' of https://git.kernel.org/.../krzk/linux into arm/dt
      Merge tag 'tegra-for-5.6-dt-bindings' of git://git.kernel.org/.../tegra/linux into arm/dt
      Merge tag 'tegra-for-5.6-arm-dt' of git://git.kernel.org/.../tegra/linux into arm/dt
      Merge tag 'tegra-for-5.6-arm64-dt' of git://git.kernel.org/.../tegra/linux into arm/dt
      Merge tag 'mvebu-dt-5.6-1' of git://git.infradead.org/linux-mvebu into arm/dt
      Merge tag 'mvebu-dt64-5.6-1' of git://git.infradead.org/linux-mvebu into arm/dt
      Merge tag 'imx-bindings-5.6' of git://git.kernel.org/.../shawnguo/linux into arm/dt
      Merge tag 'imx-dt-5.6' of git://git.kernel.org/.../shawnguo/linux into arm/dt
      Merge tag 'imx-dt64-5.6' of git://git.kernel.org/.../shawnguo/linux into arm/dt
      Merge tag 'sunxi-dt-for-5.6-2' of https://git.kernel.org/.../sunxi/linux into arm/dt
      Merge tag 'v5.5-next-dts64' of https://git.kernel.org/.../matthias.bgg/linux into arm/dt
      Merge tag 'at91-5.6-dt-1' of git://git.kernel.org/.../at91/linux into arm/dt
      Merge tag 'qcom-arm64-for-5.6' of https://git.kernel.org/.../qcom/linux into arm/dt
      Merge tag 'qcom-dts-for-5.6' of https://git.kernel.org/.../qcom/linux into arm/dt
      Merge tag 'amlogic-dt64' of https://git.kernel.org/.../khilman/linux-amlogic into arm/dt
      Merge tag 'amlogic-dt' of https://git.kernel.org/.../khilman/linux-amlogic into arm/dt
      Merge tag 'omap-for-v5.6/sdma-fix-signed' of git://git.kernel.org/.../tmlind/linux-omap into arm/dt
      Merge tag 'omap-for-v5.6/dt-part2-signed' of git://git.kernel.org/.../tmlind/linux-omap into arm/dt
      Merge tag 'ti-k3-soc-for-v5.6' of git://git.kernel.org/.../kristo/linux into arm/dt
      Merge tag 'arm-soc/for-5.6/devicetree-part2' of https://github.com/Broadcom/stblinux into arm/dt
      Merge tag 'v5.6-rockchip-dts32-2' of git://git.kernel.org/.../mmind/linux-rockchip into arm/dt
      Merge tag 'v5.6-rockchip-dts64-2' of git://git.kernel.org/.../mmind/linux-rockchip into arm/dt
      Merge tag 'at91-5.6-dt-2' of git://git.kernel.org/.../at91/linux into arm/dt
      Merge tag 'aspeed-5.6-devicetree' of git://git.kernel.org/.../joel/aspeed into arm/dt
      Merge tag 'zynqmp-dt-for-v5.6' of https://github.com/Xilinx/linux-xlnx into arm/dt
      Merge tag 'zynq-dt-for-v5.6-v2' of https://github.com/Xilinx/linux-xlnx into arm/dt
      Merge tag 'uniphier-dt-v5.6' of git://git.kernel.org/.../masahiroy/linux-uniphier into arm/dt
      Merge tag 'uniphier-dt64-v5.6' of git://git.kernel.org/.../masahiroy/linux-uniphier into arm/dt
      Merge tag 'ti-k3-soc-for-v5.6-part2' of git://git.kernel.org/.../kristo/linux into arm/dt

Ondrej Jirman (4):
      ARM: dts: sun8i-a83t: Add thermal sensor and thermal zones
      ARM: dts: sun8i-h3: Add thermal sensor and thermal zones
      arm64: dts: allwinner: h5: Add thermal sensor and thermal zones
      arm64: dts: allwinner: h6: Add thermal sensor and thermal zones

Peng Fan (1):
      arm64: dts: imx8m: drop "fsl,aips-bus" and "fsl,imx8mq-aips-bus"

Peng Ma (1):
      arm64: dts: ls1028a: Update edma compatible to fit eDMA driver

Peter Chen (1):
      ARM: dts: imx7s: Add power domain for imx7d HSIC

Peter Robinson (1):
      arm64: tegra: Allow bootloader to configure Ethernet MAC on Jetson TX2

Peter Ujfalusi (9):
      arm64: dts: ti: k3-am65-main: Correct main NAVSS representation
      arm64: dts: ti: k3-am65-main: Move secure proxy under cbass_main_navss
      arm64: dts: ti: k3-am65: DMA support
      arm64: dts: ti: k3-j721e: Correct the address for MAIN NAVSS
      arm64: dts: ti: k3-j721e-main: Correct main NAVSS representation
      arm64: dts: ti: k3-j721e-main: Move secure proxy and smmu under main_navss
      arm64: dts: ti: k3-j721e: DMA support
      arm64: dts: ti: k3-am654-main: Add McASP nodes
      arm64: dts: ti: k3-j721e-main: Add McASP nodes

Philipp Zabel (1):
      arm64: dts: imx8mq: increase NOC clock to 800 MHz

Philippe Schenker (1):
      ARM: dts: colibri-imx6ull: correct wrong pinmuxing and add comments

Qianggui Song (1):
      arm64: dts: meson: a1: add pinctrl controller support

Rabeeh Khoury (1):
      arm64: dts: lx2160a: add dts for CEX7 platforms

Rajan Vaja (3):
      arm64: dts: xilinx: Add the clock nodes for zynqmp
      arm64: dts: xilinx: Remove dtsi for fixed clock
      arm64: dts: xilinx: Add the power nodes for zynqmp

Rajendra Nayak (4):
      dt-bindings: qcom: Add SC7180 bindings
      arm64: dts: sc7180: Add minimal dts/dtsi files for SC7180 soc
      arm64: dts: sc7180: Remove additional spi chip select muxes
      arm64: dts: sc7180: Add aliases for all i2c and spi devices

Rajeshwari (2):
      arm64: dts: qcom: sc7180: Add device node support for TSENS in SC7180
      arm64: dts: qcom: sc7180: Add critical interrupt and cooling maps for TSENS in SC7180

Rasmus Villemoes (1):
      ARM: dts: ls1021a: add node describing external interrupt lines

Razvan Stefanescu (1):
      ARM: dts: at91: sama5d2: disable pwm0 by default

Rob Clark (1):
      arm64: dts: qcom: sdm845: move gpu zap nodes to per-device dts

Rob Herring (2):
      ARM: dts: rockchip: Kill off "simple-panel" compatibles
      arm64: dts: rockchip: Kill off "simple-panel" compatibles

Robert Jones (4):
      dt-bindings: arm: fsl: Add Gateworks Ventana i.MX6DL/Q compatibles
      ARM: dts: imx: Add GW5907 board support
      ARM: dts: imx: Add GW5913 board support
      ARM: dts: imx: Add GW5912 board support

Robin Murphy (4):
      arm64: dts: rockchip: Fix NanoPC-T4 cooling maps
      arm64: dts: rockchip: Improve nanopi4 PCIe
      arm64: dts: rockchip: Add GPU cooling device for RK3399
      arm64: dts: rockchip: Add RK3328 idle state

Roja Rani Yarubandi (1):
      arm64: dts: sc7180: Add qupv3_0 and qupv3_1

Ruslan V. Sushko (1):
      arm64: dts: zii-ultra: adjust board names

Russell King (4):
      arm64: dts: uDPU: fix broken ethernet
      arm64: dts: uDPU: remove i2c-fast-mode
      arm64: dts: uDPU: SFP cages support 3W modules
      arm64: dts: lx2160a: add emdio2 node

Sai Prakash Ranjan (5):
      arm64: dts: sdm845: Update the device tree node for LLCC
      arm64: dts: qcom: sc7180: Add APSS watchdog node
      arm64: dts: qcom: sm8150: Add APSS watchdog node
      arm64: dts: qcom: sc7180: Add Last level cache controller node
      arm64: dts: qcom: qcs404: Update the compatible for watchdog timer

Samuel Holland (1):
      arm64: dts: allwinner: a64: pinebook: Fix lid wakeup

Sandeep Maheswaram (1):
      arm64: dts: qcom: sc7180: Add USB related nodes

Sandeep Sheriker Mallikarjun (1):
      ARM: dts: at91: sam9x60: add device tree for soc and board

Shawn Guo (3):
      bindings: fsl: document compatibles of lx2160a boards
      arm64: dts: hi3798cv200-poplar: add linux,rc-map-name for IR
      arm64: dts: hi3798cv200: correct PCIe 'bus-range' setting

Sibi Sankar (8):
      arm64: dts: sm8150: Add rpmh power-domain node
      arm64: dts: qcom: sm8150: Add ADSP, CDSP, MPSS and SLPI smp2p
      arm64: dts: qcom: sm8150: Add ADSP, CDSP, MPSS and SLPI remoteprocs
      arm64: dts: qcom: sm8150: Add cpufreq HW device node
      arm64: dts: qcom: sc7180: Add remoteproc enablers
      arm64: dts: qcom: msm8998: Update reserved memory map
      arm64: dts: qcom: msm8998: Add ADSP, MPSS and SLPI nodes
      arm64: dts: qcom: sc7180: Add rpmh power-domain node

Simon Shields (1):
      ARM: dts: exynos: Add support for the touch-sensitive buttons on Midas family

Soeren Moch (2):
      arm64: dts: rockchip: enable wifi module at sdio0 on rockpro64
      arm64: dts: rockchip: hook up bluetooth at uart0 on rockpro64

Stanimir Varbanov (1):
      arm64: dts: qcom: msm8996: Fix venus iommu nodename error

Stefan Agner (1):
      ARM: dts: imx6qdl-apalis: mux HDMI CEC pin

Stefan Mavrodiev (1):
      arm64: dts: allwinner: a64: olinuxino: Add bank supply regulators

Stephan Gerhold (22):
      ARM: dts: ux500: snowball: Remove unused PRCMU cpufreq node
      dt-bindings: arm: Document compatibles for Ux500 boards
      ARM: dts: ux500: Move generic pin configs out of ste-href-family-pinctrl.dtsi
      ARM: dts: ux500: Rename generic pin configs according to pin group
      ARM: dts: ux500: Add alternative SDI pin configs
      ARM: dts: ux500: Add pin configs for UART1 CTS/RTS pins
      ARM: dts: ux500: nomadik-pinctrl: Add &gpio_in_nopull
      ARM: dts: ux500: Disable I2C/SPI buses by default
      ARM: dts: ux500: Add aliases for I2C and SPI buses
      ARM: dts: ux500: Move serial aliases to ste-dbx5x0.dtsi
      ARM: dts: ux500: Remove ux500_ prefix from ux500_serial* labels
      ARM: dts: ux500: Add "simple-bus" compatible to soc node
      ARM: dts: ux500: Use "arm,pl031" compatible for PL031
      arm64: dts: qcom: pm8916: Add vibration motor node
      ARM: dts: ux500: Remove unused ste-href-ab8505.dtsi
      ARM: dts: ux500: Add device tree include for AB8505
      dt-bindings: arm: ux500: Document samsung,golden compatible
      ARM: dts: ux500: Add device tree for Samsung Galaxy S III mini (GT-I8190)
      ARM: dts: ux500: samsung-golden: Add IMU (accelerometer + gyroscope)
      ARM: dts: ux500: samsung-golden: Add touch screen
      ARM: dts: ux500: samsung-golden: Add WiFi
      ARM: dts: ux500: samsung-golden: Add Bluetooth

Stephen Boyd (1):
      arm64: dts: qcom: sdm845-cheza: Add cr50 spi node

Stephen Brennan (2):
      ARM: dts: bcm2835: Move rng definition to common location
      ARM: dts: bcm2711: Enable HWRNG support

Sylwester Nawrocki (1):
      ARM: dts: exynos: Remove syscon compatible from chipid node on Exynos5

Tamás Szűcs (2):
      arm64: tegra: Enable PWM fan on Jetson Nano
      arm64: tegra: Enable SDIO on Jetson Nano M.2 Key E

Taniya Das (2):
      arm64: dts: qcom: SC7180: Add node for rpmhcc clock driver
      arm64: dts: sc7180: Add cpufreq HW node for cpu scaling

Tao Ren (2):
      ARM: dts: aspeed: netbmc: Delete no-hw-checksum
      ARM: dts: aspeed: yamp: Delete no-hw-checksum

Tero Kristo (6):
      ARM: dts: dra7: convert IOMMUs to use ti-sysc
      ARM: dts: dra74x: convert IOMMUs to use ti-sysc
      ARM: dts: omap4: convert IOMMUs to use ti-sysc
      ARM: dts: omap5: convert IOMMUs to use ti-sysc
      ARM: OMAP4: hwmod-data: remove OMAP4 IOMMU hwmod data
      ARM: OMAP5: hwmod-data: remove OMAP5 IOMMU hwmod data

Thierry Reding (13):
      dt-bindings: memory-controller: Convert Tegra124 EMC to json-schema
      ARM: tegra: Let the EMC hardware use the EMC clock
      arm64: tegra: Let the EMC hardware use the EMC clock
      ARM: tegra: Rename EMC on Tegra124
      arm64: tegra: Rename EMC on Tegra132
      dt-bindings: memory: Add Tegra186 memory client IDs
      dt-bindings: memory: Add Tegra194 memory controller header
      dt-bindings: memory: Add Tegra186 memory subsystem
      arm64: tegra: Add interrupt for memory controller on Tegra186
      arm64: tegra: Add external memory controller on Tegra186
      arm64: tegra: Add the memory subsystem on Tegra194
      arm64: tegra: Make XUSB node consistent with the rest
      arm64: tegra: Redefine force recovery key on Jetson AGX Xavier

Thor Thayer (3):
      arm64: dts: agilex: Add EDAC Device Tree
      arm64: dts: agilex: Add SysMgr compatible
      arm64: dts: agilex: Add SysMgr to Ethernet nodes

Tim Harvey (1):
      ARM: dts: imx: Add GW5910 board support

Tomi Valkeinen (2):
      ARM: dts: dra76-evm: add HDMI output
      ARM: dts: am57xx-idk-common: add HDMI to the common dtsi

Tony Lindgren (70):
      ARM: dts: Add generic compatible for omap sdma instances
      ARM: dts: Configure interconnect target module for omap2 sdma
      ARM: dts: Configure interconnect target module for omap3 sdma
      ARM: OMAP2+: Drop unused sdma functions
      ARM: OMAP2+: Drop sdma interrupt handling for mach-omap2
      ARM: OMAP2+: Configure sdma capabilities directly
      ARM: OMAP2+: Configure dma_plat_info directly and drop dma_dev_attr
      dmaengine: ti: omap-dma: Add device tree match data and use it for cpu_pm
      ARM: dts: Configure interconnect target module for am4 qspi
      ARM: dts: Configure interconnect target module for am3 sham
      ARM: dts: Configure interconnect target module for am4 sham
      ARM: dts: Configure interconnect target module for dra7 sham
      ARM: dts: Configure interconnect target module for am3 aes
      ARM: dts: Configure interconnect target module for am4 aes
      ARM: dts: Configure interconnect target module for dra7 aes
      ARM: dts: Configure interconnect target module for am4 des
      ARM: dts: Configure interconnect target module for dra7 des
      ARM: OMAP2+: Drop legacy platform data for am4 qspi
      ARM: OMAP2+: Drop legacy platform data for omap4 aess
      ARM: OMAP2+: Drop legacy platform data for omap4 dmic
      ARM: OMAP2+: Drop legacy platform data for omap4 mcpdm
      ARM: OMAP2+: Drop legacy platform data for omap5 dmic
      ARM: OMAP2+: Drop legacy platform data for omap5 mcpdm
      ARM: OMAP2+: Drop legacy platform data for am3 and am4 sham
      ARM: OMAP2+: Drop legacy platform data for dra7 sham
      ARM: OMAP2+: Drop legacy platform data for am3 and am4 aes
      ARM: OMAP2+: Drop legacy platform data for dra7 aes
      ARM: OMAP2+: Drop legacy platform data for am4 des
      ARM: OMAP2+: Drop legacy platform data for dra7 des
      ARM: OMAP2+: Drop legacy platform data for omap4 timers except timer1
      ARM: OMAP2+: Drop legacy platform data for omap5 timers except timer1
      ARM: OMAP2+: Drop legacy platform data for am3 and am4 timers except timer1 and 2
      ARM: OMAP2+: Drop legacy platform data for dra7 timers except timer1 to 4
      ARM: OMAP2+: Drop legacy platform data for am3 and am4 epwmss
      ARM: OMAP2+: Drop legacy platform data for dra7 epwmss
      ARM: OMAP2+: Drop legacy platform data for am3 and am4 spinlock
      ARM: OMAP2+: Drop legacy platform data for omap4 spinlock
      ARM: OMAP2+: Drop legacy platform data for omap5 spinlock
      ARM: OMAP2+: Drop legacy platform data for dra7 spinlock
      ARM: OMAP2+: Drop legacy platform data for am3 and am4 spi
      ARM: OMAP2+: Drop legacy platform data for am3 and am4 dcan
      ARM: OMAP2+: Drop legacy platform data for dra7 dcan
      ARM: OMAP2+: Drop legacy platform data for am3 adc_tsc
      ARM: OMAP2+: Drop legacy platform data for am4 adc_tsc
      ARM: OMAP2+: Drop legacy platform data for am3 and am4 elm
      ARM: OMAP2+: Drop legacy platform data for omap4 elm
      ARM: OMAP2+: Drop legacy platform data for dra7 elm
      ARM: OMAP2+: Drop legacy platform data for am3 lcdc
      ARM: OMAP2+: Drop legacy platform data for am4 ocp2scp
      ARM: OMAP2+: Drop legacy platform data for omap4 ocp2scp
      ARM: OMAP2+: Drop legacy platform data for omap5 ocp2scp
      ARM: OMAP2+: Drop legacy platform data for dra7 ocp2scp
      ARM: OMAP2+: Drop legacy platform data for am4 vpfe
      ARM: OMAP2+: Drop legacy platform data for omap4 hsi
      ARM: OMAP2+: Drop legacy platform data for omap4 smartreflex
      ARM: OMAP2+: Drop legacy platform data for dra7 smartreflex
      ARM: OMAP2+: Drop legacy platform data for omap4 kbd
      ARM: OMAP2+: Drop legacy platform data for omap5 kbd
      ARM: OMAP2+: Drop legacy platform data for omap4 slimbus
      ARM: OMAP2+: Drop legacy platform data for omap4 fdif
      Merge branch 'omap-for-v5.6/ti-sysc-dt' into omap-for-v5.6/ti-sysc-drop-pdata
      dmaengine: ti: omap-dma: Configure global priority register directly
      dmaengine: ti: omap-dma: Pass sdma auxdata to driver and use it
      dmaengine: ti: omap-dma: Allocate channels directly
      dmaengine: ti: omap-dma: Use cpu notifier to block idle for omap2
      ARM: OMAP2+: Drop legacy init for sdma
      ARM: OMAP2+: Drop legacy platform data for sdma
      Merge tag 'sdma-dts' into omap-for-v5.6/ti-sysc-dt
      Merge branch 'omap-for-v5.6/sdma' into omap-for-v5.6/ti-sysc-drop-pdata
      Merge branch 'omap-for-v5.6/sdma' into omap-for-v5.6/ti-sysc-drop-pdata

Vasily Khoruzhick (5):
      arm64: dts: allwinner: a64: Add thermal sensors and thermal zones
      arm64: dts: allwinner: a64: add CPU clock to CPU0-3 nodes
      arm64: dts: allwinner: a64: add cooling maps and thermal tripping points
      arm64: dts: allwinner: a64: add dtsi with CPU operating points
      arm64: dts: allwinner: a64: enable DVFS

Venkatesh Yadav Abbarapu (1):
      arm64: zynqmp: Fix the si570 clock frequency on zcu111

Victhor Foster (2):
      ARM: dts: qcom: apq8084: Change tsens definition to new style
      ARM: dts: qcom: apq8084: Remove all instances of IRQ_TYPE_NONE

Vignesh Raghavendra (3):
      arm64: dts: ti: k3-j721e: Add DT nodes for few peripherials
      arm64: dts: ti: k3-am65: Add OSPI DT node
      arm64: dts: k3-am654-base-board: Add IRQ line for GPIO expander

Vinod Koul (6):
      arm64: dts: qcom: Use gcc clock enums
      arm64: dts: qcom: sm8150: Add ufs nodes
      arm64: dts: qcom: sm8150-mtp: Enable UFS nodes
      arm64: dts: qcom: sm8150-mtp: Add UFS gpio reset
      arm64: dts: qcom: sm8150: Fix UFS phy register size
      arm64: dts: qcom: sdm845: add the ufs reset

Vivek Gautam (1):
      arm64: dts: sc7180: Add device node for apps_smmu

Vladimir Oltean (1):
      ARM: dts: ls1021a-tsn: Use interrupts for the SGMII PHYs

Xingyu Chen (1):
      arm64: dts: meson: add reset controller for Meson-A1 SoC

Yangtao Li (1):
      ARM: dts: exynos: Enable FIMD node and add proper panel node to Tiny4412

Yann Gautier (4):
      ARM: dts: stm32: update slew-rate properties for sdmmc1 on stm32mp157
      ARM: dts: stm32: add sdmmc2 & 3 nodes for STM32MP157 SoC
      ARM: dts: stm32: enable sdmmc2 node for stm32mp157c-ed1 board
      ARM: dts: stm32: add sdmmc3 node for STM32MP1 boards

Yinbo Zhu (1):
      arm64: dts: ls1028a-rdb: enable emmc hs400 mode

Zumeng Chen (1):
      ARM: dts: zynq: enablement of coresight topology

michael.kao (1):
      arm64: dts: mt8173: Add dynamic power node.

yong.liang (1):
      arm64: dts: mt8183: add reset-cells in infracfg


 .../devicetree/bindings/arm/amlogic.yaml        |    3 +
 .../devicetree/bindings/arm/atmel-at91.yaml     |   31 +
 .../devicetree/bindings/arm/atmel-sysregs.txt   |    1 +
 Documentation/devicetree/bindings/arm/fsl.yaml  |   54 +
 Documentation/devicetree/bindings/arm/qcom.yaml |   44 +-
 .../devicetree/bindings/arm/rockchip.yaml       |    9 +
 .../bindings/arm/{ => sprd}/sprd.yaml           |    2 +-
 .../devicetree/bindings/arm/sunxi.yaml          |   23 +-
 .../devicetree/bindings/arm/ux500.yaml          |   36 +
 .../clock/allwinner,sun8i-a83t-de2-clk.yaml     |   76 +
 .../clock/allwinner,sun9i-a80-de-clks.yaml      |   67 +
 .../clock/allwinner,sun9i-a80-usb-clocks.yaml   |   59 +
 .../devicetree/bindings/clock/sun8i-de2.txt     |   34 -
 .../devicetree/bindings/clock/sun9i-de.txt      |   28 -
 .../devicetree/bindings/clock/sun9i-usb.txt     |   24 -
 .../devicetree/bindings/display/mxsfb.txt       |    1 +
 .../devicetree/bindings/dma/atmel-xdma.txt      |    4 +-
 .../bindings/gpu/arm,mali-bifrost.yaml          |    1 +
 .../bindings/iio/adc/at91-sama5d2_adc.txt       |    2 +-
 .../devicetree/bindings/media/atmel-isi.txt     |    2 +-
 .../devicetree/bindings/media/fsl-pxp.txt       |    2 +-
 Documentation/devicetree/bindings/media/rc.yaml |    1 +
 .../memory-controllers/nvidia,tegra124-emc.txt  |  374 --
 .../memory-controllers/nvidia,tegra124-emc.yaml |  528 +++
 .../memory-controllers/nvidia,tegra186-mc.yaml  |  130 +
 .../devicetree/bindings/mfd/atmel-gpbr.txt      |    4 +-
 .../devicetree/bindings/mfd/atmel-matrix.txt    |    1 +
 .../devicetree/bindings/mfd/atmel-smc.txt       |    1 +
 .../bindings/misc/aspeed-p2a-ctrl.txt           |    1 +
 .../devicetree/bindings/mtd/atmel-nand.txt      |    1 +
 .../devicetree/bindings/net/can/atmel-can.txt   |    3 +-
 .../devicetree/bindings/net/can/rcar_can.txt    |    5 +-
 .../devicetree/bindings/net/can/rcar_canfd.txt  |    5 +-
 .../bindings/phy/marvell,mmp3-hsic-phy.yaml     |   42 +
 .../pinctrl/aspeed,ast2400-pinctrl.yaml         |    3 +
 .../pinctrl/aspeed,ast2500-pinctrl.yaml         |    3 +
 .../bindings/pwm/allwinner,sun4i-a10-pwm.yaml   |   51 +
 .../devicetree/bindings/timer/renesas,tmu.txt   |    1 +
 .../devicetree/bindings/vendor-prefixes.yaml    |    2 +
 MAINTAINERS                                     |    1 +
 arch/arm/boot/dts/Makefile                      |   26 +-
 arch/arm/boot/dts/am335x-evm.dts                |   40 +-
 arch/arm/boot/dts/am335x-evmsk.dts              |   38 +-
 arch/arm/boot/dts/am335x-icev2.dts              |   13 +
 arch/arm/boot/dts/am33xx-l4.dtsi                |   16 -
 arch/arm/boot/dts/am33xx.dtsi                   |   69 +-
 arch/arm/boot/dts/am3517.dtsi                   |    2 +-
 arch/arm/boot/dts/am3703.dtsi                   |   14 +
 arch/arm/boot/dts/am3715.dtsi                   |   10 +
 arch/arm/boot/dts/am4372.dtsi                   |  142 +-
 arch/arm/boot/dts/am437x-l4.dtsi                |   29 -
 arch/arm/boot/dts/am57xx-idk-common.dtsi        |   59 +
 .../arm/boot/dts/armada-385-clearfog-gtr-l8.dts |  115 +
 .../arm/boot/dts/armada-385-clearfog-gtr-s4.dts |   79 +
 arch/arm/boot/dts/armada-385-clearfog-gtr.dtsi  |  450 +++
 arch/arm/boot/dts/armada-388-clearfog.dtsi      |   11 +-
 arch/arm/boot/dts/armada-388-helios4.dts        |    5 -
 .../boot/dts/armada-38x-solidrun-microsom.dtsi  |   13 +
 .../boot/dts/aspeed-bmc-facebook-wedge100.dts   |    1 -
 .../boot/dts/aspeed-bmc-facebook-wedge40.dts    |    1 -
 arch/arm/boot/dts/aspeed-bmc-facebook-yamp.dts  |    1 -
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts    |   20 +-
 .../arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts |    2 -
 arch/arm/boot/dts/aspeed-bmc-opp-swift.dts      |    2 -
 arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts     |   18 +-
 .../arm/boot/dts/aspeed-bmc-opp-witherspoon.dts |    2 -
 arch/arm/boot/dts/aspeed-g4.dtsi                |   21 +-
 arch/arm/boot/dts/aspeed-g5.dtsi                |   49 +-
 arch/arm/boot/dts/aspeed-g6.dtsi                |    2 +-
 .../dts/ast2500-facebook-netbmc-common.dtsi     |    1 -
 arch/arm/boot/dts/at91-kizbox.dts               |  172 +-
 arch/arm/boot/dts/at91-kizboxmini-base.dts      |   24 +
 ...zboxmini.dts => at91-kizboxmini-common.dtsi} |  163 +-
 arch/arm/boot/dts/at91-kizboxmini-mb.dts        |   26 +
 arch/arm/boot/dts/at91-kizboxmini-rd.dts        |   49 +
 arch/arm/boot/dts/at91-nattis-2-natte-2.dts     |    1 -
 arch/arm/boot/dts/at91-sam9x60ek.dts            |  647 ++++
 arch/arm/boot/dts/at91-sama5d27_som1.dtsi       |    4 +
 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts     |    6 +
 arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi     |  304 ++
 arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts   |  270 ++
 arch/arm/boot/dts/at91-smartkiz.dts             |  109 +
 arch/arm/boot/dts/at91sam9260.dtsi              |   16 +-
 arch/arm/boot/dts/at91sam9261.dtsi              |    6 +-
 arch/arm/boot/dts/at91sam9263.dtsi              |    6 +-
 arch/arm/boot/dts/at91sam9g45.dtsi              |    8 +-
 arch/arm/boot/dts/at91sam9rl.dtsi               |    8 +-
 arch/arm/boot/dts/bcm2711.dtsi                  |   70 +-
 arch/arm/boot/dts/bcm2835-common.dtsi           |    6 +
 arch/arm/boot/dts/bcm283x.dtsi                  |   19 +-
 arch/arm/boot/dts/bcm958625hr.dts               |   15 +-
 arch/arm/boot/dts/dm3725.dtsi                   |   10 +
 arch/arm/boot/dts/dra7-l4.dtsi                  |   55 +-
 arch/arm/boot/dts/dra7.dtsi                     |  258 +-
 arch/arm/boot/dts/dra74x.dtsi                   |   71 +-
 arch/arm/boot/dts/dra76-evm.dts                 |   66 +
 arch/arm/boot/dts/e60k02.dtsi                   |    3 +-
 arch/arm/boot/dts/exynos3250.dtsi               |    4 +-
 arch/arm/boot/dts/exynos4210-universal_c210.dts |    6 +-
 arch/arm/boot/dts/exynos4210.dtsi               |    4 +-
 arch/arm/boot/dts/exynos4412-galaxy-s3.dtsi     |    5 +
 arch/arm/boot/dts/exynos4412-midas.dtsi         |   29 +
 arch/arm/boot/dts/exynos4412-n710x.dts          |    5 +
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi |    2 +-
 arch/arm/boot/dts/exynos4412-tiny4412.dts       |   25 +
 arch/arm/boot/dts/exynos4412.dtsi               |    4 +-
 arch/arm/boot/dts/exynos5.dtsi                  |    2 +-
 arch/arm/boot/dts/exynos5250-arndale.dts        |    4 +-
 arch/arm/boot/dts/exynos5250-smdk5250.dts       |    4 +-
 arch/arm/boot/dts/exynos5250.dtsi               |   12 +-
 arch/arm/boot/dts/exynos5260-xyref5260.dts      |    4 +-
 arch/arm/boot/dts/exynos5260.dtsi               |    2 +-
 arch/arm/boot/dts/exynos5410-odroidxu.dts       |    2 +-
 arch/arm/boot/dts/exynos5410-smdk5410.dts       |    4 +-
 arch/arm/boot/dts/exynos5410.dtsi               |    6 +-
 arch/arm/boot/dts/exynos5420-arndale-octa.dts   |    2 +-
 arch/arm/boot/dts/exynos5420-cpus.dtsi          |    2 +-
 arch/arm/boot/dts/exynos5420-smdk5420.dts       |    4 +-
 arch/arm/boot/dts/exynos5420.dtsi               |  339 +-
 arch/arm/boot/dts/exynos5422-cpus.dtsi          |    2 +-
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi   |  285 +-
 arch/arm/boot/dts/exynos5422-odroidhc1.dts      |   64 +-
 .../boot/dts/exynos5422-odroidxu3-common.dtsi   |   78 +-
 arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts |   58 +
 arch/arm/boot/dts/exynos54xx.dtsi               |    4 +-
 arch/arm/boot/dts/exynos5800-peach-pi.dts       |   13 +
 arch/arm/boot/dts/exynos5800.dtsi               |   58 +-
 arch/arm/boot/dts/ibm-power9-dual.dtsi          |    4 +-
 .../dts/imx25-eukrea-mbimxsd25-baseboard.dts    |    2 -
 arch/arm/boot/dts/imx25-pdk.dts                 |    2 -
 arch/arm/boot/dts/imx25.dtsi                    |    3 +
 arch/arm/boot/dts/imx51-babbage.dts             |   64 +-
 arch/arm/boot/dts/imx6dl-gw5907.dts             |   14 +
 arch/arm/boot/dts/imx6dl-gw5910.dts             |   14 +
 arch/arm/boot/dts/imx6dl-gw5912.dts             |   13 +
 arch/arm/boot/dts/imx6dl-gw5913.dts             |   14 +
 arch/arm/boot/dts/imx6q-gw5907.dts              |   14 +
 arch/arm/boot/dts/imx6q-gw5910.dts              |   14 +
 arch/arm/boot/dts/imx6q-gw5912.dts              |   13 +
 arch/arm/boot/dts/imx6q-gw5913.dts              |   14 +
 arch/arm/boot/dts/imx6q-logicpd.dts             |   10 +
 arch/arm/boot/dts/imx6qdl-apalis.dtsi           |    2 +-
 arch/arm/boot/dts/imx6qdl-gw5907.dtsi           |  399 ++
 arch/arm/boot/dts/imx6qdl-gw5910.dtsi           |  491 +++
 arch/arm/boot/dts/imx6qdl-gw5912.dtsi           |  461 +++
 arch/arm/boot/dts/imx6qdl-gw5913.dtsi           |  348 ++
 arch/arm/boot/dts/imx6qdl-icore-1.5.dtsi        |    2 -
 arch/arm/boot/dts/imx6qdl-icore.dtsi            |   15 +-
 .../boot/dts/imx6qdl-phytec-phycore-som.dtsi    |    9 +
 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi         |   84 +-
 arch/arm/boot/dts/imx6sl-tolino-shine3.dts      |  322 ++
 arch/arm/boot/dts/imx6sll.dtsi                  |    9 +
 arch/arm/boot/dts/imx6sx-sdb-reva.dts           |    1 +
 arch/arm/boot/dts/imx6ul-14x14-evk.dtsi         |    1 +
 arch/arm/boot/dts/imx6ull-colibri.dtsi          |  188 +-
 arch/arm/boot/dts/imx7d-pico.dtsi               |   90 +
 arch/arm/boot/dts/imx7d-sdb-reva.dts            |    3 +
 arch/arm/boot/dts/imx7d.dtsi                    |    2 +-
 arch/arm/boot/dts/imx7s.dtsi                    |   16 +-
 arch/arm/boot/dts/imx7ulp-com.dts               |   79 +
 arch/arm/boot/dts/iwg20d-q7-common.dtsi         |   88 +-
 arch/arm/boot/dts/iwg20d-q7-dbcm-ca.dtsi        |    1 -
 arch/arm/boot/dts/ls1021a-tsn.dts               |    4 +
 arch/arm/boot/dts/ls1021a.dtsi                  |   19 +
 arch/arm/boot/dts/meson.dtsi                    |    7 +
 arch/arm/boot/dts/meson6.dtsi                   |    7 -
 arch/arm/boot/dts/meson8.dtsi                   |   28 +-
 arch/arm/boot/dts/meson8b-ec100.dts             |    2 +-
 arch/arm/boot/dts/meson8b-mxq.dts               |    2 +-
 arch/arm/boot/dts/meson8b-odroidc1.dts          |    2 +-
 arch/arm/boot/dts/meson8b.dtsi                  |   30 +-
 arch/arm/boot/dts/mmp3-dell-ariel.dts           |   22 +
 arch/arm/boot/dts/mmp3.dtsi                     |   44 +
 arch/arm/boot/dts/omap2.dtsi                    |   43 +-
 arch/arm/boot/dts/omap2430.dtsi                 |    4 +
 arch/arm/boot/dts/omap3-echo.dts                |  461 +++
 arch/arm/boot/dts/omap3-n900.dts                |    5 +
 arch/arm/boot/dts/omap3.dtsi                    |   46 +-
 arch/arm/boot/dts/omap36xx.dtsi                 |    4 +
 arch/arm/boot/dts/omap4-l4-abe.dtsi             |    7 -
 arch/arm/boot/dts/omap4-l4.dtsi                 |   30 +-
 arch/arm/boot/dts/omap4.dtsi                    |   44 +-
 arch/arm/boot/dts/omap5-l4-abe.dtsi             |    6 -
 arch/arm/boot/dts/omap5-l4.dtsi                 |   24 +-
 arch/arm/boot/dts/omap5.dtsi                    |   40 +-
 arch/arm/boot/dts/qcom-apq8084.dtsi             |   44 +-
 arch/arm/boot/dts/qcom-ipq4019.dtsi             |    7 +
 .../arm/boot/dts/qcom-msm8974-fairphone-fp2.dts |   45 +
 arch/arm/boot/dts/qcom-msm8974.dtsi             |  222 +-
 arch/arm/boot/dts/r7s72100.dtsi                 |   18 +-
 arch/arm/boot/dts/r8a73a4.dtsi                  |   42 +-
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts   |    3 +-
 arch/arm/boot/dts/r8a7740.dtsi                  |  102 +-
 arch/arm/boot/dts/r8a7743.dtsi                  |  162 +-
 arch/arm/boot/dts/r8a7744.dtsi                  |  162 +-
 arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts     |    3 +-
 arch/arm/boot/dts/r8a7745.dtsi                  |  122 +-
 arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts       |    3 +-
 arch/arm/boot/dts/r8a77470.dtsi                 |   86 +-
 arch/arm/boot/dts/r8a7778.dtsi                  |   11 +-
 arch/arm/boot/dts/r8a7779-marzen.dts            |    3 +-
 arch/arm/boot/dts/r8a7779.dtsi                  |   16 +-
 arch/arm/boot/dts/r8a7790-lager.dts             |    6 +-
 arch/arm/boot/dts/r8a7790.dtsi                  |  167 +-
 arch/arm/boot/dts/r8a7791-koelsch.dts           |    9 +-
 arch/arm/boot/dts/r8a7791-porter.dts            |    6 +-
 arch/arm/boot/dts/r8a7791.dtsi                  |  159 +-
 arch/arm/boot/dts/r8a7792.dtsi                  |   67 +-
 arch/arm/boot/dts/r8a7793-gose.dts              |    9 +-
 arch/arm/boot/dts/r8a7793.dtsi                  |  123 +-
 arch/arm/boot/dts/r8a7794-alt.dts               |    6 +-
 arch/arm/boot/dts/r8a7794-silk.dts              |    3 +-
 arch/arm/boot/dts/r8a7794.dtsi                  |  111 +-
 arch/arm/boot/dts/rk3036.dtsi                   |    6 +-
 arch/arm/boot/dts/rk3188-bqedison2qc.dts        |    3 +
 arch/arm/boot/dts/rk322x.dtsi                   |    6 +-
 arch/arm/boot/dts/rk3288-evb.dtsi               |    2 +-
 arch/arm/boot/dts/rk3288-tinker.dtsi            |   13 +-
 arch/arm/boot/dts/rk3288-veyron-brain.dts       |    9 +
 .../dts/rk3288-veyron-broadcom-bluetooth.dtsi   |   22 +
 arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi |   21 -
 arch/arm/boot/dts/rk3288-veyron-edp.dtsi        |    2 +-
 arch/arm/boot/dts/rk3288-veyron-fievel.dts      |   14 +-
 arch/arm/boot/dts/rk3288-veyron-jaq.dts         |   22 +
 arch/arm/boot/dts/rk3288-veyron-jerry.dts       |   22 +
 arch/arm/boot/dts/rk3288-veyron-mickey.dts      |    9 +
 arch/arm/boot/dts/rk3288-veyron-minnie.dts      |   23 +-
 arch/arm/boot/dts/rk3288-veyron-pinky.dts       |   22 +
 arch/arm/boot/dts/rk3288-veyron-speedy.dts      |   21 +
 arch/arm/boot/dts/rk3288-veyron-tiger.dts       |    2 +-
 arch/arm/boot/dts/rk3288-veyron.dtsi            |   59 +-
 arch/arm/boot/dts/rk3288.dtsi                   |    8 +-
 arch/arm/boot/dts/rk3xxx.dtsi                   |    6 +-
 .../boot/dts/rockchip-radxa-dalang-carrier.dtsi |   81 +
 arch/arm/boot/dts/rv1108.dtsi                   |    6 +-
 arch/arm/boot/dts/s3c2416-smdk2416.dts          |    2 +-
 arch/arm/boot/dts/s3c6410-smdk6410.dts          |    4 +-
 arch/arm/boot/dts/sam9x60.dtsi                  |  691 ++++
 arch/arm/boot/dts/sama5d2.dtsi                  |   10 +-
 arch/arm/boot/dts/sama5d3.dtsi                  |   28 +-
 arch/arm/boot/dts/sama5d3_can.dtsi              |    4 +-
 arch/arm/boot/dts/sama5d3_tcb1.dtsi             |    1 +
 arch/arm/boot/dts/sama5d3_uart.dtsi             |    4 +-
 arch/arm/boot/dts/sh73a0.dtsi                   |  139 +-
 arch/arm/boot/dts/ste-ab8500.dtsi               |  102 +-
 arch/arm/boot/dts/ste-ab8505.dtsi               |  275 ++
 arch/arm/boot/dts/ste-db8500.dtsi               |   15 +
 arch/arm/boot/dts/ste-db8520.dtsi               |   15 +
 arch/arm/boot/dts/ste-dbx5x0-pinctrl.dtsi       |  632 ++++
 arch/arm/boot/dts/ste-dbx5x0.dtsi               |   75 +-
 arch/arm/boot/dts/ste-href-ab8505.dtsi          |  234 --
 arch/arm/boot/dts/ste-href-family-pinctrl.dtsi  |  532 +--
 arch/arm/boot/dts/ste-href-tvk1281618-r2.dtsi   |   79 +
 arch/arm/boot/dts/ste-href-tvk1281618-r3.dtsi   |   58 +
 arch/arm/boot/dts/ste-href-tvk1281618.dtsi      |   71 +-
 arch/arm/boot/dts/ste-href.dtsi                 |   67 +-
 arch/arm/boot/dts/ste-href520-tvk.dts           |   22 +
 arch/arm/boot/dts/ste-hrefprev60-stuib.dts      |   10 +-
 arch/arm/boot/dts/ste-hrefprev60-tvk.dts        |   10 +-
 arch/arm/boot/dts/ste-hrefprev60.dtsi           |    2 +-
 arch/arm/boot/dts/ste-hrefv60plus-stuib.dts     |   10 +-
 arch/arm/boot/dts/ste-hrefv60plus-tvk.dts       |   10 +-
 arch/arm/boot/dts/ste-hrefv60plus.dtsi          |    1 -
 arch/arm/boot/dts/ste-nomadik-pinctrl.dtsi      |    5 +
 arch/arm/boot/dts/ste-snowball.dts              |   70 +-
 arch/arm/boot/dts/ste-ux500-samsung-golden.dts  |  455 +++
 arch/arm/boot/dts/stm32429i-eval.dts            |    8 +
 arch/arm/boot/dts/stm32f4-pinctrl.dtsi          |   28 +-
 arch/arm/boot/dts/stm32f429.dtsi                |    4 +-
 arch/arm/boot/dts/stm32f469-disco.dts           |    8 +
 arch/arm/boot/dts/stm32f7-pinctrl.dtsi          |   22 +-
 arch/arm/boot/dts/stm32f746.dtsi                |    5 +-
 arch/arm/boot/dts/stm32h743.dtsi                |    6 +-
 arch/arm/boot/dts/stm32mp15-pinctrl.dtsi        | 1092 ++++++
 .../dts/{stm32mp157c.dtsi => stm32mp151.dtsi}   |  301 +-
 arch/arm/boot/dts/stm32mp153.dtsi               |   45 +
 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi       |  953 -----
 arch/arm/boot/dts/stm32mp157.dtsi               |   31 +
 arch/arm/boot/dts/stm32mp157a-avenger96.dts     |    5 +-
 arch/arm/boot/dts/stm32mp157a-dk1.dts           |  498 +--
 arch/arm/boot/dts/stm32mp157c-dk2.dts           |   15 +-
 arch/arm/boot/dts/stm32mp157c-ed1.dts           |   38 +-
 arch/arm/boot/dts/stm32mp157c-ev1.dts           |   22 +-
 arch/arm/boot/dts/stm32mp157xaa-pinctrl.dtsi    |   90 -
 arch/arm/boot/dts/stm32mp157xab-pinctrl.dtsi    |   62 -
 arch/arm/boot/dts/stm32mp157xac-pinctrl.dtsi    |   78 -
 arch/arm/boot/dts/stm32mp157xad-pinctrl.dtsi    |   62 -
 arch/arm/boot/dts/stm32mp15xc.dtsi              |   18 +
 arch/arm/boot/dts/stm32mp15xx-dkx.dtsi          |  625 ++++
 arch/arm/boot/dts/stm32mp15xxaa-pinctrl.dtsi    |   85 +
 arch/arm/boot/dts/stm32mp15xxab-pinctrl.dtsi    |   57 +
 arch/arm/boot/dts/stm32mp15xxac-pinctrl.dtsi    |   73 +
 arch/arm/boot/dts/stm32mp15xxad-pinctrl.dtsi    |   57 +
 arch/arm/boot/dts/sun4i-a10.dtsi                |   35 +
 arch/arm/boot/dts/sun5i.dtsi                    |    3 +-
 arch/arm/boot/dts/sun6i-a31.dtsi                |   25 +-
 arch/arm/boot/dts/sun7i-a20.dtsi                |   36 +
 arch/arm/boot/dts/sun8i-a23-a33.dtsi            |   13 +-
 arch/arm/boot/dts/sun8i-a83t.dtsi               |   42 +-
 arch/arm/boot/dts/sun8i-h3-beelink-x2.dts       |    1 +
 .../dts/sun8i-h3-emlid-neutis-n5h3-devboard.dts |   72 +
 .../boot/dts/sun8i-h3-emlid-neutis-n5h3.dtsi    |   11 +
 arch/arm/boot/dts/sun8i-h3-nanopi-duo2.dts      |    3 +-
 arch/arm/boot/dts/sun8i-h3.dtsi                 |   35 +-
 arch/arm/boot/dts/sun8i-r40.dtsi                |  172 +-
 arch/arm/boot/dts/sun8i-v3s.dtsi                |    2 -
 arch/arm/boot/dts/sun9i-a80.dtsi                |   42 +-
 arch/arm/boot/dts/sunxi-h3-h5-emlid-neutis.dtsi |  170 +
 arch/arm/boot/dts/sunxi-h3-h5.dtsi              |   13 +-
 .../arm/boot/dts/sunxi-libretech-all-h3-it.dtsi |  180 +
 arch/arm/boot/dts/tegra124-apalis-emc.dtsi      |    2 +-
 arch/arm/boot/dts/tegra124-jetson-tk1-emc.dtsi  |    2 +-
 arch/arm/boot/dts/tegra124-nyan-big-emc.dtsi    |    2 +-
 arch/arm/boot/dts/tegra124-nyan-blaze-emc.dtsi  |    2 +-
 arch/arm/boot/dts/tegra124.dtsi                 |    4 +-
 arch/arm/boot/dts/tegra20-paz00.dts             |   46 +
 arch/arm/boot/dts/uniphier-ld4.dtsi             |    3 +-
 arch/arm/boot/dts/uniphier-pinctrl.dtsi         |   10 +
 arch/arm/boot/dts/uniphier-pro4.dtsi            |    3 +-
 arch/arm/boot/dts/uniphier-pro5.dtsi            |    3 +-
 arch/arm/boot/dts/uniphier-pxs2.dtsi            |    3 +-
 arch/arm/boot/dts/uniphier-sld8.dtsi            |    3 +-
 arch/arm/boot/dts/vf610-zii-dev-rev-b.dts       |   10 -
 arch/arm/boot/dts/vf610-zii-scu4-aib.dts        |   29 +-
 arch/arm/boot/dts/zynq-7000.dtsi                |  135 +
 arch/arm/configs/multi_v7_defconfig             |    1 +
 arch/arm/mach-omap2/common.h                    |    3 +
 arch/arm/mach-omap2/dma.c                       |  119 +-
 arch/arm/mach-omap2/omap_device.c               |  170 -
 arch/arm/mach-omap2/omap_device.h               |    4 -
 arch/arm/mach-omap2/omap_hwmod.c                |   18 -
 arch/arm/mach-omap2/omap_hwmod.h                |    3 -
 arch/arm/mach-omap2/omap_hwmod_2420_data.c      |   34 -
 arch/arm/mach-omap2/omap_hwmod_2430_data.c      |   34 -
 .../mach-omap2/omap_hwmod_2xxx_ipblock_data.c   |   18 -
 .../omap_hwmod_33xx_43xx_common_data.h          |   33 -
 .../omap_hwmod_33xx_43xx_interconnect_data.c    |  124 -
 .../omap_hwmod_33xx_43xx_ipblock_data.c         |  335 --
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c      |   91 -
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c      |   61 -
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c      |  448 ---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c      | 1099 +-----
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c      |  662 ----
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c       |  873 -----
 arch/arm/mach-omap2/omap_hwmod_common_data.h    |    1 -
 arch/arm/mach-omap2/omap_hwmod_reset.c          |   24 -
 arch/arm/mach-omap2/pdata-quirks.c              |    1 +
 arch/arm/mach-omap2/pm24xx.c                    |   22 +-
 arch/arm/mach-omap2/pm34xx.c                    |    5 -
 arch/arm/plat-omap/dma.c                        |  471 +--
 arch/arm64/boot/dts/allwinner/Makefile          |    3 +
 arch/arm64/boot/dts/allwinner/axp803.dtsi       |   43 +-
 .../dts/allwinner/sun50i-a64-amarula-relic.dts  |   23 +-
 .../dts/allwinner/sun50i-a64-bananapi-m64.dts   |   60 +-
 .../boot/dts/allwinner/sun50i-a64-cpu-opp.dtsi  |   75 +
 .../dts/allwinner/sun50i-a64-nanopi-a64.dts     |   60 +-
 .../sun50i-a64-oceanic-5205-5inmfd.dts          |    8 +-
 .../dts/allwinner/sun50i-a64-olinuxino-emmc.dts |   10 +-
 .../boot/dts/allwinner/sun50i-a64-olinuxino.dts |   77 +-
 .../dts/allwinner/sun50i-a64-orangepi-win.dts   |   62 +-
 .../dts/allwinner/sun50i-a64-pine64-lts.dts     |    7 +-
 .../dts/allwinner/sun50i-a64-pine64-plus.dts    |   43 +-
 .../boot/dts/allwinner/sun50i-a64-pine64.dts    |   60 +-
 .../boot/dts/allwinner/sun50i-a64-pinebook.dts  |   26 +-
 .../allwinner/sun50i-a64-sopine-baseboard.dts   |   48 +-
 .../boot/dts/allwinner/sun50i-a64-sopine.dtsi   |   65 +-
 .../boot/dts/allwinner/sun50i-a64-teres-i.dts   |   26 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi   |  185 +-
 .../sun50i-h5-emlid-neutis-n5-devboard.dts      |   88 +-
 .../allwinner/sun50i-h5-emlid-neutis-n5.dtsi    |   68 +-
 .../allwinner/sun50i-h5-libretech-all-h3-cc.dts |    6 +-
 .../allwinner/sun50i-h5-libretech-all-h3-it.dts |   11 +
 .../allwinner/sun50i-h5-libretech-all-h5-cc.dts |   61 +
 .../allwinner/sun50i-h5-nanopi-neo-plus2.dts    |   45 +-
 .../dts/allwinner/sun50i-h5-nanopi-neo2.dts     |   43 +-
 .../dts/allwinner/sun50i-h5-orangepi-pc2.dts    |   43 +-
 .../dts/allwinner/sun50i-h5-orangepi-prime.dts  |   48 +-
 .../allwinner/sun50i-h5-orangepi-zero-plus.dts  |    9 +-
 .../allwinner/sun50i-h5-orangepi-zero-plus2.dts |   43 +-
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi    |   85 +-
 .../dts/allwinner/sun50i-h6-beelink-gs1.dts     |   14 +-
 .../boot/dts/allwinner/sun50i-h6-orangepi-3.dts |   10 +-
 .../dts/allwinner/sun50i-h6-orangepi-lite2.dts  |    6 +-
 .../allwinner/sun50i-h6-orangepi-one-plus.dts   |    8 +-
 .../boot/dts/allwinner/sun50i-h6-orangepi.dtsi  |    8 +-
 .../allwinner/sun50i-h6-pine-h64-model-b.dts    |   21 +
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts   |   23 +-
 .../boot/dts/allwinner/sun50i-h6-tanix-tx6.dts  |   15 +-
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi    |   59 +-
 arch/arm64/boot/dts/altera/Makefile             |    3 +-
 .../dts/altera/socfpga_stratix10_socdk_nand.dts |  223 ++
 arch/arm64/boot/dts/amlogic/Makefile            |    3 +
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi       |   25 +
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi      |    6 +
 .../boot/dts/amlogic/meson-g12-common.dtsi      |   23 +
 arch/arm64/boot/dts/amlogic/meson-g12.dtsi      |    6 +
 .../boot/dts/amlogic/meson-gx-libretech-pc.dtsi |  375 ++
 .../boot/dts/amlogic/meson-gxbb-kii-pro.dts     |   78 +
 .../amlogic/meson-gxl-s905d-libretech-pc.dts    |   16 +
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi      |    9 +
 .../dts/amlogic/meson-gxm-s912-libretech-pc.dts |   62 +
 arch/arm64/boot/dts/amlogic/meson-sm1.dtsi      |   12 +
 .../boot/dts/bitmain/bm1880-sophon-edge.dts     |    9 -
 arch/arm64/boot/dts/bitmain/bm1880.dtsi         |   28 +
 .../boot/dts/exynos/exynos5433-tm2-common.dtsi  |    2 +-
 arch/arm64/boot/dts/exynos/exynos5433-tm2.dts   |    2 +-
 arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts  |    2 +-
 arch/arm64/boot/dts/exynos/exynos7-espresso.dts |    4 +-
 arch/arm64/boot/dts/exynos/exynos7.dtsi         |    2 +-
 arch/arm64/boot/dts/freescale/Makefile          |    4 +
 .../boot/dts/freescale/fsl-ls1028a-qds.dts      |   15 +
 .../boot/dts/freescale/fsl-ls1028a-rdb.dts      |   17 +
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi  |   63 +-
 .../boot/dts/freescale/fsl-ls1046a-frwy.dts     |   14 +
 .../boot/dts/freescale/fsl-ls1046a-rdb.dts      |   16 +-
 .../boot/dts/freescale/fsl-ls1088a-qds.dts      |   24 +
 .../boot/dts/freescale/fsl-ls1088a-rdb.dts      |   24 +
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi  |   13 +
 .../boot/dts/freescale/fsl-ls208xa-rdb.dtsi     |   10 +-
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi  |    6 +-
 .../boot/dts/freescale/fsl-lx2160a-cex7.dtsi    |  127 +
 .../dts/freescale/fsl-lx2160a-clearfog-cx.dts   |   15 +
 .../dts/freescale/fsl-lx2160a-clearfog-itx.dtsi |   57 +
 .../dts/freescale/fsl-lx2160a-honeycomb.dts     |   15 +
 .../boot/dts/freescale/fsl-lx2160a-rdb.dts      |   28 +
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi  |   21 +
 arch/arm64/boot/dts/freescale/imx8mm-evk.dts    |   25 +
 arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h  |   16 +
 arch/arm64/boot/dts/freescale/imx8mm.dtsi       |   55 +-
 .../boot/dts/freescale/imx8mn-ddr4-evk.dts      |   20 +
 arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi   |   70 +
 arch/arm64/boot/dts/freescale/imx8mn.dtsi       |   61 +-
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts    |   27 +
 .../dts/freescale/imx8mq-hummingboard-pulse.dts |    6 +
 .../dts/freescale/imx8mq-librem5-devkit.dts     |    7 +
 .../boot/dts/freescale/imx8mq-phanbell.dts      |  376 ++
 .../arm64/boot/dts/freescale/imx8mq-sr-som.dtsi |    6 +
 arch/arm64/boot/dts/freescale/imx8mq-thor96.dts |  581 +++
 .../dts/freescale/imx8mq-zii-ultra-rmb3.dts     |    2 +-
 .../dts/freescale/imx8mq-zii-ultra-zest.dts     |    2 +-
 arch/arm64/boot/dts/freescale/imx8mq.dtsi       |  107 +-
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi      |   12 -
 .../boot/dts/hisilicon/hi3798cv200-poplar.dts   |    1 +
 arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi  |    2 +-
 arch/arm64/boot/dts/intel/Makefile              |    3 +-
 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi   |   76 +-
 .../dts/intel/socfpga_agilex_socdk_nand.dts     |  135 +
 .../arm64/boot/dts/marvell/armada-3720-uDPU.dts |    8 +
 .../dts/marvell/armada-8040-clearfog-gt-8k.dts  |    2 +
 arch/arm64/boot/dts/mediatek/mt8173.dtsi        |   18 +
 arch/arm64/boot/dts/mediatek/mt8183.dtsi        |   11 +
 arch/arm64/boot/dts/nvidia/tegra132.dtsi        |    4 +-
 arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi  |    1 +
 arch/arm64/boot/dts/nvidia/tegra186.dtsi        |   34 +-
 arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi  |    4 +
 .../boot/dts/nvidia/tegra194-p2972-0000.dts     |    2 +-
 arch/arm64/boot/dts/nvidia/tegra194.dtsi        |   56 +
 .../boot/dts/nvidia/tegra210-p3450-0000.dts     |   73 +
 arch/arm64/boot/dts/qcom/Makefile               |    2 +
 .../boot/dts/qcom/apq8016-sbc-pmic-pins.dtsi    |   19 +
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi       |   11 +-
 .../boot/dts/qcom/apq8096-db820c-pins.dtsi      |  109 -
 .../boot/dts/qcom/apq8096-db820c-pmic-pins.dtsi |   92 -
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi    | 1408 ++++---
 arch/arm64/boot/dts/qcom/apq8096-ifc6640.dts    |  385 ++
 arch/arm64/boot/dts/qcom/msm8916.dtsi           |    5 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi           | 3530 +++++++++---------
 arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi |   49 +
 arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi       |   41 +
 arch/arm64/boot/dts/qcom/msm8998-pins.dtsi      |   25 +-
 arch/arm64/boot/dts/qcom/msm8998.dtsi           |  262 +-
 arch/arm64/boot/dts/qcom/pm6150.dtsi            |   72 +
 arch/arm64/boot/dts/qcom/pm6150l.dtsi           |   31 +
 arch/arm64/boot/dts/qcom/pm8004.dtsi            |   10 +-
 arch/arm64/boot/dts/qcom/pm8916.dtsi            |    6 +
 arch/arm64/boot/dts/qcom/pm8994.dtsi            |    4 +
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi        |    1 +
 arch/arm64/boot/dts/qcom/qcs404.dtsi            |  160 +-
 arch/arm64/boot/dts/qcom/sc7180-idp.dts         |  430 +++
 arch/arm64/boot/dts/qcom/sc7180.dtsi            | 2187 +++++++++++
 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi      |   15 +-
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts      |   18 +-
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts         |    7 +
 arch/arm64/boot/dts/qcom/sdm845.dtsi            |   32 +-
 .../boot/dts/qcom/sdm850-lenovo-yoga-c630.dts   |    7 +
 arch/arm64/boot/dts/qcom/sm8150-mtp.dts         |   35 +
 arch/arm64/boot/dts/qcom/sm8150.dtsi            |  391 +-
 arch/arm64/boot/dts/renesas/Makefile            |   27 +-
 arch/arm64/boot/dts/renesas/hihope-common.dtsi  |    3 +-
 arch/arm64/boot/dts/renesas/r8a774a1.dtsi       |  206 +-
 arch/arm64/boot/dts/renesas/r8a774b1.dtsi       |  206 +-
 arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts |    3 +-
 .../dts/renesas/r8a774c0-ek874-idk-2121wr.dts   |  116 +
 arch/arm64/boot/dts/renesas/r8a774c0.dtsi       |  164 +-
 ...1-salvator-x.dts => r8a77950-salvator-x.dts} |    4 +-
 ...a7795-h3ulcb-kf.dts => r8a77950-ulcb-kf.dts} |    4 +-
 ...r8a7795-es1-h3ulcb.dts => r8a77950-ulcb.dts} |    4 +-
 .../renesas/{r8a7795-es1.dtsi => r8a77950.dtsi} |    4 +-
 ...5-salvator-x.dts => r8a77951-salvator-x.dts} |    4 +-
 ...salvator-xs.dts => r8a77951-salvator-xs.dts} |    8 +-
 ...5-es1-h3ulcb-kf.dts => r8a77951-ulcb-kf.dts} |    4 +-
 .../{r8a7795-h3ulcb.dts => r8a77951-ulcb.dts}   |    4 +-
 .../dts/renesas/{r8a7795.dtsi => r8a77951.dtsi} |  216 +-
 ...6-salvator-x.dts => r8a77960-salvator-x.dts} |    4 +-
 ...salvator-xs.dts => r8a77960-salvator-xs.dts} |    4 +-
 ...a7796-m3ulcb-kf.dts => r8a77960-ulcb-kf.dts} |    4 +-
 .../{r8a7796-m3ulcb.dts => r8a77960-ulcb.dts}   |    4 +-
 .../dts/renesas/{r8a7796.dtsi => r8a77960.dtsi} |  206 +-
 arch/arm64/boot/dts/renesas/r8a77961.dtsi       |  390 +-
 ...7965-m3nulcb-kf.dts => r8a77965-ulcb-kf.dts} |    2 +-
 .../{r8a77965-m3nulcb.dts => r8a77965-ulcb.dts} |    0
 arch/arm64/boot/dts/renesas/r8a77965.dtsi       |  206 +-
 arch/arm64/boot/dts/renesas/r8a77970.dtsi       |   52 +-
 arch/arm64/boot/dts/renesas/r8a77980.dtsi       |   96 +-
 arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts  |    7 +-
 arch/arm64/boot/dts/renesas/r8a77990.dtsi       |  164 +-
 arch/arm64/boot/dts/renesas/r8a77995.dtsi       |   74 +-
 .../arm64/boot/dts/renesas/salvator-common.dtsi |    6 +-
 arch/arm64/boot/dts/renesas/ulcb.dtsi           |    3 +-
 arch/arm64/boot/dts/rockchip/Makefile           |    2 +
 arch/arm64/boot/dts/rockchip/px30-evb.dts       |   43 +
 arch/arm64/boot/dts/rockchip/px30.dtsi          |  199 +-
 arch/arm64/boot/dts/rockchip/rk3308.dtsi        |   12 +-
 arch/arm64/boot/dts/rockchip/rk3328.dtsi        |   23 +-
 .../boot/dts/rockchip/rk3368-lion-haikou.dts    |    6 -
 arch/arm64/boot/dts/rockchip/rk3368.dtsi        |    6 +-
 arch/arm64/boot/dts/rockchip/rk3399-firefly.dts |    6 +-
 arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dts |    2 +-
 .../boot/dts/rockchip/rk3399-gru-kevin.dts      |    2 +-
 .../boot/dts/rockchip/rk3399-hugsun-x99.dts     |    2 -
 .../boot/dts/rockchip/rk3399-khadas-edge.dtsi   |    3 +
 .../boot/dts/rockchip/rk3399-nanopc-t4.dts      |   28 +-
 .../arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi |   27 +-
 .../arm64/boot/dts/rockchip/rk3399-orangepi.dts |    3 +
 .../dts/rockchip/rk3399-roc-pc-mezzanine.dts    |   25 +-
 arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi |   97 +-
 .../boot/dts/rockchip/rk3399-rock-pi-4.dts      |   26 +
 .../arm64/boot/dts/rockchip/rk3399-rock960.dtsi |   11 +
 .../boot/dts/rockchip/rk3399-rockpro64-v2.dts   |   30 +
 .../boot/dts/rockchip/rk3399-rockpro64.dts      |  759 +---
 .../boot/dts/rockchip/rk3399-rockpro64.dtsi     |  797 ++++
 .../dts/rockchip/rk3399-sapphire-excavator.dts  |    2 +-
 arch/arm64/boot/dts/rockchip/rk3399.dtsi        |   13 +-
 .../boot/dts/rockchip/rk3399pro-rock-pi-n10.dts |   17 +
 .../boot/dts/rockchip/rk3399pro-vmarc-som.dtsi  |  333 ++
 .../arm64/boot/dts/socionext/uniphier-ld11.dtsi |    3 +-
 .../arm64/boot/dts/socionext/uniphier-ld20.dtsi |    3 +-
 .../arm64/boot/dts/socionext/uniphier-pxs3.dtsi |    3 +-
 arch/arm64/boot/dts/sprd/Makefile               |    3 +-
 arch/arm64/boot/dts/sprd/sc9863a.dtsi           |  523 +++
 arch/arm64/boot/dts/sprd/sharkl3.dtsi           |   78 +
 arch/arm64/boot/dts/sprd/sp9863a-1h10.dts       |   39 +
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi        |  144 +-
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi         |   92 +
 arch/arm64/boot/dts/ti/k3-am65.dtsi             |   13 +-
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts  |   80 +
 .../boot/dts/ti/k3-j721e-common-proc-board.dts  |  150 +
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi       |  411 +-
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi |  149 +
 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi     |   45 +
 arch/arm64/boot/dts/ti/k3-j721e.dtsi            |    2 +-
 arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi  |  222 ++
 arch/arm64/boot/dts/xilinx/zynqmp-clk.dtsi      |  213 --
 .../boot/dts/xilinx/zynqmp-zc1232-revA.dts      |    4 +-
 .../boot/dts/xilinx/zynqmp-zc1254-revA.dts      |    4 +-
 .../boot/dts/xilinx/zynqmp-zc1275-revA.dts      |    4 +-
 .../boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts |    7 +-
 .../boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts |   11 +-
 .../boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts |    6 +-
 .../boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts |    4 +-
 .../boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts |    6 +-
 .../boot/dts/xilinx/zynqmp-zcu100-revC.dts      |   17 +-
 .../boot/dts/xilinx/zynqmp-zcu102-revA.dts      |  197 +-
 .../boot/dts/xilinx/zynqmp-zcu102-revB.dts      |    4 +-
 .../boot/dts/xilinx/zynqmp-zcu104-revA.dts      |   11 +-
 .../boot/dts/xilinx/zynqmp-zcu106-revA.dts      |  154 +-
 .../boot/dts/xilinx/zynqmp-zcu111-revA.dts      |  124 +-
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi          |   74 +-
 drivers/clk/mmp/clk-of-mmp2.c                   |    6 +
 drivers/dma/ti/omap-dma.c                       |  288 +-
 include/dt-bindings/clock/marvell,mmp2.h        |    2 +
 include/dt-bindings/memory/tegra186-mc.h        |  139 +
 include/dt-bindings/memory/tegra194-mc.h        |  410 ++
 include/linux/omap-dma.h                        |   18 -
 include/sound/aess.h                            |   53 -
 585 files changed, 32373 insertions(+), 15923 deletions(-)
 rename Documentation/devicetree/bindings/arm/{ => sprd}/sprd.yaml (92%)
 create mode 100644 Documentation/devicetree/bindings/arm/ux500.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun8i-a83t-de2-clk.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun9i-a80-de-clks.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/allwinner,sun9i-a80-usb-clocks.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/sun8i-de2.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/sun9i-de.txt
 delete mode 100644 Documentation/devicetree/bindings/clock/sun9i-usb.txt
 delete mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-emc.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-emc.yaml
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/marvell,mmp3-hsic-phy.yaml
 create mode 100644 arch/arm/boot/dts/am3703.dtsi
 create mode 100644 arch/arm/boot/dts/am3715.dtsi
 create mode 100644 arch/arm/boot/dts/armada-385-clearfog-gtr-l8.dts
 create mode 100644 arch/arm/boot/dts/armada-385-clearfog-gtr-s4.dts
 create mode 100644 arch/arm/boot/dts/armada-385-clearfog-gtr.dtsi
 create mode 100644 arch/arm/boot/dts/at91-kizboxmini-base.dts
 rename arch/arm/boot/dts/{at91-kizboxmini.dts => at91-kizboxmini-common.dtsi} (51%)
 create mode 100644 arch/arm/boot/dts/at91-kizboxmini-mb.dts
 create mode 100644 arch/arm/boot/dts/at91-kizboxmini-rd.dts
 create mode 100644 arch/arm/boot/dts/at91-sam9x60ek.dts
 create mode 100644 arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi
 create mode 100644 arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts
 create mode 100644 arch/arm/boot/dts/at91-smartkiz.dts
 create mode 100644 arch/arm/boot/dts/dm3725.dtsi
 create mode 100644 arch/arm/boot/dts/imx6dl-gw5907.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-gw5910.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-gw5912.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-gw5913.dts
 create mode 100644 arch/arm/boot/dts/imx6q-gw5907.dts
 create mode 100644 arch/arm/boot/dts/imx6q-gw5910.dts
 create mode 100644 arch/arm/boot/dts/imx6q-gw5912.dts
 create mode 100644 arch/arm/boot/dts/imx6q-gw5913.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-gw5907.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-gw5910.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-gw5912.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-gw5913.dtsi
 create mode 100644 arch/arm/boot/dts/imx6sl-tolino-shine3.dts
 create mode 100644 arch/arm/boot/dts/imx7ulp-com.dts
 create mode 100644 arch/arm/boot/dts/omap3-echo.dts
 create mode 100644 arch/arm/boot/dts/rk3288-veyron-broadcom-bluetooth.dtsi
 create mode 100644 arch/arm/boot/dts/rockchip-radxa-dalang-carrier.dtsi
 create mode 100644 arch/arm/boot/dts/sam9x60.dtsi
 create mode 100644 arch/arm/boot/dts/ste-ab8505.dtsi
 create mode 100644 arch/arm/boot/dts/ste-db8500.dtsi
 create mode 100644 arch/arm/boot/dts/ste-db8520.dtsi
 create mode 100644 arch/arm/boot/dts/ste-dbx5x0-pinctrl.dtsi
 delete mode 100644 arch/arm/boot/dts/ste-href-ab8505.dtsi
 create mode 100644 arch/arm/boot/dts/ste-href-tvk1281618-r2.dtsi
 create mode 100644 arch/arm/boot/dts/ste-href-tvk1281618-r3.dtsi
 create mode 100644 arch/arm/boot/dts/ste-href520-tvk.dts
 create mode 100644 arch/arm/boot/dts/ste-ux500-samsung-golden.dts
 create mode 100644 arch/arm/boot/dts/stm32mp15-pinctrl.dtsi
 rename arch/arm/boot/dts/{stm32mp157c.dtsi => stm32mp151.dtsi} (87%)
 create mode 100644 arch/arm/boot/dts/stm32mp153.dtsi
 delete mode 100644 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
 create mode 100644 arch/arm/boot/dts/stm32mp157.dtsi
 delete mode 100644 arch/arm/boot/dts/stm32mp157xaa-pinctrl.dtsi
 delete mode 100644 arch/arm/boot/dts/stm32mp157xab-pinctrl.dtsi
 delete mode 100644 arch/arm/boot/dts/stm32mp157xac-pinctrl.dtsi
 delete mode 100644 arch/arm/boot/dts/stm32mp157xad-pinctrl.dtsi
 create mode 100644 arch/arm/boot/dts/stm32mp15xc.dtsi
 create mode 100644 arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
 create mode 100644 arch/arm/boot/dts/stm32mp15xxaa-pinctrl.dtsi
 create mode 100644 arch/arm/boot/dts/stm32mp15xxab-pinctrl.dtsi
 create mode 100644 arch/arm/boot/dts/stm32mp15xxac-pinctrl.dtsi
 create mode 100644 arch/arm/boot/dts/stm32mp15xxad-pinctrl.dtsi
 create mode 100644 arch/arm/boot/dts/sun8i-h3-emlid-neutis-n5h3-devboard.dts
 create mode 100644 arch/arm/boot/dts/sun8i-h3-emlid-neutis-n5h3.dtsi
 create mode 100644 arch/arm/boot/dts/sunxi-h3-h5-emlid-neutis.dtsi
 create mode 100644 arch/arm/boot/dts/sunxi-libretech-all-h3-it.dtsi
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-cpu-opp.dtsi
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5-libretech-all-h3-it.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5-libretech-all-h5-cc.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts
 create mode 100644 arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gx-libretech-pc.dtsi
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-libretech-pc.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxm-s912-libretech-pc.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-itx.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2160a-honeycomb.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mq-phanbell.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mq-thor96.dts
 create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex_socdk_nand.dts
 delete mode 100644 arch/arm64/boot/dts/qcom/apq8096-db820c-pins.dtsi
 delete mode 100644 arch/arm64/boot/dts/qcom/apq8096-db820c-pmic-pins.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/apq8096-ifc6640.dts
 create mode 100644 arch/arm64/boot/dts/qcom/pm6150.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/pm6150l.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180-idp.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sc7180.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r8a774c0-ek874-idk-2121wr.dts
 rename arch/arm64/boot/dts/renesas/{r8a7795-es1-salvator-x.dts => r8a77950-salvator-x.dts} (96%)
 rename arch/arm64/boot/dts/renesas/{r8a7795-h3ulcb-kf.dts => r8a77950-ulcb-kf.dts} (75%)
 rename arch/arm64/boot/dts/renesas/{r8a7795-es1-h3ulcb.dts => r8a77950-ulcb.dts} (89%)
 rename arch/arm64/boot/dts/renesas/{r8a7795-es1.dtsi => r8a77950.dtsi} (98%)
 rename arch/arm64/boot/dts/renesas/{r8a7795-salvator-x.dts => r8a77951-salvator-x.dts} (96%)
 rename arch/arm64/boot/dts/renesas/{r8a7795-salvator-xs.dts => r8a77951-salvator-xs.dts} (96%)
 rename arch/arm64/boot/dts/renesas/{r8a7795-es1-h3ulcb-kf.dts => r8a77951-ulcb-kf.dts} (75%)
 rename arch/arm64/boot/dts/renesas/{r8a7795-h3ulcb.dts => r8a77951-ulcb.dts} (92%)
 rename arch/arm64/boot/dts/renesas/{r8a7795.dtsi => r8a77951.dtsi} (94%)
 rename arch/arm64/boot/dts/renesas/{r8a7796-salvator-x.dts => r8a77960-salvator-x.dts} (94%)
 rename arch/arm64/boot/dts/renesas/{r8a7796-salvator-xs.dts => r8a77960-salvator-xs.dts} (94%)
 rename arch/arm64/boot/dts/renesas/{r8a7796-m3ulcb-kf.dts => r8a77960-ulcb-kf.dts} (77%)
 rename arch/arm64/boot/dts/renesas/{r8a7796-m3ulcb.dts => r8a77960-ulcb.dts} (90%)
 rename arch/arm64/boot/dts/renesas/{r8a7796.dtsi => r8a77960.dtsi} (94%)
 rename arch/arm64/boot/dts/renesas/{r8a77965-m3nulcb-kf.dts => r8a77965-ulcb-kf.dts} (92%)
 rename arch/arm64/boot/dts/renesas/{r8a77965-m3nulcb.dts => r8a77965-ulcb.dts} (100%)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-rockpro64-v2.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399pro-rock-pi-n10.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
 create mode 100644 arch/arm64/boot/dts/sprd/sc9863a.dtsi
 create mode 100644 arch/arm64/boot/dts/sprd/sharkl3.dtsi
 create mode 100644 arch/arm64/boot/dts/sprd/sp9863a-1h10.dts
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
 delete mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-clk.dtsi
 create mode 100644 include/dt-bindings/memory/tegra194-mc.h
 delete mode 100644 include/sound/aess.h
