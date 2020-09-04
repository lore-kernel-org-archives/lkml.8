Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65869C2BB84
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B40F20770
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599232473;
	bh=FlSt5Uy3rO3KK0MjaHnzxZ+5UOiYYkl0bORRszeykXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LaxbbsEF99N017C0+MTuzoCATuF3djfGlSCJeWFqQ08brfMEPjiEVeXDN4BZJ9FQa
	 cRI35SDLj99FeFkHkbkVfyfJjSQVsGnKdhDp2VFb3KqEBk9vBZ90r9Bc9z1H485m0U
	 c8mYRw8MfHYuUrGB0XGYtIZ/DPRa2WbxynzZrQKA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730834AbgIDPOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:14:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:58088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730495AbgIDPOW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:14:22 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3987020770;
        Fri,  4 Sep 2020 15:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599232461;
        bh=FlSt5Uy3rO3KK0MjaHnzxZ+5UOiYYkl0bORRszeykXQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OQUpXUN1UorM33FpHl0weC/ddHJVuItnkevGMg24ePLlvnccTFB3Aup0bDcpSk1+X
         3mKnXuOEuusz4CWzVRSsrvDdlXubUoT/aCJ1XAgcrrAOa9RDPgj8vUuaunhMmQ6i8b
         hXco7JWc6sNTVaQlKikDAyiRWxZnV7BobqcsBS0M=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Wolfram Sang <wolfram@the-dreams.de>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 2/4] dt-bindings: i2c: imx-lpi2c: Fix i.MX 8QXP compatible matching
Date:   Fri,  4 Sep 2020 17:14:09 +0200
Message-Id: <20200904151411.18973-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904151411.18973-1-krzk@kernel.org>
References: <20200904151411.18973-1-krzk@kernel.org>
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
index e5cfd08faa07..3a5be4b2f911 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-imx-lpi2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/i2c-imx-lpi2c.yaml
@@ -14,10 +14,13 @@ allOf:
 
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
 
   '#address-cells': true
   '#size-cells': true
-- 
2.17.1

