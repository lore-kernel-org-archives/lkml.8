Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD56C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D34B120663
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579218358;
	bh=N+pHv9iNfYcczbHiSnRpCzmFaRtbwA/tRoVCtCPRY8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pR9FgZES9pCjTYFR6+SPIfurN7JK+j+/aqToCTNPmDK2O9czxXhoIEd7t4R4yzPKh
	 +5f++ljd65czTvqGGLmxkLM0Ke6kgUh7//13tDTURKhxd07wL0Wm555KlSFURk1p3W
	 SC7TZ5A0rP0n97jZU7x+88QU5uNt7Yht4CwLXMAc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391948AbgAPXp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:45:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:50342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733127AbgAPXWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:22:30 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39385206D9;
        Thu, 16 Jan 2020 23:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579216949;
        bh=N+pHv9iNfYcczbHiSnRpCzmFaRtbwA/tRoVCtCPRY8Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w/uGgWHeDomdknn4jUyZ87qctxTb2O4cqlksKarr+5BjhCAiQIB/2kYbW6uViq9Zj
         aXSJmSlHD0IqyrGH/aYhNRuz537DNkRNIT55ekbcnrhnyOT+p+pbcR9dk98pKNbf+0
         ItC1ADyB8d05yK+wS75x+iSDc6ck7aqxy56R9RW4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Subject: [PATCH 5.4 070/203] xprtrdma: Fix MR list handling
Date:   Fri, 17 Jan 2020 00:16:27 +0100
Message-Id: <20200116231750.261620516@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231745.218684830@linuxfoundation.org>
References: <20200116231745.218684830@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

commit c3700780a096fc66467c81076ddf7f3f11d639b5 upstream.

Close some holes introduced by commit 6dc6ec9e04c4 ("xprtrdma: Cache
free MRs in each rpcrdma_req") that could result in list corruption.

In addition, the result that is tabulated in @count is no longer
used, so @count is removed.

Fixes: 6dc6ec9e04c4 ("xprtrdma: Cache free MRs in each rpcrdma_req")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/sunrpc/xprtrdma/verbs.c |   41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -79,7 +79,6 @@ static void rpcrdma_reqs_reset(struct rp
 static void rpcrdma_reps_destroy(struct rpcrdma_buffer *buf);
 static void rpcrdma_mrs_create(struct rpcrdma_xprt *r_xprt);
 static void rpcrdma_mrs_destroy(struct rpcrdma_buffer *buf);
-static void rpcrdma_mr_free(struct rpcrdma_mr *mr);
 static struct rpcrdma_regbuf *
 rpcrdma_regbuf_alloc(size_t size, enum dma_data_direction direction,
 		     gfp_t flags);
@@ -967,7 +966,7 @@ rpcrdma_mrs_create(struct rpcrdma_xprt *
 		mr->mr_xprt = r_xprt;
 
 		spin_lock(&buf->rb_lock);
-		list_add(&mr->mr_list, &buf->rb_mrs);
+		rpcrdma_mr_push(mr, &buf->rb_mrs);
 		list_add(&mr->mr_all, &buf->rb_all_mrs);
 		spin_unlock(&buf->rb_lock);
 	}
@@ -1185,10 +1184,19 @@ out:
  */
 void rpcrdma_req_destroy(struct rpcrdma_req *req)
 {
+	struct rpcrdma_mr *mr;
+
 	list_del(&req->rl_all);
 
-	while (!list_empty(&req->rl_free_mrs))
-		rpcrdma_mr_free(rpcrdma_mr_pop(&req->rl_free_mrs));
+	while ((mr = rpcrdma_mr_pop(&req->rl_free_mrs))) {
+		struct rpcrdma_buffer *buf = &mr->mr_xprt->rx_buf;
+
+		spin_lock(&buf->rb_lock);
+		list_del(&mr->mr_all);
+		spin_unlock(&buf->rb_lock);
+
+		frwr_release_mr(mr);
+	}
 
 	rpcrdma_regbuf_free(req->rl_recvbuf);
 	rpcrdma_regbuf_free(req->rl_sendbuf);
@@ -1196,24 +1204,28 @@ void rpcrdma_req_destroy(struct rpcrdma_
 	kfree(req);
 }
 
-static void
-rpcrdma_mrs_destroy(struct rpcrdma_buffer *buf)
+/**
+ * rpcrdma_mrs_destroy - Release all of a transport's MRs
+ * @buf: controlling buffer instance
+ *
+ * Relies on caller holding the transport send lock to protect
+ * removing mr->mr_list from req->rl_free_mrs safely.
+ */
+static void rpcrdma_mrs_destroy(struct rpcrdma_buffer *buf)
 {
 	struct rpcrdma_xprt *r_xprt = container_of(buf, struct rpcrdma_xprt,
 						   rx_buf);
 	struct rpcrdma_mr *mr;
-	unsigned int count;
 
-	count = 0;
 	spin_lock(&buf->rb_lock);
 	while ((mr = list_first_entry_or_null(&buf->rb_all_mrs,
 					      struct rpcrdma_mr,
 					      mr_all)) != NULL) {
+		list_del(&mr->mr_list);
 		list_del(&mr->mr_all);
 		spin_unlock(&buf->rb_lock);
 
 		frwr_release_mr(mr);
-		count++;
 		spin_lock(&buf->rb_lock);
 	}
 	spin_unlock(&buf->rb_lock);
@@ -1286,17 +1298,6 @@ void rpcrdma_mr_put(struct rpcrdma_mr *m
 	rpcrdma_mr_push(mr, &mr->mr_req->rl_free_mrs);
 }
 
-static void rpcrdma_mr_free(struct rpcrdma_mr *mr)
-{
-	struct rpcrdma_xprt *r_xprt = mr->mr_xprt;
-	struct rpcrdma_buffer *buf = &r_xprt->rx_buf;
-
-	mr->mr_req = NULL;
-	spin_lock(&buf->rb_lock);
-	rpcrdma_mr_push(mr, &buf->rb_mrs);
-	spin_unlock(&buf->rb_lock);
-}
-
 /**
  * rpcrdma_buffer_get - Get a request buffer
  * @buffers: Buffer pool from which to obtain a buffer


