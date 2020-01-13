Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A3CC33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 15:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 865D221569
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 15:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Uh+G5lpZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbgAMPvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 10:51:39 -0500
Received: from merlin.infradead.org ([205.233.59.134]:35194 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgAMPvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 10:51:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YnZsglYJ3u81cdSyEaSN9mPuuxqI7Jwbrr370DvLj7w=; b=Uh+G5lpZ3vHiXznUv+6uORZU0
        edqX1ot3Xedws/WEVHaRIpUozKfzgI+qyHbkwhHTL3cf+MOnh7PgKhXflNQrlQi7uZViJhOzNS3bn
        k4ZZgG74MMimomwiKuYsNwAKfkBPyCsa14MoeJlahSVJnYi0NYjklLarE+er8UEFvRFnk4vlQ6oRg
        oGRvWAB93uLZuXskXAuaUvusTwAGd5BcvM5w2DRuRU7Hc+cbFZLSOZa1rbPKKC/J1VSwFmi4SBV8X
        zxPoiBLcc32WnyY/ZEes/n+XiF+4mRWOKySuH7yMeh3ODpBM+hH1wMlbSQEgOEOHeh5NFXjIHpVr4
        Q9RTfM1KA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ir203-0008Tf-AB; Mon, 13 Jan 2020 15:51:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5F2DC3042BC;
        Mon, 13 Jan 2020 16:49:53 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C1A0720427392; Mon, 13 Jan 2020 16:51:28 +0100 (CET)
Date:   Mon, 13 Jan 2020 16:51:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v2 4/6] locking/lockdep: Reuse freed chain_hlocks entries
Message-ID: <20200113155128.GX2844@hirez.programming.kicks-ass.net>
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
> +#define CHAIN_HLOCKS_MASK	0xffff

> +static inline void set_chain_block(int offset, int size, int next)
> +{
> +	if (unlikely(offset < 0)) {
> +		chain_block_buckets[0] = next;
> +		return;
> +	}
> +	chain_hlocks[offset] = (next >> 16) | CHAIN_BLK_FLAG;
> +	chain_hlocks[offset + 1] = next & CHAIN_HLOCKS_MASK;
> +	if (size > MAX_CHAIN_BUCKETS) {
> +		chain_hlocks[offset + 2] = size >> 16;
> +		chain_hlocks[offset + 3] = size & CHAIN_HLOCKS_MASK;
> +	}
> +}

AFAICT HLOCKS_MASK is superfluous. That is, you're assigning to a u16,
it will truncate automagically.

But if you want to make it more explicit, something like:

  chain_hlocks[offset + 1] = (u16)next;

might be easier to read still.
