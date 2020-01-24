Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1CCFC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8719206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579876582;
	bh=h0JhtyW6D8uUqk3WShVgnkV5IWhdc1Jwop7akn+Ke+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p6iKW3XxsnYiYL/UUXFzrxAgrO9t7gwPU1hY2WEE+1IGRshcBJKAnzyp6PH3FrDDg
	 87VXTGEn6yUKWkmsMoAxBdVxFe7qdWQRVzaq0TJBZSYnu4DMp6Bwjq+FWVvTy4AD+W
	 P9yotrGETUBpfdX3YAhQqHWn8dBQnXhFC9oSc+/M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388606AbgAXOgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 09:36:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:39404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391410AbgAXOTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 09:19:14 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1952321569;
        Fri, 24 Jan 2020 14:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579875553;
        bh=h0JhtyW6D8uUqk3WShVgnkV5IWhdc1Jwop7akn+Ke+Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pKJfPs8HCenHVO3KuzGbwN71Ub89siElLE9Z+8ozJoq/Rc1Fbqn90txbMUQ1VLsBz
         g3qg5e76qK5FEEfihjfRcYkpiqjlqQXSARhP2IBCI07z1og6u42s5Y/9Gj1/QkVikd
         tFbIx1HpBch6bIM2xyQTcU3BwCgz4neHes6ilhUc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jose Abreu <Jose.Abreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 048/107] net: stmmac: selftests: Update status when disabling RSS
Date:   Fri, 24 Jan 2020 09:17:18 -0500
Message-Id: <20200124141817.28793-48-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124141817.28793-1-sashal@kernel.org>
References: <20200124141817.28793-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jose Abreu <Jose.Abreu@synopsys.com>

[ Upstream commit e715d74504352968cf24ac95476706bc911a69cd ]

We are disabling RSS on HW but not updating the internal private status
to the 'disabled' state. This is needed for next tc commit that will
check if RSS is disabled before trying to apply filters.

Fixes: 4647e021193d ("net: stmmac: selftests: Add selftest for L3/L4 Filters")
Signed-off-by: Jose Abreu <Jose.Abreu@synopsys.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../stmicro/stmmac/stmmac_selftests.c         | 20 +++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
index a0513deab1a04..3679d123a2ab7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
@@ -1291,16 +1291,19 @@ static int __stmmac_test_l3filt(struct stmmac_priv *priv, u32 dst, u32 src,
 	struct stmmac_packet_attrs attr = { };
 	struct flow_dissector *dissector;
 	struct flow_cls_offload *cls;
+	int ret, old_enable = 0;
 	struct flow_rule *rule;
-	int ret;
 
 	if (!tc_can_offload(priv->dev))
 		return -EOPNOTSUPP;
 	if (!priv->dma_cap.l3l4fnum)
 		return -EOPNOTSUPP;
-	if (priv->rss.enable)
+	if (priv->rss.enable) {
+		old_enable = priv->rss.enable;
+		priv->rss.enable = false;
 		stmmac_rss_configure(priv, priv->hw, NULL,
 				     priv->plat->rx_queues_to_use);
+	}
 
 	dissector = kzalloc(sizeof(*dissector), GFP_KERNEL);
 	if (!dissector) {
@@ -1367,7 +1370,8 @@ cleanup_cls:
 cleanup_dissector:
 	kfree(dissector);
 cleanup_rss:
-	if (priv->rss.enable) {
+	if (old_enable) {
+		priv->rss.enable = old_enable;
 		stmmac_rss_configure(priv, priv->hw, &priv->rss,
 				     priv->plat->rx_queues_to_use);
 	}
@@ -1412,16 +1416,19 @@ static int __stmmac_test_l4filt(struct stmmac_priv *priv, u32 dst, u32 src,
 	struct stmmac_packet_attrs attr = { };
 	struct flow_dissector *dissector;
 	struct flow_cls_offload *cls;
+	int ret, old_enable = 0;
 	struct flow_rule *rule;
-	int ret;
 
 	if (!tc_can_offload(priv->dev))
 		return -EOPNOTSUPP;
 	if (!priv->dma_cap.l3l4fnum)
 		return -EOPNOTSUPP;
-	if (priv->rss.enable)
+	if (priv->rss.enable) {
+		old_enable = priv->rss.enable;
+		priv->rss.enable = false;
 		stmmac_rss_configure(priv, priv->hw, NULL,
 				     priv->plat->rx_queues_to_use);
+	}
 
 	dissector = kzalloc(sizeof(*dissector), GFP_KERNEL);
 	if (!dissector) {
@@ -1493,7 +1500,8 @@ cleanup_cls:
 cleanup_dissector:
 	kfree(dissector);
 cleanup_rss:
-	if (priv->rss.enable) {
+	if (old_enable) {
+		priv->rss.enable = old_enable;
 		stmmac_rss_configure(priv, priv->hw, &priv->rss,
 				     priv->plat->rx_queues_to_use);
 	}
-- 
2.20.1

