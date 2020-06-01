Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39074C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B9D1206A4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgFAJWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 05:22:23 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:35100 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725838AbgFAJWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 05:22:22 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1631E9C89EA068D77DAA;
        Mon,  1 Jun 2020 17:22:20 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Mon, 1 Jun 2020
 17:22:11 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <linux-afs@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <dhowells@redhat.com>, <yi.zhang@huawei.com>
Subject: [PATCH] afs: Fix memory leak in afs_put_sysnames()
Date:   Mon, 1 Jun 2020 17:21:50 +0800
Message-ID: <20200601092150.3798343-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sysnames should be freed after refcnt being decreased to zero in
afs_put_sysnames(). Besides, it would be better set net->sysnames
to 'NULL' after net->sysnames being released if afs_put_sysnames()
aims on an afs_sysnames object.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Cc: <Stable@vger.kernel.org> # v4.17+
Fixes: 6f8880d8e681557 ("afs: Implement @sys substitution handling")
---
 fs/afs/dir.c      |  2 +-
 fs/afs/internal.h |  2 ++
 fs/afs/main.c     |  4 ++--
 fs/afs/proc.c     | 25 ++++++++++++++++++++-----
 4 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index d1e1caa23c8b..cb9d8aa91048 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -894,7 +894,7 @@ static struct dentry *afs_lookup_atsys(struct inode *dir, struct dentry *dentry,
 	 */
 	ret = NULL;
 out_s:
-	afs_put_sysnames(subs);
+	afs_put_sysnames_and_null(net);
 	kfree(buf);
 out_p:
 	key_put(key);
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 80255513e230..615dd5f9ad6f 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1093,12 +1093,14 @@ extern void __net_exit afs_proc_cleanup(struct afs_net *);
 extern int afs_proc_cell_setup(struct afs_cell *);
 extern void afs_proc_cell_remove(struct afs_cell *);
 extern void afs_put_sysnames(struct afs_sysnames *);
+extern void afs_put_sysnames_and_null(struct afs_net *);
 #else
 static inline int afs_proc_init(struct afs_net *net) { return 0; }
 static inline void afs_proc_cleanup(struct afs_net *net) {}
 static inline int afs_proc_cell_setup(struct afs_cell *cell) { return 0; }
 static inline void afs_proc_cell_remove(struct afs_cell *cell) {}
 static inline void afs_put_sysnames(struct afs_sysnames *sysnames) {}
+static inline void afs_put_sysnames_and_null(struct afs_net *net) {}
 #endif
 
 /*
diff --git a/fs/afs/main.c b/fs/afs/main.c
index c9c45d7078bd..6bf73fc65fb5 100644
--- a/fs/afs/main.c
+++ b/fs/afs/main.c
@@ -132,7 +132,7 @@ static int __net_init afs_net_init(struct net *net_ns)
 	net->live = false;
 	afs_proc_cleanup(net);
 error_proc:
-	afs_put_sysnames(net->sysnames);
+	afs_put_sysnames_and_null(net);
 error_sysnames:
 	net->live = false;
 	return ret;
@@ -150,7 +150,7 @@ static void __net_exit afs_net_exit(struct net *net_ns)
 	afs_purge_servers(net);
 	afs_close_socket(net);
 	afs_proc_cleanup(net);
-	afs_put_sysnames(net->sysnames);
+	afs_put_sysnames_and_null(net);
 }
 
 static struct pernet_operations afs_net_ops = {
diff --git a/fs/afs/proc.c b/fs/afs/proc.c
index 468e1713bce1..26e1e73281a6 100644
--- a/fs/afs/proc.c
+++ b/fs/afs/proc.c
@@ -554,15 +554,30 @@ static int afs_proc_sysname_write(struct file *file, char *buf, size_t size)
 	goto out;
 }
 
-void afs_put_sysnames(struct afs_sysnames *sysnames)
+static void afs_free_sysnames(struct afs_sysnames *sysnames)
 {
 	int i;
 
+	for (i = 0; i < sysnames->nr; i++)
+		if (sysnames->subs[i] != afs_init_sysname &&
+		    sysnames->subs[i] != sysnames->blank)
+			kfree(sysnames->subs[i]);
+	kfree(sysnames);
+}
+
+void afs_put_sysnames(struct afs_sysnames *sysnames)
+{
+	if (sysnames && refcount_dec_and_test(&sysnames->usage))
+		afs_free_sysnames(sysnames);
+}
+
+void afs_put_sysnames_and_null(struct afs_net *net)
+{
+	struct afs_sysnames *sysnames = net->sysnames;
+
 	if (sysnames && refcount_dec_and_test(&sysnames->usage)) {
-		for (i = 0; i < sysnames->nr; i++)
-			if (sysnames->subs[i] != afs_init_sysname &&
-			    sysnames->subs[i] != sysnames->blank)
-				kfree(sysnames->subs[i]);
+		afs_free_sysnames(sysnames);
+		net->sysnames = NULL;
 	}
 }
 
-- 
2.25.4

