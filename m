Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A02C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 09:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9207208DB
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 09:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731917AbgFSJHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 05:07:09 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:57942 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731775AbgFSJGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 05:06:53 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DC06B6324870621A196D;
        Fri, 19 Jun 2020 17:06:48 +0800 (CST)
Received: from DESKTOP-FKFNUOQ.china.huawei.com (10.67.101.2) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Fri, 19 Jun 2020 17:06:39 +0800
From:   Zhe Li <lizhe67@huawei.com>
To:     <dwmw2@infradead.org>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <lizhe67@huawei.com>, <wangfangpeng1@huawei.com>,
        <qiuxi1@huawei.com>, <zhongjubin@huawei.com>, <chenjie6@huawei.com>
Subject: [PATCH] jffs2: fix UAF problem
Date:   Fri, 19 Jun 2020 17:06:35 +0800
Message-ID: <20200619090635.58548-1-lizhe67@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.101.2]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The log of UAF problem is listed below.
BUG: KASAN: use-after-free in jffs2_rmdir+0xa4/0x1cc [jffs2] at addr c1f165fc
Read of size 4 by task rm/8283
=============================================================================
BUG kmalloc-32 (Tainted: P    B      O   ): kasan: bad access detected
-----------------------------------------------------------------------------

INFO: Allocated in 0xbbbbbbbb age=3054364 cpu=0 pid=0
        0xb0bba6ef
        jffs2_write_dirent+0x11c/0x9c8 [jffs2]
        __slab_alloc.isra.21.constprop.25+0x2c/0x44
        __kmalloc+0x1dc/0x370
        jffs2_write_dirent+0x11c/0x9c8 [jffs2]
        jffs2_do_unlink+0x328/0x5fc [jffs2]
        jffs2_rmdir+0x110/0x1cc [jffs2]
        vfs_rmdir+0x180/0x268
        do_rmdir+0x2cc/0x300
        ret_from_syscall+0x0/0x3c
INFO: Freed in 0x205b age=3054364 cpu=0 pid=0
        0x2e9173
        jffs2_add_fd_to_list+0x138/0x1dc [jffs2]
        jffs2_add_fd_to_list+0x138/0x1dc [jffs2]
        jffs2_garbage_collect_dirent.isra.3+0x21c/0x288 [jffs2]
        jffs2_garbage_collect_live+0x16bc/0x1800 [jffs2]
        jffs2_garbage_collect_pass+0x678/0x11d4 [jffs2]
        jffs2_garbage_collect_thread+0x1e8/0x3b0 [jffs2]
        kthread+0x1a8/0x1b0
        ret_from_kernel_thread+0x5c/0x64
Call Trace:
[c17ddd20] [c02452d4] kasan_report.part.0+0x298/0x72c (unreliable)
[c17ddda0] [d2509680] jffs2_rmdir+0xa4/0x1cc [jffs2]
[c17dddd0] [c026da04] vfs_rmdir+0x180/0x268
[c17dde00] [c026f4e4] do_rmdir+0x2cc/0x300
[c17ddf40] [c001a658] ret_from_syscall+0x0/0x3c

The root cause is that we don't get "jffs2_inode_info.sem" before
we scan list "jffs2_inode_info.dents" in function jffs2_rmdir.
This patch add codes to get "jffs2_inode_info.sem" before we scan
"jffs2_inode_info.dents" to slove the UAF problem.

Signed-off-by: Zhe Li <lizhe67@huawei.com>
---
 fs/jffs2/dir.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/jffs2/dir.c b/fs/jffs2/dir.c
index f20cff1..7764937 100644
--- a/fs/jffs2/dir.c
+++ b/fs/jffs2/dir.c
@@ -590,10 +590,14 @@ static int jffs2_rmdir (struct inode *dir_i, struct dentry *dentry)
 	int ret;
 	uint32_t now = JFFS2_NOW();
 
+	mutex_lock(&f->sem);
 	for (fd = f->dents ; fd; fd = fd->next) {
-		if (fd->ino)
+		if (fd->ino) {
+			mutex_unlock(&f->sem);
 			return -ENOTEMPTY;
+		}
 	}
+	mutex_unlock(&f->sem);
 
 	ret = jffs2_do_unlink(c, dir_f, dentry->d_name.name,
 			      dentry->d_name.len, f, now);
-- 
2.7.4


