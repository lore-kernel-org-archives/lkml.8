Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2344FC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 23:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0278220842
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 23:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4Ra0Sg9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgHDXaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 19:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbgHDXaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 19:30:06 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCF9C06174A;
        Tue,  4 Aug 2020 16:30:06 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d188so15556173pfd.2;
        Tue, 04 Aug 2020 16:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=/PLnMdZ7nugbg5r5613ggouSlqIxD3KRDXk4wXbo0h8=;
        b=m4Ra0Sg96mN49VmAFMbb9sdTG4FyPW5i7EKH6ntsNYe5lXz3vu5L3PPngA9CsLf6O6
         GP02ksheTYm5WCrCv/Wxxan3koy+6mI8pQ1iu3cB58YdiHp1Z8HIiGZ4ZTVMmV0UFPfu
         eFhhRMJz0J57z4P6ikLGiF82U1suQwfYD/2T+0dg6w1CWBYesTA6m/TESy2Wugzh3IYc
         eAKj9MrboIsYRk4ZBQAJGlVxVxcW59tt8npiXkXKotVAYnW+D1ud93fGs3T8F7aK3suX
         hLuV/lks+h0MSeirMk3av0IsdMyN0nq6r0KBTrMT5c6cPFWnQsLb2PyUdovPPqRh2jKR
         oCKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=/PLnMdZ7nugbg5r5613ggouSlqIxD3KRDXk4wXbo0h8=;
        b=GDgDkPVCfFP9zFAWkABUeknrD6eOIMTqweBPPUw1fpaPDPDk+fgeQLwgkXHXl2P02d
         znHa9FhiAhpdPtPVjZ57yTjXfE5XpwBWewuumEHiHBsk0ao+rMjWEdoXPZzm4+kiRTQq
         2nIELZiIVSLsTJ1QZqvGoa80vRJDUmZUh0fhXnm0lYTMr7tNQQODaSmEb4c5kLJ7OOXM
         CepAjArrWQED2oqfbnqGelN84pmi24obJn1VnaXThcRadnOPPefqjH1SyliS7LMnG/HE
         h/n2pESkd+5/pFESrMe6xLfd6ZoQr5SDnUt87YCJ4X5gBi0s9FO+a8CSf9/miycprh8O
         ycag==
X-Gm-Message-State: AOAM533ddrHzCVAnI93UkJ5n9l1fC588fXNJpsau4S9O1pISXw+7nOxv
        0g9RAHPyxztZabmcoBl06Mycnw4X
X-Google-Smtp-Source: ABdhPJy3r3XXlEpAesRT+kn/ee/VrvecVGLa+pN+m+a4PvxAMOhcDNer1I6L/hEc7esd1phjP49NCA==
X-Received: by 2002:a63:eb42:: with SMTP id b2mr649842pgk.173.1596583805422;
        Tue, 04 Aug 2020 16:30:05 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y10sm208383pff.177.2020.08.04.16.30.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Aug 2020 16:30:04 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon updates for v5.9
Date:   Tue,  4 Aug 2020 16:30:02 -0700
Message-Id: <20200804233002.230586-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull hwmon updates for Linux v5.9 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v5.9

Thanks,
Guenter
------

