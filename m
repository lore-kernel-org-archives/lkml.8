Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105ACC54FCF
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 15:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA8D32077D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 15:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbgCYPjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 11:39:33 -0400
Received: from inva021.nxp.com ([92.121.34.21]:53422 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727873AbgCYPj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 11:39:29 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E7621200566;
        Wed, 25 Mar 2020 16:39:27 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id DA35920055D;
        Wed, 25 Mar 2020 16:39:27 +0100 (CET)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 3136A203CE;
        Wed, 25 Mar 2020 16:39:27 +0100 (CET)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Anson Huang <anson.huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     NXP Linux Team <linux-imx@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v2 06/13] clk: imx: pll14xx: Add the device as argument when registering
Date:   Wed, 25 Mar 2020 17:38:44 +0200
Message-Id: <1585150731-3354-7-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585150731-3354-1-git-send-email-abel.vesa@nxp.com>
References: <1585150731-3354-1-git-send-email-abel.vesa@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to allow runtime PM, the device needs to be passed on
to the register function. Audiomix clock controller, used on
i.MX8MP and future platforms, registers a pll14xx and has runtime
PM support.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/imx/clk-pll14xx.c |  8 ++++----
 drivers/clk/imx/clk.h         | 13 ++++++++++---
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/imx/clk-pll14xx.c b/drivers/clk/imx/clk-pll14xx.c
index a83bbbe..f9eb189 100644
--- a/drivers/clk/imx/clk-pll14xx.c
+++ b/drivers/clk/imx/clk-pll14xx.c
@@ -378,9 +378,9 @@ static const struct clk_ops clk_pll1443x_ops = {
 	.set_rate	= clk_pll1443x_set_rate,
 };
 
-struct clk_hw *imx_clk_hw_pll14xx(const char *name, const char *parent_name,
-				  void __iomem *base,
-				  const struct imx_pll14xx_clk *pll_clk)
+struct clk_hw *imx_dev_clk_hw_pll14xx(struct device *dev, const char *name,
+				const char *parent_name, void __iomem *base,
+				const struct imx_pll14xx_clk *pll_clk)
 {
 	struct clk_pll14xx *pll;
 	struct clk_hw *hw;
@@ -426,7 +426,7 @@ struct clk_hw *imx_clk_hw_pll14xx(const char *name, const char *parent_name,
 
 	hw = &pll->hw;
 
-	ret = clk_hw_register(NULL, hw);
+	ret = clk_hw_register(dev, hw);
 	if (ret) {
 		pr_err("%s: failed to register pll %s %d\n",
 			__func__, name, ret);
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 01ff1db..fcd9952a 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -133,9 +133,9 @@ struct clk *imx_clk_pll14xx(const char *name, const char *parent_name,
 #define imx_clk_pll14xx(name, parent_name, base, pll_clk) \
 	to_clk(imx_clk_hw_pll14xx(name, parent_name, base, pll_clk))
 
-struct clk_hw *imx_clk_hw_pll14xx(const char *name, const char *parent_name,
-				  void __iomem *base,
-				  const struct imx_pll14xx_clk *pll_clk);
+struct clk_hw *imx_dev_clk_hw_pll14xx(struct device *dev, const char *name,
+				const char *parent_name, void __iomem *base,
+				const struct imx_pll14xx_clk *pll_clk);
 
 struct clk_hw *imx_clk_hw_pllv1(enum imx_pllv1_type type, const char *name,
 		const char *parent, void __iomem *base);
@@ -242,6 +242,13 @@ static inline struct clk *to_clk(struct clk_hw *hw)
 	return hw->clk;
 }
 
+static inline struct clk_hw *imx_clk_hw_pll14xx(const char *name, const char *parent_name,
+				  void __iomem *base,
+				  const struct imx_pll14xx_clk *pll_clk)
+{
+	return imx_dev_clk_hw_pll14xx(NULL, name, parent_name, base, pll_clk);
+}
+
 static inline struct clk_hw *imx_clk_hw_fixed(const char *name, int rate)
 {
 	return clk_hw_register_fixed_rate(NULL, name, NULL, 0, rate);
-- 
2.7.4

