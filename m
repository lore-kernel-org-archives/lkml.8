Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEBA8C83009
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 16:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9495F20787
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 16:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y1j6BiIu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgD2QYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 12:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726815AbgD2QYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 12:24:46 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC76C03C1AD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 09:24:45 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id x4so2730058wmj.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 09:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PO/QuZ0Mf9WVJ0nQTHWav3atsf9nZINDw/pc6PWqalY=;
        b=y1j6BiIuOhRN1dvoRmKbvKatc/isFom1aaGdjrGoOQQ0T2PaBNDEzbA8XAvy9E19/c
         AIvfv0ZyNvWHgj+CykeiUt4jhzLK6akzbOiM/Vx115omW9dYQZJ250cLCDWpDMZtmoq6
         PH9X2kcsdETqXYEnHaSpeJ02UL9qzdXNwut5aazj+opWl/7DF3TjfhcTvoUjvx/lGcmA
         o8aBWz5vYOvpQsUxNMacdm9OK6iqUSSx9+2EsWL8F87ysfPJfLUhPQZoOXrWrB9o1VsC
         ZOy7V5xro9AqSQIdvOL+shKHHQbUo5vf5biUf95Ib6ZqQcsHk10sHq959BCK0yYOhjHF
         sgcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PO/QuZ0Mf9WVJ0nQTHWav3atsf9nZINDw/pc6PWqalY=;
        b=ZtLiNS7pe5kaP2OiyOEBfA7sNRpqWEcB+/8pSGFLrbYlfWv8cUPhy36wFE9UVoHhOF
         YcX6owx5BXmoEE7Hgj/vAn1kBTIEwBe/8XyrtHOB1JJhiWnyRaEgNP4D2ektwZN4wsZI
         z8Mug+xSTnDiEAxv+KfEGCp/8/oAt+/aYjgG9L+HF0fXv6ZrDwpvhohpxpn5eYwF9DC5
         p0BILx3rYcpRaxohkV0xUO8IG6szsIP6R7X7yMtJ5bJUiWQ7AeqSDh4VloTsVGRcCHjz
         wlvClINI9+t1IDrwHvsU9F6QO6/bewG1yvQiM8etKH5N9yRCGFGlgj14rqM08y2fQMIV
         X+QA==
X-Gm-Message-State: AGi0PuYMeVWGnMLsfugQygBjSzQMsvOjTDOLZZGeenoCq92QWJ/QEGEW
        /6plmvGkQVVHLnJysJLsDwfrUw==
X-Google-Smtp-Source: APiQypKjEZtumdB0vyxxWl7b7ZZQsrE9L+WMl0/qJ3WHrloyA2hmeAmRRPgp8Fl+zd6uOPynEHdmqw==
X-Received: by 2002:a1c:9a16:: with SMTP id c22mr4014872wme.38.1588177483772;
        Wed, 29 Apr 2020 09:24:43 -0700 (PDT)
Received: from xps7590.local ([37.120.81.28])
        by smtp.gmail.com with ESMTPSA id h2sm32616554wro.9.2020.04.29.09.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 09:24:43 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Maxime Ripard <maxime@cerno.tech>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Dongchun Zhu <dongchun.zhu@mediatek.com>,
        Fabio Estevam <festevam@gmail.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Robert Foss <robert.foss@linaro.org>,
        Maxime Ripard <mripard@kernel.org>
Subject: [PATCH v9 1/3] media: dt-bindings: ov8856: Document YAML bindings
Date:   Wed, 29 Apr 2020 18:24:35 +0200
Message-Id: <20200429162437.2025699-2-robert.foss@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200429162437.2025699-1-robert.foss@linaro.org>
References: <20200429162437.2025699-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dongchun Zhu <dongchun.zhu@mediatek.com>

This patch adds documentation of device tree in YAML schema for the
OV8856 CMOS image sensor.

Signed-off-by: Dongchun Zhu <dongchun.zhu@mediatek.com>
Signed-off-by: Robert Foss <robert.foss@linaro.org>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
---

- Changes since v8:
  * Maxime: Added r-b

- Changes since v7:
  * Marco: Make 'port' property optional
  * Maxime & Sakari: Add 'link-frequencies' property to dt binding
  * robher: Improve description for 'port' property

- Changes since v6:
  * Marco: remove qcom specifics from DT example
   
- Changes since v5:
  * Add assigned-clocks and assigned-clock-rates
  * robher: dt-schema errors

