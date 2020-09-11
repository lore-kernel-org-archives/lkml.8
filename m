Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B993BC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 15:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73CCA20758
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 15:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgIKPrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 11:47:12 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:34537 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbgIKPnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:43:40 -0400
Received: from methusalix.internal.home.lespocky.de ([109.250.103.56]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MGA0o-1kK4Z30yom-00GafJ; Fri, 11 Sep 2020 17:41:05 +0200
Received: from lemmy.internal.home.lespocky.de ([192.168.243.176] helo=lemmy.home.lespocky.de)
        by methusalix.internal.home.lespocky.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <alex@home.lespocky.de>)
        id 1kGlAc-00013I-Pk; Fri, 11 Sep 2020 17:41:03 +0200
Received: (nullmailer pid 28469 invoked by uid 2001);
        Fri, 11 Sep 2020 15:41:02 -0000
From:   Alexander Dahl <post@lespocky.de>
To:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Alexander Dahl <ada@thorsis.com>,
        Alexander Dahl <post@lespocky.de>
Subject: [PATCH v4 3/3] dt-bindings: leds: Convert pwm to yaml
Date:   Fri, 11 Sep 2020 17:40:04 +0200
Message-Id: <20200911154004.28354-4-post@lespocky.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200911154004.28354-1-post@lespocky.de>
References: <20200911154004.28354-1-post@lespocky.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scan-Signature: a27db00201996a3601d2552749fb2316
X-Provags-ID: V03:K1:Rc3ucBdQVYvH6p2B5iOmO02x3lqJqnDJA5ydqTPMWrr+j+/QhWs
 68YtQfgrNlfvdAGmhLSRSSxlEUDXwjoOkkGdF82QLXgft6mbX1onkJr5QuV3ThjOdExzG29
 p89l4CbhlKVMM9YZr68X73yyz3zYp+NyK40x4tYNd/zL0AXoBHFxHVbpxuvfSZgqZaf1vEh
 aY2i+mEWpL1iwyrcECLRA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5FkSoacWUCI=:tjaCre2lJBYxvBG3E+NQuv
 h8fiA00zgIJUJx26vL2M3CAwXrfmRyQJvSd7WmM2Paju4yK3ahgLr6IQzsp2T6FH36DvOZnVv
 EfdwLnwNuP7JI24jdY4G5SlRr6PyJTw5PSuBLJHdNvwWb+xtH1XpQpZhFqY2pnBiuM9duGbIb
 m1AzKRiucvXTo6b0S1gXvGMSVUzckIJhPiToAPvMuCrZEGLJdCF2u7Bw6cBPWQ3LDuoi8Gf69
 36A5y+cFgVVhEw4jRQ59Eu1Kq1f7aHJYhqDtnAucuJt4BvorIFRDKT7fP1DlgcBkK5as3ywvZ
 zLEmsEWvGINVNwUXHGPnO2x9OT+c/E21TfTatLjClxyZCDIGSTLzkyQ/+55RNaNipg3Z+6ByM
 qVpqwyT/peOVTnH93ZhfG0qVPFjxpjA+QATq5tutwcV9lvcksd3qN6LH/Mr275XC3hREz/jIP
 mUsLgPk21bIcNsVJyeTlqVW1zQW41Lr5kLqpLHyBuTD8w4ts1oIHxWI7QrAjrWHDZTtKLL+Xk
 oQFhYN1frwO8oX8dEfByYHqwJHxugQFn5GWnuGBxJQpKP8M+cj5l+BXgo9uagItVL8pu3x1CI
 /5owOHZz5DsGy2pEpFytEx3ShJY+IRcF3KT6Eeu0r5lycdHr7UgEUPsINQlvQ3g5ppK3dV0XY
 OfwypLscNNz/2yqw/H/Jf+0xPQu+qpHACIL3RuKbYe1EALD+qllKdE74Zq5cay+fLwUaLYQ1Z
 F7lQinZgJf5UySyOGymAKFiO32F2YXoJESbKz6kSTypvx2Wnlvk+MRH1oR40fXWJMM/jvmgYI
 3/en5zfbHtneot6DEjC7Rwrdupt0Pd1/khPgCqH+qEq5KatWlBWFc/oyPVIJMMygZpNDPQr
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The example was adapted slightly to make use of the 'function' and
'color' properties.  License discussed with the original author.

Suggested-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Signed-off-by: Alexander Dahl <post@lespocky.de>
Acked-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
---

Notes:
    v3 -> v4:
      * added Cc to original author of the binding
    
    v2 -> v3:
      * changed license identifier to recommended one
      * added Acked-by
    
    v2:
      * added this patch to series (Suggested-by: Jacek Anaszewski)

 .../devicetree/bindings/leds/leds-pwm.txt     | 50 -----------
 .../devicetree/bindings/leds/leds-pwm.yaml    | 85 +++++++++++++++++++
 2 files changed, 85 insertions(+), 50 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/leds/leds-pwm.txt
 create mode 100644 Documentation/devicetree/bindings/leds/leds-pwm.yaml

