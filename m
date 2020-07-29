Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B26FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 12:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20D1E20809
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 12:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgG2MIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 08:08:39 -0400
Received: from inva021.nxp.com ([92.121.34.21]:37884 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726819AbgG2MI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 08:08:28 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id AA3DD200FAB;
        Wed, 29 Jul 2020 14:08:25 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9D8FF2012EC;
        Wed, 29 Jul 2020 14:08:25 +0200 (CEST)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 022772032B;
        Wed, 29 Jul 2020 14:08:24 +0200 (CEST)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Fugang Duan <fugang.duan@nxp.com>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH 10/17] Documentation: bindings: clk: Add bindings for i.MX BLK_CTRL
Date:   Wed, 29 Jul 2020 15:07:56 +0300
Message-Id: <1596024483-21482-11-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596024483-21482-1-git-send-email-abel.vesa@nxp.com>
References: <1596024483-21482-1-git-send-email-abel.vesa@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the i.MX BLK_CTRL with its devicetree properties.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 .../bindings/clock/fsl,imx-blk-ctrl.yaml           | 55 ++++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/fsl,imx-blk-ctrl.yaml

diff --git a/Documentation/devicetree/bindings/clock/fsl,imx-blk-ctrl.yaml b/Documentation/devicetree/bindings/clock/fsl,imx-blk-ctrl.yaml
new file mode 100644
index 00000000..036d3d3
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/fsl,imx-blk-ctrl.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0-only)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/fsl,imx-blk-ctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX BLK_CTRL
+
+description: |
+  i.MX BLK_CTRL is a conglomerate of different GPRs that are
+  dedicated to a specific subsystem. Because it usually contains
+  clocks amongst other things, it needs access to the i.MX clocks
+  API. All the other functionalities it provides can work just fine
+  from the clock subsystem tree.
+
+maintainers:
+  - Abel Vesa <abel.vesa@nxp.com>
+
+properties:
+  reg:
+    maxItems: 1
+
+  compatible:
+    items:
+      - const: fsl,imx8mp-blk-ctrl
+      - const: syscon
+
+  power-domains:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+
+  '#reset-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - power-domains
+  - '#clock-cells'
+  - '#reset-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    audio-blk-ctrl: blk-ctrl@30e20000 {
+       compatible = "fsl,imx8mp-blk-ctrl", "syscon";
+       reg = <0x30e20000 0x10000>;
+       power-domains = <&audiomix_pd>;
+
+       #clock-cells = <1>;
+       #reset-cells = <1>;
+    };
-- 
2.7.4

