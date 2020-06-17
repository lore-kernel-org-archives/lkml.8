Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73232C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 15:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E302206FA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 15:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KHJyeHZ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbgFQPUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 11:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgFQPUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 11:20:07 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4909EC06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 08:20:07 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id f185so2429790wmf.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 08:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qQ975hNqevvgdpm9NCP0Rb6tLrxCJzAg5/lXYcYf+h8=;
        b=KHJyeHZ10s41JrpZB5Pc/j1c0X6zwewzhIcG6+slF3BXsbLNgM68q19y6KINW6c6hy
         PCxOrAWwzVEhxy99/vLZbzGr7lFQM+sg/uZ4BV6KaCaq8NPT5UZzsLfn333MrMJBDWom
         FhoE3j3hY/XwZLX7TMKVRyDwBCTAhD+bxH4N6thblp8zewokqlW2IFGupUCSR4HF0m4l
         +5MG0QxTH9MdGya3P8+AfKe5RaBGHF5yqrpsgAyvykNXjWatfDv7xdSvPXqKxrEprDf2
         XBhjLSJV3kAWfaAqmK5o8gGMeBy0WEY2c8rEhuB0GDRvmPAZc46/iEFVXhJQfpuAlxDL
         tJbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qQ975hNqevvgdpm9NCP0Rb6tLrxCJzAg5/lXYcYf+h8=;
        b=YUQamQKP+ikmIYpKkSS12lOUJFMg1VjA/GT1iFX6uy5OqwJKGxzYUMiu3k7HxeuQuf
         OZlDfecVijvDmCXuDEhbEEjqzJFRcJLm7gYyme87GcoE+WPgHuNgTyfOf3eRcLYOEcst
         N6+jYvx9iZD9X9xSbZHg32W0zvJAE6sqjwtAFi1UGknbVJTwvE90vY+kFWq/hYfPRIXT
         /Ppa/WCxk21yf+2qtmA3Ebs1vId9cxlb8yPrm2KeIOpoY5ssZB4G6uIesJPLm7yMFk5M
         372n0hxbgkX5CwCWozrmXnP142/Gw+8pzev0w1sYV+Sf4dM8MjWhLmB6j65uTjwSjlw7
         HU4g==
X-Gm-Message-State: AOAM533SZMXOFkGSIqtS9YGVecF/D1CCR7Oc/H+lyT3PIc3mUW/pcF4L
        XuFhRBGCxqqN3Uj3z30md2CENA==
X-Google-Smtp-Source: ABdhPJzxXi+k4xt6/8AjeT5X6w4VGU6MH0iQudesf13obIJDxGt0ltGvw7qXmHobQjAGY4eLn0WMZQ==
X-Received: by 2002:a1c:5fd4:: with SMTP id t203mr8524133wmb.184.1592407205801;
        Wed, 17 Jun 2020 08:20:05 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id y14sm76303wma.25.2020.06.17.08.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 08:20:05 -0700 (PDT)
Date:   Wed, 17 Jun 2020 17:19:59 +0200
From:   Marco Elver <elver@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
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
        Josh Poimboeuf <jpoimboe@redhat.com>, ndesaulniers@google.com
Subject: Re: [PATCH -tip v3 1/2] kcov: Make runtime functions
 noinstr-compatible
Message-ID: <20200617151959.GB56208@elver.google.com>
References: <CACT4Y+aKVKEp1yoBYSH0ebJxeqKj8TPR9MVtHC1Mh=jgX0ZvLw@mail.gmail.com>
 <20200612114900.GA187027@google.com>
 <CACT4Y+bBtCbEk2tg60gn5bgfBjARQFBgtqkQg8VnLLg5JwyL5g@mail.gmail.com>
 <CANpmjNM+Tcn40MsfFKvKxNTtev-TXDsosN+z9ATL8hVJdK1yug@mail.gmail.com>
 <20200615142949.GT2531@hirez.programming.kicks-ass.net>
 <20200615145336.GA220132@google.com>
 <20200615150327.GW2531@hirez.programming.kicks-ass.net>
 <20200615152056.GF2554@hirez.programming.kicks-ass.net>
 <20200617143208.GA56208@elver.google.com>
 <20200617144949.GA576905@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617144949.GA576905@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.13.2 (2019-12-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 04:49PM +0200, Peter Zijlstra wrote:
> On Wed, Jun 17, 2020 at 04:32:08PM +0200, Marco Elver wrote:
> > On Mon, Jun 15, 2020 at 05:20PM +0200, Peter Zijlstra wrote:
> > > On Mon, Jun 15, 2020 at 05:03:27PM +0200, Peter Zijlstra wrote:
> > > 
> > > > Yes, I think so. x86_64 needs lib/memcpy_64.S in .noinstr.text then. For
> > > > i386 it's an __always_inline inline-asm thing.
> > > 
> > > Bah, I tried writing it without memcpy, but clang inserts memcpy anyway
> > > :/
> > 
> > Hmm, __builtin_memcpy() won't help either.
> > 
> > Turns out, Clang 11 got __builtin_memcpy_inline(): https://reviews.llvm.org/D73543
> > 
> > The below works, no more crash on either KASAN or KCSAN with Clang. We
> > can test if we have it with __has_feature(__builtin_memcpy_inline)
> > (although that's currently not working as expected, trying to fix :-/).
> > 
> > Would a memcpy_inline() be generally useful? It's not just Clang but
> > also GCC that isn't entirely upfront about which memcpy is inlined and
> > which isn't. If the compiler has __builtin_memcpy_inline(), we can use
> > it, otherwise the arch likely has to provide the implementation.
> > 
> > Thoughts?
> 
> I had the below, except of course that yields another objtool
> complaint, and I was still looking at that.
> 
> Does GCC (8, as per the new KASAN thing) have that
> __builtin_memcpy_inline() ?

No, sadly it doesn't. Only Clang 11. :-/

But using a call to __memcpy() somehow breaks with Clang+KCSAN. Yet,
it's not the memcpy that BUGs, but once again check_preemption_disabled
(which is noinstr!). Just adding calls anywhere here seems to results in
unpredictable behaviour. Are we running out of stack space?

Thanks,
-- Marco
