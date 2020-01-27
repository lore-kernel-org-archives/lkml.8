Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C182EC35240
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 00:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CEFA20720
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 00:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FCWHLS6j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbgA0Auh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 19:50:37 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:36197 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbgA0Aug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 19:50:36 -0500
Received: by mail-yw1-f66.google.com with SMTP id n184so4029931ywc.3;
        Sun, 26 Jan 2020 16:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=SDwBVxt/kozp5IpVZdtFjjLbaq7lMAPRqyxX/3O+Msc=;
        b=FCWHLS6jgbIoIYcG/FwYkNaSdxyH41WbPi28ZyuUf9T2p6wct8CDsuN6tQp8MQzbcp
         L7F9R4qLx0Ekbmo1JdFewFdfJTg4mP4ZtcxU3CN5OKlih22c2rFTVzccBklzWLEb1a1M
         GOircOKN2c+hFrpRrZsSN376FaezQBhR/4ygLLVMetQE/IBji0My9DGH7+0Odam/VCkg
         GUnO/hrmX5uXq82RpYdttVfKXzKFli+3J/dVpGLjOv+Z9eAVoN9KKI/2oX9lqyVC+5/Y
         N6N9+FKzqJTdCBBYVYRSzLK70MugIjsoe7/lDiPrttB163GTEywxD8JEwbyUD6XcidR6
         hRPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=SDwBVxt/kozp5IpVZdtFjjLbaq7lMAPRqyxX/3O+Msc=;
        b=owRYKoagzKL4U/k2vokkGD1IF2qUgUWozZC8dVXhK9rss5LDM6wMWzBC/LoFj8Ca+0
         1H7Hvp8X+pADiMBakURtLPum42ri2GkyBLkOi10KntfCXaG35osWZhRdNd0A99pdvPNB
         ormffnIRaQR9und0J+GSLBYOi5SamBLlxphOWqlVnQY2+98E/MKKLuD/mNtX3WduKs9j
         bzgu84KcwzUIarYykc1ri9rSMVP4b/3OMRbEgZc7fbDrkG+RFNLCH5MCItfU9qSsEd6d
         04+5/GauS+vnnSv/6s+hIaXGw67OkXPkonq67634ffPyScUC2DMjGlF3lfHZD6l4rTcJ
         S0nw==
X-Gm-Message-State: APjAAAWAx7oIW6256FnGWULEkU/SmS0D0JyvvlqWUe5EhFNeW3jhTorX
        N26SpJHoYCKXXYBVU1l4PN6kCci8
X-Google-Smtp-Source: APXvYqyG6fE58AzJ6E3zcihdNMwikZTYarsbs8Skc9uPkPAKbJzqfooAy287Q6nsADkm5phatQh7zg==
X-Received: by 2002:a0d:dd4a:: with SMTP id g71mr10274485ywe.248.1580086235241;
        Sun, 26 Jan 2020 16:50:35 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s130sm5974173ywg.11.2020.01.26.16.50.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 26 Jan 2020 16:50:34 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon updates for v5.6
Date:   Sun, 26 Jan 2020 16:50:32 -0800
Message-Id: <20200127005032.25447-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull hwmon updates for Linux v5.6 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.6

Thanks,
Guenter
------

The following changes since commit 4703d9119972bf586d2cca76ec6438f819ffa30e:

  Merge tag 'xarray-5.5' of git://git.infradead.org/users/willy/linux-dax (2020-01-23 11:37:19 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v5.6

for you to fetch changes up to fd8bdb23b91876ac1e624337bb88dc1dcc21d67e:

  hwmon: (k10temp) Display up to eight sets of CCD temperatures (2020-01-23 15:17:59 -0800)

----------------------------------------------------------------
hwmon updates for v5.6

core:
- Add support for enable attributes to hwmon core
- Add intrusion templates

pmbus:
- Support for Infineon Multi-phase xdpe122 family controllers
- Support for Intel IMVP9 and AMD 6.25mV modes
- Support for vid mode detection per page bases
- Detect if chip is write protected
- Support for MAX20730, MAX20734, MAX20743, MAX20796, UCD90320, TPS53688
- Various improvements to ibm-cffps driver

k10temp:
- Support for additional temperature sensors as well as voltage and
  current telemetry for Zen CPUs

w83627ehf:
- Remove support for NCT6775, NCT6776 (they have their own driver)

New drivers:
- ADM1177
- MAX31730
- Driver for disk and solid state drives with temperature sensors

Other:
- pwm-fan: stop fan on shutdown

----------------------------------------------------------------
Akinobu Mita (1):
      hwmon: (pwm-fan) stop fan on shutdown

Beniamin Bia (3):
      hwmon: (adm1177) Add ADM1177 Hot Swap Controller and Digital Power Monitor driver
      dt-binding: hwmon: Add documentation for ADM1177
      MAINTAINERS: add entry for ADM1177 driver

Chen Zhou (1):
      hwmon: (w83627ehf) make sensor_dev_attr_##_name variables static

Dr. David Alan Gilbert (5):
      hwmon: Add intrusion templates
      hwmon: (w83627ehf) convert to with_info interface
      hwmon: (w83627ehf) remove nct6775 and nct6776 support
      hwmon: (w83627ehf) Remove code not needed after nct677* removal
      hwmon: (w83627ehf) Now only one intrusion channel

