Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96490C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 21:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DEFA20728
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 21:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b5mjk9TR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388554AbgAPVNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 16:13:11 -0500
Received: from merlin.infradead.org ([205.233.59.134]:43030 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbgAPVNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 16:13:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RLryx5UBYvfz2+aEO984x/J4mbotkpLkzGDNc++NzwE=; b=b5mjk9TR/xnVtJY+Fv2kVS/DW
        WZ9lodzilnPuQuCfnh3VTgt2wHC6ctgmAPTa5urzvFDh6g4lkzH2jxM/opTx7vpmFbCFMvqHgNDV6
        ucZfffQJigZ6BM3NAd2Al1JjZf0JULryFRf1EXq1SqZflfGxlsJAdGh1ieXLmILAy5pesJpJnSibP
        Rpd6cllybPE7w99OG1iKqb6frbhPIW4cfS+9inh7WMHGF5H+Eb7goU2bCAFKLlFAGqry3dMFYzFvm
        IvQK5HtOlphePYwF3+xzzRkgGMzHQy+bvCWRMjvTdYm7YXMtLi/rs1u/Ycm1xnVCSlnFyEeMoqWSi
        drlRkQS0Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1isCRr-0003gv-Oh; Thu, 16 Jan 2020 21:13:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D2307302524;
        Thu, 16 Jan 2020 22:11:23 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C0B0E201D41A2; Thu, 16 Jan 2020 22:13:00 +0100 (CET)
Date:   Thu, 16 Jan 2020 22:13:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v3 6/8] locking/lockdep: Reuse freed chain_hlocks entries
Message-ID: <20200116211300.GT2827@hirez.programming.kicks-ass.net>
References: <20200115214313.13253-1-longman@redhat.com>
 <20200115214313.13253-7-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115214313.13253-7-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2020 at 04:43:11PM -0500, Waiman Long wrote:
> +static inline int alloc_chain_hlocks_from_buckets(int size)
> +{
> +	int prev, curr, next;
> +
> +	if (!nr_free_chain_hlocks)
> +		return -1;
> +
> +	if (size <= MAX_CHAIN_BUCKETS) {
> +		curr = chain_block_buckets[size - 1];
> +		if (curr < 0)
> +			return -1;
> +
> +		chain_block_buckets[size - 1] = next_chain_block(curr);
> +		nr_free_chain_hlocks -= size;
> +		return curr;
> +	}
> +
> +	/*
> +	 * Look for a free chain block of the given size
> +	 *
> +	 * It is rare to have a lock chain with depth > MAX_CHAIN_BUCKETS.
> +	 * It is also more expensive as we may iterate the whole list
> +	 * without finding one.
> +	 */
> +	for_each_chain_block(0, prev, curr, next) {
> +		next = next_chain_block(curr);
> +		if (chain_block_size(curr) == size) {
> +			set_chain_block(prev, 0, next);
> +			nr_free_chain_hlocks -= size;
> +			nr_large_chain_blocks--;
> +			return curr;
> +		}
> +	}
> +	return -1;
> +}

> +static int alloc_chain_hlocks(int size)
> +{
> +	int curr;
> +
> +	if (size < 2)
> +		size = 2;
> +
> +	curr = alloc_chain_hlocks_from_buckets(size);
> +	if (curr >= 0)
> +		return curr;
> +
> +	BUILD_BUG_ON((1UL << 24) <= ARRAY_SIZE(chain_hlocks));
> +	BUILD_BUG_ON((1UL << 6)  <= ARRAY_SIZE(current->held_locks));
> +	BUILD_BUG_ON((1UL << 8*sizeof(chain_hlocks[0])) <=
> +		     ARRAY_SIZE(lock_classes));
> +
> +	/*
> +	 * Allocate directly from chain_hlocks.
> +	 */
> +	if (likely(nr_chain_hlocks + size <= MAX_LOCKDEP_CHAIN_HLOCKS)) {
> +		curr = nr_chain_hlocks;
> +		nr_chain_hlocks += size;
> +		return curr;
> +	}
> +	if (!debug_locks_off_graph_unlock())
> +		return -1;
> +
> +	print_lockdep_off("BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!");
> +	dump_stack();
> +	return -1;
> +}

