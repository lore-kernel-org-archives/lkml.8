Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1824AC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB8512075E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597918600;
	bh=6dI0CNvOKwmuS/gIjbOsji8rI6oY/jW+DitWteIa12w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UTQZO01nmAymwMTxaUPQFk1OBTVtZq2HMvl1jVm0RYw2c/TowJmc60kN51Kj8I7zU
	 MrKCwcL7egXjwLUKmcbSEovVLrUDibQ/Hcf38b97NtWCNq4jEmYvwCOdw0LBfdbuBY
	 xGr+yRO8ZOqXlju1XZFeHq1/ENXW8gQUinzHo0zI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731282AbgHTKQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:16:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:36684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728498AbgHTKQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:16:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3B2C20885;
        Thu, 20 Aug 2020 10:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597918586;
        bh=6dI0CNvOKwmuS/gIjbOsji8rI6oY/jW+DitWteIa12w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NEPKq3OCHX5yBxQ9NDa1ZibJQIHJKipSO/fpUZwZVJsJS+6br64t9rIy/YJg7F3CH
         gp0XI5bTPKwOHhmQicqKsOe/m6lJzWEM9aVDjARYqt0sfHHTwMYJGqnQ1dy6YZYiFA
         7MRwrQPPsui/Ux+Va5wkw7i9QYxN3B3VeHwhZOk4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Junxiao Bi <junxiao.bi@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Gang He <ghe@suse.com>, Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Changwei Ge <gechangwei@live.cn>,
        Jun Piao <piaojun@huawei.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 184/228] ocfs2: change slot number type s16 to u16
Date:   Thu, 20 Aug 2020 11:22:39 +0200
Message-Id: <20200820091616.770989662@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091607.532711107@linuxfoundation.org>
References: <20200820091607.532711107@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Junxiao Bi <junxiao.bi@oracle.com>

commit 38d51b2dd171ad973afc1f5faab825ed05a2d5e9 upstream.

Dan Carpenter reported the following static checker warning.

	fs/ocfs2/super.c:1269 ocfs2_parse_options() warn: '(-1)' 65535 can't fit into 32767 'mopt->slot'
	fs/ocfs2/suballoc.c:859 ocfs2_init_inode_steal_slot() warn: '(-1)' 65535 can't fit into 32767 'osb->s_inode_steal_slot'
	fs/ocfs2/suballoc.c:867 ocfs2_init_meta_steal_slot() warn: '(-1)' 65535 can't fit into 32767 'osb->s_meta_steal_slot'

That's because OCFS2_INVALID_SLOT is (u16)-1. Slot number in ocfs2 can be
never negative, so change s16 to u16.

Fixes: 9277f8334ffc ("ocfs2: fix value of OCFS2_INVALID_SLOT")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Reviewed-by: Gang He <ghe@suse.com>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Changwei Ge <gechangwei@live.cn>
Cc: Jun Piao <piaojun@huawei.com>
Cc: <stable@vger.kernel.org>
Link: http://lkml.kernel.org/r/20200627001259.19757-1-junxiao.bi@oracle.com
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ocfs2/ocfs2.h    |    4 ++--
 fs/ocfs2/suballoc.c |    4 ++--
 fs/ocfs2/super.c    |    4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

--- a/fs/ocfs2/ocfs2.h
+++ b/fs/ocfs2/ocfs2.h
@@ -336,8 +336,8 @@ struct ocfs2_super
 	spinlock_t osb_lock;
 	u32 s_next_generation;
 	unsigned long osb_flags;
-	s16 s_inode_steal_slot;
-	s16 s_meta_steal_slot;
+	u16 s_inode_steal_slot;
+	u16 s_meta_steal_slot;
 	atomic_t s_num_inodes_stolen;
 	atomic_t s_num_meta_stolen;
 
--- a/fs/ocfs2/suballoc.c
+++ b/fs/ocfs2/suballoc.c
@@ -895,9 +895,9 @@ static void __ocfs2_set_steal_slot(struc
 {
 	spin_lock(&osb->osb_lock);
 	if (type == INODE_ALLOC_SYSTEM_INODE)
-		osb->s_inode_steal_slot = slot;
+		osb->s_inode_steal_slot = (u16)slot;
 	else if (type == EXTENT_ALLOC_SYSTEM_INODE)
-		osb->s_meta_steal_slot = slot;
+		osb->s_meta_steal_slot = (u16)slot;
 	spin_unlock(&osb->osb_lock);
 }
 
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -92,7 +92,7 @@ struct mount_options
 	unsigned long	commit_interval;
 	unsigned long	mount_opt;
 	unsigned int	atime_quantum;
-	signed short	slot;
+	unsigned short	slot;
 	int		localalloc_opt;
 	unsigned int	resv_level;
 	int		dir_resv_level;
@@ -1369,7 +1369,7 @@ static int ocfs2_parse_options(struct su
 				goto bail;
 			}
 			if (option)
-				mopt->slot = (s16)option;
+				mopt->slot = (u16)option;
 			break;
 		case Opt_commit:
 			if (match_int(&args[0], &option)) {


