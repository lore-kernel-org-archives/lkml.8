Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53ACC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 09:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BF4E205CB
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 09:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DbQKUwvI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgFCJDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 05:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgFCJDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 05:03:08 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDF7C05BD43
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 02:03:06 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id l26so1108378wme.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 02:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=TChkWUlqJ3Z76/CF0Z5g9mSQm1q8ByAaQlMhRkDq/cw=;
        b=DbQKUwvI1pkhXZ5bf4Prqn9D9ECSF+++GjiNIm7CFPu/WdX0ohPv1Zf9EVs8qURvsO
         Tql/x1LpRcAhr8I19TfzKEgHpwWvtTttI5O5nPpiiKLkOhjRY1SIjD4/334smsafLRCT
         rBRSwWZD5yeI4t58SvVu2+1qeUYvc2kfZ5MUjEIT/zH2ojS93IvIe8iIMOoHSOSNe2dY
         68ASnU5ezxRgXsi5e4VVkfjEuvyC6h7xI14eSJWXqNrhDll+NLWcGseEfv5QHYsYVS06
         0su93dNA4F64ioP703BukF6HYJYD2hGE9q6ySnfZJmg5DJPvuyzaBnowlQAjDjA5x4pL
         Ld2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=TChkWUlqJ3Z76/CF0Z5g9mSQm1q8ByAaQlMhRkDq/cw=;
        b=A3iYMmSiZai4EfnehDqbjUe9p5F8D5T2yTknigNKwXhD9iQTnFzoDF7aaRq2ohq9tW
         T6wsuKslPnY1alDU1kuNHMUNJKKZx1g6EDnif64hUGatOWmwfUoLXPijQYun9oto8Ou8
         QlfGA5QxSNhvnPL8YMXn88CYnL+HtXKQJoOpRk6CzNBzBPM37RPdwkdIa+0g2mSKylsq
         J5eXz2TA0SsCpXL5Fu9HFVUxGqZ9D88qC+3LwGG/0EGH/ed+ov3Q6oD4wv2e96gzQfyI
         0f2DAM2aDquoo4MWHQXo4uio17AXoeoRfMyXJULcPDNlK5C18seOmRYUxsffbFS3Tp/t
         nIVg==
X-Gm-Message-State: AOAM532iAnSdK/REBhKQmK8iDZTJmpuyOLgMXzFFf4kRPY3CnlW8eQV/
        gfyQJ05s1wpIKwIaDoFeMJKhk/cydD0=
X-Google-Smtp-Source: ABdhPJwCGKIwtYjE0Oam84wXEWcybQaVl/cI2EZb7Xx56nuGKtwqMZSCnGUU4olJNuLsGwdZDPzfhQ==
X-Received: by 2002:a1c:9ad8:: with SMTP id c207mr7340467wme.45.1591174985287;
        Wed, 03 Jun 2020 02:03:05 -0700 (PDT)
Received: from dell ([95.147.198.92])
        by smtp.gmail.com with ESMTPSA id j5sm2343023wrm.57.2020.06.03.02.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 02:03:04 -0700 (PDT)
Date:   Wed, 3 Jun 2020 10:03:03 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] MFD for v5.8
Message-ID: <20200603090303.GM3714@dell>
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

The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-next-5.8

for you to fetch changes up to 098c4adf249c198519a4abebe482b1e6b8c50e47:

  mfd: mt6360: Remove duplicate REGMAP_IRQ_REG_LINE() entry (2020-06-01 08:56:44 +0100)

