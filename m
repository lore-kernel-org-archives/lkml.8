Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D781AC4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 12:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB07120776
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 12:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbgCTM6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 08:58:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35682 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbgCTM6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 08:58:39 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jFHEQ-0003qv-0M; Fri, 20 Mar 2020 13:58:34 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 944B51C22C0;
        Fri, 20 Mar 2020 13:58:33 +0100 (CET)
Date:   Fri, 20 Mar 2020 12:58:33 -0000
From:   "tip-bot2 for Boqun Feng" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/lockdep: Avoid recursion in
 lockdep_count_{for,back}ward_deps()
Cc:     Qian Cai <cai@lca.pw>, Boqun Feng <boqun.feng@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200312151258.128036-1-boqun.feng@gmail.com>
References: <20200312151258.128036-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Message-ID: <158470911332.28353.7259360463548170185.tip-bot2@tip-bot2>
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

Commit-ID:     25016bd7f4caf5fc983bbab7403d08e64cba3004
Gitweb:        https://git.kernel.org/tip/25016bd7f4caf5fc983bbab7403d08e64cba3004
Author:        Boqun Feng <boqun.feng@gmail.com>
AuthorDate:    Thu, 12 Mar 2020 23:12:55 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 20 Mar 2020 13:06:25 +01:00

locking/lockdep: Avoid recursion in lockdep_count_{for,back}ward_deps()

Qian Cai reported a bug when PROVE_RCU_LIST=y, and read on /proc/lockdep
triggered a warning:

  [ ] DEBUG_LOCKS_WARN_ON(current->hardirqs_enabled)
  ...
  [ ] Call Trace:
  [ ]  lock_is_held_type+0x5d/0x150
  [ ]  ? rcu_lockdep_current_cpu_online+0x64/0x80
  [ ]  rcu_read_lock_any_held+0xac/0x100
  [ ]  ? rcu_read_lock_held+0xc0/0xc0
  [ ]  ? __slab_free+0x421/0x540
  [ ]  ? kasan_kmalloc+0x9/0x10
  [ ]  ? __kmalloc_node+0x1d7/0x320
  [ ]  ? kvmalloc_node+0x6f/0x80
  [ ]  __bfs+0x28a/0x3c0
  [ ]  ? class_equal+0x30/0x30
  [ ]  lockdep_count_forward_deps+0x11a/0x1a0

The warning got triggered because lockdep_count_forward_deps() call
__bfs() without current->lockdep_recursion being set, as a result
a lockdep internal function (__bfs()) is checked by lockdep, which is
unexpected, and the inconsistency between the irq-off state and the
state traced by lockdep caused the warning.

Apart from this warning, lockdep internal functions like __bfs() should
always be protected by current->lockdep_recursion to avoid potential
deadlocks and data inconsistency, therefore add the
current->lockdep_recursion on-and-off section to protect __bfs() in both
lockdep_count_forward_deps() and lockdep_count_backward_deps()

Reported-by: Qian Cai <cai@lca.pw>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200312151258.128036-1-boqun.feng@gmail.com
---
 kernel/locking/lockdep.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index e55c4ee..2564950 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1723,9 +1723,11 @@ unsigned long lockdep_count_forward_deps(struct lock_class *class)
 	this.class = class;
 
 	raw_local_irq_save(flags);
+	current->lockdep_recursion = 1;
 	arch_spin_lock(&lockdep_lock);
 	ret = __lockdep_count_forward_deps(&this);
 	arch_spin_unlock(&lockdep_lock);
+	current->lockdep_recursion = 0;
 	raw_local_irq_restore(flags);
 
 	return ret;
@@ -1750,9 +1752,11 @@ unsigned long lockdep_count_backward_deps(struct lock_class *class)
 	this.class = class;
 
 	raw_local_irq_save(flags);
+	current->lockdep_recursion = 1;
 	arch_spin_lock(&lockdep_lock);
 	ret = __lockdep_count_backward_deps(&this);
 	arch_spin_unlock(&lockdep_lock);
+	current->lockdep_recursion = 0;
 	raw_local_irq_restore(flags);
 
 	return ret;
