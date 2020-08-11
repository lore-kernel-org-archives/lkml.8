Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A26FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 07:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2513A205CB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 07:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UvJk0g2Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbgHKHqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 03:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727852AbgHKHql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 03:46:41 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6BABC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 00:46:40 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id y3so10519123wrl.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 00:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=GE+D9uLz+XrrTLtXxxjJqcAXrsdrJmY2lA6CgtrYBRs=;
        b=UvJk0g2QFq7meShwzplGYRHHUzEs6U4GIQ22JR5x/CxLqLdX30JG8gyWApKFDuM9de
         9TmGs3+MCjwSvyPCJ3+KSg8oIwVD99XzEeGqDuWW4lC4dzeBdsDFafgJrQOOuHsYYoK+
         lOueXVwNiaVQQpKsmgkIr780JqatyWxBZQKrp+4XFjGqIeSne2VEx+mb7tWYWUNfwvnY
         mf19+q44434zve6Ycikfn5hrbyJ1KQ3SVjvouIDxoc6bAzWgwbjLBdhABOwzflflGAlz
         1Pnn4VyDk4GHeifPPPRcGsAXGLDjB4N9zb7f61vbRPvqGmexEDjG3olNkl6FOs9HFIGr
         FmtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=GE+D9uLz+XrrTLtXxxjJqcAXrsdrJmY2lA6CgtrYBRs=;
        b=bSQF+WbPlFFXtZSU6ucHwQPt1T+x3VHyQKLs3Dc6FXlsDnWbH3DDzGLRh+9/ryvfMx
         W+Y9pOEhquiYNhFPCw8Gz0N2DVc+7+TjwQ1p/dCJ4RVJGxCMsFZxV/ye9ak8u9s9puug
         ItM7wSEkj6b+vrqgrfxE5PHvVpR1bEcRhK05WoGUvwMzJ6cT/Jl1M/b8B7C7DAdmKWUf
         EU0CTo6okg6VtGkqStKr9iuvLHDcvg6rLPjv9O3V07ReGpcqkqC2mwzmbWYa4jxQHQ59
         I3eSOZt/F8HLJFwX5gO0yb33qJ0l8jqfg7P3ioZGsXRtAui4lgkGzRVj9i4w0qrIxUMd
         d0dg==
X-Gm-Message-State: AOAM533rX2/64GJCLiWOPPD3r9Iw6s3QFElMQ6xkj82ktsrXZpznxZ4a
        SkC8IrdBwlV1d85cq8zNPzOv2FchFG4=
X-Google-Smtp-Source: ABdhPJzhslgbpWe6ZYnL4QEslIAweBfh3E1FAJ2Fx9zG0yPs5qk8bao1gIRmFi04DXeZJdqUDFvkHA==
X-Received: by 2002:adf:9342:: with SMTP id 60mr29668539wro.143.1597131999305;
        Tue, 11 Aug 2020 00:46:39 -0700 (PDT)
Received: from dell ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id y24sm3620092wmi.17.2020.08.11.00.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 00:46:38 -0700 (PDT)
Date:   Tue, 11 Aug 2020 08:46:37 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: MFD for v5.9
Message-ID: <20200811074637.GG4411@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning Linus,

Enjoy!

The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git mfd-next-5.9

for you to fetch changes up to ee849ff1fd31f761fc65af04f2649a37e769ceab:

  mfd: core: Fix memory leak of 'cell' (2020-08-10 12:27:30 +0100)

----------------------------------------------------------------
 - Core Frameworks
   - Make better attempt at matching device with the correct OF node
   - Allow batch removal of hierarchical sub-devices

 - New Drivers
   - Add STM32 Clocksource driver
   - Add support for Khadas System Control Microcontroller

 - Driver Removal
   - Remove unused driver for TI's SMSC ECE1099

 - New Device Support
   - Add support for Intel Emmitsburg PCH to Intel LPSS PCI
   - Add support for Intel Tiger Lake PCH-H to Intel LPSS PCI
   - Add support for Dialog DA revision to Dialog DA9063

 - New Functionality
   - Add support for AXP803 to be probed by I2C

 - Fix-ups
   - Numerous W=1 warning fixes
   - Device Tree changes; stm32-lptimer, gateworks-gsc, khadas,mcu, stmfx, cros-ec, j721e-system-controller
   - Enabled Regmap 'fast I/O'; stm32-lptimer
   - Change BUG_ON to WARN_ON; arizona-core
   - Remove superfluous code/initialisation; madera, max14577
   - Trivial formatting/spelling issues; madera-core, madera-i2c, da9055, max77693-private
   - Switch to of_platform_populate(); sprd-sc27xx-spi
   - Expand out set/get brightness/pwm macros; lm3533-ctrlbank
   - Disable IRQs on suspend; motorola-cpcap
   - Clean-up error handling; intel_soc_pmic_mrfld
   - Ensure correct removal order of sub-devices; madera
   - Many s/HTTP/HTTPS/ link changes
   - Ensure name used with Regmap is unique; syscon

 - Bug Fixes
   - Properly 'put' clock on unbind and error; arizona-core
   - Fix revision handling; da9063
   - Fix 'assignment of read-only location' error; kempld-core
   - Avoid using the Regmap API when atomic; rn5t618
   - Redefine volatile register description; rn5t618
   - Use locking to protect event handler; dln2

