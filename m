Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6077C433EC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E7C1206E7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595860538;
	bh=0aoN5vnzOfi4/zZOMSrC72yarZ1t0HY7wRVv0C0BNU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cKKbI3nnNZ7Joj0DRIf+p7PkRUhzqWxlg4LgC7Vos4Yuhmz7Pvm8EX+DDcl7Sd9qD
	 7L3PF+uPFUmmJlgtXW/3wjnoWi/oFrrPX3bbUt+MIQowg6Qs9hIFjR27u2RhxUWEu+
	 N2OJDcThQisZYeagR+QwQGnPbiP/s38ezb0jU5Qk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732919AbgG0Ofh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:35:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:40844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730612AbgG0OOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:14:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63CA52083E;
        Mon, 27 Jul 2020 14:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595859291;
        bh=0aoN5vnzOfi4/zZOMSrC72yarZ1t0HY7wRVv0C0BNU8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W77C7KYz78kQAr6mn9By8iHp/4EYOaXMOmm/F3m/otUFegq3lQdHkcioqzEJrvvVF
         k+E5R+egLLh0wSEdHQgWPat6V9rSO8VN1rpJpbZrhfhUIv2Loai8Yh/UWywpzNnHen
         FXG0XuYd6RsEkC8hymXXIT7ZZapYSw5AGXUPf99s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shannon Nelson <snelson@pensando.io>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 052/138] ionic: fix up filter locks and debug msgs
Date:   Mon, 27 Jul 2020 16:04:07 +0200
Message-Id: <20200727134927.963310779@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727134925.228313570@linuxfoundation.org>
References: <20200727134925.228313570@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shannon Nelson <snelson@pensando.io>

[ Upstream commit cbec2153a9a68d011454960ba84887e46e40b37d ]

Add in a couple of forgotten spinlocks and fix up some of
the debug messages around filter management.

Fixes: c1e329ebec8d ("ionic: Add management of rx filters")
Signed-off-by: Shannon Nelson <snelson@pensando.io>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/pensando/ionic/ionic_lif.c | 17 +++++++----------
 .../ethernet/pensando/ionic/ionic_rx_filter.c   |  5 +++++
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index d5b0bf54f9610..c00ec9a020973 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -809,8 +809,7 @@ static int ionic_lif_addr_add(struct ionic_lif *lif, const u8 *addr)
 	if (f)
 		return 0;
 
-	netdev_dbg(lif->netdev, "rx_filter add ADDR %pM (id %d)\n", addr,
-		   ctx.comp.rx_filter_add.filter_id);
+	netdev_dbg(lif->netdev, "rx_filter add ADDR %pM\n", addr);
 
 	memcpy(ctx.cmd.rx_filter_add.mac.addr, addr, ETH_ALEN);
 	err = ionic_adminq_post_wait(lif, &ctx);
@@ -839,6 +838,9 @@ static int ionic_lif_addr_del(struct ionic_lif *lif, const u8 *addr)
 		return -ENOENT;
 	}
 
+	netdev_dbg(lif->netdev, "rx_filter del ADDR %pM (id %d)\n",
+		   addr, f->filter_id);
+
 	ctx.cmd.rx_filter_del.filter_id = cpu_to_le32(f->filter_id);
 	ionic_rx_filter_free(lif, f);
 	spin_unlock_bh(&lif->rx_filters.lock);
@@ -847,9 +849,6 @@ static int ionic_lif_addr_del(struct ionic_lif *lif, const u8 *addr)
 	if (err)
 		return err;
 
-	netdev_dbg(lif->netdev, "rx_filter del ADDR %pM (id %d)\n", addr,
-		   ctx.cmd.rx_filter_del.filter_id);
-
 	return 0;
 }
 
@@ -1291,13 +1290,11 @@ static int ionic_vlan_rx_add_vid(struct net_device *netdev, __be16 proto,
 	};
 	int err;
 
+	netdev_dbg(netdev, "rx_filter add VLAN %d\n", vid);
 	err = ionic_adminq_post_wait(lif, &ctx);
 	if (err)
 		return err;
 
-	netdev_dbg(netdev, "rx_filter add VLAN %d (id %d)\n", vid,
-		   ctx.comp.rx_filter_add.filter_id);
-
 	return ionic_rx_filter_save(lif, 0, IONIC_RXQ_INDEX_ANY, 0, &ctx);
 }
 
@@ -1322,8 +1319,8 @@ static int ionic_vlan_rx_kill_vid(struct net_device *netdev, __be16 proto,
 		return -ENOENT;
 	}
 
-	netdev_dbg(netdev, "rx_filter del VLAN %d (id %d)\n", vid,
-		   le32_to_cpu(ctx.cmd.rx_filter_del.filter_id));
+	netdev_dbg(netdev, "rx_filter del VLAN %d (id %d)\n",
+		   vid, f->filter_id);
 
 	ctx.cmd.rx_filter_del.filter_id = cpu_to_le32(f->filter_id);
 	ionic_rx_filter_free(lif, f);
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_rx_filter.c b/drivers/net/ethernet/pensando/ionic/ionic_rx_filter.c
index 7a093f148ee58..60cb77e2bab4c 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_rx_filter.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_rx_filter.c
@@ -36,10 +36,12 @@ int ionic_rx_filters_init(struct ionic_lif *lif)
 
 	spin_lock_init(&lif->rx_filters.lock);
 
+	spin_lock_bh(&lif->rx_filters.lock);
 	for (i = 0; i < IONIC_RX_FILTER_HLISTS; i++) {
 		INIT_HLIST_HEAD(&lif->rx_filters.by_hash[i]);
 		INIT_HLIST_HEAD(&lif->rx_filters.by_id[i]);
 	}
+	spin_unlock_bh(&lif->rx_filters.lock);
 
 	return 0;
 }
@@ -51,11 +53,13 @@ void ionic_rx_filters_deinit(struct ionic_lif *lif)
 	struct hlist_node *tmp;
 	unsigned int i;
 
+	spin_lock_bh(&lif->rx_filters.lock);
 	for (i = 0; i < IONIC_RX_FILTER_HLISTS; i++) {
 		head = &lif->rx_filters.by_id[i];
 		hlist_for_each_entry_safe(f, tmp, head, by_id)
 			ionic_rx_filter_free(lif, f);
 	}
+	spin_unlock_bh(&lif->rx_filters.lock);
 }
 
 int ionic_rx_filter_save(struct ionic_lif *lif, u32 flow_id, u16 rxq_index,
@@ -91,6 +95,7 @@ int ionic_rx_filter_save(struct ionic_lif *lif, u32 flow_id, u16 rxq_index,
 	f->filter_id = le32_to_cpu(ctx->comp.rx_filter_add.filter_id);
 	f->rxq_index = rxq_index;
 	memcpy(&f->cmd, ac, sizeof(f->cmd));
+	netdev_dbg(lif->netdev, "rx_filter add filter_id %d\n", f->filter_id);
 
 	INIT_HLIST_NODE(&f->by_hash);
 	INIT_HLIST_NODE(&f->by_id);
-- 
2.25.1



