Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CC8C2D0E5
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 15:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D22B205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 15:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dpI1okSX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729733AbgC3Pv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 11:51:27 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42268 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727952AbgC3Pv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 11:51:27 -0400
Received: by mail-pl1-f196.google.com with SMTP id e1so6877028plt.9;
        Mon, 30 Mar 2020 08:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L9o4KRn00mDjtqt+akJWlI8f2RLZQl/VvTUHSutIqZc=;
        b=dpI1okSXow4OOYbunaZ8VE/spoxDkrFnRnKrS/Q3aMCM4/g1GiuVrKnwrYY0r+C2iw
         7YmAGvblhoiq0Cfm+10H2kSVAhrbudXQlQAMO/ciRQysZlfsgYM86/T1X8F9MSqMExa6
         n/46GkZKJPLHBgs7A3TkBM3HOrCzWLiQg0ymqnUzj25rc6HEJM4HdfFATBSDlZQ3tfh2
         Y9AA2pvVIS2dxxuevFGQktuU9UK+JdvWs/2gS6CZB/jYO5sYTdXXWjgscV5382HiLOvA
         CZwrIwTY78IET02aKVRqznPkzQv7nTZ3x4xOSu6ac55CNrgNYVvgCqM1I3bha8knJ8Et
         7Etg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=L9o4KRn00mDjtqt+akJWlI8f2RLZQl/VvTUHSutIqZc=;
        b=aao03QFcHlztH3f0jmYHaNDmvxFIS7G8xpd3MTREUyU7vugT44wvlqM1C93LWgRv47
         zDVLQw4vv6uSMH9BShY1+OybP59LBJBeP/MhQ/LGcsdFMIyBp2jkapM26C4sBssvenUS
         +h0iD+q/0/AuPWQNAXqb5eBDb2h3oxiP2shrdglQYkAtyxY2PZKdj0D4yvQW2R3xyGxh
         nMG/Veky6z5hGuD8c13mdBocy8VGXUuSTAqSVGA2HgCFHVsiW9VGcZoaFLciRZTWFC3W
         3SJ/BP5Wu3xxt5ifxmLCA3BWf6yOZ9TGzY4+fV+iWYJ1vc3WxRNxZZrYjBhNlx2AoKcT
         35IA==
X-Gm-Message-State: ANhLgQ1XC+UPCT/7kNoAQQEl/gkskkqn2lQQQScYBIPnTo4I17aloFJW
        cawIwob4Z/kKU06jhS2VeBxyWBMI
X-Google-Smtp-Source: ADFU+vv9C+B1Xv0VipPjnnA/WMWiN43YowIhNsDS4hWW6fmhwtfmcDA2QmTJbFMvWFsC0gf5esa79w==
X-Received: by 2002:a17:90a:1784:: with SMTP id q4mr16358734pja.111.1585583485967;
        Mon, 30 Mar 2020 08:51:25 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 21sm9963781pgf.41.2020.03.30.08.51.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Mar 2020 08:51:25 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon updates for v5.7
Date:   Mon, 30 Mar 2020 08:51:24 -0700
Message-Id: <20200330155124.243034-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull hwmon updates for Linux v5.7 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.7

Depending on merge order, there may be a context conflict against devicetree
in Documentation/devicetree/bindings/trivial-devices.yaml.

Thanks,
Guenter
------

