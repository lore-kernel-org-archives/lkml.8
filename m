Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF53C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 13:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4141820738
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 13:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgHBNxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 09:53:53 -0400
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:48592 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgHBNxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 09:53:52 -0400
Received: from localhost.localdomain ([93.22.148.198])
        by mwinf5d42 with ME
        id Adtq230054H42jh03dtqkR; Sun, 02 Aug 2020 15:53:51 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 02 Aug 2020 15:53:51 +0200
X-ME-IP: 93.22.148.198
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     kou.ishizaki@toshiba.co.jp, davem@davemloft.net, kuba@kernel.org,
        linas@austin.ibm.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/2] net: spider_net: Remove a useless memset
Date:   Sun,  2 Aug 2020 15:53:48 +0200
Message-Id: <20200802135348.691046-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid a memset after a call to 'dma_alloc_coherent()'.
This is useless since
commit 518a2f1925c3 ("dma-mapping: zero memory returned from dma_alloc_*")

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
NOT compile tested, because I don't have the configuration for that
---
 drivers/net/ethernet/toshiba/spider_net.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/toshiba/spider_net.c b/drivers/net/ethernet/toshiba/spider_net.c
index 2d61400144a2..e1a2057fbf21 100644
--- a/drivers/net/ethernet/toshiba/spider_net.c
+++ b/drivers/net/ethernet/toshiba/spider_net.c
@@ -314,8 +314,6 @@ spider_net_init_chain(struct spider_net_card *card,
 	if (!chain->hwring)
 		return -ENOMEM;
 
-	memset(chain->ring, 0, chain->num_desc * sizeof(struct spider_net_descr));
-
 	/* Set up the hardware pointers in each descriptor */
 	descr = chain->ring;
 	hwdescr = chain->hwring;
-- 
2.25.1

