Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2F9C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5A4520870
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588943066;
	bh=pizm5190yqEzNfwvsx7bXg5xW4jY2Iiy10XBwxmLmXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uiE71auWeqiRLx/D4I4KsmNxgDNUVv0W1O5wnsJZf8G3MhZgSUB+omtLYGLO3VUO6
	 V+ntqGDx2a2cFjx6DplzgnX0PTHpHckS5vbJ6CfWB0BjLr87uXpJEINKM7fpg7+TVX
	 kOLmYXPMMmBocH7Z+90HK28rFDHZHJ8vQruSEX3c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729542AbgEHNEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:04:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:54230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728905AbgEHMtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:49:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1AF721473;
        Fri,  8 May 2020 12:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588942148;
        bh=pizm5190yqEzNfwvsx7bXg5xW4jY2Iiy10XBwxmLmXg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DcWbVQN36j0VS0GUZLdG9MI52xW4Iss2boT6ddkOxua5ZiXBq7HLrU2ASf/4VlAJz
         3vTWRxY9p4F4bZX9WslWT8RbuCpVTntZoEOXEQSNvBr4WZzLiBijDmxNa6W4bH0oAB
         ebigjr+aZbbfjl17mE7s0lwPpYHWxz7X9CLHReE8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 277/312] net: ethernet: mvneta: Remove IFF_UNICAST_FLT which is not implemented
Date:   Fri,  8 May 2020 14:34:28 +0200
Message-Id: <20200508123143.908731565@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123124.574959822@linuxfoundation.org>
References: <20200508123124.574959822@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Lunn <andrew@lunn.ch>

commit 97db8afa2ab919fc400fe982f5054060868bdf07 upstream.

The mvneta driver advertises it supports IFF_UNICAST_FLT. However, it
actually does not. The hardware probably does support it, but there is
no code to configure the filter. As a quick and simple fix, remove the
flag. This will cause the core to fall back to promiscuous mode.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Fixes: b50b72de2f2f ("net: mvneta: enable features before registering the driver")
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/marvell/mvneta.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -3406,7 +3406,7 @@ static int mvneta_probe(struct platform_
 	dev->features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_TSO;
 	dev->hw_features |= dev->features;
 	dev->vlan_features |= dev->features;
-	dev->priv_flags |= IFF_UNICAST_FLT | IFF_LIVE_ADDR_CHANGE;
+	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
 	dev->gso_max_segs = MVNETA_MAX_TSO_SEGS;
 
 	err = register_netdev(dev);


