Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50AF8C433F8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 23:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2241322B40
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 23:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595892320;
	bh=eKu6DjY96eDrcXdrf0WG2Xm8sTccD7/FHOeOGDcFR9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F6+P7DOHoc8Lgp3yBnY1IqFp7ktOnLBr3eY2LoxijaE3sAcVwdCTfO5vxCzJiky64
	 McKKiLQnrOQWkF8Lp6sposMLnimEefYBi0ZueMIP7suPjjjekZ2pJddWRZyfpMiU0J
	 E4RvuF6OXb83zyTbNwnDtqr48Xyt5P0QSaoiEndQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbgG0XZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 19:25:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:36472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728528AbgG0XZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 19:25:12 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 031E922B42;
        Mon, 27 Jul 2020 23:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595892311;
        bh=eKu6DjY96eDrcXdrf0WG2Xm8sTccD7/FHOeOGDcFR9Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A9c8fIbOgxViMkEVR8kSxrL/jcvyUgiTLCr9LnjSzsjp3fY88MizfYI+mbP3QlDHB
         YlPoxq9w9nOEYUAZznaFKQKPFQ0+NxytZzaKVUvvtLhvB9FBGCFkLuHUg+K3nLaEy2
         JoR9ZFoYkt2x+JfsfXXIy/FIqy4FUnvbYXGrmq9s=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 09/10] cxgb4: add missing release on skb in uld_send()
Date:   Mon, 27 Jul 2020 19:24:57 -0400
Message-Id: <20200727232458.718131-9-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200727232458.718131-1-sashal@kernel.org>
References: <20200727232458.718131-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

[ Upstream commit e6827d1abdc9b061a57d7b7d3019c4e99fabea2f ]

In the implementation of uld_send(), the skb is consumed on all
execution paths except one. Release skb when returning NET_XMIT_DROP.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/chelsio/cxgb4/sge.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/sge.c b/drivers/net/ethernet/chelsio/cxgb4/sge.c
index 0a5c4c7da5052..006f8b8aaa7dc 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/sge.c
@@ -1812,6 +1812,7 @@ static inline int uld_send(struct adapter *adap, struct sk_buff *skb,
 	txq_info = adap->sge.uld_txq_info[tx_uld_type];
 	if (unlikely(!txq_info)) {
 		WARN_ON(true);
+		kfree_skb(skb);
 		return NET_XMIT_DROP;
 	}
 
-- 
2.25.1

