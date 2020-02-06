Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE1EC33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 16:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7384121741
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 16:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="haqaYVzI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgBFQQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 11:16:47 -0500
Received: from merlin.infradead.org ([205.233.59.134]:42504 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727392AbgBFQQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 11:16:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AubZ6eNbPsdrFMhJeIYAUki5fHaAHzz7l6cvCGRQvNQ=; b=haqaYVzIlZYuYGBzqc4BvL/jGg
        ly6UPMSQ3Oyg+swuQg91YuTKprbFhM7Tevo9OgH7fArSxLEOkOxnHYt+cWqnmZ8NmXcw2nesvN5rT
        3XsFjo0PXvpGu2bygZsmpYN/UO8Tdc0D3Fa8ZeTg9ylXlb3ARx1T1kUy+28HUgBn+AeHlr6rMBgqW
        cEFbw5MfXfebY8i8wSZumkyg+ZYRNSTc7N0zC4J3tDq8zVjUnUfVp1J1vJdG92BQCAxiqD0USkEU5
        AzPxgqks6FkNCYWuVPgtLq9fpGl2Qgc9hdYzSW65in+t5sPdXz4NyMXMu+7ZZ+NtQh2GQoXmRt7IM
        /7yed9Lg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1izjpa-0005Ko-B4; Thu, 06 Feb 2020 16:16:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7222F30066E;
        Thu,  6 Feb 2020 17:14:54 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DB7192B813365; Thu,  6 Feb 2020 17:16:40 +0100 (CET)
Date:   Thu, 6 Feb 2020 17:16:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v6 6/6] locking/lockdep: Reuse freed chain_hlocks entries
Message-ID: <20200206161640.GW14914@hirez.programming.kicks-ass.net>
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
> +static int alloc_chain_hlocks(int req)
> +{
> +	int bucket, curr, size;
> +
> +	/*
> +	 * We rely on the MSB to act as an escape bit to denote freelist
> +	 * pointers. Make sure this bit isn't set in 'normal' class_idx usage.
> +	 */
> +	BUILD_BUG_ON((MAX_LOCKDEP_KEYS-1) & CHAIN_BLK_FLAG);
> +
> +	init_data_structures_once();
> +
> +	if (nr_free_chain_hlocks < req)
> +		return -1;
> +
> +	/*
> +	 * We require a minimum of 2 (u16) entries to encode a freelist
> +	 * 'pointer'.
> +	 */
> +	req = max(req, 2);
> +	bucket = size_to_bucket(req);
> +	curr = chain_block_buckets[bucket];
> +
> +	if (bucket && (curr >= 0)) {
> +		del_chain_block(bucket, req, chain_block_next(curr));
> +		return curr;
> +	} else if (bucket) {
> +		/* Try bucket 0 */
> +		curr = chain_block_buckets[0];
> +	}

	if (bucket) {
		if (curr >= 0) {
			del_chain_block(bucket, req, chain_block_next(curr));
			return curr;
		}
		/* Try bucket 0 */
		curr = chain_block_bucket[0];
	}

reads much easier IMO.

> +	/*
> +	 * The variable sized freelist is sorted by size; the first entry is
> +	 * the largest. Use it if it fits.
> +	 */
> +	if (curr >= 0) {
> +		size = chain_block_size(curr);
> +		if (likely(size >= req)) {
> +			del_chain_block(0, size, chain_block_next(curr));
> +			add_chain_block(curr + req, size - req);
> +			return curr;
> +		}
> +	}
> +
> +	/*
> +	 * Last resort, split a block in a larger sized bucket.
> +	 */
> +	for (size = MAX_CHAIN_BUCKETS; size > req; size--) {
> +		bucket = size_to_bucket(size);
> +		curr = chain_block_buckets[bucket];
> +		if (curr < 0)
> +			continue;
> +
> +		del_chain_block(bucket, size, chain_block_next(curr));
> +		add_chain_block(curr + req, size - req);
> +		return curr;
> +	}
> +
> +	return -1;
> +}
