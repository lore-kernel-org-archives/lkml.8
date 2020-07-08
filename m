Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6352AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 19:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FD792065D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 19:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgGHTZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 15:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgGHTZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 15:25:23 -0400
Received: from smtp.al2klimov.de (smtp.al2klimov.de [IPv6:2a01:4f8:c0c:1465::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50A6C061A0B;
        Wed,  8 Jul 2020 12:25:22 -0700 (PDT)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 3A466BC070;
        Wed,  8 Jul 2020 19:25:20 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     ohad@wizery.com, bjorn.andersson@linaro.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] remoteproc: Replace HTTP links with HTTPS ones
Date:   Wed,  8 Jul 2020 21:25:13 +0200
Message-Id: <20200708192513.18629-1-grandmaster@al2klimov.de>
In-Reply-To: <f41ac867-e653-940d-374a-41e27f2697c3@ti.com>
References: <f41ac867-e653-940d-374a-41e27f2697c3@ti.com>
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
 drivers/remoteproc/da8xx_remoteproc.c    | 2 +-
 drivers/remoteproc/keystone_remoteproc.c | 2 +-
 drivers/remoteproc/omap_remoteproc.c     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/remoteproc/da8xx_remoteproc.c b/drivers/remoteproc/da8xx_remoteproc.c
index 98e0be9476a4..9a4938c3025f 100644
--- a/drivers/remoteproc/da8xx_remoteproc.c
+++ b/drivers/remoteproc/da8xx_remoteproc.c
@@ -27,7 +27,7 @@ MODULE_PARM_DESC(da8xx_fw_name,
 
 /*
  * OMAP-L138 Technical References:
- * http://www.ti.com/product/omap-l138
+ * https://www.ti.com/product/omap-l138
  */
 #define SYSCFG_CHIPSIG0 BIT(0)
 #define SYSCFG_CHIPSIG1 BIT(1)
diff --git a/drivers/remoteproc/keystone_remoteproc.c b/drivers/remoteproc/keystone_remoteproc.c
index cd266163a65f..252ac6e2f653 100644
--- a/drivers/remoteproc/keystone_remoteproc.c
+++ b/drivers/remoteproc/keystone_remoteproc.c
@@ -2,7 +2,7 @@
 /*
  * TI Keystone DSP remoteproc driver
  *
- * Copyright (C) 2015-2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2015-2017 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include <linux/module.h>
diff --git a/drivers/remoteproc/omap_remoteproc.c b/drivers/remoteproc/omap_remoteproc.c
index 6955fab0a78b..d191610454d9 100644
--- a/drivers/remoteproc/omap_remoteproc.c
+++ b/drivers/remoteproc/omap_remoteproc.c
@@ -2,7 +2,7 @@
 /*
  * OMAP Remote Processor driver
  *
- * Copyright (C) 2011-2020 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2011-2020 Texas Instruments Incorporated - https://www.ti.com/
  * Copyright (C) 2011 Google, Inc.
  *
  * Ohad Ben-Cohen <ohad@wizery.com>
-- 
2.27.0

