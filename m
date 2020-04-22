Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69C3C55186
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A6AC20882
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587551153;
	bh=Zvt64snqt3uHyzChEK/2HaoW1LghaS7BJDekteEpWdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r+yIejJiPcSCPFzN6PV8/Pv8wkvZ6Qhr5QyLj7Gt7ndC1cFysDhQdVmap3i8zxCl7
	 6sHFjCnQ6vfhYi57QgF7D+ogk4eGbY43Zp9jAkwMQ8gFCJXi0CvF0931xT7Hp0YEJs
	 Lp/9Bl7gH4nB4zkov9RRIIrJCTDGqR8U2oJckO3o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730621AbgDVKZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:25:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:34542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730593AbgDVKZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:25:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD6C120784;
        Wed, 22 Apr 2020 10:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587551148;
        bh=Zvt64snqt3uHyzChEK/2HaoW1LghaS7BJDekteEpWdA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CLYzZLV666dzGuuILqPgeF34bo5NFeC3SuySc7Z0oaZgCWD8mNrqmednvpMjL5rtt
         GeGXHXvKcDSJ8y9WZB5J8Te0FgpDZt7Hu9e0WBCadQhWN0tC7+s96+6lFJ7CWGwYA8
         ZNWv1k2q6jDGO+S060+YQpaxx51zKHxeS9bVrJRc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 113/166] NFS: Fix memory leaks in nfs_pageio_stop_mirroring()
Date:   Wed, 22 Apr 2020 11:57:20 +0200
Message-Id: <20200422095100.853959379@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095047.669225321@linuxfoundation.org>
References: <20200422095047.669225321@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit 862f35c94730c9270833f3ad05bd758a29f204ed ]

If we just set the mirror count to 1 without first clearing out
the mirrors, we can leak queued up requests.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/pagelist.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index 8b7c525dbbf7c..b736912098eee 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -886,15 +886,6 @@ static void nfs_pageio_setup_mirroring(struct nfs_pageio_descriptor *pgio,
 	pgio->pg_mirror_count = mirror_count;
 }
 
-/*
- * nfs_pageio_stop_mirroring - stop using mirroring (set mirror count to 1)
- */
-void nfs_pageio_stop_mirroring(struct nfs_pageio_descriptor *pgio)
-{
-	pgio->pg_mirror_count = 1;
-	pgio->pg_mirror_idx = 0;
-}
-
 static void nfs_pageio_cleanup_mirroring(struct nfs_pageio_descriptor *pgio)
 {
 	pgio->pg_mirror_count = 1;
@@ -1320,6 +1311,14 @@ void nfs_pageio_cond_complete(struct nfs_pageio_descriptor *desc, pgoff_t index)
 	}
 }
 
+/*
+ * nfs_pageio_stop_mirroring - stop using mirroring (set mirror count to 1)
+ */
+void nfs_pageio_stop_mirroring(struct nfs_pageio_descriptor *pgio)
+{
+	nfs_pageio_complete(pgio);
+}
+
 int __init nfs_init_nfspagecache(void)
 {
 	nfs_page_cachep = kmem_cache_create("nfs_page",
-- 
2.20.1



