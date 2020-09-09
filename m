Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF5DC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8D40206D4
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599672022;
	bh=IdciNq/N/4EjGygxwJbHbLykp3d/ZQrUrJEOTklPc/A=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=wYvhYjLxJnJ08Y0+rGqzW3cykOx2FEn4jF6mQok+y3KrLJhfhLjeoIPPioNBainII
	 8iyjAkEzcdvuMz1eE9cIQJsp2rImI0VtHgcnwxjcM5ci/O3RA/2fmYJ7inLMjfkgil
	 KWk8UgKdNujLeNGo0YfW/BK34lF/9g20dy8EBZ0U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731150AbgIIRUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 13:20:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:51344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729738AbgIIP0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:26:37 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1DBE2228A;
        Wed,  9 Sep 2020 15:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599665092;
        bh=IdciNq/N/4EjGygxwJbHbLykp3d/ZQrUrJEOTklPc/A=;
        h=From:To:Cc:Subject:Date:From;
        b=KSoBXwpx0FIRBnhRA8tNBbDT0JHghs9nuBgU6dLdLL8CIWjZAOt/wGTjFNIGGmzRz
         QOgkRHjtmkOoNyyOCG0TnsBejQ23kqHELsWl6nu1Zbipzx4HQI8/HUBLvrDgiVHFpS
         DQnCXm6fktnlOvTu0lVHAWujTr4zb5aKvp8dtF8U=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/3] dt-bindings: arm: fsl: Add binding for Variscite Symphony board with VAR-SOM-MX8MN
Date:   Wed,  9 Sep 2020 17:24:32 +0200
Message-Id: <20200909152434.18643-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a binding for the Variscite Symphony evaluation kit board with
VAR-SOM-MX8MN System on Module.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 37cef8653541..8a8284715baf 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -363,6 +363,12 @@ properties:
               - fsl,imx8mn-evk            # i.MX8MN LPDDR4 EVK Board
           - const: fsl,imx8mn
 
+      - description: Variscite VAR-SOM-MX8MN based boards
+        items:
+          - const: variscite,var-som-mx8mn-symphony
+          - const: variscite,var-som-mx8mn
+          - const: fsl,imx8mn
+
       - description: i.MX8MP based Boards
         items:
           - enum:
-- 
2.17.1

