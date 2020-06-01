Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1097AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 02:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAC4620679
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 02:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4CHPPsr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgFACDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 22:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbgFACDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 22:03:31 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03372C061A0E;
        Sun, 31 May 2020 19:03:29 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id s10so2780956pgm.0;
        Sun, 31 May 2020 19:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=fnte9zCNQnBgZL4ODRWYE0WufaBRHwVciP2Wh+TB8HE=;
        b=S4CHPPsr9HNz3H/JcvEbrAKfz42d0VgBvfHlyYj5vZfaI61DMId+aEQf1CTaY/Nco7
         MU0ETDPcAHpy8WmAv6CmYrwuos9gsk/DzF+OgPreXXXAfan8JAknvn0PPXrOe8m04LJi
         N+GoF9ZmVWe1sqwgzczOoZJQdwvZPxis5aJbvfTejUwN1L6/B1KFG+Jul1S5BdW5n0+o
         iYbeAtVkuRvMPdhe7M1QV6Bn8ETQRoPCqcsBu2OwJCMtD7XmRQTaNyQukmnApH/HAbwO
         RpGmMhNR0lDfAMMn4URTOhA1m9jLnbLy4uRFEXbC3jCdpcZTX7/eT7LBY7P2tWpXP5mD
         qTKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=fnte9zCNQnBgZL4ODRWYE0WufaBRHwVciP2Wh+TB8HE=;
        b=O45TcEEMxQkOInNkNzMHJNVXcsGn+XxmO4bMLb8eE0Q0l0U3jg0d8NRuW2E0DDsbeT
         kyExDY/n57L009xdL+4tVKrlyetzDbAz2QvdU5/zGKXJkYrW28l8pPWE7X7OtiYwVWoK
         11ESEXdiDru30jO4ugkEPo8WFMblkL3m/J8KLwG7oVPlYtnwHLXKiJbvITW5OfT886hM
         eTxZeRA3sl5TTc3UrJwtW80R9RVAbYqYsyXOfLflNTEggJjt+HVZMEsD42YGVQDfpIqU
         F6+9Qb4ExdpBkt3Nm5wT94C4vuXLN/zwfvm9DwWILeUQ3DladYnxEyC51awnYxBtjgHy
         G2fg==
X-Gm-Message-State: AOAM533OmH8QaBB+ja0vkVOrXO9nLOArZlwFGYndmu6fRxNAAnjZ+atT
        f+VCVkA+lNYPWdAtaFDLDItkwtDv
X-Google-Smtp-Source: ABdhPJyuEPIN3Lrooxz6VUSgFq07+VwiCFZiAYjG4wFK5HIQzRJ6gyyw+Dy3xGFdI5EMRMjAJWjUug==
X-Received: by 2002:aa7:9ae3:: with SMTP id y3mr3748752pfp.224.1590977009393;
        Sun, 31 May 2020 19:03:29 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l67sm12681043pfl.81.2020.05.31.19.03.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 31 May 2020 19:03:28 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon updates for v5.8
Date:   Sun, 31 May 2020 19:03:27 -0700
Message-Id: <20200601020327.246402-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull hwmon updates for Linux v5.8 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.8

Thanks,
Guenter
------

