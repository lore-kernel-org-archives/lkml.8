Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821B6C55186
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ED912075A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587551473;
	bh=DB1F7DmshMsLEY2YqueSwvxRlGpbDWkuaDaxP+9e9Q0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D8G4yPxVIwCmcZVaOLbk5vfD4s/E8AuBF4pJGB0MgskMV41eCWgzzlkVKjjYMQgkI
	 hL0TQnSVZVugavDXteG7c78hpeuD6GTrAY1uVB7GS82ece8BNlll32BtICrdtJENZQ
	 tIIUv+cRZ7llS1958ULRou+Ols6+YCKg0BpqcuHg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730996AbgDVKbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:31:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:35146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730707AbgDVK0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:26:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 610E32071E;
        Wed, 22 Apr 2020 10:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587551177;
        bh=DB1F7DmshMsLEY2YqueSwvxRlGpbDWkuaDaxP+9e9Q0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2jPnZu9EM4dbMU4Qtsg1QCq+prqg5KBIshWGyjJhSZVqohRO2N0fNyexVuH27uP32
         nX4oJ11I4BXWOhjTwNMKZF9TIAiLL0ZjAzyWKJAF0EYSe/dK5c2VtMnRiQtWc6i09g
         1lZDNgYAYHu5v7x1WU9oQsoRydZ5KuVLpHc4oELE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 132/166] f2fs: fix to account compressed blocks in f2fs_compressed_blocks()
Date:   Wed, 22 Apr 2020 11:57:39 +0200
Message-Id: <20200422095102.577168876@linuxfoundation.org>
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

From: Chao Yu <yuchao0@huawei.com>

[ Upstream commit 1a67cbe141cf991af252a88143d0fd975be2d9e7 ]

por_fsstress reports inconsistent status in orphan inode, the root cause
of this is in f2fs_write_raw_pages() we decrease i_compr_blocks incorrectly
due to wrong calculation in f2fs_compressed_blocks().

So this patch exposes below two functions based on __f2fs_cluster_blocks:
- f2fs_compressed_blocks: get count of compressed blocks in compressed cluster
- f2fs_cluster_blocks: get count of valid blocks (including reserved blocks)
in compressed cluster.

Then use f2fs_compress_blocks() to get correct compressed blocks count in
f2fs_write_raw_pages().

sanity_check_inode: inode (ino=ad80) hash inconsistent i_compr_blocks:2, i_blocks:1, run fsck to fix

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/compress.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index ad8e25a1fbc26..11b13b881ada5 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -536,8 +536,7 @@ static bool __cluster_may_compress(struct compress_ctx *cc)
 	return true;
 }
 
-/* return # of compressed block addresses */
-static int f2fs_compressed_blocks(struct compress_ctx *cc)
+static int __f2fs_cluster_blocks(struct compress_ctx *cc, bool compr)
 {
 	struct dnode_of_data dn;
 	int ret;
@@ -560,8 +559,13 @@ static int f2fs_compressed_blocks(struct compress_ctx *cc)
 
 			blkaddr = datablock_addr(dn.inode,
 					dn.node_page, dn.ofs_in_node + i);
-			if (blkaddr != NULL_ADDR)
-				ret++;
+			if (compr) {
+				if (__is_valid_data_blkaddr(blkaddr))
+					ret++;
+			} else {
+				if (blkaddr != NULL_ADDR)
+					ret++;
+			}
 		}
 	}
 fail:
@@ -569,6 +573,18 @@ static int f2fs_compressed_blocks(struct compress_ctx *cc)
 	return ret;
 }
 
+/* return # of compressed blocks in compressed cluster */
+static int f2fs_compressed_blocks(struct compress_ctx *cc)
+{
+	return __f2fs_cluster_blocks(cc, true);
+}
+
+/* return # of valid blocks in compressed cluster */
+static int f2fs_cluster_blocks(struct compress_ctx *cc, bool compr)
+{
+	return __f2fs_cluster_blocks(cc, false);
+}
+
 int f2fs_is_compressed_cluster(struct inode *inode, pgoff_t index)
 {
 	struct compress_ctx cc = {
@@ -578,7 +594,7 @@ int f2fs_is_compressed_cluster(struct inode *inode, pgoff_t index)
 		.cluster_idx = index >> F2FS_I(inode)->i_log_cluster_size,
 	};
 
-	return f2fs_compressed_blocks(&cc);
+	return f2fs_cluster_blocks(&cc, false);
 }
 
 static bool cluster_may_compress(struct compress_ctx *cc)
@@ -627,7 +643,7 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
 	bool prealloc;
 
 retry:
-	ret = f2fs_compressed_blocks(cc);
+	ret = f2fs_cluster_blocks(cc, false);
 	if (ret <= 0)
 		return ret;
 
-- 
2.20.1



