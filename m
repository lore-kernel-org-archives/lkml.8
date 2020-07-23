Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4904C433EC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 15:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B82F2206E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 15:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ithbTwaA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729558AbgGWP0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 11:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgGWP0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 11:26:54 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF36CC0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 08:26:53 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id q5so5567792wru.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 08:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zeGJhn4QDCv7nHVcfBN1kEkOyeVk60ndJ+Wwf4G4XD8=;
        b=ithbTwaAxz5gEQyqNKS5Bgr8alt7QgnzfxZxjJOD22GNv7bw/z7+Mv9FziFhf2osFN
         M7l4Ta1TEBAqu5jbhVnArS15n2TW9DfPcJG4y5J/4Gx5ghIPSpbqVFIx0r+T4OJd4DLy
         AhKe6M5iim0KX1Ogub076YX1Y1RBT3a1rc4rNrX8dQ8rm6nZgDnUmxCx6On/Y/dSPdfc
         ZP12IT21nm+RRXaXPglA/+vvVtGAsnAJCLg5LXgTKNtsnadDiuWfWw9ge81/zORa+knG
         h+CrlR0F363lJ2GWrNQ+b82imr5aRHehlunZtZK8ywPVRKwR86/YDHmlQzkiVBLw11MG
         vEEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zeGJhn4QDCv7nHVcfBN1kEkOyeVk60ndJ+Wwf4G4XD8=;
        b=BIgrEBblhIGMmjsDSV/iXWgOHQFeezq+ASduIQwiELV6TXiVebdGEB7gsrGyctLE6k
         /BHJnltQ3tw4UQz9xp2m2U1keO3+ocFBXvyUuSet09ZTHFVLxn8t9i76pRTAi9H9vMwm
         LBMixwuB+zJ3LyJUvehdiWx07DyffAsh9mc2VHnJSHtJJX/C/Md6xb8q9/fr1UpZEZ+B
         hkwWRw7p7eWQP8PeWjcnsui33UZbBRQsgXKjPkD6CbVV6J9x+7swO/ynKlQX5/Vo4WlM
         K6wcUAfCasnMH5laTLu9N0JepyTrX04R9JoDeUt8EmzDUouLo1oC6x5d5M6w+hnSkQMp
         CzjQ==
X-Gm-Message-State: AOAM5329j8IAwEMK+YxUQDzNrZPc0mjph63p2FZDIK2UL+dTeKnhFOtS
        yfzi83eTeAlC8vQo17Nv4Ki6TQ==
X-Google-Smtp-Source: ABdhPJwQ7LHnyhS68zfPqiGMd5i53UtPOC/V7VxMNv2t0Y9efpOkBGLpTCqQlKTJsnUnFf321+vVaQ==
X-Received: by 2002:adf:d084:: with SMTP id y4mr4383828wrh.161.1595518012378;
        Thu, 23 Jul 2020 08:26:52 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:dca7:8d30:33fa:daac])
        by smtp.gmail.com with ESMTPSA id g145sm5963491wmg.23.2020.07.23.08.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 08:26:51 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Microchip
        (AT91) SoC support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 01/16] dt-bindings: atmel-tcb: convert bindings to json-schema
Date:   Thu, 23 Jul 2020 17:26:21 +0200
Message-Id: <20200723152639.639771-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1b1122f4-bce9-f349-e602-ed8e14cbb501@linaro.org>
References: <1b1122f4-bce9-f349-e602-ed8e14cbb501@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

Convert Atmel Timer Counter Blocks bindings to DT schema format using
json-schema.

Also move it out of mfd as it is not and has never been related to mfd.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200710230813.1005150-2-alexandre.belloni@bootlin.com
---
 .../devicetree/bindings/mfd/atmel-tcb.txt     |  56 --------
 .../soc/microchip/atmel,at91rm9200-tcb.yaml   | 131 ++++++++++++++++++
 2 files changed, 131 insertions(+), 56 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-tcb.txt
 create mode 100644 Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml

