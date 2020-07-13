Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C7BC433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 07:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F6172073A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 07:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbgGMHTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 03:19:31 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:35590 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbgGMHTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 03:19:31 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id D3780BC069;
        Mon, 13 Jul 2020 07:19:27 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     ssantosh@kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] ARM: keystone: Replace HTTP links with HTTPS ones
Date:   Mon, 13 Jul 2020 09:19:21 +0200
Message-Id: <20200713071921.31918-1-grandmaster@al2klimov.de>
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


 arch/arm/boot/dts/keystone-clocks.dtsi      | 2 +-
 arch/arm/boot/dts/keystone-k2e-clocks.dtsi  | 2 +-
 arch/arm/boot/dts/keystone-k2e-evm.dts      | 2 +-
 arch/arm/boot/dts/keystone-k2e-netcp.dtsi   | 2 +-
 arch/arm/boot/dts/keystone-k2e.dtsi         | 2 +-
 arch/arm/boot/dts/keystone-k2g-evm.dts      | 2 +-
 arch/arm/boot/dts/keystone-k2g-ice.dts      | 2 +-
 arch/arm/boot/dts/keystone-k2g-netcp.dtsi   | 2 +-
 arch/arm/boot/dts/keystone-k2g.dtsi         | 2 +-
 arch/arm/boot/dts/keystone-k2hk-clocks.dtsi | 2 +-
 arch/arm/boot/dts/keystone-k2hk-evm.dts     | 2 +-
 arch/arm/boot/dts/keystone-k2hk-netcp.dtsi  | 2 +-
 arch/arm/boot/dts/keystone-k2hk.dtsi        | 2 +-
 arch/arm/boot/dts/keystone-k2l-clocks.dtsi  | 2 +-
 arch/arm/boot/dts/keystone-k2l-evm.dts      | 2 +-
 arch/arm/boot/dts/keystone-k2l-netcp.dtsi   | 2 +-
 arch/arm/boot/dts/keystone-k2l.dtsi         | 2 +-
 17 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/arm/boot/dts/keystone-clocks.dtsi b/arch/arm/boot/dts/keystone-clocks.dtsi
index 0397c3423d2d..20bab90ee0ba 100644
--- a/arch/arm/boot/dts/keystone-clocks.dtsi
+++ b/arch/arm/boot/dts/keystone-clocks.dtsi
@@ -2,7 +2,7 @@
 /*
  * Device Tree Source for Keystone 2 clock tree
  *
- * Copyright (C) 2013-2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2013-2017 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 clocks {
diff --git a/arch/arm/boot/dts/keystone-k2e-clocks.dtsi b/arch/arm/boot/dts/keystone-k2e-clocks.dtsi
index cf30e007fea3..74720dbf3110 100644
--- a/arch/arm/boot/dts/keystone-k2e-clocks.dtsi
+++ b/arch/arm/boot/dts/keystone-k2e-clocks.dtsi
@@ -2,7 +2,7 @@
 /*
  * Keystone 2 Edison SoC specific device tree
  *
- * Copyright (C) 2014-2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2014-2017 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 clocks {
diff --git a/arch/arm/boot/dts/keystone-k2e-evm.dts b/arch/arm/boot/dts/keystone-k2e-evm.dts
index 66fec5f5d081..36640e18e3d3 100644
--- a/arch/arm/boot/dts/keystone-k2e-evm.dts
+++ b/arch/arm/boot/dts/keystone-k2e-evm.dts
@@ -2,7 +2,7 @@
 /*
  * Keystone 2 Edison EVM device tree
  *
- * Copyright (C) 2013-2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2013-2017 Texas Instruments Incorporated - https://www.ti.com/
  */
 /dts-v1/;
 
