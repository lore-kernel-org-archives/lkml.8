Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5987BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 09:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37C582073E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 09:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgGCJwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 05:52:02 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7369 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726287AbgGCJv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 05:51:58 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 68A429C50DBA215F809C;
        Fri,  3 Jul 2020 17:51:49 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Fri, 3 Jul 2020 17:51:41 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Dehe Gu <gudehe@huawei.com>,
        Daiyue Zhang <zhangdaiyue1@huawei.com>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: remove write attribute of main_blkaddr sysfs node
Date:   Fri, 3 Jul 2020 17:51:29 +0800
Message-ID: <20200703095129.51276-1-yuchao0@huawei.com>
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

From: Dehe Gu <gudehe@huawei.com>

Fuzzing main_blkaddr sysfs node will corrupt this field's value,
causing kernel panic, remove its write attribute to avoid potential
security risk.

[Chao Yu: add description]

Signed-off-by: Dehe Gu <gudehe@huawei.com>
Signed-off-by: Daiyue Zhang <zhangdaiyue1@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/sysfs.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 64bbe0b3b830..0b7aa7acd9ec 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -224,6 +224,13 @@ static ssize_t avg_vblocks_show(struct f2fs_attr *a,
 }
 #endif
 
+static ssize_t main_blkaddr_show(struct f2fs_attr *a,
+				struct f2fs_sb_info *sbi, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%llu\n",
+			(unsigned long long)MAIN_BLKADDR(sbi));
+}
+
 static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
 			struct f2fs_sb_info *sbi, char *buf)
 {
@@ -525,7 +532,6 @@ F2FS_RW_ATTR(GC_THREAD, f2fs_gc_kthread, gc_no_gc_sleep_time, no_gc_sleep_time);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, gc_idle, gc_mode);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, gc_urgent, gc_mode);
 F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, reclaim_segments, rec_prefree_segments);
-F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, main_blkaddr, main_blkaddr);
 F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, max_small_discards, max_discards);
 F2FS_RW_ATTR(DCC_INFO, discard_cmd_control, discard_granularity, discard_granularity);
 F2FS_RW_ATTR(RESERVED_BLOCKS, f2fs_sb_info, reserved_blocks, reserved_blocks);
@@ -568,6 +574,7 @@ F2FS_GENERAL_RO_ATTR(current_reserved_blocks);
 F2FS_GENERAL_RO_ATTR(unusable);
 F2FS_GENERAL_RO_ATTR(encoding);
 F2FS_GENERAL_RO_ATTR(mounted_time_sec);
+F2FS_GENERAL_RO_ATTR(main_blkaddr);
 #ifdef CONFIG_F2FS_STAT_FS
 F2FS_STAT_ATTR(STAT_INFO, f2fs_stat_info, cp_foreground_calls, cp_count);
 F2FS_STAT_ATTR(STAT_INFO, f2fs_stat_info, cp_background_calls, bg_cp_count);
-- 
2.26.2

