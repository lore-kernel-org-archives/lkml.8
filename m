Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B789CC433F2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 849D7207D0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NimQwGDC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbgGJNls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 09:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbgGJNlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 09:41:47 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53081C08C5CE;
        Fri, 10 Jul 2020 06:41:47 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id d4so2552912pgk.4;
        Fri, 10 Jul 2020 06:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ox6v3/6m/JURuE++39qFM5i01Mp73X4OGqXZFITJfc8=;
        b=NimQwGDCTI5TJYA0xP7+EQoTKsK4g0Uxntam9o5wrvluk6ZkTeD3nrDalXMVZIg0Kt
         BEpLzAgIUEhpXrGMcDScdUfwztxui3TfHrGpeZBQHaLoQWit9U0+N8Mbj81/zebX77wO
         BGCyFUnRDJWAEc9NztYR0JzGsrpS3f2S+0Gn85DZLTGQ2vT2tK1iTT2H+X0jOQrVjeX+
         ++iBYoJKtyFbljGp6aihKOXLupv0jOJ2vcWOwcW6YdEZSV0Cp1hJ6nZbOWokxK8W/96b
         RK0Vx54xCht6/ta+nynKTPCIDo3J5aTxrX0RGNb2sgQKtnA7rh9P0c6yW8hIpPy2Ahd0
         90Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ox6v3/6m/JURuE++39qFM5i01Mp73X4OGqXZFITJfc8=;
        b=R8QkQTPXM3QuzJBXEGpU5DKJVMNHnjRrltXDzo+abz0UNmCv8fVemU3Bp7HsxLwN4P
         N/xYNTIzddmiK5+nHF+MlLRf/R+bs9Z7s/uUl+4Cr/k9OgpLc7xr0PpQnEqN/fzqyl6u
         Rm2+cfBNxvAclyI1BOkoftprigYvW/AwObl14YVaxTRndgsObi64Bpq1sYQnmUmWCJ1a
         RPHZrf2vSBKnMPiFH46zPU9Rcs/Qm63oDM5XtVZzWbGgMHf6B1mBdQezLcgPrpfcQWV4
         u2HkrkmjbompwfiJI9PeyqswC3JrAuLXMhOfpgL+UE0wHahLDSCBtAhieTMZ9b5kZra2
         fZzw==
X-Gm-Message-State: AOAM533J86dlB+JrO7kypdOkDg6QRvWD/X/qE8JjDrPMHApsmPeWkN+d
        Cg4ENPncSZsrzDlxiEv8wHE=
X-Google-Smtp-Source: ABdhPJxTki9x8QqD3a8zSWl1MuapthA8yxzqAQ1e3GWqJZ4DjGL/AOjPOG9WO53fYEO/Dkx3Wdd2iA==
X-Received: by 2002:a65:4786:: with SMTP id e6mr42595261pgs.258.1594388505147;
        Fri, 10 Jul 2020 06:41:45 -0700 (PDT)
Received: from localhost.localdomain ([122.172.62.13])
        by smtp.gmail.com with ESMTPSA id j13sm5756863pjz.8.2020.07.10.06.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 06:41:44 -0700 (PDT)
From:   Vinay Simha BN <simhavcs@gmail.com>
Cc:     Vinay Simha BN <simhavcs@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v8 1/2] dt-binding: Add DSI/LVDS TC358775 bridge bindings
Date:   Fri, 10 Jul 2020 19:11:27 +0530
Message-Id: <1594388491-15129-1-git-send-email-simhavcs@gmail.com>
X-Mailer: git-send-email 2.1.2
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- license modified to (GPL-2.0-only OR BSD-2-Clause)
- single-link and dual-link lvds description and
  examples are added
- proper indentation
- VESA/JEIDA formats picked from panel-lvds dts
- dsi data-lanes property removed, it will be picked
  from dsi0 ports
- dual-link lvds port added and implemented
- converted from .txt to .yaml

Signed-off-by: Vinay Simha BN <simhavcs@gmail.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Rob Herring <robh@kernel.org>
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

v6:
* No changes, revision version mentioned to inline with
  driver file

v7:
* change log added
  Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

v8:
* Reviewed-by: Rob Herring <robh@kernel.org>
* change log modified in reverse chronological order
---
 .../bindings/display/bridge/toshiba,tc358775.yaml  | 215 +++++++++++++++++++++
 1 file changed, 215 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/toshiba,tc358775.yaml

diff --git a/Documentation/devicetree/bindings/display/bridge/toshiba,tc358775.yaml b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358775.yaml
new file mode 100644
index 0000000..31f085d
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
2.1.2

