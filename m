Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291FBC83009
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 17:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 092912083B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 17:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="pU7IuFhp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgD2RBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 13:01:46 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:52393 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726456AbgD2RBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 13:01:44 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588179703; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=QSQIZIE1UkRMlEWP8K7XFOlZNS3rxvCKF1UPsNcLMS0=; b=pU7IuFhpaU8FNBnOpGxCRdUenoESVsvBn7Zce8XJ3/GCfryl0nTLa4H/4YH4Y69rVK90M9U8
 nOo6ftOr6JyGsXW2z1wah3zmlmGDYh6giyJTSzGRkk1omFFT7SLF8wETUDu1cEBBfMw+gAk0
 XWm4RZSn2JrrzL9YjAfP990AS9A=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea9b2bd.7fc83cd46618-smtp-out-n03;
 Wed, 29 Apr 2020 17:00:45 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 079C8C43636; Wed, 29 Apr 2020 17:00:45 +0000 (UTC)
Received: from sayalil-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sayalil)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 08338C433CB;
        Wed, 29 Apr 2020 17:00:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 08338C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sayalil@codeaurora.org
From:   Sayali Lokhande <sayalil@codeaurora.org>
To:     jaegeuk@kernel.org, yuchao0@huawei.com,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     stummala@codeaurora.org, linux-kernel@vger.kernel.org,
        Sayali Lokhande <sayalil@codeaurora.org>
Subject: [PATCH V3] f2fs: Avoid double lock for cp_rwsem during checkpoint
Date:   Wed, 29 Apr 2020 22:30:30 +0530
Message-Id: <1588179630-22819-1-git-send-email-sayalil@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There could be a scenario where f2fs_sync_node_pages gets
called during checkpoint, which in turn tries to flush
inline data and calls iput(). This results in deadlock as
iput() tries to hold cp_rwsem, which is already held at the
beginning by checkpoint->block_operations().

Call stack :

Thread A		Thread B
f2fs_write_checkpoint()
- block_operations(sbi)
 - f2fs_lock_all(sbi);
  - down_write(&sbi->cp_rwsem);

                        - open()
                         - igrab()
                        - write() write inline data
                        - unlink()
- f2fs_sync_node_pages()
 - if (is_inline_node(page))
  - flush_inline_data()
   - ilookup()
     page = f2fs_pagecache_get_page()
     if (!page)
      goto iput_out;
     iput_out:
			-close()
			-iput()
       iput(inode);
       - f2fs_evict_inode()
        - f2fs_truncate_blocks()
         - f2fs_lock_op()
           - down_read(&sbi->cp_rwsem);

Fixes: 399368372ed9 ("f2fs: introduce a new global lock scheme")
Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
---
 fs/f2fs/checkpoint.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 5ba649e..97b6378 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1219,21 +1219,19 @@ static int block_operations(struct f2fs_sb_info *sbi)
 		goto retry_flush_quotas;
 	}
 
-retry_flush_nodes:
 	down_write(&sbi->node_write);
 
 	if (get_pages(sbi, F2FS_DIRTY_NODES)) {
 		up_write(&sbi->node_write);
+		up_write(&sbi->node_change);
+		f2fs_unlock_all(sbi);
 		atomic_inc(&sbi->wb_sync_req[NODE]);
 		err = f2fs_sync_node_pages(sbi, &wbc, false, FS_CP_NODE_IO);
 		atomic_dec(&sbi->wb_sync_req[NODE]);
-		if (err) {
-			up_write(&sbi->node_change);
-			f2fs_unlock_all(sbi);
+		if (err)
 			goto out;
-		}
 		cond_resched();
-		goto retry_flush_nodes;
+		goto retry_flush_quotas;
 	}
 
 	/*
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
