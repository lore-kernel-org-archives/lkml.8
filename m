Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D07C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 09:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 407922073E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 09:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgCZJoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 05:44:19 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:60276 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727729AbgCZJoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 05:44:18 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C03A666A181C6217AC79;
        Thu, 26 Mar 2020 17:44:07 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Thu, 26 Mar 2020 17:43:58 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: switch discard_policy.timeout to bool type
Date:   Thu, 26 Mar 2020 17:43:56 +0800
Message-ID: <20200326094356.87838-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While checking discard timeout, we use specified type
UMOUNT_DISCARD_TIMEOUT, so just replace doplicy.timeout with
it, and switch doplicy.timeout to bool type.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h    |  2 +-
 fs/f2fs/segment.c | 20 ++++++++++----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index d3eda362582f..9274399d9505 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -330,8 +330,8 @@ struct discard_policy {
 	bool io_aware;			/* issue discard in idle time */
 	bool sync;			/* submit discard with REQ_SYNC flag */
 	bool ordered;			/* issue discard by lba order */
+	bool timeout;			/* discard timeout for put_super */
 	unsigned int granularity;	/* discard granularity */
-	int timeout;			/* discard timeout for put_super */
 };
 
 struct discard_cmd_control {
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 83d778ebea71..86e944700535 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1083,7 +1083,7 @@ static void __init_discard_policy(struct f2fs_sb_info *sbi,
 
 	dpolicy->max_requests = DEF_MAX_DISCARD_REQUEST;
 	dpolicy->io_aware_gran = MAX_PLIST_NUM;
-	dpolicy->timeout = 0;
+	dpolicy->timeout = false;
 
 	if (discard_type == DPOLICY_BG) {
 		dpolicy->min_interval = DEF_MIN_DISCARD_ISSUE_TIME;
@@ -1108,6 +1108,7 @@ static void __init_discard_policy(struct f2fs_sb_info *sbi,
 		dpolicy->io_aware = false;
 		/* we need to issue all to keep CP_TRIMMED_FLAG */
 		dpolicy->granularity = 1;
+		dpolicy->timeout = true;
 	}
 }
 
@@ -1490,8 +1491,8 @@ static bool __should_discard_retry(struct f2fs_sb_info *sbi,
 
 	mutex_lock(&dcc->cmd_lock);
 	list_for_each_entry_safe(dc, tmp, &(dcc->retry_list), list) {
-		if (dpolicy->timeout != 0 &&
-			f2fs_time_over(sbi, dpolicy->timeout)) {
+		if (dpolicy->timeout &&
+			f2fs_time_over(sbi, UMOUNT_DISCARD_TIMEOUT)) {
 			retry = false;
 			break;
 		}
@@ -1521,13 +1522,13 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
 	int i, err, issued = 0;
 	bool io_interrupted = false;
 
-	if (dpolicy->timeout != 0)
-		f2fs_update_time(sbi, dpolicy->timeout);
+	if (dpolicy->timeout)
+		f2fs_update_time(sbi, UMOUNT_DISCARD_TIMEOUT);
 
 retry:
 	for (i = MAX_PLIST_NUM - 1; i >= 0; i--) {
-		if (dpolicy->timeout != 0 &&
-				f2fs_time_over(sbi, dpolicy->timeout))
+		if (dpolicy->timeout &&
+				f2fs_time_over(sbi, UMOUNT_DISCARD_TIMEOUT))
 			break;
 
 		if (i + 1 < dpolicy->granularity)
@@ -1548,8 +1549,8 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi,
 		list_for_each_entry_safe(dc, tmp, pend_list, list) {
 			f2fs_bug_on(sbi, dc->state != D_PREP);
 
-			if (dpolicy->timeout != 0 &&
-				f2fs_time_over(sbi, dpolicy->timeout))
+			if (dpolicy->timeout &&
+				f2fs_time_over(sbi, UMOUNT_DISCARD_TIMEOUT))
 				break;
 
 			if (dpolicy->io_aware && i < dpolicy->io_aware_gran &&
@@ -1741,7 +1742,6 @@ bool f2fs_issue_discard_timeout(struct f2fs_sb_info *sbi)
 
 	__init_discard_policy(sbi, &dpolicy, DPOLICY_UMOUNT,
 					dcc->discard_granularity);
-	dpolicy.timeout = UMOUNT_DISCARD_TIMEOUT;
 	__issue_discard_cmd(sbi, &dpolicy);
 	dropped = __drop_discard_cmd(sbi);
 
-- 
2.18.0.rc1

