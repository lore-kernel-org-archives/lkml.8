Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47AECC8300A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 20:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 256A420B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 20:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vvFOTxQV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgD2UhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 16:37:05 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:50544 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbgD2UhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 16:37:00 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03TKattV008709;
        Wed, 29 Apr 2020 15:36:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1588192615;
        bh=jw8NWquH3OD78gCKpvc1yhS0ViSMz4KiKX1xenW/j/U=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=vvFOTxQVW3X/gtPJr/7cOwdiwTOaCiinAQShYHJqF5P7z3i7Zcd4KUQqa9hBCo/in
         q/Ay/WgbTaJImYm9kMSZYcDclR83+yfvn4WM9kXFaocwtfzdQtyvqGn7lBTH8WEpE8
         3QbS7L0lyqUFrdRNUoL2lAzdA0ebJJeKIyCVsL3w=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 03TKateC070153
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Apr 2020 15:36:55 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 29
 Apr 2020 15:36:55 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 29 Apr 2020 15:36:55 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03TKasfJ016537;
        Wed, 29 Apr 2020 15:36:54 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>
CC:     <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH v23 01/16] dt: bindings: Add multicolor class dt bindings documention
Date:   Wed, 29 Apr 2020 15:28:01 -0500
Message-ID: <20200429202816.26501-2-dmurphy@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200429202816.26501-1-dmurphy@ti.com>
References: <20200429202816.26501-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT bindings for the LEDs multicolor class framework.
Add multicolor ID to the color ID list for device tree bindings.

CC: Rob Herring <robh@kernel.org>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 .../bindings/leds/leds-class-multicolor.yaml  | 70 +++++++++++++++++++
 drivers/leds/led-core.c                       |  1 +
 include/dt-bindings/leds/common.h             |  3 +-
 3 files changed, 73 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-class-multicolor.yaml

diff --git a/Documentation/devicetree/bindings/leds/leds-class-multicolor.yaml b/Documentation/devicetree/bindings/leds/leds-class-multicolor.yaml
new file mode 100644
index 000000000000..e6169ed5ed12
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/leds-class-multicolor.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/leds-class-multicolor.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Common properties for the multicolor LED class.
+
+maintainers:
+  - Dan Murphy <dmurphy@ti.com>
+
+description: |
+  Bindings for multi color LEDs show how to describe current outputs of
+  either integrated multi-color LED elements (like RGB, RGBW, RGBWA-UV
+  etc.) or standalone LEDs, to achieve logically grouped multi-color LED
+  modules. This is achieved by adding multi-led nodes layer to the
+  monochrome LED bindings.
+  The nodes and properties defined in this document are unique to the multicolor
+  LED class.  Common LED nodes and properties are inherited from the common.txt
+  within this documentation directory.
+
+properties:
+  color:
+    description: |
+      For multicolor LED support this property should be defined as
+      LED_COLOR_ID_MULTI and further definition can be found in
+      include/linux/leds/common.h.
+
+required:
+  - color
+
+examples:
+  - |
+    #include <dt-bindings/leds/common.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        led-controller@14 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        compatible = "ti,lp5009";
+        reg = <0x14>;
+
+        multi-led@1 {
+          #address-cells = <1>;
+          #size-cells = <0>;
+          reg = <1>;
+          color = <LED_COLOR_ID_MULTI>;
+          function = LED_FUNCTION_CHARGING;
+
+          led@0 {
+            reg = <0>;
+            color = <LED_COLOR_ID_RED>;
+          };
+
+          led@1 {
+            reg = <1>;
+            color = <LED_COLOR_ID_GREEN>;
+          };
+
+          led@2 {
+            reg = <2>;
+            color = <LED_COLOR_ID_BLUE>;
+          };
+        };
+      };
+    };
+
+additionalProperties: false
+...
diff --git a/drivers/leds/led-core.c b/drivers/leds/led-core.c
index f1f718dbe0f8..846248a0693d 100644
--- a/drivers/leds/led-core.c
+++ b/drivers/leds/led-core.c
@@ -34,6 +34,7 @@ const char * const led_colors[LED_COLOR_ID_MAX] = {
 	[LED_COLOR_ID_VIOLET] = "violet",
 	[LED_COLOR_ID_YELLOW] = "yellow",
 	[LED_COLOR_ID_IR] = "ir",
+	[LED_COLOR_ID_MULTI] = "multicolor",
 };
 EXPORT_SYMBOL_GPL(led_colors);
 
diff --git a/include/dt-bindings/leds/common.h b/include/dt-bindings/leds/common.h
index 0ce7dfc00dcb..a463ce6a8794 100644
--- a/include/dt-bindings/leds/common.h
+++ b/include/dt-bindings/leds/common.h
@@ -30,7 +30,8 @@
 #define LED_COLOR_ID_VIOLET	5
 #define LED_COLOR_ID_YELLOW	6
 #define LED_COLOR_ID_IR		7
-#define LED_COLOR_ID_MAX	8
+#define LED_COLOR_ID_MULTI	8
+#define LED_COLOR_ID_MAX	9
 
 /* Standard LED functions */
 /* Keyboard LEDs, usually it would be input4::capslock etc. */
-- 
2.25.1