----------------------------------------------------------------
 - Core Frameworks
   - Constify 'properties' attribute in core header file

 - New Drivers
   - Add support for Gateworks System Controller
   - Add support for MediaTek MT6358 PMIC
   - Add support for Mediatek MT6360 PMIC
   - Add support for Monolithic Power Systems MP2629 ADC and Battery charger
   - Rework Intel's SCU IPC collection
     - Eliminate near duplicate IPC functionality
     - Split out MFD related activities into a dedicated MFD driver

 - Fix-ups
   - Use new I2C API; htc-i2cpld
   - Remove superfluous code; sprd-sc27xx-spi
   - Improve error handling; stm32-timers
   - Device Tree additions/fixes; mt6397
   - Defer probe betterment; wm8994-core
   - Improve module handling; wm8994-core
   - Staticify; stpmic1
   - Trivial (spelling, formatting); tqmx86

 - Bug Fixes
   - Fix incorrect register/PCI IDs; intel-lpss-pci
   - Fix unbalanced Regulator API calls; wm8994-core
   - Fix double free(); wcd934x
   - Remove IRQ domain on failure; stmfx
   - Reset chip on resume; stmfx
   - Disable/enable IRQs on suspend/resume; stmfx
   - Do not use bulk writes on H/W which does not support them; max77620

----------------------------------------------------------------
Amelie Delaunay (3):
      mfd: stmfx: Reset chip on resume as supply was disabled
      mfd: stmfx: Fix stmfx_irq_init error path
      mfd: stmfx: Disable IRQ in suspend to avoid spurious interrupt

Andy Shevchenko (1):
      mfd: intel-lpss: Update LPSS UART #2 PCI ID for Jasper Lake

Baolin Wang (1):
      mfd: sprd: Remove unnecessary spi_bus_type setting

Christophe JAILLET (1):
      mfd: tqmx86: Fix a typo in MODULE_DESCRIPTION

Gene Chen (1):
      mfd: Add support for PMIC MT6360

Heikki Krogerus (1):
      usb: typec: mux: Convert the Intel PMC Mux driver to use new SCU IPC API

Hsin-Hsiung Wang (4):
      mfd: mt6397: Modify suspend/resume behavior
      mfd: mt6397: Trim probe function to support different chips more cleanly
      dt-bindings: mfd: Add compatible for the MediaTek MT6358 PMIC
      mfd: Add support for the MediaTek MT6358 PMIC

Lee Jones (2):
      Merge branches 'ib-mfd-x86-usb-watchdog-5.8', 'ib-mfd-power-rtc-5.8', 'ib-mfd-iio-power-5.8' and 'ib-mfd-hwmon-5.8' into ibs-for-mfd-merged
      mfd: mt6360: Remove duplicate REGMAP_IRQ_REG_LINE() entry

Marek Szyprowski (3):
      mfd: wm8994: Fix driver operation if loaded as modules
      mfd: wm8994: Fix unbalanced calls to regulator_bulk_disable()
      mfd: wm8994: Silence warning about supplies during deferred probe

Matthias Brugger (1):
      dt-bindings: mfd: mediatek: Add MT6397 Pin Controller

Mika Westerberg (19):
      platform/x86: intel_scu_ipc: Split out SCU IPC functionality from the SCU driver
      platform/x86: intel_scu_ipc: Log more information if SCU IPC command fails
      platform/x86: intel_scu_ipc: Move legacy SCU IPC API to a separate header
      platform/x86: intel_scu_ipc: Introduce new SCU IPC API
      platform/x86: intel_mid_powerbtn: Convert to use new SCU IPC API
      watchdog: intel-mid_wdt: Convert to use new SCU IPC API
      platform/x86: intel_scu_ipcutil: Convert to use new SCU IPC API
      platform/x86: intel_scu_ipc: Add managed function to register SCU IPC
      platform/x86: intel_pmc_ipc: Start using SCU IPC
      mfd: intel_soc_pmic: Add SCU IPC member to struct intel_soc_pmic
      mfd: intel_soc_pmic_bxtwc: Convert to use new SCU IPC API
      mfd: intel_soc_pmic_mrfld: Convert to use new SCU IPC API
      platform/x86: intel_telemetry: Convert to use new SCU IPC API
      platform/x86: intel_pmc_ipc: Drop intel_pmc_ipc_command()
      x86/platform/intel-mid: Add empty stubs for intel_scu_devices_[create|destroy]()
      platform/x86: intel_pmc_ipc: Move PCI IDs to intel_scu_pcidrv.c
      platform/x86: intel_telemetry: Add telemetry_get_pltdata()
      platform/x86: intel_pmc_ipc: Convert to MFD
      MAINTAINERS: Update entry for Intel Broxton PMC driver

