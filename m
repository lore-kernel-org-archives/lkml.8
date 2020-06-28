Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB5DC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 12:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7D5C206A1
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 12:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgF1MaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 08:30:22 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33758 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726317AbgF1MaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 08:30:18 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B128AF012B4D705F9F08;
        Sun, 28 Jun 2020 20:30:14 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Sun, 28 Jun 2020 20:30:07 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 3/3] f2fs: support to trace f2fs_fiemap()
Date:   Sun, 28 Jun 2020 20:29:40 +0800
Message-ID: <20200628122940.29665-3-yuchao0@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200628122940.29665-1-yuchao0@huawei.com>
References: <20200628122940.29665-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

to show f2fs_fiemap()'s result as below:

f2fs_fiemap: dev = (251,0), ino = 7, lblock:0, pblock:1625292800, len:2097152, flags:0, ret:0

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c              |  6 +++++-
 fs/f2fs/inline.c            |  2 ++
 include/trace/events/f2fs.h | 38 +++++++++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index c07a50e4d967..995cf78b23c5 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1813,6 +1813,7 @@ static int f2fs_xattr_fiemap(struct inode *inode,
 			flags |= FIEMAP_EXTENT_LAST;
 
 		err = fiemap_fill_next_extent(fieinfo, 0, phys, len, flags);
+		trace_f2fs_fiemap(inode, 0, phys, len, flags, err);
 		if (err || err == 1)
 			return err;
 	}
@@ -1836,8 +1837,10 @@ static int f2fs_xattr_fiemap(struct inode *inode,
 		flags = FIEMAP_EXTENT_LAST;
 	}
 
-	if (phys)
+	if (phys) {
 		err = fiemap_fill_next_extent(fieinfo, 0, phys, len, flags);
+		trace_f2fs_fiemap(inode, 0, phys, len, flags, err);
+	}
 
 	return (err < 0 ? err : 0);
 }
@@ -1931,6 +1934,7 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 
 		ret = fiemap_fill_next_extent(fieinfo, logical,
 				phys, size, flags);
+		trace_f2fs_fiemap(inode, logical, phys, size, flags, ret);
 		if (ret)
 			goto out;
 		size = 0;
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index dbade310dc79..def4b8481883 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -12,6 +12,7 @@
 
 #include "f2fs.h"
 #include "node.h"
+#include <trace/events/f2fs.h>
 
 bool f2fs_may_inline_data(struct inode *inode)
 {
@@ -776,6 +777,7 @@ int f2fs_inline_data_fiemap(struct inode *inode,
 	byteaddr += (char *)inline_data_addr(inode, ipage) -
 					(char *)F2FS_INODE(ipage);
 	err = fiemap_fill_next_extent(fieinfo, start, byteaddr, ilen, flags);
+	trace_f2fs_fiemap(inode, start, byteaddr, ilen, flags, err);
 out:
 	f2fs_put_page(ipage, 1);
 	return err;
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 3d844c51d283..67202963ef82 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -1918,6 +1918,44 @@ TRACE_EVENT(f2fs_bmap,
 		(unsigned long long)__entry->pblock)
 );
 
+TRACE_EVENT(f2fs_fiemap,
+
+	TP_PROTO(struct inode *inode, sector_t lblock, sector_t pblock,
+		unsigned long long len, unsigned int flags, int ret),
+
+	TP_ARGS(inode, lblock, pblock, len, flags, ret),
+
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(ino_t, ino)
+		__field(sector_t, lblock)
+		__field(sector_t, pblock)
+		__field(unsigned long long, len)
+		__field(unsigned int, flags)
+		__field(int, ret)
+	),
+
+	TP_fast_assign(
+		__entry->dev		= inode->i_sb->s_dev;
+		__entry->ino		= inode->i_ino;
+		__entry->lblock		= lblock;
+		__entry->pblock		= pblock;
+		__entry->len		= len;
+		__entry->flags		= flags;
+		__entry->ret		= ret;
+	),
+
+	TP_printk("dev = (%d,%d), ino = %lu, lblock:%lld, pblock:%lld, "
+		"len:%llu, flags:%u, ret:%d",
+		show_dev(__entry->dev),
+		__entry->ino,
+		(unsigned long long)__entry->lblock,
+		(unsigned long long)__entry->pblock,
+		__entry->len,
+		__entry->flags,
+		__entry->ret)
+);
+
 #endif /* _TRACE_F2FS_H */
 
  /* This part must be outside protection */
-- 
2.26.2