The following changes since commit ba47d845d715a010f7b51f6f89bae32845e6acb7:

  Linux 5.8-rc6 (2020-07-19 15:41:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v5.9

for you to fetch changes up to e2f75e6b5d766195d2ca584d92995a0dfe467fc7:

  hwmon: (adc128d818) Fix advanced configuration register init (2020-08-04 14:28:03 -0700)

----------------------------------------------------------------
hwmon updates for v5.9

Highlights:
- New driver for Sparx5 SoC temperature sensot
- New driver for Corsair Commander Pro
- MAX20710 support added to max20730 driver

Enhancements:
- max6697: Allow max6581 to create tempX_offset attributes
- gsc (Gateworks System Controller): add 16bit pre-scaled voltage mode
- adm1275: Enable adm1278 ADM1278_TEMP1_EN
- dell-smm: Add Latitude 5480 to fan control whitelist

Fixes:
- adc128d818: Fix advanced configuration register init
- pmbus/core: Use s64 instead of long for calculations
              to fix overflow issues with 32-bit architectures

Plus various cleanups in several drivers.

----------------------------------------------------------------
Alexander A. Klimov (11):
      hwmon: (tmmp513) Replace HTTP links with HTTPS links
      hwmon: (adm1025) Replace HTTP links with HTTPS ones
      docs: hwmon: Replace HTTP links with HTTPS ones
      hwmon: Replace HTTP links with HTTPS ones
      hwmon: (ina209) Replace HTTP links with HTTPS ones
      hwmon: (ina2xx) Replace HTTP links with HTTPS ones
      hwmon: (jc42) Replace HTTP links with HTTPS ones
      hwmon: (k8temp) Replace HTTP links with HTTPS ones
      hwmon: (lm90) Replace HTTP links with HTTPS ones
      hwmon: (lm95234) Replace HTTP links with HTTPS ones
      hwmon: (tmp401) Replace HTTP links with HTTPS ones

Alexandru Ardelean (1):
      hwmon: (axi-fan-control) remove duplicate macros

Chu Lin (1):
      hwmon: (max6697) Allow max6581 to create tempX_offset

Colin Ian King (1):
      hwmon: (i5k_amb) remove redundant assignment to variable res

Jeffrey Lin (1):
      hwmon: (dell-smm) Add Latitude 5480 to fan control whitelist

Josh Lehan (1):
      hwmon: (pmbus/core) Use s64 instead of long for calculations

Lars Povlsen (2):
      dt-bindings: hwmon: Add Sparx5 temperature sensor
      hwmon: sparx5: Add Sparx5 SoC temperature driver

Manikandan Elumalai (1):
      hwmon: (adm1275) Enable adm1278 ADM1278_TEMP1_EN

Marius Zachmann (2):
      hwmon: add Corsair Commander Pro driver
      hwmon: (corsair-cpro) add reading pwm values

Randy Dunlap (5):
      Documentation: hwmon/f71882fg: drop duplicate words
      Documentation: hwmon/lm93: drop duplicate words
      Documentation: hwmon/nct7665: drop duplicate words
      Documentation: hwmon/w83627ehf: drop duplicate words
      Documentation: hwmon/w83l786ng: drop duplicate words

Roy van Doormaal (1):
      hwmon: (adc128d818) Fix advanced configuration register init

Saheed O. Bolarinwa (1):
      hwmon: (i5k_amb, vt8231) Drop uses of pci_read_config_*() return value

Tim Harvey (1):
      hwmon: (gsc) add 16bit pre-scaled voltage mode

Ugur Usug (1):
      hwmon: (pmbus/max20730) Add max20710 support

Wang Qing (1):
      hwmon: (nct6683) Replace container_of() with  kobj_to_dev()

Wei Yongjun (1):
      hwmon: (sparx5) Make symbol 's5_temp_match' static

 .../bindings/hwmon/microchip,sparx5-temp.yaml      |  44 ++
 .../devicetree/bindings/hwmon/ti,tmp513.yaml       |   4 +-
 Documentation/hwmon/adc128d818.rst                 |   2 +-
 Documentation/hwmon/adm1026.rst                    |   2 +-
 Documentation/hwmon/adm1031.rst                    |   4 +-
 Documentation/hwmon/adm1275.rst                    |   2 +-
 Documentation/hwmon/adt7410.rst                    |   8 +-
 Documentation/hwmon/corsair-cpro.rst               |  41 ++
 Documentation/hwmon/emc1403.rst                    |   6 +-
 Documentation/hwmon/f71882fg.rst                   |   2 +-
 Documentation/hwmon/ina209.rst                     |   2 +-
 Documentation/hwmon/ina2xx.rst                     |  10 +-
 Documentation/hwmon/ina3221.rst                    |   2 +-
 Documentation/hwmon/index.rst                      |   1 +
 Documentation/hwmon/jc42.rst                       |  26 +-
 Documentation/hwmon/k8temp.rst                     |   2 +-
 Documentation/hwmon/lm25066.rst                    |   6 +-
 Documentation/hwmon/lm63.rst                       |   2 +-
 Documentation/hwmon/lm70.rst                       |   6 +-
 Documentation/hwmon/lm73.rst                       |   2 +-
 Documentation/hwmon/lm75.rst                       |  26 +-
 Documentation/hwmon/lm85.rst                       |   8 +-
 Documentation/hwmon/lm87.rst                       |   2 +-
 Documentation/hwmon/lm90.rst                       |  10 +-
 Documentation/hwmon/lm93.rst                       |   2 +-
 Documentation/hwmon/lm95234.rst                    |   4 +-
 Documentation/hwmon/lm95245.rst                    |   4 +-
 Documentation/hwmon/ltc2978.rst                    |   6 +-
 Documentation/hwmon/max20730.rst                   |  10 +-
 Documentation/hwmon/max20751.rst                   |   4 +-
 Documentation/hwmon/max31790.rst                   |   2 +-
 Documentation/hwmon/max34440.rst                   |  12 +-
 Documentation/hwmon/nct6775.rst                    |   2 +-
 Documentation/hwmon/pmbus.rst                      |  16 +-
 Documentation/hwmon/sht21.rst                      |   4 +-
 Documentation/hwmon/shtc1.rst                      |   6 +-
 Documentation/hwmon/sparx5-temp.rst                |  33 ++
 Documentation/hwmon/thmc50.rst                     |   2 +-
 Documentation/hwmon/tmp103.rst                     |   2 +-
 Documentation/hwmon/tmp108.rst                     |   2 +-
 Documentation/hwmon/tmp401.rst                     |   2 +-
 Documentation/hwmon/tmp421.rst                     |   4 +-
 Documentation/hwmon/tmp513.rst                     |   4 +-
 Documentation/hwmon/tps40422.rst                   |   2 +-
 Documentation/hwmon/tps53679.rst                   |   8 +-
 Documentation/hwmon/w83627ehf.rst                  |   2 +-
 Documentation/hwmon/w83781d.rst                    |   2 +-
 Documentation/hwmon/w83l786ng.rst                  |   2 +-
 MAINTAINERS                                        |   6 +
 drivers/hwmon/Kconfig                              |  20 +
 drivers/hwmon/Makefile                             |   2 +
 drivers/hwmon/adc128d818.c                         |  24 +-
 drivers/hwmon/adm1025.c                            |   2 +-
 drivers/hwmon/adm1026.c                            |   2 +-
 drivers/hwmon/axi-fan-control.c                    |   4 -
 drivers/hwmon/corsair-cpro.c                       | 582 +++++++++++++++++++++
 drivers/hwmon/dell-smm-hwmon.c                     |   8 +
 drivers/hwmon/gsc-hwmon.c                          |   8 +-
 drivers/hwmon/hwmon-vid.c                          |   6 +-
 drivers/hwmon/i5k_amb.c                            |  14 +-
 drivers/hwmon/ina209.c                             |   2 +-
 drivers/hwmon/ina2xx.c                             |  10 +-
 drivers/hwmon/ina3221.c                            |   2 +-
 drivers/hwmon/lm87.c                               |   2 +-
 drivers/hwmon/max6697.c                            |  96 +++-
 drivers/hwmon/nct6683.c                            |   8 +-
 drivers/hwmon/pmbus/Kconfig                        |   4 +-
 drivers/hwmon/pmbus/adm1275.c                      |  13 +-
 drivers/hwmon/pmbus/max20730.c                     |  49 +-
 drivers/hwmon/pmbus/pmbus_core.c                   |  66 ++-
 drivers/hwmon/powr1220.c                           |   2 +-
 drivers/hwmon/sht21.c                              |   2 +-
 drivers/hwmon/sparx5-temp.c                        | 168 ++++++
 drivers/hwmon/tmp513.c                             |   4 +-
 drivers/hwmon/vt8231.c                             |   8 +-
 include/linux/platform_data/gsc_hwmon.h            |   3 +-
 76 files changed, 1257 insertions(+), 217 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/microchip,sparx5-temp.yaml
 create mode 100644 Documentation/hwmon/corsair-cpro.rst
 create mode 100644 Documentation/hwmon/sparx5-temp.rst
 create mode 100644 drivers/hwmon/corsair-cpro.c
 create mode 100644 drivers/hwmon/sparx5-temp.c
