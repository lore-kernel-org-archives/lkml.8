Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6E3C433E7
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 21:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C129D20787
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 21:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=snejp.pl header.i=@snejp.pl header.b="VEGb0b5w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgGPVaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 17:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbgGPVaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 17:30:05 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A520C08C5CE
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 14:30:04 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id o4so4747107lfi.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 14:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snejp.pl; s=gmail;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m97woWgyvZCjuCpnu/GEoCGoRJXZfOl1hveBqC5I7xc=;
        b=VEGb0b5w2JIwKewUBzZ4y5nul6+pCFtgBRFmBzmmpi0ZMFr5A81CuXS0Yxf3u+xVoD
         QkNTHEK+Ax+G7Vfg3DGFohOTqjnBy5vsGY8QT99rvmw2iR2C/3QHM26PWeIw1+G+76WY
         gT0dDvAq0+hmpF1zN6hdYxqaRPaq3foOL90M/31IgDfYrXSnRopmuhRjgay9oIJIuSIB
         eBb8IKktcH/5aPBxhfkZKnSc9Cvjg8d5xR56OWe/xo9e6T3E5vYVPL/tFM/VU/dsTDoW
         3GMKGVxxf8i/qkH+4sqIfO+acutWbnv1YaN/vV6WtARML+L0CFP3zQ1xO52PcGds6+IG
         J8Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m97woWgyvZCjuCpnu/GEoCGoRJXZfOl1hveBqC5I7xc=;
        b=gK7Rj2AOOEVXEBjRzTrY6pRK8jRm/8miNWAqd64FwyGA7bKFQwgWrEJivLc0qQYv+x
         cjLpipm8ZSxz+vTJ3PAU6+3H1x65cHsBDPtoLKOdYHqsjHECtKKgLyGfz+/75xqCnkbc
         er3Cs+L3xwjo2LuiAdQ39BHz5CuoezBKEQlFGHqpv5j/0/EtUrjKQk0dUpVLzefq+eUL
         34vkwvwW48CdSw5E8HTa7dyjXtbUmvXi3581tULmcd77A2WDv33KppyN70v2GYKjOlNm
         LpkE4ze+bC5FoWoP50KpupIX/y832P03Wh0jycZGUJHTAEYBEIOISP8BAzWLrAtvzWSr
         M5zg==
X-Gm-Message-State: AOAM532k/z9X6ZqcL3rMjgaw5sNNFa8MqbkQ5D6r5lLp2bDu/RxB9zO4
        /kgiQUuOsSpUCV5zvOvbHLFpmA==
X-Google-Smtp-Source: ABdhPJzzanQLJNKReGHkVwKDHf2cPzf5eJKIX1Jk7KiReEQC2PBaX3JrvsVz7ZuOdI75+Xbttej3Aw==
X-Received: by 2002:a19:6a14:: with SMTP id u20mr2896420lfu.172.1594935002942;
        Thu, 16 Jul 2020 14:30:02 -0700 (PDT)
Received: from PackardBell ([82.160.139.10])
        by smtp.gmail.com with ESMTPSA id m11sm1274763ljj.122.2020.07.16.14.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 14:30:02 -0700 (PDT)
Received: from localhost (PackardBell [local])
        by PackardBell (OpenSMTPD) with ESMTPA id 0a7ea6a0;
        Thu, 16 Jul 2020 21:30:01 +0000 (UTC)
From:   Bartosz Dudziak <bartosz.dudziak@snejp.pl>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Bartosz Dudziak <bartosz.dudziak@snejp.pl>,
        Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: pinctrl: qcom: Add msm8226 pinctrl bindings
Date:   Thu, 16 Jul 2020 22:55:28 +0200
Message-Id: <20200716205530.22910-2-bartosz.dudziak@snejp.pl>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200716205530.22910-1-bartosz.dudziak@snejp.pl>
References: <20200716205530.22910-1-bartosz.dudziak@snejp.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree binding Documentation details for Qualcomm msm8226
pinctrl driver.

