Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127BDC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFED720674
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388402AbgF2UAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:00:06 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:51446 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732138AbgF2UAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 16:00:00 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EB34C1AEC8048B373B37;
        Mon, 29 Jun 2020 20:13:34 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Mon, 29 Jun 2020 20:13:28 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2 3/3] f2fs: support to trace f2fs_fiemap()
Date:   Mon, 29 Jun 2020 20:13:13 +0800
Message-ID: <20200629121313.68072-2-yuchao0@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200629121313.68072-1-yuchao0@huawei.com>
References: <20200629121313.68072-1-yuchao0@huawei.com>
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
v2:
- use show_dev_ino() to avoid compile warning.
 fs/f2fs/data.c              |  6 +++++-
 fs/f2fs/inline.c            |  2 ++
 include/trace/events/f2fs.h | 37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 44 insertions(+), 1 deletion(-)

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
index 2e8713a52d76..8a1c1311acac 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -1917,6 +1917,43 @@ TRACE_EVENT(f2fs_bmap,
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
+		show_dev_ino(__entry),
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

