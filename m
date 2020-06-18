Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 426EAC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 23:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 203782158C
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 23:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbgFRX4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 19:56:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:35906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727019AbgFRX4l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 19:56:41 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6874208C3;
        Thu, 18 Jun 2020 23:56:40 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jm4Od-003lNB-NU; Thu, 18 Jun 2020 19:56:39 -0400
Message-ID: <20200618235639.611366734@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 18 Jun 2020 19:55:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-linus][PATCH 03/17] kprobes: Use non RCU traversal APIs on kprobe_tables if possible
References: <20200618235556.451120786@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Current kprobes uses RCU traversal APIs on kprobe_tables
even if it is safe because kprobe_mutex is locked.

Make those traversals to non-RCU APIs where the kprobe_mutex
is locked.

Link: http://lkml.kernel.org/r/158927056452.27680.9710575332163005121.stgit@devnote2

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/kprobes.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 8b2fd4145ab3..ceb0e273bd69 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -46,6 +46,11 @@
 
 
 static int kprobes_initialized;
+/* kprobe_table can be accessed by
+ * - Normal hlist traversal and RCU add/del under kprobe_mutex is held.
+ * Or
+ * - RCU hlist traversal under disabling preempt (breakpoint handlers)
+ */
 static struct hlist_head kprobe_table[KPROBE_TABLE_SIZE];
 static struct hlist_head kretprobe_inst_table[KPROBE_TABLE_SIZE];
 
@@ -850,7 +855,7 @@ static void optimize_all_kprobes(void)
 	kprobes_allow_optimization = true;
 	for (i = 0; i < KPROBE_TABLE_SIZE; i++) {
 		head = &kprobe_table[i];
-		hlist_for_each_entry_rcu(p, head, hlist)
+		hlist_for_each_entry(p, head, hlist)
 			if (!kprobe_disabled(p))
 				optimize_kprobe(p);
 	}
@@ -877,7 +882,7 @@ static void unoptimize_all_kprobes(void)
 	kprobes_allow_optimization = false;
 	for (i = 0; i < KPROBE_TABLE_SIZE; i++) {
 		head = &kprobe_table[i];
-		hlist_for_each_entry_rcu(p, head, hlist) {
+		hlist_for_each_entry(p, head, hlist) {
 			if (!kprobe_disabled(p))
 				unoptimize_kprobe(p, false);
 		}
@@ -1500,12 +1505,14 @@ static struct kprobe *__get_valid_kprobe(struct kprobe *p)
 {
 	struct kprobe *ap, *list_p;
 
+	lockdep_assert_held(&kprobe_mutex);
+
 	ap = get_kprobe(p->addr);
 	if (unlikely(!ap))
 		return NULL;
 
 	if (p != ap) {
-		list_for_each_entry_rcu(list_p, &ap->list, list)
+		list_for_each_entry(list_p, &ap->list, list)
 			if (list_p == p)
 			/* kprobe p is a valid probe */
 				goto valid;
@@ -1670,7 +1677,9 @@ static int aggr_kprobe_disabled(struct kprobe *ap)
 {
 	struct kprobe *kp;
 
-	list_for_each_entry_rcu(kp, &ap->list, list)
+	lockdep_assert_held(&kprobe_mutex);
+
+	list_for_each_entry(kp, &ap->list, list)
 		if (!kprobe_disabled(kp))
 			/*
 			 * There is an active probe on the list.
@@ -1749,7 +1758,7 @@ static int __unregister_kprobe_top(struct kprobe *p)
 	else {
 		/* If disabling probe has special handlers, update aggrprobe */
 		if (p->post_handler && !kprobe_gone(p)) {
-			list_for_each_entry_rcu(list_p, &ap->list, list) {
+			list_for_each_entry(list_p, &ap->list, list) {
 				if ((list_p != p) && (list_p->post_handler))
 					goto noclean;
 			}
@@ -2063,13 +2072,15 @@ static void kill_kprobe(struct kprobe *p)
 {
 	struct kprobe *kp;
 
+	lockdep_assert_held(&kprobe_mutex);
+
 	p->flags |= KPROBE_FLAG_GONE;
 	if (kprobe_aggrprobe(p)) {
 		/*
 		 * If this is an aggr_kprobe, we have to list all the
 		 * chained probes and mark them GONE.
 		 */
-		list_for_each_entry_rcu(kp, &p->list, list)
+		list_for_each_entry(kp, &p->list, list)
 			kp->flags |= KPROBE_FLAG_GONE;
 		p->post_handler = NULL;
 		kill_optimized_kprobe(p);
@@ -2313,7 +2324,7 @@ static int kprobes_module_callback(struct notifier_block *nb,
 	mutex_lock(&kprobe_mutex);
 	for (i = 0; i < KPROBE_TABLE_SIZE; i++) {
 		head = &kprobe_table[i];
-		hlist_for_each_entry_rcu(p, head, hlist)
+		hlist_for_each_entry(p, head, hlist)
 			if (within_module_init((unsigned long)p->addr, mod) ||
 			    (checkcore &&
 			     within_module_core((unsigned long)p->addr, mod))) {
@@ -2551,7 +2562,7 @@ static int arm_all_kprobes(void)
 	for (i = 0; i < KPROBE_TABLE_SIZE; i++) {
 		head = &kprobe_table[i];
 		/* Arm all kprobes on a best-effort basis */
-		hlist_for_each_entry_rcu(p, head, hlist) {
+		hlist_for_each_entry(p, head, hlist) {
 			if (!kprobe_disabled(p)) {
 				err = arm_kprobe(p);
 				if (err)  {
@@ -2594,7 +2605,7 @@ static int disarm_all_kprobes(void)
 	for (i = 0; i < KPROBE_TABLE_SIZE; i++) {
 		head = &kprobe_table[i];
 		/* Disarm all kprobes on a best-effort basis */
-		hlist_for_each_entry_rcu(p, head, hlist) {
+		hlist_for_each_entry(p, head, hlist) {
 			if (!arch_trampoline_kprobe(p) && !kprobe_disabled(p)) {
 				err = disarm_kprobe(p, false);
 				if (err) {
-- 
2.26.2


