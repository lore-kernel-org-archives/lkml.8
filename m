Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A4FC433E3
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 09:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E19AB207DF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 09:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgGSJjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 05:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgGSJjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 05:39:49 -0400
Received: from smtp.al2klimov.de (smtp.al2klimov.de [IPv6:2a01:4f8:c0c:1465::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2A8C0619D2;
        Sun, 19 Jul 2020 02:39:49 -0700 (PDT)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id A8817BC073;
        Sun, 19 Jul 2020 09:39:45 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     robh+dt@kernel.org, kgene@kernel.org, krzk@kernel.org,
        linux@armlinux.org.uk, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH for v5.9] ARM: SAMSUNG: Replace HTTP links with HTTPS ones
Date:   Sun, 19 Jul 2020 11:39:39 +0200
Message-Id: <20200719093939.57412-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
X-Spam: Yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Deterministic algorithm:
For each file:
  If not .svg:
    For each line:
      If doesn't contain `\bxmlns\b`:
        For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
            If both the HTTP and HTTPS versions
            return 200 OK and serve the same content:
              Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 Continuing my work started at 93431e0607e5.
 See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
 (Actually letting a shell for loop submit all this stuff for me.)

 If there are any URLs to be removed completely
 or at least not (just) HTTPSified:
 Just clearly say so and I'll *undo my change*.
 See also: https://lkml.org/lkml/2020/6/27/64

 If there are any valid, but yet not changed URLs:
 See: https://lkml.org/lkml/2020/6/26/837

 If you apply the patch, please let me know.

 Sorry again to all maintainers who complained about subject lines.
 Now I realized that you want an actually perfect prefixes,
 not just subsystem ones.
 I tried my best...
 And yes, *I could* (at least half-)automate it.
 Impossible is nothing! :)


 arch/arm/boot/dts/exynos5410-pinctrl.dtsi | 2 +-
 arch/arm/mach-s3c24xx/Kconfig             | 2 +-
 arch/arm/mach-s3c24xx/mach-h1940.c        | 2 +-
 arch/arm/mach-s3c24xx/mach-mini2440.c     | 2 +-
 arch/arm/mach-s3c24xx/mach-n30.c          | 2 +-
 arch/arm/mach-s3c24xx/mach-rx3715.c       | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5410-pinctrl.dtsi b/arch/arm/boot/dts/exynos5410-pinctrl.dtsi
index 369a8a7f2105..e5d0a2a4f648 100644
--- a/arch/arm/boot/dts/exynos5410-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos5410-pinctrl.dtsi
@@ -3,7 +3,7 @@
  * Exynos5410 SoC pin-mux and pin-config device tree source
  *
  * Copyright (c) 2013 Hardkernel Co., Ltd.
- *              http://www.hardkernel.com
+ *              https://www.hardkernel.com
  */
 
 #include <dt-bindings/pinctrl/samsung.h>
diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index c5c06d98b147..7673dde9671a 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -267,7 +267,7 @@ config MACH_TCT_HAMMER
 	select S3C_DEV_USB_HOST
 	help
 	  Say Y here if you are using the TinCanTools Hammer Board
-	  <http://www.tincantools.com>
+	  <https://www.tincantools.com>
 
 config MACH_VR1000
 	bool "Thorcom VR1000"
diff --git a/arch/arm/mach-s3c24xx/mach-h1940.c b/arch/arm/mach-s3c24xx/mach-h1940.c
index e1c372e5447b..f4710052843a 100644
--- a/arch/arm/mach-s3c24xx/mach-h1940.c
+++ b/arch/arm/mach-s3c24xx/mach-h1940.c
@@ -3,7 +3,7 @@
 // Copyright (c) 2003-2005 Simtec Electronics
 //   Ben Dooks <ben@simtec.co.uk>
 //
-// http://www.handhelds.org/projects/h1940.html
+// https://www.handhelds.org/projects/h1940.html
 
 #include <linux/kernel.h>
 #include <linux/types.h>
diff --git a/arch/arm/mach-s3c24xx/mach-mini2440.c b/arch/arm/mach-s3c24xx/mach-mini2440.c
index 9035f868fb34..113b69ba4921 100644
--- a/arch/arm/mach-s3c24xx/mach-mini2440.c
+++ b/arch/arm/mach-s3c24xx/mach-mini2440.c
@@ -6,7 +6,7 @@
 //      Weibing <http://weibing.blogbus.com> and
 //      Michel Pollet <buserror@gmail.com>
 //
-// For product information, visit http://code.google.com/p/mini2440/
+// For product information, visit https://code.google.com/p/mini2440/
 
 #include <linux/kernel.h>
 #include <linux/types.h>
diff --git a/arch/arm/mach-s3c24xx/mach-n30.c b/arch/arm/mach-s3c24xx/mach-n30.c
index d856f23939af..9ebde6dc6169 100644
--- a/arch/arm/mach-s3c24xx/mach-n30.c
+++ b/arch/arm/mach-s3c24xx/mach-n30.c
@@ -9,7 +9,7 @@
 // Copyright (c) 2005-2008 Christer Weinigel <christer@weinigel.se>
 //
 // There is a wiki with more information about the n30 port at
-// http://handhelds.org/moin/moin.cgi/AcerN30Documentation .
+// https://handhelds.org/moin/moin.cgi/AcerN30Documentation .
 
 #include <linux/kernel.h>
 #include <linux/types.h>
diff --git a/arch/arm/mach-s3c24xx/mach-rx3715.c b/arch/arm/mach-s3c24xx/mach-rx3715.c
index 529c6faf862f..995f1ff34a1b 100644
--- a/arch/arm/mach-s3c24xx/mach-rx3715.c
+++ b/arch/arm/mach-s3c24xx/mach-rx3715.c
@@ -3,7 +3,7 @@
 // Copyright (c) 2003-2004 Simtec Electronics
 //	Ben Dooks <ben@simtec.co.uk>
 //
-// http://www.handhelds.org/projects/rx3715.html
+// https://www.handhelds.org/projects/rx3715.html
 
 #include <linux/kernel.h>
 #include <linux/types.h>
-- 
2.27.0

