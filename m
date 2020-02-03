Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B16C33CAC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 13:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED9112084E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 13:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pLJ+562g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgBCNFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 08:05:08 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33094 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbgBCNFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 08:05:07 -0500
Received: by mail-wr1-f68.google.com with SMTP id u6so4738313wrt.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 05:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=3kBq8kAXdU/eUGiK90mF3tp3+3qsy8R9b9xYatOimb8=;
        b=pLJ+562gCgjTDM0oYy3AC3NGZXNwFKeV87MkrYQFuVqlnyDUmJVUpyPYtufeo6lvhq
         IE6wImazhB+wyZcgTJHTfjnd5rzVtK44sAKGJ7ITfA6Zp/AxmIrCpkXQ3bh/1QjthyP+
         nGMIf6k6moX16I2xNDCaNcasK7VkbPAphbsYTDtxOgxoiRbLZVby+sssiR9j/+UJC7i3
         z2hJHfQlUOd7yx+EQY1arbeYzvKiElq+tx7QzFihVP6gzearZSsW1PR9rG6swSv24c0s
         AH3rb0jRiyhW2AiMH4NiTpcVepVXLGnYc6sCGqIPStMJuHw9WMTe5r0QxFSrKE9hf3Qq
         Sa7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=3kBq8kAXdU/eUGiK90mF3tp3+3qsy8R9b9xYatOimb8=;
        b=aABOib8YU3IBm4zdU88Rh8SUDWtc7MLy2jqOu6+3JbvBS7W9Gv7qK1kIl6wTBuvD0X
         bcATlhVYCYhlupP3N/0DtBPNuhtuY0VyEGXdATTL39DRyj1i4bOqB+JD+w9osI3PqWl/
         HAcnPuhh9jibc/oakGJExGIFiTBnYTT4WzvP5is+GDarEW4o6eMGWYz4PcbRJHj9nPjo
         iM9t92PtSw47E6bbHOCIs0uPLsJhiwFeMZpmzD0M8K+5GKHvDTi01DxwcsnQ2MOXVs5X
         P5XRnYbMjt2LyvMHUm7cvV5XVS8r6R0XqBd5WEeq7uXP5MeJ9ifeiX2qGlZHzWYKnKJR
         ndvw==
X-Gm-Message-State: APjAAAVsbWCiAIwqPQYkLSDmfZGMVFTRqd+AgtkN7ABR6KPtp/6SM5qs
        x/r35BR/tk+VkoGM36SKb2s17A==
X-Google-Smtp-Source: APXvYqxLA9S+JWcZfesIimYc5ZiLv0KEUiNPRVn1B/CtcgaTy77LCUY9315En+2GHtRjnWS/hiFJ3w==
X-Received: by 2002:adf:f8c4:: with SMTP id f4mr14817806wrq.243.1580735102235;
        Mon, 03 Feb 2020 05:05:02 -0800 (PST)
Received: from dell ([2.27.35.227])
        by smtp.gmail.com with ESMTPSA id d16sm27622039wrg.27.2020.02.03.05.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 05:05:01 -0800 (PST)
Date:   Mon, 3 Feb 2020 13:05:16 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] MFD for v5.6
Message-ID: <20200203130516.GB15069@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good afternoon Linus,

Please be aware that this is likely to conflict with Mark Brown's
Regulator tree:

  https://lkml.org/lkml/2020/1/27/791

However the fix-up should be trivial.

The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-next-5.6

for you to fetch changes up to 5312f321a67cfee1fe4de245bc558fa857dce33b:

  mfd: syscon: Fix syscon_regmap_lookup_by_phandle_args() dummy (2020-02-03 08:39:49 +0000)

----------------------------------------------------------------
 - New Drivers
   - Add support for ROHM BD71828 PMICs and GPIOs
   - Add support for Qualcomm Aqstic Audio Codecs WCD9340 and WCD9341

