Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBEDC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 15:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C6C8206ED
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 15:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ah1bdHor"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbgBLPjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 10:39:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40554 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728596AbgBLPjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 10:39:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581521938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=Pi8LTt8KWX0akczSg++lnC0sX1A9TuymEvUWidA/JpI=;
        b=Ah1bdHorl87xY7ztstbRIAOzfc0q03mSrLwzLU3h32q3vH2f2EkEBvbT24WgGR0F3KcUGL
        bXC/Lgh1sh04wJL6f2/bIAC9eOsCPFWF8zbZUgHnLM5sVZK7JrmtfPVX+CRqWqHz1Unjm6
        uM74OATiIx/iMFmE3jNLVM1A0wwCml4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-n84MaRjcMe6tr7kYUhgNUQ-1; Wed, 12 Feb 2020 10:38:53 -0500
X-MC-Unique: n84MaRjcMe6tr7kYUhgNUQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF42F800E21;
        Wed, 12 Feb 2020 15:38:51 +0000 (UTC)
Received: from llong.com (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DD8636E40A;
        Wed, 12 Feb 2020 15:38:50 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH-tip 2/3] locking/lockdep: Extract CONFIG_PROVE_LOCKING code out to lockdep_prove.c
Date:   Wed, 12 Feb 2020 10:38:27 -0500
Message-Id: <20200212153828.346-3-longman@redhat.com>
In-Reply-To: <20200212153828.346-1-longman@redhat.com>
References: <20200212153828.346-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

About half of the lockdep code in lockdep.c are surrounded by the
CONFIG_PROVE_LOCKING conditional compilation macro. There are several
of those conditional compilation blocks making it hard to figure it
out if a certain function is only used for CONFIG_PROVE_LOCKING or not.
That leads to all sort of build problems when modifying the lockdep code.

To make life easier for future update, most of the relevant
CONFIG_PROVE_LOCKING code are now extracted out to the lockdep_prove.c
file making it clear which function is for CONFIG_PROVE_LOCKING and
which is not.  There are still a number of small CONFIG_PROVE_LOCKING
blocks left in lockdep.c, but they are easy to be identified.

This is just a code relocation patch. There is no functional change.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/lockdep.c       | 3216 ++------------------------------
 kernel/locking/lockdep_prove.c | 2820 ++++++++++++++++++++++++++++
 2 files changed, 3025 insertions(+), 3011 deletions(-)
 create mode 100644 kernel/locking/lockdep_prove.c

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 3dad36e2187b..417c0616d791 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -449,104 +449,6 @@ static void print_lockdep_off(const char *bug_msg)
 
 unsigned long nr_stack_trace_entries;
 
-#ifdef CONFIG_PROVE_LOCKING
-/**
- * struct lock_trace - single stack backtrace
- * @hash_entry:	Entry in a stack_trace_hash[] list.
- * @hash:	jhash() of @entries.
- * @nr_entries:	Number of entries in @entries.
- * @entries:	Actual stack backtrace.
- */
-struct lock_trace {
-	struct hlist_node	hash_entry;
-	u32			hash;
-	u32			nr_entries;
-	unsigned long		entries[0] __aligned(sizeof(unsigned long));
-};
-#define LOCK_TRACE_SIZE_IN_LONGS				\
-	(sizeof(struct lock_trace) / sizeof(unsigned long))
-/*
- * Stack-trace: sequence of lock_trace structures. Protected by the graph_lock.
- */
-static unsigned long stack_trace[MAX_STACK_TRACE_ENTRIES];
-static struct hlist_head stack_trace_hash[STACK_TRACE_HASH_SIZE];
-
-static bool traces_identical(struct lock_trace *t1, struct lock_trace *t2)
-{
-	return t1->hash == t2->hash && t1->nr_entries == t2->nr_entries &&
-		memcmp(t1->entries, t2->entries,
-		       t1->nr_entries * sizeof(t1->entries[0])) == 0;
-}
-
-static struct lock_trace *save_trace(void)
-{
-	struct lock_trace *trace, *t2;
-	struct hlist_head *hash_head;
-	u32 hash;
-	int max_entries;
-
-	BUILD_BUG_ON_NOT_POWER_OF_2(STACK_TRACE_HASH_SIZE);
-	BUILD_BUG_ON(LOCK_TRACE_SIZE_IN_LONGS >= MAX_STACK_TRACE_ENTRIES);
-
-	trace = (struct lock_trace *)(stack_trace + nr_stack_trace_entries);
-	max_entries = MAX_STACK_TRACE_ENTRIES - nr_stack_trace_entries -
-		LOCK_TRACE_SIZE_IN_LONGS;
-
-	if (max_entries <= 0) {
-		if (!debug_locks_off_graph_unlock())
-			return NULL;
-
-		print_lockdep_off("BUG: MAX_STACK_TRACE_ENTRIES too low!");
-		dump_stack();
-
-		return NULL;
-	}
-	trace->nr_entries = stack_trace_save(trace->entries, max_entries, 3);
-
-	hash = jhash(trace->entries, trace->nr_entries *
-		     sizeof(trace->entries[0]), 0);
-	trace->hash = hash;
-	hash_head = stack_trace_hash + (hash & (STACK_TRACE_HASH_SIZE - 1));
-	hlist_for_each_entry(t2, hash_head, hash_entry) {
-		if (traces_identical(trace, t2))
-			return t2;
-	}
-	nr_stack_trace_entries += LOCK_TRACE_SIZE_IN_LONGS + trace->nr_entries;
-	hlist_add_head(&trace->hash_entry, hash_head);
-
-	return trace;
-}
-
-/* Return the number of stack traces in the stack_trace[] array. */
-u64 lockdep_stack_trace_count(void)
-{
-	struct lock_trace *trace;
-	u64 c = 0;
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(stack_trace_hash); i++) {
-		hlist_for_each_entry(trace, &stack_trace_hash[i], hash_entry) {
-			c++;
-		}
-	}
-
-	return c;
-}
-
-/* Return the number of stack hash chains that have at least one stack trace. */
-u64 lockdep_stack_hash_count(void)
-{
-	u64 c = 0;
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(stack_trace_hash); i++)
-		if (!hlist_empty(&stack_trace_hash[i]))
-			c++;
-
-	return c;
-}
-#endif
-
 unsigned int nr_hardirq_chains;
 unsigned int nr_softirq_chains;
 unsigned int nr_process_chains;
@@ -559,26 +461,6 @@ unsigned int max_lockdep_depth;
 DEFINE_PER_CPU(struct lockdep_stats, lockdep_stats);
 #endif
 
