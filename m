Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EF4C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 20:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDBB1207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 20:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597956141;
	bh=QfRyOWNm0RtO0rWx3dIyzWZvgY2IqUHJrI9e+OmVGC0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=p1wH9vTTYHeJEK29GHwMPdxWZCzJZhjboBvQHAjihc2l8PGKl7L7GldtbRXIQjKhx
	 2nYxOgt3/X7wowm5++gwkFHJtRgZIEWpw5kwuyhjGl12+hbsVRDqxmQVduCUz+zrJB
	 a/hx5fDYUcoc9GVFnsQeSTXa6sDsfs37tWChdIv8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbgHTUmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 16:42:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:57646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726911AbgHTUmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 16:42:17 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 900FE2076E;
        Thu, 20 Aug 2020 20:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597956135;
        bh=QfRyOWNm0RtO0rWx3dIyzWZvgY2IqUHJrI9e+OmVGC0=;
        h=From:To:Cc:Subject:Date:From;
        b=Y71pQRTZsBAEiJTf0QQ3qBJyTPj6R78H8BBXbkB5veoGgqwq7Zc+wgFDEMrw0YA0U
         ClwR9yNoV06/Tkvo8F6WSS3v4FpbJl7HbgJ4hdvNnL2VqsU+bAX+VbeifU59nfFkL7
         iOuL5sANGqdUJLv4GiK/lICmYAkADoQeaeDJ48YY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Simtec Linux Team <linux@simtec.co.uk>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tomasz Figa <tomasz.figa@gmail.com>
Subject: [PATCH] ARM: s3c: Avoid naming clash of S3C24xx and S3C64xx timer setup
Date:   Thu, 20 Aug 2020 22:42:03 +0200
Message-Id: <20200820204203.22328-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PWM timer initialization has two independent implementations - one for
S3C24xx and one for S3C64xx.  The naming however was always the same
and before also the declaration was shared.  This is confusing, error
prone and might cause issues when trying to build multiplatform kernel.

Suggested-by: Tomasz Figa <tomasz.figa@gmail.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/mach-s3c/mach-amlm5900.c   |  4 ++--
 arch/arm/mach-s3c/mach-anubis.c     |  4 ++--
 arch/arm/mach-s3c/mach-anw6410.c    |  4 ++--
 arch/arm/mach-s3c/mach-at2440evb.c  |  4 ++--
 arch/arm/mach-s3c/mach-bast.c       |  4 ++--
 arch/arm/mach-s3c/mach-crag6410.c   |  4 ++--
 arch/arm/mach-s3c/mach-gta02.c      |  4 ++--
 arch/arm/mach-s3c/mach-h1940.c      |  4 ++--
 arch/arm/mach-s3c/mach-hmt.c        |  4 ++--
 arch/arm/mach-s3c/mach-jive.c       |  4 ++--
 arch/arm/mach-s3c/mach-mini2440.c   |  4 ++--
 arch/arm/mach-s3c/mach-mini6410.c   |  4 ++--
 arch/arm/mach-s3c/mach-n30.c        |  4 ++--
 arch/arm/mach-s3c/mach-ncp.c        |  4 ++--
 arch/arm/mach-s3c/mach-nexcoder.c   |  4 ++--
 arch/arm/mach-s3c/mach-osiris.c     |  4 ++--
 arch/arm/mach-s3c/mach-otom.c       |  4 ++--
 arch/arm/mach-s3c/mach-qt2410.c     |  4 ++--
 arch/arm/mach-s3c/mach-real6410.c   |  4 ++--
 arch/arm/mach-s3c/mach-rx1950.c     |  4 ++--
 arch/arm/mach-s3c/mach-rx3715.c     |  4 ++--
 arch/arm/mach-s3c/mach-smartq.c     |  2 +-
 arch/arm/mach-s3c/mach-smartq5.c    |  2 +-
 arch/arm/mach-s3c/mach-smartq7.c    |  2 +-
 arch/arm/mach-s3c/mach-smdk2410.c   |  4 ++--
 arch/arm/mach-s3c/mach-smdk2413.c   |  8 ++++----
 arch/arm/mach-s3c/mach-smdk2416.c   |  4 ++--
 arch/arm/mach-s3c/mach-smdk2440.c   |  4 ++--
 arch/arm/mach-s3c/mach-smdk2443.c   |  4 ++--
 arch/arm/mach-s3c/mach-smdk6400.c   |  4 ++--
 arch/arm/mach-s3c/mach-smdk6410.c   |  4 ++--
 arch/arm/mach-s3c/mach-tct_hammer.c |  4 ++--
 arch/arm/mach-s3c/mach-vr1000.c     |  4 ++--
 arch/arm/mach-s3c/mach-vstms.c      |  4 ++--
 arch/arm/mach-s3c/s3c24xx.c         |  4 ++--
 arch/arm/mach-s3c/s3c24xx.h         | 18 +++++++++---------
 arch/arm/mach-s3c/s3c64xx.c         |  4 ++--
 arch/arm/mach-s3c/s3c64xx.h         | 18 +++++++++---------
 38 files changed, 89 insertions(+), 89 deletions(-)

diff --git a/arch/arm/mach-s3c/mach-amlm5900.c b/arch/arm/mach-s3c/mach-amlm5900.c
index f73a5223663b..94c4512ace17 100644
--- a/arch/arm/mach-s3c/mach-amlm5900.c
+++ b/arch/arm/mach-s3c/mach-amlm5900.c
@@ -153,13 +153,13 @@ static void __init amlm5900_map_io(void)
 {
 	s3c24xx_init_io(amlm5900_iodesc, ARRAY_SIZE(amlm5900_iodesc));
 	s3c24xx_init_uarts(amlm5900_uartcfgs, ARRAY_SIZE(amlm5900_uartcfgs));
-	samsung_set_timer_source(SAMSUNG_PWM3, SAMSUNG_PWM4);
+	s3c24xx_set_timer_source(S3C24XX_PWM3, S3C24XX_PWM4);
 }
 
 static void __init amlm5900_init_time(void)
 {
 	s3c2410_init_clocks(12000000);
-	samsung_timer_init();
+	s3c24xx_timer_init();
 }
 
 #ifdef CONFIG_FB_S3C2410