- Bindings documentation was based on qcom,ipq6018-pinctrl.yaml added by
  Sricharan R <sricharan@codeaurora.org> and then modified for msm8226
  content

Signed-off-by: Bartosz Dudziak <bartosz.dudziak@snejp.pl>
---
 .../pinctrl/qcom,msm8226-pinctrl.yaml         | 132 ++++++++++++++++++
 1 file changed, 132 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml
new file mode 100644
index 0000000000..1f0f5757f9
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8226-pinctrl.yaml
@@ -0,0 +1,132 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/qcom,msm8226-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies, Inc. MSM8226 TLMM block
+
+maintainers:
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
+
+description: |
+  This binding describes the Top Level Mode Multiplexer block found in the
+  MSM8226 platform.
+
+properties:
+  compatible:
+    const: qcom,msm8226-pinctrl
+
+  reg:
+    description: Specifies the base address and size of the TLMM register space
+    maxItems: 1
+
+  interrupts:
+    description: Specifies the TLMM summary IRQ
+    maxItems: 1
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    description: Specifies the PIN numbers and Flags, as defined in
+      include/dt-bindings/interrupt-controller/irq.h
+    const: 2
+
+  gpio-controller: true
+
+  '#gpio-cells':
+    description: Specifying the pin number and flags, as defined in
+      include/dt-bindings/gpio/gpio.h
+    const: 2
+
+  gpio-ranges:
+    maxItems: 1
+
+  gpio-reserved-ranges:
+    maxItems: 1
+
+#PIN CONFIGURATION NODES
+patternProperties:
+  '-pins$':
+    type: object
+    description:
+      Pinctrl node's client devices use subnodes for desired pin configuration.
+      Client device subnodes use below standard properties.
+    $ref: "/schemas/pinctrl/pincfg-node.yaml"
+
+    properties:
+      pins:
+        description:
+          List of gpio pins affected by the properties specified in this
+          subnode.
+        items:
+          oneOf:
+            - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-1][0-6])$"
+            - enum: [ sdc1_clk, sdc1_cmd, sdc1_data, sdc2_clk, sdc2_cmd, sdc2_data ]
+        minItems: 1
+        maxItems: 36
+
+      function:
+        description:
+          Specify the alternative function to be configured for the specified
+          pins. Functions are only valid for gpio pins.
+        enum: [ gpio, cci_i2c0, blsp_uim1, blsp_uim2, blsp_uim3, blsp_uim5,
+          blsp_i2c1, blsp_i2c2, blsp_i2c3, blsp_i2c5, blsp_spi1,
+          blsp_spi2, blsp_spi3, blsp_spi5, blsp_uart1, blsp_uart2,
+          blsp_uart3, blsp_uart5, cam_mclk0, cam_mclk1, wlan ]
+
+      drive-strength:
+        enum: [2, 4, 6, 8, 10, 12, 14, 16]
+        default: 2
+        description:
+          Selects the drive strength for the specified pins, in mA.
+
+      bias-pull-down: true
+
+      bias-pull-up: true
+
+      bias-disable: true
+
+      output-high: true
+
+      output-low: true
+
+    required:
+      - pins
+      - function
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-controller
+  - '#interrupt-cells'
+  - gpio-controller
+  - '#gpio-cells'
+  - gpio-ranges
+
+additionalProperties: false
+
+examples:
+  - |
+        #include <dt-bindings/interrupt-controller/arm-gic.h>
+        msmgpio: pinctrl@fd510000 {
+                compatible = "qcom,msm8226-pinctrl";
+                reg = <0xfd510000 0x4000>;
+
+                gpio-controller;
+                #gpio-cells = <2>;
+                gpio-ranges = <&msmgpio 0 0 117>;
+                interrupt-controller;
+                #interrupt-cells = <2>;
+                interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+
+                serial-pins {
+                        pins = "gpio8", "gpio9";
+                        function = "blsp_uart3";
+                        drive-strength = <8>;
+                        bias-disable;
+                };
+        };
-- 
2.25.1

