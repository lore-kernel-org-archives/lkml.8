Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562E1C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 17:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32B0020835
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 17:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591984085;
	bh=g91e/1wv5G9GRPLmh4Bj7jc/z9hjVNSYS/5MOWo0vlg=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=V594Io+B8UqG7bJ12wgZwkIdefdmhV4VQvXRn2m281XtjcCgE5APs1KLV5SmnfBDr
	 siCU8kwBh/iif+Jhf8+dzLiGzh1oDacNtfBm1rOznY2/psuqnCajss7+IoXNKZDPOG
	 hEcPm0Tof5uK2K5mo1qKBCGrQIavcWMpVRPRTsHc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgFLRsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 13:48:03 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42351 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgFLRsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 13:48:03 -0400
Received: by mail-io1-f67.google.com with SMTP id x189so2050100iof.9;
        Fri, 12 Jun 2020 10:48:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=uWyUwWKv705gfBnI7xH7f3sQ7/rOjfVXvN6QQKVwLtg=;
        b=hpQP4dBhFBA90/3jTs6s7vLUYoJKuuRIQ44/yAobhCJQjJn1nLMXBh+sntGSqvHchI
         d2rXk/6H+NVZ4pLowp1ngasZIDl8+QogyU9YlaPsM++uCaKebEQgqXdi7PJfrwPvZ8iY
         7l3Wks4UtB0SG1Wa2JSp4XQ/vsHn0cD2RA5uM+r4PJ2Ci+wB728YusVFXH9LJArMsqsC
         EimEJCoGPQPDGicPOgO5kNyuOPho58r/TK4gE+ZxqhuA/jyb5Edbq3EBBp064T/pvXY2
         Ct96xVh5EXDuFlzSjDKQlj9wb5TuuBTr8UAiGFd3q4moFqmSSgYk+EOu8QB9A6LBb2LS
         oVhQ==
X-Gm-Message-State: AOAM533AWb85YbNo2Vh5+oKLO0yCWKI7/afGwvCiVSNcaaOnOrLao9R+
        qRZsqhWhOBOzdf8xIa8geA==
X-Google-Smtp-Source: ABdhPJzwJCr4I0Uc4XSq+L9Lzoz3AqWujTzu0zZU+qqJjfl21exA2K0aKAXB3zdsPK+6/+8v2SXDdg==
X-Received: by 2002:a02:b0c4:: with SMTP id w4mr9021925jah.45.1591984081872;
        Fri, 12 Jun 2020 10:48:01 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id n17sm3399021ilq.13.2020.06.12.10.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 10:48:01 -0700 (PDT)
Received: (nullmailer pid 3462082 invoked by uid 1000);
        Fri, 12 Jun 2020 17:48:00 -0000
Date:   Fri, 12 Jun 2020 11:48:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Subject: [GIT PULL] Devicetree fixes for v5.8-rc
Message-ID: <20200612174800.GA3459802@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull a few DT fixes for v5.8-rc.

Rob

The following changes since commit 2dca74a40e1e7ff45079d85fc507769383039b9d:

  Merge tag 'mailbox-v5.8' of git://git.linaro.org/landing-teams/working/fujitsu/integration (2020-06-11 12:42:14 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.8-1

for you to fetch changes up to 8440d4a75d90556cfb8fb3e244443f67381aafd6:

  Merge branch 'dt/schema-cleanups' into dt/linus (2020-06-12 09:57:00 -0600)

----------------------------------------------------------------
Devicetree fixes for v5.8:

- Another round of whack-a-mole removing 'allOf', redundant cases of
  'maxItems' and incorrect 'reg' sizes

- Fix support for yaml.h in non-standard paths

----------------------------------------------------------------
Masahiro Yamada (1):
      scripts/dtc: use pkg-config to include <yaml.h> in non-standard path

