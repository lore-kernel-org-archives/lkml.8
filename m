Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE04C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 12:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 537DA207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 12:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgZNo5+o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgFRMTQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 08:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbgFRMTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 08:19:14 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEB0C06174E;
        Thu, 18 Jun 2020 05:19:14 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id v14so2848627pgl.1;
        Thu, 18 Jun 2020 05:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kTOrqhaLSjsiBsLxPoJaXJ3Xn/KAgWNSimnogI9J75E=;
        b=UgZNo5+oZW4A520lpaemwstKYxXtJNuozGC3SXwzXLPYXlb1L9+4dIM8ObC9jln9Ca
         D5j7D97mWAUvJzutqTNb7AUN9Jru0e1wYT7b/sHPk6W8HoYupAkAEQbi4Gpv64fTuvXp
         cKgqy18ZD2xayBVO6uOx15G2t2uqnLVc599/XAPwqE338ekq3+H55W2csypTIXZKMpId
         FzwjsFt2EG9avXgNmbqA5cbmiqPJUzoxvk/p4dej0ABOj8uR7W9QNEKhIA3OFpiwzQrU
         4wWl+5u7xE/fuj1L+8wkpUoKO5aGTj6o2cDJ4r8rgyeNIom/L6Qt8YR0hw2WkwINk03I
         sBJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kTOrqhaLSjsiBsLxPoJaXJ3Xn/KAgWNSimnogI9J75E=;
        b=nsT/04K5JvM49lYLdMcinQhTgitIXEm07s0zsZhSV7uuDeWkaqpYqXF58MLQV2v2wD
         25vKP2/9/IQLpW+8RlNEHrf7fvPiiGA/Ez9MbAH1p7WY/1vU1IPq2YRrTr4Ggf8bP+Hw
         u0bvcrHszg6+x572vuxJPAJhEm2MUPWqvQkTpa4LbzCey/SVEfbt6x+raBIqio9BoTrg
         l+uuihxUKERb0D5gaHeEpc9fHqDE5UCdX8YLLGfFTAnCihe+016BBO1zSFzlrsA8KKyF
         jHErnr7UgjPf7mP0i6J1TfKpWz3A3VgPH9By1bLvUVx+CI9OKpju7ktjg7AdVxREMuyh
         NpdQ==
X-Gm-Message-State: AOAM532Je01SfS9vzAveVjVdG2zhqQ580dkqWzqxgtr3YcXG1F+91bhd
        VFtiRYLTJXHt8S/XSM3HtiI=
X-Google-Smtp-Source: ABdhPJxN+3BMttqiR1PKkjKSnED6WnbWacJDRO/nGr2x1DjrAiQVZE62o3tDWBIzlZ64jE29zN3vLw==
X-Received: by 2002:aa7:9513:: with SMTP id b19mr3285653pfp.152.1592482753975;
        Thu, 18 Jun 2020 05:19:13 -0700 (PDT)
Received: from in099003062.routereb3c90.com ([106.51.138.45])
        by smtp.gmail.com with ESMTPSA id v7sm2787269pfn.147.2020.06.18.05.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 05:19:13 -0700 (PDT)
From:   Vinay Simha BN <simhavcs@gmail.com>
Cc:     Vinay Simha BN <simhavcs@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 1/2] dt-binding: Add DSI/LVDS TC358775 bridge bindings
Date:   Thu, 18 Jun 2020 17:48:56 +0530
Message-Id: <20200618121902.16841-1-simhavcs@gmail.com>
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