- New Device Support
   - Add support for BD71828 to BD70528 RTC driver
   - Add support for Intel's Jasper Lake to LPSS PCI

 - New Functionality
   - Add support for Power Key to ROHM BD71828
   - Add support for Clocks to ROHM BD71828
   - Add support for GPIOs to Dialog DA9062
   - Add support for USB PD Notify to ChromiumOS EC
   - Allow callers to specify args when requesting regmap lookup; syscon

 - Fix-ups
   - Improve error handling and sanity checking; atmel-hlcdc, dln2
   - Device Tree support/documentation; bd71828, da9062, xylon,logicvc,
                                        ab8500, max14577, atmel-usart
   - Match devices using platform IDs; bd7xxxx
   - Refactor BD718x7 regulator component; bd718x7-regulator
   - Use standard interfaces/helpers; syscon, sm501
   - Trivial (whitespace, spelling, etc); ab8500-core, Kconfig
   - Remove unused code; db8500-prcmu, tqmx86
   - Wait until boot has finished before accessing registers; madera-core
   - Provide missing register value defaults; cs47l15-tables
   - Allow more time for hardware to reset; madera-core

 - Bug Fixes
   - Fix erroneous register values; rohm-bd70528
   - Fix register volatility; axp20x, rn5t618
   - Fix Kconfig dependencies; MFD_MAX77650
   - Fix incorrect compatible string; da9062-core
   - Fix syscon_regmap_lookup_by_phandle_args() stub; syscon

----------------------------------------------------------------
Andreas Kemnade (1):
      mfd: rn5t618: Mark ADC control register volatile

Andy Shevchenko (2):
      mfd: syscon: Re-use resource_size() to count max_register
      mfd: intel-lpss: Add Intel Jasper Lake PCI IDs

Bartosz Golaszewski (1):
      mfd: max77650: Select REGMAP_IRQ in Kconfig

Charles Keepax (3):
      mfd: madera: Wait for boot done before accessing any other registers
      mfd: cs47l15: Add missing register default
      mfd: madera: Allow more time for hardware reset

Chuhong Yuan (1):
      mfd: sm501: Fix mismatches of request_mem_region

Claudiu Beznea (4):
      mfd: atmel-hlcdc: Add struct device member to struct atmel_hlcdc_regmap
      mfd: atmel-hlcdc: Return in case of error
      dt-bindings: atmel-usart: Remove wildcard
      dt-bindings: atmel-usart: Add microchip,sam9x60-{usart, dbgu}

Geert Uytterhoeven (1):
      mfd: syscon: Fix syscon_regmap_lookup_by_phandle_args() dummy

Krzysztof Kozlowski (1):
      mfd: Kconfig: Rename Samsung to lowercase

Lee Jones (1):
      Merge branches 'ib-mfd-drm-5.6' and 'ib-mfd-clk-gpio-regulator-rtc-5.6' into ibs-for-mfd-merged

Linus Walleij (3):
      mfd: ab8500: Fix ab8500-clk typo
      mfd: dbx500-prcmu: Drop set_display_clocks()
      mfd: dbx500-prcmu: Drop DSI pll clock functions

Marco Felsch (3):
      mfd: da9062: add support for the DA9062 GPIOs in the core
      dt-bindings: mfd: da9062: add gpio bindings
      mfd: da9062: Fix watchdog compatible string

Matheus Castello (1):
      dt-bindings: mfd: max14577: Add reference to max14040_battery.txt descriptions

Matti Vaittinen (11):
      dt-bindings: leds: ROHM BD71282 PMIC LED driver
      dt-bindings: mfd: Document ROHM BD71828 bindings
      mfd: Rohm PMICs: Use platform_device_id to match MFD sub-devices
      mfd: bd718x7: Add compatible for BD71850
      mfd: bd71828: Support ROHM BD71828 PMIC - core
      mfd: bd71828: Add power-key support
      clk: bd718x7: Support ROHM BD71828 clk block
      regulator: bd718x7: Split driver to common and bd718x7 specific parts
      mfd: bd70528: Fix hour register mask
      rtc: bd70528: add BD71828 support
      gpio: bd71828: Initial support for ROHM BD71828 PMIC GPIOs

Oliver Neukum (1):
      mfd: dln2: More sanity checking for endpoints

Orson Zhai (1):
      mfd: syscon: Add arguments support for syscon reference

Paul Kocialkowski (1):
      dt-bindings: mfd: Document the Xylon LogiCVC multi-function device

Prashant Malani (1):
      mfd: cros_ec: Add cros-usbpd-notify subdevice

Samuel Holland (1):
      mfd: axp20x: Mark AXP20X_VBUS_IPSOUT_MGMT as volatile

