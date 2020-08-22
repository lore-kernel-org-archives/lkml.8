Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35C8C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 16:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89AE4206C0
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 16:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oHwjy5xk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbgHVQjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 12:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727856AbgHVQjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 12:39:19 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A495C061573
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 09:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zwYU/mANz/J9BjiFC0XPuQDSqmPw6BXuX/9oFzrtccw=; b=oHwjy5xkCy8raJPxPoQxMFnj79
        Y6n3qSIo3I8kczEyzs5Jat+EgQyvoGqRVb2OfdAjazKsYz5YOq7AXR6Ug92Hh2qZBYz/s5tn+j/zc
        qlg4aPtk8wDRcVGZxQcBRu7DSQq6NUa6QiZX0LVpWSquw9y2pTfIB7OgqMj3KJqfL4iB5TjVMlt+l
        6biSrrD3nes4AifwjVE0uVae83l4MkqFplMXWZkedIrDVbrWlPxxg0hR2AZSwyVFfyikz052KUyUb
        Iud/ZaUNb7YmzfBLjsK+NY9B2SjG528gAfzO2yay74H1OrSn1CU23AFfdcLNDiASBd242k7fp46vQ
        hOiwRqMA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k9WXw-0000yj-Rc; Sat, 22 Aug 2020 16:39:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AE426301324;
        Sat, 22 Aug 2020 18:39:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 911222363BF8B; Sat, 22 Aug 2020 18:39:09 +0200 (CEST)
Date:   Sat, 22 Aug 2020 18:39:09 +0200
From:   peterz@infradead.org
To:     Michel Lespinasse <walken@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Lockdep question regarding two-level locks
Message-ID: <20200822163909.GR1362448@hirez.programming.kicks-ass.net>
References: <CANN689HMLC4uKCjztqfZsDO7pPbsvViOQQ_HDWWYU4=8cZbKvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANN689HMLC4uKCjztqfZsDO7pPbsvViOQQ_HDWWYU4=8cZbKvQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 22, 2020 at 09:04:09AM -0700, Michel Lespinasse wrote:
> Hi,
> 
> I am wondering about how to describe the following situation to lockdep:
> 
> - lock A would be something that's already implemented (a mutex or
> possibly a spinlock).
> - lock B is a range lock, which I would be writing the code for
> (including lockdep hooks). I do not expect lockdep to know about range
> locking, but I want it to treat lock B like any other and detect lock
> ordering issues related to it.
> - lock A protects a number of structures, including lock B's list of
> locked ranges, but other structures as well.
> - lock A is intended to be held for only short periods of time, lock
> B's ranges might be held for longer.

That's the 'normal' state for blocking locks, no?

See how both struct mutex and struct rw_semaphore have internal locks.

> Usage would be along the following lines:
> 
> acquire:
> A_lock();
> // might access data protected by A here
> bool blocked = B_lock(range); // must be called under lock A; will
> release lock A if blocking on B.
> // might access data protected by A here (especially to re-validate in
> case A was released while blocking on B...)
> A_unlock()
> 
> release:
> A_lock()
> // might access data protected by A here
> A_B_unlock(range); // must be called under lock A; releases locks A and B.

up_{read,write}() / mutex_unlock() release 'B', the actual lock, early,
and then take 'A', the internal lock, to actually implement the release.

That way lockdep doesn't see the B-A order :-)

> There might also be other places that need to lock A for a short time,
> either inside and outside of lock B.

Any cases that aren't covered by the current implementation of rwsems ?