Eddie James (4):
      hwmon: (pmbus/ibm-cffps) Add new manufacturer debugfs entries
      hwmon: (pmbus/ibm-cffps) Add the VMON property for version 2
      hwmon: (pmbus/ibm-cffps) Fix the LED behavior when turned off
      hwmon: (pmbus/ibm-cffps) Prevent writing on_off_config with bad data

Guenter Roeck (13):
      hwmon: Add support for enable attributes to hwmon core
      hwmon: Driver for MAX31730
      hwmon: (pmbus) Detect if chip is write protected
      hwmon: (pmbus) Add MAX20796 to devices supported by generic pmbus driver
      hwmon: (pmbus) Driver for MAX20730, MAX20734, and MAX20743
      hwmon: Driver for disk and solid state drives with temperature sensors
      hwmon: (k10temp) Use bitops
      hmon: (k10temp) Convert to use devm_hwmon_device_register_with_info
      hwmon: (k10temp) Report temperatures per CPU die
      hwmon: (k10temp) Show core and SoC current and voltages on Ryzen CPUs
      hwmon: (k10temp) Don't show temperature limits on Ryzen (Zen) CPUs
      hwmon: (k10temp) Add debugfs support
      hwmon: (k10temp) Display up to eight sets of CCD temperatures

Jim Wright (2):
      dt-bindings: hwmon/pmbus: Add ti,ucd90320 power sequencer
      hwmon: (pmbus/ucd9000) Add support for UCD90320 Power Sequencer

Vadim Pasternak (5):
      hwmon: (pmbus/core) Add support for vid mode detection per page bases
      hwmon: (pmbus/core) Add support for Intel IMVP9 and AMD 6.25mV modes
      hwmon: (pmbus/tps53679) Extend device list supported by driver
      hwmon: (pmbus) Add support for Infineon Multi-phase xdpe122 family controllers
      docs: hwmon: Include 'xdpe12284.rst' into docs

YueHaibing (1):
      hwmon: (w83627ehf) Remove set but not used variable 'fan4min'

 .../devicetree/bindings/hwmon/adi,adm1177.yaml     |   66 +
 .../bindings/hwmon/pmbus/ti,ucd90320.yaml          |   45 +
 Documentation/hwmon/adm1177.rst                    |   36 +
 Documentation/hwmon/drivetemp.rst                  |   52 +
 Documentation/hwmon/index.rst                      |    5 +
 Documentation/hwmon/max20730.rst                   |   74 +
 Documentation/hwmon/max31730.rst                   |   44 +
 Documentation/hwmon/pmbus.rst                      |   10 +
 Documentation/hwmon/ucd9000.rst                    |   12 +-
 Documentation/hwmon/xdpe12284.rst                  |  101 +
 MAINTAINERS                                        |    9 +
 drivers/hwmon/Kconfig                              |   37 +-
 drivers/hwmon/Makefile                             |    3 +
 drivers/hwmon/adm1177.c                            |  288 +++
 drivers/hwmon/drivetemp.c                          |  574 ++++++
 drivers/hwmon/hwmon.c                              |   17 +-
 drivers/hwmon/k10temp.c                            |  489 ++++-
 drivers/hwmon/max31730.c                           |  440 +++++
 drivers/hwmon/pmbus/Kconfig                        |   32 +-
 drivers/hwmon/pmbus/Makefile                       |    2 +
 drivers/hwmon/pmbus/ibm-cffps.c                    |   89 +-
 drivers/hwmon/pmbus/max20730.c                     |  372 ++++
 drivers/hwmon/pmbus/max20751.c                     |    2 +-
 drivers/hwmon/pmbus/pmbus.c                        |    6 +-
 drivers/hwmon/pmbus/pmbus.h                        |   15 +-
 drivers/hwmon/pmbus/pmbus_core.c                   |   22 +-
 drivers/hwmon/pmbus/pxe1610.c                      |   44 +-
 drivers/hwmon/pmbus/tps53679.c                     |   46 +-
 drivers/hwmon/pmbus/ucd9000.c                      |   39 +-
 drivers/hwmon/pmbus/xdpe12284.c                    |  117 ++
 drivers/hwmon/pwm-fan.c                            |   15 +-
 drivers/hwmon/w83627ehf.c                          | 2021 +++++++-------------
 include/linux/hwmon.h                              |   26 +-
 include/linux/pmbus.h                              |   11 +-
 34 files changed, 3639 insertions(+), 1522 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/adi,adm1177.yaml
 create mode 100644 Documentation/devicetree/bindings/hwmon/pmbus/ti,ucd90320.yaml
 create mode 100644 Documentation/hwmon/adm1177.rst
 create mode 100644 Documentation/hwmon/drivetemp.rst
 create mode 100644 Documentation/hwmon/max20730.rst
 create mode 100644 Documentation/hwmon/max31730.rst
 create mode 100644 Documentation/hwmon/xdpe12284.rst
 create mode 100644 drivers/hwmon/adm1177.c
 create mode 100644 drivers/hwmon/drivetemp.c
 create mode 100644 drivers/hwmon/max31730.c
 create mode 100644 drivers/hwmon/pmbus/max20730.c
 create mode 100644 drivers/hwmon/pmbus/xdpe12284.c
