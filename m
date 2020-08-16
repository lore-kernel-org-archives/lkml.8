Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9F2C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 07:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 415792065C
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 07:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbgHPHNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 03:13:51 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:35644 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbgHPHNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 03:13:50 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 55563FB02;
        Sun, 16 Aug 2020 09:13:46 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AUS8qpNbV_7t; Sun, 16 Aug 2020 09:13:44 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id D5083457CB; Sun, 16 Aug 2020 09:13:43 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>, Ondrej Jirman <megi@xff.cz>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: panel: rocktech,jh057n00900: Modernize
Date:   Sun, 16 Aug 2020 09:13:42 +0200
Message-Id: <60639e670028af7e8ab31379256ba331a1bdf6cc.1597561897.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597561897.git.agx@sigxcpu.org>
References: <cover.1597561897.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Use common properties from panel-common.yaml
- Indent comment like content
- Don't preserve newlines in description
- Indent example by four spaces

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 .../display/panel/rocktech,jh057n00900.yaml   | 39 +++++++++----------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml b/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml
index d5733ef309549..c97e89707342e 100644
--- a/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml
+++ b/Documentation/devicetree/bindings/display/panel/rocktech,jh057n00900.yaml
@@ -9,9 +9,9 @@ title: Rocktech JH057N00900 5.5" 720x1440 TFT LCD panel
 maintainers:
   - Ondrej Jirman <megi@xff.cz>
 
-description: |
-             Rocktech JH057N00900 is a 720x1440 TFT LCD panel
-             connected using a MIPI-DSI video interface.
+description:
+  Rocktech JH057N00900 is a 720x1440 TFT LCD panel
+  connected using a MIPI-DSI video interface.
 
 allOf:
   - $ref: panel-common.yaml#
@@ -19,9 +19,9 @@ allOf:
 properties:
   compatible:
     enum:
-        # Rocktech JH057N00900 5.5" 720x1440 TFT LCD panel
+      # Rocktech JH057N00900 5.5" 720x1440 TFT LCD panel
       - rocktech,jh057n00900
-        # Xingbangda XBD599 5.99" 720x1440 TFT LCD panel
+      # Xingbangda XBD599 5.99" 720x1440 TFT LCD panel
       - xingbangda,xbd599
 
   port: true
@@ -35,13 +35,9 @@ properties:
   iovcc-supply:
     description: I/O voltage supply
 
-  reset-gpios:
-    description: GPIO used for the reset pin
-    maxItems: 1
+  reset-gpios: true
 
-  backlight:
-    description: Backlight used by the panel
-    $ref: "/schemas/types.yaml#/definitions/phandle"
+  backlight: true
 
 required:
   - compatible
@@ -57,15 +53,16 @@ examples:
     #include <dt-bindings/gpio/gpio.h>
 
     dsi {
-      #address-cells = <1>;
-      #size-cells = <0>;
-      panel@0 {
-        compatible = "rocktech,jh057n00900";
-        reg = <0>;
-        vcc-supply = <&reg_2v8_p>;
-        iovcc-supply = <&reg_1v8_p>;
-        reset-gpios = <&gpio3 13 GPIO_ACTIVE_LOW>;
-        backlight = <&backlight>;
-      };
+        #address-cells = <1>;
+        #size-cells = <0>;
+        panel@0 {
+            compatible = "rocktech,jh057n00900";
+            reg = <0>;
+            vcc-supply = <&reg_2v8_p>;
+            iovcc-supply = <&reg_1v8_p>;
+            reset-gpios = <&gpio3 13 GPIO_ACTIVE_LOW>;
+            backlight = <&backlight>;
+        };
     };
+
 ...
-- 
2.26.2

