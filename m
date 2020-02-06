Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58E4C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 15:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97AC2222C2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 15:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IIBCtXL7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbgBFPYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 10:24:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24218 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727737AbgBFPYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 10:24:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581002671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=zZaG8fuVtwr8v8tKABmn3u7yKCy6hLAfWVM7h+uPcJM=;
        b=IIBCtXL7F8CiWbAueZw4fGg20l6XxOTardEQ8JTUQU5ezscUvo+tW/K1h2XcSN1XHHRe8F
        bgjvIpD7AUlOmbJ89Xq9t0aPRXZKS8Ej3+Drr4hRDr1vk/mNsbCBrL1nGLdjuOJG6n3iZz
        MY5/sjFyGpnxGLfRPhOyn92ghKtvi/I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-AyUR80EHMrSsFSBRM1uDFg-1; Thu, 06 Feb 2020 10:24:29 -0500
X-MC-Unique: AyUR80EHMrSsFSBRM1uDFg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7996F142FDA;
        Thu,  6 Feb 2020 15:24:28 +0000 (UTC)
Received: from llong.com (ovpn-124-223.rdu2.redhat.com [10.10.124.223])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 41A401001B05;
        Thu,  6 Feb 2020 15:24:27 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v6 6/6] locking/lockdep: Reuse freed chain_hlocks entries
Date:   Thu,  6 Feb 2020 10:24:08 -0500
Message-Id: <20200206152408.24165-7-longman@redhat.com>
In-Reply-To: <20200206152408.24165-1-longman@redhat.com>
References: <20200206152408.24165-1-longman@redhat.com>
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
just like the others. As the freed chain_hlocks entries are in blocks of
various lengths. A simple bitmap like the one used in the other reusable
lockdep arrays isn't applicable. Instead the chain_hlocks entries are
put into bucketed lists (MAX_CHAIN_BUCKETS) of chain blocks.  Bucket 0
is the variable size bucket which houses chain blocks of size larger than
MAX_CHAIN_BUCKETS sorted in decreasing size order.  Initially, the whole
array is in one chain block (the primordial chain block) in bucket 0.

The minimum size of a chain block is 2 chain_hlocks entries. That will
be the minimum allocation size. In other word, allocation requests
for one chain_hlocks entry will cause 2-entry block to be returned and
hence 1 entry will be wasted.

Allocation requests for the chain_hlocks are fulfilled first by looking
for chain block of matching size. If not found, the first chain block
from bucket[0] (the largest one) is split. That can cause hlock entries
fragmentation and reduce allocation efficiency if a chain block of size >
MAX_CHAIN_BUCKETS is ever zapped and put back to after the primordial
chain block. So the MAX_CHAIN_BUCKETS must be large enough that this
should seldom happen.

By reusing the chain_hlocks entries, we are able to handle workloads
that add and zap a lot of lock classes without the risk of running out
of chain_hlocks entries as long as the total number of outstanding lock
classes at any time remain within a reasonable limit.

Two new tracking counters, nr_free_chain_hlocks & nr_large_chain_blocks,
are added to track the total number of chain_hlocks entries in the
free bucketed lists and the number of large chain blocks in buckets[0]
respectively. The nr_free_chain_hlocks replaces nr_chain_hlocks.

The nr_large_chain_blocks counter enables to see if we should increase
the number of buckets (MAX_CHAIN_BUCKETS) available so as to avoid to
avoid the fragmentation problem in bucket[0].

An internal nfsd test that ran for more than an hour and kept on
loading and unloading kernel modules could cause the following message
to be displayed.

  [ 4318.443670] BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!

The patched kernel was able to complete the test with a lot of free
chain_hlocks entries to spare:

  # cat /proc/lockdep_stats
     :
   dependency chains:                   18867 [max: 65536]
   dependency chain hlocks:             74926 [max: 327680]
   dependency chain hlocks lost:            0
     :
   zapped classes:                       1541
   zapped lock chains:                  56765
   large chain blocks:                      1

By changing MAX_CHAIN_BUCKETS to 3 and add a counter for the size of the
largest chain block. The system still worked and We got the following
lockdep_stats data:

   dependency chains:                   18601 [max: 65536]
   dependency chain hlocks used:        73133 [max: 327680]
   dependency chain hlocks lost:            0
     :
   zapped classes:                       1541
   zapped lock chains:                  56702
   large chain blocks:                  45165
   large chain block size:              20165

By running the test again, I was indeed able to cause chain_hlocks
entries to get lost:

   dependency chain hlocks used:        74806 [max: 327680]
   dependency chain hlocks lost:          575
     :
   large chain blocks:                  48737
   large chain block size:                  7

