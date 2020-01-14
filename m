Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4059BC33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 13:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 184DA24689
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 13:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbgANNEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 08:04:49 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43111 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbgANNCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 08:02:20 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1irLpo-0004cl-6n; Tue, 14 Jan 2020 14:02:16 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D24171C07EC;
        Tue, 14 Jan 2020 14:02:15 +0100 (CET)
Date:   Tue, 14 Jan 2020 13:02:15 -0000
From:   "tip-bot2 for Dmitry Safonov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] time: Allocate per-timens vvar page
Cc:     Andy Lutomirski <luto@kernel.org>, Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191112012724.250792-24-dima@arista.com>
References: <20191112012724.250792-24-dima@arista.com>
MIME-Version: 1.0
Message-ID: <157900693562.396.13657991719182841848.tip-bot2@tip-bot2>
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

Commit-ID:     afaa7b5ac7c87479fb5a626f87d2157af30d6401
Gitweb:        https://git.kernel.org/tip/afaa7b5ac7c87479fb5a626f87d2157af30d6401
Author:        Dmitry Safonov <dima@arista.com>
AuthorDate:    Tue, 12 Nov 2019 01:27:12 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 14 Jan 2020 12:20:58 +01:00

time: Allocate per-timens vvar page

VDSO support for Time namespace needs to set up a page with the same
layout as VVAR. That timens page will be placed on position of VVAR page
inside namespace. That page contains time namespace clock offsets and it
has vdso_data->seq set to 1 to enforce the slow path and
vdso_data->clock_mode set to VCLOCK_TIMENS to enforce the time namespace
handling path.

Allocate the timens page during namespace creation. Setup the offsets
when the first task enters the ns and freeze them to guarantee the pace
of monotonic/boottime clocks and to avoid breakage of applications.

The design decision is to have a global offset_lock which is used during
namespace offsets setup and to freeze offsets when the first task joins the
new time namespace. That is better in terms of memory usage compared to
having a per namespace mutex that's used only during the setup period.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Based-on-work-by: Thomas Gleixner <tglx@linutronix.de>
Co-developed-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20191112012724.250792-24-dima@arista.com


---
 include/linux/time_namespace.h |   3 +-
 kernel/time/namespace.c        | 104 +++++++++++++++++++++++++++++++-
 2 files changed, 106 insertions(+), 1 deletion(-)

diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
index 063a343..6b7767f 100644
--- a/include/linux/time_namespace.h
+++ b/include/linux/time_namespace.h
@@ -23,6 +23,9 @@ struct time_namespace {
 	struct ucounts		*ucounts;
 	struct ns_common	ns;
 	struct timens_offsets	offsets;
+	struct page		*vvar_page;
+	/* If set prevents changing offsets after any task joined namespace. */
+	bool			frozen_offsets;
 } __randomize_layout;
 
 extern struct time_namespace init_time_ns;
diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
index 1a0fbaa..d705c15 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -16,6 +16,8 @@
 #include <linux/err.h>
 #include <linux/mm.h>
 