Srinivas Kandagatla (1):
      mfd: wcd934x: Add support to wcd9340/wcd9341 codec

Stephan Gerhold (2):
      dt-bindings: mfd: ab8500: Document AB8505 bindings
      mfd: ab8500-core: Add device tree support for AB8505

yu kuai (1):
      mfd: tqmx86: remove set but not used variable 'i2c_ien'

 .../bindings/leds/rohm,bd71828-leds.yaml           |  52 ++
 Documentation/devicetree/bindings/mfd/ab8500.txt   |   8 +-
 .../devicetree/bindings/mfd/atmel-usart.txt        |  11 +-
 Documentation/devicetree/bindings/mfd/da9062.txt   |  10 +
 Documentation/devicetree/bindings/mfd/max14577.txt |   2 +
 .../devicetree/bindings/mfd/rohm,bd71828-pmic.yaml | 193 ++++++++
 .../devicetree/bindings/mfd/xylon,logicvc.yaml     |  50 ++
 drivers/clk/Kconfig                                |   6 +-
 drivers/clk/clk-bd718x7.c                          |  50 +-
 drivers/gpio/Kconfig                               |  12 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-bd71828.c                        | 159 ++++++
 drivers/mfd/Kconfig                                |  30 +-
 drivers/mfd/Makefile                               |   2 +
 drivers/mfd/ab8500-core.c                          |  18 +-
 drivers/mfd/atmel-hlcdc.c                          |  18 +-
 drivers/mfd/axp20x.c                               |   2 +-
 drivers/mfd/cros_ec_dev.c                          |  22 +
 drivers/mfd/cs47l15-tables.c                       |   1 +
 drivers/mfd/da9062-core.c                          |  18 +-
 drivers/mfd/db8500-prcmu.c                         | 122 +----
 drivers/mfd/dln2.c                                 |  13 +-
 drivers/mfd/intel-lpss-pci.c                       |  13 +
 drivers/mfd/madera-core.c                          |  33 +-
 drivers/mfd/rn5t618.c                              |   1 +
 drivers/mfd/rohm-bd70528.c                         |   3 +-
 drivers/mfd/rohm-bd71828.c                         | 344 +++++++++++++
 drivers/mfd/rohm-bd718x7.c                         |  43 +-
 drivers/mfd/sm501.c                                |  19 +-
 drivers/mfd/syscon.c                               |  31 +-
 drivers/mfd/tqmx86.c                               |   3 +-
 drivers/mfd/wcd934x.c                              | 306 ++++++++++++
 drivers/regulator/Kconfig                          |   4 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/bd718x7-regulator.c              | 200 +++-----
 drivers/regulator/rohm-regulator.c                 |  95 ++++
 drivers/rtc/Kconfig                                |   3 +-
 drivers/rtc/rtc-bd70528.c                          | 220 +++++++--
 include/linux/mfd/db8500-prcmu.h                   |  18 -
 include/linux/mfd/dbx500-prcmu.h                   |  30 --
 include/linux/mfd/rohm-bd70528.h                   |  19 +-
 include/linux/mfd/rohm-bd71828.h                   | 423 ++++++++++++++++
 include/linux/mfd/rohm-bd718x7.h                   |   6 -
 include/linux/mfd/rohm-generic.h                   |  70 ++-
 include/linux/mfd/rohm-shared.h                    |  21 +
 include/linux/mfd/syscon.h                         |  14 +
 include/linux/mfd/wcd934x/registers.h              | 531 +++++++++++++++++++++
 include/linux/mfd/wcd934x/wcd934x.h                |  31 ++
 48 files changed, 2863 insertions(+), 419 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/rohm,bd71828-leds.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/xylon,logicvc.yaml
 create mode 100644 drivers/gpio/gpio-bd71828.c
 create mode 100644 drivers/mfd/rohm-bd71828.c
 create mode 100644 drivers/mfd/wcd934x.c
 create mode 100644 drivers/regulator/rohm-regulator.c
 create mode 100644 include/linux/mfd/rohm-bd71828.h
 create mode 100644 include/linux/mfd/rohm-shared.h
 create mode 100644 include/linux/mfd/wcd934x/registers.h
 create mode 100644 include/linux/mfd/wcd934x/wcd934x.h

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
