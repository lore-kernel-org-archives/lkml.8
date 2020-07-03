Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5650BC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 18:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42A632088E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 18:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgGCS5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 14:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgGCS5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 14:57:16 -0400
Received: from smtp.al2klimov.de (smtp.al2klimov.de [IPv6:2a01:4f8:c0c:1465::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EEDC061794;
        Fri,  3 Jul 2020 11:57:15 -0700 (PDT)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id BE7C4BC142;
        Fri,  3 Jul 2020 18:57:11 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        etremblay@distech-controls.com, corbet@lwn.net,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] Replace HTTP links with HTTPS ones: TMP513 hardware monitor driver
Date:   Fri,  3 Jul 2020 20:56:57 +0200
Message-Id: <20200703185657.15329-1-grandmaster@al2klimov.de>
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
          If both the HTTP and HTTPS versions
          return 200 OK and serve the same content:
            Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 Continuing my work started at 93431e0607e5.

 If there are any URLs to be removed completely or at least not HTTPSified:
 Just clearly say so and I'll *undo my change*.
 See also https://lkml.org/lkml/2020/6/27/64

 If there are any valid, but yet not changed URLs:
 See https://lkml.org/lkml/2020/6/26/837

 Documentation/devicetree/bindings/hwmon/ti,tmp513.yaml | 4 ++--
 Documentation/hwmon/tmp513.rst                         | 4 ++--
 drivers/hwmon/tmp513.c                                 | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwmon/ti,tmp513.yaml b/Documentation/devicetree/bindings/hwmon/ti,tmp513.yaml
index 90b2fa3f7752..c17e5d3ee3f1 100644
--- a/Documentation/devicetree/bindings/hwmon/ti,tmp513.yaml
+++ b/Documentation/devicetree/bindings/hwmon/ti,tmp513.yaml
@@ -18,8 +18,8 @@ description: |
   consumption.
 
   Datasheets:
-  http://www.ti.com/lit/gpn/tmp513
-  http://www.ti.com/lit/gpn/tmp512
+  https://www.ti.com/lit/gpn/tmp513
+  https://www.ti.com/lit/gpn/tmp512
 
 
 properties:
diff --git a/Documentation/hwmon/tmp513.rst b/Documentation/hwmon/tmp513.rst
index 6c8fae4b1a75..f2dfc1677ad9 100644
--- a/Documentation/hwmon/tmp513.rst
+++ b/Documentation/hwmon/tmp513.rst
@@ -9,13 +9,13 @@ Supported chips:
 
     Prefix: 'tmp512'
 
-    Datasheet: http://www.ti.com/lit/ds/symlink/tmp512.pdf
+    Datasheet: https://www.ti.com/lit/ds/symlink/tmp512.pdf
 
   * Texas Instruments TMP513
 
     Prefix: 'tmp513'
 
-    Datasheet: http://www.ti.com/lit/ds/symlink/tmp513.pdf
+    Datasheet: https://www.ti.com/lit/ds/symlink/tmp513.pdf
 
 Authors:
 
diff --git a/drivers/hwmon/tmp513.c b/drivers/hwmon/tmp513.c
index df66e0bc1253..23908dc5611b 100644
--- a/drivers/hwmon/tmp513.c
+++ b/drivers/hwmon/tmp513.c
@@ -5,12 +5,12 @@
  * TMP513:
  * Thermal/Power Management with Triple Remote and
  * Local Temperature Sensor and Current Shunt Monitor
- * Datasheet: http://www.ti.com/lit/gpn/tmp513
+ * Datasheet: https://www.ti.com/lit/gpn/tmp513
  *
  * TMP512:
  * Thermal/Power Management with Dual Remote
  *	and Local Temperature Sensor and Current Shunt Monitor
- * Datasheet: http://www.ti.com/lit/gpn/tmp512
+ * Datasheet: https://www.ti.com/lit/gpn/tmp512
  *
  * Copyright (C) 2019 Eric Tremblay <etremblay@distech-controls.com>
  *
-- 
2.27.0