diff --git a/arch/arm/mach-s3c/mach-anubis.c b/arch/arm/mach-s3c/mach-anubis.c
index 522bb10e8a19..969b74079c8e 100644
--- a/arch/arm/mach-s3c/mach-anubis.c
+++ b/arch/arm/mach-s3c/mach-anubis.c
@@ -381,7 +381,7 @@ static void __init anubis_map_io(void)
 {
 	s3c24xx_init_io(anubis_iodesc, ARRAY_SIZE(anubis_iodesc));
 	s3c24xx_init_uarts(anubis_uartcfgs, ARRAY_SIZE(anubis_uartcfgs));
-	samsung_set_timer_source(SAMSUNG_PWM3, SAMSUNG_PWM4);
+	s3c24xx_set_timer_source(S3C24XX_PWM3, S3C24XX_PWM4);
 
 	/* check for the newer revision boards with large page nand */
 
@@ -400,7 +400,7 @@ static void __init anubis_map_io(void)
 static void __init anubis_init_time(void)
 {
 	s3c2440_init_clocks(12000000);
-	samsung_timer_init();
+	s3c24xx_timer_init();
 }
 
 static void __init anubis_init(void)
diff --git a/arch/arm/mach-s3c/mach-anw6410.c b/arch/arm/mach-s3c/mach-anw6410.c
index b4f08e5c9858..825714e9ac66 100644
--- a/arch/arm/mach-s3c/mach-anw6410.c
+++ b/arch/arm/mach-s3c/mach-anw6410.c
@@ -202,7 +202,7 @@ static void __init anw6410_map_io(void)
 	s3c64xx_init_io(anw6410_iodesc, ARRAY_SIZE(anw6410_iodesc));
 	s3c64xx_set_xtal_freq(12000000);
 	s3c24xx_init_uarts(anw6410_uartcfgs, ARRAY_SIZE(anw6410_uartcfgs));
-	samsung_set_timer_source(SAMSUNG_PWM3, SAMSUNG_PWM4);
+	s3c64xx_set_timer_source(S3C64XX_PWM3, S3C64XX_PWM4);
 
 	anw6410_lcd_mode_set();
 }
@@ -226,5 +226,5 @@ MACHINE_START(ANW6410, "A&W6410")
 	.init_irq	= s3c6410_init_irq,
 	.map_io		= anw6410_map_io,
 	.init_machine	= anw6410_machine_init,
-	.init_time	= samsung_timer_init,
+	.init_time	= s3c64xx_timer_init,
 MACHINE_END
diff --git a/arch/arm/mach-s3c/mach-at2440evb.c b/arch/arm/mach-s3c/mach-at2440evb.c
index 13d014bc8371..18ace34bbb85 100644
--- a/arch/arm/mach-s3c/mach-at2440evb.c
+++ b/arch/arm/mach-s3c/mach-at2440evb.c
@@ -202,13 +202,13 @@ static void __init at2440evb_map_io(void)
 {
 	s3c24xx_init_io(at2440evb_iodesc, ARRAY_SIZE(at2440evb_iodesc));
 	s3c24xx_init_uarts(at2440evb_uartcfgs, ARRAY_SIZE(at2440evb_uartcfgs));
-	samsung_set_timer_source(SAMSUNG_PWM3, SAMSUNG_PWM4);
+	s3c24xx_set_timer_source(S3C24XX_PWM3, S3C24XX_PWM4);
 }
 
 static void __init at2440evb_init_time(void)
 {
 	s3c2440_init_clocks(16934400);
-	samsung_timer_init();
+	s3c24xx_timer_init();
 }
 
 static void __init at2440evb_init(void)
diff --git a/arch/arm/mach-s3c/mach-bast.c b/arch/arm/mach-s3c/mach-bast.c
index 1cb2193256e1..ad3c7e209544 100644
--- a/arch/arm/mach-s3c/mach-bast.c
+++ b/arch/arm/mach-s3c/mach-bast.c
@@ -547,13 +547,13 @@ static void __init bast_map_io(void)
 
 	s3c24xx_init_io(bast_iodesc, ARRAY_SIZE(bast_iodesc));
 	s3c24xx_init_uarts(bast_uartcfgs, ARRAY_SIZE(bast_uartcfgs));
-	samsung_set_timer_source(SAMSUNG_PWM3, SAMSUNG_PWM4);
+	s3c24xx_set_timer_source(S3C24XX_PWM3, S3C24XX_PWM4);
 }
 
 static void __init bast_init_time(void)
 {
 	s3c2410_init_clocks(12000000);
-	samsung_timer_init();
+	s3c24xx_timer_init();
 }
 
 static void __init bast_init(void)
diff --git a/arch/arm/mach-s3c/mach-crag6410.c b/arch/arm/mach-s3c/mach-crag6410.c
index 0bfcb79cc0a6..4a12c75d407f 100644
--- a/arch/arm/mach-s3c/mach-crag6410.c
+++ b/arch/arm/mach-s3c/mach-crag6410.c
@@ -748,7 +748,7 @@ static void __init crag6410_map_io(void)
 	s3c64xx_init_io(NULL, 0);
 	s3c64xx_set_xtal_freq(12000000);
 	s3c24xx_init_uarts(crag6410_uartcfgs, ARRAY_SIZE(crag6410_uartcfgs));
-	samsung_set_timer_source(SAMSUNG_PWM3, SAMSUNG_PWM4);
+	s3c64xx_set_timer_source(S3C64XX_PWM3, S3C64XX_PWM4);
 
 	/* LCD type and Bypass set by bootloader */
 }
@@ -875,5 +875,5 @@ MACHINE_START(WLF_CRAGG_6410, "Wolfson Cragganmore 6410")
 	.init_irq	= s3c6410_init_irq,
 	.map_io		= crag6410_map_io,
 	.init_machine	= crag6410_machine_init,
-	.init_time	= samsung_timer_init,
+	.init_time	= s3c64xx_timer_init,
 MACHINE_END
