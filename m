Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8078BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 20:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 618242075D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 20:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgGMUR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 16:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgGMUR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 16:17:56 -0400
Received: from smtp.al2klimov.de (smtp.al2klimov.de [IPv6:2a01:4f8:c0c:1465::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDB4C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 13:17:56 -0700 (PDT)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 559CBBC0B5;
        Mon, 13 Jul 2020 20:17:54 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] uio: Replace HTTP links with HTTPS ones
Date:   Mon, 13 Jul 2020 22:17:47 +0200
Message-Id: <20200713201747.37955-1-grandmaster@al2klimov.de>
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


 drivers/uio/Kconfig     | 6 +++---
 drivers/uio/uio_netx.c  | 2 +-
 drivers/uio/uio_pruss.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/uio/Kconfig b/drivers/uio/Kconfig
index 202ee81cfc2b..cdad8dc66b5e 100644
--- a/drivers/uio/Kconfig
+++ b/drivers/uio/Kconfig
@@ -81,7 +81,7 @@ config UIO_SERCOS3
 	  available for download from the Automata GmbH web site.
 
 	  Automata GmbH:        http://www.automataweb.com
-	  Sercos III interface: http://www.sercos.com
+	  Sercos III interface: https://www.sercos.com
 
 	  If you compile this as a module, it will be called uio_sercos3.
 
@@ -100,7 +100,7 @@ config UIO_NETX
 	help
 	  Driver for Hilscher NetX based fieldbus cards (cifX, comX).
 	  This driver requires a userspace component that comes with the card
-	  or is available from Hilscher (http://www.hilscher.com).
+	  or is available from Hilscher (https://www.hilscher.com).
 
 	  To compile this driver as a module, choose M here; the module
 	  will be called uio_netx.
@@ -123,7 +123,7 @@ config UIO_FSL_ELBC_GPCM_NETX5152
 	  together with the userspace netX stack from Hilscher.
 
 	  Information about this hardware can be found at:
-	  http://www.hilscher.com/netx
+	  https://www.hilscher.com/netx
 
 config UIO_PRUSS
 	tristate "Texas Instruments PRUSS driver"
diff --git a/drivers/uio/uio_netx.c b/drivers/uio/uio_netx.c
index 9ae29ffde410..3d5a92daa0b1 100644
--- a/drivers/uio/uio_netx.c
+++ b/drivers/uio/uio_netx.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * UIO driver for Hilscher NetX based fieldbus cards (cifX, comX).
- * See http://www.hilscher.com for details.
+ * See https://www.hilscher.com for details.
  *
  * (C) 2007 Hans J. Koch <hjk@hansjkoch.de>
  * (C) 2008 Manuel Traut <manut@linutronix.de>
diff --git a/drivers/uio/uio_pruss.c b/drivers/uio/uio_pruss.c
index 1cc175d3c25c..64e5dfa92a0d 100644
--- a/drivers/uio/uio_pruss.c
+++ b/drivers/uio/uio_pruss.c
@@ -4,7 +4,7 @@
  * This driver exports PRUSS host event out interrupts and PRUSS, L3 RAM,
  * and DDR RAM to user space for applications interacting with PRUSS firmware
  *
- * Copyright (C) 2010-11 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2010-11 Texas Instruments Incorporated - https://www.ti.com/
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License as
-- 
2.27.0

