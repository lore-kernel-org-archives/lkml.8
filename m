Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B415C3524D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C22E2087E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gVCE5X8t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730734AbgBCQmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:42:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31168 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731267AbgBCQmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:42:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580748132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=erp1FJa+7UPATkXrk6wBZd09AjmxWx51HQyFj0R5+HY=;
        b=gVCE5X8tCDqlouO3jNeNHOd499LLS3RsyW452l50y1+ELcjge9mToCFoSdujI768I6Scbw
        rSBwj5YwoMqxFLLO/2siRoKrSmGcDMn3mWYbJ0vt29llKmhMnlKQWos2wa/nKJThcX/Ry3
        hpPgfr5WXRdSuiy2ruK3WoDMwP4d6uI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-efdFHIYVMg6Y5_2ZsmIrhQ-1; Mon, 03 Feb 2020 11:42:05 -0500
X-MC-Unique: efdFHIYVMg6Y5_2ZsmIrhQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3BBE21800D41;
        Mon,  3 Feb 2020 16:42:04 +0000 (UTC)
Received: from llong.com (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 847D710013A7;
        Mon,  3 Feb 2020 16:42:03 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v5 6/7] locking/lockdep: Reuse freed chain_hlocks entries
Date:   Mon,  3 Feb 2020 11:41:46 -0500
Message-Id: <20200203164147.17990-7-longman@redhat.com>
In-Reply-To: <20200203164147.17990-1-longman@redhat.com>
References: <20200203164147.17990-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
just like the others. As the freed chain_hlocks entries are in blocks
of various lengths. A simple bitmap like the one used in the other
reusable lockdep arrays isn't applicable. Instead the chain_hlocks
entries are put into bucketed lists (MAX_CHAIN_BUCKETS) of chain blocks.
Bucket 0 is the dump bucket which houses chain blocks of size larger
than MAX_CHAIN_BUCKETS.  Initially, the whole array is in one chain
block in bucket 0.

Allocation requests for the chain_hlocks are fulfilled first by looking
for chain block of matching size. If not found, a larger chain block
is split.  As the minimum size of a chain block is 2 chain_hlocks[]
entries. That will be the minimum allocation size. In other word,
allocation requests for one chain_hlocks[] entry will cause 2-entry block
to be returned and hence 1 entry will be wasted. When the chain_hlocks[]
array is nearly full or highly fragmented, there is a slight chance
that 1-entry fragment will be created during the chain block splitting
process. Those 1-entry fragments will be discarded and hence leaked.

By reusing the chain_hlocks entries, we are able to handle workloads
that add and zap a lot of lock classes without the risk of overflowing
the chain_hlocks array as long as the total number of outstanding lock
classes at any time remain within a reasonable limit.

Two new tracking counters, nr_free_chain_hlocks & nr_large_chain_blocks,
are added to track the total number of chain_hlocks entries in the
free bucketed lists and the number of large chain blocks in buckets[0]
respectively. The nr_free_chain_hlocks replaces nr_chain_hlocks.

The nr_large_chain_blocks counter enables to see if we should increase
the number of buckets (MAX_CHAIN_BUCKETS) available as linear search is
used to find a matching chain block which is much slower than the O(1)
time to find a chain block with size not bigger than MAX_CHAIN_BUCKETS.

An internal nfsd test that ran for more than an hour and kept on
loading and unloading kernel modules could cause the following message
to be displayed.

  [ 4318.443670] BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!

The patched kernel was able to complete the test with a lot of
chain_hlocks entries to spare:

  # cat /proc/lockdep_stats
     :
   dependency chains:                   26723 [max: 65536]
   dependency chain hlocks:            115052 [max: 327680]
     :
   zapped classes:                       1538
   zapped lock chains:                  56990
   large chain blocks:                      0

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/lockdep.c           | 242 +++++++++++++++++++++++++++--
 kernel/locking/lockdep_internals.h |   3 +-
 kernel/locking/lockdep_proc.c      |   9 +-
 3 files changed, 239 insertions(+), 15 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index a63976c75253..70288bb2331d 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1071,13 +1071,15 @@ static inline void check_data_structures(void) { }
 
 #endif /* CONFIG_DEBUG_LOCKDEP */
 
+static void init_chain_block_buckets(void);
+
 /*
  * Initialize the lock_classes[] array elements, the free_lock_classes list
  * and also the delayed_free structure.
  */
 static void init_data_structures_once(void)
 {
-	static bool ds_initialized, rcu_head_initialized;
+	static bool __read_mostly ds_initialized, rcu_head_initialized;
 	int i;
 
 	if (likely(rcu_head_initialized))
@@ -1101,6 +1103,7 @@ static void init_data_structures_once(void)
 		INIT_LIST_HEAD(&lock_classes[i].locks_after);
 		INIT_LIST_HEAD(&lock_classes[i].locks_before);
 	}