diff --git a/arch/arm/mach-s3c/mach-gta02.c b/arch/arm/mach-s3c/mach-gta02.c
index 9e5cb05f3ef1..97a52fd6ded6 100644
--- a/arch/arm/mach-s3c/mach-gta02.c
+++ b/arch/arm/mach-s3c/mach-gta02.c
@@ -505,7 +505,7 @@ static void __init gta02_map_io(void)
 {
 	s3c24xx_init_io(gta02_iodesc, ARRAY_SIZE(gta02_iodesc));
 	s3c24xx_init_uarts(gta02_uartcfgs, ARRAY_SIZE(gta02_uartcfgs));
-	samsung_set_timer_source(SAMSUNG_PWM3, SAMSUNG_PWM4);
+	s3c24xx_set_timer_source(S3C24XX_PWM3, S3C24XX_PWM4);
 }
 
 
@@ -567,7 +567,7 @@ static void __init gta02_machine_init(void)
 static void __init gta02_init_time(void)
 {
 	s3c2442_init_clocks(12000000);
-	samsung_timer_init();
+	s3c24xx_timer_init();
 }
 
 MACHINE_START(NEO1973_GTA02, "GTA02")
diff --git a/arch/arm/mach-s3c/mach-h1940.c b/arch/arm/mach-s3c/mach-h1940.c
index da9ac61f7948..53d51aa83200 100644
--- a/arch/arm/mach-s3c/mach-h1940.c
+++ b/arch/arm/mach-s3c/mach-h1940.c
@@ -686,7 +686,7 @@ static void __init h1940_map_io(void)
 {
 	s3c24xx_init_io(h1940_iodesc, ARRAY_SIZE(h1940_iodesc));
 	s3c24xx_init_uarts(h1940_uartcfgs, ARRAY_SIZE(h1940_uartcfgs));
-	samsung_set_timer_source(SAMSUNG_PWM3, SAMSUNG_PWM4);
+	s3c24xx_set_timer_source(S3C24XX_PWM3, S3C24XX_PWM4);
 
 	/* setup PM */
 
@@ -703,7 +703,7 @@ static void __init h1940_map_io(void)
 static void __init h1940_init_time(void)
 {
 	s3c2410_init_clocks(12000000);
-	samsung_timer_init();
+	s3c24xx_timer_init();
 }
 
 /* H1940 and RX3715 need to reserve this for suspend */
diff --git a/arch/arm/mach-s3c/mach-hmt.c b/arch/arm/mach-s3c/mach-hmt.c
index 29510e27f90f..c58cd1fa6981 100644
--- a/arch/arm/mach-s3c/mach-hmt.c
+++ b/arch/arm/mach-s3c/mach-hmt.c
@@ -249,7 +249,7 @@ static void __init hmt_map_io(void)
 	s3c64xx_init_io(hmt_iodesc, ARRAY_SIZE(hmt_iodesc));
 	s3c64xx_set_xtal_freq(12000000);
 	s3c24xx_init_uarts(hmt_uartcfgs, ARRAY_SIZE(hmt_uartcfgs));
-	samsung_set_timer_source(SAMSUNG_PWM3, SAMSUNG_PWM4);
+	s3c64xx_set_timer_source(S3C64XX_PWM3, S3C64XX_PWM4);
 }
 
 static void __init hmt_machine_init(void)
@@ -278,5 +278,5 @@ MACHINE_START(HMT, "Airgoo-HMT")
 	.init_irq	= s3c6410_init_irq,
 	.map_io		= hmt_map_io,
 	.init_machine	= hmt_machine_init,
-	.init_time	= samsung_timer_init,
+	.init_time	= s3c64xx_timer_init,
 MACHINE_END
diff --git a/arch/arm/mach-s3c/mach-jive.c b/arch/arm/mach-s3c/mach-jive.c
index 5c3037bf647d..94b16b2cb1da 100644
--- a/arch/arm/mach-s3c/mach-jive.c
+++ b/arch/arm/mach-s3c/mach-jive.c
@@ -529,13 +529,13 @@ static void __init jive_map_io(void)
 {
 	s3c24xx_init_io(jive_iodesc, ARRAY_SIZE(jive_iodesc));
 	s3c24xx_init_uarts(jive_uartcfgs, ARRAY_SIZE(jive_uartcfgs));
-	samsung_set_timer_source(SAMSUNG_PWM3, SAMSUNG_PWM4);
+	s3c24xx_set_timer_source(S3C24XX_PWM3, S3C24XX_PWM4);
 }
 
 static void __init jive_init_time(void)
 {
 	s3c2412_init_clocks(12000000);
-	samsung_timer_init();
+	s3c24xx_timer_init();
 }
 
 static void jive_power_off(void)
diff --git a/arch/arm/mach-s3c/mach-mini2440.c b/arch/arm/mach-s3c/mach-mini2440.c
index 48e436a2f639..0f4f2a940b5c 100644
--- a/arch/arm/mach-s3c/mach-mini2440.c
+++ b/arch/arm/mach-s3c/mach-mini2440.c
@@ -597,13 +597,13 @@ static void __init mini2440_map_io(void)
 {
 	s3c24xx_init_io(mini2440_iodesc, ARRAY_SIZE(mini2440_iodesc));
 	s3c24xx_init_uarts(mini2440_uartcfgs, ARRAY_SIZE(mini2440_uartcfgs));
-	samsung_set_timer_source(SAMSUNG_PWM3, SAMSUNG_PWM4);
+	s3c24xx_set_timer_source(S3C24XX_PWM3, S3C24XX_PWM4);
 }
 
 static void __init mini2440_init_time(void)
 {
 	s3c2440_init_clocks(12000000);
-	samsung_timer_init();
+	s3c24xx_timer_init();
 }
 
 /*
diff --git a/arch/arm/mach-s3c/mach-mini6410.c b/arch/arm/mach-s3c/mach-mini6410.c
index 1580bb8ee2c7..75f2ec4a2993 100644
--- a/arch/arm/mach-s3c/mach-mini6410.c
+++ b/arch/arm/mach-s3c/mach-mini6410.c
@@ -237,7 +237,7 @@ static void __init mini6410_map_io(void)
 	s3c64xx_init_io(NULL, 0);
 	s3c64xx_set_xtal_freq(12000000);
 	s3c24xx_init_uarts(mini6410_uartcfgs, ARRAY_SIZE(mini6410_uartcfgs));
-	samsung_set_timer_source(SAMSUNG_PWM3, SAMSUNG_PWM4);
+	s3c64xx_set_timer_source(S3C64XX_PWM3, S3C64XX_PWM4);
 
 	/* set the LCD type */
 	tmp = __raw_readl(S3C64XX_SPCON);
