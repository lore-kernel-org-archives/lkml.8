Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F51BC35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 20:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3516A20674
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 20:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="jHdZ82tk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbgBDUGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 15:06:22 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:34720 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727514AbgBDUGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 15:06:19 -0500
Received: by mail-qv1-f66.google.com with SMTP id o18so9209757qvf.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 12:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=eDRuTAeCj1MHHosvk4b6Yc2l7JwwYq0uP+9wzC8UJyc=;
        b=jHdZ82tkjU44GYaoSJcSJnAuerupeTCEalGxxiMGOm2TE+edZauIN/0jgv6JpjmfWU
         r4YWYZREABtSI2sY70AC1do1uL+lfYnjjGV7d4ypjxje3R5yi3wGXrSaEStUgUxx/H7a
         Zs+XypuyYT9IwBIwGxGyU1ILYhHwxsurhx+jCbgauaiKj1gKMa5zoi3a5SVqEeSuYMKR
         kkcQ12mcyGK9wupmghUF5ZxXUt3whff1VJAW89eraeYz4jhbhkMcMI4z6giNZQuHouGC
         QfAu/3KZB/QTifmP3Ej3doaHBBA+f3Bm7/9f790Bav3tUIarB0XDpZ7Ztlu3RYP8qvyC
         ywGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eDRuTAeCj1MHHosvk4b6Yc2l7JwwYq0uP+9wzC8UJyc=;
        b=PtfnSJXDN38ENTVXeZ+OVAyKmE0SBnqLInAwGmqwfPGUhhun6DkcpQycWSms+PrHV/
         zYfmLxPVS/3YrHVRFv5CttfT2Sku7/bYtIDctf9sHHDphbKWSyof/Smuzq93H9Ob522f
         HFqPvK/3nZwG7cks0meFvh8AT/LiXU3c4OR31lD8rBZbQ2rlHjvKSe3eSBYsnOqU3ELy
         EEmZfAbDIDSyXofxoiXUvpKsAfxSeLhIrqcfK1UOYPrLa+XpWiR2htq6+t2aIHX0Z0/A
         0K9KDu3bi649lfSfpDDT+elq9t1SwGKjmtrVlnX+2oouZrYqqJmdQHbfe0T0wDg5w4SB
         BtjQ==
X-Gm-Message-State: APjAAAXSBb7Fm6qZt9OOYXKpM9G8ri28vXB32A5+x3D6HZRs+4AOXUbC
        gsy+2GjTDZebbx0OMhtLV8Q4cw==
X-Google-Smtp-Source: APXvYqxHv4MH/oj4+8kAjRtHzNst+7K1fMtll3CmFwq7IZTOFrB0vrDOekKDeuU+Lvqu2kMkYNLUCg==
X-Received: by 2002:a0c:eacb:: with SMTP id y11mr30196671qvp.68.1580846778526;
        Tue, 04 Feb 2020 12:06:18 -0800 (PST)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id u21sm5895241qke.102.2020.02.04.12.06.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Feb 2020 12:06:18 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, elver@google.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] ext4: fix a data race in EXT4_I(inode)->i_disksize
Date:   Tue,  4 Feb 2020 15:06:03 -0500
Message-Id: <1580846763-13731-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EXT4_I(inode)->i_disksize could be accessed concurrently as noticed by
KCSAN,

 BUG: KCSAN: data-race in ext4_write_end [ext4] / ext4_writepages [ext4]

 write to 0xffff91c6713b00f8 of 8 bytes by task 49268 on cpu 127:
  ext4_write_end+0x4e3/0x750 [ext4]
  ext4_update_i_disksize at fs/ext4/ext4.h:3032
  (inlined by) ext4_update_inode_size at fs/ext4/ext4.h:3046
  (inlined by) ext4_write_end at fs/ext4/inode.c:1287
  generic_perform_write+0x208/0x2a0
  ext4_buffered_write_iter+0x11f/0x210 [ext4]
  ext4_file_write_iter+0xce/0x9e0 [ext4]
  new_sync_write+0x29c/0x3b0
  __vfs_write+0x92/0xa0
  vfs_write+0x103/0x260
  ksys_write+0x9d/0x130
  __x64_sys_write+0x4c/0x60
  do_syscall_64+0x91/0xb47
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

 read to 0xffff91c6713b00f8 of 8 bytes by task 24872 on cpu 37:
  ext4_writepages+0x10ac/0x1d00 [ext4]
  mpage_map_and_submit_extent at fs/ext4/inode.c:2468
  (inlined by) ext4_writepages at fs/ext4/inode.c:2772
  do_writepages+0x5e/0x130
  __writeback_single_inode+0xeb/0xb20
  writeback_sb_inodes+0x429/0x900
  __writeback_inodes_wb+0xc4/0x150
  wb_writeback+0x4bd/0x870
  wb_workfn+0x6b4/0x960
  process_one_work+0x54c/0xbe0
  worker_thread+0x80/0x650
  kthread+0x1e0/0x200
  ret_from_fork+0x27/0x50

 Reported by Kernel Concurrency Sanitizer on:
 CPU: 37 PID: 24872 Comm: kworker/u261:2 Tainted: G        W  O L 5.5.0-next-20200204+ #5
 Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 07/10/2019
 Workqueue: writeback wb_workfn (flush-7:0)

Since only the read is operating as lockless (outside of the
"i_data_sem"), a load tearing could introduce a logic bug. Fix it by
adding READ_ONCE() for the read.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 fs/ext4/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 3313168b680f..6f9862bf63f1 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2465,7 +2465,7 @@ static int mpage_map_and_submit_extent(handle_t *handle,
 	 * truncate are avoided by checking i_size under i_data_sem.
 	 */
 	disksize = ((loff_t)mpd->first_page) << PAGE_SHIFT;
-	if (disksize > EXT4_I(inode)->i_disksize) {
+	if (disksize > READ_ONCE(EXT4_I(inode)->i_disksize)) {
 		int err2;
 		loff_t i_size;
 
-- 
1.8.3.1

