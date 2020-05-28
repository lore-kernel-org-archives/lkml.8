Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E875BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 11:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5C7D21841
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 11:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590667095;
	bh=rLPYZy8BfA6VlzlWQXP+dW2j7mV2wYkXIstlwBNSK4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cFFCyqeycPe29WPH7FD5gybBJPki9OnFDGw1+yOld0usQQIbxA9CtB21/85BlHGUy
	 1nZqnaGkNgptnip0PCjkrY4v90548EhXHulPSyp5nQMdvW34d1vqk21wNinxOj/XUD
	 xp/QXvIksmXbcxhFDf3Eqa+TMJD89x+B+9AaRiuc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389198AbgE1L6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 07:58:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:49784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388980AbgE1L5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 07:57:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A32C7215A4;
        Thu, 28 May 2020 11:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590667038;
        bh=rLPYZy8BfA6VlzlWQXP+dW2j7mV2wYkXIstlwBNSK4M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2OSaG1chsrXDOlxCJpzRkPfuJ/wK4NkZ4UJQEz7hu19k5ww0/KWlhycWrHvRaZMta
         X/nOZ2RewxGwJISx5z58d26t9IQrEl63a/l2g1fnezmP1MjFxWRoh2Kn/+VqTeoHI2
         QqTpNIgQlaoI0UnQbp3qa7ByUQBjSeTBI/NvOiOY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Moshe Shemesh <moshe@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 21/26] net/mlx5: Fix memory leak in mlx5_events_init
Date:   Thu, 28 May 2020 07:56:49 -0400
Message-Id: <20200528115654.1406165-21-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200528115654.1406165-1-sashal@kernel.org>
References: <20200528115654.1406165-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Moshe Shemesh <moshe@mellanox.com>

[ Upstream commit df14ad1eccb04a4a28c90389214dbacab085b244 ]

Fix memory leak in mlx5_events_init(), in case
create_single_thread_workqueue() fails, events
struct should be freed.

Fixes: 5d3c537f9070 ("net/mlx5: Handle event of power detection in the PCIE slot")
Signed-off-by: Moshe Shemesh <moshe@mellanox.com>
Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/events.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/events.c b/drivers/net/ethernet/mellanox/mlx5/core/events.c
index 8bcf3426b9c6..3ce17c3d7a00 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/events.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/events.c
@@ -346,8 +346,10 @@ int mlx5_events_init(struct mlx5_core_dev *dev)
 	events->dev = dev;
 	dev->priv.events = events;
 	events->wq = create_singlethread_workqueue("mlx5_events");
-	if (!events->wq)
+	if (!events->wq) {
+		kfree(events);
 		return -ENOMEM;
+	}
 	INIT_WORK(&events->pcie_core_work, mlx5_pcie_event);
 
 	return 0;
-- 
2.25.1

