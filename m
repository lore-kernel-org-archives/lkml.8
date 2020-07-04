Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD313C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 09:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B37CC20739
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 09:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d20+gBfF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgGDJZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 05:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbgGDJZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 05:25:29 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8D5C061794;
        Sat,  4 Jul 2020 02:25:29 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id gc9so8284216pjb.2;
        Sat, 04 Jul 2020 02:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=vPne7NFgJs6b8kzaJCb+n8aPS6rGBj37y5JN0ANKMsQ=;
        b=d20+gBfF/A2+zaOZAnEAHqHn11JPIhWf78A/02VJ8cAhi52B1MDoOmBVUoCkwbAQIt
         WL7EeHG4TQi5Jb8TEVtw2KUl8GvB5ofPW61yYWmJDXn/6237obVR4INx3TW5CXby8jxN
         6kmCsnlCGfHqg1hZCPIFkwu82iQnhL1rb+g/opBQjwMnmU3iTRussoVfA8z2yN7YUTkh
         ALxOp4p31NYJP0brJ83SJZcJhhotFuyHYfiYJXjLgL2MP41pctr+EGO+xF3izIFx+Rrl
         8dLVY2NNrqvCOppXnEYyHBOLpAc9qZXAZBb6mVlh9ZWzRpfrrExtPbv5xJm4N7QnmzTL
         Rtgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vPne7NFgJs6b8kzaJCb+n8aPS6rGBj37y5JN0ANKMsQ=;
        b=r3B2zo4ele/HhfLOeesCC9L6dKwIftUCTUVxISPT0eoeUwNzrV/fu4DNCGYBOt/9ap
         wuqOwTKjeNV6wWvivqOXDUbdn39hTt+UluuI7wY1jbHjILxq/bBKZrxqxl5TSz7X4xeI
         eGjsd3ayh3aWo+3sB6X708kWjnBQHn7GBShgDL/1CiIBlPOk/r0E9sMc1KvvNYIUZyQ2
         WziPeQCrXXNqKUotav52evrMmAAqhr7fDwcOfw1JpLBdRMaB1sJYXPIAU6MJ88w5ynEF
         U39Nih/yafeJi71qBUQSdok6TcE7PFxU9S0bLdbMO5WYfRo5RLwUYZ0ooTaMfNIAupw+
         K39w==
X-Gm-Message-State: AOAM533aR8rhhPfiJOSO+9FoglLemOG4P0YjsEwQaRRxo8PUNoa+8orY
        r2b19jfFDqp2odeEwQxtqGUPEojI1qU=
X-Google-Smtp-Source: ABdhPJztMwPJkf9gYnz5ynp9kd3hUkhpOC+Xkb747Q5eUfV87Ty5lmw+6nwRtRxCyBdj/iFeYUMDQA==
X-Received: by 2002:a17:902:b40f:: with SMTP id x15mr31793800plr.164.1593854728531;
        Sat, 04 Jul 2020 02:25:28 -0700 (PDT)
Received: from localhost.localdomain ([122.172.219.189])
        by smtp.gmail.com with ESMTPSA id s22sm13650917pfm.164.2020.07.04.02.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 02:25:28 -0700 (PDT)
From:   Vinay Simha BN <simhavcs@gmail.com>
Cc:     Vinay Simha BN <simhavcs@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v7 1/2] dt-binding: Add DSI/LVDS TC358775 bridge bindings
Date:   Sat,  4 Jul 2020 14:54:39 +0530
Message-Id: <20200704092511.20856-1-simhavcs@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- converted from .txt to .yaml
- dual-link lvds port added and implemented
- dsi data-lanes property removed, it will be picked
  from dsi0 ports
- VESA/JEIDA formats picked from panel-lvds dts
- proper indentation
- single-link and dual-link lvds description and
  examples are added
- license modified to (GPL-2.0-only OR BSD-2-Clause)

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

v5:
* Sam Ravnborg review comments incorporated
  license modified to (GPL-2.0-only OR BSD-2-Clause)
  changelog added
---
 .../display/bridge/toshiba,tc358775.yaml      | 215 ++++++++++++++++++
 1 file changed, 215 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/toshiba,tc358775.yaml

diff --git a/Documentation/devicetree/bindings/display/bridge/toshiba,tc358775.yaml b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358775.yaml
new file mode 100644
index 000000000000..31f085d8ab13
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358775.yaml
@@ -0,0 +1,215 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
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

