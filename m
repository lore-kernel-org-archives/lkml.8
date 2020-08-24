Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4E4C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 19:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE8062074D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 19:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598296041;
	bh=D49DFnKwX3H2+4/JHutRBjl6onsdr+JMHUvotdX4JOA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=0qcO53aElqlv+2Vui6UBxXtQorO5w1iNE56R5l4mjwISNS7Y8asPMGchC8aV/ImJN
	 bOB9KqmjKm1DKuOk5WUo4pvyaqNPW3PWoo4C6x2Joxb4OMZp1ui3oKZ55GVONlDWJt
	 5tdew5NMRI7kb3DQtejUf+FziiwvVI2kqTXk7InE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgHXTHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 15:07:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:56944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbgHXTHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 15:07:16 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF8FC2074D;
        Mon, 24 Aug 2020 19:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598296035;
        bh=D49DFnKwX3H2+4/JHutRBjl6onsdr+JMHUvotdX4JOA=;
        h=From:To:Cc:Subject:Date:From;
        b=xroCTR8eKxl6V1lvgh/HrBdL5yumIzn+QzqCpV0HmoTNHLBcd3BOlUqvYqiQ83PtV
         +jE0X2cY7O73uflWwXcWluqNlVZ9SdesRA885D2C0dd3UtzB5zoCx2kjOhk6I+djzV
         DXQeTZZ+iNeRWQbKb9Y2vaA8SQNF3ozNUVvJU0vc=
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
Subject: [PATCH 01/16] dt-bindings: mfd: rohm,bd71847-pmic: Correct clock properties requirements
Date:   Mon, 24 Aug 2020 21:06:46 +0200
Message-Id: <20200824190701.8447-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
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

