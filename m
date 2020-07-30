Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5491DC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 12:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23B1320829
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 12:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbgG3L77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 07:59:59 -0400
Received: from relay.sw.ru ([185.231.240.75]:56584 "EHLO relay3.sw.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728068AbgG3L7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 07:59:55 -0400
Received: from [192.168.15.64] (helo=localhost.localdomain)
        by relay3.sw.ru with esmtp (Exim 4.93)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1k17Dm-0002wZ-LI; Thu, 30 Jul 2020 14:59:38 +0300
Subject: [PATCH 06/23] mnt: Use generic ns_common::count
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     viro@zeniv.linux.org.uk, adobriyan@gmail.com, davem@davemloft.net,
        ebiederm@xmission.com, akpm@linux-foundation.org,
        christian.brauner@ubuntu.com, areber@redhat.com, serge@hallyn.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ktkhai@virtuozzo.com
Date:   Thu, 30 Jul 2020 14:59:52 +0300
Message-ID: <159611039253.535980.5974330310695200570.stgit@localhost.localdomain>
In-Reply-To: <159611007271.535980.15362304262237658692.stgit@localhost.localdomain>
References: <159611007271.535980.15362304262237658692.stgit@localhost.localdomain>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert mount namespace to use generic counter.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 fs/mount.h     |    3 +--
 fs/namespace.c |    4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/mount.h b/fs/mount.h
index c3e0bb6e5782..f296862032ec 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -7,7 +7,6 @@
 #include <linux/watch_queue.h>
 
 struct mnt_namespace {
-	atomic_t		count;
 	struct ns_common	ns;
 	struct mount *	root;
 	/*
@@ -130,7 +129,7 @@ static inline void detach_mounts(struct dentry *dentry)
 
 static inline void get_mnt_ns(struct mnt_namespace *ns)
 {
-	atomic_inc(&ns->count);
+	refcount_inc(&ns->ns.count);
 }
 
 extern seqlock_t mount_lock;
diff --git a/fs/namespace.c b/fs/namespace.c
index 31c387794fbd..8c39810e6ec3 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3296,7 +3296,7 @@ static struct mnt_namespace *alloc_mnt_ns(struct user_namespace *user_ns, bool a
 	new_ns->ns.ops = &mntns_operations;
 	if (!anon)
 		new_ns->seq = atomic64_add_return(1, &mnt_ns_seq);
-	atomic_set(&new_ns->count, 1);
+	refcount_set(&new_ns->ns.count, 1);
 	INIT_LIST_HEAD(&new_ns->list);
 	init_waitqueue_head(&new_ns->poll);
 	spin_lock_init(&new_ns->ns_lock);
@@ -3870,7 +3870,7 @@ void __init mnt_init(void)
 
 void put_mnt_ns(struct mnt_namespace *ns)
 {
-	if (!atomic_dec_and_test(&ns->count))
+	if (!refcount_dec_and_test(&ns->ns.count))
 		return;
 	drop_collected_mounts(&ns->root->mnt);
 	free_mnt_ns(ns);


