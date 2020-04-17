Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2526C352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 16:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8B9520771
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 16:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587139814;
	bh=z9zZIiihBm9SCrbwX4CrR7nO+1x0aofYXpCKPneYiR0=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=kwTFgwyz5EPROUE6WHDsopYr1ZMg7JrAOB8mRSmi5j1Mr4t9OI5ztHHmCoa4n9zVA
	 aqbLMLn46iNCSIzh0GGfapw6tikR8+LAYB37fKYpjyvF07XZ6MWOnDLLaGr2ok9QiZ
	 D1hI6S3q6nTqAMWqsECBn9mZUmZKzjPjQF+h9/6k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbgDQQKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 12:10:14 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42893 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729282AbgDQQKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 12:10:13 -0400
Received: by mail-oi1-f195.google.com with SMTP id d7so2496182oif.9;
        Fri, 17 Apr 2020 09:10:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Z7Icz3q5Y10NxdDT78V7SC0TdioikLrX59l8qGxJLVI=;
        b=R0v1A16M0D8vz/xxWlhlUYXo/ULe46F+Nq4K6U2rYnoMZPc+munV3Diiy9UZ5WdSGA
         5npecKPykCsS+L31QTtv3wdPRjnffsn1/4hfoD25WiHPiBs/eBUoFK68Ohxx/0DCCPiO
         zRD7gUWcfR73pJ71uNVvW2t88b8tHe6OS3uxiN5h3IHyKAsZ4v+SKgIG94AdUM5i65Q5
         M/6aNfccD7KMNiHRs8lBKviDZsayR7+E6Q4k/jOq+M5QlK7Zn1eTIR+oJuuD/3mQVdAG
         +wxhvDET4LlgLigEqckn9Or8IIlxm63bWFYzxAm1Etsc1aOsSbdrsIwZsd45zWhU7J1P
         CnJg==
X-Gm-Message-State: AGi0PuYezjygXTJcD/gmF2Qn3jDiUa4QKsKAhtI17jceMor4YZdbTz1Z
        ZXZFxLMbEQ2JVeZLCpZDYAgVcxE=
X-Google-Smtp-Source: APiQypLvRrO5P+cGBhbb4JDON5qfotnufzYAKhlxzKY8nGO1wnQN6jQfgltGn4XoBQVXPiNyxr7O8Q==
X-Received: by 2002:aca:3106:: with SMTP id x6mr2555696oix.94.1587139811949;
        Fri, 17 Apr 2020 09:10:11 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d84sm8071869oig.33.2020.04.17.09.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 09:10:11 -0700 (PDT)
Received: (nullmailer pid 16011 invoked by uid 1000);
        Fri, 17 Apr 2020 16:10:10 -0000
Date:   Fri, 17 Apr 2020 11:10:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Subject: [GIT PULL] Devicetree fixes for v5.7, take 1
Message-ID: <20200417161010.GA14296@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull.

Rob


The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.7

for you to fetch changes up to 0903060fe590105b7d31901c1ed67614c08cee08:

  kbuild: check libyaml installation for 'make dt_binding_check' (2020-04-17 10:45:23 -0500)

----------------------------------------------------------------
Devicetree fixes for v5.7:

- Fix warnings from enabling more dtc warnings which landed in the merge
  window and didn't get fixed in time.

- Fix some document references from DT schema conversions

- Fix kmemleak errors in DT unittests

----------------------------------------------------------------
Alexandru Tachici (1):
      dt-bindings: iio: dac: AD5570R fix bindings errors

Fabio Estevam (4):
      dt-bindings: iio: dac: ad5770r: Add vendor to compatible string
      dt-bindings: iio: dac: ad5770r: Fix the file path
      dt-bindings: touchscreen: edt-ft5x06: Remove unneeded I2C unit name
      dt-bindings: clock: syscon-icst: Remove unneeded unit name