@@ -361,5 +361,5 @@ MACHINE_START(MINI6410, "MINI6410")
 	.init_irq	= s3c6410_init_irq,
 	.map_io		= mini6410_map_io,
 	.init_machine	= mini6410_machine_init,
-	.init_time	= samsung_timer_init,
+	.init_time	= s3c64xx_timer_init,
 MACHINE_END
diff --git a/arch/arm/mach-s3c/mach-n30.c b/arch/arm/mach-s3c/mach-n30.c
index 8a9382326d29..e40c1fcf418c 100644
--- a/arch/arm/mach-s3c/mach-n30.c
+++ b/arch/arm/mach-s3c/mach-n30.c
@@ -579,13 +579,13 @@ static void __init n30_map_io(void)
 	s3c24xx_init_io(n30_iodesc, ARRAY_SIZE(n30_iodesc));
 	n30_hwinit();
 	s3c24xx_init_uarts(n30_uartcfgs, ARRAY_SIZE(n30_uartcfgs));
-	samsung_set_timer_source(SAMSUNG_PWM3, SAMSUNG_PWM4);
+	s3c24xx_set_timer_source(S3C24XX_PWM3, S3C24XX_PWM4);
 }
 
 static void __init n30_init_time(void)
 {
 	s3c2410_init_clocks(12000000);
-	samsung_timer_init();
+	s3c24xx_timer_init();
 }
 
 /* GPB3 is the line that controls the pull-up for the USB D+ line */
diff --git a/arch/arm/mach-s3c/mach-ncp.c b/arch/arm/mach-s3c/mach-ncp.c
index 3480ba8184b1..1a45bed56622 100644
--- a/arch/arm/mach-s3c/mach-ncp.c
+++ b/arch/arm/mach-s3c/mach-ncp.c
@@ -79,7 +79,7 @@ static void __init ncp_map_io(void)
 	s3c64xx_init_io(ncp_iodesc, ARRAY_SIZE(ncp_iodesc));
 	s3c64xx_set_xtal_freq(12000000);
 	s3c24xx_init_uarts(ncp_uartcfgs, ARRAY_SIZE(ncp_uartcfgs));
-	samsung_set_timer_source(SAMSUNG_PWM3, SAMSUNG_PWM4);
+	s3c64xx_set_timer_source(S3C64XX_PWM3, S3C64XX_PWM4);
 }
 
 static void __init ncp_machine_init(void)
@@ -96,5 +96,5 @@ MACHINE_START(NCP, "NCP")
 	.init_irq	= s3c6410_init_irq,
 	.map_io		= ncp_map_io,
 	.init_machine	= ncp_machine_init,
-	.init_time	= samsung_timer_init,
+	.init_time	= s3c64xx_timer_init,
 MACHINE_END
diff --git a/arch/arm/mach-s3c/mach-nexcoder.c b/arch/arm/mach-s3c/mach-nexcoder.c
index 7e96c546f359..2a454c919658 100644
--- a/arch/arm/mach-s3c/mach-nexcoder.c
+++ b/arch/arm/mach-s3c/mach-nexcoder.c
@@ -129,7 +129,7 @@ static void __init nexcoder_map_io(void)
 {
 	s3c24xx_init_io(nexcoder_iodesc, ARRAY_SIZE(nexcoder_iodesc));
 	s3c24xx_init_uarts(nexcoder_uartcfgs, ARRAY_SIZE(nexcoder_uartcfgs));
-	samsung_set_timer_source(SAMSUNG_PWM3, SAMSUNG_PWM4);
+	s3c24xx_set_timer_source(S3C24XX_PWM3, S3C24XX_PWM4);
 
 	nexcoder_sensorboard_init();
 }
@@ -137,7 +137,7 @@ static void __init nexcoder_map_io(void)
 static void __init nexcoder_init_time(void)
 {
 	s3c2440_init_clocks(12000000);
-	samsung_timer_init();
+	s3c24xx_timer_init();
 }
 
 static void __init nexcoder_init(void)
diff --git a/arch/arm/mach-s3c/mach-osiris.c b/arch/arm/mach-s3c/mach-osiris.c
index d0675c558d89..4e94683fff3d 100644
--- a/arch/arm/mach-s3c/mach-osiris.c
+++ b/arch/arm/mach-s3c/mach-osiris.c
@@ -356,7 +356,7 @@ static void __init osiris_map_io(void)
 
 	s3c24xx_init_io(osiris_iodesc, ARRAY_SIZE(osiris_iodesc));
 	s3c24xx_init_uarts(osiris_uartcfgs, ARRAY_SIZE(osiris_uartcfgs));
-	samsung_set_timer_source(SAMSUNG_PWM3, SAMSUNG_PWM4);
+	s3c24xx_set_timer_source(S3C24XX_PWM3, S3C24XX_PWM4);
 
 	/* check for the newer revision boards with large page nand */
 
@@ -381,7 +381,7 @@ static void __init osiris_map_io(void)
 static void __init osiris_init_time(void)
 {
 	s3c2440_init_clocks(12000000);
-	samsung_timer_init();
+	s3c24xx_timer_init();
 }
 
 static void __init osiris_init(void)
diff --git a/arch/arm/mach-s3c/mach-otom.c b/arch/arm/mach-s3c/mach-otom.c
index fc8f78396159..460ee97766cd 100644
--- a/arch/arm/mach-s3c/mach-otom.c
+++ b/arch/arm/mach-s3c/mach-otom.c
@@ -94,13 +94,13 @@ static void __init otom11_map_io(void)
 {
 	s3c24xx_init_io(otom11_iodesc, ARRAY_SIZE(otom11_iodesc));
 	s3c24xx_init_uarts(otom11_uartcfgs, ARRAY_SIZE(otom11_uartcfgs));
-	samsung_set_timer_source(SAMSUNG_PWM3, SAMSUNG_PWM4);
+	s3c24xx_set_timer_source(S3C24XX_PWM3, S3C24XX_PWM4);
 }
 
 static void __init otom11_init_time(void)
 {
 	s3c2410_init_clocks(12000000);
-	samsung_timer_init();
+	s3c24xx_timer_init();
 }
 
 static void __init otom11_init(void)
