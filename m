Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18337C3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 09:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F213321556
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 09:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbgCCJdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 04:33:25 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:54058 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728191AbgCCJdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 04:33:24 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A4A8367BBFF010DE1032;
        Tue,  3 Mar 2020 17:33:21 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Tue, 3 Mar 2020
 17:33:12 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <richard@nod.at>, <s.hauer@pengutronix.de>, <yi.zhang@huawei.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] ubifs: ubifs_jnl_write_inode: Fix a memory leak bug
Date:   Tue, 3 Mar 2020 17:40:22 +0800
Message-ID: <1583228423-60816-2-git-send-email-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583228423-60816-1-git-send-email-chengzhihao1@huawei.com>
References: <1583228423-60816-1-git-send-email-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When inodes with extended attributes are evicted, xent is not freed in one
exit branch.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Fixes: 9ca2d732644484488db3112 ("ubifs: Limit number of xattrs per inode")
---
 fs/ubifs/journal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
index 3bf8b1fda9d7..e5ec1afe1c66 100644
--- a/fs/ubifs/journal.c
+++ b/fs/ubifs/journal.c
@@ -905,6 +905,7 @@ int ubifs_jnl_write_inode(struct ubifs_info *c, const struct inode *inode)
 				ubifs_err(c, "dead directory entry '%s', error %d",
 					  xent->name, err);
 				ubifs_ro_mode(c, err);
+				kfree(xent);
 				goto out_release;
 			}
 			ubifs_assert(c, ubifs_inode(xino)->xattr);
-- 
2.7.4

