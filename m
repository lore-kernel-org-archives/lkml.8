Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FBAC2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8353222522
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730287AbgAYKow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 05:44:52 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44359 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729817AbgAYKnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 05:43:23 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ivIuN-0000Co-6P; Sat, 25 Jan 2020 11:43:19 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7D2D41C1A73;
        Sat, 25 Jan 2020 11:42:55 +0100 (CET)
Date:   Sat, 25 Jan 2020 10:42:55 -0000
From:   "tip-bot2 for Eric Dumazet" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Avoid data-race in rcu_gp_fqs_check_wake()
Cc:     Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157994897531.396.7332136014669152142.tip-bot2@tip-bot2>
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

Commit-ID:     6935c3983b246d5fbfebd3b891c825e65c118f2d
Gitweb:        https://git.kernel.org/tip/6935c3983b246d5fbfebd3b891c825e65c118f2d
Author:        Eric Dumazet <edumazet@google.com>
AuthorDate:    Wed, 09 Oct 2019 14:21:54 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 09 Dec 2019 12:37:50 -08:00

rcu: Avoid data-race in rcu_gp_fqs_check_wake()

The rcu_gp_fqs_check_wake() function uses rcu_preempt_blocked_readers_cgp()
to read ->gp_tasks while other cpus might overwrite this field.

We need READ_ONCE()/WRITE_ONCE() pairs to avoid compiler
tricks and KCSAN splats like the following :

BUG: KCSAN: data-race in rcu_gp_fqs_check_wake / rcu_preempt_deferred_qs_irqrestore

write to 0xffffffff85a7f190 of 8 bytes by task 7317 on cpu 0:
 rcu_preempt_deferred_qs_irqrestore+0x43d/0x580 kernel/rcu/tree_plugin.h:507
 rcu_read_unlock_special+0xec/0x370 kernel/rcu/tree_plugin.h:659
 __rcu_read_unlock+0xcf/0xe0 kernel/rcu/tree_plugin.h:394
 rcu_read_unlock include/linux/rcupdate.h:645 [inline]
 __ip_queue_xmit+0x3b0/0xa40 net/ipv4/ip_output.c:533
 ip_queue_xmit+0x45/0x60 include/net/ip.h:236
 __tcp_transmit_skb+0xdeb/0x1cd0 net/ipv4/tcp_output.c:1158
 __tcp_send_ack+0x246/0x300 net/ipv4/tcp_output.c:3685
 tcp_send_ack+0x34/0x40 net/ipv4/tcp_output.c:3691
 tcp_cleanup_rbuf+0x130/0x360 net/ipv4/tcp.c:1575
 tcp_recvmsg+0x633/0x1a30 net/ipv4/tcp.c:2179
 inet_recvmsg+0xbb/0x250 net/ipv4/af_inet.c:838
 sock_recvmsg_nosec net/socket.c:871 [inline]
 sock_recvmsg net/socket.c:889 [inline]
 sock_recvmsg+0x92/0xb0 net/socket.c:885
 sock_read_iter+0x15f/0x1e0 net/socket.c:967
 call_read_iter include/linux/fs.h:1864 [inline]
 new_sync_read+0x389/0x4f0 fs/read_write.c:414

read to 0xffffffff85a7f190 of 8 bytes by task 10 on cpu 1:
 rcu_gp_fqs_check_wake kernel/rcu/tree.c:1556 [inline]
 rcu_gp_fqs_check_wake+0x93/0xd0 kernel/rcu/tree.c:1546
 rcu_gp_fqs_loop+0x36c/0x580 kernel/rcu/tree.c:1611
 rcu_gp_kthread+0x143/0x220 kernel/rcu/tree.c:1768
 kthread+0x1d4/0x200 drivers/block/aoe/aoecmd.c:1253
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:352

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 10 Comm: rcu_preempt Not tainted 5.3.0+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
[ paulmck:  Added another READ_ONCE() for RCU CPU stall warnings. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 758bfe1..fe5f448 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -220,7 +220,7 @@ static void rcu_preempt_ctxt_queue(struct rcu_node *rnp, struct rcu_data *rdp)
 	 * blocked tasks.
 	 */
 	if (!rnp->gp_tasks && (blkd_state & RCU_GP_BLKD)) {
-		rnp->gp_tasks = &t->rcu_node_entry;
+		WRITE_ONCE(rnp->gp_tasks, &t->rcu_node_entry);
 		WARN_ON_ONCE(rnp->completedqs == rnp->gp_seq);
 	}
 	if (!rnp->exp_tasks && (blkd_state & RCU_EXP_BLKD))
@@ -340,7 +340,7 @@ EXPORT_SYMBOL_GPL(rcu_note_context_switch);
  */
 static int rcu_preempt_blocked_readers_cgp(struct rcu_node *rnp)
 {
-	return rnp->gp_tasks != NULL;
+	return READ_ONCE(rnp->gp_tasks) != NULL;
 }
 
 /* Bias and limit values for ->rcu_read_lock_nesting. */
@@ -493,7 +493,7 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 		trace_rcu_unlock_preempted_task(TPS("rcu_preempt"),
 						rnp->gp_seq, t->pid);
 		if (&t->rcu_node_entry == rnp->gp_tasks)
-			rnp->gp_tasks = np;
+			WRITE_ONCE(rnp->gp_tasks, np);
 		if (&t->rcu_node_entry == rnp->exp_tasks)
 			rnp->exp_tasks = np;
 		if (IS_ENABLED(CONFIG_RCU_BOOST)) {
@@ -663,7 +663,7 @@ static void rcu_preempt_check_blocked_tasks(struct rcu_node *rnp)
 		dump_blkd_tasks(rnp, 10);
 	if (rcu_preempt_has_tasks(rnp) &&
 	    (rnp->qsmaskinit || rnp->wait_blkd_tasks)) {
-		rnp->gp_tasks = rnp->blkd_tasks.next;
+		WRITE_ONCE(rnp->gp_tasks, rnp->blkd_tasks.next);
 		t = container_of(rnp->gp_tasks, struct task_struct,
 				 rcu_node_entry);
 		trace_rcu_unlock_preempted_task(TPS("rcu_preempt-GPS"),
@@ -757,7 +757,8 @@ dump_blkd_tasks(struct rcu_node *rnp, int ncheck)
 		pr_info("%s: %d:%d ->qsmask %#lx ->qsmaskinit %#lx ->qsmaskinitnext %#lx\n",
 			__func__, rnp1->grplo, rnp1->grphi, rnp1->qsmask, rnp1->qsmaskinit, rnp1->qsmaskinitnext);
 	pr_info("%s: ->gp_tasks %p ->boost_tasks %p ->exp_tasks %p\n",
-		__func__, rnp->gp_tasks, rnp->boost_tasks, rnp->exp_tasks);
+		__func__, READ_ONCE(rnp->gp_tasks), rnp->boost_tasks,
+		rnp->exp_tasks);
 	pr_info("%s: ->blkd_tasks", __func__);
 	i = 0;
 	list_for_each(lhp, &rnp->blkd_tasks) {
