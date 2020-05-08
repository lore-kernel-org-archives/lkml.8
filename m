Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED5DC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA0CC2495A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588942549;
	bh=xxlon5SXE49wUSaaUMDJaJatz3yptoEVissdAYJWjpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LS3xF86pGL1ACHN08wyOBvKrfkBNe17rRW/luitSVv5WgktPRJdLGzCz74ooYl7lA
	 xi+kRobRkTZ5x/LN4h7H+pm58oQKjyXREDUTlPLMDp2Px0uoyRj1nTFCUK6jm5B4N+
	 4yzjbwJyfsCmNIGuNGvgWjOpWvPd/72TfjdqBYB4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730371AbgEHMzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:55:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:38904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730086AbgEHMzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:55:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 828B42495A;
        Fri,  8 May 2020 12:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588942545;
        bh=xxlon5SXE49wUSaaUMDJaJatz3yptoEVissdAYJWjpE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ScyrSMoVOpLnFI7lGvuC8u6DB5NLDbYnck9W/qnfmQsvLa9434gJuwEU+yDvzISYx
         fHu7RD68Qq/brAw9ZL1TTHCIbPB0INDjKvlvT918Qf1xBUWUzH5SGjq67FW+59GPLV
         erVkj+G1VC9drqoJhPiyUTCnHOYCBb3IZFh7fwoE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 38/49] net: bcmgenet: suppress warnings on failed Rx SKB allocations
Date:   Fri,  8 May 2020 14:35:55 +0200
Message-Id: <20200508123048.317352604@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123042.775047422@linuxfoundation.org>
References: <20200508123042.775047422@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Doug Berger <opendmb@gmail.com>

[ Upstream commit ecaeceb8a8a145d93c7e136f170238229165348f ]

The driver is designed to drop Rx packets and reclaim the buffers
when an allocation fails, and the network interface needs to safely
handle this packet loss. Therefore, an allocation failure of Rx
SKBs is relatively benign.

However, the output of the warning message occurs with a high
scheduling priority that can cause excessive jitter/latency for
other high priority processing.

This commit suppresses the warning messages to prevent scheduling
problems while retaining the failure count in the statistics of
the network interface.

Signed-off-by: Doug Berger <opendmb@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index b7c0c20e13258..5fd1a9dfcfff3 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -1625,7 +1625,8 @@ static struct sk_buff *bcmgenet_rx_refill(struct bcmgenet_priv *priv,
 	dma_addr_t mapping;
 
 	/* Allocate a new Rx skb */
-	skb = netdev_alloc_skb(priv->dev, priv->rx_buf_len + SKB_ALIGNMENT);
+	skb = __netdev_alloc_skb(priv->dev, priv->rx_buf_len + SKB_ALIGNMENT,
+				 GFP_ATOMIC | __GFP_NOWARN);
 	if (!skb) {
 		priv->mib.alloc_rx_buff_failed++;
 		netif_err(priv, rx_err, priv->dev,
-- 
2.20.1



