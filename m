Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A4BC4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 005F520A8B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbgCXJSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:18:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44070 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727729AbgCXJRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:17:05 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGfgE-0008EU-2T; Tue, 24 Mar 2020 10:17:02 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7C76F1C04CF;
        Tue, 24 Mar 2020 10:16:50 +0100 (CET)
Date:   Tue, 24 Mar 2020 09:16:50 -0000
From:   "tip-bot2 for Eric Dumazet" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] timer: Use hlist_unhashed_lockless() in timer_pending()
Cc:     Eric Dumazet <edumazet@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158504141010.28353.3631312997935313071.tip-bot2@tip-bot2>
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

Commit-ID:     90c018942c2babab73814648b37808fc3bf2ed1a
Gitweb:        https://git.kernel.org/tip/90c018942c2babab73814648b37808fc3bf2ed1a
Author:        Eric Dumazet <edumazet@google.com>
AuthorDate:    Thu, 07 Nov 2019 11:37:38 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 20 Feb 2020 15:58:22 -08:00

timer: Use hlist_unhashed_lockless() in timer_pending()

The timer_pending() function is mostly used in lockless contexts, so
Without proper annotations, KCSAN might detect a data-race [1].

Using hlist_unhashed_lockless() instead of hand-coding it seems
appropriate (as suggested by Paul E. McKenney).

[1]

BUG: KCSAN: data-race in del_timer / detach_if_pending

write to 0xffff88808697d870 of 8 bytes by task 10 on cpu 0:
 __hlist_del include/linux/list.h:764 [inline]
 detach_timer kernel/time/timer.c:815 [inline]
 detach_if_pending+0xcd/0x2d0 kernel/time/timer.c:832
 try_to_del_timer_sync+0x60/0xb0 kernel/time/timer.c:1226
 del_timer_sync+0x6b/0xa0 kernel/time/timer.c:1365
 schedule_timeout+0x2d2/0x6e0 kernel/time/timer.c:1896
 rcu_gp_fqs_loop+0x37c/0x580 kernel/rcu/tree.c:1639
 rcu_gp_kthread+0x143/0x230 kernel/rcu/tree.c:1799
 kthread+0x1d4/0x200 drivers/block/aoe/aoecmd.c:1253
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:352

read to 0xffff88808697d870 of 8 bytes by task 12060 on cpu 1:
 del_timer+0x3b/0xb0 kernel/time/timer.c:1198
 sk_stop_timer+0x25/0x60 net/core/sock.c:2845
 inet_csk_clear_xmit_timers+0x69/0xa0 net/ipv4/inet_connection_sock.c:523
 tcp_clear_xmit_timers include/net/tcp.h:606 [inline]
 tcp_v4_destroy_sock+0xa3/0x3f0 net/ipv4/tcp_ipv4.c:2096
 inet_csk_destroy_sock+0xf4/0x250 net/ipv4/inet_connection_sock.c:836
 tcp_close+0x6f3/0x970 net/ipv4/tcp.c:2497
 inet_release+0x86/0x100 net/ipv4/af_inet.c:427
 __sock_release+0x85/0x160 net/socket.c:590
 sock_close+0x24/0x30 net/socket.c:1268
 __fput+0x1e1/0x520 fs/file_table.c:280
 ____fput+0x1f/0x30 fs/file_table.c:313
 task_work_run+0xf6/0x130 kernel/task_work.c:113
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_usermode_loop+0x2b4/0x2c0 arch/x86/entry/common.c:163

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 12060 Comm: syz-executor.5 Not tainted 5.4.0-rc3+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine,

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
[ paulmck: Pulled in Eric's later amendments. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/timer.h | 2 +-
 kernel/time/timer.c   | 7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/timer.h b/include/linux/timer.h
index 1e6650e..0dc19a8 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -164,7 +164,7 @@ static inline void destroy_timer_on_stack(struct timer_list *timer) { }
  */
 static inline int timer_pending(const struct timer_list * timer)
 {
-	return timer->entry.pprev != NULL;
+	return !hlist_unhashed_lockless(&timer->entry);
 }
 
 extern void add_timer_on(struct timer_list *timer, int cpu);
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 4820823..568564a 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -944,6 +944,7 @@ static struct timer_base *lock_timer_base(struct timer_list *timer,
 
 #define MOD_TIMER_PENDING_ONLY		0x01
 #define MOD_TIMER_REDUCE		0x02
+#define MOD_TIMER_NOTPENDING		0x04
 
 static inline int
 __mod_timer(struct timer_list *timer, unsigned long expires, unsigned int options)
@@ -960,7 +961,7 @@ __mod_timer(struct timer_list *timer, unsigned long expires, unsigned int option
 	 * the timer is re-modified to have the same timeout or ends up in the
 	 * same array bucket then just return:
 	 */
-	if (timer_pending(timer)) {
+	if (!(options & MOD_TIMER_NOTPENDING) && timer_pending(timer)) {
 		/*
 		 * The downside of this optimization is that it can result in
 		 * larger granularity than you would get from adding a new
@@ -1133,7 +1134,7 @@ EXPORT_SYMBOL(timer_reduce);
 void add_timer(struct timer_list *timer)
 {
 	BUG_ON(timer_pending(timer));
-	mod_timer(timer, timer->expires);
+	__mod_timer(timer, timer->expires, MOD_TIMER_NOTPENDING);
 }
 EXPORT_SYMBOL(add_timer);
 
@@ -1891,7 +1892,7 @@ signed long __sched schedule_timeout(signed long timeout)
 
 	timer.task = current;
 	timer_setup_on_stack(&timer.timer, process_timeout, 0);
-	__mod_timer(&timer.timer, expire, 0);
+	__mod_timer(&timer.timer, expire, MOD_TIMER_NOTPENDING);
 	schedule();
 	del_singleshot_timer_sync(&timer.timer);
 
