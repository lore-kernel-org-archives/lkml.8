Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0ACC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 10:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61B5A20678
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 10:16:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgHCKQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 06:16:24 -0400
Received: from relay.sw.ru ([185.231.240.75]:37744 "EHLO relay3.sw.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725951AbgHCKQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 06:16:24 -0400
Received: from [192.168.15.50] (helo=localhost.localdomain)
        by relay3.sw.ru with esmtp (Exim 4.93)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1k2XVh-0002NX-6U; Mon, 03 Aug 2020 13:16:01 +0300
Subject: [PATCH 2/8] uts: Use generic ns_common::count
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     christian.brauner@ubuntu.com, akpm@linux-foundation.org,
        ebiederm@xmission.com, viro@zeniv.linux.org.uk,
        adobriyan@gmail.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org, ktkhai@virtuozzo.com
Date:   Mon, 03 Aug 2020 13:16:21 +0300
Message-ID: <159644978167.604812.1773586504374412107.stgit@localhost.localdomain>
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

Convert uts namespace to use generic counter instead of kref.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 include/linux/utsname.h |    9 ++++-----
 init/version.c          |    2 +-
 kernel/utsname.c        |    7 ++-----
 3 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/include/linux/utsname.h b/include/linux/utsname.h
index 44429d9142ca..2b1737c9b244 100644
--- a/include/linux/utsname.h
+++ b/include/linux/utsname.h
@@ -4,7 +4,6 @@
 
 
 #include <linux/sched.h>
-#include <linux/kref.h>
 #include <linux/nsproxy.h>
 #include <linux/ns_common.h>
 #include <linux/err.h>
@@ -22,7 +21,6 @@ struct user_namespace;
 extern struct user_namespace init_user_ns;
 
 struct uts_namespace {
-	struct kref kref;
 	struct new_utsname name;
 	struct user_namespace *user_ns;
 	struct ucounts *ucounts;
@@ -33,16 +31,17 @@ extern struct uts_namespace init_uts_ns;
 #ifdef CONFIG_UTS_NS
 static inline void get_uts_ns(struct uts_namespace *ns)
 {
-	kref_get(&ns->kref);
+	refcount_inc(&ns->ns.count);
 }
 
 extern struct uts_namespace *copy_utsname(unsigned long flags,
 	struct user_namespace *user_ns, struct uts_namespace *old_ns);
-extern void free_uts_ns(struct kref *kref);
+extern void free_uts_ns(struct uts_namespace *ns);
 
 static inline void put_uts_ns(struct uts_namespace *ns)
 {
-	kref_put(&ns->kref, free_uts_ns);
+	if (refcount_dec_and_test(&ns->ns.count))
+		free_uts_ns(ns);
 }
 
 void uts_ns_init(void);
diff --git a/init/version.c b/init/version.c
index cba341161b58..80d2b7566b39 100644
--- a/init/version.c
+++ b/init/version.c
@@ -25,7 +25,7 @@ int version_string(LINUX_VERSION_CODE);
 #endif
 
 struct uts_namespace init_uts_ns = {
-	.kref = KREF_INIT(2),
+	.ns.count = REFCOUNT_INIT(2),
 	.name = {
 		.sysname	= UTS_SYSNAME,
 		.nodename	= UTS_NODENAME,
diff --git a/kernel/utsname.c b/kernel/utsname.c
index e488d0e2ab45..b1ac3ca870f2 100644
--- a/kernel/utsname.c
+++ b/kernel/utsname.c
@@ -33,7 +33,7 @@ static struct uts_namespace *create_uts_ns(void)
 
 	uts_ns = kmem_cache_alloc(uts_ns_cache, GFP_KERNEL);
 	if (uts_ns)
-		kref_init(&uts_ns->kref);
+		refcount_set(&uts_ns->ns.count, 1);
 	return uts_ns;
 }
 
@@ -103,11 +103,8 @@ struct uts_namespace *copy_utsname(unsigned long flags,
 	return new_ns;
 }
 
-void free_uts_ns(struct kref *kref)
+void free_uts_ns(struct uts_namespace *ns)
 {
-	struct uts_namespace *ns;
-
-	ns = container_of(kref, struct uts_namespace, kref);
 	dec_uts_namespaces(ns->ucounts);
 	put_user_ns(ns->user_ns);
 	ns_free_inum(&ns->ns);


