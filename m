Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D151C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 10:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71581206D7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 10:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgHCKRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 06:17:04 -0400
Received: from relay.sw.ru ([185.231.240.75]:37986 "EHLO relay3.sw.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725951AbgHCKRD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 06:17:03 -0400
Received: from [192.168.15.50] (helo=localhost.localdomain)
        by relay3.sw.ru with esmtp (Exim 4.93)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1k2XWJ-0002Oe-Qa; Mon, 03 Aug 2020 13:16:39 +0300
Subject: [PATCH 8/8] time: Use generic ns_common::count
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     christian.brauner@ubuntu.com, akpm@linux-foundation.org,
        ebiederm@xmission.com, viro@zeniv.linux.org.uk,
        adobriyan@gmail.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org, ktkhai@virtuozzo.com
Date:   Mon, 03 Aug 2020 13:17:00 +0300
Message-ID: <159644982033.604812.9406853013011123238.stgit@localhost.localdomain>
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

Convert time namespace to use generic counter.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 include/linux/time_namespace.h |    9 ++++-----
 kernel/time/namespace.c        |    9 +++------
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
index 5b6031385db0..a51ffc089219 100644
--- a/include/linux/time_namespace.h
+++ b/include/linux/time_namespace.h
@@ -4,7 +4,6 @@
 
 
 #include <linux/sched.h>
-#include <linux/kref.h>
 #include <linux/nsproxy.h>
 #include <linux/ns_common.h>
 #include <linux/err.h>
@@ -18,7 +17,6 @@ struct timens_offsets {
 };
 
 struct time_namespace {
-	struct kref		kref;
 	struct user_namespace	*user_ns;
 	struct ucounts		*ucounts;
 	struct ns_common	ns;
@@ -37,20 +35,21 @@ extern void timens_commit(struct task_struct *tsk, struct time_namespace *ns);
 
 static inline struct time_namespace *get_time_ns(struct time_namespace *ns)
 {
-	kref_get(&ns->kref);
+	refcount_inc(&ns->ns.count);
 	return ns;
 }
 
 struct time_namespace *copy_time_ns(unsigned long flags,
 				    struct user_namespace *user_ns,
 				    struct time_namespace *old_ns);
-void free_time_ns(struct kref *kref);
+void free_time_ns(struct time_namespace *ns);
 int timens_on_fork(struct nsproxy *nsproxy, struct task_struct *tsk);
 struct vdso_data *arch_get_vdso_data(void *vvar_page);
 
 static inline void put_time_ns(struct time_namespace *ns)
 {
-	kref_put(&ns->kref, free_time_ns);
+	if (refcount_dec_and_test(&ns->ns.count))
+		free_time_ns(ns);
 }
 
 void proc_timens_show_offsets(struct task_struct *p, struct seq_file *m);
diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
index afc65e6be33e..c4c829eb3511 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -92,7 +92,7 @@ static struct time_namespace *clone_time_ns(struct user_namespace *user_ns,
 	if (!ns)
 		goto fail_dec;
 
-	kref_init(&ns->kref);
+	refcount_set(&ns->ns.count, 1);
 
 	ns->vvar_page = alloc_page(GFP_KERNEL | __GFP_ZERO);
 	if (!ns->vvar_page)
@@ -226,11 +226,8 @@ static void timens_set_vvar_page(struct task_struct *task,
 	mutex_unlock(&offset_lock);
 }
 
-void free_time_ns(struct kref *kref)
+void free_time_ns(struct time_namespace *ns)
 {
-	struct time_namespace *ns;
-
-	ns = container_of(kref, struct time_namespace, kref);
 	dec_time_namespaces(ns->ucounts);
 	put_user_ns(ns->user_ns);
 	ns_free_inum(&ns->ns);
@@ -464,7 +461,7 @@ const struct proc_ns_operations timens_for_children_operations = {
 };
 
 struct time_namespace init_time_ns = {
-	.kref		= KREF_INIT(3),
+	.ns.count	= REFCOUNT_INIT(3),
 	.user_ns	= &init_user_ns,
 	.ns.inum	= PROC_TIME_INIT_INO,
 	.ns.ops		= &timens_operations,