- Changes since v4:
  * Fabio: Change reset-gpio to GPIO_ACTIVE_LOW, explain in description
  * Add clock-lanes property to example
  * robher: Fix syntax error in devicetree example

- Changes since v3:
  * robher: Fix syntax error
  * robher: Removed maxItems
  * Fixes yaml 'make dt-binding-check' errors

- Changes since v2:
  Fixes comments from from Andy, Tomasz, Sakari, Rob.
  * Convert text documentation to YAML schema.

- Changes since v1:
  Fixes comments from Sakari, Tomasz
  * Add clock-frequency and link-frequencies in DT

 .../devicetree/bindings/media/i2c/ov8856.yaml | 140 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 141 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/ov8856.yaml

diff --git a/Documentation/devicetree/bindings/media/i2c/ov8856.yaml b/Documentation/devicetree/bindings/media/i2c/ov8856.yaml
new file mode 100644
index 000000000000..f78d3eae81cb
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/ov8856.yaml
@@ -0,0 +1,140 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (c) 2019 MediaTek Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/i2c/ov8856.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Omnivision OV8856 CMOS Sensor Device Tree Bindings
+
+maintainers:
+  - Ben Kao <ben.kao@intel.com>
+  - Dongchun Zhu <dongchun.zhu@mediatek.com>
+
+description: |-
+  The Omnivision OV8856 is a high performance, 1/4-inch, 8 megapixel, CMOS
+  image sensor that delivers 3264x2448 at 30fps. It provides full-frame,
+  sub-sampled, and windowed 10-bit MIPI images in various formats via the
+  Serial Camera Control Bus (SCCB) interface. This chip is programmable
+  through I2C and two-wire SCCB. The sensor output is available via CSI-2
+  serial data output (up to 4-lane).
+
+properties:
+  compatible:
+    const: ovti,ov8856
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
+      - const: xvclk
+
+  clock-frequency:
+    description:
+      Frequency of the xvclk clock in Hertz.
+
+  dovdd-supply:
+    description:
+      Definition of the regulator used as interface power supply.
+
+  avdd-supply:
+    description:
+      Definition of the regulator used as analog power supply.
+
+  dvdd-supply:
+    description:
+      Definition of the regulator used as digital power supply.
+
+  reset-gpios:
+    description:
+      The phandle and specifier for the GPIO that controls sensor reset.
+      This corresponds to the hardware pin XSHUTDOWN which is physically
+      active low.
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
+
+        properties:
+          clock-lanes:
+            maxItems: 1
+
+          data-lanes:
+            maxItems: 1
+
+          link-frequencies:
+            maxItems: 1
+
+          remote-endpoint: true
+
+        required:
+          - clock-lanes
+          - data-lanes
+          - remote-endpoint
+          - link-frequencies
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
+  - dovdd-supply
+  - avdd-supply
+  - dvdd-supply
+  - reset-gpios
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
+        ov8856: camera@10 {
+            compatible = "ovti,ov8856";
+            reg = <0x10>;
+
+            reset-gpios = <&pio 111 GPIO_ACTIVE_LOW>;
+            pinctrl-names = "default";
+            pinctrl-0 = <&clk_24m_cam>;
+
+            clocks = <&cam_osc>;
+            clock-names = "xvclk";
+            clock-frequency = <19200000>;
+
+            avdd-supply = <&mt6358_vcama2_reg>;
+            dvdd-supply = <&mt6358_vcamd_reg>;
+            dovdd-supply = <&mt6358_vcamio_reg>;
+
+            port {
+                wcam_out: endpoint {
+                    remote-endpoint = <&mipi_in_wcam>;
+                    clock-lanes = <0>;
+                    data-lanes = <1 2 3 4>;
+                    link-frequencies = /bits/ 64 <360000000 180000000>;
+                };
+            };
+        };
+    };
+...
\ No newline at end of file
diff --git a/MAINTAINERS b/MAINTAINERS
index 26f281d9f32a..84b262afd13d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12489,6 +12489,7 @@ L:	linux-media@vger.kernel.org
 S:	Maintained
 T:	git git://linuxtv.org/media_tree.git
 F:	drivers/media/i2c/ov8856.c
+F:	Documentation/devicetree/bindings/media/i2c/ov8856.yaml
 
 OMNIVISION OV9640 SENSOR DRIVER
 M:	Petr Cvek <petrcvekcz@gmail.com>
-- 
2.25.1

