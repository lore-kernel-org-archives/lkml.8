Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C06FC33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 19:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CFBE24655
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 19:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbgAMTKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 14:10:41 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39985 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729009AbgAMTJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 14:09:53 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ir55s-00018B-Tp; Mon, 13 Jan 2020 20:09:45 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5CBFF1C18ED;
        Mon, 13 Jan 2020 20:09:31 +0100 (CET)
Date:   Mon, 13 Jan 2020 19:09:31 -0000
From:   "tip-bot2 for Andrei Vagin" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] time: Add timens_offsets to be used for tasks in
 time namespace
Cc:     Andrei Vagin <avagin@openvz.org>, Dmitry Safonov <dima@arista.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191112012724.250792-5-dima@arista.com>
References: <20191112012724.250792-5-dima@arista.com>
MIME-Version: 1.0
Message-ID: <157894257123.19145.5195489599326442618.tip-bot2@tip-bot2>
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

Commit-ID:     cad1baec2018c6c0776c4b6a49532b9e44dc3f14
Gitweb:        https://git.kernel.org/tip/cad1baec2018c6c0776c4b6a49532b9e44dc3f14
Author:        Andrei Vagin <avagin@openvz.org>
AuthorDate:    Tue, 12 Nov 2019 01:26:53 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 13 Jan 2020 08:10:48 +01:00

time: Add timens_offsets to be used for tasks in time namespace

Introduce offsets for time namespace. They will contain an adjustment
needed to convert clocks to/from host's.

A new namespace is created with the same offsets as the time namespace
of the current process.

Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20191112012724.250792-5-dima@arista.com

---
 include/linux/time_namespace.h | 22 ++++++++++++++++++++++
 kernel/time/namespace.c        |  2 ++
 2 files changed, 24 insertions(+)

diff --git a/include/linux/time_namespace.h b/include/linux/time_namespace.h
index 8c74cc1..d7e3b49 100644
--- a/include/linux/time_namespace.h
+++ b/include/linux/time_namespace.h
@@ -12,11 +12,17 @@
 struct user_namespace;
 extern struct user_namespace init_user_ns;
 
+struct timens_offsets {
+	struct timespec64 monotonic;
+	struct timespec64 boottime;
+};
+
 struct time_namespace {
 	struct kref		kref;
 	struct user_namespace	*user_ns;
 	struct ucounts		*ucounts;
 	struct ns_common	ns;
+	struct timens_offsets	offsets;
 } __randomize_layout;
 
 extern struct time_namespace init_time_ns;
@@ -39,6 +45,20 @@ static inline void put_time_ns(struct time_namespace *ns)
 	kref_put(&ns->kref, free_time_ns);
 }
 
+static inline void timens_add_monotonic(struct timespec64 *ts)
+{
+	struct timens_offsets *ns_offsets = &current->nsproxy->time_ns->offsets;
+
+	*ts = timespec64_add(*ts, ns_offsets->monotonic);
+}
+
+static inline void timens_add_boottime(struct timespec64 *ts)
+{
+	struct timens_offsets *ns_offsets = &current->nsproxy->time_ns->offsets;
+
+	*ts = timespec64_add(*ts, ns_offsets->boottime);
+}
+
 #else
 static inline struct time_namespace *get_time_ns(struct time_namespace *ns)
 {
@@ -66,6 +86,8 @@ static inline int timens_on_fork(struct nsproxy *nsproxy,
 	return 0;
 }
 
+static inline void timens_add_monotonic(struct timespec64 *ts) { }
+static inline void timens_add_boottime(struct timespec64 *ts) { }
 #endif
 
 #endif /* _LINUX_TIMENS_H */
diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
index 2662a69..c2a58e4 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/cred.h>
 #include <linux/err.h>
+#include <linux/mm.h>
 
 static struct ucounts *inc_time_namespaces(struct user_namespace *ns)
 {
@@ -60,6 +61,7 @@ static struct time_namespace *clone_time_ns(struct user_namespace *user_ns,
 	ns->ucounts = ucounts;
 	ns->ns.ops = &timens_operations;
 	ns->user_ns = get_user_ns(user_ns);
+	ns->offsets = old_ns->offsets;
 	return ns;
 
 fail_free:
