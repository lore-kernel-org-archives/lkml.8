Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9BAC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 16:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B16320B80
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 16:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598633349;
	bh=Pq6AMCutClAdC1MVlFH4CnQL+gGmRAYhCy6R3i2GV1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wop8QFSX5x8Y0mSFADCcosMbJz3iJ3YCtyUIEb1i5FU0Tz7pUrSOs9+kTN0VlQEHb
	 OiHWdV/yfPjw5a08J42Bm7RSbSGLtlF8hvAvmngrUJlNuNgXKDLtiU0S3zEcN9pZyu
	 G7t3rWAnFF9fcBlIaSHPYF4L75a/JGCu6k8nslGY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbgH1QtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 12:49:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:42892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbgH1QtF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 12:49:05 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEC5320936;
        Fri, 28 Aug 2020 16:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598633344;
        bh=Pq6AMCutClAdC1MVlFH4CnQL+gGmRAYhCy6R3i2GV1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mzM4sHYL06XpLQomfCEMXKL2NwP9POamCCfvGAT/a6QRr8556l2Sog2D2xw85j4pF
         B4XOUauS/CJ96R4CbxZuKebJlz99XHj3Gpg54ba5O8tASkW39k5dbpnxJLYWFyPrUB
         UNYsGr2Poye+HkNuPi2vBiSMzPyi+FT+yTOTEOyc=
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
        Anson Huang <Anson.Huang@nxp.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Han Xu <han.xu@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 01/19] dt-bindings: mfd: rohm,bd71847-pmic: Correct clock properties requirements
Date:   Fri, 28 Aug 2020 18:47:32 +0200
Message-Id: <20200828164750.10377-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200828164750.10377-1-krzk@kernel.org>
References: <20200828164750.10377-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The input clock and number of clock provider cells are not required for
the PMIC to operate.  They are needed only for the optional bd718x7
clock driver.

Add also clock-output-names as driver takes use of it.

This fixes dtbs_check warnings like:

    arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dt.yaml: pmic@4b: 'clocks' is a required property
    arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dt.yaml: pmic@4b: '#clock-cells' is a required property

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 .../devicetree/bindings/mfd/rohm,bd71847-pmic.yaml       | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml b/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml
index 77bcca2d414f..5d531051a153 100644
--- a/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml
@@ -38,6 +38,9 @@ properties:
   "#clock-cells":
     const: 0
 
+  clock-output-names:
+    maxItems: 1
+
 # The BD71847 abd BD71850 support two different HW states as reset target
 # states. States are called as SNVS and READY. At READY state all the PMIC
 # power outputs go down and OTP is reload. At the SNVS state all other logic
@@ -116,12 +119,14 @@ required:
   - compatible
   - reg
   - interrupts
-  - clocks
-  - "#clock-cells"
   - regulators
 
 additionalProperties: false
 
+dependencies:
+  '#clock-cells': [clocks]
+  clocks: ['#clock-cells']
+
 examples:
   - |
     #include <dt-bindings/interrupt-controller/irq.h>
-- 
2.17.1

