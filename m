Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A5DAC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 10:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 836ED2073A
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 10:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbgGSKAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 06:00:09 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:53764 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbgGSKAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 06:00:08 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 2A33ABC06F;
        Sun, 19 Jul 2020 10:00:04 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     robh+dt@kernel.org, u.kleine-koenig@pengutronix.de,
        kernel@pengutronix.de, linux@armlinux.org.uk,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH for v5.9] ARM: dts: efm32: Replace HTTP links with HTTPS ones
Date:   Sun, 19 Jul 2020 11:59:58 +0200
Message-Id: <20200719095958.57555-1-grandmaster@al2klimov.de>
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


 arch/arm/boot/dts/efm32gg-dk3750.dts | 2 +-
 arch/arm/boot/dts/efm32gg.dtsi       | 2 +-
 arch/arm/mach-efm32/Makefile.boot    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/efm32gg-dk3750.dts b/arch/arm/boot/dts/efm32gg-dk3750.dts
index adfa559a488b..f310a8191ce5 100644
--- a/arch/arm/boot/dts/efm32gg-dk3750.dts
+++ b/arch/arm/boot/dts/efm32gg-dk3750.dts
@@ -3,7 +3,7 @@
  * Device tree for EFM32GG-DK3750 development board.
  *
  * Documentation available from
- * http://www.silabs.com/Support%20Documents/TechnicalDocs/efm32gg-dk3750-ug.pdf
+ * https://www.silabs.com/Support%20Documents/TechnicalDocs/efm32gg-dk3750-ug.pdf
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/efm32gg.dtsi b/arch/arm/boot/dts/efm32gg.dtsi
index 8a58e49144cc..633c7b0809ed 100644
--- a/arch/arm/boot/dts/efm32gg.dtsi
+++ b/arch/arm/boot/dts/efm32gg.dtsi
@@ -3,7 +3,7 @@
  * Device tree for Energy Micro EFM32 Giant Gecko SoC.
  *
  * Documentation available from
- * http://www.silabs.com/Support%20Documents/TechnicalDocs/EFM32GG-RM.pdf
+ * https://www.silabs.com/Support%20Documents/TechnicalDocs/EFM32GG-RM.pdf
  */
 
 #include "armv7-m.dtsi"
diff --git a/arch/arm/mach-efm32/Makefile.boot b/arch/arm/mach-efm32/Makefile.boot
index cec195d4fcba..5dde7328a7a9 100644
--- a/arch/arm/mach-efm32/Makefile.boot
+++ b/arch/arm/mach-efm32/Makefile.boot
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 # Empty file waiting for deletion once Makefile.boot isn't needed any more.
 # Patch waits for application at
-# http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7889/1 .
+# https://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7889/1 .
-- 
2.27.0

