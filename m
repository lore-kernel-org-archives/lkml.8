Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE6EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1B532067C
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="csMUSrDv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbgHFSAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 14:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbgHFSAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 14:00:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079DCC061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 11:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MT2ki/o/y2NYLP7okz7irOUiWq3okJ0oQaW4u8dEtZ8=; b=csMUSrDvvlCdx4/Ssvp4kGJ1TP
        hb8CaqPBTZ0O6u68hn+qsG4db4LRN2L9ruW/eoh+735CKrmBOPiKcOwMWmilgOcj59zdVjMbGzIVd
        6LJ9QGeUu74MwL03AW1zgIOKemRZHL0lm+slWK6gnSFuWZ+0mQdIaMd9Ws1Z/wHXukNj/oo1eVuIW
        /+rYYtfZ+iBiyS9aX9GIQvrR7ewNTl4X2/kigsQYm98XrU3amMXE2HfECxXFW750jaFDcmKszXWQP
        rF3QRj7zout7ThNZg9lS55fU0aKje9K4e+28hjVV5tZMLZB01cs+kR/TrEQE+irvMA6gqU4BJkJ44
        zGudRwug==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k3kBk-0007g8-HC; Thu, 06 Aug 2020 18:00:24 +0000
Date:   Thu, 6 Aug 2020 19:00:24 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH] mm: silence soft lockups from unlock_page
Message-ID: <20200806180024.GB17456@casper.infradead.org>
References: <20200724152424.GC17209@redhat.com>
 <CAHk-=whuG+5pUeUqdiW4gk0prvqu7GZSMo-6oWv5PdDC5dBr=A@mail.gmail.com>
 <CAHk-=wjYHvbOs9i39EnUsC6VEJiuJ2e_5gZB5-J5CRKxq80B_Q@mail.gmail.com>
 <20200725101445.GB3870@redhat.com>
 <CAHk-=whSJbODMVmxxDs64f7BaESKWuMqOxWGpjUSDn6Jzqa71g@mail.gmail.com>
 <alpine.LSU.2.11.2007251343370.3804@eggly.anvils>
 <alpine.LSU.2.11.2007252100230.5376@eggly.anvils>
 <alpine.LSU.2.11.2007261246530.6812@eggly.anvils>
 <alpine.LSU.2.11.2008052105040.8716@eggly.anvils>
 <CAHk-=whf7wCUV2oTDUg0eeNafhhk_OhJBT2SbHZXwgtmAzNeTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whf7wCUV2oTDUg0eeNafhhk_OhJBT2SbHZXwgtmAzNeTg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 10:07:07AM -0700, Linus Torvalds wrote:
> On Wed, Aug 5, 2020 at 10:21 PM Hugh Dickins <hughd@google.com> wrote:
> > Something I was interested to realize in looking at this: trylock_page()
> > on a contended lock is now much less likely to jump the queue and
> > succeed than before, since your lock holder hands off the page lock to
> > the next holder: much smaller window than waiting for the next to wake
> > to take it. Nothing wrong with that, but effect might be seen somewhere.
> 
> Yeah, the window is smaller, but it's not gone.
> 
> It *might* be interesting to actually do the handover directly from
> "unlock_page()", and avoid clearing (and then setting) the bit
> entirely.
> 
> Something like the attached TOTALLY UNTESTED patch.
> 
> NOTE! Sometimes when I say something is untested, I think the patch is
> fine because it's simple and straightforward, I just didn't test it.
> 
> This time it's both untested and very very subtle indeed. Did I get
> the hand-over case SMP memory barriers right? Did I screw something
> else up?
> 
> So this might be complete garbage. I really don't know. But it might
> close the window for an unfair trylock (or lucky page_lock())
> entirely.

It wasn't clear to me whether Hugh thought it was an improvement or
not that trylock was now less likely to jump the queue.  There're
the usual "fair is the opposite of throughput" kind of arguments.


