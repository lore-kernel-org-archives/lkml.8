Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268E2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 16:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDB932073B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 16:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tP0inwqb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388523AbgEZQY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 12:24:27 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35182 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbgEZQYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 12:24:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=S3JSzd4qxhZQql7zHNLOO4rOyqI0Rs91xMwgjbky3rE=; b=tP0inwqbIVkR8BMeC+ExrLqtvM
        mqToMXdPVtRaowx3ByEmBoiCBOXiuqvUNYm7/M0l9RiuGhffIMVutV9mIRBl8FpB6KEnQXQ1cG7hm
        j4LLXGp/a2p2giODfGnCr1pTUw2/6LqcYsdP4fqIgNUk8hv/OUmB4xrdx95wwn8Tulv/BXvqXSNtP
        VHyz+F4dYmJlkvK4NZ+BHRGhC5a9bMwOKzRNkuBke5rT+p0HWORPaA7ETJ7ro+ylh8/bBw5Rg1F3K
        zpLLqgG4ikfwl8fvRc6QBlUVzD664VwX+e2HdP7uqW4J9y9Lchh/7QZG/5/GLtRf+QNLPqWMBHye5
        hjfVEUig==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jdcIv-0005Tg-87; Tue, 26 May 2020 16:19:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6CC48306108;
        Tue, 26 May 2020 18:19:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 489A720FF792C; Tue, 26 May 2020 18:19:41 +0200 (CEST)
Message-ID: <20200526161907.836818381@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 26 May 2020 18:10:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, frederic@kernel.org
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, cai@lca.pw,
        mgorman@techsingularity.net, peterz@infradead.org
Subject: [RFC][PATCH 2/7] smp: Optimize flush_smp_call_function_queue()
References: <20200526161057.531933155@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The call_single_queue can contain (two) different callbacks,
synchronous and asynchronous. The current interrupt handler runs them
in-order, which means that remote CPUs that are waiting for their
synchronous call can be delayed by running asynchronous callbacks.

Rework the interrupt handler to first run the synchonous callbacks.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/smp.c |   27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -209,9 +209,9 @@ void generic_smp_call_function_single_in
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
@@ -235,21 +235,40 @@ static void flush_smp_call_function_queu
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


