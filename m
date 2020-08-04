Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E394EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 22:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C54B92086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 22:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596580097;
	bh=G+UbD/sNgaYSntePKPHmYYNMn0S02UEOi+oYBpJMrzY=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=kO6IpiEG7lhoqkK2BUMJfJoslJOjgbZj8Z9j7KYgJSR/H4BAMhB2s9PA7lGJ9/t1o
	 pEDY64u0PB3wsH0SoYnibN9o/SlhyGmMOoI2gg6cwdT73Bw3BTicEqntunxZ8PC652
	 Z0wyaMlAx91/N3aM02xUtRt5QDXQFQOrpDwbosv8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbgHDW2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 18:28:16 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:36925 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgHDW2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 18:28:15 -0400
Received: by mail-il1-f193.google.com with SMTP id p13so7212723ilh.4;
        Tue, 04 Aug 2020 15:28:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=tCKvpPALPGGzoPc+HqZKs90Wqd7RFFfK1Wiar2Lz+tY=;
        b=JMRuTURwtasr+HLvn3Vj5rKYGG91TqAx6ryvJT0l+A5CjI37nmRNTTbTuRKILus5VM
         L961DaDCmG8U+MCMtuKHg1Etmh8ybdeABornnV5KmZgIp4dOklDP6LqnHzL1JVPwpHrY
         64aeXP+oRWJO8arx2XHFzaWG/bvPxXC2Y2Vcc29qXs9wOBjRSNVUMiK5PpY1Yu7v0FW0
         IbgK1Fb+ig2CdJz0nRy58AcKtyI7iTPxfI+9H+bmWM4uiO4Nq8Cz9FwT+jKZFvHmd5GQ
         zVSIaYdl3M90jBGByd3qf6eL6slvuWY3TsBVJP86Y2RCt9V9iylFlGbpOURKoBzdaoU1
         txdA==
X-Gm-Message-State: AOAM531hBs6Q6UHpgxnA3p2D3RxjVypOhefyRq4cCLYSO4jg33ApkajE
        qa3RGezDrXSOG/GvkKktvg==
X-Google-Smtp-Source: ABdhPJx0QFUzNuhtNoeRhoSGSjtbs7CF4UwbR+YU6KQ2XWLgaUOvIaomIVdxb16LsQykpCyygNH5RA==
X-Received: by 2002:a92:7409:: with SMTP id p9mr749858ilc.266.1596580093178;
        Tue, 04 Aug 2020 15:28:13 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id e84sm160269ill.60.2020.08.04.15.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 15:28:12 -0700 (PDT)
Received: (nullmailer pid 1225901 invoked by uid 1000);
        Tue, 04 Aug 2020 22:28:11 -0000
Date:   Tue, 4 Aug 2020 16:28:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Subject: [GIT PULL] Devicetree updates for v5.9
Message-ID: <20200804222811.GA1222892@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull DT updates for v5.9.

Rob

