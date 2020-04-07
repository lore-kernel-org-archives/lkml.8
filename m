Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FABCC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 09:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E96AD20731
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 09:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fZ9cv6wA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbgDGJmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 05:42:42 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46957 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgDGJml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 05:42:41 -0400
Received: by mail-wr1-f67.google.com with SMTP id j17so3032603wru.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 02:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=20leKfDnp9hGUKa9qwXeSYUwOVCG23UzDKZ3FQOqTKs=;
        b=fZ9cv6wAj7u/XdboZIaVf2DSf+/yIorTWdNC6h/fFWS7y53Y9qHd0A9N7u+ODKXs3N
         hOHdNmbeoIoPMnL4HixEF2+V/ULyQwF3/LD+GX3xc/M4Yt1CyAI3ffsrjnIuX7588vxB
         cGReJFC0W4es+8DnVTfrIx+I9nJBSV04cdBnVZNIcW4hYDfJORyZb0nZVqvBOOB5gipw
         +HdBzihbRB/lvnmTA1qhsejqF0FCAHYIGmdAvdVhiT8hv6DEMFA8VDaUThO+0yqscWLn
         Mc6t3p+TLqF3yzWPLURWqKa1mCFMzeVfCktNwfR9BgHPvpeP+wBddDgqJ0BElrRhq/gg
         v02A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=20leKfDnp9hGUKa9qwXeSYUwOVCG23UzDKZ3FQOqTKs=;
        b=PFYBWWMnmAmuuW+V5NkSczHOpmxfObI3dmUI5qW6YETuNvM5Rr61mQRx0euolX/suF
         rNhkrnsy3MzJTbieycONx1A1ydoK1Aj/LG9pEvJzCxQyWjt8lGQdjj4xJVd7+EKEnjG/
         rsGn3T6yZT6tjY1OZcqyb/i17lF47h+FAUu6kMvRGqgLbJXcbgh8nLdKY7Gvo17vukbG
         XWdmBlOi42D0+15qWJltTAWq2C3UWspISaASb5/kS9allOD1Or+pawYpEKnVmIPESpo1
         z6l0pTB5PegXCeT0yDrcd6BPL6hkxCJYo7WGikAaGDFXmT7PbH9sBLhRc6qUYXxDqymU
         v+hg==
X-Gm-Message-State: AGi0PuZbHi7YsObgawKzYsr737c/nil2fitFY8d6hLMzP8cekvwcfpXo
        zn5V06dSLkOwu+/q99li05nITg==
X-Google-Smtp-Source: APiQypKkqz6z6YyRviQPi/wzjuP/+ZuPQsKmsVWJpbc392dm7RW+JWiqNapGo5mEIHkQRM+vVn94+A==
X-Received: by 2002:a5d:6645:: with SMTP id f5mr1849365wrw.280.1586252558469;
        Tue, 07 Apr 2020 02:42:38 -0700 (PDT)
Received: from dell ([2.31.167.253])
        by smtp.gmail.com with ESMTPSA id u17sm1621294wmu.31.2020.04.07.02.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 02:42:38 -0700 (PDT)
Date:   Tue, 7 Apr 2020 10:43:34 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] MFD for v5.7
Message-ID: <20200407094334.GH30614@dell>
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

The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git mfd-next-5.7

for you to fetch changes up to d2923aa4535664ae5c46c3a093985afd18fec118:

  mfd: intel-lpss: Fix Intel Elkhart Lake LPSS I2C input clock (2020-03-30 07:35:28 +0100)

