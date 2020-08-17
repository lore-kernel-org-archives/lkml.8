Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1404AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAE4A20772
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597647742;
	bh=koUbhmcCngnEsBNZcACvvTnhRk9fiKyQLj+P1iNgYWg=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D7rEEKkGqb/iNnxR52B1yPMETCDW6/BTFPVR84ZfkW0eOGz31Om+aBj7n9t4/rGkT
	 liPiqV7+w1CWIIBZM+rSXCSHgMIiCvkmiFlPBoS44SxudFdWnSAP0WHO5yP+3ZQspx
	 Gjvd8Ud/pnvyIkAixJCGJnCPGiOdH/2iYSbWjoUg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbgHQHCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 03:02:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:45246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbgHQHBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 03:01:31 -0400
Received: from localhost.localdomain (unknown [194.230.155.242])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA98420772;
        Mon, 17 Aug 2020 07:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597647691;
        bh=koUbhmcCngnEsBNZcACvvTnhRk9fiKyQLj+P1iNgYWg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=CRb6neEmkLEgom4BTtEXtTyWG/70ZfUrnCle+07p2H3hV+fPg/WCKa4XRwdE30KAa
         X8PSuen4KV7Y2InP2hs/CeaxKEUUlClUoYmehZzLynkWq60d/1+y08wBYjzgLUcBi5
         LCeOPik3bX5jsdBOXEL/puXO4DmhV7hJCFnZCZG4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/4] dt-bindings: arm: fsl: Add binding for Variscite Symphony board with VAR-SOM-MX8MM
Date:   Mon, 17 Aug 2020 09:01:18 +0200
Message-Id: <20200817070120.4937-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817070120.4937-1-krzk@kernel.org>
References: <20200817070120.4937-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a binding for the Variscite Symphony evaluation kit board with
VAR-SOM-MX8MM System on Module.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. None
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index d8208aa56a3d..27f47ec279f4 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -345,6 +345,12 @@ properties:
               - variscite,var-som-mx8mm   # i.MX8MM Variscite VAR-SOM-MX8MM module
           - const: fsl,imx8mm
 
+      - description: Variscite VAR-SOM-MX8MM based boards
+        items:
+          - const: variscite,var-som-mx8mm-symphony
+          - const: variscite,var-som-mx8mm
+          - const: fsl,imx8mm
+
       - description: i.MX8MN based Boards
         items:
           - enum:
-- 
2.17.1

