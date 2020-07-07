Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F374C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 01:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D2B920708
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 01:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgGGBfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 21:35:55 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48210 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726918AbgGGBfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 21:35:55 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3911B215BCAADAAE62B6;
        Tue,  7 Jul 2020 09:35:53 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Tue, 7 Jul 2020 09:35:44 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: don't keep meta inode pages used for compressed block migration
Date:   Tue, 7 Jul 2020 09:35:41 +0800
Message-ID: <20200707013541.26165-1-yuchao0@huawei.com>
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

meta inode's pages are used for encrypted, verity and compressed blocks,
so the meta inode's cache invalidation condition in do_checkpoint() should
consider compression as well, not just for verity and encryption, fix it.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/checkpoint.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 415bd120e561..c5593a6f9240 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1515,9 +1515,10 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 
 	/*
 	 * invalidate intermediate page cache borrowed from meta inode which are
-	 * used for migration of encrypted or verity inode's blocks.
+	 * used for migration of encrypted, verity or compressed inode's blocks.
 	 */
-	if (f2fs_sb_has_encrypt(sbi) || f2fs_sb_has_verity(sbi))
+	if (f2fs_sb_has_encrypt(sbi) || f2fs_sb_has_verity(sbi) ||
+		f2fs_sb_has_compression(sbi))
 		invalidate_mapping_pages(META_MAPPING(sbi),
 				MAIN_BLKADDR(sbi), MAX_BLKADDR(sbi) - 1);
 
-- 
2.26.2

