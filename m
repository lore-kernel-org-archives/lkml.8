Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24AE7C54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 08:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFB702078E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 08:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589270573;
	bh=KAkmCS667bnbpRuzvQBfuZtFcFkzo9lAZUmxhvk7WiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iBf4DeBZ6XVyZpVMG4QKk7MSQCTiL5qg1SC7yGFzdix6l3JFLuo+2pashxPjkCoph
	 WQlO/jYyGpzKbzt1sR3pYrUj+IjjqXYX0utzC9DQW3yc4/8H3rPVkxP8cGBCuOwtm7
	 /NVbLez/D+AWB+Mm/lc8FjowtRmmowj0BkTGGCeg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729087AbgELICw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 04:02:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:56202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725813AbgELICv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 04:02:51 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E55620A8B;
        Tue, 12 May 2020 08:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589270570;
        bh=KAkmCS667bnbpRuzvQBfuZtFcFkzo9lAZUmxhvk7WiM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jbyZR4YrXmeRlls4SP8AVk7aPUraxpPIZhSpXRO2PuownvxVzwO6zCMuPUyRCpYzX
         B/PAhN/DRda0MPcOmoHrgVkWiXOcLu+wCJLM/X0XZFc9z9BEn7w0eepbl5fohKOnxD
         X6nY0ONKTVgKVTI66ZUwu1yReYXyS8D9ZL7fSnmY=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>, paulmck@kernel.org,
        joel@joelfernandes.org,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@elte.hu>,
        Peter Zijlstra <peterz@infradead.org>,
        Ziqian SUN <zsun@redhat.com>
Subject: [PATCH -tip V6 2/6] kprobes: Use non RCU traversal APIs on kprobe_tables if possible
Date:   Tue, 12 May 2020 17:02:44 +0900
Message-Id: <158927056452.27680.9710575332163005121.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <158927054236.27680.18209720730136003586.stgit@devnote2>
References: <158927054236.27680.18209720730136003586.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current kprobes uses RCU traversal APIs on kprobe_tables
even if it is safe because kprobe_mutex is locked.

Make those traversals to non-RCU APIs where the kprobe_mutex
is locked.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/kprobes.c |   29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index bd484392d789..38d9a5d7c8a4 100644
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
@@ -2238,7 +2249,7 @@ static int kprobes_module_callback(struct notifier_block *nb,
 	mutex_lock(&kprobe_mutex);
 	for (i = 0; i < KPROBE_TABLE_SIZE; i++) {
 		head = &kprobe_table[i];
-		hlist_for_each_entry_rcu(p, head, hlist)
+		hlist_for_each_entry(p, head, hlist)
 			if (within_module_init((unsigned long)p->addr, mod) ||
 			    (checkcore &&
 			     within_module_core((unsigned long)p->addr, mod))) {
@@ -2489,7 +2500,7 @@ static int arm_all_kprobes(void)
 	for (i = 0; i < KPROBE_TABLE_SIZE; i++) {
 		head = &kprobe_table[i];
 		/* Arm all kprobes on a best-effort basis */
-		hlist_for_each_entry_rcu(p, head, hlist) {
+		hlist_for_each_entry(p, head, hlist) {
 			if (!kprobe_disabled(p)) {
 				err = arm_kprobe(p);
 				if (err)  {
@@ -2532,7 +2543,7 @@ static int disarm_all_kprobes(void)
 	for (i = 0; i < KPROBE_TABLE_SIZE; i++) {
 		head = &kprobe_table[i];
 		/* Disarm all kprobes on a best-effort basis */
-		hlist_for_each_entry_rcu(p, head, hlist) {
+		hlist_for_each_entry(p, head, hlist) {
 			if (!arch_trampoline_kprobe(p) && !kprobe_disabled(p)) {
 				err = disarm_kprobe(p, false);
 				if (err) {

