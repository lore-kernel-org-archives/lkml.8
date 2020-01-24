Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B25C32771
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F1792077C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579865129;
	bh=RPzwxGdZF9QySgEMfxCOhhZh9G/v8Z9PCoqv92S5mds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c3m1NjB3YT2Dn4Grq9bONJoNTxKKlVgAKdwOdxRrx+w9ur4/5CGuB/v/E54Hn5RVH
	 cQIxDFlgecm0hGJpI06xIPsmwtUDdzikhitXLNo3wQXModuXkn/2cBg7/oF1GuCSrR
	 3w3DnVwLVxz1rVTiPGcDrjdUzkDVi61OHmAeuESM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391498AbgAXLZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:25:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:39474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391471AbgAXLZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:25:25 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72ACC222C2;
        Fri, 24 Jan 2020 11:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579865124;
        bh=RPzwxGdZF9QySgEMfxCOhhZh9G/v8Z9PCoqv92S5mds=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wxxgv6u6WfdXayFvHift5iJbagSk2VpA6fF3qi56FUFFE96N9CQ5rFn+qFwssjdGH
         /ULdnFEEziU5Wkpld7uSLuXUAVsZX2vyx9m3Rb4MpRSNTGfxTOneZr9X3ovsdnDysc
         O8VE65Y/5EIIoqchrpg6N1Wz89qYc8y2ZbcNIfYY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 460/639] xprtrdma: Fix use-after-free in rpcrdma_post_recvs
Date:   Fri, 24 Jan 2020 10:30:30 +0100
Message-Id: <20200124093144.844734045@linuxfoundation.org>
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

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 2d0abe36cf13fb7b577949fd1539326adddcc9bc ]

Dereference wr->next /before/ the memory backing wr has been
released. This issue was found by code inspection. It is not
expected to be a significant problem because it is in an error
path that is almost never executed.

Fixes: 7c8d9e7c8863 ("xprtrdma: Move Receive posting to ... ")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/xprtrdma/verbs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 90ec322dbbc0f..ef1f3d076af96 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -1558,10 +1558,11 @@ rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, bool temp)
 	rc = ib_post_recv(r_xprt->rx_ia.ri_id->qp, wr,
 			  (const struct ib_recv_wr **)&bad_wr);
 	if (rc) {
-		for (wr = bad_wr; wr; wr = wr->next) {
+		for (wr = bad_wr; wr;) {
 			struct rpcrdma_rep *rep;
 
 			rep = container_of(wr, struct rpcrdma_rep, rr_recv_wr);
+			wr = wr->next;
 			rpcrdma_recv_buffer_put(rep);
 			--count;
 		}
-- 
2.20.1



