Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B32C35642
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8653207FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="atHtCdxL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbgBUHtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 02:49:23 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42615 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728198AbgBUHtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 02:49:21 -0500
Received: by mail-pg1-f193.google.com with SMTP id w21so550553pgl.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 23:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KRlxVHnY6xMdVsy7PcO/fCoxo903j73okxO5nZgCM18=;
        b=atHtCdxL1sgWCq/VwfyueK33mty3HzDbieNwt5EKBCyhbGy+Xy6YmoGDwQ6DVXXnUA
         1f2nupfCV5141CdThGW+1P5qDcF9TvJBMiTAcPGRzVZQT0HKyJm+QdapEAn8L3QLHI+O
         v1SCYwuJkw8cWSJnmWR15mUTru2S/+AL5epZeaDi7c6g/v/Ko6lCTK1C5ny0bqiPz6cl
         Tp3T0cj+F5AJH7OJOoyGmEFzHDeI7GyfPDVRNG6j9dLBE5HQ4Fnv2XH2GmtA0gkAW/Q5
         oyu8lEJqG2moJBTFEXCGoxxvZTV6ZqqcOmLqB1y9PHTxSYc/Dyu8slmfUJ/Htg1O116t
         C1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KRlxVHnY6xMdVsy7PcO/fCoxo903j73okxO5nZgCM18=;
        b=O1ssDF3kis45KR3wvlrwHzlzU+20jktHbDNXVcRN0kFkvROYY/+i8j8fF72e3J63Xw
         3LwttFF0J3RyW9MLeZFLPCmvF8apa7m2XKaw8sLD0TEV3HXuq2QIfbGOvBeMRWNQxoIn
         O2M63pckQRUwZTCQR28AEQ+5e50/MaZchUX1V+MZwnUg1uvD6lUpFOA+4n0Te6P8VosO
         5USKQYW16OQr+FYvKGTzxDuvF9kAabI4Vn8zBUG/6k3rPNwCZLRBCoTgZVs1uzAo+GdV
         XXbOOlIDeBhNVZv6BEe2ikHkHKZfYgWmm38kyf6vCwqG64mY/FDbApE0kx2MxfaaWVsI
         3ZAA==
X-Gm-Message-State: APjAAAUTjv6kY/ONdFB93treI4LR3HGO0W1SMh0e5cdHwT06aTtCnXZF
        8aRAGC54PoEPXwksR77G0zk=
X-Google-Smtp-Source: APXvYqw846R9l9ZV72ot+NZpkbbIx08Foh0EvQV/MWyWThtxrgwu/chEqjgnjK7+dueYcum6uSy9mw==
X-Received: by 2002:a65:4d0d:: with SMTP id i13mr36680996pgt.346.1582271361210;
        Thu, 20 Feb 2020 23:49:21 -0800 (PST)
Received: from nj08008nbu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id d1sm1444653pgj.79.2020.02.20.23.49.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Feb 2020 23:49:20 -0800 (PST)
From:   Kevin Tang <kevin3.tang@gmail.com>
To:     airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        mark.rutland@arm.com, kevin3.tang@gmail.com
Cc:     orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH RFC v3 5/6] dt-bindings: display: add Unisoc's mipi dsi&dphy bindings
Date:   Fri, 21 Feb 2020 15:48:55 +0800
Message-Id: <1582271336-3708-6-git-send-email-kevin3.tang@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582271336-3708-1-git-send-email-kevin3.tang@gmail.com>
References: <1582271336-3708-1-git-send-email-kevin3.tang@gmail.com>
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
index 0000000..bd7819c
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
diff --git a/Documentation/devicetree/bindings/display/sprd/dsi.yaml b/Documentation/devicetree/bindings/display/sprd/dsi.yaml
new file mode 100644
index 0000000..198ac31
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
-- 
2.7.4

