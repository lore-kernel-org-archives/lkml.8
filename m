Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BCAC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A43822468E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbgCJMue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:50:34 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11616 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728596AbgCJMu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:50:29 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7B8B0322FAE80E6DD4EA;
        Tue, 10 Mar 2020 20:50:21 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Tue, 10 Mar 2020 20:50:12 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/5] f2fs: force compressed data into warm area
Date:   Tue, 10 Mar 2020 20:50:06 +0800
Message-ID: <20200310125009.12966-2-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20200310125009.12966-1-yuchao0@huawei.com>
References: <20200310125009.12966-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generally, data shows better continuity in warm data area as its
default allocation direction is right, in order to enhance
sequential read/write performance of compress inode, let's force
compress data into warm area.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 601d67e72c50..ab1bc750712a 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3037,9 +3037,10 @@ static int __get_segment_type_6(struct f2fs_io_info *fio)
 	if (fio->type == DATA) {
 		struct inode *inode = fio->page->mapping->host;
 
-		if (is_cold_data(fio->page) || file_is_cold(inode) ||
-				f2fs_compressed_file(inode))
+		if (is_cold_data(fio->page) || file_is_cold(inode))
 			return CURSEG_COLD_DATA;
+		if (f2fs_compressed_file(inode))
+			return CURSEG_WARM_DATA;
 		if (file_is_hot(inode) ||
 				is_inode_flag_set(inode, FI_HOT_DATA) ||
 				f2fs_is_atomic_file(inode) ||
-- 
2.18.0.rc1

