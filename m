Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D1EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C9AE2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592448442;
	bh=jplWrG6bk/PzGY0EE3Y+lK5ZNOODKNsKti9Z3BApBr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YRuLB94/W3zud3qcBt8STnHNxMpWxF5NML4Xlgd8OyE7GAS7eec7FDkYyuPxlmbjV
	 yriMLV42eYcPTQ6PEnAx4pmE4LXQjOE4I5NYS2w0x9IXlEcU0BUEdV9Ularo57os1M
	 LDDyHdpZDYBThJlFm8+n/ZKgzKdkU313Vf1F9ha4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730647AbgFRCrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:47:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:37532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728481AbgFRBKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:10:23 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BCEF214DB;
        Thu, 18 Jun 2020 01:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592442623;
        bh=jplWrG6bk/PzGY0EE3Y+lK5ZNOODKNsKti9Z3BApBr4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nRAYCS3NkeeuzetBi+y7fUdvnJwMWnM7ZMyP5jly6rP5jYGLu/gEQTFIuls+Ts4dN
         g8JgtKZCwcBPuWWOTSFVe7zoOdYyFn8tvP+eFIzN+77gvqTW8aXQGEwNn9UspgDqxf
         Nja2SMLAKuA59j4gHcV2l8D2L+XJKDI0gIDocAOk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chuhong Yuan <hslester96@gmail.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-xfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 102/388] xfs: Add the missed xfs_perag_put() for xfs_ifree_cluster()
Date:   Wed, 17 Jun 2020 21:03:19 -0400
Message-Id: <20200618010805.600873-102-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuhong Yuan <hslester96@gmail.com>

[ Upstream commit 8cc0072469723459dc6bd7beff81b2b3149f4cf4 ]

xfs_ifree_cluster() calls xfs_perag_get() at the beginning, but forgets to
call xfs_perag_put() in one failed path.
Add the missed function call to fix it.

Fixes: ce92464c180b ("xfs: make xfs_trans_get_buf return an error code")
Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/xfs_inode.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index d1772786af29..8845faa8161a 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -2639,8 +2639,10 @@ xfs_ifree_cluster(
 		error = xfs_trans_get_buf(tp, mp->m_ddev_targp, blkno,
 				mp->m_bsize * igeo->blocks_per_cluster,
 				XBF_UNMAPPED, &bp);
-		if (error)
+		if (error) {
+			xfs_perag_put(pag);
 			return error;
+		}
 
 		/*
 		 * This buffer may not have been correctly initialised as we
-- 
2.25.1

