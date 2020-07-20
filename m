Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95087C43445
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AA1820684
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595262027;
	bh=S+GbvqvYd5DQbyfyZrnVh7vsVEAGDL8ps5qUlMo54eQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1iFpsSH3Cd1z3XqthZLqobWCuG3lxK1a8iP3477BZPtxzXfJG9gKGpZZS0Q2mLkrS
	 SnPEY4lu2tgdd0lQLcEK67LLSbBEduhzMiHD0OAZl56j+T4Ez+n0f2ZZMuCpJhqmLW
	 GxDgCI/gn7vvlEzWwPjt+WTGjA7gHdBJncW7LpnQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387632AbgGTQKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:10:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:48366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387618AbgGTQKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:10:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A33AB20734;
        Mon, 20 Jul 2020 16:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261406;
        bh=S+GbvqvYd5DQbyfyZrnVh7vsVEAGDL8ps5qUlMo54eQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CgzGUYfyPwULE9TA8FWLSbPHV/M/AFv4CBGE4UUmOaxqAwAwblgpMcx27w2CGKLOh
         wW83J2dzPvmJIuHcobb5d0LyHnp7O+GcFFn14101H1hRRgluO0klQp2jPuFeelMHi6
         5aWQf+DF0AIcdqFTtj28GVOKH+4XTWaH/0bJb6Ms=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 103/244] xprtrdma: Fix double-free in rpcrdma_ep_create()
Date:   Mon, 20 Jul 2020 17:36:14 +0200
Message-Id: <20200720152830.728589241@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152825.863040590@linuxfoundation.org>
References: <20200720152825.863040590@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 85bfd71bc34e20d9fadb745131f6314c36d0f75b ]

In the error paths, there's no need to call kfree(ep) after calling
rpcrdma_ep_put(ep).

Fixes: e28ce90083f0 ("xprtrdma: kmalloc rpcrdma_ep separate from rpcrdma_xprt")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/xprtrdma/verbs.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index db0259c6467ef..4cb91dde849b9 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -404,8 +404,8 @@ static int rpcrdma_ep_create(struct rpcrdma_xprt *r_xprt)
 
 	id = rpcrdma_create_id(r_xprt, ep);
 	if (IS_ERR(id)) {
-		rc = PTR_ERR(id);
-		goto out_free;
+		kfree(ep);
+		return PTR_ERR(id);
 	}
 	__module_get(THIS_MODULE);
 	device = id->device;
@@ -504,9 +504,6 @@ static int rpcrdma_ep_create(struct rpcrdma_xprt *r_xprt)
 out_destroy:
 	rpcrdma_ep_put(ep);
 	rdma_destroy_id(id);
-out_free:
-	kfree(ep);
-	r_xprt->rx_ep = NULL;
 	return rc;
 }
 
-- 
2.25.1



