Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA9FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 10:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44CF6206D7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 10:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgHCKQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 06:16:40 -0400
Received: from relay.sw.ru ([185.231.240.75]:37838 "EHLO relay3.sw.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725951AbgHCKQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 06:16:40 -0400
Received: from [192.168.15.50] (helo=localhost.localdomain)
        by relay3.sw.ru with esmtp (Exim 4.93)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1k2XVx-0002O7-37; Mon, 03 Aug 2020 13:16:17 +0300
Subject: [PATCH 5/8] user: Use generic ns_common::count
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     christian.brauner@ubuntu.com, akpm@linux-foundation.org,
        ebiederm@xmission.com, viro@zeniv.linux.org.uk,
        adobriyan@gmail.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org, ktkhai@virtuozzo.com
Date:   Mon, 03 Aug 2020 13:16:37 +0300
Message-ID: <159644979754.604812.601625186726406922.stgit@localhost.localdomain>
In-Reply-To: <159644958332.604812.13004003379291842292.stgit@localhost.localdomain>
References: <159644958332.604812.13004003379291842292.stgit@localhost.localdomain>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert user namespace to use generic counter.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 include/linux/user_namespace.h |    5 ++---
 kernel/user.c                  |    2 +-
 kernel/user_namespace.c        |    4 ++--
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index 6ef1c7109fc4..64cf8ebdc4ec 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -57,7 +57,6 @@ struct user_namespace {
 	struct uid_gid_map	uid_map;
 	struct uid_gid_map	gid_map;
 	struct uid_gid_map	projid_map;
-	atomic_t		count;
 	struct user_namespace	*parent;
 	int			level;
 	kuid_t			owner;
@@ -109,7 +108,7 @@ void dec_ucount(struct ucounts *ucounts, enum ucount_type type);
 static inline struct user_namespace *get_user_ns(struct user_namespace *ns)
 {
 	if (ns)
-		atomic_inc(&ns->count);
+		refcount_inc(&ns->ns.count);
 	return ns;
 }
 
@@ -119,7 +118,7 @@ extern void __put_user_ns(struct user_namespace *ns);
 
 static inline void put_user_ns(struct user_namespace *ns)
 {
-	if (ns && atomic_dec_and_test(&ns->count))
+	if (ns && refcount_dec_and_test(&ns->ns.count))
 		__put_user_ns(ns);
 }
 
diff --git a/kernel/user.c b/kernel/user.c
index b1635d94a1f2..a2478cddf536 100644
--- a/kernel/user.c
+++ b/kernel/user.c
@@ -55,7 +55,7 @@ struct user_namespace init_user_ns = {
 			},
 		},
 	},
-	.count = ATOMIC_INIT(3),
+	.ns.count = REFCOUNT_INIT(3),
 	.owner = GLOBAL_ROOT_UID,
 	.group = GLOBAL_ROOT_GID,
 	.ns.inum = PROC_USER_INIT_INO,
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 87804e0371fe..7c2bbe8f3e45 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -111,7 +111,7 @@ int create_user_ns(struct cred *new)
 		goto fail_free;
 	ns->ns.ops = &userns_operations;
 
-	atomic_set(&ns->count, 1);
+	refcount_set(&ns->ns.count, 1);
 	/* Leave the new->user_ns reference with the new user namespace. */
 	ns->parent = parent_ns;
 	ns->level = parent_ns->level + 1;
@@ -197,7 +197,7 @@ static void free_user_ns(struct work_struct *work)
 		kmem_cache_free(user_ns_cachep, ns);
 		dec_user_namespaces(ucounts);
 		ns = parent;
-	} while (atomic_dec_and_test(&parent->count));
+	} while (refcount_dec_and_test(&parent->ns.count));
 }
 
 void __put_user_ns(struct user_namespace *ns)


