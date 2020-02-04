Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD780C2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 13:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90E7C20730
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 13:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OUAvQs5e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbgBDNow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 08:44:52 -0500
Received: from merlin.infradead.org ([205.233.59.134]:45516 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbgBDNov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 08:44:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=puxs38cLUY1pf11FaQt3b1KppwgUHSrOujvnuyJ4Okk=; b=OUAvQs5eyjgEF4Jra7qYZ/njx9
        NxyyY5DRQKiFdPF4/5hjDefbbs764HPueex5/jQQjohH52bQYe5U3LN27kcB4jr1iD5TOBbH0LNgO
        +7o0+H3FGjbUrTJt7QGODxPJHvL83Fn4d4h/mW+UL7XQ7K2cshb955lTKIlwo4h5PzSBP+5MUInp1
        PRRWcNsH0KozaBrYThKtx/ShXVr7WQsM0haayt2fEUtjXUXuI8ly7S6hi2rZnrweiiIMtflyW2NRy
        Vta4uKN0KIt6mPdXakN+ZIwLkAV/IJnodYka1unCUGgJ7UAQVIBUwV5xbp2lej5efvoiyW3sxHa5w
        bEi/Bfsg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iyyVT-00057k-FR; Tue, 04 Feb 2020 13:44:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 887B93016E5;
        Tue,  4 Feb 2020 14:43:00 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0A5A620247145; Tue,  4 Feb 2020 14:44:46 +0100 (CET)
Date:   Tue, 4 Feb 2020 14:44:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v5 7/7] locking/lockdep: Add a fast path for chain_hlocks
 allocation
Message-ID: <20200204134446.GQ14946@hirez.programming.kicks-ass.net>
References: <20200203164147.17990-1-longman@redhat.com>
 <20200203164147.17990-8-longman@redhat.com>
 <20200204131813.GQ14914@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204131813.GQ14914@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2020 at 02:18:13PM +0100, Peter Zijlstra wrote:
> On Mon, Feb 03, 2020 at 11:41:47AM -0500, Waiman Long wrote:
> 
> > @@ -2809,6 +2813,18 @@ static int alloc_chain_hlocks(int req)
> >  			return curr;
> >  		}
> >  
> > +		/*
> > +		 * Fast path: splitting out a sub-block at the end of the
> > +		 * primordial chain block.
> > +		 */
> > +		if (likely((size > MAX_LOCK_DEPTH) &&
> > +			   (size - req > MAX_CHAIN_BUCKETS))) {
> > +			size -= req;
> > +			nr_free_chain_hlocks -= req;
> > +			init_chain_block_size(curr, size);
> > +			return curr + size;
> > +		}
> > +
> >  		if (size > max_size) {
> >  			max_prev = prev;
> >  			max_curr = curr;
> 
> A less horrible hack might be to keep the freelist sorted on size (large
> -> small)
> 
> That moves the linear-search from alloc_chain_hlocks() into
> add_chain_block().  But the thing is that it would amortize to O(1)
> because this initial chunk is pretty much 'always' the largest.
> 
> Only once we've exhausted the initial block will we hit that search, but
> then the hope is that we mostly live off of the buckets, not the
> variable freelist.

Completely untested something like so

---

--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2717,7 +2717,7 @@ static inline void init_chain_block(int
 static inline void add_chain_block(int offset, int size)
 {
 	int bucket = size_to_bucket(size);
-	int next = chain_block_buckets[bucket];
+	int prev, curr, next = chain_block_buckets[bucket];
 
 	if (unlikely(size < 2)) {
 		/*
@@ -2731,26 +2731,38 @@ static inline void add_chain_block(int o
 		return;
 	}
 
-	init_chain_block(offset, next, bucket, size);
-	chain_block_buckets[bucket] = offset;
-	nr_free_chain_hlocks += size;
-
-	if (bucket == 0)
+	if (!bucket) {
 		nr_large_chain_blocks++;
+		/*
+		 * Variable sized, sort large to small.
+		 */
+		for_each_chain_block(0, prev, curr, next) {
+			if (size > chain_block_size(curr))
+				break;
+		}
+		init_chain_block(offset, curr, 0, size);
+		if (prev < 0)
+			chain_block_buckets[prev + MAX_CHAIN_BUCKETS] = offset;
+		else
+			init_chain_block(prev, offset, MAX_CHAIN_BUCKETS, 0);
+	} else {
+		/*
+		 * Fixed size, add to head.
+		 */
+		init_chain_block(offset, next, bucket, size);
+		chain_block_buckets[bucket] = offset;
+	}
+	nr_free_chain_hlocks += size;
 }
 
+
 /*
  * When offset < 0, the bucket number is encoded in it.
  */
-static inline void del_chain_block(int offset, int size, int next)
+static inline void del_chain_block(int bucket, int size, int next)
 {
-	int bucket = size_to_bucket(size);
-
 	nr_free_chain_hlocks -= size;
-	if (offset < 0)
-		chain_block_buckets[offset + MAX_CHAIN_BUCKETS] = next;
-	else
-		init_chain_block(offset, next, bucket, size);
+	chain_block_buckets[bucket] = next;
 
 	if (bucket == 0)
 		nr_large_chain_blocks--;
@@ -2774,9 +2786,7 @@ static void init_chain_block_buckets(voi
  */
 static int alloc_chain_hlocks(int req)
 {
-	int max_prev, max_curr, max_next, max_size = INT_MIN;
-	int prev, curr, next, size;
-	int bucket;
+	int bucket, curr, size;
 
 	/*
 	 * We rely on the MSB to act as an escape bit to denote freelist
@@ -2798,40 +2808,24 @@ static int alloc_chain_hlocks(int req)
 
 	if (bucket != 0) {
 		curr = chain_block_buckets[bucket];
-		if (curr < 0)
-			goto search;
-
-		del_chain_block(bucket - MAX_CHAIN_BUCKETS, req,
-				chain_block_next(curr));
-		return curr;
+		if (curr >= 0) {
+			del_chain_block(bucket, req, chain_block_next(curr));
+			return curr;
+		}
 	}
 
-search:
 	/*
-	 * linear search of the variable sized freelist; look for an exact
-	 * match or the largest block.
+	 * The variable sized freelist is sorted by size; the first entry is
+	 * the largest. Use it if it fits.
 	 */
-	for_each_chain_block(0, prev, curr, next) {
+	curr = chain_block_buckets[0];
+	if (curr >= 0) {
 		size = chain_block_size(curr);
-		next = chain_block_next(curr);
-
-		if (size == req) {
-			del_chain_block(prev, req, next);
+		if (likely(size > req)) {
+			del_chain_block(0, size, chain_block_next(curr));
+			add_chain_block(curr + req, size - req);
 			return curr;
 		}
-
-		if (size > max_size) {
-			max_prev = prev;
-			max_curr = curr;
-			max_next = next;
-			max_size = size;
-		}
-	}
-
-	if (likely(max_size > req)) {
-		del_chain_block(max_prev, max_size, max_next);
-		add_chain_block(max_curr + req, max_size - req);
-		return max_curr;
 	}
 
 	/*
@@ -2843,8 +2837,7 @@ static int alloc_chain_hlocks(int req)
 		if (curr < 0)
 			continue;
 
-		del_chain_block(bucket - MAX_CHAIN_BUCKETS, size,
-				chain_block_next(curr));
+		del_chain_block(bucket, size, chain_block_next(curr));
 		add_chain_block(curr + req, size - req);
 		return curr;
 	}