The following changes since commit 0115e6c98c22f3fc7ff7da2a41480483abe95b37:

  dt-bindings: clock: imx: Fix e-mail address (2020-07-01 16:29:11 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-5.9

for you to fetch changes up to 6f1188b4ac7577c29a4883d5618fa2231396fe9d:

  of: reserved-memory: remove duplicated call to of_get_flat_dt_prop() for no-map node (2020-08-03 16:50:54 -0600)

----------------------------------------------------------------
Devicetree updates for v5.9:

- Improve device links cycle detection and breaking.  Add more
  bindings for device link dependencies.

- Refactor parsing 'no-map' in __reserved_mem_alloc_size()

- Improve DT unittest 'ranges' and 'dma-ranges' test case to check
  differing cell sizes

- Various http to https link conversions

- Add a schema check to prevent 'syscon' from being used by itself
  without a more specific compatible

- A bunch more DT binding conversions to schema

----------------------------------------------------------------
Alexander A. Klimov (7):
      dt-bindings: media: xilinx: Replace HTTP links with HTTPS ones
      dt-bindings: mfd: dialog: Replace HTTP links with HTTPS ones
      dt-bindings: virtio: Replace HTTP links with HTTPS ones
      dt-bindings: fpga: Replace HTTP links with HTTPS ones
      drm/tilcdc: Replace HTTP links with HTTPS ones
      dt-bindings: drm/bridge: Replace HTTP links with HTTPS ones
      dt-bindings: aspeed-lpc: Replace HTTP links with HTTPS ones

Amit Kucheria (1):
      MAINTAINERS: update Amit Kucheria's email to a single email address

Anson Huang (16):
      dt-bindings: thermal: Convert qoriq to json-schema
      dt-bindings: clock: Convert imx7ulp clock to json-schema
      dt-bindings: rtc: Convert imxdi rtc to json-schema
      dt-bindings: mmc: Convert imx mmc to json-schema
      dt-bindings: mmc: Convert mxs mmc to json-schema
      dt-bindings: i2c: Convert imx lpi2c to json-schema
      dt-bindings: clock: Correct mmc node name in i.MX35 binding
      dt-bindings: clock: Correct example in i.MX8QXP LPCG binding
      dt-bindings: mmc: Convert imx esdhc to json-schema
      dt-bindings: i2c: Convert mxs i2c to json-schema
      dt-bindings: i2c: Convert imx i2c to json-schema
      dt-bindings: input: Convert matrix-keymap to json-schema
      dt-bindings: input: Convert imx keypad to json-schema
      dt-bindings: mtd: Convert gpmi nand to json-schema
      dt-bindings: mtd: Convert imx nand to json-schema
      dt-bindings: memory-controllers: Convert mmdc to json-schema

Christian Eggers (1):
      dt-bindings: iio: io-channel-mux: Fix compatible string in example code

Dan Murphy (1):
      dt-bindings: property-units: Add picoseconds type

Danny Lin (1):
      of: reserved_mem: Fix typo in the too-many-regions message

Florian Fainelli (1):
      dt-bindings: spi: Document bcm2711 and bcm7211 SPI compatible

Geert Uytterhoeven (1):
      dt-bindings: irqchip: renesas-rza1-irqc: Convert to json-schema

Grygorii Strashko (1):
      dt-bindings: phy: ti: phy-gmii-sel: convert bindings to json-schema

Krzysztof Kozlowski (1):
      dt-bindings: pwm: samsung: Do not require interrupts on Exynos SoCs

Lad Prabhakar (1):
      dt-bindings: iommu: renesas,ipmmu-vmsa: Add r8a774e1 support

Lubomir Rintel (6):
      dt-bindings: gpio: Convert mrvl-gpio to json-schema
      dt-bindings: i2c: Convert i2c-pxa to json-schema
      dt-bindings: interrupt-controller: Convert mrvl,intc to json-schema
      dt-bindings: rtc: Convert sa1100-rtc to json-schema
      dt-bindings: timer: Convert mrvl,mmp-timer to json-schema
      dt-bindings: misc: Convert olpc,xo1.75-ec to json-schema

Masahiro Yamada (1):
      dt-bindings: reset: Convert UniPhier reset to json-schema

Nicolas Saenz Julienne (1):
      of: unittest: Use bigger address cells to catch parser regressions

Niklas Söderlund (2):
      dt-bindings: adv7180: Convert bindings to json-schema
      MAINTAINERS: Add ADV7180 bindings documentation

Randy Dunlap (1):
      dt-bindings: mux: mux.h: drop a duplicated word

Rob Herring (4):
      dt-bindings: mfd: Ensure 'syscon' has a more specific compatible
      Merge tag 'devicetree-fixes-for-5.8-2' into dt/next
      dt-bindings: backlight: Convert common backlight bindings to DT schema
      dt-bindings: i2c-gpio: Use 'deprecated' keyword on deprecated properties

Saravana Kannan (4):
      driver core: Add device_is_dependent() to linux/device.h
      of: property: Improve cycle detection when one of the devices is never added
      of: property: Add device link support for multiple DT bindings
      of: property: Add device link support for pinctrl-0 through pinctrl-8

Sowjanya Komatineni (1):
      dt-bindings: media: imx274: Add optional input clock and supplies

Tiezhu Yang (1):
      dt-bindings: interrupt-controller: Fix typos in loongson,liointc.yaml

Wenchao Hao (1):
      of/address: Fix variable name in comment of of_iomap

Yoshihiro Shimoda (1):
      dt-bindings: usb: renesas,usb-xhci: convert to YAML

Yue Hu (1):
      of: reserved-memory: remove duplicated call to of_get_flat_dt_prop() for no-map node

 .../devicetree/bindings/clock/imx35-clock.yaml     |   2 +-
 .../devicetree/bindings/clock/imx7ulp-clock.txt    | 103 ------------
 .../bindings/clock/imx7ulp-pcc-clock.yaml          | 121 ++++++++++++++
 .../bindings/clock/imx7ulp-scg-clock.yaml          |  99 +++++++++++
 .../devicetree/bindings/clock/imx8qxp-lpcg.yaml    |   2 +-
 .../bindings/display/bridge/ti,sn65dsi86.txt       |   2 +-
 .../devicetree/bindings/display/tilcdc/tilcdc.txt  |   2 +-
 .../devicetree/bindings/fpga/fpga-region.txt       |   2 +-
 .../devicetree/bindings/gpio/mrvl-gpio.txt         |  48 ------
 .../devicetree/bindings/gpio/mrvl-gpio.yaml        | 173 +++++++++++++++++++
 .../devicetree/bindings/i2c/i2c-gpio.yaml          |   8 +-
 .../devicetree/bindings/i2c/i2c-imx-lpi2c.txt      |  20 ---
 .../devicetree/bindings/i2c/i2c-imx-lpi2c.yaml     |  47 ++++++
 Documentation/devicetree/bindings/i2c/i2c-imx.txt  |  49 ------
 Documentation/devicetree/bindings/i2c/i2c-imx.yaml | 103 ++++++++++++
 Documentation/devicetree/bindings/i2c/i2c-mxs.txt  |  25 ---
 Documentation/devicetree/bindings/i2c/i2c-mxs.yaml |  51 ++++++
 Documentation/devicetree/bindings/i2c/i2c-pxa.txt  |  31 ----
 Documentation/devicetree/bindings/i2c/i2c-pxa.yaml |  74 +++++++++
 .../bindings/iio/multiplexer/io-channel-mux.txt    |   2 +-
 .../devicetree/bindings/input/imx-keypad.txt       |  53 ------
 .../devicetree/bindings/input/imx-keypad.yaml      |  85 ++++++++++
 .../devicetree/bindings/input/matrix-keymap.txt    |  28 +---
 .../devicetree/bindings/input/matrix-keymap.yaml   |  46 ++++++
 .../interrupt-controller/loongson,liointc.yaml     |   4 +-
 .../bindings/interrupt-controller/mrvl,intc.txt    |  64 -------
 .../bindings/interrupt-controller/mrvl,intc.yaml   | 134 +++++++++++++++
 .../interrupt-controller/renesas,rza1-irqc.txt     |  43 -----
 .../interrupt-controller/renesas,rza1-irqc.yaml    |  80 +++++++++
 .../bindings/iommu/renesas,ipmmu-vmsa.yaml         |   1 +
 .../bindings/leds/backlight/gpio-backlight.txt     |  16 --
 .../bindings/leds/backlight/gpio-backlight.yaml    |  41 +++++
 .../bindings/leds/backlight/led-backlight.txt      |  28 ----
 .../bindings/leds/backlight/led-backlight.yaml     |  57 +++++++
 .../bindings/leds/backlight/pwm-backlight.txt      |  61 -------
 .../bindings/leds/backlight/pwm-backlight.yaml     | 104 ++++++++++++
 .../devicetree/bindings/media/i2c/adv7180.txt      |  49 ------
 .../devicetree/bindings/media/i2c/adv7180.yaml     | 184 +++++++++++++++++++++
 .../devicetree/bindings/media/i2c/imx274.txt       |   5 +
 .../devicetree/bindings/media/xilinx/video.txt     |   2 +-
 .../bindings/memory-controllers/fsl/mmdc.txt       |  35 ----
 .../bindings/memory-controllers/fsl/mmdc.yaml      |  49 ++++++
 .../devicetree/bindings/mfd/aspeed-lpc.txt         |   2 +-
 Documentation/devicetree/bindings/mfd/da9062.txt   |   4 +-
 Documentation/devicetree/bindings/mfd/syscon.yaml  |   3 +-
 .../devicetree/bindings/misc/olpc,xo1.75-ec.txt    |  23 ---
 .../devicetree/bindings/misc/olpc,xo1.75-ec.yaml   |  52 ++++++
 .../devicetree/bindings/mmc/fsl-imx-esdhc.txt      |  67 --------
 .../devicetree/bindings/mmc/fsl-imx-esdhc.yaml     | 124 ++++++++++++++
 .../devicetree/bindings/mmc/fsl-imx-mmc.txt        |  23 ---
 .../devicetree/bindings/mmc/fsl-imx-mmc.yaml       |  53 ++++++
 Documentation/devicetree/bindings/mmc/mxs-mmc.txt  |  27 ---
 Documentation/devicetree/bindings/mmc/mxs-mmc.yaml |  58 +++++++
 .../devicetree/bindings/mtd/gpmi-nand.txt          |  75 ---------
 .../devicetree/bindings/mtd/gpmi-nand.yaml         | 118 +++++++++++++
 Documentation/devicetree/bindings/mtd/mxc-nand.txt |  19 ---
 .../devicetree/bindings/mtd/mxc-nand.yaml          |  42 +++++
 .../devicetree/bindings/phy/ti,phy-gmii-sel.yaml   | 104 ++++++++++++
 .../devicetree/bindings/phy/ti-phy-gmii-sel.txt    |  69 --------
 .../devicetree/bindings/property-units.txt         |   1 +
 .../devicetree/bindings/pwm/pwm-samsung.yaml       |  23 ++-
 .../bindings/reset/socionext,uniphier-reset.yaml   | 112 +++++++++++++
 .../devicetree/bindings/reset/uniphier-reset.txt   | 121 +-------------
 .../devicetree/bindings/rtc/imxdi-rtc.txt          |  20 ---
 .../devicetree/bindings/rtc/imxdi-rtc.yaml         |  44 +++++
 .../devicetree/bindings/rtc/sa1100-rtc.txt         |  17 --
 .../devicetree/bindings/rtc/sa1100-rtc.yaml        |  57 +++++++
 .../devicetree/bindings/spi/brcm,bcm2835-spi.txt   |   3 +-
 .../devicetree/bindings/thermal/qcom-tsens.yaml    |   2 +-
 .../devicetree/bindings/thermal/qoriq-thermal.txt  |  71 --------
 .../devicetree/bindings/thermal/qoriq-thermal.yaml | 114 +++++++++++++
 .../devicetree/bindings/timer/mrvl,mmp-timer.txt   |  17 --
 .../devicetree/bindings/timer/mrvl,mmp-timer.yaml  |  46 ++++++
 .../devicetree/bindings/usb/renesas,usb-xhci.yaml  |  86 ++++++++++
 Documentation/devicetree/bindings/usb/usb-xhci.txt |  18 --
 Documentation/devicetree/bindings/virtio/mmio.txt  |   2 +-
 MAINTAINERS                                        |   5 +-
 drivers/base/core.c                                |   2 +-
 drivers/of/address.c                               |   2 +-
 drivers/of/of_reserved_mem.c                       |  14 +-
 drivers/of/property.c                              |  89 +++++++++-
 drivers/of/unittest-data/tests-address.dtsi        |  10 +-
 drivers/of/unittest.c                              |   2 +-
 include/dt-bindings/mux/mux.h                      |   2 +-
 include/linux/device.h                             |   1 +
 85 files changed, 2610 insertions(+), 1267 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/imx7ulp-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/imx7ulp-pcc-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/imx7ulp-scg-clock.yaml
 delete mode 100644 Documentation/devicetree/bindings/gpio/mrvl-gpio.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/mrvl-gpio.yaml
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-imx-lpi2c.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-imx-lpi2c.yaml
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-imx.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-imx.yaml
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-mxs.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-mxs.yaml
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-pxa.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-pxa.yaml
 delete mode 100644 Documentation/devicetree/bindings/input/imx-keypad.txt
 create mode 100644 Documentation/devicetree/bindings/input/imx-keypad.yaml
 create mode 100644 Documentation/devicetree/bindings/input/matrix-keymap.yaml
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/mrvl,intc.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/mrvl,intc.yaml
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,rza1-irqc.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,rza1-irqc.yaml
 delete mode 100644 Documentation/devicetree/bindings/leds/backlight/gpio-backlight.txt
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml
 delete mode 100644 Documentation/devicetree/bindings/leds/backlight/led-backlight.txt
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/led-backlight.yaml
 delete mode 100644 Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/pwm-backlight.yaml
 delete mode 100644 Documentation/devicetree/bindings/media/i2c/adv7180.txt
 create mode 100644 Documentation/devicetree/bindings/media/i2c/adv7180.yaml
 delete mode 100644 Documentation/devicetree/bindings/memory-controllers/fsl/mmdc.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/fsl/mmdc.yaml
 delete mode 100644 Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.txt
 create mode 100644 Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.yaml
 delete mode 100644 Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
 delete mode 100644 Documentation/devicetree/bindings/mmc/fsl-imx-mmc.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/fsl-imx-mmc.yaml
 delete mode 100644 Documentation/devicetree/bindings/mmc/mxs-mmc.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/mxs-mmc.yaml
 delete mode 100644 Documentation/devicetree/bindings/mtd/gpmi-nand.txt
 create mode 100644 Documentation/devicetree/bindings/mtd/gpmi-nand.yaml
 delete mode 100644 Documentation/devicetree/bindings/mtd/mxc-nand.txt
 create mode 100644 Documentation/devicetree/bindings/mtd/mxc-nand.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/ti-phy-gmii-sel.txt
 create mode 100644 Documentation/devicetree/bindings/reset/socionext,uniphier-reset.yaml
 delete mode 100644 Documentation/devicetree/bindings/rtc/imxdi-rtc.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/imxdi-rtc.yaml
 delete mode 100644 Documentation/devicetree/bindings/rtc/sa1100-rtc.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/sa1100-rtc.yaml
 delete mode 100644 Documentation/devicetree/bindings/thermal/qoriq-thermal.txt
 create mode 100644 Documentation/devicetree/bindings/thermal/qoriq-thermal.yaml
 delete mode 100644 Documentation/devicetree/bindings/timer/mrvl,mmp-timer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/mrvl,mmp-timer.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/renesas,usb-xhci.yaml
