Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6CDC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 483A421707
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592583643;
	bh=Clu9I0nxQue/n9z2B1IGWLrkbDGV4nqggjM4TEgJBe4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MM7RQAZRK77hpJHGdGQCBOWeu46cqud2AdcySOu/kSaQlHtb+8LDis1ymoY0x021F
	 kCI/yLgiUhvEwxfUdzz+1fs4jOlWJp8vu+ADiNmD1eLwq1isGUuZcHO0w5TsEAEuAN
	 TpVzy7Lyl1yo7WjmpfZLSDmUo6xdcnOob9MRg6k4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394649AbgFSQUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:20:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:57662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390367AbgFSPBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:01:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B450720734;
        Fri, 19 Jun 2020 15:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592578874;
        bh=Clu9I0nxQue/n9z2B1IGWLrkbDGV4nqggjM4TEgJBe4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qD5lSH/x5y8eN7wzolYy2YW1imWwIr11UR3us+k07LDtT6yj+zNozmb8o7ExqJmJv
         TjgceljGbjP7KUCrASHwpJibwftaO66pXtONlBAdyuEYx7kuLPY0ECrH0iMvBUb82s
         0aZK39+FB4nuHCmOeObbcfujX/ZJXIOnD/0vcKyo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Erez Shitrit <erezsh@mellanox.com>,
        Alex Vesker <valex@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 160/267] net/mlx5e: IPoIB, Drop multicast packets that this interface sent
Date:   Fri, 19 Jun 2020 16:32:25 +0200
Message-Id: <20200619141656.487379341@linuxfoundation.org>
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

From: Erez Shitrit <erezsh@mellanox.com>

[ Upstream commit 8b46d424a743ddfef8056d5167f13ee7ebd1dcad ]

After enabled loopback packets for IPoIB, we need to drop these packets
that this HCA has replicated and came back to the same interface that
sent them.

Fixes: 4c6c615e3f30 ("net/mlx5e: IPoIB, Add PKEY child interface nic profile")
Signed-off-by: Erez Shitrit <erezsh@mellanox.com>
Reviewed-by: Alex Vesker <valex@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 044687a1f27c..9d86e49a7f44 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1314,6 +1314,7 @@ out:
 
 #ifdef CONFIG_MLX5_CORE_IPOIB
 
+#define MLX5_IB_GRH_SGID_OFFSET 8
 #define MLX5_IB_GRH_DGID_OFFSET 24
 #define MLX5_GID_SIZE           16
 
@@ -1327,6 +1328,7 @@ static inline void mlx5i_complete_rx_cqe(struct mlx5e_rq *rq,
 	struct net_device *netdev;
 	struct mlx5e_priv *priv;
 	char *pseudo_header;
+	u32 flags_rqpn;
 	u32 qpn;
 	u8 *dgid;
 	u8 g;
@@ -1347,7 +1349,8 @@ static inline void mlx5i_complete_rx_cqe(struct mlx5e_rq *rq,
 	priv = mlx5i_epriv(netdev);
 	tstamp = &priv->tstamp;
 
-	g = (be32_to_cpu(cqe->flags_rqpn) >> 28) & 3;
+	flags_rqpn = be32_to_cpu(cqe->flags_rqpn);
+	g = (flags_rqpn >> 28) & 3;
 	dgid = skb->data + MLX5_IB_GRH_DGID_OFFSET;
 	if ((!g) || dgid[0] != 0xff)
 		skb->pkt_type = PACKET_HOST;
@@ -1356,9 +1359,15 @@ static inline void mlx5i_complete_rx_cqe(struct mlx5e_rq *rq,
 	else
 		skb->pkt_type = PACKET_MULTICAST;
 
-	/* TODO: IB/ipoib: Allow mcast packets from other VFs
-	 * 68996a6e760e5c74654723eeb57bf65628ae87f4
+	/* Drop packets that this interface sent, ie multicast packets
+	 * that the HCA has replicated.
 	 */
+	if (g && (qpn == (flags_rqpn & 0xffffff)) &&
+	    (memcmp(netdev->dev_addr + 4, skb->data + MLX5_IB_GRH_SGID_OFFSET,
+		    MLX5_GID_SIZE) == 0)) {
+		skb->dev = NULL;
+		return;
+	}
 
 	skb_pull(skb, MLX5_IB_GRH_BYTES);
 
-- 
2.25.1



