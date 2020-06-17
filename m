Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3994C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F98821527
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rqfiepsu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgFQQhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 12:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgFQQhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 12:37:07 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07ECC06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 09:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tlT1YMQ39uBGe7lMvNKoVc7btUmDBldnB9RGq7PSmdU=; b=rqfiepsuCi33loo8rMB96DxiAu
        9w1NY+X3myOmpj2D05fXb86U9Uvxn2NgLG4docMa0ChJ5PwKyPHQ/fTlpO5dfO6TcQQ9aYiWDyUVD
        IVx34rDpmlyL4guEZHN/KqXDljXE4p94UjziFzMBz8NJIteRNMOxjBTX76Bc1bv3S4FI8q5FgvXvP
        ifdRrUqkvkx44ictM3ik9G2qTUIGZ9SC2ogO5AxUYcfMAgzWW9GcXRtBVzOFnLbygyzA5Pcv8vWcB
        uWlrV/TGl65l5YBxBXzLHazsN9QI8UViP/kzrx7J3bAziA6oVuQ1LHXoT3zqTIYoZw4c5jbb+fGea
        v0RarUAg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jlb3G-0000tM-Mw; Wed, 17 Jun 2020 16:36:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0C32E3017B7;
        Wed, 17 Jun 2020 18:36:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F0F372BA7AE07; Wed, 17 Jun 2020 18:36:35 +0200 (CEST)
Date:   Wed, 17 Jun 2020 18:36:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, ndesaulniers@google.com,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH -tip v3 1/2] kcov: Make runtime functions
 noinstr-compatible
Message-ID: <20200617163635.GC576905@hirez.programming.kicks-ass.net>
References: <CACT4Y+bBtCbEk2tg60gn5bgfBjARQFBgtqkQg8VnLLg5JwyL5g@mail.gmail.com>
 <CANpmjNM+Tcn40MsfFKvKxNTtev-TXDsosN+z9ATL8hVJdK1yug@mail.gmail.com>
 <20200615142949.GT2531@hirez.programming.kicks-ass.net>
 <20200615145336.GA220132@google.com>
 <20200615150327.GW2531@hirez.programming.kicks-ass.net>
 <20200615152056.GF2554@hirez.programming.kicks-ass.net>
 <20200617143208.GA56208@elver.google.com>
 <20200617144949.GA576905@hirez.programming.kicks-ass.net>
 <20200617151959.GB56208@elver.google.com>
 <20200617155517.GB576905@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617155517.GB576905@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 05:55:17PM +0200, Peter Zijlstra wrote:
> On Wed, Jun 17, 2020 at 05:19:59PM +0200, Marco Elver wrote:
> 
> > > Does GCC (8, as per the new KASAN thing) have that
> > > __builtin_memcpy_inline() ?
> > 
> > No, sadly it doesn't. Only Clang 11. :-/
> > 
> > But using a call to __memcpy() somehow breaks with Clang+KCSAN. Yet,
> > it's not the memcpy that BUGs, but once again check_preemption_disabled
> > (which is noinstr!). Just adding calls anywhere here seems to results in
> > unpredictable behaviour. Are we running out of stack space?
> 
> Very likely, bad_iret is running on that entry_stack you found, and as
> you found, it is puny.
> 
> Andy wanted to make it a full page a while ago, so I suppose the
> question is do we do that now?

Andy suggested doing the full page; untested patches here:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/entry


