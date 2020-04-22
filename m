Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6F8C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B4D02076C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587550100;
	bh=TF/01RNQtNtjrq6KbrU+2FAcLCzjC1oerULda68YHj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=euekxNi63uVeBQXiLh/vw2ocxvd06HNErUhM8BtF6GxCr49Yjdhbt7yqbWp1abSvh
	 q/Mpr7geXRkxmWd6CLhmxeaRcDYK9xMNngQ0MfHYH/97nOOwaKdVK1kWcufYjOqnmq
	 QBNuNI2+FGRvb7bVNso9RQWFSdQl05hEI3ujPmI8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbgDVKIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:08:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:33400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726596AbgDVKIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:08:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 928F52077D;
        Wed, 22 Apr 2020 10:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550094;
        bh=TF/01RNQtNtjrq6KbrU+2FAcLCzjC1oerULda68YHj4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hm8mr3vwcH0PrpiGEL4YyV1EKdp+HXbmRyMKj07WHPuNjKa+po7MI2nRLuKsjB+Hz
         doGZ3wtY8W6VLNeYh7DpRWub7r0a2mEnerwFJp8lf0g0xwE0G9/oXwXHVt2mL6j6Ty
         +ixGwUpcJUPspBWqoRUBVcHc5+sF+l1hHiyqL7QE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 106/125] NFS: direct.c: Fix memory leak of dreq when nfs_get_lock_context fails
Date:   Wed, 22 Apr 2020 11:57:03 +0200
Message-Id: <20200422095049.996928532@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095032.909124119@linuxfoundation.org>
References: <20200422095032.909124119@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>

[ Upstream commit 8605cf0e852af3b2c771c18417499dc4ceed03d5 ]

When dreq is allocated by nfs_direct_req_alloc(), dreq->kref is
initialized to 2. Therefore we need to call nfs_direct_req_release()
twice to release the allocated dreq. Usually it is called in
nfs_file_direct_{read, write}() and nfs_direct_complete().

However, current code only calls nfs_direct_req_relese() once if
nfs_get_lock_context() fails in nfs_file_direct_{read, write}().
So, that case would result in memory leak.

Fix this by adding the missing call.

Signed-off-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/direct.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 53f0012ace42f..de135d2591ffb 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -595,6 +595,7 @@ ssize_t nfs_file_direct_read(struct kiocb *iocb, struct iov_iter *iter)
 	l_ctx = nfs_get_lock_context(dreq->ctx);
 	if (IS_ERR(l_ctx)) {
 		result = PTR_ERR(l_ctx);
+		nfs_direct_req_release(dreq);
 		goto out_release;
 	}
 	dreq->l_ctx = l_ctx;
@@ -1019,6 +1020,7 @@ ssize_t nfs_file_direct_write(struct kiocb *iocb, struct iov_iter *iter)
 	l_ctx = nfs_get_lock_context(dreq->ctx);
 	if (IS_ERR(l_ctx)) {
 		result = PTR_ERR(l_ctx);
+		nfs_direct_req_release(dreq);
 		goto out_release;
 	}
 	dreq->l_ctx = l_ctx;
-- 
2.20.1



