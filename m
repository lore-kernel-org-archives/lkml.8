Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01AA0C10F29
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 13:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB9A52146E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 13:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="P/CN4sXj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729670AbgCKNlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 09:41:25 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:50472 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729535AbgCKNlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 09:41:21 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A785243B60;
        Wed, 11 Mar 2020 13:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1583934080; bh=MrYqWoJsLLc48EYOcna6bzraId29vA+POfySYiFDcto=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P/CN4sXj58UqoIpsW4r9iBWNBV9e2ghWDYdt6Rnv2sdAvNBFlQv3/ZR+Jn5n9WGEe
         eVzF2YfV2bURfjeSQI74i5fX0ojR4tn6EaA3g1FjOvNhRBtbPIZ/dmkH4FaD3/ROrV
         yyFi7ST30lj44kBoHHOFrSp19lO9Oop4rxUreaV4gWLPR197kHINcNjx+WuZ4PR8Vp
         ll+29ymICQHJxLG3hi5099RTxYWu7B2fXeS0Tnk5MrgGjWoLTL94pWh2ZTktMua4q9
         z2hAp+Q5+835a8hAz0VnngDfHOcWDE2HNXYbVDTF+hC88AtSdMJjXT4bWUtAqf4iCU
         tdDK0+iZDO4pw==
Received: from paltsev-e7480.internal.synopsys.com (unknown [10.121.8.79])
        by mailhost.synopsys.com (Postfix) with ESMTP id F380CA0063;
        Wed, 11 Mar 2020 13:41:18 +0000 (UTC)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH 2/3] CLK: HSDK: CGU: support PLL bypassing
Date:   Wed, 11 Mar 2020 16:41:14 +0300
Message-Id: <20200311134115.13257-3-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200311134115.13257-1-Eugeniy.Paltsev@synopsys.com>
References: <20200311134115.13257-1-Eugeniy.Paltsev@synopsys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support setting PLL to bypass mode to support output frequency
equal to input one.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 drivers/clk/clk-hsdk-pll.c | 61 +++++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 27 deletions(-)

diff --git a/drivers/clk/clk-hsdk-pll.c b/drivers/clk/clk-hsdk-pll.c
index b47a559f3528..0ea7af57a5b1 100644
--- a/drivers/clk/clk-hsdk-pll.c
+++ b/drivers/clk/clk-hsdk-pll.c
@@ -53,35 +53,37 @@ struct hsdk_pll_cfg {
 	u32 fbdiv;
 	u32 odiv;
 	u32 band;
+	u32 bypass;
 };
 
 static const struct hsdk_pll_cfg asdt_pll_cfg[] = {
-	{ 100000000,  0, 11, 3, 0 },
-	{ 133000000,  0, 15, 3, 0 },
-	{ 200000000,  1, 47, 3, 0 },
-	{ 233000000,  1, 27, 2, 0 },
-	{ 300000000,  1, 35, 2, 0 },
-	{ 333000000,  1, 39, 2, 0 },
-	{ 400000000,  1, 47, 2, 0 },
-	{ 500000000,  0, 14, 1, 0 },
-	{ 600000000,  0, 17, 1, 0 },
-	{ 700000000,  0, 20, 1, 0 },
-	{ 800000000,  0, 23, 1, 0 },
-	{ 900000000,  1, 26, 0, 0 },
-	{ 1000000000, 1, 29, 0, 0 },
-	{ 1100000000, 1, 32, 0, 0 },
-	{ 1200000000, 1, 35, 0, 0 },
-	{ 1300000000, 1, 38, 0, 0 },
-	{ 1400000000, 1, 41, 0, 0 },
-	{ 1500000000, 1, 44, 0, 0 },
-	{ 1600000000, 1, 47, 0, 0 },
+	{ 100000000,  0, 11, 3, 0, 0 },
+	{ 133000000,  0, 15, 3, 0, 0 },
+	{ 200000000,  1, 47, 3, 0, 0 },
+	{ 233000000,  1, 27, 2, 0, 0 },
+	{ 300000000,  1, 35, 2, 0, 0 },
+	{ 333000000,  1, 39, 2, 0, 0 },
+	{ 400000000,  1, 47, 2, 0, 0 },
+	{ 500000000,  0, 14, 1, 0, 0 },
+	{ 600000000,  0, 17, 1, 0, 0 },
+	{ 700000000,  0, 20, 1, 0, 0 },
+	{ 800000000,  0, 23, 1, 0, 0 },
+	{ 900000000,  1, 26, 0, 0, 0 },
+	{ 1000000000, 1, 29, 0, 0, 0 },
+	{ 1100000000, 1, 32, 0, 0, 0 },
+	{ 1200000000, 1, 35, 0, 0, 0 },
+	{ 1300000000, 1, 38, 0, 0, 0 },
+	{ 1400000000, 1, 41, 0, 0, 0 },
+	{ 1500000000, 1, 44, 0, 0, 0 },
+	{ 1600000000, 1, 47, 0, 0, 0 },
 	{}
 };
 
 static const struct hsdk_pll_cfg hdmi_pll_cfg[] = {
-	{ 297000000,  0, 21, 2, 0 },
-	{ 540000000,  0, 19, 1, 0 },
-	{ 594000000,  0, 21, 1, 0 },
+	{ 27000000,   0, 0,  0, 0, 1 },
+	{ 297000000,  0, 21, 2, 0, 0 },
+	{ 540000000,  0, 19, 1, 0, 0 },
+	{ 594000000,  0, 21, 1, 0, 0 },
 	{}
 };
 
@@ -134,11 +136,16 @@ static inline void hsdk_pll_set_cfg(struct hsdk_pll_clk *clk,
 {
 	u32 val = 0;
 
-	/* Powerdown and Bypass bits should be cleared */
-	val |= cfg->idiv << CGU_PLL_CTRL_IDIV_SHIFT;
-	val |= cfg->fbdiv << CGU_PLL_CTRL_FBDIV_SHIFT;
-	val |= cfg->odiv << CGU_PLL_CTRL_ODIV_SHIFT;
-	val |= cfg->band << CGU_PLL_CTRL_BAND_SHIFT;
+	if (cfg->bypass) {
+		val = hsdk_pll_read(clk, CGU_PLL_CTRL);
+		val |= CGU_PLL_CTRL_BYPASS;
+	} else {
+		/* Powerdown and Bypass bits should be cleared */
+		val |= cfg->idiv << CGU_PLL_CTRL_IDIV_SHIFT;
+		val |= cfg->fbdiv << CGU_PLL_CTRL_FBDIV_SHIFT;
+		val |= cfg->odiv << CGU_PLL_CTRL_ODIV_SHIFT;
+		val |= cfg->band << CGU_PLL_CTRL_BAND_SHIFT;
+	}
 
 	dev_dbg(clk->dev, "write configuration: %#x\n", val);
 
-- 
2.21.1

