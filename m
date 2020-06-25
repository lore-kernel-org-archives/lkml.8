Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA36BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 14:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB12E206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 14:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OB6P4UXq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405256AbgFYOBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 10:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405145AbgFYOBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 10:01:12 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD9EC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 07:01:12 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id h23so4678664qtr.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 07:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xmHeLYCaw0g+TtCjwJeJ3J50snewkzB3BQXGW6qA/b8=;
        b=OB6P4UXqU2MNty9AwXP6n9oE/Z1JLPm536SlYulamUkDDzM5uvwHvne33+ZaP5Dyyp
         uewLuO9kUfZv8sfgv6iLi+e+pPVFpir2ZI2HLPMATUvrMhmBBMgEb4qxeVKJxh0mbAx0
         Or8V3KfdeM5hPJY1vpQTj2evsm9P5ujMhD4k2gotd6Mf0QmictaJWM0YDSKEVR9M1Q4v
         tFdekITcq1fXubmwWZlJO9Kad8gqpz68pNJj5E1g8XoPxAqEs9GCgvrXRbPy9c0sKJKS
         9D3voyowUm8BgYAfSSWKFd2A2NtSb1NChVv92RNH23C4N17W++fCnKUc4Hi3mgKa+A/O
         cqWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xmHeLYCaw0g+TtCjwJeJ3J50snewkzB3BQXGW6qA/b8=;
        b=gZG3yOpPW5B4whOMvP0Ycv5kJ8W/260hpBGQ7HyWg9PVe1LKiBSj/YJstOa27/N8dr
         7u0+EbmYfzmHdCqBuCUwssTNuetROc0wEyHIyQ0ikefbnWNrsvH5+7UeLyr6twdn/LVG
         T7WzUCkWtqEe7skMkU3Y6cmlOzcBk6niCi1hV8zxxx9XRvFIPqlshNbHtEgmOBDJHdAR
         C36cD2+nV+93VjNDrMLrZG2YzfnYY56WhAr9CdkK8xAQgmP+Ozl6ZQPS1L+w7h2D+kwo
         TSRIsPSABBUDks4/h8Gqw5CdIZKX2fdryoLXOl8ke7oFiZpzUbdCUpUiE1gnbLqK3g5r
         WOvQ==
X-Gm-Message-State: AOAM531ptMX/E2WUvu2c1GJaaTrKM5PJyxESnwU5BTelLmmjretxz8Ng
        9nkEtuq1ZAK2PPG4j1NSqxs=
X-Google-Smtp-Source: ABdhPJwXJ2hlI1sfszdA2UXUkgOAQfdCwi5/qN1PAljUUsu/xdXtuzfYnXrvyVG40QRsxfncSdK8kw==
X-Received: by 2002:ac8:1ac4:: with SMTP id h4mr19480556qtk.249.1593093671249;
        Thu, 25 Jun 2020 07:01:11 -0700 (PDT)
Received: from localhost.localdomain ([72.53.229.195])
        by smtp.gmail.com with ESMTPSA id f4sm5337691qtv.59.2020.06.25.07.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 07:01:10 -0700 (PDT)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     shawnguo@kernel.org, fugang.duan@nxp.com
Cc:     Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] ARM: imx: mach-imx6q: Search for fsl,imx6q-iomuxc-gpr earlier
Date:   Thu, 25 Jun 2020 10:01:04 -0400
Message-Id: <20200625140105.14999-1-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabio Estevam <festevam@gmail.com>

Check the presence of fsl,imx6q-iomuxc-gpr earlier and exit in case
of failure.

This is done in preparation for adding support for configuring the
GPR5 register for i.MX6QP a bit easier.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---

Patch history: see
  [PATCH v4 2/2] ARM: imx6plus: enable internal routing of clk_enet_ref

To: Shawn Guo <shawnguo@kernel.org>
To: Andy Duan <fugang.duan@nxp.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

 arch/arm/mach-imx/mach-imx6q.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 85c084a716ab..ae89ad93ca83 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -169,6 +169,12 @@ static void __init imx6q_1588_init(void)
 	struct regmap *gpr;
 	u32 clksel;
 
+	gpr = syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
+	if (IS_ERR(gpr)) {
+		pr_err("failed to find fsl,imx6q-iomuxc-gpr regmap\n");
+		return;
+	}
+
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-fec");
 	if (!np) {
 		pr_warn("%s: failed to find fec node\n", __func__);
@@ -195,13 +201,8 @@ static void __init imx6q_1588_init(void)
 	clksel = clk_is_match(ptp_clk, enet_ref) ?
 				IMX6Q_GPR1_ENET_CLK_SEL_ANATOP :
 				IMX6Q_GPR1_ENET_CLK_SEL_PAD;
-	gpr = syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
-	if (!IS_ERR(gpr))
-		regmap_update_bits(gpr, IOMUXC_GPR1,
-				IMX6Q_GPR1_ENET_CLK_SEL_MASK,
-				clksel);
-	else
-		pr_err("failed to find fsl,imx6q-iomuxc-gpr regmap\n");
+	regmap_update_bits(gpr, IOMUXC_GPR1, IMX6Q_GPR1_ENET_CLK_SEL_MASK,
+			   clksel);
 
 	clk_put(enet_ref);
 put_ptp_clk:
-- 
2.17.1

