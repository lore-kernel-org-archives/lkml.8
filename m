Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3910BC32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 21:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E916A24679
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 21:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hfbgY1Gm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730276AbgAOVn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 16:43:56 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57970 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730126AbgAOVnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 16:43:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579124621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=5ZzAI/432JqCpKLXhkN7jy67Ny2diOYIeZ7QMEWZxHI=;
        b=hfbgY1GmJQWSBQvUGSdAeCbgFfjKvC2nAcgbVjnuAhEM81hkStOQOrEWuNzxMk7uPfdxvK
        nnm+nvpgki737/9FZNxIkIkZ83NrcCIxZfMjDWQenclIVJFqzwh0oJEVzRxgOt2dhcJBYb
        DxxmLvUkiBN5Y/nCC7zq0+Yjy62CvxY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-IivoFpUDMC6suouA6sOZIg-1; Wed, 15 Jan 2020 16:43:37 -0500
X-MC-Unique: IivoFpUDMC6suouA6sOZIg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3CF1800A02;
        Wed, 15 Jan 2020 21:43:35 +0000 (UTC)
Received: from llong.com (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4CB915C290;
        Wed, 15 Jan 2020 21:43:35 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v3 6/8] locking/lockdep: Reuse freed chain_hlocks entries
Date:   Wed, 15 Jan 2020 16:43:11 -0500
Message-Id: <20200115214313.13253-7-longman@redhat.com>
In-Reply-To: <20200115214313.13253-1-longman@redhat.com>
References: <20200115214313.13253-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once a lock class is zapped, all the lock chains that include the zapped
class are essentially useless. The lock_chain structure itself can be
reused, but not the corresponding chain_hlocks[] entries. Over time,
we will run out of chain_hlocks entries while there are still plenty
of other lockdep array entries available.

To fix this imbalance, we have to make chain_hlocks entries reusable
just like the others. As the freed chain_hlocks entries are in blocks of
various lengths. A simple bitmap like the one used in the other reusable
lockdep arrays isn't applicable. Instead the freed chain_hlocks entries
are formed into a chain block and put into a free bucketed list according
to the block size. On allocation, the corresponding chain block bucket
is searched first before allocating directly from the chain_hlocks array.

By reusing the chain_hlocks entries, we are able to handle workloads
that add and zap a lot of lock classes without the risk of overflowing
the chain_hlocks array as long as the total number of outstanding lock
classes at any time remain within a reasonable limit.

Two new tracking counters, nr_free_chain_hlocks & nr_large_chain_blocks,
are added to track the total number of chain_hlocks entries in the
free bucketed lists and the number of large chain blocks in buckets[0]
respectively.

The nr_free_chain_hlocks counters enables us to see how efficient the
current workload is able to reuse the freed chain_hlocks entries in
the bucketed lists. The nr_large_chain_blocks counter enables to see if
we should increase the number of buckets (MAX_CHAIN_BUCKETS) available
as linear search is used to find a matching chain block which is much
slower than the O(1) time to find a chain block with size not bigger
than MAX_CHAIN_BUCKETS.

An internal nfsd test that ran for more than an hour and kept on
loading and unloading kernel modules could cause the following message
to be displayed.

  [ 4318.443670] BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!

The patched kernel was able to complete the test with a lot of
chain_hlocks entries to spare:

  # cat /proc/lockdep_stats
     :
   dependency chains:                   24861 [max: 65536]
   dependency chain hlocks:            102232 [max: 327680]
     :
   zapped classes:                       1538
   zapped lock chains:                  57077
   free chain hlocks:                     335
   large chain blocks:                      0

By modifying MAX_CHAIN_BUCKETS to 3 in order to exercise the large
chain blocks allocation and freeing code paths, the stats were:

  # cat /proc/lockdep_stats
     :
   dependency chains:                   24561 [max: 65536]
   dependency chain hlocks:            103098 [max: 327680]
     :
   zapped classes:                       1544
   zapped lock chains:                  57067
   free chain hlocks:                     383
   large chain blocks:                     64

