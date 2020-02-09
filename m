Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74F1C2BA83
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 19:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACCA7207FF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 19:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgBITMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 14:12:13 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42627 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbgBITMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 14:12:12 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j0rzc-0006gk-FK; Sun, 09 Feb 2020 20:11:44 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B78621C04CC;
        Sun,  9 Feb 2020 20:11:41 +0100 (CET)
Date:   Sun, 09 Feb 2020 19:11:41 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/rt: Provide migrate_disable/enable() inlines
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <878slclv1u.fsf@nanos.tec.linutronix.de>
References: <878slclv1u.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Message-ID: <158127550143.411.9644440031937252653.tip-bot2@tip-bot2>
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

Commit-ID:     9fe65747dbacf0c9fcf12350c3afb5fcf7e78534
Gitweb:        https://git.kernel.org/tip/9fe65747dbacf0c9fcf12350c3afb5fcf7e78534
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 08 Feb 2020 20:48:29 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 09 Feb 2020 20:07:41 +01:00

sched/rt: Provide migrate_disable/enable() inlines

Code which solely needs to prevent migration of a task uses
preempt_disable()/enable() pairs. This is the only reliable way to do so
as setting the task affinity to a single CPU can be undone by a
setaffinity operation from a different task/process.

RT provides a seperate migrate_disable/enable() mechanism which does not
disable preemption to achieve the semantic requirements of a (almost) fully
preemptible kernel.

As it is unclear from looking at a given code path whether the intention is
to disable preemption or migration, introduce migrate_disable/enable()
inline functions which can be used to annotate code which merely needs to
disable migration. Map them to preempt_disable/enable() for now. The RT
substitution will be provided later.

Code which is annotated that way documents that it has no requirement to
protect against reentrancy of a preempting task. Either this is not
required at all or the call sites are already serialized by other means.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://lore.kernel.org/r/878slclv1u.fsf@nanos.tec.linutronix.de
---
 include/linux/preempt.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index bbb68db..bc3f1ae 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -322,4 +322,34 @@ static inline void preempt_notifier_init(struct preempt_notifier *notifier,
 
 #endif
 
+/**
+ * migrate_disable - Prevent migration of the current task
+ *
+ * Maps to preempt_disable() which also disables preemption. Use
+ * migrate_disable() to annotate that the intent is to prevent migration,
+ * but not necessarily preemption.
+ *
+ * Can be invoked nested like preempt_disable() and needs the corresponding
+ * number of migrate_enable() invocations.
+ */
+static __always_inline void migrate_disable(void)
+{
+	preempt_disable();
+}
+
+/**
+ * migrate_enable - Allow migration of the current task
+ *
+ * Counterpart to migrate_disable().
+ *
+ * As migrate_disable() can be invoked nested, only the outermost invocation
+ * reenables migration.
+ *
+ * Currently mapped to preempt_enable().
+ */
+static __always_inline void migrate_enable(void)
+{
+	preempt_enable();
+}
+
 #endif /* __LINUX_PREEMPT_H */