diff --git a/Documentation/devicetree/bindings/mfd/atmel-tcb.txt b/Documentation/devicetree/bindings/mfd/atmel-tcb.txt
deleted file mode 100644
index c4a83e364cb6..000000000000
--- a/Documentation/devicetree/bindings/mfd/atmel-tcb.txt
+++ /dev/null
@@ -1,56 +0,0 @@
-* Device tree bindings for Atmel Timer Counter Blocks
-- compatible: Should be "atmel,<chip>-tcb", "simple-mfd", "syscon".
-  <chip> can be "at91rm9200" or "at91sam9x5"
-- reg: Should contain registers location and length
-- #address-cells: has to be 1
-- #size-cells: has to be 0
-- interrupts: Should contain all interrupts for the TC block
-  Note that you can specify several interrupt cells if the TC
-  block has one interrupt per channel.
-- clock-names: tuple listing input clock names.
-	Required elements: "t0_clk", "slow_clk"
-	Optional elements: "t1_clk", "t2_clk"
-- clocks: phandles to input clocks.
-
-The TCB can expose multiple subdevices:
- * a timer
-   - compatible: Should be "atmel,tcb-timer"
-   - reg: Should contain the TCB channels to be used. If the
-     counter width is 16 bits (at91rm9200-tcb), two consecutive
-     channels are needed. Else, only one channel will be used.
-
-Examples:
-
-One interrupt per TC block:
-	tcb0: timer@fff7c000 {
-		compatible = "atmel,at91rm9200-tcb", "simple-mfd", "syscon";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		reg = <0xfff7c000 0x100>;
-		interrupts = <18 4>;
-		clocks = <&tcb0_clk>, <&clk32k>;
-		clock-names = "t0_clk", "slow_clk";
-
-		timer@0 {
-			compatible = "atmel,tcb-timer";
-			reg = <0>, <1>;
-		};
-
-		timer@2 {
-			compatible = "atmel,tcb-timer";
-			reg = <2>;
-		};
-	};
-
-One interrupt per TC channel in a TC block:
-	tcb1: timer@fffdc000 {
-		compatible = "atmel,at91rm9200-tcb", "simple-mfd", "syscon";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		reg = <0xfffdc000 0x100>;
-		interrupts = <26 4>, <27 4>, <28 4>;
-		clocks = <&tcb1_clk>, <&clk32k>;
-		clock-names = "t0_clk", "slow_clk";
-	};
-
-
diff --git a/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml b/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
new file mode 100644
index 000000000000..9d680e0b9109
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
@@ -0,0 +1,131 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/soc/microchip/atmel,at91rm9200-tcb.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Atmel Timer Counter Block
+
+maintainers:
+  - Alexandre Belloni <alexandre.belloni@bootlin.com>
+
+description: |
+  The Atmel (now Microchip) SoCs have timers named Timer Counter Block. Each
+  timer has three channels with two counters each.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - atmel,at91rm9200-tcb
+          - atmel,at91sam9x5-tcb
+      - const: simple-mfd
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description:
+      List of interrupts. One interrupt per TCB channel if available or one
+      interrupt for the TC block
+    minItems: 1
+    maxItems: 3
+
+  clock-names:
+    description:
+      List of clock names. Always includes t0_clk and slow clk. Also includes
+      t1_clk and t2_clk if a clock per channel is available.
+    oneOf:
+      - items:
+        - const: t0_clk
+        - const: slow_clk
+      - items:
+        - const: t0_clk
+        - const: t1_clk
+        - const: t2_clk
+        - const: slow_clk
+    minItems: 2
+    maxItems: 4
+
+  clocks:
+    minItems: 2
+    maxItems: 4
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+patternProperties:
+  "^timer@[0-2]$":
+    description: The timer block channels that are used as timers.
+    type: object
+    properties:
+      compatible:
+        const: atmel,tcb-timer
+      reg:
+        description:
+          List of channels to use for this particular timer.
+        minItems: 1
+        maxItems: 3
+
+    required:
+      - compatible
+      - reg
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - '#address-cells'
+  - '#size-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    /* One interrupt per TC block: */
+        tcb0: timer@fff7c000 {
+                compatible = "atmel,at91rm9200-tcb", "simple-mfd", "syscon";
+                #address-cells = <1>;
+                #size-cells = <0>;
+                reg = <0xfff7c000 0x100>;
+                interrupts = <18 4>;
+                clocks = <&tcb0_clk>, <&clk32k>;
+                clock-names = "t0_clk", "slow_clk";
+
+                timer@0 {
+                        compatible = "atmel,tcb-timer";
+                        reg = <0>, <1>;
+                };
+
+                timer@2 {
+                        compatible = "atmel,tcb-timer";
+                        reg = <2>;
+                };
+        };
+
+    /* One interrupt per TC channel in a TC block: */
+        tcb1: timer@fffdc000 {
+                compatible = "atmel,at91rm9200-tcb", "simple-mfd", "syscon";
+                #address-cells = <1>;
+                #size-cells = <0>;
+                reg = <0xfffdc000 0x100>;
+                interrupts = <26 4>, <27 4>, <28 4>;
+                clocks = <&tcb1_clk>, <&clk32k>;
+                clock-names = "t0_clk", "slow_clk";
+
+                timer@0 {
+                        compatible = "atmel,tcb-timer";
+                        reg = <0>;
+                };
+
+                timer@1 {
+                        compatible = "atmel,tcb-timer";
+                        reg = <1>;
+                };
+        };
-- 
2.25.1

