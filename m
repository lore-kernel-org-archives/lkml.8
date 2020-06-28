Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC96C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 02:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 007192080C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 02:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbgF1C7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 22:59:07 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6321 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725880AbgF1C7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 22:59:07 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8684C82A6CEB93331B4C;
        Sun, 28 Jun 2020 10:59:03 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Sun, 28 Jun 2020 10:58:54 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2 5/5] f2fs: show more debug info for per-temperature log
Date:   Sun, 28 Jun 2020 10:58:44 +0800
Message-ID: <20200628025844.90785-1-yuchao0@huawei.com>
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

- Add to account and show per-log dirty_seg, full_seg and valid_blocks
in debugfs.
- reformat printed info.

    TYPE            segno    secno   zoneno  dirty_seg   full_seg  valid_blk
  - COLD   data:     1523     1523     1523          1          0        399
  - WARM   data:      769      769      769         20        255     133098
  - HOT    data:      767      767      767          9          0        167
  - Dir   dnode:       22       22       22          3          0         70
  - File  dnode:      722      722      722         14         10       6505
  - Indir nodes:        2        2        2          1          0          3

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- account debug info for current segments.
 fs/f2fs/debug.c | 64 +++++++++++++++++++++++++++++++++++++++----------
 fs/f2fs/f2fs.h  |  3 +++
 2 files changed, 55 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 0dbcb0f9c019..4276c0f79beb 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -174,6 +174,26 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 	for (i = META_CP; i < META_MAX; i++)
 		si->meta_count[i] = atomic_read(&sbi->meta_count[i]);
 
+	for (i = 0; i < NO_CHECK_TYPE; i++) {
+		si->dirty_seg[i] = 0;
+		si->full_seg[i] = 0;
+		si->valid_blks[i] = 0;
+	}
+
+	for (i = 0; i < MAIN_SEGS(sbi); i++) {
+		int blks = get_seg_entry(sbi, i)->valid_blocks;
+		int type = get_seg_entry(sbi, i)->type;
+
+		if (!blks)
+			continue;
+
+		if (blks == sbi->blocks_per_seg)
+			si->full_seg[type]++;
+		else
+			si->dirty_seg[type]++;
+		si->valid_blks[type] += blks;
+	}
+
 	for (i = 0; i < 2; i++) {
 		si->segment_count[i] = sbi->segment_count[i];
 		si->block_count[i] = sbi->block_count[i];
@@ -329,30 +349,50 @@ static int stat_show(struct seq_file *s, void *v)
 		seq_printf(s, "\nMain area: %d segs, %d secs %d zones\n",
 			   si->main_area_segs, si->main_area_sections,
 			   si->main_area_zones);
-		seq_printf(s, "  - COLD  data: %d, %d, %d\n",
+		seq_printf(s, "    TYPE         %8s %8s %8s %10s %10s %10s\n",
+			   "segno", "secno", "zoneno", "dirty_seg", "full_seg", "valid_blk");
+		seq_printf(s, "  - COLD   data: %8d %8d %8d %10u %10u %10u\n",
 			   si->curseg[CURSEG_COLD_DATA],
 			   si->cursec[CURSEG_COLD_DATA],
-			   si->curzone[CURSEG_COLD_DATA]);
-		seq_printf(s, "  - WARM  data: %d, %d, %d\n",
+			   si->curzone[CURSEG_COLD_DATA],
+			   si->dirty_seg[CURSEG_COLD_DATA],
+			   si->full_seg[CURSEG_COLD_DATA],
+			   si->valid_blks[CURSEG_COLD_DATA]);
+		seq_printf(s, "  - WARM   data: %8d %8d %8d %10u %10u %10u\n",
 			   si->curseg[CURSEG_WARM_DATA],
 			   si->cursec[CURSEG_WARM_DATA],
-			   si->curzone[CURSEG_WARM_DATA]);
-		seq_printf(s, "  - HOT   data: %d, %d, %d\n",
+			   si->curzone[CURSEG_WARM_DATA],
+			   si->dirty_seg[CURSEG_WARM_DATA],
+			   si->full_seg[CURSEG_WARM_DATA],
+			   si->valid_blks[CURSEG_WARM_DATA]);
+		seq_printf(s, "  - HOT    data: %8d %8d %8d %10u %10u %10u\n",
 			   si->curseg[CURSEG_HOT_DATA],
 			   si->cursec[CURSEG_HOT_DATA],
-			   si->curzone[CURSEG_HOT_DATA]);
-		seq_printf(s, "  - Dir   dnode: %d, %d, %d\n",
+			   si->curzone[CURSEG_HOT_DATA],
+			   si->dirty_seg[CURSEG_HOT_DATA],
+			   si->full_seg[CURSEG_HOT_DATA],
+			   si->valid_blks[CURSEG_HOT_DATA]);
+		seq_printf(s, "  - Dir   dnode: %8d %8d %8d %10u %10u %10u\n",
 			   si->curseg[CURSEG_HOT_NODE],
 			   si->cursec[CURSEG_HOT_NODE],
-			   si->curzone[CURSEG_HOT_NODE]);
-		seq_printf(s, "  - File   dnode: %d, %d, %d\n",
+			   si->curzone[CURSEG_HOT_NODE],
+			   si->dirty_seg[CURSEG_HOT_NODE],
+			   si->full_seg[CURSEG_HOT_NODE],
+			   si->valid_blks[CURSEG_HOT_NODE]);
+		seq_printf(s, "  - File  dnode: %8d %8d %8d %10u %10u %10u\n",
 			   si->curseg[CURSEG_WARM_NODE],
 			   si->cursec[CURSEG_WARM_NODE],
-			   si->curzone[CURSEG_WARM_NODE]);
-		seq_printf(s, "  - Indir nodes: %d, %d, %d\n",
+			   si->curzone[CURSEG_WARM_NODE],
+			   si->dirty_seg[CURSEG_WARM_NODE],
+			   si->full_seg[CURSEG_WARM_NODE],
+			   si->valid_blks[CURSEG_WARM_NODE]);
+		seq_printf(s, "  - Indir nodes: %8d %8d %8d %10u %10u %10u\n",
 			   si->curseg[CURSEG_COLD_NODE],
 			   si->cursec[CURSEG_COLD_NODE],
-			   si->curzone[CURSEG_COLD_NODE]);
+			   si->curzone[CURSEG_COLD_NODE],
+			   si->dirty_seg[CURSEG_COLD_NODE],
+			   si->full_seg[CURSEG_COLD_NODE],
+			   si->valid_blks[CURSEG_COLD_NODE]);
 		seq_printf(s, "\n  - Valid: %d\n  - Dirty: %d\n",
 			   si->main_area_segs - si->dirty_count -
 			   si->prefree_count - si->free_segs,
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index d8bf07ba159c..7fb2a1a33438 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3551,6 +3551,9 @@ struct f2fs_stat_info {
 	int curseg[NR_CURSEG_TYPE];
 	int cursec[NR_CURSEG_TYPE];
 	int curzone[NR_CURSEG_TYPE];
+	unsigned int dirty_seg[NR_CURSEG_TYPE];
+	unsigned int full_seg[NR_CURSEG_TYPE];
+	unsigned int valid_blks[NR_CURSEG_TYPE];
 
 	unsigned int meta_count[META_MAX];
 	unsigned int segment_count[2];
-- 
2.26.2

