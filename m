Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3664C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 15:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8666320720
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 15:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbgGFPt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 11:49:28 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60985 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729476AbgGFPtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 11:49:24 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jsTMv-0005O9-JL; Mon, 06 Jul 2020 15:49:21 +0000
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
Subject: [PATCH v2 3/4] nsproxy: support CLONE_NEWTIME with setns()
Date:   Mon,  6 Jul 2020 17:49:11 +0200
Message-Id: <20200706154912.3248030-4-christian.brauner@ubuntu.com>
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

So far setns() was missing time namespace support. This was partially due
to it simply not being implemented but also because vdso_join_timens()
could still fail which made switching to multiple namespaces atomically
problematic. This is now fixed so support CLONE_NEWTIME with setns()

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Reviewed-by: Andrei Vagin <avagin@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: Serge Hallyn <serge@hallyn.com>
Cc: Dmitry Safonov <dima@arista.com>
Link: https://lore.kernel.org/r/20200619153559.724863-4-christian.brauner@ubuntu.com
---
 include/linux/time_namespace.h |  6 ++++++
 kernel/nsproxy.c               | 21 +++++++++++++++++++--
 kernel/time/namespace.c        |  5 +----
 3 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
index 824d54e057eb..5b6031385db0 100644
--- a/include/linux/time_namespace.h
+++ b/include/linux/time_namespace.h
@@ -33,6 +33,7 @@ extern struct time_namespace init_time_ns;
 #ifdef CONFIG_TIME_NS
 extern int vdso_join_timens(struct task_struct *task,
 			    struct time_namespace *ns);
+extern void timens_commit(struct task_struct *tsk, struct time_namespace *ns);
 
 static inline struct time_namespace *get_time_ns(struct time_namespace *ns)
 {
@@ -96,6 +97,11 @@ static inline int vdso_join_timens(struct task_struct *task,
 	return 0;
 }
 
+static inline void timens_commit(struct task_struct *tsk,
+				 struct time_namespace *ns)
+{
+}
+
 static inline struct time_namespace *get_time_ns(struct time_namespace *ns)
 {
 	return NULL;
diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
index cd356630a311..12dd41b39a7f 100644
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -262,8 +262,8 @@ void exit_task_namespaces(struct task_struct *p)
 static int check_setns_flags(unsigned long flags)
 {
 	if (!flags || (flags & ~(CLONE_NEWNS | CLONE_NEWUTS | CLONE_NEWIPC |
-				 CLONE_NEWNET | CLONE_NEWUSER | CLONE_NEWPID |
-				 CLONE_NEWCGROUP)))
+				 CLONE_NEWNET | CLONE_NEWTIME | CLONE_NEWUSER |
+				 CLONE_NEWPID | CLONE_NEWCGROUP)))
 		return -EINVAL;
 
 #ifndef CONFIG_USER_NS
@@ -290,6 +290,10 @@ static int check_setns_flags(unsigned long flags)
 	if (flags & CLONE_NEWNET)
 		return -EINVAL;
 #endif
+#ifndef CONFIG_TIME_NS
+	if (flags & CLONE_NEWTIME)
+		return -EINVAL;
+#endif
 
 	return 0;
 }
@@ -464,6 +468,14 @@ static int validate_nsset(struct nsset *nsset, struct pid *pid)
 	}
 #endif
 
+#ifdef CONFIG_TIME_NS
+	if (flags & CLONE_NEWTIME) {
+		ret = validate_ns(nsset, &nsp->time_ns->ns);
+		if (ret)
+			goto out;
+	}
+#endif
+
 out:
 	if (pid_ns)
 		put_pid_ns(pid_ns);
@@ -507,6 +519,11 @@ static void commit_nsset(struct nsset *nsset)
 		exit_sem(me);
 #endif
 
+#ifdef CONFIG_TIME_NS
+	if (flags & CLONE_NEWTIME)
+		timens_commit(me, nsset->nsproxy->time_ns);
+#endif
+
 	/* transfer ownership */
 	switch_task_namespaces(me, nsset->nsproxy);
 	nsset->nsproxy = NULL;
diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
index aa7b90aac2a7..afc65e6be33e 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -280,7 +280,7 @@ static void timens_put(struct ns_common *ns)
 	put_time_ns(to_time_ns(ns));
 }
 
-static void timens_commit(struct task_struct *tsk, struct time_namespace *ns)
+void timens_commit(struct task_struct *tsk, struct time_namespace *ns)
 {
 	timens_set_vvar_page(tsk, ns);
 	vdso_join_timens(tsk, ns);
@@ -298,9 +298,6 @@ static int timens_install(struct nsset *nsset, struct ns_common *new)
 	    !ns_capable(nsset->cred->user_ns, CAP_SYS_ADMIN))
 		return -EPERM;
 
-
-	timens_commit(current, ns);
-
 	get_time_ns(ns);
 	put_time_ns(nsproxy->time_ns);
 	nsproxy->time_ns = ns;
-- 
2.27.0

