Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A85C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 12:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8299D20890
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 12:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EzT5LNBw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbgGBMhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 08:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729049AbgGBMhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 08:37:20 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4EFC08C5C1;
        Thu,  2 Jul 2020 05:37:20 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id c1so5220876pja.5;
        Thu, 02 Jul 2020 05:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=hs09kBqZUpojWMERTQ68P9qxiV/sd6ftXrgMPytiT7Y=;
        b=EzT5LNBwf/h98OqjqMSVZVIWKn5l5WdGWvLAvE5/9DC613F4RitINTAWzG8kF8Beu0
         nWAku3yaWCaq7kwdrykytMLZg78QUm84jskHnMq0wSE05tvSv43k0vXv9T6caLc13hix
         TuxoTxbi6ceX25Ln9wR98zCa6acL1Dp9GZdtuWdJXlSMTVy8HymjktiODWEV2r8eGTMz
         ebo4qOnZ+qfqRkIqx06IscH9nBGYJZwcCeRzvHk2QA8cc/MCP0EInNfqZo/NplsAYKCc
         GdJS07DbDtc2dA0HgB0v0e1PX01zkP+pJm2MF4bUQduyOP+l/mRbwbJdXkdnATFf0P2i
         c0jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hs09kBqZUpojWMERTQ68P9qxiV/sd6ftXrgMPytiT7Y=;
        b=SPql515WPcs1omA7z393tWd2kK1bZhevyu7fEFxQowjZLeS9VemHMbBnDcEI3dGaGh
         NHffv2Afy2vAAnnLhjG1vCOZ+GuRX8sqcj5W+AhqP0uGpyq0WGbuAULiFi8TVUP0PYlz
         7iqh92ztQ0c8RwiMtpqLQal3xkYZAGeccIFi7R9UkCXHW041UiS0HwA5a47TgCqhUHUb
         m1VibI2vLwu+dBo0f5+LGBgLHTcARu07QDt9TPg+7w664OC0r3sZX38h9eOOS/x8vzUT
         G6vP4d0y/iP+6RyaQu9ko6YcJK/ZZuH8tBHlFr6P6Af3GhHXUZM3tccPQqfbb2Z/r13e
         22DQ==
X-Gm-Message-State: AOAM531S/cjniIddLropSynajPwh+hIrvGUkK6dRH9555QVRIg5Z8fy0
        /52m6uS0sj8HguLOhlXUISA=
X-Google-Smtp-Source: ABdhPJw3BcEUt+Jj9BBLi3GC4UcKJpo5HvV09Zdvy+VFGcRhfiGbaYFDsEDnhLsML+VFnoxbDFtEBg==
X-Received: by 2002:a17:90a:f014:: with SMTP id bt20mr33359387pjb.135.1593693440133;
        Thu, 02 Jul 2020 05:37:20 -0700 (PDT)
Received: from localhost.localdomain ([122.172.43.9])
        by smtp.gmail.com with ESMTPSA id q14sm8720421pgk.86.2020.07.02.05.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 05:37:19 -0700 (PDT)
From:   Vinay Simha BN <simhavcs@gmail.com>
Cc:     Vinay Simha BN <simhavcs@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 1/2] dt-binding: Add DSI/LVDS TC358775 bridge bindings
Date:   Thu,  2 Jul 2020 18:06:33 +0530
Message-Id: <20200702123651.12177-1-simhavcs@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Vinay Simha BN <simhavcs@gmail.com>

---
v1:
 Initial version wast .txt file

v2:
 From txt to yaml file format

v3:
* Andrzej Hajda review comments incorporated
  dual port lvds implemented

* Laurent Pinchart review comments incorporated
  dsi lanes property removed and it is dynamically
  picked from the dsi ports
  VESA/JEIDA format picked from panel-lvds dts

v4:
* Sam Ravnborg review comments incorporated
  }' is indented properly in examples data-lanes
  description for single-link and dual-link lvds
---
 .../display/bridge/toshiba,tc358775.yaml      | 215 ++++++++++++++++++
 1 file changed, 215 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/toshiba,tc358775.yaml

