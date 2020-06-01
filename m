Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBC9C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A45642077D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbgFAJwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 05:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbgFAJwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 05:52:25 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48F0C08C5CA;
        Mon,  1 Jun 2020 02:52:24 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jfh7F-0003fb-KJ; Mon, 01 Jun 2020 11:52:21 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5343C1C0481;
        Mon,  1 Jun 2020 11:52:21 +0200 (CEST)
Date:   Mon, 01 Jun 2020 09:52:21 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] smp: Optimize flush_smp_call_function_queue()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200526161907.836818381@infradead.org>
References: <20200526161907.836818381@infradead.org>
MIME-Version: 1.0
Message-ID: <159100514119.17951.4934899720059285189.tip-bot2@tip-bot2>
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

Commit-ID:     52103be07d8b08311955f8c30e535c2dda290cf4
Gitweb:        https://git.kernel.org/tip/52103be07d8b08311955f8c30e535c2dda290cf4
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 26 May 2020 18:10:59 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 28 May 2020 10:54:15 +02:00

smp: Optimize flush_smp_call_function_queue()

The call_single_queue can contain (two) different callbacks,
synchronous and asynchronous. The current interrupt handler runs them
in-order, which means that remote CPUs that are waiting for their
synchronous call can be delayed by running asynchronous callbacks.

Rework the interrupt handler to first run the synchonous callbacks.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200526161907.836818381@infradead.org
---
 kernel/smp.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index 786092a..db2f738 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -209,9 +209,9 @@ void generic_smp_call_function_single_interrupt(void)
  */
 static void flush_smp_call_function_queue(bool warn_cpu_offline)
 {
-	struct llist_head *head;
-	struct llist_node *entry;
 	call_single_data_t *csd, *csd_next;
+	struct llist_node *entry, *prev;
+	struct llist_head *head;
 	static bool warned;
 
 	lockdep_assert_irqs_disabled();
@@ -235,21 +235,40 @@ static void flush_smp_call_function_queue(bool warn_cpu_offline)
 				csd->func);
 	}
 
+	/*
+	 * First; run all SYNC callbacks, people are waiting for us.
+	 */
+	prev = NULL;
 	llist_for_each_entry_safe(csd, csd_next, entry, llist) {
 		smp_call_func_t func = csd->func;
 		void *info = csd->info;
 
 		/* Do we wait until *after* callback? */
 		if (csd->flags & CSD_FLAG_SYNCHRONOUS) {
+			if (prev) {
+				prev->next = &csd_next->llist;
+			} else {
+				entry = &csd_next->llist;
+			}
 			func(info);
 			csd_unlock(csd);
 		} else {
-			csd_unlock(csd);
-			func(info);
+			prev = &csd->llist;
 		}
 	}
 
 	/*
+	 * Second; run all !SYNC callbacks.
+	 */
+	llist_for_each_entry_safe(csd, csd_next, entry, llist) {
+		smp_call_func_t func = csd->func;
+		void *info = csd->info;
+
+		csd_unlock(csd);
+		func(info);
+	}
+
+	/*
 	 * Handle irq works queued remotely by irq_work_queue_on().
 	 * Smp functions above are typically synchronous so they
 	 * better run first since some other CPUs may be busy waiting
