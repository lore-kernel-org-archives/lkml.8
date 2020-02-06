Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B125FC33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 16:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 832AF20838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 16:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FoC4/Iud"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbgBFQDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 11:03:47 -0500
Received: from merlin.infradead.org ([205.233.59.134]:41370 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbgBFQDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 11:03:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5bXJ5Rw26RpYjEWcuqqQmXts3e2aBzD3XsiSch9tXCk=; b=FoC4/Iud91mZ7T1371q+55R/r+
        m3u1CBnxN9VEqvfk0qyw9fIX4u6PR1MTbTIuRqEhsXApPmLZiFH+LIbKwMimFbRqXCGhEIH3+SIHx
        Q/UDN9HnJ3MlG98HPsnVjQ0CW1BWNg1sr79UMXj8apEh89wLh2zdLhdy+Lcugrc57CjJAA+Xxclhx
        75EGzdQoT8t6I9d6O1qY2L3GJ/mDae8aXFYgjZ0TGLQ/ZE1mbg10lJOnkd2OGiZHwLhIFjtzJYjji
        mXP/bSKaPEie+qh5O8IQFyeTa1EWsrjiWS957YFjoq7F71JvGYCN0y2gby6yOJe0OoY7qTjmTAroZ
        zeZQfJ/A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1izjcw-00058S-D4; Thu, 06 Feb 2020 16:03:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AC0103008A9;
        Thu,  6 Feb 2020 17:01:48 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EBAC52B72EEBF; Thu,  6 Feb 2020 17:03:34 +0100 (CET)
Date:   Thu, 6 Feb 2020 17:03:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v6 6/6] locking/lockdep: Reuse freed chain_hlocks entries
Message-ID: <20200206160334.GV14914@hirez.programming.kicks-ass.net>
References: <20200206152408.24165-1-longman@redhat.com>
 <20200206152408.24165-7-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200206152408.24165-7-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2020 at 10:24:08AM -0500, Waiman Long wrote:
> +#define for_each_chain_block(bucket, prev, curr)		\
> +	for ((prev) = -1, (curr) = chain_block_buckets[bucket];	\
> +	     (curr) >= 0;					\
> +	     (prev) = (curr), (curr) = chain_block_next(curr))

> +static inline void add_chain_block(int offset, int size)
> +{
> +	int bucket = size_to_bucket(size);
> +	int next = chain_block_buckets[bucket];
> +	int prev, curr;
> +
> +	if (unlikely(size < 2)) {
> +		/*
> +		 * We can't store single entries on the freelist. Leak them.
> +		 *
> +		 * One possible way out would be to uniquely mark them, other
> +		 * than with CHAIN_BLK_FLAG, such that we can recover them when
> +		 * the block before it is re-added.
> +		 */
> +		if (size)
> +			nr_lost_chain_hlocks++;
> +		return;
> +	}
> +
> +	nr_free_chain_hlocks += size;
> +	if (!bucket) {
> +		nr_large_chain_blocks++;
> +
> +		if (unlikely(next >= 0)) {

I was surprised by this condition..

> +			/*
> +			 * Variable sized, sort large to small.
> +			 */
> +			for_each_chain_block(0, prev, curr) {
> +				if (size >= chain_block_size(curr))
> +					break;
> +			}

Because if that is not so, then here:
	@curr == @next
	@prev == -1

> +			init_chain_block(offset, curr, 0, size);

and this will be identical to:

	init_chain_block(offset, next, bucket, size);


> +			if (prev < 0)
> +				chain_block_buckets[0] = offset;
> +			else
> +				init_chain_block(prev, offset, 0, 0);

and this will be:

	chain_block_buckets[bucket] = offset;


Or am I missing something?

> +			return;
> +		}
> +	}
> +	/*
> +	 * Fixed size or bucket[0] empty, add to head.
> +	 */
> +	init_chain_block(offset, next, bucket, size);
> +	chain_block_buckets[bucket] = offset;
> +}
