Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD3AC55186
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEF4A20735
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587549741;
	bh=JPbhoqeFUPHJpXc+rO/mAZalsSq5l5AOvG/Eb06Qy8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZuoYuRgnMalfgCq7IxvVx2b4hEq3JEmYfCbaztduFgmkaJvm4lMvp3jrHmMJGkwW6
	 jsaeO3KFnRq22fvuZxVCF00O65DKo4vgW96e7puwBJB5WclpD6JQPVmJc3aZ9TSETj
	 9bc4/l0wONcur9iVXqc84RShL1tMtnGh3vdMmIZw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgDVKCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:02:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:51282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbgDVKCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:02:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30C9320735;
        Wed, 22 Apr 2020 10:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587549737;
        bh=JPbhoqeFUPHJpXc+rO/mAZalsSq5l5AOvG/Eb06Qy8o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wy5pHtfGhujDI8iwKTQFXn9znpayHzWPr8EPSNfdhAMvh9Z1VeQ78CNq8gTmtaYnh
         YUgY0S1W2ljj+8bhKS9CNmQXQTfQaLzB6QGihbKlXArhO+nKZ8ek9Ypg4PdQMffPFM
         2mMvF4GdpJXujD37l9/2wD0hXzDaLUa0rkUHXUa4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 086/100] NFS: direct.c: Fix memory leak of dreq when nfs_get_lock_context fails
Date:   Wed, 22 Apr 2020 11:56:56 +0200
Message-Id: <20200422095038.503493751@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095022.476101261@linuxfoundation.org>
References: <20200422095022.476101261@linuxfoundation.org>
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
index 88cb8e0d60149..7789f0b9b999e 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -605,6 +605,7 @@ ssize_t nfs_file_direct_read(struct kiocb *iocb, struct iov_iter *iter,
 	l_ctx = nfs_get_lock_context(dreq->ctx);
 	if (IS_ERR(l_ctx)) {
 		result = PTR_ERR(l_ctx);
+		nfs_direct_req_release(dreq);
 		goto out_release;
 	}
 	dreq->l_ctx = l_ctx;
@@ -1015,6 +1016,7 @@ ssize_t nfs_file_direct_write(struct kiocb *iocb, struct iov_iter *iter)
 	l_ctx = nfs_get_lock_context(dreq->ctx);
 	if (IS_ERR(l_ctx)) {
 		result = PTR_ERR(l_ctx);
+		nfs_direct_req_release(dreq);
 		goto out_release;
 	}
 	dreq->l_ctx = l_ctx;
-- 
2.20.1