----------------------------------------------------------------
 - New Drivers
   - Add support for IQS620A/621/622/624/625 Azoteq IQS62X Sensors

 - New Device Support
   - Add support for ADC, IRQ, Regulator, RTC and WDT to Ricoh RN5T618 PMIC
   - Add support for Comet Lake to Intel LPSS

 - New Functionality
   - Add support for Charger Detection to Spreadtrum SC27xx PMICs
   - Add support for Interrupt Polarity to Dialog Semi DA9062/61 PMIC
   - Add ACPI enumeration support to Diolan DLN2 USB Adaptor

 - Fix-ups
   - Device Tree; iqs62x, rn5t618, cros_ec_dev, stm32-lptimer, rohm,bd71837, rohm,bd71847
   - I2C registration; rn5t618
   - Kconfig; MFD_CPCAP, AB8500_CORE, MFD_WM8994, MFD_WM97xx, MFD_STPMIC1
   - Use flexible-array members; omap-usb-tll, qcom-pm8xxx
   - Remove unnecessary casts; omap-usb-host, omap-usb-tll
   - Power (suspend/resume/poweroff) enhancements; rk808
   - Improve error/sanity checking; dln2
   - Use snprintf(); aat2870-core

 - Bug Fixes
   - Fix PCI IDs; intel-lpss-pci

----------------------------------------------------------------
Andreas Kemnade (7):
      dt-bindings: mfd: rn5t618: Document optional property interrupts
      mfd: rn5t618: Add IRQ support
      mfd: rn5t618: Add RTC related registers
      mfd: rn5t618: Add more subdevices
      rtc: rc5t619: Add Ricoh RC5T619 RTC driver
      iio: adc: rn5t618: Add ADC driver for RN5T618/RC5T619
      mfd: rn5t618: Cleanup i2c_device_id

Andy Shevchenko (3):
      mfd: intel-lpss: Add Intel Comet Lake PCH-V PCI IDs
      mfd: dln2: Fix sanity checking for endpoints
      mfd: dln2: Allow to be enumerated via ACPI

Baolin Wang (1):
      mfd: sc27xx: Add USB charger type detection support

Benjamin Gaignard (1):
      dt-bindings: mfd: Document STM32 low power timer bindings

Christophe JAILLET (1):
      mfd: Kconfig: Fix some misspelling of the word functionality

Corentin Labbe (1):
      mfd: omap: Remove useless cast for driver.name

Gustavo A. R. Silva (2):
      mfd: omap-usb-tll: Replace zero-length array with flexible-array member
      mfd: pm8xxx: Replace zero-length array with flexible-array member

Jarkko Nikula (1):
      mfd: intel-lpss: Fix Intel Elkhart Lake LPSS I2C input clock

Jeff LaBundy (6):
      dt-bindings: Add bindings for Azoteq IQS620A/621/622/624/625
      mfd: Add support for Azoteq IQS620A/621/622/624/625
      input: keyboard: Add support for Azoteq IQS620A/621/622/624/625
      iio: temperature: Add support for Azoteq IQS620AT temperature sensor
      iio: light: Add support for Azoteq IQS621/622 ambient light sensors
      iio: position: Add support for Azoteq IQS624/625 angle sensors

Lee Jones (1):
      Merge branches 'ib-mfd-iio-input-5.7' and 'ib-mfd-iio-rtc-5.7' into ibs-for-mfd-merged

Matti Vaittinen (1):
      dt-bindings: bd718x7: Yamlify and add BD71850

Prashant Malani (1):
      mfd: cros_ec: Check DT node for usbpd-notify add

Robin Murphy (4):
      mfd: rk808: Ensure suspend/resume hooks always work
      mfd: rk808: Stop using syscore ops
      mfd: rk808: Reduce shutdown duplication
      mfd: rk808: Convert RK805 to shutdown/suspend hooks

Shreyas Joshi (1):
      mfd: da9062: Add support for interrupt polarity defined in device tree

Soeren Moch (1):
      mfd: rk808: Always use poweroff when requested

Takashi Iwai (1):
      mfd: aat2870: Use scnprintf() for avoiding potential buffer overflow

