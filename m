Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEA2C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6E7720775
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591659128;
	bh=joHfT7bcauPIx7wZQqsTyIJ76SF7kDA5AvCTJjZoit0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Zh7qz60ye3hHkYK72wM6thVwoLnDjY/2O9wR1xpayijcP1STFPTKYlKUAz2oUvxDE
	 HR9tIMKm0QgC7zvVIoe9jVpd0IUc3Yftrf+ojy6kibBcmzMDplwZJI83WZLPC6elKu
	 yswm1EXNSG8ruskq0ob2smfteFcdhXHe2ef9lbsc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732443AbgFHXcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:32:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:52814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731888AbgFHXZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:25:57 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8B0420814;
        Mon,  8 Jun 2020 23:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658756;
        bh=joHfT7bcauPIx7wZQqsTyIJ76SF7kDA5AvCTJjZoit0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hpWqbZop34Rs+G7SaR3gCy6D5eNB31XFQM9qh6NLOBUdm/aDEsF5YAbkCRc6zen6F
         81kl6XfzQ8NhjbsCir1AHUGFSxG4ftE7gDodIiThnEcmw0mwKeALLo04SzYjKR2QjP
         Bn6YnK6or7bMsfWzCtb2cUlkEhmzYzDpoCa3y6Yw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yunjian Wang <wangyunjian@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.14 41/72] net: allwinner: Fix use correct return type for ndo_start_xmit()
Date:   Mon,  8 Jun 2020 19:24:29 -0400
Message-Id: <20200608232500.3369581-41-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608232500.3369581-1-sashal@kernel.org>
References: <20200608232500.3369581-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunjian Wang <wangyunjian@huawei.com>

[ Upstream commit 09f6c44aaae0f1bdb8b983d7762676d5018c53bc ]

The method ndo_start_xmit() returns a value of type netdev_tx_t. Fix
the ndo function to use the correct type. And emac_start_xmit() can
leak one skb if 'channel' == 3.

Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/allwinner/sun4i-emac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/allwinner/sun4i-emac.c b/drivers/net/ethernet/allwinner/sun4i-emac.c
index 3143de45baaa..c458b81ba63a 100644
--- a/drivers/net/ethernet/allwinner/sun4i-emac.c
+++ b/drivers/net/ethernet/allwinner/sun4i-emac.c
@@ -433,7 +433,7 @@ static void emac_timeout(struct net_device *dev)
 /* Hardware start transmission.
  * Send a packet to media from the upper layer.
  */
-static int emac_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t emac_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct emac_board_info *db = netdev_priv(dev);
 	unsigned long channel;
@@ -441,7 +441,7 @@ static int emac_start_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	channel = db->tx_fifo_stat & 3;
 	if (channel == 3)
-		return 1;
+		return NETDEV_TX_BUSY;
 
 	channel = (channel == 1 ? 1 : 0);
 
-- 
2.25.1

