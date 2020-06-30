Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A33AC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C9C3206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593547278;
	bh=6KdpPJUim7cHpfO/0ME9wdNr0MYxFs3rP34h+nQP6oo=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=mZorak4xMJKZNr530cdr1ku45cFBjDRFcVxSEqOXNlqKIxdOA5OPO/XzXDnr5NdbH
	 bZIMMJZvysnxYFzOUSBfK86KBqSpINZerc18b2MjRNcADcto9mSBE/AOv4ciWDViZu
	 OGXTX4M/H/54WLcpbX36/iZKeY1Yk/Pj5m8m/zag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbgF3UBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 16:01:17 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:42586 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbgF3UBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 16:01:16 -0400
Received: by mail-il1-f196.google.com with SMTP id t27so13958128ill.9;
        Tue, 30 Jun 2020 13:01:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TJmbtey+in3rh5OrOGAFbpkrYEFdNgFz53SELbvo7pI=;
        b=c1I/euqbGSzaXU0w//+hRDPR+MqaPiZJPRxDzZxt3L2VwUIqtT4oTI7Ar1w92NL5Vm
         ZT7rQYC1ObSCRRMndptOn4abSDfW0MaLXCVzi45I7v9ICeLUPPequycP8PNImmr4OOIC
         +JqoDoTA3qA11ZLxQuE1xmuRuiV596snaFUz4j/WOpTSlhJzY/lzsIg0dTd8pVv5+ifc
         PbQjOoXobtHzvqG3rf+Y4UY/PfzrhUvc7Xbjx47UkAfzTYEFowwppL4XKFO7MNrj+gm8
         s70VTAwALjtlXgxJZRXZhcnnN1qCy826dzOwlbMku7tQcZElPcjmvt0CO8wyBFTYifa+
         isEQ==
X-Gm-Message-State: AOAM5326aSblHTtpKoIxUjQyrWmWYayFs6wPkxPQeTX2OeOyERw2L48l
        H34IbB4Gumus0p0uOiVDsQK5pHTR7w==
X-Google-Smtp-Source: ABdhPJzOZqAnFhmOj5zoR361SpSTOH4mm82LRU11Kwi8yb9blcWPjPvQkl8BUC6oxQqhR4EclYj2+Q==
X-Received: by 2002:a05:6e02:dc4:: with SMTP id l4mr3366218ilj.134.1593547273202;
        Tue, 30 Jun 2020 13:01:13 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.255])
        by smtp.googlemail.com with ESMTPSA id v16sm2063415iow.19.2020.06.30.13.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 13:01:12 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v2] dt-bindings: backlight: Convert common backlight bindings to DT schema
Date:   Tue, 30 Jun 2020 14:01:11 -0600
Message-Id: <20200630200111.1170742-1-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the common GPIO, LED, and PWM backlight bindings to DT schema
format.

Given there's only 2 common properties and the descriptions are slightly
different, I opted to not create a common backlight schema.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
- Reformat descriptions
- drop default-brightness-level dependency on brightness-levels for
  led-backlight
---
 .../leds/backlight/gpio-backlight.txt         |  16 ---
 .../leds/backlight/gpio-backlight.yaml        |  41 +++++++
 .../bindings/leds/backlight/led-backlight.txt |  28 -----
 .../leds/backlight/led-backlight.yaml         |  57 ++++++++++
 .../bindings/leds/backlight/pwm-backlight.txt |  61 ----------
 .../leds/backlight/pwm-backlight.yaml         | 104 ++++++++++++++++++
 6 files changed, 202 insertions(+), 105 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/leds/backlight/gpio-backlight.txt
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml
 delete mode 100644 Documentation/devicetree/bindings/leds/backlight/led-backlight.txt
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/led-backlight.yaml
 delete mode 100644 Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/pwm-backlight.yaml

