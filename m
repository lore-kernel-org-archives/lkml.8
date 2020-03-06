Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33807C10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 21:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0340120709
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 21:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583530813;
	bh=EZROZ9FsTsm7YeD05Jo4rsONkCEMo69qS9i0hbmHAyo=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=UzatlOJ/ef/132y4H5myL+NCSWcKDePcaXyecuxqLhSs1Q9aoKDT0JQTM+wKl9ELl
	 C1B2bT1SreqTPjM1OT/ePGxafyEbo2K+CaekDJEmNWvMAcK1EKAUHLI+KPYFJZbYx9
	 3ulzhDbQEUlHdXqIalHiVslYRpPHbiXYIZO5/+H8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgCFVkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 16:40:11 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41555 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgCFVkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 16:40:11 -0500
Received: by mail-ot1-f66.google.com with SMTP id v19so3914107ote.8;
        Fri, 06 Mar 2020 13:40:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=OOBnvG6kzhfAdxI3pcV1+f+VAcb0QCUBOlTZAz/5NjA=;
        b=e2ZNv7AWcaDyHQURXQJQ0MLqaovhCP/sK0t5YvD/MALsj4lFV4KelRWkE9TppJTyJe
         MtljnNMfeqAD3eRvEf54DWmBYMMA6fjHaVg2gUkhpLca1sjtaXAzxoX+5T9ixzE5sB8F
         4eiEXXcBUTsTsK+WKZbODwz9WJnwgWiYV9Vs0tEs5axtDF6cESNZ4PEH0b01KsDEoJEF
         SGN7EvigYJ9qEN6dXoUjFMCpgjNzBWAL/kSnkcYDh8KTxzAKKEb/LcP1d9krDI7MPDbL
         jsuDz789D+x4ZwPyT8gEHtzV833+2BfRWhalw54OfOBkruoBzahDDf8R9RGbOWG5UW4R
         oSUg==
X-Gm-Message-State: ANhLgQ0icW+Hum7yP2N3bOsjxrJHxq7jKKlNoAg1rulFcMwaL2d72c86
        emEyGt6itLZy3JMXr24MuA==
X-Google-Smtp-Source: ADFU+vveo27N46sHVUg1Z+Of33BGswz48sE1ZjlAi5CETETbhLQDbA4hSpvNpaaxswOiTeRxIijpJw==
X-Received: by 2002:a9d:c69:: with SMTP id 96mr4377083otr.129.1583530809949;
        Fri, 06 Mar 2020 13:40:09 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d9sm4704839otl.50.2020.03.06.13.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 13:40:08 -0800 (PST)
Received: (nullmailer pid 29659 invoked by uid 1000);
        Fri, 06 Mar 2020 21:40:07 -0000
Date:   Fri, 6 Mar 2020 15:40:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Subject: [GIT PULL] Devicetree fixes for v5.6, take 3
Message-ID: <20200306214007.GA23564@bogus>
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

Another batch of DT fixes. I think this should be the last of it, but 
sending PRs seems to cause people to send more fixes.

Rob


