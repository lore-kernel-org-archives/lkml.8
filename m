Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7AAC33CAA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 03:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4727F24650
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 03:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbgAUDhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 22:37:23 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:53982 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726935AbgAUDhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 22:37:22 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0ToGalaE_1579577838;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0ToGalaE_1579577838)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Jan 2020 11:37:18 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        ChenGang <cg.chen@huawei.com>,
        Richard Fontana <rfontana@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: [PATCH] OCFS2: remove useless err
Date:   Tue, 21 Jan 2020 11:37:16 +0800
Message-Id: <1579577836-251879-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need 'err' in these 2 places, better to remove them.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Mark Fasheh <mark@fasheh.com> 
Cc: Joel Becker <jlbec@evilplan.org> 
Cc: Joseph Qi <joseph.qi@linux.alibaba.com> 
Cc: Andrew Morton <akpm@linux-foundation.org> 
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org> 
Cc: Kate Stewart <kstewart@linuxfoundation.org> 
Cc: ChenGang <cg.chen@huawei.com> 
Cc: Richard Fontana <rfontana@redhat.com> 
Cc: Thomas Gleixner <tglx@linutronix.de> 
Cc: ocfs2-devel@oss.oracle.com 
Cc: linux-kernel@vger.kernel.org 
---
 fs/ocfs2/cluster/tcp.c | 3 +--
 fs/ocfs2/dir.c         | 4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/ocfs2/cluster/tcp.c b/fs/ocfs2/cluster/tcp.c
index 48a3398f0bf5..9261c1f06a9f 100644
--- a/fs/ocfs2/cluster/tcp.c
+++ b/fs/ocfs2/cluster/tcp.c
@@ -1948,7 +1948,6 @@ static void o2net_accept_many(struct work_struct *work)
 {
 	struct socket *sock = o2net_listen_sock;
 	int	more;
-	int	err;
 
 	/*
 	 * It is critical to note that due to interrupt moderation
@@ -1963,7 +1962,7 @@ static void o2net_accept_many(struct work_struct *work)
 	 */
 
 	for (;;) {
-		err = o2net_accept_one(sock, &more);
+		o2net_accept_one(sock, &more);
 		if (!more)
 			break;
 		cond_resched();
diff --git a/fs/ocfs2/dir.c b/fs/ocfs2/dir.c
index bdef72c0f099..5761060d2ba8 100644
--- a/fs/ocfs2/dir.c
+++ b/fs/ocfs2/dir.c
@@ -676,7 +676,7 @@ static struct buffer_head *ocfs2_find_entry_el(const char *name, int namelen,
 	int ra_ptr = 0;		/* Current index into readahead
 				   buffer */
 	int num = 0;
-	int nblocks, i, err;
+	int nblocks, i;
 
 	sb = dir->i_sb;
 
@@ -708,7 +708,7 @@ static struct buffer_head *ocfs2_find_entry_el(const char *name, int namelen,
 				num++;
 
 				bh = NULL;
-				err = ocfs2_read_dir_block(dir, b++, &bh,
+				ocfs2_read_dir_block(dir, b++, &bh,
 							   OCFS2_BH_READAHEAD);
 				bh_use[ra_max] = bh;
 			}
-- 
1.8.3.1

