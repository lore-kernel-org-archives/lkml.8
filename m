Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06123C8300A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 12:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBBD2206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 12:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgD1MrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 08:47:14 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:53584 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726620AbgD1MrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 08:47:12 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 39AEF243388146992167;
        Tue, 28 Apr 2020 20:47:07 +0800 (CST)
Received: from huawei.com (10.175.105.27) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Tue, 28 Apr 2020
 20:46:56 +0800
From:   Wu Bo <wubo40@huawei.com>
To:     <jlayton@kernel.org>, <sage@redhat.com>, <idryomov@gmail.com>
CC:     <ceph-devel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <liuzhiqiang26@huawei.com>, <linfeilong@huawei.com>,
        <wubo40@huawei.com>
Subject: [PATCH] fs/ceph:fix double unlock in handle_cap_export()
Date:   Tue, 28 Apr 2020 20:46:02 +0800
Message-ID: <1588077962-353994-1-git-send-email-wubo40@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.105.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the ceph_mdsc_open_export_target_session() return fails,
should add a lock to avoid twice unlocking.
Because the lock will be released at the retry or out_unlock tag. 

Signed-off-by: Wu Bo <wubo40@huawei.com>
---
 fs/ceph/caps.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 185db76..b5a62a8 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -3731,22 +3731,24 @@ static void handle_cap_export(struct inode *inode, struct ceph_mds_caps *ex,
 
 	/* open target session */
 	tsession = ceph_mdsc_open_export_target_session(mdsc, target);
-	if (!IS_ERR(tsession)) {
-		if (mds > target) {
-			mutex_lock(&session->s_mutex);
-			mutex_lock_nested(&tsession->s_mutex,
-					  SINGLE_DEPTH_NESTING);
-		} else {
-			mutex_lock(&tsession->s_mutex);
-			mutex_lock_nested(&session->s_mutex,
-					  SINGLE_DEPTH_NESTING);
-		}
-		new_cap = ceph_get_cap(mdsc, NULL);
-	} else {
+	if (IS_ERR(tsession)) {
 		WARN_ON(1);
 		tsession = NULL;
 		target = -1;
+		mutex_lock(&session->s_mutex);
+		goto out_unlock;
+	}
+
+	if (mds > target) {
+		mutex_lock(&session->s_mutex);
+		mutex_lock_nested(&tsession->s_mutex,
+					SINGLE_DEPTH_NESTING);
+	} else {
+		mutex_lock(&tsession->s_mutex);
+		mutex_lock_nested(&session->s_mutex,
+					SINGLE_DEPTH_NESTING);
 	}
+	new_cap = ceph_get_cap(mdsc, NULL);
 	goto retry;
 
 out_unlock:
-- 
1.8.3.1

