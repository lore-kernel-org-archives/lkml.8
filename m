Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C98C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 17:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 561F320C09
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 17:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgIJRbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 13:31:46 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54586 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbgIJR2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 13:28:43 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 2F8C329BB08
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, fparent@baylibre.com,
        matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        weiyi.lu@mediatek.com, Matthias Brugger <mbrugger@suse.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 01/12] dt-bindings: power: Add bindings for the Mediatek SCPSYS power domains controller
Date:   Thu, 10 Sep 2020 19:28:15 +0200
Message-Id: <20200910172826.3074357-2-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200910172826.3074357-1-enric.balletbo@collabora.com>
References: <20200910172826.3074357-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The System Control Processor System (SCPSYS) has several power management
related tasks in the system. Add the bindings to define the power
domains for the SCPSYS power controller.

Co-developed-by: Matthias Brugger <mbrugger@suse.com>
Signed-off-by: Matthias Brugger <mbrugger@suse.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
Dear Rob,

I am awasre that this binding is not ready, but I prefered to send because I'm
kind of blocked. Compiling this binding triggers the following error:

    mediatek,power-controller.example.dt.yaml: syscon@10006000: mfg_async@7:
    '#address-cells', '#size-cells', 'mfg_2d@8'
    do not match any of the regexes: 'pinctrl-[0-9]+'

This happens when a definition of a power-domain (parent) contains
another power-domain (child), like the example. I am not sure how to
specify this in the yaml and deal with this, so any clue is welcome.

Thanks,
  Enric

 .../power/mediatek,power-controller.yaml      | 171 ++++++++++++++++++
 1 file changed, 171 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/mediatek,power-controller.yaml

diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
new file mode 100644
index 000000000000..8be9244ad160
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
@@ -0,0 +1,171 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/mediatek,power-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek Power Domains Controller
+
+maintainers:
+  - Weiyi Lu <weiyi.lu@mediatek.com>
+  - Matthias Brugger <mbrugger@suse.com>
+
+description: |
+  Mediatek processors include support for multiple power domains which can be
+  powered up/down by software based on different application scenes to save power.
+
+  IP cores belonging to a power domain should contain a 'power-domains'
+  property that is a phandle for SCPSYS node representing the domain.
+
+properties:
+  $nodename:
+    pattern: "^syscon@[0-9a-f]+$"
+
+  compatible:
+    items:
+      - enum:
+        - mediatek,mt8173-power-controller
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+patternProperties:
+  "^.*@[0-9]$":
+    type: object
+    description: |
+      Represents the power domains within the power controller node as documented
+      in Documentation/devicetree/bindings/power/power-domain.yaml.
+
+    properties:
+      reg:
+        description: |
+          Power domain index. Valid values are defined in:
+              "include/dt-bindings/power/mt8173-power.h" - for MT8173 type power domain.
+        maxItems: 1
+
+      '#power-domain-cells':
+        description:
+          Documented by the generic PM Domain bindings in
+          Documentation/devicetree/bindings/power/power-domain.yaml.
+
+      clocks:
+        description: |
+          A number of phandles to clocks that need to be enabled during domain
+          power-up sequencing.
+
+      clock-names:
+        description: |
+          List of names of clocks, in order to match the power-up sequencing
+          for each power domain we need to group the clocks by name. BASIC
+          clocks need to be enabled before enabling the corresponding power
+          domain, and should not have a '-' in their name (i.e mm, mfg, venc).
+          SUSBYS clocks need to be enabled before releasing the bus protection,
+          and should contain a '-' in their name (i.e mm-0, isp-0, cam-0).
+
+          In order to follow properly the power-up sequencing, the clocks must
+          be specified by order, adding first the BASIC clocks followed by the
+          SUSBSYS clocks.
+
+      mediatek,infracfg:
+        $ref: /schemas/types.yaml#definitions/phandle
+        description: phandle to the device containing the INFRACFG register range.
+
+      mediatek,smi:
+        $ref: /schemas/types.yaml#definitions/phandle
+        description: phandle to the device containing the SMI register range.
+
+    required:
+      - reg
+      - '#power-domain-cells'
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mt8173-clk.h>
+    #include <dt-bindings/power/mt8173-power.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        scpsys: syscon@10006000 {
+            compatible = "mediatek,mt8173-power-controller", "syscon";
+            reg = <0 0x10006000 0 0x1000>;
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            /* power domains of the SoC */
+            vdec@MT8173_POWER_DOMAIN_VDEC {
+                reg = <MT8173_POWER_DOMAIN_VDEC>;
+                clocks = <&topckgen CLK_TOP_MM_SEL>;
+                clock-names = "mm";
+                #power-domain-cells = <0>;
+            };
+
+            venc@MT8173_POWER_DOMAIN_VENC {
+                reg = <MT8173_POWER_DOMAIN_VENC>;
+                clocks = <&topckgen CLK_TOP_MM_SEL>,
+                         <&topckgen CLK_TOP_VENC_SEL>;
+                clock-names = "mm", "venc";
+                #power-domain-cells = <0>;
+            };
+            isp@MT8173_POWER_DOMAIN_ISP {
+                reg = <MT8173_POWER_DOMAIN_ISP>;
+                clocks = <&topckgen CLK_TOP_MM_SEL>;
+                clock-names = "mm";
+                #power-domain-cells = <0>;
+            };
+            mm@MT8173_POWER_DOMAIN_MM {
+                reg = <MT8173_POWER_DOMAIN_MM>;
+                clocks = <&topckgen CLK_TOP_MM_SEL>;
+                clock-names = "mm";
+                #power-domain-cells = <0>;
+                mediatek,infracfg = <&infracfg>;
+            };
+            venc_lt@MT8173_POWER_DOMAIN_VENC_LT {
+                reg = <MT8173_POWER_DOMAIN_VENC_LT>;
+                clocks = <&topckgen CLK_TOP_MM_SEL>,
+                         <&topckgen CLK_TOP_VENC_LT_SEL>;
+                clock-names = "mm", "venclt";
+                #power-domain-cells = <0>;
+            };
+            audio@MT8173_POWER_DOMAIN_AUDIO {
+                reg = <MT8173_POWER_DOMAIN_AUDIO>;
+                #power-domain-cells = <0>;
+            };
+            usb@MT8173_POWER_DOMAIN_USB {
+                reg = <MT8173_POWER_DOMAIN_USB>;
+                #power-domain-cells = <0>;
+            };
+            mfg_async@MT8173_POWER_DOMAIN_MFG_ASYNC {
+                reg = <MT8173_POWER_DOMAIN_MFG_ASYNC>;
+                clocks = <&clk26m>;
+                clock-names = "mfg";
+                #address-cells = <1>;
+                #size-cells = <0>;
+                #power-domain-cells = <1>;
+
+                mfg_2d@MT8173_POWER_DOMAIN_MFG_2D {
+                    reg = <MT8173_POWER_DOMAIN_MFG_2D>;
+                    #address-cells = <1>;
+                    #size-cells = <0>;
+                    #power-domain-cells = <1>;
+
+                    mfg@MT8173_POWER_DOMAIN_MFG {
+                        reg = <MT8173_POWER_DOMAIN_MFG>;
+                        #power-domain-cells = <0>;
+                        mediatek,infracfg = <&infracfg>;
+                    };
+                };
+            };
+        };
+    };
-- 
2.28.0

