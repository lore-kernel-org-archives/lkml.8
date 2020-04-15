Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500F3C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 13:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B3BD2078B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 13:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586956942;
	bh=Pk3LH+KtmLOnF31lo8mARZysIUUWRRZBhV3Ch4KKeVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VzMX140tSoJZLknE3bR9Q797wYdQT5moTsK9ng6zNzi5ZWprJ6G551crHcouJg7MH
	 01SkJSVJYT5tZ1Xb2gLuRmBmtugfuVEhZJyrcgM1Gsqb4vG/lBd+GwVObG6DSdheH+
	 59630qAQBpDwXoDh9IsOsI+uUe9dkxJNrkOvLsh8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506336AbgDONWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 09:22:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:54384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2897009AbgDOLfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 07:35:03 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAEA520857;
        Wed, 15 Apr 2020 11:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586950502;
        bh=Pk3LH+KtmLOnF31lo8mARZysIUUWRRZBhV3Ch4KKeVI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gCQkZOt18wS5nOnSEVmt6zMpF4xPoszlNzFqPApeVIREvWSKvQj6LkWKI/lE2bt35
         H5/+DFtW6ECEPc+7rbwNCUUKGuNgqDD0bn1p28QjAX29R5zQ+CA2V3LfQr8O7fvtzi
         RMrEt8TlWp7RAArRoRiLUly9dGKpaIF6jS+MBSXQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 5.6 014/129] f2fs: fix to avoid use-after-free in f2fs_write_multi_pages()
Date:   Wed, 15 Apr 2020 07:32:49 -0400
Message-Id: <20200415113445.11881-14-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415113445.11881-1-sashal@kernel.org>
References: <20200415113445.11881-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

[ Upstream commit 95978caa138948054e06d00bfc3432b518699f1b ]

In compress cluster, if physical block number is less than logic
page number, race condition will cause use-after-free issue as
described below:

- f2fs_write_compressed_pages
 - fio.page = cic->rpages[0];
 - f2fs_outplace_write_data
					- f2fs_compress_write_end_io
					 - kfree(cic->rpages);
					 - kfree(cic);
 - fio.page = cic->rpages[1];

f2fs_write_multi_pages+0xfd0/0x1a98
f2fs_write_data_pages+0x74c/0xb5c
do_writepages+0x64/0x108
__writeback_single_inode+0xdc/0x4b8
writeback_sb_inodes+0x4d0/0xa68
__writeback_inodes_wb+0x88/0x178
wb_writeback+0x1f0/0x424
wb_workfn+0x2f4/0x574
process_one_work+0x210/0x48c
worker_thread+0x2e8/0x44c
kthread+0x110/0x120
ret_from_fork+0x10/0x18

Fixes: 4c8ff7095bef ("f2fs: support data compression")
Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/compress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index c847523ab4a2e..927db1205bd81 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -845,7 +845,7 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 
 		blkaddr = datablock_addr(dn.inode, dn.node_page,
 							dn.ofs_in_node);
-		fio.page = cic->rpages[i];
+		fio.page = cc->rpages[i];
 		fio.old_blkaddr = blkaddr;
 
 		/* cluster header */
-- 
2.20.1

