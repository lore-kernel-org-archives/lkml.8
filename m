Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BEC0C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 388672076C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597160383;
	bh=ONUj1MhOcyH5grU4GRbUvx8jd92g2gDccNem5aUwfIc=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L7uq/voiG0mBvU6iHh6SXXVOa64bDK4H7Xk+SMzj9LjERrNU28B+R10mLigS2KUIs
	 Vko/7HYb286EmswFD7+s9+Zs+lLKzLjjANVvaa3bLDctL5ba9VJ3p4Izqlf0kEYLaI
	 kF6ZszmrH3Qd0v7+I/58joQ5QuHWsx82lP7Jiol0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbgHKPji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 11:39:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:45672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728943AbgHKPjb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 11:39:31 -0400
Received: from localhost.localdomain (unknown [194.230.155.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E034120771;
        Tue, 11 Aug 2020 15:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597160371;
        bh=ONUj1MhOcyH5grU4GRbUvx8jd92g2gDccNem5aUwfIc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=dcwXWo2M13MoU2CNBVznx5BjlBLMAU7iby1LFXfq373unAMpHDnNkGRz3j0WGmOrU
         WS5JdgHKt7+1eFWVCIFNT9Acb5PuW9FryVDsjtDVLsjBtwkP9MNw9uuUkDG2JVGD3I
         eO1ixRoy5rxhhy3Cw/O0aBIN4QkP7Dks45J5ZhMY=
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
Subject: [PATCH 2/4] dt-bindings: arm: fsl: Add binding for Variscite Symphony board with VAR-SOM-MX8MM
Date:   Tue, 11 Aug 2020 17:39:14 +0200
Message-Id: <20200811153916.5455-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200811153916.5455-1-krzk@kernel.org>
References: <20200811153916.5455-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a binding for the Variscite Symphony evaluation kit board with
VAR-SOM-MX8MM System on Module.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
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

