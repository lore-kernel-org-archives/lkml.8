Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07979C433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 11:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D58AE21527
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 11:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598700547;
	bh=jpPjWh6NvjNnA8Jn0CmFtKO+pYti8+XJbh59IY3ALEE=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BL69/04kEsh+remadMgpA4skFuktBbYgJfr2i8WKQfRnQqLIjAN3ezgIMgEb3yZpY
	 carYDL/9NzpVBF2CR8bq7oJdXWThdHN/x6mx0mLuPYKA1/ShXYuM+9kGekHSQSJ5K/
	 5TCL1hLUOH7pG5w+DBNOj+lNZLdLheVMI8D9VLHQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgH2L27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 07:28:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:44802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727930AbgH2LXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 07:23:44 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27C2F20CC7;
        Sat, 29 Aug 2020 11:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598699912;
        bh=jpPjWh6NvjNnA8Jn0CmFtKO+pYti8+XJbh59IY3ALEE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=u/iBHlfCQMbcoJGw+hNYUjYe6HpcATuliCE+mdP/1pjDbyBePKFiRRo6CbPrUBtrG
         +z7UavNPTgyiA3XEyQCp8pCz7X18g1hcII+N02RC0YoMllqVy/2/Ec0zsQ6yCxnOIo
         0bfFBtVJvgRxV5wESQAL+466Plxc02TsTTqWM6fg=
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
Subject: [PATCH 7/7] dt-bindings: i2c: imx: Fix i.MX 7 compatible matching
Date:   Sat, 29 Aug 2020 13:18:00 +0200
Message-Id: <20200829111800.2786-7-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200829111800.2786-1-krzk@kernel.org>
References: <20200829111800.2786-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX 7 DTSes use two compatibles so update the binding to fix
dtbs_check warnings like:

  arch/arm/boot/dts/imx7d-cl-som-imx7.dt.yaml: i2c@30a20000:
    compatible: ['fsl,imx7d-i2c', 'fsl,imx21-i2c'] is not valid under any of the given schemas (Possible causes of the failure):

  arch/arm/boot/dts/imx7d-cl-som-imx7.dt.yaml: i2c@30a20000:
    compatible: ['fsl,imx7d-i2c', 'fsl,imx21-i2c'] is too long

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/i2c/i2c-imx.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-imx.yaml b/Documentation/devicetree/bindings/i2c/i2c-imx.yaml
index 73b4e628802c..2d555d5bacc5 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-imx.yaml
+++ b/Documentation/devicetree/bindings/i2c/i2c-imx.yaml
@@ -18,6 +18,9 @@ properties:
       - items:
           - const: fsl,imx35-i2c
           - const: fsl,imx1-i2c
+      - items:
+          - const: fsl,imx7d-i2c
+          - const: fsl,imx21-i2c
       - items:
           - enum:
               - fsl,imx25-i2c
-- 
2.17.1

