Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E02C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 10:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 721B42074F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 10:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="fEJwAmuN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgDWKOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 06:14:15 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:42107 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726470AbgDWKOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 06:14:14 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587636854; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=XkTvNo/jbkM19vHDq0zRKvy3gJ3iYXjBL0TBCr698Hs=; b=fEJwAmuNRdduEc4IqXUR3/T+1JcAwdyu3aqs96y+mfvNysuhzNl8Ab36Xf5KgDPnKRofU3yK
 vprnvyHbViZ8N762GSnglFDYaoI9AO0VAzfPwxeAWFRlGNkwVX7uVCr641j0FjNqTyH3Fo4B
 7BV54Mvpx3lHue5qTO4DcR+2r9A=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea16a70.7f56514b1e30-smtp-out-n04;
 Thu, 23 Apr 2020 10:14:08 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 89CCCC433CB; Thu, 23 Apr 2020 10:14:07 +0000 (UTC)
Received: from sayalil-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sayalil)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4318FC433D2;
        Thu, 23 Apr 2020 10:14:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4318FC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sayalil@codeaurora.org
From:   Sayali Lokhande <sayalil@codeaurora.org>
To:     jaegeuk@kernel.org, yuchao0@huawei.com,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     stummala@codeaurora.org, linux-kernel@vger.kernel.org,
        Sayali Lokhande <sayalil@codeaurora.org>
Subject: [PATCH] f2fs: Avoid double lock for cp_rwsem
Date:   Thu, 23 Apr 2020 15:43:52 +0530
Message-Id: <1587636832-17939-1-git-send-email-sayalil@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call stack :
f2fs_write_checkpoint()
-> block_operations(sbi)
    f2fs_lock_all(sbi);
     down_write(&sbi->cp_rwsem); => write lock held
<>
-> f2fs_sync_node_pages()
    if (is_inline_node(page))
     flush_inline_data()
	page = f2fs_pagecache_get_page()
         if (!page)
           goto iput_out;
	iput_out:
	 iput(inode);
          -> f2fs_evict_inode()
	      f2fs_truncate_blocks()
	       f2fs_lock_op()
	        down_read(&sbi->cp_rwsem); => read lock fail

Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
---
 fs/f2fs/checkpoint.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 5ba649e..5c504cf 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1219,21 +1219,19 @@ static int block_operations(struct f2fs_sb_info *sbi)
 		goto retry_flush_quotas;
 	}
 
-retry_flush_nodes:
 	down_write(&sbi->node_write);
 
 	if (get_pages(sbi, F2FS_DIRTY_NODES)) {
 		up_write(&sbi->node_write);
+		f2fs_unlock_all(sbi);
 		atomic_inc(&sbi->wb_sync_req[NODE]);
 		err = f2fs_sync_node_pages(sbi, &wbc, false, FS_CP_NODE_IO);
 		atomic_dec(&sbi->wb_sync_req[NODE]);
-		if (err) {
-			up_write(&sbi->node_change);
-			f2fs_unlock_all(sbi);
+		up_write(&sbi->node_change);
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
