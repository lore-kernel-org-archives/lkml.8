Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C87DC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 307B222464
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579863651;
	bh=1NsGV94png0klvDL1K/LNL6Q3FdShQSloHuWw/2IpDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n28+nhOWjjg34dyqP/7UuDQ7STcV7im+ra8598uasd9mbYHzQ3B5mpN6QSdMBR63c
	 0JVvH2Rz418Jut9LLjB1AIiFrIh948JvT+7nKgSYtImNyrZIXHmUehZnjBcVKuwjlQ
	 fU0tfiCXROmZBnlMzuZSe4vsQig7xdG2sN+btdXU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387419AbgAXLAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:00:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:60910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733286AbgAXLAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:00:46 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 799612071A;
        Fri, 24 Jan 2020 11:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579863646;
        bh=1NsGV94png0klvDL1K/LNL6Q3FdShQSloHuWw/2IpDg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t94HsM/r2o7bPJ7uhNt5VQz69UXz58xEXVn+L7FYITCHil0l60CK8fu46n1sCq6MZ
         DyW5PrGBdjR1QiYpJWIgpxz+p4HyXh9d1rUF+9c4d1e9p3EqBGEn/gPtB8w8x3ngCr
         U74upd/ExZLtuYXo5lkXZFuoT5fn3Ve8xbqv/NHk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Leon Romanovsky <leonro@mellanox.com>,
        Zhu Yanjun <yanjun.zhu@oracle.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 036/639] IB/rxe: replace kvfree with vfree
Date:   Fri, 24 Jan 2020 10:23:26 +0100
Message-Id: <20200124093051.966032768@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
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
index 2ee4b08b00ea4..a57276f2cb849 100644
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
index c58452daffc74..230697fa31fe3 100644
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