diff --git a/arch/arm/boot/dts/keystone-k2e-netcp.dtsi b/arch/arm/boot/dts/keystone-k2e-netcp.dtsi
index ad15e77874b1..249f5f63bfc1 100644
--- a/arch/arm/boot/dts/keystone-k2e-netcp.dtsi
+++ b/arch/arm/boot/dts/keystone-k2e-netcp.dtsi
@@ -2,7 +2,7 @@
 /*
  * Device Tree Source for Keystone 2 Edison Netcp driver
  *
- * Copyright (C) 2015-2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2015-2017 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 qmss: qmss@2a40000 {
diff --git a/arch/arm/boot/dts/keystone-k2e.dtsi b/arch/arm/boot/dts/keystone-k2e.dtsi
index 2d94faf31fab..2506bf4c0a27 100644
--- a/arch/arm/boot/dts/keystone-k2e.dtsi
+++ b/arch/arm/boot/dts/keystone-k2e.dtsi
@@ -2,7 +2,7 @@
 /*
  * Keystone 2 Edison soc device tree
  *
- * Copyright (C) 2013-2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2013-2017 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include <dt-bindings/reset/ti-syscon.h>
diff --git a/arch/arm/boot/dts/keystone-k2g-evm.dts b/arch/arm/boot/dts/keystone-k2g-evm.dts
index db640bab8c1d..003036abf7ba 100644
--- a/arch/arm/boot/dts/keystone-k2g-evm.dts
+++ b/arch/arm/boot/dts/keystone-k2g-evm.dts
@@ -2,7 +2,7 @@
 /*
  * Device Tree Source for K2G EVM
  *
- * Copyright (C) 2016-2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2016-2017 Texas Instruments Incorporated - https://www.ti.com/
  */
 /dts-v1/;
 
diff --git a/arch/arm/boot/dts/keystone-k2g-ice.dts b/arch/arm/boot/dts/keystone-k2g-ice.dts
index 2a2d38cf0fff..86c111bcfd0d 100644
--- a/arch/arm/boot/dts/keystone-k2g-ice.dts
+++ b/arch/arm/boot/dts/keystone-k2g-ice.dts
@@ -2,7 +2,7 @@
 /*
  * Device Tree Source for K2G Industrial Communication Engine EVM
  *
- * Copyright (C) 2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2017 Texas Instruments Incorporated - https://www.ti.com/
  */
 /dts-v1/;
 
diff --git a/arch/arm/boot/dts/keystone-k2g-netcp.dtsi b/arch/arm/boot/dts/keystone-k2g-netcp.dtsi
index d0e6a9a43402..268ede13db8c 100644
--- a/arch/arm/boot/dts/keystone-k2g-netcp.dtsi
+++ b/arch/arm/boot/dts/keystone-k2g-netcp.dtsi
@@ -2,7 +2,7 @@
 /*
  * Device Tree Source for K2G Netcp driver
  *
- * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 qmss: qmss@4020000 {
diff --git a/arch/arm/boot/dts/keystone-k2g.dtsi b/arch/arm/boot/dts/keystone-k2g.dtsi
index 05a75019275e..c3b237b8ae6f 100644
--- a/arch/arm/boot/dts/keystone-k2g.dtsi
+++ b/arch/arm/boot/dts/keystone-k2g.dtsi
@@ -2,7 +2,7 @@
 /*
  * Device Tree Source for K2G SOC
  *
- * Copyright (C) 2016-2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2016-2017 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
diff --git a/arch/arm/boot/dts/keystone-k2hk-clocks.dtsi b/arch/arm/boot/dts/keystone-k2hk-clocks.dtsi
index 4ba6912176ef..3ca4722087c9 100644
--- a/arch/arm/boot/dts/keystone-k2hk-clocks.dtsi
+++ b/arch/arm/boot/dts/keystone-k2hk-clocks.dtsi
@@ -2,7 +2,7 @@
 /*
  * Keystone 2 Kepler/Hawking SoC clock nodes
  *
- * Copyright (C) 2013-2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2013-2017 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 clocks {
diff --git a/arch/arm/boot/dts/keystone-k2hk-evm.dts b/arch/arm/boot/dts/keystone-k2hk-evm.dts
index ad4e22afe133..deb1bd793664 100644
--- a/arch/arm/boot/dts/keystone-k2hk-evm.dts
+++ b/arch/arm/boot/dts/keystone-k2hk-evm.dts
@@ -2,7 +2,7 @@
 /*
  * Keystone 2 Kepler/Hawking EVM device tree
  *
- * Copyright (C) 2013-2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2013-2017 Texas Instruments Incorporated - https://www.ti.com/
  */
 /dts-v1/;
 
