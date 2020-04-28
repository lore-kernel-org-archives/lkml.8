Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF04EC83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C0B92085B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588098873;
	bh=btOVB0RLFuHhmGmdNI83TsUryhSAp6OgTUHhyiHbk98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wdzWr7hV0nSjYXdVCDeqE0F3P3mImGzkoXGleVd3T661bAf9Cimh3XVzzSXas85ik
	 oRltmqiB9Q/J0/oNCwbvixNSb1BZwkQn7ZGhbgcMV0+cmjytebTm5NhT9xK5nln7jp
	 LMvX00v/RhyQ+wQT5sUn5F2Yz12EtSPjoR5H/Ctg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730055AbgD1Sec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:34:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:51188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730137AbgD1Se1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:34:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B1E621707;
        Tue, 28 Apr 2020 18:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588098866;
        bh=btOVB0RLFuHhmGmdNI83TsUryhSAp6OgTUHhyiHbk98=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ROrD2kjzvo2P7Sryqhl4tknFicZ13YzWqqJN0PyqybKBxY2AEN8P7vQ0W5xN4QXdo
         AGs6zvMqm78eec6a1lM00zZPCYE8I14Mp4u6CgSIeRTzbxm3xMbPoujebU5IwCuQPN
         IjLNRlEAYZann0EQx0eqrR4rRf7vwRNFxNA8Dbk0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Trond Myklebust <trondmy@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 5.6 122/167] SUNRPC: Fix backchannel RPC soft lockups
Date:   Tue, 28 Apr 2020 20:24:58 +0200
Message-Id: <20200428182240.699650773@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182225.451225420@linuxfoundation.org>
References: <20200428182225.451225420@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

commit 6221f1d9b63fed6260273e59a2b89ab30537a811 upstream.

Currently, after the forward channel connection goes away,
backchannel operations are causing soft lockups on the server
because call_transmit_status's SOFTCONN logic ignores ENOTCONN.
Such backchannel Calls are aggressively retried until the client
reconnects.

Backchannel Calls should use RPC_TASK_NOCONNECT rather than
RPC_TASK_SOFTCONN. If there is no forward connection, the server is
not capable of establishing a connection back to the client, thus
that backchannel request should fail before the server attempts to
send it. Commit 58255a4e3ce5 ("NFSD: NFSv4 callback client should
use RPC_TASK_SOFTCONN") was merged several years before
RPC_TASK_NOCONNECT was available.

Because setup_callback_client() explicitly sets NOPING, the NFSv4.0
callback connection depends on the first callback RPC to initiate
a connection to the client. Thus NFSv4.0 needs to continue to use
RPC_TASK_SOFTCONN.

Suggested-by: Trond Myklebust <trondmy@hammerspace.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Cc: <stable@vger.kernel.org> # v4.20+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfsd/nfs4callback.c                     |    4 +++-
 net/sunrpc/svc_xprt.c                      |    2 ++
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c |    2 ++
 net/sunrpc/xprtsock.c                      |    1 +
 4 files changed, 8 insertions(+), 1 deletion(-)

--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1312,6 +1312,7 @@ nfsd4_run_cb_work(struct work_struct *wo
 		container_of(work, struct nfsd4_callback, cb_work);
 	struct nfs4_client *clp = cb->cb_clp;
 	struct rpc_clnt *clnt;
+	int flags;
 
 	if (cb->cb_need_restart) {
 		cb->cb_need_restart = false;
@@ -1340,7 +1341,8 @@ nfsd4_run_cb_work(struct work_struct *wo
 	}
 
 	cb->cb_msg.rpc_cred = clp->cl_cb_cred;
-	rpc_call_async(clnt, &cb->cb_msg, RPC_TASK_SOFT | RPC_TASK_SOFTCONN,
+	flags = clp->cl_minorversion ? RPC_TASK_NOCONNECT : RPC_TASK_SOFTCONN;
+	rpc_call_async(clnt, &cb->cb_msg, RPC_TASK_SOFT | flags,
 			cb->cb_ops ? &nfsd4_cb_ops : &nfsd4_cb_probe_ops, cb);
 }
 
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -1028,6 +1028,8 @@ static void svc_delete_xprt(struct svc_x
 
 	dprintk("svc: svc_delete_xprt(%p)\n", xprt);
 	xprt->xpt_ops->xpo_detach(xprt);
+	if (xprt->xpt_bc_xprt)
+		xprt->xpt_bc_xprt->ops->close(xprt->xpt_bc_xprt);
 
 	spin_lock_bh(&serv->sv_lock);
 	list_del_init(&xprt->xpt_list);
--- a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
@@ -242,6 +242,8 @@ static void
 xprt_rdma_bc_close(struct rpc_xprt *xprt)
 {
 	dprintk("svcrdma: %s: xprt %p\n", __func__, xprt);
+
+	xprt_disconnect_done(xprt);
 	xprt->cwnd = RPC_CWNDSHIFT;
 }
 
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2714,6 +2714,7 @@ static int bc_send_request(struct rpc_rq
 
 static void bc_close(struct rpc_xprt *xprt)
 {
+	xprt_disconnect_done(xprt);
 }
 
 /*


