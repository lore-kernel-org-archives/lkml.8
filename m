Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D9FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 17:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF81C2068D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 17:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgFCRut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 13:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgFCRul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 13:50:41 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF98AC08C5C0;
        Wed,  3 Jun 2020 10:50:41 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jgXX4-0005xL-HC; Wed, 03 Jun 2020 19:50:30 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2BC021C0475;
        Wed,  3 Jun 2020 19:50:30 +0200 (CEST)
Date:   Wed, 03 Jun 2020 17:50:30 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] lockdep: __always_inline more for noinstr
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200603114052.185201076@infradead.org>
References: <20200603114052.185201076@infradead.org>
MIME-Version: 1.0
Message-ID: <159120663002.17951.9332380509898245862.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     87374bc31053b40d64dfe7199d830fb225694637
Gitweb:        https://git.kernel.org/tip/87374bc31053b40d64dfe7199d830fb225694637
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 03 Jun 2020 13:40:21 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 03 Jun 2020 16:35:38 +02:00

lockdep: __always_inline more for noinstr

vmlinux.o: warning: objtool: debug_locks_off()+0xd: call to __debug_locks_off() leaves .noinstr.text section
vmlinux.o: warning: objtool: match_held_lock()+0x6a: call to look_up_lock_class.isra.0() leaves .noinstr.text section
vmlinux.o: warning: objtool: lock_is_held_type()+0x90: call to lockdep_recursion_finish() leaves .noinstr.text section

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200603114052.185201076@infradead.org

---
 include/linux/debug_locks.h | 2 +-
 kernel/locking/lockdep.c    | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/debug_locks.h b/include/linux/debug_locks.h
index 257ab3c..e7e45f0 100644
--- a/include/linux/debug_locks.h
+++ b/include/linux/debug_locks.h
@@ -12,7 +12,7 @@ extern int debug_locks __read_mostly;
 extern int debug_locks_silent __read_mostly;
 
 
-static inline int __debug_locks_off(void)
+static __always_inline int __debug_locks_off(void)
 {
 	return xchg(&debug_locks, 0);
 }
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index bdea09b..c1f352b 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -393,7 +393,7 @@ void lockdep_init_task(struct task_struct *task)
 	task->lockdep_recursion = 0;
 }
 
-static inline void lockdep_recursion_finish(void)
+static __always_inline void lockdep_recursion_finish(void)
 {
 	if (WARN_ON_ONCE(--current->lockdep_recursion))
 		current->lockdep_recursion = 0;
@@ -801,7 +801,7 @@ static int count_matching_names(struct lock_class *new_class)
 }
 
 /* used from NMI context -- must be lockless */
-static inline struct lock_class *
+static __always_inline struct lock_class *
 look_up_lock_class(const struct lockdep_map *lock, unsigned int subclass)
 {
 	struct lockdep_subclass_key *key;
