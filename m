Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98793C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 22:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DCC020C09
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 22:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592348291;
	bh=iZXGWJHS5AgDNH9ptElUK048yEyJAZNWudN8OL5QXdY=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=jQEugq+5zQsg6xnJDy/3Ocem7adBh0Y1+YlhYXWSu2GdgaryMyF8gJH8syTZFO6Oo
	 bNgfAk/7mVYd19t/2AxBGp8g1sXj3sFN4wQqbXJPws8YyML8k+iucxJaw8d9RI7rag
	 IuISyDz09nCLOmQ22FB7Urqt3HpBR5oWcc6CREXI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgFPW6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 18:58:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:34344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbgFPW6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 18:58:09 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0EDA20B80;
        Tue, 16 Jun 2020 22:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592348288;
        bh=iZXGWJHS5AgDNH9ptElUK048yEyJAZNWudN8OL5QXdY=;
        h=Date:From:To:Cc:Subject:From;
        b=cYroHiDL1Ijn2MBZ8THz3jteXIC2CqPbtZakQcURpttLwU0p4UNiv+j0bfUl2tzQB
         m3pFMV0JjAHqEEhBqujFp78z9/7dL9DQ0/n05hSB04eO37rW7pLLgd36Zt56AaNHSu
         rRc/YSc+IYcoAr1p+m0JbNfAUxWP2bj+f/bqs8WY=
Date:   Tue, 16 Jun 2020 18:03:28 -0500
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
Subject: [PATCH][next] net: stmmac: selftests: Use struct_size() helper in
 kzalloc()
Message-ID: <20200616230328.GA23281@embeddedor>
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