By monitoring the output of lockdep_stats, the number of free
chain hlocks and large chain blocks grew and shrank (sometimes to 0)
repetitively as the test was progressing. There was no movement in the
large chain blocks count with a MAX_CHAIN_BUCKETS value of 10.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/lockdep.c           | 231 ++++++++++++++++++++++++++---
 kernel/locking/lockdep_internals.h |   2 +
 kernel/locking/lockdep_proc.c      |   4 +
 3 files changed, 218 insertions(+), 19 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 10471167b5f7..a1d839e522a9 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2639,6 +2639,207 @@ static DECLARE_BITMAP(lock_chains_in_use, MAX_LOCKDEP_CHAINS);
 static u16 chain_hlocks[MAX_LOCKDEP_CHAIN_HLOCKS];
 unsigned long nr_zapped_lock_chains;
 unsigned int nr_chain_hlocks;
+unsigned int nr_free_chain_hlocks;	/* Free cfhain_hlocks in buckets */
+unsigned int nr_large_chain_blocks;	/* size > MAX_CHAIN_BUCKETS */
+
+#ifdef CONFIG_PROVE_LOCKING
+/*
+ * As chain_hlocks entries are allocated and freed, the freed entries are
+ * grouped into chain blocks that can be reused again. These chain blocks
+ * are put into a bucketed list according to their block size.
+ *
+ * Two APIs are provided for chain block allocation and freeing:
+ *  - int alloc_chain_hlocks(int size)
+ *  - void free_chain_hlocks(int base, int size)
+ *
+ * A minimum allocation size of 2 entries is enforced. When a lock chain
+ * is freed, the corresponding chain_hlocks[] entries are put into one
+ * of the bucketed lists:
+ *   2 <= size <= MAX_CHAIN_BUCKETS => buckets[size-1]
+ *   > MAX_CHAIN_BUCKETS	    => buckets[0]
+ *
+ * When an allocation request is made, alloc_chain_hlocks() will first
+ * look up the matching bucketed list to find a free chain block. If not
+ * found, allocation will be made directly from the chain_hlocks array
+ * from the current nr_chain_hlocks value.
+ *
+ * Note that a chain_hlocks entry contain the class index which is
+ * crrently limited to 13 bits.
+ *
+ * The first 2 chain_hlocks entries in the chain block in the bucket
+ * list contains the following meta data:
+ * entry[0]:
+ *   Bit    15 - always set to 1 (it is not a class index)
+ *   Bits 0-14 - upper 15 bits of the next block index
+ * entry[1]    - lower 16 bits of next block index
+ *
+ * A next block index of all 1 bits means it is the end of the list.
+ *
+ * On the unsized bucket (buckets[0]), the 3rd and 4th entries contain
+ * the chain block size.
+ *
+ * entry[2] - upper 16 bits of the chain block size
+ * entry[3] - lower 16 bits of the chain block size
+ */
+#define MAX_CHAIN_BUCKETS	10
+#define CHAIN_BLK_FLAG		(1U << 15)
+#define CHAIN_BLK_LIST_END	((u16)-1)
+
+/*
+ * An empty bucket has a value of -1. Otherwise, it represents an offset
+ * to the chain_hlocks array.
+ */
+static int chain_block_buckets[MAX_CHAIN_BUCKETS];
+
+/*
+ * Iterate all the chain blocks in a bucket.
+ * The loop body has to set the next parameter.
+ */
+#define for_each_chain_block(bucket, prev, curr, next)		\
+	for ((prev) = -1, (curr) = chain_block_buckets[bucket];	\
+	     (curr) >= 0;					\
+	     (prev) = (curr), (curr) = (next))
+
+static inline void init_chain_block_buckets(void)
+{
+	int i;
+
+	for (i = 0; i < MAX_CHAIN_BUCKETS; i++)
+		chain_block_buckets[i] = -1;
+}
+
+/*
+ * Return offset of next chain block or -1 if end of list.
+ */
+static inline int next_chain_block(int offset)
+{
+	if (chain_hlocks[offset] == CHAIN_BLK_LIST_END)
+		return -1;
+	return ((chain_hlocks[offset] & ~CHAIN_BLK_FLAG) << 16) |
+		 chain_hlocks[offset + 1];
+}
+
+static inline void set_chain_block(int offset, int size, int next)
+{
+	if (unlikely(offset < 0)) {
+		chain_block_buckets[0] = next;
+		return;
+	}
+	chain_hlocks[offset] = (next >> 16) | CHAIN_BLK_FLAG;
+	chain_hlocks[offset + 1] = (u16)next;
+	if (size > MAX_CHAIN_BUCKETS) {
+		chain_hlocks[offset + 2] = size >> 16;
+		chain_hlocks[offset + 3] = (u16)size;
+	}
+}
+
+/*
+ * This function should only be called for chain block in buckets[0].
+ */
+static inline int chain_block_size(int offset)
+{
+	return (chain_hlocks[offset + 2] << 16) | chain_hlocks[offset + 3];
+}
+
+/*
+ * Return offset of a chain block of the right size or -1 if not found.
+ */
+static inline int alloc_chain_hlocks_from_buckets(int size)
+{
+	int prev, curr, next;
+
+	if (!nr_free_chain_hlocks)
+		return -1;
+
+	if (size <= MAX_CHAIN_BUCKETS) {
+		curr = chain_block_buckets[size - 1];
+		if (curr < 0)
+			return -1;
+
+		chain_block_buckets[size - 1] = next_chain_block(curr);
+		nr_free_chain_hlocks -= size;
+		return curr;
+	}
+
+	/*
+	 * Look for a free chain block of the given size
+	 *
+	 * It is rare to have a lock chain with depth > MAX_CHAIN_BUCKETS.
+	 * It is also more expensive as we may iterate the whole list
+	 * without finding one.
+	 */
+	for_each_chain_block(0, prev, curr, next) {
+		next = next_chain_block(curr);
+		if (chain_block_size(curr) == size) {
+			set_chain_block(prev, 0, next);
+			nr_free_chain_hlocks -= size;
+			nr_large_chain_blocks--;
+			return curr;
+		}
+	}
+	return -1;
+}
+
+static inline void free_chain_hlocks(int base, int size)
+{
+	if (size < 2)
+		size = 2;
+
+	nr_free_chain_hlocks += size;
+	if (size <= MAX_CHAIN_BUCKETS) {
+		set_chain_block(base, 0, chain_block_buckets[size - 1]);
+		chain_block_buckets[size - 1] = base;
+		return;
+	}
+	set_chain_block(base, size, chain_block_buckets[0]);
+	chain_block_buckets[0] = base;
+	nr_large_chain_blocks++;
+}
+#else
+static inline void init_chain_block_buckets(void)	{ }
+static inline int  alloc_chain_hlocks_from_buckets(int size)
+{
+	return -1;
+}
+#endif /* CONFIG_PROVE_LOCKING */
+
+/*
+ * The graph lock must be held before calling this function.
+ *
+ * Return: an offset to chain_hlocks if successful, or
+ *	   -1 with graph lock released
+ */
+static int alloc_chain_hlocks(int size)
+{
+	int curr;
+
+	if (size < 2)
+		size = 2;
+
+	curr = alloc_chain_hlocks_from_buckets(size);
+	if (curr >= 0)
+		return curr;
+
+	BUILD_BUG_ON((1UL << 24) <= ARRAY_SIZE(chain_hlocks));
+	BUILD_BUG_ON((1UL << 6)  <= ARRAY_SIZE(current->held_locks));
+	BUILD_BUG_ON((1UL << 8*sizeof(chain_hlocks[0])) <=
+		     ARRAY_SIZE(lock_classes));
+
+	/*
+	 * Allocate directly from chain_hlocks.
+	 */
+	if (likely(nr_chain_hlocks + size <= MAX_LOCKDEP_CHAIN_HLOCKS)) {
+		curr = nr_chain_hlocks;
+		nr_chain_hlocks += size;
+		return curr;
+	}
+	if (!debug_locks_off_graph_unlock())
+		return -1;
+
+	print_lockdep_off("BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!");
+	dump_stack();
+	return -1;
+}
 
 struct lock_class *lock_chain_get_class(struct lock_chain *chain, int i)
 {
@@ -2834,28 +3035,17 @@ static inline int add_chain_cache(struct task_struct *curr,
 	chain->irq_context = hlock->irq_context;
 	i = get_first_held_lock(curr, hlock);
 	chain->depth = curr->lockdep_depth + 1 - i;
+	j = alloc_chain_hlocks(chain->depth);
+	if (j < 0)
+		return 0;
 
-	BUILD_BUG_ON((1UL << 24) <= ARRAY_SIZE(chain_hlocks));
-	BUILD_BUG_ON((1UL << 6)  <= ARRAY_SIZE(curr->held_locks));
-	BUILD_BUG_ON((1UL << 8*sizeof(chain_hlocks[0])) <= ARRAY_SIZE(lock_classes));
-
-	if (likely(nr_chain_hlocks + chain->depth <= MAX_LOCKDEP_CHAIN_HLOCKS)) {
-		chain->base = nr_chain_hlocks;
-		for (j = 0; j < chain->depth - 1; j++, i++) {
-			int lock_id = curr->held_locks[i].class_idx;
-			chain_hlocks[chain->base + j] = lock_id;
-		}
-		chain_hlocks[chain->base + j] = class - lock_classes;
-		nr_chain_hlocks += chain->depth;
-	} else {
-		if (!debug_locks_off_graph_unlock())
-			return 0;
+	chain->base = j;
+	for (j = 0; j < chain->depth - 1; j++, i++) {
+		int lock_id = curr->held_locks[i].class_idx;
 
-		print_lockdep_off("BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!");
-		dump_stack();
-		return 0;
+		chain_hlocks[chain->base + j] = lock_id;
 	}
-
+	chain_hlocks[chain->base + j] = class - lock_classes;
 	hlist_add_head_rcu(&chain->entry, hash_head);
 	debug_atomic_inc(chain_lookup_misses);
 	inc_chains(chain->irq_context);
@@ -4799,6 +4989,7 @@ static void remove_class_from_lock_chain(struct pending_free *pf,
 	return;
 
 free_lock_chain:
+	free_chain_hlocks(chain->base, chain->depth);
 	/* Overwrite the chain key for concurrent RCU readers. */
 	WRITE_ONCE(chain->chain_key, INITIAL_CHAIN_KEY);
 	dec_chains(chain->irq_context);
@@ -5193,6 +5384,8 @@ EXPORT_SYMBOL_GPL(lockdep_unregister_key);
 
 void __init lockdep_init(void)
 {
+	init_chain_block_buckets();
+
 	printk("Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar\n");
 
 	printk("... MAX_LOCKDEP_SUBCLASSES:  %lu\n", MAX_LOCKDEP_SUBCLASSES);
diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index b013250f2ca1..9425155b9053 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -141,6 +141,8 @@ extern unsigned int nr_hardirq_chains;
 extern unsigned int nr_softirq_chains;
 extern unsigned int nr_process_chains;
 extern unsigned int nr_chain_hlocks;
+extern unsigned int nr_free_chain_hlocks;
+extern unsigned int nr_large_chain_blocks;
 
 extern unsigned int max_lockdep_depth;
 extern unsigned int max_bfs_queue_depth;
diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
index df1b97912871..9b3d2976bd5a 100644
--- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -351,6 +351,10 @@ static int lockdep_stats_show(struct seq_file *m, void *v)
 			nr_zapped_classes);
 	seq_printf(m, " zapped lock chains:            %11lu\n",
 			nr_zapped_lock_chains);
+	seq_printf(m, " free chain hlocks:             %11u\n",
+			nr_free_chain_hlocks);
+	seq_printf(m, " large chain blocks:            %11u\n",
+			nr_large_chain_blocks);
 	return 0;
 }
 
-- 
2.18.1

