Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8F3C3A5A0
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B97E21974
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587221052;
	bh=1SgW/ysHszzLwNS0KAzEGP8RyyZsEVAJdzYA/bUoOmE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tLwquZ9oSNfFSqpgOtiE3KxX4IGZ4gtCAIvNDhzG20Em4SR9P+JR7aEnk5TFNgNyQ
	 3lYIlZQ1Q7RHqErluxk2Byn/PNRsQfMOz8TrODn+U/vJYRuvFj+0FGcs6AvqQmqvxR
	 ZMJvCqBMW14gxh3mdMlXewrFPVOVE10PTIDE8agk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbgDROoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 10:44:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:55364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728698AbgDROn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 10:43:56 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBD6521D7E;
        Sat, 18 Apr 2020 14:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587221036;
        bh=1SgW/ysHszzLwNS0KAzEGP8RyyZsEVAJdzYA/bUoOmE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A+HIZ0EgsFyPScf7OpEcqaBGOTad12/c0uNrdDolFNR1hA7NXu7Iy6xVrJ79whrJh
         SYmsqo9IclRpErdIWOOQ9jR/FSntvc54A7v+8VQl8eadqf8UxB9x0Wj7ncFgl8acZP
         PAuO8ZLuESCjiUDzUWj7iruwH0fyTbz5KfjV2dtg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Changwei Ge <chge@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Junxiao Bi <junxiao.bi@oracle.com>,
        Changwei Ge <gechangwei@live.cn>, Gang He <ghe@suse.com>,
        Jun Piao <piaojun@huawei.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, ocfs2-devel@oss.oracle.com
Subject: [PATCH AUTOSEL 4.14 21/28] ocfs2: no need try to truncate file beyond i_size
Date:   Sat, 18 Apr 2020 10:43:21 -0400
Message-Id: <20200418144328.10265-21-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418144328.10265-1-sashal@kernel.org>
References: <20200418144328.10265-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changwei Ge <chge@linux.alibaba.com>

[ Upstream commit 783fda856e1034dee90a873f7654c418212d12d7 ]

Linux fallocate(2) with FALLOC_FL_PUNCH_HOLE mode set, its offset can
exceed the inode size.  Ocfs2 now doesn't allow that offset beyond inode
size.  This restriction is not necessary and violates fallocate(2)
semantics.

If fallocate(2) offset is beyond inode size, just return success and do
nothing further.

Otherwise, ocfs2 will crash the kernel.

  kernel BUG at fs/ocfs2//alloc.c:7264!
   ocfs2_truncate_inline+0x20f/0x360 [ocfs2]
   ocfs2_remove_inode_range+0x23c/0xcb0 [ocfs2]
   __ocfs2_change_file_space+0x4a5/0x650 [ocfs2]
   ocfs2_fallocate+0x83/0xa0 [ocfs2]
   vfs_fallocate+0x148/0x230
   SyS_fallocate+0x48/0x80
   do_syscall_64+0x79/0x170

Signed-off-by: Changwei Ge <chge@linux.alibaba.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Changwei Ge <gechangwei@live.cn>
Cc: Gang He <ghe@suse.com>
Cc: Jun Piao <piaojun@huawei.com>
Cc: <stable@vger.kernel.org>
Link: http://lkml.kernel.org/r/20200407082754.17565-1-chge@linux.alibaba.com
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ocfs2/alloc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
index addd7c5f2d3e5..bed54e8adcf99 100644
--- a/fs/ocfs2/alloc.c
+++ b/fs/ocfs2/alloc.c
@@ -7240,6 +7240,10 @@ int ocfs2_truncate_inline(struct inode *inode, struct buffer_head *di_bh,
 	struct ocfs2_dinode *di = (struct ocfs2_dinode *)di_bh->b_data;
 	struct ocfs2_inline_data *idata = &di->id2.i_data;
 
+	/* No need to punch hole beyond i_size. */
+	if (start >= i_size_read(inode))
+		return 0;
+
 	if (end > i_size_read(inode))
 		end = i_size_read(inode);
 
-- 
2.20.1

