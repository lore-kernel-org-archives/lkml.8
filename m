Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA75C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD2CB221E2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596739252;
	bh=iF89LuB35lab+Fgz3M0fESxE9Y2D3dP+g652YftWM9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JLvEc3en5b/QDpjPp2mVRC1ex6rAoI7Jie5KNBbNa6q5BQ6uAbTYCLAnNphL/hISD
	 lRUb4xC6chqF8tFI3SeLYzgOmSLuCtSFwc26tAcgBFehf+nOsav8vxSSU0fF3ax8ZW
	 Njr7nBothGdOMyfnkIMeDwKc8sG8So03BC8pV+fg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730050AbgHFSku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 14:40:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:33608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729028AbgHFSk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 14:40:26 -0400
Received: from localhost.localdomain (unknown [194.230.155.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE1A722EBF;
        Thu,  6 Aug 2020 18:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596738319;
        bh=iF89LuB35lab+Fgz3M0fESxE9Y2D3dP+g652YftWM9M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jLMMNBtcjlQUu+qrFbd5HwxRu/Ma+cxLpZu2r+7G0CYq8eYF03AqbrWnPiOMt0mde
         Glv5RdRfVAyBZt83Q4QzanwDMWCONO4DdKTY6t6JuHXUo572svRgFVRFIY0uPYLTii
         gqsFRnGeylIMRVATrQSgQuI6HvBndNKk65sSNMu4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, patches@opensource.cirrus.com,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 40/41] ARM: s3c: make headers local if possible
Date:   Thu,  6 Aug 2020 20:20:57 +0200
Message-Id: <20200806182059.2431-40-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806181932.2253-1-krzk@kernel.org>
References: <20200806181932.2253-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

A lot of header files are only used internally now, so they can be moved
to mach-s3c, out of the visibility of drivers.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../mach-s3c/{include/plat => }/adc-core.h    |  0
 arch/arm/mach-s3c/adc.c                       |  2 +-
 arch/arm/mach-s3c/bast-ide.c                  |  2 +-
 arch/arm/mach-s3c/bast-irq.c                  |  2 +-
 arch/arm/mach-s3c/common-smdk-s3c24xx.c       | 10 +++----
 arch/arm/mach-s3c/cpu.c                       |  4 +--
 arch/arm/mach-s3c/{include/plat => }/cpu.h    |  0
 arch/arm/mach-s3c/cpufreq-utils-s3c24xx.c     |  4 +--
 arch/arm/mach-s3c/cpuidle-s3c64xx.c           |  4 +--
 arch/arm/mach-s3c/crag6410.h                  |  2 +-
 arch/arm/mach-s3c/dev-audio-s3c64xx.c         |  8 +++---
 arch/arm/mach-s3c/dev-backlight-s3c64xx.c     |  4 +--
 arch/arm/mach-s3c/dev-uart-s3c64xx.c          |  4 +--
 arch/arm/mach-s3c/dev-uart.c                  |  2 +-
 arch/arm/mach-s3c/devs.c                      | 22 ++++++++--------
 arch/arm/mach-s3c/{include/plat => }/devs.h   |  0
 .../mach-s3c/{include/mach => }/dma-s3c24xx.h |  0
 .../mach-s3c/{include/mach => }/dma-s3c64xx.h |  0
 arch/arm/mach-s3c/{include/mach => }/dma.h    |  0
 arch/arm/mach-s3c/{include/plat => }/fb.h     |  0
 .../{include/plat => }/gpio-cfg-helpers.h     |  0
 .../mach-s3c/{include/plat => }/gpio-cfg.h    |  0
 .../mach-s3c/{include/plat => }/gpio-core.h   |  2 +-
 .../{include/mach => }/gpio-samsung-s3c24xx.h |  2 +-
 .../{include/mach => }/gpio-samsung-s3c64xx.h |  0
 arch/arm/mach-s3c/gpio-samsung.c              | 18 ++++++-------
 .../{include/mach => }/gpio-samsung.h         |  0
 arch/arm/mach-s3c/gta02.h                     |  2 +-
 arch/arm/mach-s3c/h1940-bluetooth.c           |  6 ++---
 .../{include/mach => }/hardware-s3c24xx.h     |  0
 .../mach-s3c/{include/plat => }/iic-core.h    |  0
 arch/arm/mach-s3c/include/mach/io-s3c24xx.h   |  2 +-
 .../include/{plat => mach}/map-base.h         |  0
 arch/arm/mach-s3c/init.c                      |  4 +--
 arch/arm/mach-s3c/iotiming-s3c2410.c          |  4 +--
 arch/arm/mach-s3c/iotiming-s3c2412.c          |  4 +--
 arch/arm/mach-s3c/irq-pm-s3c24xx.c            | 16 ++++++------
 arch/arm/mach-s3c/irq-pm-s3c64xx.c            |  8 +++---
 arch/arm/mach-s3c/irq-s3c24xx-fiq.S           |  4 +--
 arch/arm/mach-s3c/irq-s3c24xx.c               | 10 +++----
 arch/arm/mach-s3c/{include/plat => }/keypad.h |  0
 arch/arm/mach-s3c/mach-amlm5900.c             | 10 +++----
 arch/arm/mach-s3c/mach-anubis.c               |  8 +++---
 arch/arm/mach-s3c/mach-anw6410.c              | 12 ++++-----
 arch/arm/mach-s3c/mach-at2440evb.c            |  8 +++---
 arch/arm/mach-s3c/mach-bast.c                 | 10 +++----
 arch/arm/mach-s3c/mach-crag6410-module.c      |  2 +-
 arch/arm/mach-s3c/mach-crag6410.c             | 20 +++++++-------
 arch/arm/mach-s3c/mach-gta02.c                | 16 ++++++------
 arch/arm/mach-s3c/mach-h1940.c                | 20 +++++++-------
 arch/arm/mach-s3c/mach-hmt.c                  | 10 +++----
 arch/arm/mach-s3c/mach-jive.c                 | 14 +++++-----
 arch/arm/mach-s3c/mach-mini2440.c             | 10 +++----
 arch/arm/mach-s3c/mach-mini6410.c             | 14 +++++-----
 arch/arm/mach-s3c/mach-n30.c                  | 13 +++++-----
 arch/arm/mach-s3c/mach-ncp.c                  |  8 +++---
 arch/arm/mach-s3c/mach-nexcoder.c             | 10 +++----
 arch/arm/mach-s3c/mach-osiris-dvs.c           |  2 +-
 arch/arm/mach-s3c/mach-osiris.c               | 10 +++----
 arch/arm/mach-s3c/mach-otom.c                 |  9 +++----
 arch/arm/mach-s3c/mach-qt2410.c               | 10 +++----
 arch/arm/mach-s3c/mach-real6410.c             | 12 ++++-----
 arch/arm/mach-s3c/mach-rx1950.c               | 16 ++++++------
 arch/arm/mach-s3c/mach-rx3715.c               | 12 ++++-----
 arch/arm/mach-s3c/mach-s3c2416-dt.c           |  6 ++---
 arch/arm/mach-s3c/mach-s3c64xx-dt.c           |  4 +--
 arch/arm/mach-s3c/mach-smartq.c               | 14 +++++-----
 arch/arm/mach-s3c/mach-smartq5.c              | 16 ++++++------
 arch/arm/mach-s3c/mach-smartq7.c              | 16 ++++++------
 arch/arm/mach-s3c/mach-smdk2410.c             |  8 +++---
 arch/arm/mach-s3c/mach-smdk2413.c             | 12 ++++-----
 arch/arm/mach-s3c/mach-smdk2416.c             | 18 ++++++-------
 arch/arm/mach-s3c/mach-smdk2440.c             | 10 +++----
 arch/arm/mach-s3c/mach-smdk2443.c             |  6 ++---
 arch/arm/mach-s3c/mach-smdk6400.c             |  8 +++---
 arch/arm/mach-s3c/mach-smdk6410.c             | 16 ++++++------
 arch/arm/mach-s3c/mach-tct_hammer.c           |  4 +--
 arch/arm/mach-s3c/mach-vr1000.c               | 10 +++----
 arch/arm/mach-s3c/mach-vstms.c                | 10 +++----
 .../arm/mach-s3c/{include/plat => }/map-s3c.h |  4 +--
 .../mach-s3c/{include/mach => }/map-s3c24xx.h |  4 +--
 .../mach-s3c/{include/mach => }/map-s3c64xx.h |  4 +--
 .../arm/mach-s3c/{include/plat => }/map-s5p.h |  2 +-
 arch/arm/mach-s3c/{include/mach => }/map.h    |  0
 arch/arm/mach-s3c/pl080.c                     |  4 +--
 arch/arm/mach-s3c/platformdata.c              |  4 +--
 arch/arm/mach-s3c/pm-common.c                 |  2 +-
 .../mach-s3c/{include/plat => }/pm-common.h   |  0
 .../{include/mach => }/pm-core-s3c24xx.h      |  0
 .../{include/mach => }/pm-core-s3c64xx.h      |  6 ++---
 .../arm/mach-s3c/{include/mach => }/pm-core.h |  0
 arch/arm/mach-s3c/pm-gpio.c                   |  6 ++---
 arch/arm/mach-s3c/pm-h1940.S                  |  4 +--
 arch/arm/mach-s3c/pm-s3c2410.c                | 10 +++----
 arch/arm/mach-s3c/pm-s3c2412.c                |  8 +++---
 arch/arm/mach-s3c/pm-s3c2416.c                |  6 ++---
 arch/arm/mach-s3c/pm-s3c24xx.c                | 12 ++++-----
 arch/arm/mach-s3c/pm-s3c64xx.c                | 16 ++++++------
 arch/arm/mach-s3c/pm.c                        | 12 ++++-----
 arch/arm/mach-s3c/{include/plat => }/pm.h     |  2 +-
 .../mach-s3c/{include/plat => }/pwm-core.h    |  0
 .../mach-s3c/{include/plat => }/regs-adc.h    |  0
 .../{include/mach => }/regs-clock-s3c24xx.h   |  2 +-
 .../{include/mach => }/regs-clock-s3c64xx.h   |  0
 .../mach-s3c/{include/mach => }/regs-clock.h  |  0
 .../{include/mach => }/regs-gpio-s3c24xx.h    |  2 +-
 .../{include/mach => }/regs-gpio-s3c64xx.h    |  0
 .../mach-s3c/{include/mach => }/regs-gpio.h   |  0
 .../{include/mach => }/regs-irq-s3c24xx.h     |  2 +-
 .../{include/mach => }/regs-irq-s3c64xx.h     |  0
 .../mach-s3c/{include/mach => }/regs-irq.h    |  0
 .../{include/plat => }/regs-irqtype.h         |  0
 arch/arm/mach-s3c/regs-mem-s3c24xx.h          |  2 +-
 .../{include/mach => }/regs-s3c2443-clock.h   |  2 +-
 .../{include/mach => }/rtc-core-s3c24xx.h     |  0
 arch/arm/mach-s3c/s3c2410.c                   | 18 ++++++-------
 arch/arm/mach-s3c/s3c2412.c                   | 12 ++++-----
 .../arm/mach-s3c/{include/mach => }/s3c2412.h |  2 +-
 arch/arm/mach-s3c/s3c2416.c                   | 26 +++++++++----------
 arch/arm/mach-s3c/s3c2440.c                   | 14 +++++-----
 arch/arm/mach-s3c/s3c2442.c                   | 14 +++++-----
 arch/arm/mach-s3c/s3c2443.c                   | 20 +++++++-------
 arch/arm/mach-s3c/s3c244x.c                   | 12 ++++-----
 arch/arm/mach-s3c/s3c24xx.c                   | 16 ++++++------
 arch/arm/mach-s3c/s3c6400.c                   | 10 +++----
 arch/arm/mach-s3c/s3c6410.c                   | 12 ++++-----
 arch/arm/mach-s3c/s3c64xx.c                   | 21 +++++++--------
 arch/arm/mach-s3c/{include/plat => }/sdhci.h  |  2 +-
 arch/arm/mach-s3c/setup-camif-s3c24xx.c       |  4 +--
 arch/arm/mach-s3c/setup-fb-24bpp-s3c64xx.c    |  6 ++---
 arch/arm/mach-s3c/setup-i2c-s3c24xx.c         |  7 ++---
 arch/arm/mach-s3c/setup-i2c0-s3c64xx.c        |  4 +--
 arch/arm/mach-s3c/setup-i2c1-s3c64xx.c        |  4 +--
 arch/arm/mach-s3c/setup-ide-s3c64xx.c         |  9 ++++---
 arch/arm/mach-s3c/setup-keypad-s3c64xx.c      |  6 ++---
 arch/arm/mach-s3c/setup-sdhci-gpio-s3c24xx.c  |  8 +++---
 arch/arm/mach-s3c/setup-sdhci-gpio-s3c64xx.c  |  6 ++---
 arch/arm/mach-s3c/setup-spi-s3c24xx.c         |  6 ++---
 arch/arm/mach-s3c/setup-spi-s3c64xx.c         |  4 +--
 arch/arm/mach-s3c/setup-ts-s3c24xx.c          |  4 +--
 arch/arm/mach-s3c/setup-usb-phy-s3c64xx.c     |  6 ++---
 arch/arm/mach-s3c/simtec-audio.c              |  8 +++---
 arch/arm/mach-s3c/simtec-nor.c                |  2 +-
 arch/arm/mach-s3c/simtec-pm.c                 |  6 ++---
 arch/arm/mach-s3c/simtec-usb.c                |  4 +--
 arch/arm/mach-s3c/sleep-s3c2410.S             |  6 ++---
 arch/arm/mach-s3c/sleep-s3c2412.S             |  4 +--
 arch/arm/mach-s3c/sleep-s3c24xx.S             |  6 ++---
 arch/arm/mach-s3c/sleep-s3c64xx.S             |  4 +--
 .../arm/mach-s3c/{include/plat => }/usb-phy.h |  0
 arch/arm/mach-s3c/wakeup-mask.c               |  4 +--
 .../mach-s3c/{include/plat => }/wakeup-mask.h |  0
 152 files changed, 489 insertions(+), 490 deletions(-)
 rename arch/arm/mach-s3c/{include/plat => }/adc-core.h (100%)
 rename arch/arm/mach-s3c/{include/plat => }/cpu.h (100%)
 rename arch/arm/mach-s3c/{include/plat => }/devs.h (100%)
 rename arch/arm/mach-s3c/{include/mach => }/dma-s3c24xx.h (100%)
 rename arch/arm/mach-s3c/{include/mach => }/dma-s3c64xx.h (100%)
 rename arch/arm/mach-s3c/{include/mach => }/dma.h (100%)
 rename arch/arm/mach-s3c/{include/plat => }/fb.h (100%)
 rename arch/arm/mach-s3c/{include/plat => }/gpio-cfg-helpers.h (100%)
 rename arch/arm/mach-s3c/{include/plat => }/gpio-cfg.h (100%)
 rename arch/arm/mach-s3c/{include/plat => }/gpio-core.h (99%)
 rename arch/arm/mach-s3c/{include/mach => }/gpio-samsung-s3c24xx.h (99%)
 rename arch/arm/mach-s3c/{include/mach => }/gpio-samsung-s3c64xx.h (100%)
 rename arch/arm/mach-s3c/{include/mach => }/gpio-samsung.h (100%)
 rename arch/arm/mach-s3c/{include/mach => }/hardware-s3c24xx.h (100%)
 rename arch/arm/mach-s3c/{include/plat => }/iic-core.h (100%)
 rename arch/arm/mach-s3c/include/{plat => mach}/map-base.h (100%)
 rename arch/arm/mach-s3c/{include/plat => }/keypad.h (100%)
 rename arch/arm/mach-s3c/{include/plat => }/map-s3c.h (97%)
 rename arch/arm/mach-s3c/{include/mach => }/map-s3c24xx.h (98%)
 rename arch/arm/mach-s3c/{include/mach => }/map-s3c64xx.h (98%)
 rename arch/arm/mach-s3c/{include/plat => }/map-s5p.h (94%)
 rename arch/arm/mach-s3c/{include/mach => }/map.h (100%)
 rename arch/arm/mach-s3c/{include/plat => }/pm-common.h (100%)
 rename arch/arm/mach-s3c/{include/mach => }/pm-core-s3c24xx.h (100%)
 rename arch/arm/mach-s3c/{include/mach => }/pm-core-s3c64xx.h (96%)
 rename arch/arm/mach-s3c/{include/mach => }/pm-core.h (100%)
 rename arch/arm/mach-s3c/{include/plat => }/pm.h (98%)
 rename arch/arm/mach-s3c/{include/plat => }/pwm-core.h (100%)
 rename arch/arm/mach-s3c/{include/plat => }/regs-adc.h (100%)
 rename arch/arm/mach-s3c/{include/mach => }/regs-clock-s3c24xx.h (99%)
 rename arch/arm/mach-s3c/{include/mach => }/regs-clock-s3c64xx.h (100%)
 rename arch/arm/mach-s3c/{include/mach => }/regs-clock.h (100%)
 rename arch/arm/mach-s3c/{include/mach => }/regs-gpio-s3c24xx.h (99%)
 rename arch/arm/mach-s3c/{include/mach => }/regs-gpio-s3c64xx.h (100%)
 rename arch/arm/mach-s3c/{include/mach => }/regs-gpio.h (100%)
 rename arch/arm/mach-s3c/{include/mach => }/regs-irq-s3c24xx.h (98%)
 rename arch/arm/mach-s3c/{include/mach => }/regs-irq-s3c64xx.h (100%)
 rename arch/arm/mach-s3c/{include/mach => }/regs-irq.h (100%)
 rename arch/arm/mach-s3c/{include/plat => }/regs-irqtype.h (100%)
 rename arch/arm/mach-s3c/{include/mach => }/regs-s3c2443-clock.h (99%)
 rename arch/arm/mach-s3c/{include/mach => }/rtc-core-s3c24xx.h (100%)
 rename arch/arm/mach-s3c/{include/mach => }/s3c2412.h (96%)
 rename arch/arm/mach-s3c/{include/plat => }/sdhci.h (99%)
 rename arch/arm/mach-s3c/{include/plat => }/usb-phy.h (100%)
 rename arch/arm/mach-s3c/{include/plat => }/wakeup-mask.h (100%)

diff --git a/arch/arm/mach-s3c/include/plat/adc-core.h b/arch/arm/mach-s3c/adc-core.h
similarity index 100%
rename from arch/arm/mach-s3c/include/plat/adc-core.h
rename to arch/arm/mach-s3c/adc-core.h
diff --git a/arch/arm/mach-s3c/adc.c b/arch/arm/mach-s3c/adc.c
index e35e04417cce..0232520d3c13 100644
--- a/arch/arm/mach-s3c/adc.c
+++ b/arch/arm/mach-s3c/adc.c
@@ -19,7 +19,7 @@
 #include <linux/io.h>
 #include <linux/regulator/consumer.h>
 
-#include <plat/regs-adc.h>
+#include "regs-adc.h"
 #include <linux/soc/samsung/s3c-adc.h>
 
 /* This driver is designed to control the usage of the ADC block between
diff --git a/arch/arm/mach-s3c/bast-ide.c b/arch/arm/mach-s3c/bast-ide.c
index ee6fbb407640..da64db1811d8 100644
--- a/arch/arm/mach-s3c/bast-ide.c
+++ b/arch/arm/mach-s3c/bast-ide.c
@@ -19,7 +19,7 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
-#include <mach/map.h>
+#include "map.h"
 #include <mach/irqs.h>
 
 #include "bast.h"
diff --git a/arch/arm/mach-s3c/bast-irq.c b/arch/arm/mach-s3c/bast-irq.c
index 141a35d58dd7..d299f124e6dc 100644
--- a/arch/arm/mach-s3c/bast-irq.c
+++ b/arch/arm/mach-s3c/bast-irq.c
@@ -15,7 +15,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/irq.h>
 
-#include <mach/regs-irq.h>
+#include "regs-irq.h"
 #include <mach/irqs.h>
 
 #include "bast.h"
diff --git a/arch/arm/mach-s3c/common-smdk-s3c24xx.c b/arch/arm/mach-s3c/common-smdk-s3c24xx.c
index e3281dc3af13..353bc22ce448 100644
--- a/arch/arm/mach-s3c/common-smdk-s3c24xx.c
+++ b/arch/arm/mach-s3c/common-smdk-s3c24xx.c
@@ -31,14 +31,14 @@
 #include <asm/mach-types.h>
 #include <asm/irq.h>
 
-#include <mach/regs-gpio.h>
-#include <mach/gpio-samsung.h>
+#include "regs-gpio.h"
+#include "gpio-samsung.h"
 #include <linux/platform_data/leds-s3c24xx.h>
 #include <linux/platform_data/mtd-nand-s3c2410.h>
 
-#include <plat/gpio-cfg.h>
-#include <plat/devs.h>
-#include <plat/pm.h>
+#include "gpio-cfg.h"
+#include "devs.h"
+#include "pm.h"
 
 #include "common-smdk-s3c24xx.h"
 
diff --git a/arch/arm/mach-s3c/cpu.c b/arch/arm/mach-s3c/cpu.c
index 8acba21bbf4b..6e9772555f0d 100644
--- a/arch/arm/mach-s3c/cpu.c
+++ b/arch/arm/mach-s3c/cpu.c
@@ -10,8 +10,8 @@
 #include <linux/init.h>
 #include <linux/io.h>
 
-#include <plat/map-base.h>
-#include <plat/cpu.h>
+#include <mach/map-base.h>
+#include "cpu.h"
 
 unsigned long samsung_cpu_id;
 
diff --git a/arch/arm/mach-s3c/include/plat/cpu.h b/arch/arm/mach-s3c/cpu.h
similarity index 100%
rename from arch/arm/mach-s3c/include/plat/cpu.h
rename to arch/arm/mach-s3c/cpu.h
diff --git a/arch/arm/mach-s3c/cpufreq-utils-s3c24xx.c b/arch/arm/mach-s3c/cpufreq-utils-s3c24xx.c
index 17b70d635236..c1784d8facdf 100644
--- a/arch/arm/mach-s3c/cpufreq-utils-s3c24xx.c
+++ b/arch/arm/mach-s3c/cpufreq-utils-s3c24xx.c
@@ -12,8 +12,8 @@
 #include <linux/io.h>
 #include <linux/clk.h>
 
-#include <mach/map.h>
-#include <mach/regs-clock.h>
+#include "map.h"
+#include "regs-clock.h"
 
 #include <linux/soc/samsung/s3c-cpufreq-core.h>
 
diff --git a/arch/arm/mach-s3c/cpuidle-s3c64xx.c b/arch/arm/mach-s3c/cpuidle-s3c64xx.c
index a629f4d2fa3b..b1c5f43d4922 100644
--- a/arch/arm/mach-s3c/cpuidle-s3c64xx.c
+++ b/arch/arm/mach-s3c/cpuidle-s3c64xx.c
@@ -13,8 +13,8 @@
 
 #include <asm/cpuidle.h>
 
-#include <plat/cpu.h>
-#include <mach/map.h>
+#include "cpu.h"
+#include "map.h"
 
 #include "regs-sys-s3c64xx.h"
 #include "regs-syscon-power-s3c64xx.h"
diff --git a/arch/arm/mach-s3c/crag6410.h b/arch/arm/mach-s3c/crag6410.h
index 00d9aa114aa7..f39ea2ca7a75 100644
--- a/arch/arm/mach-s3c/crag6410.h
+++ b/arch/arm/mach-s3c/crag6410.h
@@ -8,7 +8,7 @@
 #ifndef MACH_CRAG6410_H
 #define MACH_CRAG6410_H
 
-#include <mach/gpio-samsung.h>
+#include "gpio-samsung.h"
 
 #define GLENFARCLAS_PMIC_IRQ_BASE	IRQ_BOARD_START
 #define BANFF_PMIC_IRQ_BASE		(IRQ_BOARD_START + 64)
diff --git a/arch/arm/mach-s3c/dev-audio-s3c64xx.c b/arch/arm/mach-s3c/dev-audio-s3c64xx.c
index 1d3124db6afc..fc2f077afd24 100644
--- a/arch/arm/mach-s3c/dev-audio-s3c64xx.c
+++ b/arch/arm/mach-s3c/dev-audio-s3c64xx.c
@@ -11,12 +11,12 @@
 #include <linux/export.h>
 
 #include <mach/irqs.h>
-#include <mach/map.h>
+#include "map.h"
 
-#include <plat/devs.h>
+#include "devs.h"
 #include <linux/platform_data/asoc-s3c.h>
-#include <plat/gpio-cfg.h>
-#include <mach/gpio-samsung.h>
+#include "gpio-cfg.h"
+#include "gpio-samsung.h"
 
 static int s3c64xx_i2s_cfg_gpio(struct platform_device *pdev)
 {
diff --git a/arch/arm/mach-s3c/dev-backlight-s3c64xx.c b/arch/arm/mach-s3c/dev-backlight-s3c64xx.c
index 53bf14f5467f..65488b61e50c 100644
--- a/arch/arm/mach-s3c/dev-backlight-s3c64xx.c
+++ b/arch/arm/mach-s3c/dev-backlight-s3c64xx.c
@@ -11,8 +11,8 @@
 #include <linux/io.h>
 #include <linux/pwm_backlight.h>
 
-#include <plat/devs.h>
-#include <plat/gpio-cfg.h>
+#include "devs.h"
+#include "gpio-cfg.h"
 
 #include "backlight-s3c64xx.h"
 
diff --git a/arch/arm/mach-s3c/dev-uart-s3c64xx.c b/arch/arm/mach-s3c/dev-uart-s3c64xx.c
index 021a2b7926fa..8288e8d6c092 100644
--- a/arch/arm/mach-s3c/dev-uart-s3c64xx.c
+++ b/arch/arm/mach-s3c/dev-uart-s3c64xx.c
@@ -15,10 +15,10 @@
 
 #include <asm/mach/arch.h>
 #include <asm/mach/irq.h>
-#include <mach/map.h>
+#include "map.h"
 #include <mach/irqs.h>
 
-#include <plat/devs.h>
+#include "devs.h"
 
 /* Serial port registrations */
 
diff --git a/arch/arm/mach-s3c/dev-uart.c b/arch/arm/mach-s3c/dev-uart.c
index 7476a5dbae77..3d1f7f2fd7c7 100644
--- a/arch/arm/mach-s3c/dev-uart.c
+++ b/arch/arm/mach-s3c/dev-uart.c
@@ -10,7 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 
-#include <plat/devs.h>
+#include "devs.h"
 
 /* uart devices */
 
diff --git a/arch/arm/mach-s3c/devs.c b/arch/arm/mach-s3c/devs.c
index e23204132b27..06dec64848f9 100644
--- a/arch/arm/mach-s3c/devs.c
+++ b/arch/arm/mach-s3c/devs.c
@@ -39,31 +39,31 @@
 #include <asm/mach/irq.h>
 
 #include <mach/irqs.h>
-#include <mach/map.h>
-#include <mach/gpio-samsung.h>
+#include "map.h"
+#include "gpio-samsung.h"
+#include "gpio-cfg.h"
 
 #ifdef CONFIG_PLAT_S3C24XX
-#include <mach/regs-s3c2443-clock.h>
+#include "regs-s3c2443-clock.h"
 #endif /* CONFIG_PLAT_S3C24XX */
 
-#include <plat/cpu.h>
-#include <plat/devs.h>
-#include <plat/gpio-cfg.h>
+#include "cpu.h"
+#include "devs.h"
 #include <linux/soc/samsung/s3c-adc.h>
 #include <linux/platform_data/ata-samsung_cf.h>
-#include <plat/fb.h>
+#include "fb.h"
 #include <linux/platform_data/fb-s3c2410.h>
 #include <linux/platform_data/hwmon-s3c.h>
 #include <linux/platform_data/i2c-s3c2410.h>
-#include <plat/keypad.h>
+#include "keypad.h"
 #include <linux/platform_data/mmc-s3cmci.h>
 #include <linux/platform_data/mtd-nand-s3c2410.h>
-#include <plat/pwm-core.h>
-#include <plat/sdhci.h>
+#include "pwm-core.h"
+#include "sdhci.h"
 #include <linux/platform_data/touchscreen-s3c2410.h>
 #include <linux/platform_data/usb-s3c2410_udc.h>
 #include <linux/platform_data/usb-ohci-s3c2410.h>
-#include <plat/usb-phy.h>
+#include "usb-phy.h"
 #include <linux/platform_data/asoc-s3c.h>
 #include <linux/platform_data/spi-s3c64xx.h>
 
diff --git a/arch/arm/mach-s3c/include/plat/devs.h b/arch/arm/mach-s3c/devs.h
similarity index 100%
rename from arch/arm/mach-s3c/include/plat/devs.h
rename to arch/arm/mach-s3c/devs.h
diff --git a/arch/arm/mach-s3c/include/mach/dma-s3c24xx.h b/arch/arm/mach-s3c/dma-s3c24xx.h
similarity index 100%
rename from arch/arm/mach-s3c/include/mach/dma-s3c24xx.h
rename to arch/arm/mach-s3c/dma-s3c24xx.h
diff --git a/arch/arm/mach-s3c/include/mach/dma-s3c64xx.h b/arch/arm/mach-s3c/dma-s3c64xx.h
similarity index 100%
rename from arch/arm/mach-s3c/include/mach/dma-s3c64xx.h
rename to arch/arm/mach-s3c/dma-s3c64xx.h
diff --git a/arch/arm/mach-s3c/include/mach/dma.h b/arch/arm/mach-s3c/dma.h
similarity index 100%
rename from arch/arm/mach-s3c/include/mach/dma.h
rename to arch/arm/mach-s3c/dma.h
diff --git a/arch/arm/mach-s3c/include/plat/fb.h b/arch/arm/mach-s3c/fb.h
similarity index 100%
rename from arch/arm/mach-s3c/include/plat/fb.h
rename to arch/arm/mach-s3c/fb.h
diff --git a/arch/arm/mach-s3c/include/plat/gpio-cfg-helpers.h b/arch/arm/mach-s3c/gpio-cfg-helpers.h
similarity index 100%
rename from arch/arm/mach-s3c/include/plat/gpio-cfg-helpers.h
rename to arch/arm/mach-s3c/gpio-cfg-helpers.h
diff --git a/arch/arm/mach-s3c/include/plat/gpio-cfg.h b/arch/arm/mach-s3c/gpio-cfg.h
similarity index 100%
rename from arch/arm/mach-s3c/include/plat/gpio-cfg.h
rename to arch/arm/mach-s3c/gpio-cfg.h
diff --git a/arch/arm/mach-s3c/include/plat/gpio-core.h b/arch/arm/mach-s3c/gpio-core.h
similarity index 99%
rename from arch/arm/mach-s3c/include/plat/gpio-core.h
rename to arch/arm/mach-s3c/gpio-core.h
index c0bfceb88340..b361c8c0d669 100644
--- a/arch/arm/mach-s3c/include/plat/gpio-core.h
+++ b/arch/arm/mach-s3c/gpio-core.h
@@ -11,7 +11,7 @@
 #define __PLAT_SAMSUNG_GPIO_CORE_H
 
 /* Bring in machine-local definitions, especially S3C_GPIO_END */
-#include <mach/gpio-samsung.h>
+#include "gpio-samsung.h"
 #include <linux/gpio/driver.h>
 
 #define GPIOCON_OFF	(0x00)
diff --git a/arch/arm/mach-s3c/include/mach/gpio-samsung-s3c24xx.h b/arch/arm/mach-s3c/gpio-samsung-s3c24xx.h
similarity index 99%
rename from arch/arm/mach-s3c/include/mach/gpio-samsung-s3c24xx.h
rename to arch/arm/mach-s3c/gpio-samsung-s3c24xx.h
index f8a114891f16..c29fdc95f883 100644
--- a/arch/arm/mach-s3c/include/mach/gpio-samsung-s3c24xx.h
+++ b/arch/arm/mach-s3c/gpio-samsung-s3c24xx.h
@@ -14,7 +14,7 @@
 #ifndef GPIO_SAMSUNG_S3C24XX_H
 #define GPIO_SAMSUNG_S3C24XX_H
 
-#include <mach/map.h>
+#include "map.h"
 
 /*
  * GPIO sizes for various SoCs:
diff --git a/arch/arm/mach-s3c/include/mach/gpio-samsung-s3c64xx.h b/arch/arm/mach-s3c/gpio-samsung-s3c64xx.h
similarity index 100%
rename from arch/arm/mach-s3c/include/mach/gpio-samsung-s3c64xx.h
rename to arch/arm/mach-s3c/gpio-samsung-s3c64xx.h
diff --git a/arch/arm/mach-s3c/gpio-samsung.c b/arch/arm/mach-s3c/gpio-samsung.c
index 8955fd675265..76ef415789f2 100644
--- a/arch/arm/mach-s3c/gpio-samsung.c
+++ b/arch/arm/mach-s3c/gpio-samsung.c
@@ -27,15 +27,15 @@
 #include <asm/irq.h>
 
 #include <mach/irqs.h>
-#include <mach/map.h>
-#include <mach/regs-gpio.h>
-#include <mach/gpio-samsung.h>
-
-#include <plat/cpu.h>
-#include <plat/gpio-core.h>
-#include <plat/gpio-cfg.h>
-#include <plat/gpio-cfg-helpers.h>
-#include <plat/pm.h>
+#include "map.h"
+#include "regs-gpio.h"
+#include "gpio-samsung.h"
+
+#include "cpu.h"
+#include "gpio-core.h"
+#include "gpio-cfg.h"
+#include "gpio-cfg-helpers.h"
+#include "pm.h"
 
 int samsung_gpio_setpull_updown(struct samsung_gpio_chip *chip,
 				unsigned int off, samsung_gpio_pull_t pull)
diff --git a/arch/arm/mach-s3c/include/mach/gpio-samsung.h b/arch/arm/mach-s3c/gpio-samsung.h
similarity index 100%
rename from arch/arm/mach-s3c/include/mach/gpio-samsung.h
rename to arch/arm/mach-s3c/gpio-samsung.h
diff --git a/arch/arm/mach-s3c/gta02.h b/arch/arm/mach-s3c/gta02.h
index d5610ba829a4..043ae382bfc5 100644
--- a/arch/arm/mach-s3c/gta02.h
+++ b/arch/arm/mach-s3c/gta02.h
@@ -6,7 +6,7 @@
 #ifndef __MACH_S3C24XX_GTA02_H
 #define __MACH_S3C24XX_GTA02_H __FILE__
 
-#include <mach/regs-gpio.h>
+#include "regs-gpio.h"
 
 #define GTA02_GPIO_AUX_LED	S3C2410_GPB(2)
 #define GTA02_GPIO_USB_PULLUP	S3C2410_GPB(9)
diff --git a/arch/arm/mach-s3c/h1940-bluetooth.c b/arch/arm/mach-s3c/h1940-bluetooth.c
index 8533e7521b50..59edcf8a620d 100644
--- a/arch/arm/mach-s3c/h1940-bluetooth.c
+++ b/arch/arm/mach-s3c/h1940-bluetooth.c
@@ -13,9 +13,9 @@
 #include <linux/gpio.h>
 #include <linux/rfkill.h>
 
-#include <plat/gpio-cfg.h>
-#include <mach/regs-gpio.h>
-#include <mach/gpio-samsung.h>
+#include "gpio-cfg.h"
+#include "regs-gpio.h"
+#include "gpio-samsung.h"
 
 #include "h1940.h"
 
diff --git a/arch/arm/mach-s3c/include/mach/hardware-s3c24xx.h b/arch/arm/mach-s3c/hardware-s3c24xx.h
similarity index 100%
rename from arch/arm/mach-s3c/include/mach/hardware-s3c24xx.h
rename to arch/arm/mach-s3c/hardware-s3c24xx.h
diff --git a/arch/arm/mach-s3c/include/plat/iic-core.h b/arch/arm/mach-s3c/iic-core.h
similarity index 100%
rename from arch/arm/mach-s3c/include/plat/iic-core.h
rename to arch/arm/mach-s3c/iic-core.h
diff --git a/arch/arm/mach-s3c/include/mach/io-s3c24xx.h b/arch/arm/mach-s3c/include/mach/io-s3c24xx.h
index 9b78b0a3d486..738b775d3336 100644
--- a/arch/arm/mach-s3c/include/mach/io-s3c24xx.h
+++ b/arch/arm/mach-s3c/include/mach/io-s3c24xx.h
@@ -10,7 +10,7 @@
 #ifndef __ASM_ARM_ARCH_IO_S3C24XX_H
 #define __ASM_ARM_ARCH_IO_S3C24XX_H
 
-#include <plat/map-base.h>
+#include <mach/map-base.h>
 
 /*
  * ISA style IO, for each machine to sort out mappings for,
diff --git a/arch/arm/mach-s3c/include/plat/map-base.h b/arch/arm/mach-s3c/include/mach/map-base.h
similarity index 100%
rename from arch/arm/mach-s3c/include/plat/map-base.h
rename to arch/arm/mach-s3c/include/mach/map-base.h
diff --git a/arch/arm/mach-s3c/init.c b/arch/arm/mach-s3c/init.c
index e9acf02ef3c3..9d92f03e9bc1 100644
--- a/arch/arm/mach-s3c/init.c
+++ b/arch/arm/mach-s3c/init.c
@@ -23,8 +23,8 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <plat/cpu.h>
-#include <plat/devs.h>
+#include "cpu.h"
+#include "devs.h"
 
 static struct cpu_table *cpu;
 
diff --git a/arch/arm/mach-s3c/iotiming-s3c2410.c b/arch/arm/mach-s3c/iotiming-s3c2410.c
index d91f26efd07a..28d9f473e24a 100644
--- a/arch/arm/mach-s3c/iotiming-s3c2410.c
+++ b/arch/arm/mach-s3c/iotiming-s3c2410.c
@@ -14,8 +14,8 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 
-#include <mach/map.h>
-#include <mach/regs-clock.h>
+#include "map.h"
+#include "regs-clock.h"
 
 #include <linux/soc/samsung/s3c-cpufreq-core.h>
 
diff --git a/arch/arm/mach-s3c/iotiming-s3c2412.c b/arch/arm/mach-s3c/iotiming-s3c2412.c
index a22b5611697d..003f89c4dc53 100644
--- a/arch/arm/mach-s3c/iotiming-s3c2412.c
+++ b/arch/arm/mach-s3c/iotiming-s3c2412.c
@@ -23,10 +23,10 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <plat/cpu.h>
+#include "cpu.h"
 #include <linux/soc/samsung/s3c-cpufreq-core.h>
 
-#include <mach/s3c2412.h>
+#include "s3c2412.h"
 
 #define print_ns(x) ((x) / 10), ((x) % 10)
 
diff --git a/arch/arm/mach-s3c/irq-pm-s3c24xx.c b/arch/arm/mach-s3c/irq-pm-s3c24xx.c
index e0131b16a4af..4d5e28312d91 100644
--- a/arch/arm/mach-s3c/irq-pm-s3c24xx.c
+++ b/arch/arm/mach-s3c/irq-pm-s3c24xx.c
@@ -13,14 +13,14 @@
 #include <linux/syscore_ops.h>
 #include <linux/io.h>
 
-#include <plat/cpu.h>
-#include <plat/pm.h>
-#include <plat/map-base.h>
-#include <plat/map-s3c.h>
-
-#include <mach/regs-irq.h>
-#include <mach/regs-gpio.h>
-#include <mach/pm-core.h>
+#include "cpu.h"
+#include "pm.h"
+#include <mach/map-base.h>
+#include "map-s3c.h"
+
+#include "regs-irq.h"
+#include "regs-gpio.h"
+#include "pm-core.h"
 
 #include <asm/irq.h>
 
diff --git a/arch/arm/mach-s3c/irq-pm-s3c64xx.c b/arch/arm/mach-s3c/irq-pm-s3c64xx.c
index 31b221190479..4a1e935bada1 100644
--- a/arch/arm/mach-s3c/irq-pm-s3c64xx.c
+++ b/arch/arm/mach-s3c/irq-pm-s3c64xx.c
@@ -20,11 +20,11 @@
 #include <linux/io.h>
 #include <linux/of.h>
 
-#include <mach/map.h>
+#include "map.h"
 
-#include <mach/regs-gpio.h>
-#include <plat/cpu.h>
-#include <plat/pm.h>
+#include "regs-gpio.h"
+#include "cpu.h"
+#include "pm.h"
 
 /* We handled all the IRQ types in this code, to save having to make several
  * small files to handle each different type separately. Having the EINT_GRP
diff --git a/arch/arm/mach-s3c/irq-s3c24xx-fiq.S b/arch/arm/mach-s3c/irq-s3c24xx-fiq.S
index 2a84535a14fd..b54cbd012241 100644
--- a/arch/arm/mach-s3c/irq-s3c24xx-fiq.S
+++ b/arch/arm/mach-s3c/irq-s3c24xx-fiq.S
@@ -10,8 +10,8 @@
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 
-#include <mach/map.h>
-#include <mach/regs-irq.h>
+#include "map.h"
+#include "regs-irq.h"
 
 #include <linux/spi/s3c24xx-fiq.h>
 
diff --git a/arch/arm/mach-s3c/irq-s3c24xx.c b/arch/arm/mach-s3c/irq-s3c24xx.c
index 3965347cacf0..79b5f19af7a5 100644
--- a/arch/arm/mach-s3c/irq-s3c24xx.c
+++ b/arch/arm/mach-s3c/irq-s3c24xx.c
@@ -26,12 +26,12 @@
 #include <asm/mach/irq.h>
 
 #include <mach/irqs.h>
-#include <mach/regs-irq.h>
-#include <mach/regs-gpio.h>
+#include "regs-irq.h"
+#include "regs-gpio.h"
 
-#include <plat/cpu.h>
-#include <plat/regs-irqtype.h>
-#include <plat/pm.h>
+#include "cpu.h"
+#include "regs-irqtype.h"
+#include "pm.h"
 
 #define S3C_IRQTYPE_NONE	0
 #define S3C_IRQTYPE_EINT	1
diff --git a/arch/arm/mach-s3c/include/plat/keypad.h b/arch/arm/mach-s3c/keypad.h
similarity index 100%
rename from arch/arm/mach-s3c/include/plat/keypad.h
rename to arch/arm/mach-s3c/keypad.h
diff --git a/arch/arm/mach-s3c/mach-amlm5900.c b/arch/arm/mach-s3c/mach-amlm5900.c
index 724240e1b662..f73a5223663b 100644
--- a/arch/arm/mach-s3c/mach-amlm5900.c
+++ b/arch/arm/mach-s3c/mach-amlm5900.c
@@ -31,13 +31,13 @@
 #include <asm/mach-types.h>
 #include <linux/platform_data/fb-s3c2410.h>
 
-#include <mach/regs-gpio.h>
-#include <mach/gpio-samsung.h>
+#include "regs-gpio.h"
+#include "gpio-samsung.h"
 
 #include <linux/platform_data/i2c-s3c2410.h>
-#include <plat/devs.h>
-#include <plat/cpu.h>
-#include <plat/gpio-cfg.h>
+#include "devs.h"
+#include "cpu.h"
+#include "gpio-cfg.h"
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
diff --git a/arch/arm/mach-s3c/mach-anubis.c b/arch/arm/mach-s3c/mach-anubis.c
index 83b2f7fb268e..522bb10e8a19 100644
--- a/arch/arm/mach-s3c/mach-anubis.c
+++ b/arch/arm/mach-s3c/mach-anubis.c
@@ -27,8 +27,8 @@
 #include <asm/irq.h>
 #include <asm/mach-types.h>
 
-#include <mach/regs-gpio.h>
-#include <mach/gpio-samsung.h>
+#include "regs-gpio.h"
+#include "gpio-samsung.h"
 #include <linux/platform_data/mtd-nand-s3c2410.h>
 #include <linux/platform_data/i2c-s3c2410.h>
 
@@ -39,8 +39,8 @@
 
 #include <net/ax88796.h>
 
-#include <plat/devs.h>
-#include <plat/cpu.h>
+#include "devs.h"
+#include "cpu.h"
 #include <linux/platform_data/asoc-s3c24xx_simtec.h>
 
 #include "anubis.h"
diff --git a/arch/arm/mach-s3c/mach-anw6410.c b/arch/arm/mach-s3c/mach-anw6410.c
index ff183ced8e6e..b4f08e5c9858 100644
--- a/arch/arm/mach-s3c/mach-anw6410.c
+++ b/arch/arm/mach-s3c/mach-anw6410.c
@@ -30,19 +30,19 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
-#include <mach/map.h>
+#include "map.h"
 
 #include <asm/irq.h>
 #include <asm/mach-types.h>
 
 #include <linux/platform_data/i2c-s3c2410.h>
-#include <plat/fb.h>
+#include "fb.h"
 
-#include <plat/devs.h>
-#include <plat/cpu.h>
+#include "devs.h"
+#include "cpu.h"
 #include <mach/irqs.h>
-#include <mach/regs-gpio.h>
-#include <mach/gpio-samsung.h>
+#include "regs-gpio.h"
+#include "gpio-samsung.h"
 
 #include "s3c64xx.h"
 #include "regs-modem-s3c64xx.h"
diff --git a/arch/arm/mach-s3c/mach-at2440evb.c b/arch/arm/mach-s3c/mach-at2440evb.c
index 1ae61ae913d4..13d014bc8371 100644
--- a/arch/arm/mach-s3c/mach-at2440evb.c
+++ b/arch/arm/mach-s3c/mach-at2440evb.c
@@ -28,8 +28,8 @@
 #include <asm/irq.h>
 #include <asm/mach-types.h>
 
-#include <mach/regs-gpio.h>
-#include <mach/gpio-samsung.h>
+#include "regs-gpio.h"
+#include "gpio-samsung.h"
 #include <linux/platform_data/mtd-nand-s3c2410.h>
 #include <linux/platform_data/i2c-s3c2410.h>
 
@@ -38,8 +38,8 @@
 #include <linux/mtd/nand_ecc.h>
 #include <linux/mtd/partitions.h>
 
-#include <plat/devs.h>
-#include <plat/cpu.h>
+#include "devs.h"
+#include "cpu.h"
 #include <linux/platform_data/mmc-s3cmci.h>
 
 #include "s3c24xx.h"
diff --git a/arch/arm/mach-s3c/mach-bast.c b/arch/arm/mach-s3c/mach-bast.c
index f971cbf99d29..1cb2193256e1 100644
--- a/arch/arm/mach-s3c/mach-bast.c
+++ b/arch/arm/mach-s3c/mach-bast.c
@@ -41,13 +41,13 @@
 #include <asm/mach-types.h>
 
 #include <linux/platform_data/fb-s3c2410.h>
-#include <mach/regs-gpio.h>
-#include <mach/gpio-samsung.h>
+#include "regs-gpio.h"
+#include "gpio-samsung.h"
 
-#include <plat/cpu.h>
+#include "cpu.h"
 #include <linux/soc/samsung/s3c-cpu-freq.h>
-#include <plat/devs.h>
-#include <plat/gpio-cfg.h>
+#include "devs.h"
+#include "gpio-cfg.h"
 
 #include "bast.h"
 #include "s3c24xx.h"
diff --git a/arch/arm/mach-s3c/mach-crag6410-module.c b/arch/arm/mach-s3c/mach-crag6410-module.c
index 34f1baa10c54..1e0d442dcdb6 100644
--- a/arch/arm/mach-s3c/mach-crag6410-module.c
+++ b/arch/arm/mach-s3c/mach-crag6410-module.c
@@ -27,7 +27,7 @@
 
 #include <linux/platform_data/spi-s3c64xx.h>
 
-#include <plat/cpu.h>
+#include "cpu.h"
 #include <mach/irqs.h>
 
 #include "crag6410.h"
diff --git a/arch/arm/mach-s3c/mach-crag6410.c b/arch/arm/mach-s3c/mach-crag6410.c
index 8e7f637833f2..0bfcb79cc0a6 100644
--- a/arch/arm/mach-s3c/mach-crag6410.c
+++ b/arch/arm/mach-s3c/mach-crag6410.c
@@ -44,22 +44,22 @@
 #include <asm/mach-types.h>
 
 #include <video/samsung_fimd.h>
-#include <mach/map.h>
-#include <mach/regs-gpio.h>
-#include <mach/gpio-samsung.h>
+#include "map.h"
+#include "regs-gpio.h"
+#include "gpio-samsung.h"
 #include <mach/irqs.h>
 
-#include <plat/fb.h>
-#include <plat/sdhci.h>
-#include <plat/gpio-cfg.h>
+#include "fb.h"
+#include "sdhci.h"
+#include "gpio-cfg.h"
 #include <linux/platform_data/spi-s3c64xx.h>
 
-#include <plat/keypad.h>
-#include <plat/devs.h>
-#include <plat/cpu.h>
+#include "keypad.h"
+#include "devs.h"
+#include "cpu.h"
 #include <linux/soc/samsung/s3c-adc.h>
 #include <linux/platform_data/i2c-s3c2410.h>
-#include <plat/pm.h>
+#include "pm.h"
 
 #include "s3c64xx.h"
 #include "crag6410.h"
diff --git a/arch/arm/mach-s3c/mach-gta02.c b/arch/arm/mach-s3c/mach-gta02.c
index b4fb58632555..9e5cb05f3ef1 100644
--- a/arch/arm/mach-s3c/mach-gta02.c
+++ b/arch/arm/mach-s3c/mach-gta02.c
@@ -59,14 +59,14 @@
 #include <linux/platform_data/usb-s3c2410_udc.h>
 #include <linux/platform_data/fb-s3c2410.h>
 
-#include <mach/regs-gpio.h>
-#include <mach/regs-irq.h>
-#include <mach/gpio-samsung.h>
-
-#include <plat/cpu.h>
-#include <plat/devs.h>
-#include <plat/gpio-cfg.h>
-#include <plat/pm.h>
+#include "regs-gpio.h"
+#include "regs-irq.h"
+#include "gpio-samsung.h"
+
+#include "cpu.h"
+#include "devs.h"
+#include "gpio-cfg.h"
+#include "pm.h"
 
 #include "s3c24xx.h"
 #include "gta02.h"
diff --git a/arch/arm/mach-s3c/mach-h1940.c b/arch/arm/mach-s3c/mach-h1940.c
index c8e4c4d6a979..da9ac61f7948 100644
--- a/arch/arm/mach-s3c/mach-h1940.c
+++ b/arch/arm/mach-s3c/mach-h1940.c
@@ -48,16 +48,16 @@
 #include <sound/uda1380.h>
 
 #include <linux/platform_data/fb-s3c2410.h>
-#include <mach/map.h>
-#include <mach/hardware-s3c24xx.h>
-#include <mach/regs-clock.h>
-#include <mach/regs-gpio.h>
-#include <mach/gpio-samsung.h>
-
-#include <plat/cpu.h>
-#include <plat/devs.h>
-#include <plat/gpio-cfg.h>
-#include <plat/pm.h>
+#include "map.h"
+#include "hardware-s3c24xx.h"
+#include "regs-clock.h"
+#include "regs-gpio.h"
+#include "gpio-samsung.h"
+
+#include "cpu.h"
+#include "devs.h"
+#include "gpio-cfg.h"
+#include "pm.h"
 
 #include "s3c24xx.h"
 #include "h1940.h"
diff --git a/arch/arm/mach-s3c/mach-hmt.c b/arch/arm/mach-s3c/mach-hmt.c
index e0d8cc30a0f0..29510e27f90f 100644
--- a/arch/arm/mach-s3c/mach-hmt.c
+++ b/arch/arm/mach-s3c/mach-hmt.c
@@ -25,19 +25,19 @@
 #include <asm/mach/irq.h>
 
 #include <video/samsung_fimd.h>
-#include <mach/map.h>
+#include "map.h"
 #include <mach/irqs.h>
 
 #include <asm/irq.h>
 #include <asm/mach-types.h>
 
 #include <linux/platform_data/i2c-s3c2410.h>
-#include <mach/gpio-samsung.h>
-#include <plat/fb.h>
+#include "gpio-samsung.h"
+#include "fb.h"
 #include <linux/platform_data/mtd-nand-s3c2410.h>
 
-#include <plat/devs.h>
-#include <plat/cpu.h>
+#include "devs.h"
+#include "cpu.h"
 
 #include "s3c64xx.h"
 
diff --git a/arch/arm/mach-s3c/mach-jive.c b/arch/arm/mach-s3c/mach-jive.c
index 2e7119d34179..5c3037bf647d 100644
--- a/arch/arm/mach-s3c/mach-jive.c
+++ b/arch/arm/mach-s3c/mach-jive.c
@@ -31,10 +31,10 @@
 #include <linux/platform_data/mtd-nand-s3c2410.h>
 #include <linux/platform_data/i2c-s3c2410.h>
 
-#include <mach/hardware-s3c24xx.h>
-#include <mach/regs-gpio.h>
+#include "hardware-s3c24xx.h"
+#include "regs-gpio.h"
 #include <linux/platform_data/fb-s3c2410.h>
-#include <mach/gpio-samsung.h>
+#include "gpio-samsung.h"
 
 #include <asm/mach-types.h>
 
@@ -43,10 +43,10 @@
 #include <linux/mtd/nand_ecc.h>
 #include <linux/mtd/partitions.h>
 
-#include <plat/gpio-cfg.h>
-#include <plat/devs.h>
-#include <plat/cpu.h>
-#include <plat/pm.h>
+#include "gpio-cfg.h"
+#include "devs.h"
+#include "cpu.h"
+#include "pm.h"
 #include <linux/platform_data/usb-s3c2410_udc.h>
 
 #include "s3c24xx.h"
diff --git a/arch/arm/mach-s3c/mach-mini2440.c b/arch/arm/mach-s3c/mach-mini2440.c
index 83de1ba22cda..48e436a2f639 100644
--- a/arch/arm/mach-s3c/mach-mini2440.c
+++ b/arch/arm/mach-s3c/mach-mini2440.c
@@ -33,10 +33,10 @@
 #include <linux/platform_data/fb-s3c2410.h>
 #include <asm/mach-types.h>
 
-#include <mach/regs-gpio.h>
+#include "regs-gpio.h"
 #include <linux/platform_data/leds-s3c24xx.h>
 #include <mach/irqs.h>
-#include <mach/gpio-samsung.h>
+#include "gpio-samsung.h"
 #include <linux/platform_data/mtd-nand-s3c2410.h>
 #include <linux/platform_data/i2c-s3c2410.h>
 #include <linux/platform_data/mmc-s3cmci.h>
@@ -47,9 +47,9 @@
 #include <linux/mtd/nand_ecc.h>
 #include <linux/mtd/partitions.h>
 
-#include <plat/gpio-cfg.h>
-#include <plat/devs.h>
-#include <plat/cpu.h>
+#include "gpio-cfg.h"
+#include "devs.h"
+#include "cpu.h"
 
 #include <sound/s3c24xx_uda134x.h>
 
diff --git a/arch/arm/mach-s3c/mach-mini6410.c b/arch/arm/mach-s3c/mach-mini6410.c
index 9bd6581619b9..1580bb8ee2c7 100644
--- a/arch/arm/mach-s3c/mach-mini6410.c
+++ b/arch/arm/mach-s3c/mach-mini6410.c
@@ -23,17 +23,17 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/map.h>
-#include <mach/regs-gpio.h>
-#include <mach/gpio-samsung.h>
+#include "map.h"
+#include "regs-gpio.h"
+#include "gpio-samsung.h"
 
 #include <linux/soc/samsung/s3c-adc.h>
-#include <plat/cpu.h>
-#include <plat/devs.h>
-#include <plat/fb.h>
+#include "cpu.h"
+#include "devs.h"
+#include "fb.h"
 #include <linux/platform_data/mtd-nand-s3c2410.h>
 #include <linux/platform_data/mmc-sdhci-s3c.h>
-#include <plat/sdhci.h>
+#include "sdhci.h"
 #include <linux/platform_data/touchscreen-s3c2410.h>
 #include <mach/irqs.h>
 
diff --git a/arch/arm/mach-s3c/mach-n30.c b/arch/arm/mach-s3c/mach-n30.c
index d79bd9b8e25e..8a9382326d29 100644
--- a/arch/arm/mach-s3c/mach-n30.c
+++ b/arch/arm/mach-s3c/mach-n30.c
@@ -27,15 +27,15 @@
 #include <linux/io.h>
 #include <linux/mmc/host.h>
 
-#include <mach/hardware-s3c24xx.h>
+#include "hardware-s3c24xx.h"
 #include <asm/irq.h>
 #include <asm/mach-types.h>
 
 #include <linux/platform_data/fb-s3c2410.h>
 #include <linux/platform_data/leds-s3c24xx.h>
-#include <mach/regs-gpio.h>
-#include <mach/gpio-samsung.h>
-#include <plat/gpio-cfg.h>
+#include "regs-gpio.h"
+#include "gpio-samsung.h"
+#include "gpio-cfg.h"
 
 #include <asm/mach/arch.h>
 #include <asm/mach/irq.h>
@@ -43,9 +43,8 @@
 
 #include <linux/platform_data/i2c-s3c2410.h>
 
-#include <plat/cpu.h>
-#include <plat/devs.h>
-#include <plat/gpio-cfg.h>
+#include "cpu.h"
+#include "devs.h"
 #include <linux/platform_data/mmc-s3cmci.h>
 #include <linux/platform_data/usb-s3c2410_udc.h>
 
diff --git a/arch/arm/mach-s3c/mach-ncp.c b/arch/arm/mach-s3c/mach-ncp.c
index ed4dd67add97..3480ba8184b1 100644
--- a/arch/arm/mach-s3c/mach-ncp.c
+++ b/arch/arm/mach-s3c/mach-ncp.c
@@ -25,16 +25,16 @@
 #include <asm/mach/irq.h>
 
 #include <mach/irqs.h>
-#include <mach/map.h>
+#include "map.h"
 
 #include <asm/irq.h>
 #include <asm/mach-types.h>
 
 #include <linux/platform_data/i2c-s3c2410.h>
-#include <plat/fb.h>
+#include "fb.h"
 
-#include <plat/devs.h>
-#include <plat/cpu.h>
+#include "devs.h"
+#include "cpu.h"
 
 #include "s3c64xx.h"
 
diff --git a/arch/arm/mach-s3c/mach-nexcoder.c b/arch/arm/mach-s3c/mach-nexcoder.c
index 84610a91e732..7e96c546f359 100644
--- a/arch/arm/mach-s3c/mach-nexcoder.c
+++ b/arch/arm/mach-s3c/mach-nexcoder.c
@@ -32,13 +32,13 @@
 #include <asm/mach-types.h>
 
 //#include <asm/debug-ll.h>
-#include <mach/regs-gpio.h>
-#include <mach/gpio-samsung.h>
+#include "regs-gpio.h"
+#include "gpio-samsung.h"
 #include <linux/platform_data/i2c-s3c2410.h>
 
-#include <plat/gpio-cfg.h>
-#include <plat/devs.h>
-#include <plat/cpu.h>
+#include "gpio-cfg.h"
+#include "devs.h"
+#include "cpu.h"
 
 #include "s3c24xx.h"
 
diff --git a/arch/arm/mach-s3c/mach-osiris-dvs.c b/arch/arm/mach-s3c/mach-osiris-dvs.c
index 1250520b3bcc..2e283aedab65 100644
--- a/arch/arm/mach-s3c/mach-osiris-dvs.c
+++ b/arch/arm/mach-s3c/mach-osiris-dvs.c
@@ -15,7 +15,7 @@
 #include <linux/mfd/tps65010.h>
 
 #include <linux/soc/samsung/s3c-cpu-freq.h>
-#include <mach/gpio-samsung.h>
+#include "gpio-samsung.h"
 
 #define OSIRIS_GPIO_DVS	S3C2410_GPB(5)
 
diff --git a/arch/arm/mach-s3c/mach-osiris.c b/arch/arm/mach-s3c/mach-osiris.c
index 90cf7d8cb07d..d0675c558d89 100644
--- a/arch/arm/mach-s3c/mach-osiris.c
+++ b/arch/arm/mach-s3c/mach-osiris.c
@@ -36,13 +36,13 @@
 #include <linux/mtd/nand_ecc.h>
 #include <linux/mtd/partitions.h>
 
-#include <plat/cpu.h>
+#include "cpu.h"
 #include <linux/soc/samsung/s3c-cpu-freq.h>
-#include <plat/devs.h>
-#include <plat/gpio-cfg.h>
+#include "devs.h"
+#include "gpio-cfg.h"
 
-#include <mach/regs-gpio.h>
-#include <mach/gpio-samsung.h>
+#include "regs-gpio.h"
+#include "gpio-samsung.h"
 
 #include "s3c24xx.h"
 #include "osiris.h"
diff --git a/arch/arm/mach-s3c/mach-otom.c b/arch/arm/mach-s3c/mach-otom.c
index 32482f052ac7..fc8f78396159 100644
--- a/arch/arm/mach-s3c/mach-otom.c
+++ b/arch/arm/mach-s3c/mach-otom.c
@@ -22,12 +22,11 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
-#include <mach/regs-gpio.h>
-#include <mach/gpio-samsung.h>
-#include <plat/gpio-cfg.h>
+#include "gpio-samsung.h"
+#include "gpio-cfg.h"
 
-#include <plat/cpu.h>
-#include <plat/devs.h>
+#include "cpu.h"
+#include "devs.h"
 
 #include "s3c24xx.h"
 #include "otom.h"
diff --git a/arch/arm/mach-s3c/mach-qt2410.c b/arch/arm/mach-s3c/mach-qt2410.c
index ea7af23b0ac7..cba41466b261 100644
--- a/arch/arm/mach-s3c/mach-qt2410.c
+++ b/arch/arm/mach-s3c/mach-qt2410.c
@@ -36,12 +36,12 @@
 #include <linux/platform_data/mtd-nand-s3c2410.h>
 #include <linux/platform_data/usb-s3c2410_udc.h>
 #include <linux/platform_data/i2c-s3c2410.h>
-#include <mach/gpio-samsung.h>
+#include "gpio-samsung.h"
 
-#include <plat/gpio-cfg.h>
-#include <plat/devs.h>
-#include <plat/cpu.h>
-#include <plat/pm.h>
+#include "gpio-cfg.h"
+#include "devs.h"
+#include "cpu.h"
+#include "pm.h"
 
 #include "s3c24xx.h"
 #include "common-smdk-s3c24xx.h"
diff --git a/arch/arm/mach-s3c/mach-real6410.c b/arch/arm/mach-s3c/mach-real6410.c
index 099a99e5b6d2..63819560fc4c 100644
--- a/arch/arm/mach-s3c/mach-real6410.c
+++ b/arch/arm/mach-s3c/mach-real6410.c
@@ -24,15 +24,15 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/map.h>
-#include <mach/regs-gpio.h>
-#include <mach/gpio-samsung.h>
+#include "map.h"
+#include "regs-gpio.h"
+#include "gpio-samsung.h"
 #include <mach/irqs.h>
 
 #include <linux/soc/samsung/s3c-adc.h>
-#include <plat/cpu.h>
-#include <plat/devs.h>
-#include <plat/fb.h>
+#include "cpu.h"
+#include "devs.h"
+#include "fb.h"
 #include <linux/platform_data/mtd-nand-s3c2410.h>
 #include <linux/platform_data/touchscreen-s3c2410.h>
 
diff --git a/arch/arm/mach-s3c/mach-rx1950.c b/arch/arm/mach-s3c/mach-rx1950.c
index 13614b372109..99dabe7309ef 100644
--- a/arch/arm/mach-s3c/mach-rx1950.c
+++ b/arch/arm/mach-s3c/mach-rx1950.c
@@ -46,14 +46,14 @@
 
 #include <sound/uda1380.h>
 
-#include <mach/hardware-s3c24xx.h>
-#include <mach/regs-gpio.h>
-#include <mach/gpio-samsung.h>
-
-#include <plat/cpu.h>
-#include <plat/devs.h>
-#include <plat/pm.h>
-#include <plat/gpio-cfg.h>
+#include "hardware-s3c24xx.h"
+#include "regs-gpio.h"
+#include "gpio-samsung.h"
+
+#include "cpu.h"
+#include "devs.h"
+#include "pm.h"
+#include "gpio-cfg.h"
 
 #include "s3c24xx.h"
 #include "h1940.h"
diff --git a/arch/arm/mach-s3c/mach-rx3715.c b/arch/arm/mach-s3c/mach-rx3715.c
index 1c0730176799..4d6e9d9c8e07 100644
--- a/arch/arm/mach-s3c/mach-rx3715.c
+++ b/arch/arm/mach-s3c/mach-rx3715.c
@@ -35,13 +35,13 @@
 #include <asm/irq.h>
 #include <asm/mach-types.h>
 
-#include <mach/regs-gpio.h>
-#include <mach/gpio-samsung.h>
-#include <plat/gpio-cfg.h>
+#include "regs-gpio.h"
+#include "gpio-samsung.h"
+#include "gpio-cfg.h"
 
-#include <plat/cpu.h>
-#include <plat/devs.h>
-#include <plat/pm.h>
+#include "cpu.h"
+#include "devs.h"
+#include "pm.h"
 
 #include "s3c24xx.h"
 #include "h1940.h"
diff --git a/arch/arm/mach-s3c/mach-s3c2416-dt.c b/arch/arm/mach-s3c/mach-s3c2416-dt.c
index 2924e230e79d..418544d3015d 100644
--- a/arch/arm/mach-s3c/mach-s3c2416-dt.c
+++ b/arch/arm/mach-s3c/mach-s3c2416-dt.c
@@ -16,10 +16,10 @@
 #include <linux/serial_s3c.h>
 
 #include <asm/mach/arch.h>
-#include <mach/map.h>
+#include "map.h"
 
-#include <plat/cpu.h>
-#include <plat/pm.h>
+#include "cpu.h"
+#include "pm.h"
 
 #include "s3c24xx.h"
 
diff --git a/arch/arm/mach-s3c/mach-s3c64xx-dt.c b/arch/arm/mach-s3c/mach-s3c64xx-dt.c
index cd1da9602c86..00169c103862 100644
--- a/arch/arm/mach-s3c/mach-s3c64xx-dt.c
+++ b/arch/arm/mach-s3c/mach-s3c64xx-dt.c
@@ -8,8 +8,8 @@
 #include <asm/mach/map.h>
 #include <asm/system_misc.h>
 
-#include <plat/cpu.h>
-#include <mach/map.h>
+#include "cpu.h"
+#include "map.h"
 
 #include "s3c64xx.h"
 
diff --git a/arch/arm/mach-s3c/mach-smartq.c b/arch/arm/mach-s3c/mach-smartq.c
index 3a9ca85d09c5..da44a2610506 100644
--- a/arch/arm/mach-s3c/mach-smartq.c
+++ b/arch/arm/mach-s3c/mach-smartq.c
@@ -18,17 +18,17 @@
 #include <asm/mach-types.h>
 #include <asm/mach/map.h>
 
-#include <mach/map.h>
-#include <mach/regs-gpio.h>
-#include <mach/gpio-samsung.h>
+#include "map.h"
+#include "regs-gpio.h"
+#include "gpio-samsung.h"
 
-#include <plat/cpu.h>
-#include <plat/devs.h>
+#include "cpu.h"
+#include "devs.h"
 #include <linux/platform_data/i2c-s3c2410.h>
-#include <plat/gpio-cfg.h>
+#include "gpio-cfg.h"
 #include <linux/platform_data/hwmon-s3c.h>
 #include <linux/platform_data/usb-ohci-s3c2410.h>
-#include <plat/sdhci.h>
+#include "sdhci.h"
 #include <linux/platform_data/touchscreen-s3c2410.h>
 
 #include <video/platform_lcd.h>
diff --git a/arch/arm/mach-s3c/mach-smartq5.c b/arch/arm/mach-s3c/mach-smartq5.c
index f67cc50cb5b9..5d5e3c241629 100644
--- a/arch/arm/mach-s3c/mach-smartq5.c
+++ b/arch/arm/mach-s3c/mach-smartq5.c
@@ -15,14 +15,14 @@
 
 #include <video/samsung_fimd.h>
 #include <mach/irqs.h>
-#include <mach/map.h>
-#include <mach/regs-gpio.h>
-#include <mach/gpio-samsung.h>
-
-#include <plat/cpu.h>
-#include <plat/devs.h>
-#include <plat/fb.h>
-#include <plat/gpio-cfg.h>
+#include "map.h"
+#include "regs-gpio.h"
+#include "gpio-samsung.h"
+
+#include "cpu.h"
+#include "devs.h"
+#include "fb.h"
+#include "gpio-cfg.h"
 
 #include "s3c64xx.h"
 #include "mach-smartq.h"
diff --git a/arch/arm/mach-s3c/mach-smartq7.c b/arch/arm/mach-s3c/mach-smartq7.c
index af58147c6721..16b62e337d8d 100644
--- a/arch/arm/mach-s3c/mach-smartq7.c
+++ b/arch/arm/mach-s3c/mach-smartq7.c
@@ -15,14 +15,14 @@
 
 #include <video/samsung_fimd.h>
 #include <mach/irqs.h>
-#include <mach/map.h>
-#include <mach/regs-gpio.h>
-#include <mach/gpio-samsung.h>
-
-#include <plat/cpu.h>
-#include <plat/devs.h>
-#include <plat/fb.h>
-#include <plat/gpio-cfg.h>
+#include "map.h"
+#include "regs-gpio.h"
+#include "gpio-samsung.h"
+
+#include "cpu.h"
+#include "devs.h"
+#include "fb.h"
+#include "gpio-cfg.h"
 
 #include "s3c64xx.h"
 #include "mach-smartq.h"
diff --git a/arch/arm/mach-s3c/mach-smdk2410.c b/arch/arm/mach-s3c/mach-smdk2410.c
index 411216c46522..c6f0d0abf515 100644
--- a/arch/arm/mach-s3c/mach-smdk2410.c
+++ b/arch/arm/mach-s3c/mach-smdk2410.c
@@ -19,8 +19,8 @@
 #include <linux/serial_s3c.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
-#include <mach/gpio-samsung.h>
-#include <plat/gpio-cfg.h>
+#include "gpio-samsung.h"
+#include "gpio-cfg.h"
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -31,8 +31,8 @@
 
 #include <linux/platform_data/i2c-s3c2410.h>
 
-#include <plat/devs.h>
-#include <plat/cpu.h>
+#include "devs.h"
+#include "cpu.h"
 
 #include "s3c24xx.h"
 #include "common-smdk-s3c24xx.h"
diff --git a/arch/arm/mach-s3c/mach-smdk2413.c b/arch/arm/mach-s3c/mach-smdk2413.c
index 2ebf78cf0f3f..67ca5c855684 100644
--- a/arch/arm/mach-s3c/mach-smdk2413.c
+++ b/arch/arm/mach-s3c/mach-smdk2413.c
@@ -23,23 +23,23 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
-#include <mach/hardware-s3c24xx.h>
 #include <asm/hardware/iomd.h>
 #include <asm/setup.h>
 #include <asm/irq.h>
 #include <asm/mach-types.h>
 
 //#include <asm/debug-ll.h>
-#include <mach/regs-gpio.h>
+#include "hardware-s3c24xx.h"
+#include "regs-gpio.h"
 
 #include <linux/platform_data/usb-s3c2410_udc.h>
 #include <linux/platform_data/i2c-s3c2410.h>
 #include <linux/platform_data/fb-s3c2410.h>
-#include <mach/gpio-samsung.h>
-#include <plat/gpio-cfg.h>
+#include "gpio-samsung.h"
+#include "gpio-cfg.h"
 
-#include <plat/devs.h>
-#include <plat/cpu.h>
+#include "devs.h"
+#include "cpu.h"
 
 #include "s3c24xx.h"
 #include "common-smdk-s3c24xx.h"
diff --git a/arch/arm/mach-s3c/mach-smdk2416.c b/arch/arm/mach-s3c/mach-smdk2416.c
index 3bf3322740fc..3e28f65a6f83 100644
--- a/arch/arm/mach-s3c/mach-smdk2416.c
+++ b/arch/arm/mach-s3c/mach-smdk2416.c
@@ -25,26 +25,26 @@
 #include <asm/mach/irq.h>
 
 #include <video/samsung_fimd.h>
-#include <mach/hardware-s3c24xx.h>
 #include <asm/irq.h>
 #include <asm/mach-types.h>
 
-#include <mach/regs-gpio.h>
-#include <mach/regs-s3c2443-clock.h>
-#include <mach/gpio-samsung.h>
+#include "hardware-s3c24xx.h"
+#include "regs-gpio.h"
+#include "regs-s3c2443-clock.h"
+#include "gpio-samsung.h"
 
 #include <linux/platform_data/leds-s3c24xx.h>
 #include <linux/platform_data/i2c-s3c2410.h>
 
-#include <plat/gpio-cfg.h>
-#include <plat/devs.h>
-#include <plat/cpu.h>
+#include "gpio-cfg.h"
+#include "devs.h"
+#include "cpu.h"
 #include <linux/platform_data/mtd-nand-s3c2410.h>
-#include <plat/sdhci.h>
+#include "sdhci.h"
 #include <linux/platform_data/usb-s3c2410_udc.h>
 #include <linux/platform_data/s3c-hsudc.h>
 
-#include <plat/fb.h>
+#include "fb.h"
 
 #include "s3c24xx.h"
 #include "common-smdk-s3c24xx.h"
diff --git a/arch/arm/mach-s3c/mach-smdk2440.c b/arch/arm/mach-s3c/mach-smdk2440.c
index cc40316bc294..596a76702edb 100644
--- a/arch/arm/mach-s3c/mach-smdk2440.c
+++ b/arch/arm/mach-s3c/mach-smdk2440.c
@@ -26,15 +26,15 @@
 #include <asm/irq.h>
 #include <asm/mach-types.h>
 
-#include <mach/regs-gpio.h>
-#include <mach/gpio-samsung.h>
-#include <plat/gpio-cfg.h>
+#include "regs-gpio.h"
+#include "gpio-samsung.h"
+#include "gpio-cfg.h"
 
 #include <linux/platform_data/fb-s3c2410.h>
 #include <linux/platform_data/i2c-s3c2410.h>
 
-#include <plat/devs.h>
-#include <plat/cpu.h>
+#include "devs.h"
+#include "cpu.h"
 
 #include "s3c24xx.h"
 #include "common-smdk-s3c24xx.h"
diff --git a/arch/arm/mach-s3c/mach-smdk2443.c b/arch/arm/mach-s3c/mach-smdk2443.c
index 85a3f73fd0a1..ee6af7ad4429 100644
--- a/arch/arm/mach-s3c/mach-smdk2443.c
+++ b/arch/arm/mach-s3c/mach-smdk2443.c
@@ -25,13 +25,13 @@
 #include <asm/irq.h>
 #include <asm/mach-types.h>
 
-#include <mach/regs-gpio.h>
+#include "regs-gpio.h"
 
 #include <linux/platform_data/fb-s3c2410.h>
 #include <linux/platform_data/i2c-s3c2410.h>
 
-#include <plat/devs.h>
-#include <plat/cpu.h>
+#include "devs.h"
+#include "cpu.h"
 
 #include "s3c24xx.h"
 #include "common-smdk-s3c24xx.h"
diff --git a/arch/arm/mach-s3c/mach-smdk6400.c b/arch/arm/mach-s3c/mach-smdk6400.c
index 18ee5e203ca0..8f7c5071e113 100644
--- a/arch/arm/mach-s3c/mach-smdk6400.c
+++ b/arch/arm/mach-s3c/mach-smdk6400.c
@@ -23,12 +23,12 @@
 #include <asm/mach/irq.h>
 
 #include <mach/irqs.h>
-#include <mach/map.h>
+#include "map.h"
 
-#include <plat/devs.h>
-#include <plat/cpu.h>
+#include "devs.h"
+#include "cpu.h"
 #include <linux/platform_data/i2c-s3c2410.h>
-#include <mach/gpio-samsung.h>
+#include "gpio-samsung.h"
 
 #include "s3c64xx.h"
 
diff --git a/arch/arm/mach-s3c/mach-smdk6410.c b/arch/arm/mach-s3c/mach-smdk6410.c
index 371a605daa30..9614916f1294 100644
--- a/arch/arm/mach-s3c/mach-smdk6410.c
+++ b/arch/arm/mach-s3c/mach-smdk6410.c
@@ -46,23 +46,23 @@
 #include <asm/mach/irq.h>
 
 #include <mach/irqs.h>
-#include <mach/map.h>
+#include "map.h"
 
 #include <asm/irq.h>
 #include <asm/mach-types.h>
 
-#include <mach/regs-gpio.h>
-#include <mach/gpio-samsung.h>
+#include "regs-gpio.h"
+#include "gpio-samsung.h"
 #include <linux/platform_data/ata-samsung_cf.h>
 #include <linux/platform_data/i2c-s3c2410.h>
-#include <plat/fb.h>
-#include <plat/gpio-cfg.h>
+#include "fb.h"
+#include "gpio-cfg.h"
 
-#include <plat/devs.h>
-#include <plat/cpu.h>
+#include "devs.h"
+#include "cpu.h"
 #include <linux/soc/samsung/s3c-adc.h>
 #include <linux/platform_data/touchscreen-s3c2410.h>
-#include <plat/keypad.h>
+#include "keypad.h"
 
 #include "backlight-s3c64xx.h"
 #include "s3c64xx.h"
diff --git a/arch/arm/mach-s3c/mach-tct_hammer.c b/arch/arm/mach-s3c/mach-tct_hammer.c
index 53a550b915e0..3570cfdd817d 100644
--- a/arch/arm/mach-s3c/mach-tct_hammer.c
+++ b/arch/arm/mach-s3c/mach-tct_hammer.c
@@ -29,8 +29,8 @@
 #include <asm/mach-types.h>
 
 #include <linux/platform_data/i2c-s3c2410.h>
-#include <plat/devs.h>
-#include <plat/cpu.h>
+#include "devs.h"
+#include "cpu.h"
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
diff --git a/arch/arm/mach-s3c/mach-vr1000.c b/arch/arm/mach-s3c/mach-vr1000.c
index b63ece0def04..2f7f61d188eb 100644
--- a/arch/arm/mach-s3c/mach-vr1000.c
+++ b/arch/arm/mach-s3c/mach-vr1000.c
@@ -35,12 +35,12 @@
 #include <linux/platform_data/i2c-s3c2410.h>
 #include <linux/platform_data/asoc-s3c24xx_simtec.h>
 
-#include <mach/regs-gpio.h>
-#include <mach/gpio-samsung.h>
+#include "regs-gpio.h"
+#include "gpio-samsung.h"
+#include "gpio-cfg.h"
 
-#include <plat/cpu.h>
-#include <plat/devs.h>
-#include <plat/gpio-cfg.h>
+#include "cpu.h"
+#include "devs.h"
 
 #include "bast.h"
 #include "s3c24xx.h"
diff --git a/arch/arm/mach-s3c/mach-vstms.c b/arch/arm/mach-s3c/mach-vstms.c
index 0bd289705a01..3cf798cffbfb 100644
--- a/arch/arm/mach-s3c/mach-vstms.c
+++ b/arch/arm/mach-s3c/mach-vstms.c
@@ -28,17 +28,17 @@
 #include <asm/irq.h>
 #include <asm/mach-types.h>
 
-#include <mach/regs-gpio.h>
-#include <mach/gpio-samsung.h>
-#include <plat/gpio-cfg.h>
+#include "regs-gpio.h"
+#include "gpio-samsung.h"
+#include "gpio-cfg.h"
 
 #include <linux/platform_data/fb-s3c2410.h>
 
 #include <linux/platform_data/i2c-s3c2410.h>
 #include <linux/platform_data/mtd-nand-s3c2410.h>
 
-#include <plat/devs.h>
-#include <plat/cpu.h>
+#include "devs.h"
+#include "cpu.h"
 
 #include "s3c24xx.h"
 
diff --git a/arch/arm/mach-s3c/include/plat/map-s3c.h b/arch/arm/mach-s3c/map-s3c.h
similarity index 97%
rename from arch/arm/mach-s3c/include/plat/map-s3c.h
rename to arch/arm/mach-s3c/map-s3c.h
index bf247d836684..a18fdd3d6ae2 100644
--- a/arch/arm/mach-s3c/include/plat/map-s3c.h
+++ b/arch/arm/mach-s3c/map-s3c.h
@@ -9,7 +9,7 @@
 #ifndef __ASM_PLAT_MAP_S3C_H
 #define __ASM_PLAT_MAP_S3C_H __FILE__
 
-#include <mach/map.h>
+#include "map.h"
 
 #define S3C24XX_VA_IRQ		S3C_VA_IRQ
 #define S3C24XX_VA_MEMCTRL	S3C_VA_MEM
@@ -65,6 +65,6 @@ extern void __iomem *s3c24xx_va_gpio2;
 #define S3C24XX_VA_GPIO2 S3C24XX_VA_GPIO
 #endif
 
-#include <plat/map-s5p.h>
+#include "map-s5p.h"
 
 #endif /* __ASM_PLAT_MAP_S3C_H */
diff --git a/arch/arm/mach-s3c/include/mach/map-s3c24xx.h b/arch/arm/mach-s3c/map-s3c24xx.h
similarity index 98%
rename from arch/arm/mach-s3c/include/mach/map-s3c24xx.h
rename to arch/arm/mach-s3c/map-s3c24xx.h
index a20c9fd0d855..b5dba78a9dd7 100644
--- a/arch/arm/mach-s3c/include/mach/map-s3c24xx.h
+++ b/arch/arm/mach-s3c/map-s3c24xx.h
@@ -9,8 +9,8 @@
 #ifndef __ASM_ARCH_MAP_H
 #define __ASM_ARCH_MAP_H
 
-#include <plat/map-base.h>
-#include <plat/map-s3c.h>
+#include <mach/map-base.h>
+#include "map-s3c.h"
 
 /*
  * interrupt controller is the first thing we put in, to make
diff --git a/arch/arm/mach-s3c/include/mach/map-s3c64xx.h b/arch/arm/mach-s3c/map-s3c64xx.h
similarity index 98%
rename from arch/arm/mach-s3c/include/mach/map-s3c64xx.h
rename to arch/arm/mach-s3c/map-s3c64xx.h
index 9372a535b7ba..d7740d2a77c4 100644
--- a/arch/arm/mach-s3c/include/mach/map-s3c64xx.h
+++ b/arch/arm/mach-s3c/map-s3c64xx.h
@@ -11,8 +11,8 @@
 #ifndef __ASM_ARCH_MAP_H
 #define __ASM_ARCH_MAP_H __FILE__
 
-#include <plat/map-base.h>
-#include <plat/map-s3c.h>
+#include <mach/map-base.h>
+#include "map-s3c.h"
 
 /*
  * Post-mux Chip Select Regions Xm0CSn_
diff --git a/arch/arm/mach-s3c/include/plat/map-s5p.h b/arch/arm/mach-s3c/map-s5p.h
similarity index 94%
rename from arch/arm/mach-s3c/include/plat/map-s5p.h
rename to arch/arm/mach-s3c/map-s5p.h
index 3812085f8761..cd237924e34d 100644
--- a/arch/arm/mach-s3c/include/plat/map-s5p.h
+++ b/arch/arm/mach-s3c/map-s5p.h
@@ -15,6 +15,6 @@
 #define VA_VIC2			VA_VIC(2)
 #define VA_VIC3			VA_VIC(3)
 
-#include <plat/map-s3c.h>
+#include "map-s3c.h"
 
 #endif /* __ASM_PLAT_MAP_S5P_H */
diff --git a/arch/arm/mach-s3c/include/mach/map.h b/arch/arm/mach-s3c/map.h
similarity index 100%
rename from arch/arm/mach-s3c/include/mach/map.h
rename to arch/arm/mach-s3c/map.h
diff --git a/arch/arm/mach-s3c/pl080.c b/arch/arm/mach-s3c/pl080.c
index 3cbc755f7cd0..4730f080c736 100644
--- a/arch/arm/mach-s3c/pl080.c
+++ b/arch/arm/mach-s3c/pl080.c
@@ -10,9 +10,9 @@
 #include <linux/amba/pl08x.h>
 #include <linux/of.h>
 
-#include <plat/cpu.h>
+#include "cpu.h"
 #include <mach/irqs.h>
-#include <mach/map.h>
+#include "map.h"
 
 #include "regs-sys-s3c64xx.h"
 
diff --git a/arch/arm/mach-s3c/platformdata.c b/arch/arm/mach-s3c/platformdata.c
index cbc3b4b45c74..e643c81aef45 100644
--- a/arch/arm/mach-s3c/platformdata.c
+++ b/arch/arm/mach-s3c/platformdata.c
@@ -9,8 +9,8 @@
 #include <linux/string.h>
 #include <linux/platform_device.h>
 
-#include <plat/devs.h>
-#include <plat/sdhci.h>
+#include "devs.h"
+#include "sdhci.h"
 
 void __init *s3c_set_platdata(void *pd, size_t pdsize,
 			      struct platform_device *pdev)
diff --git a/arch/arm/mach-s3c/pm-common.c b/arch/arm/mach-s3c/pm-common.c
index 2da0d352441f..618bd4499cae 100644
--- a/arch/arm/mach-s3c/pm-common.c
+++ b/arch/arm/mach-s3c/pm-common.c
@@ -12,7 +12,7 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 
-#include <plat/pm-common.h>
+#include "pm-common.h"
 
 /* helper functions to save and restore register state */
 
diff --git a/arch/arm/mach-s3c/include/plat/pm-common.h b/arch/arm/mach-s3c/pm-common.h
similarity index 100%
rename from arch/arm/mach-s3c/include/plat/pm-common.h
rename to arch/arm/mach-s3c/pm-common.h
diff --git a/arch/arm/mach-s3c/include/mach/pm-core-s3c24xx.h b/arch/arm/mach-s3c/pm-core-s3c24xx.h
similarity index 100%
rename from arch/arm/mach-s3c/include/mach/pm-core-s3c24xx.h
rename to arch/arm/mach-s3c/pm-core-s3c24xx.h
diff --git a/arch/arm/mach-s3c/include/mach/pm-core-s3c64xx.h b/arch/arm/mach-s3c/pm-core-s3c64xx.h
similarity index 96%
rename from arch/arm/mach-s3c/include/mach/pm-core-s3c64xx.h
rename to arch/arm/mach-s3c/pm-core-s3c64xx.h
index 33cf242734a0..06f564e5cf63 100644
--- a/arch/arm/mach-s3c/include/mach/pm-core-s3c64xx.h
+++ b/arch/arm/mach-s3c/pm-core-s3c64xx.h
@@ -14,9 +14,9 @@
 #include <linux/serial_s3c.h>
 #include <linux/delay.h>
 
-#include <mach/regs-gpio.h>
-#include <mach/regs-clock.h>
-#include <mach/map.h>
+#include "regs-gpio.h"
+#include "regs-clock.h"
+#include "map.h"
 
 static inline void s3c_pm_debug_init_uart(void)
 {
diff --git a/arch/arm/mach-s3c/include/mach/pm-core.h b/arch/arm/mach-s3c/pm-core.h
similarity index 100%
rename from arch/arm/mach-s3c/include/mach/pm-core.h
rename to arch/arm/mach-s3c/pm-core.h
diff --git a/arch/arm/mach-s3c/pm-gpio.c b/arch/arm/mach-s3c/pm-gpio.c
index cb2e3bc79336..cfdbc2337998 100644
--- a/arch/arm/mach-s3c/pm-gpio.c
+++ b/arch/arm/mach-s3c/pm-gpio.c
@@ -13,10 +13,10 @@
 #include <linux/io.h>
 #include <linux/gpio.h>
 
-#include <mach/gpio-samsung.h>
+#include "gpio-samsung.h"
 
-#include <plat/gpio-core.h>
-#include <plat/pm.h>
+#include "gpio-core.h"
+#include "pm.h"
 
 /* PM GPIO helpers */
 
diff --git a/arch/arm/mach-s3c/pm-h1940.S b/arch/arm/mach-s3c/pm-h1940.S
index f9ee515e1cbe..3bf6685123cb 100644
--- a/arch/arm/mach-s3c/pm-h1940.S
+++ b/arch/arm/mach-s3c/pm-h1940.S
@@ -7,9 +7,9 @@
 
 #include <linux/linkage.h>
 #include <asm/assembler.h>
-#include <mach/map.h>
+#include "map.h"
 
-#include <mach/regs-gpio.h>
+#include "regs-gpio.h"
 
 	.text
 	.global	h1940_pm_return
diff --git a/arch/arm/mach-s3c/pm-s3c2410.c b/arch/arm/mach-s3c/pm-s3c2410.c
index ffd0d6c2324f..a66419883735 100644
--- a/arch/arm/mach-s3c/pm-s3c2410.c
+++ b/arch/arm/mach-s3c/pm-s3c2410.c
@@ -16,12 +16,12 @@
 
 #include <asm/mach-types.h>
 
-#include <mach/regs-gpio.h>
-#include <mach/gpio-samsung.h>
+#include "regs-gpio.h"
+#include "gpio-samsung.h"
 
-#include <plat/gpio-cfg.h>
-#include <plat/cpu.h>
-#include <plat/pm.h>
+#include "gpio-cfg.h"
+#include "cpu.h"
+#include "pm.h"
 
 #include "h1940.h"
 
diff --git a/arch/arm/mach-s3c/pm-s3c2412.c b/arch/arm/mach-s3c/pm-s3c2412.c
index 1caf53b65dc1..6a9604477c9e 100644
--- a/arch/arm/mach-s3c/pm-s3c2412.c
+++ b/arch/arm/mach-s3c/pm-s3c2412.c
@@ -20,11 +20,11 @@
 #include <asm/irq.h>
 
 #include <mach/irqs.h>
-#include <mach/regs-gpio.h>
+#include "regs-gpio.h"
 
-#include <plat/cpu.h>
-#include <plat/pm.h>
-#include <plat/wakeup-mask.h>
+#include "cpu.h"
+#include "pm.h"
+#include "wakeup-mask.h"
 
 #include "regs-dsc-s3c24xx.h"
 #include "s3c2412-power.h"
diff --git a/arch/arm/mach-s3c/pm-s3c2416.c b/arch/arm/mach-s3c/pm-s3c2416.c
index 9a2f05e279d4..f69ad84cf4ff 100644
--- a/arch/arm/mach-s3c/pm-s3c2416.c
+++ b/arch/arm/mach-s3c/pm-s3c2416.c
@@ -11,10 +11,10 @@
 
 #include <asm/cacheflush.h>
 
-#include <mach/regs-s3c2443-clock.h>
+#include "regs-s3c2443-clock.h"
 
-#include <plat/cpu.h>
-#include <plat/pm.h>
+#include "cpu.h"
+#include "pm.h"
 
 #include "s3c2412-power.h"
 
diff --git a/arch/arm/mach-s3c/pm-s3c24xx.c b/arch/arm/mach-s3c/pm-s3c24xx.c
index 0c583cbe41b2..3a8f5c38882e 100644
--- a/arch/arm/mach-s3c/pm-s3c24xx.c
+++ b/arch/arm/mach-s3c/pm-s3c24xx.c
@@ -21,15 +21,15 @@
 #include <linux/serial_s3c.h>
 #include <linux/io.h>
 
-#include <mach/regs-clock.h>
-#include <mach/regs-gpio.h>
-#include <mach/regs-irq.h>
-#include <mach/gpio-samsung.h>
+#include "regs-clock.h"
+#include "regs-gpio.h"
+#include "regs-irq.h"
+#include "gpio-samsung.h"
 
 #include <asm/mach/time.h>
 
-#include <plat/gpio-cfg.h>
-#include <plat/pm.h>
+#include "gpio-cfg.h"
+#include "pm.h"
 
 #include "regs-mem-s3c24xx.h"
 
diff --git a/arch/arm/mach-s3c/pm-s3c64xx.c b/arch/arm/mach-s3c/pm-s3c64xx.c
index 03393664a797..4f1778123dee 100644
--- a/arch/arm/mach-s3c/pm-s3c64xx.c
+++ b/arch/arm/mach-s3c/pm-s3c64xx.c
@@ -14,17 +14,17 @@
 #include <linux/gpio.h>
 #include <linux/pm_domain.h>
 
-#include <mach/map.h>
+#include "map.h"
 #include <mach/irqs.h>
 
-#include <plat/cpu.h>
-#include <plat/devs.h>
-#include <plat/pm.h>
-#include <plat/wakeup-mask.h>
+#include "cpu.h"
+#include "devs.h"
+#include "pm.h"
+#include "wakeup-mask.h"
 
-#include <mach/regs-gpio.h>
-#include <mach/regs-clock.h>
-#include <mach/gpio-samsung.h>
+#include "regs-gpio.h"
+#include "regs-clock.h"
+#include "gpio-samsung.h"
 
 #include "regs-gpio-memport-s3c64xx.h"
 #include "regs-modem-s3c64xx.h"
diff --git a/arch/arm/mach-s3c/pm.c b/arch/arm/mach-s3c/pm.c
index 03c22a9dee21..c563bb9d92be 100644
--- a/arch/arm/mach-s3c/pm.c
+++ b/arch/arm/mach-s3c/pm.c
@@ -18,16 +18,16 @@
 #include <asm/cacheflush.h>
 #include <asm/suspend.h>
 
-#include <mach/map.h>
-#include <mach/regs-clock.h>
-#include <mach/regs-irq.h>
+#include "map.h"
+#include "regs-clock.h"
+#include "regs-irq.h"
 #include <mach/irqs.h>
 
 #include <asm/irq.h>
 
-#include <plat/cpu.h>
-#include <plat/pm.h>
-#include <mach/pm-core.h>
+#include "cpu.h"
+#include "pm.h"
+#include "pm-core.h"
 
 /* for external use */
 
diff --git a/arch/arm/mach-s3c/include/plat/pm.h b/arch/arm/mach-s3c/pm.h
similarity index 98%
rename from arch/arm/mach-s3c/include/plat/pm.h
rename to arch/arm/mach-s3c/pm.h
index 2746137f9794..eed61e585457 100644
--- a/arch/arm/mach-s3c/include/plat/pm.h
+++ b/arch/arm/mach-s3c/pm.h
@@ -11,7 +11,7 @@
  * management
 */
 
-#include <plat/pm-common.h>
+#include "pm-common.h"
 
 struct device;
 
diff --git a/arch/arm/mach-s3c/include/plat/pwm-core.h b/arch/arm/mach-s3c/pwm-core.h
similarity index 100%
rename from arch/arm/mach-s3c/include/plat/pwm-core.h
rename to arch/arm/mach-s3c/pwm-core.h
diff --git a/arch/arm/mach-s3c/include/plat/regs-adc.h b/arch/arm/mach-s3c/regs-adc.h
similarity index 100%
rename from arch/arm/mach-s3c/include/plat/regs-adc.h
rename to arch/arm/mach-s3c/regs-adc.h
diff --git a/arch/arm/mach-s3c/include/mach/regs-clock-s3c24xx.h b/arch/arm/mach-s3c/regs-clock-s3c24xx.h
similarity index 99%
rename from arch/arm/mach-s3c/include/mach/regs-clock-s3c24xx.h
rename to arch/arm/mach-s3c/regs-clock-s3c24xx.h
index da4e7b3aeba6..933ddb5eedec 100644
--- a/arch/arm/mach-s3c/include/mach/regs-clock-s3c24xx.h
+++ b/arch/arm/mach-s3c/regs-clock-s3c24xx.h
@@ -9,7 +9,7 @@
 #ifndef __ASM_ARM_REGS_CLOCK
 #define __ASM_ARM_REGS_CLOCK
 
-#include <mach/map.h>
+#include "map.h"
 
 #define S3C2410_CLKREG(x) ((x) + S3C24XX_VA_CLKPWR)
 
diff --git a/arch/arm/mach-s3c/include/mach/regs-clock-s3c64xx.h b/arch/arm/mach-s3c/regs-clock-s3c64xx.h
similarity index 100%
rename from arch/arm/mach-s3c/include/mach/regs-clock-s3c64xx.h
rename to arch/arm/mach-s3c/regs-clock-s3c64xx.h
diff --git a/arch/arm/mach-s3c/include/mach/regs-clock.h b/arch/arm/mach-s3c/regs-clock.h
similarity index 100%
rename from arch/arm/mach-s3c/include/mach/regs-clock.h
rename to arch/arm/mach-s3c/regs-clock.h
diff --git a/arch/arm/mach-s3c/include/mach/regs-gpio-s3c24xx.h b/arch/arm/mach-s3c/regs-gpio-s3c24xx.h
similarity index 99%
rename from arch/arm/mach-s3c/include/mach/regs-gpio-s3c24xx.h
rename to arch/arm/mach-s3c/regs-gpio-s3c24xx.h
index 51827d5577b6..9a7e262268a7 100644
--- a/arch/arm/mach-s3c/include/mach/regs-gpio-s3c24xx.h
+++ b/arch/arm/mach-s3c/regs-gpio-s3c24xx.h
@@ -10,7 +10,7 @@
 #ifndef __ASM_ARCH_REGS_GPIO_H
 #define __ASM_ARCH_REGS_GPIO_H
 
-#include <plat/map-s3c.h>
+#include "map-s3c.h"
 
 #define S3C24XX_MISCCR		S3C24XX_GPIOREG2(0x80)
 
diff --git a/arch/arm/mach-s3c/include/mach/regs-gpio-s3c64xx.h b/arch/arm/mach-s3c/regs-gpio-s3c64xx.h
similarity index 100%
rename from arch/arm/mach-s3c/include/mach/regs-gpio-s3c64xx.h
rename to arch/arm/mach-s3c/regs-gpio-s3c64xx.h
diff --git a/arch/arm/mach-s3c/include/mach/regs-gpio.h b/arch/arm/mach-s3c/regs-gpio.h
similarity index 100%
rename from arch/arm/mach-s3c/include/mach/regs-gpio.h
rename to arch/arm/mach-s3c/regs-gpio.h
diff --git a/arch/arm/mach-s3c/include/mach/regs-irq-s3c24xx.h b/arch/arm/mach-s3c/regs-irq-s3c24xx.h
similarity index 98%
rename from arch/arm/mach-s3c/include/mach/regs-irq-s3c24xx.h
rename to arch/arm/mach-s3c/regs-irq-s3c24xx.h
index 2921b48c56b2..c0b97b203415 100644
--- a/arch/arm/mach-s3c/include/mach/regs-irq-s3c24xx.h
+++ b/arch/arm/mach-s3c/regs-irq-s3c24xx.h
@@ -8,7 +8,7 @@
 #ifndef ___ASM_ARCH_REGS_IRQ_H
 #define ___ASM_ARCH_REGS_IRQ_H
 
-#include <plat/map-s3c.h>
+#include "map-s3c.h"
 
 /* interrupt controller */
 
diff --git a/arch/arm/mach-s3c/include/mach/regs-irq-s3c64xx.h b/arch/arm/mach-s3c/regs-irq-s3c64xx.h
similarity index 100%
rename from arch/arm/mach-s3c/include/mach/regs-irq-s3c64xx.h
rename to arch/arm/mach-s3c/regs-irq-s3c64xx.h
diff --git a/arch/arm/mach-s3c/include/mach/regs-irq.h b/arch/arm/mach-s3c/regs-irq.h
similarity index 100%
rename from arch/arm/mach-s3c/include/mach/regs-irq.h
rename to arch/arm/mach-s3c/regs-irq.h
diff --git a/arch/arm/mach-s3c/include/plat/regs-irqtype.h b/arch/arm/mach-s3c/regs-irqtype.h
similarity index 100%
rename from arch/arm/mach-s3c/include/plat/regs-irqtype.h
rename to arch/arm/mach-s3c/regs-irqtype.h
diff --git a/arch/arm/mach-s3c/regs-mem-s3c24xx.h b/arch/arm/mach-s3c/regs-mem-s3c24xx.h
index 5048ab8f06c2..8fed34a1672a 100644
--- a/arch/arm/mach-s3c/regs-mem-s3c24xx.h
+++ b/arch/arm/mach-s3c/regs-mem-s3c24xx.h
@@ -9,7 +9,7 @@
 #ifndef __ARCH_ARM_MACH_S3C24XX_REGS_MEM_H
 #define __ARCH_ARM_MACH_S3C24XX_REGS_MEM_H __FILE__
 
-#include <plat/map-s3c.h>
+#include "map-s3c.h"
 
 #define S3C2410_MEMREG(x)		(S3C24XX_VA_MEMCTRL + (x))
 
diff --git a/arch/arm/mach-s3c/include/mach/regs-s3c2443-clock.h b/arch/arm/mach-s3c/regs-s3c2443-clock.h
similarity index 99%
rename from arch/arm/mach-s3c/include/mach/regs-s3c2443-clock.h
rename to arch/arm/mach-s3c/regs-s3c2443-clock.h
index fefef7233f4b..b3b670d463db 100644
--- a/arch/arm/mach-s3c/include/mach/regs-s3c2443-clock.h
+++ b/arch/arm/mach-s3c/regs-s3c2443-clock.h
@@ -11,7 +11,7 @@
 #define __ASM_ARM_REGS_S3C2443_CLOCK
 
 #include <linux/delay.h>
-#include <plat/map-s3c.h>
+#include "map-s3c.h"
 
 #define S3C2443_CLKREG(x)		((x) + S3C24XX_VA_CLKPWR)
 
diff --git a/arch/arm/mach-s3c/include/mach/rtc-core-s3c24xx.h b/arch/arm/mach-s3c/rtc-core-s3c24xx.h
similarity index 100%
rename from arch/arm/mach-s3c/include/mach/rtc-core-s3c24xx.h
rename to arch/arm/mach-s3c/rtc-core-s3c24xx.h
diff --git a/arch/arm/mach-s3c/s3c2410.c b/arch/arm/mach-s3c/s3c2410.c
index 0013125b03ee..4153e67f0e86 100644
--- a/arch/arm/mach-s3c/s3c2410.c
+++ b/arch/arm/mach-s3c/s3c2410.c
@@ -25,21 +25,21 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
-#include <mach/map.h>
-#include <mach/gpio-samsung.h>
+#include "map.h"
+#include "gpio-samsung.h"
 #include <asm/irq.h>
 #include <asm/system_misc.h>
 
 
-#include <mach/regs-clock.h>
+#include "regs-clock.h"
 
-#include <plat/cpu.h>
-#include <plat/devs.h>
-#include <plat/pm.h>
+#include "cpu.h"
+#include "devs.h"
+#include "pm.h"
 
-#include <plat/gpio-core.h>
-#include <plat/gpio-cfg.h>
-#include <plat/gpio-cfg-helpers.h>
+#include "gpio-core.h"
+#include "gpio-cfg.h"
+#include "gpio-cfg-helpers.h"
 
 #include "s3c24xx.h"
 
diff --git a/arch/arm/mach-s3c/s3c2412.c b/arch/arm/mach-s3c/s3c2412.c
index 5fbea5b4276d..35f4addd110b 100644
--- a/arch/arm/mach-s3c/s3c2412.c
+++ b/arch/arm/mach-s3c/s3c2412.c
@@ -29,13 +29,13 @@
 #include <asm/irq.h>
 #include <asm/system_misc.h>
 
-#include <mach/map.h>
-#include <mach/regs-clock.h>
-#include <mach/regs-gpio.h>
+#include "map.h"
+#include "regs-clock.h"
+#include "regs-gpio.h"
 
-#include <plat/cpu.h>
-#include <plat/devs.h>
-#include <plat/pm.h>
+#include "cpu.h"
+#include "devs.h"
+#include "pm.h"
 
 #include "s3c24xx.h"
 #include "nand-core-s3c24xx.h"
diff --git a/arch/arm/mach-s3c/include/mach/s3c2412.h b/arch/arm/mach-s3c/s3c2412.h
similarity index 96%
rename from arch/arm/mach-s3c/include/mach/s3c2412.h
rename to arch/arm/mach-s3c/s3c2412.h
index 1ae369c81beb..ed09a0e13bd8 100644
--- a/arch/arm/mach-s3c/include/mach/s3c2412.h
+++ b/arch/arm/mach-s3c/s3c2412.h
@@ -8,7 +8,7 @@
 #ifndef __ARCH_ARM_MACH_S3C24XX_S3C2412_H
 #define __ARCH_ARM_MACH_S3C24XX_S3C2412_H __FILE__
 
-#include <plat/map-s3c.h>
+#include "map-s3c.h"
 
 #define S3C2412_MEMREG(x)		(S3C24XX_VA_MEMCTRL + (x))
 #define S3C2412_EBIREG(x)		(S3C2412_VA_EBI + (x))
diff --git a/arch/arm/mach-s3c/s3c2416.c b/arch/arm/mach-s3c/s3c2416.c
index f24476c16e4a..34b7c101becf 100644
--- a/arch/arm/mach-s3c/s3c2416.c
+++ b/arch/arm/mach-s3c/s3c2416.c
@@ -26,25 +26,25 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
-#include <mach/map.h>
-#include <mach/gpio-samsung.h>
+#include "map.h"
+#include "gpio-samsung.h"
 #include <asm/proc-fns.h>
 #include <asm/irq.h>
 #include <asm/system_misc.h>
 
-#include <mach/regs-s3c2443-clock.h>
-#include <mach/rtc-core-s3c24xx.h>
+#include "regs-s3c2443-clock.h"
+#include "rtc-core-s3c24xx.h"
 
-#include <plat/gpio-core.h>
-#include <plat/gpio-cfg.h>
-#include <plat/gpio-cfg-helpers.h>
-#include <plat/devs.h>
-#include <plat/cpu.h>
-#include <plat/sdhci.h>
-#include <plat/pm.h>
+#include "gpio-core.h"
+#include "gpio-cfg.h"
+#include "gpio-cfg-helpers.h"
+#include "devs.h"
+#include "cpu.h"
+#include "sdhci.h"
+#include "pm.h"
 
-#include <plat/iic-core.h>
-#include <plat/adc-core.h>
+#include "iic-core.h"
+#include "adc-core.h"
 
 #include "s3c24xx.h"
 #include "fb-core-s3c24xx.h"
diff --git a/arch/arm/mach-s3c/s3c2440.c b/arch/arm/mach-s3c/s3c2440.c
index 234b08e57046..c6cdee4987e8 100644
--- a/arch/arm/mach-s3c/s3c2440.c
+++ b/arch/arm/mach-s3c/s3c2440.c
@@ -23,16 +23,16 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
-#include <mach/gpio-samsung.h>
 #include <asm/irq.h>
 
-#include <plat/devs.h>
-#include <plat/cpu.h>
-#include <plat/pm.h>
+#include "devs.h"
+#include "cpu.h"
+#include "pm.h"
 
-#include <plat/gpio-core.h>
-#include <plat/gpio-cfg.h>
-#include <plat/gpio-cfg-helpers.h>
+#include "gpio-core.h"
+#include "gpio-cfg.h"
+#include "gpio-cfg-helpers.h"
+#include "gpio-samsung.h"
 
 #include "s3c24xx.h"
 
diff --git a/arch/arm/mach-s3c/s3c2442.c b/arch/arm/mach-s3c/s3c2442.c
index 29d82315339d..0c0e30b6688f 100644
--- a/arch/arm/mach-s3c/s3c2442.c
+++ b/arch/arm/mach-s3c/s3c2442.c
@@ -21,18 +21,18 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
-#include <mach/gpio-samsung.h>
 #include <linux/atomic.h>
 #include <asm/irq.h>
 
-#include <mach/regs-clock.h>
+#include "regs-clock.h"
 
-#include <plat/cpu.h>
-#include <plat/pm.h>
+#include "cpu.h"
+#include "pm.h"
 
-#include <plat/gpio-core.h>
-#include <plat/gpio-cfg.h>
-#include <plat/gpio-cfg-helpers.h>
+#include "gpio-core.h"
+#include "gpio-cfg.h"
+#include "gpio-cfg-helpers.h"
+#include "gpio-samsung.h"
 
 #include "s3c24xx.h"
 
diff --git a/arch/arm/mach-s3c/s3c2443.c b/arch/arm/mach-s3c/s3c2443.c
index d070e738eafb..45fde50b202c 100644
--- a/arch/arm/mach-s3c/s3c2443.c
+++ b/arch/arm/mach-s3c/s3c2443.c
@@ -23,21 +23,21 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
-#include <mach/map.h>
-#include <mach/gpio-samsung.h>
+#include "map.h"
+#include "gpio-samsung.h"
 #include <mach/irqs.h>
 #include <asm/irq.h>
 #include <asm/system_misc.h>
 
-#include <mach/regs-s3c2443-clock.h>
-#include <mach/rtc-core-s3c24xx.h>
+#include "regs-s3c2443-clock.h"
+#include "rtc-core-s3c24xx.h"
 
-#include <plat/gpio-core.h>
-#include <plat/gpio-cfg.h>
-#include <plat/gpio-cfg-helpers.h>
-#include <plat/devs.h>
-#include <plat/cpu.h>
-#include <plat/adc-core.h>
+#include "gpio-core.h"
+#include "gpio-cfg.h"
+#include "gpio-cfg-helpers.h"
+#include "devs.h"
+#include "cpu.h"
+#include "adc-core.h"
 
 #include "s3c24xx.h"
 #include "fb-core-s3c24xx.h"
diff --git a/arch/arm/mach-s3c/s3c244x.c b/arch/arm/mach-s3c/s3c244x.c
index 9d8464178412..bae93598f009 100644
--- a/arch/arm/mach-s3c/s3c244x.c
+++ b/arch/arm/mach-s3c/s3c244x.c
@@ -25,15 +25,15 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
-#include <mach/map.h>
+#include "map.h"
 #include <asm/irq.h>
 
-#include <mach/regs-clock.h>
-#include <mach/regs-gpio.h>
+#include "regs-clock.h"
+#include "regs-gpio.h"
 
-#include <plat/devs.h>
-#include <plat/cpu.h>
-#include <plat/pm.h>
+#include "devs.h"
+#include "cpu.h"
+#include "pm.h"
 
 #include "s3c24xx.h"
 #include "nand-core-s3c24xx.h"
diff --git a/arch/arm/mach-s3c/s3c24xx.c b/arch/arm/mach-s3c/s3c24xx.c
index d854cf9d290b..db049dd94324 100644
--- a/arch/arm/mach-s3c/s3c24xx.c
+++ b/arch/arm/mach-s3c/s3c24xx.c
@@ -22,9 +22,9 @@
 #include <linux/dmaengine.h>
 #include <linux/clk/samsung.h>
 
-#include <mach/hardware-s3c24xx.h>
-#include <mach/map.h>
-#include <mach/regs-clock.h>
+#include "hardware-s3c24xx.h"
+#include "map.h"
+#include "regs-clock.h"
 #include <asm/irq.h>
 #include <asm/cacheflush.h>
 #include <asm/system_info.h>
@@ -33,12 +33,12 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/regs-gpio.h>
-#include <mach/dma.h>
+#include "regs-gpio.h"
+#include "dma-s3c24xx.h"
 
-#include <plat/cpu.h>
-#include <plat/devs.h>
-#include <plat/pwm-core.h>
+#include "cpu.h"
+#include "devs.h"
+#include "pwm-core.h"
 
 #include "s3c24xx.h"
 
diff --git a/arch/arm/mach-s3c/s3c6400.c b/arch/arm/mach-s3c/s3c6400.c
index 86be7eeef6e1..802f4fb7462d 100644
--- a/arch/arm/mach-s3c/s3c6400.c
+++ b/arch/arm/mach-s3c/s3c6400.c
@@ -28,12 +28,12 @@
 
 #include <asm/irq.h>
 
-#include <mach/regs-clock.h>
+#include "regs-clock.h"
 
-#include <plat/cpu.h>
-#include <plat/devs.h>
-#include <plat/sdhci.h>
-#include <plat/iic-core.h>
+#include "cpu.h"
+#include "devs.h"
+#include "sdhci.h"
+#include "iic-core.h"
 
 #include "s3c64xx.h"
 #include "onenand-core-s3c64xx.h"
diff --git a/arch/arm/mach-s3c/s3c6410.c b/arch/arm/mach-s3c/s3c6410.c
index 0f253d423581..dae17d5fd092 100644
--- a/arch/arm/mach-s3c/s3c6410.c
+++ b/arch/arm/mach-s3c/s3c6410.c
@@ -30,13 +30,13 @@
 #include <asm/irq.h>
 
 #include <linux/soc/samsung/s3c-pm.h>
-#include <mach/regs-clock.h>
+#include "regs-clock.h"
 
-#include <plat/cpu.h>
-#include <plat/devs.h>
-#include <plat/sdhci.h>
-#include <plat/adc-core.h>
-#include <plat/iic-core.h>
+#include "cpu.h"
+#include "devs.h"
+#include "sdhci.h"
+#include "adc-core.h"
+#include "iic-core.h"
 
 #include "ata-core-s3c64xx.h"
 #include "s3c64xx.h"
diff --git a/arch/arm/mach-s3c/s3c64xx.c b/arch/arm/mach-s3c/s3c64xx.c
index fcb096298113..ef79aaf1aced 100644
--- a/arch/arm/mach-s3c/s3c64xx.c
+++ b/arch/arm/mach-s3c/s3c64xx.c
@@ -35,18 +35,17 @@
 #include <asm/mach/map.h>
 #include <asm/system_misc.h>
 
-#include <mach/map.h>
+#include "map.h"
 #include <mach/irqs.h>
-#include <mach/regs-gpio.h>
-#include <mach/gpio-samsung.h>
-
-#include <plat/cpu.h>
-#include <plat/devs.h>
-#include <plat/pm.h>
-#include <plat/gpio-cfg.h>
-#include <plat/pwm-core.h>
-#include <plat/regs-irqtype.h>
-
+#include "regs-gpio.h"
+#include "gpio-samsung.h"
+
+#include "cpu.h"
+#include "devs.h"
+#include "pm.h"
+#include "gpio-cfg.h"
+#include "pwm-core.h"
+#include "regs-irqtype.h"
 #include "s3c64xx.h"
 #include "irq-uart-s3c64xx.h"
 
diff --git a/arch/arm/mach-s3c/include/plat/sdhci.h b/arch/arm/mach-s3c/sdhci.h
similarity index 99%
rename from arch/arm/mach-s3c/include/plat/sdhci.h
rename to arch/arm/mach-s3c/sdhci.h
index 5731e42ea208..9f9d419e58d7 100644
--- a/arch/arm/mach-s3c/include/plat/sdhci.h
+++ b/arch/arm/mach-s3c/sdhci.h
@@ -15,7 +15,7 @@
 #define __PLAT_S3C_SDHCI_H __FILE__
 
 #include <linux/platform_data/mmc-sdhci-s3c.h>
-#include <plat/devs.h>
+#include "devs.h"
 
 /* s3c_sdhci_set_platdata() - common helper for setting SDHCI platform data
  * @pd: The default platform data for this device.
diff --git a/arch/arm/mach-s3c/setup-camif-s3c24xx.c b/arch/arm/mach-s3c/setup-camif-s3c24xx.c
index 4046afaad645..11e97719a50a 100644
--- a/arch/arm/mach-s3c/setup-camif-s3c24xx.c
+++ b/arch/arm/mach-s3c/setup-camif-s3c24xx.c
@@ -5,8 +5,8 @@
 // Helper functions for S3C24XX/S3C64XX SoC series CAMIF driver
 
 #include <linux/gpio.h>
-#include <plat/gpio-cfg.h>
-#include <mach/gpio-samsung.h>
+#include "gpio-cfg.h"
+#include "gpio-samsung.h"
 #include <media/drv-intf/s3c_camif.h>
 
 /* Number of camera port pins, without FIELD */
diff --git a/arch/arm/mach-s3c/setup-fb-24bpp-s3c64xx.c b/arch/arm/mach-s3c/setup-fb-24bpp-s3c64xx.c
index 2c7178b26ebb..cfa34b55ca21 100644
--- a/arch/arm/mach-s3c/setup-fb-24bpp-s3c64xx.c
+++ b/arch/arm/mach-s3c/setup-fb-24bpp-s3c64xx.c
@@ -12,9 +12,9 @@
 #include <linux/fb.h>
 #include <linux/gpio.h>
 
-#include <plat/fb.h>
-#include <plat/gpio-cfg.h>
-#include <mach/gpio-samsung.h>
+#include "fb.h"
+#include "gpio-cfg.h"
+#include "gpio-samsung.h"
 
 void s3c64xx_fb_gpio_setup_24bpp(void)
 {
diff --git a/arch/arm/mach-s3c/setup-i2c-s3c24xx.c b/arch/arm/mach-s3c/setup-i2c-s3c24xx.c
index 1be5372e0261..0d88366b234c 100644
--- a/arch/arm/mach-s3c/setup-i2c-s3c24xx.c
+++ b/arch/arm/mach-s3c/setup-i2c-s3c24xx.c
@@ -10,10 +10,11 @@
 
 struct platform_device;
 
-#include <plat/gpio-cfg.h>
 #include <linux/platform_data/i2c-s3c2410.h>
-#include <mach/regs-gpio.h>
-#include <mach/gpio-samsung.h>
+
+#include "gpio-cfg.h"
+#include "regs-gpio.h"
+#include "gpio-samsung.h"
 
 void s3c_i2c0_cfg_gpio(struct platform_device *dev)
 {
diff --git a/arch/arm/mach-s3c/setup-i2c0-s3c64xx.c b/arch/arm/mach-s3c/setup-i2c0-s3c64xx.c
index 552eb50da38c..a6ef8d2bc995 100644
--- a/arch/arm/mach-s3c/setup-i2c0-s3c64xx.c
+++ b/arch/arm/mach-s3c/setup-i2c0-s3c64xx.c
@@ -14,8 +14,8 @@
 struct platform_device; /* don't need the contents */
 
 #include <linux/platform_data/i2c-s3c2410.h>
-#include <plat/gpio-cfg.h>
-#include <mach/gpio-samsung.h>
+#include "gpio-cfg.h"
+#include "gpio-samsung.h"
 
 void s3c_i2c0_cfg_gpio(struct platform_device *dev)
 {
diff --git a/arch/arm/mach-s3c/setup-i2c1-s3c64xx.c b/arch/arm/mach-s3c/setup-i2c1-s3c64xx.c
index d231f0fc508d..0fe37363d26e 100644
--- a/arch/arm/mach-s3c/setup-i2c1-s3c64xx.c
+++ b/arch/arm/mach-s3c/setup-i2c1-s3c64xx.c
@@ -14,8 +14,8 @@
 struct platform_device; /* don't need the contents */
 
 #include <linux/platform_data/i2c-s3c2410.h>
-#include <plat/gpio-cfg.h>
-#include <mach/gpio-samsung.h>
+#include "gpio-cfg.h"
+#include "gpio-samsung.h"
 
 void s3c_i2c1_cfg_gpio(struct platform_device *dev)
 {
diff --git a/arch/arm/mach-s3c/setup-ide-s3c64xx.c b/arch/arm/mach-s3c/setup-ide-s3c64xx.c
index 810139a807ce..f11f2b02e49f 100644
--- a/arch/arm/mach-s3c/setup-ide-s3c64xx.c
+++ b/arch/arm/mach-s3c/setup-ide-s3c64xx.c
@@ -9,12 +9,13 @@
 #include <linux/gpio.h>
 #include <linux/io.h>
 
-#include <mach/map.h>
-#include <mach/regs-clock.h>
-#include <plat/gpio-cfg.h>
-#include <mach/gpio-samsung.h>
 #include <linux/platform_data/ata-samsung_cf.h>
 
+#include "map.h"
+#include "regs-clock.h"
+#include "gpio-cfg.h"
+#include "gpio-samsung.h"
+
 void s3c64xx_ide_setup_gpio(void)
 {
 	u32 reg;
diff --git a/arch/arm/mach-s3c/setup-keypad-s3c64xx.c b/arch/arm/mach-s3c/setup-keypad-s3c64xx.c
index 351961025273..8463ad37c6ab 100644
--- a/arch/arm/mach-s3c/setup-keypad-s3c64xx.c
+++ b/arch/arm/mach-s3c/setup-keypad-s3c64xx.c
@@ -6,9 +6,9 @@
 // GPIO configuration for S3C64XX KeyPad device
 
 #include <linux/gpio.h>
-#include <plat/gpio-cfg.h>
-#include <plat/keypad.h>
-#include <mach/gpio-samsung.h>
+#include "gpio-cfg.h"
+#include "keypad.h"
+#include "gpio-samsung.h"
 
 void samsung_keypad_cfg_gpio(unsigned int rows, unsigned int cols)
 {
diff --git a/arch/arm/mach-s3c/setup-sdhci-gpio-s3c24xx.c b/arch/arm/mach-s3c/setup-sdhci-gpio-s3c24xx.c
index ff5c0a51ded5..02131b3a731d 100644
--- a/arch/arm/mach-s3c/setup-sdhci-gpio-s3c24xx.c
+++ b/arch/arm/mach-s3c/setup-sdhci-gpio-s3c24xx.c
@@ -14,10 +14,10 @@
 #include <linux/io.h>
 #include <linux/gpio.h>
 
-#include <mach/regs-gpio.h>
-#include <mach/gpio-samsung.h>
-#include <plat/gpio-cfg.h>
-#include <plat/sdhci.h>
+#include "regs-gpio.h"
+#include "gpio-samsung.h"
+#include "gpio-cfg.h"
+#include "sdhci.h"
 
 void s3c2416_setup_sdhci0_cfg_gpio(struct platform_device *dev, int width)
 {
diff --git a/arch/arm/mach-s3c/setup-sdhci-gpio-s3c64xx.c b/arch/arm/mach-s3c/setup-sdhci-gpio-s3c64xx.c
index 138455af4937..646ff949acd5 100644
--- a/arch/arm/mach-s3c/setup-sdhci-gpio-s3c64xx.c
+++ b/arch/arm/mach-s3c/setup-sdhci-gpio-s3c64xx.c
@@ -13,9 +13,9 @@
 #include <linux/io.h>
 #include <linux/gpio.h>
 
-#include <plat/gpio-cfg.h>
-#include <plat/sdhci.h>
-#include <mach/gpio-samsung.h>
+#include "gpio-cfg.h"
+#include "sdhci.h"
+#include "gpio-samsung.h"
 
 void s3c64xx_setup_sdhci0_cfg_gpio(struct platform_device *dev, int width)
 {
diff --git a/arch/arm/mach-s3c/setup-spi-s3c24xx.c b/arch/arm/mach-s3c/setup-spi-s3c24xx.c
index c8b897cbc7ce..93fa1bbc9d5c 100644
--- a/arch/arm/mach-s3c/setup-spi-s3c24xx.c
+++ b/arch/arm/mach-s3c/setup-spi-s3c24xx.c
@@ -8,10 +8,10 @@
 #include <linux/gpio.h>
 #include <linux/platform_device.h>
 
-#include <plat/gpio-cfg.h>
+#include "gpio-cfg.h"
 
-#include <mach/hardware-s3c24xx.h>
-#include <mach/regs-gpio.h>
+#include "hardware-s3c24xx.h"
+#include "regs-gpio.h"
 
 #ifdef CONFIG_S3C64XX_DEV_SPI0
 int s3c64xx_spi0_cfg_gpio(void)
diff --git a/arch/arm/mach-s3c/setup-spi-s3c64xx.c b/arch/arm/mach-s3c/setup-spi-s3c64xx.c
index 03c9d296bb0f..efcf78d41585 100644
--- a/arch/arm/mach-s3c/setup-spi-s3c64xx.c
+++ b/arch/arm/mach-s3c/setup-spi-s3c64xx.c
@@ -5,8 +5,8 @@
 
 #include <linux/gpio.h>
 #include <linux/platform_data/spi-s3c64xx.h>
-#include <plat/gpio-cfg.h>
-#include <mach/gpio-samsung.h>
+#include "gpio-cfg.h"
+#include "gpio-samsung.h"
 
 #ifdef CONFIG_S3C64XX_DEV_SPI0
 int s3c64xx_spi0_cfg_gpio(void)
diff --git a/arch/arm/mach-s3c/setup-ts-s3c24xx.c b/arch/arm/mach-s3c/setup-ts-s3c24xx.c
index 65ec67e0759f..57363eaeb7e8 100644
--- a/arch/arm/mach-s3c/setup-ts-s3c24xx.c
+++ b/arch/arm/mach-s3c/setup-ts-s3c24xx.c
@@ -12,8 +12,8 @@ struct platform_device; /* don't need the contents */
 
 #include <linux/platform_data/touchscreen-s3c2410.h>
 
-#include <plat/gpio-cfg.h>
-#include <mach/gpio-samsung.h>
+#include "gpio-cfg.h"
+#include "gpio-samsung.h"
 
 /**
  * s3c24xx_ts_cfg_gpio - configure gpio for s3c2410 systems
diff --git a/arch/arm/mach-s3c/setup-usb-phy-s3c64xx.c b/arch/arm/mach-s3c/setup-usb-phy-s3c64xx.c
index 3a0e589bd8a1..f3f6ab55d9d2 100644
--- a/arch/arm/mach-s3c/setup-usb-phy-s3c64xx.c
+++ b/arch/arm/mach-s3c/setup-usb-phy-s3c64xx.c
@@ -8,9 +8,9 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
-#include <mach/map.h>
-#include <plat/cpu.h>
-#include <plat/usb-phy.h>
+#include "map.h"
+#include "cpu.h"
+#include "usb-phy.h"
 
 #include "regs-sys-s3c64xx.h"
 #include "regs-usb-hsotg-phy-s3c64xx.h"
diff --git a/arch/arm/mach-s3c/simtec-audio.c b/arch/arm/mach-s3c/simtec-audio.c
index af87261e6a59..487485bcc2ab 100644
--- a/arch/arm/mach-s3c/simtec-audio.c
+++ b/arch/arm/mach-s3c/simtec-audio.c
@@ -12,12 +12,12 @@
 #include <linux/device.h>
 #include <linux/io.h>
 
-#include <mach/regs-gpio.h>
-#include <mach/gpio-samsung.h>
-#include <plat/gpio-cfg.h>
+#include "regs-gpio.h"
+#include "gpio-samsung.h"
+#include "gpio-cfg.h"
 
 #include <linux/platform_data/asoc-s3c24xx_simtec.h>
-#include <plat/devs.h>
+#include "devs.h"
 
 #include "bast.h"
 #include "simtec.h"
diff --git a/arch/arm/mach-s3c/simtec-nor.c b/arch/arm/mach-s3c/simtec-nor.c
index 26b18497e959..a6fba056a747 100644
--- a/arch/arm/mach-s3c/simtec-nor.c
+++ b/arch/arm/mach-s3c/simtec-nor.c
@@ -21,7 +21,7 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
-#include <mach/map.h>
+#include "map.h"
 
 #include "bast.h"
 #include "simtec.h"
diff --git a/arch/arm/mach-s3c/simtec-pm.c b/arch/arm/mach-s3c/simtec-pm.c
index 4d8248763eb6..490256a766e2 100644
--- a/arch/arm/mach-s3c/simtec-pm.c
+++ b/arch/arm/mach-s3c/simtec-pm.c
@@ -19,12 +19,12 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/map.h>
-#include <mach/regs-gpio.h>
+#include "map.h"
+#include "regs-gpio.h"
 
 #include <asm/mach-types.h>
 
-#include <plat/pm.h>
+#include "pm.h"
 
 #include "regs-mem-s3c24xx.h"
 
diff --git a/arch/arm/mach-s3c/simtec-usb.c b/arch/arm/mach-s3c/simtec-usb.c
index 693a2a9a7349..18fe0642743a 100644
--- a/arch/arm/mach-s3c/simtec-usb.c
+++ b/arch/arm/mach-s3c/simtec-usb.c
@@ -23,12 +23,12 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
-#include <mach/gpio-samsung.h>
+#include "gpio-samsung.h"
 #include <mach/irqs.h>
 #include <asm/irq.h>
 
 #include <linux/platform_data/usb-ohci-s3c2410.h>
-#include <plat/devs.h>
+#include "devs.h"
 
 #include "bast.h"
 #include "simtec.h"
diff --git a/arch/arm/mach-s3c/sleep-s3c2410.S b/arch/arm/mach-s3c/sleep-s3c2410.S
index 0340297596e9..04aded98782b 100644
--- a/arch/arm/mach-s3c/sleep-s3c2410.S
+++ b/arch/arm/mach-s3c/sleep-s3c2410.S
@@ -13,10 +13,10 @@
 #include <linux/linkage.h>
 #include <linux/serial_s3c.h>
 #include <asm/assembler.h>
-#include <mach/map.h>
+#include "map.h"
 
-#include <mach/regs-gpio.h>
-#include <mach/regs-clock.h>
+#include "regs-gpio.h"
+#include "regs-clock.h"
 
 #include "regs-mem-s3c24xx.h"
 
diff --git a/arch/arm/mach-s3c/sleep-s3c2412.S b/arch/arm/mach-s3c/sleep-s3c2412.S
index 434f5082b2ed..b4b61737fbb2 100644
--- a/arch/arm/mach-s3c/sleep-s3c2412.S
+++ b/arch/arm/mach-s3c/sleep-s3c2412.S
@@ -8,9 +8,9 @@
 
 #include <linux/linkage.h>
 #include <asm/assembler.h>
-#include <mach/map.h>
+#include "map.h"
 
-#include <mach/regs-irq.h>
+#include "regs-irq.h"
 
 	.text
 
diff --git a/arch/arm/mach-s3c/sleep-s3c24xx.S b/arch/arm/mach-s3c/sleep-s3c24xx.S
index 4bda4a413584..4b2af91f3dce 100644
--- a/arch/arm/mach-s3c/sleep-s3c24xx.S
+++ b/arch/arm/mach-s3c/sleep-s3c24xx.S
@@ -13,10 +13,10 @@
 #include <linux/linkage.h>
 #include <linux/serial_s3c.h>
 #include <asm/assembler.h>
-#include <mach/map.h>
+#include "map.h"
 
-#include <mach/regs-gpio.h>
-#include <mach/regs-clock.h>
+#include "regs-gpio.h"
+#include "regs-clock.h"
 
 /*
  * S3C24XX_DEBUG_RESUME is dangerous if your bootloader does not
diff --git a/arch/arm/mach-s3c/sleep-s3c64xx.S b/arch/arm/mach-s3c/sleep-s3c64xx.S
index 39e16a07a5e4..739e53fbce09 100644
--- a/arch/arm/mach-s3c/sleep-s3c64xx.S
+++ b/arch/arm/mach-s3c/sleep-s3c64xx.S
@@ -11,12 +11,12 @@
 
 #include <linux/linkage.h>
 #include <asm/assembler.h>
-#include <mach/map.h>
+#include "map.h"
 
 #undef S3C64XX_VA_GPIO
 #define S3C64XX_VA_GPIO (0x0)
 
-#include <mach/regs-gpio.h>
+#include "regs-gpio.h"
 
 #define LL_UART (S3C_PA_UART + (0x400 * CONFIG_S3C_LOWLEVEL_UART_PORT))
 
diff --git a/arch/arm/mach-s3c/include/plat/usb-phy.h b/arch/arm/mach-s3c/usb-phy.h
similarity index 100%
rename from arch/arm/mach-s3c/include/plat/usb-phy.h
rename to arch/arm/mach-s3c/usb-phy.h
diff --git a/arch/arm/mach-s3c/wakeup-mask.c b/arch/arm/mach-s3c/wakeup-mask.c
index 24f96fb80738..b490e7527c66 100644
--- a/arch/arm/mach-s3c/wakeup-mask.c
+++ b/arch/arm/mach-s3c/wakeup-mask.c
@@ -11,8 +11,8 @@
 #include <linux/irq.h>
 #include <linux/io.h>
 
-#include <plat/wakeup-mask.h>
-#include <plat/pm.h>
+#include "wakeup-mask.h"
+#include "pm.h"
 
 void samsung_sync_wakemask(void __iomem *reg,
 			   const struct samsung_wakeup_mask *mask, int nr_mask)
diff --git a/arch/arm/mach-s3c/include/plat/wakeup-mask.h b/arch/arm/mach-s3c/wakeup-mask.h
similarity index 100%
rename from arch/arm/mach-s3c/include/plat/wakeup-mask.h
rename to arch/arm/mach-s3c/wakeup-mask.h
-- 
2.17.1