diff --git a/Documentation/devicetree/bindings/leds/leds-pwm.txt b/Documentation/devicetree/bindings/leds/leds-pwm.txt
deleted file mode 100644
index 6c6583c35f2f..000000000000
--- a/Documentation/devicetree/bindings/leds/leds-pwm.txt
+++ /dev/null
@@ -1,50 +0,0 @@
-LED connected to PWM
-
-Required properties:
-- compatible : should be "pwm-leds".
-
-Each LED is represented as a sub-node of the pwm-leds device.  Each
-node's name represents the name of the corresponding LED.
-
-LED sub-node properties:
-- pwms : PWM property to point to the PWM device (phandle)/port (id) and to
-  specify the period time to be used: <&phandle id period_ns>;
-- pwm-names : (optional) Name to be used by the PWM subsystem for the PWM device
-  For the pwms and pwm-names property please refer to:
-  Documentation/devicetree/bindings/pwm/pwm.txt
-- max-brightness : Maximum brightness possible for the LED
-- active-low : (optional) For PWMs where the LED is wired to supply
-  rather than ground.
-- label :  (optional)
-  see Documentation/devicetree/bindings/leds/common.txt
-- linux,default-trigger :  (optional)
-  see Documentation/devicetree/bindings/leds/common.txt
-
-Example:
-
-twl_pwm: pwm {
-	/* provides two PWMs (id 0, 1 for PWM1 and PWM2) */
-	compatible = "ti,twl6030-pwm";
-	#pwm-cells = <2>;
-};
-
-twl_pwmled: pwmled {
-	/* provides one PWM (id 0 for Charing indicator LED) */
-	compatible = "ti,twl6030-pwmled";
-	#pwm-cells = <2>;
-};
-
-pwmleds {
-	compatible = "pwm-leds";
-	kpad {
-		label = "omap4::keypad";
-		pwms = <&twl_pwm 0 7812500>;
-		max-brightness = <127>;
-	};
-
-	charging {
-		label = "omap4:green:chrg";
-		pwms = <&twl_pwmled 0 7812500>;
-		max-brightness = <255>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/leds/leds-pwm.yaml b/Documentation/devicetree/bindings/leds/leds-pwm.yaml
new file mode 100644
index 000000000000..c74867492424
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/leds-pwm.yaml
@@ -0,0 +1,85 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/leds-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LEDs connected to PWM
+
+maintainers:
+  - Pavel Machek <pavel@ucw.cz>
+
+description:
+  Each LED is represented as a sub-node of the pwm-leds device.  Each
+  node's name represents the name of the corresponding LED.
+
+properties:
+  compatible:
+    const: pwm-leds
+
+patternProperties:
+  "^pwm-led-([0-9a-f])$":
+    type: object
+
+    $ref: common.yaml#
+
+    properties:
+      pwms:
+        description:
+          "PWM property to point to the PWM device (phandle)/port (id)
+          and to specify the period time to be used:
+          <&phandle id period_ns>;"
+
+      pwm-names:
+        description:
+          "Name to be used by the PWM subsystem for the PWM device For
+          the pwms and pwm-names property please refer to:
+          Documentation/devicetree/bindings/pwm/pwm.txt"
+
+      max-brightness:
+        description:
+          Maximum brightness possible for the LED
+
+      active-low:
+        description:
+          For PWMs where the LED is wired to supply rather than ground.
+
+    required:
+      - pwms
+      - max-brightness
+
+examples:
+  - |
+
+    #include <dt-bindings/leds/common.h>
+
+    twl_pwm: pwm {
+        /* provides two PWMs (id 0, 1 for PWM1 and PWM2) */
+        compatible = "ti,twl6030-pwm";
+        #pwm-cells = <2>;
+    };
+
+    twl_pwmled: pwmled {
+        /* provides one PWM (id 0 for Charing indicator LED) */
+        compatible = "ti,twl6030-pwmled";
+        #pwm-cells = <2>;
+    };
+
+    pwm_leds {
+        compatible = "pwm-leds";
+
+        pwm-led-1 {
+            label = "omap4::keypad";
+            pwms = <&twl_pwm 0 7812500>;
+            max-brightness = <127>;
+        };
+
+        pwm-led-2 {
+            color = <LED_COLOR_ID_GREEN>;
+            function = LED_FUNCTION_CHARGING;
+            pwms = <&twl_pwmled 0 7812500>;
+            max-brightness = <255>;
+        };
+    };
+
+...
-- 
2.20.1

