Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EABAC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 08:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CC1121734
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 08:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1IWE9m+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbgAUIvl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 03:51:41 -0500
Received: from mail-pf1-f173.google.com ([209.85.210.173]:41381 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729096AbgAUIvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 03:51:40 -0500
Received: by mail-pf1-f173.google.com with SMTP id w62so1131930pfw.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 00:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ry4/ep16oNKoCc2xrlZ2XWt3hGVglx47MU7Pj1OXlYM=;
        b=k1IWE9m+k9xJWthTRraJnQzq1Rw3wkzmZNmq66aIX2Uv8T8JnILLr8i+5e6+k1JewB
         R+XJhBkmfviWpVxG4ndKNLMArnCLSnFbgi7Avc0GXxHYmtLZXIqGc4CAGB1fyg7+lThj
         +R6SD4z0HAwaHh4US76MAfjY+IoZkXdnjOIsEqiKayZBaTI53eDaBolqfw8KRiN3F9hv
         hkWcD2R4BsJNIwURGwMcsdOmr7HaLwPagyYrMW7F7pTElJ2jTpY58PZom0RjVoOkZ9ql
         1/LdVPY4HfgJM7YOv9FfZZbIG3eJDe8NqzlFcjTqyq1QhfEKeQ4e8hgD64cF1xDcL2Oa
         e/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ry4/ep16oNKoCc2xrlZ2XWt3hGVglx47MU7Pj1OXlYM=;
        b=Sz/wNAr3SpYMche3ihax7lZFTM8cQETQBwWQMPmwmMeOQwdIIhEb+J6H3s5H7Cc37l
         NEJtpdSRR19VC/vmvRiqsKtgrMAk2CXFF0KrNnraSs6c9aiQicrW76NmVfpyI+sqfSeR
         ZYlizZ5MbgUgwYgFuoID3r+5MeXUMk+GFhuNBNvkd74nR7z9AS9rNot96lNEo5ucPysf
         EsdPrmOz9K3wi2c4TU5mOaRYfUKTBCEJSHfzT2o+eQakXTYlfseGOHIJLtH5M9xAJ+VI
         QCLfa+Br05DO1xdFR/rzhXGPioLEKJIur2OkaoVLcKU+N5hVYEbXVMay+Bio4DpaCH7y
         fWcw==
X-Gm-Message-State: APjAAAUA6unxIauQJ4CVMkB9VNgctzoM+q9wihSASRwPOvYQomatIzZd
        0QR4UxARYsgnPHmfZyJl3Kj/qnVN
X-Google-Smtp-Source: APXvYqyswxxK9QRmtJByIcY/Wvc2iUBp6rl8K7qZLF9df/+mqbmb6EXm+ES3IYc2NIHfXdKKr+1apw==
X-Received: by 2002:a63:cc4a:: with SMTP id q10mr4182000pgi.241.1579596699371;
        Tue, 21 Jan 2020 00:51:39 -0800 (PST)
Received: from nj08008nbu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id 80sm42820957pfw.123.2020.01.21.00.51.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 Jan 2020 00:51:39 -0800 (PST)
From:   Kevin Tang <kevin3.tang@gmail.com>
To:     airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        mark.rutland@arm.com, kevin3.tang@gmail.com
Cc:     orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH RFC v2 5/6] dt-bindings: display: add Unisoc's mipi dsi&dphy bindings
Date:   Tue, 21 Jan 2020 16:51:01 +0800
Message-Id: <1579596662-15466-6-git-send-email-kevin3.tang@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579596662-15466-1-git-send-email-kevin3.tang@gmail.com>
References: <1579596662-15466-1-git-send-email-kevin3.tang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kevin Tang <kevin.tang@unisoc.com>

Adds MIPI DSI Master and MIPI DSI-PHY (D-PHY)
support for Unisoc's display subsystem.

Cc: Orson Zhai <orsonzhai@gmail.com>
Cc: Baolin Wang <baolin.wang@linaro.org>
Cc: Chunyan Zhang <zhang.lyra@gmail.com>
Signed-off-by: Kevin Tang <kevin.tang@unisoc.com>
---
 .../devicetree/bindings/display/sprd/dphy.yaml     |  78 ++++++++++++++++
 .../devicetree/bindings/display/sprd/dsi.yaml      | 101 +++++++++++++++++++++
 2 files changed, 179 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/sprd/dphy.yaml
 create mode 100644 Documentation/devicetree/bindings/display/sprd/dsi.yaml