diff --git a/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.txt b/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.txt
deleted file mode 100644
index 321be6640533..000000000000
--- a/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.txt
+++ /dev/null
@@ -1,16 +0,0 @@
-gpio-backlight bindings
-
-Required properties:
-  - compatible: "gpio-backlight"
-  - gpios: describes the gpio that is used for enabling/disabling the backlight.
-    refer to bindings/gpio/gpio.txt for more details.
-
-Optional properties:
-  - default-on: enable the backlight at boot.
-
-Example:
-	backlight {
-		compatible = "gpio-backlight";
-		gpios = <&gpio3 4 GPIO_ACTIVE_HIGH>;
-		default-on;
-	};
diff --git a/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml
new file mode 100644
index 000000000000..75cc569b9c55
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/backlight/gpio-backlight.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: gpio-backlight bindings
+
+maintainers:
+  - Lee Jones <lee.jones@linaro.org>
+  - Daniel Thompson <daniel.thompson@linaro.org>
+  - Jingoo Han <jingoohan1@gmail.com>
+
+properties:
+  compatible:
+    const: gpio-backlight
+
+  gpios:
+    description: The gpio that is used for enabling/disabling the backlight.
+    maxItems: 1
+
+  default-on:
+    description: enable the backlight at boot.
+    type: boolean
+
+required:
+  - compatible
+  - gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    backlight {
+        compatible = "gpio-backlight";
+        gpios = <&gpio3 4 GPIO_ACTIVE_HIGH>;
+        default-on;
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/leds/backlight/led-backlight.txt b/Documentation/devicetree/bindings/leds/backlight/led-backlight.txt
deleted file mode 100644
index 4c7dfbe7f67a..000000000000
--- a/Documentation/devicetree/bindings/leds/backlight/led-backlight.txt
+++ /dev/null
@@ -1,28 +0,0 @@
-led-backlight bindings
-
-This binding is used to describe a basic backlight device made of LEDs.
-It can also be used to describe a backlight device controlled by the output of
-a LED driver.
-
-Required properties:
-  - compatible: "led-backlight"
-  - leds: a list of LEDs
-
-Optional properties:
-  - brightness-levels: Array of distinct brightness levels. The levels must be
-                       in the range accepted by the underlying LED devices.
-                       This is used to translate a backlight brightness level
-                       into a LED brightness level. If it is not provided, the
-                       identity mapping is used.
-
-  - default-brightness-level: The default brightness level.
-
-Example:
-
-	backlight {
-		compatible = "led-backlight";
-
-		leds = <&led1>, <&led2>;
-		brightness-levels = <0 4 8 16 32 64 128 255>;
-		default-brightness-level = <6>;
-	};
diff --git a/Documentation/devicetree/bindings/leds/backlight/led-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/led-backlight.yaml
new file mode 100644
index 000000000000..625082bf3892
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/backlight/led-backlight.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/backlight/led-backlight.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: led-backlight bindings
+
+maintainers:
+  - Lee Jones <lee.jones@linaro.org>
+  - Daniel Thompson <daniel.thompson@linaro.org>
+  - Jingoo Han <jingoohan1@gmail.com>
+
+description:
+  This binding is used to describe a basic backlight device made of LEDs. It
+  can also be used to describe a backlight device controlled by the output of
+  a LED driver.
+
+properties:
+  compatible:
+    const: led-backlight
+
+  leds:
+    description: A list of LED nodes
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+
+  brightness-levels:
+    description:
+      Array of distinct brightness levels. The levels must be in the range
+      accepted by the underlying LED devices. This is used to translate a
+      backlight brightness level into a LED brightness level. If it is not
+      provided, the identity mapping is used.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+
+  default-brightness-level:
+    description:
+      The default brightness level (index into the array defined by the
+      "brightness-levels" property).
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - compatible
+  - leds
+
+additionalProperties: false
+
+examples:
+  - |
+    backlight {
+        compatible = "led-backlight";
+
+        leds = <&led1>, <&led2>;
+        brightness-levels = <0 4 8 16 32 64 128 255>;
+        default-brightness-level = <6>;
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
deleted file mode 100644
index 64fa2fbd98c9..000000000000
--- a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.txt
+++ /dev/null
@@ -1,61 +0,0 @@
-pwm-backlight bindings
-
-Required properties:
-  - compatible: "pwm-backlight"
-  - pwms: OF device-tree PWM specification (see PWM binding[0])
-  - power-supply: regulator for supply voltage
-
-Optional properties:
-  - pwm-names: a list of names for the PWM devices specified in the
-               "pwms" property (see PWM binding[0])
-  - enable-gpios: contains a single GPIO specifier for the GPIO which enables
-                  and disables the backlight (see GPIO binding[1])
-  - post-pwm-on-delay-ms: Delay in ms between setting an initial (non-zero) PWM
-                          and enabling the backlight using GPIO.
-  - pwm-off-delay-ms: Delay in ms between disabling the backlight using GPIO
-                      and setting PWM value to 0.
-  - brightness-levels: Array of distinct brightness levels. Typically these
-                       are in the range from 0 to 255, but any range starting at
-                       0 will do. The actual brightness level (PWM duty cycle)
-                       will be interpolated from these values. 0 means a 0% duty
-                       cycle (darkest/off), while the last value in the array
-                       represents a 100% duty cycle (brightest).
-  - default-brightness-level: The default brightness level (index into the
-                              array defined by the "brightness-levels" property).
-  - num-interpolated-steps: Number of interpolated steps between each value
-                            of brightness-levels table. This way a high
-                            resolution pwm duty cycle can be used without
-                            having to list out every possible value in the
-                            brightness-level array.
-
-[0]: Documentation/devicetree/bindings/pwm/pwm.txt
-[1]: Documentation/devicetree/bindings/gpio/gpio.txt
-
-Example:
-
-	backlight {
-		compatible = "pwm-backlight";
-		pwms = <&pwm 0 5000000>;
-
-		brightness-levels = <0 4 8 16 32 64 128 255>;
-		default-brightness-level = <6>;
-
-		power-supply = <&vdd_bl_reg>;
-		enable-gpios = <&gpio 58 0>;
-		post-pwm-on-delay-ms = <10>;
-		pwm-off-delay-ms = <10>;
-	};
-
-Example using num-interpolation-steps:
-
-	backlight {
-		compatible = "pwm-backlight";
-		pwms = <&pwm 0 5000000>;
-
-		brightness-levels = <0 2048 4096 8192 16384 65535>;
-		num-interpolated-steps = <2048>;
-		default-brightness-level = <4096>;
-
-		power-supply = <&vdd_bl_reg>;
-		enable-gpios = <&gpio 58 0>;
-	};
diff --git a/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.yaml
new file mode 100644
index 000000000000..fcb8429f3088
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/backlight/pwm-backlight.yaml
@@ -0,0 +1,104 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/backlight/pwm-backlight.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: pwm-backlight bindings
+
+maintainers:
+  - Lee Jones <lee.jones@linaro.org>
+  - Daniel Thompson <daniel.thompson@linaro.org>
+  - Jingoo Han <jingoohan1@gmail.com>
+
+properties:
+  compatible:
+    const: pwm-backlight
+
+  pwms:
+    maxItems: 1
+
+  pwm-names: true
+
+  power-supply:
+    description: regulator for supply voltage
+
+  enable-gpios:
+    description:
+      Contains a single GPIO specifier for the GPIO which enables and disables
+      the backlight.
+    maxItems: 1
+
+  post-pwm-on-delay-ms:
+    description:
+      Delay in ms between setting an initial (non-zero) PWM and enabling the
+      backlight using GPIO.
+
+  pwm-off-delay-ms:
+    description:
+      Delay in ms between disabling the backlight using GPIO and setting PWM
+      value to 0.
+
+  brightness-levels:
+    description:
+      Array of distinct brightness levels. Typically these are in the range
+      from 0 to 255, but any range starting at 0 will do. The actual brightness
+      level (PWM duty cycle) will be interpolated from these values. 0 means a
+      0% duty cycle (darkest/off), while the last value in the array represents
+      a 100% duty cycle (brightest).
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+
+  default-brightness-level:
+    description:
+      The default brightness level (index into the array defined by the
+      "brightness-levels" property).
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  num-interpolated-steps:
+    description:
+      Number of interpolated steps between each value of brightness-levels
+      table. This way a high resolution pwm duty cycle can be used without
+      having to list out every possible value in the brightness-level array.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+dependencies:
+  default-brightness-level: [brightness-levels]
+  num-interpolated-steps: [brightness-levels]
+
+required:
+  - compatible
+  - pwms
+  - power-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    backlight {
+        compatible = "pwm-backlight";
+        pwms = <&pwm 0 5000000>;
+
+        brightness-levels = <0 4 8 16 32 64 128 255>;
+        default-brightness-level = <6>;
+
+        power-supply = <&vdd_bl_reg>;
+        enable-gpios = <&gpio 58 0>;
+        post-pwm-on-delay-ms = <10>;
+        pwm-off-delay-ms = <10>;
+    };
+
+  - |
+    // Example using num-interpolation-steps:
+    backlight {
+        compatible = "pwm-backlight";
+        pwms = <&pwm 0 5000000>;
+
+        brightness-levels = <0 2048 4096 8192 16384 65535>;
+        num-interpolated-steps = <2048>;
+        default-brightness-level = <4096>;
+
+        power-supply = <&vdd_bl_reg>;
+        enable-gpios = <&gpio 58 0>;
+    };
+
+...
-- 
2.25.1