The following changes since commit 854bdbae9058bcf09b0add70b6047bc9ca776de2:

  dt-bindings: media: csi: Fix clocks description (2020-02-19 19:03:44 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.6-3

for you to fetch changes up to d2334a91a3b01dce4f290b4536fcfa4b9e923a3d:

  dt-bindings: arm: Fixup the DT bindings for hierarchical PSCI states (2020-03-06 12:12:21 -0600)

----------------------------------------------------------------
Devicetree fixes for v5.6, take 3:

- Fixes for warnings introduced by hierarchical PSCI binding changes

- Fixes for broken doc references due to DT schema conversions

- Several grammar and typo fixes

- Fix a bunch of dtc warnings in examples

----------------------------------------------------------------
Jonathan Neuschäfer (3):
      dt-bindings: mfd: zii,rave-sp: Fix a typo ("onborad")
      dt-bindings: mfd: tps65910: Improve grammar
      dt-bindings: mfd: Fix typo in file name of twl-familly.txt

Lukas Bulwahn (2):
      MAINTAINERS: clean up PCIE DRIVER FOR CAVIUM THUNDERX
      MAINTAINERS: update ALLWINNER CPUFREQ DRIVER entry

Mauro Carvalho Chehab (2):
      docs: dt: fix several broken references due to renames
      docs: dt: fix several broken doc references

Rob Herring (2):
      dt-bindings: Fix dtc warnings in examples
      dt-bindings: bus: Drop empty compatible string in example

Sébastien Szymanski (1):
      dt-bindings: arm: fsl: fix APF6Dev compatible

Ulf Hansson (5):
      dt-bindings: arm: Correct links to idle states definitions
      dt-bindings: arm: Fix cpu compatibles in the hierarchical example for PSCI
      dt-bindings: power: Convert domain-idle-states bindings to json-schema
      dt-bindings: power: Extend nodename pattern for power-domain providers
      dt-bindings: arm: Fixup the DT bindings for hierarchical PSCI states

 Documentation/devicetree/bindings/arm/arm,scmi.txt |  2 +-
 Documentation/devicetree/bindings/arm/arm,scpi.txt |  2 +-
 .../devicetree/bindings/arm/bcm/brcm,bcm63138.txt  |  2 +-
 Documentation/devicetree/bindings/arm/cpus.yaml    |  2 +-
 Documentation/devicetree/bindings/arm/fsl.yaml     |  2 +-
 .../bindings/arm/hisilicon/hi3519-sysctrl.txt      |  2 +-
 .../bindings/arm/msm/qcom,idle-state.txt           |  2 +-
 Documentation/devicetree/bindings/arm/omap/mpu.txt |  2 +-
 Documentation/devicetree/bindings/arm/psci.yaml    | 36 ++++++------
 .../devicetree/bindings/arm/stm32/st,mlahb.yaml    |  2 +-
 .../bindings/bus/allwinner,sun8i-a23-rsb.yaml      |  1 -
 .../clock/allwinner,sun4i-a10-osc-clk.yaml         |  2 +-
 .../bindings/clock/allwinner,sun9i-a80-gt-clk.yaml |  2 +-
 .../bindings/clock/qcom,gcc-apq8064.yaml           |  2 +-
 .../display/allwinner,sun4i-a10-tv-encoder.yaml    |  6 +-
 .../bindings/display/bridge/anx6345.yaml           | 10 +---
 .../display/panel/leadtek,ltk500hd1829.yaml        |  2 +
 .../bindings/display/panel/xinpeng,xpp055c272.yaml |  2 +
 .../bindings/display/simple-framebuffer.yaml       |  6 +-
 .../devicetree/bindings/display/tilcdc/tilcdc.txt  |  2 +-
 .../devicetree/bindings/dma/ti/k3-udma.yaml        | 14 +----
 .../devicetree/bindings/gpu/arm,mali-bifrost.yaml  | 14 ++---
 .../devicetree/bindings/gpu/arm,mali-midgard.yaml  | 14 ++---
 .../bindings/iio/adc/samsung,exynos-adc.yaml       |  2 +-
 .../bindings/input/touchscreen/goodix.yaml         |  2 +-
 .../bindings/input/twl4030-pwrbutton.txt           |  2 +-
 Documentation/devicetree/bindings/leds/common.yaml |  2 +-
 .../devicetree/bindings/leds/register-bit-led.txt  |  2 +-
 .../devicetree/bindings/media/ti,cal.yaml          |  2 +-
 .../bindings/memory-controllers/ti/emif.txt        |  2 +-
 .../devicetree/bindings/mfd/max77650.yaml          |  4 +-
 Documentation/devicetree/bindings/mfd/tps65910.txt |  4 +-
 .../mfd/{twl-familly.txt => twl-family.txt}        |  0
 .../devicetree/bindings/mfd/zii,rave-sp.txt        |  2 +-
 .../devicetree/bindings/misc/fsl,qoriq-mc.txt      |  2 +-
 .../devicetree/bindings/mmc/mmc-controller.yaml    |  1 +
 .../bindings/mtd/cadence-nand-controller.txt       |  2 +-
 .../bindings/net/brcm,bcm7445-switch-v4.0.txt      |  2 +-
 Documentation/devicetree/bindings/nvmem/nvmem.yaml |  2 +
 .../bindings/phy/allwinner,sun4i-a10-usb-phy.yaml  |  2 +-
 .../bindings/pinctrl/aspeed,ast2400-pinctrl.yaml   |  2 +-
 .../bindings/pinctrl/aspeed,ast2500-pinctrl.yaml   |  2 +-
 .../bindings/pinctrl/aspeed,ast2600-pinctrl.yaml   |  2 +-
 .../bindings/pinctrl/st,stm32-pinctrl.yaml         |  2 +-
 .../bindings/power/amlogic,meson-ee-pwrc.yaml      |  2 +-
 .../bindings/power/domain-idle-state.txt           | 33 -----------
 .../bindings/power/domain-idle-state.yaml          | 64 ++++++++++++++++++++++
 .../devicetree/bindings/power/power-domain.yaml    | 24 ++++----
 .../devicetree/bindings/power/power_domain.txt     |  2 +-
 .../devicetree/bindings/regulator/regulator.yaml   |  2 +-
 .../devicetree/bindings/reset/st,stm32mp1-rcc.txt  |  2 +-
 .../devicetree/bindings/sound/st,stm32-sai.txt     |  2 +-
 .../devicetree/bindings/sound/st,stm32-spdifrx.txt |  2 +-
 .../devicetree/bindings/spi/st,stm32-spi.yaml      |  2 +-
 .../sram/allwinner,sun4i-a10-system-control.yaml   |  2 +-
 .../bindings/thermal/brcm,avs-ro-thermal.yaml      |  2 +-
 .../bindings/timer/allwinner,sun4i-a10-timer.yaml  |  2 +-
 MAINTAINERS                                        | 15 +++--
 .../bindings/net/wireless/siliabs,wfx.txt          |  2 +-
 59 files changed, 169 insertions(+), 163 deletions(-)
 rename Documentation/devicetree/bindings/mfd/{twl-familly.txt => twl-family.txt} (100%)
 delete mode 100644 Documentation/devicetree/bindings/power/domain-idle-state.txt
 create mode 100644 Documentation/devicetree/bindings/power/domain-idle-state.yaml
