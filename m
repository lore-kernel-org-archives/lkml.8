Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F49C38A29
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EB5D21BE5
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587219129;
	bh=8bPoquuPIG8DCqchvpjw9lTLeL0MKv0uYeSKMsQmhRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lxX/5mbcz6cogGvhE9BlB/zTyWCxfsID21D9d6cMC39awUj+MvK1bSptjhxkJbBO5
	 hpXSIMjoreZmY0GN6W3XFt2HcOQDQBFUU/wsding+1SRBJr3MFPJPPodmGd682WgUK
	 bz3Zwg04wMcsQAtTj5m4s7l5Q3IgBOJce+HegRkY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbgDROMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 10:12:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:38224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726885AbgDROKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 10:10:15 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8C1821D82;
        Sat, 18 Apr 2020 14:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587219015;
        bh=8bPoquuPIG8DCqchvpjw9lTLeL0MKv0uYeSKMsQmhRQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ABvp1WFoP+xmCsCQwAcxwjqNtmmchNSz/z1ha6cT+kNRP8aS/s5R5ol5QpY05HwMx
         E+KN4qi+9pL7fLy4VhYc9VaC3vY8dJgAiol5kbqrzlSGJF8wzF/07lHvzEj/cYlA8C
         yJMQyiVsyYKeWu6cijxY8lxA1JQbFTW8t8fbULW0=
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
Subject: [PATCH AUTOSEL 5.5 51/75] ocfs2: no need try to truncate file beyond i_size
Date:   Sat, 18 Apr 2020 10:08:46 -0400
Message-Id: <20200418140910.8280-51-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418140910.8280-1-sashal@kernel.org>
References: <20200418140910.8280-1-sashal@kernel.org>
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
index 88534eb0e7c2a..3d5b6b989db26 100644
--- a/fs/ocfs2/alloc.c
+++ b/fs/ocfs2/alloc.c
@@ -7403,6 +7403,10 @@ int ocfs2_truncate_inline(struct inode *inode, struct buffer_head *di_bh,
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

