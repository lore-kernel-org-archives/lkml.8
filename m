Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14E6C433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 11:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C4CD20776
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 11:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598701047;
	bh=XbS00cGM7FWW3OaLpUHfAbAx2qWn7eq/QxFzyvyD3oE=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Sbojc1eBS5lUVFFdAWtM3bwRKwvVfvycqYWIPBZOp8XYaKAXWV3xYEbnbqzmro0Y7
	 EuZ/Gm12aH18TWJ4aVCcy+YyWk2UhFCGDjJevKgkitol8VffqyIfLKtTcNWwZ0CKa/
	 /W+c7FzfEUnioznQtPJB2C1n4CCHivZ4VXtrAUhc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgH2LhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 07:37:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:47908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728089AbgH2La1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 07:30:27 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF91F20E65;
        Sat, 29 Aug 2020 11:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598699892;
        bh=XbS00cGM7FWW3OaLpUHfAbAx2qWn7eq/QxFzyvyD3oE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=YKqbY9CKJYBZRazouF05mCPzF5D4bmOANdigV1PvouyabuS3dxZy4VR1NbBLxjunf
         wpUJg42+kEh1NO8bPevSRlsZRnLvyZLDPZKpwx/KseQ+nqaq1LoIbnMuIlRyuKHG+d
         EqALPxHH/2IRs6nV6Y1dth7WwF3OWmr3/p6ygSjc=
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
Subject: [PATCH 2/7] dt-bindings: mailbox: fsl,mu: Fix i.MX 8QXP compatible matching
Date:   Sat, 29 Aug 2020 13:17:55 +0200
Message-Id: <20200829111800.2786-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200829111800.2786-1-krzk@kernel.org>
References: <20200829111800.2786-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Mailbox on i.MX 8QXP (fsl,imx8qxp-mu) can also be compatible with
fsl,imx8-mu-scu (for fast IPC) so adjust the compatibles to fix
dtbs_check warnings like:

  arch/arm64/boot/dts/freescale/imx8qxp-mek.dt.yaml: mailbox@5d1f0000:
    compatible: ['fsl,imx8-mu-scu', 'fsl,imx8qxp-mu', 'fsl,imx6sx-mu']
    is not valid under any of the given schemas (Possible causes of the failure):

  arch/arm64/boot/dts/freescale/imx8qxp-mek.dt.yaml: mailbox@5d1f0000:
    compatible: ['fsl,imx8-mu-scu', 'fsl,imx8qxp-mu', 'fsl,imx6sx-mu'] is too long

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/mailbox/fsl,mu.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
index 8a3470b64d06..7ed096360be2 100644
--- a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
+++ b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
@@ -38,8 +38,9 @@ properties:
           - const: fsl,imx6sx-mu
       - description: To communicate with i.MX8 SCU with fast IPC
         items:
-          - const: fsl,imx8qxp-mu
           - const: fsl,imx8-mu-scu
+          - const: fsl,imx8qxp-mu
+          - const: fsl,imx6sx-mu
 
   reg:
     maxItems: 1
-- 
2.17.1

