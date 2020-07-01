Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9379FC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DE8B20722
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnxOQGwN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbgGAHEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 03:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727981AbgGAHEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 03:04:23 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E51C061755;
        Wed,  1 Jul 2020 00:04:23 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id b92so10635476pjc.4;
        Wed, 01 Jul 2020 00:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=gEzbAtWIsd1iT+azfZmBohV/AqNwaJqbCk/ZUwUKLT0=;
        b=NnxOQGwN2fiVijkyKWMDRKyu6NhJ9XGf1RN8fCmtWJbYPFPZwt1E2v1y95ag2laVoz
         JuRRtV/SSKcCUZ5IBPUmO4XZZOss80RdERJBx/cWm3TR/JNM8fcyzk79WbIqDxc2+8Um
         6bAnewGJU/0QdRS1mj/C/NqEo5w4fF/ao5pT/Bfp2sMKKvlfNqt0xWNBGW4yy9TfKEQJ
         UTMBlxfU8+DNUQ/I/lK0ONPLhCR47k9No8uQ6GRE8QF32H5caMOcNZ/GXPFSCQlPGX7p
         vdMzvNa00shOqnPOB6rxqrSPoA6ueTsDPgqXItp09e21hATcW6yrktrPCXRbnsAO0lYZ
         URfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gEzbAtWIsd1iT+azfZmBohV/AqNwaJqbCk/ZUwUKLT0=;
        b=hy4nJOd4iJFyHi0RMpOLHbQEyAon/bm5qsRvbK/EhnrSs4oK0YgXrv/WSmQidYnghV
         GPoDtylMVM5ZhlgreT4ICW79Dj6xqAYHjA0datPYXh6ntpSICdp52sK0jb3teCM/1tbJ
         NJ9+X0wJ4HLvvZjTr3kccteV0rapWeYg1ANU3p7sB8+LuDFxR70pRQanSnkngnFOR4bd
         bvVhaBUCE+UD0p7bh8oJMAff0mGW1TpLbh6+yIKJ6pxK2uuaOjgBRWgc30mOvIayPah5
         mH804Xhlq9jW07z/wmd9hCooW983vUaUc/bitwrrDps+ox7NsS99qvyV9t+fLhw9NCnT
         4Akg==
X-Gm-Message-State: AOAM5305EP+J5NjBuU5aJDt9JgYF/8bVhCL4F7e+O711sJNQKrrs68Md
        Pxhye5P9M8VM6m2vxdco9tqfWd7LnMc=
X-Google-Smtp-Source: ABdhPJx/6lPBNeVtHwsvQ63vNg3gQTw0bGryosd9ftVV+EMIb/Bl718hMVuloKtYMtKlOW9lBXxOlQ==
X-Received: by 2002:a17:902:9042:: with SMTP id w2mr11542065plz.8.1593587062534;
        Wed, 01 Jul 2020 00:04:22 -0700 (PDT)
Received: from in099003062.routereb3c90.com ([106.51.138.45])
        by smtp.gmail.com with ESMTPSA id f2sm3623201pfb.184.2020.07.01.00.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 00:04:21 -0700 (PDT)
From:   Vinay Simha BN <simhavcs@gmail.com>
To:     narmstrong@baylibre.com, Ken-Sue.Tan@taec.toshiba.com,
        Chris.Cheng@taec.toshiba.com, Bhushan.Patel@taec.toshiba.com
Cc:     Vinay Simha BN <simhavcs@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 1/2] dt-binding: Add DSI/LVDS TC358775 bridge bindings
Date:   Wed,  1 Jul 2020 12:33:36 +0530
Message-Id: <20200701070344.6330-1-simhavcs@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver is tested with two panels with Apq8016-IFC6309 board
https://www.inforcecomputing.com/products/single-board-computers-sbc/qualcomm-snapdragon-410-inforce-6309-micro-sbc

1. 1366x768@60 auo,b101xtn01 data-mapping = "jeida-24"
2. 800x480@60 innolux,at070tn92 data-mapping = "vesa-24"

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
---
 .../display/bridge/toshiba,tc358775.yaml      | 204 ++++++++++++++++++
 1 file changed, 204 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/toshiba,tc358775.yaml

diff --git a/Documentation/devicetree/bindings/display/bridge/toshiba,tc358775.yaml b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358775.yaml
new file mode 100644
index 000000000000..ec53d62d408b
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358775.yaml
@@ -0,0 +1,204 @@
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
+                        data-lanes = <0 1 2 3>;
+                };
+             };
+         };
+     };
+
+ - |
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
+                        data-lanes = <0 1 2 3>;
+                };
+             };
+         };
+     };
+...
-- 
2.17.1