+#include <vdso/datapage.h>
+
 ktime_t do_timens_ktime_to_host(clockid_t clockid, ktime_t tim,
 				struct timens_offsets *ns_offsets)
 {
@@ -90,16 +92,23 @@ static struct time_namespace *clone_time_ns(struct user_namespace *user_ns,
 
 	kref_init(&ns->kref);
 
+	ns->vvar_page = alloc_page(GFP_KERNEL | __GFP_ZERO);
+	if (!ns->vvar_page)
+		goto fail_free;
+
 	err = ns_alloc_inum(&ns->ns);
 	if (err)
-		goto fail_free;
+		goto fail_free_page;
 
 	ns->ucounts = ucounts;
 	ns->ns.ops = &timens_operations;
 	ns->user_ns = get_user_ns(user_ns);
 	ns->offsets = old_ns->offsets;
+	ns->frozen_offsets = false;
 	return ns;
 
+fail_free_page:
+	__free_page(ns->vvar_page);
 fail_free:
 	kfree(ns);
 fail_dec:
@@ -128,6 +137,93 @@ struct time_namespace *copy_time_ns(unsigned long flags,
 	return clone_time_ns(user_ns, old_ns);
 }
 
+static struct timens_offset offset_from_ts(struct timespec64 off)
+{
+	struct timens_offset ret;
+
+	ret.sec = off.tv_sec;
+	ret.nsec = off.tv_nsec;
+
+	return ret;
+}
+
+/*
+ * A time namespace VVAR page has the same layout as the VVAR page which
+ * contains the system wide VDSO data.
+ *
+ * For a normal task the VVAR pages are installed in the normal ordering:
+ *     VVAR
+ *     PVCLOCK
+ *     HVCLOCK
+ *     TIMENS   <- Not really required
+ *
+ * Now for a timens task the pages are installed in the following order:
+ *     TIMENS
+ *     PVCLOCK
+ *     HVCLOCK
+ *     VVAR
+ *
+ * The check for vdso_data->clock_mode is in the unlikely path of
+ * the seq begin magic. So for the non-timens case most of the time
+ * 'seq' is even, so the branch is not taken.
+ *
+ * If 'seq' is odd, i.e. a concurrent update is in progress, the extra check
+ * for vdso_data->clock_mode is a non-issue. The task is spin waiting for the
+ * update to finish and for 'seq' to become even anyway.
+ *
+ * Timens page has vdso_data->clock_mode set to VCLOCK_TIMENS which enforces
+ * the time namespace handling path.
+ */
+static void timens_setup_vdso_data(struct vdso_data *vdata,
+				   struct time_namespace *ns)
+{
+	struct timens_offset *offset = vdata->offset;
+	struct timens_offset monotonic = offset_from_ts(ns->offsets.monotonic);
+	struct timens_offset boottime = offset_from_ts(ns->offsets.boottime);
+
+	vdata->seq			= 1;
+	vdata->clock_mode		= VCLOCK_TIMENS;
+	offset[CLOCK_MONOTONIC]		= monotonic;
+	offset[CLOCK_MONOTONIC_RAW]	= monotonic;
+	offset[CLOCK_MONOTONIC_COARSE]	= monotonic;
+	offset[CLOCK_BOOTTIME]		= boottime;
+	offset[CLOCK_BOOTTIME_ALARM]	= boottime;
+}
+
+/*
+ * Protects possibly multiple offsets writers racing each other
+ * and tasks entering the namespace.
+ */
+static DEFINE_MUTEX(offset_lock);
+
+static void timens_set_vvar_page(struct task_struct *task,
+				struct time_namespace *ns)
+{
+	struct vdso_data *vdata;
+	unsigned int i;
+
+	if (ns == &init_time_ns)
+		return;
+
+	/* Fast-path, taken by every task in namespace except the first. */
+	if (likely(ns->frozen_offsets))
+		return;
+
+	mutex_lock(&offset_lock);
+	/* Nothing to-do: vvar_page has been already initialized. */
+	if (ns->frozen_offsets)
+		goto out;
+
+	ns->frozen_offsets = true;
+	vdata = arch_get_vdso_data(page_address(ns->vvar_page));
+
+	for (i = 0; i < CS_BASES; i++)
+		timens_setup_vdso_data(&vdata[i], ns);
+
+out:
+	mutex_unlock(&offset_lock);
+}
+
 void free_time_ns(struct kref *kref)
 {
 	struct time_namespace *ns;
@@ -136,6 +232,7 @@ void free_time_ns(struct kref *kref)
 	dec_time_namespaces(ns->ucounts);
 	put_user_ns(ns->user_ns);
 	ns_free_inum(&ns->ns);
+	__free_page(ns->vvar_page);
 	kfree(ns);
 }
 
@@ -192,6 +289,8 @@ static int timens_install(struct nsproxy *nsproxy, struct ns_common *new)
 	    !ns_capable(current_user_ns(), CAP_SYS_ADMIN))
 		return -EPERM;
 
+	timens_set_vvar_page(current, ns);
+
 	get_time_ns(ns);
 	put_time_ns(nsproxy->time_ns);
 	nsproxy->time_ns = ns;
@@ -211,6 +310,8 @@ int timens_on_fork(struct nsproxy *nsproxy, struct task_struct *tsk)
 	if (nsproxy->time_ns == nsproxy->time_ns_for_children)
 		return 0;
 
+	timens_set_vvar_page(tsk, ns);
+
 	get_time_ns(ns);
 	put_time_ns(nsproxy->time_ns);
 	nsproxy->time_ns = ns;
@@ -246,6 +347,7 @@ struct time_namespace init_time_ns = {
 	.user_ns	= &init_user_ns,
 	.ns.inum	= PROC_TIME_INIT_INO,
 	.ns.ops		= &timens_operations,
+	.frozen_offsets	= true,
 };
 
 static int __init time_ns_init(void)
