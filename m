Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0ACBC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC1B820715
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589824276;
	bh=v17KLpkrUK8PVtqnolrS1fM1oTtoXKQykSbkQwFs/cU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XvspzEL7Mesge3idDDZn4S5z5Hl/1BEYlKY/D4y7dgvE5r/tKsjFiPgPmkqzX2d94
	 Cn8AIOIvQbn9mBOEL/gJKY+3Xlf3MhlU+WndozZ2CUfg6svbtni+/8VxFGxRN7BdM+
	 DcQpBBmsdBTopzui+v/OHkOaVVdONStEzZDCh36s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbgERRvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:51:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:53744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730829AbgERRvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:51:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85C9F20674;
        Mon, 18 May 2020 17:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589824270;
        bh=v17KLpkrUK8PVtqnolrS1fM1oTtoXKQykSbkQwFs/cU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hJrx6oZggjKNW1LRiAOLvr4DMB93cOmymIaLv8k5SJWcPSKvNY554lz9380Dj3bvx
         ZckAWTv0SZNdh9iqpLB0d1cEIIfTDO04/fkqd5EV2jcrEh2Pgknk9uKJv1EdAJnmyf
         Dpnvj5UYSLqIf7VY5VHNknSYx3rfYaq9bcALXWIM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 04/80] net: moxa: Fix a potential double free_irq()
Date:   Mon, 18 May 2020 19:36:22 +0200
Message-Id: <20200518173451.021483004@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173450.097837707@linuxfoundation.org>
References: <20200518173450.097837707@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