Tony Lindgren (1):
      mfd: cpcap: Fix compile if MFD_CORE is not selected

 .../devicetree/bindings/input/iqs62x-keys.yaml     |  132 +++
 Documentation/devicetree/bindings/mfd/iqs62x.yaml  |  179 ++++
 Documentation/devicetree/bindings/mfd/rn5t618.txt  |    4 +
 .../devicetree/bindings/mfd/rohm,bd71837-pmic.txt  |   90 --
 .../devicetree/bindings/mfd/rohm,bd71837-pmic.yaml |  236 +++++
 .../devicetree/bindings/mfd/rohm,bd71847-pmic.yaml |  222 ++++
 .../devicetree/bindings/mfd/st,stm32-lptimer.yaml  |   16 +
 .../devicetree/bindings/pwm/iqs620a-pwm.yaml       |   32 +
 .../bindings/regulator/rohm,bd71837-regulator.txt  |  162 ---
 .../bindings/regulator/rohm,bd71837-regulator.yaml |  103 ++
 .../bindings/regulator/rohm,bd71847-regulator.yaml |   97 ++
 drivers/iio/Kconfig                                |    1 +
 drivers/iio/Makefile                               |    1 +
 drivers/iio/adc/Kconfig                            |   10 +
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/rn5t618-adc.c                      |  256 +++++
 drivers/iio/light/Kconfig                          |   10 +
 drivers/iio/light/Makefile                         |    1 +
 drivers/iio/light/iqs621-als.c                     |  617 ++++++++++++
 drivers/iio/position/Kconfig                       |   19 +
 drivers/iio/position/Makefile                      |    7 +
 drivers/iio/position/iqs624-pos.c                  |  284 ++++++
 drivers/iio/temperature/Kconfig                    |   10 +
 drivers/iio/temperature/Makefile                   |    1 +
 drivers/iio/temperature/iqs620at-temp.c            |   97 ++
 drivers/input/keyboard/Kconfig                     |   10 +
 drivers/input/keyboard/Makefile                    |    1 +
 drivers/input/keyboard/iqs62x-keys.c               |  335 ++++++
 drivers/mfd/Kconfig                                |   23 +-
 drivers/mfd/Makefile                               |    1 +
 drivers/mfd/aat2870-core.c                         |    2 +-
 drivers/mfd/cros_ec_dev.c                          |    2 +-
 drivers/mfd/da9062-core.c                          |   44 +-
 drivers/mfd/dln2.c                                 |   30 +-
 drivers/mfd/intel-lpss-pci.c                       |   31 +-
 drivers/mfd/iqs62x.c                               | 1063 ++++++++++++++++++++
 drivers/mfd/omap-usb-host.c                        |    2 +-
 drivers/mfd/omap-usb-tll.c                         |    4 +-
 drivers/mfd/qcom-pm8xxx.c                          |    2 +-
 drivers/mfd/rk808.c                                |  139 +--
 drivers/mfd/rn5t618.c                              |  109 +-
 drivers/mfd/sprd-sc27xx-spi.c                      |   52 +
 drivers/rtc/Kconfig                                |   10 +
 drivers/rtc/Makefile                               |    1 +
 drivers/rtc/rtc-rc5t619.c                          |  444 ++++++++
 include/linux/mfd/iqs62x.h                         |  139 +++
 include/linux/mfd/rk808.h                          |    2 -
 include/linux/mfd/rn5t618.h                        |   26 +
 include/linux/mfd/sc27xx-pmic.h                    |    7 +
 49 files changed, 4688 insertions(+), 379 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/iqs62x-keys.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/iqs62x.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml
 create mode 100644 Documentation/devicetree/bindings/pwm/iqs620a-pwm.yaml
 delete mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd71847-regulator.yaml
 create mode 100644 drivers/iio/adc/rn5t618-adc.c
 create mode 100644 drivers/iio/light/iqs621-als.c
 create mode 100644 drivers/iio/position/Kconfig
 create mode 100644 drivers/iio/position/Makefile
 create mode 100644 drivers/iio/position/iqs624-pos.c
 create mode 100644 drivers/iio/temperature/iqs620at-temp.c
 create mode 100644 drivers/input/keyboard/iqs62x-keys.c
 create mode 100644 drivers/mfd/iqs62x.c
 create mode 100644 drivers/rtc/rtc-rc5t619.c
 create mode 100644 include/linux/mfd/iqs62x.h
 create mode 100644 include/linux/mfd/sc27xx-pmic.h

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
