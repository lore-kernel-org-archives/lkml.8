Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5EBC33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 09:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F24224670
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 09:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qVgUP7+G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728944AbgANJrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 04:47:07 -0500
Received: from merlin.infradead.org ([205.233.59.134]:41218 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgANJrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 04:47:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=K7fMYkkK9Q+axZjaI7p+tnNY2x5Rriik0Ul4/G3yv/Q=; b=qVgUP7+Gomw24l7V9LgYH2RXT
        U0Gtlmg7Q2R7xQRUsViuEH0jAeE9VmfWTtHKIBg8/EWf8K7QBMQKxeBha58UJYsLJ3WWPDg8/8IAz
        6TMlszkWio1EnM/3chvY/6eEgHt+sepd/8dCymwgiqicrvwTorDOe6bk+QOymW7NyPQDEFf/SEoid
        yppNFpysImoweyINk4lKZHR5t47ZJWpSEyuBa3yYEEe0dxrOlB8+vBz8e5pNlm4hZmG4oifoNx3px
        r8+G6l3ZZYwkTzYmVTIfebkDH7Xmj+XMpVk26/+EgAQO4b+WoW1tZNkpG6CapfEOyH6xlaVxekRJp
        4d1QlGyqA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1irImp-0006XG-Jq; Tue, 14 Jan 2020 09:47:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 06F183013A4;
        Tue, 14 Jan 2020 10:45:20 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BF19A20B79C98; Tue, 14 Jan 2020 10:46:56 +0100 (CET)
Date:   Tue, 14 Jan 2020 10:46:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v2 4/6] locking/lockdep: Reuse freed chain_hlocks entries
Message-ID: <20200114094656.GA2844@hirez.programming.kicks-ass.net>
References: <20191216151517.7060-1-longman@redhat.com>
 <20191216151517.7060-5-longman@redhat.com>
 <20200113155823.GY2844@hirez.programming.kicks-ass.net>
 <e282e7f3-6010-ef13-bd07-524445049ef8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e282e7f3-6010-ef13-bd07-524445049ef8@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 11:24:37AM -0500, Waiman Long wrote:
> On 1/13/20 10:58 AM, Peter Zijlstra wrote:

> > That's _two_ allocators :/ And it can trivially fail, even if there's
> > plenty space available.
> >
> > Consider nr_chain_hlocks is exhaused, and @size is empty, but size+1
> > still has blocks.
> >
> > I'm guessing you didn't make it a single allocator because you didn't
> > want to implement block splitting? why?
> >
> In my testing, most of the lock chains tend to be rather short (within
> the 2-8 range). I don't see a lot of free blocks left in the system
> after the test. So I don't see a need to implement block splitting for now.
> 
> If you think this is a feature that needs to be implemented for the
> patch to be complete, I can certainly add patch to do that. My initial
> thought is just to split long blocks in the unsized list for allocation
> request that is no longer than 8 to make thing easier.

From an engineering POV I'd much prefer a single complete allocator over
two half ones. We can leave block merger out of the initial allocator I
suppose and worry about that if/when fragmentation really shows to be a
problem.

I'm thinking worst-fit might work well for our use-case. Best-fit would
result in a heap of tiny fragments and we don't have really large
allocations, which is the Achilles-heel of worst-fit.

Also, since you put in a minimal allocation size of 2, but did not
mandate size is a multiple of 2, there is a weird corner case of size-1
fragments. The simplest case is to leak those, but put in a counter so
we can see if they're a problem -- there is a fairly trivial way to
recover them without going full merge.

Also, there's a bunch of syzcaller reports of running out of
ENTRIES/CHAIN_HLOCKS, perhaps try some of those workloads to better
stress the allocator?
