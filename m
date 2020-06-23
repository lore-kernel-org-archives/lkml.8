Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94CBC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70DCB214DB
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592944431;
	bh=selabKS2AlkwqO/qOA7DWHVc5iEPhiIKHTp4r33ZNP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rWSWO4neUVXqer6iZxVLPGFkpMI8wlhJIjFFbVJEmjXY+Sy+qc8EZx5QFFOQkOTlt
	 NuxXad6WlUn97sKGnxYvmaRPORI55KwNW66xpXp7cVu11ENm4IjQh25b5mLmMmMNfz
	 v2k4jjDOc5arJGrRnppVLDVbW5lswlbQQnU1KU4I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391458AbgFWUdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:33:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:54910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391426AbgFWUdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:33:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FA042080C;
        Tue, 23 Jun 2020 20:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592944412;
        bh=selabKS2AlkwqO/qOA7DWHVc5iEPhiIKHTp4r33ZNP0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SqCh9daaKXKcSvT2ho67osIT6FdsexOL7EN5GYxHT6NkRPvUz/pUpiAQ7eDZTc4k2
         C7g7yY+azDCvao2NZxaspj6O/5hyIjKG4iLip0XKbsobiBgb3nANtErEYN41DWPtz7
         Pllhi9qUGO7lLUsJYMUw/sQRPytKdNxtCRuxu7+U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Denis Efremov <efremov@linux.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 293/314] net/mlx5: DR, Fix freeing in dr_create_rc_qp()
Date:   Tue, 23 Jun 2020 21:58:08 +0200
Message-Id: <20200623195352.943802344@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195338.770401005@linuxfoundation.org>
References: <20200623195338.770401005@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Efremov <efremov@linux.com>

[ Upstream commit 47a357de2b6b706af3c9471d5042f9ba8907031e ]

Variable "in" in dr_create_rc_qp() is allocated with kvzalloc() and
should be freed with kvfree().

Fixes: 297cccebdc5a ("net/mlx5: DR, Expose an internal API to issue RDMA operations")
Cc: stable@vger.kernel.org
Signed-off-by: Denis Efremov <efremov@linux.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/steering/dr_send.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_send.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_send.c
index 7c77378accf04..f012aac83b10e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_send.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_send.c
@@ -181,7 +181,7 @@ static struct mlx5dr_qp *dr_create_rc_qp(struct mlx5_core_dev *mdev,
 							 in, pas));
 
 	err = mlx5_core_create_qp(mdev, &dr_qp->mqp, in, inlen);
-	kfree(in);
+	kvfree(in);
 
 	if (err) {
 		mlx5_core_warn(mdev, " Can't create QP\n");
-- 
2.25.1