The following changes since commit b9bbe6ed63b2b9f2c9ee5cbd0f2c946a2723f4ce:

  Linux 5.7-rc6 (2020-05-17 16:48:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v5.8

for you to fetch changes up to 87976ce2825d9f1ca2e70ee7d38dec490ad5a6e2:

  hwmon: Add Baikal-T1 PVT sensor driver (2020-05-28 07:59:45 -0700)

----------------------------------------------------------------
hwmon updates for v5.8

Infrastructure
- Add notification support

New drivers
- Baikal-T1 PVT sensor driver
- amd_energy driver to report energy counters
- Driver for Maxim MAX16601
- Gateworks System Controller

Various
- applesmc: avoid overlong udelay()
- dell-smm: Use one DMI match for all XPS models
- ina2xx: Implement alert functions
- lm70: Add support for ACPI
- lm75: Fix coding-style warnings
- lm90: Add max6654 support to lm90 driver
- nct7802: Replace container_of() API
- nct7904: Set default timeout
- nct7904: Add watchdog function
- pmbus: Improve initialization of 'currpage' and 'currphase'

----------------------------------------------------------------
Akinobu Mita (1):
      hwmon: Reduce indentation level in __hwmon_device_register()

Alex Qiu (1):
      hwmon: (ina2xx) Implement alert functions

Andrej Picej (1):
      hwmon: (lm70) Add support for ACPI

Arnd Bergmann (1):
      hwmon: (applesmc) avoid overlong udelay()

Guenter Roeck (4):
      hwmon: (pmbus) Improve initialization of 'currpage' and 'currphase'
      hwmon: (pmbus) Driver for Maxim MAX16601
      Merge tag 'ib-mfd-hwmon-v5.8' into hwmon-next
      hwmon: Add notification support

Josh Lehan (1):
      hwmon: (lm90) Add max6654 support to lm90 driver

Michal Orzel (1):
      hwmon: (lm75) Fix all coding-style warnings on lm75 driver

Naveen Krishna Chatradhi (3):
      hwmon: Add amd_energy driver to report energy counters
      hwmon: (amd_energy) Add documentation
      MAINTAINERS: add entry for AMD energy driver

Serge Semin (2):
      dt-bindings: hwmon: Add Baikal-T1 PVT sensor binding
      hwmon: Add Baikal-T1 PVT sensor driver

Thomas Hebb (1):
      hwmon: (dell-smm) Use one DMI match for all XPS models

Tim Harvey (3):
      dt-bindings: mfd: Add Gateworks System Controller bindings
      mfd: Add Gateworks System Controller core driver
      hwmon: Add Gateworks System Controller support

Wei Yongjun (1):
      hwmon: (amd_energy) Missing platform_driver_unregister() on error in amd_energy_init()

Wolfram Sang (1):
      hwmon: (adt7411) update contact email

Yuechao Zhao (2):
      hwmon: (nct7904) Add watchdog function
      hwmon: (nct7904) Set default timeout

hailizheng (1):
      hwmon: (nct7802) Replace container_of() API

zhouchuangao (1):
      hwmon : (nct6775) Use kobj_to_dev() API

 .../devicetree/bindings/hwmon/baikal,bt1-pvt.yaml  |  107 ++
 .../devicetree/bindings/mfd/gateworks-gsc.yaml     |  196 ++++
 Documentation/hwmon/amd_energy.rst                 |  109 ++
 Documentation/hwmon/bt1-pvt.rst                    |  117 ++
 Documentation/hwmon/gsc-hwmon.rst                  |   53 +
 Documentation/hwmon/ina2xx.rst                     |   19 +
 Documentation/hwmon/index.rst                      |    4 +
 Documentation/hwmon/lm90.rst                       |   23 +-
 Documentation/hwmon/max16601.rst                   |  159 +++
 MAINTAINERS                                        |   18 +
 drivers/hwmon/Kconfig                              |   59 +-
 drivers/hwmon/Makefile                             |    3 +
 drivers/hwmon/adt7411.c                            |    3 +-
 drivers/hwmon/amd_energy.c                         |  408 +++++++
 drivers/hwmon/applesmc.c                           |   12 +-
 drivers/hwmon/bt1-pvt.c                            | 1146 ++++++++++++++++++++
 drivers/hwmon/bt1-pvt.h                            |  244 +++++
 drivers/hwmon/dell-smm-hwmon.c                     |   26 +-
 drivers/hwmon/gsc-hwmon.c                          |  390 +++++++
 drivers/hwmon/hwmon.c                              |  136 ++-
 drivers/hwmon/ina2xx.c                             |  183 ++++
 drivers/hwmon/lm70.c                               |   47 +-
 drivers/hwmon/lm75.c                               |    8 +-
 drivers/hwmon/lm75.h                               |   31 +-
 drivers/hwmon/lm90.c                               |   45 +-
 drivers/hwmon/nct6775.c                            |   10 +-
 drivers/hwmon/nct7802.c                            |    6 +-
 drivers/hwmon/nct7904.c                            |  138 ++-
 drivers/hwmon/pmbus/Kconfig                        |    9 +
 drivers/hwmon/pmbus/Makefile                       |    1 +
 drivers/hwmon/pmbus/max16601.c                     |  314 ++++++
 drivers/hwmon/pmbus/pmbus_core.c                   |    8 +-
 drivers/mfd/Kconfig                                |   15 +
 drivers/mfd/Makefile                               |    1 +
 drivers/mfd/gateworks-gsc.c                        |  277 +++++
 include/linux/hwmon.h                              |    3 +
 include/linux/mfd/gsc.h                            |   76 ++
 include/linux/platform_data/gsc_hwmon.h            |   44 +
 38 files changed, 4342 insertions(+), 106 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/baikal,bt1-pvt.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
 create mode 100644 Documentation/hwmon/amd_energy.rst
 create mode 100644 Documentation/hwmon/bt1-pvt.rst
 create mode 100644 Documentation/hwmon/gsc-hwmon.rst
 create mode 100644 Documentation/hwmon/max16601.rst
 create mode 100644 drivers/hwmon/amd_energy.c
 create mode 100644 drivers/hwmon/bt1-pvt.c
 create mode 100644 drivers/hwmon/bt1-pvt.h
 create mode 100644 drivers/hwmon/gsc-hwmon.c
 create mode 100644 drivers/hwmon/pmbus/max16601.c
 create mode 100644 drivers/mfd/gateworks-gsc.c
 create mode 100644 include/linux/mfd/gsc.h
 create mode 100644 include/linux/platform_data/gsc_hwmon.h
