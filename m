Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61704C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 10:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DE6C2065E
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 10:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbgGZKjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 06:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgGZKjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 06:39:54 -0400
Received: from smtp.al2klimov.de (smtp.al2klimov.de [IPv6:2a01:4f8:c0c:1465::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F93C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 03:39:54 -0700 (PDT)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id A675B6F636;
        Sun, 26 Jul 2020 10:39:51 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     torvalds@linux-foundation.org, Jonathan.Cameron@huawei.com,
        david@lechnology.com, tiwai@suse.de, linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] drivers: Replace HTTP links with HTTPS ones
Date:   Sun, 26 Jul 2020 12:39:45 +0200
Message-Id: <20200726103945.16163-1-grandmaster@al2klimov.de>
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

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 Continuing my work started at 93431e0607e5 with unmaintained stuff according to:
 perl scripts/get_maintainer.pl --nogit{,-fallback} --nol

 See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
 (Actually letting a shell for loop submit all this stuff for me.)

 If there are any URLs to be removed completely
 or at least not (just) HTTPSified:
 Just clearly say so and I'll *undo my change*.
 See also: https://lkml.org/lkml/2020/6/27/64

 If there are any valid, but yet not changed URLs:
 See: https://lkml.org/lkml/2020/6/26/837

 If you apply the patch, please let me know.


 drivers/bus/omap-ocp2scp.c | 6 +++---
 drivers/bus/omap_l3_noc.c  | 2 +-
 drivers/bus/omap_l3_noc.h  | 2 +-
 drivers/bus/ti-pwmss.c     | 2 +-
 drivers/firmware/edd.c     | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/bus/omap-ocp2scp.c b/drivers/bus/omap-ocp2scp.c
index e02d0656242b..1475ceaa7add 100644
--- a/drivers/bus/omap-ocp2scp.c
+++ b/drivers/bus/omap-ocp2scp.c
@@ -2,7 +2,7 @@
 /*
  * omap-ocp2scp.c - transform ocp interface protocol to scp protocol
  *
- * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2012 Texas Instruments Incorporated - https://www.ti.com
  * Author: Kishon Vijay Abraham I <kishon@ti.com>
  */
 
@@ -47,9 +47,9 @@ static int omap_ocp2scp_probe(struct platform_device *pdev)
 	/*
 	 * As per AM572x TRM: http://www.ti.com/lit/ug/spruhz6/spruhz6.pdf
 	 * under section 26.3.2.2, table 26-26 OCP2SCP TIMING Caution;
-	 * As per OMAP4430 TRM: http://www.ti.com/lit/ug/swpu231ap/swpu231ap.pdf
+	 * As per OMAP4430 TRM: https://www.ti.com/lit/ug/swpu231ap/swpu231ap.pdf
 	 * under section 23.12.6.2.2 , Table 23-1213 OCP2SCP TIMING Caution;
-	 * As per OMAP4460 TRM: http://www.ti.com/lit/ug/swpu235ab/swpu235ab.pdf
+	 * As per OMAP4460 TRM: https://www.ti.com/lit/ug/swpu235ab/swpu235ab.pdf
 	 * under section 23.12.6.2.2, Table 23-1213 OCP2SCP TIMING Caution;
 	 * As per OMAP543x TRM http://www.ti.com/lit/pdf/swpu249
 	 * under section 27.3.2.2, Table 27-27 OCP2SCP TIMING Caution;
diff --git a/drivers/bus/omap_l3_noc.c b/drivers/bus/omap_l3_noc.c
index b040447575ad..69e9341f402d 100644
--- a/drivers/bus/omap_l3_noc.c
+++ b/drivers/bus/omap_l3_noc.c
@@ -1,7 +1,7 @@
 /*
  * OMAP L3 Interconnect error handling driver
  *
- * Copyright (C) 2011-2015 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2011-2015 Texas Instruments Incorporated - https://www.ti.com/
  *	Santosh Shilimkar <santosh.shilimkar@ti.com>
  *	Sricharan <r.sricharan@ti.com>
  *
diff --git a/drivers/bus/omap_l3_noc.h b/drivers/bus/omap_l3_noc.h
index 73431f81da28..efce07239b1f 100644
--- a/drivers/bus/omap_l3_noc.h
+++ b/drivers/bus/omap_l3_noc.h
@@ -1,7 +1,7 @@
 /*
  * OMAP L3 Interconnect  error handling driver header
  *
- * Copyright (C) 2011-2015 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2011-2015 Texas Instruments Incorporated - https://www.ti.com/
  *	Santosh Shilimkar <santosh.shilimkar@ti.com>
  *	sricharan <r.sricharan@ti.com>
  *
diff --git a/drivers/bus/ti-pwmss.c b/drivers/bus/ti-pwmss.c
index e9c26c94251b..ff3a2dab3d1e 100644
--- a/drivers/bus/ti-pwmss.c
+++ b/drivers/bus/ti-pwmss.c
@@ -2,7 +2,7 @@
 /*
  * TI PWM Subsystem driver
  *
- * Copyright (C) 2012 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2012 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include <linux/module.h>
diff --git a/drivers/firmware/edd.c b/drivers/firmware/edd.c
index 14d0970a7198..d1cc8f5bde89 100644
--- a/drivers/firmware/edd.c
+++ b/drivers/firmware/edd.c
@@ -16,7 +16,7 @@
  * made in setup.S, copied to safe structures in setup.c,
  * and presents it in sysfs.
  *
- * Please see http://linux.dell.com/edd/results.html for
+ * Please see https://linux.dell.com/edd/results.html for
  * the list of BIOSs which have been reported to implement EDD.
  */
 
-- 
2.27.0

