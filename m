Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB83C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 06:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E650B22202
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 06:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NunQtbmf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgDQGTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 02:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727820AbgDQGTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 02:19:34 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA72C0610D6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 23:19:33 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id v2so592088plp.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 23:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ww+ocuz+g0SY9n8NDJDmRUl2GmD1jwSQtouEoRqHOsc=;
        b=NunQtbmfsLHCz1HWyQjQfyc0kyROI+uTxjbULA8qzv+wzPcxUiBD7yBYdBI312OQpB
         nCcmSnsrT+yIUlKSXntD9tVqLFSNQ84CHJVIewCPqSUkRk6G7ZiLyxvSc7c21J3gquvR
         +ljbUKoVidZ4o0SxAA+sWo5xya0boAKzj6nkZQoHlQvV1PMicXAeqKIaH4SSh5oMuJbV
         TQSvqHXkoA2J0jpBoh+wIYqzAFgM5VY45+ESyn22gJzHpHmrmyLJYUjpmTz/RY/pBsE5
         bOwxuXm38luizO1ZkZ34kMWS8IP02auhQcadHTRRzophgf5HVsJPcYfPvmBqybdVo7EO
         q5+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ww+ocuz+g0SY9n8NDJDmRUl2GmD1jwSQtouEoRqHOsc=;
        b=Ps7lxXvwdKKGhKXI9dcrJKfj2XZlDwKrXu2tbbLZheSAAVmAqxqFVACjhqYlGmU157
         NNVzuFT9e3UgFmAYRSOY4Yx9geBiRbY8TtERzlZaQ11uduXXrRASW5CBZ0aa8B8UZlCq
         9/GGCOj33ogvd4PV8G6mjUlBwSVWl3LjeHXK5ViDyPjXj4V4lOgcGdc5EffKcYePQpfD
         OxsGGgKgrhLmhJX0+APp3QUQnSgj2ANyikRxGs4ZPE9GH7Bg57dK0MMT+hNbox0TPTmX
         zHcBRLhb6ysVBxbbaue3mxStgM7JvcKNve5e13R4Jh7TRBjEXqyEAIFsPZ1qEdgrAfDw
         YXdw==
X-Gm-Message-State: AGi0Pua3jHPWGitXTm7GB10BSILkTLRuhxINdYFQPUEH46Vaa1qzPgI/
        GrAEAz2watzpYLf56g4SIbH44g==
X-Google-Smtp-Source: APiQypLmCiwNY/ojl8PYjHaSVLcZEV9zYPH1MlmGgT4O7wFq+UDZcrECL7w2UxWnkp6rU5tY376niQ==
X-Received: by 2002:a17:902:6acc:: with SMTP id i12mr1981774plt.61.1587104372766;
        Thu, 16 Apr 2020 23:19:32 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id nu13sm4696201pjb.22.2020.04.16.23.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 23:19:32 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: pinctrl: qcom: Add sm8250 pinctrl bindings
Date:   Thu, 16 Apr 2020 23:19:06 -0700
Message-Id: <20200417061907.1226490-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200417061907.1226490-1-bjorn.andersson@linaro.org>
References: <20200417061907.1226490-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree binding Documentation details for Qualcomm SM8250
pinctrl driver.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 .../bindings/pinctrl/qcom,sm8250-pinctrl.yaml | 147 ++++++++++++++++++
 1 file changed, 147 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml
