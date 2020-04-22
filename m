Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BC3C5518A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D90920775
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587551004;
	bh=Pk3LH+KtmLOnF31lo8mARZysIUUWRRZBhV3Ch4KKeVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aF5rsBXvGzU56aP3OcToIvivmr2jwgYSSK4ixUEDLFLgRAyic0KVJwcC5CC/Pla2U
	 yzWzyKb/uhDsKKzdCbODipFg21MoxK8+9OJwQIbTsS77D/bpvm/JLnb3chxu+e5Y32
	 yhHi3LWS62/Sfz/vljPo+8xgp/9l+Z8+5cTbbwQ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730329AbgDVKXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:23:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:59468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730273AbgDVKXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:23:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BB3C215A4;
        Wed, 22 Apr 2020 10:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550982;
        bh=Pk3LH+KtmLOnF31lo8mARZysIUUWRRZBhV3Ch4KKeVI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G5b/Sp0HBiqzYEj/YvJyVZ8Xtq6vOXidOAPO1ixEIFTDZoKh+1kGJBhcldZt8S74B
         GmKEJbtJbhIoQPw7lTwC6LrEjR22J0ygj2Pi+9pXdxVHT7wHXjXBcATLgwbyJZwdw4
         LrSWYsGLlf8o3aaoj7xjdKl6+6SAISTWXIobIMlY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 052/166] f2fs: fix to avoid use-after-free in f2fs_write_multi_pages()
Date:   Wed, 22 Apr 2020 11:56:19 +0200
Message-Id: <20200422095054.595424518@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095047.669225321@linuxfoundation.org>
References: <20200422095047.669225321@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



