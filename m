Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,
	BUG6152_INVALID_DATE_TZ_ABSURD,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INVALID_DATE_TZ_ABSURD,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A16EC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 23:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59177207DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 23:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z5wUL9xy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cGNiBmrg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgHSX0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 19:26:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42942 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727871AbgHSX0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 19:26:41 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597879595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8GxjYGXfUv1PPKHdGZLWPSRxkDaNhSt5GiKkc3YYiLc=;
        b=z5wUL9xyuyVf2vcxVJzjUNXCW+Wit4k+gQ/9RizYFV3BeFgp+Bb6xBjuhHhbkfPsE/POgl
        sLn1H6QMKBYCBowSSPeoWu/G3lDsCMWAtjirTbj0kxsWah7WNTI6I16uEOD9niIYafsIjG
        oxlgURwMrAe6gq6Cuip6yjVedB4ehOSziU9GxYrTusZX8krFb4Rvp2oU1rlC4q+g+MHhr1
        0xGOG9P/frJIZwuhVCw3jP9MCElzk7L70oJpTN6C5CQ9wXNa7Zc5huDNxHaIqDUl3arOpE
        6ZRZeZOQAePz3yUVvF5he5t7tmoD6sHJelcYCpeTdntGYKN8Z7mnZ31XzZJLyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597879595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8GxjYGXfUv1PPKHdGZLWPSRxkDaNhSt5GiKkc3YYiLc=;
        b=cGNiBmrgZfofKj9GjwKdqFudSDuSqIZ5Ahah6ldrQWloQSSPMEVPCLB7s2K3Eh2MCeYRHy
        REj+XKWulesRfpAg==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 5/5] lockdep: use pr_cont_t for cont messages
Date:   Thu, 20 Aug 2020 01:32:32 +0206
Message-Id: <20200819232632.13418-6-john.ogness@linutronix.de>
In-Reply-To: <20200819232632.13418-1-john.ogness@linutronix.de>
References: <20200819232632.13418-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new pr_cont_t mechanism.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/locking/lockdep.c | 463 +++++++++++++++++++++++----------------
 1 file changed, 275 insertions(+), 188 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 2fad21d345b0..3210f244cb94 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -638,7 +638,7 @@ void get_usage_chars(struct lock_class *class, char usage[LOCK_USAGE_CHARS])
 	usage[i] = '\0';
 }
 
-static void __print_lock_name(struct lock_class *class)
+static void __print_lock_name(pr_cont_t *c, struct lock_class *class)
 {
 	char str[KSYM_NAME_LEN];
 	const char *name;
@@ -646,30 +646,30 @@ static void __print_lock_name(struct lock_class *class)
 	name = class->name;
 	if (!name) {
 		name = __get_key_name(class->key, str);
-		printk(KERN_CONT "%s", name);
+		pr_cont_append(c, "%s", name);
 	} else {
-		printk(KERN_CONT "%s", name);
+		pr_cont_append(c, "%s", name);
 		if (class->name_version > 1)
-			printk(KERN_CONT "#%d", class->name_version);
+			pr_cont_append(c, "#%d", class->name_version);
 		if (class->subclass)
-			printk(KERN_CONT "/%d", class->subclass);
+			pr_cont_append(c, "/%d", class->subclass);
 	}
 }
 