diff --git a/arch/arm/mach-s3c/mach-qt2410.c b/arch/arm/mach-s3c/mach-qt2410.c
index cba41466b261..9a4212ea07db 100644
--- a/arch/arm/mach-s3c/mach-qt2410.c
+++ b/arch/arm/mach-s3c/mach-qt2410.c
@@ -320,13 +320,13 @@ static void __init qt2410_map_io(void)
 {
 	s3c24xx_init_io(qt2410_iodesc, ARRAY_SIZE(qt2410_iodesc));
 	s3c24xx_init_uarts(smdk2410_uartcfgs, ARRAY_SIZE(smdk2410_uartcfgs));
-	samsung_set_timer_source(SAMSUNG_PWM3, SAMSUNG_PWM4);
+	s3c24xx_set_timer_source(S3C24XX_PWM3, S3C24XX_PWM4);
 }
 
 static void __init qt2410_init_time(void)
 {
 	s3c2410_init_clocks(12000000);
-	samsung_timer_init();
+	s3c24xx_timer_init();
 }
 
 static void __init qt2410_machine_init(void)
diff --git a/arch/arm/mach-s3c/mach-real6410.c b/arch/arm/mach-s3c/mach-real6410.c
index 63819560fc4c..147e660647ba 100644
--- a/arch/arm/mach-s3c/mach-real6410.c
+++ b/arch/arm/mach-s3c/mach-real6410.c
@@ -207,7 +207,7 @@ static void __init real6410_map_io(void)
 	s3c64xx_init_io(NULL, 0);
 	s3c24xx_init_clocks(12000000);
 	s3c24xx_init_uarts(real6410_uartcfgs, ARRAY_SIZE(real6410_uartcfgs));
-	samsung_set_timer_source(SAMSUNG_PWM3, SAMSUNG_PWM4);
+	s3c64xx_set_timer_source(S3C64XX_PWM3, S3C64XX_PWM4);
 
 	/* set the LCD type */
 	tmp = __raw_readl(S3C64XX_SPCON);
@@ -329,5 +329,5 @@ MACHINE_START(REAL6410, "REAL6410")
 	.init_irq	= s3c6410_init_irq,
 	.map_io		= real6410_map_io,
 	.init_machine	= real6410_machine_init,
-	.init_time	= samsung_timer_init,
+	.init_time	= s3c64xx_timer_init,
 MACHINE_END
diff --git a/arch/arm/mach-s3c/mach-rx1950.c b/arch/arm/mach-s3c/mach-rx1950.c
index 99dabe7309ef..4df7a54ad7e4 100644
--- a/arch/arm/mach-s3c/mach-rx1950.c
+++ b/arch/arm/mach-s3c/mach-rx1950.c
@@ -778,7 +778,7 @@ static void __init rx1950_map_io(void)
 {
 	s3c24xx_init_io(rx1950_iodesc, ARRAY_SIZE(rx1950_iodesc));
 	s3c24xx_init_uarts(rx1950_uartcfgs, ARRAY_SIZE(rx1950_uartcfgs));
-	samsung_set_timer_source(SAMSUNG_PWM3, SAMSUNG_PWM4);
+	s3c24xx_set_timer_source(S3C24XX_PWM3, S3C24XX_PWM4);
 
 	/* setup PM */
 
@@ -792,7 +792,7 @@ static void __init rx1950_map_io(void)
 static void __init rx1950_init_time(void)
 {
 	s3c2442_init_clocks(16934000);
-	samsung_timer_init();
+	s3c24xx_timer_init();
 }
 
 static void __init rx1950_init_machine(void)
diff --git a/arch/arm/mach-s3c/mach-rx3715.c b/arch/arm/mach-s3c/mach-rx3715.c
index 4d6e9d9c8e07..889e44d86586 100644
--- a/arch/arm/mach-s3c/mach-rx3715.c
+++ b/arch/arm/mach-s3c/mach-rx3715.c
@@ -176,13 +176,13 @@ static void __init rx3715_map_io(void)
 {
 	s3c24xx_init_io(rx3715_iodesc, ARRAY_SIZE(rx3715_iodesc));
 	s3c24xx_init_uarts(rx3715_uartcfgs, ARRAY_SIZE(rx3715_uartcfgs));
-	samsung_set_timer_source(SAMSUNG_PWM3, SAMSUNG_PWM4);
+	s3c24xx_set_timer_source(S3C24XX_PWM3, S3C24XX_PWM4);
 }
 
 static void __init rx3715_init_time(void)
 {
 	s3c2440_init_clocks(16934000);
-	samsung_timer_init();
+	s3c24xx_timer_init();
 }
 
 /* H1940 and RX3715 need to reserve this for suspend */
diff --git a/arch/arm/mach-s3c/mach-smartq.c b/arch/arm/mach-s3c/mach-smartq.c
index da44a2610506..5b6e7c2a85ef 100644
--- a/arch/arm/mach-s3c/mach-smartq.c
+++ b/arch/arm/mach-s3c/mach-smartq.c
@@ -383,7 +383,7 @@ void __init smartq_map_io(void)
 	s3c64xx_set_xtal_freq(12000000);
 	s3c64xx_set_xusbxti_freq(12000000);
 	s3c24xx_init_uarts(smartq_uartcfgs, ARRAY_SIZE(smartq_uartcfgs));
-	samsung_set_timer_source(SAMSUNG_PWM3, SAMSUNG_PWM4);
+	s3c64xx_set_timer_source(S3C64XX_PWM3, S3C64XX_PWM4);
 
 	smartq_lcd_mode_set();
 }
diff --git a/arch/arm/mach-s3c/mach-smartq5.c b/arch/arm/mach-s3c/mach-smartq5.c
index 5d5e3c241629..8c940227e810 100644
--- a/arch/arm/mach-s3c/mach-smartq5.c
+++ b/arch/arm/mach-s3c/mach-smartq5.c
@@ -150,5 +150,5 @@ MACHINE_START(SMARTQ5, "SmartQ 5")
 	.init_irq	= s3c6410_init_irq,
 	.map_io		= smartq_map_io,
 	.init_machine	= smartq5_machine_init,