Due to the fragmentation, it is possible that the
"MAX_LOCKDEP_CHAIN_HLOCKS too low!" error can happen even if a lot of
of chain_hlocks entries appear to be free.

Fortunately, a MAX_CHAIN_BUCKETS value of 16 should be big enough that
few variable sized chain blocks, other than the initial one, should
ever be present in bucket 0.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/lockdep.c           | 255 +++++++++++++++++++++++++++--
 kernel/locking/lockdep_internals.h |   4 +-
 kernel/locking/lockdep_proc.c      |  12 +-
 3 files changed, 256 insertions(+), 15 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index a63976c75253..179b416c3273 100644
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
@@ -2627,7 +2630,234 @@ struct lock_chain lock_chains[MAX_LOCKDEP_CHAINS];
 static DECLARE_BITMAP(lock_chains_in_use, MAX_LOCKDEP_CHAINS);
 static u16 chain_hlocks[MAX_LOCKDEP_CHAIN_HLOCKS];
 unsigned long nr_zapped_lock_chains;
-unsigned int nr_chain_hlocks;
+unsigned int nr_free_chain_hlocks;	/* Free chain_hlocks in buckets */
+unsigned int nr_lost_chain_hlocks;	/* Lost chain_hlocks */
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
+		if (unlikely(next >= 0)) {
+			/*
+			 * Variable sized, sort large to small.
+			 */
+			for_each_chain_block(0, prev, curr) {
+				if (size >= chain_block_size(curr))
+					break;
+			}
+			init_chain_block(offset, curr, 0, size);
+			if (prev < 0)
+				chain_block_buckets[0] = offset;
+			else
+				init_chain_block(prev, offset, 0, 0);
+			return;
+		}
+	}
+	/*
+	 * Fixed size or bucket[0] empty, add to head.
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
+	if (bucket && (curr >= 0)) {
+		del_chain_block(bucket, req, chain_block_next(curr));
+		return curr;
+	} else if (bucket) {
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
 
 struct lock_class *lock_chain_get_class(struct lock_chain *chain, int i)
 {
@@ -2828,15 +3058,8 @@ static inline int add_chain_cache(struct task_struct *curr,
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
 
@@ -2845,6 +3068,13 @@ static inline int add_chain_cache(struct task_struct *curr,
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
@@ -2991,6 +3221,8 @@ static inline int validate_chain(struct task_struct *curr,
 {
 	return 1;
 }
+
+static void init_chain_block_buckets(void)	{ }
 #endif /* CONFIG_PROVE_LOCKING */
 
 /*
@@ -4788,6 +5020,7 @@ static void remove_class_from_lock_chain(struct pending_free *pf,
 	return;
 
 free_lock_chain:
+	free_chain_hlocks(chain->base, chain->depth);
 	/* Overwrite the chain key for concurrent RCU readers. */
 	WRITE_ONCE(chain->chain_key, INITIAL_CHAIN_KEY);
 	dec_chains(chain->irq_context);
diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index af722ceeda33..baca699b94e9 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -140,7 +140,9 @@ extern unsigned long nr_stack_trace_entries;
 extern unsigned int nr_hardirq_chains;
 extern unsigned int nr_softirq_chains;
 extern unsigned int nr_process_chains;
-extern unsigned int nr_chain_hlocks;
+extern unsigned int nr_free_chain_hlocks;
+extern unsigned int nr_lost_chain_hlocks;
+extern unsigned int nr_large_chain_blocks;
 
 extern unsigned int max_lockdep_depth;
 extern unsigned int max_bfs_queue_depth;
diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
index 92fe0742453c..1b7f187aa020 100644
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
@@ -278,8 +278,12 @@ static int lockdep_stats_show(struct seq_file *m, void *v)
 #ifdef CONFIG_PROVE_LOCKING
 	seq_printf(m, " dependency chains:             %11lu [max: %lu]\n",
 			lock_chain_count(), MAX_LOCKDEP_CHAINS);
-	seq_printf(m, " dependency chain hlocks:       %11u [max: %lu]\n",
-			nr_chain_hlocks, MAX_LOCKDEP_CHAIN_HLOCKS);
+	seq_printf(m, " dependency chain hlocks used:  %11lu [max: %lu]\n",
+			MAX_LOCKDEP_CHAIN_HLOCKS -
+			(nr_free_chain_hlocks + nr_lost_chain_hlocks),
+			MAX_LOCKDEP_CHAIN_HLOCKS);
+	seq_printf(m, " dependency chain hlocks lost:  %11u\n",
+			nr_lost_chain_hlocks);
 #endif
 
 #ifdef CONFIG_TRACE_IRQFLAGS
@@ -352,6 +356,8 @@ static int lockdep_stats_show(struct seq_file *m, void *v)
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