Peter Ujfalusi (1):
      mfd: stm32-timers: Use dma_request_chan() instead dma_request_slave_channel()

Ran Bi (1):
      rtc: mt6397: Add support for the MediaTek MT6358 RTC

Saravanan Sekar (6):
      dt-bindings: mfd: Add document bindings for mp2629
      mfd: mp2629: Add support for mps battery charger
      iio: adc: mp2629: Add support for mp2629 ADC driver
      power: supply: Add support for mps mp2629 battery charger
      power: supply: mp2629: Add impedance compensation config
      MAINTAINERS: Add entry for mp2629 Battery Charger driver

Thierry Reding (1):
      mfd: max77620: Use single-byte writes on MAX77620

Tim Harvey (3):
      dt-bindings: mfd: Add Gateworks System Controller bindings
      mfd: Add Gateworks System Controller core driver
      hwmon: Add Gateworks System Controller support

Tomas Winkler (1):
      mfd: Constify properties in mfd_cell

Wei Yongjun (1):
      mfd: wcd934x: Drop kfree for memory allocated with devm_kzalloc

Wolfram Sang (1):
      mfd: htc-i2cpld: Convert to use i2c_new_client_device()

YueHaibing (1):
      mfd: stpmic1: Make stpmic1_regmap_config static

 .../ABI/obsolete/sysfs-driver-intel_pmc_bxt        |  22 +
 Documentation/ABI/testing/sysfs-class-power-mp2629 |   8 +
 .../devicetree/bindings/mfd/gateworks-gsc.yaml     | 196 +++++
 .../devicetree/bindings/mfd/mps,mp2629.yaml        |  62 ++
 Documentation/devicetree/bindings/mfd/mt6397.txt   |  19 +-
 Documentation/hwmon/gsc-hwmon.rst                  |  53 ++
 Documentation/hwmon/index.rst                      |   1 +
 MAINTAINERS                                        |  39 +-
 arch/x86/Kconfig                                   |   2 +-
 arch/x86/include/asm/intel-mid.h                   |   9 +-
 arch/x86/include/asm/intel_pmc_ipc.h               |  59 --
 arch/x86/include/asm/intel_scu_ipc.h               | 114 +--
 arch/x86/include/asm/intel_scu_ipc_legacy.h        |  91 ++
 arch/x86/include/asm/intel_telemetry.h             |   6 +-
 drivers/hwmon/Kconfig                              |   9 +
 drivers/hwmon/Makefile                             |   1 +
 drivers/hwmon/gsc-hwmon.c                          | 390 +++++++++
 drivers/iio/adc/Kconfig                            |  10 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/mp2629_adc.c                       | 208 +++++
 drivers/mfd/Kconfig                                |  56 +-
 drivers/mfd/Makefile                               |   7 +-
 drivers/mfd/gateworks-gsc.c                        | 277 ++++++
 drivers/mfd/htc-i2cpld.c                           |   6 +-
 drivers/mfd/intel-lpss-pci.c                       |   2 +-
 drivers/mfd/intel_pmc_bxt.c                        | 468 ++++++++++
 drivers/mfd/intel_soc_pmic_bxtwc.c                 |  34 +-
 drivers/mfd/intel_soc_pmic_mrfld.c                 |  10 +-
 drivers/mfd/max77620.c                             |   1 +
 drivers/mfd/mp2629.c                               |  79 ++
 drivers/mfd/mt6358-irq.c                           | 235 +++++
 drivers/mfd/mt6360-core.c                          | 424 +++++++++
 drivers/mfd/mt6397-core.c                          | 101 ++-
 drivers/mfd/mt6397-irq.c                           |  35 +-
 drivers/mfd/sprd-sc27xx-spi.c                      |   1 -
 drivers/mfd/stm32-timers.c                         |  32 +-
 drivers/mfd/stmfx.c                                |  22 +-
 drivers/mfd/stpmic1.c                              |   2 +-
 drivers/mfd/tqmx86.c                               |   2 +-
 drivers/mfd/wcd934x.c                              |   1 -
 drivers/mfd/wm8994-core.c                          |   8 +-
 drivers/platform/x86/Kconfig                       |  46 +-
 drivers/platform/x86/Makefile                      |   2 +-
 drivers/platform/x86/intel_mid_powerbtn.c          |  15 +-
 drivers/platform/x86/intel_pmc_ipc.c               | 949 ---------------------
 drivers/platform/x86/intel_scu_ipc.c               | 447 +++++++---
 drivers/platform/x86/intel_scu_ipcutil.c           |  43 +-
 drivers/platform/x86/intel_scu_pcidrv.c            |  68 ++
 drivers/platform/x86/intel_telemetry_core.c        |  17 +-
 drivers/platform/x86/intel_telemetry_debugfs.c     |  15 +-
 drivers/platform/x86/intel_telemetry_pltdrv.c      |  97 ++-
 drivers/power/reset/mt6323-poweroff.c              |   2 +-
 drivers/power/supply/Kconfig                       |  10 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/mp2629_charger.c              | 669 +++++++++++++++
 drivers/rtc/rtc-mt6397.c                           |  18 +-
 drivers/usb/typec/mux/Kconfig                      |   2 +-
 drivers/usb/typec/mux/intel_pmc_mux.c              |  12 +-
 drivers/usb/typec/tcpm/Kconfig                     |   2 +-
 drivers/watchdog/iTCO_wdt.c                        |  25 +-
 drivers/watchdog/intel-mid_wdt.c                   |  53 +-
 include/linux/mfd/core.h                           |   2 +-
 include/linux/mfd/gsc.h                            |  76 ++
 include/linux/mfd/intel_pmc_bxt.h                  |  53 ++
 include/linux/mfd/intel_soc_pmic.h                 |  15 +
 include/linux/mfd/mp2629.h                         |  26 +
 include/linux/mfd/mt6358/core.h                    | 158 ++++
 include/linux/mfd/mt6358/registers.h               | 282 ++++++
 include/linux/mfd/mt6360.h                         | 240 ++++++
 include/linux/mfd/mt6397/core.h                    |   5 +
 include/linux/mfd/mt6397/rtc.h                     |   9 +-
 include/linux/mfd/stmfx.h                          |   1 +
 include/linux/platform_data/gsc_hwmon.h            |  44 +
 include/linux/platform_data/itco_wdt.h             |  11 +-
 74 files changed, 5115 insertions(+), 1403 deletions(-)
 create mode 100644 Documentation/ABI/obsolete/sysfs-driver-intel_pmc_bxt
 create mode 100644 Documentation/ABI/testing/sysfs-class-power-mp2629
 create mode 100644 Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
 create mode 100644 Documentation/hwmon/gsc-hwmon.rst
 delete mode 100644 arch/x86/include/asm/intel_pmc_ipc.h
 create mode 100644 arch/x86/include/asm/intel_scu_ipc_legacy.h
 create mode 100644 drivers/hwmon/gsc-hwmon.c
 create mode 100644 drivers/iio/adc/mp2629_adc.c
 create mode 100644 drivers/mfd/gateworks-gsc.c
 create mode 100644 drivers/mfd/intel_pmc_bxt.c
 create mode 100644 drivers/mfd/mp2629.c
 create mode 100644 drivers/mfd/mt6358-irq.c
 create mode 100644 drivers/mfd/mt6360-core.c
 delete mode 100644 drivers/platform/x86/intel_pmc_ipc.c
 create mode 100644 drivers/platform/x86/intel_scu_pcidrv.c
 create mode 100644 drivers/power/supply/mp2629_charger.c
 create mode 100644 include/linux/mfd/gsc.h
 create mode 100644 include/linux/mfd/intel_pmc_bxt.h
 create mode 100644 include/linux/mfd/mp2629.h
 create mode 100644 include/linux/mfd/mt6358/core.h
 create mode 100644 include/linux/mfd/mt6358/registers.h
 create mode 100644 include/linux/mfd/mt6360.h
 create mode 100644 include/linux/platform_data/gsc_hwmon.h

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
