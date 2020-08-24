Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B10CC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 19:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D11FE2074D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 19:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598296047;
	bh=XHlvvAtBERuOAyXXY6dPcG5or9pk/gOG5ME94ky5VIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ivioQZW4+v7CqPp850Ib13U3g7ll9APbDzelO825q4eWt7rOaLGK2d5aptknjITJV
	 9+vrt2UUVfYpSwUaGfDNK/uAuA7hqtE9XT6/WQwjqqCpI4PL9VMjwDdf07q2n5XPhS
	 h3dVR73mQ1guaoaaQYFR4ZtGbCYcFX2ZQ10R2qoQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgHXTHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 15:07:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:57078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbgHXTHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 15:07:22 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87C9F2078D;
        Mon, 24 Aug 2020 19:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598296041;
        bh=XHlvvAtBERuOAyXXY6dPcG5or9pk/gOG5ME94ky5VIQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pk63FqLps1QHpow/V9UpEWLK7ynLybVvcGCXAYSHNPZQQKVWQ+6DNVWwsD3KOi1Yj
         XceVtBLA0n83YgD16ApL8lIttezVrPDKM8YkaTL+2c9mgxYWLrB++UqhMd2SJ8yYFV
         w98xPVO1LxCi3P6So88BaDiQgK68xDhvu9vUuRO4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Adam Ford <aford173@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>, Li Jun <jun.li@nxp.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Han Xu <han.xu@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 02/16] dt-bindings: mtd: gpmi-nand: Fix matching of clocks on different SoCs
Date:   Mon, 24 Aug 2020 21:06:47 +0200
Message-Id: <20200824190701.8447-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200824190701.8447-1-krzk@kernel.org>
References: <20200824190701.8447-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver requires different amount of clocks for different SoCs.  Describe
these requirements properly to fix dtbs_check warnings like:

    arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dt.yaml: nand-controller@33002000: clock-names:1: 'gpmi_apb' was expected

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../devicetree/bindings/mtd/gpmi-nand.yaml    | 76 +++++++++++++++----
 1 file changed, 61 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml b/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml
index 28ff8c581837..9d764e654e1d 100644
--- a/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml
+++ b/Documentation/devicetree/bindings/mtd/gpmi-nand.yaml
@@ -9,9 +9,6 @@ title: Freescale General-Purpose Media Interface (GPMI) binding
 maintainers:
   - Han Xu <han.xu@nxp.com>
 
-allOf:
-  - $ref: "nand-controller.yaml"
-
 description: |
   The GPMI nand controller provides an interface to control the NAND
   flash chips. The device tree may optionally contain sub-nodes
@@ -58,22 +55,10 @@ properties:
   clocks:
     minItems: 1
     maxItems: 5
-    items:
-      - description: SoC gpmi io clock
-      - description: SoC gpmi apb clock
-      - description: SoC gpmi bch clock
-      - description: SoC gpmi bch apb clock
-      - description: SoC per1 bch clock
 
   clock-names:
     minItems: 1
     maxItems: 5
-    items:
-      - const: gpmi_io
-      - const: gpmi_apb
-      - const: gpmi_bch
-      - const: gpmi_bch_apb
-      - const: per1_bch
 
   fsl,use-minimum-ecc:
     type: boolean
@@ -107,6 +92,67 @@ required:
 
 unevaluatedProperties: false
 
+allOf:
+  - $ref: "nand-controller.yaml"
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx23-gpmi-nand
+              - fsl,imx28-gpmi-nand
+    then:
+      properties:
+        clocks:
+          items:
+            - description: SoC gpmi io clock
+        clock-names:
+          items:
+            - const: gpmi_io
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx6q-gpmi-nand
+              - fsl,imx6sx-gpmi-nand
+    then:
+      properties:
+        clocks:
+          items:
+            - description: SoC gpmi io clock
+            - description: SoC gpmi apb clock
+            - description: SoC gpmi bch clock
+            - description: SoC gpmi bch apb clock
+            - description: SoC per1 bch clock
+        clock-names:
+          items:
+            - const: gpmi_io
+            - const: gpmi_apb
+            - const: gpmi_bch
+            - const: gpmi_bch_apb
+            - const: per1_bch
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: fsl,imx7d-gpmi-nand
+    then:
+      properties:
+        clocks:
+          items:
+            - description: SoC gpmi io clock
+            - description: SoC gpmi bch apb clock
+        clock-names:
+          minItems: 2
+          maxItems: 2
+          items:
+            - const: gpmi_io
+            - const: gpmi_bch_apb
+
 examples:
   - |
     nand-controller@8000c000 {
-- 
2.17.1