Argh, that's still _two_ half allocators.

Here, please try this one, it seems to boot. It compiles with some
noise, but that is because GCC is stupid and I'm too tired.

---

--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1071,15 +1071,22 @@ static inline void check_data_structures
 
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
+	static bool ds_initialized, rcu_head_initialized, chain_block_initialized;
 	int i;
 
+	if (!chain_block_initialized) {
+		chain_block_initialized = true;
+		init_chain_block_buckets();
+	}
+
 	if (likely(rcu_head_initialized))
 		return;
 
@@ -2637,7 +2644,217 @@ struct lock_chain lock_chains[MAX_LOCKDE
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
+	if (size < 2)
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
+	if (max_size > req) {
+		del_chain_block(max_prev, max_size, max_next);
+		add_chain_block(max_curr + req, max_size - req);
+		return max_curr;
+	}
+
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
+#ifdef CONFIG_PROVE_LOCKING
+static inline void free_chain_hlocks(int base, int size)
+{
+	add_chain_block(base, max(size, 2));
+}
+#endif
 
 struct lock_class *lock_chain_get_class(struct lock_chain *chain, int i)
 {
@@ -2838,15 +3055,8 @@ static inline int add_chain_cache(struct
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
 
@@ -2855,6 +3065,13 @@ static inline int add_chain_cache(struct
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
@@ -4798,6 +5015,7 @@ static void remove_class_from_lock_chain
 	return;
 
 free_lock_chain:
+	free_chain_hlocks(chain->base, chain->depth);
 	/* Overwrite the chain key for concurrent RCU readers. */
 	WRITE_ONCE(chain->chain_key, INITIAL_CHAIN_KEY);
 	dec_chains(chain->irq_context);
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -140,7 +140,8 @@ extern unsigned long nr_stack_trace_entr
 extern unsigned int nr_hardirq_chains;
 extern unsigned int nr_softirq_chains;
 extern unsigned int nr_process_chains;
-extern unsigned int nr_chain_hlocks;
+extern unsigned int nr_free_chain_hlocks;
+extern unsigned int nr_large_chain_blocks;
 
 extern unsigned int max_lockdep_depth;
 extern unsigned int max_bfs_queue_depth;
--- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -137,7 +137,7 @@ static int lc_show(struct seq_file *m, v
 	};
 
 	if (v == SEQ_START_TOKEN) {
-		if (nr_chain_hlocks > MAX_LOCKDEP_CHAIN_HLOCKS)
+		if (!nr_free_chain_hlocks)
 			seq_printf(m, "(buggered) ");
 		seq_printf(m, "all lock chains:\n");
 		return 0;
@@ -278,8 +278,8 @@ static int lockdep_stats_show(struct seq
 #ifdef CONFIG_PROVE_LOCKING
 	seq_printf(m, " dependency chains:             %11lu [max: %lu]\n",
 			lock_chain_count(), MAX_LOCKDEP_CHAINS);
-	seq_printf(m, " dependency chain hlocks:       %11u [max: %lu]\n",
-			nr_chain_hlocks, MAX_LOCKDEP_CHAIN_HLOCKS);
+	seq_printf(m, " dependency chain hlocks:       %11lu [max: %lu]\n",
+			MAX_LOCKDEP_CHAIN_HLOCKS - nr_free_chain_hlocks, MAX_LOCKDEP_CHAIN_HLOCKS);
 #endif
 
 #ifdef CONFIG_TRACE_IRQFLAGS
@@ -351,6 +351,10 @@ static int lockdep_stats_show(struct seq
 			nr_zapped_classes);
 	seq_printf(m, " zapped lock chains:            %11lu\n",
 			nr_zapped_lock_chains);
+	seq_printf(m, " free chain hlocks:             %11u\n",
+			nr_free_chain_hlocks);
+	seq_printf(m, " large chain blocks:            %11u\n",
+			nr_large_chain_blocks);
 	return 0;
 }
 
