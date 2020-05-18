Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E654EC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD46F20715
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589824711;
	bh=SaX49qfGwTNFGoVpFnGMa04LewjALtVS9R49yIOfXvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RfBGHQ7tVuUFG8Jl0dkRiHvVBESuxXrZNSXTN4p6USp4noHrZmwNCkDN3tH6aBpbL
	 ZI0UPoo2hhq1k6sDrC5Dzt9bN1q1JaUrEG0juxbOQ+pUnXgw7+I7NBYe1segavh16W
	 WEu1KT52V6wwUISx1z50PGS0cGebncQ0PwHe7AcI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731915AbgERR6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:58:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:37880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731902AbgERR61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:58:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8E3620715;
        Mon, 18 May 2020 17:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589824707;
        bh=SaX49qfGwTNFGoVpFnGMa04LewjALtVS9R49yIOfXvY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NnuBk+AxtPClKfnFDUTvBWw0TEJxrUVFCMHqoSfR1OyGGWylAQcIoP4RocJbdMrV9
         +RVNcmyF3M0tXpTAgWPBIiKMTmxzwlv63sQqcIm7Fs2jCzAESXpUHoAPafPCx2J9rN
         6IKv2C2LNMNLL+UPvz9piQwvfRDgAd6nxeiEwv84=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 081/147] SUNRPC: Signalled ASYNC tasks need to exit
Date:   Mon, 18 May 2020 19:36:44 +0200
Message-Id: <20200518173523.780014614@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173513.009514388@linuxfoundation.org>
References: <20200518173513.009514388@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit ce99aa62e1eb793e259d023c7f6ccb7c4879917b ]

Ensure that signalled ASYNC rpc_tasks exit immediately instead of
spinning until a timeout (or forever).

To avoid checking for the signal flag on every scheduler iteration,
the check is instead introduced in the client's finite state
machine.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Fixes: ae67bd3821bb ("SUNRPC: Fix up task signalling")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/clnt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index f7f78566be463..f1088ca39d44c 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2422,6 +2422,11 @@ rpc_check_timeout(struct rpc_task *task)
 {
 	struct rpc_clnt	*clnt = task->tk_client;
 
+	if (RPC_SIGNALLED(task)) {
+		rpc_call_rpcerror(task, -ERESTARTSYS);
+		return;
+	}
+
 	if (xprt_adjust_timeout(task->tk_rqstp) == 0)
 		return;
 
-- 
2.20.1



