Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3A2C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 12:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 792FF20786
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 12:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598443509;
	bh=qEUBPgWgjWF0Gc0SRUEsBtJRhQzYGp9MrUrb9t2w3r0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zrVTMBIVFKHHGga7Uw6KTw6odwfXHlQWwec8wzSX0xBqmPgJqyFm0FWWo6t6ayJof
	 u1y9W6wQJc6y53g1GCREb4ppJRNAzWEzJN/mHRzVBNRBZzk6ZUsl/RU2BOsXKob2xE
	 bZL96Aqu77xVQU80yeDtbtBWeFJH5CtJBnHCTmEg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729681AbgHZMFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 08:05:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:39274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729561AbgHZMDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 08:03:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F4892087D;
        Wed, 26 Aug 2020 12:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598443429;
        bh=qEUBPgWgjWF0Gc0SRUEsBtJRhQzYGp9MrUrb9t2w3r0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1amu0VfyW0LpwkF0b+cY39pYJv6ihV5k+X0c7da7cWyQrtC8/ZQh4MxkPyvNve3Po
         CsoBYNS6TJS34vC9YS7xpmyAXy2ev5t3bXafcWQxk6f4Tfsm7gO+QTCC14VwwDxWbi
         TLMw2pIzpgjegF3obyAh3gutvbeylU+IqhzWx2Nw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Ursula Braun <ubraun@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.8 07/16] net/smc: Prevent kernel-infoleak in __smc_diag_dump()
Date:   Wed, 26 Aug 2020 14:02:44 +0200
Message-Id: <20200826114911.583260809@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200826114911.216745274@linuxfoundation.org>
References: <20200826114911.216745274@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peilin Ye <yepeilin.cs@gmail.com>

[ Upstream commit ce51f63e63c52a4e1eee4dd040fb0ba0af3b43ab ]

__smc_diag_dump() is potentially copying uninitialized kernel stack memory
into socket buffers, since the compiler may leave a 4-byte hole near the
beginning of `struct smcd_diag_dmbinfo`. Fix it by initializing `dinfo`
with memset().

Fixes: 4b1b7d3b30a6 ("net/smc: add SMC-D diag support")
Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/smc/smc_diag.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

--- a/net/smc/smc_diag.c
+++ b/net/smc/smc_diag.c
@@ -170,13 +170,15 @@ static int __smc_diag_dump(struct sock *
 	    (req->diag_ext & (1 << (SMC_DIAG_DMBINFO - 1))) &&
 	    !list_empty(&smc->conn.lgr->list)) {
 		struct smc_connection *conn = &smc->conn;
-		struct smcd_diag_dmbinfo dinfo = {
-			.linkid = *((u32 *)conn->lgr->id),
-			.peer_gid = conn->lgr->peer_gid,
-			.my_gid = conn->lgr->smcd->local_gid,
-			.token = conn->rmb_desc->token,
-			.peer_token = conn->peer_token
-		};
+		struct smcd_diag_dmbinfo dinfo;
+
+		memset(&dinfo, 0, sizeof(dinfo));
+
+		dinfo.linkid = *((u32 *)conn->lgr->id);
+		dinfo.peer_gid = conn->lgr->peer_gid;
+		dinfo.my_gid = conn->lgr->smcd->local_gid;
+		dinfo.token = conn->rmb_desc->token;
+		dinfo.peer_token = conn->peer_token;
 
 		if (nla_put(skb, SMC_DIAG_DMBINFO, sizeof(dinfo), &dinfo) < 0)
 			goto errout;


