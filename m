Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E353C3B186
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6037C208C4
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbgBKMsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 07:48:37 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46108 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729037AbgBKMsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 07:48:32 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j1Uxm-0007ow-HX; Tue, 11 Feb 2020 13:48:26 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 274BE1C201A;
        Tue, 11 Feb 2020 13:48:26 +0100 (CET)
Date:   Tue, 11 Feb 2020 12:48:25 -0000
From:   "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/lockdep: Display irq_context names in
 /proc/lockdep_chains
Cc:     Waiman Long <longman@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200206152408.24165-3-longman@redhat.com>
References: <20200206152408.24165-3-longman@redhat.com>
MIME-Version: 1.0
Message-ID: <158142530591.411.8801852288314331385.tip-bot2@tip-bot2>
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

Commit-ID:     b9875e9882295749a14b31e16dd504ae904cf070
Gitweb:        https://git.kernel.org/tip/b9875e9882295749a14b31e16dd504ae904cf070
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Thu, 06 Feb 2020 10:24:04 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 11 Feb 2020 13:10:48 +01:00

locking/lockdep: Display irq_context names in /proc/lockdep_chains

Currently, the irq_context field of a lock chains displayed in
/proc/lockdep_chains is just a number. It is likely that many people
may not know what a non-zero number means. To make the information more
useful, print the actual irq names ("softirq" and "hardirq") instead.

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20200206152408.24165-3-longman@redhat.com
---
 kernel/locking/lockdep_proc.c |  9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
index 231684c..c222438 100644
--- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -128,6 +128,13 @@ static int lc_show(struct seq_file *m, void *v)
 	struct lock_chain *chain = v;
 	struct lock_class *class;
 	int i;
+	static const char * const irq_strs[] = {
+		[0]			     = "0",
+		[LOCK_CHAIN_HARDIRQ_CONTEXT] = "hardirq",
+		[LOCK_CHAIN_SOFTIRQ_CONTEXT] = "softirq",
+		[LOCK_CHAIN_SOFTIRQ_CONTEXT|
+		 LOCK_CHAIN_HARDIRQ_CONTEXT] = "hardirq|softirq",
+	};
 
 	if (v == SEQ_START_TOKEN) {
 		if (nr_chain_hlocks > MAX_LOCKDEP_CHAIN_HLOCKS)
@@ -136,7 +143,7 @@ static int lc_show(struct seq_file *m, void *v)
 		return 0;
 	}
 
-	seq_printf(m, "irq_context: %d\n", chain->irq_context);
+	seq_printf(m, "irq_context: %s\n", irq_strs[chain->irq_context]);
 
 	for (i = 0; i < chain->depth; i++) {
 		class = lock_chain_get_class(chain, i);
