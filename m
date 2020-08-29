Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F051CC433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 11:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A97C320776
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 11:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598701211;
	bh=rDXBcV3XN5qq1pJVMo/u6Jp3rVX4suUWfxh/aiZVSVc=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I2TtEWFljhsZpTsHeezhabh0CTpF9Jc5auwa2ijaPTaaA4pc6bKUnz9ihEtElUbX7
	 rPzL8V0uucaCe/xbFFkbopl/w1DNmUvnbrgrKo0GSuvE4uiLNaTcK1yxVIypEcF4WM
	 Bpw1Y+dB8IiSEEqQ7t4cKVpJeRx542yzXAjICrNU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbgH2Ljk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 07:39:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:47906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728087AbgH2La1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 07:30:27 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D519E212CC;
        Sat, 29 Aug 2020 11:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598699904;
        bh=rDXBcV3XN5qq1pJVMo/u6Jp3rVX4suUWfxh/aiZVSVc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=EgI+NKrxdWQD93vyhOdGOCT6BeKcx7yOgSRZkezVVndRl4x41g1yV6TMPGTFBYkvy
         vG9VHEtgFU+u66NNxDxQrwiUh1IgAhXVdDHcr8DhAubc7QoqAvo7pzS2SzOezjFv2U
         dUmDMHNbbsgNiAfU5hIdGxGzXkZSF9hJh5Bb4GIE=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Wolfram Sang <wolfram@the-dreams.de>,
        Dong Aisheng <aisheng.dong@nxp.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: [PATCH 5/7] dt-bindings: i2c: imx-lpi2c: Fix i.MX 8QXP compatible matching
Date:   Sat, 29 Aug 2020 13:17:58 +0200
Message-Id: <20200829111800.2786-5-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200829111800.2786-1-krzk@kernel.org>
References: <20200829111800.2786-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX 8QXP DTSes use two compatibles so update the binding to fix
dtbs_check warnings like:

  arch/arm64/boot/dts/freescale/imx8qxp-mek.dt.yaml: i2c@5a820000:
    compatible: ['fsl,imx8qxp-lpi2c', 'fsl,imx7ulp-lpi2c'] is too long

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../devicetree/bindings/i2c/i2c-imx-lpi2c.yaml        | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-imx-lpi2c.yaml b/Documentation/devicetree/bindings/i2c/i2c-imx-lpi2c.yaml
index 594e174e2cde..319147b780cb 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-imx-lpi2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/i2c-imx-lpi2c.yaml
@@ -11,10 +11,13 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - fsl,imx7ulp-lpi2c
-      - fsl,imx8qxp-lpi2c
-      - fsl,imx8qm-lpi2c
+    oneOf:
+      - enum:
+          - fsl,imx7ulp-lpi2c
+          - fsl,imx8qm-lpi2c
+      - items:
+          - const: fsl,imx8qxp-lpi2c
+          - const: fsl,imx7ulp-lpi2c
 
   reg:
     maxItems: 1
-- 
2.17.1

