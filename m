Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2068AC433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 17:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F20E92064C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 17:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgGORC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 13:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbgGORCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 13:02:25 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9AE9C061755;
        Wed, 15 Jul 2020 10:02:25 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 287A127FF58
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, dianders@chromium.org,
        heiko@sntech.de, Caesar Wang <wxt@rock-chips.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH] dt-bindings: power: rockchip: Convert to json-schema
Date:   Wed, 15 Jul 2020 19:02:16 +0200
Message-Id: <20200715170216.2875868-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the soc/rockchip/power_domain.txt binding document to json-schema
and move to the power bindings directory.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 .../power/rockchip,power-controller.yaml      | 154 ++++++++++++++++++
 .../bindings/soc/rockchip/power_domain.txt    | 136 ----------------
 2 files changed, 154 insertions(+), 136 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
 delete mode 100644 Documentation/devicetree/bindings/soc/rockchip/power_domain.txt

diff --git a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
new file mode 100644
index 000000000000..af50cf2b3e63
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
@@ -0,0 +1,154 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/rockchip,power-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip Power Domains
+
+maintainers:
+  - Caesar Wang <wxt@rock-chips.com>
+  - Heiko Stuebner <heiko@sntech.de>
+
+description: |
+  Rockchip processors include support for multiple power domains which can be
+  powered up/down by software based on different application scenes to save power.
+
+  Power domains contained within power-controller node are generic power domain
+  providers documented in Documentation/devicetree/bindings/power/power-domain.yaml.
+
+  IP cores belonging to a power domain should contain a 'power-domains'
+  property that is a phandle for the power domain node representing the domain.
+
+properties:
+  power-controller:
+    type: object
+    description: List of power domains provided by this controller.
+
+    properties:
+      compatible:
+        enum:
+          - rockchip,px30-power-controller
+          - rockchip,rk3036-power-controller
+          - rockchip,rk3066-power-controller
+          - rockchip,rk3128-power-controller
+          - rockchip,rk3188-power-controller
+          - rockchip,rk3228-power-controller
+          - rockchip,rk3288-power-controller
+          - rockchip,rk3328-power-controller
+          - rockchip,rk3366-power-controller
+          - rockchip,rk3368-power-controller
+          - rockchip,rk3399-power-controller
+
+      reg:
+        description: |
+          Power domain index. Valid values are defined in:
+          "include/dt-bindings/power/px30-power.h" - for PX30 type power domain.
+          "include/dt-bindings/power/rk3036-power.h" - for RK3036 type power domain.
+          "include/dt-bindings/power/rk3066-power.h" - for RK3066 type power domain.
+          "include/dt-bindings/power/rk3128-power.h" - for RK3128 type power domain.
+          "include/dt-bindings/power/rk3188-power.h" - for RK3188 type power domain.
+          "include/dt-bindings/power/rk3228-power.h" - for RK3228 type power domain.
+          "include/dt-bindings/power/rk3288-power.h" - for RK3288 type power domain.
+          "include/dt-bindings/power/rk3328-power.h" - for RK3328 type power domain.
+          "include/dt-bindings/power/rk3366-power.h" - for RK3366 type power domain.
+          "include/dt-bindings/power/rk3368-power.h" - for RK3368 type power domain.
+          "include/dt-bindings/power/rk3399-power.h" - for RK3399 type power domain.
+        maxItems: 1
+
+      clocks:
+        description: |
+          A number of phandles to clocks that need to be enabled while power domain
+          switches state.
+      pm_qos:
+        description: |
+          A number of phandles to qos blocks which need to be saved and restored
+          while power domain switches state.
+
+      power-supply: true
+
+    required:
+      - compatible
+      - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/rk3399-cru.h>
+    #include <dt-bindings/power/rk3399-power.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        qos_iep: qos@ffa98000 {
+            compatible = "syscon";
+            reg = <0x0 0xffa98000 0x0 0x20>;
+        };
+
+        qos_rga_r: qos@ffab0000 {
+            compatible = "syscon";
+            reg = <0x0 0xffab0000 0x0 0x20>;
+        };
+
+        qos_rga_w: qos@ffab0080 {
+            compatible = "syscon";
+            reg = <0x0 0xffab0080 0x0 0x20>;
+        };
+
+        qos_video_m0: qos@ffab8000 {
+            compatible = "syscon";
+            reg = <0x0 0xffab8000 0x0 0x20>;
+        };
+
+        qos_video_m1_r: qos@ffac0000 {
+            compatible = "syscon";
+            reg = <0x0 0xffac0000 0x0 0x20>;
+        };
+
+        qos_video_m1_w: qos@ffac0080 {
+            compatible = "syscon";
+            reg = <0x0 0xffac0080 0x0 0x20>;
+        };
+
+        power-management@ff310000 {
+            compatible = "rockchip,rk3399-pmu", "syscon", "simple-mfd";
+            reg = <0x0 0xff310000 0x0 0x1000>;
+
+            power-controller {
+                compatible = "rockchip,rk3399-power-controller";
+                #power-domain-cells = <1>;
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                /* These power domains are grouped by VD_CENTER */
+                pd_iep@RK3399_PD_IEP {
+                    reg = <RK3399_PD_IEP>;
+                    clocks = <&cru ACLK_IEP>,
+                             <&cru HCLK_IEP>;
+                    pm_qos = <&qos_iep>;
+                };
+                pd_rga@RK3399_PD_RGA {
+                    reg = <RK3399_PD_RGA>;
+                    clocks = <&cru ACLK_RGA>,
+                             <&cru HCLK_RGA>;
+                    pm_qos = <&qos_rga_r>,
+                             <&qos_rga_w>;
+                };
+                pd_vcodec@RK3399_PD_VCODEC {
+                    reg = <RK3399_PD_VCODEC>;
+                    clocks = <&cru ACLK_VCODEC>,
+                             <&cru HCLK_VCODEC>;
+                    pm_qos = <&qos_video_m0>;
+                };
+                pd_vdu@RK3399_PD_VDU {
+                    reg = <RK3399_PD_VDU>;
+                    clocks = <&cru ACLK_VDU>,
+                             <&cru HCLK_VDU>;
+                    pm_qos = <&qos_video_m1_r>,
+                             <&qos_video_m1_w>;
+                };
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt b/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
deleted file mode 100644
index 8304eceb62e4..000000000000
--- a/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
+++ /dev/null
@@ -1,136 +0,0 @@
-* Rockchip Power Domains
-
-Rockchip processors include support for multiple power domains which can be
-powered up/down by software based on different application scenes to save power.
-
-Required properties for power domain controller:
-- compatible: Should be one of the following.
-	"rockchip,px30-power-controller" - for PX30 SoCs.
-	"rockchip,rk3036-power-controller" - for RK3036 SoCs.
-	"rockchip,rk3066-power-controller" - for RK3066 SoCs.
-	"rockchip,rk3128-power-controller" - for RK3128 SoCs.
-	"rockchip,rk3188-power-controller" - for RK3188 SoCs.
-	"rockchip,rk3228-power-controller" - for RK3228 SoCs.
-	"rockchip,rk3288-power-controller" - for RK3288 SoCs.
-	"rockchip,rk3328-power-controller" - for RK3328 SoCs.
-	"rockchip,rk3366-power-controller" - for RK3366 SoCs.
-	"rockchip,rk3368-power-controller" - for RK3368 SoCs.
-	"rockchip,rk3399-power-controller" - for RK3399 SoCs.
-- #power-domain-cells: Number of cells in a power-domain specifier.
-	Should be 1 for multiple PM domains.
-- #address-cells: Should be 1.
-- #size-cells: Should be 0.
-
-Required properties for power domain sub nodes:
-- reg: index of the power domain, should use macros in:
-	"include/dt-bindings/power/px30-power.h" - for PX30 type power domain.
-	"include/dt-bindings/power/rk3036-power.h" - for RK3036 type power domain.
-	"include/dt-bindings/power/rk3066-power.h" - for RK3066 type power domain.
-	"include/dt-bindings/power/rk3128-power.h" - for RK3128 type power domain.
-	"include/dt-bindings/power/rk3188-power.h" - for RK3188 type power domain.
-	"include/dt-bindings/power/rk3228-power.h" - for RK3228 type power domain.
-	"include/dt-bindings/power/rk3288-power.h" - for RK3288 type power domain.
-	"include/dt-bindings/power/rk3328-power.h" - for RK3328 type power domain.
-	"include/dt-bindings/power/rk3366-power.h" - for RK3366 type power domain.
-	"include/dt-bindings/power/rk3368-power.h" - for RK3368 type power domain.
-	"include/dt-bindings/power/rk3399-power.h" - for RK3399 type power domain.
-- clocks (optional): phandles to clocks which need to be enabled while power domain
-	switches state.
-- pm_qos (optional): phandles to qos blocks which need to be saved and restored
-	while power domain switches state.
-
-Qos Example:
-
-	qos_gpu: qos_gpu@ffaf0000 {
-		compatible ="syscon";
-		reg = <0x0 0xffaf0000 0x0 0x20>;
-	};
-
-Example:
-
-	power: power-controller {
-		compatible = "rockchip,rk3288-power-controller";
-		#power-domain-cells = <1>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		pd_gpu {
-			reg = <RK3288_PD_GPU>;
-			clocks = <&cru ACLK_GPU>;
-			pm_qos = <&qos_gpu>;
-		};
-	};
-
-	 power: power-controller {
-                compatible = "rockchip,rk3368-power-controller";
-                #power-domain-cells = <1>;
-                #address-cells = <1>;
-                #size-cells = <0>;
-
-                pd_gpu_1 {
-                        reg = <RK3368_PD_GPU_1>;
-                        clocks = <&cru ACLK_GPU_CFG>;
-                };
-        };
-
-Example 2:
-		power: power-controller {
-			compatible = "rockchip,rk3399-power-controller";
-			#power-domain-cells = <1>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			pd_vio {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				reg = <RK3399_PD_VIO>;
-
-				pd_vo {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <RK3399_PD_VO>;
-
-					pd_vopb {
-						reg = <RK3399_PD_VOPB>;
-					};
-
-					pd_vopl {
-						reg = <RK3399_PD_VOPL>;
-					};
-				};
-			};
-		};
-
-Node of a device using power domains must have a power-domains property,
-containing a phandle to the power device node and an index specifying which
-power domain to use.
-The index should use macros in:
-	"include/dt-bindings/power/px30-power.h" - for px30 type power domain.
-	"include/dt-bindings/power/rk3036-power.h" - for rk3036 type power domain.
-	"include/dt-bindings/power/rk3128-power.h" - for rk3128 type power domain.
-	"include/dt-bindings/power/rk3128-power.h" - for rk3228 type power domain.
-	"include/dt-bindings/power/rk3288-power.h" - for rk3288 type power domain.
-	"include/dt-bindings/power/rk3328-power.h" - for rk3328 type power domain.
-	"include/dt-bindings/power/rk3366-power.h" - for rk3366 type power domain.
-	"include/dt-bindings/power/rk3368-power.h" - for rk3368 type power domain.
-	"include/dt-bindings/power/rk3399-power.h" - for rk3399 type power domain.
-
-Example of the node using power domain:
-
-	node {
-		/* ... */
-		power-domains = <&power RK3288_PD_GPU>;
-		/* ... */
-	};
-
-	node {
-                /* ... */
-                power-domains = <&power RK3368_PD_GPU_1>;
-                /* ... */
-        };
-
-	node {
-		/* ... */
-		power-domains = <&power RK3399_PD_VOPB>;
-		/* ... */
-	};
-- 
2.27.0

