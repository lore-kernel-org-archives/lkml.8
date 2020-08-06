Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43DAC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5A5B22CAF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596739073;
	bh=Pet8usq6vLkfnEHsRK3Hoaw0sEG6UxMvBQ2LZDWxbX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H6ulcg1FJxGi+XFvxaBncsS2wjKknz2vo4OnuA8H4mj07rGMNTnrZY+Mc1nj1Gfs8
	 o9wx6ut9O+8nG4XsXgWRTM76/kwE8zOHzSfTZ0p3t0SRRFJcUXYjosIILm8bEVBEar
	 Z4ewNKyLnHpNoGM3QU4AtqvBpk5sr7bqKUlFcr/I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729707AbgHFShu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 14:37:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:58934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728923AbgHFSf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 14:35:58 -0400
Received: from localhost.localdomain (unknown [194.230.155.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F05C022DFB;
        Thu,  6 Aug 2020 18:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596738235;
        bh=Pet8usq6vLkfnEHsRK3Hoaw0sEG6UxMvBQ2LZDWxbX0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sNZ8uaLTB8z7OBL1r9fze2clYnyHVuQpkCzQwikVT/fhc1Ss3R/g6hspvDb7cpf9y
         qza6LVvffD+IIkKD/ln2C6v98BLiFwTmWArYvzgWGIvHQuPkep+8qYJipkEKsv0xtl
         ISl0iwwBcUvI8aq3AX1ourJu7enNTENDFoOTmIEM=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 30/41] ARM: s3c24xx: include mach/irqs.h where needed
Date:   Thu,  6 Aug 2020 20:20:47 +0200
Message-Id: <20200806182059.2431-30-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806181932.2253-1-krzk@kernel.org>
References: <20200806181932.2253-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Preparing for a later conversion to sparse IRQs, this ensures that
the mach/irqs.h header is still visible in files that reference
an IRQ number.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/mach-s3c24xx/bast-ide.c    | 1 +
 arch/arm/mach-s3c24xx/bast-irq.c    | 1 +
 arch/arm/mach-s3c24xx/common.h      | 1 +
 arch/arm/mach-s3c24xx/irq-s3c24xx.c | 1 +
 arch/arm/mach-s3c24xx/pm-s3c2412.c  | 1 +
 arch/arm/mach-s3c24xx/s3c2443.c     | 1 +
 arch/arm/mach-s3c24xx/simtec-usb.c  | 1 +
 7 files changed, 7 insertions(+)

diff --git a/arch/arm/mach-s3c24xx/bast-ide.c b/arch/arm/mach-s3c24xx/bast-ide.c
index 067944398f46..ee6fbb407640 100644
--- a/arch/arm/mach-s3c24xx/bast-ide.c
+++ b/arch/arm/mach-s3c24xx/bast-ide.c
@@ -20,6 +20,7 @@
 #include <asm/mach/irq.h>
 
 #include <mach/map.h>
+#include <mach/irqs.h>
 
 #include "bast.h"
 
diff --git a/arch/arm/mach-s3c24xx/bast-irq.c b/arch/arm/mach-s3c24xx/bast-irq.c
index 03209fefa5db..a6db5e2c910c 100644
--- a/arch/arm/mach-s3c24xx/bast-irq.c
+++ b/arch/arm/mach-s3c24xx/bast-irq.c
@@ -16,6 +16,7 @@
 #include <asm/mach/irq.h>
 
 #include <mach/regs-irq.h>
+#include <mach/irqs.h>
 
 #include "bast.h"
 
diff --git a/arch/arm/mach-s3c24xx/common.h b/arch/arm/mach-s3c24xx/common.h
index 8d2e2c6ae7eb..86826cafa15d 100644
--- a/arch/arm/mach-s3c24xx/common.h
+++ b/arch/arm/mach-s3c24xx/common.h
@@ -10,6 +10,7 @@
 #define __ARCH_ARM_MACH_S3C24XX_COMMON_H __FILE__
 
 #include <linux/reboot.h>
+#include <mach/irqs.h>
 
 struct s3c2410_uartcfg;
 
diff --git a/arch/arm/mach-s3c24xx/irq-s3c24xx.c b/arch/arm/mach-s3c24xx/irq-s3c24xx.c
index d2031fecc386..b0e879ee14c1 100644
--- a/arch/arm/mach-s3c24xx/irq-s3c24xx.c
+++ b/arch/arm/mach-s3c24xx/irq-s3c24xx.c
@@ -25,6 +25,7 @@
 #include <asm/exception.h>
 #include <asm/mach/irq.h>
 
+#include <mach/irqs.h>
 #include <mach/regs-irq.h>
 #include <mach/regs-gpio.h>
 
diff --git a/arch/arm/mach-s3c24xx/pm-s3c2412.c b/arch/arm/mach-s3c24xx/pm-s3c2412.c
index b1d0ad07301b..2779d67d2c07 100644
--- a/arch/arm/mach-s3c24xx/pm-s3c2412.c
+++ b/arch/arm/mach-s3c24xx/pm-s3c2412.c
@@ -19,6 +19,7 @@
 #include <asm/cacheflush.h>
 #include <asm/irq.h>
 
+#include <mach/irqs.h>
 #include <mach/regs-gpio.h>
 
 #include <plat/cpu.h>
diff --git a/arch/arm/mach-s3c24xx/s3c2443.c b/arch/arm/mach-s3c24xx/s3c2443.c
index c278cfc10ba5..3c05d04bbbeb 100644
--- a/arch/arm/mach-s3c24xx/s3c2443.c
+++ b/arch/arm/mach-s3c24xx/s3c2443.c
@@ -25,6 +25,7 @@
 
 #include <mach/hardware.h>
 #include <mach/gpio-samsung.h>
+#include <mach/irqs.h>
 #include <asm/irq.h>
 #include <asm/system_misc.h>
 
diff --git a/arch/arm/mach-s3c24xx/simtec-usb.c b/arch/arm/mach-s3c24xx/simtec-usb.c
index 3488988316a8..693a2a9a7349 100644
--- a/arch/arm/mach-s3c24xx/simtec-usb.c
+++ b/arch/arm/mach-s3c24xx/simtec-usb.c
@@ -24,6 +24,7 @@
 #include <asm/mach/irq.h>
 
 #include <mach/gpio-samsung.h>
+#include <mach/irqs.h>
 #include <asm/irq.h>
 
 #include <linux/platform_data/usb-ohci-s3c2410.h>
-- 
2.17.1

