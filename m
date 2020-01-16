Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4EAC33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B100E2077B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579202215;
	bh=MGeSLlY5TsMsrM4CMCU6nTzFUKELvmTkU0CYxuigBdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mQ2g/qbHKF49shxD3s/S9NRTnaWo1w0Xio5JvgnJXskbr88Bo5UVWsOQHcnb77Fws
	 +ypzim1edBGXtkN0q5obHnv+wMwHxAGqNrqVPemaQIOsNFb5nzdgjNGseDhLSjhj5L
	 /Na2hN3Advse2Ub0+Dpm4lG7lvSXXevYD2iO8EnM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730741AbgAPQzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:55:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:40666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732866AbgAPQz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:55:26 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B3E0205F4;
        Thu, 16 Jan 2020 16:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579193725;
        bh=MGeSLlY5TsMsrM4CMCU6nTzFUKELvmTkU0CYxuigBdQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oIaJjdIT+k5c3NBwORmIthTI4l2RoDce9vyxmBJsyU4HYmPkMuHJ2Ht+t7l+8rEwm
         GLI0/f0N3DxHhiBFKKfgaOI4CakJNmdE/q0FuDiEYvpLgH9ce0/lw6OrVa2QKl/U4A
         jKCnWAyXQBgGw4oK+rdrLu0cP8dVduDGMfE7GbZY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zhu Yanjun <yanjun.zhu@oracle.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>, linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 019/671] IB/rxe: replace kvfree with vfree
Date:   Thu, 16 Jan 2020 11:44:10 -0500
Message-Id: <20200116165502.8838-19-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116165502.8838-1-sashal@kernel.org>
References: <20200116165502.8838-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@oracle.com>

[ Upstream commit 721ad7e643f7002efa398838693f90284ea216d1 ]

The buf is allocated by vmalloc_user in the function rxe_queue_init.
So it is better to free it by vfree.

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Zhu Yanjun <yanjun.zhu@oracle.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/sw/rxe/rxe_cq.c | 4 ++--
 drivers/infiniband/sw/rxe/rxe_qp.c | 5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c b/drivers/infiniband/sw/rxe/rxe_cq.c
index 2ee4b08b00ea..a57276f2cb84 100644
--- a/drivers/infiniband/sw/rxe/rxe_cq.c
+++ b/drivers/infiniband/sw/rxe/rxe_cq.c
@@ -30,7 +30,7 @@
  * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  * SOFTWARE.
  */
-
+#include <linux/vmalloc.h>
 #include "rxe.h"
 #include "rxe_loc.h"
 #include "rxe_queue.h"
@@ -97,7 +97,7 @@ int rxe_cq_from_init(struct rxe_dev *rxe, struct rxe_cq *cq, int cqe,
 	err = do_mmap_info(rxe, uresp ? &uresp->mi : NULL, context,
 			   cq->queue->buf, cq->queue->buf_size, &cq->queue->ip);
 	if (err) {
-		kvfree(cq->queue->buf);
+		vfree(cq->queue->buf);
 		kfree(cq->queue);
 		return err;
 	}
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index c58452daffc7..230697fa31fe 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -34,6 +34,7 @@
 #include <linux/skbuff.h>
 #include <linux/delay.h>
 #include <linux/sched.h>
+#include <linux/vmalloc.h>
 
 #include "rxe.h"
 #include "rxe_loc.h"
@@ -247,7 +248,7 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
 			   &qp->sq.queue->ip);
 
 	if (err) {
-		kvfree(qp->sq.queue->buf);
+		vfree(qp->sq.queue->buf);
 		kfree(qp->sq.queue);
 		return err;
 	}
@@ -300,7 +301,7 @@ static int rxe_qp_init_resp(struct rxe_dev *rxe, struct rxe_qp *qp,
 				   qp->rq.queue->buf, qp->rq.queue->buf_size,
 				   &qp->rq.queue->ip);
 		if (err) {
-			kvfree(qp->rq.queue->buf);
+			vfree(qp->rq.queue->buf);
 			kfree(qp->rq.queue);
 			return err;
 		}
-- 
2.20.1

