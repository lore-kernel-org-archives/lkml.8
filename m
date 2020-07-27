Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F8EC433EA
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D5E42173E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595859711;
	bh=9wNdLFe2Mc0qAiEK+P603wJC8PshkNcKQvnyLiY81/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ai5LhyycjGGx2plJhSf9mrQmnfLuV3NpNfZ8mWXv06YlR/jm+qCTZ5V1KExcYITp0
	 a2WGnU1RnpOMJfWAoZ59ITOhclcrAC0L6Sn5hDKy2y51fs1N3kmCGUQu96oayHQ5oH
	 TRYXiLb+uMwSS4ZIJF+x/1kHXXV2xnpcFtAdSY6M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731793AbgG0OVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:21:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:50490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730258AbgG0OVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:21:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8778A2070A;
        Mon, 27 Jul 2020 14:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595859706;
        bh=9wNdLFe2Mc0qAiEK+P603wJC8PshkNcKQvnyLiY81/8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d2y35IClG6sYTM37tVh1ksFWFTNOeCszvdU5kc4Xf2WaCpyj25Q6SmQTcJ/m8lbJx
         Y5WCFraQUgvpc8J/VgE3+YABWVfCxealk31V5t3DB49hJLy32JKuB2ACp8ELou/XqT
         LQ05jWPrK5Ei61CJmrelD1s1U24oZYOrkNb9NHtg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shannon Nelson <snelson@pensando.io>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 073/179] ionic: keep rss hash after fw update
Date:   Mon, 27 Jul 2020 16:04:08 +0200
Message-Id: <20200727134936.238606592@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727134932.659499757@linuxfoundation.org>
References: <20200727134932.659499757@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shannon Nelson <snelson@pensando.io>

[ Upstream commit bdff46665ee655600d0fe2a0e5f62ec7853d3b22 ]

Make sure the RSS hash key is kept across a fw update by not
de-initing it when an update is happening.

Fixes: c672412f6172 ("ionic: remove lifs on fw reset")
Signed-off-by: Shannon Nelson <snelson@pensando.io>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/pensando/ionic/ionic_lif.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index 48aa502e4bd3d..08ab6dafc66c5 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -2227,11 +2227,10 @@ static void ionic_lif_deinit(struct ionic_lif *lif)
 		cancel_work_sync(&lif->deferred.work);
 		cancel_work_sync(&lif->tx_timeout_work);
 		ionic_rx_filters_deinit(lif);
+		if (lif->netdev->features & NETIF_F_RXHASH)
+			ionic_lif_rss_deinit(lif);
 	}
 
-	if (lif->netdev->features & NETIF_F_RXHASH)
-		ionic_lif_rss_deinit(lif);
-
 	napi_disable(&lif->adminqcq->napi);
 	ionic_lif_qcq_deinit(lif, lif->notifyqcq);
 	ionic_lif_qcq_deinit(lif, lif->adminqcq);
-- 
2.25.1



