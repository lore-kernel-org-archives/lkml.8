Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD66C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 15:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBAED20722
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 15:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbgGFPtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 11:49:24 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60980 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729471AbgGFPtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 11:49:23 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jsTMv-0005O9-05; Mon, 06 Jul 2020 15:49:21 +0000
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
Subject: [PATCH v2 2/4] timens: add timens_commit() helper
Date:   Mon,  6 Jul 2020 17:49:10 +0200
Message-Id: <20200706154912.3248030-3-christian.brauner@ubuntu.com>
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

Wrap the calls to timens_set_vvar_page() and vdso_join_timens() in
timens_on_fork() and timens_install() in a new timens_commit() helper.
We'll use this helper in a follow-up patch in nsproxy too.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Reviewed-by: Andrei Vagin <avagin@gmail.com>
Cc: Will Deacon <will@kernel.org>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Dmitry Safonov <dima@arista.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: https://lore.kernel.org/r/20200619153559.724863-3-christian.brauner@ubuntu.com
---
 kernel/time/namespace.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
index e5af6fe87af8..aa7b90aac2a7 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -280,6 +280,12 @@ static void timens_put(struct ns_common *ns)
 	put_time_ns(to_time_ns(ns));
 }
 
+static void timens_commit(struct task_struct *tsk, struct time_namespace *ns)
+{
+	timens_set_vvar_page(tsk, ns);
+	vdso_join_timens(tsk, ns);
+}
+
 static int timens_install(struct nsset *nsset, struct ns_common *new)
 {
 	struct nsproxy *nsproxy = nsset->nsproxy;
@@ -292,9 +298,8 @@ static int timens_install(struct nsset *nsset, struct ns_common *new)
 	    !ns_capable(nsset->cred->user_ns, CAP_SYS_ADMIN))
 		return -EPERM;
 
-	timens_set_vvar_page(current, ns);
 
-	vdso_join_timens(current, ns);
+	timens_commit(current, ns);
 
 	get_time_ns(ns);
 	put_time_ns(nsproxy->time_ns);
@@ -315,14 +320,12 @@ int timens_on_fork(struct nsproxy *nsproxy, struct task_struct *tsk)
 	if (nsproxy->time_ns == nsproxy->time_ns_for_children)
 		return 0;
 
-	timens_set_vvar_page(tsk, ns);
-
-	vdso_join_timens(tsk, ns);
-
 	get_time_ns(ns);
 	put_time_ns(nsproxy->time_ns);
 	nsproxy->time_ns = ns;
 
+	timens_commit(tsk, ns);
+
 	return 0;
 }
 
-- 
2.27.0

