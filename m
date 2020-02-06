Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3CFDC33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 17:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B316721741
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 17:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iAp/+gmv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgBFRcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 12:32:03 -0500
Received: from merlin.infradead.org ([205.233.59.134]:48618 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbgBFRcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 12:32:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5qqLfcCzZqb9lsXWveDQ2LL6r9oP/9a7+gTw/Jw44lg=; b=iAp/+gmvhiXYw+HT6nED2uCPqx
        wcdbO7CICi5P3VZHW5Wk/M9cRq18evzlINEmuUVpP93Uf1fLMXQJfEdvUL27uigxWmZymgZJOEYQU
        9awyC7PjBa0ZeZBouQlvObyti8zFjP4+j3bK1FwhoU9YZAN0PH/LZn6Fiq2OwjT44ECFAgXmJGBQM
        fzM/gSkDxF1iAJU9ECU/v/t751cLc0q5NyaVt8NVY0CtYxypYBPYc6NsQJ57o+ef1+/HOG9aCgBwf
        oC68OdKifGB3EAMArOVUSX5++WsSGODisyZSf4T7dnHGX/yHnvMuziWQO0EcZydkQF2pD/ACOFVeY
        k+KH9nsg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1izl0O-0006Yb-33; Thu, 06 Feb 2020 17:31:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 35A333016E5;
        Thu,  6 Feb 2020 18:30:07 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AB2962B813A87; Thu,  6 Feb 2020 18:31:53 +0100 (CET)
Date:   Thu, 6 Feb 2020 18:31:53 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v6 6/6] locking/lockdep: Reuse freed chain_hlocks entries
Message-ID: <20200206173153.GX14914@hirez.programming.kicks-ass.net>
References: <20200206152408.24165-1-longman@redhat.com>
 <20200206152408.24165-7-longman@redhat.com>
 <20200206161640.GW14914@hirez.programming.kicks-ass.net>
 <29fbb4c6-aa8f-f6ce-6115-232db5f2db52@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29fbb4c6-aa8f-f6ce-6115-232db5f2db52@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2020 at 12:08:20PM -0500, Waiman Long wrote:
> On 2/6/20 11:16 AM, Peter Zijlstra wrote:
> > On Thu, Feb 06, 2020 at 10:24:08AM -0500, Waiman Long wrote:
> >> +static int alloc_chain_hlocks(int req)
> >> +{
> >> +	int bucket, curr, size;
> >> +
> >> +	/*
> >> +	 * We rely on the MSB to act as an escape bit to denote freelist
> >> +	 * pointers. Make sure this bit isn't set in 'normal' class_idx usage.
> >> +	 */
> >> +	BUILD_BUG_ON((MAX_LOCKDEP_KEYS-1) & CHAIN_BLK_FLAG);
> >> +
> >> +	init_data_structures_once();
> >> +
> >> +	if (nr_free_chain_hlocks < req)
> >> +		return -1;
> >> +
> >> +	/*
> >> +	 * We require a minimum of 2 (u16) entries to encode a freelist
> >> +	 * 'pointer'.
> >> +	 */
> >> +	req = max(req, 2);
> >> +	bucket = size_to_bucket(req);
> >> +	curr = chain_block_buckets[bucket];
> >> +
> >> +	if (bucket && (curr >= 0)) {
> >> +		del_chain_block(bucket, req, chain_block_next(curr));
> >> +		return curr;
> >> +	} else if (bucket) {
> >> +		/* Try bucket 0 */
> >> +		curr = chain_block_buckets[0];
> >> +	}
> > 	if (bucket) {
> > 		if (curr >= 0) {
> > 			del_chain_block(bucket, req, chain_block_next(curr));
> > 			return curr;
> > 		}
> > 		/* Try bucket 0 */
> > 		curr = chain_block_bucket[0];
> > 	}
> >
> > reads much easier IMO.
> 
> Yes, that is simpler. I can send out an updated patch if you want, or
> you can apply the change when you pull the patch.

I'll frob it. Thanks!
