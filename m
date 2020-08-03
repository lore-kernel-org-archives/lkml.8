Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3313CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 10:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 180B720678
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 10:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgHCKQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 06:16:30 -0400
Received: from relay.sw.ru ([185.231.240.75]:37768 "EHLO relay3.sw.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725951AbgHCKQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 06:16:29 -0400
Received: from [192.168.15.50] (helo=localhost.localdomain)
        by relay3.sw.ru with esmtp (Exim 4.93)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1k2XVm-0002Nk-Fm; Mon, 03 Aug 2020 13:16:06 +0300
Subject: [PATCH 3/8] ipc: Use generic ns_common::count
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     christian.brauner@ubuntu.com, akpm@linux-foundation.org,
        ebiederm@xmission.com, viro@zeniv.linux.org.uk,
        adobriyan@gmail.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org, ktkhai@virtuozzo.com
Date:   Mon, 03 Aug 2020 13:16:27 +0300
Message-ID: <159644978697.604812.16592754423881032385.stgit@localhost.localdomain>
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

Convert uts namespace to use generic counter.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 include/linux/ipc_namespace.h |    3 +--
 ipc/msgutil.c                 |    2 +-
 ipc/namespace.c               |    4 ++--
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/linux/ipc_namespace.h b/include/linux/ipc_namespace.h
index a06a78c67f19..05e22770af51 100644
--- a/include/linux/ipc_namespace.h
+++ b/include/linux/ipc_namespace.h
@@ -27,7 +27,6 @@ struct ipc_ids {
 };
 
 struct ipc_namespace {
-	refcount_t	count;
 	struct ipc_ids	ids[3];
 
 	int		sem_ctls[4];
@@ -128,7 +127,7 @@ extern struct ipc_namespace *copy_ipcs(unsigned long flags,
 static inline struct ipc_namespace *get_ipc_ns(struct ipc_namespace *ns)
 {
 	if (ns)
-		refcount_inc(&ns->count);
+		refcount_inc(&ns->ns.count);
 	return ns;
 }
 
diff --git a/ipc/msgutil.c b/ipc/msgutil.c
index 3149b4a379de..d0a0e877cadd 100644
--- a/ipc/msgutil.c
+++ b/ipc/msgutil.c
@@ -26,7 +26,7 @@ DEFINE_SPINLOCK(mq_lock);
  * and not CONFIG_IPC_NS.
  */
 struct ipc_namespace init_ipc_ns = {
-	.count		= REFCOUNT_INIT(1),
+	.ns.count = REFCOUNT_INIT(1),
 	.user_ns = &init_user_ns,
 	.ns.inum = PROC_IPC_INIT_INO,
 #ifdef CONFIG_IPC_NS
diff --git a/ipc/namespace.c b/ipc/namespace.c
index 24e7b45320f7..7bd0766ddc3b 100644
--- a/ipc/namespace.c
+++ b/ipc/namespace.c
@@ -51,7 +51,7 @@ static struct ipc_namespace *create_ipc_ns(struct user_namespace *user_ns,
 		goto fail_free;
 	ns->ns.ops = &ipcns_operations;
 
-	refcount_set(&ns->count, 1);
+	refcount_set(&ns->ns.count, 1);
 	ns->user_ns = get_user_ns(user_ns);
 	ns->ucounts = ucounts;
 
@@ -164,7 +164,7 @@ static DECLARE_WORK(free_ipc_work, free_ipc);
  */
 void put_ipc_ns(struct ipc_namespace *ns)
 {
-	if (refcount_dec_and_lock(&ns->count, &mq_lock)) {
+	if (refcount_dec_and_lock(&ns->ns.count, &mq_lock)) {
 		mq_clear_sbinfo(ns);
 		spin_unlock(&mq_lock);
 


