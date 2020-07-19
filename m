Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC68AC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 18:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB6A020684
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 18:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgGSSPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 14:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgGSSPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 14:15:41 -0400
Received: from smtp.al2klimov.de (smtp.al2klimov.de [IPv6:2a01:4f8:c0c:1465::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE63C0619D2;
        Sun, 19 Jul 2020 11:15:40 -0700 (PDT)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 1F613BC084;
        Sun, 19 Jul 2020 18:15:36 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     linux@roeck-us.net, jdelvare@suse.com, corbet@lwn.net,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH for v5.9] hwmon: (ina2xx) Replace HTTP links with HTTPS ones
Date:   Sun, 19 Jul 2020 20:15:30 +0200
Message-Id: <20200719181530.60878-1-grandmaster@al2klimov.de>
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


 Documentation/hwmon/ina2xx.rst | 10 +++++-----
 drivers/hwmon/ina2xx.c         | 10 +++++-----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/hwmon/ina2xx.rst b/Documentation/hwmon/ina2xx.rst
index ed81f5416331..f78a5cd44c4c 100644
--- a/Documentation/hwmon/ina2xx.rst
+++ b/Documentation/hwmon/ina2xx.rst
@@ -11,7 +11,7 @@ Supported chips:
 
     Datasheet: Publicly available at the Texas Instruments website
 
-	       http://www.ti.com/
+	       https://www.ti.com/
 
   * Texas Instruments INA220
 
@@ -21,7 +21,7 @@ Supported chips:
 
     Datasheet: Publicly available at the Texas Instruments website
 
-	       http://www.ti.com/
+	       https://www.ti.com/
 
   * Texas Instruments INA226
 
@@ -31,7 +31,7 @@ Supported chips:
 
     Datasheet: Publicly available at the Texas Instruments website
 
-	       http://www.ti.com/
+	       https://www.ti.com/
 
   * Texas Instruments INA230
 
@@ -41,7 +41,7 @@ Supported chips:
 
     Datasheet: Publicly available at the Texas Instruments website
 
-	       http://www.ti.com/
+	       https://www.ti.com/
 
   * Texas Instruments INA231
 
@@ -51,7 +51,7 @@ Supported chips:
 
     Datasheet: Publicly available at the Texas Instruments website
 
-	       http://www.ti.com/
+	       https://www.ti.com/
 
 Author: Lothar Felten <lothar.felten@gmail.com>
 
diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
index 55d474ec7c35..0fc6d5857993 100644
--- a/drivers/hwmon/ina2xx.c
+++ b/drivers/hwmon/ina2xx.c
@@ -4,19 +4,19 @@
  *
  * INA219:
  * Zero Drift Bi-Directional Current/Power Monitor with I2C Interface
- * Datasheet: http://www.ti.com/product/ina219
+ * Datasheet: https://www.ti.com/product/ina219
  *
  * INA220:
  * Bi-Directional Current/Power Monitor with I2C Interface
- * Datasheet: http://www.ti.com/product/ina220
+ * Datasheet: https://www.ti.com/product/ina220
  *
  * INA226:
  * Bi-Directional Current/Power Monitor with I2C Interface
- * Datasheet: http://www.ti.com/product/ina226
+ * Datasheet: https://www.ti.com/product/ina226
  *
  * INA230:
  * Bi-directional Current/Power Monitor with I2C Interface
- * Datasheet: http://www.ti.com/product/ina230
+ * Datasheet: https://www.ti.com/product/ina230
  *
  * Copyright (C) 2012 Lothar Felten <lothar.felten@gmail.com>
  * Thanks to Jan Volkering
@@ -148,7 +148,7 @@ static const struct ina2xx_config ina2xx_config[] = {
  * Available averaging rates for ina226. The indices correspond with
  * the bit values expected by the chip (according to the ina226 datasheet,
  * table 3 AVG bit settings, found at
- * http://www.ti.com/lit/ds/symlink/ina226.pdf.
+ * https://www.ti.com/lit/ds/symlink/ina226.pdf.
  */
 static const int ina226_avg_tab[] = { 1, 4, 16, 64, 128, 256, 512, 1024 };
 
-- 
2.27.0

