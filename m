Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1986C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 17:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A358F20DD4
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 17:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592588192;
	bh=L+tk6K8+KLeTw56G+NcQJe1v8l4u5Inpr28aIByN6bM=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=KkzwFURLV8H8Yg+c8r7zy9YgQafRqBL2U7IdTSciM/qcCyz/eCyp3qFY9WtEEf0eP
	 xMd3dEg5H/+/5ll73Gj6iIX+d5E5GQeHwljD48TIzcCjBWAUuNryt1vqEa1B7Ikh6e
	 +bl67b3i19JiH0apSKW2+9eB1k9nO4p/OadeCkrU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393001AbgFSRgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 13:36:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:34564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733014AbgFSRga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 13:36:30 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B4AC207FC;
        Fri, 19 Jun 2020 17:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592588190;
        bh=L+tk6K8+KLeTw56G+NcQJe1v8l4u5Inpr28aIByN6bM=;
        h=Date:From:To:Cc:Subject:From;
        b=pFszgEe7W52VYhYygyQ81y07znn+5vd4rlFJsiO3UMl1RN0TlJ8AbdjXbaWwCm/2B
         YYKLYOweHPapKY1Aoxb065KEKNpUvox6CHx7LTeNP1Ja5k3+QQPDs3AgB4xxaArU8c
         oHfLTfSYF3i9C1z65G43J+1DpgFZdHNXiyXJ2Jts=
Date:   Fri, 19 Jun 2020 12:41:54 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc:     netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] net: stmmac: selftests: Use struct_size() in kzalloc()
Message-ID: <20200619174154.GA21660@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes.

This code was detected with the help of Coccinelle and, audited and
fixed manually.

Addresses-KSPP-ID: https://github.com/KSPP/linux/issues/83
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
index e6696495f126..e113b1376fdd 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
@@ -1094,7 +1094,7 @@ static int stmmac_test_rxp(struct stmmac_priv *priv)
 	if (!priv->dma_cap.frpsel)
 		return -EOPNOTSUPP;
 
-	sel = kzalloc(sizeof(*sel) + nk * sizeof(struct tc_u32_key), GFP_KERNEL);
+	sel = kzalloc(struct_size(sel, keys, nk), GFP_KERNEL);
 	if (!sel)
 		return -ENOMEM;
 
-- 
2.27.0

