Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 536FAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 381B420674
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597692938;
	bh=L0Qb6iWSC9f8uqPcyvIxwgiepdf1g4/2ZxUmL2djvjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CyG4xUmUbKuvPhYObxnybq0maziSN06gqXOzITVAW8ZlbHDWF8vgh/bdV+l4L7L63
	 8l3Tnajit5Jo/IGMVaKKLtN/beaYnfxpQ0TpRdD+Mut6OOiQfu0SQ+7zj8tilowTDn
	 /tptimKVJ9Uf8cIlKGWNURFVq8nGbYo94QwOJZLk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732368AbgHQTfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:35:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:46782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730068AbgHQP3L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:29:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B14A23110;
        Mon, 17 Aug 2020 15:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597678150;
        bh=L0Qb6iWSC9f8uqPcyvIxwgiepdf1g4/2ZxUmL2djvjI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dr64GM/mg8pzs48hgzgw9TuDQq/FdwjEgsBbBAM1aRXCoXPi17Vst7nV9pqDSIcBO
         1pbwBYPPtBCD1kmkVlkPspc1xphfInkzw5myoljovbhVx2a9U9waFGwcLC01jyoG6V
         MqNfYoQGXjwtAqAWGWbaIuP/e9F+GD9wE82VGkEM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yuval Bason <yuval.bason@marvell.com>,
        Michal Kalderon <michal.kalderon@marvell.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 236/464] RDMA/qedr: Add EDPM mode type for user-fw compatibility
Date:   Mon, 17 Aug 2020 17:13:09 +0200
Message-Id: <20200817143845.103317410@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143833.737102804@linuxfoundation.org>
References: <20200817143833.737102804@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Kalderon <michal.kalderon@marvell.com>

[ Upstream commit bbe4f4245271bd0f21bf826996c0c5d87a3529c9 ]

In older FW versions the completion flag was treated as the ack flag in
edpm messages.  commit ff937b916eb6 ("qed: Add EDPM mode type for user-fw
compatibility") exposed the FW option of setting which mode the QP is in
by adding a flag to the qedr <-> qed API.

This patch adds the qedr <-> libqedr interface so that the libqedr can set
the flag appropriately and qedr can pass it down to FW.  Flag is added for
backward compatibility with libqedr.

For older libs, this flag didn't exist and therefore set to zero.

Fixes: ac1b36e55a51 ("qedr: Add support for user context verbs")
Link: https://lore.kernel.org/r/20200707063100.3811-2-michal.kalderon@marvell.com
Signed-off-by: Yuval Bason <yuval.bason@marvell.com>
Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/qedr/qedr.h  |  1 +
 drivers/infiniband/hw/qedr/verbs.c | 11 ++++++++---
 include/uapi/rdma/qedr-abi.h       |  4 ++--
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/qedr/qedr.h b/drivers/infiniband/hw/qedr/qedr.h
index aa332027da868..460292179b327 100644
--- a/drivers/infiniband/hw/qedr/qedr.h
+++ b/drivers/infiniband/hw/qedr/qedr.h
@@ -235,6 +235,7 @@ struct qedr_ucontext {
 	u32 dpi_size;
 	u16 dpi;
 	bool db_rec;
+	u8 edpm_mode;
 };
 
 union db_prod32 {
diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index c6355e369a3a3..bddd85e1c8c77 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -275,7 +275,8 @@ int qedr_alloc_ucontext(struct ib_ucontext *uctx, struct ib_udata *udata)
 			DP_ERR(dev, "Problem copying data from user space\n");
 			return -EFAULT;
 		}
-
+		ctx->edpm_mode = !!(ureq.context_flags &
+				    QEDR_ALLOC_UCTX_EDPM_MODE);
 		ctx->db_rec = !!(ureq.context_flags & QEDR_ALLOC_UCTX_DB_REC);
 	}
 
@@ -316,7 +317,8 @@ int qedr_alloc_ucontext(struct ib_ucontext *uctx, struct ib_udata *udata)
 		uresp.dpm_flags = QEDR_DPM_TYPE_IWARP_LEGACY;
 	else
 		uresp.dpm_flags = QEDR_DPM_TYPE_ROCE_ENHANCED |
-				  QEDR_DPM_TYPE_ROCE_LEGACY;
+				  QEDR_DPM_TYPE_ROCE_LEGACY |
+				  QEDR_DPM_TYPE_ROCE_EDPM_MODE;
 
 	uresp.dpm_flags |= QEDR_DPM_SIZES_SET;
 	uresp.ldpm_limit_size = QEDR_LDPM_MAX_SIZE;
@@ -1750,7 +1752,7 @@ static int qedr_create_user_qp(struct qedr_dev *dev,
 	struct qed_rdma_create_qp_out_params out_params;
 	struct qedr_pd *pd = get_qedr_pd(ibpd);
 	struct qedr_create_qp_uresp uresp;
-	struct qedr_ucontext *ctx = NULL;
+	struct qedr_ucontext *ctx = pd ? pd->uctx : NULL;
 	struct qedr_create_qp_ureq ureq;
 	int alloc_and_init = rdma_protocol_roce(&dev->ibdev, 1);
 	int rc = -EINVAL;
@@ -1788,6 +1790,9 @@ static int qedr_create_user_qp(struct qedr_dev *dev,
 		in_params.rq_pbl_ptr = qp->urq.pbl_tbl->pa;
 	}
 
+	if (ctx)
+		SET_FIELD(in_params.flags, QED_ROCE_EDPM_MODE, ctx->edpm_mode);
+
 	qp->qed_qp = dev->ops->rdma_create_qp(dev->rdma_ctx,
 					      &in_params, &out_params);
 
diff --git a/include/uapi/rdma/qedr-abi.h b/include/uapi/rdma/qedr-abi.h
index a0b83c9d4498b..b261c9fca07bb 100644
--- a/include/uapi/rdma/qedr-abi.h
+++ b/include/uapi/rdma/qedr-abi.h
@@ -39,7 +39,7 @@
 
 /* user kernel communication data structures. */
 enum qedr_alloc_ucontext_flags {
-	QEDR_ALLOC_UCTX_RESERVED	= 1 << 0,
+	QEDR_ALLOC_UCTX_EDPM_MODE	= 1 << 0,
 	QEDR_ALLOC_UCTX_DB_REC		= 1 << 1
 };
 
@@ -56,7 +56,7 @@ enum qedr_rdma_dpm_type {
 	QEDR_DPM_TYPE_ROCE_ENHANCED	= 1 << 0,
 	QEDR_DPM_TYPE_ROCE_LEGACY	= 1 << 1,
 	QEDR_DPM_TYPE_IWARP_LEGACY	= 1 << 2,
-	QEDR_DPM_TYPE_RESERVED		= 1 << 3,
+	QEDR_DPM_TYPE_ROCE_EDPM_MODE	= 1 << 3,
 	QEDR_DPM_SIZES_SET		= 1 << 4,
 };
 
-- 
2.25.1



