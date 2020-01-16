Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE93C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C57F206D9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579217028;
	bh=x7VWme2lw8ORk0owWce2dMLY20RlkOnl0DIjrDoy5VE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iesp7pJbHnDfcOoJIudfA7YFOonckwSE+Oxz8HMdgmMY1dHLHcA35ZYfGZQaD7i3R
	 b4ho+cVZrLrACOhlMmsSpxMKCy+yE/HVCEc33u9p1q191Ufx0ijlIUazCZ8/ontJgJ
	 AvOS1emPySW5NyZlEEulxB2OaS+fVoSbZdr15A6E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbgAPXXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:23:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:52308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729536AbgAPXXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:23:44 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1C132072E;
        Thu, 16 Jan 2020 23:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579217023;
        bh=x7VWme2lw8ORk0owWce2dMLY20RlkOnl0DIjrDoy5VE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sh6MNO3EyV3R0gvwQkrXYnvYb34QQhMXVWkFkJ5H1f90VSGY7a0c1hrv0ofinfZXY
         ZdM6degYTat6LslTaMaygWMil/Skrph4MzsrV+MOQTY8y/gut2OIdcVIC1ivKZ5cTh
         4121+A+GB9bS8jJzl0vxYaQi/WdlDSykGyY77F0k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Leonard Crestez <leonard.crestez@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 5.4 116/203] clk: imx: pll14xx: Fix quick switch of S/K parameter
Date:   Fri, 17 Jan 2020 00:17:13 +0100
Message-Id: <20200116231755.533571415@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231745.218684830@linuxfoundation.org>
References: <20200116231745.218684830@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leonard Crestez <leonard.crestez@nxp.com>

commit 094234fcf46146339caaac8282aa15d225a5911a upstream.

The PLL14xx on imx8m can change the S and K parameter without requiring
a reset and relock of the whole PLL.

Fix clk_pll144xx_mp_change register reading and use it for pll1443 as
well since no reset+relock is required on K changes either.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Fixes: 8646d4dcc7fb ("clk: imx: Add PLLs driver for imx8mm soc")
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/imx/clk-pll14xx.c |   40 ++++++++--------------------------------
 1 file changed, 8 insertions(+), 32 deletions(-)

--- a/drivers/clk/imx/clk-pll14xx.c
+++ b/drivers/clk/imx/clk-pll14xx.c
@@ -112,43 +112,17 @@ static unsigned long clk_pll1443x_recalc
 	return fvco;
 }
 
-static inline bool clk_pll1416x_mp_change(const struct imx_pll14xx_rate_table *rate,
+static inline bool clk_pll14xx_mp_change(const struct imx_pll14xx_rate_table *rate,
 					  u32 pll_div)
 {
 	u32 old_mdiv, old_pdiv;
 
-	old_mdiv = (pll_div >> MDIV_SHIFT) & MDIV_MASK;
-	old_pdiv = (pll_div >> PDIV_SHIFT) & PDIV_MASK;
+	old_mdiv = (pll_div & MDIV_MASK) >> MDIV_SHIFT;
+	old_pdiv = (pll_div & PDIV_MASK) >> PDIV_SHIFT;
 
 	return rate->mdiv != old_mdiv || rate->pdiv != old_pdiv;
 }
 
-static inline bool clk_pll1443x_mpk_change(const struct imx_pll14xx_rate_table *rate,
-					  u32 pll_div_ctl0, u32 pll_div_ctl1)
-{
-	u32 old_mdiv, old_pdiv, old_kdiv;
-
-	old_mdiv = (pll_div_ctl0 >> MDIV_SHIFT) & MDIV_MASK;
-	old_pdiv = (pll_div_ctl0 >> PDIV_SHIFT) & PDIV_MASK;
-	old_kdiv = (pll_div_ctl1 >> KDIV_SHIFT) & KDIV_MASK;
-
-	return rate->mdiv != old_mdiv || rate->pdiv != old_pdiv ||
-		rate->kdiv != old_kdiv;
-}
-
-static inline bool clk_pll1443x_mp_change(const struct imx_pll14xx_rate_table *rate,
-					  u32 pll_div_ctl0, u32 pll_div_ctl1)
-{
-	u32 old_mdiv, old_pdiv, old_kdiv;
-
-	old_mdiv = (pll_div_ctl0 >> MDIV_SHIFT) & MDIV_MASK;
-	old_pdiv = (pll_div_ctl0 >> PDIV_SHIFT) & PDIV_MASK;
-	old_kdiv = (pll_div_ctl1 >> KDIV_SHIFT) & KDIV_MASK;
-
-	return rate->mdiv != old_mdiv || rate->pdiv != old_pdiv ||
-		rate->kdiv != old_kdiv;
-}
-
 static int clk_pll14xx_wait_lock(struct clk_pll14xx *pll)
 {
 	u32 val;
@@ -174,7 +148,7 @@ static int clk_pll1416x_set_rate(struct
 
 	tmp = readl_relaxed(pll->base + 4);
 
-	if (!clk_pll1416x_mp_change(rate, tmp)) {
+	if (!clk_pll14xx_mp_change(rate, tmp)) {
 		tmp &= ~(SDIV_MASK) << SDIV_SHIFT;
 		tmp |= rate->sdiv << SDIV_SHIFT;
 		writel_relaxed(tmp, pll->base + 4);
@@ -239,13 +213,15 @@ static int clk_pll1443x_set_rate(struct
 	}
 
 	tmp = readl_relaxed(pll->base + 4);
-	div_val = readl_relaxed(pll->base + 8);
 
-	if (!clk_pll1443x_mpk_change(rate, tmp, div_val)) {
+	if (!clk_pll14xx_mp_change(rate, tmp)) {
 		tmp &= ~(SDIV_MASK) << SDIV_SHIFT;
 		tmp |= rate->sdiv << SDIV_SHIFT;
 		writel_relaxed(tmp, pll->base + 4);
 
+		tmp = rate->kdiv << KDIV_SHIFT;
+		writel_relaxed(tmp, pll->base + 8);
+
 		return 0;
 	}
 


