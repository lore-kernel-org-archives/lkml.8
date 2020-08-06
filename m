Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2634BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AFDB206B5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596738984;
	bh=Td+BuxAy7EkKamK9YgFeqqMp2DT1o2HviE8ac3qvCEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ho6uNvq/8ByJhCNjcj9qZntZoFFcKBZpR8EwLhgRiGuON+2tBXuyvJbecmbgFbxik
	 zwh5kGFS2ADJ5yZb2wO08sA/MebT2cx1y/ik2WHaCBLU9GG1ZBgA92EQzzTQrNFUrS
	 WdRyMDiFG2HiQ29lUlDXoiu4mBPOVyhTzXdoh9Dw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729425AbgHFSgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 14:36:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:58936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729332AbgHFSgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 14:36:17 -0400
Received: from localhost.localdomain (unknown [194.230.155.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE70B22D00;
        Thu,  6 Aug 2020 18:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596738305;
        bh=Td+BuxAy7EkKamK9YgFeqqMp2DT1o2HviE8ac3qvCEg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hD+CMjM1Sxsz6GqJjr5yy7fVabiMuJzgPeL2XAa6iTJmLD3KakwEsChzDgOClJClP
         Tz9Iv3wYEqL0EU9gap1GyYbaSI6ug7Z84/9Tgboq/gNYla68LMpi4YB9Mag0wCCRic
         gYgaf3vQyPU+mOwVdSHNtsJXiqYHXS+Vtqh0b5Ik=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Kukjin Kim <kgene@kernel.org>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, patches@opensource.cirrus.com,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 39/41] ARM: s3c: move into a common directory
Date:   Thu,  6 Aug 2020 20:20:56 +0200
Message-Id: <20200806182059.2431-39-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806181932.2253-1-krzk@kernel.org>
References: <20200806181932.2253-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

s3c24xx and s3c64xx have a lot in common, but are split across three
separate directories, which makes the interaction of the header files
more complicated than necessary.

Move all three directories into a new mach-s3c, with a minimal
set of changes to each file.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
[krzk: Rebase, add s3c24xx and s3c64xx suffix to several files, add SPDX
       headers to new files, remove plat-samsung from MAINTAINERS]
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Add s3c24xx and s3c64xx suffix to several files (headers and source
   files),
2. Add SPDX headers to newly created files,
3. Remove plat-samsung from MAINTAINERS.
---
 MAINTAINERS                                   | 16 ++++------
 arch/arm/Kconfig                              |  5 +--
 arch/arm/Makefile                             |  5 +--
 arch/arm/{plat-samsung => mach-s3c}/Kconfig   |  3 ++
 .../Kconfig => mach-s3c/Kconfig.s3c24xx}      |  0
 .../Kconfig => mach-s3c/Kconfig.s3c64xx}      |  0
 arch/arm/{plat-samsung => mach-s3c}/Makefile  |  9 +++++-
 .../{mach-s3c24xx => mach-s3c}/Makefile.boot  |  0
 .../Makefile => mach-s3c/Makefile.s3c24xx}    | 20 ++++++------
 .../Makefile => mach-s3c/Makefile.s3c64xx}    | 32 +++++++++----------
 arch/arm/{plat-samsung => mach-s3c}/adc.c     |  0
 arch/arm/{mach-s3c24xx => mach-s3c}/anubis.h  |  0
 .../ata-core-s3c64xx.h}                       |  6 ++--
 .../backlight-s3c64xx.h}                      |  6 ++--
 .../arm/{mach-s3c24xx => mach-s3c}/bast-ide.c |  0
 .../arm/{mach-s3c24xx => mach-s3c}/bast-irq.c |  0
 arch/arm/{mach-s3c24xx => mach-s3c}/bast.h    |  0
 .../common-smdk-s3c24xx.c}                    |  2 +-
 .../common-smdk-s3c24xx.h}                    |  0
 arch/arm/{plat-samsung => mach-s3c}/cpu.c     |  0
 .../cpufreq-utils-s3c24xx.c}                  |  2 +-
 .../cpuidle.c => mach-s3c/cpuidle-s3c64xx.c}  |  4 +--
 .../arm/{mach-s3c64xx => mach-s3c}/crag6410.h |  0
 .../dev-audio-s3c64xx.c}                      |  0
 .../dev-backlight-s3c64xx.c}                  |  2 +-
 .../dev-uart-s3c64xx.c}                       |  0
 .../arm/{plat-samsung => mach-s3c}/dev-uart.c |  0
 arch/arm/{plat-samsung => mach-s3c}/devs.c    |  0
 .../fb-core.h => mach-s3c/fb-core-s3c24xx.h}  |  6 ++--
 .../{plat-samsung => mach-s3c}/gpio-samsung.c |  0
 arch/arm/{mach-s3c24xx => mach-s3c}/gta02.h   |  0
 .../h1940-bluetooth.c                         |  0
 arch/arm/{mach-s3c24xx => mach-s3c}/h1940.h   |  0
 .../include/mach/dma-s3c24xx.h}               |  0
 .../include/mach/dma-s3c64xx.h}               |  0
 arch/arm/mach-s3c/include/mach/dma.h          |  9 ++++++
 .../include/mach/gpio-samsung-s3c24xx.h}      |  0
 .../include/mach/gpio-samsung-s3c64xx.h}      |  0
 arch/arm/mach-s3c/include/mach/gpio-samsung.h |  9 ++++++
 .../include/mach/hardware-s3c24xx.h}          |  6 ++--
 .../include/mach/io-s3c24xx.h}                |  4 +--
 arch/arm/mach-s3c/include/mach/io.h           |  8 +++++
 .../include/mach/irqs-s3c24xx.h}              |  0
 .../include/mach/irqs-s3c64xx.h}              |  0
 arch/arm/mach-s3c/include/mach/irqs.h         |  9 ++++++
 .../include/mach/map-s3c24xx.h}               |  0
 .../include/mach/map-s3c64xx.h}               |  0
 arch/arm/mach-s3c/include/mach/map.h          |  9 ++++++
 .../include/mach/pm-core-s3c24xx.h}           |  2 +-
 .../include/mach/pm-core-s3c64xx.h}           |  0
 arch/arm/mach-s3c/include/mach/pm-core.h      |  9 ++++++
 .../include/mach/regs-clock-s3c24xx.h}        |  0
 .../include/mach/regs-clock-s3c64xx.h}        |  0
 arch/arm/mach-s3c/include/mach/regs-clock.h   |  9 ++++++
 .../include/mach/regs-gpio-s3c24xx.h}         |  0
 .../include/mach/regs-gpio-s3c64xx.h}         |  0
 arch/arm/mach-s3c/include/mach/regs-gpio.h    |  9 ++++++
 .../include/mach/regs-irq-s3c24xx.h}          |  0
 .../include/mach/regs-irq-s3c64xx.h}          |  0
 arch/arm/mach-s3c/include/mach/regs-irq.h     |  9 ++++++
 .../include/mach/regs-s3c2443-clock.h         |  0
 .../include/mach/rtc-core-s3c24xx.h}          |  6 ++--
 .../include/mach/s3c2412.h                    |  0
 .../include/plat/adc-core.h                   |  0
 .../include/plat/cpu.h                        |  0
 .../include/plat/devs.h                       |  0
 .../include/plat/fb.h                         |  0
 .../include/plat/gpio-cfg-helpers.h           |  0
 .../include/plat/gpio-cfg.h                   |  0
 .../include/plat/gpio-core.h                  |  0
 .../include/plat/iic-core.h                   |  0
 .../include/plat/keypad.h                     |  0
 .../include/plat/map-base.h                   |  0
 .../include/plat/map-s3c.h                    |  0
 .../include/plat/map-s5p.h                    |  0
 .../include/plat/pm-common.h                  |  0
 .../include/plat/pm.h                         |  0
 .../include/plat/pwm-core.h                   |  0
 .../include/plat/regs-adc.h                   |  0
 .../include/plat/regs-irqtype.h               |  0
 .../include/plat/sdhci.h                      |  0
 .../include/plat/usb-phy.h                    |  0
 .../include/plat/wakeup-mask.h                |  0
 arch/arm/{plat-samsung => mach-s3c}/init.c    |  0
 .../iotiming-s3c2410.c                        |  2 +-
 .../iotiming-s3c2412.c                        |  0
 .../irq-pm.c => mach-s3c/irq-pm-s3c24xx.c}    |  0
 .../irq-pm.c => mach-s3c/irq-pm-s3c64xx.c}    |  0
 .../irq-s3c24xx-fiq-exports.c                 |  0
 .../irq-s3c24xx-fiq.S                         |  0
 .../{mach-s3c24xx => mach-s3c}/irq-s3c24xx.c  |  0
 .../irq-uart-s3c64xx.h}                       |  0
 .../mach-amlm5900.c                           |  2 +-
 .../{mach-s3c24xx => mach-s3c}/mach-anubis.c  |  2 +-
 .../{mach-s3c64xx => mach-s3c}/mach-anw6410.c |  4 +--
 .../mach-at2440evb.c                          |  2 +-
 .../{mach-s3c24xx => mach-s3c}/mach-bast.c    |  2 +-
 .../mach-crag6410-module.c                    |  0
 .../mach-crag6410.c                           |  8 ++---
 .../{mach-s3c24xx => mach-s3c}/mach-gta02.c   |  2 +-
 .../{mach-s3c24xx => mach-s3c}/mach-h1940.c   |  4 +--
 .../arm/{mach-s3c64xx => mach-s3c}/mach-hmt.c |  2 +-
 .../{mach-s3c24xx => mach-s3c}/mach-jive.c    |  4 +--
 .../mach-mini2440.c                           |  2 +-
 .../mach-mini6410.c                           |  6 ++--
 .../arm/{mach-s3c24xx => mach-s3c}/mach-n30.c |  4 +--
 .../arm/{mach-s3c64xx => mach-s3c}/mach-ncp.c |  2 +-
 .../mach-nexcoder.c                           |  2 +-
 .../mach-osiris-dvs.c                         |  0
 .../{mach-s3c24xx => mach-s3c}/mach-osiris.c  |  4 +--
 .../{mach-s3c24xx => mach-s3c}/mach-otom.c    |  2 +-
 .../{mach-s3c24xx => mach-s3c}/mach-qt2410.c  |  4 +--
 .../mach-real6410.c                           |  6 ++--
 .../{mach-s3c24xx => mach-s3c}/mach-rx1950.c  |  4 +--
 .../{mach-s3c24xx => mach-s3c}/mach-rx3715.c  |  2 +-
 .../mach-s3c2416-dt.c                         |  2 +-
 .../mach-s3c64xx-dt.c                         |  2 +-
 .../{mach-s3c64xx => mach-s3c}/mach-smartq.c  |  4 +--
 .../{mach-s3c64xx => mach-s3c}/mach-smartq.h  |  0
 .../{mach-s3c64xx => mach-s3c}/mach-smartq5.c |  2 +-
 .../{mach-s3c64xx => mach-s3c}/mach-smartq7.c |  2 +-
 .../mach-smdk2410.c                           |  4 +--
 .../mach-smdk2413.c                           |  6 ++--
 .../mach-smdk2416.c                           |  6 ++--
 .../mach-smdk2440.c                           |  4 +--
 .../mach-smdk2443.c                           |  4 +--
 .../mach-smdk6400.c                           |  2 +-
 .../mach-smdk6410.c                           | 10 +++---
 .../mach-tct_hammer.c                         |  2 +-
 .../{mach-s3c24xx => mach-s3c}/mach-vr1000.c  |  2 +-
 .../{mach-s3c24xx => mach-s3c}/mach-vstms.c   |  2 +-
 .../nand-core-s3c24xx.h}                      |  6 ++--
 .../onenand-core-s3c64xx.h}                   |  6 ++--
 arch/arm/{mach-s3c24xx => mach-s3c}/osiris.h  |  0
 arch/arm/{mach-s3c24xx => mach-s3c}/otom.h    |  0
 arch/arm/{mach-s3c64xx => mach-s3c}/pl080.c   |  2 +-
 .../{plat-samsung => mach-s3c}/platformdata.c |  0
 .../{mach-s3c24xx => mach-s3c}/pll-s3c2410.c  |  0
 .../pll-s3c2440-12000000.c                    |  0
 .../pll-s3c2440-16934400.c                    |  0
 .../{plat-samsung => mach-s3c}/pm-common.c    |  0
 arch/arm/{plat-samsung => mach-s3c}/pm-gpio.c |  0
 .../arm/{mach-s3c24xx => mach-s3c}/pm-h1940.S |  0
 .../{mach-s3c24xx => mach-s3c}/pm-s3c2410.c   |  0
 .../{mach-s3c24xx => mach-s3c}/pm-s3c2412.c   |  2 +-
 .../{mach-s3c24xx => mach-s3c}/pm-s3c2416.c   |  0
 .../pm.c => mach-s3c/pm-s3c24xx.c}            |  2 +-
 .../pm.c => mach-s3c/pm-s3c64xx.c}            |  8 ++---
 arch/arm/{plat-samsung => mach-s3c}/pm.c      |  0
 .../regs-dsc-s3c24xx.h}                       |  6 ++--
 .../regs-gpio-memport-s3c64xx.h}              |  0
 .../regs-mem-s3c24xx.h}                       |  0
 .../regs-modem-s3c64xx.h}                     |  0
 .../regs-srom-s3c64xx.h}                      |  0
 .../regs-sys-s3c64xx.h}                       |  0
 .../regs-syscon-power-s3c64xx.h}              |  0
 .../regs-usb-hsotg-phy-s3c64xx.h}             |  0
 arch/arm/{mach-s3c24xx => mach-s3c}/s3c2410.c |  2 +-
 .../s3c2412-power.h                           |  0
 arch/arm/{mach-s3c24xx => mach-s3c}/s3c2412.c |  6 ++--
 arch/arm/{mach-s3c24xx => mach-s3c}/s3c2416.c | 10 +++---
 arch/arm/{mach-s3c24xx => mach-s3c}/s3c2440.c |  2 +-
 arch/arm/{mach-s3c24xx => mach-s3c}/s3c2442.c |  2 +-
 arch/arm/{mach-s3c24xx => mach-s3c}/s3c2443.c | 10 +++---
 arch/arm/{mach-s3c24xx => mach-s3c}/s3c244x.c |  6 ++--
 .../common.c => mach-s3c/s3c24xx.c}           |  4 +--
 .../common.h => mach-s3c/s3c24xx.h}           |  0
 arch/arm/{mach-s3c64xx => mach-s3c}/s3c6400.c |  4 +--
 arch/arm/{mach-s3c64xx => mach-s3c}/s3c6410.c |  6 ++--
 .../common.c => mach-s3c/s3c64xx.c}           |  4 +--
 .../common.h => mach-s3c/s3c64xx.h}           |  0
 .../setup-camif-s3c24xx.c}                    |  0
 .../setup-fb-24bpp-s3c64xx.c}                 |  0
 .../setup-i2c-s3c24xx.c}                      |  0
 .../setup-i2c0-s3c64xx.c}                     |  0
 .../setup-i2c1-s3c64xx.c}                     |  0
 .../setup-ide-s3c64xx.c}                      |  0
 .../setup-keypad-s3c64xx.c}                   |  0
 .../setup-sdhci-gpio-s3c24xx.c}               |  0
 .../setup-sdhci-gpio-s3c64xx.c}               |  0
 .../setup-spi-s3c24xx.c}                      |  2 +-
 .../setup-spi-s3c64xx.c}                      |  0
 .../setup-ts-s3c24xx.c}                       |  0
 .../setup-usb-phy-s3c64xx.c}                  |  4 +--
 .../{mach-s3c24xx => mach-s3c}/simtec-audio.c |  0
 .../{mach-s3c24xx => mach-s3c}/simtec-nor.c   |  0
 .../{mach-s3c24xx => mach-s3c}/simtec-pm.c    |  2 +-
 .../{mach-s3c24xx => mach-s3c}/simtec-usb.c   |  0
 arch/arm/{mach-s3c24xx => mach-s3c}/simtec.h  |  0
 .../sleep-s3c2410.S                           |  2 +-
 .../sleep-s3c2412.S                           |  0
 .../sleep.S => mach-s3c/sleep-s3c24xx.S}      |  0
 .../sleep.S => mach-s3c/sleep-s3c64xx.S}      |  0
 .../spi-core-s3c24xx.h}                       |  6 ++--
 arch/arm/{mach-s3c24xx => mach-s3c}/vr1000.h  |  0
 .../{plat-samsung => mach-s3c}/wakeup-mask.c  |  0
 196 files changed, 264 insertions(+), 182 deletions(-)
 rename arch/arm/{plat-samsung => mach-s3c}/Kconfig (98%)
 rename arch/arm/{mach-s3c24xx/Kconfig => mach-s3c/Kconfig.s3c24xx} (100%)
 rename arch/arm/{mach-s3c64xx/Kconfig => mach-s3c/Kconfig.s3c64xx} (100%)
 rename arch/arm/{plat-samsung => mach-s3c}/Makefile (82%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/Makefile.boot (100%)
 rename arch/arm/{mach-s3c24xx/Makefile => mach-s3c/Makefile.s3c24xx} (84%)
 rename arch/arm/{mach-s3c64xx/Makefile => mach-s3c/Makefile.s3c64xx} (58%)
 rename arch/arm/{plat-samsung => mach-s3c}/adc.c (100%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/anubis.h (100%)
 rename arch/arm/{mach-s3c64xx/ata-core.h => mach-s3c/ata-core-s3c64xx.h} (78%)
 rename arch/arm/{mach-s3c64xx/backlight.h => mach-s3c/backlight-s3c64xx.h} (78%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/bast-ide.c (100%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/bast-irq.c (100%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/bast.h (100%)
 rename arch/arm/{mach-s3c24xx/common-smdk.c => mach-s3c/common-smdk-s3c24xx.c} (99%)
 rename arch/arm/{mach-s3c24xx/common-smdk.h => mach-s3c/common-smdk-s3c24xx.h} (100%)
 rename arch/arm/{plat-samsung => mach-s3c}/cpu.c (100%)
 rename arch/arm/{mach-s3c24xx/cpufreq-utils.c => mach-s3c/cpufreq-utils-s3c24xx.c} (98%)
 rename arch/arm/{mach-s3c64xx/cpuidle.c => mach-s3c/cpuidle-s3c64xx.c} (94%)
 rename arch/arm/{mach-s3c64xx => mach-s3c}/crag6410.h (100%)
 rename arch/arm/{mach-s3c64xx/dev-audio.c => mach-s3c/dev-audio-s3c64xx.c} (100%)
 rename arch/arm/{mach-s3c64xx/dev-backlight.c => mach-s3c/dev-backlight-s3c64xx.c} (99%)
 rename arch/arm/{mach-s3c64xx/dev-uart.c => mach-s3c/dev-uart-s3c64xx.c} (100%)
 rename arch/arm/{plat-samsung => mach-s3c}/dev-uart.c (100%)
 rename arch/arm/{plat-samsung => mach-s3c}/devs.c (100%)
 rename arch/arm/{mach-s3c24xx/fb-core.h => mach-s3c/fb-core-s3c24xx.h} (78%)
 rename arch/arm/{plat-samsung => mach-s3c}/gpio-samsung.c (100%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/gta02.h (100%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/h1940-bluetooth.c (100%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/h1940.h (100%)
 rename arch/arm/{mach-s3c24xx/include/mach/dma.h => mach-s3c/include/mach/dma-s3c24xx.h} (100%)
 rename arch/arm/{mach-s3c64xx/include/mach/dma.h => mach-s3c/include/mach/dma-s3c64xx.h} (100%)
 create mode 100644 arch/arm/mach-s3c/include/mach/dma.h
 rename arch/arm/{mach-s3c24xx/include/mach/gpio-samsung.h => mach-s3c/include/mach/gpio-samsung-s3c24xx.h} (100%)
 rename arch/arm/{mach-s3c64xx/include/mach/gpio-samsung.h => mach-s3c/include/mach/gpio-samsung-s3c64xx.h} (100%)
 create mode 100644 arch/arm/mach-s3c/include/mach/gpio-samsung.h
 rename arch/arm/{mach-s3c24xx/include/mach/hardware.h => mach-s3c/include/mach/hardware-s3c24xx.h} (65%)
 rename arch/arm/{mach-s3c24xx/include/mach/io.h => mach-s3c/include/mach/io-s3c24xx.h} (94%)
 create mode 100644 arch/arm/mach-s3c/include/mach/io.h
 rename arch/arm/{mach-s3c24xx/include/mach/irqs.h => mach-s3c/include/mach/irqs-s3c24xx.h} (100%)
 rename arch/arm/{mach-s3c64xx/include/mach/irqs.h => mach-s3c/include/mach/irqs-s3c64xx.h} (100%)
 create mode 100644 arch/arm/mach-s3c/include/mach/irqs.h
 rename arch/arm/{mach-s3c24xx/include/mach/map.h => mach-s3c/include/mach/map-s3c24xx.h} (100%)
 rename arch/arm/{mach-s3c64xx/include/mach/map.h => mach-s3c/include/mach/map-s3c64xx.h} (100%)
 create mode 100644 arch/arm/mach-s3c/include/mach/map.h
 rename arch/arm/{mach-s3c24xx/include/mach/pm-core.h => mach-s3c/include/mach/pm-core-s3c24xx.h} (98%)
 rename arch/arm/{mach-s3c64xx/include/mach/pm-core.h => mach-s3c/include/mach/pm-core-s3c64xx.h} (100%)
 create mode 100644 arch/arm/mach-s3c/include/mach/pm-core.h
 rename arch/arm/{mach-s3c24xx/include/mach/regs-clock.h => mach-s3c/include/mach/regs-clock-s3c24xx.h} (100%)
 rename arch/arm/{mach-s3c64xx/include/mach/regs-clock.h => mach-s3c/include/mach/regs-clock-s3c64xx.h} (100%)
 create mode 100644 arch/arm/mach-s3c/include/mach/regs-clock.h
 rename arch/arm/{mach-s3c24xx/include/mach/regs-gpio.h => mach-s3c/include/mach/regs-gpio-s3c24xx.h} (100%)
 rename arch/arm/{mach-s3c64xx/include/mach/regs-gpio.h => mach-s3c/include/mach/regs-gpio-s3c64xx.h} (100%)
 create mode 100644 arch/arm/mach-s3c/include/mach/regs-gpio.h
 rename arch/arm/{mach-s3c24xx/include/mach/regs-irq.h => mach-s3c/include/mach/regs-irq-s3c24xx.h} (100%)
 rename arch/arm/{mach-s3c64xx/include/mach/regs-irq.h => mach-s3c/include/mach/regs-irq-s3c64xx.h} (100%)
 create mode 100644 arch/arm/mach-s3c/include/mach/regs-irq.h
 rename arch/arm/{mach-s3c24xx => mach-s3c}/include/mach/regs-s3c2443-clock.h (100%)
 rename arch/arm/{mach-s3c24xx/include/mach/rtc-core.h => mach-s3c/include/mach/rtc-core-s3c24xx.h} (81%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/include/mach/s3c2412.h (100%)
 rename arch/arm/{plat-samsung => mach-s3c}/include/plat/adc-core.h (100%)
 rename arch/arm/{plat-samsung => mach-s3c}/include/plat/cpu.h (100%)
 rename arch/arm/{plat-samsung => mach-s3c}/include/plat/devs.h (100%)
 rename arch/arm/{plat-samsung => mach-s3c}/include/plat/fb.h (100%)
 rename arch/arm/{plat-samsung => mach-s3c}/include/plat/gpio-cfg-helpers.h (100%)
 rename arch/arm/{plat-samsung => mach-s3c}/include/plat/gpio-cfg.h (100%)
 rename arch/arm/{plat-samsung => mach-s3c}/include/plat/gpio-core.h (100%)
 rename arch/arm/{plat-samsung => mach-s3c}/include/plat/iic-core.h (100%)
 rename arch/arm/{plat-samsung => mach-s3c}/include/plat/keypad.h (100%)
 rename arch/arm/{plat-samsung => mach-s3c}/include/plat/map-base.h (100%)
 rename arch/arm/{plat-samsung => mach-s3c}/include/plat/map-s3c.h (100%)
 rename arch/arm/{plat-samsung => mach-s3c}/include/plat/map-s5p.h (100%)
 rename arch/arm/{plat-samsung => mach-s3c}/include/plat/pm-common.h (100%)
 rename arch/arm/{plat-samsung => mach-s3c}/include/plat/pm.h (100%)
 rename arch/arm/{plat-samsung => mach-s3c}/include/plat/pwm-core.h (100%)
 rename arch/arm/{plat-samsung => mach-s3c}/include/plat/regs-adc.h (100%)
 rename arch/arm/{plat-samsung => mach-s3c}/include/plat/regs-irqtype.h (100%)
 rename arch/arm/{plat-samsung => mach-s3c}/include/plat/sdhci.h (100%)
 rename arch/arm/{plat-samsung => mach-s3c}/include/plat/usb-phy.h (100%)
 rename arch/arm/{plat-samsung => mach-s3c}/include/plat/wakeup-mask.h (100%)
 rename arch/arm/{plat-samsung => mach-s3c}/init.c (100%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/iotiming-s3c2410.c (99%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/iotiming-s3c2412.c (100%)
 rename arch/arm/{mach-s3c24xx/irq-pm.c => mach-s3c/irq-pm-s3c24xx.c} (100%)
 rename arch/arm/{mach-s3c64xx/irq-pm.c => mach-s3c/irq-pm-s3c64xx.c} (100%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/irq-s3c24xx-fiq-exports.c (100%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/irq-s3c24xx-fiq.S (100%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/irq-s3c24xx.c (100%)
 rename arch/arm/{mach-s3c64xx/irq-uart.h => mach-s3c/irq-uart-s3c64xx.h} (100%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/mach-amlm5900.c (99%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/mach-anubis.c (99%)
 rename arch/arm/{mach-s3c64xx => mach-s3c}/mach-anw6410.c (99%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/mach-at2440evb.c (99%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/mach-bast.c (99%)
 rename arch/arm/{mach-s3c64xx => mach-s3c}/mach-crag6410-module.c (100%)
 rename arch/arm/{mach-s3c64xx => mach-s3c}/mach-crag6410.c (99%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/mach-gta02.c (99%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/mach-h1940.c (99%)
 rename arch/arm/{mach-s3c64xx => mach-s3c}/mach-hmt.c (99%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/mach-jive.c (99%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/mach-mini2440.c (99%)
 rename arch/arm/{mach-s3c64xx => mach-s3c}/mach-mini6410.c (99%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/mach-n30.c (99%)
 rename arch/arm/{mach-s3c64xx => mach-s3c}/mach-ncp.c (99%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/mach-nexcoder.c (99%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/mach-osiris-dvs.c (100%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/mach-osiris.c (99%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/mach-otom.c (99%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/mach-qt2410.c (99%)
 rename arch/arm/{mach-s3c64xx => mach-s3c}/mach-real6410.c (98%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/mach-rx1950.c (99%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/mach-rx3715.c (99%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/mach-s3c2416-dt.c (98%)
 rename arch/arm/{mach-s3c64xx => mach-s3c}/mach-s3c64xx-dt.c (98%)
 rename arch/arm/{mach-s3c64xx => mach-s3c}/mach-smartq.c (99%)
 rename arch/arm/{mach-s3c64xx => mach-s3c}/mach-smartq.h (100%)
 rename arch/arm/{mach-s3c64xx => mach-s3c}/mach-smartq5.c (99%)
 rename arch/arm/{mach-s3c64xx => mach-s3c}/mach-smartq7.c (99%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/mach-smdk2410.c (97%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/mach-smdk2413.c (97%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/mach-smdk2416.c (98%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/mach-smdk2440.c (98%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/mach-smdk2443.c (98%)
 rename arch/arm/{mach-s3c64xx => mach-s3c}/mach-smdk6400.c (99%)
 rename arch/arm/{mach-s3c64xx => mach-s3c}/mach-smdk6410.c (99%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/mach-tct_hammer.c (99%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/mach-vr1000.c (99%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/mach-vstms.c (99%)
 rename arch/arm/{mach-s3c24xx/nand-core.h => mach-s3c/nand-core-s3c24xx.h} (77%)
 rename arch/arm/{mach-s3c64xx/onenand-core.h => mach-s3c/onenand-core-s3c64xx.h} (82%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/osiris.h (100%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/otom.h (100%)
 rename arch/arm/{mach-s3c64xx => mach-s3c}/pl080.c (99%)
 rename arch/arm/{plat-samsung => mach-s3c}/platformdata.c (100%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/pll-s3c2410.c (100%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/pll-s3c2440-12000000.c (100%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/pll-s3c2440-16934400.c (100%)
 rename arch/arm/{plat-samsung => mach-s3c}/pm-common.c (100%)
 rename arch/arm/{plat-samsung => mach-s3c}/pm-gpio.c (100%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/pm-h1940.S (100%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/pm-s3c2410.c (100%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/pm-s3c2412.c (98%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/pm-s3c2416.c (100%)
 rename arch/arm/{mach-s3c24xx/pm.c => mach-s3c/pm-s3c24xx.c} (98%)
 rename arch/arm/{mach-s3c64xx/pm.c => mach-s3c/pm-s3c64xx.c} (98%)
 rename arch/arm/{plat-samsung => mach-s3c}/pm.c (100%)
 rename arch/arm/{mach-s3c24xx/regs-dsc.h => mach-s3c/regs-dsc-s3c24xx.h} (77%)
 rename arch/arm/{mach-s3c64xx/regs-gpio-memport.h => mach-s3c/regs-gpio-memport-s3c64xx.h} (100%)
 rename arch/arm/{mach-s3c24xx/regs-mem.h => mach-s3c/regs-mem-s3c24xx.h} (100%)
 rename arch/arm/{mach-s3c64xx/regs-modem.h => mach-s3c/regs-modem-s3c64xx.h} (100%)
 rename arch/arm/{mach-s3c64xx/regs-srom.h => mach-s3c/regs-srom-s3c64xx.h} (100%)
 rename arch/arm/{mach-s3c64xx/regs-sys.h => mach-s3c/regs-sys-s3c64xx.h} (100%)
 rename arch/arm/{mach-s3c64xx/regs-syscon-power.h => mach-s3c/regs-syscon-power-s3c64xx.h} (100%)
 rename arch/arm/{mach-s3c64xx/regs-usb-hsotg-phy.h => mach-s3c/regs-usb-hsotg-phy-s3c64xx.h} (100%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/s3c2410.c (99%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/s3c2412-power.h (100%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/s3c2412.c (97%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/s3c2416.c (95%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/s3c2440.c (98%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/s3c2442.c (98%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/s3c2443.c (94%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/s3c244x.c (97%)
 rename arch/arm/{mach-s3c24xx/common.c => mach-s3c/s3c24xx.c} (99%)
 rename arch/arm/{mach-s3c24xx/common.h => mach-s3c/s3c24xx.h} (100%)
 rename arch/arm/{mach-s3c64xx => mach-s3c}/s3c6400.c (97%)
 rename arch/arm/{mach-s3c64xx => mach-s3c}/s3c6410.c (96%)
 rename arch/arm/{mach-s3c64xx/common.c => mach-s3c/s3c64xx.c} (99%)
 rename arch/arm/{mach-s3c64xx/common.h => mach-s3c/s3c64xx.h} (100%)
 rename arch/arm/{mach-s3c24xx/setup-camif.c => mach-s3c/setup-camif-s3c24xx.c} (100%)
 rename arch/arm/{mach-s3c64xx/setup-fb-24bpp.c => mach-s3c/setup-fb-24bpp-s3c64xx.c} (100%)
 rename arch/arm/{mach-s3c24xx/setup-i2c.c => mach-s3c/setup-i2c-s3c24xx.c} (100%)
 rename arch/arm/{mach-s3c64xx/setup-i2c0.c => mach-s3c/setup-i2c0-s3c64xx.c} (100%)
 rename arch/arm/{mach-s3c64xx/setup-i2c1.c => mach-s3c/setup-i2c1-s3c64xx.c} (100%)
 rename arch/arm/{mach-s3c64xx/setup-ide.c => mach-s3c/setup-ide-s3c64xx.c} (100%)
 rename arch/arm/{mach-s3c64xx/setup-keypad.c => mach-s3c/setup-keypad-s3c64xx.c} (100%)
 rename arch/arm/{mach-s3c24xx/setup-sdhci-gpio.c => mach-s3c/setup-sdhci-gpio-s3c24xx.c} (100%)
 rename arch/arm/{mach-s3c64xx/setup-sdhci-gpio.c => mach-s3c/setup-sdhci-gpio-s3c64xx.c} (100%)
 rename arch/arm/{mach-s3c24xx/setup-spi.c => mach-s3c/setup-spi-s3c24xx.c} (93%)
 rename arch/arm/{mach-s3c64xx/setup-spi.c => mach-s3c/setup-spi-s3c64xx.c} (100%)
 rename arch/arm/{mach-s3c24xx/setup-ts.c => mach-s3c/setup-ts-s3c24xx.c} (100%)
 rename arch/arm/{mach-s3c64xx/setup-usb-phy.c => mach-s3c/setup-usb-phy-s3c64xx.c} (96%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/simtec-audio.c (100%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/simtec-nor.c (100%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/simtec-pm.c (97%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/simtec-usb.c (100%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/simtec.h (100%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/sleep-s3c2410.S (97%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/sleep-s3c2412.S (100%)
 rename arch/arm/{mach-s3c24xx/sleep.S => mach-s3c/sleep-s3c24xx.S} (100%)
 rename arch/arm/{mach-s3c64xx/sleep.S => mach-s3c/sleep-s3c64xx.S} (100%)
 rename arch/arm/{mach-s3c24xx/spi-core.h => mach-s3c/spi-core-s3c24xx.h} (81%)
 rename arch/arm/{mach-s3c24xx => mach-s3c}/vr1000.h (100%)
 rename arch/arm/{plat-samsung => mach-s3c}/wakeup-mask.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index d9accf3c2582..6c74aa41e35b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2220,8 +2220,8 @@ ARM/OPENMOKO NEO FREERUNNER (GTA02) MACHINE SUPPORT
 L:	openmoko-kernel@lists.openmoko.org (subscribers-only)
 S:	Orphan
 W:	http://wiki.openmoko.org/wiki/Neo_FreeRunner
-F:	arch/arm/mach-s3c24xx/gta02.h
-F:	arch/arm/mach-s3c24xx/mach-gta02.c
+F:	arch/arm/mach-s3c/gta02.h
+F:	arch/arm/mach-s3c/mach-gta02.c
 
 ARM/Orion SoC/Technologic Systems TS-78xx platform support
 M:	Alexander Clouter <alex@digriz.org.uk>
@@ -2410,10 +2410,8 @@ F:	arch/arm/boot/dts/exynos*
 F:	arch/arm/boot/dts/s3c*
 F:	arch/arm/boot/dts/s5p*
 F:	arch/arm/mach-exynos*/
-F:	arch/arm/mach-s3c24*/
-F:	arch/arm/mach-s3c64xx/
+F:	arch/arm/mach-s3c/
 F:	arch/arm/mach-s5p*/
-F:	arch/arm/plat-samsung/
 F:	arch/arm64/boot/dts/exynos/
 F:	drivers/*/*/*s3c24*
 F:	drivers/*/*s3c24*
@@ -15829,9 +15827,9 @@ SIMTEC EB2410ITX (BAST)
 M:	Simtec Linux Team <linux@simtec.co.uk>
 S:	Supported
 W:	http://www.simtec.co.uk/products/EB2410ITX/
-F:	arch/arm/mach-s3c24xx/bast-ide.c
-F:	arch/arm/mach-s3c24xx/bast-irq.c
-F:	arch/arm/mach-s3c24xx/mach-bast.c
+F:	arch/arm/mach-s3c/bast-ide.c
+F:	arch/arm/mach-s3c/bast-irq.c
+F:	arch/arm/mach-s3c/mach-bast.c
 
 SIOX
 M:	Thorsten Scherer <t.scherer@eckelmann.de>
@@ -18750,7 +18748,7 @@ F:	Documentation/devicetree/bindings/mfd/wm831x.txt
 F:	Documentation/devicetree/bindings/regulator/wlf,arizona.yaml
 F:	Documentation/devicetree/bindings/sound/wlf,arizona.yaml
 F:	Documentation/hwmon/wm83??.rst
-F:	arch/arm/mach-s3c64xx/mach-crag6410*
+F:	arch/arm/mach-s3c/mach-crag6410*
 F:	drivers/clk/clk-wm83*.c
 F:	drivers/extcon/extcon-arizona.c
 F:	drivers/gpio/gpio-*wm*.c
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 063018c387be..8d784597ab0c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -638,7 +638,6 @@ source "arch/arm/mach-dove/Kconfig"
 source "arch/arm/mach-ep93xx/Kconfig"
 
 source "arch/arm/mach-exynos/Kconfig"
-source "arch/arm/plat-samsung/Kconfig"
 
 source "arch/arm/mach-footbridge/Kconfig"
 
@@ -711,9 +710,7 @@ source "arch/arm/mach-realview/Kconfig"
 
 source "arch/arm/mach-rockchip/Kconfig"
 
-source "arch/arm/mach-s3c24xx/Kconfig"
-
-source "arch/arm/mach-s3c64xx/Kconfig"
+source "arch/arm/mach-s3c/Kconfig"
 
 source "arch/arm/mach-s5pv210/Kconfig"
 
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 3997cec8848e..d3a447a856ce 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -209,8 +209,7 @@ machine-$(CONFIG_ARCH_REALTEK)		+= realtek
 machine-$(CONFIG_ARCH_REALVIEW)		+= realview
 machine-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip
 machine-$(CONFIG_ARCH_RPC)		+= rpc
-machine-$(CONFIG_ARCH_S3C24XX)		+= s3c24xx
-machine-$(CONFIG_ARCH_S3C64XX)		+= s3c64xx
+machine-$(CONFIG_PLAT_SAMSUNG)		+= s3c
 machine-$(CONFIG_ARCH_S5PV210)		+= s5pv210
 machine-$(CONFIG_ARCH_SA1100)		+= sa1100
 machine-$(CONFIG_ARCH_RENESAS)	 	+= shmobile
@@ -233,10 +232,8 @@ machine-$(CONFIG_PLAT_SPEAR)		+= spear
 # Platform directory name.  This list is sorted alphanumerically
 # by CONFIG_* macro name.
 plat-$(CONFIG_ARCH_OMAP)	+= omap
-plat-$(CONFIG_ARCH_S3C64XX)	+= samsung
 plat-$(CONFIG_PLAT_ORION)	+= orion
 plat-$(CONFIG_PLAT_PXA)		+= pxa
-plat-$(CONFIG_PLAT_S3C24XX)	+= samsung
 plat-$(CONFIG_PLAT_VERSATILE)	+= versatile
 
 ifeq ($(CONFIG_ARCH_EBSA110),y)
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/mach-s3c/Kconfig
similarity index 98%
rename from arch/arm/plat-samsung/Kconfig
rename to arch/arm/mach-s3c/Kconfig
index 13b39684b582..25606e668cf9 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/mach-s3c/Kconfig
@@ -2,6 +2,9 @@
 #
 # Copyright 2009 Simtec Electronics
 
+source "arch/arm/mach-s3c/Kconfig.s3c24xx"
+source "arch/arm/mach-s3c/Kconfig.s3c64xx"
+
 config PLAT_SAMSUNG
 	bool
 	depends on PLAT_S3C24XX || ARCH_S3C64XX
diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c/Kconfig.s3c24xx
similarity index 100%
rename from arch/arm/mach-s3c24xx/Kconfig
rename to arch/arm/mach-s3c/Kconfig.s3c24xx
diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c/Kconfig.s3c64xx
similarity index 100%
rename from arch/arm/mach-s3c64xx/Kconfig
rename to arch/arm/mach-s3c/Kconfig.s3c64xx
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/mach-s3c/Makefile
similarity index 82%
rename from arch/arm/plat-samsung/Makefile
rename to arch/arm/mach-s3c/Makefile
index feddb42cae51..54188d10ab2e 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/mach-s3c/Makefile
@@ -2,9 +2,16 @@
 #
 # Copyright 2009 Simtec Electronics
 
-ccflags-$(CONFIG_ARCH_S3C64XX) := -I$(srctree)/arch/arm/mach-s3c64xx/include
 ccflags-$(CONFIG_ARCH_MULTIPLATFORM) += -I$(srctree)/$(src)/include
 
+ifdef CONFIG_ARCH_S3C24XX
+include $(src)/Makefile.s3c24xx
+endif
+
+ifdef CONFIG_ARCH_S3C64XX
+include $(src)/Makefile.s3c64xx
+endif
+
 # Objects we always build independent of SoC choice
 
 obj-y				+= init.o cpu.o
diff --git a/arch/arm/mach-s3c24xx/Makefile.boot b/arch/arm/mach-s3c/Makefile.boot
similarity index 100%
rename from arch/arm/mach-s3c24xx/Makefile.boot
rename to arch/arm/mach-s3c/Makefile.boot
diff --git a/arch/arm/mach-s3c24xx/Makefile b/arch/arm/mach-s3c/Makefile.s3c24xx
similarity index 84%
rename from arch/arm/mach-s3c24xx/Makefile
rename to arch/arm/mach-s3c/Makefile.s3c24xx
index 195a4cb23ecb..bbca7ef4fc74 100644
--- a/arch/arm/mach-s3c24xx/Makefile
+++ b/arch/arm/mach-s3c/Makefile.s3c24xx
@@ -7,7 +7,7 @@
 
 # core
 
-obj-y				+= common.o
+obj-y				+= s3c24xx.o
 obj-y				+= irq-s3c24xx.o
 obj-$(CONFIG_SPI_S3C24XX_FIQ)	+= irq-s3c24xx-fiq.o
 obj-$(CONFIG_SPI_S3C24XX_FIQ)	+= irq-s3c24xx-fiq-exports.o
@@ -33,12 +33,12 @@ obj-$(CONFIG_CPU_S3C2443)	+= s3c2443.o
 
 # PM
 
-obj-$(CONFIG_PM)		+= pm.o
-obj-$(CONFIG_PM_SLEEP)		+= irq-pm.o sleep.o
+obj-$(CONFIG_PM)		+= pm-s3c24xx.o
+obj-$(CONFIG_PM_SLEEP)		+= irq-pm-s3c24xx.o sleep-s3c24xx.o
 
 # common code
 
-obj-$(CONFIG_ARM_S3C24XX_CPUFREQ) += cpufreq-utils.o
+obj-$(CONFIG_ARM_S3C24XX_CPUFREQ) += cpufreq-utils-s3c24xx.o
 
 obj-$(CONFIG_S3C2410_IOTIMING)	+= iotiming-s3c2410.o
 obj-$(CONFIG_S3C2412_IOTIMING)	+= iotiming-s3c2412.o
@@ -83,7 +83,7 @@ obj-$(CONFIG_MACH_SMDK2443)		+= mach-smdk2443.o
 
 # common bits of machine support
 
-obj-$(CONFIG_S3C24XX_SMDK)		+= common-smdk.o
+obj-$(CONFIG_S3C24XX_SMDK)		+= common-smdk-s3c24xx.o
 obj-$(CONFIG_S3C24XX_SIMTEC_AUDIO)	+= simtec-audio.o
 obj-$(CONFIG_S3C24XX_SIMTEC_NOR)	+= simtec-nor.o
 obj-$(CONFIG_S3C24XX_SIMTEC_PM)		+= simtec-pm.o
@@ -96,8 +96,8 @@ obj-$(CONFIG_MACH_OSIRIS_DVS)		+= mach-osiris-dvs.o
 
 # device setup
 
-obj-$(CONFIG_S3C2416_SETUP_SDHCI_GPIO)	+= setup-sdhci-gpio.o
-obj-$(CONFIG_S3C2443_SETUP_SPI)		+= setup-spi.o
-obj-$(CONFIG_ARCH_S3C24XX)		+= setup-i2c.o
-obj-$(CONFIG_S3C24XX_SETUP_TS)		+= setup-ts.o
-obj-$(CONFIG_S3C_SETUP_CAMIF)		+= setup-camif.o
+obj-$(CONFIG_S3C2416_SETUP_SDHCI_GPIO)	+= setup-sdhci-gpio-s3c24xx.o
+obj-$(CONFIG_S3C2443_SETUP_SPI)		+= setup-spi-s3c24xx.o
+obj-$(CONFIG_ARCH_S3C24XX)		+= setup-i2c-s3c24xx.o
+obj-$(CONFIG_S3C24XX_SETUP_TS)		+= setup-ts-s3c24xx.o
+obj-$(CONFIG_S3C_SETUP_CAMIF)		+= setup-camif-s3c24xx.o
diff --git a/arch/arm/mach-s3c64xx/Makefile b/arch/arm/mach-s3c/Makefile.s3c64xx
similarity index 58%
rename from arch/arm/mach-s3c64xx/Makefile
rename to arch/arm/mach-s3c/Makefile.s3c64xx
index 8caeb4ad17e9..e06e5356da9b 100644
--- a/arch/arm/mach-s3c64xx/Makefile
+++ b/arch/arm/mach-s3c/Makefile.s3c64xx
@@ -8,17 +8,17 @@ asflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include -I$(srctree)
 
 # PM
 
-obj-$(CONFIG_PM)		+= pm.o
-obj-$(CONFIG_PM_SLEEP)		+= sleep.o
-obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
+obj-$(CONFIG_PM)		+= pm-s3c64xx.o
+obj-$(CONFIG_PM_SLEEP)		+= sleep-s3c64xx.o
+obj-$(CONFIG_CPU_IDLE)		+= cpuidle-s3c64xx.o
 
 ifdef CONFIG_SAMSUNG_ATAGS
 
-obj-$(CONFIG_PM_SLEEP)          += irq-pm.o
+obj-$(CONFIG_PM_SLEEP)          += irq-pm-s3c64xx.o
 
 # Core
 
-obj-y				+= common.o
+obj-y				+= s3c64xx.o
 obj-$(CONFIG_CPU_S3C6400)	+= s3c6400.o
 obj-$(CONFIG_CPU_S3C6410)	+= s3c6410.o
 
@@ -28,21 +28,21 @@ obj-$(CONFIG_S3C64XX_PL080)	+= pl080.o
 
 # Device support
 
-obj-y				+= dev-uart.o
-obj-y				+= dev-audio.o
+obj-y				+= dev-uart-s3c64xx.o
+obj-y				+= dev-audio-s3c64xx.o
 
 # Device setup
 
-obj-$(CONFIG_S3C64XX_SETUP_FB_24BPP)	+= setup-fb-24bpp.o
-obj-$(CONFIG_S3C64XX_SETUP_I2C0)	+= setup-i2c0.o
-obj-$(CONFIG_S3C64XX_SETUP_I2C1)	+= setup-i2c1.o
-obj-$(CONFIG_S3C64XX_SETUP_IDE)		+= setup-ide.o
-obj-$(CONFIG_S3C64XX_SETUP_KEYPAD)	+= setup-keypad.o
-obj-$(CONFIG_S3C64XX_SETUP_SDHCI_GPIO)	+= setup-sdhci-gpio.o
-obj-$(CONFIG_S3C64XX_SETUP_SPI)		+= setup-spi.o
-obj-$(CONFIG_S3C64XX_SETUP_USB_PHY) += setup-usb-phy.o
+obj-$(CONFIG_S3C64XX_SETUP_FB_24BPP)	+= setup-fb-24bpp-s3c64xx.o
+obj-$(CONFIG_S3C64XX_SETUP_I2C0)	+= setup-i2c0-s3c64xx.o
+obj-$(CONFIG_S3C64XX_SETUP_I2C1)	+= setup-i2c1-s3c64xx.o
+obj-$(CONFIG_S3C64XX_SETUP_IDE)		+= setup-ide-s3c64xx.o
+obj-$(CONFIG_S3C64XX_SETUP_KEYPAD)	+= setup-keypad-s3c64xx.o
+obj-$(CONFIG_S3C64XX_SETUP_SDHCI_GPIO)	+= setup-sdhci-gpio-s3c64xx.o
+obj-$(CONFIG_S3C64XX_SETUP_SPI)		+= setup-spi-s3c64xx.o
+obj-$(CONFIG_S3C64XX_SETUP_USB_PHY) += setup-usb-phy-s3c64xx.o
 
-obj-$(CONFIG_SAMSUNG_DEV_BACKLIGHT)	+= dev-backlight.o
+obj-$(CONFIG_SAMSUNG_DEV_BACKLIGHT)	+= dev-backlight-s3c64xx.o
 
 # Machine support
 
diff --git a/arch/arm/plat-samsung/adc.c b/arch/arm/mach-s3c/adc.c
similarity index 100%
rename from arch/arm/plat-samsung/adc.c
rename to arch/arm/mach-s3c/adc.c
diff --git a/arch/arm/mach-s3c24xx/anubis.h b/arch/arm/mach-s3c/anubis.h
similarity index 100%
rename from arch/arm/mach-s3c24xx/anubis.h
rename to arch/arm/mach-s3c/anubis.h
diff --git a/arch/arm/mach-s3c64xx/ata-core.h b/arch/arm/mach-s3c/ata-core-s3c64xx.h
similarity index 78%
rename from arch/arm/mach-s3c64xx/ata-core.h
rename to arch/arm/mach-s3c/ata-core-s3c64xx.h
index 6d9a81f759e6..4863ad9d3a42 100644
--- a/arch/arm/mach-s3c64xx/ata-core.h
+++ b/arch/arm/mach-s3c/ata-core-s3c64xx.h
@@ -6,8 +6,8 @@
  * Samsung CF-ATA Controller core functions
  */
 
-#ifndef __ASM_PLAT_ATA_CORE_H
-#define __ASM_PLAT_ATA_CORE_H __FILE__
+#ifndef __ASM_PLAT_ATA_CORE_S3C64XX_H
+#define __ASM_PLAT_ATA_CORE_S3C64XX_H __FILE__
 
 /* These functions are only for use with the core support code, such as
  * the cpu specific initialisation code
@@ -21,4 +21,4 @@ static inline void s3c_cfcon_setname(char *name)
 #endif
 }
 
-#endif /* __ASM_PLAT_ATA_CORE_H */
+#endif /* __ASM_PLAT_ATA_CORE_S3C64XX_H */
diff --git a/arch/arm/mach-s3c64xx/backlight.h b/arch/arm/mach-s3c/backlight-s3c64xx.h
similarity index 78%
rename from arch/arm/mach-s3c64xx/backlight.h
rename to arch/arm/mach-s3c/backlight-s3c64xx.h
index 028663f1cacc..2a2b35821d58 100644
--- a/arch/arm/mach-s3c64xx/backlight.h
+++ b/arch/arm/mach-s3c/backlight-s3c64xx.h
@@ -4,8 +4,8 @@
  *              http://www.samsung.com
  */
 
-#ifndef __ASM_PLAT_BACKLIGHT_H
-#define __ASM_PLAT_BACKLIGHT_H __FILE__
+#ifndef __ASM_PLAT_BACKLIGHT_S3C64XX_H
+#define __ASM_PLAT_BACKLIGHT_S3C64XX_H __FILE__
 
 /* samsung_bl_gpio_info - GPIO info for PWM Backlight control
  * @no:		GPIO number for PWM timer out
@@ -19,4 +19,4 @@ struct samsung_bl_gpio_info {
 extern void __init samsung_bl_set(struct samsung_bl_gpio_info *gpio_info,
 	struct platform_pwm_backlight_data *bl_data);
 
-#endif /* __ASM_PLAT_BACKLIGHT_H */
+#endif /* __ASM_PLAT_BACKLIGHT_S3C64XX_H */
diff --git a/arch/arm/mach-s3c24xx/bast-ide.c b/arch/arm/mach-s3c/bast-ide.c
similarity index 100%
rename from arch/arm/mach-s3c24xx/bast-ide.c
rename to arch/arm/mach-s3c/bast-ide.c
diff --git a/arch/arm/mach-s3c24xx/bast-irq.c b/arch/arm/mach-s3c/bast-irq.c
similarity index 100%
rename from arch/arm/mach-s3c24xx/bast-irq.c
rename to arch/arm/mach-s3c/bast-irq.c
diff --git a/arch/arm/mach-s3c24xx/bast.h b/arch/arm/mach-s3c/bast.h
similarity index 100%
rename from arch/arm/mach-s3c24xx/bast.h
rename to arch/arm/mach-s3c/bast.h
diff --git a/arch/arm/mach-s3c24xx/common-smdk.c b/arch/arm/mach-s3c/common-smdk-s3c24xx.c
similarity index 99%
rename from arch/arm/mach-s3c24xx/common-smdk.c
rename to arch/arm/mach-s3c/common-smdk-s3c24xx.c
index c0c176651f96..e3281dc3af13 100644
--- a/arch/arm/mach-s3c24xx/common-smdk.c
+++ b/arch/arm/mach-s3c/common-smdk-s3c24xx.c
@@ -40,7 +40,7 @@
 #include <plat/devs.h>
 #include <plat/pm.h>
 
-#include "common-smdk.h"
+#include "common-smdk-s3c24xx.h"
 
 /* LED devices */
 
diff --git a/arch/arm/mach-s3c24xx/common-smdk.h b/arch/arm/mach-s3c/common-smdk-s3c24xx.h
similarity index 100%
rename from arch/arm/mach-s3c24xx/common-smdk.h
rename to arch/arm/mach-s3c/common-smdk-s3c24xx.h
diff --git a/arch/arm/plat-samsung/cpu.c b/arch/arm/mach-s3c/cpu.c
similarity index 100%
rename from arch/arm/plat-samsung/cpu.c
rename to arch/arm/mach-s3c/cpu.c
diff --git a/arch/arm/mach-s3c24xx/cpufreq-utils.c b/arch/arm/mach-s3c/cpufreq-utils-s3c24xx.c
similarity index 98%
rename from arch/arm/mach-s3c24xx/cpufreq-utils.c
rename to arch/arm/mach-s3c/cpufreq-utils-s3c24xx.c
index 3bc374dd0b2d..17b70d635236 100644
--- a/arch/arm/mach-s3c24xx/cpufreq-utils.c
+++ b/arch/arm/mach-s3c/cpufreq-utils-s3c24xx.c
@@ -17,7 +17,7 @@
 
 #include <linux/soc/samsung/s3c-cpufreq-core.h>
 
-#include "regs-mem.h"
+#include "regs-mem-s3c24xx.h"
 
 /**
  * s3c2410_cpufreq_setrefresh - set SDRAM refresh value
diff --git a/arch/arm/mach-s3c64xx/cpuidle.c b/arch/arm/mach-s3c/cpuidle-s3c64xx.c
similarity index 94%
rename from arch/arm/mach-s3c64xx/cpuidle.c
rename to arch/arm/mach-s3c/cpuidle-s3c64xx.c
index 0bac6f6413b0..a629f4d2fa3b 100644
--- a/arch/arm/mach-s3c64xx/cpuidle.c
+++ b/arch/arm/mach-s3c/cpuidle-s3c64xx.c
@@ -16,8 +16,8 @@
 #include <plat/cpu.h>
 #include <mach/map.h>
 
-#include "regs-sys.h"
-#include "regs-syscon-power.h"
+#include "regs-sys-s3c64xx.h"
+#include "regs-syscon-power-s3c64xx.h"
 
 static int s3c64xx_enter_idle(struct cpuidle_device *dev,
 			      struct cpuidle_driver *drv,
diff --git a/arch/arm/mach-s3c64xx/crag6410.h b/arch/arm/mach-s3c/crag6410.h
similarity index 100%
rename from arch/arm/mach-s3c64xx/crag6410.h
rename to arch/arm/mach-s3c/crag6410.h
diff --git a/arch/arm/mach-s3c64xx/dev-audio.c b/arch/arm/mach-s3c/dev-audio-s3c64xx.c
similarity index 100%
rename from arch/arm/mach-s3c64xx/dev-audio.c
rename to arch/arm/mach-s3c/dev-audio-s3c64xx.c
diff --git a/arch/arm/mach-s3c64xx/dev-backlight.c b/arch/arm/mach-s3c/dev-backlight-s3c64xx.c
similarity index 99%
rename from arch/arm/mach-s3c64xx/dev-backlight.c
rename to arch/arm/mach-s3c/dev-backlight-s3c64xx.c
index 09e6da305f60..53bf14f5467f 100644
--- a/arch/arm/mach-s3c64xx/dev-backlight.c
+++ b/arch/arm/mach-s3c/dev-backlight-s3c64xx.c
@@ -14,7 +14,7 @@
 #include <plat/devs.h>
 #include <plat/gpio-cfg.h>
 
-#include "backlight.h"
+#include "backlight-s3c64xx.h"
 
 struct samsung_bl_drvdata {
 	struct platform_pwm_backlight_data plat_data;
diff --git a/arch/arm/mach-s3c64xx/dev-uart.c b/arch/arm/mach-s3c/dev-uart-s3c64xx.c
similarity index 100%
rename from arch/arm/mach-s3c64xx/dev-uart.c
rename to arch/arm/mach-s3c/dev-uart-s3c64xx.c
diff --git a/arch/arm/plat-samsung/dev-uart.c b/arch/arm/mach-s3c/dev-uart.c
similarity index 100%
rename from arch/arm/plat-samsung/dev-uart.c
rename to arch/arm/mach-s3c/dev-uart.c
diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/mach-s3c/devs.c
similarity index 100%
rename from arch/arm/plat-samsung/devs.c
rename to arch/arm/mach-s3c/devs.c
diff --git a/arch/arm/mach-s3c24xx/fb-core.h b/arch/arm/mach-s3c/fb-core-s3c24xx.h
similarity index 78%
rename from arch/arm/mach-s3c24xx/fb-core.h
rename to arch/arm/mach-s3c/fb-core-s3c24xx.h
index 1821e820262c..0e07f3ba4aef 100644
--- a/arch/arm/mach-s3c24xx/fb-core.h
+++ b/arch/arm/mach-s3c/fb-core-s3c24xx.h
@@ -5,8 +5,8 @@
  *
  * Samsung framebuffer driver core functions
  */
-#ifndef __ASM_PLAT_FB_CORE_H
-#define __ASM_PLAT_FB_CORE_H __FILE__
+#ifndef __ASM_PLAT_FB_CORE_S3C24XX_H
+#define __ASM_PLAT_FB_CORE_S3C24XX_H __FILE__
 
 /*
  * These functions are only for use with the core support code, such as
@@ -21,4 +21,4 @@ static inline void s3c_fb_setname(char *name)
 #endif
 }
 
-#endif /* __ASM_PLAT_FB_CORE_H */
+#endif /* __ASM_PLAT_FB_CORE_S3C24XX_H */
diff --git a/arch/arm/plat-samsung/gpio-samsung.c b/arch/arm/mach-s3c/gpio-samsung.c
similarity index 100%
rename from arch/arm/plat-samsung/gpio-samsung.c
rename to arch/arm/mach-s3c/gpio-samsung.c
diff --git a/arch/arm/mach-s3c24xx/gta02.h b/arch/arm/mach-s3c/gta02.h
similarity index 100%
rename from arch/arm/mach-s3c24xx/gta02.h
rename to arch/arm/mach-s3c/gta02.h
diff --git a/arch/arm/mach-s3c24xx/h1940-bluetooth.c b/arch/arm/mach-s3c/h1940-bluetooth.c
similarity index 100%
rename from arch/arm/mach-s3c24xx/h1940-bluetooth.c
rename to arch/arm/mach-s3c/h1940-bluetooth.c
diff --git a/arch/arm/mach-s3c24xx/h1940.h b/arch/arm/mach-s3c/h1940.h
similarity index 100%
rename from arch/arm/mach-s3c24xx/h1940.h
rename to arch/arm/mach-s3c/h1940.h
diff --git a/arch/arm/mach-s3c24xx/include/mach/dma.h b/arch/arm/mach-s3c/include/mach/dma-s3c24xx.h
similarity index 100%
rename from arch/arm/mach-s3c24xx/include/mach/dma.h
rename to arch/arm/mach-s3c/include/mach/dma-s3c24xx.h
diff --git a/arch/arm/mach-s3c64xx/include/mach/dma.h b/arch/arm/mach-s3c/include/mach/dma-s3c64xx.h
similarity index 100%
rename from arch/arm/mach-s3c64xx/include/mach/dma.h
rename to arch/arm/mach-s3c/include/mach/dma-s3c64xx.h
diff --git a/arch/arm/mach-s3c/include/mach/dma.h b/arch/arm/mach-s3c/include/mach/dma.h
new file mode 100644
index 000000000000..59a4578c5f00
--- /dev/null
+++ b/arch/arm/mach-s3c/include/mach/dma.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifdef CONFIG_ARCH_S3C24XX
+#include "dma-s3c24xx.h"
+#endif
+
+#ifdef CONFIG_ARCH_S3C64XX
+#include "dma-s3c64xx.h"
+#endif
diff --git a/arch/arm/mach-s3c24xx/include/mach/gpio-samsung.h b/arch/arm/mach-s3c/include/mach/gpio-samsung-s3c24xx.h
similarity index 100%
rename from arch/arm/mach-s3c24xx/include/mach/gpio-samsung.h
rename to arch/arm/mach-s3c/include/mach/gpio-samsung-s3c24xx.h
diff --git a/arch/arm/mach-s3c64xx/include/mach/gpio-samsung.h b/arch/arm/mach-s3c/include/mach/gpio-samsung-s3c64xx.h
similarity index 100%
rename from arch/arm/mach-s3c64xx/include/mach/gpio-samsung.h
rename to arch/arm/mach-s3c/include/mach/gpio-samsung-s3c64xx.h
diff --git a/arch/arm/mach-s3c/include/mach/gpio-samsung.h b/arch/arm/mach-s3c/include/mach/gpio-samsung.h
new file mode 100644
index 000000000000..02f6f4a96862
--- /dev/null
+++ b/arch/arm/mach-s3c/include/mach/gpio-samsung.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifdef CONFIG_ARCH_S3C24XX
+#include "gpio-samsung-s3c24xx.h"
+#endif
+
+#ifdef CONFIG_ARCH_S3C64XX
+#include "gpio-samsung-s3c64xx.h"
+#endif
diff --git a/arch/arm/mach-s3c24xx/include/mach/hardware.h b/arch/arm/mach-s3c/include/mach/hardware-s3c24xx.h
similarity index 65%
rename from arch/arm/mach-s3c24xx/include/mach/hardware.h
rename to arch/arm/mach-s3c/include/mach/hardware-s3c24xx.h
index c732ea54984c..33b37467d05f 100644
--- a/arch/arm/mach-s3c24xx/include/mach/hardware.h
+++ b/arch/arm/mach-s3c/include/mach/hardware-s3c24xx.h
@@ -6,9 +6,9 @@
  * S3C2410 - hardware
  */
 
-#ifndef __ASM_ARCH_HARDWARE_H
-#define __ASM_ARCH_HARDWARE_H
+#ifndef __ASM_ARCH_HARDWARE_S3C24XX_H
+#define __ASM_ARCH_HARDWARE_S3C24XX_H
 
 extern unsigned int s3c2410_modify_misccr(unsigned int clr, unsigned int chg);
 
-#endif /* __ASM_ARCH_HARDWARE_H */
+#endif /* __ASM_ARCH_HARDWARE_S3C24XX_H */
diff --git a/arch/arm/mach-s3c24xx/include/mach/io.h b/arch/arm/mach-s3c/include/mach/io-s3c24xx.h
similarity index 94%
rename from arch/arm/mach-s3c24xx/include/mach/io.h
rename to arch/arm/mach-s3c/include/mach/io-s3c24xx.h
index bcddf615adb6..9b78b0a3d486 100644
--- a/arch/arm/mach-s3c24xx/include/mach/io.h
+++ b/arch/arm/mach-s3c/include/mach/io-s3c24xx.h
@@ -7,8 +7,8 @@
  *	     (C) 2003 Simtec Electronics
 */
 
-#ifndef __ASM_ARM_ARCH_IO_H
-#define __ASM_ARM_ARCH_IO_H
+#ifndef __ASM_ARM_ARCH_IO_S3C24XX_H
+#define __ASM_ARM_ARCH_IO_S3C24XX_H
 
 #include <plat/map-base.h>
 
diff --git a/arch/arm/mach-s3c/include/mach/io.h b/arch/arm/mach-s3c/include/mach/io.h
new file mode 100644
index 000000000000..30a0135708dc
--- /dev/null
+++ b/arch/arm/mach-s3c/include/mach/io.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2020 Krzysztof Kozlowski <krzk@kernel.org>
+ */
+
+#ifdef CONFIG_ARCH_S3C24XX
+#include "io-s3c24xx.h"
+#endif
diff --git a/arch/arm/mach-s3c24xx/include/mach/irqs.h b/arch/arm/mach-s3c/include/mach/irqs-s3c24xx.h
similarity index 100%
rename from arch/arm/mach-s3c24xx/include/mach/irqs.h
rename to arch/arm/mach-s3c/include/mach/irqs-s3c24xx.h
diff --git a/arch/arm/mach-s3c64xx/include/mach/irqs.h b/arch/arm/mach-s3c/include/mach/irqs-s3c64xx.h
similarity index 100%
rename from arch/arm/mach-s3c64xx/include/mach/irqs.h
rename to arch/arm/mach-s3c/include/mach/irqs-s3c64xx.h
diff --git a/arch/arm/mach-s3c/include/mach/irqs.h b/arch/arm/mach-s3c/include/mach/irqs.h
new file mode 100644
index 000000000000..0bff1c1c8eb0
--- /dev/null
+++ b/arch/arm/mach-s3c/include/mach/irqs.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifdef CONFIG_ARCH_S3C24XX
+#include "irqs-s3c24xx.h"
+#endif
+
+#ifdef CONFIG_ARCH_S3C64XX
+#include "irqs-s3c64xx.h"
+#endif
diff --git a/arch/arm/mach-s3c24xx/include/mach/map.h b/arch/arm/mach-s3c/include/mach/map-s3c24xx.h
similarity index 100%
rename from arch/arm/mach-s3c24xx/include/mach/map.h
rename to arch/arm/mach-s3c/include/mach/map-s3c24xx.h
diff --git a/arch/arm/mach-s3c64xx/include/mach/map.h b/arch/arm/mach-s3c/include/mach/map-s3c64xx.h
similarity index 100%
rename from arch/arm/mach-s3c64xx/include/mach/map.h
rename to arch/arm/mach-s3c/include/mach/map-s3c64xx.h
diff --git a/arch/arm/mach-s3c/include/mach/map.h b/arch/arm/mach-s3c/include/mach/map.h
new file mode 100644
index 000000000000..7cfb517d4886
--- /dev/null
+++ b/arch/arm/mach-s3c/include/mach/map.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifdef CONFIG_ARCH_S3C24XX
+#include "map-s3c24xx.h"
+#endif
+
+#ifdef CONFIG_ARCH_S3C64XX
+#include "map-s3c64xx.h"
+#endif
diff --git a/arch/arm/mach-s3c24xx/include/mach/pm-core.h b/arch/arm/mach-s3c/include/mach/pm-core-s3c24xx.h
similarity index 98%
rename from arch/arm/mach-s3c24xx/include/mach/pm-core.h
rename to arch/arm/mach-s3c/include/mach/pm-core-s3c24xx.h
index a22b4a37ee57..bcb7978a4e85 100644
--- a/arch/arm/mach-s3c24xx/include/mach/pm-core.h
+++ b/arch/arm/mach-s3c/include/mach/pm-core-s3c24xx.h
@@ -11,7 +11,7 @@
 #include <linux/io.h>
 
 #include "regs-clock.h"
-#include "regs-irq.h"
+#include "regs-irq-s3c24xx.h"
 #include <mach/irqs.h>
 
 static inline void s3c_pm_debug_init_uart(void)
diff --git a/arch/arm/mach-s3c64xx/include/mach/pm-core.h b/arch/arm/mach-s3c/include/mach/pm-core-s3c64xx.h
similarity index 100%
rename from arch/arm/mach-s3c64xx/include/mach/pm-core.h
rename to arch/arm/mach-s3c/include/mach/pm-core-s3c64xx.h
diff --git a/arch/arm/mach-s3c/include/mach/pm-core.h b/arch/arm/mach-s3c/include/mach/pm-core.h
new file mode 100644
index 000000000000..b0e1d277f599
--- /dev/null
+++ b/arch/arm/mach-s3c/include/mach/pm-core.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifdef CONFIG_ARCH_S3C24XX
+#include "pm-core-s3c24xx.h"
+#endif
+
+#ifdef CONFIG_ARCH_S3C64XX
+#include "pm-core-s3c64xx.h"
+#endif
diff --git a/arch/arm/mach-s3c24xx/include/mach/regs-clock.h b/arch/arm/mach-s3c/include/mach/regs-clock-s3c24xx.h
similarity index 100%
rename from arch/arm/mach-s3c24xx/include/mach/regs-clock.h
rename to arch/arm/mach-s3c/include/mach/regs-clock-s3c24xx.h
diff --git a/arch/arm/mach-s3c64xx/include/mach/regs-clock.h b/arch/arm/mach-s3c/include/mach/regs-clock-s3c64xx.h
similarity index 100%
rename from arch/arm/mach-s3c64xx/include/mach/regs-clock.h
rename to arch/arm/mach-s3c/include/mach/regs-clock-s3c64xx.h
diff --git a/arch/arm/mach-s3c/include/mach/regs-clock.h b/arch/arm/mach-s3c/include/mach/regs-clock.h
new file mode 100644
index 000000000000..7df31f203d28
--- /dev/null
+++ b/arch/arm/mach-s3c/include/mach/regs-clock.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifdef CONFIG_ARCH_S3C24XX
+#include "regs-clock-s3c24xx.h"
+#endif
+
+#ifdef CONFIG_ARCH_S3C64XX
+#include "regs-clock-s3c64xx.h"
+#endif
diff --git a/arch/arm/mach-s3c24xx/include/mach/regs-gpio.h b/arch/arm/mach-s3c/include/mach/regs-gpio-s3c24xx.h
similarity index 100%
rename from arch/arm/mach-s3c24xx/include/mach/regs-gpio.h
rename to arch/arm/mach-s3c/include/mach/regs-gpio-s3c24xx.h
diff --git a/arch/arm/mach-s3c64xx/include/mach/regs-gpio.h b/arch/arm/mach-s3c/include/mach/regs-gpio-s3c64xx.h
similarity index 100%
rename from arch/arm/mach-s3c64xx/include/mach/regs-gpio.h
rename to arch/arm/mach-s3c/include/mach/regs-gpio-s3c64xx.h
diff --git a/arch/arm/mach-s3c/include/mach/regs-gpio.h b/arch/arm/mach-s3c/include/mach/regs-gpio.h
new file mode 100644
index 000000000000..0d41cb76d440
--- /dev/null
+++ b/arch/arm/mach-s3c/include/mach/regs-gpio.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifdef CONFIG_ARCH_S3C24XX
+#include "regs-gpio-s3c24xx.h"
+#endif
+
+#ifdef CONFIG_ARCH_S3C64XX
+#include "regs-gpio-s3c64xx.h"
+#endif
diff --git a/arch/arm/mach-s3c24xx/include/mach/regs-irq.h b/arch/arm/mach-s3c/include/mach/regs-irq-s3c24xx.h
similarity index 100%
rename from arch/arm/mach-s3c24xx/include/mach/regs-irq.h
rename to arch/arm/mach-s3c/include/mach/regs-irq-s3c24xx.h
diff --git a/arch/arm/mach-s3c64xx/include/mach/regs-irq.h b/arch/arm/mach-s3c/include/mach/regs-irq-s3c64xx.h
similarity index 100%
rename from arch/arm/mach-s3c64xx/include/mach/regs-irq.h
rename to arch/arm/mach-s3c/include/mach/regs-irq-s3c64xx.h
diff --git a/arch/arm/mach-s3c/include/mach/regs-irq.h b/arch/arm/mach-s3c/include/mach/regs-irq.h
new file mode 100644
index 000000000000..57f0dda8dbf5
--- /dev/null
+++ b/arch/arm/mach-s3c/include/mach/regs-irq.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifdef CONFIG_ARCH_S3C24XX
+#include "regs-irq-s3c24xx.h"
+#endif
+
+#ifdef CONFIG_ARCH_S3C64XX
+#include "regs-irq-s3c64xx.h"
+#endif
diff --git a/arch/arm/mach-s3c24xx/include/mach/regs-s3c2443-clock.h b/arch/arm/mach-s3c/include/mach/regs-s3c2443-clock.h
similarity index 100%
rename from arch/arm/mach-s3c24xx/include/mach/regs-s3c2443-clock.h
rename to arch/arm/mach-s3c/include/mach/regs-s3c2443-clock.h
diff --git a/arch/arm/mach-s3c24xx/include/mach/rtc-core.h b/arch/arm/mach-s3c/include/mach/rtc-core-s3c24xx.h
similarity index 81%
rename from arch/arm/mach-s3c24xx/include/mach/rtc-core.h
rename to arch/arm/mach-s3c/include/mach/rtc-core-s3c24xx.h
index 88510333b96b..e7258b2423fc 100644
--- a/arch/arm/mach-s3c24xx/include/mach/rtc-core.h
+++ b/arch/arm/mach-s3c/include/mach/rtc-core-s3c24xx.h
@@ -5,8 +5,8 @@
  * Samsung RTC Controller core functions
  */
 
-#ifndef __RTC_CORE_H
-#define __RTC_CORE_H __FILE__
+#ifndef __RTC_CORE_S3C24XX_H
+#define __RTC_CORE_S3C24XX_H __FILE__
 
 /* These functions are only for use with the core support code, such as
  * the cpu specific initialisation code
@@ -20,4 +20,4 @@ static inline void s3c_rtc_setname(char *name)
 	s3c_device_rtc.name = name;
 }
 
-#endif /* __RTC_CORE_H */
+#endif /* __RTC_CORE_S3C24XX_H */
diff --git a/arch/arm/mach-s3c24xx/include/mach/s3c2412.h b/arch/arm/mach-s3c/include/mach/s3c2412.h
similarity index 100%
rename from arch/arm/mach-s3c24xx/include/mach/s3c2412.h
rename to arch/arm/mach-s3c/include/mach/s3c2412.h
diff --git a/arch/arm/plat-samsung/include/plat/adc-core.h b/arch/arm/mach-s3c/include/plat/adc-core.h
similarity index 100%
rename from arch/arm/plat-samsung/include/plat/adc-core.h
rename to arch/arm/mach-s3c/include/plat/adc-core.h
diff --git a/arch/arm/plat-samsung/include/plat/cpu.h b/arch/arm/mach-s3c/include/plat/cpu.h
similarity index 100%
rename from arch/arm/plat-samsung/include/plat/cpu.h
rename to arch/arm/mach-s3c/include/plat/cpu.h
diff --git a/arch/arm/plat-samsung/include/plat/devs.h b/arch/arm/mach-s3c/include/plat/devs.h
similarity index 100%
rename from arch/arm/plat-samsung/include/plat/devs.h
rename to arch/arm/mach-s3c/include/plat/devs.h
diff --git a/arch/arm/plat-samsung/include/plat/fb.h b/arch/arm/mach-s3c/include/plat/fb.h
similarity index 100%
rename from arch/arm/plat-samsung/include/plat/fb.h
rename to arch/arm/mach-s3c/include/plat/fb.h
diff --git a/arch/arm/plat-samsung/include/plat/gpio-cfg-helpers.h b/arch/arm/mach-s3c/include/plat/gpio-cfg-helpers.h
similarity index 100%
rename from arch/arm/plat-samsung/include/plat/gpio-cfg-helpers.h
rename to arch/arm/mach-s3c/include/plat/gpio-cfg-helpers.h
diff --git a/arch/arm/plat-samsung/include/plat/gpio-cfg.h b/arch/arm/mach-s3c/include/plat/gpio-cfg.h
similarity index 100%
rename from arch/arm/plat-samsung/include/plat/gpio-cfg.h
rename to arch/arm/mach-s3c/include/plat/gpio-cfg.h
diff --git a/arch/arm/plat-samsung/include/plat/gpio-core.h b/arch/arm/mach-s3c/include/plat/gpio-core.h
similarity index 100%
rename from arch/arm/plat-samsung/include/plat/gpio-core.h
rename to arch/arm/mach-s3c/include/plat/gpio-core.h
diff --git a/arch/arm/plat-samsung/include/plat/iic-core.h b/arch/arm/mach-s3c/include/plat/iic-core.h
similarity index 100%
rename from arch/arm/plat-samsung/include/plat/iic-core.h
rename to arch/arm/mach-s3c/include/plat/iic-core.h
diff --git a/arch/arm/plat-samsung/include/plat/keypad.h b/arch/arm/mach-s3c/include/plat/keypad.h
similarity index 100%
rename from arch/arm/plat-samsung/include/plat/keypad.h
rename to arch/arm/mach-s3c/include/plat/keypad.h
diff --git a/arch/arm/plat-samsung/include/plat/map-base.h b/arch/arm/mach-s3c/include/plat/map-base.h
similarity index 100%
rename from arch/arm/plat-samsung/include/plat/map-base.h
rename to arch/arm/mach-s3c/include/plat/map-base.h
diff --git a/arch/arm/plat-samsung/include/plat/map-s3c.h b/arch/arm/mach-s3c/include/plat/map-s3c.h
similarity index 100%
rename from arch/arm/plat-samsung/include/plat/map-s3c.h
rename to arch/arm/mach-s3c/include/plat/map-s3c.h
diff --git a/arch/arm/plat-samsung/include/plat/map-s5p.h b/arch/arm/mach-s3c/include/plat/map-s5p.h
similarity index 100%
rename from arch/arm/plat-samsung/include/plat/map-s5p.h
rename to arch/arm/mach-s3c/include/plat/map-s5p.h
diff --git a/arch/arm/plat-samsung/include/plat/pm-common.h b/arch/arm/mach-s3c/include/plat/pm-common.h
similarity index 100%
rename from arch/arm/plat-samsung/include/plat/pm-common.h
rename to arch/arm/mach-s3c/include/plat/pm-common.h
diff --git a/arch/arm/plat-samsung/include/plat/pm.h b/arch/arm/mach-s3c/include/plat/pm.h
similarity index 100%
rename from arch/arm/plat-samsung/include/plat/pm.h
rename to arch/arm/mach-s3c/include/plat/pm.h
diff --git a/arch/arm/plat-samsung/include/plat/pwm-core.h b/arch/arm/mach-s3c/include/plat/pwm-core.h
similarity index 100%
rename from arch/arm/plat-samsung/include/plat/pwm-core.h
rename to arch/arm/mach-s3c/include/plat/pwm-core.h
diff --git a/arch/arm/plat-samsung/include/plat/regs-adc.h b/arch/arm/mach-s3c/include/plat/regs-adc.h
similarity index 100%
rename from arch/arm/plat-samsung/include/plat/regs-adc.h
rename to arch/arm/mach-s3c/include/plat/regs-adc.h
diff --git a/arch/arm/plat-samsung/include/plat/regs-irqtype.h b/arch/arm/mach-s3c/include/plat/regs-irqtype.h
similarity index 100%
rename from arch/arm/plat-samsung/include/plat/regs-irqtype.h
rename to arch/arm/mach-s3c/include/plat/regs-irqtype.h
diff --git a/arch/arm/plat-samsung/include/plat/sdhci.h b/arch/arm/mach-s3c/include/plat/sdhci.h
similarity index 100%
rename from arch/arm/plat-samsung/include/plat/sdhci.h
rename to arch/arm/mach-s3c/include/plat/sdhci.h
diff --git a/arch/arm/plat-samsung/include/plat/usb-phy.h b/arch/arm/mach-s3c/include/plat/usb-phy.h
similarity index 100%
rename from arch/arm/plat-samsung/include/plat/usb-phy.h
rename to arch/arm/mach-s3c/include/plat/usb-phy.h
diff --git a/arch/arm/plat-samsung/include/plat/wakeup-mask.h b/arch/arm/mach-s3c/include/plat/wakeup-mask.h
similarity index 100%
rename from arch/arm/plat-samsung/include/plat/wakeup-mask.h
rename to arch/arm/mach-s3c/include/plat/wakeup-mask.h
diff --git a/arch/arm/plat-samsung/init.c b/arch/arm/mach-s3c/init.c
similarity index 100%
rename from arch/arm/plat-samsung/init.c
rename to arch/arm/mach-s3c/init.c
diff --git a/arch/arm/mach-s3c24xx/iotiming-s3c2410.c b/arch/arm/mach-s3c/iotiming-s3c2410.c
similarity index 99%
rename from arch/arm/mach-s3c24xx/iotiming-s3c2410.c
rename to arch/arm/mach-s3c/iotiming-s3c2410.c
index 5d85c259f328..d91f26efd07a 100644
--- a/arch/arm/mach-s3c24xx/iotiming-s3c2410.c
+++ b/arch/arm/mach-s3c/iotiming-s3c2410.c
@@ -19,7 +19,7 @@
 
 #include <linux/soc/samsung/s3c-cpufreq-core.h>
 
-#include "regs-mem.h"
+#include "regs-mem-s3c24xx.h"
 
 #define print_ns(x) ((x) / 10), ((x) % 10)
 
diff --git a/arch/arm/mach-s3c24xx/iotiming-s3c2412.c b/arch/arm/mach-s3c/iotiming-s3c2412.c
similarity index 100%
rename from arch/arm/mach-s3c24xx/iotiming-s3c2412.c
rename to arch/arm/mach-s3c/iotiming-s3c2412.c
diff --git a/arch/arm/mach-s3c24xx/irq-pm.c b/arch/arm/mach-s3c/irq-pm-s3c24xx.c
similarity index 100%
rename from arch/arm/mach-s3c24xx/irq-pm.c
rename to arch/arm/mach-s3c/irq-pm-s3c24xx.c
diff --git a/arch/arm/mach-s3c64xx/irq-pm.c b/arch/arm/mach-s3c/irq-pm-s3c64xx.c
similarity index 100%
rename from arch/arm/mach-s3c64xx/irq-pm.c
rename to arch/arm/mach-s3c/irq-pm-s3c64xx.c
diff --git a/arch/arm/mach-s3c24xx/irq-s3c24xx-fiq-exports.c b/arch/arm/mach-s3c/irq-s3c24xx-fiq-exports.c
similarity index 100%
rename from arch/arm/mach-s3c24xx/irq-s3c24xx-fiq-exports.c
rename to arch/arm/mach-s3c/irq-s3c24xx-fiq-exports.c
diff --git a/arch/arm/mach-s3c24xx/irq-s3c24xx-fiq.S b/arch/arm/mach-s3c/irq-s3c24xx-fiq.S
similarity index 100%
rename from arch/arm/mach-s3c24xx/irq-s3c24xx-fiq.S
rename to arch/arm/mach-s3c/irq-s3c24xx-fiq.S
diff --git a/arch/arm/mach-s3c24xx/irq-s3c24xx.c b/arch/arm/mach-s3c/irq-s3c24xx.c
similarity index 100%
rename from arch/arm/mach-s3c24xx/irq-s3c24xx.c
rename to arch/arm/mach-s3c/irq-s3c24xx.c
diff --git a/arch/arm/mach-s3c64xx/irq-uart.h b/arch/arm/mach-s3c/irq-uart-s3c64xx.h
similarity index 100%
rename from arch/arm/mach-s3c64xx/irq-uart.h
rename to arch/arm/mach-s3c/irq-uart-s3c64xx.h
diff --git a/arch/arm/mach-s3c24xx/mach-amlm5900.c b/arch/arm/mach-s3c/mach-amlm5900.c
similarity index 99%
rename from arch/arm/mach-s3c24xx/mach-amlm5900.c
rename to arch/arm/mach-s3c/mach-amlm5900.c
index f04eb9aa29ac..724240e1b662 100644
--- a/arch/arm/mach-s3c24xx/mach-amlm5900.c
+++ b/arch/arm/mach-s3c/mach-amlm5900.c
@@ -44,7 +44,7 @@
 #include <linux/mtd/map.h>
 #include <linux/mtd/physmap.h>
 
-#include "common.h"
+#include "s3c24xx.h"
 
 static struct resource amlm5900_nor_resource =
 			DEFINE_RES_MEM(0x00000000, SZ_16M);
diff --git a/arch/arm/mach-s3c24xx/mach-anubis.c b/arch/arm/mach-s3c/mach-anubis.c
similarity index 99%
rename from arch/arm/mach-s3c24xx/mach-anubis.c
rename to arch/arm/mach-s3c/mach-anubis.c
index 15cab0976941..83b2f7fb268e 100644
--- a/arch/arm/mach-s3c24xx/mach-anubis.c
+++ b/arch/arm/mach-s3c/mach-anubis.c
@@ -44,7 +44,7 @@
 #include <linux/platform_data/asoc-s3c24xx_simtec.h>
 
 #include "anubis.h"
-#include "common.h"
+#include "s3c24xx.h"
 #include "simtec.h"
 
 #define COPYRIGHT ", Copyright 2005-2009 Simtec Electronics"
diff --git a/arch/arm/mach-s3c64xx/mach-anw6410.c b/arch/arm/mach-s3c/mach-anw6410.c
similarity index 99%
rename from arch/arm/mach-s3c64xx/mach-anw6410.c
rename to arch/arm/mach-s3c/mach-anw6410.c
index bb248b12e308..ff183ced8e6e 100644
--- a/arch/arm/mach-s3c64xx/mach-anw6410.c
+++ b/arch/arm/mach-s3c/mach-anw6410.c
@@ -44,8 +44,8 @@
 #include <mach/regs-gpio.h>
 #include <mach/gpio-samsung.h>
 
-#include "common.h"
-#include "regs-modem.h"
+#include "s3c64xx.h"
+#include "regs-modem-s3c64xx.h"
 
 /* DM9000 */
 #define ANW6410_PA_DM9000	(0x18000000)
diff --git a/arch/arm/mach-s3c24xx/mach-at2440evb.c b/arch/arm/mach-s3c/mach-at2440evb.c
similarity index 99%
rename from arch/arm/mach-s3c24xx/mach-at2440evb.c
rename to arch/arm/mach-s3c/mach-at2440evb.c
index 7fcb24a49ad8..1ae61ae913d4 100644
--- a/arch/arm/mach-s3c24xx/mach-at2440evb.c
+++ b/arch/arm/mach-s3c/mach-at2440evb.c
@@ -42,7 +42,7 @@
 #include <plat/cpu.h>
 #include <linux/platform_data/mmc-s3cmci.h>
 
-#include "common.h"
+#include "s3c24xx.h"
 
 static struct map_desc at2440evb_iodesc[] __initdata = {
 	/* Nothing here */
diff --git a/arch/arm/mach-s3c24xx/mach-bast.c b/arch/arm/mach-s3c/mach-bast.c
similarity index 99%
rename from arch/arm/mach-s3c24xx/mach-bast.c
rename to arch/arm/mach-s3c/mach-bast.c
index 7e3ce48539c4..f971cbf99d29 100644
--- a/arch/arm/mach-s3c24xx/mach-bast.c
+++ b/arch/arm/mach-s3c/mach-bast.c
@@ -50,7 +50,7 @@
 #include <plat/gpio-cfg.h>
 
 #include "bast.h"
-#include "common.h"
+#include "s3c24xx.h"
 #include "simtec.h"
 
 #define COPYRIGHT ", Copyright 2004-2008 Simtec Electronics"
diff --git a/arch/arm/mach-s3c64xx/mach-crag6410-module.c b/arch/arm/mach-s3c/mach-crag6410-module.c
similarity index 100%
rename from arch/arm/mach-s3c64xx/mach-crag6410-module.c
rename to arch/arm/mach-s3c/mach-crag6410-module.c
diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c/mach-crag6410.c
similarity index 99%
rename from arch/arm/mach-s3c64xx/mach-crag6410.c
rename to arch/arm/mach-s3c/mach-crag6410.c
index ca9a346056ed..8e7f637833f2 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410.c
+++ b/arch/arm/mach-s3c/mach-crag6410.c
@@ -61,11 +61,11 @@
 #include <linux/platform_data/i2c-s3c2410.h>
 #include <plat/pm.h>
 
-#include "common.h"
+#include "s3c64xx.h"
 #include "crag6410.h"
-#include "regs-gpio-memport.h"
-#include "regs-modem.h"
-#include "regs-sys.h"
+#include "regs-gpio-memport-s3c64xx.h"
+#include "regs-modem-s3c64xx.h"
+#include "regs-sys-s3c64xx.h"
 
 /* serial port setup */
 
diff --git a/arch/arm/mach-s3c24xx/mach-gta02.c b/arch/arm/mach-s3c/mach-gta02.c
similarity index 99%
rename from arch/arm/mach-s3c24xx/mach-gta02.c
rename to arch/arm/mach-s3c/mach-gta02.c
index a28e92142b04..b4fb58632555 100644
--- a/arch/arm/mach-s3c24xx/mach-gta02.c
+++ b/arch/arm/mach-s3c/mach-gta02.c
@@ -68,7 +68,7 @@
 #include <plat/gpio-cfg.h>
 #include <plat/pm.h>
 
-#include "common.h"
+#include "s3c24xx.h"
 #include "gta02.h"
 
 static struct pcf50633 *gta02_pcf;
diff --git a/arch/arm/mach-s3c24xx/mach-h1940.c b/arch/arm/mach-s3c/mach-h1940.c
similarity index 99%
rename from arch/arm/mach-s3c24xx/mach-h1940.c
rename to arch/arm/mach-s3c/mach-h1940.c
index 3cb56fc9db5c..c8e4c4d6a979 100644
--- a/arch/arm/mach-s3c24xx/mach-h1940.c
+++ b/arch/arm/mach-s3c/mach-h1940.c
@@ -49,7 +49,7 @@
 
 #include <linux/platform_data/fb-s3c2410.h>
 #include <mach/map.h>
-#include <mach/hardware.h>
+#include <mach/hardware-s3c24xx.h>
 #include <mach/regs-clock.h>
 #include <mach/regs-gpio.h>
 #include <mach/gpio-samsung.h>
@@ -59,7 +59,7 @@
 #include <plat/gpio-cfg.h>
 #include <plat/pm.h>
 
-#include "common.h"
+#include "s3c24xx.h"
 #include "h1940.h"
 
 #define H1940_LATCH		((void __force __iomem *)0xF8000000)
diff --git a/arch/arm/mach-s3c64xx/mach-hmt.c b/arch/arm/mach-s3c/mach-hmt.c
similarity index 99%
rename from arch/arm/mach-s3c64xx/mach-hmt.c
rename to arch/arm/mach-s3c/mach-hmt.c
index 32b555a4757b..e0d8cc30a0f0 100644
--- a/arch/arm/mach-s3c64xx/mach-hmt.c
+++ b/arch/arm/mach-s3c/mach-hmt.c
@@ -39,7 +39,7 @@
 #include <plat/devs.h>
 #include <plat/cpu.h>
 
-#include "common.h"
+#include "s3c64xx.h"
 
 #define UCON S3C2410_UCON_DEFAULT
 #define ULCON (S3C2410_LCON_CS8 | S3C2410_LCON_PNONE)
diff --git a/arch/arm/mach-s3c24xx/mach-jive.c b/arch/arm/mach-s3c/mach-jive.c
similarity index 99%
rename from arch/arm/mach-s3c24xx/mach-jive.c
rename to arch/arm/mach-s3c/mach-jive.c
index 9ef8733be3fd..2e7119d34179 100644
--- a/arch/arm/mach-s3c24xx/mach-jive.c
+++ b/arch/arm/mach-s3c/mach-jive.c
@@ -31,7 +31,7 @@
 #include <linux/platform_data/mtd-nand-s3c2410.h>
 #include <linux/platform_data/i2c-s3c2410.h>
 
-#include <mach/hardware.h>
+#include <mach/hardware-s3c24xx.h>
 #include <mach/regs-gpio.h>
 #include <linux/platform_data/fb-s3c2410.h>
 #include <mach/gpio-samsung.h>
@@ -49,7 +49,7 @@
 #include <plat/pm.h>
 #include <linux/platform_data/usb-s3c2410_udc.h>
 
-#include "common.h"
+#include "s3c24xx.h"
 #include "s3c2412-power.h"
 
 static struct map_desc jive_iodesc[] __initdata = {
diff --git a/arch/arm/mach-s3c24xx/mach-mini2440.c b/arch/arm/mach-s3c/mach-mini2440.c
similarity index 99%
rename from arch/arm/mach-s3c24xx/mach-mini2440.c
rename to arch/arm/mach-s3c/mach-mini2440.c
index 6f58a3404b36..83de1ba22cda 100644
--- a/arch/arm/mach-s3c24xx/mach-mini2440.c
+++ b/arch/arm/mach-s3c/mach-mini2440.c
@@ -53,7 +53,7 @@
 
 #include <sound/s3c24xx_uda134x.h>
 
-#include "common.h"
+#include "s3c24xx.h"
 
 #define MACH_MINI2440_DM9K_BASE (S3C2410_CS4 + 0x300)
 
diff --git a/arch/arm/mach-s3c64xx/mach-mini6410.c b/arch/arm/mach-s3c/mach-mini6410.c
similarity index 99%
rename from arch/arm/mach-s3c64xx/mach-mini6410.c
rename to arch/arm/mach-s3c/mach-mini6410.c
index cbf6a1696a6d..9bd6581619b9 100644
--- a/arch/arm/mach-s3c64xx/mach-mini6410.c
+++ b/arch/arm/mach-s3c/mach-mini6410.c
@@ -40,9 +40,9 @@
 #include <video/platform_lcd.h>
 #include <video/samsung_fimd.h>
 
-#include "common.h"
-#include "regs-modem.h"
-#include "regs-srom.h"
+#include "s3c64xx.h"
+#include "regs-modem-s3c64xx.h"
+#include "regs-srom-s3c64xx.h"
 
 #define UCON S3C2410_UCON_DEFAULT
 #define ULCON (S3C2410_LCON_CS8 | S3C2410_LCON_PNONE | S3C2410_LCON_STOPB)
diff --git a/arch/arm/mach-s3c24xx/mach-n30.c b/arch/arm/mach-s3c/mach-n30.c
similarity index 99%
rename from arch/arm/mach-s3c24xx/mach-n30.c
rename to arch/arm/mach-s3c/mach-n30.c
index a3c1315f5ffb..d79bd9b8e25e 100644
--- a/arch/arm/mach-s3c24xx/mach-n30.c
+++ b/arch/arm/mach-s3c/mach-n30.c
@@ -27,7 +27,7 @@
 #include <linux/io.h>
 #include <linux/mmc/host.h>
 
-#include <mach/hardware.h>
+#include <mach/hardware-s3c24xx.h>
 #include <asm/irq.h>
 #include <asm/mach-types.h>
 
@@ -49,7 +49,7 @@
 #include <linux/platform_data/mmc-s3cmci.h>
 #include <linux/platform_data/usb-s3c2410_udc.h>
 
-#include "common.h"
+#include "s3c24xx.h"
 
 static struct map_desc n30_iodesc[] __initdata = {
 	/* nothing here yet */
diff --git a/arch/arm/mach-s3c64xx/mach-ncp.c b/arch/arm/mach-s3c/mach-ncp.c
similarity index 99%
rename from arch/arm/mach-s3c64xx/mach-ncp.c
rename to arch/arm/mach-s3c/mach-ncp.c
index f0a26dd27938..ed4dd67add97 100644
--- a/arch/arm/mach-s3c64xx/mach-ncp.c
+++ b/arch/arm/mach-s3c/mach-ncp.c
@@ -36,7 +36,7 @@
 #include <plat/devs.h>
 #include <plat/cpu.h>
 
-#include "common.h"
+#include "s3c64xx.h"
 
 #define UCON S3C2410_UCON_DEFAULT
 #define ULCON S3C2410_LCON_CS8 | S3C2410_LCON_PNONE
diff --git a/arch/arm/mach-s3c24xx/mach-nexcoder.c b/arch/arm/mach-s3c/mach-nexcoder.c
similarity index 99%
rename from arch/arm/mach-s3c24xx/mach-nexcoder.c
rename to arch/arm/mach-s3c/mach-nexcoder.c
index ec23b115261e..84610a91e732 100644
--- a/arch/arm/mach-s3c24xx/mach-nexcoder.c
+++ b/arch/arm/mach-s3c/mach-nexcoder.c
@@ -40,7 +40,7 @@
 #include <plat/devs.h>
 #include <plat/cpu.h>
 
-#include "common.h"
+#include "s3c24xx.h"
 
 static struct map_desc nexcoder_iodesc[] __initdata = {
 	/* nothing here yet */
diff --git a/arch/arm/mach-s3c24xx/mach-osiris-dvs.c b/arch/arm/mach-s3c/mach-osiris-dvs.c
similarity index 100%
rename from arch/arm/mach-s3c24xx/mach-osiris-dvs.c
rename to arch/arm/mach-s3c/mach-osiris-dvs.c
diff --git a/arch/arm/mach-s3c24xx/mach-osiris.c b/arch/arm/mach-s3c/mach-osiris.c
similarity index 99%
rename from arch/arm/mach-s3c24xx/mach-osiris.c
rename to arch/arm/mach-s3c/mach-osiris.c
index 258850c1bbb2..90cf7d8cb07d 100644
--- a/arch/arm/mach-s3c24xx/mach-osiris.c
+++ b/arch/arm/mach-s3c/mach-osiris.c
@@ -44,9 +44,9 @@
 #include <mach/regs-gpio.h>
 #include <mach/gpio-samsung.h>
 
-#include "common.h"
+#include "s3c24xx.h"
 #include "osiris.h"
-#include "regs-mem.h"
+#include "regs-mem-s3c24xx.h"
 
 /* onboard perihperal map */
 
diff --git a/arch/arm/mach-s3c24xx/mach-otom.c b/arch/arm/mach-s3c/mach-otom.c
similarity index 99%
rename from arch/arm/mach-s3c24xx/mach-otom.c
rename to arch/arm/mach-s3c/mach-otom.c
index 1f777ab4ced7..32482f052ac7 100644
--- a/arch/arm/mach-s3c24xx/mach-otom.c
+++ b/arch/arm/mach-s3c/mach-otom.c
@@ -29,7 +29,7 @@
 #include <plat/cpu.h>
 #include <plat/devs.h>
 
-#include "common.h"
+#include "s3c24xx.h"
 #include "otom.h"
 
 static struct map_desc otom11_iodesc[] __initdata = {
diff --git a/arch/arm/mach-s3c24xx/mach-qt2410.c b/arch/arm/mach-s3c/mach-qt2410.c
similarity index 99%
rename from arch/arm/mach-s3c24xx/mach-qt2410.c
rename to arch/arm/mach-s3c/mach-qt2410.c
index 1ccad4e9e437..ea7af23b0ac7 100644
--- a/arch/arm/mach-s3c24xx/mach-qt2410.c
+++ b/arch/arm/mach-s3c/mach-qt2410.c
@@ -43,8 +43,8 @@
 #include <plat/cpu.h>
 #include <plat/pm.h>
 
-#include "common.h"
-#include "common-smdk.h"
+#include "s3c24xx.h"
+#include "common-smdk-s3c24xx.h"
 
 static struct map_desc qt2410_iodesc[] __initdata = {
 	{ 0xe0000000, __phys_to_pfn(S3C2410_CS3+0x01000000), SZ_1M, MT_DEVICE }
diff --git a/arch/arm/mach-s3c64xx/mach-real6410.c b/arch/arm/mach-s3c/mach-real6410.c
similarity index 98%
rename from arch/arm/mach-s3c64xx/mach-real6410.c
rename to arch/arm/mach-s3c/mach-real6410.c
index e2aa7c0998bd..099a99e5b6d2 100644
--- a/arch/arm/mach-s3c64xx/mach-real6410.c
+++ b/arch/arm/mach-s3c/mach-real6410.c
@@ -39,9 +39,9 @@
 #include <video/platform_lcd.h>
 #include <video/samsung_fimd.h>
 
-#include "common.h"
-#include "regs-modem.h"
-#include "regs-srom.h"
+#include "s3c64xx.h"
+#include "regs-modem-s3c64xx.h"
+#include "regs-srom-s3c64xx.h"
 
 #define UCON S3C2410_UCON_DEFAULT
 #define ULCON (S3C2410_LCON_CS8 | S3C2410_LCON_PNONE | S3C2410_LCON_STOPB)
diff --git a/arch/arm/mach-s3c24xx/mach-rx1950.c b/arch/arm/mach-s3c/mach-rx1950.c
similarity index 99%
rename from arch/arm/mach-s3c24xx/mach-rx1950.c
rename to arch/arm/mach-s3c/mach-rx1950.c
index af6300076b0a..13614b372109 100644
--- a/arch/arm/mach-s3c24xx/mach-rx1950.c
+++ b/arch/arm/mach-s3c/mach-rx1950.c
@@ -46,7 +46,7 @@
 
 #include <sound/uda1380.h>
 
-#include <mach/hardware.h>
+#include <mach/hardware-s3c24xx.h>
 #include <mach/regs-gpio.h>
 #include <mach/gpio-samsung.h>
 
@@ -55,7 +55,7 @@
 #include <plat/pm.h>
 #include <plat/gpio-cfg.h>
 
-#include "common.h"
+#include "s3c24xx.h"
 #include "h1940.h"
 
 #define LCD_PWM_PERIOD 192960
diff --git a/arch/arm/mach-s3c24xx/mach-rx3715.c b/arch/arm/mach-s3c/mach-rx3715.c
similarity index 99%
rename from arch/arm/mach-s3c24xx/mach-rx3715.c
rename to arch/arm/mach-s3c/mach-rx3715.c
index 0eb45f13f0c4..1c0730176799 100644
--- a/arch/arm/mach-s3c24xx/mach-rx3715.c
+++ b/arch/arm/mach-s3c/mach-rx3715.c
@@ -43,7 +43,7 @@
 #include <plat/devs.h>
 #include <plat/pm.h>
 
-#include "common.h"
+#include "s3c24xx.h"
 #include "h1940.h"
 
 static struct map_desc rx3715_iodesc[] __initdata = {
diff --git a/arch/arm/mach-s3c24xx/mach-s3c2416-dt.c b/arch/arm/mach-s3c/mach-s3c2416-dt.c
similarity index 98%
rename from arch/arm/mach-s3c24xx/mach-s3c2416-dt.c
rename to arch/arm/mach-s3c/mach-s3c2416-dt.c
index aa7102713b37..2924e230e79d 100644
--- a/arch/arm/mach-s3c24xx/mach-s3c2416-dt.c
+++ b/arch/arm/mach-s3c/mach-s3c2416-dt.c
@@ -21,7 +21,7 @@
 #include <plat/cpu.h>
 #include <plat/pm.h>
 
-#include "common.h"
+#include "s3c24xx.h"
 
 static void __init s3c2416_dt_map_io(void)
 {
diff --git a/arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c b/arch/arm/mach-s3c/mach-s3c64xx-dt.c
similarity index 98%
rename from arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c
rename to arch/arm/mach-s3c/mach-s3c64xx-dt.c
index 09c4e8742629..cd1da9602c86 100644
--- a/arch/arm/mach-s3c64xx/mach-s3c64xx-dt.c
+++ b/arch/arm/mach-s3c/mach-s3c64xx-dt.c
@@ -11,7 +11,7 @@
 #include <plat/cpu.h>
 #include <mach/map.h>
 
-#include "common.h"
+#include "s3c64xx.h"
 
 /*
  * IO mapping for shared system controller IP.
diff --git a/arch/arm/mach-s3c64xx/mach-smartq.c b/arch/arm/mach-s3c/mach-smartq.c
similarity index 99%
rename from arch/arm/mach-s3c64xx/mach-smartq.c
rename to arch/arm/mach-s3c/mach-smartq.c
index 37d878909b17..3a9ca85d09c5 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq.c
+++ b/arch/arm/mach-s3c/mach-smartq.c
@@ -33,9 +33,9 @@
 
 #include <video/platform_lcd.h>
 
-#include "common.h"
+#include "s3c64xx.h"
 #include "mach-smartq.h"
-#include "regs-modem.h"
+#include "regs-modem-s3c64xx.h"
 
 #define UCON S3C2410_UCON_DEFAULT
 #define ULCON (S3C2410_LCON_CS8 | S3C2410_LCON_PNONE)
diff --git a/arch/arm/mach-s3c64xx/mach-smartq.h b/arch/arm/mach-s3c/mach-smartq.h
similarity index 100%
rename from arch/arm/mach-s3c64xx/mach-smartq.h
rename to arch/arm/mach-s3c/mach-smartq.h
diff --git a/arch/arm/mach-s3c64xx/mach-smartq5.c b/arch/arm/mach-s3c/mach-smartq5.c
similarity index 99%
rename from arch/arm/mach-s3c64xx/mach-smartq5.c
rename to arch/arm/mach-s3c/mach-smartq5.c
index 789876a20534..f67cc50cb5b9 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq5.c
+++ b/arch/arm/mach-s3c/mach-smartq5.c
@@ -24,7 +24,7 @@
 #include <plat/fb.h>
 #include <plat/gpio-cfg.h>
 
-#include "common.h"
+#include "s3c64xx.h"
 #include "mach-smartq.h"
 
 static struct gpio_led smartq5_leds[] = {
diff --git a/arch/arm/mach-s3c64xx/mach-smartq7.c b/arch/arm/mach-s3c/mach-smartq7.c
similarity index 99%
rename from arch/arm/mach-s3c64xx/mach-smartq7.c
rename to arch/arm/mach-s3c/mach-smartq7.c
index d004e34b63bb..af58147c6721 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq7.c
+++ b/arch/arm/mach-s3c/mach-smartq7.c
@@ -24,7 +24,7 @@
 #include <plat/fb.h>
 #include <plat/gpio-cfg.h>
 
-#include "common.h"
+#include "s3c64xx.h"
 #include "mach-smartq.h"
 
 static struct gpio_led smartq7_leds[] = {
diff --git a/arch/arm/mach-s3c24xx/mach-smdk2410.c b/arch/arm/mach-s3c/mach-smdk2410.c
similarity index 97%
rename from arch/arm/mach-s3c24xx/mach-smdk2410.c
rename to arch/arm/mach-s3c/mach-smdk2410.c
index c78fe1d8802c..411216c46522 100644
--- a/arch/arm/mach-s3c24xx/mach-smdk2410.c
+++ b/arch/arm/mach-s3c/mach-smdk2410.c
@@ -34,8 +34,8 @@
 #include <plat/devs.h>
 #include <plat/cpu.h>
 
-#include "common.h"
-#include "common-smdk.h"
+#include "s3c24xx.h"
+#include "common-smdk-s3c24xx.h"
 
 static struct map_desc smdk2410_iodesc[] __initdata = {
   /* nothing here yet */
diff --git a/arch/arm/mach-s3c24xx/mach-smdk2413.c b/arch/arm/mach-s3c/mach-smdk2413.c
similarity index 97%
rename from arch/arm/mach-s3c24xx/mach-smdk2413.c
rename to arch/arm/mach-s3c/mach-smdk2413.c
index 4604ec89f06e..2ebf78cf0f3f 100644
--- a/arch/arm/mach-s3c24xx/mach-smdk2413.c
+++ b/arch/arm/mach-s3c/mach-smdk2413.c
@@ -23,7 +23,7 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
-#include <mach/hardware.h>
+#include <mach/hardware-s3c24xx.h>
 #include <asm/hardware/iomd.h>
 #include <asm/setup.h>
 #include <asm/irq.h>
@@ -41,8 +41,8 @@
 #include <plat/devs.h>
 #include <plat/cpu.h>
 
-#include "common.h"
-#include "common-smdk.h"
+#include "s3c24xx.h"
+#include "common-smdk-s3c24xx.h"
 
 static struct map_desc smdk2413_iodesc[] __initdata = {
 };
diff --git a/arch/arm/mach-s3c24xx/mach-smdk2416.c b/arch/arm/mach-s3c/mach-smdk2416.c
similarity index 98%
rename from arch/arm/mach-s3c24xx/mach-smdk2416.c
rename to arch/arm/mach-s3c/mach-smdk2416.c
index 217401b2238d..3bf3322740fc 100644
--- a/arch/arm/mach-s3c24xx/mach-smdk2416.c
+++ b/arch/arm/mach-s3c/mach-smdk2416.c
@@ -25,7 +25,7 @@
 #include <asm/mach/irq.h>
 
 #include <video/samsung_fimd.h>
-#include <mach/hardware.h>
+#include <mach/hardware-s3c24xx.h>
 #include <asm/irq.h>
 #include <asm/mach-types.h>
 
@@ -46,8 +46,8 @@
 
 #include <plat/fb.h>
 
-#include "common.h"
-#include "common-smdk.h"
+#include "s3c24xx.h"
+#include "common-smdk-s3c24xx.h"
 
 static struct map_desc smdk2416_iodesc[] __initdata = {
 	/* ISA IO Space map (memory space selected by A24) */
diff --git a/arch/arm/mach-s3c24xx/mach-smdk2440.c b/arch/arm/mach-s3c/mach-smdk2440.c
similarity index 98%
rename from arch/arm/mach-s3c24xx/mach-smdk2440.c
rename to arch/arm/mach-s3c/mach-smdk2440.c
index a0116cff6e4e..cc40316bc294 100644
--- a/arch/arm/mach-s3c24xx/mach-smdk2440.c
+++ b/arch/arm/mach-s3c/mach-smdk2440.c
@@ -36,8 +36,8 @@
 #include <plat/devs.h>
 #include <plat/cpu.h>
 
-#include "common.h"
-#include "common-smdk.h"
+#include "s3c24xx.h"
+#include "common-smdk-s3c24xx.h"
 
 static struct map_desc smdk2440_iodesc[] __initdata = {
 	/* ISA IO Space map (memory space selected by A24) */
diff --git a/arch/arm/mach-s3c24xx/mach-smdk2443.c b/arch/arm/mach-s3c/mach-smdk2443.c
similarity index 98%
rename from arch/arm/mach-s3c24xx/mach-smdk2443.c
rename to arch/arm/mach-s3c/mach-smdk2443.c
index 1c2fa7c3feb8..85a3f73fd0a1 100644
--- a/arch/arm/mach-s3c24xx/mach-smdk2443.c
+++ b/arch/arm/mach-s3c/mach-smdk2443.c
@@ -33,8 +33,8 @@
 #include <plat/devs.h>
 #include <plat/cpu.h>
 
-#include "common.h"
-#include "common-smdk.h"
+#include "s3c24xx.h"
+#include "common-smdk-s3c24xx.h"
 
 static struct map_desc smdk2443_iodesc[] __initdata = {
 	/* ISA IO Space map (memory space selected by A24) */
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6400.c b/arch/arm/mach-s3c/mach-smdk6400.c
similarity index 99%
rename from arch/arm/mach-s3c64xx/mach-smdk6400.c
rename to arch/arm/mach-s3c/mach-smdk6400.c
index ca033450ab8c..18ee5e203ca0 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6400.c
+++ b/arch/arm/mach-s3c/mach-smdk6400.c
@@ -30,7 +30,7 @@
 #include <linux/platform_data/i2c-s3c2410.h>
 #include <mach/gpio-samsung.h>
 
-#include "common.h"
+#include "s3c64xx.h"
 
 #define UCON S3C2410_UCON_DEFAULT | S3C2410_UCON_UCLK
 #define ULCON S3C2410_LCON_CS8 | S3C2410_LCON_PNONE | S3C2410_LCON_STOPB
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c/mach-smdk6410.c
similarity index 99%
rename from arch/arm/mach-s3c64xx/mach-smdk6410.c
rename to arch/arm/mach-s3c/mach-smdk6410.c
index febeacc476c8..371a605daa30 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
+++ b/arch/arm/mach-s3c/mach-smdk6410.c
@@ -64,11 +64,11 @@
 #include <linux/platform_data/touchscreen-s3c2410.h>
 #include <plat/keypad.h>
 
-#include "backlight.h"
-#include "common.h"
-#include "regs-modem.h"
-#include "regs-srom.h"
-#include "regs-sys.h"
+#include "backlight-s3c64xx.h"
+#include "s3c64xx.h"
+#include "regs-modem-s3c64xx.h"
+#include "regs-srom-s3c64xx.h"
+#include "regs-sys-s3c64xx.h"
 
 #define UCON S3C2410_UCON_DEFAULT | S3C2410_UCON_UCLK
 #define ULCON S3C2410_LCON_CS8 | S3C2410_LCON_PNONE | S3C2410_LCON_STOPB
diff --git a/arch/arm/mach-s3c24xx/mach-tct_hammer.c b/arch/arm/mach-s3c/mach-tct_hammer.c
similarity index 99%
rename from arch/arm/mach-s3c24xx/mach-tct_hammer.c
rename to arch/arm/mach-s3c/mach-tct_hammer.c
index 8092be7b47db..53a550b915e0 100644
--- a/arch/arm/mach-s3c24xx/mach-tct_hammer.c
+++ b/arch/arm/mach-s3c/mach-tct_hammer.c
@@ -37,7 +37,7 @@
 #include <linux/mtd/map.h>
 #include <linux/mtd/physmap.h>
 
-#include "common.h"
+#include "s3c24xx.h"
 
 static struct resource tct_hammer_nor_resource =
 			DEFINE_RES_MEM(0x00000000, SZ_16M);
diff --git a/arch/arm/mach-s3c24xx/mach-vr1000.c b/arch/arm/mach-s3c/mach-vr1000.c
similarity index 99%
rename from arch/arm/mach-s3c24xx/mach-vr1000.c
rename to arch/arm/mach-s3c/mach-vr1000.c
index 638e53ec1e4f..b63ece0def04 100644
--- a/arch/arm/mach-s3c24xx/mach-vr1000.c
+++ b/arch/arm/mach-s3c/mach-vr1000.c
@@ -43,7 +43,7 @@
 #include <plat/gpio-cfg.h>
 
 #include "bast.h"
-#include "common.h"
+#include "s3c24xx.h"
 #include "simtec.h"
 #include "vr1000.h"
 
diff --git a/arch/arm/mach-s3c24xx/mach-vstms.c b/arch/arm/mach-s3c/mach-vstms.c
similarity index 99%
rename from arch/arm/mach-s3c24xx/mach-vstms.c
rename to arch/arm/mach-s3c/mach-vstms.c
index ff3fa0017494..0bd289705a01 100644
--- a/arch/arm/mach-s3c24xx/mach-vstms.c
+++ b/arch/arm/mach-s3c/mach-vstms.c
@@ -40,7 +40,7 @@
 #include <plat/devs.h>
 #include <plat/cpu.h>
 
-#include "common.h"
+#include "s3c24xx.h"
 
 static struct map_desc vstms_iodesc[] __initdata = {
 };
diff --git a/arch/arm/mach-s3c24xx/nand-core.h b/arch/arm/mach-s3c/nand-core-s3c24xx.h
similarity index 77%
rename from arch/arm/mach-s3c24xx/nand-core.h
rename to arch/arm/mach-s3c/nand-core-s3c24xx.h
index 8de633d416ae..a14316729c48 100644
--- a/arch/arm/mach-s3c24xx/nand-core.h
+++ b/arch/arm/mach-s3c/nand-core-s3c24xx.h
@@ -6,8 +6,8 @@
  * S3C -  Nand Controller core functions
  */
 
-#ifndef __ASM_ARCH_NAND_CORE_H
-#define __ASM_ARCH_NAND_CORE_H __FILE__
+#ifndef __ASM_ARCH_NAND_CORE_S3C24XX_H
+#define __ASM_ARCH_NAND_CORE_S3C24XX_H __FILE__
 
 /* These functions are only for use with the core support code, such as
  * the cpu specific initialisation code
@@ -21,4 +21,4 @@ static inline void s3c_nand_setname(char *name)
 #endif
 }
 
-#endif /* __ASM_ARCH_NAND_CORE_H */
+#endif /* __ASM_ARCH_NAND_CORE_S3C24XX_H */
diff --git a/arch/arm/mach-s3c64xx/onenand-core.h b/arch/arm/mach-s3c/onenand-core-s3c64xx.h
similarity index 82%
rename from arch/arm/mach-s3c64xx/onenand-core.h
rename to arch/arm/mach-s3c/onenand-core-s3c64xx.h
index 0cf6b5e76b24..e2dfdd1fec93 100644
--- a/arch/arm/mach-s3c64xx/onenand-core.h
+++ b/arch/arm/mach-s3c/onenand-core-s3c64xx.h
@@ -7,8 +7,8 @@
  * Samsung OneNAD Controller core functions
  */
 
-#ifndef __ASM_ARCH_ONENAND_CORE_H
-#define __ASM_ARCH_ONENAND_CORE_H __FILE__
+#ifndef __ASM_ARCH_ONENAND_CORE_S3C64XX_H
+#define __ASM_ARCH_ONENAND_CORE_S3C64XX_H __FILE__
 
 /* These functions are only for use with the core support code, such as
  * the cpu specific initialisation code
@@ -29,4 +29,4 @@ static inline void s3c64xx_onenand1_setname(char *name)
 #endif
 }
 
-#endif /* __ASM_ARCH_ONENAND_CORE_H */
+#endif /* __ASM_ARCH_ONENAND_CORE_S3C64XX_H */
diff --git a/arch/arm/mach-s3c24xx/osiris.h b/arch/arm/mach-s3c/osiris.h
similarity index 100%
rename from arch/arm/mach-s3c24xx/osiris.h
rename to arch/arm/mach-s3c/osiris.h
diff --git a/arch/arm/mach-s3c24xx/otom.h b/arch/arm/mach-s3c/otom.h
similarity index 100%
rename from arch/arm/mach-s3c24xx/otom.h
rename to arch/arm/mach-s3c/otom.h
diff --git a/arch/arm/mach-s3c64xx/pl080.c b/arch/arm/mach-s3c/pl080.c
similarity index 99%
rename from arch/arm/mach-s3c64xx/pl080.c
rename to arch/arm/mach-s3c/pl080.c
index 152edbeea0c7..3cbc755f7cd0 100644
--- a/arch/arm/mach-s3c64xx/pl080.c
+++ b/arch/arm/mach-s3c/pl080.c
@@ -14,7 +14,7 @@
 #include <mach/irqs.h>
 #include <mach/map.h>
 
-#include "regs-sys.h"
+#include "regs-sys-s3c64xx.h"
 
 static int pl08x_get_xfer_signal(const struct pl08x_channel_data *cd)
 {
diff --git a/arch/arm/plat-samsung/platformdata.c b/arch/arm/mach-s3c/platformdata.c
similarity index 100%
rename from arch/arm/plat-samsung/platformdata.c
rename to arch/arm/mach-s3c/platformdata.c
diff --git a/arch/arm/mach-s3c24xx/pll-s3c2410.c b/arch/arm/mach-s3c/pll-s3c2410.c
similarity index 100%
rename from arch/arm/mach-s3c24xx/pll-s3c2410.c
rename to arch/arm/mach-s3c/pll-s3c2410.c
diff --git a/arch/arm/mach-s3c24xx/pll-s3c2440-12000000.c b/arch/arm/mach-s3c/pll-s3c2440-12000000.c
similarity index 100%
rename from arch/arm/mach-s3c24xx/pll-s3c2440-12000000.c
rename to arch/arm/mach-s3c/pll-s3c2440-12000000.c
diff --git a/arch/arm/mach-s3c24xx/pll-s3c2440-16934400.c b/arch/arm/mach-s3c/pll-s3c2440-16934400.c
similarity index 100%
rename from arch/arm/mach-s3c24xx/pll-s3c2440-16934400.c
rename to arch/arm/mach-s3c/pll-s3c2440-16934400.c
diff --git a/arch/arm/plat-samsung/pm-common.c b/arch/arm/mach-s3c/pm-common.c
similarity index 100%
rename from arch/arm/plat-samsung/pm-common.c
rename to arch/arm/mach-s3c/pm-common.c
diff --git a/arch/arm/plat-samsung/pm-gpio.c b/arch/arm/mach-s3c/pm-gpio.c
similarity index 100%
rename from arch/arm/plat-samsung/pm-gpio.c
rename to arch/arm/mach-s3c/pm-gpio.c
diff --git a/arch/arm/mach-s3c24xx/pm-h1940.S b/arch/arm/mach-s3c/pm-h1940.S
similarity index 100%
rename from arch/arm/mach-s3c24xx/pm-h1940.S
rename to arch/arm/mach-s3c/pm-h1940.S
diff --git a/arch/arm/mach-s3c24xx/pm-s3c2410.c b/arch/arm/mach-s3c/pm-s3c2410.c
similarity index 100%
rename from arch/arm/mach-s3c24xx/pm-s3c2410.c
rename to arch/arm/mach-s3c/pm-s3c2410.c
diff --git a/arch/arm/mach-s3c24xx/pm-s3c2412.c b/arch/arm/mach-s3c/pm-s3c2412.c
similarity index 98%
rename from arch/arm/mach-s3c24xx/pm-s3c2412.c
rename to arch/arm/mach-s3c/pm-s3c2412.c
index 2779d67d2c07..1caf53b65dc1 100644
--- a/arch/arm/mach-s3c24xx/pm-s3c2412.c
+++ b/arch/arm/mach-s3c/pm-s3c2412.c
@@ -26,7 +26,7 @@
 #include <plat/pm.h>
 #include <plat/wakeup-mask.h>
 
-#include "regs-dsc.h"
+#include "regs-dsc-s3c24xx.h"
 #include "s3c2412-power.h"
 
 extern void s3c2412_sleep_enter(void);
diff --git a/arch/arm/mach-s3c24xx/pm-s3c2416.c b/arch/arm/mach-s3c/pm-s3c2416.c
similarity index 100%
rename from arch/arm/mach-s3c24xx/pm-s3c2416.c
rename to arch/arm/mach-s3c/pm-s3c2416.c
diff --git a/arch/arm/mach-s3c24xx/pm.c b/arch/arm/mach-s3c/pm-s3c24xx.c
similarity index 98%
rename from arch/arm/mach-s3c24xx/pm.c
rename to arch/arm/mach-s3c/pm-s3c24xx.c
index c64988c609ad..0c583cbe41b2 100644
--- a/arch/arm/mach-s3c24xx/pm.c
+++ b/arch/arm/mach-s3c/pm-s3c24xx.c
@@ -31,7 +31,7 @@
 #include <plat/gpio-cfg.h>
 #include <plat/pm.h>
 
-#include "regs-mem.h"
+#include "regs-mem-s3c24xx.h"
 
 #define PFX "s3c24xx-pm: "
 
diff --git a/arch/arm/mach-s3c64xx/pm.c b/arch/arm/mach-s3c/pm-s3c64xx.c
similarity index 98%
rename from arch/arm/mach-s3c64xx/pm.c
rename to arch/arm/mach-s3c/pm-s3c64xx.c
index a612e9779057..03393664a797 100644
--- a/arch/arm/mach-s3c64xx/pm.c
+++ b/arch/arm/mach-s3c/pm-s3c64xx.c
@@ -26,10 +26,10 @@
 #include <mach/regs-clock.h>
 #include <mach/gpio-samsung.h>
 
-#include "regs-gpio-memport.h"
-#include "regs-modem.h"
-#include "regs-sys.h"
-#include "regs-syscon-power.h"
+#include "regs-gpio-memport-s3c64xx.h"
+#include "regs-modem-s3c64xx.h"
+#include "regs-sys-s3c64xx.h"
+#include "regs-syscon-power-s3c64xx.h"
 
 struct s3c64xx_pm_domain {
 	char *const name;
diff --git a/arch/arm/plat-samsung/pm.c b/arch/arm/mach-s3c/pm.c
similarity index 100%
rename from arch/arm/plat-samsung/pm.c
rename to arch/arm/mach-s3c/pm.c
diff --git a/arch/arm/mach-s3c24xx/regs-dsc.h b/arch/arm/mach-s3c/regs-dsc-s3c24xx.h
similarity index 77%
rename from arch/arm/mach-s3c24xx/regs-dsc.h
rename to arch/arm/mach-s3c/regs-dsc-s3c24xx.h
index b500636276f2..8b8b572aef04 100644
--- a/arch/arm/mach-s3c24xx/regs-dsc.h
+++ b/arch/arm/mach-s3c/regs-dsc-s3c24xx.h
@@ -7,8 +7,8 @@
  */
 
 
-#ifndef __ASM_ARCH_REGS_DSC_H
-#define __ASM_ARCH_REGS_DSC_H __FILE__
+#ifndef __ASM_ARCH_REGS_DSC_S3C24XX_H
+#define __ASM_ARCH_REGS_DSC_S3C24XX_H __FILE__
 
 /* S3C2412 */
 #define S3C2412_DSC0	   S3C2410_GPIOREG(0xdc)
@@ -18,5 +18,5 @@
 #define S3C2440_DSC0	   S3C2410_GPIOREG(0xc4)
 #define S3C2440_DSC1	   S3C2410_GPIOREG(0xc8)
 
-#endif	/* __ASM_ARCH_REGS_DSC_H */
+#endif	/* __ASM_ARCH_REGS_DSC_S3C24XX_H */
 
diff --git a/arch/arm/mach-s3c64xx/regs-gpio-memport.h b/arch/arm/mach-s3c/regs-gpio-memport-s3c64xx.h
similarity index 100%
rename from arch/arm/mach-s3c64xx/regs-gpio-memport.h
rename to arch/arm/mach-s3c/regs-gpio-memport-s3c64xx.h
diff --git a/arch/arm/mach-s3c24xx/regs-mem.h b/arch/arm/mach-s3c/regs-mem-s3c24xx.h
similarity index 100%
rename from arch/arm/mach-s3c24xx/regs-mem.h
rename to arch/arm/mach-s3c/regs-mem-s3c24xx.h
diff --git a/arch/arm/mach-s3c64xx/regs-modem.h b/arch/arm/mach-s3c/regs-modem-s3c64xx.h
similarity index 100%
rename from arch/arm/mach-s3c64xx/regs-modem.h
rename to arch/arm/mach-s3c/regs-modem-s3c64xx.h
diff --git a/arch/arm/mach-s3c64xx/regs-srom.h b/arch/arm/mach-s3c/regs-srom-s3c64xx.h
similarity index 100%
rename from arch/arm/mach-s3c64xx/regs-srom.h
rename to arch/arm/mach-s3c/regs-srom-s3c64xx.h
diff --git a/arch/arm/mach-s3c64xx/regs-sys.h b/arch/arm/mach-s3c/regs-sys-s3c64xx.h
similarity index 100%
rename from arch/arm/mach-s3c64xx/regs-sys.h
rename to arch/arm/mach-s3c/regs-sys-s3c64xx.h
diff --git a/arch/arm/mach-s3c64xx/regs-syscon-power.h b/arch/arm/mach-s3c/regs-syscon-power-s3c64xx.h
similarity index 100%
rename from arch/arm/mach-s3c64xx/regs-syscon-power.h
rename to arch/arm/mach-s3c/regs-syscon-power-s3c64xx.h
diff --git a/arch/arm/mach-s3c64xx/regs-usb-hsotg-phy.h b/arch/arm/mach-s3c/regs-usb-hsotg-phy-s3c64xx.h
similarity index 100%
rename from arch/arm/mach-s3c64xx/regs-usb-hsotg-phy.h
rename to arch/arm/mach-s3c/regs-usb-hsotg-phy-s3c64xx.h
diff --git a/arch/arm/mach-s3c24xx/s3c2410.c b/arch/arm/mach-s3c/s3c2410.c
similarity index 99%
rename from arch/arm/mach-s3c24xx/s3c2410.c
rename to arch/arm/mach-s3c/s3c2410.c
index 44bf3e1e77f1..0013125b03ee 100644
--- a/arch/arm/mach-s3c24xx/s3c2410.c
+++ b/arch/arm/mach-s3c/s3c2410.c
@@ -41,7 +41,7 @@
 #include <plat/gpio-cfg.h>
 #include <plat/gpio-cfg-helpers.h>
 
-#include "common.h"
+#include "s3c24xx.h"
 
 /* Initial IO mappings */
 
diff --git a/arch/arm/mach-s3c24xx/s3c2412-power.h b/arch/arm/mach-s3c/s3c2412-power.h
similarity index 100%
rename from arch/arm/mach-s3c24xx/s3c2412-power.h
rename to arch/arm/mach-s3c/s3c2412-power.h
diff --git a/arch/arm/mach-s3c24xx/s3c2412.c b/arch/arm/mach-s3c/s3c2412.c
similarity index 97%
rename from arch/arm/mach-s3c24xx/s3c2412.c
rename to arch/arm/mach-s3c/s3c2412.c
index 75648dcc2c1d..5fbea5b4276d 100644
--- a/arch/arm/mach-s3c24xx/s3c2412.c
+++ b/arch/arm/mach-s3c/s3c2412.c
@@ -37,9 +37,9 @@
 #include <plat/devs.h>
 #include <plat/pm.h>
 
-#include "common.h"
-#include "nand-core.h"
-#include "regs-dsc.h"
+#include "s3c24xx.h"
+#include "nand-core-s3c24xx.h"
+#include "regs-dsc-s3c24xx.h"
 #include "s3c2412-power.h"
 
 #ifndef CONFIG_CPU_S3C2412_ONLY
diff --git a/arch/arm/mach-s3c24xx/s3c2416.c b/arch/arm/mach-s3c/s3c2416.c
similarity index 95%
rename from arch/arm/mach-s3c24xx/s3c2416.c
rename to arch/arm/mach-s3c/s3c2416.c
index 6576187b4638..f24476c16e4a 100644
--- a/arch/arm/mach-s3c24xx/s3c2416.c
+++ b/arch/arm/mach-s3c/s3c2416.c
@@ -33,7 +33,7 @@
 #include <asm/system_misc.h>
 
 #include <mach/regs-s3c2443-clock.h>
-#include <mach/rtc-core.h>
+#include <mach/rtc-core-s3c24xx.h>
 
 #include <plat/gpio-core.h>
 #include <plat/gpio-cfg.h>
@@ -46,10 +46,10 @@
 #include <plat/iic-core.h>
 #include <plat/adc-core.h>
 
-#include "common.h"
-#include "fb-core.h"
-#include "nand-core.h"
-#include "spi-core.h"
+#include "s3c24xx.h"
+#include "fb-core-s3c24xx.h"
+#include "nand-core-s3c24xx.h"
+#include "spi-core-s3c24xx.h"
 
 static struct map_desc s3c2416_iodesc[] __initdata = {
 	IODESC_ENT(WATCHDOG),
diff --git a/arch/arm/mach-s3c24xx/s3c2440.c b/arch/arm/mach-s3c/s3c2440.c
similarity index 98%
rename from arch/arm/mach-s3c24xx/s3c2440.c
rename to arch/arm/mach-s3c/s3c2440.c
index bbe1f9cf5cf0..234b08e57046 100644
--- a/arch/arm/mach-s3c24xx/s3c2440.c
+++ b/arch/arm/mach-s3c/s3c2440.c
@@ -34,7 +34,7 @@
 #include <plat/gpio-cfg.h>
 #include <plat/gpio-cfg-helpers.h>
 
-#include "common.h"
+#include "s3c24xx.h"
 
 static struct device s3c2440_dev = {
 	.bus		= &s3c2440_subsys,
diff --git a/arch/arm/mach-s3c24xx/s3c2442.c b/arch/arm/mach-s3c/s3c2442.c
similarity index 98%
rename from arch/arm/mach-s3c24xx/s3c2442.c
rename to arch/arm/mach-s3c/s3c2442.c
index 5b8751506d02..29d82315339d 100644
--- a/arch/arm/mach-s3c24xx/s3c2442.c
+++ b/arch/arm/mach-s3c/s3c2442.c
@@ -34,7 +34,7 @@
 #include <plat/gpio-cfg.h>
 #include <plat/gpio-cfg-helpers.h>
 
-#include "common.h"
+#include "s3c24xx.h"
 
 static struct device s3c2442_dev = {
 	.bus		= &s3c2442_subsys,
diff --git a/arch/arm/mach-s3c24xx/s3c2443.c b/arch/arm/mach-s3c/s3c2443.c
similarity index 94%
rename from arch/arm/mach-s3c24xx/s3c2443.c
rename to arch/arm/mach-s3c/s3c2443.c
index 74794a55b015..d070e738eafb 100644
--- a/arch/arm/mach-s3c24xx/s3c2443.c
+++ b/arch/arm/mach-s3c/s3c2443.c
@@ -30,7 +30,7 @@
 #include <asm/system_misc.h>
 
 #include <mach/regs-s3c2443-clock.h>
-#include <mach/rtc-core.h>
+#include <mach/rtc-core-s3c24xx.h>
 
 #include <plat/gpio-core.h>
 #include <plat/gpio-cfg.h>
@@ -39,10 +39,10 @@
 #include <plat/cpu.h>
 #include <plat/adc-core.h>
 
-#include "common.h"
-#include "fb-core.h"
-#include "nand-core.h"
-#include "spi-core.h"
+#include "s3c24xx.h"
+#include "fb-core-s3c24xx.h"
+#include "nand-core-s3c24xx.h"
+#include "spi-core-s3c24xx.h"
 
 static struct map_desc s3c2443_iodesc[] __initdata = {
 	IODESC_ENT(WATCHDOG),
diff --git a/arch/arm/mach-s3c24xx/s3c244x.c b/arch/arm/mach-s3c/s3c244x.c
similarity index 97%
rename from arch/arm/mach-s3c24xx/s3c244x.c
rename to arch/arm/mach-s3c/s3c244x.c
index 0ca188d0ffe5..9d8464178412 100644
--- a/arch/arm/mach-s3c24xx/s3c244x.c
+++ b/arch/arm/mach-s3c/s3c244x.c
@@ -35,9 +35,9 @@
 #include <plat/cpu.h>
 #include <plat/pm.h>
 
-#include "common.h"
-#include "nand-core.h"
-#include "regs-dsc.h"
+#include "s3c24xx.h"
+#include "nand-core-s3c24xx.h"
+#include "regs-dsc-s3c24xx.h"
 
 static struct map_desc s3c244x_iodesc[] __initdata = {
 	IODESC_ENT(CLKPWR),
diff --git a/arch/arm/mach-s3c24xx/common.c b/arch/arm/mach-s3c/s3c24xx.c
similarity index 99%
rename from arch/arm/mach-s3c24xx/common.c
rename to arch/arm/mach-s3c/s3c24xx.c
index 30b0dcd20f17..d854cf9d290b 100644
--- a/arch/arm/mach-s3c24xx/common.c
+++ b/arch/arm/mach-s3c/s3c24xx.c
@@ -22,7 +22,7 @@
 #include <linux/dmaengine.h>
 #include <linux/clk/samsung.h>
 
-#include <mach/hardware.h>
+#include <mach/hardware-s3c24xx.h>
 #include <mach/map.h>
 #include <mach/regs-clock.h>
 #include <asm/irq.h>
@@ -40,7 +40,7 @@
 #include <plat/devs.h>
 #include <plat/pwm-core.h>
 
-#include "common.h"
+#include "s3c24xx.h"
 
 /* table of supported CPUs */
 
diff --git a/arch/arm/mach-s3c24xx/common.h b/arch/arm/mach-s3c/s3c24xx.h
similarity index 100%
rename from arch/arm/mach-s3c24xx/common.h
rename to arch/arm/mach-s3c/s3c24xx.h
diff --git a/arch/arm/mach-s3c64xx/s3c6400.c b/arch/arm/mach-s3c/s3c6400.c
similarity index 97%
rename from arch/arm/mach-s3c64xx/s3c6400.c
rename to arch/arm/mach-s3c/s3c6400.c
index d18af724c807..86be7eeef6e1 100644
--- a/arch/arm/mach-s3c64xx/s3c6400.c
+++ b/arch/arm/mach-s3c/s3c6400.c
@@ -35,8 +35,8 @@
 #include <plat/sdhci.h>
 #include <plat/iic-core.h>
 
-#include "common.h"
-#include "onenand-core.h"
+#include "s3c64xx.h"
+#include "onenand-core-s3c64xx.h"
 
 void __init s3c6400_map_io(void)
 {
diff --git a/arch/arm/mach-s3c64xx/s3c6410.c b/arch/arm/mach-s3c/s3c6410.c
similarity index 96%
rename from arch/arm/mach-s3c64xx/s3c6410.c
rename to arch/arm/mach-s3c/s3c6410.c
index b1d725e55cd2..0f253d423581 100644
--- a/arch/arm/mach-s3c64xx/s3c6410.c
+++ b/arch/arm/mach-s3c/s3c6410.c
@@ -38,9 +38,9 @@
 #include <plat/adc-core.h>
 #include <plat/iic-core.h>
 
-#include "ata-core.h"
-#include "common.h"
-#include "onenand-core.h"
+#include "ata-core-s3c64xx.h"
+#include "s3c64xx.h"
+#include "onenand-core-s3c64xx.h"
 
 void __init s3c6410_map_io(void)
 {
diff --git a/arch/arm/mach-s3c64xx/common.c b/arch/arm/mach-s3c/s3c64xx.c
similarity index 99%
rename from arch/arm/mach-s3c64xx/common.c
rename to arch/arm/mach-s3c/s3c64xx.c
index efda4bfb7948..fcb096298113 100644
--- a/arch/arm/mach-s3c64xx/common.c
+++ b/arch/arm/mach-s3c/s3c64xx.c
@@ -47,8 +47,8 @@
 #include <plat/pwm-core.h>
 #include <plat/regs-irqtype.h>
 
-#include "common.h"
-#include "irq-uart.h"
+#include "s3c64xx.h"
+#include "irq-uart-s3c64xx.h"
 
 /* External clock frequency */
 static unsigned long xtal_f __ro_after_init = 12000000;
diff --git a/arch/arm/mach-s3c64xx/common.h b/arch/arm/mach-s3c/s3c64xx.h
similarity index 100%
rename from arch/arm/mach-s3c64xx/common.h
rename to arch/arm/mach-s3c/s3c64xx.h
diff --git a/arch/arm/mach-s3c24xx/setup-camif.c b/arch/arm/mach-s3c/setup-camif-s3c24xx.c
similarity index 100%
rename from arch/arm/mach-s3c24xx/setup-camif.c
rename to arch/arm/mach-s3c/setup-camif-s3c24xx.c
diff --git a/arch/arm/mach-s3c64xx/setup-fb-24bpp.c b/arch/arm/mach-s3c/setup-fb-24bpp-s3c64xx.c
similarity index 100%
rename from arch/arm/mach-s3c64xx/setup-fb-24bpp.c
rename to arch/arm/mach-s3c/setup-fb-24bpp-s3c64xx.c
diff --git a/arch/arm/mach-s3c24xx/setup-i2c.c b/arch/arm/mach-s3c/setup-i2c-s3c24xx.c
similarity index 100%
rename from arch/arm/mach-s3c24xx/setup-i2c.c
rename to arch/arm/mach-s3c/setup-i2c-s3c24xx.c
diff --git a/arch/arm/mach-s3c64xx/setup-i2c0.c b/arch/arm/mach-s3c/setup-i2c0-s3c64xx.c
similarity index 100%
rename from arch/arm/mach-s3c64xx/setup-i2c0.c
rename to arch/arm/mach-s3c/setup-i2c0-s3c64xx.c
diff --git a/arch/arm/mach-s3c64xx/setup-i2c1.c b/arch/arm/mach-s3c/setup-i2c1-s3c64xx.c
similarity index 100%
rename from arch/arm/mach-s3c64xx/setup-i2c1.c
rename to arch/arm/mach-s3c/setup-i2c1-s3c64xx.c
diff --git a/arch/arm/mach-s3c64xx/setup-ide.c b/arch/arm/mach-s3c/setup-ide-s3c64xx.c
similarity index 100%
rename from arch/arm/mach-s3c64xx/setup-ide.c
rename to arch/arm/mach-s3c/setup-ide-s3c64xx.c
diff --git a/arch/arm/mach-s3c64xx/setup-keypad.c b/arch/arm/mach-s3c/setup-keypad-s3c64xx.c
similarity index 100%
rename from arch/arm/mach-s3c64xx/setup-keypad.c
rename to arch/arm/mach-s3c/setup-keypad-s3c64xx.c
diff --git a/arch/arm/mach-s3c24xx/setup-sdhci-gpio.c b/arch/arm/mach-s3c/setup-sdhci-gpio-s3c24xx.c
similarity index 100%
rename from arch/arm/mach-s3c24xx/setup-sdhci-gpio.c
rename to arch/arm/mach-s3c/setup-sdhci-gpio-s3c24xx.c
diff --git a/arch/arm/mach-s3c64xx/setup-sdhci-gpio.c b/arch/arm/mach-s3c/setup-sdhci-gpio-s3c64xx.c
similarity index 100%
rename from arch/arm/mach-s3c64xx/setup-sdhci-gpio.c
rename to arch/arm/mach-s3c/setup-sdhci-gpio-s3c64xx.c
diff --git a/arch/arm/mach-s3c24xx/setup-spi.c b/arch/arm/mach-s3c/setup-spi-s3c24xx.c
similarity index 93%
rename from arch/arm/mach-s3c24xx/setup-spi.c
rename to arch/arm/mach-s3c/setup-spi-s3c24xx.c
index 6c2b96a82da5..c8b897cbc7ce 100644
--- a/arch/arm/mach-s3c24xx/setup-spi.c
+++ b/arch/arm/mach-s3c/setup-spi-s3c24xx.c
@@ -10,7 +10,7 @@
 
 #include <plat/gpio-cfg.h>
 
-#include <mach/hardware.h>
+#include <mach/hardware-s3c24xx.h>
 #include <mach/regs-gpio.h>
 
 #ifdef CONFIG_S3C64XX_DEV_SPI0
diff --git a/arch/arm/mach-s3c64xx/setup-spi.c b/arch/arm/mach-s3c/setup-spi-s3c64xx.c
similarity index 100%
rename from arch/arm/mach-s3c64xx/setup-spi.c
rename to arch/arm/mach-s3c/setup-spi-s3c64xx.c
diff --git a/arch/arm/mach-s3c24xx/setup-ts.c b/arch/arm/mach-s3c/setup-ts-s3c24xx.c
similarity index 100%
rename from arch/arm/mach-s3c24xx/setup-ts.c
rename to arch/arm/mach-s3c/setup-ts-s3c24xx.c
diff --git a/arch/arm/mach-s3c64xx/setup-usb-phy.c b/arch/arm/mach-s3c/setup-usb-phy-s3c64xx.c
similarity index 96%
rename from arch/arm/mach-s3c64xx/setup-usb-phy.c
rename to arch/arm/mach-s3c/setup-usb-phy-s3c64xx.c
index d6b0e3b268af..3a0e589bd8a1 100644
--- a/arch/arm/mach-s3c64xx/setup-usb-phy.c
+++ b/arch/arm/mach-s3c/setup-usb-phy-s3c64xx.c
@@ -12,8 +12,8 @@
 #include <plat/cpu.h>
 #include <plat/usb-phy.h>
 
-#include "regs-sys.h"
-#include "regs-usb-hsotg-phy.h"
+#include "regs-sys-s3c64xx.h"
+#include "regs-usb-hsotg-phy-s3c64xx.h"
 
 enum samsung_usb_phy_type {
 	USB_PHY_TYPE_DEVICE,
diff --git a/arch/arm/mach-s3c24xx/simtec-audio.c b/arch/arm/mach-s3c/simtec-audio.c
similarity index 100%
rename from arch/arm/mach-s3c24xx/simtec-audio.c
rename to arch/arm/mach-s3c/simtec-audio.c
diff --git a/arch/arm/mach-s3c24xx/simtec-nor.c b/arch/arm/mach-s3c/simtec-nor.c
similarity index 100%
rename from arch/arm/mach-s3c24xx/simtec-nor.c
rename to arch/arm/mach-s3c/simtec-nor.c
diff --git a/arch/arm/mach-s3c24xx/simtec-pm.c b/arch/arm/mach-s3c/simtec-pm.c
similarity index 97%
rename from arch/arm/mach-s3c24xx/simtec-pm.c
rename to arch/arm/mach-s3c/simtec-pm.c
index bc939dfce488..4d8248763eb6 100644
--- a/arch/arm/mach-s3c24xx/simtec-pm.c
+++ b/arch/arm/mach-s3c/simtec-pm.c
@@ -26,7 +26,7 @@
 
 #include <plat/pm.h>
 
-#include "regs-mem.h"
+#include "regs-mem-s3c24xx.h"
 
 #define COPYRIGHT ", Copyright 2005 Simtec Electronics"
 
diff --git a/arch/arm/mach-s3c24xx/simtec-usb.c b/arch/arm/mach-s3c/simtec-usb.c
similarity index 100%
rename from arch/arm/mach-s3c24xx/simtec-usb.c
rename to arch/arm/mach-s3c/simtec-usb.c
diff --git a/arch/arm/mach-s3c24xx/simtec.h b/arch/arm/mach-s3c/simtec.h
similarity index 100%
rename from arch/arm/mach-s3c24xx/simtec.h
rename to arch/arm/mach-s3c/simtec.h
diff --git a/arch/arm/mach-s3c24xx/sleep-s3c2410.S b/arch/arm/mach-s3c/sleep-s3c2410.S
similarity index 97%
rename from arch/arm/mach-s3c24xx/sleep-s3c2410.S
rename to arch/arm/mach-s3c/sleep-s3c2410.S
index e4f6f64e7826..0340297596e9 100644
--- a/arch/arm/mach-s3c24xx/sleep-s3c2410.S
+++ b/arch/arm/mach-s3c/sleep-s3c2410.S
@@ -18,7 +18,7 @@
 #include <mach/regs-gpio.h>
 #include <mach/regs-clock.h>
 
-#include "regs-mem.h"
+#include "regs-mem-s3c24xx.h"
 
 	/* s3c2410_cpu_suspend
 	 *
diff --git a/arch/arm/mach-s3c24xx/sleep-s3c2412.S b/arch/arm/mach-s3c/sleep-s3c2412.S
similarity index 100%
rename from arch/arm/mach-s3c24xx/sleep-s3c2412.S
rename to arch/arm/mach-s3c/sleep-s3c2412.S
diff --git a/arch/arm/mach-s3c24xx/sleep.S b/arch/arm/mach-s3c/sleep-s3c24xx.S
similarity index 100%
rename from arch/arm/mach-s3c24xx/sleep.S
rename to arch/arm/mach-s3c/sleep-s3c24xx.S
diff --git a/arch/arm/mach-s3c64xx/sleep.S b/arch/arm/mach-s3c/sleep-s3c64xx.S
similarity index 100%
rename from arch/arm/mach-s3c64xx/sleep.S
rename to arch/arm/mach-s3c/sleep-s3c64xx.S
diff --git a/arch/arm/mach-s3c24xx/spi-core.h b/arch/arm/mach-s3c/spi-core-s3c24xx.h
similarity index 81%
rename from arch/arm/mach-s3c24xx/spi-core.h
rename to arch/arm/mach-s3c/spi-core-s3c24xx.h
index 1048fac629a2..057667469cc3 100644
--- a/arch/arm/mach-s3c24xx/spi-core.h
+++ b/arch/arm/mach-s3c/spi-core-s3c24xx.h
@@ -3,8 +3,8 @@
  * Copyright (C) 2012 Heiko Stuebner <heiko@sntech.de>
  */
 
-#ifndef __PLAT_S3C_SPI_CORE_H
-#define __PLAT_S3C_SPI_CORE_H
+#ifndef __PLAT_S3C_SPI_CORE_S3C24XX_H
+#define __PLAT_S3C_SPI_CORE_S3C24XX_H
 
 /* These functions are only for use with the core support code, such as
  * the cpu specific initialisation code
@@ -24,4 +24,4 @@ static inline void s3c24xx_spi_setname(char *name)
 #endif
 }
 
-#endif /* __PLAT_S3C_SPI_CORE_H */
+#endif /* __PLAT_S3C_SPI_CORE_S3C24XX_H */
diff --git a/arch/arm/mach-s3c24xx/vr1000.h b/arch/arm/mach-s3c/vr1000.h
similarity index 100%
rename from arch/arm/mach-s3c24xx/vr1000.h
rename to arch/arm/mach-s3c/vr1000.h
diff --git a/arch/arm/plat-samsung/wakeup-mask.c b/arch/arm/mach-s3c/wakeup-mask.c
similarity index 100%
rename from arch/arm/plat-samsung/wakeup-mask.c
rename to arch/arm/mach-s3c/wakeup-mask.c
-- 
2.17.1

