Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CB5C54FCB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 20:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95E6320700
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 20:59:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgDZU7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 16:59:30 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:31531 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbgDZU7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 16:59:30 -0400
Received: from localhost.localdomain ([93.23.12.11])
        by mwinf5d64 with ME
        id XYzQ2201a0EJ3pp03YzReA; Sun, 26 Apr 2020 22:59:28 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 26 Apr 2020 22:59:28 +0200
X-ME-IP: 93.23.12.11
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     davem@davemloft.net, jonas.jensen@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] net: moxa: Fix a potential double 'free_irq()'
Date:   Sun, 26 Apr 2020 22:59:21 +0200
Message-Id: <20200426205921.47714-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Should an irq requested with 'devm_request_irq' be released explicitly,
it should be done by 'devm_free_irq()', not 'free_irq()'.

Fixes: 6c821bd9edc9 ("net: Add MOXA ART SoCs ethernet driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Maybe 'devm_free_irq()' is useless here and it could be freed automatically
by the core framework, but sometimes irq can be tricky.
So I've preferred to keep the logic in place.
---
 drivers/net/ethernet/moxa/moxart_ether.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/moxa/moxart_ether.c b/drivers/net/ethernet/moxa/moxart_ether.c
index e1651756bf9d..f70bb81e1ed6 100644
--- a/drivers/net/ethernet/moxa/moxart_ether.c
+++ b/drivers/net/ethernet/moxa/moxart_ether.c
@@ -564,7 +564,7 @@ static int moxart_remove(struct platform_device *pdev)
 	struct net_device *ndev = platform_get_drvdata(pdev);
 
 	unregister_netdev(ndev);
-	free_irq(ndev->irq, ndev);
+	devm_free_irq(&pdev->dev, ndev->irq, ndev);
 	moxart_mac_free_memory(ndev);
 	free_netdev(ndev);
 
-- 
2.25.1

