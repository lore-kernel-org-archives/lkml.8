Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF7FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 10:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31D0220675
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 10:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732147AbgF3KEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 06:04:46 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:54192 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730237AbgF3KEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 06:04:45 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3BA0BC1F9C3760ACAEC7;
        Tue, 30 Jun 2020 18:04:42 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Tue, 30 Jun 2020 18:04:35 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH RFC 2/5] f2fs: record average update time of segment
Date:   Tue, 30 Jun 2020 18:04:25 +0800
Message-ID: <20200630100428.19105-2-yuchao0@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200630100428.19105-1-yuchao0@huawei.com>
References: <20200630100428.19105-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, once we update one block in segment, we will update mtime of
segment to last time, making aged segment becoming freshest, result in
that GC with cost benefit algorithm missing such segment, So this patch
changes to record mtime as average block updating time instead of last
updating time.

It's not needed to reset mtime for prefree segment, as se->valid_blocks
is zero, then old se->mtime won't take any weight with below calculation:

	se->mtime = (se->mtime * se->valid_blocks + mtime) /
				(se->valid_blocks + 1);

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 863ec6f1fb87..906c313835ad 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2150,6 +2150,22 @@ static void __set_sit_entry_type(struct f2fs_sb_info *sbi, int type,
 		__mark_sit_entry_dirty(sbi, segno);
 }
 
+static void update_segment_mtime(struct f2fs_sb_info *sbi, block_t blkaddr)
+{
+	unsigned int segno = GET_SEGNO(sbi, blkaddr);
+	struct seg_entry *se = get_seg_entry(sbi, segno);
+	unsigned long long mtime = get_mtime(sbi, false);
+
+	if (!se->mtime) {
+		se->mtime = mtime;
+	} else {
+		se->mtime = (se->mtime * se->valid_blocks + mtime) /
+						(se->valid_blocks + 1);
+	}
+	if (mtime > SIT_I(sbi)->max_mtime)
+		SIT_I(sbi)->max_mtime = mtime;
+}
+
 static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
 {
 	struct seg_entry *se;
@@ -2169,10 +2185,9 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
 	f2fs_bug_on(sbi, (new_vblocks >> (sizeof(unsigned short) << 3) ||
 				(new_vblocks > sbi->blocks_per_seg)));
 
+	update_segment_mtime(sbi, blkaddr);
+
 	se->valid_blocks = new_vblocks;
-	se->mtime = get_mtime(sbi, false);
-	if (se->mtime > SIT_I(sbi)->max_mtime)
-		SIT_I(sbi)->max_mtime = se->mtime;
 
 	/* Update valid block bitmap */
 	if (del > 0) {
-- 
2.26.2

