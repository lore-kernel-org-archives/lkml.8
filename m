Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E48DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 11:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 651BB207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 11:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o9WbLLPr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404220AbgFYL3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 07:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403997AbgFYL3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 07:29:52 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109B6C061573
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 04:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fXCHQRpJ34HMUF2mE+6g5VzQO598DF13gdLnlC4s9Ls=; b=o9WbLLPrIAEPqOYbQtLUUJrbN9
        PXZDcuhUC/NJTa9HGeNz7UsLPcgg0RYFdoeKQWJWijvg7b8gmpYZotdjtJVpiRGMuNq+It63B3jWt
        G0HDtvO0rJZPemFiCdwGhnz7KWI2hB82Qk4yY9u4a5PK099Z4cd/cQyeTbbAw1LBuJm/EjDSIW8Dk
        LOxSzzX4vFcgCD+rWS5qAxMR4WQJ1pSJancBwZ7oVy+97m5kcROU4fnQ81EwUu1Zf0vex7UbAp6Zn
        45d3Kx4REtuyILGF4kaW9pekSkRkaTD6yETtm/82ZAWrTGup7d/7IeGdkeyqclXFpwxfEyX/yDSJM
        8L2Q3VWQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1joQ4N-0001qd-6Z; Thu, 25 Jun 2020 11:29:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 32E23301A7A;
        Thu, 25 Jun 2020 13:29:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1A00A20707D3A; Thu, 25 Jun 2020 13:29:26 +0200 (CEST)
Date:   Thu, 25 Jun 2020 13:29:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        LKML <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [rcu:rcu/next 35/35] kernel/rcu/tree.c:251:8: error: implicit
 declaration of function 'arch_atomic_add_return'; did you mean
Message-ID: <20200625112926.GO4781@hirez.programming.kicks-ass.net>
References: <202006250300.ic32FsdY%lkp@intel.com>
 <20200624203025.GJ9247@paulmck-ThinkPad-P72>
 <CANpmjNO5uBSZj0gHy0t+O2VhD+UjG58+zON0AFX8i7MNSO5a6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNO5uBSZj0gHy0t+O2VhD+UjG58+zON0AFX8i7MNSO5a6Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 11:55:13AM +0200, Marco Elver wrote:
> On Wed, 24 Jun 2020 at 22:30, Paul E. McKenney <paulmck@kernel.org> wrote:

> > diff --git a/include/linux/atomic-fallback.h b/include/linux/atomic-fallback.h
> > index 2c4927b..b7935857 100644
> > --- a/include/linux/atomic-fallback.h
> > +++ b/include/linux/atomic-fallback.h
> > @@ -133,6 +133,7 @@ atomic_add_return(int i, atomic_t *v)
> >         return ret;
> >  }
> >  #define atomic_add_return atomic_add_return
> > +#define arch_atomic_add_return atomic_add_return
> >  #endif
> >
> >  #endif /* atomic_add_return_relaxed */
> >
> > ------------------------------------------------------------------------
> >
> > And of course similar for arch_atomic_andnot() and arch_atomic_read().
> >
> > Another way would be to define a noinstr_atomic_add_return() that
> > was defined something like this:
> >
> > ------------------------------------------------------------------------
> >
> > #ifdef CONFIG_HAVE_ARCH_KCSAN
> > # define noinstr_atomic_add_return arch_atomic_add_return
> > #else
> > # define noinstr_atomic_add_return atomic_add_return
> > #endif
> 
> noinstr also needs to apply to KASAN & co, so this won't quite work.
> Every architecture that defines arch_atomic_* has #define ARCH_ATOMIC,
> so that could be used instead.

Right. And my bad for forgetting arch_atomic_ isn't generally available
:/

> > ------------------------------------------------------------------------
> >
> > And again similarly for the others.
> >
> > Left to myself, I would take the second option just because it provably
> > leaves unaltered anything that isn't using the new API.  That said,
> > there has to be a better Kconfig option to key this off of.
> >
> > Thoughts?
> 
> I think 'arch_atomic_*' is already the noinstr variant, and your first
> suggestion of adding arch-defines to atomic-fallback.h seems cleaner,
> as it avoids introducing new interfaces. But that also depends on if
> it's a one-off, only for RCU, or if the use of 'arch_atomic'
> proliferates outside of arch/. My guess is that, unfortunately, other
> places will want 'arch_atomic' as well eventually.

I fear the same. Let me see if I can quickly modify the atomic scripts
to generate the required fallbacks.
