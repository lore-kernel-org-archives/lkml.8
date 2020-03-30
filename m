Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C167C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 23:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59C4820733
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 23:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbgC3XHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 19:07:22 -0400
Received: from icp-osb-irony-out6.external.iinet.net.au ([203.59.1.106]:28018
        "EHLO icp-osb-irony-out6.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728987AbgC3XHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 19:07:22 -0400
X-SMTP-MATCH: 0
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2BdHgD7eoJe/+im0XZmHgELHIFwCwK?=
 =?us-ascii?q?CJ4FhEiqDUkiPTwEBAQEBAQaBEjiJaIUUij6BewoBAQEBAQEBAQEbGQECBAE?=
 =?us-ascii?q?BhESCNCQ2Bw4CEAEBAQUBAQEBAQUDAW2FClhCAQwBhUoEUigNAhgOAkkWE4V?=
 =?us-ascii?q?+JK4YfzMaAoovgQ4qAYwwGnmBB4FEA4E2gWaBF4ZJgl4EkHaHD0WYG4JGlxU?=
 =?us-ascii?q?dj0IDjCctrHAMJoFYTS4KgydQGJx/NzCBBgEBhDWKCgEB?=
X-IPAS-Result: =?us-ascii?q?A2BdHgD7eoJe/+im0XZmHgELHIFwCwKCJ4FhEiqDUkiPT?=
 =?us-ascii?q?wEBAQEBAQaBEjiJaIUUij6BewoBAQEBAQEBAQEbGQECBAEBhESCNCQ2Bw4CE?=
 =?us-ascii?q?AEBAQUBAQEBAQUDAW2FClhCAQwBhUoEUigNAhgOAkkWE4V+JK4YfzMaAoovg?=
 =?us-ascii?q?Q4qAYwwGnmBB4FEA4E2gWaBF4ZJgl4EkHaHD0WYG4JGlxUdj0IDjCctrHAMJ?=
 =?us-ascii?q?oFYTS4KgydQGJx/NzCBBgEBhDWKCgEB?=
X-IronPort-AV: E=Sophos;i="5.72,326,1580745600"; 
   d="scan'208";a="233609802"
Received: from unknown (HELO mickey.themaw.net) ([118.209.166.232])
  by icp-osb-irony-out6.iinet.net.au with ESMTP; 31 Mar 2020 07:06:52 +0800
Subject: [PATCH 1/4] autofs: dont call do_expire_wait() in autofs_d_manage()
From:   Ian Kent <raven@themaw.net>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     autofs mailing list <autofs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 31 Mar 2020 07:06:51 +0800
Message-ID: <158560961146.14841.14430383874338917674.stgit@mickey.themaw.net>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calling do_expire_wait() in autofs_d_manage() isn't really necessary.

If in rcu-walk mode -ECHILD will be returned and if in ref-walk mode
and the dentry might be picked for expire (or is expiring) 0 will be
returned otherwise it waits for the expire.

But waiting is meant to be done in autofs_d_automount() so simplify
autofs_d_manage() by testing the expire status and returning only
what's needed.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/root.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/autofs/root.c b/fs/autofs/root.c
index 5aaa1732bf1e..a3b7c72a298d 100644
--- a/fs/autofs/root.c
+++ b/fs/autofs/root.c
@@ -410,9 +410,12 @@ static int autofs_d_manage(const struct path *path, bool rcu_walk)
 		return 0;
 	}
 
-	/* Wait for pending expires */
-	if (do_expire_wait(path, rcu_walk) == -ECHILD)
-		return -ECHILD;
+	/* Check for (possible) pending expire */
+	if (ino->flags & AUTOFS_INF_WANT_EXPIRE) {
+		if (rcu_walk)
+			return -ECHILD;
+		return 0;
+	}
 
 	/*
 	 * This dentry may be under construction so wait on mount
@@ -432,8 +435,6 @@ static int autofs_d_manage(const struct path *path, bool rcu_walk)
 		 */
 		struct inode *inode;
 
-		if (ino->flags & AUTOFS_INF_WANT_EXPIRE)
-			return 0;
 		if (path_is_mountpoint(path))
 			return 0;
 		inode = d_inode_rcu(dentry);