-	.init_time	= samsung_timer_init,
+	.init_time	= s3c64xx_timer_init,
 MACHINE_END
diff --git a/arch/arm/mach-s3c/mach-smartq7.c b/arch/arm/mach-s3c/mach-smartq7.c
index 16b62e337d8d..ab243969d6d0 100644
--- a/arch/arm/mach-s3c/mach-smartq7.c
+++ b/arch/arm/mach-s3c/mach-smartq7.c
@@ -166,5 +166,5 @@ MACHINE_START(SMARTQ7, "SmartQ 7")
 	.init_irq	= s3c6410_init_irq,
 	.map_io		= smartq_map_io,
 	.init_machine	= smartq7_machine_init,
-	.init_time	= samsung_timer_init,
+	.init_time	= s3c64xx_timer_init,
 MACHINE_END
diff --git a/arch/arm/mach-s3c/mach-smdk2410.c b/arch/arm/mach-s3c/mach-smdk2410.c
index c6f0d0abf515..ca83d5a7d101 100644
--- a/arch/arm/mach-s3c/mach-smdk2410.c
+++ b/arch/arm/mach-s3c/mach-smdk2410.c
@@ -81,13 +81,13 @@ static void __init smdk2410_map_io(void)
 {
 	s3c24xx_init_io(smdk2410_iodesc, ARRAY_SIZE(smdk2410_iodesc));
 	s3c24xx_init_uarts(smdk2410_uartcfgs, ARRAY_SIZE(smdk2410_uartcfgs));
-	samsung_set_timer_source(SAMSUNG_PWM3, SAMSUNG_PWM4);
+	s3c24xx_set_timer_source(S3C24XX_PWM3, S3C24XX_PWM4);
 }
 
 static void __init smdk2410_init_time(void)
 {
 	s3c2410_init_clocks(12000000);
-	samsung_timer_init();
+	s3c24xx_timer_init();
 }
 
 static void __init smdk2410_init(void)
diff --git a/arch/arm/mach-s3c/mach-smdk2413.c b/arch/arm/mach-s3c/mach-smdk2413.c
index 67ca5c855684..c43095b321d7 100644
--- a/arch/arm/mach-s3c/mach-smdk2413.c
+++ b/arch/arm/mach-s3c/mach-smdk2413.c
@@ -98,13 +98,13 @@ static void __init smdk2413_map_io(void)
 {
 	s3c24xx_init_io(smdk2413_iodesc, ARRAY_SIZE(smdk2413_iodesc));
 	s3c24xx_init_uarts(smdk2413_uartcfgs, ARRAY_SIZE(smdk2413_uartcfgs));
-	samsung_set_timer_source(SAMSUNG_PWM3, SAMSUNG_PWM4);
+	s3c24xx_set_timer_source(S3C24XX_PWM3, S3C24XX_PWM4);
 }
 
 static void __init smdk2413_init_time(void)
 {
 	s3c2412_init_clocks(12000000);
-	samsung_timer_init();
+	s3c24xx_timer_init();
 }
 
 static void __init smdk2413_machine_init(void)
@@ -134,7 +134,7 @@ MACHINE_START(S3C2413, "S3C2413")
 	.init_irq	= s3c2412_init_irq,
 	.map_io		= smdk2413_map_io,
 	.init_machine	= smdk2413_machine_init,
-	.init_time	= samsung_timer_init,
+	.init_time	= s3c24xx_timer_init,
 MACHINE_END
 
 MACHINE_START(SMDK2412, "SMDK2412")
@@ -145,7 +145,7 @@ MACHINE_START(SMDK2412, "SMDK2412")
 	.init_irq	= s3c2412_init_irq,
 	.map_io		= smdk2413_map_io,
 	.init_machine	= smdk2413_machine_init,
-	.init_time	= samsung_timer_init,
+	.init_time	= s3c24xx_timer_init,
 MACHINE_END
 
 MACHINE_START(SMDK2413, "SMDK2413")
