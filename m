Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97FC3C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 10:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7578F20738
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 10:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbgGMKpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 06:45:03 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:52386 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727035AbgGMKpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 06:45:03 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 2FC10BC07E;
        Mon, 13 Jul 2020 10:44:59 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] char: Replace HTTP links with HTTPS ones
Date:   Mon, 13 Jul 2020 12:44:53 +0200
Message-Id: <20200713104453.33414-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
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

 If there are any URLs to be removed completely or at least not just HTTPSified:
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


 drivers/char/Kconfig     | 6 +++---
 drivers/misc/echo/echo.c | 6 +++---
 drivers/misc/sram-exec.c | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index 98c3a5d8003e..b1bd336761b1 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -38,7 +38,7 @@ config PRINTER
 	  box (as opposed to using a serial printer; if the connector at the
 	  printer has 9 or 25 holes ["female"], then it's serial), say Y.
 	  Also read the Printing-HOWTO, available from
-	  <http://www.tldp.org/docs.html#howto>.
+	  <https://www.tldp.org/docs.html#howto>.
 
 	  It is possible to share one parallel port among several devices
 	  (e.g. printer and ZIP drive) and it is safe to compile the
@@ -201,7 +201,7 @@ config DTLK
 	depends on ISA
 	help
 	  This driver is for the DoubleTalk PC, a speech synthesizer
-	  manufactured by RC Systems (<http://www.rcsys.com/>).  It is also
+	  manufactured by RC Systems (<https://www.rcsys.com/>).  It is also
 	  called the `internal DoubleTalk'.
 
 	  To compile this driver as a module, choose M here: the
@@ -237,7 +237,7 @@ config APPLICOM
 	  This driver provides the kernel-side support for the intelligent
 	  fieldbus cards made by Applicom International. More information
 	  about these cards can be found on the WWW at the address
-	  <http://www.applicom-int.com/>, or by email from David Woodhouse
+	  <https://www.applicom-int.com/>, or by email from David Woodhouse
 	  <dwmw2@infradead.org>.
 
 	  To compile this driver as a module, choose M here: the
diff --git a/drivers/misc/echo/echo.c b/drivers/misc/echo/echo.c
index 713e92ee27ac..3c4eaba86576 100644
--- a/drivers/misc/echo/echo.c
+++ b/drivers/misc/echo/echo.c
@@ -66,13 +66,13 @@
        Path Models", IEEE Transactions on communications, COM-25,
        No. 6, June
        1977.
-       http://www.rowetel.com/images/echo/dual_path_paper.pdf
+       https://www.rowetel.com/images/echo/dual_path_paper.pdf
 
    [2] The classic, very useful paper that tells you how to
        actually build a real world echo canceller:
 	 Messerschmitt, Hedberg, Cole, Haoui, Winship, "Digital Voice
 	 Echo Canceller with a TMS320020,
-	 http://www.rowetel.com/images/echo/spra129.pdf
+	 https://www.rowetel.com/images/echo/spra129.pdf
 
    [3] I have written a series of blog posts on this work, here is
        Part 1: http://www.rowetel.com/blog/?p=18
@@ -80,7 +80,7 @@
    [4] The source code http://svn.rowetel.com/software/oslec/
 
    [5] A nice reference on LMS filters:
-	 http://en.wikipedia.org/wiki/Least_mean_squares_filter
+	 https://en.wikipedia.org/wiki/Least_mean_squares_filter
 
    Credits:
 
diff --git a/drivers/misc/sram-exec.c b/drivers/misc/sram-exec.c
index cb57ac6ab4c3..6cc31789b38d 100644
--- a/drivers/misc/sram-exec.c
+++ b/drivers/misc/sram-exec.c
@@ -1,7 +1,7 @@
 /*
  * SRAM protect-exec region helper functions
  *
- * Copyright (C) 2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2017 Texas Instruments Incorporated - https://www.ti.com/
  *	Dave Gerlach
  *
  * This program is free software; you can redistribute it and/or modify
-- 
2.27.0

