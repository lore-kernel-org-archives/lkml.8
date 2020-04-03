Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA24EC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 14:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 942722078C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 14:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391049AbgDCOVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 10:21:51 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:60323 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390896AbgDCOVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 10:21:49 -0400
X-Originating-IP: 77.205.41.241
Received: from localhost.localdomain (241.41.205.77.rev.sfr.net [77.205.41.241])
        (Authenticated sender: maxime.chevallier@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 1B7311BF221;
        Fri,  3 Apr 2020 14:21:44 +0000 (UTC)
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH 1/3] media: dt-bindings: media: Document Rockchip CIF bindings
Date:   Fri,  3 Apr 2020 16:21:20 +0200
Message-Id: <20200403142122.297283-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200403142122.297283-1-maxime.chevallier@bootlin.com>
References: <20200403142122.297283-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a documentation for the Rockchip Camera Interface controller
binding.

This controller can be found on platforms such as the PX30 or the
RK3288, the PX30 being the only platform supported so far.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 .../bindings/media/rockchip-cif.yaml          | 98 +++++++++++++++++++
 1 file changed, 98 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/rockchip-cif.yaml

diff --git a/Documentation/devicetree/bindings/media/rockchip-cif.yaml b/Documentation/devicetree/bindings/media/rockchip-cif.yaml
new file mode 100644
index 000000000000..87fb5e136edd
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/rockchip-cif.yaml
@@ -0,0 +1,98 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/rockchip-cif.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip Camera Interface (CIF)
+
+maintainers:
+  - Maxime Chevallier <maxime.chevallier@bootlin.com>
+
+description: |-
+Camera Interface for Rockcip platforms
+
+properties:
+  compatible:
+    const: rockchip,px30-cif
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: ACLK
+      - description: HCLK
+      - description: PCLK
+      - description: CIF_OUT
+
+  clock-names:
+    items:
+      - const: aclk_cif
+      - const: hclk_cif
+      - const: pclk_cif
+      - const: cif_out
+
+  resets:
+    items:
+      - description: Reset CIF A
+      - description: Reset CIF H
+      - description: Reset CIF PCLK IN
+
+  reset-names:
+    items:
+      - const: rst_cif_a
+      - const: rst_cif_h
+      - const: rst_cif_pclkin
+
+  power-domains:
+    maxItems: 1
+    description: phandle to the associated power domain
+
+  # See ./video-interfaces.txt for details
+  port:
+    type: object
+    additionalProperties: false
+
+    properties:
+      endpoint:
+        type: object
+
+        properties:
+          remote-endpoint: true
+
+        required:
+          - remote-endpoint
+
+    required:
+      - endpoint
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+        cif: cif@ff490000 {
+		compatible = "rockchip,px30-cif";
+		reg = <0x0 0xff490000 0x0 0x200>;
+		interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru ACLK_CIF>, <&cru HCLK_CIF>, <&cru PCLK_CIF>, <&cru SCLK_CIF_OUT>;
+		clock-names = "aclk_cif", "hclk_cif", "pclk_cif", "cif_out";
+		resets = <&cru SRST_CIF_A>, <&cru SRST_CIF_H>, <&cru SRST_CIF_PCLKIN>;
+		reset-names = "rst_cif_a", "rst_cif_h", "rst_cif_pclkin";
+		power-domains = <&power PX30_PD_VI>;
+                port {
+                        cif_in: endpoint {
+                                remote-endpoint = <&tw9900_out>;
+                        };
+                };
+	};
+...
-- 
2.24.1

