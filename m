Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02456C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D62BA2078C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588615907;
	bh=tTx+X6ofM/0dXOC1QY/hOoerybTx5eC+WY95hSicXC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mxlWVx9jSJCkq8PxOI7rpmAgS1Y07eekhohScB5bYKE0gWB15VwjfWNXtbwJOCkS7
	 T4CIDS+70bvCYVR2MzJ9Hz7OAcNE0wk4/mYewCD49+wJ4Uvye5GphN9Ul6hSxGb574
	 UZSYPpOCtamNoC59QSL2i9EZVcOHWksXK6ySG7og=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732226AbgEDSLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 14:11:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:32896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730975AbgEDSDs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 14:03:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90A3520707;
        Mon,  4 May 2020 18:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588615428;
        bh=tTx+X6ofM/0dXOC1QY/hOoerybTx5eC+WY95hSicXC4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ut2FRucAC9GScW9e61iNzQg9pmULyfaIkkEsYA7qzPl0lBITGqJ423zVXxE+Kgrsq
         G70v9rCNzfiMp5jYECilT8+bE+A40GCfZT1ctuI4Gd8GL5sOPuiNocADIcEuS6wxoR
         TmjQ3Fx7xpTT3RFA4cVpwxJ9qn0XO3DR2uiQkxH4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 5.4 27/57] IB/rdmavt: Always return ERR_PTR from rvt_create_mmap_info()
Date:   Mon,  4 May 2020 19:57:31 +0200
Message-Id: <20200504165458.696080500@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504165456.783676004@linuxfoundation.org>
References: <20200504165456.783676004@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

commit 47c370c1a5eea9b2f6f026d49e060c3748c89667 upstream.

The commit below modified rvt_create_mmap_info() to return ERR_PTR's but
didn't update the callers to handle them. Modify rvt_create_mmap_info() to
only return ERR_PTR and fix all error checking after
rvt_create_mmap_info() was called.

Fixes: ff23dfa13457 ("IB: Pass only ib_udata in function prototypes")
Link: https://lore.kernel.org/r/20200424173146.10970-1-sudipm.mukherjee@gmail.com
Cc: stable@vger.kernel.org [5.4+]
Tested-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Acked-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/sw/rdmavt/cq.c   |    4 ++--
 drivers/infiniband/sw/rdmavt/mmap.c |    4 ++--
 drivers/infiniband/sw/rdmavt/qp.c   |    4 ++--
 drivers/infiniband/sw/rdmavt/srq.c  |    4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

--- a/drivers/infiniband/sw/rdmavt/cq.c
+++ b/drivers/infiniband/sw/rdmavt/cq.c
@@ -248,8 +248,8 @@ int rvt_create_cq(struct ib_cq *ibcq, co
 	 */
 	if (udata && udata->outlen >= sizeof(__u64)) {
 		cq->ip = rvt_create_mmap_info(rdi, sz, udata, u_wc);
-		if (!cq->ip) {
-			err = -ENOMEM;
+		if (IS_ERR(cq->ip)) {
+			err = PTR_ERR(cq->ip);
 			goto bail_wc;
 		}
 
--- a/drivers/infiniband/sw/rdmavt/mmap.c
+++ b/drivers/infiniband/sw/rdmavt/mmap.c
@@ -154,7 +154,7 @@ done:
  * @udata: user data (must be valid!)
  * @obj: opaque pointer to a cq, wq etc
  *
- * Return: rvt_mmap struct on success
+ * Return: rvt_mmap struct on success, ERR_PTR on failure
  */
 struct rvt_mmap_info *rvt_create_mmap_info(struct rvt_dev_info *rdi, u32 size,
 					   struct ib_udata *udata, void *obj)
@@ -166,7 +166,7 @@ struct rvt_mmap_info *rvt_create_mmap_in
 
 	ip = kmalloc_node(sizeof(*ip), GFP_KERNEL, rdi->dparms.node);
 	if (!ip)
-		return ip;
+		return ERR_PTR(-ENOMEM);
 
 	size = PAGE_ALIGN(size);
 
--- a/drivers/infiniband/sw/rdmavt/qp.c
+++ b/drivers/infiniband/sw/rdmavt/qp.c
@@ -1244,8 +1244,8 @@ struct ib_qp *rvt_create_qp(struct ib_pd
 
 			qp->ip = rvt_create_mmap_info(rdi, s, udata,
 						      qp->r_rq.wq);
-			if (!qp->ip) {
-				ret = ERR_PTR(-ENOMEM);
+			if (IS_ERR(qp->ip)) {
+				ret = ERR_CAST(qp->ip);
 				goto bail_qpn;
 			}
 
--- a/drivers/infiniband/sw/rdmavt/srq.c
+++ b/drivers/infiniband/sw/rdmavt/srq.c
@@ -111,8 +111,8 @@ int rvt_create_srq(struct ib_srq *ibsrq,
 		u32 s = sizeof(struct rvt_rwq) + srq->rq.size * sz;
 
 		srq->ip = rvt_create_mmap_info(dev, s, udata, srq->rq.wq);
-		if (!srq->ip) {
-			ret = -ENOMEM;
+		if (IS_ERR(srq->ip)) {
+			ret = PTR_ERR(srq->ip);
 			goto bail_wq;
 		}
 


