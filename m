Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A82C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 19:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCCED20771
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 19:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597434005;
	bh=FeeXCr2lQHPOglPuGp8OyG+m6rVOxXy+9dfPyGFC8xY=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=nvYePWu8o9xIaLnqy8WGLkYQImfTG47zUZVC6YjHDHMUrYiF28KL+GsfR1jGIYxhz
	 dkENsW5eXth7RQqQHJqxLNuooNgQv2BtHSY4IoGEEtOrulzpS3mU+ORRh3AXkJOJ7O
	 0aqapp0oiflsjUCBrmjOtCYAba7pAYbWglLdLTrg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbgHNTkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 15:40:04 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36460 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbgHNTkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 15:40:04 -0400
Received: by mail-io1-f66.google.com with SMTP id t15so11935266iob.3;
        Fri, 14 Aug 2020 12:40:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=uCkXEsmyHdTx2ebyK0sux0QXDRBNxPvBoeCNxv8kQ7Q=;
        b=TXjhKUGt57aFwc3Q7nzxHHcO97MYG1uG7pf7aXX7qsvBGytdrA7Q3m01mU+gqd/IWs
         rUCugC/cNIKuVUtc3rzFdfTWrjvRczgM2ahTjYMNnCZNIlKGTjChEdOhkVYUXOpBR2Lz
         vSJeifKHhqxSnu5ggm3J16snzkHxoMoCUHcTCcE6mUTEnqU0HSoluumzpEkgB7sdyHnY
         tgwjPBDVbj/OxwKUefeI6H9sNLGhG09GWamP/b6xmcJh0R4AufxrNcVWiP5O2+6xNHWt
         o9pcyjso92i8ctm++X1PqQZN9iD3YHs2ZHDHxS6myUTauXf3T2iGCXvFGmJmDZ7VuiO4
         KIjQ==
X-Gm-Message-State: AOAM532Zg2hQQZaPXfmq7NbEFV3JgpqG9jxhM8DxPsiYr5NizR8oZsHf
        yi0gWNEetVNdo55yshUOSBqeRHK9yQ==
X-Google-Smtp-Source: ABdhPJxRhdex6uymYYcLIcSj2+cr2wYwjGflCX9Oed2G4BabnsAtUdxAeOxbyOLu9wpU4ksVU5AGxw==
X-Received: by 2002:a5e:9601:: with SMTP id a1mr3460621ioq.179.1597434001935;
        Fri, 14 Aug 2020 12:40:01 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id u89sm635699ili.87.2020.08.14.12.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 12:40:01 -0700 (PDT)
Received: (nullmailer pid 2596869 invoked by uid 1000);
        Fri, 14 Aug 2020 19:40:00 -0000
Date:   Fri, 14 Aug 2020 13:40:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Subject: [GIT PULL] Devicetree fixes for v5.9
Message-ID: <20200814194000.GA2591103@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull these 2 DT schema clean-ups. I'm doing them in the merge 
window to avoid possible conflicts.

Rob


The following changes since commit 7c2a69f610e64c8dec6a06a66e721f4ce1dd783a:

  Merge tag 'ceph-for-5.9-rc1' of git://github.com/ceph/ceph-client (2020-08-12 12:51:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.9

for you to fetch changes up to 5f0b06da5cde3f0a613308b89f0afea678559fdf:

  dt-bindings: Remove more cases of 'allOf' containing a '$ref' (2020-08-14 09:28:52 -0600)

----------------------------------------------------------------
Devicetree fixes for v5.9:

Another round of 'allOf' removals and whitespace clean-ups of schemas.

