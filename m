Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37939C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 107EA206F1
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgFAJxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 05:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbgFAJwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 05:52:35 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C81C08C5C0;
        Mon,  1 Jun 2020 02:52:35 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jfh7Q-0003i6-2L; Mon, 01 Jun 2020 11:52:32 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B09FD1C0244;
        Mon,  1 Jun 2020 11:52:31 +0200 (CEST)
Date:   Mon, 01 Jun 2020 09:52:31 -0000
From:   "tip-bot2 for Mike Galbraith" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] connector/cn_proc: Protect send_msg() with a local lock
Cc:     Mike Galbraith <umgwanakikbuti@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200527201119.1692513-6-bigeasy@linutronix.de>
References: <20200527201119.1692513-6-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <159100515158.17951.5876738878274408032.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     3e92fd7bd2b8418b53cb7304855b8b69bedbe2b4
Gitweb:        https://git.kernel.org/tip/3e92fd7bd2b8418b53cb7304855b8b69bedbe2b4
Author:        Mike Galbraith <umgwanakikbuti@gmail.com>
AuthorDate:    Wed, 27 May 2020 22:11:17 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 28 May 2020 10:31:10 +02:00

connector/cn_proc: Protect send_msg() with a local lock

send_msg() disables preemption to avoid out-of-order messages. As the
code inside the preempt disabled section acquires regular spinlocks,
which are converted to 'sleeping' spinlocks on a PREEMPT_RT kernel and
eventually calls into a memory allocator, this conflicts with the RT
semantics.

Convert it to a local_lock which allows RT kernels to substitute them with
a real per CPU lock. On non RT kernels this maps to preempt_disable() as
before. No functional change.

[bigeasy: Patch description]

Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20200527201119.1692513-6-bigeasy@linutronix.de
---
 drivers/connector/cn_proc.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/connector/cn_proc.c b/drivers/connector/cn_proc.c
index d58ce66..646ad38 100644
--- a/drivers/connector/cn_proc.c
+++ b/drivers/connector/cn_proc.c
@@ -18,6 +18,7 @@
 #include <linux/pid_namespace.h>
 
 #include <linux/cn_proc.h>
+#include <linux/local_lock.h>
 
 /*
  * Size of a cn_msg followed by a proc_event structure.  Since the
@@ -38,25 +39,31 @@ static inline struct cn_msg *buffer_to_cn_msg(__u8 *buffer)
 static atomic_t proc_event_num_listeners = ATOMIC_INIT(0);
 static struct cb_id cn_proc_event_id = { CN_IDX_PROC, CN_VAL_PROC };
 
-/* proc_event_counts is used as the sequence number of the netlink message */
-static DEFINE_PER_CPU(__u32, proc_event_counts) = { 0 };
+/* local_event.count is used as the sequence number of the netlink message */
+struct local_event {
+	local_lock_t lock;
+	__u32 count;
+};
+static DEFINE_PER_CPU(struct local_event, local_event) = {
+	.lock = INIT_LOCAL_LOCK(lock),
+};
 
 static inline void send_msg(struct cn_msg *msg)
 {
-	preempt_disable();
+	local_lock(&local_event.lock);
 
-	msg->seq = __this_cpu_inc_return(proc_event_counts) - 1;
+	msg->seq = __this_cpu_inc_return(local_event.count) - 1;
 	((struct proc_event *)msg->data)->cpu = smp_processor_id();
 
 	/*
-	 * Preemption remains disabled during send to ensure the messages are
-	 * ordered according to their sequence numbers.
+	 * local_lock() disables preemption during send to ensure the messages
+	 * are ordered according to their sequence numbers.
 	 *
 	 * If cn_netlink_send() fails, the data is not sent.
 	 */
 	cn_netlink_send(msg, 0, CN_IDX_PROC, GFP_NOWAIT);
 
-	preempt_enable();
+	local_unlock(&local_event.lock);
 }
 
 void proc_fork_connector(struct task_struct *task)
