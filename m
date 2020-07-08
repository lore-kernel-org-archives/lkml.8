Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A13AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 18:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17E90206E2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 18:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgGHSTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 14:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgGHSTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 14:19:46 -0400
Received: from smtp.al2klimov.de (smtp.al2klimov.de [IPv6:2a01:4f8:c0c:1465::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A97C061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 11:19:46 -0700 (PDT)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 59C85BC06F;
        Wed,  8 Jul 2020 18:19:43 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     ssantosh@kernel.org, nm@ti.com, t-kristo@ti.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] Replace HTTP links with HTTPS ones: TI KEYSTONE MULTICORE NAVIGATOR DRIVERS
Date:   Wed,  8 Jul 2020 20:19:37 +0200
Message-Id: <20200708181937.16369-1-grandmaster@al2klimov.de>
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

 If there are any URLs to be removed completely or at least not HTTPSified:
 Just clearly say so and I'll *undo my change*.
 See also: https://lkml.org/lkml/2020/6/27/64

 If there are any valid, but yet not changed URLs:
 See: https://lkml.org/lkml/2020/6/26/837

 If you apply the patch, please let me know.


 drivers/soc/ti/k3-ringacc.c        | 2 +-
 drivers/soc/ti/knav_qmss.h         | 2 +-
 drivers/soc/ti/knav_qmss_acc.c     | 2 +-
 drivers/soc/ti/knav_qmss_queue.c   | 2 +-
 drivers/soc/ti/omap_prm.c          | 2 +-
 drivers/soc/ti/pm33xx.c            | 2 +-
 drivers/soc/ti/ti_sci_inta_msi.c   | 2 +-
 drivers/soc/ti/ti_sci_pm_domains.c | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/ti/k3-ringacc.c b/drivers/soc/ti/k3-ringacc.c
index 5fb2ee2ac978..036d89aa3e2b 100644
--- a/drivers/soc/ti/k3-ringacc.c
+++ b/drivers/soc/ti/k3-ringacc.c
@@ -2,7 +2,7 @@
 /*
  * TI K3 NAVSS Ring Accelerator subsystem driver
  *
- * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com
  */
 
 #include <linux/dma-mapping.h>
diff --git a/drivers/soc/ti/knav_qmss.h b/drivers/soc/ti/knav_qmss.h
index a01eda720bf6..b815aed8f365 100644
--- a/drivers/soc/ti/knav_qmss.h
+++ b/drivers/soc/ti/knav_qmss.h
@@ -2,7 +2,7 @@
 /*
  * Keystone Navigator QMSS driver internal header
  *
- * Copyright (C) 2014 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2014 Texas Instruments Incorporated - https://www.ti.com
  * Author:	Sandeep Nair <sandeep_n@ti.com>
  *		Cyril Chemparathy <cyril@ti.com>
  *		Santosh Shilimkar <santosh.shilimkar@ti.com>
diff --git a/drivers/soc/ti/knav_qmss_acc.c b/drivers/soc/ti/knav_qmss_acc.c
index 1762d89fc05d..29670d47cdfd 100644
--- a/drivers/soc/ti/knav_qmss_acc.c
+++ b/drivers/soc/ti/knav_qmss_acc.c
@@ -2,7 +2,7 @@
 /*
  * Keystone accumulator queue manager
  *
- * Copyright (C) 2014 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2014 Texas Instruments Incorporated - https://www.ti.com
  * Author:	Sandeep Nair <sandeep_n@ti.com>
  *		Cyril Chemparathy <cyril@ti.com>
  *		Santosh Shilimkar <santosh.shilimkar@ti.com>
diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
index aa071d96ef36..feaead96ff93 100644
--- a/drivers/soc/ti/knav_qmss_queue.c
+++ b/drivers/soc/ti/knav_qmss_queue.c
@@ -2,7 +2,7 @@
 /*
  * Keystone Queue Manager subsystem driver
  *
- * Copyright (C) 2014 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2014 Texas Instruments Incorporated - https://www.ti.com
  * Authors:	Sandeep Nair <sandeep_n@ti.com>
  *		Cyril Chemparathy <cyril@ti.com>
  *		Santosh Shilimkar <santosh.shilimkar@ti.com>
diff --git a/drivers/soc/ti/omap_prm.c b/drivers/soc/ti/omap_prm.c
index c9b3f9ebf0bb..06e9d59e75bf 100644
--- a/drivers/soc/ti/omap_prm.c
+++ b/drivers/soc/ti/omap_prm.c
@@ -2,7 +2,7 @@
 /*
  * OMAP2+ PRM driver
  *
- * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com/
  *	Tero Kristo <t-kristo@ti.com>
  */
 
diff --git a/drivers/soc/ti/pm33xx.c b/drivers/soc/ti/pm33xx.c
index de0123ec8ad6..9bd2da2758f4 100644
--- a/drivers/soc/ti/pm33xx.c
+++ b/drivers/soc/ti/pm33xx.c
@@ -2,7 +2,7 @@
 /*
  * AM33XX Power Management Routines
  *
- * Copyright (C) 2012-2018 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2012-2018 Texas Instruments Incorporated - https://www.ti.com/
  *	Vaibhav Bedia, Dave Gerlach
  */
 
diff --git a/drivers/soc/ti/ti_sci_inta_msi.c b/drivers/soc/ti/ti_sci_inta_msi.c
index 0eb9462f609e..8e439759b451 100644
--- a/drivers/soc/ti/ti_sci_inta_msi.c
+++ b/drivers/soc/ti/ti_sci_inta_msi.c
@@ -2,7 +2,7 @@
 /*
  * Texas Instruments' K3 Interrupt Aggregator MSI bus
  *
- * Copyright (C) 2018-2019 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2018-2019 Texas Instruments Incorporated - https://www.ti.com/
  *	Lokesh Vutla <lokeshvutla@ti.com>
  */
 
diff --git a/drivers/soc/ti/ti_sci_pm_domains.c b/drivers/soc/ti/ti_sci_pm_domains.c
index 8c2a2f23982c..771b0ab51872 100644
--- a/drivers/soc/ti/ti_sci_pm_domains.c
+++ b/drivers/soc/ti/ti_sci_pm_domains.c
@@ -2,7 +2,7 @@
 /*
  * TI SCI Generic Power Domain Driver
  *
- * Copyright (C) 2015-2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2015-2017 Texas Instruments Incorporated - https://www.ti.com/
  *	J Keerthy <j-keerthy@ti.com>
  *	Dave Gerlach <d-gerlach@ti.com>
  */
-- 
2.27.0

