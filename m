Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D2FC33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 19:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A58B2222C4
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 19:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729439AbgAMTML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 14:12:11 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39838 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728633AbgAMTJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 14:09:29 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ir55a-0000wR-JZ; Mon, 13 Jan 2020 20:09:26 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 229731C18DA;
        Mon, 13 Jan 2020 20:09:26 +0100 (CET)
Date:   Mon, 13 Jan 2020 19:09:25 -0000
From:   "tip-bot2 for Dmitry Safonov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] x86/vdso: Zap vvar pages when switching to a time
 namespace
Cc:     Andrei Vagin <avagin@gmail.com>, Dmitry Safonov <dima@arista.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191112012724.250792-27-dima@arista.com>
References: <20191112012724.250792-27-dima@arista.com>
MIME-Version: 1.0
Message-ID: <157894256597.19145.2579311477753145409.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     fa8acdc8f8f58be60e43bae6ead83c7dd332337a
Gitweb:        https://git.kernel.org/tip/fa8acdc8f8f58be60e43bae6ead83c7dd332337a
Author:        Dmitry Safonov <dima@arista.com>
AuthorDate:    Tue, 12 Nov 2019 01:27:15 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 13 Jan 2020 08:10:57 +01:00

x86/vdso: Zap vvar pages when switching to a time namespace

The VVAR page layout depends on whether a task belongs to the root or
non-root time namespace. Whenever a task changes its namespace, the VVAR
page tables are cleared and then they will be re-faulted with a
corresponding layout.

Co-developed-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20191112012724.250792-27-dima@arista.com

---
 arch/x86/entry/vdso/vma.c      | 27 +++++++++++++++++++++++++++
 include/linux/time_namespace.h |  9 +++++++++
 kernel/time/namespace.c        | 10 ++++++++++
 3 files changed, 46 insertions(+)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index d2fd8a5..c1b8496 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -51,6 +51,7 @@ void __init init_vdso_image(const struct vdso_image *image)
 						image->alt_len));
 }
 
+static const struct vm_special_mapping vvar_mapping;
 struct linux_binprm;
 
 static vm_fault_t vdso_fault(const struct vm_special_mapping *sm,
@@ -128,6 +129,32 @@ static struct page *find_timens_vvar_page(struct vm_area_struct *vma)
 
 	return NULL;
 }
+
+/*
+ * The vvar page layout depends on whether a task belongs to the root or
+ * non-root time namespace. Whenever a task changes its namespace, the VVAR
+ * page tables are cleared and then they will re-faulted with a
+ * corresponding layout.
+ * See also the comment near timens_setup_vdso_data() for details.
+ */
+int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
+{
+	struct mm_struct *mm = task->mm;
+	struct vm_area_struct *vma;
+
+	if (down_write_killable(&mm->mmap_sem))
+		return -EINTR;
+
+	for (vma = mm->mmap; vma; vma = vma->vm_next) {
+		unsigned long size = vma->vm_end - vma->vm_start;
+
+		if (vma_is_special_mapping(vma, &vvar_mapping))
+			zap_page_range(vma, vma->vm_start, size);
+	}
+
+	up_write(&mm->mmap_sem);
+	return 0;
+}
 #else
 static inline struct page *find_timens_vvar_page(struct vm_area_struct *vma)
 {
diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
index 6b7767f..04a2ba8 100644
--- a/include/linux/time_namespace.h
+++ b/include/linux/time_namespace.h
@@ -31,6 +31,9 @@ struct time_namespace {
 extern struct time_namespace init_time_ns;
 
 #ifdef CONFIG_TIME_NS
+extern int vdso_join_timens(struct task_struct *task,
+			    struct time_namespace *ns);
+
 static inline struct time_namespace *get_time_ns(struct time_namespace *ns)
 {
 	kref_get(&ns->kref);
@@ -77,6 +80,12 @@ static inline ktime_t timens_ktime_to_host(clockid_t clockid, ktime_t tim)
 }
 
 #else
+static inline int vdso_join_timens(struct task_struct *task,
+				   struct time_namespace *ns)
+{
+	return 0;
+}
+
 static inline struct time_namespace *get_time_ns(struct time_namespace *ns)
 {
 	return NULL;
diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
index d705c15..0732964 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -281,6 +281,7 @@ static void timens_put(struct ns_common *ns)
 static int timens_install(struct nsproxy *nsproxy, struct ns_common *new)
 {
 	struct time_namespace *ns = to_time_ns(new);
+	int err;
 
 	if (!current_is_single_threaded())
 		return -EUSERS;
@@ -291,6 +292,10 @@ static int timens_install(struct nsproxy *nsproxy, struct ns_common *new)
 
 	timens_set_vvar_page(current, ns);
 
+	err = vdso_join_timens(current, ns);
+	if (err)
+		return err;
+
 	get_time_ns(ns);
 	put_time_ns(nsproxy->time_ns);
 	nsproxy->time_ns = ns;
@@ -305,6 +310,7 @@ int timens_on_fork(struct nsproxy *nsproxy, struct task_struct *tsk)
 {
 	struct ns_common *nsc = &nsproxy->time_ns_for_children->ns;
 	struct time_namespace *ns = to_time_ns(nsc);
+	int err;
 
 	/* create_new_namespaces() already incremented the ref counter */
 	if (nsproxy->time_ns == nsproxy->time_ns_for_children)
@@ -312,6 +318,10 @@ int timens_on_fork(struct nsproxy *nsproxy, struct task_struct *tsk)
 
 	timens_set_vvar_page(tsk, ns);
 
+	err = vdso_join_timens(tsk, ns);
+	if (err)
+		return err;
+
 	get_time_ns(ns);
 	put_time_ns(nsproxy->time_ns);
 	nsproxy->time_ns = ns;
