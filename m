Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D47C433E7
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 06:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72B47207BB
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 06:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598682329;
	bh=qIkTPYaLCHkfiMzdPbJZFSyObU1cQmHOgPZyCvUGrds=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=vDVZ0F+Ex4R3ztvg0QdRpw32bGufsj7ri0RK/eskBlH7H+A6gdUBmh0Iwjj/9/BS+
	 oY2QyHHoXhQWE/8SfTfcyfZ8J71HyiudV7KYDT/YOb8073qGa3bVD90mUo72sKi+kg
	 S8ee9EDrHfMJ8eA/NCKzsx1No5RDqGP5sHTuQYWU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgH2GZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 02:25:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:56730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbgH2GZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 02:25:20 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E3A420936;
        Sat, 29 Aug 2020 06:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598682319;
        bh=qIkTPYaLCHkfiMzdPbJZFSyObU1cQmHOgPZyCvUGrds=;
        h=From:To:Cc:Subject:Date:From;
        b=jxALBv4gVlZsetLBui5NUtHFVD9Uz+jH6gR4bdjj7GqsRskdbXn9YoI5xDAV4coWs
         Tomeao5mkuGFpBtbsSwdI1/iinnt33w6RYQ206lWsUDr5pcinLPczqLP88/4DB5lWc
         urNLvjOV8mXtPa7jahP0LPj9eiVG5kPuLzJq+0tM=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v4] dt-bindings: mmc: fsl-imx-esdhc: Fix i.MX 8 compatible matching
Date:   Sat, 29 Aug 2020 08:25:05 +0200
Message-Id: <20200829062505.4642-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX 8 DTSes use two compatibles so update the binding to fix
dtbs_check warnings like:

  arch/arm64/boot/dts/freescale/imx8mn-evk.dt.yaml: mmc@30b40000:
    compatible: ['fsl,imx8mn-usdhc', 'fsl,imx7d-usdhc'] is too long
    From schema: Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml

  arch/arm64/boot/dts/freescale/imx8mn-evk.dt.yaml: mmc@30b40000:
    compatible: Additional items are not allowed ('fsl,imx7d-usdhc' was unexpected)

  arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dt.yaml: mmc@30b40000:
    compatible: ['fsl,imx8mn-usdhc', 'fsl,imx7d-usdhc'] is too long

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v3:
1. Fix also example in Documentation/devicetree/bindings/clock/imx8qxp-lpcg.yaml

Changes since v2:
1. Remove moved compatibles.

Changes since v1:
1. Handle also fsl,imx8mm-usdhc and fsl,imx8qxp-usdhc
---
 .../bindings/clock/imx8qxp-lpcg.yaml          |  2 +-
 .../bindings/mmc/fsl-imx-esdhc.yaml           | 37 ++++++++++---------
 2 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/imx8qxp-lpcg.yaml b/Documentation/devicetree/bindings/clock/imx8qxp-lpcg.yaml
index 1d5e9bcce4c8..33f3010f48c3 100644
--- a/Documentation/devicetree/bindings/clock/imx8qxp-lpcg.yaml
+++ b/Documentation/devicetree/bindings/clock/imx8qxp-lpcg.yaml
@@ -62,7 +62,7 @@ examples:
     };
 
     mmc@5b010000 {
-        compatible = "fsl,imx8qxp-usdhc";
+        compatible = "fsl,imx8qxp-usdhc", "fsl,imx7d-usdhc";
         interrupts = <GIC_SPI 232 IRQ_TYPE_LEVEL_HIGH>;
         reg = <0x5b010000 0x10000>;
         clocks = <&conn_lpcg IMX_CONN_LPCG_SDHC0_IPG_CLK>,
diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
index 10b45966f1b8..e71d13c2d109 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
+++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
@@ -21,23 +21,26 @@ description: |
 
 properties:
   compatible:
-    enum:
-      - fsl,imx25-esdhc
-      - fsl,imx35-esdhc
-      - fsl,imx51-esdhc
-      - fsl,imx53-esdhc
-      - fsl,imx6q-usdhc
-      - fsl,imx6sl-usdhc
-      - fsl,imx6sx-usdhc
-      - fsl,imx6ull-usdhc
-      - fsl,imx7d-usdhc
-      - fsl,imx7ulp-usdhc
-      - fsl,imx8mq-usdhc
-      - fsl,imx8mm-usdhc
-      - fsl,imx8mn-usdhc
-      - fsl,imx8mp-usdhc
-      - fsl,imx8qm-usdhc
-      - fsl,imx8qxp-usdhc
+    oneOf:
+      - enum:
+          - fsl,imx25-esdhc
+          - fsl,imx35-esdhc
+          - fsl,imx51-esdhc
+          - fsl,imx53-esdhc
+          - fsl,imx6q-usdhc
+          - fsl,imx6sl-usdhc
+          - fsl,imx6sx-usdhc
+          - fsl,imx6ull-usdhc
+          - fsl,imx7d-usdhc
+          - fsl,imx7ulp-usdhc
+      - items:
+          - enum:
+              - fsl,imx8mm-usdhc
+              - fsl,imx8mn-usdhc
+              - fsl,imx8mp-usdhc
+              - fsl,imx8mq-usdhc
+              - fsl,imx8qxp-usdhc
+          - const: fsl,imx7d-usdhc
 
   reg:
     maxItems: 1
-- 
2.17.1

