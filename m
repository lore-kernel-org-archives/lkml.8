Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D93C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 12:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B64C2072D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 12:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729704AbgGMMSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 08:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgGMMSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 08:18:17 -0400
Received: from smtp.al2klimov.de (smtp.al2klimov.de [IPv6:2a01:4f8:c0c:1465::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB007C061755;
        Mon, 13 Jul 2020 05:18:16 -0700 (PDT)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id B8C72BC0CB;
        Mon, 13 Jul 2020 12:18:11 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org, rogerq@ti.com,
        wen.yang99@zte.com.cn, sboyd@kernel.org, grygorii.strashko@ti.com,
        jsarha@ti.com, weiyongjun1@huawei.com, nsekhar@ti.com,
        hslester96@gmail.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] drivers: phy: Replace HTTP links with HTTPS ones
Date:   Mon, 13 Jul 2020 14:18:05 +0200
Message-Id: <20200713121805.34047-1-grandmaster@al2klimov.de>
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


 Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml | 2 +-
 drivers/phy/phy-core.c                                      | 2 +-
 drivers/phy/ti/phy-am654-serdes.c                           | 2 +-
 drivers/phy/ti/phy-gmii-sel.c                               | 2 +-
 drivers/phy/ti/phy-j721e-wiz.c                              | 2 +-
 drivers/phy/ti/phy-omap-control.c                           | 2 +-
 drivers/phy/ti/phy-omap-usb2.c                              | 2 +-
 drivers/phy/ti/phy-ti-pipe3.c                               | 2 +-
 include/linux/phy/omap_control_phy.h                        | 2 +-
 include/linux/phy/omap_usb.h                                | 2 +-
 include/linux/phy/phy.h                                     | 2 +-
 11 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
index 3f913d6d1c3d..ebb5ffe1b821 100644
--- a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
+++ b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-# Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
+# Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com/
 %YAML 1.2
 ---
 $id: "http://devicetree.org/schemas/phy/ti,phy-j721e-wiz.yaml#"
diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index a27b8d578d7f..41182dd3b705 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -2,7 +2,7 @@
 /*
  * phy-core.c  --  Generic Phy framework.
  *
- * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2013 Texas Instruments Incorporated - https://www.ti.com
  *
  * Author: Kishon Vijay Abraham I <kishon@ti.com>
  */
diff --git a/drivers/phy/ti/phy-am654-serdes.c b/drivers/phy/ti/phy-am654-serdes.c
index 0a166d5a6414..89d5b5a5d83a 100644
--- a/drivers/phy/ti/phy-am654-serdes.c
+++ b/drivers/phy/ti/phy-am654-serdes.c
@@ -2,7 +2,7 @@
 /**
  * PCIe SERDES driver for AM654x SoC
  *
- * Copyright (C) 2018 - 2019 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2018 - 2019 Texas Instruments Incorporated - https://www.ti.com/
  * Author: Kishon Vijay Abraham I <kishon@ti.com>
  */
 
diff --git a/drivers/phy/ti/phy-gmii-sel.c b/drivers/phy/ti/phy-gmii-sel.c
index 7edd5c3bc536..84a3434375ab 100644
--- a/drivers/phy/ti/phy-gmii-sel.c
+++ b/drivers/phy/ti/phy-gmii-sel.c
@@ -2,7 +2,7 @@
 /*
  * Texas Instruments CPSW Port's PHY Interface Mode selection Driver
  *
- * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2018 Texas Instruments Incorporated - https://www.ti.com/
  *
  * Based on cpsw-phy-sel.c driver created by Mugunthan V N <mugunthanvnm@ti.com>
  */
diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
index 30ea5b207285..f8cfdc8f56b9 100644
--- a/drivers/phy/ti/phy-j721e-wiz.c
+++ b/drivers/phy/ti/phy-j721e-wiz.c
@@ -2,7 +2,7 @@
 /**
  * Wrapper driver for SERDES used in J721E
  *
- * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
+ * Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com/
  * Author: Kishon Vijay Abraham I <kishon@ti.com>
  */
 
diff --git a/drivers/phy/ti/phy-omap-control.c b/drivers/phy/ti/phy-omap-control.c
index ccd0e4e00451..8257972fac25 100644
--- a/drivers/phy/ti/phy-omap-control.c
+++ b/drivers/phy/ti/phy-omap-control.c
@@ -2,7 +2,7 @@
 /*
  * omap-control-phy.c - The PHY part of control module.
  *
- * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2013 Texas Instruments Incorporated - https://www.ti.com
  * Author: Kishon Vijay Abraham I <kishon@ti.com>
  */
 
diff --git a/drivers/phy/ti/phy-omap-usb2.c b/drivers/phy/ti/phy-omap-usb2.c
index cb2dd3230fa7..9bc96db3315f 100644
--- a/drivers/phy/ti/phy-omap-usb2.c
+++ b/drivers/phy/ti/phy-omap-usb2.c
@@ -2,7 +2,7 @@
 /*
  * omap-usb2.c - USB PHY, talking to USB controller on TI SoCs.
  *
- * Copyright (C) 2012-2020 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2012-2020 Texas Instruments Incorporated - https://www.ti.com
  * Author: Kishon Vijay Abraham I <kishon@ti.com>
  */
 
diff --git a/drivers/phy/ti/phy-ti-pipe3.c b/drivers/phy/ti/phy-ti-pipe3.c
index a87946589eb7..b6d5e1e94f92 100644
--- a/drivers/phy/ti/phy-ti-pipe3.c
+++ b/drivers/phy/ti/phy-ti-pipe3.c
@@ -2,7 +2,7 @@
 /*
  * phy-ti-pipe3 - PIPE3 PHY driver.
  *
- * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2013 Texas Instruments Incorporated - https://www.ti.com
  * Author: Kishon Vijay Abraham I <kishon@ti.com>
  */
 
diff --git a/include/linux/phy/omap_control_phy.h b/include/linux/phy/omap_control_phy.h
index aec57dd784f7..2fd00c05acbf 100644
--- a/include/linux/phy/omap_control_phy.h
+++ b/include/linux/phy/omap_control_phy.h
@@ -2,7 +2,7 @@
 /*
  * omap_control_phy.h - Header file for the PHY part of control module.
  *
- * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2013 Texas Instruments Incorporated - https://www.ti.com
  * Author: Kishon Vijay Abraham I <kishon@ti.com>
  */
 
diff --git a/include/linux/phy/omap_usb.h b/include/linux/phy/omap_usb.h
index e23b52df93ec..783effd61185 100644
--- a/include/linux/phy/omap_usb.h
+++ b/include/linux/phy/omap_usb.h
@@ -2,7 +2,7 @@
 /*
  * omap_usb.h -- omap usb2 phy header file
  *
- * Copyright (C) 2012-2020 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2012-2020 Texas Instruments Incorporated - https://www.ti.com
  * Author: Kishon Vijay Abraham I <kishon@ti.com>
  */
 
diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index bcee8eba62b3..baa3b1c7a0fb 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -2,7 +2,7 @@
 /*
  * phy.h -- generic phy header file
  *
- * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com
+ * Copyright (C) 2013 Texas Instruments Incorporated - https://www.ti.com
  *
  * Author: Kishon Vijay Abraham I <kishon@ti.com>
  */
-- 
2.27.0

