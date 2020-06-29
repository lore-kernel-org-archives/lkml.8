Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BDF4C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27F57206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593461020;
	bh=pY8EGcIEjvaSxYEoqBZ0j3spqMDbhpQfWO1FvxNGtHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AdDenM12QAhf1iXtdDlrUy0L0vaLFFfS/PVlRtSujwqlkAyHJMiXhQZeoLzQ4bMhw
	 Huh8xS4obtbfYLcN+agsGcQOd4ON6webr8LIiSq1ObjcxaV/2D5KU9Jh028O+Xuc5P
	 FKdpca0Kt95EOrxFgVf6t5HKo1qiVruRazXTfONI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388753AbgF2UDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:03:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:40600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733000AbgF2Tad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:30:33 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47D6F252A8;
        Mon, 29 Jun 2020 15:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593445016;
        bh=pY8EGcIEjvaSxYEoqBZ0j3spqMDbhpQfWO1FvxNGtHs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qQ0rQqwUJf72VP3V7tCzqfV5pgKwJsSf3HyyNwgOstEZDF9wSLYJhXQn4n61oaoRQ
         oIUgiaIUNJoIGr9A3FWlB4AReBe0WKAeJITC20tccM06Po5lwXWCLqTKFDoOac0K69
         SM4C/+Z6JVMN+X4OjbS9mwFcOk6+sLX3Lld387TA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Junxiao Bi <junxiao.bi@oracle.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Changwei Ge <gechangwei@live.cn>, Gang He <ghe@suse.com>,
        Joel Becker <jlbec@evilplan.org>,
        Jun Piao <piaojun@huawei.com>, Mark Fasheh <mark@fasheh.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4.19 115/131] ocfs2: load global_inode_alloc
Date:   Mon, 29 Jun 2020 11:34:46 -0400
Message-Id: <20200629153502.2494656-116-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629153502.2494656-1-sashal@kernel.org>
References: <20200629153502.2494656-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.131-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.131-rc1
X-KernelTest-Deadline: 2020-07-01T15:34+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Junxiao Bi <junxiao.bi@oracle.com>

commit 7569d3c754e452769a5747eeeba488179e38a5da upstream.

Set global_inode_alloc as OCFS2_FIRST_ONLINE_SYSTEM_INODE, that will
make it load during mount.  It can be used to test whether some
global/system inodes are valid.  One use case is that nfsd will test
whether root inode is valid.

Link: http://lkml.kernel.org/r/20200616183829.87211-3-junxiao.bi@oracle.com
Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Changwei Ge <gechangwei@live.cn>
Cc: Gang He <ghe@suse.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Jun Piao <piaojun@huawei.com>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ocfs2/ocfs2_fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ocfs2/ocfs2_fs.h b/fs/ocfs2/ocfs2_fs.h
index 7071ad0dec900..263e28ebeeabe 100644
--- a/fs/ocfs2/ocfs2_fs.h
+++ b/fs/ocfs2/ocfs2_fs.h
@@ -339,8 +339,8 @@ struct ocfs2_system_inode_info {
 enum {
 	BAD_BLOCK_SYSTEM_INODE = 0,
 	GLOBAL_INODE_ALLOC_SYSTEM_INODE,
+#define OCFS2_FIRST_ONLINE_SYSTEM_INODE GLOBAL_INODE_ALLOC_SYSTEM_INODE
 	SLOT_MAP_SYSTEM_INODE,
-#define OCFS2_FIRST_ONLINE_SYSTEM_INODE SLOT_MAP_SYSTEM_INODE
 	HEARTBEAT_SYSTEM_INODE,
 	GLOBAL_BITMAP_SYSTEM_INODE,
 	USER_QUOTA_SYSTEM_INODE,
-- 
2.25.1