-#ifdef CONFIG_PROVE_LOCKING
-/*
- * Locking printouts:
- */
-
-#define __USAGE(__STATE)						\
-	[LOCK_USED_IN_##__STATE] = "IN-"__stringify(__STATE)"-W",	\
-	[LOCK_ENABLED_##__STATE] = __stringify(__STATE)"-ON-W",		\
-	[LOCK_USED_IN_##__STATE##_READ] = "IN-"__stringify(__STATE)"-R",\
-	[LOCK_ENABLED_##__STATE##_READ] = __stringify(__STATE)"-ON-R",
-
-static const char *usage_str[] =
-{
-#define LOCKDEP_STATE(__STATE) __USAGE(__STATE)
-#include "lockdep_states.h"
-#undef LOCKDEP_STATE
-	[LOCK_USED] = "INITIAL USE",
-};
-#endif
-
 const char *__get_key_name(const struct lockdep_subclass_key *key, char *str)
 {
 	return kallsyms_lookup((unsigned long)key, NULL, NULL, NULL, str);
@@ -885,8 +767,49 @@ static bool assign_lock_key(struct lockdep_map *lock)
 	return true;
 }
 
+#ifdef CONFIG_PROVE_LOCKING
+#include "lockdep_prove.c"
+#else
+
+static inline int
+mark_usage(struct task_struct *curr, struct held_lock *hlock, int check)
+{
+	return 1;
+}
+
+static inline unsigned int task_irq_context(struct task_struct *task)
+{
+	return 0;
+}
+
+static inline int separate_irq_context(struct task_struct *curr,
+		struct held_lock *hlock)
+{
+	return 0;
+}
+
+static inline int validate_chain(struct task_struct *curr,
+				 struct held_lock *hlock,
+				 int chain_head, u64 chain_key)
+{
+	return 1;
+}
+
+static inline void init_chain_block_buckets(void)			{ }
+static inline void check_flags(unsigned long flags)			{ }
+static inline void remove_class_from_lock_chains(struct pending_free *pf,
+					struct lock_class *class)	{ }
+#endif /* CONFIG_PROVE_LOCKING */
+
 #ifdef CONFIG_DEBUG_LOCKDEP
 
+#ifndef check_lock_chain_key
+static inline bool check_lock_chain_key(struct lock_chain *chain)
+{
+	return true;
+}
+#endif
+
 /* Check whether element @e occurs in list @h */
 static bool in_list(struct list_head *e, struct list_head *h)
 {
@@ -937,33 +860,6 @@ static bool class_lock_list_valid(struct lock_class *c, struct list_head *h)
 	return true;
 }
 
-#ifdef CONFIG_PROVE_LOCKING
-static u16 chain_hlocks[MAX_LOCKDEP_CHAIN_HLOCKS];
-#endif
-
-static bool check_lock_chain_key(struct lock_chain *chain)
-{
-#ifdef CONFIG_PROVE_LOCKING
-	u64 chain_key = INITIAL_CHAIN_KEY;
-	int i;
-
-	for (i = chain->base; i < chain->base + chain->depth; i++)
-		chain_key = iterate_chain_key(chain_key, chain_hlocks[i]);
-	/*
-	 * The 'unsigned long long' casts avoid that a compiler warning
-	 * is reported when building tools/lib/lockdep.
-	 */
-	if (chain->chain_key != chain_key) {
-		printk(KERN_INFO "chain %lld: key %#llx <> %#llx\n",
-		       (unsigned long long)(chain - lock_chains),
-		       (unsigned long long)chain->chain_key,
-		       (unsigned long long)chain_key);
-		return false;
-	}
-#endif
-	return true;
-}
-
 static bool in_any_zapped_class_list(struct lock_class *class)
 {
 	struct pending_free *pf;
@@ -1127,2817 +1023,208 @@ void lockdep_register_key(struct lock_class_key *key)
 	raw_local_irq_save(flags);
 	if (!graph_lock())
 		goto restore_irqs;
-	hlist_for_each_entry_rcu(k, hash_head, hash_entry) {
-		if (WARN_ON_ONCE(k == key))
-			goto out_unlock;
-	}
-	hlist_add_head_rcu(&key->hash_entry, hash_head);
-out_unlock:
-	graph_unlock();
-restore_irqs:
-	raw_local_irq_restore(flags);
-}
-EXPORT_SYMBOL_GPL(lockdep_register_key);
-
-/* Check whether a key has been registered as a dynamic key. */
-static bool is_dynamic_key(const struct lock_class_key *key)
-{
-	struct hlist_head *hash_head;
-	struct lock_class_key *k;
-	bool found = false;
-
-	if (WARN_ON_ONCE(static_obj(key)))
-		return false;
-
-	/*
-	 * If lock debugging is disabled lock_keys_hash[] may contain
-	 * pointers to memory that has already been freed. Avoid triggering
-	 * a use-after-free in that case by returning early.
-	 */
-	if (!debug_locks)
-		return true;
-
-	hash_head = keyhashentry(key);
-
-	rcu_read_lock();
-	hlist_for_each_entry_rcu(k, hash_head, hash_entry) {
-		if (k == key) {
-			found = true;
-			break;
-		}
-	}
-	rcu_read_unlock();
-
-	return found;
-}
-
-/*
- * Register a lock's class in the hash-table, if the class is not present
- * yet. Otherwise we look it up. We cache the result in the lock object
- * itself, so actual lookup of the hash should be once per lock object.
- */
-static struct lock_class *
-register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
-{
-	struct lockdep_subclass_key *key;
-	struct hlist_head *hash_head;
-	struct lock_class *class;
-
-	DEBUG_LOCKS_WARN_ON(!irqs_disabled());
-
-	class = look_up_lock_class(lock, subclass);
-	if (likely(class))
-		goto out_set_class_cache;
-
-	if (!lock->key) {
-		if (!assign_lock_key(lock))
-			return NULL;
-	} else if (!static_obj(lock->key) && !is_dynamic_key(lock->key)) {
-		return NULL;
-	}
-
-	key = lock->key->subkeys + subclass;
-	hash_head = classhashentry(key);
-
-	if (!graph_lock()) {
-		return NULL;
-	}
-	/*
-	 * We have to do the hash-walk again, to avoid races
-	 * with another CPU:
-	 */
-	hlist_for_each_entry_rcu(class, hash_head, hash_entry) {
-		if (class->key == key)
-			goto out_unlock_set;
-	}
-
-	init_data_structures_once();
-
-	/* Allocate a new lock class and add it to the hash. */
-	class = list_first_entry_or_null(&free_lock_classes, typeof(*class),
-					 lock_entry);
-	if (!class) {
-		if (!debug_locks_off_graph_unlock()) {
-			return NULL;
-		}
-
-		print_lockdep_off("BUG: MAX_LOCKDEP_KEYS too low!");
-		dump_stack();
-		return NULL;
-	}
-	nr_lock_classes++;
-	__set_bit(class - lock_classes, lock_classes_in_use);
-	debug_atomic_inc(nr_unused_locks);
-	class->key = key;
-	class->name = lock->name;
-	class->subclass = subclass;
-	WARN_ON_ONCE(!list_empty(&class->locks_before));
-	WARN_ON_ONCE(!list_empty(&class->locks_after));
-	class->name_version = count_matching_names(class);
-	/*
-	 * We use RCU's safe list-add method to make
-	 * parallel walking of the hash-list safe:
-	 */
-	hlist_add_head_rcu(&class->hash_entry, hash_head);
-	/*
-	 * Remove the class from the free list and add it to the global list
-	 * of classes.
-	 */
-	list_move_tail(&class->lock_entry, &all_lock_classes);
-
-	if (verbose(class)) {
-		graph_unlock();
-
-		printk("\nnew class %px: %s", class->key, class->name);
-		if (class->name_version > 1)
-			printk(KERN_CONT "#%d", class->name_version);
-		printk(KERN_CONT "\n");
-		dump_stack();
-
-		if (!graph_lock()) {
-			return NULL;
-		}
-	}
-out_unlock_set:
-	graph_unlock();
-
-out_set_class_cache:
-	if (!subclass || force)
-		lock->class_cache[0] = class;
-	else if (subclass < NR_LOCKDEP_CACHING_CLASSES)
-		lock->class_cache[subclass] = class;
-
-	/*
-	 * Hash collision, did we smoke some? We found a class with a matching
-	 * hash but the subclass -- which is hashed in -- didn't match.
-	 */
-	if (DEBUG_LOCKS_WARN_ON(class->subclass != subclass))
-		return NULL;
-
-	return class;
-}
-
-#ifdef CONFIG_PROVE_LOCKING
-/*
- * Allocate a lockdep entry. (assumes the graph_lock held, returns
- * with NULL on failure)
- */
-static struct lock_list *alloc_list_entry(void)
-{
-	int idx = find_first_zero_bit(list_entries_in_use,
-				      ARRAY_SIZE(list_entries));
-
-	if (idx >= ARRAY_SIZE(list_entries)) {
-		if (!debug_locks_off_graph_unlock())
-			return NULL;
-
-		print_lockdep_off("BUG: MAX_LOCKDEP_ENTRIES too low!");
-		dump_stack();
-		return NULL;
-	}
-	nr_list_entries++;
-	__set_bit(idx, list_entries_in_use);
-	return list_entries + idx;
-}
-
-/*
- * Add a new dependency to the head of the list:
- */
-static int add_lock_to_list(struct lock_class *this,
-			    struct lock_class *links_to, struct list_head *head,
-			    unsigned long ip, int distance,
-			    const struct lock_trace *trace)
-{
-	struct lock_list *entry;
-	/*
-	 * Lock not present yet - get a new dependency struct and
-	 * add it to the list:
-	 */
-	entry = alloc_list_entry();
-	if (!entry)
-		return 0;
-
-	entry->class = this;
-	entry->links_to = links_to;
-	entry->distance = distance;
-	entry->trace = trace;
-	/*
-	 * Both allocation and removal are done under the graph lock; but
-	 * iteration is under RCU-sched; see look_up_lock_class() and
-	 * lockdep_free_key_range().
-	 */
-	list_add_tail_rcu(&entry->entry, head);
-
-	return 1;
-}
-
-/*
- * For good efficiency of modular, we use power of 2
- */
-#define MAX_CIRCULAR_QUEUE_SIZE		4096UL
-#define CQ_MASK				(MAX_CIRCULAR_QUEUE_SIZE-1)
-
-/*
- * The circular_queue and helpers are used to implement graph
- * breadth-first search (BFS) algorithm, by which we can determine
- * whether there is a path from a lock to another. In deadlock checks,
- * a path from the next lock to be acquired to a previous held lock
- * indicates that adding the <prev> -> <next> lock dependency will
- * produce a circle in the graph. Breadth-first search instead of
- * depth-first search is used in order to find the shortest (circular)
- * path.
- */
-struct circular_queue {
-	struct lock_list *element[MAX_CIRCULAR_QUEUE_SIZE];
-	unsigned int  front, rear;
-};
-
-static struct circular_queue lock_cq;
-
-unsigned int max_bfs_queue_depth;
-
-static unsigned int lockdep_dependency_gen_id;
-
-static inline void __cq_init(struct circular_queue *cq)
-{
-	cq->front = cq->rear = 0;
-	lockdep_dependency_gen_id++;
-}
-
-static inline int __cq_empty(struct circular_queue *cq)
-{
-	return (cq->front == cq->rear);
-}
-
-static inline int __cq_full(struct circular_queue *cq)
-{
-	return ((cq->rear + 1) & CQ_MASK) == cq->front;
-}
-
-static inline int __cq_enqueue(struct circular_queue *cq, struct lock_list *elem)
-{
-	if (__cq_full(cq))
-		return -1;
-
-	cq->element[cq->rear] = elem;
-	cq->rear = (cq->rear + 1) & CQ_MASK;
-	return 0;
-}
-
-/*
- * Dequeue an element from the circular_queue, return a lock_list if
- * the queue is not empty, or NULL if otherwise.
- */
-static inline struct lock_list * __cq_dequeue(struct circular_queue *cq)
-{
-	struct lock_list * lock;
-
-	if (__cq_empty(cq))
-		return NULL;
-
-	lock = cq->element[cq->front];
-	cq->front = (cq->front + 1) & CQ_MASK;
-
-	return lock;
-}
-
-static inline unsigned int  __cq_get_elem_count(struct circular_queue *cq)
-{
-	return (cq->rear - cq->front) & CQ_MASK;
-}
-
-static inline void mark_lock_accessed(struct lock_list *lock,
-					struct lock_list *parent)
-{
-	unsigned long nr;
-
-	nr = lock - list_entries;
-	WARN_ON(nr >= ARRAY_SIZE(list_entries)); /* Out-of-bounds, input fail */
-	lock->parent = parent;
-	lock->class->dep_gen_id = lockdep_dependency_gen_id;
-}
-
-static inline unsigned long lock_accessed(struct lock_list *lock)
-{
-	unsigned long nr;
-
-	nr = lock - list_entries;
-	WARN_ON(nr >= ARRAY_SIZE(list_entries)); /* Out-of-bounds, input fail */
-	return lock->class->dep_gen_id == lockdep_dependency_gen_id;
-}
-
-static inline struct lock_list *get_lock_parent(struct lock_list *child)
-{
-	return child->parent;
-}
-
-static inline int get_lock_depth(struct lock_list *child)
-{
-	int depth = 0;
-	struct lock_list *parent;
-
-	while ((parent = get_lock_parent(child))) {
-		child = parent;
-		depth++;
-	}
-	return depth;
-}
-
-/*
- * Return the forward or backward dependency list.
- *
- * @lock:   the lock_list to get its class's dependency list
- * @offset: the offset to struct lock_class to determine whether it is
- *          locks_after or locks_before
- */
-static inline struct list_head *get_dep_list(struct lock_list *lock, int offset)
-{
-	void *lock_class = lock->class;
-
-	return lock_class + offset;
-}
-
-/*
- * Forward- or backward-dependency search, used for both circular dependency
- * checking and hardirq-unsafe/softirq-unsafe checking.
- */
-static int __bfs(struct lock_list *source_entry,
-		 void *data,
-		 int (*match)(struct lock_list *entry, void *data),
-		 struct lock_list **target_entry,
-		 int offset)
-{
-	struct lock_list *entry;
-	struct lock_list *lock;
-	struct list_head *head;
-	struct circular_queue *cq = &lock_cq;
-	int ret = 1;
-
-	if (match(source_entry, data)) {
-		*target_entry = source_entry;
-		ret = 0;
-		goto exit;
-	}
-
-	head = get_dep_list(source_entry, offset);
-	if (list_empty(head))
-		goto exit;
-
-	__cq_init(cq);
-	__cq_enqueue(cq, source_entry);
-
-	while ((lock = __cq_dequeue(cq))) {
-
-		if (!lock->class) {
-			ret = -2;
-			goto exit;
-		}
-
-		head = get_dep_list(lock, offset);
-
-		DEBUG_LOCKS_WARN_ON(!irqs_disabled());
-
-		list_for_each_entry_rcu(entry, head, entry) {
-			if (!lock_accessed(entry)) {
-				unsigned int cq_depth;
-				mark_lock_accessed(entry, lock);
-				if (match(entry, data)) {
-					*target_entry = entry;
-					ret = 0;
-					goto exit;
-				}
-
-				if (__cq_enqueue(cq, entry)) {
-					ret = -1;
-					goto exit;
-				}
-				cq_depth = __cq_get_elem_count(cq);
-				if (max_bfs_queue_depth < cq_depth)
-					max_bfs_queue_depth = cq_depth;
-			}
-		}
-	}
-exit:
-	return ret;
-}
-
-static inline int __bfs_forwards(struct lock_list *src_entry,
-			void *data,
-			int (*match)(struct lock_list *entry, void *data),
-			struct lock_list **target_entry)
-{
-	return __bfs(src_entry, data, match, target_entry,
-		     offsetof(struct lock_class, locks_after));
-
-}
-
-static inline int __bfs_backwards(struct lock_list *src_entry,
-			void *data,
-			int (*match)(struct lock_list *entry, void *data),
-			struct lock_list **target_entry)
-{
-	return __bfs(src_entry, data, match, target_entry,
-		     offsetof(struct lock_class, locks_before));
-
-}
-
-static void print_lock_trace(const struct lock_trace *trace,
-			     unsigned int spaces)
-{
-	stack_trace_print(trace->entries, trace->nr_entries, spaces);
-}
-
-/*
- * Print a dependency chain entry (this is only done when a deadlock
- * has been detected):
- */
-static noinline void
-print_circular_bug_entry(struct lock_list *target, int depth)
-{
-	if (debug_locks_silent)
-		return;
-	printk("\n-> #%u", depth);
-	print_lock_name(target->class);
-	printk(KERN_CONT ":\n");
-	print_lock_trace(target->trace, 6);
-}
-
-static void
-print_circular_lock_scenario(struct held_lock *src,
-			     struct held_lock *tgt,
-			     struct lock_list *prt)
-{
-	struct lock_class *source = hlock_class(src);
-	struct lock_class *target = hlock_class(tgt);
-	struct lock_class *parent = prt->class;
-
-	/*
-	 * A direct locking problem where unsafe_class lock is taken
-	 * directly by safe_class lock, then all we need to show
-	 * is the deadlock scenario, as it is obvious that the
-	 * unsafe lock is taken under the safe lock.
-	 *
-	 * But if there is a chain instead, where the safe lock takes
-	 * an intermediate lock (middle_class) where this lock is
-	 * not the same as the safe lock, then the lock chain is
-	 * used to describe the problem. Otherwise we would need
-	 * to show a different CPU case for each link in the chain
-	 * from the safe_class lock to the unsafe_class lock.
-	 */
-	if (parent != source) {
-		printk("Chain exists of:\n  ");
-		__print_lock_name(source);
-		printk(KERN_CONT " --> ");
-		__print_lock_name(parent);
-		printk(KERN_CONT " --> ");
-		__print_lock_name(target);
-		printk(KERN_CONT "\n\n");
-	}
-
-	printk(" Possible unsafe locking scenario:\n\n");
-	printk("       CPU0                    CPU1\n");
-	printk("       ----                    ----\n");
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
-	printk("\n *** DEADLOCK ***\n\n");
-}
-
-/*
- * When a circular dependency is detected, print the
- * header first:
- */
-static noinline void
-print_circular_bug_header(struct lock_list *entry, unsigned int depth,
-			struct held_lock *check_src,
-			struct held_lock *check_tgt)
-{
-	struct task_struct *curr = current;
-
-	if (debug_locks_silent)
-		return;
-
-	pr_warn("\n");
-	pr_warn("======================================================\n");
-	pr_warn("WARNING: possible circular locking dependency detected\n");
-	print_kernel_ident();
-	pr_warn("------------------------------------------------------\n");
-	pr_warn("%s/%d is trying to acquire lock:\n",
-		curr->comm, task_pid_nr(curr));
-	print_lock(check_src);
-
-	pr_warn("\nbut task is already holding lock:\n");
-
-	print_lock(check_tgt);
-	pr_warn("\nwhich lock already depends on the new lock.\n\n");
-	pr_warn("\nthe existing dependency chain (in reverse order) is:\n");
-
-	print_circular_bug_entry(entry, depth);
-}
-
-static inline int class_equal(struct lock_list *entry, void *data)
-{
-	return entry->class == data;
-}
-
-static noinline void print_circular_bug(struct lock_list *this,
-					struct lock_list *target,
-					struct held_lock *check_src,
-					struct held_lock *check_tgt)
-{
-	struct task_struct *curr = current;
-	struct lock_list *parent;
-	struct lock_list *first_parent;
-	int depth;
-
-	if (!debug_locks_off_graph_unlock() || debug_locks_silent)
-		return;
-
-	this->trace = save_trace();
-	if (!this->trace)
-		return;
-
-	depth = get_lock_depth(target);
-
-	print_circular_bug_header(target, depth, check_src, check_tgt);
-
-	parent = get_lock_parent(target);
-	first_parent = parent;
-
-	while (parent) {
-		print_circular_bug_entry(parent, --depth);
-		parent = get_lock_parent(parent);
-	}
-
-	printk("\nother info that might help us debug this:\n\n");
-	print_circular_lock_scenario(check_src, check_tgt,
-				     first_parent);
-
-	lockdep_print_held_locks(curr);
-
-	printk("\nstack backtrace:\n");
-	dump_stack();
-}
-
-static noinline void print_bfs_bug(int ret)
-{
-	if (!debug_locks_off_graph_unlock())
-		return;
-
-	/*
-	 * Breadth-first-search failed, graph got corrupted?
-	 */
-	WARN(1, "lockdep bfs error:%d\n", ret);
-}
-
-static int noop_count(struct lock_list *entry, void *data)
-{
-	(*(unsigned long *)data)++;
-	return 0;
-}
-
-static unsigned long __lockdep_count_forward_deps(struct lock_list *this)
-{
-	unsigned long  count = 0;
-	struct lock_list *uninitialized_var(target_entry);
-
-	__bfs_forwards(this, (void *)&count, noop_count, &target_entry);
-
-	return count;
-}
-unsigned long lockdep_count_forward_deps(struct lock_class *class)
-{
-	unsigned long ret, flags;
-	struct lock_list this;
-
-	this.parent = NULL;
-	this.class = class;
-
-	raw_local_irq_save(flags);
-	arch_spin_lock(&lockdep_lock);
-	ret = __lockdep_count_forward_deps(&this);
-	arch_spin_unlock(&lockdep_lock);
-	raw_local_irq_restore(flags);
-
-	return ret;
-}
-
-static unsigned long __lockdep_count_backward_deps(struct lock_list *this)
-{
-	unsigned long  count = 0;
-	struct lock_list *uninitialized_var(target_entry);
-
-	__bfs_backwards(this, (void *)&count, noop_count, &target_entry);
-
-	return count;
-}
-
-unsigned long lockdep_count_backward_deps(struct lock_class *class)
-{
-	unsigned long ret, flags;
-	struct lock_list this;
-
-	this.parent = NULL;
-	this.class = class;
-
-	raw_local_irq_save(flags);
-	arch_spin_lock(&lockdep_lock);
-	ret = __lockdep_count_backward_deps(&this);
-	arch_spin_unlock(&lockdep_lock);
-	raw_local_irq_restore(flags);
-
-	return ret;
-}
-
-/*
- * Check that the dependency graph starting at <src> can lead to
- * <target> or not. Print an error and return 0 if it does.
- */
-static noinline int
-check_path(struct lock_class *target, struct lock_list *src_entry,
-	   struct lock_list **target_entry)
-{
-	int ret;
-
-	ret = __bfs_forwards(src_entry, (void *)target, class_equal,
-			     target_entry);
-
-	if (unlikely(ret < 0))
-		print_bfs_bug(ret);
-
-	return ret;
-}
-
-/*
- * Prove that the dependency graph starting at <src> can not
- * lead to <target>. If it can, there is a circle when adding
- * <target> -> <src> dependency.
- *
- * Print an error and return 0 if it does.
- */
-static noinline int
-check_noncircular(struct held_lock *src, struct held_lock *target,
-		  struct lock_trace **const trace)
-{
-	int ret;
-	struct lock_list *uninitialized_var(target_entry);
-	struct lock_list src_entry = {
-		.class = hlock_class(src),
-		.parent = NULL,
-	};
-
-	debug_atomic_inc(nr_cyclic_checks);
-
-	ret = check_path(hlock_class(target), &src_entry, &target_entry);
-
-	if (unlikely(!ret)) {
-		if (!*trace) {
-			/*
-			 * If save_trace fails here, the printing might
-			 * trigger a WARN but because of the !nr_entries it
-			 * should not do bad things.
-			 */
-			*trace = save_trace();
-		}
-
-		print_circular_bug(&src_entry, target_entry, src, target);
-	}
-
-	return ret;
-}
-
-#ifdef CONFIG_LOCKDEP_SMALL
-/*
- * Check that the dependency graph starting at <src> can lead to
- * <target> or not. If it can, <src> -> <target> dependency is already
- * in the graph.
- *
- * Print an error and return 2 if it does or 1 if it does not.
- */
-static noinline int
-check_redundant(struct held_lock *src, struct held_lock *target)
-{
-	int ret;
-	struct lock_list *uninitialized_var(target_entry);
-	struct lock_list src_entry = {
-		.class = hlock_class(src),
-		.parent = NULL,
-	};
-
-	debug_atomic_inc(nr_redundant_checks);
-
-	ret = check_path(hlock_class(target), &src_entry, &target_entry);
-
-	if (!ret) {
-		debug_atomic_inc(nr_redundant);
-		ret = 2;
-	} else if (ret < 0)
-		ret = 0;
-
-	return ret;
-}
-#endif
-
-#ifdef CONFIG_TRACE_IRQFLAGS
-
-static inline int usage_accumulate(struct lock_list *entry, void *mask)
-{
-	*(unsigned long *)mask |= entry->class->usage_mask;
-
-	return 0;
-}
-
-/*
- * Forwards and backwards subgraph searching, for the purposes of
- * proving that two subgraphs can be connected by a new dependency
- * without creating any illegal irq-safe -> irq-unsafe lock dependency.
- */
-
-static inline int usage_match(struct lock_list *entry, void *mask)
-{
-	return entry->class->usage_mask & *(unsigned long *)mask;
-}
-
-/*
- * Find a node in the forwards-direction dependency sub-graph starting
- * at @root->class that matches @bit.
- *
- * Return 0 if such a node exists in the subgraph, and put that node
- * into *@target_entry.
- *
- * Return 1 otherwise and keep *@target_entry unchanged.
- * Return <0 on error.
- */
-static int
-find_usage_forwards(struct lock_list *root, unsigned long usage_mask,
-			struct lock_list **target_entry)
-{
-	int result;
-
-	debug_atomic_inc(nr_find_usage_forwards_checks);
-
-	result = __bfs_forwards(root, &usage_mask, usage_match, target_entry);
-
-	return result;
-}
-
-/*
- * Find a node in the backwards-direction dependency sub-graph starting
- * at @root->class that matches @bit.
- *
- * Return 0 if such a node exists in the subgraph, and put that node
- * into *@target_entry.
- *
- * Return 1 otherwise and keep *@target_entry unchanged.
- * Return <0 on error.
- */
-static int
-find_usage_backwards(struct lock_list *root, unsigned long usage_mask,
-			struct lock_list **target_entry)
-{
-	int result;
-
-	debug_atomic_inc(nr_find_usage_backwards_checks);
-
-	result = __bfs_backwards(root, &usage_mask, usage_match, target_entry);
-
-	return result;
-}
-
-static void print_lock_class_header(struct lock_class *class, int depth)
-{
-	int bit;
-
-	printk("%*s->", depth, "");
-	print_lock_name(class);
-#ifdef CONFIG_DEBUG_LOCKDEP
-	printk(KERN_CONT " ops: %lu", debug_class_ops_read(class));
-#endif
-	printk(KERN_CONT " {\n");
-
-	for (bit = 0; bit < LOCK_USAGE_STATES; bit++) {
-		if (class->usage_mask & (1 << bit)) {
-			int len = depth;
-
-			len += printk("%*s   %s", depth, "", usage_str[bit]);
-			len += printk(KERN_CONT " at:\n");
-			print_lock_trace(class->usage_traces[bit], len);
-		}
-	}
-	printk("%*s }\n", depth, "");
-
-	printk("%*s ... key      at: [<%px>] %pS\n",
-		depth, "", class->key, class->key);
-}
-
-/*
- * printk the shortest lock dependencies from @start to @end in reverse order:
- */
-static void __used
-print_shortest_lock_dependencies(struct lock_list *leaf,
-				 struct lock_list *root)
-{
-	struct lock_list *entry = leaf;
-	int depth;
-
-	/*compute depth from generated tree by BFS*/
-	depth = get_lock_depth(leaf);
-
-	do {
-		print_lock_class_header(entry->class, depth);
-		printk("%*s ... acquired at:\n", depth, "");
-		print_lock_trace(entry->trace, 2);
-		printk("\n");
-
-		if (depth == 0 && (entry != root)) {
-			printk("lockdep:%s bad path found in chain graph\n", __func__);
-			break;
-		}
-
-		entry = get_lock_parent(entry);
-		depth--;
-	} while (entry && (depth >= 0));
-}
-
-static void
-print_irq_lock_scenario(struct lock_list *safe_entry,
-			struct lock_list *unsafe_entry,
-			struct lock_class *prev_class,
-			struct lock_class *next_class)
-{
-	struct lock_class *safe_class = safe_entry->class;
-	struct lock_class *unsafe_class = unsafe_entry->class;
-	struct lock_class *middle_class = prev_class;
-
-	if (middle_class == safe_class)
-		middle_class = next_class;
-
-	/*
-	 * A direct locking problem where unsafe_class lock is taken
-	 * directly by safe_class lock, then all we need to show
-	 * is the deadlock scenario, as it is obvious that the
-	 * unsafe lock is taken under the safe lock.
-	 *
-	 * But if there is a chain instead, where the safe lock takes
-	 * an intermediate lock (middle_class) where this lock is
-	 * not the same as the safe lock, then the lock chain is
-	 * used to describe the problem. Otherwise we would need
-	 * to show a different CPU case for each link in the chain
-	 * from the safe_class lock to the unsafe_class lock.
-	 */
-	if (middle_class != unsafe_class) {
-		printk("Chain exists of:\n  ");
-		__print_lock_name(safe_class);
-		printk(KERN_CONT " --> ");
-		__print_lock_name(middle_class);
-		printk(KERN_CONT " --> ");
-		__print_lock_name(unsafe_class);
-		printk(KERN_CONT "\n\n");
-	}
-
-	printk(" Possible interrupt unsafe locking scenario:\n\n");
-	printk("       CPU0                    CPU1\n");
-	printk("       ----                    ----\n");
-	printk("  lock(");
-	__print_lock_name(unsafe_class);
-	printk(KERN_CONT ");\n");
-	printk("                               local_irq_disable();\n");
-	printk("                               lock(");
-	__print_lock_name(safe_class);
-	printk(KERN_CONT ");\n");
-	printk("                               lock(");
-	__print_lock_name(middle_class);
-	printk(KERN_CONT ");\n");
-	printk("  <Interrupt>\n");
-	printk("    lock(");
-	__print_lock_name(safe_class);
-	printk(KERN_CONT ");\n");
-	printk("\n *** DEADLOCK ***\n\n");
-}
-
-static void
-print_bad_irq_dependency(struct task_struct *curr,
-			 struct lock_list *prev_root,
-			 struct lock_list *next_root,
-			 struct lock_list *backwards_entry,
-			 struct lock_list *forwards_entry,
-			 struct held_lock *prev,
-			 struct held_lock *next,
-			 enum lock_usage_bit bit1,
-			 enum lock_usage_bit bit2,
-			 const char *irqclass)
-{
-	if (!debug_locks_off_graph_unlock() || debug_locks_silent)
-		return;
-
-	pr_warn("\n");
-	pr_warn("=====================================================\n");
-	pr_warn("WARNING: %s-safe -> %s-unsafe lock order detected\n",
-		irqclass, irqclass);
-	print_kernel_ident();
-	pr_warn("-----------------------------------------------------\n");
-	pr_warn("%s/%d [HC%u[%lu]:SC%u[%lu]:HE%u:SE%u] is trying to acquire:\n",
-		curr->comm, task_pid_nr(curr),
-		curr->hardirq_context, hardirq_count() >> HARDIRQ_SHIFT,
-		curr->softirq_context, softirq_count() >> SOFTIRQ_SHIFT,
-		curr->hardirqs_enabled,
-		curr->softirqs_enabled);
-	print_lock(next);
-
-	pr_warn("\nand this task is already holding:\n");
-	print_lock(prev);
-	pr_warn("which would create a new lock dependency:\n");
-	print_lock_name(hlock_class(prev));
-	pr_cont(" ->");
-	print_lock_name(hlock_class(next));
-	pr_cont("\n");
-
-	pr_warn("\nbut this new dependency connects a %s-irq-safe lock:\n",
-		irqclass);
-	print_lock_name(backwards_entry->class);
-	pr_warn("\n... which became %s-irq-safe at:\n", irqclass);
-
-	print_lock_trace(backwards_entry->class->usage_traces[bit1], 1);
-
-	pr_warn("\nto a %s-irq-unsafe lock:\n", irqclass);
-	print_lock_name(forwards_entry->class);
-	pr_warn("\n... which became %s-irq-unsafe at:\n", irqclass);
-	pr_warn("...");
-
-	print_lock_trace(forwards_entry->class->usage_traces[bit2], 1);
-
-	pr_warn("\nother info that might help us debug this:\n\n");
-	print_irq_lock_scenario(backwards_entry, forwards_entry,
-				hlock_class(prev), hlock_class(next));
-
-	lockdep_print_held_locks(curr);
-
-	pr_warn("\nthe dependencies between %s-irq-safe lock and the holding lock:\n", irqclass);
-	prev_root->trace = save_trace();
-	if (!prev_root->trace)
-		return;
-	print_shortest_lock_dependencies(backwards_entry, prev_root);
-
-	pr_warn("\nthe dependencies between the lock to be acquired");
-	pr_warn(" and %s-irq-unsafe lock:\n", irqclass);
-	next_root->trace = save_trace();
-	if (!next_root->trace)
-		return;
-	print_shortest_lock_dependencies(forwards_entry, next_root);
-
-	pr_warn("\nstack backtrace:\n");
-	dump_stack();
-}
-
-static const char *state_names[] = {
-#define LOCKDEP_STATE(__STATE) \
-	__stringify(__STATE),
-#include "lockdep_states.h"
-#undef LOCKDEP_STATE
-};
-
-static const char *state_rnames[] = {
-#define LOCKDEP_STATE(__STATE) \
-	__stringify(__STATE)"-READ",
-#include "lockdep_states.h"
-#undef LOCKDEP_STATE
-};
-
-static inline const char *state_name(enum lock_usage_bit bit)
-{
-	if (bit & LOCK_USAGE_READ_MASK)
-		return state_rnames[bit >> LOCK_USAGE_DIR_MASK];
-	else
-		return state_names[bit >> LOCK_USAGE_DIR_MASK];
-}
-
-/*
- * The bit number is encoded like:
- *
- *  bit0: 0 exclusive, 1 read lock
- *  bit1: 0 used in irq, 1 irq enabled
- *  bit2-n: state
- */
-static int exclusive_bit(int new_bit)
-{
-	int state = new_bit & LOCK_USAGE_STATE_MASK;
-	int dir = new_bit & LOCK_USAGE_DIR_MASK;
-
-	/*
-	 * keep state, bit flip the direction and strip read.
-	 */
-	return state | (dir ^ LOCK_USAGE_DIR_MASK);
-}
-
-/*
- * Observe that when given a bitmask where each bitnr is encoded as above, a
- * right shift of the mask transforms the individual bitnrs as -1 and
- * conversely, a left shift transforms into +1 for the individual bitnrs.
- *
- * So for all bits whose number have LOCK_ENABLED_* set (bitnr1 == 1), we can
- * create the mask with those bit numbers using LOCK_USED_IN_* (bitnr1 == 0)
- * instead by subtracting the bit number by 2, or shifting the mask right by 2.
- *
- * Similarly, bitnr1 == 0 becomes bitnr1 == 1 by adding 2, or shifting left 2.
- *
- * So split the mask (note that LOCKF_ENABLED_IRQ_ALL|LOCKF_USED_IN_IRQ_ALL is
- * all bits set) and recompose with bitnr1 flipped.
- */
-static unsigned long invert_dir_mask(unsigned long mask)
-{
-	unsigned long excl = 0;
-
-	/* Invert dir */
-	excl |= (mask & LOCKF_ENABLED_IRQ_ALL) >> LOCK_USAGE_DIR_MASK;
-	excl |= (mask & LOCKF_USED_IN_IRQ_ALL) << LOCK_USAGE_DIR_MASK;
-
-	return excl;
-}
-
-/*
- * As above, we clear bitnr0 (LOCK_*_READ off) with bitmask ops. First, for all
- * bits with bitnr0 set (LOCK_*_READ), add those with bitnr0 cleared (LOCK_*).
- * And then mask out all bitnr0.
- */
-static unsigned long exclusive_mask(unsigned long mask)
-{
-	unsigned long excl = invert_dir_mask(mask);
-
-	/* Strip read */
-	excl |= (excl & LOCKF_IRQ_READ) >> LOCK_USAGE_READ_MASK;
-	excl &= ~LOCKF_IRQ_READ;
-
-	return excl;
-}
-
-/*
- * Retrieve the _possible_ original mask to which @mask is
- * exclusive. Ie: this is the opposite of exclusive_mask().
- * Note that 2 possible original bits can match an exclusive
- * bit: one has LOCK_USAGE_READ_MASK set, the other has it
- * cleared. So both are returned for each exclusive bit.
- */
-static unsigned long original_mask(unsigned long mask)
-{
-	unsigned long excl = invert_dir_mask(mask);
-
-	/* Include read in existing usages */
-	excl |= (excl & LOCKF_IRQ) << LOCK_USAGE_READ_MASK;
-
-	return excl;
-}
-
-/*
- * Find the first pair of bit match between an original
- * usage mask and an exclusive usage mask.
- */
-static int find_exclusive_match(unsigned long mask,
-				unsigned long excl_mask,
-				enum lock_usage_bit *bitp,
-				enum lock_usage_bit *excl_bitp)
-{
-	int bit, excl;
-
-	for_each_set_bit(bit, &mask, LOCK_USED) {
-		excl = exclusive_bit(bit);
-		if (excl_mask & lock_flag(excl)) {
-			*bitp = bit;
-			*excl_bitp = excl;
-			return 0;
-		}
-	}
-	return -1;
-}
-
-/*
- * Prove that the new dependency does not connect a hardirq-safe(-read)
- * lock with a hardirq-unsafe lock - to achieve this we search
- * the backwards-subgraph starting at <prev>, and the
- * forwards-subgraph starting at <next>:
- */
-static int check_irq_usage(struct task_struct *curr, struct held_lock *prev,
-			   struct held_lock *next)
-{
-	unsigned long usage_mask = 0, forward_mask, backward_mask;
-	enum lock_usage_bit forward_bit = 0, backward_bit = 0;
-	struct lock_list *uninitialized_var(target_entry1);
-	struct lock_list *uninitialized_var(target_entry);
-	struct lock_list this, that;
-	int ret;
-
-	/*
-	 * Step 1: gather all hard/soft IRQs usages backward in an
-	 * accumulated usage mask.
-	 */
-	this.parent = NULL;
-	this.class = hlock_class(prev);
-
-	ret = __bfs_backwards(&this, &usage_mask, usage_accumulate, NULL);
-	if (ret < 0) {
-		print_bfs_bug(ret);
-		return 0;
-	}
-
-	usage_mask &= LOCKF_USED_IN_IRQ_ALL;
-	if (!usage_mask)
-		return 1;
-
-	/*
-	 * Step 2: find exclusive uses forward that match the previous
-	 * backward accumulated mask.
-	 */
-	forward_mask = exclusive_mask(usage_mask);
-
-	that.parent = NULL;
-	that.class = hlock_class(next);
-
-	ret = find_usage_forwards(&that, forward_mask, &target_entry1);
-	if (ret < 0) {
-		print_bfs_bug(ret);
-		return 0;
-	}
-	if (ret == 1)
-		return ret;
-
-	/*
-	 * Step 3: we found a bad match! Now retrieve a lock from the backward
-	 * list whose usage mask matches the exclusive usage mask from the
-	 * lock found on the forward list.
-	 */
-	backward_mask = original_mask(target_entry1->class->usage_mask);
-
-	ret = find_usage_backwards(&this, backward_mask, &target_entry);
-	if (ret < 0) {
-		print_bfs_bug(ret);
-		return 0;
-	}
-	if (DEBUG_LOCKS_WARN_ON(ret == 1))
-		return 1;
-
-	/*
-	 * Step 4: narrow down to a pair of incompatible usage bits
-	 * and report it.
-	 */
-	ret = find_exclusive_match(target_entry->class->usage_mask,
-				   target_entry1->class->usage_mask,
-				   &backward_bit, &forward_bit);
-	if (DEBUG_LOCKS_WARN_ON(ret == -1))
-		return 1;
-
-	print_bad_irq_dependency(curr, &this, &that,
-				 target_entry, target_entry1,
-				 prev, next,
-				 backward_bit, forward_bit,
-				 state_name(backward_bit));
-
-	return 0;
-}
-
-#else
-
-static inline int check_irq_usage(struct task_struct *curr,
-				  struct held_lock *prev, struct held_lock *next)
-{
-	return 1;
-}
-#endif /* CONFIG_TRACE_IRQFLAGS */
-
-static void inc_chains(int irq_context)
-{
-	if (irq_context & LOCK_CHAIN_HARDIRQ_CONTEXT)
-		nr_hardirq_chains++;
-	else if (irq_context & LOCK_CHAIN_SOFTIRQ_CONTEXT)
-		nr_softirq_chains++;
-	else
-		nr_process_chains++;
-}
-
-static void dec_chains(int irq_context)
-{
-	if (irq_context & LOCK_CHAIN_HARDIRQ_CONTEXT)
-		nr_hardirq_chains--;
-	else if (irq_context & LOCK_CHAIN_SOFTIRQ_CONTEXT)
-		nr_softirq_chains--;
-	else
-		nr_process_chains--;
-}
-
-static void
-print_deadlock_scenario(struct held_lock *nxt, struct held_lock *prv)
-{
-	struct lock_class *next = hlock_class(nxt);
-	struct lock_class *prev = hlock_class(prv);
-
-	printk(" Possible unsafe locking scenario:\n\n");
-	printk("       CPU0\n");
-	printk("       ----\n");
-	printk("  lock(");
-	__print_lock_name(prev);
-	printk(KERN_CONT ");\n");
-	printk("  lock(");
-	__print_lock_name(next);
-	printk(KERN_CONT ");\n");
-	printk("\n *** DEADLOCK ***\n\n");
-	printk(" May be due to missing lock nesting notation\n\n");
-}
-
-static void
-print_deadlock_bug(struct task_struct *curr, struct held_lock *prev,
-		   struct held_lock *next)
-{
-	if (!debug_locks_off_graph_unlock() || debug_locks_silent)
-		return;
-
-	pr_warn("\n");
-	pr_warn("============================================\n");
-	pr_warn("WARNING: possible recursive locking detected\n");
-	print_kernel_ident();
-	pr_warn("--------------------------------------------\n");
-	pr_warn("%s/%d is trying to acquire lock:\n",
-		curr->comm, task_pid_nr(curr));
-	print_lock(next);
-	pr_warn("\nbut task is already holding lock:\n");
-	print_lock(prev);
-
-	pr_warn("\nother info that might help us debug this:\n");
-	print_deadlock_scenario(next, prev);
-	lockdep_print_held_locks(curr);
-
-	pr_warn("\nstack backtrace:\n");
-	dump_stack();
-}
-
-/*
- * Check whether we are holding such a class already.
- *
- * (Note that this has to be done separately, because the graph cannot
- * detect such classes of deadlocks.)
- *
- * Returns: 0 on deadlock detected, 1 on OK, 2 on recursive read
- */
-static int
-check_deadlock(struct task_struct *curr, struct held_lock *next)
-{
-	struct held_lock *prev;
-	struct held_lock *nest = NULL;
-	int i;
-
-	for (i = 0; i < curr->lockdep_depth; i++) {
-		prev = curr->held_locks + i;
-
-		if (prev->instance == next->nest_lock)
-			nest = prev;
-
-		if (hlock_class(prev) != hlock_class(next))
-			continue;
-
-		/*
-		 * Allow read-after-read recursion of the same
-		 * lock class (i.e. read_lock(lock)+read_lock(lock)):
-		 */
-		if ((next->read == 2) && prev->read)
-			return 2;
-
-		/*
-		 * We're holding the nest_lock, which serializes this lock's
-		 * nesting behaviour.
-		 */
-		if (nest)
-			return 2;
-
-		print_deadlock_bug(curr, prev, next);
-		return 0;
-	}
-	return 1;
-}
-
-/*
- * There was a chain-cache miss, and we are about to add a new dependency
- * to a previous lock. We validate the following rules:
- *
- *  - would the adding of the <prev> -> <next> dependency create a
- *    circular dependency in the graph? [== circular deadlock]
- *
- *  - does the new prev->next dependency connect any hardirq-safe lock
- *    (in the full backwards-subgraph starting at <prev>) with any
- *    hardirq-unsafe lock (in the full forwards-subgraph starting at
- *    <next>)? [== illegal lock inversion with hardirq contexts]
- *
- *  - does the new prev->next dependency connect any softirq-safe lock
- *    (in the full backwards-subgraph starting at <prev>) with any
- *    softirq-unsafe lock (in the full forwards-subgraph starting at
- *    <next>)? [== illegal lock inversion with softirq contexts]
- *
- * any of these scenarios could lead to a deadlock.
- *
- * Then if all the validations pass, we add the forwards and backwards
- * dependency.
- */
-static int
-check_prev_add(struct task_struct *curr, struct held_lock *prev,
-	       struct held_lock *next, int distance,
-	       struct lock_trace **const trace)
-{
-	struct lock_list *entry;
-	int ret;
-
-	if (!hlock_class(prev)->key || !hlock_class(next)->key) {
-		/*
-		 * The warning statements below may trigger a use-after-free
-		 * of the class name. It is better to trigger a use-after free
-		 * and to have the class name most of the time instead of not
-		 * having the class name available.
-		 */
-		WARN_ONCE(!debug_locks_silent && !hlock_class(prev)->key,
-			  "Detected use-after-free of lock class %px/%s\n",
-			  hlock_class(prev),
-			  hlock_class(prev)->name);
-		WARN_ONCE(!debug_locks_silent && !hlock_class(next)->key,
-			  "Detected use-after-free of lock class %px/%s\n",
-			  hlock_class(next),
-			  hlock_class(next)->name);
-		return 2;
-	}
-
-	/*
-	 * Prove that the new <prev> -> <next> dependency would not
-	 * create a circular dependency in the graph. (We do this by
-	 * a breadth-first search into the graph starting at <next>,
-	 * and check whether we can reach <prev>.)
-	 *
-	 * The search is limited by the size of the circular queue (i.e.,
-	 * MAX_CIRCULAR_QUEUE_SIZE) which keeps track of a breadth of nodes
-	 * in the graph whose neighbours are to be checked.
-	 */
-	ret = check_noncircular(next, prev, trace);
-	if (unlikely(ret <= 0))
-		return 0;
-
-	if (!check_irq_usage(curr, prev, next))
-		return 0;
-
-	/*
-	 * For recursive read-locks we do all the dependency checks,
-	 * but we dont store read-triggered dependencies (only
-	 * write-triggered dependencies). This ensures that only the
-	 * write-side dependencies matter, and that if for example a
-	 * write-lock never takes any other locks, then the reads are
-	 * equivalent to a NOP.
-	 */
-	if (next->read == 2 || prev->read == 2)
-		return 1;
-	/*
-	 * Is the <prev> -> <next> dependency already present?
-	 *
-	 * (this may occur even though this is a new chain: consider
-	 *  e.g. the L1 -> L2 -> L3 -> L4 and the L5 -> L1 -> L2 -> L3
-	 *  chains - the second one will be new, but L1 already has
-	 *  L2 added to its dependency list, due to the first chain.)
-	 */
-	list_for_each_entry(entry, &hlock_class(prev)->locks_after, entry) {
-		if (entry->class == hlock_class(next)) {
-			if (distance == 1)
-				entry->distance = 1;
-			return 1;
-		}
-	}
-
-#ifdef CONFIG_LOCKDEP_SMALL
-	/*
-	 * Is the <prev> -> <next> link redundant?
-	 */
-	ret = check_redundant(prev, next);
-	if (ret != 1)
-		return ret;
-#endif
-
-	if (!*trace) {
-		*trace = save_trace();
-		if (!*trace)
-			return 0;
-	}
-
-	/*
-	 * Ok, all validations passed, add the new lock
-	 * to the previous lock's dependency list:
-	 */
-	ret = add_lock_to_list(hlock_class(next), hlock_class(prev),
-			       &hlock_class(prev)->locks_after,
-			       next->acquire_ip, distance, *trace);
-
-	if (!ret)
-		return 0;
-
-	ret = add_lock_to_list(hlock_class(prev), hlock_class(next),
-			       &hlock_class(next)->locks_before,
-			       next->acquire_ip, distance, *trace);
-	if (!ret)
-		return 0;
-
-	return 2;
-}
-
-/*
- * Add the dependency to all directly-previous locks that are 'relevant'.
- * The ones that are relevant are (in increasing distance from curr):
- * all consecutive trylock entries and the final non-trylock entry - or
- * the end of this context's lock-chain - whichever comes first.
- */
-static int
-check_prevs_add(struct task_struct *curr, struct held_lock *next)
-{
-	struct lock_trace *trace = NULL;
-	int depth = curr->lockdep_depth;
-	struct held_lock *hlock;
-
-	/*
-	 * Debugging checks.
-	 *
-	 * Depth must not be zero for a non-head lock:
-	 */
-	if (!depth)
-		goto out_bug;
-	/*
-	 * At least two relevant locks must exist for this
-	 * to be a head:
-	 */
-	if (curr->held_locks[depth].irq_context !=
-			curr->held_locks[depth-1].irq_context)
-		goto out_bug;
-
-	for (;;) {
-		int distance = curr->lockdep_depth - depth + 1;
-		hlock = curr->held_locks + depth - 1;
-
-		/*
-		 * Only non-recursive-read entries get new dependencies
-		 * added:
-		 */
-		if (hlock->read != 2 && hlock->check) {
-			int ret = check_prev_add(curr, hlock, next, distance,
-						 &trace);
-			if (!ret)
-				return 0;
-
-			/*
-			 * Stop after the first non-trylock entry,
-			 * as non-trylock entries have added their
-			 * own direct dependencies already, so this
-			 * lock is connected to them indirectly:
-			 */
-			if (!hlock->trylock)
-				break;
-		}
-
-		depth--;
-		/*
-		 * End of lock-stack?
-		 */
-		if (!depth)
-			break;
-		/*
-		 * Stop the search if we cross into another context:
-		 */
-		if (curr->held_locks[depth].irq_context !=
-				curr->held_locks[depth-1].irq_context)
-			break;
-	}
-	return 1;
-out_bug:
-	if (!debug_locks_off_graph_unlock())
-		return 0;
-
-	/*
-	 * Clearly we all shouldn't be here, but since we made it we
-	 * can reliable say we messed up our state. See the above two
-	 * gotos for reasons why we could possibly end up here.
-	 */
-	WARN_ON(1);
-
-	return 0;
-}
-
-struct lock_chain lock_chains[MAX_LOCKDEP_CHAINS];
-static DECLARE_BITMAP(lock_chains_in_use, MAX_LOCKDEP_CHAINS);
-static u16 chain_hlocks[MAX_LOCKDEP_CHAIN_HLOCKS];
-unsigned long nr_zapped_lock_chains;
-unsigned int nr_free_chain_hlocks;	/* Free chain_hlocks in buckets */
-unsigned int nr_lost_chain_hlocks;	/* Lost chain_hlocks */
-unsigned int nr_large_chain_blocks;	/* size > MAX_CHAIN_BUCKETS */
-
-/*
- * The first 2 chain_hlocks entries in the chain block in the bucket
- * list contains the following meta data:
- *
- *   entry[0]:
- *     Bit    15 - always set to 1 (it is not a class index)
- *     Bits 0-14 - upper 15 bits of the next block index
- *   entry[1]    - lower 16 bits of next block index
- *
- * A next block index of all 1 bits means it is the end of the list.
- *
- * On the unsized bucket (bucket-0), the 3rd and 4th entries contain
- * the chain block size:
- *
- *   entry[2] - upper 16 bits of the chain block size
- *   entry[3] - lower 16 bits of the chain block size
- */
-#define MAX_CHAIN_BUCKETS	16
-#define CHAIN_BLK_FLAG		(1U << 15)
-#define CHAIN_BLK_LIST_END	0xFFFFU
-
-static int chain_block_buckets[MAX_CHAIN_BUCKETS];
-
-static inline int size_to_bucket(int size)
-{
-	if (size > MAX_CHAIN_BUCKETS)
-		return 0;
-
-	return size - 1;
-}
-
-/*
- * Iterate all the chain blocks in a bucket.
- */
-#define for_each_chain_block(bucket, prev, curr)		\
-	for ((prev) = -1, (curr) = chain_block_buckets[bucket];	\
-	     (curr) >= 0;					\
-	     (prev) = (curr), (curr) = chain_block_next(curr))
-
-/*
- * next block or -1
- */
-static inline int chain_block_next(int offset)
-{
-	int next = chain_hlocks[offset];
-
-	WARN_ON_ONCE(!(next & CHAIN_BLK_FLAG));
-
-	if (next == CHAIN_BLK_LIST_END)
-		return -1;
-
-	next &= ~CHAIN_BLK_FLAG;
-	next <<= 16;
-	next |= chain_hlocks[offset + 1];
-
-	return next;
-}
-
-/*
- * bucket-0 only
- */
-static inline int chain_block_size(int offset)
-{
-	return (chain_hlocks[offset + 2] << 16) | chain_hlocks[offset + 3];
-}
-
-static inline void init_chain_block(int offset, int next, int bucket, int size)
-{
-	chain_hlocks[offset] = (next >> 16) | CHAIN_BLK_FLAG;
-	chain_hlocks[offset + 1] = (u16)next;
-
-	if (size && !bucket) {
-		chain_hlocks[offset + 2] = size >> 16;
-		chain_hlocks[offset + 3] = (u16)size;
-	}
-}
-
-static inline void add_chain_block(int offset, int size)
-{
-	int bucket = size_to_bucket(size);
-	int next = chain_block_buckets[bucket];
-	int prev, curr;
-
-	if (unlikely(size < 2)) {
-		/*
-		 * We can't store single entries on the freelist. Leak them.
-		 *
-		 * One possible way out would be to uniquely mark them, other
-		 * than with CHAIN_BLK_FLAG, such that we can recover them when
-		 * the block before it is re-added.
-		 */
-		if (size)
-			nr_lost_chain_hlocks++;
-		return;
-	}
-
-	nr_free_chain_hlocks += size;
-	if (!bucket) {
-		nr_large_chain_blocks++;
-
-		/*
-		 * Variable sized, sort large to small.
-		 */
-		for_each_chain_block(0, prev, curr) {
-			if (size >= chain_block_size(curr))
-				break;
-		}
-		init_chain_block(offset, curr, 0, size);
-		if (prev < 0)
-			chain_block_buckets[0] = offset;
-		else
-			init_chain_block(prev, offset, 0, 0);
-		return;
-	}
-	/*
-	 * Fixed size, add to head.
-	 */
-	init_chain_block(offset, next, bucket, size);
-	chain_block_buckets[bucket] = offset;
-}
-
-/*
- * Only the first block in the list can be deleted.
- *
- * For the variable size bucket[0], the first block (the largest one) is
- * returned, broken up and put back into the pool. So if a chain block of
- * length > MAX_CHAIN_BUCKETS is ever used and zapped, it will just be
- * queued up after the primordial chain block and never be used until the
- * hlock entries in the primordial chain block is almost used up. That
- * causes fragmentation and reduce allocation efficiency. That can be
- * monitored by looking at the "large chain blocks" number in lockdep_stats.
- */
-static inline void del_chain_block(int bucket, int size, int next)
-{
-	nr_free_chain_hlocks -= size;
-	chain_block_buckets[bucket] = next;
-
-	if (!bucket)
-		nr_large_chain_blocks--;
-}
-
-static void init_chain_block_buckets(void)
-{
-	int i;
-
-	for (i = 0; i < MAX_CHAIN_BUCKETS; i++)
-		chain_block_buckets[i] = -1;
-
-	add_chain_block(0, ARRAY_SIZE(chain_hlocks));
-}
-
-/*
- * Return offset of a chain block of the right size or -1 if not found.
- *
- * Fairly simple worst-fit allocator with the addition of a number of size
- * specific free lists.
- */
-static int alloc_chain_hlocks(int req)
-{
-	int bucket, curr, size;
-
-	/*
-	 * We rely on the MSB to act as an escape bit to denote freelist
-	 * pointers. Make sure this bit isn't set in 'normal' class_idx usage.
-	 */
-	BUILD_BUG_ON((MAX_LOCKDEP_KEYS-1) & CHAIN_BLK_FLAG);
-
-	init_data_structures_once();
-
-	if (nr_free_chain_hlocks < req)
-		return -1;
-
-	/*
-	 * We require a minimum of 2 (u16) entries to encode a freelist
-	 * 'pointer'.
-	 */
-	req = max(req, 2);
-	bucket = size_to_bucket(req);
-	curr = chain_block_buckets[bucket];
-
-	if (bucket) {
-		if (curr >= 0) {
-			del_chain_block(bucket, req, chain_block_next(curr));
-			return curr;
-		}
-		/* Try bucket 0 */
-		curr = chain_block_buckets[0];
-	}
-
-	/*
-	 * The variable sized freelist is sorted by size; the first entry is
-	 * the largest. Use it if it fits.
-	 */
-	if (curr >= 0) {
-		size = chain_block_size(curr);
-		if (likely(size >= req)) {
-			del_chain_block(0, size, chain_block_next(curr));
-			add_chain_block(curr + req, size - req);
-			return curr;
-		}
-	}
-
-	/*
-	 * Last resort, split a block in a larger sized bucket.
-	 */
-	for (size = MAX_CHAIN_BUCKETS; size > req; size--) {
-		bucket = size_to_bucket(size);
-		curr = chain_block_buckets[bucket];
-		if (curr < 0)
-			continue;
-
-		del_chain_block(bucket, size, chain_block_next(curr));
-		add_chain_block(curr + req, size - req);
-		return curr;
-	}
-
-	return -1;
-}
-
-static inline void free_chain_hlocks(int base, int size)
-{
-	add_chain_block(base, max(size, 2));
-}
-
-struct lock_class *lock_chain_get_class(struct lock_chain *chain, int i)
-{
-	return lock_classes + chain_hlocks[chain->base + i];
-}
-
-/*
- * Returns the index of the first held_lock of the current chain
- */
-static inline int get_first_held_lock(struct task_struct *curr,
-					struct held_lock *hlock)
-{
-	int i;
-	struct held_lock *hlock_curr;
-
-	for (i = curr->lockdep_depth - 1; i >= 0; i--) {
-		hlock_curr = curr->held_locks + i;
-		if (hlock_curr->irq_context != hlock->irq_context)
-			break;
-
-	}
-
-	return ++i;
-}
-
-#ifdef CONFIG_DEBUG_LOCKDEP
-/*
- * Returns the next chain_key iteration
- */
-static u64 print_chain_key_iteration(int class_idx, u64 chain_key)
-{
-	u64 new_chain_key = iterate_chain_key(chain_key, class_idx);
-
-	printk(" class_idx:%d -> chain_key:%016Lx",
-		class_idx,
-		(unsigned long long)new_chain_key);
-	return new_chain_key;
-}
-
-static void
-print_chain_keys_held_locks(struct task_struct *curr, struct held_lock *hlock_next)
-{
-	struct held_lock *hlock;
-	u64 chain_key = INITIAL_CHAIN_KEY;
-	int depth = curr->lockdep_depth;
-	int i = get_first_held_lock(curr, hlock_next);
-
-	printk("depth: %u (irq_context %u)\n", depth - i + 1,
-		hlock_next->irq_context);
-	for (; i < depth; i++) {
-		hlock = curr->held_locks + i;
-		chain_key = print_chain_key_iteration(hlock->class_idx, chain_key);
-
-		print_lock(hlock);
-	}
-
-	print_chain_key_iteration(hlock_next->class_idx, chain_key);
-	print_lock(hlock_next);
-}
-
-static void print_chain_keys_chain(struct lock_chain *chain)
-{
-	int i;
-	u64 chain_key = INITIAL_CHAIN_KEY;
-	int class_id;
-
-	printk("depth: %u\n", chain->depth);
-	for (i = 0; i < chain->depth; i++) {
-		class_id = chain_hlocks[chain->base + i];
-		chain_key = print_chain_key_iteration(class_id, chain_key);
-
-		print_lock_name(lock_classes + class_id);
-		printk("\n");
-	}
-}
-
-static void print_collision(struct task_struct *curr,
-			struct held_lock *hlock_next,
-			struct lock_chain *chain)
-{
-	pr_warn("\n");
-	pr_warn("============================\n");
-	pr_warn("WARNING: chain_key collision\n");
-	print_kernel_ident();
-	pr_warn("----------------------------\n");
-	pr_warn("%s/%d: ", current->comm, task_pid_nr(current));
-	pr_warn("Hash chain already cached but the contents don't match!\n");
-
-	pr_warn("Held locks:");
-	print_chain_keys_held_locks(curr, hlock_next);
-
-	pr_warn("Locks in cached chain:");
-	print_chain_keys_chain(chain);
-
-	pr_warn("\nstack backtrace:\n");
-	dump_stack();
-}
-#endif
-
-/*
- * Checks whether the chain and the current held locks are consistent
- * in depth and also in content. If they are not it most likely means
- * that there was a collision during the calculation of the chain_key.
- * Returns: 0 not passed, 1 passed
- */
-static int check_no_collision(struct task_struct *curr,
-			struct held_lock *hlock,
-			struct lock_chain *chain)
-{
-#ifdef CONFIG_DEBUG_LOCKDEP
-	int i, j, id;
-
-	i = get_first_held_lock(curr, hlock);
-
-	if (DEBUG_LOCKS_WARN_ON(chain->depth != curr->lockdep_depth - (i - 1))) {
-		print_collision(curr, hlock, chain);
-		return 0;
-	}
-
-	for (j = 0; j < chain->depth - 1; j++, i++) {
-		id = curr->held_locks[i].class_idx;
-
-		if (DEBUG_LOCKS_WARN_ON(chain_hlocks[chain->base + j] != id)) {
-			print_collision(curr, hlock, chain);
-			return 0;
-		}
-	}
-#endif
-	return 1;
-}
-
-/*
- * Given an index that is >= -1, return the index of the next lock chain.
- * Return -2 if there is no next lock chain.
- */
-long lockdep_next_lockchain(long i)
-{
-	i = find_next_bit(lock_chains_in_use, ARRAY_SIZE(lock_chains), i + 1);
-	return i < ARRAY_SIZE(lock_chains) ? i : -2;
-}
-
-unsigned long lock_chain_count(void)
-{
-	return bitmap_weight(lock_chains_in_use, ARRAY_SIZE(lock_chains));
-}
-
-/* Must be called with the graph lock held. */
-static struct lock_chain *alloc_lock_chain(void)
-{
-	int idx = find_first_zero_bit(lock_chains_in_use,
-				      ARRAY_SIZE(lock_chains));
-
-	if (unlikely(idx >= ARRAY_SIZE(lock_chains)))
-		return NULL;
-	__set_bit(idx, lock_chains_in_use);
-	return lock_chains + idx;
-}
-
-/*
- * Adds a dependency chain into chain hashtable. And must be called with
- * graph_lock held.
- *
- * Return 0 if fail, and graph_lock is released.
- * Return 1 if succeed, with graph_lock held.
- */
-static inline int add_chain_cache(struct task_struct *curr,
-				  struct held_lock *hlock,
-				  u64 chain_key)
-{
-	struct lock_class *class = hlock_class(hlock);
-	struct hlist_head *hash_head = chainhashentry(chain_key);
-	struct lock_chain *chain;
-	int i, j;
-
-	/*
-	 * The caller must hold the graph lock, ensure we've got IRQs
-	 * disabled to make this an IRQ-safe lock.. for recursion reasons
-	 * lockdep won't complain about its own locking errors.
-	 */
-	if (DEBUG_LOCKS_WARN_ON(!irqs_disabled()))
-		return 0;
-
-	chain = alloc_lock_chain();
-	if (!chain) {
-		if (!debug_locks_off_graph_unlock())
-			return 0;
-
-		print_lockdep_off("BUG: MAX_LOCKDEP_CHAINS too low!");
-		dump_stack();
-		return 0;
-	}
-	chain->chain_key = chain_key;
-	chain->irq_context = hlock->irq_context;
-	i = get_first_held_lock(curr, hlock);
-	chain->depth = curr->lockdep_depth + 1 - i;
-
-	BUILD_BUG_ON((1UL << 24) <= ARRAY_SIZE(chain_hlocks));
-	BUILD_BUG_ON((1UL << 6)  <= ARRAY_SIZE(curr->held_locks));
-	BUILD_BUG_ON((1UL << 8*sizeof(chain_hlocks[0])) <= ARRAY_SIZE(lock_classes));
-
-	j = alloc_chain_hlocks(chain->depth);
-	if (j < 0) {
-		if (!debug_locks_off_graph_unlock())
-			return 0;
-
-		print_lockdep_off("BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!");
-		dump_stack();
-		return 0;
-	}
-
-	chain->base = j;
-	for (j = 0; j < chain->depth - 1; j++, i++) {
-		int lock_id = curr->held_locks[i].class_idx;
-
-		chain_hlocks[chain->base + j] = lock_id;
-	}
-	chain_hlocks[chain->base + j] = class - lock_classes;
-	hlist_add_head_rcu(&chain->entry, hash_head);
-	debug_atomic_inc(chain_lookup_misses);
-	inc_chains(chain->irq_context);
-
-	return 1;
-}
-
-/*
- * Look up a dependency chain. Must be called with either the graph lock or
- * the RCU read lock held.
- */
-static inline struct lock_chain *lookup_chain_cache(u64 chain_key)
-{
-	struct hlist_head *hash_head = chainhashentry(chain_key);
-	struct lock_chain *chain;
-
-	hlist_for_each_entry_rcu(chain, hash_head, entry) {
-		if (READ_ONCE(chain->chain_key) == chain_key) {
-			debug_atomic_inc(chain_lookup_hits);
-			return chain;
-		}
-	}
-	return NULL;
-}
-
-/*
- * If the key is not present yet in dependency chain cache then
- * add it and return 1 - in this case the new dependency chain is
- * validated. If the key is already hashed, return 0.
- * (On return with 1 graph_lock is held.)
- */
-static inline int lookup_chain_cache_add(struct task_struct *curr,
-					 struct held_lock *hlock,
-					 u64 chain_key)
-{
-	struct lock_class *class = hlock_class(hlock);
-	struct lock_chain *chain = lookup_chain_cache(chain_key);
-
-	if (chain) {
-cache_hit:
-		if (!check_no_collision(curr, hlock, chain))
-			return 0;
-
-		if (very_verbose(class)) {
-			printk("\nhash chain already cached, key: "
-					"%016Lx tail class: [%px] %s\n",
-					(unsigned long long)chain_key,
-					class->key, class->name);
-		}
-
-		return 0;
-	}
-
-	if (very_verbose(class)) {
-		printk("\nnew hash chain, key: %016Lx tail class: [%px] %s\n",
-			(unsigned long long)chain_key, class->key, class->name);
-	}
-
-	if (!graph_lock())
-		return 0;
-
-	/*
-	 * We have to walk the chain again locked - to avoid duplicates:
-	 */
-	chain = lookup_chain_cache(chain_key);
-	if (chain) {
-		graph_unlock();
-		goto cache_hit;
-	}
-
-	if (!add_chain_cache(curr, hlock, chain_key))
-		return 0;
-
-	return 1;
-}
-
-static int validate_chain(struct task_struct *curr,
-			  struct held_lock *hlock,
-			  int chain_head, u64 chain_key)
-{
-	/*
-	 * Trylock needs to maintain the stack of held locks, but it
-	 * does not add new dependencies, because trylock can be done
-	 * in any order.
-	 *
-	 * We look up the chain_key and do the O(N^2) check and update of
-	 * the dependencies only if this is a new dependency chain.
-	 * (If lookup_chain_cache_add() return with 1 it acquires
-	 * graph_lock for us)
-	 */
-	if (!hlock->trylock && hlock->check &&
-	    lookup_chain_cache_add(curr, hlock, chain_key)) {
-		/*
-		 * Check whether last held lock:
-		 *
-		 * - is irq-safe, if this lock is irq-unsafe
-		 * - is softirq-safe, if this lock is hardirq-unsafe
-		 *
-		 * And check whether the new lock's dependency graph
-		 * could lead back to the previous lock:
-		 *
-		 * - within the current held-lock stack
-		 * - across our accumulated lock dependency records
-		 *
-		 * any of these scenarios could lead to a deadlock.
-		 */
-		/*
-		 * The simple case: does the current hold the same lock
-		 * already?
-		 */
-		int ret = check_deadlock(curr, hlock);
-
-		if (!ret)
-			return 0;
-		/*
-		 * Mark recursive read, as we jump over it when
-		 * building dependencies (just like we jump over
-		 * trylock entries):
-		 */
-		if (ret == 2)
-			hlock->read = 2;
-		/*
-		 * Add dependency only if this lock is not the head
-		 * of the chain, and if it's not a secondary read-lock:
-		 */
-		if (!chain_head && ret != 2) {
-			if (!check_prevs_add(curr, hlock))
-				return 0;
-		}
-
-		graph_unlock();
-	} else {
-		/* after lookup_chain_cache_add(): */
-		if (unlikely(!debug_locks))
-			return 0;
-	}
-
-	return 1;
-}
-#else
-static inline int validate_chain(struct task_struct *curr,
-				 struct held_lock *hlock,
-				 int chain_head, u64 chain_key)
-{
-	return 1;
-}
-
-static void init_chain_block_buckets(void)	{ }
-#endif /* CONFIG_PROVE_LOCKING */
-
-/*
- * We are building curr_chain_key incrementally, so double-check
- * it from scratch, to make sure that it's done correctly:
- */
-static void check_chain_key(struct task_struct *curr)
-{
-#ifdef CONFIG_DEBUG_LOCKDEP
-	struct held_lock *hlock, *prev_hlock = NULL;
-	unsigned int i;
-	u64 chain_key = INITIAL_CHAIN_KEY;
-
-	for (i = 0; i < curr->lockdep_depth; i++) {
-		hlock = curr->held_locks + i;
-		if (chain_key != hlock->prev_chain_key) {
-			debug_locks_off();
-			/*
-			 * We got mighty confused, our chain keys don't match
-			 * with what we expect, someone trample on our task state?
-			 */
-			WARN(1, "hm#1, depth: %u [%u], %016Lx != %016Lx\n",
-				curr->lockdep_depth, i,
-				(unsigned long long)chain_key,
-				(unsigned long long)hlock->prev_chain_key);
-			return;
-		}
-
-		/*
-		 * hlock->class_idx can't go beyond MAX_LOCKDEP_KEYS, but is
-		 * it registered lock class index?
-		 */
-		if (DEBUG_LOCKS_WARN_ON(!test_bit(hlock->class_idx, lock_classes_in_use)))
-			return;
-
-		if (prev_hlock && (prev_hlock->irq_context !=
-							hlock->irq_context))
-			chain_key = INITIAL_CHAIN_KEY;
-		chain_key = iterate_chain_key(chain_key, hlock->class_idx);
-		prev_hlock = hlock;
-	}
-	if (chain_key != curr->curr_chain_key) {
-		debug_locks_off();
-		/*
-		 * More smoking hash instead of calculating it, damn see these
-		 * numbers float.. I bet that a pink elephant stepped on my memory.
-		 */
-		WARN(1, "hm#2, depth: %u [%u], %016Lx != %016Lx\n",
-			curr->lockdep_depth, i,
-			(unsigned long long)chain_key,
-			(unsigned long long)curr->curr_chain_key);
-	}
-#endif
-}
-
-#ifdef CONFIG_PROVE_LOCKING
-static int mark_lock(struct task_struct *curr, struct held_lock *this,
-		     enum lock_usage_bit new_bit);
-
-static void print_usage_bug_scenario(struct held_lock *lock)
-{
-	struct lock_class *class = hlock_class(lock);
-
-	printk(" Possible unsafe locking scenario:\n\n");
-	printk("       CPU0\n");
-	printk("       ----\n");
-	printk("  lock(");
-	__print_lock_name(class);
-	printk(KERN_CONT ");\n");
-	printk("  <Interrupt>\n");
-	printk("    lock(");
-	__print_lock_name(class);
-	printk(KERN_CONT ");\n");
-	printk("\n *** DEADLOCK ***\n\n");
-}
-
-static void
-print_usage_bug(struct task_struct *curr, struct held_lock *this,
-		enum lock_usage_bit prev_bit, enum lock_usage_bit new_bit)
-{
-	if (!debug_locks_off_graph_unlock() || debug_locks_silent)
-		return;
-
-	pr_warn("\n");
-	pr_warn("================================\n");
-	pr_warn("WARNING: inconsistent lock state\n");
-	print_kernel_ident();
-	pr_warn("--------------------------------\n");
-
-	pr_warn("inconsistent {%s} -> {%s} usage.\n",
-		usage_str[prev_bit], usage_str[new_bit]);
-
-	pr_warn("%s/%d [HC%u[%lu]:SC%u[%lu]:HE%u:SE%u] takes:\n",
-		curr->comm, task_pid_nr(curr),
-		trace_hardirq_context(curr), hardirq_count() >> HARDIRQ_SHIFT,
-		trace_softirq_context(curr), softirq_count() >> SOFTIRQ_SHIFT,
-		trace_hardirqs_enabled(curr),
-		trace_softirqs_enabled(curr));
-	print_lock(this);
-
-	pr_warn("{%s} state was registered at:\n", usage_str[prev_bit]);
-	print_lock_trace(hlock_class(this)->usage_traces[prev_bit], 1);
-
-	print_irqtrace_events(curr);
-	pr_warn("\nother info that might help us debug this:\n");
-	print_usage_bug_scenario(this);
-
-	lockdep_print_held_locks(curr);
-
-	pr_warn("\nstack backtrace:\n");
-	dump_stack();
-}
-
-/*
- * Print out an error if an invalid bit is set:
- */
-static inline int
-valid_state(struct task_struct *curr, struct held_lock *this,
-	    enum lock_usage_bit new_bit, enum lock_usage_bit bad_bit)
-{
-	if (unlikely(hlock_class(this)->usage_mask & (1 << bad_bit))) {
-		print_usage_bug(curr, this, bad_bit, new_bit);
-		return 0;
-	}
-	return 1;
-}
-
-
-/*
- * print irq inversion bug:
- */
-static void
-print_irq_inversion_bug(struct task_struct *curr,
-			struct lock_list *root, struct lock_list *other,
-			struct held_lock *this, int forwards,
-			const char *irqclass)
-{
-	struct lock_list *entry = other;
-	struct lock_list *middle = NULL;
-	int depth;
-
-	if (!debug_locks_off_graph_unlock() || debug_locks_silent)
-		return;
-
-	pr_warn("\n");
-	pr_warn("========================================================\n");
-	pr_warn("WARNING: possible irq lock inversion dependency detected\n");
-	print_kernel_ident();
-	pr_warn("--------------------------------------------------------\n");
-	pr_warn("%s/%d just changed the state of lock:\n",
-		curr->comm, task_pid_nr(curr));
-	print_lock(this);
-	if (forwards)
-		pr_warn("but this lock took another, %s-unsafe lock in the past:\n", irqclass);
-	else
-		pr_warn("but this lock was taken by another, %s-safe lock in the past:\n", irqclass);
-	print_lock_name(other->class);
-	pr_warn("\n\nand interrupts could create inverse lock ordering between them.\n\n");
-
-	pr_warn("\nother info that might help us debug this:\n");
-
-	/* Find a middle lock (if one exists) */
-	depth = get_lock_depth(other);
-	do {
-		if (depth == 0 && (entry != root)) {
-			pr_warn("lockdep:%s bad path found in chain graph\n", __func__);
-			break;
-		}
-		middle = entry;
-		entry = get_lock_parent(entry);
-		depth--;
-	} while (entry && entry != root && (depth >= 0));
-	if (forwards)
-		print_irq_lock_scenario(root, other,
-			middle ? middle->class : root->class, other->class);
-	else
-		print_irq_lock_scenario(other, root,
-			middle ? middle->class : other->class, root->class);
-
-	lockdep_print_held_locks(curr);
-
-	pr_warn("\nthe shortest dependencies between 2nd lock and 1st lock:\n");
-	root->trace = save_trace();
-	if (!root->trace)
-		return;
-	print_shortest_lock_dependencies(other, root);
-
-	pr_warn("\nstack backtrace:\n");
-	dump_stack();
-}
-
-/*
- * Prove that in the forwards-direction subgraph starting at <this>
- * there is no lock matching <mask>:
- */
-static int
-check_usage_forwards(struct task_struct *curr, struct held_lock *this,
-		     enum lock_usage_bit bit, const char *irqclass)
-{
-	int ret;
-	struct lock_list root;
-	struct lock_list *uninitialized_var(target_entry);
-
-	root.parent = NULL;
-	root.class = hlock_class(this);
-	ret = find_usage_forwards(&root, lock_flag(bit), &target_entry);
-	if (ret < 0) {
-		print_bfs_bug(ret);
-		return 0;
-	}
-	if (ret == 1)
-		return ret;
-
-	print_irq_inversion_bug(curr, &root, target_entry,
-				this, 1, irqclass);
-	return 0;
-}
-
-/*
- * Prove that in the backwards-direction subgraph starting at <this>
- * there is no lock matching <mask>:
- */
-static int
-check_usage_backwards(struct task_struct *curr, struct held_lock *this,
-		      enum lock_usage_bit bit, const char *irqclass)
-{
-	int ret;
-	struct lock_list root;
-	struct lock_list *uninitialized_var(target_entry);
-
-	root.parent = NULL;
-	root.class = hlock_class(this);
-	ret = find_usage_backwards(&root, lock_flag(bit), &target_entry);
-	if (ret < 0) {
-		print_bfs_bug(ret);
-		return 0;
-	}
-	if (ret == 1)
-		return ret;
-
-	print_irq_inversion_bug(curr, &root, target_entry,
-				this, 0, irqclass);
-	return 0;
-}
-
-void print_irqtrace_events(struct task_struct *curr)
-{
-	printk("irq event stamp: %u\n", curr->irq_events);
-	printk("hardirqs last  enabled at (%u): [<%px>] %pS\n",
-		curr->hardirq_enable_event, (void *)curr->hardirq_enable_ip,
-		(void *)curr->hardirq_enable_ip);
-	printk("hardirqs last disabled at (%u): [<%px>] %pS\n",
-		curr->hardirq_disable_event, (void *)curr->hardirq_disable_ip,
-		(void *)curr->hardirq_disable_ip);
-	printk("softirqs last  enabled at (%u): [<%px>] %pS\n",
-		curr->softirq_enable_event, (void *)curr->softirq_enable_ip,
-		(void *)curr->softirq_enable_ip);
-	printk("softirqs last disabled at (%u): [<%px>] %pS\n",
-		curr->softirq_disable_event, (void *)curr->softirq_disable_ip,
-		(void *)curr->softirq_disable_ip);
-}
-
-static int HARDIRQ_verbose(struct lock_class *class)
-{
-#if HARDIRQ_VERBOSE
-	return class_filter(class);
-#endif
-	return 0;
-}
-
-static int SOFTIRQ_verbose(struct lock_class *class)
-{
-#if SOFTIRQ_VERBOSE
-	return class_filter(class);
-#endif
-	return 0;
-}
-
-#define STRICT_READ_CHECKS	1
-
-static int (*state_verbose_f[])(struct lock_class *class) = {
-#define LOCKDEP_STATE(__STATE) \
-	__STATE##_verbose,
-#include "lockdep_states.h"
-#undef LOCKDEP_STATE
-};
-
-static inline int state_verbose(enum lock_usage_bit bit,
-				struct lock_class *class)
-{
-	return state_verbose_f[bit >> LOCK_USAGE_DIR_MASK](class);
-}
-
-typedef int (*check_usage_f)(struct task_struct *, struct held_lock *,
-			     enum lock_usage_bit bit, const char *name);
-
-static int
-mark_lock_irq(struct task_struct *curr, struct held_lock *this,
-		enum lock_usage_bit new_bit)
-{
-	int excl_bit = exclusive_bit(new_bit);
-	int read = new_bit & LOCK_USAGE_READ_MASK;
-	int dir = new_bit & LOCK_USAGE_DIR_MASK;
-
-	/*
-	 * mark USED_IN has to look forwards -- to ensure no dependency
-	 * has ENABLED state, which would allow recursion deadlocks.
-	 *
-	 * mark ENABLED has to look backwards -- to ensure no dependee
-	 * has USED_IN state, which, again, would allow  recursion deadlocks.
-	 */
-	check_usage_f usage = dir ?
-		check_usage_backwards : check_usage_forwards;
-
-	/*
-	 * Validate that this particular lock does not have conflicting
-	 * usage states.
-	 */
-	if (!valid_state(curr, this, new_bit, excl_bit))
-		return 0;
-
-	/*
-	 * Validate that the lock dependencies don't have conflicting usage
-	 * states.
-	 */
-	if ((!read || STRICT_READ_CHECKS) &&
-			!usage(curr, this, excl_bit, state_name(new_bit & ~LOCK_USAGE_READ_MASK)))
-		return 0;
-
-	/*
-	 * Check for read in write conflicts
-	 */
-	if (!read) {
-		if (!valid_state(curr, this, new_bit, excl_bit + LOCK_USAGE_READ_MASK))
-			return 0;
-
-		if (STRICT_READ_CHECKS &&
-			!usage(curr, this, excl_bit + LOCK_USAGE_READ_MASK,
-				state_name(new_bit + LOCK_USAGE_READ_MASK)))
-			return 0;
-	}
-
-	if (state_verbose(new_bit, hlock_class(this)))
-		return 2;
-
-	return 1;
-}
-
-/*
- * Mark all held locks with a usage bit:
- */
-static int
-mark_held_locks(struct task_struct *curr, enum lock_usage_bit base_bit)
-{
-	struct held_lock *hlock;
-	int i;
-
-	for (i = 0; i < curr->lockdep_depth; i++) {
-		enum lock_usage_bit hlock_bit = base_bit;
-		hlock = curr->held_locks + i;
-
-		if (hlock->read)
-			hlock_bit += LOCK_USAGE_READ_MASK;
-
-		BUG_ON(hlock_bit >= LOCK_USAGE_STATES);
-
-		if (!hlock->check)
-			continue;
-
-		if (!mark_lock(curr, hlock, hlock_bit))
-			return 0;
-	}
-
-	return 1;
-}
-
-/*
- * Hardirqs will be enabled:
- */
-static void __trace_hardirqs_on_caller(unsigned long ip)
-{
-	struct task_struct *curr = current;
-
-	/* we'll do an OFF -> ON transition: */
-	curr->hardirqs_enabled = 1;
-
-	/*
-	 * We are going to turn hardirqs on, so set the
-	 * usage bit for all held locks:
-	 */
-	if (!mark_held_locks(curr, LOCK_ENABLED_HARDIRQ))
-		return;
-	/*
-	 * If we have softirqs enabled, then set the usage
-	 * bit for all held locks. (disabled hardirqs prevented
-	 * this bit from being set before)
-	 */
-	if (curr->softirqs_enabled)
-		if (!mark_held_locks(curr, LOCK_ENABLED_SOFTIRQ))
-			return;
-
-	curr->hardirq_enable_ip = ip;
-	curr->hardirq_enable_event = ++curr->irq_events;
-	debug_atomic_inc(hardirqs_on_events);
-}
-
-void lockdep_hardirqs_on(unsigned long ip)
-{
-	if (unlikely(!debug_locks || current->lockdep_recursion))
-		return;
-
-	if (unlikely(current->hardirqs_enabled)) {
-		/*
-		 * Neither irq nor preemption are disabled here
-		 * so this is racy by nature but losing one hit
-		 * in a stat is not a big deal.
-		 */
-		__debug_atomic_inc(redundant_hardirqs_on);
-		return;
-	}
-
-	/*
-	 * We're enabling irqs and according to our state above irqs weren't
-	 * already enabled, yet we find the hardware thinks they are in fact
-	 * enabled.. someone messed up their IRQ state tracing.
-	 */
-	if (DEBUG_LOCKS_WARN_ON(!irqs_disabled()))
-		return;
-
-	/*
-	 * See the fine text that goes along with this variable definition.
-	 */
-	if (DEBUG_LOCKS_WARN_ON(early_boot_irqs_disabled))
-		return;
-
-	/*
-	 * Can't allow enabling interrupts while in an interrupt handler,
-	 * that's general bad form and such. Recursion, limited stack etc..
-	 */
-	if (DEBUG_LOCKS_WARN_ON(current->hardirq_context))
-		return;
-
-	current->lockdep_recursion = 1;
-	__trace_hardirqs_on_caller(ip);
-	current->lockdep_recursion = 0;
-}
-NOKPROBE_SYMBOL(lockdep_hardirqs_on);
-
-/*
- * Hardirqs were disabled:
- */
-void lockdep_hardirqs_off(unsigned long ip)
-{
-	struct task_struct *curr = current;
-
-	if (unlikely(!debug_locks || current->lockdep_recursion))
-		return;
-
-	/*
-	 * So we're supposed to get called after you mask local IRQs, but for
-	 * some reason the hardware doesn't quite think you did a proper job.
-	 */
-	if (DEBUG_LOCKS_WARN_ON(!irqs_disabled()))
-		return;
-
-	if (curr->hardirqs_enabled) {
-		/*
-		 * We have done an ON -> OFF transition:
-		 */
-		curr->hardirqs_enabled = 0;
-		curr->hardirq_disable_ip = ip;
-		curr->hardirq_disable_event = ++curr->irq_events;
-		debug_atomic_inc(hardirqs_off_events);
-	} else
-		debug_atomic_inc(redundant_hardirqs_off);
-}
-NOKPROBE_SYMBOL(lockdep_hardirqs_off);
-
-/*
- * Softirqs will be enabled:
- */
-void trace_softirqs_on(unsigned long ip)
-{
-	struct task_struct *curr = current;
-
-	if (unlikely(!debug_locks || current->lockdep_recursion))
-		return;
-
-	/*
-	 * We fancy IRQs being disabled here, see softirq.c, avoids
-	 * funny state and nesting things.
-	 */
-	if (DEBUG_LOCKS_WARN_ON(!irqs_disabled()))
-		return;
-
-	if (curr->softirqs_enabled) {
-		debug_atomic_inc(redundant_softirqs_on);
-		return;
-	}
-
-	current->lockdep_recursion = 1;
-	/*
-	 * We'll do an OFF -> ON transition:
-	 */
-	curr->softirqs_enabled = 1;
-	curr->softirq_enable_ip = ip;
-	curr->softirq_enable_event = ++curr->irq_events;
-	debug_atomic_inc(softirqs_on_events);
-	/*
-	 * We are going to turn softirqs on, so set the
-	 * usage bit for all held locks, if hardirqs are
-	 * enabled too:
-	 */
-	if (curr->hardirqs_enabled)
-		mark_held_locks(curr, LOCK_ENABLED_SOFTIRQ);
-	current->lockdep_recursion = 0;
-}
-
-/*
- * Softirqs were disabled:
- */
-void trace_softirqs_off(unsigned long ip)
-{
-	struct task_struct *curr = current;
-
-	if (unlikely(!debug_locks || current->lockdep_recursion))
-		return;
-
-	/*
-	 * We fancy IRQs being disabled here, see softirq.c
-	 */
-	if (DEBUG_LOCKS_WARN_ON(!irqs_disabled()))
-		return;
-
-	if (curr->softirqs_enabled) {
-		/*
-		 * We have done an ON -> OFF transition:
-		 */
-		curr->softirqs_enabled = 0;
-		curr->softirq_disable_ip = ip;
-		curr->softirq_disable_event = ++curr->irq_events;
-		debug_atomic_inc(softirqs_off_events);
-		/*
-		 * Whoops, we wanted softirqs off, so why aren't they?
-		 */
-		DEBUG_LOCKS_WARN_ON(!softirq_count());
-	} else
-		debug_atomic_inc(redundant_softirqs_off);
-}
-
-static int
-mark_usage(struct task_struct *curr, struct held_lock *hlock, int check)
-{
-	if (!check)
-		goto lock_used;
-
-	/*
-	 * If non-trylock use in a hardirq or softirq context, then
-	 * mark the lock as used in these contexts:
-	 */
-	if (!hlock->trylock) {
-		if (hlock->read) {
-			if (curr->hardirq_context)
-				if (!mark_lock(curr, hlock,
-						LOCK_USED_IN_HARDIRQ_READ))
-					return 0;
-			if (curr->softirq_context)
-				if (!mark_lock(curr, hlock,
-						LOCK_USED_IN_SOFTIRQ_READ))
-					return 0;
-		} else {
-			if (curr->hardirq_context)
-				if (!mark_lock(curr, hlock, LOCK_USED_IN_HARDIRQ))
-					return 0;
-			if (curr->softirq_context)
-				if (!mark_lock(curr, hlock, LOCK_USED_IN_SOFTIRQ))
-					return 0;
-		}
-	}
-	if (!hlock->hardirqs_off) {
-		if (hlock->read) {
-			if (!mark_lock(curr, hlock,
-					LOCK_ENABLED_HARDIRQ_READ))
-				return 0;
-			if (curr->softirqs_enabled)
-				if (!mark_lock(curr, hlock,
-						LOCK_ENABLED_SOFTIRQ_READ))
-					return 0;
-		} else {
-			if (!mark_lock(curr, hlock,
-					LOCK_ENABLED_HARDIRQ))
-				return 0;
-			if (curr->softirqs_enabled)
-				if (!mark_lock(curr, hlock,
-						LOCK_ENABLED_SOFTIRQ))
-					return 0;
-		}
+	hlist_for_each_entry_rcu(k, hash_head, hash_entry) {
+		if (WARN_ON_ONCE(k == key))
+			goto out_unlock;
 	}
-
-lock_used:
-	/* mark it as used: */
-	if (!mark_lock(curr, hlock, LOCK_USED))
-		return 0;
-
-	return 1;
+	hlist_add_head_rcu(&key->hash_entry, hash_head);
+out_unlock:
+	graph_unlock();
+restore_irqs:
+	raw_local_irq_restore(flags);
 }
+EXPORT_SYMBOL_GPL(lockdep_register_key);
 
-static inline unsigned int task_irq_context(struct task_struct *task)
+/* Check whether a key has been registered as a dynamic key. */
+static bool is_dynamic_key(const struct lock_class_key *key)
 {
-	return LOCK_CHAIN_HARDIRQ_CONTEXT * !!task->hardirq_context +
-	       LOCK_CHAIN_SOFTIRQ_CONTEXT * !!task->softirq_context;
-}
+	struct hlist_head *hash_head;
+	struct lock_class_key *k;
+	bool found = false;
 
-static int separate_irq_context(struct task_struct *curr,
-		struct held_lock *hlock)
-{
-	unsigned int depth = curr->lockdep_depth;
+	if (WARN_ON_ONCE(static_obj(key)))
+		return false;
 
 	/*
-	 * Keep track of points where we cross into an interrupt context:
+	 * If lock debugging is disabled lock_keys_hash[] may contain
+	 * pointers to memory that has already been freed. Avoid triggering
+	 * a use-after-free in that case by returning early.
 	 */
-	if (depth) {
-		struct held_lock *prev_hlock;
+	if (!debug_locks)
+		return true;
 
-		prev_hlock = curr->held_locks + depth-1;
-		/*
-		 * If we cross into another context, reset the
-		 * hash key (this also prevents the checking and the
-		 * adding of the dependency to 'prev'):
-		 */
-		if (prev_hlock->irq_context != hlock->irq_context)
-			return 1;
+	hash_head = keyhashentry(key);
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(k, hash_head, hash_entry) {
+		if (k == key) {
+			found = true;
+			break;
+		}
 	}
-	return 0;
+	rcu_read_unlock();
+
+	return found;
 }
 
 /*
- * Mark a lock with a usage bit, and validate the state transition:
+ * Register a lock's class in the hash-table, if the class is not present
+ * yet. Otherwise we look it up. We cache the result in the lock object
+ * itself, so actual lookup of the hash should be once per lock object.
  */
-static int mark_lock(struct task_struct *curr, struct held_lock *this,
-			     enum lock_usage_bit new_bit)
+static struct lock_class *
+register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
 {
-	unsigned int new_mask = 1 << new_bit, ret = 1;
+	struct lockdep_subclass_key *key;
+	struct hlist_head *hash_head;
+	struct lock_class *class;
 
-	if (new_bit >= LOCK_USAGE_STATES) {
-		DEBUG_LOCKS_WARN_ON(1);
-		return 0;
+	DEBUG_LOCKS_WARN_ON(!irqs_disabled());
+
+	class = look_up_lock_class(lock, subclass);
+	if (likely(class))
+		goto out_set_class_cache;
+
+	if (!lock->key) {
+		if (!assign_lock_key(lock))
+			return NULL;
+	} else if (!static_obj(lock->key) && !is_dynamic_key(lock->key)) {
+		return NULL;
 	}
 
-	/*
-	 * If already set then do not dirty the cacheline,
-	 * nor do any checks:
-	 */
-	if (likely(hlock_class(this)->usage_mask & new_mask))
-		return 1;
+	key = lock->key->subkeys + subclass;
+	hash_head = classhashentry(key);
 
-	if (!graph_lock())
-		return 0;
+	if (!graph_lock()) {
+		return NULL;
+	}
 	/*
-	 * Make sure we didn't race:
+	 * We have to do the hash-walk again, to avoid races
+	 * with another CPU:
 	 */
-	if (unlikely(hlock_class(this)->usage_mask & new_mask)) {
-		graph_unlock();
-		return 1;
+	hlist_for_each_entry_rcu(class, hash_head, hash_entry) {
+		if (class->key == key)
+			goto out_unlock_set;
 	}
 
-	hlock_class(this)->usage_mask |= new_mask;
+	init_data_structures_once();
 
-	if (!(hlock_class(this)->usage_traces[new_bit] = save_trace()))
-		return 0;
+	/* Allocate a new lock class and add it to the hash. */
+	class = list_first_entry_or_null(&free_lock_classes, typeof(*class),
+					 lock_entry);
+	if (!class) {
+		if (!debug_locks_off_graph_unlock()) {
+			return NULL;
+		}
 
-	switch (new_bit) {
-	case LOCK_USED:
-		debug_atomic_dec(nr_unused_locks);
-		break;
-	default:
-		ret = mark_lock_irq(curr, this, new_bit);
-		if (!ret)
-			return 0;
+		print_lockdep_off("BUG: MAX_LOCKDEP_KEYS too low!");
+		dump_stack();
+		return NULL;
 	}
-
-	graph_unlock();
-
+	nr_lock_classes++;
+	__set_bit(class - lock_classes, lock_classes_in_use);
+	debug_atomic_inc(nr_unused_locks);
+	class->key = key;
+	class->name = lock->name;
+	class->subclass = subclass;
+	WARN_ON_ONCE(!list_empty(&class->locks_before));
+	WARN_ON_ONCE(!list_empty(&class->locks_after));
+	class->name_version = count_matching_names(class);
+	/*
+	 * We use RCU's safe list-add method to make
+	 * parallel walking of the hash-list safe:
+	 */
+	hlist_add_head_rcu(&class->hash_entry, hash_head);
 	/*
-	 * We must printk outside of the graph_lock:
+	 * Remove the class from the free list and add it to the global list
+	 * of classes.
 	 */
-	if (ret == 2) {
-		printk("\nmarked lock as {%s}:\n", usage_str[new_bit]);
-		print_lock(this);
-		print_irqtrace_events(curr);
+	list_move_tail(&class->lock_entry, &all_lock_classes);
+
+	if (verbose(class)) {
+		graph_unlock();
+
+		printk("\nnew class %px: %s", class->key, class->name);
+		if (class->name_version > 1)
+			printk(KERN_CONT "#%d", class->name_version);
+		printk(KERN_CONT "\n");
 		dump_stack();
+
+		if (!graph_lock()) {
+			return NULL;
+		}
 	}
+out_unlock_set:
+	graph_unlock();
 
-	return ret;
-}
+out_set_class_cache:
+	if (!subclass || force)
+		lock->class_cache[0] = class;
+	else if (subclass < NR_LOCKDEP_CACHING_CLASSES)
+		lock->class_cache[subclass] = class;
 
-#else /* CONFIG_PROVE_LOCKING */
+	/*
+	 * Hash collision, did we smoke some? We found a class with a matching
+	 * hash but the subclass -- which is hashed in -- didn't match.
+	 */
+	if (DEBUG_LOCKS_WARN_ON(class->subclass != subclass))
+		return NULL;
 
-static inline int
-mark_usage(struct task_struct *curr, struct held_lock *hlock, int check)
-{
-	return 1;
+	return class;
 }
 
-static inline unsigned int task_irq_context(struct task_struct *task)
+/*
+ * We are building curr_chain_key incrementally, so double-check
+ * it from scratch, to make sure that it's done correctly:
+ */
+static void check_chain_key(struct task_struct *curr)
 {
-	return 0;
-}
+#ifdef CONFIG_DEBUG_LOCKDEP
+	struct held_lock *hlock, *prev_hlock = NULL;
+	unsigned int i;
+	u64 chain_key = INITIAL_CHAIN_KEY;
 
-static inline int separate_irq_context(struct task_struct *curr,
-		struct held_lock *hlock)
-{
-	return 0;
-}
+	for (i = 0; i < curr->lockdep_depth; i++) {
+		hlock = curr->held_locks + i;
+		if (chain_key != hlock->prev_chain_key) {
+			debug_locks_off();
+			/*
+			 * We got mighty confused, our chain keys don't match
+			 * with what we expect, someone trample on our task state?
+			 */
+			WARN(1, "hm#1, depth: %u [%u], %016Lx != %016Lx\n",
+				curr->lockdep_depth, i,
+				(unsigned long long)chain_key,
+				(unsigned long long)hlock->prev_chain_key);
+			return;
+		}
 
-#endif /* CONFIG_PROVE_LOCKING */
+		/*
+		 * hlock->class_idx can't go beyond MAX_LOCKDEP_KEYS, but is
+		 * it registered lock class index?
+		 */
+		if (DEBUG_LOCKS_WARN_ON(!test_bit(hlock->class_idx, lock_classes_in_use)))
+			return;
+
+		if (prev_hlock && (prev_hlock->irq_context !=
+							hlock->irq_context))
+			chain_key = INITIAL_CHAIN_KEY;
+		chain_key = iterate_chain_key(chain_key, hlock->class_idx);
+		prev_hlock = hlock;
+	}
+	if (chain_key != curr->curr_chain_key) {
+		debug_locks_off();
+		/*
+		 * More smoking hash instead of calculating it, damn see these
+		 * numbers float.. I bet that a pink elephant stepped on my memory.
+		 */
+		WARN(1, "hm#2, depth: %u [%u], %016Lx != %016Lx\n",
+			curr->lockdep_depth, i,
+			(unsigned long long)chain_key,
+			(unsigned long long)curr->curr_chain_key);
+	}
+#endif
+}
 
 /*
  * Initialize a lock instance's lock-class mapping info:
@@ -4624,45 +1911,6 @@ static void __lock_unpin_lock(struct lockdep_map *lock, struct pin_cookie cookie
 	WARN(1, "unpinning an unheld lock\n");
 }
 
-/*
- * Check whether we follow the irq-flags state precisely:
- */
-static void check_flags(unsigned long flags)
-{
-#if defined(CONFIG_PROVE_LOCKING) && defined(CONFIG_DEBUG_LOCKDEP)
-	if (!debug_locks)
-		return;
-
-	if (irqs_disabled_flags(flags)) {
-		if (DEBUG_LOCKS_WARN_ON(current->hardirqs_enabled)) {
-			printk("possible reason: unannotated irqs-off.\n");
-		}
-	} else {
-		if (DEBUG_LOCKS_WARN_ON(!current->hardirqs_enabled)) {
-			printk("possible reason: unannotated irqs-on.\n");
-		}
-	}
-
-	/*
-	 * We dont accurately track softirq state in e.g.
-	 * hardirq contexts (such as on 4KSTACKS), so only
-	 * check if not in hardirq contexts:
-	 */
-	if (!hardirq_count()) {
-		if (softirq_count()) {
-			/* like the above, but with softirqs */
-			DEBUG_LOCKS_WARN_ON(current->softirqs_enabled);
-		} else {
-			/* lick the above, does it taste good? */
-			DEBUG_LOCKS_WARN_ON(!current->softirqs_enabled);
-		}
-	}
-
-	if (!debug_locks)
-		print_irqtrace_events(current);
-#endif
-}
-
 void lock_set_class(struct lockdep_map *lock, const char *name,
 		    struct lock_class_key *key, unsigned int subclass,
 		    unsigned long ip)
@@ -4998,60 +2246,6 @@ void lockdep_reset(void)
 	raw_local_irq_restore(flags);
 }
 
-#ifdef CONFIG_PROVE_LOCKING
-/* Remove a class from a lock chain. Must be called with the graph lock held. */
-static void remove_class_from_lock_chain(struct pending_free *pf,
-					 struct lock_chain *chain,
-					 struct lock_class *class)
-{
-	int i;
-
-	for (i = chain->base; i < chain->base + chain->depth; i++) {
-		if (chain_hlocks[i] != class - lock_classes)
-			continue;
-		/*
-		 * Each lock class occurs at most once in a lock chain so once
-		 * we found a match we can break out of this loop.
-		 */
-		goto free_lock_chain;
-	}
-	/* Since the chain has not been modified, return. */
-	return;
-
-free_lock_chain:
-	free_chain_hlocks(chain->base, chain->depth);
-	/* Overwrite the chain key for concurrent RCU readers. */
-	WRITE_ONCE(chain->chain_key, INITIAL_CHAIN_KEY);
-	dec_chains(chain->irq_context);
-
-	/*
-	 * Note: calling hlist_del_rcu() from inside a
-	 * hlist_for_each_entry_rcu() loop is safe.
-	 */
-	hlist_del_rcu(&chain->entry);
-	__set_bit(chain - lock_chains, pf->lock_chains_being_freed);
-	nr_zapped_lock_chains++;
-}
-#endif
-
-/* Must be called with the graph lock held. */
-static void remove_class_from_lock_chains(struct pending_free *pf,
-					  struct lock_class *class)
-{
-#ifdef CONFIG_PROVE_LOCKING
-	struct lock_chain *chain;
-	struct hlist_head *head;
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(chainhash_table); i++) {
-		head = chainhash_table + i;
-		hlist_for_each_entry_rcu(chain, head, entry) {
-			remove_class_from_lock_chain(pf, chain, class);
-		}
-	}
-#endif
-}
-
 /*
  * Remove all references to a lock class. The caller must hold the graph lock.
  */
diff --git a/kernel/locking/lockdep_prove.c b/kernel/locking/lockdep_prove.c
new file mode 100644
index 000000000000..e3709489f6ee
--- /dev/null
+++ b/kernel/locking/lockdep_prove.c
@@ -0,0 +1,2820 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * This file is included in lockdep.c when CONFIG_PROVE_LOCKING is on.
+ * It contains all the functions and data structures that are needed to
+ * implement the CONFIG_PROVE_LOCKING functionality.
+ */
+
+/**
+ * struct lock_trace - single stack backtrace
+ * @hash_entry:	Entry in a stack_trace_hash[] list.
+ * @hash:	jhash() of @entries.
+ * @nr_entries:	Number of entries in @entries.
+ * @entries:	Actual stack backtrace.
+ */
+struct lock_trace {
+	struct hlist_node	hash_entry;
+	u32			hash;
+	u32			nr_entries;
+	unsigned long		entries[0] __aligned(sizeof(unsigned long));
+};
+#define LOCK_TRACE_SIZE_IN_LONGS				\
+	(sizeof(struct lock_trace) / sizeof(unsigned long))
+/*
+ * Stack-trace: sequence of lock_trace structures. Protected by the graph_lock.
+ */
+static unsigned long stack_trace[MAX_STACK_TRACE_ENTRIES];
+static struct hlist_head stack_trace_hash[STACK_TRACE_HASH_SIZE];
+
+struct lock_chain lock_chains[MAX_LOCKDEP_CHAINS];
+static DECLARE_BITMAP(lock_chains_in_use, MAX_LOCKDEP_CHAINS);
+static u16 chain_hlocks[MAX_LOCKDEP_CHAIN_HLOCKS];
+unsigned long nr_zapped_lock_chains;
+unsigned int nr_free_chain_hlocks;	/* Free chain_hlocks in buckets */
+unsigned int nr_lost_chain_hlocks;	/* Lost chain_hlocks */
+unsigned int nr_large_chain_blocks;	/* size > MAX_CHAIN_BUCKETS */
+
+/*
+ * Forward references
+ */
+static void init_data_structures_once(void);
+static int mark_lock(struct task_struct *curr, struct held_lock *this,
+		     enum lock_usage_bit new_bit);
+
+/*
+ * Locking printouts:
+ */
+
+#define __USAGE(__STATE)						\
+	[LOCK_USED_IN_##__STATE] = "IN-"__stringify(__STATE)"-W",	\
+	[LOCK_ENABLED_##__STATE] = __stringify(__STATE)"-ON-W",		\
+	[LOCK_USED_IN_##__STATE##_READ] = "IN-"__stringify(__STATE)"-R",\
+	[LOCK_ENABLED_##__STATE##_READ] = __stringify(__STATE)"-ON-R",
+
+static const char *usage_str[] =
+{
+#define LOCKDEP_STATE(__STATE) __USAGE(__STATE)
+#include "lockdep_states.h"
+#undef LOCKDEP_STATE
+	[LOCK_USED] = "INITIAL USE",
+};
+
+static bool traces_identical(struct lock_trace *t1, struct lock_trace *t2)
+{
+	return t1->hash == t2->hash && t1->nr_entries == t2->nr_entries &&
+		memcmp(t1->entries, t2->entries,
+		       t1->nr_entries * sizeof(t1->entries[0])) == 0;
+}
+
+static struct lock_trace *save_trace(void)
+{
+	struct lock_trace *trace, *t2;
+	struct hlist_head *hash_head;
+	u32 hash;
+	int max_entries;
+
+	BUILD_BUG_ON_NOT_POWER_OF_2(STACK_TRACE_HASH_SIZE);
+	BUILD_BUG_ON(LOCK_TRACE_SIZE_IN_LONGS >= MAX_STACK_TRACE_ENTRIES);
+
+	trace = (struct lock_trace *)(stack_trace + nr_stack_trace_entries);
+	max_entries = MAX_STACK_TRACE_ENTRIES - nr_stack_trace_entries -
+		LOCK_TRACE_SIZE_IN_LONGS;
+
+	if (max_entries <= 0) {
+		if (!debug_locks_off_graph_unlock())
+			return NULL;
+
+		print_lockdep_off("BUG: MAX_STACK_TRACE_ENTRIES too low!");
+		dump_stack();
+
+		return NULL;
+	}
+	trace->nr_entries = stack_trace_save(trace->entries, max_entries, 3);
+
+	hash = jhash(trace->entries, trace->nr_entries *
+		     sizeof(trace->entries[0]), 0);
+	trace->hash = hash;
+	hash_head = stack_trace_hash + (hash & (STACK_TRACE_HASH_SIZE - 1));
+	hlist_for_each_entry(t2, hash_head, hash_entry) {
+		if (traces_identical(trace, t2))
+			return t2;
+	}
+	nr_stack_trace_entries += LOCK_TRACE_SIZE_IN_LONGS + trace->nr_entries;
+	hlist_add_head(&trace->hash_entry, hash_head);
+
+	return trace;
+}
+
+/* Return the number of stack traces in the stack_trace[] array. */
+u64 lockdep_stack_trace_count(void)
+{
+	struct lock_trace *trace;
+	u64 c = 0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(stack_trace_hash); i++) {
+		hlist_for_each_entry(trace, &stack_trace_hash[i], hash_entry) {
+			c++;
+		}
+	}
+
+	return c;
+}
+
+/* Return the number of stack hash chains that have at least one stack trace. */
+u64 lockdep_stack_hash_count(void)
+{
+	u64 c = 0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(stack_trace_hash); i++)
+		if (!hlist_empty(&stack_trace_hash[i]))
+			c++;
+
+	return c;
+}
+
+/*
+ * Allocate a lockdep entry. (assumes the graph_lock held, returns
+ * with NULL on failure)
+ */
+static struct lock_list *alloc_list_entry(void)
+{
+	int idx = find_first_zero_bit(list_entries_in_use,
+				      ARRAY_SIZE(list_entries));
+
+	if (idx >= ARRAY_SIZE(list_entries)) {
+		if (!debug_locks_off_graph_unlock())
+			return NULL;
+
+		print_lockdep_off("BUG: MAX_LOCKDEP_ENTRIES too low!");
+		dump_stack();
+		return NULL;
+	}
+	nr_list_entries++;
+	__set_bit(idx, list_entries_in_use);
+	return list_entries + idx;
+}
+
+/*
+ * Add a new dependency to the head of the list:
+ */
+static int add_lock_to_list(struct lock_class *this,
+			    struct lock_class *links_to, struct list_head *head,
+			    unsigned long ip, int distance,
+			    const struct lock_trace *trace)
+{
+	struct lock_list *entry;
+	/*
+	 * Lock not present yet - get a new dependency struct and
+	 * add it to the list:
+	 */
+	entry = alloc_list_entry();
+	if (!entry)
+		return 0;
+
+	entry->class = this;
+	entry->links_to = links_to;
+	entry->distance = distance;
+	entry->trace = trace;
+	/*
+	 * Both allocation and removal are done under the graph lock; but
+	 * iteration is under RCU-sched; see look_up_lock_class() and
+	 * lockdep_free_key_range().
+	 */
+	list_add_tail_rcu(&entry->entry, head);
+
+	return 1;
+}
+
+/*
+ * For good efficiency of modular, we use power of 2
+ */
+#define MAX_CIRCULAR_QUEUE_SIZE		4096UL
+#define CQ_MASK				(MAX_CIRCULAR_QUEUE_SIZE-1)
+
+/*
+ * The circular_queue and helpers are used to implement graph
+ * breadth-first search (BFS) algorithm, by which we can determine
+ * whether there is a path from a lock to another. In deadlock checks,
+ * a path from the next lock to be acquired to a previous held lock
+ * indicates that adding the <prev> -> <next> lock dependency will
+ * produce a circle in the graph. Breadth-first search instead of
+ * depth-first search is used in order to find the shortest (circular)
+ * path.
+ */
+struct circular_queue {
+	struct lock_list *element[MAX_CIRCULAR_QUEUE_SIZE];
+	unsigned int  front, rear;
+};
+
+static struct circular_queue lock_cq;
+
+unsigned int max_bfs_queue_depth;
+
+static unsigned int lockdep_dependency_gen_id;
+
+static inline void __cq_init(struct circular_queue *cq)
+{
+	cq->front = cq->rear = 0;
+	lockdep_dependency_gen_id++;
+}
+
+static inline int __cq_empty(struct circular_queue *cq)
+{
+	return (cq->front == cq->rear);
+}
+
+static inline int __cq_full(struct circular_queue *cq)
+{
+	return ((cq->rear + 1) & CQ_MASK) == cq->front;
+}
+
+static inline int __cq_enqueue(struct circular_queue *cq, struct lock_list *elem)
+{
+	if (__cq_full(cq))
+		return -1;
+
+	cq->element[cq->rear] = elem;
+	cq->rear = (cq->rear + 1) & CQ_MASK;
+	return 0;
+}
+
+/*
+ * Dequeue an element from the circular_queue, return a lock_list if
+ * the queue is not empty, or NULL if otherwise.
+ */
+static inline struct lock_list * __cq_dequeue(struct circular_queue *cq)
+{
+	struct lock_list * lock;
+
+	if (__cq_empty(cq))
+		return NULL;
+
+	lock = cq->element[cq->front];
+	cq->front = (cq->front + 1) & CQ_MASK;
+
+	return lock;
+}
+
+static inline unsigned int  __cq_get_elem_count(struct circular_queue *cq)
+{
+	return (cq->rear - cq->front) & CQ_MASK;
+}
+
+static inline void mark_lock_accessed(struct lock_list *lock,
+					struct lock_list *parent)
+{
+	unsigned long nr;
+
+	nr = lock - list_entries;
+	WARN_ON(nr >= ARRAY_SIZE(list_entries)); /* Out-of-bounds, input fail */
+	lock->parent = parent;
+	lock->class->dep_gen_id = lockdep_dependency_gen_id;
+}
+
+static inline unsigned long lock_accessed(struct lock_list *lock)
+{
+	unsigned long nr;
+
+	nr = lock - list_entries;
+	WARN_ON(nr >= ARRAY_SIZE(list_entries)); /* Out-of-bounds, input fail */
+	return lock->class->dep_gen_id == lockdep_dependency_gen_id;
+}
+
+static inline struct lock_list *get_lock_parent(struct lock_list *child)
+{
+	return child->parent;
+}
+
+static inline int get_lock_depth(struct lock_list *child)
+{
+	int depth = 0;
+	struct lock_list *parent;
+
+	while ((parent = get_lock_parent(child))) {
+		child = parent;
+		depth++;
+	}
+	return depth;
+}
+
+/*
+ * Return the forward or backward dependency list.
+ *
+ * @lock:   the lock_list to get its class's dependency list
+ * @offset: the offset to struct lock_class to determine whether it is
+ *          locks_after or locks_before
+ */
+static inline struct list_head *get_dep_list(struct lock_list *lock, int offset)
+{
+	void *lock_class = lock->class;
+
+	return lock_class + offset;
+}
+
+/*
+ * Forward- or backward-dependency search, used for both circular dependency
+ * checking and hardirq-unsafe/softirq-unsafe checking.
+ */
+static int __bfs(struct lock_list *source_entry,
+		 void *data,
+		 int (*match)(struct lock_list *entry, void *data),
+		 struct lock_list **target_entry,
+		 int offset)
+{
+	struct lock_list *entry;
+	struct lock_list *lock;
+	struct list_head *head;
+	struct circular_queue *cq = &lock_cq;
+	int ret = 1;
+
+	if (match(source_entry, data)) {
+		*target_entry = source_entry;
+		ret = 0;
+		goto exit;
+	}
+
+	head = get_dep_list(source_entry, offset);
+	if (list_empty(head))
+		goto exit;
+
+	__cq_init(cq);
+	__cq_enqueue(cq, source_entry);
+
+	while ((lock = __cq_dequeue(cq))) {
+
+		if (!lock->class) {
+			ret = -2;
+			goto exit;
+		}
+
+		head = get_dep_list(lock, offset);
+
+		DEBUG_LOCKS_WARN_ON(!irqs_disabled());
+
+		list_for_each_entry_rcu(entry, head, entry) {
+			if (!lock_accessed(entry)) {
+				unsigned int cq_depth;
+				mark_lock_accessed(entry, lock);
+				if (match(entry, data)) {
+					*target_entry = entry;
+					ret = 0;
+					goto exit;
+				}
+
+				if (__cq_enqueue(cq, entry)) {
+					ret = -1;
+					goto exit;
+				}
+				cq_depth = __cq_get_elem_count(cq);
+				if (max_bfs_queue_depth < cq_depth)
+					max_bfs_queue_depth = cq_depth;
+			}
+		}
+	}
+exit:
+	return ret;
+}
+
+static inline int __bfs_forwards(struct lock_list *src_entry,
+			void *data,
+			int (*match)(struct lock_list *entry, void *data),
+			struct lock_list **target_entry)
+{
+	return __bfs(src_entry, data, match, target_entry,
+		     offsetof(struct lock_class, locks_after));
+
+}
+
+static inline int __bfs_backwards(struct lock_list *src_entry,
+			void *data,
+			int (*match)(struct lock_list *entry, void *data),
+			struct lock_list **target_entry)
+{
+	return __bfs(src_entry, data, match, target_entry,
+		     offsetof(struct lock_class, locks_before));
+
+}
+
+static void print_lock_trace(const struct lock_trace *trace,
+			     unsigned int spaces)
+{
+	stack_trace_print(trace->entries, trace->nr_entries, spaces);
+}
+
+/*
+ * Print a dependency chain entry (this is only done when a deadlock
+ * has been detected):
+ */
+static noinline void
+print_circular_bug_entry(struct lock_list *target, int depth)
+{
+	if (debug_locks_silent)
+		return;
+	printk("\n-> #%u", depth);
+	print_lock_name(target->class);
+	printk(KERN_CONT ":\n");
+	print_lock_trace(target->trace, 6);
+}
+
+static void
+print_circular_lock_scenario(struct held_lock *src,
+			     struct held_lock *tgt,
+			     struct lock_list *prt)
+{
+	struct lock_class *source = hlock_class(src);
+	struct lock_class *target = hlock_class(tgt);
+	struct lock_class *parent = prt->class;
+
+	/*
+	 * A direct locking problem where unsafe_class lock is taken
+	 * directly by safe_class lock, then all we need to show
+	 * is the deadlock scenario, as it is obvious that the
+	 * unsafe lock is taken under the safe lock.
+	 *
+	 * But if there is a chain instead, where the safe lock takes
+	 * an intermediate lock (middle_class) where this lock is
+	 * not the same as the safe lock, then the lock chain is
+	 * used to describe the problem. Otherwise we would need
+	 * to show a different CPU case for each link in the chain
+	 * from the safe_class lock to the unsafe_class lock.
+	 */
+	if (parent != source) {
+		printk("Chain exists of:\n  ");
+		__print_lock_name(source);
+		printk(KERN_CONT " --> ");
+		__print_lock_name(parent);
+		printk(KERN_CONT " --> ");
+		__print_lock_name(target);
+		printk(KERN_CONT "\n\n");
+	}
+
+	printk(" Possible unsafe locking scenario:\n\n");
+	printk("       CPU0                    CPU1\n");
+	printk("       ----                    ----\n");
+	printk("  lock(");
+	__print_lock_name(target);
+	printk(KERN_CONT ");\n");
+	printk("                               lock(");
+	__print_lock_name(parent);
+	printk(KERN_CONT ");\n");
+	printk("                               lock(");
+	__print_lock_name(target);
+	printk(KERN_CONT ");\n");
+	printk("  lock(");
+	__print_lock_name(source);
+	printk(KERN_CONT ");\n");
+	printk("\n *** DEADLOCK ***\n\n");
+}
+
+/*
+ * When a circular dependency is detected, print the
+ * header first:
+ */
+static noinline void
+print_circular_bug_header(struct lock_list *entry, unsigned int depth,
+			struct held_lock *check_src,
+			struct held_lock *check_tgt)
+{
+	struct task_struct *curr = current;
+
+	if (debug_locks_silent)
+		return;
+
+	pr_warn("\n");
+	pr_warn("======================================================\n");
+	pr_warn("WARNING: possible circular locking dependency detected\n");
+	print_kernel_ident();
+	pr_warn("------------------------------------------------------\n");
+	pr_warn("%s/%d is trying to acquire lock:\n",
+		curr->comm, task_pid_nr(curr));
+	print_lock(check_src);
+
+	pr_warn("\nbut task is already holding lock:\n");
+
+	print_lock(check_tgt);
+	pr_warn("\nwhich lock already depends on the new lock.\n\n");
+	pr_warn("\nthe existing dependency chain (in reverse order) is:\n");
+
+	print_circular_bug_entry(entry, depth);
+}
+
+static inline int class_equal(struct lock_list *entry, void *data)
+{
+	return entry->class == data;
+}
+
+static noinline void print_circular_bug(struct lock_list *this,
+					struct lock_list *target,
+					struct held_lock *check_src,
+					struct held_lock *check_tgt)
+{
+	struct task_struct *curr = current;
+	struct lock_list *parent;
+	struct lock_list *first_parent;
+	int depth;
+
+	if (!debug_locks_off_graph_unlock() || debug_locks_silent)
+		return;
+
+	this->trace = save_trace();
+	if (!this->trace)
+		return;
+
+	depth = get_lock_depth(target);
+
+	print_circular_bug_header(target, depth, check_src, check_tgt);
+
+	parent = get_lock_parent(target);
+	first_parent = parent;
+
+	while (parent) {
+		print_circular_bug_entry(parent, --depth);
+		parent = get_lock_parent(parent);
+	}
+
+	printk("\nother info that might help us debug this:\n\n");
+	print_circular_lock_scenario(check_src, check_tgt,
+				     first_parent);
+
+	lockdep_print_held_locks(curr);
+
+	printk("\nstack backtrace:\n");
+	dump_stack();
+}
+
+static noinline void print_bfs_bug(int ret)
+{
+	if (!debug_locks_off_graph_unlock())
+		return;
+
+	/*
+	 * Breadth-first-search failed, graph got corrupted?
+	 */
+	WARN(1, "lockdep bfs error:%d\n", ret);
+}
+
+static int noop_count(struct lock_list *entry, void *data)
+{
+	(*(unsigned long *)data)++;
+	return 0;
+}
+
+static unsigned long __lockdep_count_forward_deps(struct lock_list *this)
+{
+	unsigned long  count = 0;
+	struct lock_list *uninitialized_var(target_entry);
+
+	__bfs_forwards(this, (void *)&count, noop_count, &target_entry);
+
+	return count;
+}
+unsigned long lockdep_count_forward_deps(struct lock_class *class)
+{
+	unsigned long ret, flags;
+	struct lock_list this;
+
+	this.parent = NULL;
+	this.class = class;
+
+	raw_local_irq_save(flags);
+	arch_spin_lock(&lockdep_lock);
+	ret = __lockdep_count_forward_deps(&this);
+	arch_spin_unlock(&lockdep_lock);
+	raw_local_irq_restore(flags);
+
+	return ret;
+}
+
+static unsigned long __lockdep_count_backward_deps(struct lock_list *this)
+{
+	unsigned long  count = 0;
+	struct lock_list *uninitialized_var(target_entry);
+
+	__bfs_backwards(this, (void *)&count, noop_count, &target_entry);
+
+	return count;
+}
+
+unsigned long lockdep_count_backward_deps(struct lock_class *class)
+{
+	unsigned long ret, flags;
+	struct lock_list this;
+
+	this.parent = NULL;
+	this.class = class;
+
+	raw_local_irq_save(flags);
+	arch_spin_lock(&lockdep_lock);
+	ret = __lockdep_count_backward_deps(&this);
+	arch_spin_unlock(&lockdep_lock);
+	raw_local_irq_restore(flags);
+
+	return ret;
+}
+
+/*
+ * Check that the dependency graph starting at <src> can lead to
+ * <target> or not. Print an error and return 0 if it does.
+ */
+static noinline int
+check_path(struct lock_class *target, struct lock_list *src_entry,
+	   struct lock_list **target_entry)
+{
+	int ret;
+
+	ret = __bfs_forwards(src_entry, (void *)target, class_equal,
+			     target_entry);
+
+	if (unlikely(ret < 0))
+		print_bfs_bug(ret);
+
+	return ret;
+}
+
+/*
+ * Prove that the dependency graph starting at <src> can not
+ * lead to <target>. If it can, there is a circle when adding
+ * <target> -> <src> dependency.
+ *
+ * Print an error and return 0 if it does.
+ */
+static noinline int
+check_noncircular(struct held_lock *src, struct held_lock *target,
+		  struct lock_trace **const trace)
+{
+	int ret;
+	struct lock_list *uninitialized_var(target_entry);
+	struct lock_list src_entry = {
+		.class = hlock_class(src),
+		.parent = NULL,
+	};
+
+	debug_atomic_inc(nr_cyclic_checks);
+
+	ret = check_path(hlock_class(target), &src_entry, &target_entry);
+
+	if (unlikely(!ret)) {
+		if (!*trace) {
+			/*
+			 * If save_trace fails here, the printing might
+			 * trigger a WARN but because of the !nr_entries it
+			 * should not do bad things.
+			 */
+			*trace = save_trace();
+		}
+
+		print_circular_bug(&src_entry, target_entry, src, target);
+	}
+
+	return ret;
+}
+
+#ifdef CONFIG_LOCKDEP_SMALL
+/*
+ * Check that the dependency graph starting at <src> can lead to
+ * <target> or not. If it can, <src> -> <target> dependency is already
+ * in the graph.
+ *
+ * Print an error and return 2 if it does or 1 if it does not.
+ */
+static noinline int
+check_redundant(struct held_lock *src, struct held_lock *target)
+{
+	int ret;
+	struct lock_list *uninitialized_var(target_entry);
+	struct lock_list src_entry = {
+		.class = hlock_class(src),
+		.parent = NULL,
+	};
+
+	debug_atomic_inc(nr_redundant_checks);
+
+	ret = check_path(hlock_class(target), &src_entry, &target_entry);
+
+	if (!ret) {
+		debug_atomic_inc(nr_redundant);
+		ret = 2;
+	} else if (ret < 0)
+		ret = 0;
+
+	return ret;
+}
+#endif
+
+#ifdef CONFIG_TRACE_IRQFLAGS
+
+static inline int usage_accumulate(struct lock_list *entry, void *mask)
+{
+	*(unsigned long *)mask |= entry->class->usage_mask;
+
+	return 0;
+}
+
+/*
+ * Forwards and backwards subgraph searching, for the purposes of
+ * proving that two subgraphs can be connected by a new dependency
+ * without creating any illegal irq-safe -> irq-unsafe lock dependency.
+ */
+
+static inline int usage_match(struct lock_list *entry, void *mask)
+{
+	return entry->class->usage_mask & *(unsigned long *)mask;
+}
+
+/*
+ * Find a node in the forwards-direction dependency sub-graph starting
+ * at @root->class that matches @bit.
+ *
+ * Return 0 if such a node exists in the subgraph, and put that node
+ * into *@target_entry.
+ *
+ * Return 1 otherwise and keep *@target_entry unchanged.
+ * Return <0 on error.
+ */
+static int
+find_usage_forwards(struct lock_list *root, unsigned long usage_mask,
+			struct lock_list **target_entry)
+{
+	int result;
+
+	debug_atomic_inc(nr_find_usage_forwards_checks);
+
+	result = __bfs_forwards(root, &usage_mask, usage_match, target_entry);
+
+	return result;
+}
+
+/*
+ * Find a node in the backwards-direction dependency sub-graph starting
+ * at @root->class that matches @bit.
+ *
+ * Return 0 if such a node exists in the subgraph, and put that node
+ * into *@target_entry.
+ *
+ * Return 1 otherwise and keep *@target_entry unchanged.
+ * Return <0 on error.
+ */
+static int
+find_usage_backwards(struct lock_list *root, unsigned long usage_mask,
+			struct lock_list **target_entry)
+{
+	int result;
+
+	debug_atomic_inc(nr_find_usage_backwards_checks);
+
+	result = __bfs_backwards(root, &usage_mask, usage_match, target_entry);
+
+	return result;
+}
+
+static void print_lock_class_header(struct lock_class *class, int depth)
+{
+	int bit;
+
+	printk("%*s->", depth, "");
+	print_lock_name(class);
+#ifdef CONFIG_DEBUG_LOCKDEP
+	printk(KERN_CONT " ops: %lu", debug_class_ops_read(class));
+#endif
+	printk(KERN_CONT " {\n");
+
+	for (bit = 0; bit < LOCK_USAGE_STATES; bit++) {
+		if (class->usage_mask & (1 << bit)) {
+			int len = depth;
+
+			len += printk("%*s   %s", depth, "", usage_str[bit]);
+			len += printk(KERN_CONT " at:\n");
+			print_lock_trace(class->usage_traces[bit], len);
+		}
+	}
+	printk("%*s }\n", depth, "");
+
+	printk("%*s ... key      at: [<%px>] %pS\n",
+		depth, "", class->key, class->key);
+}
+
+/*
+ * printk the shortest lock dependencies from @start to @end in reverse order:
+ */
+static void __used
+print_shortest_lock_dependencies(struct lock_list *leaf,
+				 struct lock_list *root)
+{
+	struct lock_list *entry = leaf;
+	int depth;
+
+	/*compute depth from generated tree by BFS*/
+	depth = get_lock_depth(leaf);
+
+	do {
+		print_lock_class_header(entry->class, depth);
+		printk("%*s ... acquired at:\n", depth, "");
+		print_lock_trace(entry->trace, 2);
+		printk("\n");
+
+		if (depth == 0 && (entry != root)) {
+			printk("lockdep:%s bad path found in chain graph\n", __func__);
+			break;
+		}
+
+		entry = get_lock_parent(entry);
+		depth--;
+	} while (entry && (depth >= 0));
+}
+
+static void
+print_irq_lock_scenario(struct lock_list *safe_entry,
+			struct lock_list *unsafe_entry,
+			struct lock_class *prev_class,
+			struct lock_class *next_class)
+{
+	struct lock_class *safe_class = safe_entry->class;
+	struct lock_class *unsafe_class = unsafe_entry->class;
+	struct lock_class *middle_class = prev_class;
+
+	if (middle_class == safe_class)
+		middle_class = next_class;
+
+	/*
+	 * A direct locking problem where unsafe_class lock is taken
+	 * directly by safe_class lock, then all we need to show
+	 * is the deadlock scenario, as it is obvious that the
+	 * unsafe lock is taken under the safe lock.
+	 *
+	 * But if there is a chain instead, where the safe lock takes
+	 * an intermediate lock (middle_class) where this lock is
+	 * not the same as the safe lock, then the lock chain is
+	 * used to describe the problem. Otherwise we would need
+	 * to show a different CPU case for each link in the chain
+	 * from the safe_class lock to the unsafe_class lock.
+	 */
+	if (middle_class != unsafe_class) {
+		printk("Chain exists of:\n  ");
+		__print_lock_name(safe_class);
+		printk(KERN_CONT " --> ");
+		__print_lock_name(middle_class);
+		printk(KERN_CONT " --> ");
+		__print_lock_name(unsafe_class);
+		printk(KERN_CONT "\n\n");
+	}
+
+	printk(" Possible interrupt unsafe locking scenario:\n\n");
+	printk("       CPU0                    CPU1\n");
+	printk("       ----                    ----\n");
+	printk("  lock(");
+	__print_lock_name(unsafe_class);
+	printk(KERN_CONT ");\n");
+	printk("                               local_irq_disable();\n");
+	printk("                               lock(");
+	__print_lock_name(safe_class);
+	printk(KERN_CONT ");\n");
+	printk("                               lock(");
+	__print_lock_name(middle_class);
+	printk(KERN_CONT ");\n");
+	printk("  <Interrupt>\n");
+	printk("    lock(");
+	__print_lock_name(safe_class);
+	printk(KERN_CONT ");\n");
+	printk("\n *** DEADLOCK ***\n\n");
+}
+
+static void
+print_bad_irq_dependency(struct task_struct *curr,
+			 struct lock_list *prev_root,
+			 struct lock_list *next_root,
+			 struct lock_list *backwards_entry,
+			 struct lock_list *forwards_entry,
+			 struct held_lock *prev,
+			 struct held_lock *next,
+			 enum lock_usage_bit bit1,
+			 enum lock_usage_bit bit2,
+			 const char *irqclass)
+{
+	if (!debug_locks_off_graph_unlock() || debug_locks_silent)
+		return;
+
+	pr_warn("\n");
+	pr_warn("=====================================================\n");
+	pr_warn("WARNING: %s-safe -> %s-unsafe lock order detected\n",
+		irqclass, irqclass);
+	print_kernel_ident();
+	pr_warn("-----------------------------------------------------\n");
+	pr_warn("%s/%d [HC%u[%lu]:SC%u[%lu]:HE%u:SE%u] is trying to acquire:\n",
+		curr->comm, task_pid_nr(curr),
+		curr->hardirq_context, hardirq_count() >> HARDIRQ_SHIFT,
+		curr->softirq_context, softirq_count() >> SOFTIRQ_SHIFT,
+		curr->hardirqs_enabled,
+		curr->softirqs_enabled);
+	print_lock(next);
+
+	pr_warn("\nand this task is already holding:\n");
+	print_lock(prev);
+	pr_warn("which would create a new lock dependency:\n");
+	print_lock_name(hlock_class(prev));
+	pr_cont(" ->");
+	print_lock_name(hlock_class(next));
+	pr_cont("\n");
+
+	pr_warn("\nbut this new dependency connects a %s-irq-safe lock:\n",
+		irqclass);
+	print_lock_name(backwards_entry->class);
+	pr_warn("\n... which became %s-irq-safe at:\n", irqclass);
+
+	print_lock_trace(backwards_entry->class->usage_traces[bit1], 1);
+
+	pr_warn("\nto a %s-irq-unsafe lock:\n", irqclass);
+	print_lock_name(forwards_entry->class);
+	pr_warn("\n... which became %s-irq-unsafe at:\n", irqclass);
+	pr_warn("...");
+
+	print_lock_trace(forwards_entry->class->usage_traces[bit2], 1);
+
+	pr_warn("\nother info that might help us debug this:\n\n");
+	print_irq_lock_scenario(backwards_entry, forwards_entry,
+				hlock_class(prev), hlock_class(next));
+
+	lockdep_print_held_locks(curr);
+
+	pr_warn("\nthe dependencies between %s-irq-safe lock and the holding lock:\n", irqclass);
+	prev_root->trace = save_trace();
+	if (!prev_root->trace)
+		return;
+	print_shortest_lock_dependencies(backwards_entry, prev_root);
+
+	pr_warn("\nthe dependencies between the lock to be acquired");
+	pr_warn(" and %s-irq-unsafe lock:\n", irqclass);
+	next_root->trace = save_trace();
+	if (!next_root->trace)
+		return;
+	print_shortest_lock_dependencies(forwards_entry, next_root);
+
+	pr_warn("\nstack backtrace:\n");
+	dump_stack();
+}
+
+static const char *state_names[] = {
+#define LOCKDEP_STATE(__STATE) \
+	__stringify(__STATE),
+#include "lockdep_states.h"
+#undef LOCKDEP_STATE
+};
+
+static const char *state_rnames[] = {
+#define LOCKDEP_STATE(__STATE) \
+	__stringify(__STATE)"-READ",
+#include "lockdep_states.h"
+#undef LOCKDEP_STATE
+};
+
+static inline const char *state_name(enum lock_usage_bit bit)
+{
+	if (bit & LOCK_USAGE_READ_MASK)
+		return state_rnames[bit >> LOCK_USAGE_DIR_MASK];
+	else
+		return state_names[bit >> LOCK_USAGE_DIR_MASK];
+}
+
+/*
+ * The bit number is encoded like:
+ *
+ *  bit0: 0 exclusive, 1 read lock
+ *  bit1: 0 used in irq, 1 irq enabled
+ *  bit2-n: state
+ */
+static int exclusive_bit(int new_bit)
+{
+	int state = new_bit & LOCK_USAGE_STATE_MASK;
+	int dir = new_bit & LOCK_USAGE_DIR_MASK;
+
+	/*
+	 * keep state, bit flip the direction and strip read.
+	 */
+	return state | (dir ^ LOCK_USAGE_DIR_MASK);
+}
+
+/*
+ * Observe that when given a bitmask where each bitnr is encoded as above, a
+ * right shift of the mask transforms the individual bitnrs as -1 and
+ * conversely, a left shift transforms into +1 for the individual bitnrs.
+ *
+ * So for all bits whose number have LOCK_ENABLED_* set (bitnr1 == 1), we can
+ * create the mask with those bit numbers using LOCK_USED_IN_* (bitnr1 == 0)
+ * instead by subtracting the bit number by 2, or shifting the mask right by 2.
+ *
+ * Similarly, bitnr1 == 0 becomes bitnr1 == 1 by adding 2, or shifting left 2.
+ *
+ * So split the mask (note that LOCKF_ENABLED_IRQ_ALL|LOCKF_USED_IN_IRQ_ALL is
+ * all bits set) and recompose with bitnr1 flipped.
+ */
+static unsigned long invert_dir_mask(unsigned long mask)
+{
+	unsigned long excl = 0;
+
+	/* Invert dir */
+	excl |= (mask & LOCKF_ENABLED_IRQ_ALL) >> LOCK_USAGE_DIR_MASK;
+	excl |= (mask & LOCKF_USED_IN_IRQ_ALL) << LOCK_USAGE_DIR_MASK;
+
+	return excl;
+}
+
+/*
+ * As above, we clear bitnr0 (LOCK_*_READ off) with bitmask ops. First, for all
+ * bits with bitnr0 set (LOCK_*_READ), add those with bitnr0 cleared (LOCK_*).
+ * And then mask out all bitnr0.
+ */
+static unsigned long exclusive_mask(unsigned long mask)
+{
+	unsigned long excl = invert_dir_mask(mask);
+
+	/* Strip read */
+	excl |= (excl & LOCKF_IRQ_READ) >> LOCK_USAGE_READ_MASK;
+	excl &= ~LOCKF_IRQ_READ;
+
+	return excl;
+}
+
+/*
+ * Retrieve the _possible_ original mask to which @mask is
+ * exclusive. Ie: this is the opposite of exclusive_mask().
+ * Note that 2 possible original bits can match an exclusive
+ * bit: one has LOCK_USAGE_READ_MASK set, the other has it
+ * cleared. So both are returned for each exclusive bit.
+ */
+static unsigned long original_mask(unsigned long mask)
+{
+	unsigned long excl = invert_dir_mask(mask);
+
+	/* Include read in existing usages */
+	excl |= (excl & LOCKF_IRQ) << LOCK_USAGE_READ_MASK;
+
+	return excl;
+}
+
+/*
+ * Find the first pair of bit match between an original
+ * usage mask and an exclusive usage mask.
+ */
+static int find_exclusive_match(unsigned long mask,
+				unsigned long excl_mask,
+				enum lock_usage_bit *bitp,
+				enum lock_usage_bit *excl_bitp)
+{
+	int bit, excl;
+
+	for_each_set_bit(bit, &mask, LOCK_USED) {
+		excl = exclusive_bit(bit);
+		if (excl_mask & lock_flag(excl)) {
+			*bitp = bit;
+			*excl_bitp = excl;
+			return 0;
+		}
+	}
+	return -1;
+}
+
+/*
+ * Prove that the new dependency does not connect a hardirq-safe(-read)
+ * lock with a hardirq-unsafe lock - to achieve this we search
+ * the backwards-subgraph starting at <prev>, and the
+ * forwards-subgraph starting at <next>:
+ */
+static int check_irq_usage(struct task_struct *curr, struct held_lock *prev,
+			   struct held_lock *next)
+{
+	unsigned long usage_mask = 0, forward_mask, backward_mask;
+	enum lock_usage_bit forward_bit = 0, backward_bit = 0;
+	struct lock_list *uninitialized_var(target_entry1);
+	struct lock_list *uninitialized_var(target_entry);
+	struct lock_list this, that;
+	int ret;
+
+	/*
+	 * Step 1: gather all hard/soft IRQs usages backward in an
+	 * accumulated usage mask.
+	 */
+	this.parent = NULL;
+	this.class = hlock_class(prev);
+
+	ret = __bfs_backwards(&this, &usage_mask, usage_accumulate, NULL);
+	if (ret < 0) {
+		print_bfs_bug(ret);
+		return 0;
+	}
+
+	usage_mask &= LOCKF_USED_IN_IRQ_ALL;
+	if (!usage_mask)
+		return 1;
+
+	/*
+	 * Step 2: find exclusive uses forward that match the previous
+	 * backward accumulated mask.
+	 */
+	forward_mask = exclusive_mask(usage_mask);
+
+	that.parent = NULL;
+	that.class = hlock_class(next);
+
+	ret = find_usage_forwards(&that, forward_mask, &target_entry1);
+	if (ret < 0) {
+		print_bfs_bug(ret);
+		return 0;
+	}
+	if (ret == 1)
+		return ret;
+
+	/*
+	 * Step 3: we found a bad match! Now retrieve a lock from the backward
+	 * list whose usage mask matches the exclusive usage mask from the
+	 * lock found on the forward list.
+	 */
+	backward_mask = original_mask(target_entry1->class->usage_mask);
+
+	ret = find_usage_backwards(&this, backward_mask, &target_entry);
+	if (ret < 0) {
+		print_bfs_bug(ret);
+		return 0;
+	}
+	if (DEBUG_LOCKS_WARN_ON(ret == 1))
+		return 1;
+
+	/*
+	 * Step 4: narrow down to a pair of incompatible usage bits
+	 * and report it.
+	 */
+	ret = find_exclusive_match(target_entry->class->usage_mask,
+				   target_entry1->class->usage_mask,
+				   &backward_bit, &forward_bit);
+	if (DEBUG_LOCKS_WARN_ON(ret == -1))
+		return 1;
+
+	print_bad_irq_dependency(curr, &this, &that,
+				 target_entry, target_entry1,
+				 prev, next,
+				 backward_bit, forward_bit,
+				 state_name(backward_bit));
+
+	return 0;
+}
+
+#else
+
+static inline int check_irq_usage(struct task_struct *curr,
+				  struct held_lock *prev, struct held_lock *next)
+{
+	return 1;
+}
+#endif /* CONFIG_TRACE_IRQFLAGS */
+
+static void inc_chains(int irq_context)
+{
+	if (irq_context & LOCK_CHAIN_HARDIRQ_CONTEXT)
+		nr_hardirq_chains++;
+	else if (irq_context & LOCK_CHAIN_SOFTIRQ_CONTEXT)
+		nr_softirq_chains++;
+	else
+		nr_process_chains++;
+}
+
+static void dec_chains(int irq_context)
+{
+	if (irq_context & LOCK_CHAIN_HARDIRQ_CONTEXT)
+		nr_hardirq_chains--;
+	else if (irq_context & LOCK_CHAIN_SOFTIRQ_CONTEXT)
+		nr_softirq_chains--;
+	else
+		nr_process_chains--;
+}
+
+static void
+print_deadlock_scenario(struct held_lock *nxt, struct held_lock *prv)
+{
+	struct lock_class *next = hlock_class(nxt);
+	struct lock_class *prev = hlock_class(prv);
+
+	printk(" Possible unsafe locking scenario:\n\n");
+	printk("       CPU0\n");
+	printk("       ----\n");
+	printk("  lock(");
+	__print_lock_name(prev);
+	printk(KERN_CONT ");\n");
+	printk("  lock(");
+	__print_lock_name(next);
+	printk(KERN_CONT ");\n");
+	printk("\n *** DEADLOCK ***\n\n");
+	printk(" May be due to missing lock nesting notation\n\n");
+}
+
+static void
+print_deadlock_bug(struct task_struct *curr, struct held_lock *prev,
+		   struct held_lock *next)
+{
+	if (!debug_locks_off_graph_unlock() || debug_locks_silent)
+		return;
+
+	pr_warn("\n");
+	pr_warn("============================================\n");
+	pr_warn("WARNING: possible recursive locking detected\n");
+	print_kernel_ident();
+	pr_warn("--------------------------------------------\n");
+	pr_warn("%s/%d is trying to acquire lock:\n",
+		curr->comm, task_pid_nr(curr));
+	print_lock(next);
+	pr_warn("\nbut task is already holding lock:\n");
+	print_lock(prev);
+
+	pr_warn("\nother info that might help us debug this:\n");
+	print_deadlock_scenario(next, prev);
+	lockdep_print_held_locks(curr);
+
+	pr_warn("\nstack backtrace:\n");
+	dump_stack();
+}
+
+/*
+ * Check whether we are holding such a class already.
+ *
+ * (Note that this has to be done separately, because the graph cannot
+ * detect such classes of deadlocks.)
+ *
+ * Returns: 0 on deadlock detected, 1 on OK, 2 on recursive read
+ */
+static int
+check_deadlock(struct task_struct *curr, struct held_lock *next)
+{
+	struct held_lock *prev;
+	struct held_lock *nest = NULL;
+	int i;
+
+	for (i = 0; i < curr->lockdep_depth; i++) {
+		prev = curr->held_locks + i;
+
+		if (prev->instance == next->nest_lock)
+			nest = prev;
+
+		if (hlock_class(prev) != hlock_class(next))
+			continue;
+
+		/*
+		 * Allow read-after-read recursion of the same
+		 * lock class (i.e. read_lock(lock)+read_lock(lock)):
+		 */
+		if ((next->read == 2) && prev->read)
+			return 2;
+
+		/*
+		 * We're holding the nest_lock, which serializes this lock's
+		 * nesting behaviour.
+		 */
+		if (nest)
+			return 2;
+
+		print_deadlock_bug(curr, prev, next);
+		return 0;
+	}
+	return 1;
+}
+
+/*
+ * There was a chain-cache miss, and we are about to add a new dependency
+ * to a previous lock. We validate the following rules:
+ *
+ *  - would the adding of the <prev> -> <next> dependency create a
+ *    circular dependency in the graph? [== circular deadlock]
+ *
+ *  - does the new prev->next dependency connect any hardirq-safe lock
+ *    (in the full backwards-subgraph starting at <prev>) with any
+ *    hardirq-unsafe lock (in the full forwards-subgraph starting at
+ *    <next>)? [== illegal lock inversion with hardirq contexts]
+ *
+ *  - does the new prev->next dependency connect any softirq-safe lock
+ *    (in the full backwards-subgraph starting at <prev>) with any
+ *    softirq-unsafe lock (in the full forwards-subgraph starting at
+ *    <next>)? [== illegal lock inversion with softirq contexts]
+ *
+ * any of these scenarios could lead to a deadlock.
+ *
+ * Then if all the validations pass, we add the forwards and backwards
+ * dependency.
+ */
+static int
+check_prev_add(struct task_struct *curr, struct held_lock *prev,
+	       struct held_lock *next, int distance,
+	       struct lock_trace **const trace)
+{
+	struct lock_list *entry;
+	int ret;
+
+	if (!hlock_class(prev)->key || !hlock_class(next)->key) {
+		/*
+		 * The warning statements below may trigger a use-after-free
+		 * of the class name. It is better to trigger a use-after free
+		 * and to have the class name most of the time instead of not
+		 * having the class name available.
+		 */
+		WARN_ONCE(!debug_locks_silent && !hlock_class(prev)->key,
+			  "Detected use-after-free of lock class %px/%s\n",
+			  hlock_class(prev),
+			  hlock_class(prev)->name);
+		WARN_ONCE(!debug_locks_silent && !hlock_class(next)->key,
+			  "Detected use-after-free of lock class %px/%s\n",
+			  hlock_class(next),
+			  hlock_class(next)->name);
+		return 2;
+	}
+
+	/*
+	 * Prove that the new <prev> -> <next> dependency would not
+	 * create a circular dependency in the graph. (We do this by
+	 * a breadth-first search into the graph starting at <next>,
+	 * and check whether we can reach <prev>.)
+	 *
+	 * The search is limited by the size of the circular queue (i.e.,
+	 * MAX_CIRCULAR_QUEUE_SIZE) which keeps track of a breadth of nodes
+	 * in the graph whose neighbours are to be checked.
+	 */
+	ret = check_noncircular(next, prev, trace);
+	if (unlikely(ret <= 0))
+		return 0;
+
+	if (!check_irq_usage(curr, prev, next))
+		return 0;
+
+	/*
+	 * For recursive read-locks we do all the dependency checks,
+	 * but we dont store read-triggered dependencies (only
+	 * write-triggered dependencies). This ensures that only the
+	 * write-side dependencies matter, and that if for example a
+	 * write-lock never takes any other locks, then the reads are
+	 * equivalent to a NOP.
+	 */
+	if (next->read == 2 || prev->read == 2)
+		return 1;
+	/*
+	 * Is the <prev> -> <next> dependency already present?
+	 *
+	 * (this may occur even though this is a new chain: consider
+	 *  e.g. the L1 -> L2 -> L3 -> L4 and the L5 -> L1 -> L2 -> L3
+	 *  chains - the second one will be new, but L1 already has
+	 *  L2 added to its dependency list, due to the first chain.)
+	 */
+	list_for_each_entry(entry, &hlock_class(prev)->locks_after, entry) {
+		if (entry->class == hlock_class(next)) {
+			if (distance == 1)
+				entry->distance = 1;
+			return 1;
+		}
+	}
+
+#ifdef CONFIG_LOCKDEP_SMALL
+	/*
+	 * Is the <prev> -> <next> link redundant?
+	 */
+	ret = check_redundant(prev, next);
+	if (ret != 1)
+		return ret;
+#endif
+
+	if (!*trace) {
+		*trace = save_trace();
+		if (!*trace)
+			return 0;
+	}
+
+	/*
+	 * Ok, all validations passed, add the new lock
+	 * to the previous lock's dependency list:
+	 */
+	ret = add_lock_to_list(hlock_class(next), hlock_class(prev),
+			       &hlock_class(prev)->locks_after,
+			       next->acquire_ip, distance, *trace);
+
+	if (!ret)
+		return 0;
+
+	ret = add_lock_to_list(hlock_class(prev), hlock_class(next),
+			       &hlock_class(next)->locks_before,
+			       next->acquire_ip, distance, *trace);
+	if (!ret)
+		return 0;
+
+	return 2;
+}
+
+/*
+ * Add the dependency to all directly-previous locks that are 'relevant'.
+ * The ones that are relevant are (in increasing distance from curr):
+ * all consecutive trylock entries and the final non-trylock entry - or
+ * the end of this context's lock-chain - whichever comes first.
+ */
+static int
+check_prevs_add(struct task_struct *curr, struct held_lock *next)
+{
+	struct lock_trace *trace = NULL;
+	int depth = curr->lockdep_depth;
+	struct held_lock *hlock;
+
+	/*
+	 * Debugging checks.
+	 *
+	 * Depth must not be zero for a non-head lock:
+	 */
+	if (!depth)
+		goto out_bug;
+	/*
+	 * At least two relevant locks must exist for this
+	 * to be a head:
+	 */
+	if (curr->held_locks[depth].irq_context !=
+			curr->held_locks[depth-1].irq_context)
+		goto out_bug;
+
+	for (;;) {
+		int distance = curr->lockdep_depth - depth + 1;
+		hlock = curr->held_locks + depth - 1;
+
+		/*
+		 * Only non-recursive-read entries get new dependencies
+		 * added:
+		 */
+		if (hlock->read != 2 && hlock->check) {
+			int ret = check_prev_add(curr, hlock, next, distance,
+						 &trace);
+			if (!ret)
+				return 0;
+
+			/*
+			 * Stop after the first non-trylock entry,
+			 * as non-trylock entries have added their
+			 * own direct dependencies already, so this
+			 * lock is connected to them indirectly:
+			 */
+			if (!hlock->trylock)
+				break;
+		}
+
+		depth--;
+		/*
+		 * End of lock-stack?
+		 */
+		if (!depth)
+			break;
+		/*
+		 * Stop the search if we cross into another context:
+		 */
+		if (curr->held_locks[depth].irq_context !=
+				curr->held_locks[depth-1].irq_context)
+			break;
+	}
+	return 1;
+out_bug:
+	if (!debug_locks_off_graph_unlock())
+		return 0;
+
+	/*
+	 * Clearly we all shouldn't be here, but since we made it we
+	 * can reliable say we messed up our state. See the above two
+	 * gotos for reasons why we could possibly end up here.
+	 */
+	WARN_ON(1);
+
+	return 0;
+}
+
+/*
+ * The first 2 chain_hlocks entries in the chain block in the bucket
+ * list contains the following meta data:
+ *
+ *   entry[0]:
+ *     Bit    15 - always set to 1 (it is not a class index)
+ *     Bits 0-14 - upper 15 bits of the next block index
+ *   entry[1]    - lower 16 bits of next block index
+ *
+ * A next block index of all 1 bits means it is the end of the list.
+ *
+ * On the unsized bucket (bucket-0), the 3rd and 4th entries contain
+ * the chain block size:
+ *
+ *   entry[2] - upper 16 bits of the chain block size
+ *   entry[3] - lower 16 bits of the chain block size
+ */
+#define MAX_CHAIN_BUCKETS	16
+#define CHAIN_BLK_FLAG		(1U << 15)
+#define CHAIN_BLK_LIST_END	0xFFFFU
+
+static int chain_block_buckets[MAX_CHAIN_BUCKETS];
+
+static inline int size_to_bucket(int size)
+{
+	if (size > MAX_CHAIN_BUCKETS)
+		return 0;
+
+	return size - 1;
+}
+
+/*
+ * Iterate all the chain blocks in a bucket.
+ */
+#define for_each_chain_block(bucket, prev, curr)		\
+	for ((prev) = -1, (curr) = chain_block_buckets[bucket];	\
+	     (curr) >= 0;					\
+	     (prev) = (curr), (curr) = chain_block_next(curr))
+
+/*
+ * next block or -1
+ */
+static inline int chain_block_next(int offset)
+{
+	int next = chain_hlocks[offset];
+
+	WARN_ON_ONCE(!(next & CHAIN_BLK_FLAG));
+
+	if (next == CHAIN_BLK_LIST_END)
+		return -1;
+
+	next &= ~CHAIN_BLK_FLAG;
+	next <<= 16;
+	next |= chain_hlocks[offset + 1];
+
+	return next;
+}
+
+/*
+ * bucket-0 only
+ */
+static inline int chain_block_size(int offset)
+{
+	return (chain_hlocks[offset + 2] << 16) | chain_hlocks[offset + 3];
+}
+
+static inline void init_chain_block(int offset, int next, int bucket, int size)
+{
+	chain_hlocks[offset] = (next >> 16) | CHAIN_BLK_FLAG;
+	chain_hlocks[offset + 1] = (u16)next;
+
+	if (size && !bucket) {
+		chain_hlocks[offset + 2] = size >> 16;
+		chain_hlocks[offset + 3] = (u16)size;
+	}
+}
+
+static inline void add_chain_block(int offset, int size)
+{
+	int bucket = size_to_bucket(size);
+	int next = chain_block_buckets[bucket];
+	int prev, curr;
+
+	if (unlikely(size < 2)) {
+		/*
+		 * We can't store single entries on the freelist. Leak them.
+		 *
+		 * One possible way out would be to uniquely mark them, other
+		 * than with CHAIN_BLK_FLAG, such that we can recover them when
+		 * the block before it is re-added.
+		 */
+		if (size)
+			nr_lost_chain_hlocks++;
+		return;
+	}
+
+	nr_free_chain_hlocks += size;
+	if (!bucket) {
+		nr_large_chain_blocks++;
+
+		/*
+		 * Variable sized, sort large to small.
+		 */
+		for_each_chain_block(0, prev, curr) {
+			if (size >= chain_block_size(curr))
+				break;
+		}
+		init_chain_block(offset, curr, 0, size);
+		if (prev < 0)
+			chain_block_buckets[0] = offset;
+		else
+			init_chain_block(prev, offset, 0, 0);
+		return;
+	}
+	/*
+	 * Fixed size, add to head.
+	 */
+	init_chain_block(offset, next, bucket, size);
+	chain_block_buckets[bucket] = offset;
+}
+
+/*
+ * Only the first block in the list can be deleted.
+ *
+ * For the variable size bucket[0], the first block (the largest one) is
+ * returned, broken up and put back into the pool. So if a chain block of
+ * length > MAX_CHAIN_BUCKETS is ever used and zapped, it will just be
+ * queued up after the primordial chain block and never be used until the
+ * hlock entries in the primordial chain block is almost used up. That
+ * causes fragmentation and reduce allocation efficiency. That can be
+ * monitored by looking at the "large chain blocks" number in lockdep_stats.
+ */
+static inline void del_chain_block(int bucket, int size, int next)
+{
+	nr_free_chain_hlocks -= size;
+	chain_block_buckets[bucket] = next;
+
+	if (!bucket)
+		nr_large_chain_blocks--;
+}
+
+static void init_chain_block_buckets(void)
+{
+	int i;
+
+	for (i = 0; i < MAX_CHAIN_BUCKETS; i++)
+		chain_block_buckets[i] = -1;
+
+	add_chain_block(0, ARRAY_SIZE(chain_hlocks));
+}
+
+/*
+ * Return offset of a chain block of the right size or -1 if not found.
+ *
+ * Fairly simple worst-fit allocator with the addition of a number of size
+ * specific free lists.
+ */
+static int alloc_chain_hlocks(int req)
+{
+	int bucket, curr, size;
+
+	/*
+	 * We rely on the MSB to act as an escape bit to denote freelist
+	 * pointers. Make sure this bit isn't set in 'normal' class_idx usage.
+	 */
+	BUILD_BUG_ON((MAX_LOCKDEP_KEYS-1) & CHAIN_BLK_FLAG);
+
+	init_data_structures_once();
+
+	if (nr_free_chain_hlocks < req)
+		return -1;
+
+	/*
+	 * We require a minimum of 2 (u16) entries to encode a freelist
+	 * 'pointer'.
+	 */
+	req = max(req, 2);
+	bucket = size_to_bucket(req);
+	curr = chain_block_buckets[bucket];
+
+	if (bucket) {
+		if (curr >= 0) {
+			del_chain_block(bucket, req, chain_block_next(curr));
+			return curr;
+		}
+		/* Try bucket 0 */
+		curr = chain_block_buckets[0];
+	}
+
+	/*
+	 * The variable sized freelist is sorted by size; the first entry is
+	 * the largest. Use it if it fits.
+	 */
+	if (curr >= 0) {
+		size = chain_block_size(curr);
+		if (likely(size >= req)) {
+			del_chain_block(0, size, chain_block_next(curr));
+			add_chain_block(curr + req, size - req);
+			return curr;
+		}
+	}
+
+	/*
+	 * Last resort, split a block in a larger sized bucket.
+	 */
+	for (size = MAX_CHAIN_BUCKETS; size > req; size--) {
+		bucket = size_to_bucket(size);
+		curr = chain_block_buckets[bucket];
+		if (curr < 0)
+			continue;
+
+		del_chain_block(bucket, size, chain_block_next(curr));
+		add_chain_block(curr + req, size - req);
+		return curr;
+	}
+
+	return -1;
+}
+
+static inline void free_chain_hlocks(int base, int size)
+{
+	add_chain_block(base, max(size, 2));
+}
+
+struct lock_class *lock_chain_get_class(struct lock_chain *chain, int i)
+{
+	return lock_classes + chain_hlocks[chain->base + i];
+}
+
+/*
+ * Returns the index of the first held_lock of the current chain
+ */
+static inline int get_first_held_lock(struct task_struct *curr,
+					struct held_lock *hlock)
+{
+	int i;
+	struct held_lock *hlock_curr;
+
+	for (i = curr->lockdep_depth - 1; i >= 0; i--) {
+		hlock_curr = curr->held_locks + i;
+		if (hlock_curr->irq_context != hlock->irq_context)
+			break;
+
+	}
+
+	return ++i;
+}
+
+#ifdef CONFIG_DEBUG_LOCKDEP
+/*
+ * Returns the next chain_key iteration
+ */
+static u64 print_chain_key_iteration(int class_idx, u64 chain_key)
+{
+	u64 new_chain_key = iterate_chain_key(chain_key, class_idx);
+
+	printk(" class_idx:%d -> chain_key:%016Lx",
+		class_idx,
+		(unsigned long long)new_chain_key);
+	return new_chain_key;
+}
+
+static void
+print_chain_keys_held_locks(struct task_struct *curr, struct held_lock *hlock_next)
+{
+	struct held_lock *hlock;
+	u64 chain_key = INITIAL_CHAIN_KEY;
+	int depth = curr->lockdep_depth;
+	int i = get_first_held_lock(curr, hlock_next);
+
+	printk("depth: %u (irq_context %u)\n", depth - i + 1,
+		hlock_next->irq_context);
+	for (; i < depth; i++) {
+		hlock = curr->held_locks + i;
+		chain_key = print_chain_key_iteration(hlock->class_idx, chain_key);
+
+		print_lock(hlock);
+	}
+
+	print_chain_key_iteration(hlock_next->class_idx, chain_key);
+	print_lock(hlock_next);
+}
+
+static void print_chain_keys_chain(struct lock_chain *chain)
+{
+	int i;
+	u64 chain_key = INITIAL_CHAIN_KEY;
+	int class_id;
+
+	printk("depth: %u\n", chain->depth);
+	for (i = 0; i < chain->depth; i++) {
+		class_id = chain_hlocks[chain->base + i];
+		chain_key = print_chain_key_iteration(class_id, chain_key);
+
+		print_lock_name(lock_classes + class_id);
+		printk("\n");
+	}
+}
+
+static void print_collision(struct task_struct *curr,
+			struct held_lock *hlock_next,
+			struct lock_chain *chain)
+{
+	pr_warn("\n");
+	pr_warn("============================\n");
+	pr_warn("WARNING: chain_key collision\n");
+	print_kernel_ident();
+	pr_warn("----------------------------\n");
+	pr_warn("%s/%d: ", current->comm, task_pid_nr(current));
+	pr_warn("Hash chain already cached but the contents don't match!\n");
+
+	pr_warn("Held locks:");
+	print_chain_keys_held_locks(curr, hlock_next);
+
+	pr_warn("Locks in cached chain:");
+	print_chain_keys_chain(chain);
+
+	pr_warn("\nstack backtrace:\n");
+	dump_stack();
+}
+
+/*
+ * Checks whether the chain and the current held locks are consistent
+ * in depth and also in content. If they are not it most likely means
+ * that there was a collision during the calculation of the chain_key.
+ * Returns: 0 not passed, 1 passed
+ */
+static int check_no_collision(struct task_struct *curr,
+			struct held_lock *hlock,
+			struct lock_chain *chain)
+{
+	int i, j, id;
+
+	i = get_first_held_lock(curr, hlock);
+
+	if (DEBUG_LOCKS_WARN_ON(chain->depth != curr->lockdep_depth - (i - 1))) {
+		print_collision(curr, hlock, chain);
+		return 0;
+	}
+
+	for (j = 0; j < chain->depth - 1; j++, i++) {
+		id = curr->held_locks[i].class_idx;
+
+		if (DEBUG_LOCKS_WARN_ON(chain_hlocks[chain->base + j] != id)) {
+			print_collision(curr, hlock, chain);
+			return 0;
+		}
+	}
+	return 1;
+}
+
+/*
+ * Check whether we follow the irq-flags state precisely:
+ */
+static void check_flags(unsigned long flags)
+{
+	if (!debug_locks)
+		return;
+
+	if (irqs_disabled_flags(flags)) {
+		if (DEBUG_LOCKS_WARN_ON(current->hardirqs_enabled)) {
+			printk("possible reason: unannotated irqs-off.\n");
+		}
+	} else {
+		if (DEBUG_LOCKS_WARN_ON(!current->hardirqs_enabled)) {
+			printk("possible reason: unannotated irqs-on.\n");
+		}
+	}
+
+	/*
+	 * We dont accurately track softirq state in e.g.
+	 * hardirq contexts (such as on 4KSTACKS), so only
+	 * check if not in hardirq contexts:
+	 */
+	if (!hardirq_count()) {
+		if (softirq_count()) {
+			/* like the above, but with softirqs */
+			DEBUG_LOCKS_WARN_ON(current->softirqs_enabled);
+		} else {
+			/* lick the above, does it taste good? */
+			DEBUG_LOCKS_WARN_ON(!current->softirqs_enabled);
+		}
+	}
+
+	if (!debug_locks)
+		print_irqtrace_events(current);
+}
+
+#define check_lock_chain_key	check_lock_chain_key
+static bool check_lock_chain_key(struct lock_chain *chain)
+{
+	u64 chain_key = INITIAL_CHAIN_KEY;
+	int i;
+
+	for (i = chain->base; i < chain->base + chain->depth; i++)
+		chain_key = iterate_chain_key(chain_key, chain_hlocks[i]);
+	/*
+	 * The 'unsigned long long' casts avoid that a compiler warning
+	 * is reported when building tools/lib/lockdep.
+	 */
+	if (chain->chain_key != chain_key) {
+		printk(KERN_INFO "chain %lld: key %#llx <> %#llx\n",
+		       (unsigned long long)(chain - lock_chains),
+		       (unsigned long long)chain->chain_key,
+		       (unsigned long long)chain_key);
+		return false;
+	}
+	return true;
+}
+
+#else
+static int check_no_collision(struct task_struct *curr,
+			struct held_lock *hlock,
+			struct lock_chain *chain)
+{
+	return 1;
+}
+
+static void check_flags(unsigned long flags)	{ }
+#endif	/* CONFIG_DEBUG_LOCKDEP */
+
+/*
+ * Given an index that is >= -1, return the index of the next lock chain.
+ * Return -2 if there is no next lock chain.
+ */
+long lockdep_next_lockchain(long i)
+{
+	i = find_next_bit(lock_chains_in_use, ARRAY_SIZE(lock_chains), i + 1);
+	return i < ARRAY_SIZE(lock_chains) ? i : -2;
+}
+
+unsigned long lock_chain_count(void)
+{
+	return bitmap_weight(lock_chains_in_use, ARRAY_SIZE(lock_chains));
+}
+
+/* Must be called with the graph lock held. */
+static struct lock_chain *alloc_lock_chain(void)
+{
+	int idx = find_first_zero_bit(lock_chains_in_use,
+				      ARRAY_SIZE(lock_chains));
+
+	if (unlikely(idx >= ARRAY_SIZE(lock_chains)))
+		return NULL;
+	__set_bit(idx, lock_chains_in_use);
+	return lock_chains + idx;
+}
+
+/*
+ * Adds a dependency chain into chain hashtable. And must be called with
+ * graph_lock held.
+ *
+ * Return 0 if fail, and graph_lock is released.
+ * Return 1 if succeed, with graph_lock held.
+ */
+static inline int add_chain_cache(struct task_struct *curr,
+				  struct held_lock *hlock,
+				  u64 chain_key)
+{
+	struct lock_class *class = hlock_class(hlock);
+	struct hlist_head *hash_head = chainhashentry(chain_key);
+	struct lock_chain *chain;
+	int i, j;
+
+	/*
+	 * The caller must hold the graph lock, ensure we've got IRQs
+	 * disabled to make this an IRQ-safe lock.. for recursion reasons
+	 * lockdep won't complain about its own locking errors.
+	 */
+	if (DEBUG_LOCKS_WARN_ON(!irqs_disabled()))
+		return 0;
+
+	chain = alloc_lock_chain();
+	if (!chain) {
+		if (!debug_locks_off_graph_unlock())
+			return 0;
+
+		print_lockdep_off("BUG: MAX_LOCKDEP_CHAINS too low!");
+		dump_stack();
+		return 0;
+	}
+	chain->chain_key = chain_key;
+	chain->irq_context = hlock->irq_context;
+	i = get_first_held_lock(curr, hlock);
+	chain->depth = curr->lockdep_depth + 1 - i;
+
+	BUILD_BUG_ON((1UL << 24) <= ARRAY_SIZE(chain_hlocks));
+	BUILD_BUG_ON((1UL << 6)  <= ARRAY_SIZE(curr->held_locks));
+	BUILD_BUG_ON((1UL << 8*sizeof(chain_hlocks[0])) <= ARRAY_SIZE(lock_classes));
+
+	j = alloc_chain_hlocks(chain->depth);
+	if (j < 0) {
+		if (!debug_locks_off_graph_unlock())
+			return 0;
+
+		print_lockdep_off("BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!");
+		dump_stack();
+		return 0;
+	}
+
+	chain->base = j;
+	for (j = 0; j < chain->depth - 1; j++, i++) {
+		int lock_id = curr->held_locks[i].class_idx;
+
+		chain_hlocks[chain->base + j] = lock_id;
+	}
+	chain_hlocks[chain->base + j] = class - lock_classes;
+	hlist_add_head_rcu(&chain->entry, hash_head);
+	debug_atomic_inc(chain_lookup_misses);
+	inc_chains(chain->irq_context);
+
+	return 1;
+}
+
+/*
+ * Look up a dependency chain. Must be called with either the graph lock or
+ * the RCU read lock held.
+ */
+static inline struct lock_chain *lookup_chain_cache(u64 chain_key)
+{
+	struct hlist_head *hash_head = chainhashentry(chain_key);
+	struct lock_chain *chain;
+
+	hlist_for_each_entry_rcu(chain, hash_head, entry) {
+		if (READ_ONCE(chain->chain_key) == chain_key) {
+			debug_atomic_inc(chain_lookup_hits);
+			return chain;
+		}
+	}
+	return NULL;
+}
+
+/*
+ * If the key is not present yet in dependency chain cache then
+ * add it and return 1 - in this case the new dependency chain is
+ * validated. If the key is already hashed, return 0.
+ * (On return with 1 graph_lock is held.)
+ */
+static inline int lookup_chain_cache_add(struct task_struct *curr,
+					 struct held_lock *hlock,
+					 u64 chain_key)
+{
+	struct lock_class *class = hlock_class(hlock);
+	struct lock_chain *chain = lookup_chain_cache(chain_key);
+
+	if (chain) {
+cache_hit:
+		if (!check_no_collision(curr, hlock, chain))
+			return 0;
+
+		if (very_verbose(class)) {
+			printk("\nhash chain already cached, key: "
+					"%016Lx tail class: [%px] %s\n",
+					(unsigned long long)chain_key,
+					class->key, class->name);
+		}
+
+		return 0;
+	}
+
+	if (very_verbose(class)) {
+		printk("\nnew hash chain, key: %016Lx tail class: [%px] %s\n",
+			(unsigned long long)chain_key, class->key, class->name);
+	}
+
+	if (!graph_lock())
+		return 0;
+
+	/*
+	 * We have to walk the chain again locked - to avoid duplicates:
+	 */
+	chain = lookup_chain_cache(chain_key);
+	if (chain) {
+		graph_unlock();
+		goto cache_hit;
+	}
+
+	if (!add_chain_cache(curr, hlock, chain_key))
+		return 0;
+
+	return 1;
+}
+
+static int validate_chain(struct task_struct *curr,
+			  struct held_lock *hlock,
+			  int chain_head, u64 chain_key)
+{
+	/*
+	 * Trylock needs to maintain the stack of held locks, but it
+	 * does not add new dependencies, because trylock can be done
+	 * in any order.
+	 *
+	 * We look up the chain_key and do the O(N^2) check and update of
+	 * the dependencies only if this is a new dependency chain.
+	 * (If lookup_chain_cache_add() return with 1 it acquires
+	 * graph_lock for us)
+	 */
+	if (!hlock->trylock && hlock->check &&
+	    lookup_chain_cache_add(curr, hlock, chain_key)) {
+		/*
+		 * Check whether last held lock:
+		 *
+		 * - is irq-safe, if this lock is irq-unsafe
+		 * - is softirq-safe, if this lock is hardirq-unsafe
+		 *
+		 * And check whether the new lock's dependency graph
+		 * could lead back to the previous lock:
+		 *
+		 * - within the current held-lock stack
+		 * - across our accumulated lock dependency records
+		 *
+		 * any of these scenarios could lead to a deadlock.
+		 */
+		/*
+		 * The simple case: does the current hold the same lock
+		 * already?
+		 */
+		int ret = check_deadlock(curr, hlock);
+
+		if (!ret)
+			return 0;
+		/*
+		 * Mark recursive read, as we jump over it when
+		 * building dependencies (just like we jump over
+		 * trylock entries):
+		 */
+		if (ret == 2)
+			hlock->read = 2;
+		/*
+		 * Add dependency only if this lock is not the head
+		 * of the chain, and if it's not a secondary read-lock:
+		 */
+		if (!chain_head && ret != 2) {
+			if (!check_prevs_add(curr, hlock))
+				return 0;
+		}
+
+		graph_unlock();
+	} else {
+		/* after lookup_chain_cache_add(): */
+		if (unlikely(!debug_locks))
+			return 0;
+	}
+
+	return 1;
+}
+
+static int mark_lock(struct task_struct *curr, struct held_lock *this,
+		     enum lock_usage_bit new_bit);
+
+static void print_usage_bug_scenario(struct held_lock *lock)
+{
+	struct lock_class *class = hlock_class(lock);
+
+	printk(" Possible unsafe locking scenario:\n\n");
+	printk("       CPU0\n");
+	printk("       ----\n");
+	printk("  lock(");
+	__print_lock_name(class);
+	printk(KERN_CONT ");\n");
+	printk("  <Interrupt>\n");
+	printk("    lock(");
+	__print_lock_name(class);
+	printk(KERN_CONT ");\n");
+	printk("\n *** DEADLOCK ***\n\n");
+}
+
+static void
+print_usage_bug(struct task_struct *curr, struct held_lock *this,
+		enum lock_usage_bit prev_bit, enum lock_usage_bit new_bit)
+{
+	if (!debug_locks_off_graph_unlock() || debug_locks_silent)
+		return;
+
+	pr_warn("\n");
+	pr_warn("================================\n");
+	pr_warn("WARNING: inconsistent lock state\n");
+	print_kernel_ident();
+	pr_warn("--------------------------------\n");
+
+	pr_warn("inconsistent {%s} -> {%s} usage.\n",
+		usage_str[prev_bit], usage_str[new_bit]);
+
+	pr_warn("%s/%d [HC%u[%lu]:SC%u[%lu]:HE%u:SE%u] takes:\n",
+		curr->comm, task_pid_nr(curr),
+		trace_hardirq_context(curr), hardirq_count() >> HARDIRQ_SHIFT,
+		trace_softirq_context(curr), softirq_count() >> SOFTIRQ_SHIFT,
+		trace_hardirqs_enabled(curr),
+		trace_softirqs_enabled(curr));
+	print_lock(this);
+
+	pr_warn("{%s} state was registered at:\n", usage_str[prev_bit]);
+	print_lock_trace(hlock_class(this)->usage_traces[prev_bit], 1);
+
+	print_irqtrace_events(curr);
+	pr_warn("\nother info that might help us debug this:\n");
+	print_usage_bug_scenario(this);
+
+	lockdep_print_held_locks(curr);
+
+	pr_warn("\nstack backtrace:\n");
+	dump_stack();
+}
+
+/*
+ * Print out an error if an invalid bit is set:
+ */
+static inline int
+valid_state(struct task_struct *curr, struct held_lock *this,
+	    enum lock_usage_bit new_bit, enum lock_usage_bit bad_bit)
+{
+	if (unlikely(hlock_class(this)->usage_mask & (1 << bad_bit))) {
+		print_usage_bug(curr, this, bad_bit, new_bit);
+		return 0;
+	}
+	return 1;
+}
+
+
+/*
+ * print irq inversion bug:
+ */
+static void
+print_irq_inversion_bug(struct task_struct *curr,
+			struct lock_list *root, struct lock_list *other,
+			struct held_lock *this, int forwards,
+			const char *irqclass)
+{
+	struct lock_list *entry = other;
+	struct lock_list *middle = NULL;
+	int depth;
+
+	if (!debug_locks_off_graph_unlock() || debug_locks_silent)
+		return;
+
+	pr_warn("\n");
+	pr_warn("========================================================\n");
+	pr_warn("WARNING: possible irq lock inversion dependency detected\n");
+	print_kernel_ident();
+	pr_warn("--------------------------------------------------------\n");
+	pr_warn("%s/%d just changed the state of lock:\n",
+		curr->comm, task_pid_nr(curr));
+	print_lock(this);
+	if (forwards)
+		pr_warn("but this lock took another, %s-unsafe lock in the past:\n", irqclass);
+	else
+		pr_warn("but this lock was taken by another, %s-safe lock in the past:\n", irqclass);
+	print_lock_name(other->class);
+	pr_warn("\n\nand interrupts could create inverse lock ordering between them.\n\n");
+
+	pr_warn("\nother info that might help us debug this:\n");
+
+	/* Find a middle lock (if one exists) */
+	depth = get_lock_depth(other);
+	do {
+		if (depth == 0 && (entry != root)) {
+			pr_warn("lockdep:%s bad path found in chain graph\n", __func__);
+			break;
+		}
+		middle = entry;
+		entry = get_lock_parent(entry);
+		depth--;
+	} while (entry && entry != root && (depth >= 0));
+	if (forwards)
+		print_irq_lock_scenario(root, other,
+			middle ? middle->class : root->class, other->class);
+	else
+		print_irq_lock_scenario(other, root,
+			middle ? middle->class : other->class, root->class);
+
+	lockdep_print_held_locks(curr);
+
+	pr_warn("\nthe shortest dependencies between 2nd lock and 1st lock:\n");
+	root->trace = save_trace();
+	if (!root->trace)
+		return;
+	print_shortest_lock_dependencies(other, root);
+
+	pr_warn("\nstack backtrace:\n");
+	dump_stack();
+}
+
+/*
+ * Prove that in the forwards-direction subgraph starting at <this>
+ * there is no lock matching <mask>:
+ */
+static int
+check_usage_forwards(struct task_struct *curr, struct held_lock *this,
+		     enum lock_usage_bit bit, const char *irqclass)
+{
+	int ret;
+	struct lock_list root;
+	struct lock_list *uninitialized_var(target_entry);
+
+	root.parent = NULL;
+	root.class = hlock_class(this);
+	ret = find_usage_forwards(&root, lock_flag(bit), &target_entry);
+	if (ret < 0) {
+		print_bfs_bug(ret);
+		return 0;
+	}
+	if (ret == 1)
+		return ret;
+
+	print_irq_inversion_bug(curr, &root, target_entry,
+				this, 1, irqclass);
+	return 0;
+}
+
+/*
+ * Prove that in the backwards-direction subgraph starting at <this>
+ * there is no lock matching <mask>:
+ */
+static int
+check_usage_backwards(struct task_struct *curr, struct held_lock *this,
+		      enum lock_usage_bit bit, const char *irqclass)
+{
+	int ret;
+	struct lock_list root;
+	struct lock_list *uninitialized_var(target_entry);
+
+	root.parent = NULL;
+	root.class = hlock_class(this);
+	ret = find_usage_backwards(&root, lock_flag(bit), &target_entry);
+	if (ret < 0) {
+		print_bfs_bug(ret);
+		return 0;
+	}
+	if (ret == 1)
+		return ret;
+
+	print_irq_inversion_bug(curr, &root, target_entry,
+				this, 0, irqclass);
+	return 0;
+}
+
+void print_irqtrace_events(struct task_struct *curr)
+{
+	printk("irq event stamp: %u\n", curr->irq_events);
+	printk("hardirqs last  enabled at (%u): [<%px>] %pS\n",
+		curr->hardirq_enable_event, (void *)curr->hardirq_enable_ip,
+		(void *)curr->hardirq_enable_ip);
+	printk("hardirqs last disabled at (%u): [<%px>] %pS\n",
+		curr->hardirq_disable_event, (void *)curr->hardirq_disable_ip,
+		(void *)curr->hardirq_disable_ip);
+	printk("softirqs last  enabled at (%u): [<%px>] %pS\n",
+		curr->softirq_enable_event, (void *)curr->softirq_enable_ip,
+		(void *)curr->softirq_enable_ip);
+	printk("softirqs last disabled at (%u): [<%px>] %pS\n",
+		curr->softirq_disable_event, (void *)curr->softirq_disable_ip,
+		(void *)curr->softirq_disable_ip);
+}
+
+static int HARDIRQ_verbose(struct lock_class *class)
+{
+#if HARDIRQ_VERBOSE
+	return class_filter(class);
+#endif
+	return 0;
+}
+
+static int SOFTIRQ_verbose(struct lock_class *class)
+{
+#if SOFTIRQ_VERBOSE
+	return class_filter(class);
+#endif
+	return 0;
+}
+
+#define STRICT_READ_CHECKS	1
+
+static int (*state_verbose_f[])(struct lock_class *class) = {
+#define LOCKDEP_STATE(__STATE) \
+	__STATE##_verbose,
+#include "lockdep_states.h"
+#undef LOCKDEP_STATE
+};
+
+static inline int state_verbose(enum lock_usage_bit bit,
+				struct lock_class *class)
+{
+	return state_verbose_f[bit >> LOCK_USAGE_DIR_MASK](class);
+}
+
+typedef int (*check_usage_f)(struct task_struct *, struct held_lock *,
+			     enum lock_usage_bit bit, const char *name);
+
+static int
+mark_lock_irq(struct task_struct *curr, struct held_lock *this,
+		enum lock_usage_bit new_bit)
+{
+	int excl_bit = exclusive_bit(new_bit);
+	int read = new_bit & LOCK_USAGE_READ_MASK;
+	int dir = new_bit & LOCK_USAGE_DIR_MASK;
+
+	/*
+	 * mark USED_IN has to look forwards -- to ensure no dependency
+	 * has ENABLED state, which would allow recursion deadlocks.
+	 *
+	 * mark ENABLED has to look backwards -- to ensure no dependee
+	 * has USED_IN state, which, again, would allow  recursion deadlocks.
+	 */
+	check_usage_f usage = dir ?
+		check_usage_backwards : check_usage_forwards;
+
+	/*
+	 * Validate that this particular lock does not have conflicting
+	 * usage states.
+	 */
+	if (!valid_state(curr, this, new_bit, excl_bit))
+		return 0;
+
+	/*
+	 * Validate that the lock dependencies don't have conflicting usage
+	 * states.
+	 */
+	if ((!read || STRICT_READ_CHECKS) &&
+			!usage(curr, this, excl_bit, state_name(new_bit & ~LOCK_USAGE_READ_MASK)))
+		return 0;
+
+	/*
+	 * Check for read in write conflicts
+	 */
+	if (!read) {
+		if (!valid_state(curr, this, new_bit, excl_bit + LOCK_USAGE_READ_MASK))
+			return 0;
+
+		if (STRICT_READ_CHECKS &&
+			!usage(curr, this, excl_bit + LOCK_USAGE_READ_MASK,
+				state_name(new_bit + LOCK_USAGE_READ_MASK)))
+			return 0;
+	}
+
+	if (state_verbose(new_bit, hlock_class(this)))
+		return 2;
+
+	return 1;
+}
+
+/*
+ * Mark all held locks with a usage bit:
+ */
+static int
+mark_held_locks(struct task_struct *curr, enum lock_usage_bit base_bit)
+{
+	struct held_lock *hlock;
+	int i;
+
+	for (i = 0; i < curr->lockdep_depth; i++) {
+		enum lock_usage_bit hlock_bit = base_bit;
+		hlock = curr->held_locks + i;
+
+		if (hlock->read)
+			hlock_bit += LOCK_USAGE_READ_MASK;
+
+		BUG_ON(hlock_bit >= LOCK_USAGE_STATES);
+
+		if (!hlock->check)
+			continue;
+
+		if (!mark_lock(curr, hlock, hlock_bit))
+			return 0;
+	}
+
+	return 1;
+}
+
+/*
+ * Hardirqs will be enabled:
+ */
+static void __trace_hardirqs_on_caller(unsigned long ip)
+{
+	struct task_struct *curr = current;
+
+	/* we'll do an OFF -> ON transition: */
+	curr->hardirqs_enabled = 1;
+
+	/*
+	 * We are going to turn hardirqs on, so set the
+	 * usage bit for all held locks:
+	 */
+	if (!mark_held_locks(curr, LOCK_ENABLED_HARDIRQ))
+		return;
+	/*
+	 * If we have softirqs enabled, then set the usage
+	 * bit for all held locks. (disabled hardirqs prevented
+	 * this bit from being set before)
+	 */
+	if (curr->softirqs_enabled)
+		if (!mark_held_locks(curr, LOCK_ENABLED_SOFTIRQ))
+			return;
+
+	curr->hardirq_enable_ip = ip;
+	curr->hardirq_enable_event = ++curr->irq_events;
+	debug_atomic_inc(hardirqs_on_events);
+}
+
+void lockdep_hardirqs_on(unsigned long ip)
+{
+	if (unlikely(!debug_locks || current->lockdep_recursion))
+		return;
+
+	if (unlikely(current->hardirqs_enabled)) {
+		/*
+		 * Neither irq nor preemption are disabled here
+		 * so this is racy by nature but losing one hit
+		 * in a stat is not a big deal.
+		 */
+		__debug_atomic_inc(redundant_hardirqs_on);
+		return;
+	}
+
+	/*
+	 * We're enabling irqs and according to our state above irqs weren't
+	 * already enabled, yet we find the hardware thinks they are in fact
+	 * enabled.. someone messed up their IRQ state tracing.
+	 */
+	if (DEBUG_LOCKS_WARN_ON(!irqs_disabled()))
+		return;
+
+	/*
+	 * See the fine text that goes along with this variable definition.
+	 */
+	if (DEBUG_LOCKS_WARN_ON(early_boot_irqs_disabled))
+		return;
+
+	/*
+	 * Can't allow enabling interrupts while in an interrupt handler,
+	 * that's general bad form and such. Recursion, limited stack etc..
+	 */
+	if (DEBUG_LOCKS_WARN_ON(current->hardirq_context))
+		return;
+
+	current->lockdep_recursion = 1;
+	__trace_hardirqs_on_caller(ip);
+	current->lockdep_recursion = 0;
+}
+NOKPROBE_SYMBOL(lockdep_hardirqs_on);
+
+/*
+ * Hardirqs were disabled:
+ */
+void lockdep_hardirqs_off(unsigned long ip)
+{
+	struct task_struct *curr = current;
+
+	if (unlikely(!debug_locks || current->lockdep_recursion))
+		return;
+
+	/*
+	 * So we're supposed to get called after you mask local IRQs, but for
+	 * some reason the hardware doesn't quite think you did a proper job.
+	 */
+	if (DEBUG_LOCKS_WARN_ON(!irqs_disabled()))
+		return;
+
+	if (curr->hardirqs_enabled) {
+		/*
+		 * We have done an ON -> OFF transition:
+		 */
+		curr->hardirqs_enabled = 0;
+		curr->hardirq_disable_ip = ip;
+		curr->hardirq_disable_event = ++curr->irq_events;
+		debug_atomic_inc(hardirqs_off_events);
+	} else
+		debug_atomic_inc(redundant_hardirqs_off);
+}
+NOKPROBE_SYMBOL(lockdep_hardirqs_off);
+
+/*
+ * Softirqs will be enabled:
+ */
+void trace_softirqs_on(unsigned long ip)
+{
+	struct task_struct *curr = current;
+
+	if (unlikely(!debug_locks || current->lockdep_recursion))
+		return;
+
+	/*
+	 * We fancy IRQs being disabled here, see softirq.c, avoids
+	 * funny state and nesting things.
+	 */
+	if (DEBUG_LOCKS_WARN_ON(!irqs_disabled()))
+		return;
+
+	if (curr->softirqs_enabled) {
+		debug_atomic_inc(redundant_softirqs_on);
+		return;
+	}
+
+	current->lockdep_recursion = 1;
+	/*
+	 * We'll do an OFF -> ON transition:
+	 */
+	curr->softirqs_enabled = 1;
+	curr->softirq_enable_ip = ip;
+	curr->softirq_enable_event = ++curr->irq_events;
+	debug_atomic_inc(softirqs_on_events);
+	/*
+	 * We are going to turn softirqs on, so set the
+	 * usage bit for all held locks, if hardirqs are
+	 * enabled too:
+	 */
+	if (curr->hardirqs_enabled)
+		mark_held_locks(curr, LOCK_ENABLED_SOFTIRQ);
+	current->lockdep_recursion = 0;
+}
+
+/*
+ * Softirqs were disabled:
+ */
+void trace_softirqs_off(unsigned long ip)
+{
+	struct task_struct *curr = current;
+
+	if (unlikely(!debug_locks || current->lockdep_recursion))
+		return;
+
+	/*
+	 * We fancy IRQs being disabled here, see softirq.c
+	 */
+	if (DEBUG_LOCKS_WARN_ON(!irqs_disabled()))
+		return;
+
+	if (curr->softirqs_enabled) {
+		/*
+		 * We have done an ON -> OFF transition:
+		 */
+		curr->softirqs_enabled = 0;
+		curr->softirq_disable_ip = ip;
+		curr->softirq_disable_event = ++curr->irq_events;
+		debug_atomic_inc(softirqs_off_events);
+		/*
+		 * Whoops, we wanted softirqs off, so why aren't they?
+		 */
+		DEBUG_LOCKS_WARN_ON(!softirq_count());
+	} else
+		debug_atomic_inc(redundant_softirqs_off);
+}
+
+static int
+mark_usage(struct task_struct *curr, struct held_lock *hlock, int check)
+{
+	if (!check)
+		goto lock_used;
+
+	/*
+	 * If non-trylock use in a hardirq or softirq context, then
+	 * mark the lock as used in these contexts:
+	 */
+	if (!hlock->trylock) {
+		if (hlock->read) {
+			if (curr->hardirq_context)
+				if (!mark_lock(curr, hlock,
+						LOCK_USED_IN_HARDIRQ_READ))
+					return 0;
+			if (curr->softirq_context)
+				if (!mark_lock(curr, hlock,
+						LOCK_USED_IN_SOFTIRQ_READ))
+					return 0;
+		} else {
+			if (curr->hardirq_context)
+				if (!mark_lock(curr, hlock, LOCK_USED_IN_HARDIRQ))
+					return 0;
+			if (curr->softirq_context)
+				if (!mark_lock(curr, hlock, LOCK_USED_IN_SOFTIRQ))
+					return 0;
+		}
+	}
+	if (!hlock->hardirqs_off) {
+		if (hlock->read) {
+			if (!mark_lock(curr, hlock,
+					LOCK_ENABLED_HARDIRQ_READ))
+				return 0;
+			if (curr->softirqs_enabled)
+				if (!mark_lock(curr, hlock,
+						LOCK_ENABLED_SOFTIRQ_READ))
+					return 0;
+		} else {
+			if (!mark_lock(curr, hlock,
+					LOCK_ENABLED_HARDIRQ))
+				return 0;
+			if (curr->softirqs_enabled)
+				if (!mark_lock(curr, hlock,
+						LOCK_ENABLED_SOFTIRQ))
+					return 0;
+		}
+	}
+
+lock_used:
+	/* mark it as used: */
+	if (!mark_lock(curr, hlock, LOCK_USED))
+		return 0;
+
+	return 1;
+}
+
+static inline unsigned int task_irq_context(struct task_struct *task)
+{
+	return LOCK_CHAIN_HARDIRQ_CONTEXT * !!task->hardirq_context +
+	       LOCK_CHAIN_SOFTIRQ_CONTEXT * !!task->softirq_context;
+}
+
+static int separate_irq_context(struct task_struct *curr,
+		struct held_lock *hlock)
+{
+	unsigned int depth = curr->lockdep_depth;
+
+	/*
+	 * Keep track of points where we cross into an interrupt context:
+	 */
+	if (depth) {
+		struct held_lock *prev_hlock;
+
+		prev_hlock = curr->held_locks + depth-1;
+		/*
+		 * If we cross into another context, reset the
+		 * hash key (this also prevents the checking and the
+		 * adding of the dependency to 'prev'):
+		 */
+		if (prev_hlock->irq_context != hlock->irq_context)
+			return 1;
+	}
+	return 0;
+}
+
+/*
+ * Mark a lock with a usage bit, and validate the state transition:
+ */
+static int mark_lock(struct task_struct *curr, struct held_lock *this,
+			     enum lock_usage_bit new_bit)
+{
+	unsigned int new_mask = 1 << new_bit, ret = 1;
+
+	if (new_bit >= LOCK_USAGE_STATES) {
+		DEBUG_LOCKS_WARN_ON(1);
+		return 0;
+	}
+
+	/*
+	 * If already set then do not dirty the cacheline,
+	 * nor do any checks:
+	 */
+	if (likely(hlock_class(this)->usage_mask & new_mask))
+		return 1;
+
+	if (!graph_lock())
+		return 0;
+	/*
+	 * Make sure we didn't race:
+	 */
+	if (unlikely(hlock_class(this)->usage_mask & new_mask)) {
+		graph_unlock();
+		return 1;
+	}
+
+	hlock_class(this)->usage_mask |= new_mask;
+
+	if (!(hlock_class(this)->usage_traces[new_bit] = save_trace()))
+		return 0;
+
+	switch (new_bit) {
+	case LOCK_USED:
+		debug_atomic_dec(nr_unused_locks);
+		break;
+	default:
+		ret = mark_lock_irq(curr, this, new_bit);
+		if (!ret)
+			return 0;
+	}
+
+	graph_unlock();
+
+	/*
+	 * We must printk outside of the graph_lock:
+	 */
+	if (ret == 2) {
+		printk("\nmarked lock as {%s}:\n", usage_str[new_bit]);
+		print_lock(this);
+		print_irqtrace_events(curr);
+		dump_stack();
+	}
+
+	return ret;
+}
+
+/* Remove a class from a lock chain. Must be called with the graph lock held. */
+static void remove_class_from_lock_chain(struct pending_free *pf,
+					 struct lock_chain *chain,
+					 struct lock_class *class)
+{
+	int i;
+
+	for (i = chain->base; i < chain->base + chain->depth; i++) {
+		if (chain_hlocks[i] != class - lock_classes)
+			continue;
+		/*
+		 * Each lock class occurs at most once in a lock chain so once
+		 * we found a match we can break out of this loop.
+		 */
+		goto free_lock_chain;
+	}
+	/* Since the chain has not been modified, return. */
+	return;
+
+free_lock_chain:
+	free_chain_hlocks(chain->base, chain->depth);
+	/* Overwrite the chain key for concurrent RCU readers. */
+	WRITE_ONCE(chain->chain_key, INITIAL_CHAIN_KEY);
+	dec_chains(chain->irq_context);
+
+	/*
+	 * Note: calling hlist_del_rcu() from inside a
+	 * hlist_for_each_entry_rcu() loop is safe.
+	 */
+	hlist_del_rcu(&chain->entry);
+	__set_bit(chain - lock_chains, pf->lock_chains_being_freed);
+	nr_zapped_lock_chains++;
+}
+
+/* Must be called with the graph lock held. */
+static void remove_class_from_lock_chains(struct pending_free *pf,
+					  struct lock_class *class)
+{
+	struct lock_chain *chain;
+	struct hlist_head *head;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(chainhash_table); i++) {
+		head = chainhash_table + i;
+		hlist_for_each_entry_rcu(chain, head, entry) {
+			remove_class_from_lock_chain(pf, chain, class);
+		}
+	}
+}
-- 
2.18.1

