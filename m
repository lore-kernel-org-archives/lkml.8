Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B97C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A611A20758
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597687768;
	bh=Vu9YtsmIoFQfdcdLRbaC+4txrJLouS8kwzF+ksYOP9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RsjBGsBddaE1HCFXNkjAO+cZfiCY0x+CezVSTA16UjahQX/Q49DlVERb6bD4vwyb7
	 F3KCvXo1OgoF7KfRB6dHfoeEv9LAGKe/ZVnHV4u14vaYDeEEke4VR2RnGCySLtMpJP
	 GuBtR4BkTUONVNt1wHsnfRXDHuHxfaVHj8JDSjv0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390375AbgHQSJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:09:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:56546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388429AbgHQQH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 12:07:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7114720760;
        Mon, 17 Aug 2020 16:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597680477;
        bh=Vu9YtsmIoFQfdcdLRbaC+4txrJLouS8kwzF+ksYOP9o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g7Dn4ZajOiDQ6zhpaYajK9MqHyb7/1esJWUDYjlyERMRpF42i1IYIymmXRmBvXfCX
         4p8MzvHz5XihhFXDQdjWIMLyCpfs9yzYS/+oRRunVMqUOdVExdsQqSXOfs90bfWXZV
         EoWzwMC7fKN05xzKpsYghSJKjUoDgRJMM4KD5j2A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 203/270] net: spider_net: Fix the size used in a dma_free_coherent() call
Date:   Mon, 17 Aug 2020 17:16:44 +0200
Message-Id: <20200817143805.890592496@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143755.807583758@linuxfoundation.org>
References: <20200817143755.807583758@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 36f28f7687a9ce665479cce5d64ce7afaa9e77ae ]

Update the size used in 'dma_free_coherent()' in order to match the one
used in the corresponding 'dma_alloc_coherent()', in
'spider_net_init_chain()'.

Fixes: d4ed8f8d1fb7 ("Spidernet DMA coalescing")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/toshiba/spider_net.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/toshiba/spider_net.c b/drivers/net/ethernet/toshiba/spider_net.c
index 538e70810d3de..a99c7c95de5cc 100644
--- a/drivers/net/ethernet/toshiba/spider_net.c
+++ b/drivers/net/ethernet/toshiba/spider_net.c
@@ -283,8 +283,8 @@ spider_net_free_chain(struct spider_net_card *card,
 		descr = descr->next;
 	} while (descr != chain->ring);
 
-	dma_free_coherent(&card->pdev->dev, chain->num_desc,
-	    chain->hwring, chain->dma_addr);
+	dma_free_coherent(&card->pdev->dev, chain->num_desc * sizeof(struct spider_net_hw_descr),
+			  chain->hwring, chain->dma_addr);
 }
 
 /**
-- 
2.25.1



