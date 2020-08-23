Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772B0C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 17:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55D3C204FD
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 17:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598203241;
	bh=MTCNHI1J3CTFq9wsTXJ5Uw1+UYBYl714y/KonzIvP2I=;
	h=From:To:Subject:Date:List-ID:From;
	b=wjO0Vcp/axcZYz2sgFygL1QDgH3x4N87+rIFLRIt5MC/89zbjOo2sV1Oc70aUa79D
	 76jZSzuyLJVHnjXZFONhVB/rwJ4sMfotcweIO7WUzqlui/DEULXo1sb9eePCenJaIa
	 /zeJw6rf6aaj5+gh7Th4wmp9vMRri3ZPDoGaaKfw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgHWRUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 13:20:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:50826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbgHWRU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 13:20:28 -0400
Received: from kozik-lap.proceq-device.com (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D407F20767;
        Sun, 23 Aug 2020 17:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598203226;
        bh=MTCNHI1J3CTFq9wsTXJ5Uw1+UYBYl714y/KonzIvP2I=;
        h=From:To:Subject:Date:From;
        b=TMPPq1Zo4pNSpM3P0EE5fSAKNJwrV02uNz7s3aEBZBuH28Wp0TINtSDu5/uBeczvo
         tuEqG3FuJLytw90XNtjEAV50M7XDRg+FWSCOLK1kpwM/nA9RTmPBtqBtPByVCdyfVu
         uwr9coNRcs9+rcQWPkoR5OgXPtVC2Ejz0Kyg5bC8=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/5] dt-bindings: arm: fsl: Add Beacon i.MX8M Mini Development Kit binding
Date:   Sun, 23 Aug 2020 19:20:15 +0200
Message-Id: <20200823172019.18606-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the binding for Beacon EmbeddedWorks i.MX8M Mini Development
Kit board.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 6da9d734cdb7..37592e7bfee9 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -344,6 +344,7 @@ properties:
       - description: i.MX8MM based Boards
         items:
           - enum:
+              - beacon,imx8mm-beacon-kit  # i.MX8MM Beacon Development Kit
               - fsl,imx8mm-evk            # i.MX8MM EVK Board
           - const: fsl,imx8mm
 
-- 
2.17.1

