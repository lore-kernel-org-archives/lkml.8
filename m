Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44D0C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A538422522
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbgAYKnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 05:43:09 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44191 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729324AbgAYKm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 05:42:59 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ivItz-0008US-67; Sat, 25 Jan 2020 11:42:55 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B4C0A1C1A73;
        Sat, 25 Jan 2020 11:42:47 +0100 (CET)
Date:   Sat, 25 Jan 2020 10:42:47 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Mark non-global functions and variables as static
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157994896754.396.1035985898715511278.tip-bot2@tip-bot2>
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

Commit-ID:     c30fe541896440667bd9e9068aedd1d440fbbcd2
Gitweb:        https://git.kernel.org/tip/c30fe541896440667bd9e9068aedd1d440fbbcd2
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 11 Oct 2019 21:40:09 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 12 Dec 2019 10:24:52 -08:00

rcu: Mark non-global functions and variables as static

Each of rcu_state, rcu_rnp_online_cpus(), rcu_dynticks_curr_cpu_in_eqs(),
and rcu_dynticks_snap() are used only in the kernel/rcu/tree.o translation
unit, and may thus be marked static.  This commit therefore makes this
change.

Reported-by: Ben Dooks <ben.dooks@codethink.co.uk>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 8 ++++----
 kernel/rcu/tree.h | 2 --
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 1694a6b..dd8cfc3 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -84,7 +84,7 @@ static DEFINE_PER_CPU_SHARED_ALIGNED(struct rcu_data, rcu_data) = {
 	.dynticks_nmi_nesting = DYNTICK_IRQ_NONIDLE,
 	.dynticks = ATOMIC_INIT(RCU_DYNTICK_CTRL_CTR),
 };
-struct rcu_state rcu_state = {
+static struct rcu_state rcu_state = {
 	.level = { &rcu_state.node[0] },
 	.gp_state = RCU_GP_IDLE,
 	.gp_seq = (0UL - 300UL) << RCU_SEQ_CTR_SHIFT,
@@ -188,7 +188,7 @@ EXPORT_SYMBOL_GPL(rcu_get_gp_kthreads_prio);
  * held, but the bit corresponding to the current CPU will be stable
  * in most contexts.
  */
-unsigned long rcu_rnp_online_cpus(struct rcu_node *rnp)
+static unsigned long rcu_rnp_online_cpus(struct rcu_node *rnp)
 {
 	return READ_ONCE(rnp->qsmaskinitnext);
 }
@@ -294,7 +294,7 @@ static void rcu_dynticks_eqs_online(void)
  *
  * No ordering, as we are sampling CPU-local information.
  */
-bool rcu_dynticks_curr_cpu_in_eqs(void)
+static bool rcu_dynticks_curr_cpu_in_eqs(void)
 {
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 
@@ -305,7 +305,7 @@ bool rcu_dynticks_curr_cpu_in_eqs(void)
  * Snapshot the ->dynticks counter with full ordering so as to allow
  * stable comparison of this counter with past and future snapshots.
  */
-int rcu_dynticks_snap(struct rcu_data *rdp)
+static int rcu_dynticks_snap(struct rcu_data *rdp)
 {
 	int snap = atomic_add_return(0, &rdp->dynticks);
 
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 055c317..e4dc5de 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -403,8 +403,6 @@ static const char *tp_rcu_varname __used __tracepoint_string = rcu_name;
 #define RCU_NAME rcu_name
 #endif /* #else #ifdef CONFIG_TRACING */
 
-int rcu_dynticks_snap(struct rcu_data *rdp);
-
 /* Forward declarations for tree_plugin.h */
 static void rcu_bootup_announce(void);
 static void rcu_qs(void);
