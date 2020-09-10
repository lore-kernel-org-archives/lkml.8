Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B892C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 15:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBBAD2087C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 15:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599752853;
	bh=7/GQtbMpBvk6Kn5kVES74TXZCExnH/I5HKULKqYnLN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FrDrC3NNaS2jatxFe1ZgK1LGecblWdUwajgPxMrJZqrcimfgCMJjAmMCwn/8w9CUB
	 ltJoSkbjKY5cOxhhRuZu6vhuEIs2Y+wXdf605zeXnI/xTARIDClzASzjTVR9viWotU
	 tGr57haauNnIkEv+rGczNVx7vZF2zcMioImqC0K0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731368AbgIJPqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 11:46:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:40746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731270AbgIJPmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 11:42:09 -0400
Received: from localhost.localdomain (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFA5F208E4;
        Thu, 10 Sep 2020 15:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599752523;
        bh=7/GQtbMpBvk6Kn5kVES74TXZCExnH/I5HKULKqYnLN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IhMKY788JI2IUOnBRk7ru2o8BXRFF6mZfMJRWw70ZFAqd/2nytaObkY3yNCLDFTJN
         r1GnWi5wCPTc1vTgqebn4bxa4xVgx644flY2CsSCzz9Yaj6Bq7TbKu1FETsrRnuB3M
         opuUNXP1W0hAmmFQy7ZBnGp4CyxS57LRsA1zEYEM=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Tomasz Figa <t.figa@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/2] ARM: s3c24xx: fix Wunused-variable warning on !MMU
Date:   Thu, 10 Sep 2020 17:41:50 +0200
Message-Id: <20200910154150.3318-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200910154150.3318-1-krzk@kernel.org>
References: <20200910154150.3318-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If S3C24xx machine code is build without CONFIG_MMU, the iotable()
macros do nothing so annotate structures to get rid of warnings:

  arch/arm/mach-s3c24xx/common.c:140:24: warning: ‘s3c_iodesc’ defined but not used [-Wunused-variable]
  arch/arm/mach-s3c24xx/s3c2410.c:49:24: warning: ‘s3c2410_iodesc’ defined but not used [-Wunused-variable]
  arch/arm/mach-s3c24xx/s3c2412.c:60:24: warning: ‘s3c2412_iodesc’ defined but not used [-Wunused-variable]
  arch/arm/mach-s3c24xx/s3c2416.c:54:24: warning: ‘s3c2416_iodesc’ defined but not used [-Wunused-variable]
  arch/arm/mach-s3c24xx/s3c2443.c:45:24: warning: ‘s3c2443_iodesc’ defined but not used [-Wunused-variable]
  arch/arm/mach-s3c24xx/s3c244x.c:44:24: warning: ‘s3c244x_iodesc’ defined but not used [-Wunused-variable]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/mach-s3c24xx/common.c  | 2 +-
 arch/arm/mach-s3c24xx/s3c2410.c | 2 +-
 arch/arm/mach-s3c24xx/s3c2412.c | 2 +-
 arch/arm/mach-s3c24xx/s3c2416.c | 2 +-
 arch/arm/mach-s3c24xx/s3c2443.c | 2 +-
 arch/arm/mach-s3c24xx/s3c244x.c | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/common.c b/arch/arm/mach-s3c24xx/common.c
index 3dc029c2d2cb..1ec8fe20684c 100644
--- a/arch/arm/mach-s3c24xx/common.c
+++ b/arch/arm/mach-s3c24xx/common.c
@@ -137,7 +137,7 @@ static struct cpu_table cpu_ids[] __initdata = {
 
 /* minimal IO mapping */
 
-static struct map_desc s3c_iodesc[] __initdata = {
+static struct map_desc s3c_iodesc[] __initdata __maybe_unused = {
 	IODESC_ENT(GPIO),
 	IODESC_ENT(IRQ),
 	IODESC_ENT(MEMCTRL),
diff --git a/arch/arm/mach-s3c24xx/s3c2410.c b/arch/arm/mach-s3c24xx/s3c2410.c
index 21fd5404bc98..ed498835ce13 100644
--- a/arch/arm/mach-s3c24xx/s3c2410.c
+++ b/arch/arm/mach-s3c24xx/s3c2410.c
@@ -46,7 +46,7 @@
 
 /* Initial IO mappings */
 
-static struct map_desc s3c2410_iodesc[] __initdata = {
+static struct map_desc s3c2410_iodesc[] __initdata __maybe_unused = {
 	IODESC_ENT(CLKPWR),
 	IODESC_ENT(TIMER),
 	IODESC_ENT(WATCHDOG),
diff --git a/arch/arm/mach-s3c24xx/s3c2412.c b/arch/arm/mach-s3c24xx/s3c2412.c
index 8fe4d4670dcb..d1ea1cab86e7 100644
--- a/arch/arm/mach-s3c24xx/s3c2412.c
+++ b/arch/arm/mach-s3c24xx/s3c2412.c
@@ -57,7 +57,7 @@ static inline void s3c2412_init_gpio2(void)
 
 /* Initial IO mappings */
 
-static struct map_desc s3c2412_iodesc[] __initdata = {
+static struct map_desc s3c2412_iodesc[] __initdata __maybe_unused = {
 	IODESC_ENT(CLKPWR),
 	IODESC_ENT(TIMER),
 	IODESC_ENT(WATCHDOG),
diff --git a/arch/arm/mach-s3c24xx/s3c2416.c b/arch/arm/mach-s3c24xx/s3c2416.c
index 9514196cad8c..17157f063264 100644
--- a/arch/arm/mach-s3c24xx/s3c2416.c
+++ b/arch/arm/mach-s3c24xx/s3c2416.c
@@ -51,7 +51,7 @@
 #include "nand-core.h"
 #include "spi-core.h"
 
-static struct map_desc s3c2416_iodesc[] __initdata = {
+static struct map_desc s3c2416_iodesc[] __initdata __maybe_unused = {
 	IODESC_ENT(WATCHDOG),
 	IODESC_ENT(CLKPWR),
 	IODESC_ENT(TIMER),
diff --git a/arch/arm/mach-s3c24xx/s3c2443.c b/arch/arm/mach-s3c24xx/s3c2443.c
index 4cbeb74cf3d6..2afeb53a48d1 100644
--- a/arch/arm/mach-s3c24xx/s3c2443.c
+++ b/arch/arm/mach-s3c24xx/s3c2443.c
@@ -42,7 +42,7 @@
 #include "nand-core.h"
 #include "spi-core.h"
 
-static struct map_desc s3c2443_iodesc[] __initdata = {
+static struct map_desc s3c2443_iodesc[] __initdata __maybe_unused = {
 	IODESC_ENT(WATCHDOG),
 	IODESC_ENT(CLKPWR),
 	IODESC_ENT(TIMER),
diff --git a/arch/arm/mach-s3c24xx/s3c244x.c b/arch/arm/mach-s3c24xx/s3c244x.c
index a75f588b9d45..4439cfb1d049 100644
--- a/arch/arm/mach-s3c24xx/s3c244x.c
+++ b/arch/arm/mach-s3c24xx/s3c244x.c
@@ -41,7 +41,7 @@
 #include "nand-core.h"
 #include "regs-dsc.h"
 
-static struct map_desc s3c244x_iodesc[] __initdata = {
+static struct map_desc s3c244x_iodesc[] __initdata __maybe_unused = {
 	IODESC_ENT(CLKPWR),
 	IODESC_ENT(TIMER),
 	IODESC_ENT(WATCHDOG),
-- 
2.17.1