----------------------------------------------------------------
Adam Thomson (2):
      mfd: da9063: Fix revision handling to correctly select reg tables
      mfd: da9063: Add support for latest DA silicon revision

Alexander A. Klimov (1):
      mfd: Replace HTTP links with HTTPS ones

Andreas Kemnade (2):
      mfd: rn5t618: Make restart handler atomic safe
      mfd: rn5t618: Fix caching of battery related registers

Andy Shevchenko (3):
      mfd: intel-lpss: Add Intel Emmitsburg PCH PCI IDs
      mfd: intel-lpss: Add Intel Tiger Lake PCH-H PCI IDs
      mfd: dln2: Run event handler loop under spinlock

Benjamin Gaignard (5):
      dt-bindings: mfd: Document STM32 low power timer bindings
      mfd: stm32: Add defines to be used for clkevent purpose
      mfd: stm32: Enable regmap fast_io for stm32-lptimer
      clocksource: Add Low Power STM32 timers driver
      dt-bindings: mfd: Convert stmfx bindings to json-schema

Charles Keepax (6):
      mfd: arizona: Remove BUG_ON usage
      mfd: arizona: Ensure 32k clock is put on driver unbind and error
      mfd: madera: Remove unused forward declaration of madera_codec_pdata
      mfd: madera: Fix minor formatting issues
      mfd: mfd-core: Add mechanism for removal of a subset of children
      mfd: madera: Improve handling of regulator unbinding

Chunyan Zhang (1):
      mfd: sprd: Populate sub-devices defined in DT

Colin Ian King (1):
      mfd: max14577: Remove redundant initialization of variable current_bits

Fabio Estevam (2):
      dt-bindings: mfd: st,stmfx: Remove extra additionalProperties
      dt-bindings: mfd: st,stmfx: Remove I2C unit name

Frank Lee (1):
      mfd: axp20x: Allow the AXP803 to be probed by I2C

Ikjoon Jang (1):
      dt-bindings: mfd: Convert ChromeOS EC bindings to json-schema

Johan Hovold (1):
      mfd: lm3533: Expand control-bank accessors

Lee Jones (37):
      mfd: twl4030-irq: Fix incorrect type in assignment warning
      mfd: twl4030-irq: Fix cast to restricted __le32 warning
      mfd: tps6586x: Fix cast to restricted __le32 warning
      mfd: altera-sysmgr: Fix physical address storing hacks
      mfd: sprd-sc27xx-spi: Fix symbol 'sprd_pmic_detect_charger_type' was not declared warning
      mfd: ab3100-core: Fix incompatible types in comparison expression warning
      mfd: ab8500-debugfs: Fix incompatible types in comparison expression issue
      mfd: tc3589x: Remove invalid use of kerneldoc syntax
      mfd: wm8400-core: Supply description for wm8400_reset_codec_reg_cache's arg
      mfd: wm831x-core: Supply description wm831x_reg_{un}lock args
      mfd: wm8350-core: Supply description wm8350_reg_{un}lock args
      mfd: mfd-core: Complete kerneldoc header for devm_mfd_add_devices()
      mfd: db8500-prcmu: Add description for 'reset_reason' in kerneldoc
      mfd: db8500-prcmu: Remove incorrect function header from .probe() function
      mfd: omap-usb-host: Remove invalid use of kerneldoc syntax
      mfd: omap-usb-host: Provide description for 'pdev' argument to .probe()
      mfd: omap-usb-tll: Provide description for 'pdev' argument to .probe()
      mfd: atmel-smc: Add missing colon(s) for 'conf' arguments
      mfd: altera-sysmgr: Supply descriptions for 'np' and 'property' function args
      mfd: cros_ec_dev: Fix cros_feature_to_{name,cells} struct descriptions
      mfd: tps65218: Repair incorrect function argument name 's/tps65218/tps/'
      mfd: tps65217: Repair incorrect function argument name 's/tps65217/tps/'
      mfd: ab3100-otp: Add missing colon(s) for all documented kerneldoc arguments
      mfd: tps65010: Remove delcared and set, but never used variable 'status'
      mfd: si476x-cmd: Repair wrongly described function argument 's/response/resp'
      mfd: si476x-cmd: Add missing colon(s) for all documented kerneldoc arguments
      mfd: si476x-i2c: Add description for si476x_core_fwver_to_revision()'s arg 'func'
      mfd: si476x-i2c: Fix spelling mistake in case() statement's FALLTHROUGH comment
      mfd: si476x-cmd: Update si476x_cmd_am_rsq_status()'s kerneldoc
      mfd: si476x-cmd: Add missing documentation for si476x_cmd_fm_rds_status()'s arg 'report'
      mfd: rave-sp: Fix mistake in 'struct rave_sp_deframer's kerneldoc
      mfd: sprd-sc27xx-spi: Fix-up bogus IRQ register offset and mask setting
      mfd: axp20x-i2c: Do not define 'struct acpi_device_id' when !CONFIG_ACPI
      mfd: core: Make a best effort attempt to match devices with the correct of_nodes
      mfd: core: Fix formatting of MFD helpers
      mfd: core: Add OF_MFD_CELL_REG() helper
      mfd: core: Fix memory leak of 'cell'