diff --git a/Documentation/devicetree/bindings/display/sprd/dphy.yaml b/Documentation/devicetree/bindings/display/sprd/dphy.yaml
new file mode 100644
index 0000000..c5e97c9
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/sprd/dphy.yaml
@@ -0,0 +1,78 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/sprd/dphy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Unisoc MIPI DSI-PHY (D-PHY)
+
+maintainers:
+  - David Airlie <airlied@linux.ie>
+  - Daniel Vetter <daniel@ffwll.ch>
+  - Rob Herring <robh+dt@kernel.org>
+  - Mark Rutland <mark.rutland@arm.com>
+
+properties:
+  compatible:
+    const: sprd,sharkl3-dsi-phy
+
+  reg:
+    maxItems: 1
+    description:
+      Must be the dsi controller base address.
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  port@0:
+    type: object
+    description:
+      A port node with endpoint definitions as defined in
+      Documentation/devicetree/bindings/media/video-interfaces.txt.
+      That port should be the output endpoint, usually output to
+      the associated panel.
+  port@1:
+    type: object
+    description:
+      A port node with endpoint definitions as defined in
+      Documentation/devicetree/bindings/media/video-interfaces.txt.
+      That port should be the input endpoint, usually coming from
+      the associated DSI controller.
+
+required:
+  - compatible
+  - reg
+  - port@0
+  - port@1
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    dphy: dphy {
+        compatible = "sprd,sharkl3-dsi-phy";
+        reg = <0x0 0x63100000 0x0 0x1000>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        /* input port*/
+        port@1 {
+            reg = <1>;
+            dphy_in: endpoint {
+    	          remote-endpoint = <&dsi_out>;
+            };
+        };
+
+        /* output port */
+        port@0 {
+    	      reg = <0>;
+    	      dphy_out: endpoint {
+    		        remote-endpoint = <&panel_in>;
+    	      };
+        };
+    };
\ No newline at end of file
diff --git a/Documentation/devicetree/bindings/display/sprd/dsi.yaml b/Documentation/devicetree/bindings/display/sprd/dsi.yaml
new file mode 100644
index 0000000..f38d7f3
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/sprd/dsi.yaml
@@ -0,0 +1,101 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/sprd/dsi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Unisoc MIPI DSI Master
+
+maintainers:
+  - David Airlie <airlied@linux.ie>
+  - Daniel Vetter <daniel@ffwll.ch>
+  - Rob Herring <robh+dt@kernel.org>
+  - Mark Rutland <mark.rutland@arm.com>
+
+properties:
+  compatible:
+    const: sprd,sharkl3-dsi-host
+
+  reg:
+    maxItems: 1
+    description:
+      Physical base address and length of the registers set for the device.
+
+  interrupts:
+    maxItems: 2
+    description:
+      Should contain DSI interrupt.
+
+  clocks:
+    minItems: 1
+
+  clock-names:
+    items:
+      - const: clk_src_96m
+
+  power-domains:
+    maxItems: 1
+    description: A phandle to DSIM power domain node
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  port@0:
+    type: object
+    description:
+      A port node with endpoint definitions as defined in
+      Documentation/devicetree/bindings/media/video-interfaces.txt.
+      That port should be the input endpoint, usually coming from
+      the associated DPU.
+  port@1:
+    type: object
+    description:
+      A port node with endpoint definitions as defined in
+      Documentation/devicetree/bindings/media/video-interfaces.txt.
+      That port should be the output endpoint, usually output to
+      the associated DPHY.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - port@0
+  - port@1
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/sprd,sc9860-clk.h>
+    dsi: dsi@0x63100000 {
+        compatible = "sprd,sharkl3-dsi-host";
+        reg = <0 0x63100000 0 0x1000>;
+        interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>,
+          <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+        clock-names = "clk_src_96m";
+        clocks = <&pll CLK_TWPLL_96M>;
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+        port@0 {
+            reg = <0>;
+            dsi_in: endpoint {
+                remote-endpoint = <&dpu_out>;
+            };
+        };
+
+        port@1 {
+            reg = <1>;
+            dsi_out: endpoint@1 {
+                remote-endpoint = <&dphy_in>;
+            };
+        };
+    };
\ No newline at end of file
-- 
2.7.4

