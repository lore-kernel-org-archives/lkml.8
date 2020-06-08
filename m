Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A797C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DDB120659
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591659782;
	bh=b/50F7gkO3+K/pAR6DbtLDdBm4g7DWks/GCUmwikn3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ctqvWvpBzX+97aaS1r0UUWvMCGrtVrfYCtofHB4ynUL/yY1hdEVk3r5pc6xX/aiwi
	 C2mhd635Ph5+FWReEHmDwnXWOKpsYs96BPdkYTJ/kStwOw/dz56fcrpQBG1dVkc+kU
	 I3ZYO9g2raRuLb6Vo7bAv+q7X1tTg367s/RQw3do=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387523AbgFHXnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:43:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:55666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730843AbgFHX1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:27:19 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB6D62068D;
        Mon,  8 Jun 2020 23:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658838;
        bh=b/50F7gkO3+K/pAR6DbtLDdBm4g7DWks/GCUmwikn3E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XGO/MVwr8XPzhx44SHeVtaRTszJj72a9SrKf2g0uRPjw3YHeF7bpT0m7Fax9j3qDj
         07iRMIzWTksoBQBU0lF/yIfij+shWO/RS/ErAQiDL2FHRQaeiyf3EUkDRYWblfvOs4
         j/1DUtbxRs6hI2R/CpWPYIodgpH+BCugiPXdeFYE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yunjian Wang <wangyunjian@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.9 28/50] net: allwinner: Fix use correct return type for ndo_start_xmit()
Date:   Mon,  8 Jun 2020 19:26:18 -0400
Message-Id: <20200608232640.3370262-28-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608232640.3370262-1-sashal@kernel.org>
References: <20200608232640.3370262-1-sashal@kernel.org>
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
index 6ffdff68bfc4..672a8212c8d9 100644
--- a/drivers/net/ethernet/allwinner/sun4i-emac.c
+++ b/drivers/net/ethernet/allwinner/sun4i-emac.c
@@ -412,7 +412,7 @@ static void emac_timeout(struct net_device *dev)
 /* Hardware start transmission.
  * Send a packet to media from the upper layer.
  */
-static int emac_start_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t emac_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct emac_board_info *db = netdev_priv(dev);
 	unsigned long channel;
@@ -420,7 +420,7 @@ static int emac_start_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	channel = db->tx_fifo_stat & 3;
 	if (channel == 3)
-		return 1;
+		return NETDEV_TX_BUSY;
 
 	channel = (channel == 1 ? 1 : 0);
 
-- 
2.25.1