+	init_chain_block_buckets();
 }
 
 static inline struct hlist_head *keyhashentry(const struct lock_class_key *key)
@@ -2627,7 +2630,221 @@ struct lock_chain lock_chains[MAX_LOCKDEP_CHAINS];
 static DECLARE_BITMAP(lock_chains_in_use, MAX_LOCKDEP_CHAINS);
 static u16 chain_hlocks[MAX_LOCKDEP_CHAIN_HLOCKS];
 unsigned long nr_zapped_lock_chains;
-unsigned int nr_chain_hlocks;
+unsigned int nr_free_chain_hlocks;	/* Free cfhain_hlocks in buckets */
+unsigned int nr_large_chain_blocks;	/* size > MAX_CHAIN_BUCKETS */
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
+#define MAX_CHAIN_BUCKETS	10
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
+ * The loop body has to set the next parameter.
+ */
+#define for_each_chain_block(bucket, prev, curr, next)		\
+	for ((prev) = bucket - MAX_CHAIN_BUCKETS,		\
+	     (curr) = chain_block_buckets[bucket];		\
+	     (curr) >= 0;					\
+	     (prev) = (curr), (curr) = (next))
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
+	if (bucket == 0) {
+		chain_hlocks[offset + 2] = size >> 16;
+		chain_hlocks[offset + 3] = (u16)size;
+	}
+}
+
+static inline void add_chain_block(int offset, int size)
+{
+	int bucket = size_to_bucket(size);
+	int next = chain_block_buckets[bucket];
+
+	if (unlikely(size < 2))
+		return; // XXX leak!
+
+	init_chain_block(offset, next, bucket, size);
+	chain_block_buckets[bucket] = offset;
+	nr_free_chain_hlocks += size;
+
+	if (bucket == 0)
+		nr_large_chain_blocks++;
+}
+
+/*
+ * When offset < 0, the bucket number is encoded in it.
+ */
+static inline void del_chain_block(int offset, int size, int next)
+{
+	int bucket = size_to_bucket(size);
+
+	nr_free_chain_hlocks -= size;
+	if (offset < 0)
+		chain_block_buckets[offset + MAX_CHAIN_BUCKETS] = next;
+	else
+		init_chain_block(offset, next, bucket, size);
+
+	if (bucket == 0)
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
+	int max_prev, max_curr, max_next, max_size = INT_MIN;
+	int prev, curr, next, size;
+	int bucket;
+
+	/*
+	 * We rely on the MSB to act as an escape bit to denote freelist
+	 * pointers. Make sure this bit isn't set in 'normal' class_idx usage.
+	 */
+	BUILD_BUG_ON((MAX_LOCKDEP_KEYS-1) & CHAIN_BLK_FLAG);
+
+	init_data_structures_once();
+
+	if (!nr_free_chain_hlocks)
+		return -1;
+
+	/*
+	 * We require a minimum of 2 (u16) entries to encode a freelist
+	 * 'pointer'.
+	 */
+	req = max(req, 2);
+	bucket = size_to_bucket(req);
+
+	if (bucket != 0) {
+		curr = chain_block_buckets[bucket];
+		if (curr < 0)
+			goto search;
+
+		del_chain_block(bucket - MAX_CHAIN_BUCKETS, req,
+				chain_block_next(curr));
+		return curr;
+	}
+
+search:
+	/*
+	 * linear search in the 'dump' bucket; look for an exact match or the
+	 * largest block.
+	 */
+	for_each_chain_block(0, prev, curr, next) {
+		size = chain_block_size(curr);
+		next = chain_block_next(curr);
+
+		if (size == req) {
+			del_chain_block(prev, req, next);
+			return curr;
+		}
+
+		if (size > max_size) {
+			max_prev = prev;
+			max_curr = curr;
+			max_next = next;
+			max_size = size;
+		}
+	}
+
+	if (likely(max_size > req)) {
+		del_chain_block(max_prev, max_size, max_next);
+		add_chain_block(max_curr + req, max_size - req);
+		return max_curr;
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
+		del_chain_block(bucket - MAX_CHAIN_BUCKETS, size,
+				chain_block_next(curr));
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
 
 struct lock_class *lock_chain_get_class(struct lock_chain *chain, int i)
 {
@@ -2828,15 +3045,8 @@ static inline int add_chain_cache(struct task_struct *curr,
 	BUILD_BUG_ON((1UL << 6)  <= ARRAY_SIZE(curr->held_locks));
 	BUILD_BUG_ON((1UL << 8*sizeof(chain_hlocks[0])) <= ARRAY_SIZE(lock_classes));
 
-	if (likely(nr_chain_hlocks + chain->depth <= MAX_LOCKDEP_CHAIN_HLOCKS)) {
-		chain->base = nr_chain_hlocks;
-		for (j = 0; j < chain->depth - 1; j++, i++) {
-			int lock_id = curr->held_locks[i].class_idx;
-			chain_hlocks[chain->base + j] = lock_id;
-		}
-		chain_hlocks[chain->base + j] = class - lock_classes;
-		nr_chain_hlocks += chain->depth;
-	} else {
+	j = alloc_chain_hlocks(chain->depth);
+	if (j < 0) {
 		if (!debug_locks_off_graph_unlock())
 			return 0;
 
@@ -2845,6 +3055,13 @@ static inline int add_chain_cache(struct task_struct *curr,
 		return 0;
 	}
 
+	chain->base = j;
+	for (j = 0; j < chain->depth - 1; j++, i++) {
+		int lock_id = curr->held_locks[i].class_idx;
+
+		chain_hlocks[chain->base + j] = lock_id;
+	}
+	chain_hlocks[chain->base + j] = class - lock_classes;
 	hlist_add_head_rcu(&chain->entry, hash_head);
 	debug_atomic_inc(chain_lookup_misses);
 	inc_chains(chain->irq_context);
@@ -2991,6 +3208,8 @@ static inline int validate_chain(struct task_struct *curr,
 {
 	return 1;
 }
+
+static void init_chain_block_buckets(void)	{ }
 #endif /* CONFIG_PROVE_LOCKING */
 
 /*
@@ -4788,6 +5007,7 @@ static void remove_class_from_lock_chain(struct pending_free *pf,
 	return;
 
 free_lock_chain:
+	free_chain_hlocks(chain->base, chain->depth);
 	/* Overwrite the chain key for concurrent RCU readers. */
 	WRITE_ONCE(chain->chain_key, INITIAL_CHAIN_KEY);
 	dec_chains(chain->irq_context);
diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index af722ceeda33..5040e6729c05 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -140,7 +140,8 @@ extern unsigned long nr_stack_trace_entries;
 extern unsigned int nr_hardirq_chains;
 extern unsigned int nr_softirq_chains;
 extern unsigned int nr_process_chains;
-extern unsigned int nr_chain_hlocks;
+extern unsigned int nr_free_chain_hlocks;
+extern unsigned int nr_large_chain_blocks;
 
 extern unsigned int max_lockdep_depth;
 extern unsigned int max_bfs_queue_depth;
diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
index 92fe0742453c..14932ea50317 100644
--- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -137,7 +137,7 @@ static int lc_show(struct seq_file *m, void *v)
 	};
 
 	if (v == SEQ_START_TOKEN) {
-		if (nr_chain_hlocks > MAX_LOCKDEP_CHAIN_HLOCKS)
+		if (!nr_free_chain_hlocks)
 			seq_printf(m, "(buggered) ");
 		seq_printf(m, "all lock chains:\n");
 		return 0;
@@ -278,8 +278,9 @@ static int lockdep_stats_show(struct seq_file *m, void *v)
 #ifdef CONFIG_PROVE_LOCKING
 	seq_printf(m, " dependency chains:             %11lu [max: %lu]\n",
 			lock_chain_count(), MAX_LOCKDEP_CHAINS);
-	seq_printf(m, " dependency chain hlocks:       %11u [max: %lu]\n",
-			nr_chain_hlocks, MAX_LOCKDEP_CHAIN_HLOCKS);
+	seq_printf(m, " dependency chain hlocks:       %11lu [max: %lu]\n",
+			MAX_LOCKDEP_CHAIN_HLOCKS - nr_free_chain_hlocks,
+			MAX_LOCKDEP_CHAIN_HLOCKS);
 #endif
 
 #ifdef CONFIG_TRACE_IRQFLAGS
@@ -352,6 +353,8 @@ static int lockdep_stats_show(struct seq_file *m, void *v)
 #ifdef CONFIG_PROVE_LOCKING
 	seq_printf(m, " zapped lock chains:            %11lu\n",
 			nr_zapped_lock_chains);
+	seq_printf(m, " large chain blocks:            %11u\n",
+			nr_large_chain_blocks);
 #endif
 	return 0;
 }
-- 
2.18.1

