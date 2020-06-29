Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1360CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA04720702
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388460AbgF2T7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:59:10 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50686 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388517AbgF2T7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:59:02 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id F099BE347D5E59611496;
        Mon, 29 Jun 2020 20:13:34 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Mon, 29 Jun 2020 20:13:27 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2 2/3] f2fs: support to trace f2fs_bmap()
Date:   Mon, 29 Jun 2020 20:13:12 +0800
Message-ID: <20200629121313.68072-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

to show f2fs_bmap()'s result as below:

f2fs_bmap: dev = (251,0), ino = 7, lblock:0, pblock:396800

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- use show_dev_ino() to avoid compile warning.
 fs/f2fs/data.c              | 14 +++++++++++---
 include/trace/events/f2fs.h | 26 ++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 91dc7b598961..c07a50e4d967 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3713,18 +3713,26 @@ static sector_t f2fs_bmap_compress(struct inode *inode, sector_t block)
 static sector_t f2fs_bmap(struct address_space *mapping, sector_t block)
 {
 	struct inode *inode = mapping->host;
+	struct buffer_head tmp = {
+		.b_size = i_blocksize(inode),
+	};
+	sector_t blknr = 0;
 
 	if (f2fs_has_inline_data(inode))
-		return 0;
+		goto out;
 
 	/* make sure allocating whole blocks */
 	if (mapping_tagged(mapping, PAGECACHE_TAG_DIRTY))
 		filemap_write_and_wait(mapping);
 
 	if (f2fs_compressed_file(inode))
-		return f2fs_bmap_compress(inode, block);
+		blknr = f2fs_bmap_compress(inode, block);
 
-	return generic_block_bmap(mapping, block, get_data_block_bmap);
+	if (!get_data_block_bmap(inode, block, &tmp, 0))
+		blknr = tmp.b_blocknr;
+out:
+	trace_f2fs_bmap(inode, block, blknr);
+	return blknr;
 }
 
 #ifdef CONFIG_MIGRATION
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 8639ab962a71..2e8713a52d76 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -1891,6 +1891,32 @@ TRACE_EVENT(f2fs_iostat,
 		__entry->fs_cdrio, __entry->fs_nrio, __entry->fs_mrio)
 );
 
+TRACE_EVENT(f2fs_bmap,
+
+	TP_PROTO(struct inode *inode, sector_t lblock, sector_t pblock),
+
+	TP_ARGS(inode, lblock, pblock),
+
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(ino_t, ino)
+		__field(sector_t, lblock)
+		__field(sector_t, pblock)
+	),
+
+	TP_fast_assign(
+		__entry->dev		= inode->i_sb->s_dev;
+		__entry->ino		= inode->i_ino;
+		__entry->lblock		= lblock;
+		__entry->pblock		= pblock;
+	),
+
+	TP_printk("dev = (%d,%d), ino = %lu, lblock:%lld, pblock:%lld",
+		show_dev_ino(__entry),
+		(unsigned long long)__entry->lblock,
+		(unsigned long long)__entry->pblock)
+);
+
 #endif /* _TRACE_F2FS_H */
 
  /* This part must be outside protection */
-- 
2.26.2

