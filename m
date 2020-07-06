Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E8AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 15:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85DEE20720
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 15:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729379AbgGFPtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 11:49:25 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60975 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729401AbgGFPtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 11:49:22 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jsTMu-0005O9-Cx; Mon, 06 Jul 2020 15:49:20 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrei Vagin <avagin@gmail.com>,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Serge Hallyn <serge@hallyn.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Safonov <dima@arista.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v2 1/4] timens: make vdso_join_timens() always succeed
Date:   Mon,  6 Jul 2020 17:49:09 +0200
Message-Id: <20200706154912.3248030-2-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200706154912.3248030-1-christian.brauner@ubuntu.com>
References: <https://lore.kernel.org/lkml/20200625090618.GC151695@gmail.com>
 <20200706154912.3248030-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As discussed on-list (cf. [1]), in order to make setns() support time
namespaces when attaching to multiple namespaces at once properly we
need to tweak vdso_join_timens() to always succeed. So switch
vdso_join_timens() to using a read lock and replacing
mmap_write_lock_killable() to mmap_read_lock() as we discussed.

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

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Reviewed-by: Andrei Vagin <avagin@gmail.com>
Cc: Will Deacon <will@kernel.org>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Dmitry Safonov <dima@arista.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: https://lore.kernel.org/r/20200619153559.724863-2-christian.brauner@ubuntu.com
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 arch/x86/entry/vdso/vma.c |  5 ++---
 kernel/time/namespace.c   | 10 ++--------
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index ea7c1f0b79df..9185cb1d13b9 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -144,8 +144,7 @@ int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
 	struct mm_struct *mm = task->mm;
 	struct vm_area_struct *vma;
 
-	if (mmap_write_lock_killable(mm))
-		return -EINTR;
+	mmap_read_lock(mm);
 
 	for (vma = mm->mmap; vma; vma = vma->vm_next) {
 		unsigned long size = vma->vm_end - vma->vm_start;
@@ -154,7 +153,7 @@ int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
 			zap_page_range(vma, vma->vm_start, size);
 	}
 
-	mmap_write_unlock(mm);
+	mmap_read_unlock(mm);
 	return 0;
 }
 #else
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