----------------------------------------------------------------
Rob Herring (2):
      dt-bindings: Whitespace clean-ups in schema files
      dt-bindings: Remove more cases of 'allOf' containing a '$ref'

 .../devicetree/bindings/arm/arm,integrator.yaml    |  6 +-
 .../devicetree/bindings/arm/arm,realview.yaml      | 66 +++++++--------
 .../devicetree/bindings/arm/arm,vexpress-juno.yaml | 12 +--
 .../devicetree/bindings/arm/bcm/brcm,bcm11351.yaml |  2 +-
 .../devicetree/bindings/arm/bcm/brcm,bcm21664.yaml |  2 +-
 .../devicetree/bindings/arm/bcm/brcm,bcm23550.yaml |  2 +-
 .../devicetree/bindings/arm/bcm/brcm,cygnus.yaml   | 20 ++---
 .../devicetree/bindings/arm/bcm/brcm,hr2.yaml      |  2 +-
 .../devicetree/bindings/arm/bcm/brcm,ns2.yaml      |  4 +-
 .../devicetree/bindings/arm/bcm/brcm,nsp.yaml      | 14 ++--
 .../devicetree/bindings/arm/bcm/brcm,stingray.yaml |  6 +-
 .../bindings/arm/bcm/brcm,vulcan-soc.yaml          |  4 +-
 .../devicetree/bindings/arm/coresight-cti.yaml     | 20 ++---
 Documentation/devicetree/bindings/arm/cpus.yaml    |  4 +-
 Documentation/devicetree/bindings/arm/fsl.yaml     | 13 +--
 .../devicetree/bindings/arm/intel,keembay.yaml     |  2 +-
 .../bindings/arm/mediatek/mediatek,pericfg.yaml    | 30 +++----
 .../devicetree/bindings/bus/baikal,bt1-apb.yaml    |  2 +-
 .../devicetree/bindings/bus/baikal,bt1-axi.yaml    |  2 +-
 .../devicetree/bindings/clock/idt,versaclock5.yaml |  8 +-
 .../devicetree/bindings/clock/ingenic,cgu.yaml     | 16 ++--
 .../devicetree/bindings/clock/qcom,mmcc.yaml       |  2 +-
 .../bindings/clock/renesas,cpg-clocks.yaml         | 16 ++--
 .../bindings/clock/sprd,sc9863a-clk.yaml           |  2 +-
 .../bindings/display/brcm,bcm2835-hdmi.yaml        |  3 +-
 .../bindings/display/bridge/nwl-dsi.yaml           | 15 ++--
 .../bindings/display/bridge/renesas,lvds.yaml      | 18 ++--
 .../bindings/display/bridge/simple-bridge.yaml     | 18 ++--
 .../bindings/display/dsi-controller.yaml           | 10 +--
 .../bindings/display/ilitek,ili9486.yaml           |  4 +-
 .../devicetree/bindings/display/ingenic,ipu.yaml   |  8 +-
 .../devicetree/bindings/display/ingenic,lcd.yaml   | 10 +--
 .../devicetree/bindings/display/msm/gmu.yaml       | 38 ++++-----
 .../display/panel/asus,z00t-tm5p5-nt35596.yaml     |  4 +-
 .../bindings/display/panel/boe,tv101wum-nl6.yaml   | 12 +--
 .../bindings/display/panel/elida,kd35t133.yaml     |  4 +-
 .../display/panel/feixin,k101-im2ba02.yaml         |  6 +-
 .../bindings/display/panel/ilitek,ili9322.yaml     |  3 +-
 .../bindings/display/panel/ilitek,ili9881c.yaml    |  3 +-
 .../display/panel/leadtek,ltk050h3146w.yaml        |  4 +-
 .../display/panel/leadtek,ltk500hd1829.yaml        |  4 +-
 .../bindings/display/panel/novatek,nt35510.yaml    |  4 +-
 .../bindings/display/panel/panel-dsi-cm.yaml       |  8 +-
 .../bindings/display/panel/panel-timing.yaml       | 20 ++---
 .../bindings/display/panel/raydium,rm68200.yaml    |  4 +-
 .../display/panel/samsung,s6e88a0-ams452ef01.yaml  |  4 +-
 .../bindings/display/panel/visionox,rm69299.yaml   |  2 +-
 .../devicetree/bindings/display/st,stm32-dsi.yaml  |  3 +-
 .../bindings/display/ti/ti,j721e-dss.yaml          |  2 +-
 Documentation/devicetree/bindings/dsp/fsl,dsp.yaml |  4 +-
 .../devicetree/bindings/example-schema.yaml        |  4 +-
 .../devicetree/bindings/fsi/ibm,fsi2spi.yaml       |  2 +-
 .../bindings/gpio/brcm,xgs-iproc-gpio.yaml         |  6 +-
 .../bindings/gpio/renesas,rcar-gpio.yaml           | 58 ++++++-------
 .../devicetree/bindings/gpu/vivante,gc.yaml        |  3 +-
 .../bindings/hwmon/adi,axi-fan-control.yaml        |  2 +-
 Documentation/devicetree/bindings/i2c/i2c-imx.yaml | 32 ++++----
 Documentation/devicetree/bindings/i2c/i2c-pxa.yaml |  4 +-
 .../devicetree/bindings/iio/adc/adi,ad7606.yaml    |  8 +-
 .../devicetree/bindings/iio/adc/maxim,max1238.yaml |  2 +-
 .../bindings/iio/adc/qcom,spmi-vadc.yaml           | 22 +++--
 .../bindings/iio/adc/rockchip-saradc.yaml          |  8 +-
 .../bindings/iio/amplifiers/adi,hmc425a.yaml       |  4 +-
 .../bindings/iio/chemical/atlas,sensor.yaml        |  4 +-
 .../devicetree/bindings/iio/dac/adi,ad5770r.yaml   | 60 +++++++-------
 .../bindings/iio/light/vishay,vcnl4000.yaml        | 22 ++---
 .../iio/magnetometer/asahi-kasei,ak8975.yaml       | 16 ++--
 .../bindings/iio/proximity/vishay,vcnl3020.yaml    |  4 +-
 .../bindings/iio/temperature/adi,ltc2983.yaml      |  2 +-
 .../devicetree/bindings/input/imx-keypad.yaml      | 26 +++---
 .../input/touchscreen/cypress,cy8ctma140.yaml      |  2 +-
 .../bindings/input/touchscreen/edt-ft5x06.yaml     | 10 +--
 .../bindings/input/touchscreen/goodix.yaml         |  5 +-
 .../bindings/input/touchscreen/touchscreen.yaml    | 12 +--
 .../bindings/interconnect/fsl,imx8m-noc.yaml       | 20 ++---
 .../bindings/interconnect/qcom,sc7180.yaml         |  2 +-
 .../bindings/interconnect/qcom,sdm845.yaml         |  2 +-
 .../bindings/interrupt-controller/arm,gic.yaml     |  4 +-
 .../interrupt-controller/ingenic,intc.yaml         | 22 ++---
 .../bindings/interrupt-controller/mti,gic.yaml     | 28 +++----
 .../bindings/leds/backlight/qcom-wled.yaml         |  3 +-
 .../devicetree/bindings/mailbox/fsl,mu.yaml        | 12 +--
 .../devicetree/bindings/mailbox/qcom-ipcc.yaml     |  2 +-
 .../media/allwinner,sun8i-a83t-de2-rotate.yaml     |  4 +-
 .../media/allwinner,sun8i-h3-deinterlace.yaml      |  4 +-
 .../devicetree/bindings/media/i2c/adv7180.yaml     | 43 +++++-----
 .../bindings/media/i2c/dongwoon,dw9768.yaml        | 43 +++++-----
 .../bindings/media/i2c/imi,rdacm2x-gmsl.yaml       |  2 +-
 .../bindings/media/i2c/maxim,max9286.yaml          |  2 +-
 .../devicetree/bindings/media/i2c/ov8856.yaml      |  3 +-
 .../devicetree/bindings/media/renesas,csi2.yaml    | 18 ++--
 .../devicetree/bindings/media/rockchip-vpu.yaml    |  4 +-
 .../bindings/media/xilinx/xlnx,csi2rxss.yaml       | 15 ++--
 .../bindings/memory-controllers/fsl/mmdc.yaml      | 12 +--
 .../bindings/memory-controllers/ingenic,nemc.yaml  |  8 +-
 .../memory-controllers/renesas,rpc-if.yaml         |  8 +-
 .../devicetree/bindings/mfd/cirrus,madera.yaml     | 34 ++++----
 .../devicetree/bindings/mfd/gateworks-gsc.yaml     |  4 +-
 .../devicetree/bindings/mfd/st,stpmic1.yaml        | 24 +++---
 .../bindings/mfd/ti,j721e-system-controller.yaml   | 11 ++-
 .../devicetree/bindings/mfd/wlf,arizona.yaml       | 22 ++---
 .../bindings/mmc/amlogic,meson-mx-sdhc.yaml        |  6 +-
 .../devicetree/bindings/mmc/ingenic,mmc.yaml       | 14 ++--
 .../devicetree/bindings/mmc/renesas,sdhi.yaml      |  6 +-
 .../bindings/mtd/arasan,nand-controller.yaml       |  8 +-
 .../devicetree/bindings/mtd/gpmi-nand.yaml         |  2 +-
 .../devicetree/bindings/mtd/mxc-nand.yaml          |  2 +-
 .../bindings/mtd/st,stm32-fmc2-nand.yaml           |  2 +-
 Documentation/devicetree/bindings/net/dsa/dsa.yaml |  4 +-
 .../devicetree/bindings/net/qcom,ipa.yaml          | 12 +--
 .../bindings/net/socionext,uniphier-ave4.yaml      | 12 +--
 .../devicetree/bindings/net/stm32-dwmac.yaml       | 12 +--
 .../devicetree/bindings/net/ti,cpsw-switch.yaml    | 62 +++++++-------
 .../bindings/net/ti,k3-am654-cpsw-nuss.yaml        | 66 +++++++--------
 .../devicetree/bindings/nvmem/imx-ocotp.yaml       | 24 +++---
 .../devicetree/bindings/nvmem/qcom,qfprom.yaml     |  4 +-
 .../devicetree/bindings/pci/ti,j721e-pci-ep.yaml   |  3 +-
 .../devicetree/bindings/pci/ti,j721e-pci-host.yaml |  3 +-
 .../bindings/phy/amlogic,meson-g12a-usb2-phy.yaml  |  6 +-
 .../bindings/phy/phy-rockchip-inno-usb2.yaml       |  6 +-
 .../devicetree/bindings/phy/qcom,qmp-phy.yaml      | 13 ++-
 .../bindings/phy/qcom,qmp-usb3-dp-phy.yaml         |  9 +-
 .../devicetree/bindings/phy/qcom,qusb2-phy.yaml    | 30 +++----
 .../bindings/phy/socionext,uniphier-pcie-phy.yaml  |  8 +-
 .../phy/socionext,uniphier-usb3hs-phy.yaml         | 10 +--
 .../phy/socionext,uniphier-usb3ss-phy.yaml         | 22 ++---
 .../devicetree/bindings/phy/ti,phy-j721e-wiz.yaml  |  3 +-
 .../bindings/pinctrl/aspeed,ast2400-pinctrl.yaml   | 32 ++++----
 .../bindings/pinctrl/aspeed,ast2500-pinctrl.yaml   | 36 ++++----
 .../bindings/pinctrl/aspeed,ast2600-pinctrl.yaml   | 96 +++++++++++-----------
 .../bindings/pinctrl/ingenic,pinctrl.yaml          | 24 +++---
 .../bindings/pinctrl/qcom,ipq6018-pinctrl.yaml     | 54 ++++++------
 .../bindings/pinctrl/qcom,sm8250-pinctrl.yaml      | 32 ++++----
 .../bindings/pinctrl/st,stm32-pinctrl.yaml         |  4 +-
 .../devicetree/bindings/power/power-domain.yaml    | 14 ++--
 .../bindings/power/supply/gpio-charger.yaml        |  4 +-
 .../bindings/regulator/qcom,smd-rpm-regulator.yaml |  3 +-
 .../bindings/regulator/qcom-labibb-regulator.yaml  |  4 +-
 .../bindings/remoteproc/ti,k3-dsp-rproc.yaml       | 20 ++---
 .../devicetree/bindings/reset/fsl,imx7-src.yaml    |  6 +-
 .../devicetree/bindings/rtc/ingenic,rtc.yaml       | 16 ++--
 .../devicetree/bindings/serial/ingenic,uart.yaml   | 20 ++---
 .../soc/microchip/atmel,at91rm9200-tcb.yaml        | 12 +--
 .../devicetree/bindings/soc/qcom/qcom,geni-se.yaml | 30 +++----
 .../devicetree/bindings/sound/amlogic,aiu.yaml     | 11 ++-
 .../bindings/sound/amlogic,g12a-toacodec.yaml      | 10 +--
 .../devicetree/bindings/sound/cirrus,cs42l51.yaml  |  2 +-
 .../devicetree/bindings/sound/ingenic,aic.yaml     | 12 +--
 .../devicetree/bindings/sound/maxim,max98390.yaml  |  8 +-
 .../bindings/sound/nvidia,tegra186-dspk.yaml       |  3 +-
 .../bindings/sound/nvidia,tegra210-dmic.yaml       |  3 +-
 .../bindings/sound/nvidia,tegra210-i2s.yaml        |  3 +-
 .../devicetree/bindings/sound/rockchip-i2s.yaml    | 24 +++---
 .../devicetree/bindings/sound/rockchip-spdif.yaml  |  4 +-
 .../devicetree/bindings/sound/tas2770.yaml         |  4 +-
 .../bindings/sound/ti,j721e-cpb-audio.yaml         |  6 +-
 .../bindings/sound/ti,j721e-cpb-ivi-audio.yaml     | 15 ++--
 .../devicetree/bindings/sound/tlv320adcx140.yaml   | 28 +++----
 .../bindings/spi/allwinner,sun6i-a31-spi.yaml      |  8 +-
 .../devicetree/bindings/spi/fsl-imx-cspi.yaml      | 26 +++---
 .../bindings/spi/mikrotik,rb4xx-spi.yaml           |  2 +-
 Documentation/devicetree/bindings/spi/spi-mux.yaml | 74 ++++++++---------
 .../devicetree/bindings/spi/spi-rockchip.yaml      | 14 ++--
 .../bindings/thermal/thermal-cooling-devices.yaml  |  6 +-
 .../devicetree/bindings/thermal/thermal-idle.yaml  | 45 +++++-----
 .../devicetree/bindings/timer/fsl,imxgpt.yaml      | 14 ++--
 .../devicetree/bindings/timer/ingenic,tcu.yaml     | 50 +++++------
 .../bindings/timer/snps,dw-apb-timer.yaml          |  4 +-
 .../devicetree/bindings/trivial-devices.yaml       |  2 +-
 Documentation/devicetree/bindings/usb/dwc2.yaml    | 31 +++----
 .../devicetree/bindings/usb/generic-ehci.yaml      |  2 +-
 .../devicetree/bindings/usb/ingenic,musb.yaml      |  8 +-
 .../devicetree/bindings/usb/nvidia,tegra-xudc.yaml | 10 +--
 .../devicetree/bindings/usb/ti,j721e-usb.yaml      |  6 +-
 .../devicetree/bindings/usb/ti,keystone-dwc3.yaml  |  4 +-
 .../devicetree/bindings/vendor-prefixes.yaml       |  3 +-
 176 files changed, 1156 insertions(+), 1188 deletions(-)
