Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEC7C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D91D8207DE
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HRIGydaP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732665AbgIHUDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 16:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730470AbgIHPYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:24:02 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7994DC0619EC
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 08:21:36 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id c19so14557197wmd.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 08:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UKA8pKnO1XgI5TJnprRPT/npi5cBz+avnhKYxtTWBW4=;
        b=HRIGydaPAJkaOWuBKc7d27QZz482FZ8rdxSZz6uNdbw5Su/m6qKHUczYNAP6sSydlY
         SNsXYqqSmJdpZTnrP6V1iIozB1fW9Z+0JFH7M56c+ilSEh9sqSauJtmNlSXdyBjohBiB
         TDbG8PVekF+JFayFi5Z0L8LdKwC2skqUGDXRTStkwl1qX21is4XqFwmAQciUgnoX85F/
         B1OM0qfh5OFlBLwkd/XsxUEnoOPnf9+Mnthhd1cS35JdLOOWxo/gfGP7RDKTxFfvOADe
         Ky0FOihRMcxrl0xU2I5v3tDoPhh8ErdajJR9PSz8TLDBie0V25qN4NN+MhyEr7gk9sgo
         qH6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UKA8pKnO1XgI5TJnprRPT/npi5cBz+avnhKYxtTWBW4=;
        b=CXJQEfjkqsrXg2/NBD7yBWMHEIN/qSPYHZMQKjJi7i0vQDE+Lu1T6tDLmQ6VqDfqMr
         53p1DSLotnKJE/NZGvQH+k+ctu5K+LfnWhE/oDBMLyfu+csWxslJBEBhDU46ppa1si6V
         8x24b6XIQZf1IAEzORHCDyfeEOBrKAKyx1h0lx2YBu34gUCaVbBe+cbdVDjdMcrvEWfP
         7oZMdzfp0E9nr4MTRygBGtki57NuL7OOz0MqqTvURJS86bGNkuabvg4+mEWJOKkNdS9k
         kKIIm8vaepdia21ttzStg4iMLfo3WxWpjkDajOZlINPMWTnvsNIpGCWJecPcJzro4GYx
         raZg==
X-Gm-Message-State: AOAM5329+rUxLaeVHlWtUBISzODD6vjk8gjPfvy0MO7//Cxx9klQaA14
        hlT4Rtv48E9mMcV1Y7ydrnDoMg==
X-Google-Smtp-Source: ABdhPJzR5sEeN+3WkgbqqiMs+xGyY3ppaJbCxHcVgY+v/r3iEbblqpBNU1uJoIblL1gF5vuYTSpBhg==
X-Received: by 2002:a1c:7e83:: with SMTP id z125mr96250wmc.32.1599578494903;
        Tue, 08 Sep 2020 08:21:34 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id c10sm31766553wmk.30.2020.09.08.08.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 08:21:33 -0700 (PDT)
Date:   Tue, 8 Sep 2020 17:21:28 +0200
From:   Marco Elver <elver@google.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Pekka Enberg <penberg@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, paulmck@kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>, dave.hansen@linux.intel.com,
        Dmitriy Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>, Qian Cai <cai@lca.pw>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH RFC 00/10] KFENCE: A low-overhead sampling-based memory
 safety error detector
Message-ID: <20200908152128.GA61807@elver.google.com>
References: <20200907134055.2878499-1-elver@google.com>
 <4dc8852a-120d-0835-1dc4-1a91f8391c8a@suse.cz>
 <CAG_fn=UdnN4EL6OtAV8RY7kuqO+VXqSsf+grx2Le64UQJOUMvQ@mail.gmail.com>
 <1c4a5a6e-1f11-b04f-ebd0-17919ba93bca@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c4a5a6e-1f11-b04f-ebd0-17919ba93bca@suse.cz>
User-Agent: Mutt/1.14.4 (2020-06-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 04:40PM +0200, Vlastimil Babka wrote:
> On 9/8/20 2:16 PM, Alexander Potapenko wrote:
> >> Toggling a static branch is AFAIK quite disruptive (PeterZ will probably tell
> >> you better), and with the default 100ms sample interval, I'd think it's not good
> >> to toggle it so often? Did you measure what performance would you get, if the
> >> static key was only for long-term toggling the whole feature on and off (boot
> >> time or even runtime), but the decisions "am I in a sample interval right now?"
> >> would be normal tests behind this static key? Thanks.
> > 
> > 100ms is the default that we use for testing, but for production it
> > should be fine to pick a longer interval (e.g. 1 second or more).
> > We haven't noticed any performance impact with neither 100ms nor bigger values.
> 
> Hmm, I see.

To add to this, we initially also weren't sure what the results would be
toggling the static branches at varying intervals. In the end we were
pleasantly surprised, and our benchmarking results always proved there
is no noticeable slowdown above 100ms (somewhat noticeable in the range
of 1-10ms but it's tolerable if you wanted to go there).

I think we were initially, just like you might be, deceived about the
time scales here. 100ms is a really long time for a computer.

> > Regarding using normal branches, they are quite expensive.
> > E.g. at some point we used to have a branch in slab_free() to check
> > whether the freed object belonged to KFENCE pool.
> > When the pool address was taken from memory, this resulted in some
> > non-zero performance penalty.
> 
> Well yeah, if the checks involve extra cache misses, that adds up. But AFAICS
> you can't avoid that kind of checks with static key anyway (am I looking right
> at is_kfence_address()?) because some kfence-allocated objects will exist even
> after the sampling period ended, right?
> So AFAICS kfence_alloc() is the only user of the static key and I wonder if it
> really makes such difference there.

The really important bit here is to differentiate between fast-paths and
slow-paths!

We insert kfence_alloc() into the allocator fast-paths, which is where
the majority of cost would be. On the other hand, the major user of
is_kfence_address(), kfence_free(), is only inserted into the slow-path.

As a result, is_kfence_address() usage has negligible cost (esp. if the
statically allocated pool is used) -- we benchmarked this quite
extensively.

> > As for enabling the whole feature at runtime, our intention is to let
> > the users have it enabled by default, otherwise someone will need to
> > tell every machine in the fleet when the feature is to be enabled.
> 
> Sure, but I guess there are tools that make it no difference in effort between 1
> machine and fleet.
> 
> I'll try to explain my general purpose distro-kernel POV. What I like e.g. about
> debug_pagealloc and page_owner (and contributed to that state of these features)
> is that a distro kernel can be shipped with them compiled in, but they are
> static-key disabled thus have no overhead, until a user enables them on boot,
> without a need to replace the kernel with a debug one first. Users can enable
> them for their own debugging, or when asked by somebody from the distro
> assisting with the debugging.
> 
> I think KFENCE has similar potential and could work the same way - compiled in
> always, but a static key would eliminate everything, even the
> is_kfence_address() checks,

[ See my answer for the cost of is_kfence_address() above. In short,
  until we add is_kfence_address() to fast-paths, introducing yet
  another static branch would be premature optimization. ]

> until it became enabled (but then it would probably
> be a one-way street for the rest of the kernel's uptime). Some distro users
> would decide to enable it always, some not, but could be advised to when needed.
> So the existing static key could be repurposed for this, or if it's really worth
> having the current one to control just the sampling period, then there would be two?

You can already do this. Just set CONFIG_KFENCE_SAMPLE_INTERVAL=0. When
you decide to enable it, set kfence.sample_interval=<somenumber> as a
boot parameter.

I'll add something to that effect into Documentation/dev-tools/kfence.rst.

Thanks,
-- Marco
