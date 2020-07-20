Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6B0C433F1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D65D20656
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595261974;
	bh=szj5pF3Hu8+fMoUbth9HWWOwyoot+TTZu6n6IlqCFgA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gXReszyDlVOCzACLmuUsZoLSAROqKmMgGdnmPNqlRMwVYqOjLgs0Q2fgD1K5NBsPw
	 CpGS75cMnT8qTrCkfxp9RS6rRoiQX6oE8SBke20IB9sTQDDJBYhBHV+c2LGQeGPybV
	 wV1BoIfdpDHuLwxpo9MWTl6d2y9Eu0YQVK7BIcDA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387892AbgGTQMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:12:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:51132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387864AbgGTQLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:11:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8E422064B;
        Mon, 20 Jul 2020 16:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261511;
        bh=szj5pF3Hu8+fMoUbth9HWWOwyoot+TTZu6n6IlqCFgA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xrphnxRmWSEBRoTjVsmzjaPgf6m23xbv02DoQSnwU+Cjy1VnaouXXWdFYP5K34Lvn
         UjOexpUYAn5S56pzrmtwzHsaDcQUiR3mJusYuIi7Ks3gtuDsfQdNH32iD9bN099VPf
         2XiPvwt9fbYD0n8smRgYkpy2VY5hBYgLkBUo6W8k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 111/244] xprtrdma: fix incorrect header size calculations
Date:   Mon, 20 Jul 2020 17:36:22 +0200
Message-Id: <20200720152831.115840305@linuxfoundation.org>
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

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit 912288442cb2f431bf3c8cb097a5de83bc6dbac1 ]

Currently the header size calculations are using an assignment
operator instead of a += operator when accumulating the header
size leading to incorrect sizes.  Fix this by using the correct
operator.

Addresses-Coverity: ("Unused value")
Fixes: 302d3deb2068 ("xprtrdma: Prevent inline overflow")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/xprtrdma/rpc_rdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index 57118e342c8eb..06a8268edf3b4 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -71,7 +71,7 @@ static unsigned int rpcrdma_max_call_header_size(unsigned int maxsegs)
 	size = RPCRDMA_HDRLEN_MIN;
 
 	/* Maximum Read list size */
-	size = maxsegs * rpcrdma_readchunk_maxsz * sizeof(__be32);
+	size += maxsegs * rpcrdma_readchunk_maxsz * sizeof(__be32);
 
 	/* Minimal Read chunk size */
 	size += sizeof(__be32);	/* segment count */
@@ -94,7 +94,7 @@ static unsigned int rpcrdma_max_reply_header_size(unsigned int maxsegs)
 	size = RPCRDMA_HDRLEN_MIN;
 
 	/* Maximum Write list size */
-	size = sizeof(__be32);		/* segment count */
+	size += sizeof(__be32);		/* segment count */
 	size += maxsegs * rpcrdma_segment_maxsz * sizeof(__be32);
 	size += sizeof(__be32);	/* list discriminator */
 
-- 
2.25.1



