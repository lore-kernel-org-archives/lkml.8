Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74D8C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96F0A206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586955132;
	bh=ozbil6teHRQms2yndtqXeku8YT1e+SBiAYvYG9sQlIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dm4an750nqmUNrLpJHti93a5SJp4wyYlEU86FzqYRvhfdmNh5BFKlQhqfHpqhZZ3r
	 dJe5BzQEbjfvt++XSJbT5AwPvIP2rgFvqKMhgFedNUri7dgfiAwN1zN4JsxR82q8et
	 1/tpbfqnC8nvYvw4BkDZ1x6LYrRrSqs6nV+4J8Jc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897493AbgDOLml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 07:42:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:56408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2897168AbgDOLgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 07:36:42 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8676721556;
        Wed, 15 Apr 2020 11:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586950596;
        bh=ozbil6teHRQms2yndtqXeku8YT1e+SBiAYvYG9sQlIA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MlUh+AqSk3zxSn3pRS8HKV9UX8Hrd5ycBubibHtqZykvDFZ/lz3VrxwLmj8mgzbAP
         6owJwL66qq/0TDH4ym2XYkXw5FC2s7TmJ7eKRHxQqwpGcbs95LfM7iSnOrBQf5Swlh
         2nYtEISys07jB3q3ASoV2DvjVaq0gu8wwjZXHIuU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 092/129] cxgb4: free MQPRIO resources in shutdown path
Date:   Wed, 15 Apr 2020 07:34:07 -0400
Message-Id: <20200415113445.11881-92-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415113445.11881-1-sashal@kernel.org>
References: <20200415113445.11881-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>

[ Upstream commit cef8dac96bc108633f5090bb3a9988d734dc1ee0 ]

Perform missing MQPRIO resource cleanup in PCI shutdown path. Also,
fix MQPRIO MSIX bitmap leak in resource cleanup.

Fixes: b1396c2bd675 ("cxgb4: parse and configure TC-MQPRIO offload")
Signed-off-by: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/chelsio/cxgb4/cxgb4_main.c   |  4 ++++
 .../ethernet/chelsio/cxgb4/cxgb4_tc_mqprio.c  | 23 +++++++++++++++++++
 .../ethernet/chelsio/cxgb4/cxgb4_tc_mqprio.h  |  1 +
 3 files changed, 28 insertions(+)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
index 6767c73c87a1e..b0bdf7233f0ca 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
@@ -6681,6 +6681,10 @@ static void shutdown_one(struct pci_dev *pdev)
 			if (adapter->port[i]->reg_state == NETREG_REGISTERED)
 				cxgb_close(adapter->port[i]);
 
+		rtnl_lock();
+		cxgb4_mqprio_stop_offload(adapter);
+		rtnl_unlock();
+
 		if (is_uld(adapter)) {
 			detach_ulds(adapter);
 			t4_uld_clean_up(adapter);
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_mqprio.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_mqprio.c
index ec3eb45ee3b48..e6af4906d6743 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_mqprio.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_mqprio.c
@@ -301,6 +301,7 @@ static void cxgb4_mqprio_free_hw_resources(struct net_device *dev)
 			cxgb4_clear_msix_aff(eorxq->msix->vec,
 					     eorxq->msix->aff_mask);
 			free_irq(eorxq->msix->vec, &eorxq->rspq);
+			cxgb4_free_msix_idx_in_bmap(adap, eorxq->msix->idx);
 		}
 
 		free_rspq_fl(adap, &eorxq->rspq, &eorxq->fl);
@@ -611,6 +612,28 @@ int cxgb4_setup_tc_mqprio(struct net_device *dev,
 	return ret;
 }
 
+void cxgb4_mqprio_stop_offload(struct adapter *adap)
+{
+	struct cxgb4_tc_port_mqprio *tc_port_mqprio;
+	struct net_device *dev;
+	u8 i;
+
+	if (!adap->tc_mqprio || !adap->tc_mqprio->port_mqprio)
+		return;
+
+	for_each_port(adap, i) {
+		dev = adap->port[i];
+		if (!dev)
+			continue;
+
+		tc_port_mqprio = &adap->tc_mqprio->port_mqprio[i];
+		if (!tc_port_mqprio->mqprio.qopt.num_tc)
+			continue;
+
+		cxgb4_mqprio_disable_offload(dev);
+	}
+}
+
 int cxgb4_init_tc_mqprio(struct adapter *adap)
 {
 	struct cxgb4_tc_port_mqprio *tc_port_mqprio, *port_mqprio;
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_mqprio.h b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_mqprio.h
index c532f1ef84517..ff8794132b22b 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_mqprio.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_mqprio.h
@@ -38,6 +38,7 @@ struct cxgb4_tc_mqprio {
 
 int cxgb4_setup_tc_mqprio(struct net_device *dev,
 			  struct tc_mqprio_qopt_offload *mqprio);
+void cxgb4_mqprio_stop_offload(struct adapter *adap);
 int cxgb4_init_tc_mqprio(struct adapter *adap);
 void cxgb4_cleanup_tc_mqprio(struct adapter *adap);
 #endif /* __CXGB4_TC_MQPRIO_H__ */
-- 
2.20.1