Rob Herring (5):
      dt-bindings: Remove more cases of 'allOf' containing a '$ref'
      dt-bindings: phy: qcom: Fix missing 'ranges' and example addresses
      dt-bindings: Fix more incorrect 'reg' property sizes in examples
      dt-bindings: Remove redundant 'maxItems'
      Merge branch 'dt/schema-cleanups' into dt/linus

 .../bindings/arm/tegra/nvidia,tegra20-pmc.yaml     |   5 +-
 .../devicetree/bindings/ata/sata_highbank.yaml     |  21 +-
 .../devicetree/bindings/bus/baikal,bt1-apb.yaml    |   4 +-
 .../devicetree/bindings/bus/baikal,bt1-axi.yaml    |   4 +-
 .../devicetree/bindings/clock/imx6q-clock.yaml     |   1 -
 .../devicetree/bindings/clock/imx6sl-clock.yaml    |   1 -
 .../devicetree/bindings/clock/imx6sll-clock.yaml   |   1 -
 .../devicetree/bindings/clock/imx6sx-clock.yaml    |   1 -
 .../devicetree/bindings/clock/imx6ul-clock.yaml    |   1 -
 .../bindings/display/rockchip/rockchip-vop.yaml    |   4 +-
 .../devicetree/bindings/gpio/snps,dw-apb-gpio.yaml |   7 +-
 .../devicetree/bindings/iio/imu/adi,adis16475.yaml |   3 +-
 .../bindings/iio/light/amstaos,tsl2563.yaml        |   5 +-
 .../devicetree/bindings/input/iqs269a.yaml         | 222 +++++++++------------
 .../interrupt-controller/loongson,pch-msi.yaml     |  14 +-
 .../interrupt-controller/loongson,pch-pic.yaml     |   7 +-
 .../devicetree/bindings/ipmi/ipmi-smic.yaml        |  10 +-
 .../bindings/leds/backlight/qcom-wled.yaml         |  43 ++--
 .../devicetree/bindings/leds/leds-aw2013.yaml      |   3 +-
 .../devicetree/bindings/leds/leds-sgm3140.yaml     |   3 +-
 .../devicetree/bindings/mailbox/sprd-mailbox.yaml  |   2 +-
 .../devicetree/bindings/media/i2c/ov8856.yaml      |   3 +-
 .../devicetree/bindings/media/rockchip,vdec.yaml   |   2 +-
 .../devicetree/bindings/media/rockchip-vpu.yaml    |   2 +-
 .../bindings/memory-controllers/ingenic,nemc.yaml  |   5 +-
 .../bindings/mtd/arasan,nand-controller.yaml       |   2 +-
 .../bindings/net/ti,k3-am654-cpsw-nuss.yaml        |   3 +-
 .../devicetree/bindings/net/ti,k3-am654-cpts.yaml  |   8 +-
 .../devicetree/bindings/pci/cdns-pcie-ep.yaml      |   3 +-
 .../devicetree/bindings/pci/cdns-pcie-host.yaml    |   3 +-
 .../devicetree/bindings/phy/calxeda-combophy.yaml  |   5 +-
 .../devicetree/bindings/phy/qcom,qmp-phy.yaml      |  20 +-
 .../bindings/phy/qcom,qmp-usb3-dp-phy.yaml         |  38 ++--
 .../bindings/phy/qcom,usb-snps-femto-v2.yaml       |   2 +-
 .../devicetree/bindings/phy/renesas,usb3-phy.yaml  |   5 +-
 .../bindings/power/supply/cw2015_battery.yaml      |  15 +-
 .../bindings/power/supply/sbs,sbs-battery.yaml     |   6 +-
 Documentation/devicetree/bindings/pwm/imx-pwm.yaml |   2 -
 .../bindings/regulator/maxim,max77826.yaml         |   9 +-
 .../bindings/regulator/rohm,bd71847-regulator.yaml |  27 +--
 .../devicetree/bindings/rng/arm-cctrng.yaml        |   6 +-
 .../devicetree/bindings/serial/samsung_uart.yaml   |   5 +-
 .../devicetree/bindings/soc/qcom/qcom,geni-se.yaml |   9 +-
 .../devicetree/bindings/sound/fsl,easrc.yaml       |  21 +-
 .../devicetree/bindings/sound/simple-card.yaml     |  10 +-
 .../devicetree/bindings/sound/tlv320adcx140.yaml   |  26 ++-
 .../thermal/socionext,uniphier-thermal.yaml        |   5 +-
 .../devicetree/bindings/usb/aspeed,usb-vhub.yaml   |  24 +--
 .../devicetree/bindings/usb/nvidia,tegra-xudc.yaml |   2 -
 .../devicetree/bindings/watchdog/arm-smc-wdt.yaml  |   3 +-
 scripts/dtc/Makefile                               |   3 +
 51 files changed, 273 insertions(+), 363 deletions(-)
