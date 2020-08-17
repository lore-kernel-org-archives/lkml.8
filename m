Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C0AC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2009E2067C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbgHQO3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 10:29:32 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:42034 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728669AbgHQO33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 10:29:29 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5D1E6EE9A0B1D631E51B;
        Mon, 17 Aug 2020 22:29:26 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Mon, 17 Aug 2020
 22:29:17 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <richard.weinberger@gmail.com>, <yi.zhang@huawei.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] ubifs: ubifs_jnl_change_xattr: Remove assertion 'nlink > 0' for host inode
Date:   Mon, 17 Aug 2020 22:29:09 +0800
Message-ID: <20200817142909.1972897-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changing xattr of a temp file will trigger following assertion failed
and make ubifs turn into readonly filesystem:
  ubifs_assert_failed [ubifs]: UBIFS assert failed: host->i_nlink > 0,
  in fs/ubifs/journal.c:1801

Reproducer:
  1. fd = open(__O_TMPFILE)
  2. fsetxattr(fd, key, value2, XATTR_CREATE)
  3. fsetxattr(fd, key, value2, XATTR_REPLACE)

Fix this by removing assertion 'nlink > 0' for host inode.

Reported-by: Chengsong Ke <kechengsong@huawei.com>
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/ubifs/journal.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
index 4a5b06f8d812..0b9f686d1d42 100644
--- a/fs/ubifs/journal.c
+++ b/fs/ubifs/journal.c
@@ -1798,7 +1798,6 @@ int ubifs_jnl_change_xattr(struct ubifs_info *c, const struct inode *inode,
 	u8 hash[UBIFS_HASH_ARR_SZ];
 
 	dbg_jnl("ino %lu, ino %lu", host->i_ino, inode->i_ino);
-	ubifs_assert(c, host->i_nlink > 0);
 	ubifs_assert(c, inode->i_nlink > 0);
 	ubifs_assert(c, mutex_is_locked(&host_ui->ui_mutex));
 
-- 
2.25.4

