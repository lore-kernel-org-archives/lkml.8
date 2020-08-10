Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA70C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DB45207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597073567;
	bh=STaAiDozz5Ey94ASQtqCmUMNQiuV/yBML8B1zscPEZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pXWwsb93775e+6WxcyrecXcnx3E5cFG/du4uZyWElFw+b3VErUYb0Nr0rfUmutsLB
	 qCTYmFztq0W94Kf6uVk2g+J6d//LHLzn7gdnF77m45t4t7J9Lmk4xezOJ/N+9aUbvU
	 B1v/D8oROsropsy2VPmdhZaUjfSOQjo+Hn2ykPOY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbgHJPcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 11:32:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:37182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729057AbgHJPaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 11:30:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89C1820791;
        Mon, 10 Aug 2020 15:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597073422;
        bh=STaAiDozz5Ey94ASQtqCmUMNQiuV/yBML8B1zscPEZ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Um8zrUZLsngtYTP7TyyrZxq2uMFVZV3xwFgJOmYZpsfOenMiTczeKKOzGP3ybnvmk
         Esa+vGKWmzuHa2Y45waM3y7YtL7/bknAkJHYb2srlKJcOkbtwGnvUInxJEXH6m8EGX
         7nZoyPSKnSwfVyK+FpaeGf3azu2SColLy6XWoqZo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Landen Chao <landen.chao@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 34/48] net: ethernet: mtk_eth_soc: fix MTU warnings
Date:   Mon, 10 Aug 2020 17:21:56 +0200
Message-Id: <20200810151805.896505636@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200810151804.199494191@linuxfoundation.org>
References: <20200810151804.199494191@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Landen Chao <landen.chao@mediatek.com>

[ Upstream commit 555a893303872e044fb86f0a5834ce78d41ad2e2 ]

in recent kernel versions there are warnings about incorrect MTU size
like these:

eth0: mtu greater than device maximum
mtk_soc_eth 1b100000.ethernet eth0: error -22 setting MTU to include DSA overhead

Fixes: bfcb813203e6 ("net: dsa: configure the MTU for switch ports")
Fixes: 72579e14a1d3 ("net: dsa: don't fail to probe if we couldn't set the MTU")
Fixes: 7a4c53bee332 ("net: report invalid mtu value via netlink extack")
Signed-off-by: Landen Chao <landen.chao@mediatek.com>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -2452,6 +2452,8 @@ static int mtk_add_mac(struct mtk_eth *e
 	eth->netdev[id]->irq = eth->irq[0];
 	eth->netdev[id]->dev.of_node = np;
 
+	eth->netdev[id]->max_mtu = MTK_MAX_RX_LENGTH - MTK_RX_ETH_HLEN;
+
 	return 0;
 
 free_netdev:


