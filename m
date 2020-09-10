Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA7DC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 17:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E9572087C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 17:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sslab.ics.keio.ac.jp header.i=@sslab.ics.keio.ac.jp header.b="d8XEy/h9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbgIJRPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 13:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbgIJQfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 12:35:01 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CECBC0617AA
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 09:34:59 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id n14so4939871pff.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 09:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sslab.ics.keio.ac.jp; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FaJXhfrjUU4Eb8omzwhQgbkduynoMOFupoGOfbaZ3s0=;
        b=d8XEy/h9aLwc461GtbYpEe6YJG5kQc027sQcQm8cbVphWcNTxqAgmcr9eSuRX9UQQ9
         26gVkQDbm6fPZ7+oet9lRe3ok5l8ezihGzUh4bzHJA63YTEZze9hlwD3/2FlMzV/2BXl
         XuEa2TERzj29I2cbOZy3ofzWAigoEqHbPHn/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FaJXhfrjUU4Eb8omzwhQgbkduynoMOFupoGOfbaZ3s0=;
        b=NujhxqCbFe2x5ADfRchVUhu44aFJliM3ZpBaSS6fzF3jy+HkpuRHVxm2BHZXmmz3XI
         DZBFhYct+q5P6rBOMBw4IpyZIRV8ZM1pcxFBwKOxq3Io7BUjKuqbW16T8bTq2DTlhMgf
         8u+zPGD6sEYvIDFEpGPibU3tQCx5P1/p9emBqW80k95nJ+uBoRHf1zyQRvOGnsbKXoMl
         WelW9IeNVLEFFgq5gmS87eVOZJMVhGl9s45lImIvqZdOgvp9bcCNH/hcqL4W0iFfJ5EB
         v38jD7yH8oaki8Ovu+Tyf5I5uTDm/rEYbnTt1eKuzvmqcDK0o07PpQQJl54wxOE4kKTZ
         Sc+A==
X-Gm-Message-State: AOAM531JX1jH3XusKXaq3Lhk4dWkHdhchMkCTK3pylpMgwzvXUm1eEtM
        1o7ExCr0/Z9I5yXcBk9Hhp3eREmBIhSXslOr7ZY=
X-Google-Smtp-Source: ABdhPJz8+1xKmpNVjR270T+PrLOO0s0m0+KunPLaRqaGMSDDT6h8BgUh8KAPaMIEr504buLU1S6p+Q==
X-Received: by 2002:a63:1402:: with SMTP id u2mr4824306pgl.400.1599755698842;
        Thu, 10 Sep 2020 09:34:58 -0700 (PDT)
Received: from brooklyn.i.sslab.ics.keio.ac.jp (sslab-relay.ics.keio.ac.jp. [131.113.126.173])
        by smtp.googlemail.com with ESMTPSA id x25sm5586983pgk.26.2020.09.10.09.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 09:34:58 -0700 (PDT)
From:   Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
Cc:     keitasuzuki.park@sslab.ics.keio.ac.jp,
        takafumi@sslab.ics.keio.ac.jp,
        Michal Kalderon <mkalderon@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Yuval Bason <yuval.bason@cavium.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] qedr: fix resource leak in qedr_create_qp
Date:   Thu, 10 Sep 2020 16:34:38 +0000
Message-Id: <20200910163438.20495-1-keitasuzuki.park@sslab.ics.keio.ac.jp>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAEYrHj=pfGB7OuHt90t2aaawr31W9XZCHeHJurt3o0rK44jZ+A@mail.gmail.com>
References: <CAEYrHj=pfGB7OuHt90t2aaawr31W9XZCHeHJurt3o0rK44jZ+A@mail.gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When xa_insert() fails, the acquired resource in qedr_create_qp should
also be freed. However, current implementation does not handle the
error.

Fix this by adding a new goto label that calls qedr_free_qp_resources.

Fixes: 1212767e23bb ("qedr: Add wrapping generic structure for qpidr and
adjust idr routines.")
Signed-off-by: Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
---
changelog(v2): Change numbered labels to descriptive labels

 drivers/infiniband/hw/qedr/verbs.c | 52 ++++++++++++++++--------------
 1 file changed, 27 insertions(+), 25 deletions(-)

diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index b49bef94637e..3b4c84f67023 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -2112,6 +2112,28 @@ static int qedr_create_kernel_qp(struct qedr_dev *dev,
 	return rc;
 }
 
+static int qedr_free_qp_resources(struct qedr_dev *dev, struct qedr_qp *qp,
+				  struct ib_udata *udata)
+{
+	struct qedr_ucontext *ctx =
+		rdma_udata_to_drv_context(udata, struct qedr_ucontext,
+					  ibucontext);
+	int rc;
+
+	if (qp->qp_type != IB_QPT_GSI) {
+		rc = dev->ops->rdma_destroy_qp(dev->rdma_ctx, qp->qed_qp);
+		if (rc)
+			return rc;
+	}
+
+	if (qp->create_type == QEDR_QP_CREATE_USER)
+		qedr_cleanup_user(dev, ctx, qp);
+	else
+		qedr_cleanup_kernel(dev, qp);
+
+	return 0;
+}
+
 struct ib_qp *qedr_create_qp(struct ib_pd *ibpd,
 			     struct ib_qp_init_attr *attrs,
 			     struct ib_udata *udata)
@@ -2158,19 +2180,21 @@ struct ib_qp *qedr_create_qp(struct ib_pd *ibpd,
 		rc = qedr_create_kernel_qp(dev, qp, ibpd, attrs);
 
 	if (rc)
-		goto err;
+		goto out_free_qp;
 
 	qp->ibqp.qp_num = qp->qp_id;
 
 	if (rdma_protocol_iwarp(&dev->ibdev, 1)) {
 		rc = xa_insert(&dev->qps, qp->qp_id, qp, GFP_KERNEL);
 		if (rc)
-			goto err;
+			goto out_free_qp_resources;
 	}
 
 	return &qp->ibqp;
 
-err:
+out_free_qp_resources:
+	qedr_free_qp_resources(dev, qp, udata);
+out_free_qp:
 	kfree(qp);
 
 	return ERR_PTR(-EFAULT);
@@ -2671,28 +2695,6 @@ int qedr_query_qp(struct ib_qp *ibqp,
 	return rc;
 }
 
-static int qedr_free_qp_resources(struct qedr_dev *dev, struct qedr_qp *qp,
-				  struct ib_udata *udata)
-{
-	struct qedr_ucontext *ctx =
-		rdma_udata_to_drv_context(udata, struct qedr_ucontext,
-					  ibucontext);
-	int rc;
-
-	if (qp->qp_type != IB_QPT_GSI) {
-		rc = dev->ops->rdma_destroy_qp(dev->rdma_ctx, qp->qed_qp);
-		if (rc)
-			return rc;
-	}
-
-	if (qp->create_type == QEDR_QP_CREATE_USER)
-		qedr_cleanup_user(dev, ctx, qp);
-	else
-		qedr_cleanup_kernel(dev, qp);
-
-	return 0;
-}
-
 int qedr_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 {
 	struct qedr_qp *qp = get_qedr_qp(ibqp);
-- 
2.17.1

