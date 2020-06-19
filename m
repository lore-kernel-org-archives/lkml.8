Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0D6C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D200206FA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405086AbgFSPgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:36:31 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39847 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391229AbgFSPgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:36:23 -0400
Received: from ip-109-41-0-196.web.vodafone.de ([109.41.0.196] helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jmJ40-0000bE-FM; Fri, 19 Jun 2020 15:36:20 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Serge Hallyn <serge@hallyn.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Safonov <dima@arista.com>,
        Andrei Vagin <avagin@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 1/3] timens: make vdso_join_timens() always succeed
Date:   Fri, 19 Jun 2020 17:35:57 +0200
Message-Id: <20200619153559.724863-2-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619153559.724863-1-christian.brauner@ubuntu.com>
References: <20200619153559.724863-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As discussed on-list (cf. [1]), in order to make setns() support time
namespaces properly we need to tweak vdso_join_timens() to always succeed.
So switch vdso_join_timens() from mmap_write_lock_killable() to
mmap_write_lock().

Last cycle setns() was changed to support attaching to multiple namespaces
atomically. This requires all namespaces to have a point of no return where
they can't fail anymore. Specifically, <namespace-type>_install() is
allowed to perform permission checks and install the namespace into the new
struct nsset that it has been given but it is not allowed to make visible
changes to the affected task. Once <namespace-type>_install() returns
anything that the given namespace type requires to be setup in addition
needs to ideally be done in a function that can't fail or if it fails the
failure is not fatal. For time namespaces the relevant functions that fall
into this category are timens_set_vvar_page() and vdso_join_timens().
Currently the latter can fail but doesn't need to. With this we can go on
to implement a timens_commit() helper in a follow up patch to be used by
setns().

[1]: https://lore.kernel.org/lkml/20200611110221.pgd3r5qkjrjmfqa2@wittgenstein
Cc: Will Deacon <will@kernel.org>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Dmitry Safonov <dima@arista.com>
Cc: Andrei Vagin <avagin@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 arch/x86/entry/vdso/vma.c      |  6 ++----
 include/linux/time_namespace.h |  7 +++----
 kernel/time/namespace.c        | 10 ++--------
 3 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index ea7c1f0b79df..be3f542e419c 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -139,13 +139,12 @@ static struct page *find_timens_vvar_page(struct vm_area_struct *vma)
  * corresponding layout.
  * See also the comment near timens_setup_vdso_data() for details.
  */
-int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
+void vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
 {
 	struct mm_struct *mm = task->mm;
 	struct vm_area_struct *vma;
 
-	if (mmap_write_lock_killable(mm))
-		return -EINTR;
+	mmap_write_lock(mm);
 
 	for (vma = mm->mmap; vma; vma = vma->vm_next) {
 		unsigned long size = vma->vm_end - vma->vm_start;
@@ -155,7 +154,6 @@ int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
 	}
 
 	mmap_write_unlock(mm);
-	return 0;
 }
 #else
 static inline struct page *find_timens_vvar_page(struct vm_area_struct *vma)
diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
index 824d54e057eb..4d1768c6f836 100644
--- a/include/linux/time_namespace.h
+++ b/include/linux/time_namespace.h
@@ -31,8 +31,8 @@ struct time_namespace {
 extern struct time_namespace init_time_ns;
 
 #ifdef CONFIG_TIME_NS
-extern int vdso_join_timens(struct task_struct *task,
-			    struct time_namespace *ns);
+extern void vdso_join_timens(struct task_struct *task,
+			     struct time_namespace *ns);
 
 static inline struct time_namespace *get_time_ns(struct time_namespace *ns)
 {
@@ -90,10 +90,9 @@ static inline ktime_t timens_ktime_to_host(clockid_t clockid, ktime_t tim)
 }
 
 #else
-static inline int vdso_join_timens(struct task_struct *task,
+static inline void vdso_join_timens(struct task_struct *task,
 				   struct time_namespace *ns)
 {
-	return 0;
 }
 
 static inline struct time_namespace *get_time_ns(struct time_namespace *ns)
diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
index 5d9fc22d836a..e5af6fe87af8 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -284,7 +284,6 @@ static int timens_install(struct nsset *nsset, struct ns_common *new)
 {
 	struct nsproxy *nsproxy = nsset->nsproxy;
 	struct time_namespace *ns = to_time_ns(new);
-	int err;
 
 	if (!current_is_single_threaded())
 		return -EUSERS;
@@ -295,9 +294,7 @@ static int timens_install(struct nsset *nsset, struct ns_common *new)
 
 	timens_set_vvar_page(current, ns);
 
-	err = vdso_join_timens(current, ns);
-	if (err)
-		return err;
+	vdso_join_timens(current, ns);
 
 	get_time_ns(ns);
 	put_time_ns(nsproxy->time_ns);
@@ -313,7 +310,6 @@ int timens_on_fork(struct nsproxy *nsproxy, struct task_struct *tsk)
 {
 	struct ns_common *nsc = &nsproxy->time_ns_for_children->ns;
 	struct time_namespace *ns = to_time_ns(nsc);
-	int err;
 
 	/* create_new_namespaces() already incremented the ref counter */
 	if (nsproxy->time_ns == nsproxy->time_ns_for_children)
@@ -321,9 +317,7 @@ int timens_on_fork(struct nsproxy *nsproxy, struct task_struct *tsk)
 
 	timens_set_vvar_page(tsk, ns);
 
-	err = vdso_join_timens(tsk, ns);
-	if (err)
-		return err;
+	vdso_join_timens(tsk, ns);
 
 	get_time_ns(ns);
 	put_time_ns(nsproxy->time_ns);
-- 
2.27.0