-static void print_lock_name(struct lock_class *class)
+static void _print_lock_name(pr_cont_t *c, struct lock_class *class)
 {
 	char usage[LOCK_USAGE_CHARS];
 
 	get_usage_chars(class, usage);
 
-	printk(KERN_CONT " (");
-	__print_lock_name(class);
-	printk(KERN_CONT "){%s}-{%hd:%hd}", usage,
+	pr_cont_append(c, " (");
+	__print_lock_name(c, class);
+	pr_cont_append(c, "){%s}-{%hd:%hd}", usage,
 			class->wait_type_outer ?: class->wait_type_inner,
 			class->wait_type_inner);
 }
 
-static void print_lockdep_cache(struct lockdep_map *lock)
+static void _print_lockdep_cache(pr_cont_t *c, struct lockdep_map *lock)
 {
 	const char *name;
 	char str[KSYM_NAME_LEN];
@@ -678,10 +678,10 @@ static void print_lockdep_cache(struct lockdep_map *lock)
 	if (!name)
 		name = __get_key_name(lock->key->subkeys, str);
 
-	printk(KERN_CONT "%s", name);
+	pr_cont_append(c, "%s", name);
 }
 
-static void print_lock(struct held_lock *hlock)
+static void _print_lock(pr_cont_t *c, struct held_lock *hlock)
 {
 	/*
 	 * We can be called locklessly through debug_show_all_locks() so be
@@ -696,16 +696,16 @@ static void print_lock(struct held_lock *hlock)
 	struct lock_class *lock = hlock_class(hlock);
 
 	if (!lock) {
-		printk(KERN_CONT "<RELEASED>\n");
+		pr_cont_append(c, "<RELEASED>");
 		return;
 	}
 
-	printk(KERN_CONT "%px", hlock->instance);
-	print_lock_name(lock);
-	printk(KERN_CONT ", at: %pS\n", (void *)hlock->acquire_ip);
+	pr_cont_append(c, "%px", hlock->instance);
+	_print_lock_name(c, lock);
+	pr_cont_append(c, ", at: %pS\n", (void *)hlock->acquire_ip);
 }
 
-static void lockdep_print_held_locks(struct task_struct *p)
+static void lockdep_print_held_locks(pr_cont_t *c, struct task_struct *p)
 {
 	int i, depth = READ_ONCE(p->lockdep_depth);
 
@@ -721,8 +721,9 @@ static void lockdep_print_held_locks(struct task_struct *p)
 	if (p->state == TASK_RUNNING && p != current)
 		return;
 	for (i = 0; i < depth; i++) {
-		printk(" #%d: ", i);
-		print_lock(p->held_locks + i);
+		pr_cont_begin(c, " #%d: ", i);
+		_print_lock(c, p->held_locks + i);
+		pr_cont_end(c);
 	}
 }
 
@@ -937,7 +938,7 @@ static bool class_lock_list_valid(struct lock_class *c, struct list_head *h)
 
 	list_for_each_entry(e, h, entry) {
 		if (e->links_to != c) {
-			printk(KERN_INFO "class %s: mismatch for lock entry %ld; class %s <> %s",
+			printk(KERN_INFO "class %s: mismatch for lock entry %ld; class %s <> %s\n",
 			       c->name ? : "(?)",
 			       (unsigned long)(e - list_entries),
 			       e->links_to && e->links_to->name ?
@@ -1195,6 +1196,7 @@ register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
 	struct lockdep_subclass_key *key;
 	struct hlist_head *hash_head;
 	struct lock_class *class;
+	pr_cont_t c;
 
 	DEBUG_LOCKS_WARN_ON(!irqs_disabled());
 
@@ -1263,10 +1265,10 @@ register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
 	if (verbose(class)) {
 		graph_unlock();
 
-		printk("\nnew class %px: %s", class->key, class->name);
+		pr_cont_begin(&c, "\nnew class %px: %s", class->key, class->name);
 		if (class->name_version > 1)
-			printk(KERN_CONT "#%d", class->name_version);
-		printk(KERN_CONT "\n");
+			pr_cont_append(&c, "#%d", class->name_version);
+		pr_cont_end(&c);
 		dump_stack();
 
 		if (!graph_lock()) {
@@ -1567,18 +1569,20 @@ static void print_lock_trace(const struct lock_trace *trace,
  * has been detected):
  */
 static noinline void
-print_circular_bug_entry(struct lock_list *target, int depth)
+print_circular_bug_entry(pr_cont_t *c, struct lock_list *target, int depth)
 {
 	if (debug_locks_silent)
 		return;
-	printk("\n-> #%u", depth);
-	print_lock_name(target->class);
-	printk(KERN_CONT ":\n");
+	pr_cont_begin(c, "\n-> #%u", depth);
+	_print_lock_name(c, target->class);
+	pr_cont_append(c, ":");
+	pr_cont_end(c);
 	print_lock_trace(target->trace, 6);
 }
 
 static void
-print_circular_lock_scenario(struct held_lock *src,
+print_circular_lock_scenario(pr_cont_t *c,
+			     struct held_lock *src,
 			     struct held_lock *tgt,
 			     struct lock_list *prt)
 {
@@ -1600,30 +1604,35 @@ print_circular_lock_scenario(struct held_lock *src,
 	 * from the safe_class lock to the unsafe_class lock.
 	 */
 	if (parent != source) {
-		printk("Chain exists of:\n  ");
-		__print_lock_name(source);
-		printk(KERN_CONT " --> ");
-		__print_lock_name(parent);
-		printk(KERN_CONT " --> ");
-		__print_lock_name(target);
-		printk(KERN_CONT "\n\n");
+		pr_cont_begin(c, "Chain exists of:\n  ");
+		__print_lock_name(c, source);
+		pr_cont_append(c, " --> ");
+		__print_lock_name(c, parent);
+		pr_cont_append(c, " --> ");
+		__print_lock_name(c, target);
+		pr_cont_append(c, "\n");
+		pr_cont_end(c);
 	}
 
 	printk(" Possible unsafe locking scenario:\n\n");
 	printk("       CPU0                    CPU1\n");
 	printk("       ----                    ----\n");
-	printk("  lock(");
-	__print_lock_name(target);
-	printk(KERN_CONT ");\n");
-	printk("                               lock(");
-	__print_lock_name(parent);
-	printk(KERN_CONT ");\n");
-	printk("                               lock(");
-	__print_lock_name(target);
-	printk(KERN_CONT ");\n");
-	printk("  lock(");
-	__print_lock_name(source);
-	printk(KERN_CONT ");\n");
+	pr_cont_begin(c, "  lock(");
+	__print_lock_name(c, target);
+	pr_cont_append(c, ");");
+	pr_cont_end(c);
+	pr_cont_begin(c, "                               lock(");
+	__print_lock_name(c, parent);
+	pr_cont_append(c, ");");
+	pr_cont_end(c);
+	pr_cont_begin(c, "                               lock(");
+	__print_lock_name(c, target);
+	pr_cont_append(c, ");");
+	pr_cont_end(c);
+	pr_cont_begin(c, "  lock(");
+	__print_lock_name(c, source);
+	pr_cont_append(c, ");");
+	pr_cont_end(c);
 	printk("\n *** DEADLOCK ***\n\n");
 }
 
@@ -1632,7 +1641,7 @@ print_circular_lock_scenario(struct held_lock *src,
  * header first:
  */
 static noinline void
-print_circular_bug_header(struct lock_list *entry, unsigned int depth,
+print_circular_bug_header(pr_cont_t *c, struct lock_list *entry, unsigned int depth,
 			struct held_lock *check_src,
 			struct held_lock *check_tgt)
 {
@@ -1648,15 +1657,19 @@ print_circular_bug_header(struct lock_list *entry, unsigned int depth,
 	pr_warn("------------------------------------------------------\n");
 	pr_warn("%s/%d is trying to acquire lock:\n",
 		curr->comm, task_pid_nr(curr));
-	print_lock(check_src);
+	pr_cont_begin(c, KERN_WARNING);
+	_print_lock(c, check_src);
+	pr_cont_end(c);
 
 	pr_warn("\nbut task is already holding lock:\n");
 
-	print_lock(check_tgt);
+	pr_cont_begin(c, KERN_WARNING);
+	_print_lock(c, check_tgt);
+	pr_cont_end(c);
 	pr_warn("\nwhich lock already depends on the new lock.\n\n");
 	pr_warn("\nthe existing dependency chain (in reverse order) is:\n");
 
-	print_circular_bug_entry(entry, depth);
+	print_circular_bug_entry(c, entry, depth);
 }
 
 static inline int class_equal(struct lock_list *entry, void *data)
@@ -1664,7 +1677,7 @@ static inline int class_equal(struct lock_list *entry, void *data)
 	return entry->class == data;
 }
 
-static noinline void print_circular_bug(struct lock_list *this,
+static noinline void print_circular_bug(pr_cont_t *c, struct lock_list *this,
 					struct lock_list *target,
 					struct held_lock *check_src,
 					struct held_lock *check_tgt)
@@ -1683,21 +1696,21 @@ static noinline void print_circular_bug(struct lock_list *this,
 
 	depth = get_lock_depth(target);
 
-	print_circular_bug_header(target, depth, check_src, check_tgt);
+	print_circular_bug_header(c, target, depth, check_src, check_tgt);
 
 	parent = get_lock_parent(target);
 	first_parent = parent;
 
 	while (parent) {
-		print_circular_bug_entry(parent, --depth);
+		print_circular_bug_entry(c, parent, --depth);
 		parent = get_lock_parent(parent);
 	}
 
 	printk("\nother info that might help us debug this:\n\n");
-	print_circular_lock_scenario(check_src, check_tgt,
+	print_circular_lock_scenario(c, check_src, check_tgt,
 				     first_parent);
 
-	lockdep_print_held_locks(curr);
+	lockdep_print_held_locks(c, curr);
 
 	printk("\nstack backtrace:\n");
 	dump_stack();
@@ -1803,6 +1816,7 @@ static noinline int
 check_noncircular(struct held_lock *src, struct held_lock *target,
 		  struct lock_trace **const trace)
 {
+	pr_cont_t c;
 	int ret;
 	struct lock_list *target_entry;
 	struct lock_list src_entry = {
@@ -1824,7 +1838,7 @@ check_noncircular(struct held_lock *src, struct held_lock *target,
 			*trace = save_trace();
 		}
 
-		print_circular_bug(&src_entry, target_entry, src, target);
+		print_circular_bug(&c, &src_entry, target_entry, src, target);
 	}
 
 	return ret;
@@ -1928,23 +1942,25 @@ find_usage_backwards(struct lock_list *root, unsigned long usage_mask,
 	return result;
 }
 
-static void print_lock_class_header(struct lock_class *class, int depth)
+static void print_lock_class_header(pr_cont_t *c, struct lock_class *class, int depth)
 {
 	int bit;
 
-	printk("%*s->", depth, "");
-	print_lock_name(class);
+	pr_cont_begin(c, "%*s->", depth, "");
+	_print_lock_name(c, class);
 #ifdef CONFIG_DEBUG_LOCKDEP
-	printk(KERN_CONT " ops: %lu", debug_class_ops_read(class));
+	pr_cont_append(c, " ops: %lu", debug_class_ops_read(class));
 #endif
-	printk(KERN_CONT " {\n");
+	pr_cont_append(c, " {");
+	pr_cont_end(c);
 
 	for (bit = 0; bit < LOCK_USAGE_STATES; bit++) {
 		if (class->usage_mask & (1 << bit)) {
 			int len = depth;
 
-			len += printk("%*s   %s", depth, "", usage_str[bit]);
-			len += printk(KERN_CONT " at:\n");
+			len += pr_cont_begin(c, "%*s   %s", depth, "", usage_str[bit]);
+			len += pr_cont_append(c, " at:");
+			pr_cont_end(c);
 			print_lock_trace(class->usage_traces[bit], len);
 		}
 	}
@@ -1958,7 +1974,7 @@ static void print_lock_class_header(struct lock_class *class, int depth)
  * printk the shortest lock dependencies from @start to @end in reverse order:
  */
 static void __used
-print_shortest_lock_dependencies(struct lock_list *leaf,
+print_shortest_lock_dependencies(pr_cont_t *c, struct lock_list *leaf,
 				 struct lock_list *root)
 {
 	struct lock_list *entry = leaf;
@@ -1968,7 +1984,7 @@ print_shortest_lock_dependencies(struct lock_list *leaf,
 	depth = get_lock_depth(leaf);
 
 	do {
-		print_lock_class_header(entry->class, depth);
+		print_lock_class_header(c, entry->class, depth);
 		printk("%*s ... acquired at:\n", depth, "");
 		print_lock_trace(entry->trace, 2);
 		printk("\n");
@@ -1984,7 +2000,8 @@ print_shortest_lock_dependencies(struct lock_list *leaf,
 }
 
 static void
-print_irq_lock_scenario(struct lock_list *safe_entry,
+print_irq_lock_scenario(pr_cont_t *c,
+			struct lock_list *safe_entry,
 			struct lock_list *unsafe_entry,
 			struct lock_class *prev_class,
 			struct lock_class *next_class)
@@ -2010,37 +2027,43 @@ print_irq_lock_scenario(struct lock_list *safe_entry,
 	 * from the safe_class lock to the unsafe_class lock.
 	 */
 	if (middle_class != unsafe_class) {
-		printk("Chain exists of:\n  ");
-		__print_lock_name(safe_class);
-		printk(KERN_CONT " --> ");
-		__print_lock_name(middle_class);
-		printk(KERN_CONT " --> ");
-		__print_lock_name(unsafe_class);
-		printk(KERN_CONT "\n\n");
+		pr_cont_begin(c, "Chain exists of:\n  ");
+		__print_lock_name(c, safe_class);
+		pr_cont_append(c, " --> ");
+		__print_lock_name(c, middle_class);
+		pr_cont_append(c, " --> ");
+		__print_lock_name(c, unsafe_class);
+		pr_cont_append(c, "\n");
+		pr_cont_end(c);
 	}
 
 	printk(" Possible interrupt unsafe locking scenario:\n\n");
 	printk("       CPU0                    CPU1\n");
 	printk("       ----                    ----\n");
-	printk("  lock(");
-	__print_lock_name(unsafe_class);
-	printk(KERN_CONT ");\n");
+	pr_cont_begin(c, "  lock(");
+	__print_lock_name(c, unsafe_class);
+	pr_cont_append(c, ");");
+	pr_cont_end(c);
 	printk("                               local_irq_disable();\n");
-	printk("                               lock(");
-	__print_lock_name(safe_class);
-	printk(KERN_CONT ");\n");
-	printk("                               lock(");
-	__print_lock_name(middle_class);
-	printk(KERN_CONT ");\n");
+	pr_cont_begin(c, "                               lock(");
+	__print_lock_name(c, safe_class);
+	pr_cont_append(c, ");");
+	pr_cont_end(c);
+	pr_cont_begin(c, "                               lock(");
+	__print_lock_name(c, middle_class);
+	pr_cont_append(c, ");");
+	pr_cont_end(c);
 	printk("  <Interrupt>\n");
-	printk("    lock(");
-	__print_lock_name(safe_class);
-	printk(KERN_CONT ");\n");
+	pr_cont_begin(c, "    lock(");
+	__print_lock_name(c, safe_class);
+	pr_cont_append(c, ");");
+	pr_cont_end(c);
 	printk("\n *** DEADLOCK ***\n\n");
 }
 
 static void
-print_bad_irq_dependency(struct task_struct *curr,
+print_bad_irq_dependency(pr_cont_t *c,
+			 struct task_struct *curr,
 			 struct lock_list *prev_root,
 			 struct lock_list *next_root,
 			 struct lock_list *backwards_entry,
@@ -2066,48 +2089,57 @@ print_bad_irq_dependency(struct task_struct *curr,
 		curr->softirq_context, softirq_count() >> SOFTIRQ_SHIFT,
 		lockdep_hardirqs_enabled(),
 		curr->softirqs_enabled);
-	print_lock(next);
+	pr_cont_begin(c, KERN_WARNING);
+	_print_lock(c, next);
+	pr_cont_end(c);
 
 	pr_warn("\nand this task is already holding:\n");
-	print_lock(prev);
+	pr_cont_begin(c, KERN_WARNING);
+	_print_lock(c, prev);
+	pr_cont_end(c);
 	pr_warn("which would create a new lock dependency:\n");
-	print_lock_name(hlock_class(prev));
-	pr_cont(" ->");
-	print_lock_name(hlock_class(next));
-	pr_cont("\n");
+	pr_cont_begin(c, KERN_WARNING);
+	_print_lock_name(c, hlock_class(prev));
+	pr_cont_append(c, " ->");
+	_print_lock_name(c, hlock_class(next));
+	pr_cont_end(c);
 
 	pr_warn("\nbut this new dependency connects a %s-irq-safe lock:\n",
 		irqclass);
-	print_lock_name(backwards_entry->class);
+	pr_cont_begin(c, KERN_WARNING);
+	_print_lock_name(c, backwards_entry->class);
+	pr_cont_end(c);
 	pr_warn("\n... which became %s-irq-safe at:\n", irqclass);
 
 	print_lock_trace(backwards_entry->class->usage_traces[bit1], 1);
 
 	pr_warn("\nto a %s-irq-unsafe lock:\n", irqclass);
-	print_lock_name(forwards_entry->class);
+	pr_cont_begin(c, KERN_WARNING);
+	_print_lock_name(c, forwards_entry->class);
+	pr_cont_end(c);
 	pr_warn("\n... which became %s-irq-unsafe at:\n", irqclass);
-	pr_warn("...");
+	pr_warn("...\n");
 
 	print_lock_trace(forwards_entry->class->usage_traces[bit2], 1);
 
 	pr_warn("\nother info that might help us debug this:\n\n");
-	print_irq_lock_scenario(backwards_entry, forwards_entry,
+	print_irq_lock_scenario(c, backwards_entry, forwards_entry,
 				hlock_class(prev), hlock_class(next));
 
-	lockdep_print_held_locks(curr);
+	lockdep_print_held_locks(c, curr);
 
 	pr_warn("\nthe dependencies between %s-irq-safe lock and the holding lock:\n", irqclass);
 	prev_root->trace = save_trace();
 	if (!prev_root->trace)
 		return;
-	print_shortest_lock_dependencies(backwards_entry, prev_root);
+	print_shortest_lock_dependencies(c, backwards_entry, prev_root);
 
 	pr_warn("\nthe dependencies between the lock to be acquired");
 	pr_warn(" and %s-irq-unsafe lock:\n", irqclass);
 	next_root->trace = save_trace();
 	if (!next_root->trace)
 		return;
-	print_shortest_lock_dependencies(forwards_entry, next_root);
+	print_shortest_lock_dependencies(c, forwards_entry, next_root);
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
@@ -2247,6 +2279,7 @@ static int check_irq_usage(struct task_struct *curr, struct held_lock *prev,
 	struct lock_list *target_entry1;
 	struct lock_list *target_entry;
 	struct lock_list this, that;
+	pr_cont_t c;
 	int ret;
 
 	/*
@@ -2308,7 +2341,7 @@ static int check_irq_usage(struct task_struct *curr, struct held_lock *prev,
 	if (DEBUG_LOCKS_WARN_ON(ret == -1))
 		return 1;
 
-	print_bad_irq_dependency(curr, &this, &that,
+	print_bad_irq_dependency(&c, curr, &this, &that,
 				 target_entry, target_entry1,
 				 prev, next,
 				 backward_bit, forward_bit,
@@ -2347,7 +2380,7 @@ static void dec_chains(int irq_context)
 }
 
 static void
-print_deadlock_scenario(struct held_lock *nxt, struct held_lock *prv)
+print_deadlock_scenario(pr_cont_t *c, struct held_lock *nxt, struct held_lock *prv)
 {
 	struct lock_class *next = hlock_class(nxt);
 	struct lock_class *prev = hlock_class(prv);
@@ -2355,18 +2388,20 @@ print_deadlock_scenario(struct held_lock *nxt, struct held_lock *prv)
 	printk(" Possible unsafe locking scenario:\n\n");
 	printk("       CPU0\n");
 	printk("       ----\n");
-	printk("  lock(");
-	__print_lock_name(prev);
-	printk(KERN_CONT ");\n");
-	printk("  lock(");
-	__print_lock_name(next);
-	printk(KERN_CONT ");\n");
+	pr_cont_begin(c, "  lock(");
+	__print_lock_name(c, prev);
+	pr_cont_append(c, ");");
+	pr_cont_end(c);
+	pr_cont_begin(c, "  lock(");
+	__print_lock_name(c, next);
+	pr_cont_append(c, ");");
+	pr_cont_end(c);
 	printk("\n *** DEADLOCK ***\n\n");
 	printk(" May be due to missing lock nesting notation\n\n");
 }
 
 static void
-print_deadlock_bug(struct task_struct *curr, struct held_lock *prev,
+print_deadlock_bug(pr_cont_t *c, struct task_struct *curr, struct held_lock *prev,
 		   struct held_lock *next)
 {
 	if (!debug_locks_off_graph_unlock() || debug_locks_silent)
@@ -2379,13 +2414,17 @@ print_deadlock_bug(struct task_struct *curr, struct held_lock *prev,
 	pr_warn("--------------------------------------------\n");
 	pr_warn("%s/%d is trying to acquire lock:\n",
 		curr->comm, task_pid_nr(curr));
-	print_lock(next);
+	pr_cont_begin(c, KERN_WARNING);
+	_print_lock(c, next);
+	pr_cont_end(c);
 	pr_warn("\nbut task is already holding lock:\n");
-	print_lock(prev);
+	pr_cont_begin(c, KERN_WARNING);
+	_print_lock(c, prev);
+	pr_cont_end(c);
 
 	pr_warn("\nother info that might help us debug this:\n");
-	print_deadlock_scenario(next, prev);
-	lockdep_print_held_locks(curr);
+	print_deadlock_scenario(c, next, prev);
+	lockdep_print_held_locks(c, curr);
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
@@ -2404,6 +2443,7 @@ check_deadlock(struct task_struct *curr, struct held_lock *next)
 {
 	struct held_lock *prev;
 	struct held_lock *nest = NULL;
+	pr_cont_t c;
 	int i;
 
 	for (i = 0; i < curr->lockdep_depth; i++) {
@@ -2429,7 +2469,7 @@ check_deadlock(struct task_struct *curr, struct held_lock *next)
 		if (nest)
 			return 2;
 
-		print_deadlock_bug(curr, prev, next);
+		print_deadlock_bug(&c, curr, prev, next);
 		return 0;
 	}
 	return 1;
@@ -2901,18 +2941,18 @@ static inline int get_first_held_lock(struct task_struct *curr,
 /*
  * Returns the next chain_key iteration
  */
-static u64 print_chain_key_iteration(int class_idx, u64 chain_key)
+static u64 _print_chain_key_iteration(pr_cont_t *c, int class_idx, u64 chain_key)
 {
 	u64 new_chain_key = iterate_chain_key(chain_key, class_idx);
 
-	printk(" class_idx:%d -> chain_key:%016Lx",
+	pr_cont_append(c, " class_idx:%d -> chain_key:%016Lx",
 		class_idx,
 		(unsigned long long)new_chain_key);
 	return new_chain_key;
 }
 
 static void
-print_chain_keys_held_locks(struct task_struct *curr, struct held_lock *hlock_next)
+print_chain_keys_held_locks(pr_cont_t *c, struct task_struct *curr, struct held_lock *hlock_next)
 {
 	struct held_lock *hlock;
 	u64 chain_key = INITIAL_CHAIN_KEY;
@@ -2923,16 +2963,20 @@ print_chain_keys_held_locks(struct task_struct *curr, struct held_lock *hlock_ne
 		hlock_next->irq_context);
 	for (; i < depth; i++) {
 		hlock = curr->held_locks + i;
-		chain_key = print_chain_key_iteration(hlock->class_idx, chain_key);
 
-		print_lock(hlock);
+		pr_cont_begin(c, "");
+		chain_key = _print_chain_key_iteration(c, hlock->class_idx, chain_key);
+		_print_lock(c, hlock);
+		pr_cont_end(c);
 	}
 
-	print_chain_key_iteration(hlock_next->class_idx, chain_key);
-	print_lock(hlock_next);
+	pr_cont_begin(c, "");
+	_print_chain_key_iteration(c, hlock_next->class_idx, chain_key);
+	_print_lock(c, hlock_next);
+	pr_cont_end(c);
 }
 
-static void print_chain_keys_chain(struct lock_chain *chain)
+static void print_chain_keys_chain(pr_cont_t *c, struct lock_chain *chain)
 {
 	int i;
 	u64 chain_key = INITIAL_CHAIN_KEY;
@@ -2941,14 +2985,15 @@ static void print_chain_keys_chain(struct lock_chain *chain)
 	printk("depth: %u\n", chain->depth);
 	for (i = 0; i < chain->depth; i++) {
 		class_id = chain_hlocks[chain->base + i];
-		chain_key = print_chain_key_iteration(class_id, chain_key);
 
-		print_lock_name(lock_classes + class_id);
-		printk("\n");
+		pr_cont_begin(c, "");
+		chain_key = _print_chain_key_iteration(c, class_id, chain_key);
+		_print_lock_name(c, lock_classes + class_id);
+		pr_cont_end(c);
 	}
 }
 
-static void print_collision(struct task_struct *curr,
+static void print_collision(pr_cont_t *c, struct task_struct *curr,
 			struct held_lock *hlock_next,
 			struct lock_chain *chain)
 {
@@ -2961,10 +3006,10 @@ static void print_collision(struct task_struct *curr,
 	pr_warn("Hash chain already cached but the contents don't match!\n");
 
 	pr_warn("Held locks:");
-	print_chain_keys_held_locks(curr, hlock_next);
+	print_chain_keys_held_locks(c, curr, hlock_next);
 
 	pr_warn("Locks in cached chain:");
-	print_chain_keys_chain(chain);
+	print_chain_keys_chain(c, chain);
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
@@ -2983,11 +3028,12 @@ static int check_no_collision(struct task_struct *curr,
 {
 #ifdef CONFIG_DEBUG_LOCKDEP
 	int i, j, id;
+	pr_cont_t c;
 
 	i = get_first_held_lock(curr, hlock);
 
 	if (DEBUG_LOCKS_WARN_ON(chain->depth != curr->lockdep_depth - (i - 1))) {
-		print_collision(curr, hlock, chain);
+		print_collision(&c, curr, hlock, chain);
 		return 0;
 	}
 
@@ -2995,7 +3041,7 @@ static int check_no_collision(struct task_struct *curr,
 		id = curr->held_locks[i].class_idx;
 
 		if (DEBUG_LOCKS_WARN_ON(chain_hlocks[chain->base + j] != id)) {
-			print_collision(curr, hlock, chain);
+			print_collision(&c, curr, hlock, chain);
 			return 0;
 		}
 	}
@@ -3296,25 +3342,27 @@ static void check_chain_key(struct task_struct *curr)
 static int mark_lock(struct task_struct *curr, struct held_lock *this,
 		     enum lock_usage_bit new_bit);
 
-static void print_usage_bug_scenario(struct held_lock *lock)
+static void print_usage_bug_scenario(pr_cont_t *c, struct held_lock *lock)
 {
 	struct lock_class *class = hlock_class(lock);
 
 	printk(" Possible unsafe locking scenario:\n\n");
 	printk("       CPU0\n");
 	printk("       ----\n");
-	printk("  lock(");
-	__print_lock_name(class);
-	printk(KERN_CONT ");\n");
+	pr_cont_begin(c, "  lock(");
+	__print_lock_name(c, class);
+	pr_cont_append(c, ");");
+	pr_cont_end(c);
 	printk("  <Interrupt>\n");
-	printk("    lock(");
-	__print_lock_name(class);
-	printk(KERN_CONT ");\n");
+	pr_cont_begin(c, "    lock(");
+	__print_lock_name(c, class);
+	pr_cont_append(c, ");");
+	pr_cont_end(c);
 	printk("\n *** DEADLOCK ***\n\n");
 }
 
 static void
-print_usage_bug(struct task_struct *curr, struct held_lock *this,
+print_usage_bug(pr_cont_t *c, struct task_struct *curr, struct held_lock *this,
 		enum lock_usage_bit prev_bit, enum lock_usage_bit new_bit)
 {
 	if (!debug_locks_off_graph_unlock() || debug_locks_silent)
@@ -3335,16 +3383,18 @@ print_usage_bug(struct task_struct *curr, struct held_lock *this,
 		lockdep_softirq_context(curr), softirq_count() >> SOFTIRQ_SHIFT,
 		lockdep_hardirqs_enabled(),
 		lockdep_softirqs_enabled(curr));
-	print_lock(this);
+	pr_cont_begin(c, KERN_WARNING);
+	_print_lock(c, this);
+	pr_cont_end(c);
 
 	pr_warn("{%s} state was registered at:\n", usage_str[prev_bit]);
 	print_lock_trace(hlock_class(this)->usage_traces[prev_bit], 1);
 
 	print_irqtrace_events(curr);
 	pr_warn("\nother info that might help us debug this:\n");
-	print_usage_bug_scenario(this);
+	print_usage_bug_scenario(c, this);
 
-	lockdep_print_held_locks(curr);
+	lockdep_print_held_locks(c, curr);
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
@@ -3357,8 +3407,10 @@ static inline int
 valid_state(struct task_struct *curr, struct held_lock *this,
 	    enum lock_usage_bit new_bit, enum lock_usage_bit bad_bit)
 {
+	pr_cont_t c;
+
 	if (unlikely(hlock_class(this)->usage_mask & (1 << bad_bit))) {
-		print_usage_bug(curr, this, bad_bit, new_bit);
+		print_usage_bug(&c, curr, this, bad_bit, new_bit);
 		return 0;
 	}
 	return 1;
@@ -3369,7 +3421,7 @@ valid_state(struct task_struct *curr, struct held_lock *this,
  * print irq inversion bug:
  */
 static void
-print_irq_inversion_bug(struct task_struct *curr,
+print_irq_inversion_bug(pr_cont_t *c, struct task_struct *curr,
 			struct lock_list *root, struct lock_list *other,
 			struct held_lock *this, int forwards,
 			const char *irqclass)
@@ -3388,12 +3440,16 @@ print_irq_inversion_bug(struct task_struct *curr,
 	pr_warn("--------------------------------------------------------\n");
 	pr_warn("%s/%d just changed the state of lock:\n",
 		curr->comm, task_pid_nr(curr));
-	print_lock(this);
+	pr_cont_begin(c, KERN_WARNING);
+	_print_lock(c, this);
+	pr_cont_end(c);
 	if (forwards)
 		pr_warn("but this lock took another, %s-unsafe lock in the past:\n", irqclass);
 	else
 		pr_warn("but this lock was taken by another, %s-safe lock in the past:\n", irqclass);
-	print_lock_name(other->class);
+	pr_cont_begin(c, KERN_WARNING);
+	_print_lock_name(c, other->class);
+	pr_cont_end(c);
 	pr_warn("\n\nand interrupts could create inverse lock ordering between them.\n\n");
 
 	pr_warn("\nother info that might help us debug this:\n");
@@ -3410,19 +3466,19 @@ print_irq_inversion_bug(struct task_struct *curr,
 		depth--;
 	} while (entry && entry != root && (depth >= 0));
 	if (forwards)
-		print_irq_lock_scenario(root, other,
+		print_irq_lock_scenario(c, root, other,
 			middle ? middle->class : root->class, other->class);
 	else
-		print_irq_lock_scenario(other, root,
+		print_irq_lock_scenario(c, other, root,
 			middle ? middle->class : other->class, root->class);
 
-	lockdep_print_held_locks(curr);
+	lockdep_print_held_locks(c, curr);
 
 	pr_warn("\nthe shortest dependencies between 2nd lock and 1st lock:\n");
 	root->trace = save_trace();
 	if (!root->trace)
 		return;
-	print_shortest_lock_dependencies(other, root);
+	print_shortest_lock_dependencies(c, other, root);
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
@@ -3439,6 +3495,7 @@ check_usage_forwards(struct task_struct *curr, struct held_lock *this,
 	int ret;
 	struct lock_list root;
 	struct lock_list *target_entry;
+	pr_cont_t c;
 
 	root.parent = NULL;
 	root.class = hlock_class(this);
@@ -3450,7 +3507,7 @@ check_usage_forwards(struct task_struct *curr, struct held_lock *this,
 	if (ret == 1)
 		return ret;
 
-	print_irq_inversion_bug(curr, &root, target_entry,
+	print_irq_inversion_bug(&c, curr, &root, target_entry,
 				this, 1, irqclass);
 	return 0;
 }
@@ -3466,6 +3523,7 @@ check_usage_backwards(struct task_struct *curr, struct held_lock *this,
 	int ret;
 	struct lock_list root;
 	struct lock_list *target_entry;
+	pr_cont_t c;
 
 	root.parent = NULL;
 	root.class = hlock_class(this);
@@ -3477,7 +3535,7 @@ check_usage_backwards(struct task_struct *curr, struct held_lock *this,
 	if (ret == 1)
 		return ret;
 
-	print_irq_inversion_bug(curr, &root, target_entry,
+	print_irq_inversion_bug(&c, curr, &root, target_entry,
 				this, 0, irqclass);
 	return 0;
 }
@@ -3970,6 +4028,7 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 			     enum lock_usage_bit new_bit)
 {
 	unsigned int new_mask = 1 << new_bit, ret = 1;
+	pr_cont_t c;
 
 	if (new_bit >= LOCK_USAGE_STATES) {
 		DEBUG_LOCKS_WARN_ON(1);
@@ -4015,7 +4074,9 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 	 */
 	if (ret == 2) {
 		printk("\nmarked lock as {%s}:\n", usage_str[new_bit]);
-		print_lock(this);
+		pr_cont_begin(&c, "");
+		_print_lock(&c, this);
+		pr_cont_end(&c);
 		print_irqtrace_events(curr);
 		dump_stack();
 	}
@@ -4048,7 +4109,7 @@ static inline short task_wait_context(struct task_struct *curr)
 }
 
 static int
-print_lock_invalid_wait_context(struct task_struct *curr,
+print_lock_invalid_wait_context(pr_cont_t *c, struct task_struct *curr,
 				struct held_lock *hlock)
 {
 	short curr_inner;
@@ -4065,14 +4126,16 @@ print_lock_invalid_wait_context(struct task_struct *curr,
 	pr_warn("-----------------------------\n");
 
 	pr_warn("%s/%d is trying to lock:\n", curr->comm, task_pid_nr(curr));
-	print_lock(hlock);
+	pr_cont_begin(c, KERN_WARNING);
+	_print_lock(c, hlock);
+	pr_cont_end(c);
 
 	pr_warn("other info that might help us debug this:\n");
 
 	curr_inner = task_wait_context(curr);
 	pr_warn("context-{%d:%d}\n", curr_inner, curr_inner);
 
-	lockdep_print_held_locks(curr);
+	lockdep_print_held_locks(c, curr);
 
 	pr_warn("stack backtrace:\n");
 	dump_stack();
@@ -4100,6 +4163,7 @@ static int check_wait_context(struct task_struct *curr, struct held_lock *next)
 	short next_inner = hlock_class(next)->wait_type_inner;
 	short next_outer = hlock_class(next)->wait_type_outer;
 	short curr_inner;
+	pr_cont_t c;
 	int depth;
 
 	if (!curr->lockdep_depth || !next_inner || next->trylock)
@@ -4136,7 +4200,7 @@ static int check_wait_context(struct task_struct *curr, struct held_lock *next)
 	}
 
 	if (next_outer > curr_inner)
-		return print_lock_invalid_wait_context(curr, next);
+		return print_lock_invalid_wait_context(&c, curr, next);
 
 	return 0;
 }
@@ -4236,7 +4300,7 @@ struct lock_class_key __lockdep_no_validate__;
 EXPORT_SYMBOL_GPL(__lockdep_no_validate__);
 
 static void
-print_lock_nested_lock_not_held(struct task_struct *curr,
+print_lock_nested_lock_not_held(pr_cont_t *c, struct task_struct *curr,
 				struct held_lock *hlock,
 				unsigned long ip)
 {
@@ -4252,7 +4316,9 @@ print_lock_nested_lock_not_held(struct task_struct *curr,
 	pr_warn("----------------------------------\n");
 
 	pr_warn("%s/%d is trying to lock:\n", curr->comm, task_pid_nr(curr));
-	print_lock(hlock);
+	pr_cont_begin(c, KERN_WARNING);
+	_print_lock(c, hlock);
+	pr_cont_end(c);
 
 	pr_warn("\nbut this task is not holding:\n");
 	pr_warn("%s\n", hlock->nest_lock->name);
@@ -4261,7 +4327,7 @@ print_lock_nested_lock_not_held(struct task_struct *curr,
 	dump_stack();
 
 	pr_warn("\nother info that might help us debug this:\n");
-	lockdep_print_held_locks(curr);
+	lockdep_print_held_locks(c, curr);
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
@@ -4289,6 +4355,7 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 	int chain_head = 0;
 	int class_idx;
 	u64 chain_key;
+	pr_cont_t c;
 
 	if (unlikely(!debug_locks))
 		return 0;
@@ -4310,10 +4377,10 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 	debug_class_ops_inc(class);
 
 	if (very_verbose(class)) {
-		printk("\nacquire class [%px] %s", class->key, class->name);
+		pr_cont_begin(&c, "\nacquire class [%px] %s", class->key, class->name);
 		if (class->name_version > 1)
-			printk(KERN_CONT "#%d", class->name_version);
-		printk(KERN_CONT "\n");
+			pr_cont_append(&c, "#%d", class->name_version);
+		pr_cont_end(&c);
 		dump_stack();
 	}
 
@@ -4414,7 +4481,7 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 	chain_key = iterate_chain_key(chain_key, class_idx);
 
 	if (nest_lock && !__lock_is_held(nest_lock, -1)) {
-		print_lock_nested_lock_not_held(curr, hlock, ip);
+		print_lock_nested_lock_not_held(&c, curr, hlock, ip);
 		return 0;
 	}
 
@@ -4439,7 +4506,7 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 		printk(KERN_DEBUG "depth: %i  max: %lu!\n",
 		       curr->lockdep_depth, MAX_LOCK_DEPTH);
 
-		lockdep_print_held_locks(current);
+		lockdep_print_held_locks(&c, current);
 		debug_show_all_locks();
 		dump_stack();
 
@@ -4452,7 +4519,7 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 	return 1;
 }
 
-static void print_unlock_imbalance_bug(struct task_struct *curr,
+static void print_unlock_imbalance_bug(pr_cont_t *c, struct task_struct *curr,
 				       struct lockdep_map *lock,
 				       unsigned long ip)
 {
@@ -4468,12 +4535,14 @@ static void print_unlock_imbalance_bug(struct task_struct *curr,
 	pr_warn("-------------------------------------\n");
 	pr_warn("%s/%d is trying to release lock (",
 		curr->comm, task_pid_nr(curr));
-	print_lockdep_cache(lock);
-	pr_cont(") at:\n");
+	pr_cont_begin(c, KERN_WARNING);
+	_print_lockdep_cache(c, lock);
+	pr_cont_append(c, ") at:");
+	pr_cont_end(c);
 	print_ip_sym(KERN_WARNING, ip);
 	pr_warn("but there are no more locks to release!\n");
 	pr_warn("\nother info that might help us debug this:\n");
-	lockdep_print_held_locks(curr);
+	lockdep_print_held_locks(c, curr);
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
@@ -4592,6 +4661,7 @@ __lock_set_class(struct lockdep_map *lock, const char *name,
 	unsigned int depth, merged = 0;
 	struct held_lock *hlock;
 	struct lock_class *class;
+	pr_cont_t c;
 	int i;
 
 	if (unlikely(!debug_locks))
@@ -4607,7 +4677,7 @@ __lock_set_class(struct lockdep_map *lock, const char *name,
 
 	hlock = find_held_lock(curr, lock, depth, &i);
 	if (!hlock) {
-		print_unlock_imbalance_bug(curr, lock, ip);
+		print_unlock_imbalance_bug(&c, curr, lock, ip);
 		return 0;
 	}
 
@@ -4637,6 +4707,7 @@ static int __lock_downgrade(struct lockdep_map *lock, unsigned long ip)
 	struct task_struct *curr = current;
 	unsigned int depth, merged = 0;
 	struct held_lock *hlock;
+	pr_cont_t c;
 	int i;
 
 	if (unlikely(!debug_locks))
@@ -4652,7 +4723,7 @@ static int __lock_downgrade(struct lockdep_map *lock, unsigned long ip)
 
 	hlock = find_held_lock(curr, lock, depth, &i);
 	if (!hlock) {
-		print_unlock_imbalance_bug(curr, lock, ip);
+		print_unlock_imbalance_bug(&c, curr, lock, ip);
 		return 0;
 	}
 
@@ -4691,6 +4762,7 @@ __lock_release(struct lockdep_map *lock, unsigned long ip)
 	struct task_struct *curr = current;
 	unsigned int depth, merged = 1;
 	struct held_lock *hlock;
+	pr_cont_t c;
 	int i;
 
 	if (unlikely(!debug_locks))
@@ -4702,7 +4774,7 @@ __lock_release(struct lockdep_map *lock, unsigned long ip)
 	 * own any locks, you've been drinking again?
 	 */
 	if (depth <= 0) {
-		print_unlock_imbalance_bug(curr, lock, ip);
+		print_unlock_imbalance_bug(&c, curr, lock, ip);
 		return 0;
 	}
 
@@ -4712,7 +4784,7 @@ __lock_release(struct lockdep_map *lock, unsigned long ip)
 	 */
 	hlock = find_held_lock(curr, lock, depth, &i);
 	if (!hlock) {
-		print_unlock_imbalance_bug(curr, lock, ip);
+		print_unlock_imbalance_bug(&c, curr, lock, ip);
 		return 0;
 	}
 
@@ -4942,6 +5014,7 @@ static void verify_lock_unused(struct lockdep_map *lock, struct held_lock *hlock
 {
 #ifdef CONFIG_PROVE_LOCKING
 	struct lock_class *class = look_up_lock_class(lock, subclass);
+	pr_cont_t c;
 
 	/* if it doesn't have a class (yet), it certainly hasn't been used yet */
 	if (!class)
@@ -4952,7 +5025,7 @@ static void verify_lock_unused(struct lockdep_map *lock, struct held_lock *hlock
 
 	hlock->class_idx = class - lock_classes;
 
-	print_usage_bug(current, hlock, LOCK_USED, LOCK_USAGE_STATES);
+	print_usage_bug(&c, current, hlock, LOCK_USED, LOCK_USAGE_STATES);
 #endif
 }
 
@@ -5103,7 +5176,7 @@ void lock_unpin_lock(struct lockdep_map *lock, struct pin_cookie cookie)
 EXPORT_SYMBOL_GPL(lock_unpin_lock);
 
 #ifdef CONFIG_LOCK_STAT
-static void print_lock_contention_bug(struct task_struct *curr,
+static void print_lock_contention_bug(pr_cont_t *c, struct task_struct *curr,
 				      struct lockdep_map *lock,
 				      unsigned long ip)
 {
@@ -5119,12 +5192,14 @@ static void print_lock_contention_bug(struct task_struct *curr,
 	pr_warn("---------------------------------\n");
 	pr_warn("%s/%d is trying to contend lock (",
 		curr->comm, task_pid_nr(curr));
-	print_lockdep_cache(lock);
-	pr_cont(") at:\n");
+	pr_cont_begin(c, KERN_WARNING);
+	_print_lockdep_cache(c, lock);
+	pr_cont_append(c, ") at:");
+	pr_cont_end(c);
 	print_ip_sym(KERN_WARNING, ip);
 	pr_warn("but there are no locks held!\n");
 	pr_warn("\nother info that might help us debug this:\n");
-	lockdep_print_held_locks(curr);
+	lockdep_print_held_locks(c, curr);
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
@@ -5138,6 +5213,7 @@ __lock_contended(struct lockdep_map *lock, unsigned long ip)
 	struct lock_class_stats *stats;
 	unsigned int depth;
 	int i, contention_point, contending_point;
+	pr_cont_t c;
 
 	depth = curr->lockdep_depth;
 	/*
@@ -5149,7 +5225,7 @@ __lock_contended(struct lockdep_map *lock, unsigned long ip)
 
 	hlock = find_held_lock(curr, lock, depth, &i);
 	if (!hlock) {
-		print_lock_contention_bug(curr, lock, ip);
+		print_lock_contention_bug(&c, curr, lock, ip);
 		return;
 	}
 
@@ -5179,6 +5255,7 @@ __lock_acquired(struct lockdep_map *lock, unsigned long ip)
 	struct lock_class_stats *stats;
 	unsigned int depth;
 	u64 now, waittime = 0;
+	pr_cont_t c;
 	int i, cpu;
 
 	depth = curr->lockdep_depth;
@@ -5191,7 +5268,7 @@ __lock_acquired(struct lockdep_map *lock, unsigned long ip)
 
 	hlock = find_held_lock(curr, lock, depth, &i);
 	if (!hlock) {
-		print_lock_contention_bug(curr, lock, _RET_IP_);
+		print_lock_contention_bug(&c, curr, lock, _RET_IP_);
 		return;
 	}
 
@@ -5733,7 +5810,7 @@ void __init lockdep_init(void)
 }
 
 static void
-print_freed_lock_bug(struct task_struct *curr, const void *mem_from,
+print_freed_lock_bug(pr_cont_t *c, struct task_struct *curr, const void *mem_from,
 		     const void *mem_to, struct held_lock *hlock)
 {
 	if (!debug_locks_off())
@@ -5748,8 +5825,10 @@ print_freed_lock_bug(struct task_struct *curr, const void *mem_from,
 	pr_warn("-------------------------\n");
 	pr_warn("%s/%d is freeing memory %px-%px, with a lock still held there!\n",
 		curr->comm, task_pid_nr(curr), mem_from, mem_to-1);
-	print_lock(hlock);
-	lockdep_print_held_locks(curr);
+	pr_cont_begin(c, KERN_WARNING);
+	_print_lock(c, hlock);
+	pr_cont_end(c);
+	lockdep_print_held_locks(c, curr);
 
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
@@ -5772,6 +5851,7 @@ void debug_check_no_locks_freed(const void *mem_from, unsigned long mem_len)
 	struct task_struct *curr = current;
 	struct held_lock *hlock;
 	unsigned long flags;
+	pr_cont_t c;
 	int i;
 
 	if (unlikely(!debug_locks))
@@ -5785,7 +5865,7 @@ void debug_check_no_locks_freed(const void *mem_from, unsigned long mem_len)
 					sizeof(*hlock->instance)))
 			continue;
 
-		print_freed_lock_bug(curr, mem_from, mem_from + mem_len, hlock);
+		print_freed_lock_bug(&c, curr, mem_from, mem_from + mem_len, hlock);
 		break;
 	}
 	raw_local_irq_restore(flags);
@@ -5794,6 +5874,8 @@ EXPORT_SYMBOL_GPL(debug_check_no_locks_freed);
 
 static void print_held_locks_bug(void)
 {
+	pr_cont_t c;
+
 	if (!debug_locks_off())
 		return;
 	if (debug_locks_silent)
@@ -5805,7 +5887,7 @@ static void print_held_locks_bug(void)
 	       current->comm, task_pid_nr(current));
 	print_kernel_ident();
 	pr_warn("------------------------------------\n");
-	lockdep_print_held_locks(current);
+	lockdep_print_held_locks(&c, current);
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
 }
@@ -5821,6 +5903,7 @@ EXPORT_SYMBOL_GPL(debug_check_no_locks_held);
 void debug_show_all_locks(void)
 {
 	struct task_struct *g, *p;
+	pr_cont_t c;
 
 	if (unlikely(!debug_locks)) {
 		pr_warn("INFO: lockdep is turned off.\n");
@@ -5832,7 +5915,7 @@ void debug_show_all_locks(void)
 	for_each_process_thread(g, p) {
 		if (!p->lockdep_depth)
 			continue;
-		lockdep_print_held_locks(p);
+		lockdep_print_held_locks(&c, p);
 		touch_nmi_watchdog();
 		touch_all_softlockup_watchdogs();
 	}
@@ -5850,17 +5933,20 @@ EXPORT_SYMBOL_GPL(debug_show_all_locks);
  */
 void debug_show_held_locks(struct task_struct *task)
 {
+	pr_cont_t c;
+
 	if (unlikely(!debug_locks)) {
 		printk("INFO: lockdep is turned off.\n");
 		return;
 	}
-	lockdep_print_held_locks(task);
+	lockdep_print_held_locks(&c, task);
 }
 EXPORT_SYMBOL_GPL(debug_show_held_locks);
 
 asmlinkage __visible void lockdep_sys_exit(void)
 {
 	struct task_struct *curr = current;
+	pr_cont_t c;
 
 	if (unlikely(curr->lockdep_depth)) {
 		if (!debug_locks_off())
@@ -5872,7 +5958,7 @@ asmlinkage __visible void lockdep_sys_exit(void)
 		pr_warn("------------------------------------------------\n");
 		pr_warn("%s/%d is leaving the kernel with locks still held!\n",
 				curr->comm, curr->pid);
-		lockdep_print_held_locks(curr);
+		lockdep_print_held_locks(&c, curr);
 	}
 
 	/*
@@ -5885,6 +5971,7 @@ asmlinkage __visible void lockdep_sys_exit(void)
 void lockdep_rcu_suspicious(const char *file, const int line, const char *s)
 {
 	struct task_struct *curr = current;
+	pr_cont_t c;
 
 	/* Note: the following can be executed concurrently, so be careful. */
 	pr_warn("\n");
@@ -5921,7 +6008,7 @@ void lockdep_rcu_suspicious(const char *file, const int line, const char *s)
 	if (!rcu_is_watching())
 		pr_warn("RCU used illegally from extended quiescent state!\n");
 
-	lockdep_print_held_locks(curr);
+	lockdep_print_held_locks(&c, curr);
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
 }
-- 
2.20.1

