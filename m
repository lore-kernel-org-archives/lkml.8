Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1188CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 13:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5EA722C9C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 13:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595251010;
	bh=/w4zUcpzSmycbsin7CZs2gbAQ2dRurvcogYM3QtsWDc=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=wIa4wR1LntSiiHknEtGf3JBgk6qsrmglaRnKRiEHUXnw6/7N8JBYwRte9DR6YWaCr
	 DpDpC0kFtsLtdQBXkWcBZrPtxe44OvF47/aw2+TyFSKBj439mjHPvfDxtbj5n1Pqdl
	 VW0sQwxCqZ1PhiqmxPf9P7WjoJg6+XjzW4JqFT6M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgGTNQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 09:16:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:46926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726492AbgGTNQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 09:16:49 -0400
Received: from embeddedor (unknown [201.162.161.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F9F520729;
        Mon, 20 Jul 2020 13:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595251009;
        bh=/w4zUcpzSmycbsin7CZs2gbAQ2dRurvcogYM3QtsWDc=;
        h=Date:From:To:Cc:Subject:From;
        b=rej2PXlrc1S4wwyvGpFU8CewXeP3lqkU8i+pz/rQ/QerQ8MBdjueftv24OHeVL+Cx
         lwnPWy76nMoE3AP6lz1D0Tqm52shZJsA59uP4UWIGgIPmi/JN/KwUEcxosdlMOwxv5
         WtsFAF9d7ViHuCJej5RYr8g5NDAN2gBu9DhDTVuo=
Date:   Mon, 20 Jul 2020 08:22:21 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Seungwon Jeon <essuuj@gmail.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH][next] phy: samsung-ufs: Fix inconsistent IS_ERR and PTR_ERR
Message-ID: <20200720132221.GA13346@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix inconsistent IS_ERR and PTR_ERR in samsung_ufs_phy_symbol_clk_init().
The proper pointer to be passed as argument to PTR_ERR() is rx1_symbol_clk.

This bug was detected with the help of Coccinelle.

Fixes: bca21e930451 ("phy: samsung-ufs: add UFS PHY driver for samsung SoC")
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/phy/samsung/phy-samsung-ufs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/samsung/phy-samsung-ufs.c b/drivers/phy/samsung/phy-samsung-ufs.c
index 43ef77d1d96c..9832599a0283 100644
--- a/drivers/phy/samsung/phy-samsung-ufs.c
+++ b/drivers/phy/samsung/phy-samsung-ufs.c
@@ -147,7 +147,7 @@ static int samsung_ufs_phy_symbol_clk_init(struct samsung_ufs_phy *phy)
 	}
 
 	phy->rx1_symbol_clk = devm_clk_get(phy->dev, "rx1_symbol_clk");
-	if (IS_ERR(phy->rx0_symbol_clk)) {
+	if (IS_ERR(phy->rx1_symbol_clk)) {
 		dev_err(phy->dev, "failed to get rx1_symbol_clk clock\n");
 		return PTR_ERR(phy->rx1_symbol_clk);
 	}
-- 
2.27.0