new file mode 100644
index 000000000000..6dc3b52f47cd
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml
@@ -0,0 +1,147 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/qcom,sm8250-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies, Inc. SM8250 TLMM block
+
+maintainers:
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
+
+description: |
+  This binding describes the Top Level Mode Multiplexer block found in the
+  SM8250 platform.
+
+properties:
+  compatible:
+    const: qcom,sm8250-pinctrl
+
+  reg:
+    minItems: 3
+    maxItems: 3
+
+  reg-names:
+    items:
+      - const: "west"
+      - const: "south"
+      - const: "north"
+
+  interrupts:
+    description: Specifies the TLMM summary IRQ
+    maxItems: 1
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    description:
+      Specifies the PIN numbers and Flags, as defined in defined in
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
+  wakeup-parent:
+    maxItems: 1
+
+#PIN CONFIGURATION NODES
+patternProperties:
+  '^.*$':
+    if:
+      type: object
+    then:
+      properties:
+        pins:
+          description:
+            List of gpio pins affected by the properties specified in this
+            subnode.
+          items:
+            oneOf:
+              - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-7][0-9])$"
+              - enum: [ sdc2_clk, sdc2_cmd, sdc2_data, ufs_reset ]
+          minItems: 1
+          maxItems: 36
+
+        function:
+          description:
+            Specify the alternative function to be configured for the specified
+            pins.
+
+          enum: [ aoss_cti, atest, audio_ref, cam_mclk, cci_async, cci_i2c,
+            cci_timer0, cci_timer1, cci_timer2, cci_timer3, cci_timer4, cri_trng,
+            cri_trng0, cri_trng1, dbg_out, ddr_bist, ddr_pxi0, ddr_pxi1,
+            ddr_pxi2, ddr_pxi3, dp_hot, dp_lcd, gcc_gp1, gcc_gp2, gcc_gp3, gpio,
+            ibi_i3c, jitter_bist, lpass_slimbus, mdp_vsync, mdp_vsync0,
+            mdp_vsync1, mdp_vsync2, mdp_vsync3, mi2s0_data0, mi2s0_data1,
+            mi2s0_sck, mi2s0_ws, mi2s1_data0, mi2s1_data1, mi2s1_sck, mi2s1_ws,
+            mi2s2_data0, mi2s2_data1, mi2s2_sck, mi2s2_ws, pci_e0, pci_e1,
+            pci_e2, phase_flag, pll_bist, pll_bypassnl, pll_clk, pll_reset,
+            pri_mi2s, prng_rosc, qdss_cti, qdss_gpio, qspi0, qspi1, qspi2, qspi3,
+            qspi_clk, qspi_cs, qup0, qup1, qup10, qup11, qup12, qup13, qup14,
+            qup15, qup16, qup17, qup18, qup19, qup2, qup3, qup4, qup5, qup6,
+            qup7, qup8, qup9, qup_l4, qup_l5, qup_l6, sd_write, sdc40, sdc41,
+            sdc42, sdc43, sdc4_clk, sdc4_cmd, sec_mi2s, sp_cmu, tgu_ch0, tgu_ch1,
+            tgu_ch2, tgu_ch3, tsense_pwm1, tsense_pwm2, tsif0_clk, tsif0_data,
+            tsif0_en, tsif0_error, tsif0_sync, tsif1_clk, tsif1_data, tsif1_en,
+            tsif1_error, tsif1_sync, usb2phy_ac, usb_phy, vsense_trigger ]
+
+        drive-strength:
+          enum: [2, 4, 6, 8, 10, 12, 14, 16]
+          default: 2
+          description:
+            Selects the drive strength for the specified pins, in mA.
+
+        bias-pull-down: true
+
+        bias-pull-up: true
+
+        bias-disable: true
+
+        output-high: true
+
+        output-low: true
+
+      required:
+        - pins
+        - function
+
+      additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - reg-names
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
+        pinctrl@1f00000 {
+                compatible = "qcom,sm8250-pinctrl";
+                reg = <0x0f100000 0x300000>,
+                      <0x0f500000 0x300000>,
+                      <0x0f900000 0x300000>;
+                reg-names = "west", "south", "north";
+                interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
+                gpio-controller;
+                #gpio-cells = <2>;
+                interrupt-controller;
+                #interrupt-cells = <2>;
+                gpio-ranges = <&tlmm 0 0 180>;
+                wakeup-parent = <&pdc>;
+        };
-- 
2.24.0

