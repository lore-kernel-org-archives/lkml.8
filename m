Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF0AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC2C920663
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592946167;
	bh=tpk1lI+xUhmj9x8UVeBpdgPE5A7IUMhonMn75/qTPS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CB2yFhTqG12NizmTjiGeKekbnn4DdL1BD+Ed5+PC8LZpj2tzD3yfLUkt/uL4nIwa/
	 GXVdtZxmHFdeD2Muc4Xh8KgjabUh3Xz9yCMwyglAALGULSXHQ7B/txm8LNyxL87P1N
	 w7IgsbT7+f6RPUyIHMsen3O07QCXnYgJrXs8c5pk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403842AbgFWUjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:39:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:34436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391998AbgFWUiw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:38:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAE2821531;
        Tue, 23 Jun 2020 20:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592944732;
        bh=tpk1lI+xUhmj9x8UVeBpdgPE5A7IUMhonMn75/qTPS8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cn1cnE4zTOct53AK9/TBOBb5siCrlRNffFQhNYkzlHP+RxbV1e6UwhUR9dfRIQ1+V
         +lptd5dggB/AeelYkVX9vbLLmCrzgsZoDD1ycHrPfBoijOwtju8kwwgbybK1uovwHo
         Ur84Jo4xYRdeWQDOg8pJq6lrm3LAgpMcvmnjTe+Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Maor Gottlieb <maorg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 104/206] IB/cma: Fix ports memory leak in cma_configfs
Date:   Tue, 23 Jun 2020 21:57:12 +0200
Message-Id: <20200623195322.059007984@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195316.864547658@linuxfoundation.org>
References: <20200623195316.864547658@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maor Gottlieb <maorg@mellanox.com>

[ Upstream commit 63a3345c2d42a9b29e1ce2d3a4043689b3995cea ]

The allocated ports structure in never freed. The free function should be
called by release_cma_ports_group, but the group is never released since
we don't remove its default group.

Remove default groups when device group is deleted.

Fixes: 045959db65c6 ("IB/cma: Add configfs for rdma_cm")
Link: https://lore.kernel.org/r/20200521072650.567908-1-leon@kernel.org
Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/core/cma_configfs.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/infiniband/core/cma_configfs.c b/drivers/infiniband/core/cma_configfs.c
index eee38b40be990..ce183d0547852 100644
--- a/drivers/infiniband/core/cma_configfs.c
+++ b/drivers/infiniband/core/cma_configfs.c
@@ -319,8 +319,21 @@ fail:
 	return ERR_PTR(err);
 }
 
+static void drop_cma_dev(struct config_group *cgroup, struct config_item *item)
+{
+	struct config_group *group =
+		container_of(item, struct config_group, cg_item);
+	struct cma_dev_group *cma_dev_group =
+		container_of(group, struct cma_dev_group, device_group);
+
+	configfs_remove_default_groups(&cma_dev_group->ports_group);
+	configfs_remove_default_groups(&cma_dev_group->device_group);
+	config_item_put(item);
+}
+
 static struct configfs_group_operations cma_subsys_group_ops = {
 	.make_group	= make_cma_dev,
+	.drop_item	= drop_cma_dev,
 };
 
 static const struct config_item_type cma_subsys_type = {
-- 
2.25.1



