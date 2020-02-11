Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E081BC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C028D208C4
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbgBKMtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 07:49:00 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46101 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729030AbgBKMsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 07:48:31 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j1Uxl-0007o1-EJ; Tue, 11 Feb 2020 13:48:25 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2366B1C2019;
        Tue, 11 Feb 2020 13:48:25 +0100 (CET)
Date:   Tue, 11 Feb 2020 12:48:24 -0000
From:   "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/lockdep: Track number of zapped lock chains
Cc:     Waiman Long <longman@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200206152408.24165-6-longman@redhat.com>
References: <20200206152408.24165-6-longman@redhat.com>
MIME-Version: 1.0
Message-ID: <158142530491.411.13846763021268112187.tip-bot2@tip-bot2>
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

Commit-ID:     797b82eb906eeba24dcd6e9ab92faef01fc684cb
Gitweb:        https://git.kernel.org/tip/797b82eb906eeba24dcd6e9ab92faef01fc684cb
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Thu, 06 Feb 2020 10:24:07 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 11 Feb 2020 13:10:51 +01:00

locking/lockdep: Track number of zapped lock chains

Add a new counter nr_zapped_lock_chains to track the number lock chains
that have been removed.

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20200206152408.24165-6-longman@redhat.com
---
 kernel/locking/lockdep.c           | 2 ++
 kernel/locking/lockdep_internals.h | 1 +
 kernel/locking/lockdep_proc.c      | 4 ++++
 3 files changed, 7 insertions(+)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index ef2a643..a63976c 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2626,6 +2626,7 @@ out_bug:
 struct lock_chain lock_chains[MAX_LOCKDEP_CHAINS];
 static DECLARE_BITMAP(lock_chains_in_use, MAX_LOCKDEP_CHAINS);
 static u16 chain_hlocks[MAX_LOCKDEP_CHAIN_HLOCKS];
+unsigned long nr_zapped_lock_chains;
 unsigned int nr_chain_hlocks;
 
 struct lock_class *lock_chain_get_class(struct lock_chain *chain, int i)
@@ -4797,6 +4798,7 @@ free_lock_chain:
 	 */
 	hlist_del_rcu(&chain->entry);
 	__set_bit(chain - lock_chains, pf->lock_chains_being_freed);
+	nr_zapped_lock_chains++;
 #endif
 }
 
diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index 926bfa4..af722ce 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -131,6 +131,7 @@ struct lock_class *lock_chain_get_class(struct lock_chain *chain, int i);
 
 extern unsigned long nr_lock_classes;
 extern unsigned long nr_zapped_classes;
+extern unsigned long nr_zapped_lock_chains;
 extern unsigned long nr_list_entries;
 long lockdep_next_lockchain(long i);
 unsigned long lock_chain_count(void);
diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
index 53c2a2a..524580d 100644
--- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -349,6 +349,10 @@ static int lockdep_stats_show(struct seq_file *m, void *v)
 	seq_puts(m, "\n");
 	seq_printf(m, " zapped classes:                %11lu\n",
 			nr_zapped_classes);
+#ifdef CONFIG_PROVE_LOCKING
+	seq_printf(m, " zapped lock chains:            %11lu\n",
+			nr_zapped_lock_chains);
+#endif
 	return 0;
 }
 
