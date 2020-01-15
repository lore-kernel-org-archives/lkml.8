Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26313C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 21:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1DD42465A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 21:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XyLTJHp1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730304AbgAOVn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 16:43:58 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41255 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730161AbgAOVnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 16:43:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579124622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=LS8yaDLDS7kiFQ8atjsBYWiyzRekCHkh3HKwMVBL1vg=;
        b=XyLTJHp1fWj9SVgkUgvEBiVf9N7aJg/PyFvi8qnvcq9nnBg6P2/xsUxhoXTdP4KiKmhe8f
        r5JV1kN14p6iaQrNUFd9J+E5znKLHZRnVrZyVdIXpK9ZHB8s/RVE5nx4nwRc3/7/Ia+pNs
        tCd+dzYe+6Dr0Md7FOWgygI5XzQlJyE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-110-IcV8ey5sORSAE5fMDRa6uw-1; Wed, 15 Jan 2020 16:43:38 -0500
X-MC-Unique: IcV8ey5sORSAE5fMDRa6uw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A457D800EBF;
        Wed, 15 Jan 2020 21:43:37 +0000 (UTC)
Received: from llong.com (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EE30E5C290;
        Wed, 15 Jan 2020 21:43:36 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v3 8/8] locking/lockdep: Enable chain block splitting as last resort
Date:   Wed, 15 Jan 2020 16:43:13 -0500
Message-Id: <20200115214313.13253-9-longman@redhat.com>
In-Reply-To: <20200115214313.13253-1-longman@redhat.com>
References: <20200115214313.13253-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the main chain_hlocks[] buffer is running out and a chain block of
a matching size isn't available, it is possible that there are larger
free chain blocks available that can accommodate an allocation request.
So instead of disabling lockdep, we will try to find a larger chain
block and split it.

Chain block splitting will be used as the last resort as doing too many
splitting will generate a lot of small chain blocks that cannot satisfy
larger size allocation requests and hence potentally wasting more space.

To test chain block splitting code, the call to
alloc_chain_hlocks_by_splitting_block() was moved up before direct
array allocation. A nfsd workload was run before and after the change.
Before it, the lockdep_stats output was:

 zapped classes:                       1538
 zapped direct dependencies:           4612
 zapped lock chains:                  57409
 free chain hlocks:                       0
 large chain blocks:                      0
 split chain blocks:                      0

After the change, the output became:

 zapped classes:                       1538
 zapped direct dependencies:           4612
 zapped lock chains:                  57002
 free chain hlocks:                     944
 large chain blocks:                      0
 split chain blocks:                    784

Chain block merging is not being considered for now as it can be time
consuming while holding the graph lock which is not good.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/lockdep.c           | 66 +++++++++++++++++++++++++++++-
 kernel/locking/lockdep_internals.h |  1 +
 kernel/locking/lockdep_proc.c      |  2 +
 3 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 165e2361b25e..9a75f9582b6b 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2641,6 +2641,7 @@ unsigned long nr_zapped_lock_chains;
 unsigned int nr_chain_hlocks;
 unsigned int nr_free_chain_hlocks;	/* Free cfhain_hlocks in buckets */
 unsigned int nr_large_chain_blocks;	/* size > MAX_CHAIN_BUCKETS */
+unsigned int nr_split_chain_blocks;	/* Chain block split count */
 
 #ifdef CONFIG_PROVE_LOCKING
 /*
@@ -2661,7 +2662,8 @@ unsigned int nr_large_chain_blocks;	/* size > MAX_CHAIN_BUCKETS */
  * When an allocation request is made, alloc_chain_hlocks() will first
  * look up the matching bucketed list to find a free chain block. If not
  * found, allocation will be made directly from the chain_hlocks array
- * from the current nr_chain_hlocks value.
+ * from the current nr_chain_hlocks value. As a last resort, larger chain
+ * block will be split, if available, to satisfy the request.
  *
  * Note that a chain_hlocks entry contain the class index which is
  * crrently limited to 13 bits.
@@ -2795,12 +2797,66 @@ static inline void free_chain_hlocks(int base, int size)
 	chain_block_buckets[0] = base;
 	nr_large_chain_blocks++;
 }
+
+/*
+ * Allocate chain block by splitting larger block in buckets.
+ * This is the last resort before disabling lockdep.
+ */
+static inline int alloc_chain_hlocks_by_splitting_block(int size)
+{
+	int newsize;
+	int prev, curr, next;
+
+	if (!nr_free_chain_hlocks)
+		return -1;
+
+	/*
+	 * As the minimum block size is 2, we have to look for a larger
+	 * block that is at least 2 greater than the desired size.
+	 */
+	for (newsize = size + 2; newsize <= MAX_CHAIN_BUCKETS; newsize++) {
+		curr = chain_block_buckets[newsize - 1];
+		if (curr < 0)
+			continue;
+		chain_block_buckets[newsize - 1] = next_chain_block(curr);
+		nr_free_chain_hlocks -= newsize;
+		goto found;
+	}
+
+	/*
+	 * Look for a block in chain_block_buckets[0] with a size of
+	 * (size + 2) or larger.
+	 */
+	for_each_chain_block(0, prev, curr, next) {
+		next = next_chain_block(curr);
+		newsize = chain_block_size(curr);
+		if (newsize >= size + 2) {
+			set_chain_block(prev, 0, next);
+			nr_free_chain_hlocks -= newsize;
+			nr_large_chain_blocks--;
+			goto found;
+		}
+	}
+	return -1;
+
+found:
+	/*
+	 * Free the unneed chain_hlocks entries at the end of the block.
+	 */
+	free_chain_hlocks(curr + size, newsize - size);
+	nr_split_chain_blocks++;
+	return curr;
+}
 #else
 static inline void init_chain_block_buckets(void)	{ }
 static inline int  alloc_chain_hlocks_from_buckets(int size)
 {
 	return -1;
 }
+static inline int alloc_chain_hlocks_by_splitting_block(int size)
+{
+	return -1;
+}
 #endif /* CONFIG_PROVE_LOCKING */
 
 /*
@@ -2833,6 +2889,14 @@ static int alloc_chain_hlocks(int size)
 		nr_chain_hlocks += size;
 		return curr;
 	}
+
+	/*
+	 * Try to allocate it by splitting large chain block.
+	 */
+	curr = alloc_chain_hlocks_by_splitting_block(size);
+	if (curr >= 0)
+		return curr;
+
 	if (!debug_locks_off_graph_unlock())
 		return -1;
 
diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index 9425155b9053..7b6ec1e7168a 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -143,6 +143,7 @@ extern unsigned int nr_process_chains;
 extern unsigned int nr_chain_hlocks;
 extern unsigned int nr_free_chain_hlocks;
 extern unsigned int nr_large_chain_blocks;
+extern unsigned int nr_split_chain_blocks;
 
 extern unsigned int max_lockdep_depth;
 extern unsigned int max_bfs_queue_depth;
diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
index 9b3d2976bd5a..97fc50facd98 100644
--- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -355,6 +355,8 @@ static int lockdep_stats_show(struct seq_file *m, void *v)
 			nr_free_chain_hlocks);
 	seq_printf(m, " large chain blocks:            %11u\n",
 			nr_large_chain_blocks);
+	seq_printf(m, " split chain blocks:            %11u\n",
+			nr_split_chain_blocks);
 	return 0;
 }
 
-- 
2.18.1

