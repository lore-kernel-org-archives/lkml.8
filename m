Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 744E3C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4574E24690
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580221929;
	bh=vFwKv6+IOjYUGHyaQxM/vTaosCbWrV9HShRB2gnc7yg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TaGAY9WzLRpWwYZprnaG7pJ9GyIwDcgCEVm7VBH6UnCgoHqEkXc3MbKuAyo588/SL
	 t8EfrV5B968Hs+1FIkBT6OyhNrpkNB1DXvXYNSat9msGLTdkMgRpXunRbOljlpJzoJ
	 KnzgwtHCIfEJIF03S8IaUeo3ZEuvigZ8Ftn47mJk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733245AbgA1O07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:26:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:54538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733239AbgA1O0z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:26:55 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D81C024688;
        Tue, 28 Jan 2020 14:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580221615;
        bh=vFwKv6+IOjYUGHyaQxM/vTaosCbWrV9HShRB2gnc7yg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bcz730kajifunjxn5Q/JNlfgj3kaZ+peqP08rDd+x3grV3NLu4wnRUCe210Mez0vW
         ChtwOx3FQtEhdVN3leNwJwI9k6wpOPGe8HGUx2RnpEtyKgn/jRWC6h4TgPZA9/NsUo
         +Kd+8dZHmkUHJKEMmqwV1Yyb8KErbduBhwK9jBc0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Doug Berger <opendmb@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 05/92] net: bcmgenet: Use netif_tx_napi_add() for TX NAPI
Date:   Tue, 28 Jan 2020 15:07:33 +0100
Message-Id: <20200128135809.992532654@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135809.344954797@linuxfoundation.org>
References: <20200128135809.344954797@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit 148965df1a990af98b2c84092c2a2274c7489284 ]

Before commit 7587935cfa11 ("net: bcmgenet: move NAPI initialization to
ring initialization") moved the code, this used to be
netif_tx_napi_add(), but we lost that small semantic change in the
process, restore that.

Fixes: 7587935cfa11 ("net: bcmgenet: move NAPI initialization to ring initialization")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Acked-by: Doug Berger <opendmb@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -2166,8 +2166,8 @@ static void bcmgenet_init_tx_ring(struct
 				  DMA_END_ADDR);
 
 	/* Initialize Tx NAPI */
-	netif_napi_add(priv->dev, &ring->napi, bcmgenet_tx_poll,
-		       NAPI_POLL_WEIGHT);
+	netif_tx_napi_add(priv->dev, &ring->napi, bcmgenet_tx_poll,
+			  NAPI_POLL_WEIGHT);
 }
 
 /* Initialize a RDMA ring */


