Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2EB4C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 02:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73F1120748
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 02:00:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgHUCAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 22:00:03 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:53790 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727070AbgHUCAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 22:00:00 -0400
X-IronPort-AV: E=Sophos;i="5.76,335,1592841600"; 
   d="scan'208";a="98365593"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 21 Aug 2020 09:59:58 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 0A8DF48990C1;
        Fri, 21 Aug 2020 09:59:56 +0800 (CST)
Received: from G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Fri, 21 Aug 2020 09:59:55 +0800
Received: from localhost.localdomain (10.167.225.206) by
 G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Fri, 21 Aug 2020 09:59:55 +0800
From:   Hao Li <lihao2018.fnst@cn.fujitsu.com>
To:     <viro@zeniv.linux.org.uk>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lihao2018.fnst@cn.fujitsu.com>, <y-goto@fujitsu.com>
Subject: [PATCH] fs: Kill DCACHE_DONTCACHE dentry even if DCACHE_REFERENCED is set
Date:   Fri, 21 Aug 2020 09:59:53 +0800
Message-ID: <20200821015953.22956-1-lihao2018.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 0A8DF48990C1.A0C10
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lihao2018.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, DCACHE_REFERENCED prevents the dentry with DCACHE_DONTCACHE
set from being killed, so the corresponding inode can't be evicted. If
the DAX policy of an inode is changed, we can't make policy changing
take effects unless dropping caches manually.

This patch fixes this problem and flushes the inode to disk to prepare
for evicting it.

Signed-off-by: Hao Li <lihao2018.fnst@cn.fujitsu.com>
---
 fs/dcache.c | 3 ++-
 fs/inode.c  | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index ea0485861d93..486c7409dc82 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -796,7 +796,8 @@ static inline bool fast_dput(struct dentry *dentry)
 	 */
 	smp_rmb();
 	d_flags = READ_ONCE(dentry->d_flags);
-	d_flags &= DCACHE_REFERENCED | DCACHE_LRU_LIST | DCACHE_DISCONNECTED;
+	d_flags &= DCACHE_REFERENCED | DCACHE_LRU_LIST | DCACHE_DISCONNECTED
+			| DCACHE_DONTCACHE;
 
 	/* Nothing to do? Dropping the reference was all we needed? */
 	if (d_flags == (DCACHE_REFERENCED | DCACHE_LRU_LIST) && !d_unhashed(dentry))
diff --git a/fs/inode.c b/fs/inode.c
index 72c4c347afb7..5218a8aebd7f 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1632,7 +1632,7 @@ static void iput_final(struct inode *inode)
 	}
 
 	state = inode->i_state;
-	if (!drop) {
+	if (!drop || (drop && (inode->i_state & I_DONTCACHE))) {
 		WRITE_ONCE(inode->i_state, state | I_WILL_FREE);
 		spin_unlock(&inode->i_lock);
 
-- 
2.28.0



