Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD24CC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 07:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89E5D214F1
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 07:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JiUND/gj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725778AbgIKHgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 03:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbgIKHgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 03:36:11 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FCB3C061756
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 00:36:10 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id 19so7157135qtp.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 00:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AgNHmGolg065FIPbyM/md78J/4QNU3wlyP9uV/8/RYg=;
        b=JiUND/gjxrV/gBkj143394Hm2srxooce7sGxGfCQSsiLfV4lvwc6tVZuZPj155tOU6
         L3uPm0geiPdeXrRMHUqYgtM1qD7dGKHVMcQxgnkI2FGfUqQIOcs4r9zAl+XEbYLULF9c
         Dr5ibZj4jpH+Vo1ZDbAr29HeknsCBt1a77gCErDYBN1Xp6zKczaF5v3KAjaP2MRH2aT3
         M/6dsFHremiT4SeSPVFW9cWRPT5HMEw2EVJFSVTaZ0/V/Wy5USdxStUEt0CtIL7ZlXia
         otL+xA3gFKF3xHSOh69ooIli779AmgDhoKeNtAUCnw5T6RPdmbPRd5Eod2PxXe0ZFbB2
         4gyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AgNHmGolg065FIPbyM/md78J/4QNU3wlyP9uV/8/RYg=;
        b=XkYP2pZ8TwRu1qHbfD07BBGj838pOZ8F9i8ZJaT1u9xHDvnLW+/0il4x7b4G3a2ywW
         pG3e4isna4vRWBVBN8zPhV/SHuGnoaJB4ElLke4GUp2RXXIu038s5ZaP1X3YJUCNwe/K
         4GFg/oe9TcDwEQSiXpVR9Hnh1FrlCRl9XCjdrhmpYVKuS1iTpNlcq2oS79TVKdwh9ltu
         XynT4Umioth5UZrXyAU/eWfe+gv8Sebpo8D4ax4myYzuTNDYBvYejeX6K0VqKdRylUqn
         RWvB8ujHKj3HCPbO+wLKiB3kvp8zK07foy4Xb8ZtnmENrbQlH9zwnMHQfEvvVwGr06G8
         eTSg==
X-Gm-Message-State: AOAM532g4FR+rAKhUUSontIdAUcALHD9sYzzuuapaglGPr+Pv7wdz4Np
        OYjHY+qXgQGZ2YmMpbaMd9fEYxTtSE4aZXvUYBbkbw==
X-Google-Smtp-Source: ABdhPJxHoNHd4QLdks06t0G4pvWYQGyvt9teUFNsQIlgL4vGramjgW27KW2RfbNH8qlUHaNUu+IXpXoAS+47ksJC4eQ=
X-Received: by 2002:ac8:5215:: with SMTP id r21mr667601qtn.257.1599809769436;
 Fri, 11 Sep 2020 00:36:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200907134055.2878499-1-elver@google.com> <e399d8d5-03c2-3c13-2a43-3bb8e842c55a@intel.com>
 <20200908153102.GB61807@elver.google.com> <feb73053-17a6-8b43-5b2b-51a813e81622@suse.cz>
 <20200908155631.GC61807@elver.google.com>
In-Reply-To: <20200908155631.GC61807@elver.google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 11 Sep 2020 09:35:58 +0200
Message-ID: <CACT4Y+YZqj0CJTumpHr-g9HcRgs+JHwWP5eg1nYHP0E-Zw25DQ@mail.gmail.com>
Subject: Re: [PATCH RFC 00/10] KFENCE: A low-overhead sampling-based memory
 safety error detector
To:     Marco Elver <elver@google.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Dave Hansen <dave.hansen@intel.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Pekka Enberg <penberg@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>, Qian Cai <cai@lca.pw>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 8, 2020 at 5:56 PM Marco Elver <elver@google.com> wrote:
>
> On Tue, Sep 08, 2020 at 05:36PM +0200, Vlastimil Babka wrote:
> > On 9/8/20 5:31 PM, Marco Elver wrote:
> > >>
> > >> How much memory overhead does this end up having?  I know it depends on
> > >> the object size and so forth.  But, could you give some real-world
> > >> examples of memory consumption?  Also, what's the worst case?  Say I
> > >> have a ton of worst-case-sized (32b) slab objects.  Will I notice?
> > >
> > > KFENCE objects are limited (default 255). If we exhaust KFENCE's memory
> > > pool, no more KFENCE allocations will occur.
> > > Documentation/dev-tools/kfence.rst gives a formula to calculate the
> > > KFENCE pool size:
> > >
> > >     The total memory dedicated to the KFENCE memory pool can be computed as::
> > >
> > >         ( #objects + 1 ) * 2 * PAGE_SIZE
> > >
> > >     Using the default config, and assuming a page size of 4 KiB, results in
> > >     dedicating 2 MiB to the KFENCE memory pool.
> > >
> > > Does that clarify this point? Or anything else that could help clarify
> > > this?
> >
> > Hmm did you observe that with this limit, a long-running system would eventually
> > converge to KFENCE memory pool being filled with long-aged objects, so there
> > would be no space to sample new ones?
>
> Sure, that's a possibility. But remember that we're not trying to
> deterministically detect bugs on 1 system (if you wanted that, you
> should use KASAN), but a fleet of machines! The non-determinism of which
> allocations will end up in KFENCE, will ensure we won't end up with a
> fleet of machines of identical allocations. That's exactly what we're
> after. Even if we eventually exhaust the pool, you'll still detect bugs
> if there are any.
>
> If you are overly worried, either the sample interval or number of
> available objects needs to be tweaked to be larger. The default of 255
> is quite conservative, and even using something larger on a modern
> system is hardly noticeable. Choosing a sample interval & number of
> objects should also factor in how many machines you plan to deploy this
> on. Monitoring /sys/kernel/debug/kfence/stats can help you here.

Hi Marco,

I reviewed patches and they look good to me (minus some local comments
that I've left).

The main question/concern I have is what Vlastimil mentioned re
long-aged objects.
Is the default sample interval values reasonable for typical
workloads? Do we have any guidelines on choosing the sample interval?
Should it depend on workload/use pattern?
By "reasonable" I mean if the pool will last long enough to still
sample something after hours/days? Have you tried any experiments with
some workload (both short-lived processes and long-lived
processes/namespaces) capturing state of the pool? It can make sense
to do to better understand dynamics. I suspect that the rate may need
to be orders of magnitude lower.

Also I am wondering about the boot process (both kernel and init).
It's both inherently almost the same for the whole population of
machines and inherently produces persistent objects. Should we lower
the rate for the first minute of uptime? Or maybe make it proportional
to uptime?

I feel it's quite an important aspect. We can have this awesome idea
and implementation, but radically lower its utility by using bad
sampling value (which will have silent "failure mode" -- no bugs
detected).

But to make it clear: all of this does not conflict with the merge of
the first version. Just having tunable sampling interval is good
enough. We will get the ultimate understanding only when we start
using it widely anyway.
