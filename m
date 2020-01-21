Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8502C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8715207E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbgAUKZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 05:25:43 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:32778 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729605AbgAUKZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 05:25:43 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R411e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0ToHewUC_1579602339;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0ToHewUC_1579602339)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Jan 2020 18:25:40 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>,
        Bharath Vedartham <linux.bhar@gmail.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Jason Yan <yanaijie@huawei.com>,
        zhengbin <zhengbin13@huawei.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/reiserfs: remove unused macros
Date:   Tue, 21 Jan 2020 18:25:38 +0800
Message-Id: <1579602338-57079-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

these macros are never used from introduced. better to
remove them.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org> 
Cc: Jan Kara <jack@suse.cz> 
Cc: Bharath Vedartham <linux.bhar@gmail.com> 
Cc: Hariprasad Kelam <hariprasad.kelam@gmail.com> 
Cc: Jason Yan <yanaijie@huawei.com> 
Cc: zhengbin <zhengbin13@huawei.com> 
Cc: Jia-Ju Bai <baijiaju1990@gmail.com> 
Cc: reiserfs-devel@vger.kernel.org 
Cc: linux-kernel@vger.kernel.org 
---
 fs/reiserfs/journal.c | 2 --
 fs/reiserfs/procfs.c  | 1 -
 fs/reiserfs/stree.c   | 6 ------
 3 files changed, 9 deletions(-)

diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
index 4b3e3e73b512..072156c4f895 100644
--- a/fs/reiserfs/journal.c
+++ b/fs/reiserfs/journal.c
@@ -56,8 +56,6 @@
 /* gets a struct reiserfs_journal_list * from a list head */
 #define JOURNAL_LIST_ENTRY(h) (list_entry((h), struct reiserfs_journal_list, \
                                j_list))
-#define JOURNAL_WORK_ENTRY(h) (list_entry((h), struct reiserfs_journal_list, \
-                               j_working_list))
 
 /* must be correct to keep the desc and commit structs at 4k */
 #define JOURNAL_TRANS_HALF 1018
diff --git a/fs/reiserfs/procfs.c b/fs/reiserfs/procfs.c
index f2cf3441fdfc..ff336513c254 100644
--- a/fs/reiserfs/procfs.c
+++ b/fs/reiserfs/procfs.c
@@ -63,7 +63,6 @@ static int show_version(struct seq_file *m, void *unused)
 #define MAP( i ) D4C( objectid_map( sb, rs )[ i ] )
 
 #define DJF( x ) le32_to_cpu( rs -> x )
-#define DJV( x ) le32_to_cpu( s_v1 -> x )
 #define DJP( x ) le32_to_cpu( jp -> x )
 #define JF( x ) ( r -> s_journal -> x )
 
diff --git a/fs/reiserfs/stree.c b/fs/reiserfs/stree.c
index da9ebe33882b..6051e7bbc221 100644
--- a/fs/reiserfs/stree.c
+++ b/fs/reiserfs/stree.c
@@ -918,12 +918,6 @@ int comp_items(const struct item_head *stored_ih, const struct treepath *path)
 	return memcmp(stored_ih, ih, IH_SIZE);
 }
 
-/* unformatted nodes are not logged anymore, ever.  This is safe now */
-#define held_by_others(bh) (atomic_read(&(bh)->b_count) > 1)
-
-/* block can not be forgotten as it is in I/O or held by someone */
-#define block_in_use(bh) (buffer_locked(bh) || (held_by_others(bh)))
-
 /* prepare for delete or cut of direct item */
 static inline int prepare_for_direct_item(struct treepath *path,
 					  struct item_head *le_ih,
-- 
1.8.3.1

