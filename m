Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F998C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6C9B2078D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591661288;
	bh=Qkj99BUys1+rY+I3IbmkVrdm/KcZjemQzjIXCh/HxWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LNJIkRBAVd51w0fwD5/Rg3TySO4z6xx/DZsGd8mMBe9KvYeQBt3Bzn7n53lANM+aG
	 0qgEY6Epi+WEKJ0md74UIRap9KUjWHH2cPV/634WSogjIeT5OlfKdnY1LWCqsafEL1
	 +xCEcwFA0qKkqurWT8fqMsrLhC2WWbPBybIVNJHc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732750AbgFIAIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:08:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:44442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731017AbgFHXUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:20:42 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C3CA20897;
        Mon,  8 Jun 2020 23:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658441;
        bh=Qkj99BUys1+rY+I3IbmkVrdm/KcZjemQzjIXCh/HxWQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EvFWmmD2019gfkpSRopH2HJmM03ViFZJCmXErp+QTHFhf4/Iz5oT9UP5Q+bte7zz9
         P/zMop+CcarWGS9UDVJ9Cf7eKB/69T+kIfynp9a74c8lcCrivb5mclTFh1QmHeXhzR
         9etFTMnmGNsKNBLU6I6CywEJPnsEVaUUAcgL0yDc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 084/175] net: bcmgenet: set Rx mode before starting netif
Date:   Mon,  8 Jun 2020 19:17:17 -0400
Message-Id: <20200608231848.3366970-84-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231848.3366970-1-sashal@kernel.org>
References: <20200608231848.3366970-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Doug Berger <opendmb@gmail.com>

[ Upstream commit 72f96347628e73dbb61b307f18dd19293cc6792a ]

This commit explicitly calls the bcmgenet_set_rx_mode() function when
the network interface is started. This function is normally called by
ndo_set_rx_mode when the flags are changed, but apparently not when
the driver is suspended and resumed.

This change ensures that address filtering or promiscuous mode are
properly restored by the driver after the MAC may have been reset.

Fixes: b6e978e50444 ("net: bcmgenet: add suspend/resume callbacks")
Signed-off-by: Doug Berger <opendmb@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 6f01f4e03cef..3d3b1005d076 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -69,6 +69,9 @@
 #define GENET_RDMA_REG_OFF	(priv->hw_params->rdma_offset + \
 				TOTAL_DESC * DMA_DESC_SIZE)
 
+/* Forward declarations */
+static void bcmgenet_set_rx_mode(struct net_device *dev);
+
 static inline void bcmgenet_writel(u32 value, void __iomem *offset)
 {
 	/* MIPS chips strapped for BE will automagically configure the
@@ -2852,6 +2855,7 @@ static void bcmgenet_netif_start(struct net_device *dev)
 	struct bcmgenet_priv *priv = netdev_priv(dev);
 
 	/* Start the network engine */
+	bcmgenet_set_rx_mode(dev);
 	bcmgenet_enable_rx_napi(priv);
 
 	umac_enable_set(priv, CMD_TX_EN | CMD_RX_EN, true);
-- 
2.25.1