diff --git a/arch/arm/boot/dts/keystone-k2hk-netcp.dtsi b/arch/arm/boot/dts/keystone-k2hk-netcp.dtsi
index d5a6c1f5633c..2042f28f2d2f 100644
--- a/arch/arm/boot/dts/keystone-k2hk-netcp.dtsi
+++ b/arch/arm/boot/dts/keystone-k2hk-netcp.dtsi
@@ -2,7 +2,7 @@
 /*
  * Device Tree Source for Keystone 2 Hawking Netcp driver
  *
- * Copyright (C) 2015-2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2015-2017 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 qmss: qmss@2a40000 {
diff --git a/arch/arm/boot/dts/keystone-k2hk.dtsi b/arch/arm/boot/dts/keystone-k2hk.dtsi
index 8a9447703310..0acfa2cebe4c 100644
--- a/arch/arm/boot/dts/keystone-k2hk.dtsi
+++ b/arch/arm/boot/dts/keystone-k2hk.dtsi
@@ -2,7 +2,7 @@
 /*
  * Keystone 2 Kepler/Hawking soc specific device tree
  *
- * Copyright (C) 2013-2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2013-2017 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include <dt-bindings/reset/ti-syscon.h>
diff --git a/arch/arm/boot/dts/keystone-k2l-clocks.dtsi b/arch/arm/boot/dts/keystone-k2l-clocks.dtsi
index 635528064dea..fcfc2fb6cc2d 100644
--- a/arch/arm/boot/dts/keystone-k2l-clocks.dtsi
+++ b/arch/arm/boot/dts/keystone-k2l-clocks.dtsi
@@ -2,7 +2,7 @@
 /*
  * Keystone 2 lamarr SoC clock nodes
  *
- * Copyright (C) 2013-2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2013-2017 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 clocks {
diff --git a/arch/arm/boot/dts/keystone-k2l-evm.dts b/arch/arm/boot/dts/keystone-k2l-evm.dts
index e200533d26a4..3a17da60d668 100644
--- a/arch/arm/boot/dts/keystone-k2l-evm.dts
+++ b/arch/arm/boot/dts/keystone-k2l-evm.dts
@@ -2,7 +2,7 @@
 /*
  * Keystone 2 Lamarr EVM device tree
  *
- * Copyright (C) 2014-2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2014-2017 Texas Instruments Incorporated - https://www.ti.com/
  */
 /dts-v1/;
 
diff --git a/arch/arm/boot/dts/keystone-k2l-netcp.dtsi b/arch/arm/boot/dts/keystone-k2l-netcp.dtsi
index c1f982604145..aaf852b4739e 100644
--- a/arch/arm/boot/dts/keystone-k2l-netcp.dtsi
+++ b/arch/arm/boot/dts/keystone-k2l-netcp.dtsi
@@ -2,7 +2,7 @@
 /*
  * Device Tree Source for Keystone 2 Lamarr Netcp driver
  *
- * Copyright (C) 2015-2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2015-2017 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 qmss: qmss@2a40000 {
diff --git a/arch/arm/boot/dts/keystone-k2l.dtsi b/arch/arm/boot/dts/keystone-k2l.dtsi
index dff5fea72b2f..c89c8fa24a7a 100644
--- a/arch/arm/boot/dts/keystone-k2l.dtsi
+++ b/arch/arm/boot/dts/keystone-k2l.dtsi
@@ -2,7 +2,7 @@
 /*
  * Keystone 2 Lamarr SoC specific device tree
  *
- * Copyright (C) 2014-2017 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2014-2017 Texas Instruments Incorporated - https://www.ti.com/
  */
 
 #include <dt-bindings/reset/ti-syscon.h>
-- 
2.27.0

