Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A147C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E577920724
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592947436;
	bh=6xG++iIvFQ0P9w0PQXIEtbxJNWBGcef1pHmStQxfyfU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cY3/rE/ybAvwvcf1KdIiVSIWQoJUHnZPiMhyN0LR7v3zlb53TyR7yq50U254oxo7E
	 01VAh4Qd/Xql50WiJhh3JOTv6cjsFsAtaddSIViDbbmsooimvJPg/JwNTtC0jzD3J8
	 e0cCFFtHMLD1q7oY3ELdLGRaK4CXxnW+LS5d5czE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390308AbgFWVXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:23:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:38006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389952AbgFWUUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:20:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65C462168B;
        Tue, 23 Jun 2020 20:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943637;
        bh=6xG++iIvFQ0P9w0PQXIEtbxJNWBGcef1pHmStQxfyfU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LsExLFsCkCsSY2CRl8bNJR3F3l/iQxfbFULXH2KQDWQAFjDiYhNQciunu1eNJEwcW
         aL2pEFQZf0QGsIL8hCKjzRcq+5USKTv828s1fMLnm18iQgQAs0Ma+NtPMg4B/UQqhF
         0j5txnlsrlQatz2vp0/ksz1gZeyEoxB84O6SPXdg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Denis Efremov <efremov@linux.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 438/477] net/mlx5: DR, Fix freeing in dr_create_rc_qp()
Date:   Tue, 23 Jun 2020 21:57:15 +0200
Message-Id: <20200623195428.235096926@linuxfoundation.org>
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
index 18719acb7e547..eff8bb64899d6 100644
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



