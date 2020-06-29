Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19198C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E157220760
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593460125;
	bh=5+Q2LbZakW7M8pUDTNFnL1YeRbaqIOCUnuuA2pCSyaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xIcIOMuY9sI/ypqtPf63alO1BYaXyENF/bYT5A2mfU+3UIYKJgZ8JxXpiJn+VLPpv
	 WjB7b0+UWMkF1RA7QNPW6kUd1gaAPCin3tAzDWhGEp/KuS6976/zVy3k4lYLygcagH
	 I4QcBCbQV9oUr/FM02+8lNuDRd1k5Uw/83GWLpcs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388188AbgF2Tso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:48:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:47654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387775AbgF2Tkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:40:39 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB8D4248A8;
        Mon, 29 Jun 2020 15:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593444405;
        bh=5+Q2LbZakW7M8pUDTNFnL1YeRbaqIOCUnuuA2pCSyaM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j66nQpb8lbZ0i6Jn7takeny7YoDCVV3k9vS2Bdnop6VuxIMuHXhK2UIG8lVFUeh82
         UznRZyAnarx0DJnzHU3LAzo8HEKeUjHPRayFT+7bF5Ce5F+PP/YX3LGUIO1E/hxcLU
         T8EkxzzZswPF1MsGo1HWtaZMSfVx/+6UB3gVwSWI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Aditya Pakki <pakki001@umn.edu>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 083/178] RDMA/rvt: Fix potential memory leak caused by rvt_alloc_rq
Date:   Mon, 29 Jun 2020 11:23:48 -0400
Message-Id: <20200629152523.2494198-84-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629152523.2494198-1-sashal@kernel.org>
References: <20200629152523.2494198-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.50-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.50-rc1
X-KernelTest-Deadline: 2020-07-01T15:25+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aditya Pakki <pakki001@umn.edu>

[ Upstream commit 90a239ee25fa3a483facec3de7c144361a3d3a51 ]

In case of failure of alloc_ud_wq_attr(), the memory allocated by
rvt_alloc_rq() is not freed. Fix it by calling rvt_free_rq() using the
existing clean-up code.

Fixes: d310c4bf8aea ("IB/{rdmavt, hfi1, qib}: Remove AH refcount for UD QPs")
Link: https://lore.kernel.org/r/20200614041148.131983-1-pakki001@umn.edu
Signed-off-by: Aditya Pakki <pakki001@umn.edu>
Acked-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/sw/rdmavt/qp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdmavt/qp.c
index d354653893577..19556c62c7ea8 100644
--- a/drivers/infiniband/sw/rdmavt/qp.c
+++ b/drivers/infiniband/sw/rdmavt/qp.c
@@ -1196,7 +1196,7 @@ struct ib_qp *rvt_create_qp(struct ib_pd *ibpd,
 		err = alloc_ud_wq_attr(qp, rdi->dparms.node);
 		if (err) {
 			ret = (ERR_PTR(err));
-			goto bail_driver_priv;
+			goto bail_rq_rvt;
 		}
 
 		err = alloc_qpn(rdi, &rdi->qp_dev->qpn_table,
@@ -1300,9 +1300,11 @@ struct ib_qp *rvt_create_qp(struct ib_pd *ibpd,
 	rvt_free_qpn(&rdi->qp_dev->qpn_table, qp->ibqp.qp_num);
 
 bail_rq_wq:
-	rvt_free_rq(&qp->r_rq);
 	free_ud_wq_attr(qp);
 
+bail_rq_rvt:
+	rvt_free_rq(&qp->r_rq);
+
 bail_driver_priv:
 	rdi->driver_f.qp_priv_free(rdi, qp);
 
-- 
2.25.1

