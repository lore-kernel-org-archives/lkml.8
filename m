Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBC9C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 19:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DA1C208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 19:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598296712;
	bh=Jfwa0GB0ZLb8gVwHhi0OjtkS/JePmX7U96zqz3dMCNQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=by33cjFMmksWkSavJEug23lW47Ffr/G8zFGa+C4Z0skQs4Auc4xlcua+Sc+HSBZqU
	 JbvqlFDlGmPL9nqTdJETbWiF+94qHqywVhh/HCZWFyjwBR5LtebtXATkITvYtY7jhA
	 AUsG7eoSeWrtgDBMGNS8LzzA9hvdlV9smvdSDWRs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgHXTSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 15:18:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:40162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726519AbgHXTS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 15:18:28 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D89B020578;
        Mon, 24 Aug 2020 19:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598296708;
        bh=Jfwa0GB0ZLb8gVwHhi0OjtkS/JePmX7U96zqz3dMCNQ=;
        h=From:To:Cc:Subject:Date:From;
        b=1blOXHtC28gYM4YCJ6ugjvip2y7cy3vtrg0Tn9fvtv9hwp/T0+uMdDrJJlIEQmQkf
         9jvOafZVtH7EzFG4luNzpKZ54NY7as9F1KGSFqFlyErmAL7K7UpzfLzz7vqdgSHilp
         zsyGHGpgcqa2KxVXxmdyLwv+5mB/rQDpkgOc5Ur8=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v4 1/4] dt-bindings: arm: fsl: Add binding for Variscite VAR-SOM-MX8MM module
Date:   Mon, 24 Aug 2020 21:18:16 +0200
Message-Id: <20200824191819.11057-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a binding for the Variscite VAR-SOM-MX8MM System on Module.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Based on top of:
https://lore.kernel.org/linux-arm-kernel/20200823172019.18606-1-krzk@kernel.org/

Changes since v1:
1. None
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index b48dbf924cfe..39f3a3d5f524 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -346,6 +346,7 @@ properties:
           - enum:
               - beacon,imx8mm-beacon-kit  # i.MX8MM Beacon Development Kit
               - fsl,imx8mm-evk            # i.MX8MM EVK Board
+              - variscite,var-som-mx8mm   # i.MX8MM Variscite VAR-SOM-MX8MM module
           - const: fsl,imx8mm
 
       - description: i.MX8MN based Boards
-- 
2.17.1