diff --git a/arch/arm/mach-s3c/mach-smdk2416.c b/arch/arm/mach-s3c/mach-smdk2416.c
index 3e28f65a6f83..4d883a792cc6 100644
--- a/arch/arm/mach-s3c/mach-smdk2416.c
+++ b/arch/arm/mach-s3c/mach-smdk2416.c
@@ -213,14 +213,14 @@ static struct platform_device *smdk2416_devices[] __initdata = {
 static void __init smdk2416_init_time(void)
 {
 	s3c2416_init_clocks(12000000);
-	samsung_timer_init();
+	s3c24xx_timer_init();
 }
 
 static void __init smdk2416_map_io(void)
 {
 	s3c24xx_init_io(smdk2416_iodesc, ARRAY_SIZE(smdk2416_iodesc));
 	s3c24xx_init_uarts(smdk2416_uartcfgs, ARRAY_SIZE(smdk2416_uartcfgs));
-	samsung_set_timer_source(SAMSUNG_PWM3, SAMSUNG_PWM4);
+	s3c24xx_set_timer_source(S3C24XX_PWM3, S3C24XX_PWM4);
 }
 
 static void __init smdk2416_machine_init(void)
diff --git a/arch/arm/mach-s3c/mach-smdk2440.c b/arch/arm/mach-s3c/mach-smdk2440.c
index 596a76702edb..7f6fe0db04f3 100644
--- a/arch/arm/mach-s3c/mach-smdk2440.c
+++ b/arch/arm/mach-s3c/mach-smdk2440.c
@@ -158,13 +158,13 @@ static void __init smdk2440_map_io(void)
 {
 	s3c24xx_init_io(smdk2440_iodesc, ARRAY_SIZE(smdk2440_iodesc));
 	s3c24xx_init_uarts(smdk2440_uartcfgs, ARRAY_SIZE(smdk2440_uartcfgs));
-	samsung_set_timer_source(SAMSUNG_PWM3, SAMSUNG_PWM4);
+	s3c24xx_set_timer_source(S3C24XX_PWM3, S3C24XX_PWM4);
 }
 
 static void __init smdk2440_init_time(void)
 {
 	s3c2440_init_clocks(16934400);
-	samsung_timer_init();
+	s3c24xx_timer_init();
 }
 
 static void __init smdk2440_machine_init(void)
diff --git a/arch/arm/mach-s3c/mach-smdk2443.c b/arch/arm/mach-s3c/mach-smdk2443.c
index ee6af7ad4429..fc54c91ade56 100644
--- a/arch/arm/mach-s3c/mach-smdk2443.c
+++ b/arch/arm/mach-s3c/mach-smdk2443.c
@@ -109,13 +109,13 @@ static void __init smdk2443_map_io(void)
 {
 	s3c24xx_init_io(smdk2443_iodesc, ARRAY_SIZE(smdk2443_iodesc));
 	s3c24xx_init_uarts(smdk2443_uartcfgs, ARRAY_SIZE(smdk2443_uartcfgs));
-	samsung_set_timer_source(SAMSUNG_PWM3, SAMSUNG_PWM4);
+	s3c24xx_set_timer_source(S3C24XX_PWM3, S3C24XX_PWM4);
 }
 
 static void __init smdk2443_init_time(void)
 {
 	s3c2443_init_clocks(12000000);
-	samsung_timer_init();
+	s3c24xx_timer_init();
 }
 
 static void __init smdk2443_machine_init(void)
diff --git a/arch/arm/mach-s3c/mach-smdk6400.c b/arch/arm/mach-s3c/mach-smdk6400.c
index 8f7c5071e113..827221398d6c 100644
--- a/arch/arm/mach-s3c/mach-smdk6400.c
+++ b/arch/arm/mach-s3c/mach-smdk6400.c
@@ -60,7 +60,7 @@ static void __init smdk6400_map_io(void)
 	s3c64xx_init_io(smdk6400_iodesc, ARRAY_SIZE(smdk6400_iodesc));
 	s3c64xx_set_xtal_freq(12000000);
 	s3c24xx_init_uarts(smdk6400_uartcfgs, ARRAY_SIZE(smdk6400_uartcfgs));
-	samsung_set_timer_source(SAMSUNG_PWM3, SAMSUNG_PWM4);
+	s3c64xx_set_timer_source(S3C64XX_PWM3, S3C64XX_PWM4);
 }
 
 static struct platform_device *smdk6400_devices[] __initdata = {
@@ -86,5 +86,5 @@ MACHINE_START(SMDK6400, "SMDK6400")
 	.init_irq	= s3c6400_init_irq,
 	.map_io		= smdk6400_map_io,
 	.init_machine	= smdk6400_machine_init,
-	.init_time	= samsung_timer_init,
+	.init_time	= s3c64xx_timer_init,
 MACHINE_END
diff --git a/arch/arm/mach-s3c/mach-smdk6410.c b/arch/arm/mach-s3c/mach-smdk6410.c
index 9614916f1294..ae18c1375c9c 100644
--- a/arch/arm/mach-s3c/mach-smdk6410.c
+++ b/arch/arm/mach-s3c/mach-smdk6410.c
@@ -633,7 +633,7 @@ static void __init smdk6410_map_io(void)
 	s3c64xx_init_io(smdk6410_iodesc, ARRAY_SIZE(smdk6410_iodesc));
 	s3c64xx_set_xtal_freq(12000000);
 	s3c24xx_init_uarts(smdk6410_uartcfgs, ARRAY_SIZE(smdk6410_uartcfgs));
-	samsung_set_timer_source(SAMSUNG_PWM3, SAMSUNG_PWM4);
+	s3c64xx_set_timer_source(S3C64XX_PWM3, S3C64XX_PWM4);
 
 	/* set the LCD type */
 
@@ -702,5 +702,5 @@ MACHINE_START(SMDK6410, "SMDK6410")
 	.init_irq	= s3c6410_init_irq,
 	.map_io		= smdk6410_map_io,
 	.init_machine	= smdk6410_machine_init,
-	.init_time	= samsung_timer_init,
+	.init_time	= s3c64xx_timer_init,
 MACHINE_END
diff --git a/arch/arm/mach-s3c/mach-tct_hammer.c b/arch/arm/mach-s3c/mach-tct_hammer.c
index 3570cfdd817d..2a61df316e8c 100644
--- a/arch/arm/mach-s3c/mach-tct_hammer.c
+++ b/arch/arm/mach-s3c/mach-tct_hammer.c
@@ -131,13 +131,13 @@ static void __init tct_hammer_map_io(void)
 {
 	s3c24xx_init_io(tct_hammer_iodesc, ARRAY_SIZE(tct_hammer_iodesc));
 	s3c24xx_init_uarts(tct_hammer_uartcfgs, ARRAY_SIZE(tct_hammer_uartcfgs));
-	samsung_set_timer_source(SAMSUNG_PWM3, SAMSUNG_PWM4);
+	s3c24xx_set_timer_source(S3C24XX_PWM3, S3C24XX_PWM4);
 }
 
 static void __init tct_hammer_init_time(void)
 {
 	s3c2410_init_clocks(12000000);
-	samsung_timer_init();
+	s3c24xx_timer_init();
 }
 
 static void __init tct_hammer_init(void)
diff --git a/arch/arm/mach-s3c/mach-vr1000.c b/arch/arm/mach-s3c/mach-vr1000.c
index 2f7f61d188eb..5c3d07cf2e79 100644
--- a/arch/arm/mach-s3c/mach-vr1000.c
+++ b/arch/arm/mach-s3c/mach-vr1000.c
@@ -326,13 +326,13 @@ static void __init vr1000_map_io(void)
 
 	s3c24xx_init_io(vr1000_iodesc, ARRAY_SIZE(vr1000_iodesc));
 	s3c24xx_init_uarts(vr1000_uartcfgs, ARRAY_SIZE(vr1000_uartcfgs));
-	samsung_set_timer_source(SAMSUNG_PWM3, SAMSUNG_PWM4);
+	s3c24xx_set_timer_source(S3C24XX_PWM3, S3C24XX_PWM4);
 }
 
 static void __init vr1000_init_time(void)
 {
 	s3c2410_init_clocks(12000000);
-	samsung_timer_init();
+	s3c24xx_timer_init();
 }
 
 static void __init vr1000_init(void)
