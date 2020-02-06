Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED2EFC35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 23:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE33720730
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 23:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbgBFXo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 18:44:29 -0500
Received: from [65.157.77.67] ([65.157.77.67]:24832 "HELO ubuntu.localdomain"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with SMTP
        id S1726543AbgBFXo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 18:44:29 -0500
Received: by ubuntu.localdomain (Postfix, from userid 1000)
        id D8602465309; Thu,  6 Feb 2020 16:44:27 -0700 (MST)
From:   Mike Jones <michael-a1.jones@analog.com>
To:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux@roeck-us.net, jdelvare@suse.com, robh+dt@kernel.org,
        corbet@lwn.net, Mike Jones <michael-a1.jones@analog.com>
Subject: [PATCH 2/2] bindings: (hwmon/ltc2978.txt): add support for more parts.
Date:   Thu,  6 Feb 2020 16:44:14 -0700
Message-Id: <1581032654-4330-2-git-send-email-michael-a1.jones@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581032654-4330-1-git-send-email-michael-a1.jones@analog.com>
References: <1581032654-4330-1-git-send-email-michael-a1.jones@analog.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LTC2972, LTC2979, LTC3884, LTC3889, LTC7880, LTM4664, LTM4677,
LTM4678, LTM4680, LTM4700.

Signed-off-by: Mike Jones <michael-a1.jones@analog.com>
---
 .../devicetree/bindings/hwmon/ltc2978.txt          | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwmon/ltc2978.txt b/Documentation/devicetree/bindings/hwmon/ltc2978.txt
index b428a70..4e7f621 100644
--- a/Documentation/devicetree/bindings/hwmon/ltc2978.txt
+++ b/Documentation/devicetree/bindings/hwmon/ltc2978.txt
@@ -2,20 +2,30 @@ ltc2978
 
 Required properties:
 - compatible: should contain one of:
+  * "lltc,ltc2972"
   * "lltc,ltc2974"
   * "lltc,ltc2975"
   * "lltc,ltc2977"
   * "lltc,ltc2978"
+  * "lltc,ltc2979"
   * "lltc,ltc2980"
   * "lltc,ltc3880"
   * "lltc,ltc3882"
   * "lltc,ltc3883"
+  * "lltc,ltc3884"
   * "lltc,ltc3886"
   * "lltc,ltc3887"
+  * "lltc,ltc3889"
+  * "lltc,ltc7880"
   * "lltc,ltm2987"
+  * "lltc,ltm4664"
   * "lltc,ltm4675"
   * "lltc,ltm4676"
+  * "lltc,ltm4677"
+  * "lltc,ltm4678"
+  * "lltc,ltm4680"
   * "lltc,ltm4686"
+  * "lltc,ltm4700"
 - reg: I2C slave address
 
 Optional properties:
@@ -25,13 +35,17 @@ Optional properties:
   standard binding for regulators; see regulator.txt.
 
 Valid names of regulators depend on number of supplies supported per device:
+  * ltc2972 vout0 - vout1
   * ltc2974, ltc2975 : vout0 - vout3
-  * ltc2977, ltc2980, ltm2987 : vout0 - vout7
+  * ltc2977, ltc2979, ltc2980, ltm2987 : vout0 - vout7
   * ltc2978 : vout0 - vout7
-  * ltc3880, ltc3882, ltc3886 : vout0 - vout1
+  * ltc3880, ltc3882, ltc3884, ltc3886, ltc3887, ltc3889 : vout0 - vout1
+  * ltc7880 : vout0 - vout1
   * ltc3883 : vout0
-  * ltm4676 : vout0 - vout1
-  * ltm4686 : vout0 - vout1
+  * ltm4664 : vout0 - vout1
+  * ltm4675, ltm4676, ltm4677, ltm4678 : vout0 - vout1
+  * ltm4680, ltm4686 : vout0 - vout1
+  * ltm4700 : vout0 - vout1
 
 Example:
 ltc2978@5e {
-- 
2.7.4

