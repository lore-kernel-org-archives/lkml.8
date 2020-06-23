Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92037C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A3C32078A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592947500;
	bh=E/EbDtPkBQbB1aRsDxJjrMwQOwUXREm0Gll4iXD4QKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PGa3sSaKyZycI1ybLGLCYu4i4e6CGPTaqgsJHE+1Q5i3LkxMipH8+z/s51QQY+dk5
	 oZqrblGbwaWpSvCcQl1GL+uf0hnxMvSd6H6LOBEym6okpFPGie9ewlZEX0k0CIf3Hj
	 wsco+Ko5nq47gpE4ZtF19hQxL6SXDUrLbK2qgdJ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389780AbgFWUTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:19:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:36304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389769AbgFWUTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:19:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D87052073E;
        Tue, 23 Jun 2020 20:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943554;
        bh=E/EbDtPkBQbB1aRsDxJjrMwQOwUXREm0Gll4iXD4QKg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zjrd6nZtFHBnZwxbRcuLr4mAekOIF7Sj0Tfe2ntpxYlVhS0jALWJN/vCIBACLL/vs
         PS0H5sy9oKxYSu2RlybN+J7dUL2b+XMG8NyxcxaQPyPaYT/OgGcHT90Y9HHt7Wg9kj
         0yxIKQPozi0YrkNcKfoNS+iE8GNUNVfIcef6vKdU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sven Auhagen <sven.auhagen@voleatech.de>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 407/477] mvpp2: remove module bugfix
Date:   Tue, 23 Jun 2020 21:56:44 +0200
Message-Id: <20200623195426.775063421@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Auhagen <sven.auhagen@voleatech.de>

[ Upstream commit 807eaf99688ce162a98a7501477644782d4af098 ]

The remove function does not destroy all
BM Pools when per cpu pool is active.

When reloading the mvpp2 as a module the BM Pools
are still active in hardware and due to the bug
have twice the size now old + new.

This eventually leads to a kernel crash.

v2:
* add Fixes tag

Fixes: 7d04b0b13b11 ("mvpp2: percpu buffers")
Signed-off-by: Sven Auhagen <sven.auhagen@voleatech.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 2b5dad2ec650c..b7b553602ea9f 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -5983,8 +5983,8 @@ static int mvpp2_remove(struct platform_device *pdev)
 {
 	struct mvpp2 *priv = platform_get_drvdata(pdev);
 	struct fwnode_handle *fwnode = pdev->dev.fwnode;
+	int i = 0, poolnum = MVPP2_BM_POOLS_NUM;
 	struct fwnode_handle *port_fwnode;
-	int i = 0;
 
 	mvpp2_dbgfs_cleanup(priv);
 
@@ -5998,7 +5998,10 @@ static int mvpp2_remove(struct platform_device *pdev)
 
 	destroy_workqueue(priv->stats_queue);
 
-	for (i = 0; i < MVPP2_BM_POOLS_NUM; i++) {
+	if (priv->percpu_pools)
+		poolnum = mvpp2_get_nrxqs(priv) * 2;
+
+	for (i = 0; i < poolnum; i++) {
 		struct mvpp2_bm_pool *bm_pool = &priv->bm_pools[i];
 
 		mvpp2_bm_pool_destroy(&pdev->dev, priv, bm_pool);
-- 
2.25.1