diff --git a/arch/arm/mach-s3c/mach-vstms.c b/arch/arm/mach-s3c/mach-vstms.c
index 3cf798cffbfb..0a67641e5218 100644
--- a/arch/arm/mach-s3c/mach-vstms.c
+++ b/arch/arm/mach-s3c/mach-vstms.c
@@ -135,13 +135,13 @@ static void __init vstms_map_io(void)
 {
 	s3c24xx_init_io(vstms_iodesc, ARRAY_SIZE(vstms_iodesc));
 	s3c24xx_init_uarts(vstms_uartcfgs, ARRAY_SIZE(vstms_uartcfgs));
-	samsung_set_timer_source(SAMSUNG_PWM3, SAMSUNG_PWM4);
+	s3c24xx_set_timer_source(S3C24XX_PWM3, S3C24XX_PWM4);
 }
 
 static void __init vstms_init_time(void)
 {
 	s3c2412_init_clocks(12000000);
-	samsung_timer_init();
+	s3c24xx_timer_init();
 }
 
 static void __init vstms_init(void)
diff --git a/arch/arm/mach-s3c/s3c24xx.c b/arch/arm/mach-s3c/s3c24xx.c
index db049dd94324..26a2190a81ff 100644
--- a/arch/arm/mach-s3c/s3c24xx.c
+++ b/arch/arm/mach-s3c/s3c24xx.c
@@ -222,13 +222,13 @@ void __init s3c24xx_init_io(struct map_desc *mach_desc, int size)
 	samsung_pwm_set_platdata(&s3c24xx_pwm_variant);
 }
 
-void __init samsung_set_timer_source(unsigned int event, unsigned int source)
+void __init s3c24xx_set_timer_source(unsigned int event, unsigned int source)
 {
 	s3c24xx_pwm_variant.output_mask = BIT(SAMSUNG_PWM_NUM) - 1;
 	s3c24xx_pwm_variant.output_mask &= ~(BIT(event) | BIT(source));
 }
 
-void __init samsung_timer_init(void)
+void __init s3c24xx_timer_init(void)
 {
 	unsigned int timer_irqs[SAMSUNG_PWM_NUM] = {
 		IRQ_TIMER0, IRQ_TIMER1, IRQ_TIMER2, IRQ_TIMER3, IRQ_TIMER4,
diff --git a/arch/arm/mach-s3c/s3c24xx.h b/arch/arm/mach-s3c/s3c24xx.h
index 86826cafa15d..5848bef5bb49 100644
--- a/arch/arm/mach-s3c/s3c24xx.h
+++ b/arch/arm/mach-s3c/s3c24xx.h
@@ -109,16 +109,16 @@ extern struct platform_device s3c2443_device_dma;
 
 extern struct platform_device s3c2410_device_dclk;
 
-enum samsung_timer_mode {
-	SAMSUNG_PWM0,
-	SAMSUNG_PWM1,
-	SAMSUNG_PWM2,
-	SAMSUNG_PWM3,
-	SAMSUNG_PWM4,
+enum s3c24xx_timer_mode {
+	S3C24XX_PWM0,
+	S3C24XX_PWM1,
+	S3C24XX_PWM2,
+	S3C24XX_PWM3,
+	S3C24XX_PWM4,
 };
 
-extern void __init samsung_set_timer_source(enum samsung_timer_mode event,
-					    enum samsung_timer_mode source);
-extern void __init samsung_timer_init(void);
+extern void __init s3c24xx_set_timer_source(enum s3c24xx_timer_mode event,
+					    enum s3c24xx_timer_mode source);
+extern void __init s3c24xx_timer_init(void);
 
 #endif /* __ARCH_ARM_MACH_S3C24XX_COMMON_H */
diff --git a/arch/arm/mach-s3c/s3c64xx.c b/arch/arm/mach-s3c/s3c64xx.c
index ef79aaf1aced..b5fc615a482f 100644
--- a/arch/arm/mach-s3c/s3c64xx.c
+++ b/arch/arm/mach-s3c/s3c64xx.c
@@ -168,13 +168,13 @@ static struct samsung_pwm_variant s3c64xx_pwm_variant = {
 	.tclk_mask	= (1 << 7) | (1 << 6) | (1 << 5),
 };
 
-void __init samsung_set_timer_source(unsigned int event, unsigned int source)
+void __init s3c64xx_set_timer_source(unsigned int event, unsigned int source)
 {
 	s3c64xx_pwm_variant.output_mask = BIT(SAMSUNG_PWM_NUM) - 1;
 	s3c64xx_pwm_variant.output_mask &= ~(BIT(event) | BIT(source));
 }
 
-void __init samsung_timer_init(void)
+void __init s3c64xx_timer_init(void)
 {
 	unsigned int timer_irqs[SAMSUNG_PWM_NUM] = {
 		IRQ_TIMER0_VIC, IRQ_TIMER1_VIC, IRQ_TIMER2_VIC,
diff --git a/arch/arm/mach-s3c/s3c64xx.h b/arch/arm/mach-s3c/s3c64xx.h
index 567bf3017171..92258e4f60f6 100644
--- a/arch/arm/mach-s3c/s3c64xx.h
+++ b/arch/arm/mach-s3c/s3c64xx.h
@@ -51,16 +51,16 @@ extern struct pl08x_platform_data s3c64xx_dma1_plat_data;
 #endif
 
 /* Samsung HR-Timer Clock mode */
-enum samsung_timer_mode {
-	SAMSUNG_PWM0,
-	SAMSUNG_PWM1,
-	SAMSUNG_PWM2,
-	SAMSUNG_PWM3,
-	SAMSUNG_PWM4,
+enum s3c64xx_timer_mode {
+	S3C64XX_PWM0,
+	S3C64XX_PWM1,
+	S3C64XX_PWM2,
+	S3C64XX_PWM3,
+	S3C64XX_PWM4,
 };
 
-extern void __init samsung_set_timer_source(enum samsung_timer_mode event,
-					    enum samsung_timer_mode source);
-extern void __init samsung_timer_init(void);
+extern void __init s3c64xx_set_timer_source(enum s3c64xx_timer_mode event,
+					    enum s3c64xx_timer_mode source);
+extern void __init s3c64xx_timer_init(void);
 
 #endif /* __ARCH_ARM_MACH_S3C64XX_COMMON_H */
-- 
2.17.1

