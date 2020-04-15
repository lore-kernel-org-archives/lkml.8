Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D6C1C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EEC7206F9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586952339;
	bh=TF/01RNQtNtjrq6KbrU+2FAcLCzjC1oerULda68YHj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KBcDFihRZS78Pp/q+TjjBhnm8Lx+/0/YSREJhrEwWqOcvh9WSKOtuHTHos7aQYG6R
	 FxfqjVdpZ29itFF3LhMCOJf52V5rCsK2Bq24UV4huhcRuiohRLel5NJChbiJcUVK/g
	 1rlaTb9Hyos5EQ/HQ3dEB5dVQtKBCxAb8d8LSpGE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368369AbgDOMFg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 08:05:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:43468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727920AbgDOLry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 07:47:54 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03A5821582;
        Wed, 15 Apr 2020 11:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586951273;
        bh=TF/01RNQtNtjrq6KbrU+2FAcLCzjC1oerULda68YHj4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CvxUiypJuukFn8WeoAaKsHcmZqHkoSTZ7jCCMnlX8ipfj1euR9kxwpM8dl4aCtdo1
         ayFM4Aqw08ZWNe4ffzxVn+BDL+bimho1LbWSb4ju3yE1kr13hrggs+s3VhmtsgQpHy
         KNPk6ZEWn1hkkDntaSV1bUqJ8sV7mFJ+H5qsdpRk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Sasha Levin <sashal@kernel.org>, linux-nfs@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 04/21] NFS: direct.c: Fix memory leak of dreq when nfs_get_lock_context fails
Date:   Wed, 15 Apr 2020 07:47:31 -0400
Message-Id: <20200415114748.15713-4-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415114748.15713-1-sashal@kernel.org>
References: <20200415114748.15713-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

