Return-Path: <SRS0=5Fkd=6R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34EC7C47247
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 12:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13DED2071C
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 12:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iM06fCo9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbgECMlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 08:41:09 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:56828 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728332AbgECMlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 08:41:04 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 043CewKt108747;
        Sun, 3 May 2020 07:40:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1588509658;
        bh=3bzLl8HBvF4150syMyCQ4gleTCaGHOSV4cwOX3bo4+k=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=iM06fCo9YTNlbtLgzBtzohhkk2S2FhpJ/B3qandCZDNgaCugoILqCBZknubmgH5SA
         qi4fOujjNjsFq+mQRj/9J+zsDgabQaDhh45o2kGDk9YhMqZjqiUIAYAlNZX03s3jX2
         /4ndsnn+Pze7TQ7oaf9zEvihjM0vJFeUeldKct5o=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 043Cew9O060310
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 3 May 2020 07:40:58 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Sun, 3 May
 2020 07:40:58 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Sun, 3 May 2020 07:40:58 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 043Cew4Q041984;
        Sun, 3 May 2020 07:40:58 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>
CC:     <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH v24 01/16] dt: bindings: Add multicolor class dt bindings documention
Date:   Sun, 3 May 2020 07:32:00 -0500
Message-ID: <20200503123215.6449-2-dmurphy@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200503123215.6449-1-dmurphy@ti.com>
References: <20200503123215.6449-1-dmurphy@ti.com>
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
Acked-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 .../bindings/leds/leds-class-multicolor.yaml  | 71 +++++++++++++++++++
 drivers/leds/led-core.c                       |  1 +
 include/dt-bindings/leds/common.h             |  3 +-
 3 files changed, 74 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-class-multicolor.yaml

diff --git a/Documentation/devicetree/bindings/leds/leds-class-multicolor.yaml b/Documentation/devicetree/bindings/leds/leds-class-multicolor.yaml
new file mode 100644
index 000000000000..16ffafc062ad
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/leds-class-multicolor.yaml
@@ -0,0 +1,71 @@
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
+
+        led-controller@14 {
+          #address-cells = <1>;
+          #size-cells = <0>;
+          compatible = "ti,lp5009";
+          reg = <0x14>;
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

