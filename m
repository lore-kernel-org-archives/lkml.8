Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A8AC2BBD0
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 22:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EB6320767
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 22:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YnRGeZlO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgIBWsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 18:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbgIBWsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 18:48:22 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2794C061251
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 15:48:20 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id e16so1061384wrm.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 15:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DSUUqflNM89hjEoS2I4y9vcCANSdclOkuUNrQ1yjm0A=;
        b=YnRGeZlOf5WRkMrLiwxfOTIOZrblf+8LvustYSwJjGwoiV+xkhkgZ5vR0vqd/E7tNU
         iLDk3apR1rm6cpIjFAWF8NUj54FDdNyfSCJWfXZ8EA2E/ESYqqgRoewLqBHMxXHBI6dj
         TfMbS6nXDV2vNL7LP7RgPwIacTPAGkkbZniHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DSUUqflNM89hjEoS2I4y9vcCANSdclOkuUNrQ1yjm0A=;
        b=s/NaHdjyN6LRAS5n9Kqde406j+qLN0RzUhIg8gers2pl3nLx/YjZ8G74MfwPyZL2VM
         cMFPl7K1vRisC+B2A2/GCGrNulxrsyIy/AZsvSzFToS6jJ/b+DEd3ePnMO6HXQHm7xL0
         CYC38X3mO2g07DMLJ2thP9xfj/LmXMQferjcQ4oRXCz+ZhSYqmI/xsj8lkSVvQNZ000K
         FH6iUM6+FqLIzChLzJT2ndC1oI1s4D5V28ltx+2NLVNsxEGGsSRRSHceAcArOUMGhBQ2
         IRHaZ+ZFb60z2yGq4r29vYjyj5CL2VEIPdEtZynybdKw+AxTKCIRJopU4qVQC7/tmFLm
         byeA==
X-Gm-Message-State: AOAM530t6busg1835pHIO22Ael0nWCKNqLtwZlePqKpXhvn0BvfNBnAL
        LW8PYJTSqlqxmZemEoOvbp7iB3XD3pPQrw==
X-Google-Smtp-Source: ABdhPJyl45V678eQ5ZC9Fv+EL/uZUE+NbzZKSZ3FYEDQoVT7GWMVpVHMyTNFuHDK4E7yfFBiMp/0wQ==
X-Received: by 2002:a5d:522d:: with SMTP id i13mr405043wra.296.1599086898980;
        Wed, 02 Sep 2020 15:48:18 -0700 (PDT)
Received: from tfiga.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id m125sm1557568wme.35.2020.09.02.15.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 15:48:18 -0700 (PDT)
From:   Tomasz Figa <tfiga@chromium.org>
To:     linux-media@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hao He <hao.he@bitland.com.cn>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, drinkcat@chromium.org,
        Xingyu Wu <wuxy@bitland.com.cn>, dongchun.zhu@mediatek.com,
        sj.huang@mediatek.com, darfur_liu@gcoreinc.com, hao.he7@gmail.com,
        Tomasz Figa <tfiga@chromium.org>
Subject: [PATCH v4 2/4] media: dt-bindings: media: i2c: Add bindings for GC5035
Date:   Wed,  2 Sep 2020 22:48:11 +0000
Message-Id: <20200902224813.14283-3-tfiga@chromium.org>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
In-Reply-To: <20200902224813.14283-1-tfiga@chromium.org>
References: <20200902224813.14283-1-tfiga@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add YAML device tree bindings for Galaxycore Inc. GC5035 imaging sensor.

Signed-off-by: Tomasz Figa <tfiga@chromium.org>
---
 .../devicetree/bindings/media/i2c/gc5035.yaml | 142 ++++++++++++++++++
 1 file changed, 142 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/gc5035.yaml

diff --git a/Documentation/devicetree/bindings/media/i2c/gc5035.yaml b/Documentation/devicetree/bindings/media/i2c/gc5035.yaml
new file mode 100644
index 000000000000..cf8cc3b581cf
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/gc5035.yaml
@@ -0,0 +1,142 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (c) 2019 MediaTek Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/i2c/gc5035.yaml
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Galaxycore Inc. GC5035 CMOS Sensor Device Tree Bindings
+
+maintainers:
+  - Tomasz Figa <tfiga@chromium.org>
+
+description: |-
+  The Galaxycore Inc. GC5035 is a 5 megapixel, 1/5 inch CMOS 10-bit Bayer image
+  sensor that delivers 2592x1944 at 30fps. This chip is programmable through
+  an I2C interface. The image output is available via a MIPI CSI-2 interface.
+
+properties:
+  compatible:
+    const: galaxycore,gc5035
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    description:
+      Input clock for the sensor.
+    items:
+      - const: inclk
+
+  clock-frequency:
+    description:
+      Frequency of the inclk clock in Hz.
+
+  iovdd-supply:
+    description:
+      Regulator driving the I/O power rail.
+
+  avdd28-supply:
+    description:
+      Regulator driving the analog power rail.
+
+  dvdd12-supply:
+    description:
+      Regulator driving the digital power rail.
+
+  resetb-gpios:
+    description:
+      The GPIO pin that drives the RESETB signal, controlling sensor reset.
+      The RESETB signal must be driven low to activate the reset, so the
+      GPIO_ACTIVE_LOW flag should be given by default.
+
+  pwdn-gpios:
+    description:
+      The GPIO pin that drives the PWDN signal, controlling sensor power-down
+      mode. The PWDN signal must be driven low to activate the power-down
+      mode, so the GPIO_ACTIVE_LOW flag should be given by default.
+
+  port:
+    type: object
+    additionalProperties: false
+    description:
+      A node containing an output port node with an endpoint definition
+      as documented in
+      Documentation/devicetree/bindings/media/video-interfaces.txt
+
+    properties:
+      endpoint:
+        type: object
+        additionalProperties: false
+
+        properties:
+          data-lanes:
+            items:
+              - const: 1
+              - const: 2
+
+          link-frequencies: true
+          remote-endpoint: true
+
+        required:
+          - data-lanes
+          - link-frequencies
+          - remote-endpoint
+
+    required:
+      - endpoint
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - clock-frequency
+  - iovdd-supply
+  - avdd28-supply
+  - dvdd12-supply
+  - resetb-gpios
+  - pwdn-gpios
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        gc5035: camera@10 {
+            compatible = "galaxycore,gc5035";
+            reg = <0x10>;
+
+            reset-gpios = <&pio 111 GPIO_ACTIVE_LOW>;
+            pwdn-gpios = <&pio 112 GPIO_ACTIVE_LOW>;
+            pinctrl-names = "default";
+            pinctrl-0 = <&clk_24m_cam>;
+
+            clocks = <&cam_osc>;
+            clock-names = "inclk";
+            clock-frequency = <24000000>;
+
+            avdd28-supply = <&mt6358_vcama2_reg>;
+            dvdd12-supply = <&mt6358_vcamd_reg>;
+            iovdd-supply = <&mt6358_vcamio_reg>;
+
+            port {
+                wcam_out: endpoint {
+                    remote-endpoint = <&mipi_in_wcam>;
+                    data-lanes = <1 2>;
+                    link-frequencies = /bits/ 64 <438000000>;
+                };
+            };
+        };
+    };
+...
+
-- 
2.28.0.402.g5ffc5be6b7-goog

