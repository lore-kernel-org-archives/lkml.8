Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30E2C2D0E8
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 13:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC30F206E6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 13:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="mFk1SjUO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbgCZNpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 09:45:16 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40875 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbgCZNpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 09:45:15 -0400
Received: by mail-wr1-f67.google.com with SMTP id u10so7848251wro.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 06:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aUt5da61uLANGwJFYYiA7zZjRTcSYMRB6icGf3vbU0k=;
        b=mFk1SjUOpWFCWV3w8NUixREHmK4vDmUPsSbxrhNEvoMQoUozHNBVhh/84MOqcYKSh4
         7nnQSLIvwIGGnrge7xHSEy+jXUSNnfwpa6LhrX9eAMWzJjJiiFyCERkVmpWT/0X+IHJp
         hBP+BoSqsf+Q37GSlozIUGbJ+fEah8GfsiwgnpMN6JJ+K+5njBrV+P684va9X1vP3Jac
         OFWwYXyUQr/zClqzm2tBNy7zpw31A8oiD6cQiuvCPFaasRz4jET2QoPmVugn6+FCyGJp
         eVvBiQ7KakQsVkpFf5EDlE8/uLsoU/Jas0eIgTClWTl70sS13Y3YmZxoa1yS4wXFNUaw
         I3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aUt5da61uLANGwJFYYiA7zZjRTcSYMRB6icGf3vbU0k=;
        b=EhgSJfQS0vtFEMjRWQtUvdlo7eoaIf/kp0s+pkVx8llDyLOugPtstfJq3JQHg/sLAw
         /vRJCLUvvu3kzkQe3Ib6euiVKvXwZV6YEnygJTb2ySio6wQNxce9jhfyhVz//9rp+2C9
         Y2K8fHgK7xfR1P0IU+/h49UuQ8Ob9f/R435O9RsolHOkKafGr8hQZXRn4enM0omZm3dh
         /CePQCZNmj9E6fsRCOW7ENeArGT/LMEwK2xS8hAuG3URe6t/B0eD58HQA5MVld9KHcs1
         +5AfQdSm/00sV0NxFN6xmpZDWqmyev6A4sa8KRgYlQsaKtN/Tasalh0rMcipiKZYTIGZ
         /I7g==
X-Gm-Message-State: ANhLgQ16BCUpZmEnzz0J6+dIlRlGitQHSmFkm4NEIMDaAaHnrQdUNCAD
        2H8szN++9k29N2LdCiUnUUOP/pLHiFsAYQ==
X-Google-Smtp-Source: ADFU+vt66+XPqsyLeO+POW2yrcqbRJYseC7D+4t4IRvUw/9oFw1qz5OYThNV1WSSuwK+mezl4JqO8Q==
X-Received: by 2002:a5d:4d07:: with SMTP id z7mr9105092wrt.89.1585230311563;
        Thu, 26 Mar 2020 06:45:11 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5c5f:613e:f775:b6a2])
        by smtp.gmail.com with ESMTPSA id h29sm4079617wrc.64.2020.03.26.06.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 06:45:11 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     kishon@ti.com, balbi@kernel.org, khilman@baylibre.com,
        martin.blumenstingl@googlemail.com, devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/14] dt-bindings: usb: amlogic,meson-g12a-usb-ctrl: add the Amlogic GXL and GXM Families USB Glue Bindings
Date:   Thu, 26 Mar 2020 14:44:53 +0100
Message-Id: <20200326134507.4808-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200326134507.4808-1-narmstrong@baylibre.com>
References: <20200326134507.4808-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic GXL and GXM is slightly different from the Amlogic G12A Glue.

The GXL SoCs only embeds 2 USB2 PHYs and no USB3 PHYs, and the GXM SoCs
embeds 3 USB2 PHYs.

Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../usb/amlogic,meson-g12a-usb-ctrl.yaml      | 73 ++++++++++++++++++-
 1 file changed, 69 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml b/Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml
index b0e5e0fe9386..b0af50a7c124 100644
--- a/Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml
+++ b/Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml
@@ -25,9 +25,13 @@ description: |
   The Amlogic A1 embeds a DWC3 USB IP Core configured for USB2 in
   host-only mode.
 
+  The Amlogic GXL & GXM SoCs doesn't embed an USB3 PHY.
+
 properties:
   compatible:
     enum:
+      - amlogic,meson-gxl-usb-ctrl
+      - amlogic,meson-gxm-usb-ctrl
       - amlogic,meson-g12a-usb-ctrl
       - amlogic,meson-a1-usb-ctrl
 
@@ -41,6 +45,11 @@ properties:
 
   clocks:
     minItems: 1
+    maxItems: 3
+
+  clock-names:
+    minItems: 1
+    maxItems: 3
 
   resets:
     minItems: 1
@@ -52,10 +61,8 @@ properties:
     maxItems: 1
 
   phy-names:
-    items:
-      - const: usb2-phy0 # USB2 PHY0 if USBHOST_A port is used
-      - const: usb2-phy1 # USB2 PHY1 if USBOTG_B port is used
-      - const: usb3-phy0 # USB3 PHY if USB3_0 is used
+    minItems: 1
+    maxItems: 3
 
   phys:
     minItems: 1
@@ -89,6 +96,61 @@ required:
   - dr_mode
 
 allOf:
+  - if:
+      properties:
+        compatible:
+          enum:
+            - amlogic,meson-g12a-usb-ctrl
+
+    then:
+      properties:
+        phy-names:
+          items:
+            - const: usb2-phy0 # USB2 PHY0 if USBHOST_A port is used
+            - const: usb2-phy1 # USB2 PHY1 if USBOTG_B port is used
+            - const: usb3-phy0 # USB3 PHY if USB3_0 is used
+  - if:
+      properties:
+        compatible:
+          enum:
+            - amlogic,meson-gxl-usb-ctrl
+
+    then:
+      properties:
+        clocks:
+          minItems: 2
+        clock-names:
+          items:
+            - const: usb_ctrl
+            - const: ddr
+        phy-names:
+          items:
+            - const: usb2-phy0 # USB2 PHY0 if USBHOST_A port is used
+            - const: usb2-phy1 # USB2 PHY1 if USBOTG_B port is used
+      required:
+        - clock-names
+  - if:
+      properties:
+        compatible:
+          enum:
+            - amlogic,meson-gxm-usb-ctrl
+
+    then:
+      properties:
+        clocks:
+          minItems: 2
+        clock-names:
+          items:
+            - const: usb_ctrl
+            - const: ddr
+        phy-names:
+          items:
+            - const: usb2-phy0 # USB2 PHY0 if USBHOST_A port is used
+            - const: usb2-phy1 # USB2 PHY1 if USBOTG_B port is used
+            - const: usb2-phy2 # USB2 PHY2 if USBOTG_C port is used
+
+      required:
+        - clock-names
   - if:
       properties:
         compatible:
@@ -97,6 +159,9 @@ allOf:
 
     then:
       properties:
+        phy-names:
+          items:
+            - const: usb2-phy1 # USB2 PHY1 if USBOTG_B port is used
         clocks:
           minItems: 3
         clock-names:
-- 
2.22.0

