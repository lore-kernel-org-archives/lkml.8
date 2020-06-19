Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A02C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 224C0218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592578730;
	bh=vvo7Ahi+utMWS+xIUC6nXo1jAOt7DowPCxW6SV+Q9jM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Sq2Jvr8QeSbGG9LO28gAcf1eacfXbMJt4b5dIC+3f6TMLzSFXaiDx6CdIc/wTGoGf
	 I+C0nDWBz8fFQzVbsGW24/o942tke+PGPCv2BQt2R9Fk4tLCNu+RkxVWXeAa2sazKh
	 oYMFeANd+ykoqnkiAEsjfbGysuYSOfA3ilq4XVpM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389643AbgFSO6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:58:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:54632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390430AbgFSO6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:58:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1822521852;
        Fri, 19 Jun 2020 14:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592578724;
        bh=vvo7Ahi+utMWS+xIUC6nXo1jAOt7DowPCxW6SV+Q9jM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eomNITraP79AUtL9P/bCoNruMf0uPG2uwcXmH1e8hOZK86zn7fr9BgstOvzjICV22
         yF54mihopZgmhLnX9bENYFC7KjPTJumlFEdog2UixerTqJKA4HUQPFHPpovKnQEal8
         hT53v1bKcQ3rxEFwd8/cPOz6kKUTKRimlmVKMtII=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 133/267] net: bcmgenet: set Rx mode before starting netif
Date:   Fri, 19 Jun 2020 16:31:58 +0200
Message-Id: <20200619141655.208192856@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141648.840376470@linuxfoundation.org>
References: <20200619141648.840376470@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 047fc0cf0263..40e8ef984b62 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -72,6 +72,9 @@
 #define GENET_RDMA_REG_OFF	(priv->hw_params->rdma_offset + \
 				TOTAL_DESC * DMA_DESC_SIZE)
 
+/* Forward declarations */
+static void bcmgenet_set_rx_mode(struct net_device *dev);
+
 static inline void bcmgenet_writel(u32 value, void __iomem *offset)
 {
 	/* MIPS chips strapped for BE will automagically configure the
@@ -2859,6 +2862,7 @@ static void bcmgenet_netif_start(struct net_device *dev)
 	struct bcmgenet_priv *priv = netdev_priv(dev);
 
 	/* Start the network engine */
+	bcmgenet_set_rx_mode(dev);
 	bcmgenet_enable_rx_napi(priv);
 
 	umac_enable_set(priv, CMD_TX_EN | CMD_RX_EN, true);
-- 
2.25.1



