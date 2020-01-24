Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5E0C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E998121556
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579859040;
	bh=Sl395GrVpGDGaZ2/F4Y7NMHYq0j3IKh1E0LH4WAT5aM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XWdTml6Ie26pWVPEJ/OBUjtUoUp01Bdf3NdSZqPtB2cELQyOdazgPntIQYBXcS53a
	 q9fKn+noA8WmIYiYyshkZtyQE/wGsBPrx061YL9OKMx0XFwAUJeQ05ZPxy9mbkOe2H
	 jAqdIjKFG+liU8wYBzwN1ZMBHc7Xw4b7Nmlm0ML8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733253AbgAXJn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:43:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:42130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733222AbgAXJn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:43:56 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5517121569;
        Fri, 24 Jan 2020 09:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579859036;
        bh=Sl395GrVpGDGaZ2/F4Y7NMHYq0j3IKh1E0LH4WAT5aM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WBfQuhH7ZA4dNdxuBICX5FafTgpd3w3ndE435qE0l8ZVmcPeZV0079U+sRT4YOJOB
         tcKAeUJTo8mO0dgmZCJl1LEQ3m5H51vLpzfZv1kqaNe4/hOBg4TigvvSZhr21mZHL3
         zIl1wh7uUnFGpjLhhHN4ugO93KhwPJLfr9LRaefQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Leon Romanovsky <leonro@mellanox.com>,
        Zhu Yanjun <yanjun.zhu@oracle.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 014/343] IB/rxe: replace kvfree with vfree
Date:   Fri, 24 Jan 2020 10:27:12 +0100
Message-Id: <20200124092921.505024770@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092919.490687572@linuxfoundation.org>
References: <20200124092919.490687572@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index c4aabf78dc90f..f6e036ded046e 100644
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
 	err = do_mmap_info(rxe, udata, false, context, cq->queue->buf,
 			   cq->queue->buf_size, &cq->queue->ip);
 	if (err) {
-		kvfree(cq->queue->buf);
+		vfree(cq->queue->buf);
 		kfree(cq->queue);
 		return err;
 	}
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index aeea994b04c43..25055a68a2c07 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -34,6 +34,7 @@
 #include <linux/skbuff.h>
 #include <linux/delay.h>
 #include <linux/sched.h>
+#include <linux/vmalloc.h>
 
 #include "rxe.h"
 #include "rxe_loc.h"
@@ -255,7 +256,7 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
 			   qp->sq.queue->buf_size, &qp->sq.queue->ip);
 
 	if (err) {
-		kvfree(qp->sq.queue->buf);
+		vfree(qp->sq.queue->buf);
 		kfree(qp->sq.queue);
 		return err;
 	}
@@ -308,7 +309,7 @@ static int rxe_qp_init_resp(struct rxe_dev *rxe, struct rxe_qp *qp,
 				   qp->rq.queue->buf_size,
 				   &qp->rq.queue->ip);
 		if (err) {
-			kvfree(qp->rq.queue->buf);
+			vfree(qp->rq.queue->buf);
 			kfree(qp->rq.queue);
 			return err;
 		}
-- 
2.20.1



