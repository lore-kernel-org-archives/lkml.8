Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ECD6C433E8
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 13:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DD6E22BF3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 13:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595251306;
	bh=KcVtPrttpoJMaGyQ/DdWgPvlUJcXW5mZq+GFmiTN9VE=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=awxpKiiDpb1+At2FbmJCVafeu8hvb1n9Mk9qHVP1bodR5VIu4rjyc5Fr4CQynRTyK
	 0ugmyI8t/kiwRgZ66uJvSe6pV0BvP/JBONn/+TimU05Nj8lkMZNijHA6u9F0eRvicO
	 XacH3tZFfcywrqSgCVNl+/VJ0x3zzNoKRyXgcbaM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgGTNVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 09:21:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:50310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726483AbgGTNVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 09:21:44 -0400
Received: from embeddedor (unknown [200.39.29.188])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCEBE20729;
        Mon, 20 Jul 2020 13:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595251304;
        bh=KcVtPrttpoJMaGyQ/DdWgPvlUJcXW5mZq+GFmiTN9VE=;
        h=Date:From:To:Cc:Subject:From;
        b=LwaCeIZuT5YgJyMS1ovaGKArkbglL0qRz6fANRdGQS9GVsVETuf68yUuDs7lIMbK3
         8JVH9ASc8cu/jn4/Gdsq7r/sUZRhGVXWzAj06vFE5sZ05t07PsJVA9RY7GBalea1kW
         sZV5Z8dHncVHkUJZ3U5DxG9t0osNJdJZa2I7VYn4=
Date:   Mon, 20 Jul 2020 08:27:18 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Seungwon Jeon <essuuj@gmail.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH v2][next] phy: samsung-ufs: Fix IS_ERR argument
Message-ID: <20200720132718.GA13413@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix IS_ERR argument in samsung_ufs_phy_symbol_clk_init(). The proper
argument to be passed to IS_ERR() is phy->rx1_symbol_clk.

This bug was detected with the help of Coccinelle.

Fixes: bca21e930451 ("phy: samsung-ufs: add UFS PHY driver for samsung SoC")
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Update subject line and changelog text.

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

