Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C63C2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 13:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AD552084E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 13:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J/awYUnE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbgBDNSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 08:18:21 -0500
Received: from merlin.infradead.org ([205.233.59.134]:43130 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbgBDNSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 08:18:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ix0NumNpsipKs3I7asBAFIMQ7gyLpWw2Gx20iaMSHxs=; b=J/awYUnEP1Z2HE1xW6zPHgdmmP
        qgJThzdUlsh1/6B6UdVVWDXj1qp8hjlgQsqN783pTTf09HaD3pD1knlyW1U/i2bNCpi8OXDZy7KSE
        04i7J5PHGpccgElYuZA3jQLZ7ZjvUNXYHiHBjpk/HVqhKxG/HBTjx1hJHpsCo7vr+bujDs3tMcMon
        Ya3/5YZULrpkwvTo8fC9dKx2Qjm5YqnzlcgzoJ3+QARnGa3cX20t+Wy47fKCaoBWMt6dWA/fuI168
        o14OJJlZ0SSH1SYOc6bhbJ2BQOnguPpc5icP2lZtWOiBcG7M9vxRjY9HKiSv0l54FI5imJ2ZujYFZ
        NtiM0bkQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iyy5o-0004Zq-DZ; Tue, 04 Feb 2020 13:18:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BA96E300E0C;
        Tue,  4 Feb 2020 14:16:27 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3AAB82024714C; Tue,  4 Feb 2020 14:18:13 +0100 (CET)
Date:   Tue, 4 Feb 2020 14:18:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v5 7/7] locking/lockdep: Add a fast path for chain_hlocks
 allocation
Message-ID: <20200204131813.GQ14914@hirez.programming.kicks-ass.net>
References: <20200203164147.17990-1-longman@redhat.com>
 <20200203164147.17990-8-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203164147.17990-8-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2020 at 11:41:47AM -0500, Waiman Long wrote:

> @@ -2809,6 +2813,18 @@ static int alloc_chain_hlocks(int req)
>  			return curr;
>  		}
>  
> +		/*
> +		 * Fast path: splitting out a sub-block at the end of the
> +		 * primordial chain block.
> +		 */
> +		if (likely((size > MAX_LOCK_DEPTH) &&
> +			   (size - req > MAX_CHAIN_BUCKETS))) {
> +			size -= req;
> +			nr_free_chain_hlocks -= req;
> +			init_chain_block_size(curr, size);
> +			return curr + size;
> +		}
> +
>  		if (size > max_size) {
>  			max_prev = prev;
>  			max_curr = curr;

A less horrible hack might be to keep the freelist sorted on size (large
-> small)

That moves the linear-search from alloc_chain_hlocks() into
add_chain_block().  But the thing is that it would amortize to O(1)
because this initial chunk is pretty much 'always' the largest.

Only once we've exhausted the initial block will we hit that search, but
then the hope is that we mostly live off of the buckets, not the
variable freelist.
