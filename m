Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B199C41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5795F20A8B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbgCXJRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:17:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44018 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbgCXJQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:16:57 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGfg5-00088S-SA; Tue, 24 Mar 2020 10:16:54 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 3C04C1C04CE;
        Tue, 24 Mar 2020 10:16:45 +0100 (CET)
Date:   Tue, 24 Mar 2020 09:16:44 -0000
From:   "tip-bot2 for Uladzislau Rezki (Sony)" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Add a trace event for kfree_rcu() use of kfree_bulk()
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158504140491.28353.12360538628522268701.tip-bot2@tip-bot2>
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

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     613707929b304737e6eb841588772f1994f6702b
Gitweb:        https://git.kernel.org/tip/613707929b304737e6eb841588772f1994f6702b
Author:        Uladzislau Rezki (Sony) <urezki@gmail.com>
AuthorDate:    Mon, 20 Jan 2020 15:42:26 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 20 Feb 2020 15:58:51 -08:00

rcu: Add a trace event for kfree_rcu() use of kfree_bulk()

The event is given three parameters, first one is the name
of RCU flavour, second one is the number of elements in array
for free and last one is an address of the array holding
pointers to be freed by the kfree_bulk() function.

To enable the trace event your kernel has to be build with
CONFIG_RCU_TRACE=y, after that it is possible to track the
events using ftrace subsystem.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/trace/events/rcu.h | 28 ++++++++++++++++++++++++++++
 kernel/rcu/tree.c          |  3 +++
 2 files changed, 31 insertions(+)

diff --git a/include/trace/events/rcu.h b/include/trace/events/rcu.h
index 5e49b06..49a49e6 100644
--- a/include/trace/events/rcu.h
+++ b/include/trace/events/rcu.h
@@ -624,6 +624,34 @@ TRACE_EVENT_RCU(rcu_invoke_kfree_callback,
 );
 
 /*
+ * Tracepoint for the invocation of a single RCU callback of the special
+ * kfree_bulk() form. The first argument is the RCU flavor, the second
+ * argument is a number of elements in array to free, the third is an
+ * address of the array holding nr_records entries.
+ */
+TRACE_EVENT_RCU(rcu_invoke_kfree_bulk_callback,
+
+	TP_PROTO(const char *rcuname, unsigned long nr_records, void **p),
+
+	TP_ARGS(rcuname, nr_records, p),
+
+	TP_STRUCT__entry(
+		__field(const char *, rcuname)
+		__field(unsigned long, nr_records)
+		__field(void **, p)
+	),
+
+	TP_fast_assign(
+		__entry->rcuname = rcuname;
+		__entry->nr_records = nr_records;
+		__entry->p = p;
+	),
+
+	TP_printk("%s bulk=0x%p nr_records=%lu",
+		__entry->rcuname, __entry->p, __entry->nr_records)
+);
+
+/*
  * Tracepoint for exiting rcu_do_batch after RCU callbacks have been
  * invoked.  The first argument is the name of the RCU flavor,
  * the second argument is number of callbacks actually invoked,
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 51a3aa8..909f97e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2792,6 +2792,9 @@ static void kfree_rcu_work(struct work_struct *work)
 		debug_rcu_head_unqueue_bulk(bhead->head_free_debug);
 
 		rcu_lock_acquire(&rcu_callback_map);
+		trace_rcu_invoke_kfree_bulk_callback(rcu_state.name,
+			bhead->nr_records, bhead->records);
+
 		kfree_bulk(bhead->nr_records, bhead->records);
 		rcu_lock_release(&rcu_callback_map);
 
