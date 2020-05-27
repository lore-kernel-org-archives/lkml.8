Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C81C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 10:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5636A20C56
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 10:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387449AbgE0K2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 06:28:13 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33966 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727018AbgE0K2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 06:28:10 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 26207C1D2B936DEEF8CB;
        Wed, 27 May 2020 18:28:06 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Wed, 27 May 2020 18:27:55 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 3/3] f2fs: fix to cover meta flush with cp_lock
Date:   Wed, 27 May 2020 18:27:53 +0800
Message-ID: <20200527102753.15743-3-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20200527102753.15743-1-yuchao0@huawei.com>
References: <20200527102753.15743-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

meta inode page should be flushed under cp_lock, fix it.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index f7de2a1da528..0fcae4d90074 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2260,7 +2260,9 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
 		set_sbi_flag(sbi, SBI_IS_SHUTDOWN);
 		break;
 	case F2FS_GOING_DOWN_METAFLUSH:
+		mutex_lock(&sbi->cp_mutex);
 		f2fs_sync_meta_pages(sbi, META, LONG_MAX, FS_META_IO);
+		mutex_unlock(&sbi->cp_mutex);
 		f2fs_stop_checkpoint(sbi, false);
 		set_sbi_flag(sbi, SBI_IS_SHUTDOWN);
 		break;
-- 
2.18.0.rc1

