Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E14CC33CB2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 18:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12228214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 18:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgA1SKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 13:10:05 -0500
Received: from [65.157.77.67] ([65.157.77.67]:62511 "HELO ubuntu.localdomain"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with SMTP
        id S1726520AbgA1SKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 13:10:04 -0500
Received: by ubuntu.localdomain (Postfix, from userid 1000)
        id DB239461A3C; Tue, 28 Jan 2020 11:00:25 -0700 (MST)
From:   Mike Jones <michael-a1.jones@analog.com>
To:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux@roeck-us.net, jdelvare@suse.com, robh+dt@kernel.org,
        corbet@lwn.net, Mike Jones <michael-a1.jones@analog.com>
Subject: [PATCH 1/3] docs: hwmon: (pmbus/ltc2978): Update datasheet URLs to analog.com.
Date:   Tue, 28 Jan 2020 10:59:58 -0700
Message-Id: <1580234400-2829-1-git-send-email-michael-a1.jones@analog.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mike Jones <michael-a1.jones@analog.com>
---
 Documentation/hwmon/ltc2978.rst | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/Documentation/hwmon/ltc2978.rst b/Documentation/hwmon/ltc2978.rst
index 01a24fd..42fd841 100644
--- a/Documentation/hwmon/ltc2978.rst
+++ b/Documentation/hwmon/ltc2978.rst
@@ -9,7 +9,7 @@ Supported chips:
 
     Addresses scanned: -
 
-    Datasheet: http://www.linear.com/product/ltc2974
+    Datasheet: https://www.analog.com/en/products/ltc2974
 
   * Linear Technology LTC2975
 
@@ -17,7 +17,7 @@ Supported chips:
 
     Addresses scanned: -
 
-    Datasheet: http://www.linear.com/product/ltc2975
+    Datasheet: https://www.analog.com/en/products/ltc2975
 
   * Linear Technology LTC2977
 
@@ -25,7 +25,7 @@ Supported chips:
 
     Addresses scanned: -
 
-    Datasheet: http://www.linear.com/product/ltc2977
+    Datasheet: https://www.analog.com/en/products/ltc2977
 
   * Linear Technology LTC2978, LTC2978A
 
@@ -33,9 +33,9 @@ Supported chips:
 
     Addresses scanned: -
 
-    Datasheet: http://www.linear.com/product/ltc2978
+    Datasheet: https://www.analog.com/en/products/ltc2978
 
-	       http://www.linear.com/product/ltc2978a
+	       https://www.analog.com/en/products/ltc2978a
 
   * Linear Technology LTC2980
 
@@ -43,7 +43,7 @@ Supported chips:
 
     Addresses scanned: -
 
-    Datasheet: http://www.linear.com/product/ltc2980
+    Datasheet: https://www.analog.com/en/products/ltc2980
 
   * Linear Technology LTC3880
 
@@ -51,7 +51,7 @@ Supported chips:
 
     Addresses scanned: -
 
-    Datasheet: http://www.linear.com/product/ltc3880
+    Datasheet: https://www.analog.com/en/products/ltc3880
 
   * Linear Technology LTC3882
 
@@ -59,7 +59,7 @@ Supported chips:
 
     Addresses scanned: -
 
-    Datasheet: http://www.linear.com/product/ltc3882
+    Datasheet: https://www.analog.com/en/products/ltc3882
 
   * Linear Technology LTC3883
 
@@ -67,7 +67,7 @@ Supported chips:
 
     Addresses scanned: -
 
-    Datasheet: http://www.linear.com/product/ltc3883
+    Datasheet: https://www.analog.com/en/products/ltc3883
 
   * Linear Technology LTC3886
 
@@ -75,7 +75,7 @@ Supported chips:
 
     Addresses scanned: -
 
-    Datasheet: http://www.linear.com/product/ltc3886
+    Datasheet: https://www.analog.com/en/products/ltc3886
 
   * Linear Technology LTC3887
 
@@ -83,7 +83,7 @@ Supported chips:
 
     Addresses scanned: -
 
-    Datasheet: http://www.linear.com/product/ltc3887
+    Datasheet: https://www.analog.com/en/products/ltc3887
 
   * Linear Technology LTM2987
 
@@ -91,7 +91,7 @@ Supported chips:
 
     Addresses scanned: -
 
-    Datasheet: http://www.linear.com/product/ltm2987
+    Datasheet: https://www.analog.com/en/products/ltm2987
 
   * Linear Technology LTM4675
 
@@ -99,7 +99,7 @@ Supported chips:
 
     Addresses scanned: -
 
-    Datasheet: http://www.linear.com/product/ltm4675
+    Datasheet: https://www.analog.com/en/products/ltm4675
 
   * Linear Technology LTM4676
 
@@ -107,7 +107,7 @@ Supported chips:
 
     Addresses scanned: -
 
-    Datasheet: http://www.linear.com/product/ltm4676
+    Datasheet: https://www.analog.com/en/products/ltm4676
 
   * Analog Devices LTM4686
 
-- 
2.7.4

