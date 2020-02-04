Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D7FC2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 12:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 798122087E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 12:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KkENac0l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbgBDMgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 07:36:36 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58906 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbgBDMgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 07:36:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GGceJ4EtvvsDv6X5qZjSy1jFYQR9Lzc9wQn41fpyh+4=; b=KkENac0lFLhC88vzKh62FZvw8p
        cBYiVh7a/DwxGk+5Zj8sS0RV2A4tOxN3KpNK7hveNbnARjIBU60UqyZdu+H9PG98viZKNGNpTKTwD
        WDBjfzx0kfuwkRui6wL4l3TcFaHVK1pIP8jJ0St1V76L3ZHKzfr8wNhH22V/haCWQjIY86i6Uco9P
        WNf0up7nb7nuvccEQC7C8O3O6s2gnyiqOUa3v9gHg+nrnemCqlAr26xo6pMLMLZTBNDJtZoWgDNv0
        2MXQkuwEB1FIos0n/BiWNRuahJwDrMWSlJHJddn8JBceNOtMrNSWnbdzejRwHevIo7beX7nyyk64W
        5pYVugFw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iyxRP-0006wS-4j; Tue, 04 Feb 2020 12:36:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B9126300E0C;
        Tue,  4 Feb 2020 13:34:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3BA8B2024714C; Tue,  4 Feb 2020 13:36:29 +0100 (CET)
Date:   Tue, 4 Feb 2020 13:36:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v5 6/7] locking/lockdep: Reuse freed chain_hlocks entries
Message-ID: <20200204123629.GO14914@hirez.programming.kicks-ass.net>
References: <20200203164147.17990-1-longman@redhat.com>
 <20200203164147.17990-7-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203164147.17990-7-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2020 at 11:41:46AM -0500, Waiman Long wrote:
> +	if (unlikely(size < 2))
> +		return; // XXX leak!

Stuck this on top...

--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2631,7 +2631,8 @@ struct lock_chain lock_chains[MAX_LOCKDE
 static DECLARE_BITMAP(lock_chains_in_use, MAX_LOCKDEP_CHAINS);
 static u16 chain_hlocks[MAX_LOCKDEP_CHAIN_HLOCKS];
 unsigned long nr_zapped_lock_chains;
-unsigned int nr_free_chain_hlocks;	/* Free cfhain_hlocks in buckets */
+unsigned int nr_free_chain_hlocks;	/* Free chain_hlocks in buckets */
+unsigned int nr_lost_chain_hlocks;	/* Lost chain_hlocks */
 unsigned int nr_large_chain_blocks;	/* size > MAX_CHAIN_BUCKETS */
 
 /*
@@ -2718,8 +2719,17 @@ static inline void add_chain_block(int o
 	int bucket = size_to_bucket(size);
 	int next = chain_block_buckets[bucket];
 
-	if (unlikely(size < 2))
-		return; // XXX leak!
+	if (unlikely(size < 2)) {
+		/*
+		 * We can't store single entries on the freelist. Leak them.
+		 *
+		 * One possible way out would be to uniquely mark them, other
+		 * than with CHAIN_BLK_FLAG, such that we can recover them when
+		 * the block before it is re-added.
+		 */
+		nr_lost_chain_hlocks++;
+		return;
+	}
 
 	init_chain_block(offset, next, bucket, size);
 	chain_block_buckets[bucket] = offset;
@@ -2798,8 +2808,8 @@ static int alloc_chain_hlocks(int req)
 
 search:
 	/*
-	 * linear search in the 'dump' bucket; look for an exact match or the
-	 * largest block.
+	 * linear search of the variable sized freelist; look for an exact
+	 * match or the largest block.
 	 */
 	for_each_chain_block(0, prev, curr, next) {
 		size = chain_block_size(curr);
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -141,6 +141,7 @@ extern unsigned int nr_hardirq_chains;
 extern unsigned int nr_softirq_chains;
 extern unsigned int nr_process_chains;
 extern unsigned int nr_free_chain_hlocks;
+extern unsigned int nr_lost_chain_hlocks;
 extern unsigned int nr_large_chain_blocks;
 
 extern unsigned int max_lockdep_depth;
--- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -278,9 +278,11 @@ static int lockdep_stats_show(struct seq
 #ifdef CONFIG_PROVE_LOCKING
 	seq_printf(m, " dependency chains:             %11lu [max: %lu]\n",
 			lock_chain_count(), MAX_LOCKDEP_CHAINS);
-	seq_printf(m, " dependency chain hlocks:       %11lu [max: %lu]\n",
-			MAX_LOCKDEP_CHAIN_HLOCKS - nr_free_chain_hlocks,
+	seq_printf(m, " dependency chain hlocks used:  %11lu [max: %lu]\n",
+			MAX_LOCKDEP_CHAIN_HLOCKS - (nr_free_chain_hlocks - nr_lost_chain_hlocks),
 			MAX_LOCKDEP_CHAIN_HLOCKS);
+	seq_printf(m, " dependency chain hlocks free:  %11lu\n", nr_free_chain_hlocks);
+	seq_printf(m, " dependency chain hlocks lost:  %11lu\n", nr_lost_chain_hlocks);
 #endif
 
 #ifdef CONFIG_TRACE_IRQFLAGS
