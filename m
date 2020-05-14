Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22A0C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 19:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AF85206A5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 19:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589483035;
	bh=v17KLpkrUK8PVtqnolrS1fM1oTtoXKQykSbkQwFs/cU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hVtVw+DR8FLq4r93LjK8xStNfaeRdAbA20ApSWpqH8kjtEXa3zGFF+8JT5jz6i7nf
	 HnSiCguUNUlrhFgYANdSq/U8IZppEKz5CtQrqnEH1GmaYYIwkp3HLRjCYVzBzmHyPO
	 fa6DGjPnKm+0m6McpWAkkxT0Kn6m6W2SpwcPPrj0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730103AbgENTDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 15:03:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:54810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729142AbgENSyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 14:54:39 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 211282065F;
        Thu, 14 May 2020 18:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589482478;
        bh=v17KLpkrUK8PVtqnolrS1fM1oTtoXKQykSbkQwFs/cU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=URTh+3TIJW73GmBV56fi0n8y+ooPEnYYyIJb8R+LpbtUXx8yhiZUZWkMc53+j+fH7
         lWcMuHxu57fheHX9o06NXKr0sxNMfkNN1uKy3v8zLShYRbn2sM0naGTlzc0hs98sCG
         FIvWD+h+QNYnny/BadUP4CC/YPnC31zMljTce+Og=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 19/31] net: moxa: Fix a potential double 'free_irq()'
Date:   Thu, 14 May 2020 14:54:01 -0400
Message-Id: <20200514185413.20755-19-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514185413.20755-1-sashal@kernel.org>
References: <20200514185413.20755-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit ee8d2267f0e39a1bfd95532da3a6405004114b27 ]

Should an irq requested with 'devm_request_irq' be released explicitly,
it should be done by 'devm_free_irq()', not 'free_irq()'.

Fixes: 6c821bd9edc9 ("net: Add MOXA ART SoCs ethernet driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/moxa/moxart_ether.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/moxa/moxart_ether.c b/drivers/net/ethernet/moxa/moxart_ether.c
index b34055ac476f7..4db3431b79ac1 100644
--- a/drivers/net/ethernet/moxa/moxart_ether.c
+++ b/drivers/net/ethernet/moxa/moxart_ether.c
@@ -561,7 +561,7 @@ static int moxart_remove(struct platform_device *pdev)
 	struct net_device *ndev = platform_get_drvdata(pdev);
 
 	unregister_netdev(ndev);
-	free_irq(ndev->irq, ndev);
+	devm_free_irq(&pdev->dev, ndev->irq, ndev);
 	moxart_mac_free_memory(ndev);
 	free_netdev(ndev);
 
-- 
2.20.1