Matti Vaittinen (1):
      MAINTAINERS: Add entry for ROHM Power Management ICs

Michael Walle (1):
      mfd: smsc-ece1099: Remove driver

Neil Armstrong (4):
      dt-bindings: mfd: Add Khadas Microcontroller bindings
      mfd: Add support for the Khadas System control Microcontroller
      thermal: Add support for the MCU controlled FAN on Khadas boards
      MAINTAINERS: Add myself as maintainer for Khadas MCU drivers

Randy Dunlap (2):
      mfd: da9055: pdata.h: Drop a duplicated word
      mfd: max77693-private: Drop a duplicated word

Roger Quadros (1):
      dt-bindings: mfd: ti,j721e-system-controller.yaml: Add J721e system controller

Stephen Rothwell (1):
      mfd: kempld-core: Fix 'assignment of read-only location' error

Suman Anna (1):
      mfd: syscon: Use a unique name with regmap_config

Tim Harvey (1):
      dt-bindings: mfd: gateworks-gsc: Add 16bit pre-scaled voltage mode

Tony Lindgren (1):
      mfd: motorola-cpcap: Disable interrupt for suspend

Xu Wang (1):
      mfd: intel_soc_pmic_mrfld: Simplify the return expression of intel_scu_ipc_dev_iowrite8()

 Documentation/devicetree/bindings/mfd/cros-ec.txt  |  76 ------
 .../devicetree/bindings/mfd/gateworks-gsc.yaml     |   5 +-
 .../devicetree/bindings/mfd/google,cros-ec.yaml    | 129 ++++++++++
 .../devicetree/bindings/mfd/khadas,mcu.yaml        |  44 ++++
 .../devicetree/bindings/mfd/st,stm32-lptimer.yaml  |   5 +
 .../devicetree/bindings/mfd/st,stmfx.yaml          | 122 ++++++++++
 Documentation/devicetree/bindings/mfd/stmfx.txt    |  28 ---
 .../bindings/mfd/ti,j721e-system-controller.yaml   |  74 ++++++
 .../devicetree/bindings/mfd/twl-family.txt         |   2 +-
 .../devicetree/bindings/pinctrl/pinctrl-stmfx.txt  | 116 ---------
 Documentation/driver-api/index.rst                 |   1 -
 Documentation/driver-api/smsc_ece1099.rst          |  60 -----
 MAINTAINERS                                        |  41 ++++
 drivers/clocksource/Kconfig                        |   4 +
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/timer-stm32-lp.c               | 221 +++++++++++++++++
 drivers/mfd/Kconfig                                |  33 ++-
 drivers/mfd/Makefile                               |   2 +-
 drivers/mfd/ab3100-core.c                          |   2 +-
 drivers/mfd/ab3100-otp.c                           |  20 +-
 drivers/mfd/ab8500-debugfs.c                       |   2 +-
 drivers/mfd/altera-sysmgr.c                        |  19 +-
 drivers/mfd/arizona-core.c                         |  20 +-
 drivers/mfd/atmel-smc.c                            |   4 +-
 drivers/mfd/axp20x-i2c.c                           |   4 +
 drivers/mfd/cros_ec_dev.c                          |   4 +-
 drivers/mfd/da9063-core.c                          |  31 ---
 drivers/mfd/da9063-i2c.c                           | 271 +++++++++++++++++++--
 drivers/mfd/db8500-prcmu.c                         |   6 +-
 drivers/mfd/dln2.c                                 |   4 +
 drivers/mfd/hi6421-pmic-core.c                     |   2 +-
 drivers/mfd/intel-lpss-pci.c                       |  19 ++
 drivers/mfd/intel_soc_pmic_mrfld.c                 |   7 +-
 drivers/mfd/kempld-core.c                          |  30 +--
 drivers/mfd/khadas-mcu.c                           | 142 +++++++++++
 drivers/mfd/lm3533-ctrlbank.c                      |  94 ++++---
 drivers/mfd/lp873x.c                               |   2 +-
 drivers/mfd/lp87565.c                              |   2 +-
 drivers/mfd/madera-core.c                          |  33 ++-
 drivers/mfd/madera-i2c.c                           |   1 -
 drivers/mfd/max14577.c                             |   2 +-
 drivers/mfd/mfd-core.c                             | 123 +++++++++-
 drivers/mfd/motorola-cpcap.c                       |  23 ++
 drivers/mfd/omap-usb-host.c                        |   6 +-
 drivers/mfd/omap-usb-tll.c                         |   4 +-
 drivers/mfd/rave-sp.c                              |   2 +-
 drivers/mfd/rn5t618.c                              |  46 +++-
 drivers/mfd/si476x-cmd.c                           |  74 +++---
 drivers/mfd/si476x-i2c.c                           |   7 +-
 drivers/mfd/smsc-ece1099.c                         |  87 -------
 drivers/mfd/sprd-sc27xx-spi.c                      |  82 +------
 drivers/mfd/stm32-lptimer.c                        |   1 +
 drivers/mfd/syscon.c                               |   4 +-
 drivers/mfd/tc3589x.c                              |   2 +-
 drivers/mfd/ti_am335x_tscadc.c                     |   2 +-
 drivers/mfd/tps65010.c                             |   5 +-
 drivers/mfd/tps65086.c                             |   2 +-
 drivers/mfd/tps65217.c                             |   6 +-
 drivers/mfd/tps65218.c                             |   6 +-
 drivers/mfd/tps6586x.c                             |   7 +-
 drivers/mfd/tps65912-core.c                        |   2 +-
 drivers/mfd/tps65912-i2c.c                         |   2 +-
 drivers/mfd/tps65912-spi.c                         |   2 +-
 drivers/mfd/twl4030-irq.c                          |   4 +-
 drivers/mfd/wm831x-core.c                          |   4 +
 drivers/mfd/wm8350-core.c                          |   4 +
 drivers/mfd/wm8400-core.c                          |   2 +
 drivers/thermal/Kconfig                            |  11 +
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/khadas_mcu_fan.c                   | 162 ++++++++++++
 include/linux/mfd/core.h                           |  42 +++-
 include/linux/mfd/da9055/pdata.h                   |   2 +-
 include/linux/mfd/da9063/core.h                    |   1 +
 include/linux/mfd/da9063/registers.h               |  15 +-
 include/linux/mfd/hi6421-pmic.h                    |   2 +-
 include/linux/mfd/khadas-mcu.h                     |  91 +++++++
 include/linux/mfd/lp873x.h                         |   2 +-
 include/linux/mfd/lp87565.h                        |   2 +-
 include/linux/mfd/madera/pdata.h                   |   1 -
 include/linux/mfd/max77693-private.h               |   2 +-
 include/linux/mfd/smsc.h                           | 104 --------
 include/linux/mfd/stm32-lptimer.h                  |   5 +
 include/linux/mfd/ti_am335x_tscadc.h               |   2 +-
 include/linux/mfd/tps65086.h                       |   2 +-
 include/linux/mfd/tps65217.h                       |   2 +-
 include/linux/mfd/tps65218.h                       |   2 +-
 include/linux/mfd/tps65912.h                       |   2 +-
 87 files changed, 1801 insertions(+), 846 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mfd/cros-ec.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/khadas,mcu.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/st,stmfx.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/stmfx.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
 delete mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-stmfx.txt
 delete mode 100644 Documentation/driver-api/smsc_ece1099.rst
 create mode 100644 drivers/clocksource/timer-stm32-lp.c
 create mode 100644 drivers/mfd/khadas-mcu.c
 delete mode 100644 drivers/mfd/smsc-ece1099.c
 create mode 100644 drivers/thermal/khadas_mcu_fan.c
 create mode 100644 include/linux/mfd/khadas-mcu.h
 delete mode 100644 include/linux/mfd/smsc.h

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
