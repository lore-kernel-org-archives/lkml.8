Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F153BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 03:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA96220721
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 03:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436853AbgE2DhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 23:37:25 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42986 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2436649AbgE2DhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 23:37:19 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9DBEF28C4CD8D514F742;
        Fri, 29 May 2020 11:37:17 +0800 (CST)
Received: from DESKTOP-FKFNUOQ.china.huawei.com (10.67.101.2) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Fri, 29 May 2020 11:37:13 +0800
From:   Zhe Li <lizhe67@huawei.com>
To:     <dwmw2@infradead.org>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] jffs2: fix GC exit abnormally
Date:   Fri, 29 May 2020 11:37:11 +0800
Message-ID: <20200529033711.79180-1-lizhe67@huawei.com>
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

The log of this problem is:
jffs2: Error garbage collecting node at 0x***!
jffs2: No space for garbage collection. Aborting GC thread

This is because GC believe that it do nothing, so it abort.

After going over the image of jffs2, I find a scene that
can trigger this problem stably.
The scene is: there is a normal dirent node at summary-area,
but abnormal at corresponding not-summary-area with error
name_crc.

The reason that GC exit abnormally is because it find that
abnormal dirent node to GC, but when it goes to function
jffs2_add_fd_to_list, it cannot meet the condition listed
below:

if ((*prev)->nhash == new->nhash && !strcmp((*prev)->name, new->name))

So no node is marked obsolete, statistical information of
erase_block do not change, which cause GC exit abnormally.

The root cause of this problem is: we do not check the
name_crc of the abnormal dirent node with summary is enabled.

Noticed that in function jffs2_scan_dirent_node, we use
function jffs2_scan_dirty_space to deal with the dirent
node with error name_crc. So this patch add a checking
code in function read_direntry to ensure the correctness
of dirent node. If checked failed, the dirent node will
be marked obsolete so GC will pass this node and this
problem will be fixed.

Signed-off-by: Zhe Li <lizhe67@huawei.com>
---
 fs/jffs2/readinode.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/jffs2/readinode.c b/fs/jffs2/readinode.c
index bccfc40b..d19483f 100644
--- a/fs/jffs2/readinode.c
+++ b/fs/jffs2/readinode.c
@@ -672,6 +672,22 @@ static inline int read_direntry(struct jffs2_sb_info *c, struct jffs2_raw_node_r
 			jffs2_free_full_dirent(fd);
 			return -EIO;
 		}
+
+#ifdef CONFIG_JFFS2_SUMMARY
+		/*
+		 * we use CONFIG_JFFS2_SUMMARY because without it, we
+		 * have checked it while mounting
+		 */
+		crc = crc32(0, fd->name, rd->nsize);
+		if (unlikely(crc != je32_to_cpu(rd->name_crc))) {
+			JFFS2_NOTICE("name CRC failed on dirent node at"
+			   "%#08x: read %#08x,calculated %#08x\n",
+			   ref_offset(ref), je32_to_cpu(rd->node_crc), crc);
+			jffs2_mark_node_obsolete(c, ref);
+			jffs2_free_full_dirent(fd);
+			return 0;
+		}
+#endif
 	}
 
 	fd->nhash = full_name_hash(NULL, fd->name, rd->nsize);
-- 
2.7.4


