Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF12C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 10:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7975B246A6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 10:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbgAQKJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 05:09:29 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55448 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729304AbgAQKJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 05:09:27 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1isOYw-0005b0-6A; Fri, 17 Jan 2020 11:09:10 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E07E61C19CD;
        Fri, 17 Jan 2020 11:09:09 +0100 (CET)
Date:   Fri, 17 Jan 2020 10:09:09 -0000
From:   "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/lockdep: Fix lockdep_stats indentation problem
Cc:     Waiman Long <longman@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Bart Van Assche <bvanassche@acm.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191211213139.29934-1-longman@redhat.com>
References: <20191211213139.29934-1-longman@redhat.com>
MIME-Version: 1.0
Message-ID: <157925574974.396.9931702297640535543.tip-bot2@tip-bot2>
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

Commit-ID:     a030f9767da1a6bbcec840fc54770eb11c2414b6
Gitweb:        https://git.kernel.org/tip/a030f9767da1a6bbcec840fc54770eb11c2414b6
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Wed, 11 Dec 2019 16:31:39 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 17 Jan 2020 10:19:30 +01:00

locking/lockdep: Fix lockdep_stats indentation problem

It was found that two lines in the output of /proc/lockdep_stats have
indentation problem:

  # cat /proc/lockdep_stats
     :
   in-process chains:                   25057
   stack-trace entries:                137827 [max: 524288]
   number of stack traces:        7973
   number of stack hash chains:   6355
   combined max dependencies:      1356414598
   hardirq-safe locks:                     57
   hardirq-unsafe locks:                 1286
     :

All the numbers displayed in /proc/lockdep_stats except the two stack
trace numbers are formatted with a field with of 11. To properly align
all the numbers, a field width of 11 is now added to the two stack
trace numbers.

Fixes: 8c779229d0f4 ("locking/lockdep: Report more stack trace statistics")
Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Link: https://lkml.kernel.org/r/20191211213139.29934-1-longman@redhat.com
---
 kernel/locking/lockdep_proc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
index dadb7b7..9bb6d24 100644
--- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -286,9 +286,9 @@ static int lockdep_stats_show(struct seq_file *m, void *v)
 	seq_printf(m, " stack-trace entries:           %11lu [max: %lu]\n",
 			nr_stack_trace_entries, MAX_STACK_TRACE_ENTRIES);
 #if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING)
-	seq_printf(m, " number of stack traces:        %llu\n",
+	seq_printf(m, " number of stack traces:        %11llu\n",
 		   lockdep_stack_trace_count());
-	seq_printf(m, " number of stack hash chains:   %llu\n",
+	seq_printf(m, " number of stack hash chains:   %11llu\n",
 		   lockdep_stack_hash_count());
 #endif
 	seq_printf(m, " combined max dependencies:     %11u\n",
