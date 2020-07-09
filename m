Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC2DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 07:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DEC32070E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 07:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgGIH2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 03:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgGIH2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 03:28:24 -0400
Received: from smtp.al2klimov.de (smtp.al2klimov.de [IPv6:2a01:4f8:c0c:1465::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4573EC061A0B;
        Thu,  9 Jul 2020 00:28:24 -0700 (PDT)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 4EBD1BC070;
        Thu,  9 Jul 2020 07:28:21 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     prabhakar.csengg@gmail.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] TI DAVINCI SERIES MEDIA DRIVER: Replace HTTP links with HTTPS ones
Date:   Thu,  9 Jul 2020 09:28:14 +0200
Message-Id: <20200709072814.24218-1-grandmaster@al2klimov.de>
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

 If there are any URLs to be removed completely or at least not HTTPSified:
 Just clearly say so and I'll *undo my change*.
 See also: https://lkml.org/lkml/2020/6/27/64

 If there are any valid, but yet not changed URLs:
 See: https://lkml.org/lkml/2020/6/26/837

 If you apply the patch, please let me know.


 drivers/media/platform/davinci/vpbe_display.c | 2 +-
 drivers/media/platform/davinci/vpif.c         | 2 +-
 drivers/media/platform/davinci/vpif.h         | 2 +-
 drivers/media/platform/davinci/vpif_display.c | 2 +-
 drivers/media/platform/davinci/vpif_display.h | 2 +-
 include/media/davinci/vpbe_display.h          | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/davinci/vpbe_display.c b/drivers/media/platform/davinci/vpbe_display.c
index 7ab13eb7527d..d19bad997f30 100644
--- a/drivers/media/platform/davinci/vpbe_display.c
+++ b/drivers/media/platform/davinci/vpbe_display.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) 2010 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2010 Texas Instruments Incorporated - https://www.ti.com/
  */
 #include <linux/kernel.h>
 #include <linux/init.h>
diff --git a/drivers/media/platform/davinci/vpif.c b/drivers/media/platform/davinci/vpif.c
index df66461f5d4f..e9794c9fc7fe 100644
--- a/drivers/media/platform/davinci/vpif.c
+++ b/drivers/media/platform/davinci/vpif.c
@@ -5,7 +5,7 @@
  * The hardware supports SDTV, HDTV formats, raw data capture.
  * Currently, the driver supports NTSC and PAL standards.
  *
- * Copyright (C) 2009 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2009 Texas Instruments Incorporated - https://www.ti.com/
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
diff --git a/drivers/media/platform/davinci/vpif.h b/drivers/media/platform/davinci/vpif.h
index 2466c7c77deb..c6d1d890478a 100644
--- a/drivers/media/platform/davinci/vpif.h
+++ b/drivers/media/platform/davinci/vpif.h
@@ -1,7 +1,7 @@
 /*
  * VPIF header file
  *
- * Copyright (C) 2009 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2009 Texas Instruments Incorporated - https://www.ti.com/
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
diff --git a/drivers/media/platform/davinci/vpif_display.c b/drivers/media/platform/davinci/vpif_display.c
index 7d55fd45240e..46afc029138f 100644
--- a/drivers/media/platform/davinci/vpif_display.c
+++ b/drivers/media/platform/davinci/vpif_display.c
@@ -2,7 +2,7 @@
  * vpif-display - VPIF display driver
  * Display driver for TI DaVinci VPIF
  *
- * Copyright (C) 2009 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2009 Texas Instruments Incorporated - https://www.ti.com/
  * Copyright (C) 2014 Lad, Prabhakar <prabhakar.csengg@gmail.com>
  *
  * This program is free software; you can redistribute it and/or
diff --git a/drivers/media/platform/davinci/vpif_display.h b/drivers/media/platform/davinci/vpif_display.h
index af2765fdcea8..f731a65eefd6 100644
--- a/drivers/media/platform/davinci/vpif_display.h
+++ b/drivers/media/platform/davinci/vpif_display.h
@@ -1,7 +1,7 @@
 /*
  * VPIF display header file
  *
- * Copyright (C) 2009 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2009 Texas Instruments Incorporated - https://www.ti.com/
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
diff --git a/include/media/davinci/vpbe_display.h b/include/media/davinci/vpbe_display.h
index 56d05a855140..6d2a93740130 100644
--- a/include/media/davinci/vpbe_display.h
+++ b/include/media/davinci/vpbe_display.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * Copyright (C) 2010 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2010 Texas Instruments Incorporated - https://www.ti.com/
  */
 #ifndef VPBE_DISPLAY_H
 #define VPBE_DISPLAY_H
-- 
2.27.0