The following changes since commit 2c523b344dfa65a3738e7039832044aa133c75fb:

  Linux 5.6-rc5 (2020-03-08 17:44:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v5.7

for you to fetch changes up to 5b10a8194664a0d3b025f9b53de4476754ce8e41:

  docs: hwmon: Update documentation for isl68137 pmbus driver (2020-03-22 16:42:54 -0700)

----------------------------------------------------------------
hwmon patches for v5.7

New driver for AXI fan control.
Attenuator bypass support and support for inverting pwm output
in adt7475 driver.
Support for new power supply version in ibm-cffps driver.
PMBus drivers:
  Support for multi-phase chips.
  Support for LTC2972, LTC2979, LTC3884, LTC3889, LTC7880, LTM4664,
  LTM4677, LTM4678, LTM4680, and LTM4700 added to ltc2978 driver.
  Support for TPS53681, TPS53647, and TPS53667 added to tps53679
  driver.
  Support for various 2nd Gen Renesas digital multiphase chips
  added to isl68137 driver.

Minor improvements and fixes in nct7904, ibmpowernv, lm73, ibmaem,
and k10temp drivers.

----------------------------------------------------------------
Amy Shih (1):
      hwmon: (nct7904) Fix the incorrect quantity for fan & temp attributes

Chris Packham (2):
      dt-bindings: hwmon: Document adt7475 pwm-active-state property
      hwmon: (adt7475) Add support for inverting pwm output

Eddie James (1):
      hwmon: (pmbus/ibm-cffps) Add another PSU CCIN to version detection

Grant Peltier (2):
      hwmon: (pmbus) add support for 2nd Gen Renesas digital multiphase
      docs: hwmon: Update documentation for isl68137 pmbus driver

Guenter Roeck (11):
      hwmon: (k10temp) Swap Tdie and Tctl on Family 17h CPUs
      hwmon: (k10temp) Reorganize and simplify temperature support detection
      hwmon: (k10temp) Update driver documentation
      hwmon: (pmbus) Add IC_DEVICE_ID and IC_DEVICE_REV command definitions
      hwmon: (pmbus) Add 'phase' parameter where needed for multi-phase support
      hwmon: (pmbus) Implement multi-phase support
      hwmon: (pmbus/tps53679) Add support for multiple chips IDs
      hwmon: (pmbus/tps53679) Add support for IIN and PIN to TPS53679 and TPS53688
      hwmon: (pmbus/tps53679) Add support for TPS53681
      hwmon: (pmbus/tps53679) Add support for TPS53647 and TPS53667
      hwmon: (pmbus/tps53679) Add documentation

Gustavo A. R. Silva (1):
      hwmon: (ibmaem) Replace zero-length array with flexible-array member

Henry Shen (2):
      dt-bindings: Add TI LM73 as a trivial device
      hwmon: (lm73) Add support for of_match_table

Logan Shaw (3):
      dt-bindings: hwmon: Document adt7475 binding
      dt-bindings: hwmon: Document adt7475 bypass-attenuator property
      hwmon: (adt7475) Add attenuator bypass support

Mike Jones (3):
      docs: hwmon: (pmbus/ltc2978) Update datasheet URLs to analog.com.
      hwmon: (pmbus/ltc2978) add support for more parts.
      bindings: (hwmon/ltc2978.txt) add support for more parts (bindings)

Nuno Sá (2):
      hwmon: Support ADI Fan Control IP
      dt-bindings: hwmon: Add AXI FAN Control documentation

Takashi Iwai (1):
      hwmon: (ibmpowernv) Use scnprintf() for avoiding potential buffer overflow

 .../bindings/hwmon/adi,axi-fan-control.yaml        |  62 +++
 .../devicetree/bindings/hwmon/adt7475.yaml         |  84 ++++
 .../devicetree/bindings/hwmon/ltc2978.txt          |  22 +-
 .../devicetree/bindings/trivial-devices.yaml       |  10 +-
 Documentation/hwmon/index.rst                      |   1 +
 Documentation/hwmon/isl68137.rst                   | 541 ++++++++++++++++++++-
 Documentation/hwmon/k10temp.rst                    |  29 +-
 Documentation/hwmon/ltc2978.rst                    | 198 ++++++--
 Documentation/hwmon/pmbus-core.rst                 |  22 +-
 Documentation/hwmon/pmbus.rst                      |   8 +-
 Documentation/hwmon/tps53679.rst                   | 178 +++++++
 MAINTAINERS                                        |   8 +
 drivers/hwmon/Kconfig                              |   9 +
 drivers/hwmon/Makefile                             |   1 +
 drivers/hwmon/adt7475.c                            |  95 +++-
 drivers/hwmon/axi-fan-control.c                    | 469 ++++++++++++++++++
 drivers/hwmon/ibmaem.c                             |   2 +-
 drivers/hwmon/ibmpowernv.c                         |   8 +-
 drivers/hwmon/k10temp.c                            |  60 +--
 drivers/hwmon/lm73.c                               |  10 +
 drivers/hwmon/nct7904.c                            |  21 +
 drivers/hwmon/pmbus/Kconfig                        |  21 +-
 drivers/hwmon/pmbus/adm1275.c                      |  37 +-
 drivers/hwmon/pmbus/ibm-cffps.c                    |  29 +-
 drivers/hwmon/pmbus/ir35221.c                      |  23 +-
 drivers/hwmon/pmbus/isl68137.c                     | 114 ++++-
 drivers/hwmon/pmbus/lm25066.c                      |  39 +-
 drivers/hwmon/pmbus/ltc2978.c                      | 130 ++++-
 drivers/hwmon/pmbus/ltc3815.c                      |  20 +-
 drivers/hwmon/pmbus/max16064.c                     |   7 +-
 drivers/hwmon/pmbus/max20730.c                     |   3 +-
 drivers/hwmon/pmbus/max31785.c                     |   6 +-
 drivers/hwmon/pmbus/max34440.c                     |  25 +-
 drivers/hwmon/pmbus/max8688.c                      |  17 +-
 drivers/hwmon/pmbus/pmbus.c                        |   4 +-
 drivers/hwmon/pmbus/pmbus.h                        |  20 +-
 drivers/hwmon/pmbus/pmbus_core.c                   | 119 +++--
 drivers/hwmon/pmbus/tps53679.c                     | 172 ++++++-
 drivers/hwmon/pmbus/ucd9000.c                      |   2 +-
 drivers/hwmon/pmbus/xdpe12284.c                    |   5 +-
 drivers/hwmon/pmbus/zl6100.c                       |   5 +-
 41 files changed, 2325 insertions(+), 311 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/adi,axi-fan-control.yaml
 create mode 100644 Documentation/devicetree/bindings/hwmon/adt7475.yaml
 create mode 100644 Documentation/hwmon/tps53679.rst
 create mode 100644 drivers/hwmon/axi-fan-control.c
