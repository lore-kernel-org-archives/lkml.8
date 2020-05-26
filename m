Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C3FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A10BA20776
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590521178;
	bh=PCsgbt5v6WinRuq7K+SJDG9+42A3faV5vX8tzMT9ruo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FR/lr/bO7cHzX+/q5ygdTumaJAaFnicB/lr3AMuNAqcfBBgek+BOl/40X5mWUAAvt
	 pjCYem3Q7B+OX3jtNpFh57AJDPcrRKKw1rh3araxiazB0Y4FJ54k8OvuXy7qGTobMs
	 FTKR6d44B/C+eW9SeHZsrquH7tDOutrmnvD2qn0c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392577AbgEZT0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:26:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:34236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403856AbgEZTGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:06:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08A6920873;
        Tue, 26 May 2020 19:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590519966;
        bh=PCsgbt5v6WinRuq7K+SJDG9+42A3faV5vX8tzMT9ruo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hb1yOdcMWQDacrvcPnfihIachXEq4JDPfQXPP5v0v0cGzcq5SA61jsQtePGuc89DO
         syTRKXH7D6sLmFE2opcJ6sXvZFklASCjOV5RoyJSKNYYCQfEqPCfuwws+0PmJBoORB
         arlmJ2LcRKTaDxd/8tNq5TenR8mvaElfS6GsvG4w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arjun Vynipadath <arjun@chelsio.com>,
        Casey Leedom <leedom@chelsio.com>,
        Ganesh Goudar <ganeshgr@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 61/81] cxgb4/cxgb4vf: Fix mac_hlist initialization and free
Date:   Tue, 26 May 2020 20:53:36 +0200
Message-Id: <20200526183933.823740601@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183923.108515292@linuxfoundation.org>
References: <20200526183923.108515292@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arjun Vynipadath <arjun@chelsio.com>

[ Upstream commit b539ea60f5043b9acd7562f04fa2117f18776cbb ]

Null pointer dereference seen when cxgb4vf driver is unloaded
without bringing up any interfaces, moving mac_hlist initialization
to driver probe and free the mac_hlist in remove to fix the issue.

Fixes: 24357e06ba51 ("cxgb4vf: fix memleak in mac_hlist initialization")
Signed-off-by: Arjun Vynipadath <arjun@chelsio.com>
Signed-off-by: Casey Leedom <leedom@chelsio.com>
Signed-off-by: Ganesh Goudar <ganeshgr@chelsio.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/chelsio/cxgb4/cxgb4_main.c   | 19 ++++++++++---------
 .../ethernet/chelsio/cxgb4vf/cxgb4vf_main.c   |  6 +++---
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
index c334b6206871..9d1d77125826 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
@@ -2281,8 +2281,6 @@ static int cxgb_up(struct adapter *adap)
 #if IS_ENABLED(CONFIG_IPV6)
 	update_clip(adap);
 #endif
-	/* Initialize hash mac addr list*/
-	INIT_LIST_HEAD(&adap->mac_hlist);
 	return err;
 
  irq_err:
@@ -2296,8 +2294,6 @@ static int cxgb_up(struct adapter *adap)
 
 static void cxgb_down(struct adapter *adapter)
 {
-	struct hash_mac_addr *entry, *tmp;
-
 	cancel_work_sync(&adapter->tid_release_task);
 	cancel_work_sync(&adapter->db_full_task);
 	cancel_work_sync(&adapter->db_drop_task);
@@ -2307,11 +2303,6 @@ static void cxgb_down(struct adapter *adapter)
 	t4_sge_stop(adapter);
 	t4_free_sge_resources(adapter);
 
-	list_for_each_entry_safe(entry, tmp, &adapter->mac_hlist, list) {
-		list_del(&entry->list);
-		kfree(entry);
-	}
-
 	adapter->flags &= ~FULL_INIT_DONE;
 }
 
@@ -5610,6 +5601,9 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 			     (is_t5(adapter->params.chip) ? STATMODE_V(0) :
 			      T6_STATMODE_V(0)));
 
+	/* Initialize hash mac addr list */
+	INIT_LIST_HEAD(&adapter->mac_hlist);
+
 	for_each_port(adapter, i) {
 		netdev = alloc_etherdev_mq(sizeof(struct port_info),
 					   MAX_ETH_QSETS);
@@ -5884,6 +5878,7 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 static void remove_one(struct pci_dev *pdev)
 {
 	struct adapter *adapter = pci_get_drvdata(pdev);
+	struct hash_mac_addr *entry, *tmp;
 
 	if (!adapter) {
 		pci_release_regions(pdev);
@@ -5931,6 +5926,12 @@ static void remove_one(struct pci_dev *pdev)
 		if (adapter->num_uld || adapter->num_ofld_uld)
 			t4_uld_mem_free(adapter);
 		free_some_resources(adapter);
+		list_for_each_entry_safe(entry, tmp, &adapter->mac_hlist,
+					 list) {
+			list_del(&entry->list);
+			kfree(entry);
+		}
+
 #if IS_ENABLED(CONFIG_IPV6)
 		t4_cleanup_clip_tbl(adapter);
 #endif
diff --git a/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c b/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c
index 972dc7bd721d..15029a5e62b9 100644
--- a/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c
@@ -723,9 +723,6 @@ static int adapter_up(struct adapter *adapter)
 		if (adapter->flags & USING_MSIX)
 			name_msix_vecs(adapter);
 
-		/* Initialize hash mac addr list*/
-		INIT_LIST_HEAD(&adapter->mac_hlist);
-
 		adapter->flags |= FULL_INIT_DONE;
 	}
 
@@ -3038,6 +3035,9 @@ static int cxgb4vf_pci_probe(struct pci_dev *pdev,
 	if (err)
 		goto err_unmap_bar;
 
+	/* Initialize hash mac addr list */
+	INIT_LIST_HEAD(&adapter->mac_hlist);
+
 	/*
 	 * Allocate our "adapter ports" and stitch everything together.
 	 */
-- 
2.25.1