Frank Rowand (5):
      of: unittest: kmemleak on changeset destroy
      of: unittest: kmemleak in of_unittest_platform_populate()
      of: unittest: kmemleak in of_unittest_overlay_high_level()
      of: overlay: kmemleak in dup_and_fixup_symbol_prop()
      of: unittest: kmemleak in duplicate property update

Geert Uytterhoeven (1):
      dt-bindings: Fix misspellings of "Analog Devices"

Masahiro Yamada (1):
      kbuild: check libyaml installation for 'make dt_binding_check'

Matti Vaittinen (1):
      dt-bindings: BD718x7 - add missing I2C bus properties

Mauro Carvalho Chehab (6):
      docs: dt: fix broken reference to phy-cadence-torrent.yaml
      docs: dt: qcom,dwc3.txt: fix cross-reference for a converted file
      docs: dt: fix a broken reference for a file converted to json
      docs: dt: rockchip,dwc3.txt: fix a pointer to a renamed file
      MAINTAINERS: dt: update display/allwinner file entry
      MAINTAINERS: dt: fix pointers for ARM Integrator, Versatile and RealView

Rob Herring (4):
      dt-bindings: Fix dtc warnings on reg and ranges in examples
      dt-bindings: hwmon: Fix incorrect $id paths
      dt-bindings: interrupt-controller: Fix loongson,parent_int_map property schema
      dt-bindings: pwm: Fix cros-ec-pwm example dtc 'reg' warning

 .../arm/sunxi/allwinner,sun4i-a10-mbus.yaml        |  6 ++
 .../devicetree/bindings/clock/arm,syscon-icst.yaml |  2 +-
 .../bindings/display/bridge/adi,adv7123.txt        |  4 +-
 .../bindings/display/bridge/adi,adv7511.txt        |  4 +-
 .../devicetree/bindings/dma/adi,axi-dmac.txt       |  2 +-
 .../bindings/hwmon/adi,axi-fan-control.yaml        |  4 +-
 .../devicetree/bindings/hwmon/adt7475.yaml         |  2 +-
 .../devicetree/bindings/iio/dac/ad5755.txt         |  2 +-
 .../devicetree/bindings/iio/dac/adi,ad5770r.yaml   | 97 ++++++++++------------
 .../bindings/input/touchscreen/edt-ft5x06.yaml     |  2 +-
 .../interrupt-controller/loongson,liointc.yaml     |  5 +-
 .../memory-controllers/nvidia,tegra186-mc.yaml     | 41 +++++----
 .../devicetree/bindings/mfd/rohm,bd71837-pmic.yaml |  4 +-
 .../devicetree/bindings/mfd/rohm,bd71847-pmic.yaml |  4 +-
 .../devicetree/bindings/mfd/st,stpmic1.yaml        |  2 +-
 .../devicetree/bindings/net/qcom,ipq8064-mdio.yaml |  1 +
 .../devicetree/bindings/net/qualcomm-bluetooth.txt |  2 +-
 .../devicetree/bindings/phy/ti,phy-j721e-wiz.yaml  |  2 +-
 .../bindings/pwm/google,cros-ec-pwm.yaml           | 17 ++--
 .../devicetree/bindings/rng/brcm,bcm2835.yaml      |  2 +-
 .../bindings/spi/qcom,spi-qcom-qspi.yaml           |  2 +-
 .../devicetree/bindings/usb/ingenic,musb.yaml      |  2 +-
 .../devicetree/bindings/usb/qcom,dwc3.txt          |  4 +-
 .../devicetree/bindings/usb/rockchip,dwc3.txt      |  2 +-
 MAINTAINERS                                        |  7 +-
 drivers/of/overlay.c                               |  2 +
 .../of/unittest-data/overlay_bad_add_dup_prop.dts  | 23 ++++-
 drivers/of/unittest.c                              | 28 +++++--
 scripts/dtc/Makefile                               |  2 +-
 29 files changed, 162 insertions(+), 115 deletions(-)
