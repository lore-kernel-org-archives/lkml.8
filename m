Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5EFC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 16:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5C892067D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 16:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730109AbgGMQyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 12:54:21 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:38296 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729659AbgGMQyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 12:54:20 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 585A3BC0FD;
        Mon, 13 Jul 2020 16:54:16 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, linus.walleij@linaro.org, arnd@arndb.de,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] mtd: Replace HTTP links with HTTPS ones
Date:   Mon, 13 Jul 2020 18:54:08 +0200
Message-Id: <20200713165408.36229-1-grandmaster@al2klimov.de>
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


 Documentation/devicetree/bindings/mtd/davinci-nand.txt | 4 ++--
 drivers/mtd/chips/Kconfig                              | 2 +-
 drivers/mtd/maps/Kconfig                               | 2 +-
 drivers/mtd/maps/sc520cdp.c                            | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/davinci-nand.txt b/Documentation/devicetree/bindings/mtd/davinci-nand.txt
index cfb18abe6001..edebeae1f5b3 100644
--- a/Documentation/devicetree/bindings/mtd/davinci-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/davinci-nand.txt
@@ -4,8 +4,8 @@ This file provides information, what the device node for the davinci/keystone
 NAND interface contains.
 
 Documentation:
-Davinci DM646x - http://www.ti.com/lit/ug/sprueq7c/sprueq7c.pdf
-Kestone - http://www.ti.com/lit/ug/sprugz3a/sprugz3a.pdf
+Davinci DM646x - https://www.ti.com/lit/ug/sprueq7c/sprueq7c.pdf
+Kestone - https://www.ti.com/lit/ug/sprugz3a/sprugz3a.pdf
 
 Required properties:
 
diff --git a/drivers/mtd/chips/Kconfig b/drivers/mtd/chips/Kconfig
index a7e47e068ad9..aef14990e5f7 100644
--- a/drivers/mtd/chips/Kconfig
+++ b/drivers/mtd/chips/Kconfig
@@ -11,7 +11,7 @@ config MTD_CFI
 	  AMD and other flash manufactures that provides a universal method
 	  for probing the capabilities of flash devices. If you wish to
 	  support any device that is CFI-compliant, you need to enable this
-	  option. Visit <http://www.amd.com/products/nvd/overview/cfi.html>
+	  option. Visit <https://www.amd.com/products/nvd/overview/cfi.html>
 	  for more information on CFI.
 
 config MTD_JEDECPROBE
diff --git a/drivers/mtd/maps/Kconfig b/drivers/mtd/maps/Kconfig
index b28225a7c4f3..fd37553f1b07 100644
--- a/drivers/mtd/maps/Kconfig
+++ b/drivers/mtd/maps/Kconfig
@@ -310,7 +310,7 @@ config MTD_DC21285
 	help
 	  This provides a driver for the flash accessed using Intel's
 	  21285 bridge used with Intel's StrongARM processors. More info at
-	  <http://www.intel.com/design/bridge/docs/21285_documentation.htm>.
+	  <https://www.intel.com/design/bridge/docs/21285_documentation.htm>.
 
 config MTD_IXP4XX
 	tristate "CFI Flash device mapped on Intel IXP4xx based systems"
diff --git a/drivers/mtd/maps/sc520cdp.c b/drivers/mtd/maps/sc520cdp.c
index 9902b37e18b4..8ef7aec634c7 100644
--- a/drivers/mtd/maps/sc520cdp.c
+++ b/drivers/mtd/maps/sc520cdp.c
@@ -6,7 +6,7 @@
  * The SC520CDP is an evaluation board for the Elan SC520 processor available
  * from AMD. It has two banks of 32-bit Flash ROM, each 8 Megabytes in size,
  * and up to 512 KiB of 8-bit DIL Flash ROM.
- * For details see http://www.amd.com/products/epd/desiging/evalboards/18.elansc520/520_cdp_brief/index.html
+ * For details see https://www.amd.com/products/epd/desiging/evalboards/18.elansc520/520_cdp_brief/index.html
  */
 
 #include <linux/module.h>
-- 
2.27.0

