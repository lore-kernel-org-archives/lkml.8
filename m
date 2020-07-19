Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2CFFC433E3
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 19:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D17EB20B1F
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 19:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgGSTFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 15:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgGSTFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 15:05:35 -0400
Received: from smtp.al2klimov.de (smtp.al2klimov.de [IPv6:2a01:4f8:c0c:1465::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F4BC0619D2;
        Sun, 19 Jul 2020 12:05:34 -0700 (PDT)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id EDEB2BC06F;
        Sun, 19 Jul 2020 19:05:31 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     jdelvare@suse.com, linux@roeck-us.net, corbet@lwn.net,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH for v5.9] hwmon: (lm90) Replace HTTP links with HTTPS ones
Date:   Sun, 19 Jul 2020 21:05:25 +0200
Message-Id: <20200719190525.61112-1-grandmaster@al2klimov.de>
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


 Documentation/hwmon/lm90.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/hwmon/lm90.rst b/Documentation/hwmon/lm90.rst
index 78dfc01b47a2..3da8c6e06a36 100644
--- a/Documentation/hwmon/lm90.rst
+++ b/Documentation/hwmon/lm90.rst
@@ -51,7 +51,7 @@ Supported chips:
 
     Datasheet: Publicly available at the ON Semiconductor website
 
-	       http://www.onsemi.com/PowerSolutions/product.do?id=ADM1032
+	       https://www.onsemi.com/PowerSolutions/product.do?id=ADM1032
 
   * Analog Devices ADT7461
 
@@ -61,7 +61,7 @@ Supported chips:
 
     Datasheet: Publicly available at the ON Semiconductor website
 
-	       http://www.onsemi.com/PowerSolutions/product.do?id=ADT7461
+	       https://www.onsemi.com/PowerSolutions/product.do?id=ADT7461
 
   * Analog Devices ADT7461A
 
@@ -71,7 +71,7 @@ Supported chips:
 
     Datasheet: Publicly available at the ON Semiconductor website
 
-	       http://www.onsemi.com/PowerSolutions/product.do?id=ADT7461A
+	       https://www.onsemi.com/PowerSolutions/product.do?id=ADT7461A
 
   * ON Semiconductor NCT1008
 
@@ -81,7 +81,7 @@ Supported chips:
 
     Datasheet: Publicly available at the ON Semiconductor website
 
-	       http://www.onsemi.com/PowerSolutions/product.do?id=NCT1008
+	       https://www.onsemi.com/PowerSolutions/product.do?id=NCT1008
 
   * Maxim MAX6646
 
@@ -263,7 +263,7 @@ Supported chips:
 
     Datasheet: Publicly available at TI website
 
-	       http://www.ti.com/litv/pdf/sbos686
+	       https://www.ti.com/litv/pdf/sbos686
 
 Author: Jean Delvare <jdelvare@suse.de>
 
-- 
2.27.0

