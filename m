Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB0BC33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 10:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FDFF222C3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 10:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mIo+EQ+A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729817AbgAOKow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 05:44:52 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38730 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729674AbgAOKow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 05:44:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pdU5TXOUBJeGM8sToGEGfNPav52p0rRGd0Ij1+omwDs=; b=mIo+EQ+AhTvzhmuhCKJ0X//iu
        GcKukhSGSEamAYZIYmwnDsBDadX4+GLf83Znwi12q51LPZeqgbBw4w9Tl0QXKeWHn12BvjXuOZGl4
        0IKufJs4RSCTf3tyyK8M/UmoczxPaq59EFVOkFlIXd/EtKL9jtPUS6EvmFCFh8lYUoRkdg2BWbML1
        yc7g+KGITFci6V+KVYeBT/dBLxXgLdnJtbv7uPdpxpXSMFAEWHYDAsFylBaCvgrbuPECvGjr5u6Xf
        kWU9o0L29gQi7EKdoir2yFLSI6E77mX/C+mCvXE3dwm1kSsugPJGqg6oPbKDq48sTRWk+Cqd8DHaj
        Cso+Xxavg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1irgAK-0005Tz-DG; Wed, 15 Jan 2020 10:44:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E090D30257C;
        Wed, 15 Jan 2020 11:43:09 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1D557203D72A2; Wed, 15 Jan 2020 11:44:46 +0100 (CET)
Date:   Wed, 15 Jan 2020 11:44:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v2 4/6] locking/lockdep: Reuse freed chain_hlocks entries
Message-ID: <20200115104446.GK2827@hirez.programming.kicks-ass.net>
References: <20191216151517.7060-1-longman@redhat.com>
 <20191216151517.7060-5-longman@redhat.com>
 <20200113155823.GY2844@hirez.programming.kicks-ass.net>
 <e282e7f3-6010-ef13-bd07-524445049ef8@redhat.com>
 <20200114094656.GA2844@hirez.programming.kicks-ass.net>
 <b19df484-1d82-1014-1edf-a1294b4dcd09@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b19df484-1d82-1014-1edf-a1294b4dcd09@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 02:16:58PM -0500, Waiman Long wrote:
> On 1/14/20 4:46 AM, Peter Zijlstra wrote:

> > I'm thinking worst-fit might work well for our use-case. Best-fit would
> > result in a heap of tiny fragments and we don't have really large
> > allocations, which is the Achilles-heel of worst-fit.
> I am going to add a patch to split chain block as a last resort in case
> we run out of the main buffer.

It will be the common path; you'll start with a single huge fragment.

Remember, 1 allocator is better than 2.

> > Also, since you put in a minimal allocation size of 2, but did not
> > mandate size is a multiple of 2, there is a weird corner case of size-1
> > fragments. The simplest case is to leak those, but put in a counter so
> > we can see if they're a problem -- there is a fairly trivial way to
> > recover them without going full merge.
> 
> There is no size-1 fragment. Are you referring to the those blocks with
> a size of 2, but with only one entry used? There are some wasted space
> there. I can add a counter to track that.

There will be; imagine you have a size-6 fragment and request a size-5,
then we'll have to split off one. But one is too short to encode on the
free lists.

Suppose you tag them with -2, then on free of the size-5, we can check
if curr+size+1 is -2 and reunite.

First-fit or best-fit would result in lots of that, hence my suggestion
to use worst-fit if you can't find an exact match.
