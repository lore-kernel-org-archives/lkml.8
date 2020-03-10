Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D932FC18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B122C2468C
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583845515;
	bh=KL4JErVhXuQl6imqunCMwr80X2awD10BEWqPHBFpjGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FOOG2OgrldO27ZuUkheAMfuULl3BvFWdjgpGW5ZjhOG+3X/K9PSMFJhMhS7EmcYyd
	 c8YjjyVB2crGViAXbUWfQF8jarlWJd0G/HY17FSZTzbNl5K6rh9MrgY4I4XYrV7SpI
	 EzRxdbKke16htDRPm6eeZqdpIThCCM43yox/R38E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730587AbgCJND0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:03:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:47948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730563AbgCJNDS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:03:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B51BF2468D;
        Tue, 10 Mar 2020 13:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583845398;
        bh=KL4JErVhXuQl6imqunCMwr80X2awD10BEWqPHBFpjGc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JrlBC37Mxu2joB40ENgpO5UOSELKV4NADvGZGeZtLua2kTah0caCUGb6FvNkkw7CS
         XxPloBfqxIf6jciKLoHwSnmrK01s+Zi/H2oIytng19SdQZDFSYCjfD+2D7kp/Y2lLK
         uldDMIu6Gv72iesUEk2NZmkc+c20xc+rkjLCB3YM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Artemy Kovalyov <artemyko@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: [PATCH 5.5 169/189] IB/mlx5: Fix implicit ODP race
Date:   Tue, 10 Mar 2020 13:40:06 +0100
Message-Id: <20200310123656.987256451@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123639.608886314@linuxfoundation.org>
References: <20200310123639.608886314@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Artemy Kovalyov <artemyko@mellanox.com>

commit de5ed007a03d71daaa505f5daa4d3666530c7090 upstream.

Following race may occur because of the call_srcu and the placement of
the synchronize_srcu vs the xa_erase.

CPU0				   CPU1

mlx5_ib_free_implicit_mr:	   destroy_unused_implicit_child_mr:
 xa_erase(odp_mkeys)
 synchronize_srcu()
				    xa_lock(implicit_children)
				    if (still in xarray)
				       atomic_inc()
				       call_srcu()
				    xa_unlock(implicit_children)
 xa_erase(implicit_children):
   xa_lock(implicit_children)
   __xa_erase()
   xa_unlock(implicit_children)

 flush_workqueue()
				   [..]
				    free_implicit_child_mr_rcu:
				     (via call_srcu)
				      queue_work()

 WARN_ON(atomic_read())
				   [..]
				    free_implicit_child_mr_work:
				     (via wq)
				      free_implicit_child_mr()
 mlx5_mr_cache_invalidate()
				     mlx5_ib_update_xlt() <-- UMR QP fail
				     atomic_dec()

The wait_event() solves the race because it blocks until
free_implicit_child_mr_work() completes.

Fixes: 5256edcb98a1 ("RDMA/mlx5: Rework implicit ODP destroy")
Link: https://lore.kernel.org/r/20200227113918.94432-1-leon@kernel.org
Signed-off-by: Artemy Kovalyov <artemyko@mellanox.com>
Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/mlx5/mlx5_ib.h |    1 +
 drivers/infiniband/hw/mlx5/odp.c     |   17 +++++++----------
 2 files changed, 8 insertions(+), 10 deletions(-)

--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -629,6 +629,7 @@ struct mlx5_ib_mr {
 
 	/* For ODP and implicit */
 	atomic_t		num_deferred_work;
+	wait_queue_head_t       q_deferred_work;
 	struct xarray		implicit_children;
 	union {
 		struct rcu_head rcu;
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -197,7 +197,8 @@ static void free_implicit_child_mr(struc
 	mr->parent = NULL;
 	mlx5_mr_cache_free(mr->dev, mr);
 	ib_umem_odp_release(odp);
-	atomic_dec(&imr->num_deferred_work);
+	if (atomic_dec_and_test(&imr->num_deferred_work))
+		wake_up(&imr->q_deferred_work);
 }
 
 static void free_implicit_child_mr_work(struct work_struct *work)
@@ -516,6 +517,7 @@ struct mlx5_ib_mr *mlx5_ib_alloc_implici
 	imr->umem = &umem_odp->umem;
 	imr->is_odp_implicit = true;
 	atomic_set(&imr->num_deferred_work, 0);
+	init_waitqueue_head(&imr->q_deferred_work);
 	xa_init(&imr->implicit_children);
 
 	err = mlx5_ib_update_xlt(imr, 0,
@@ -573,10 +575,7 @@ void mlx5_ib_free_implicit_mr(struct mlx
 	 * under xa_lock while the child is in the xarray. Thus at this point
 	 * it is only decreasing, and all work holding it is now on the wq.
 	 */
-	if (atomic_read(&imr->num_deferred_work)) {
-		flush_workqueue(system_unbound_wq);
-		WARN_ON(atomic_read(&imr->num_deferred_work));
-	}
+	wait_event(imr->q_deferred_work, !atomic_read(&imr->num_deferred_work));
 
 	/*
 	 * Fence the imr before we destroy the children. This allows us to
@@ -607,10 +606,7 @@ void mlx5_ib_fence_odp_mr(struct mlx5_ib
 	/* Wait for all running page-fault handlers to finish. */
 	synchronize_srcu(&mr->dev->odp_srcu);
 
-	if (atomic_read(&mr->num_deferred_work)) {
-		flush_workqueue(system_unbound_wq);
-		WARN_ON(atomic_read(&mr->num_deferred_work));
-	}
+	wait_event(mr->q_deferred_work, !atomic_read(&mr->num_deferred_work));
 
 	dma_fence_odp_mr(mr);
 }
@@ -1682,7 +1678,8 @@ static void destroy_prefetch_work(struct
 	u32 i;
 
 	for (i = 0; i < work->num_sge; ++i)
-		atomic_dec(&work->frags[i].mr->num_deferred_work);
+		if (atomic_dec_and_test(&work->frags[i].mr->num_deferred_work))
+			wake_up(&work->frags[i].mr->q_deferred_work);
 	kvfree(work);
 }
 