diff --git a/Documentation/devicetree/bindings/display/bridge/toshiba,tc358775.yaml b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358775.yaml
new file mode 100644
index 000000000000..9ddd63bee403
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358775.yaml
@@ -0,0 +1,215 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/bridge/toshiba,tc358775.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Toshiba TC358775 DSI to LVDS bridge bindings
+
+maintainers:
+ - Vinay Simha BN <simhavcs@gmail.com>
+
+description: |
+ This binding supports DSI to LVDS bridge TC358775
+
+ MIPI DSI-RX Data 4-lane, CLK 1-lane with data rates up to 800 Mbps/lane.
+ Video frame size:
+ Up to 1600x1200 24-bit/pixel resolution for single-link LVDS display panel
+ limited by 135 MHz LVDS speed
+ Up to WUXGA (1920x1200 24-bit pixels) resolution for dual-link LVDS display
+ panel, limited by 270 MHz LVDS speed.
+
+properties:
+  compatible:
+    const: toshiba,tc358775
+
+  reg:
+    maxItems: 1
+    description: i2c address of the bridge, 0x0f
+
+  vdd-supply:
+    maxItems: 1
+    description:  1.2V LVDS Power Supply
+
+  vddio-supply:
+    maxItems: 1
+    description: 1.8V IO Power Supply
+
+  stby-gpios:
+    maxItems: 1
+    description: Standby pin, Low active
+
+  reset-gpios:
+    maxItems: 1
+    description: Hardware reset, Low active
+
+  ports:
+    type: object
+    description:
+      A node containing input and output port nodes with endpoint definitions
+      as documented in
+      Documentation/devicetree/bindings/media/video-interfaces.txt
+    properties:
+      "#address-cells":
+        const: 1
+
+      "#size-cells":
+        const: 0
+
+      port@0:
+        type: object
+        description: |
+          DSI Input. The remote endpoint phandle should be a
+          reference to a valid mipi_dsi_host device node.
+
+      port@1:
+        type: object
+        description: |
+          Video port for LVDS output (panel or connector).
+
+      port@2:
+        type: object
+        description: |
+          Video port for Dual link LVDS output (panel or connector).
+
+    required:
+      - port@0
+      - port@1
+
+required:
+ - compatible
+ - reg
+ - vdd-supply
+ - vddio-supply
+ - stby-gpios
+ - reset-gpios
+ - ports
+
+examples:
+ - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    /* For single-link LVDS display panel */
+
+    i2c@78b8000 {
+        /* On High speed expansion */
+        label = "HS-I2C2";
+        reg = <0x078b8000 0x500>;
+        clock-frequency = <400000>; /* fastmode operation */
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        tc_bridge: bridge@f {
+            compatible = "toshiba,tc358775";
+            reg = <0x0f>;
+
+            vdd-supply = <&pm8916_l2>;
+            vddio-supply = <&pm8916_l6>;
+
+            stby-gpios = <&msmgpio 99 GPIO_ACTIVE_LOW>;
+            reset-gpios = <&msmgpio 72 GPIO_ACTIVE_LOW>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    d2l_in_test: endpoint {
+                        remote-endpoint = <&dsi0_out>;
+                    };
+                };
+
+                port@1 {
+                    reg = <1>;
+                    lvds_out: endpoint {
+                        remote-endpoint = <&panel_in>;
+                    };
+                };
+            };
+        };
+    };
+
+    dsi@1a98000 {
+        reg = <0x1a98000 0x25c>;
+        reg-names = "dsi_ctrl";
+
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            port@1 {
+                reg = <1>;
+                dsi0_out: endpoint {
+                    remote-endpoint = <&d2l_in_test>;
+                    data-lanes = <0 1 2 3>;
+                };
+             };
+         };
+     };
+
+ - |
+    /* For dual-link LVDS display panel */
+
+    i2c@78b8000 {
+        /* On High speed expansion */
+        label = "HS-I2C2";
+        reg = <0x078b8000 0x500>;
+        clock-frequency = <400000>; /* fastmode operation */
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        tc_bridge_dual: bridge@f {
+            compatible = "toshiba,tc358775";
+            reg = <0x0f>;
+
+            vdd-supply = <&pm8916_l2>;
+            vddio-supply = <&pm8916_l6>;
+
+            stby-gpios = <&msmgpio 99 GPIO_ACTIVE_LOW>;
+            reset-gpios = <&msmgpio 72 GPIO_ACTIVE_LOW>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    d2l_in_dual: endpoint {
+                        remote-endpoint = <&dsi0_out_dual>;
+                    };
+                };
+
+                port@1 {
+                    reg = <1>;
+                    lvds0_out: endpoint {
+                        remote-endpoint = <&panel_in0>;
+                    };
+                };
+
+                port@2 {
+                    reg = <2>;
+                    lvds1_out: endpoint {
+                        remote-endpoint = <&panel_in1>;
+                    };
+                };
+            };
+        };
+    };
+
+    dsi@1a98000 {
+        reg = <0x1a98000 0x25c>;
+        reg-names = "dsi_ctrl";
+
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            port@1 {
+                reg = <1>;
+                dsi0_out_dual: endpoint {
+                    remote-endpoint = <&d2l_in_dual>;
+                    data-lanes = <0 1 2 3>;
+                };
+             };
+         };
+     };
+...
-- 
2.17.1

