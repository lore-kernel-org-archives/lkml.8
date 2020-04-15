Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A98CC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 08:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78AD82078A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 08:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635531AbgDOIGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 04:06:40 -0400
Received: from inva021.nxp.com ([92.121.34.21]:46752 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408044AbgDOID2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 04:03:28 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id AE110200349;
        Wed, 15 Apr 2020 10:03:06 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A0B89200790;
        Wed, 15 Apr 2020 10:03:06 +0200 (CEST)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 0994F202B0;
        Wed, 15 Apr 2020 10:03:06 +0200 (CEST)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Lee Jones <lee.jones@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v3 02/13] Documentation: mfd: Add DT bindings for i.MX Mix
Date:   Wed, 15 Apr 2020 11:02:42 +0300
Message-Id: <1586937773-5836-3-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586937773-5836-1-git-send-email-abel.vesa@nxp.com>
References: <1586937773-5836-1-git-send-email-abel.vesa@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documnent the i.MX Mix with its devicetree properties.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 .../devicetree/bindings/mfd/fsl,imx-mix.yaml       | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/fsl,imx-mix.yaml

diff --git a/Documentation/devicetree/bindings/mfd/fsl,imx-mix.yaml b/Documentation/devicetree/bindings/mfd/fsl,imx-mix.yaml
new file mode 100644
index 00000000..8b1870e
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/fsl,imx-mix.yaml
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/fsl,imx-mix.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale i.MX mix
+
+description: |
+  i.MX mix is a conglomerate of different GPRs that are
+  usually dedicated to one subsystem. These GPRs can be
+  further split between different types of drivers, once
+  the MFD populates all the devices based on its devicetree
+  subnodes.
+
+maintainers:
+  - Abel Vesa <abel.vesa@nxp.com>
+
+properties:
+  reg:
+    maxItems: 1
+  compatible:
+    const: fsl,imx8mp-mix
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    audiomix: mix@30e20000 {
+       compatible = "fsl,imx8mp-mix";
+       reg = <0x30e20000 0x10000>;
+    };
-- 
2.7.4

