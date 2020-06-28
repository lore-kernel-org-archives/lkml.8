Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A168C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 01:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E6AF2080C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 01:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgF1B1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 21:27:30 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6319 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726378AbgF1B13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 21:27:29 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 74FAB780EEE5A1BC09DE
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 09:27:27 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Sun, 28 Jun 2020
 09:27:21 +0800
From:   fengyubo <fengyubo3@huawei.com>
To:     <hirofumi@mail.parknet.co.jp>
CC:     <fangwei1@huawei.com>, <fengyubo3@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] fatfs: switch write_lock to read_lock in fat_ioctl_get_attributes
Date:   Sun, 28 Jun 2020 09:34:13 +0800
Message-ID: <1593308053-12702-1-git-send-email-fengyubo3@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yubo Feng <fengyubo3@huawei.com>

There is no necessery to hold write_lock in fat_ioctl_get_attributes.
write_lock may make an impact on concurrency of fat_ioctl_get_attributes.

Signed-off-by: Yubo Feng <fengyubo3@huawei.com>
---
 fs/fat/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fat/file.c b/fs/fat/file.c
index 42134c5..f9ee27c 100644
--- a/fs/fat/file.c
+++ b/fs/fat/file.c
@@ -25,9 +25,9 @@ static int fat_ioctl_get_attributes(struct inode *inode, u32 __user *user_attr)
 {
 	u32 attr;
 
-	inode_lock(inode);
+	inode_lock_shared(inode);
 	attr = fat_make_attrs(inode);
-	inode_unlock(inode);
+	inode_unlock_shared(inode);
 
 	return put_user(attr, user_attr);
 }
-- 
2.7.4

