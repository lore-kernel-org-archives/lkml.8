Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F415C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 11:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E97920702
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 11:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404486AbgFYLxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 07:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404261AbgFYLxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 07:53:47 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947AEC0613ED;
        Thu, 25 Jun 2020 04:53:47 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1joQRZ-0005q7-MO; Thu, 25 Jun 2020 13:53:25 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5C72C1C0470;
        Thu, 25 Jun 2020 13:53:25 +0200 (CEST)
Date:   Thu, 25 Jun 2020 11:53:25 -0000
From:   "tip-bot2 for Steven Rostedt (VMware)" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Have sched_class_highest define by vmlinux.lds.h
Cc:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191219214558.682913590@goodmis.org>
References: <20191219214558.682913590@goodmis.org>
MIME-Version: 1.0
Message-ID: <159308600506.16989.4684187013846395025.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     c3a340f7e7eadac7662ab104ceb16432e5a4c6b2
Gitweb:        https://git.kernel.org/tip/c3a340f7e7eadac7662ab104ceb16432e5a4c6b2
Author:        Steven Rostedt (VMware) <rostedt@goodmis.org>
AuthorDate:    Thu, 19 Dec 2019 16:44:53 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 25 Jun 2020 13:45:44 +02:00

sched: Have sched_class_highest define by vmlinux.lds.h

Now that the sched_class descriptors are defined by the linker script, and
this needs to be aware of the existance of stop_sched_class when SMP is
enabled or not, as it is used as the "highest" priority when defined. Move
the declaration of sched_class_highest to the same location in the linker
script that inserts stop_sched_class, and this will also make it easier to
see what should be defined as the highest class, as this linker script
location defines the priorities as well.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20191219214558.682913590@goodmis.org
---
 include/asm-generic/vmlinux.lds.h |  5 ++++-
 kernel/sched/core.c               |  8 ++++++++
 kernel/sched/sched.h              | 17 +++++++++--------
 3 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 2186d7b..66fb84c 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -114,11 +114,14 @@
  * relation to each other.
  */
 #define SCHED_DATA				\
+	STRUCT_ALIGN();				\
+	__begin_sched_classes = .;		\
 	*(__idle_sched_class)			\
 	*(__fair_sched_class)			\
 	*(__rt_sched_class)			\
 	*(__dl_sched_class)			\
-	*(__stop_sched_class)
+	*(__stop_sched_class)			\
+	__end_sched_classes = .;
 
 /*
  * Align to a 32 byte boundary equal to the
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0208b71..81640fe 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6646,6 +6646,14 @@ void __init sched_init(void)
 	unsigned long ptr = 0;
 	int i;
 
+	/* Make sure the linker didn't screw up */
+	BUG_ON(&idle_sched_class + 1 != &fair_sched_class ||
+	       &fair_sched_class + 1 != &rt_sched_class ||
+	       &rt_sched_class + 1   != &dl_sched_class);
+#ifdef CONFIG_SMP
+	BUG_ON(&dl_sched_class + 1 != &stop_sched_class);
+#endif
+
 	wait_bit_init();
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3368876..4165c06 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1811,7 +1811,7 @@ struct sched_class {
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	void (*task_change_group)(struct task_struct *p, int type);
 #endif
-};
+} __aligned(32); /* STRUCT_ALIGN(), vmlinux.lds.h */
 
 static inline void put_prev_task(struct rq *rq, struct task_struct *prev)
 {
@@ -1825,17 +1825,18 @@ static inline void set_next_task(struct rq *rq, struct task_struct *next)
 	next->sched_class->set_next_task(rq, next, false);
 }
 
-#ifdef CONFIG_SMP
-#define sched_class_highest (&stop_sched_class)
-#else
-#define sched_class_highest (&dl_sched_class)
-#endif
+/* Defined in include/asm-generic/vmlinux.lds.h */
+extern struct sched_class __begin_sched_classes[];
+extern struct sched_class __end_sched_classes[];
+
+#define sched_class_highest (__end_sched_classes - 1)
+#define sched_class_lowest  (__begin_sched_classes - 1)
 
 #define for_class_range(class, _from, _to) \
-	for (class = (_from); class != (_to); class = class->next)
+	for (class = (_from); class != (_to); class--)
 
 #define for_each_class(class) \
-	for_class_range(class, sched_class_highest, NULL)
+	for_class_range(class, sched_class_highest, sched_class_lowest)
 
 extern const struct sched_class stop_sched_class;
 extern const struct sched_class dl_sched_class;
