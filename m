Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD603C433E3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC8A522C9F
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596739069;
	bh=lU5wNn/T9PmwblR4OUI1J7Lrz/yR8NVfa8Ry3YJWFwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I57l1lnJUa03SOOu/Jk8EZCXXy67bAz+bX1Vz8yApGoLGMmlEiWbQeOuzwlP1DGCU
	 f2nXUpDXT6esQlcu33JQto5D7oxqRsuw5nBZcYC8KuR0W+wAIduDF3GJMlG8W2OWih
	 lkPOjdJGTQpTpxsH0z323X3YAOhhTvjgBzCkg5P8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729692AbgHFShr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 14:37:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:58936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728935AbgHFSf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 14:35:58 -0400
Received: from localhost.localdomain (unknown [194.230.155.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D81F22CE3;
        Thu,  6 Aug 2020 18:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596738176;
        bh=lU5wNn/T9PmwblR4OUI1J7Lrz/yR8NVfa8Ry3YJWFwQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2CkLjH1W6F26DkdSLwSedU1vIjnnjDrR3jFSKAOn3jiYv5qhJzJb5IL00vTAcBFWr
         i2VPDnZGE84wG8GJYdwLd3CVGXta3qSoS5aKbL46Y9IqUmleVAqPH1neNdkw7kR9N0
         SWcWUrarZ4rqSDEogsdgJK6OyMBAihDa4woY0v5Y=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 19/41] ARM: s3c64xx: remove mach/hardware.h
Date:   Thu,  6 Aug 2020 20:20:36 +0200
Message-Id: <20200806182059.2431-19-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806181932.2253-1-krzk@kernel.org>
References: <20200806181932.2253-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

This header is empty and conflicts with the s3c24xx version
of the same file when we merge the two, so stop including it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/mach-s3c64xx/common.c                |  1 -
 arch/arm/mach-s3c64xx/dev-uart.c              |  1 -
 arch/arm/mach-s3c64xx/include/mach/hardware.h | 17 -----------------
 arch/arm/mach-s3c64xx/mach-anw6410.c          |  1 -
 arch/arm/mach-s3c64xx/mach-crag6410.c         |  1 -
 arch/arm/mach-s3c64xx/mach-hmt.c              |  1 -
 arch/arm/mach-s3c64xx/mach-ncp.c              |  1 -
 arch/arm/mach-s3c64xx/mach-smdk6400.c         |  1 -
 arch/arm/mach-s3c64xx/mach-smdk6410.c         |  1 -
 arch/arm/mach-s3c64xx/s3c6400.c               |  1 -
 arch/arm/mach-s3c64xx/s3c6410.c               |  1 -
 11 files changed, 27 deletions(-)
 delete mode 100644 arch/arm/mach-s3c64xx/include/mach/hardware.h

diff --git a/arch/arm/mach-s3c64xx/common.c b/arch/arm/mach-s3c64xx/common.c
index c9c20256488b..efda4bfb7948 100644
--- a/arch/arm/mach-s3c64xx/common.c
+++ b/arch/arm/mach-s3c64xx/common.c
@@ -37,7 +37,6 @@
 
 #include <mach/map.h>
 #include <mach/irqs.h>
-#include <mach/hardware.h>
 #include <mach/regs-gpio.h>
 #include <mach/gpio-samsung.h>
 
diff --git a/arch/arm/mach-s3c64xx/dev-uart.c b/arch/arm/mach-s3c64xx/dev-uart.c
index 5fb59ad30008..021a2b7926fa 100644
--- a/arch/arm/mach-s3c64xx/dev-uart.c
+++ b/arch/arm/mach-s3c64xx/dev-uart.c
@@ -15,7 +15,6 @@
 
 #include <asm/mach/arch.h>
 #include <asm/mach/irq.h>
-#include <mach/hardware.h>
 #include <mach/map.h>
 #include <mach/irqs.h>
 
diff --git a/arch/arm/mach-s3c64xx/include/mach/hardware.h b/arch/arm/mach-s3c64xx/include/mach/hardware.h
deleted file mode 100644
index c4ed359474de..000000000000
--- a/arch/arm/mach-s3c64xx/include/mach/hardware.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* linux/arch/arm/mach-s3c6400/include/mach/hardware.h
- *
- * Copyright 2008 Openmoko, Inc.
- * Copyright 2008 Simtec Electronics
- *      Ben Dooks <ben@simtec.co.uk>
- *      http://armlinux.simtec.co.uk/
- *
- * S3C6400 - Hardware support
- */
-
-#ifndef __ASM_ARCH_HARDWARE_H
-#define __ASM_ARCH_HARDWARE_H __FILE__
-
-/* currently nothing here, placeholder */
-
-#endif /* __ASM_ARCH_IRQ_H */
diff --git a/arch/arm/mach-s3c64xx/mach-anw6410.c b/arch/arm/mach-s3c64xx/mach-anw6410.c
index e783f5b3593a..bb248b12e308 100644
--- a/arch/arm/mach-s3c64xx/mach-anw6410.c
+++ b/arch/arm/mach-s3c64xx/mach-anw6410.c
@@ -30,7 +30,6 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
-#include <mach/hardware.h>
 #include <mach/map.h>
 
 #include <asm/irq.h>
diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
index 223a3d51d8b6..a2fefb2609e7 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
@@ -44,7 +44,6 @@
 #include <asm/mach-types.h>
 
 #include <video/samsung_fimd.h>
-#include <mach/hardware.h>
 #include <mach/map.h>
 #include <mach/regs-gpio.h>
 #include <mach/gpio-samsung.h>
diff --git a/arch/arm/mach-s3c64xx/mach-hmt.c b/arch/arm/mach-s3c64xx/mach-hmt.c
index ad15260c12b4..32b555a4757b 100644
--- a/arch/arm/mach-s3c64xx/mach-hmt.c
+++ b/arch/arm/mach-s3c64xx/mach-hmt.c
@@ -25,7 +25,6 @@
 #include <asm/mach/irq.h>
 
 #include <video/samsung_fimd.h>
-#include <mach/hardware.h>
 #include <mach/map.h>
 #include <mach/irqs.h>
 
diff --git a/arch/arm/mach-s3c64xx/mach-ncp.c b/arch/arm/mach-s3c64xx/mach-ncp.c
index 0a67ff173575..f0a26dd27938 100644
--- a/arch/arm/mach-s3c64xx/mach-ncp.c
+++ b/arch/arm/mach-s3c64xx/mach-ncp.c
@@ -25,7 +25,6 @@
 #include <asm/mach/irq.h>
 
 #include <mach/irqs.h>
-#include <mach/hardware.h>
 #include <mach/map.h>
 
 #include <asm/irq.h>
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6400.c b/arch/arm/mach-s3c64xx/mach-smdk6400.c
index d24899dd3883..ca033450ab8c 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6400.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6400.c
@@ -23,7 +23,6 @@
 #include <asm/mach/irq.h>
 
 #include <mach/irqs.h>
-#include <mach/hardware.h>
 #include <mach/map.h>
 
 #include <plat/devs.h>
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
index 104548fb192a..7b931e7a7913 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
@@ -45,7 +45,6 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
-#include <mach/hardware.h>
 #include <mach/irqs.h>
 #include <mach/map.h>
 
diff --git a/arch/arm/mach-s3c64xx/s3c6400.c b/arch/arm/mach-s3c64xx/s3c6400.c
index 545eea716db8..81233495d548 100644
--- a/arch/arm/mach-s3c64xx/s3c6400.c
+++ b/arch/arm/mach-s3c64xx/s3c6400.c
@@ -26,7 +26,6 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
-#include <mach/hardware.h>
 #include <asm/irq.h>
 
 #include <plat/cpu-freq.h>
diff --git a/arch/arm/mach-s3c64xx/s3c6410.c b/arch/arm/mach-s3c64xx/s3c6410.c
index 47e04e019624..9465a6e0f068 100644
--- a/arch/arm/mach-s3c64xx/s3c6410.c
+++ b/arch/arm/mach-s3c64xx/s3c6410.c
@@ -27,7 +27,6 @@
 #include <asm/mach/map.h>
 #include <asm/mach/irq.h>
 
-#include <mach/hardware.h>
 #include <asm/irq.h>
 
 #include <plat/cpu-freq.h>
-- 
2.17.1

