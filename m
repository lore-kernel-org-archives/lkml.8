Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452AFC33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 15:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 135C320678
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 15:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GEkgVvbn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbgAMP6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 10:58:31 -0500
Received: from merlin.infradead.org ([205.233.59.134]:35282 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728640AbgAMP6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 10:58:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VuHxvPaAgsYx36If2k60MIYF3RrnkaYTNJXJ1zwlP44=; b=GEkgVvbnYg/xGjSAucpDBsm62
        idGeWOlsjV+lZq1DQOwu0ImmJSjrg3bCX7vYkz1xiysXOj68/eilTBk2GMdb8OUH4UCrJiCtOixqx
        m5wikCJ3nnuoa1X5QNianZ7f6IrttlrCr48XNsCm2NP8ZbcUY/vfTNY3kYnJmmh634swoRlfcbNKx
        wz+QP6UyC6a+jBKaD9JKWeyas+9jnPMxl4akHBC88P7GwxUar4cxT/5G3EidxX/r1EOdDb1lAMUJ/
        pQ7YAqyiWQdJAskTReSnNujND1dmpSltD2EXtjLRb9i4B+AFi88bjrIh5IW9IpepmhfesW4ghmmwn
        Au9C7S1dA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ir26j-0000C3-PS; Mon, 13 Jan 2020 15:58:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7FC6A304121;
        Mon, 13 Jan 2020 16:56:48 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DECF420427392; Mon, 13 Jan 2020 16:58:23 +0100 (CET)
Date:   Mon, 13 Jan 2020 16:58:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v2 4/6] locking/lockdep: Reuse freed chain_hlocks entries
Message-ID: <20200113155823.GY2844@hirez.programming.kicks-ass.net>
References: <20191216151517.7060-1-longman@redhat.com>
 <20191216151517.7060-5-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216151517.7060-5-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 10:15:15AM -0500, Waiman Long wrote:
> +/*
> + * Return offset of a chain block of the right size or -1 if not found.
> + */
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
> +	prev = -1;
> +	curr = chain_block_buckets[0];
> +	while (curr >= 0) {
> +		next = next_chain_block(curr);
> +		if (chain_block_size(curr) == size) {
> +			set_chain_block(prev, 0, next);
> +			nr_free_chain_hlocks -= size;
> +			nr_large_chain_blocks--;
> +			return curr;
> +		}
> +		prev = curr;
> +		curr = next;
> +	}
> +	return -1;
> +}

> +/*
> + * The graph lock must be held before calling this function.
> + *
> + * Return: an offset to chain_hlocks if successful, or
> + *	   -1 with graph lock released
> + */
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

*groan*....

That's _two_ allocators :/ And it can trivially fail, even if there's
plenty space available.

Consider nr_chain_hlocks is exhaused, and @size is empty, but size+1
still has blocks.

I'm guessing you didn't make it a single allocator because you didn't
want to implement block splitting? why?
