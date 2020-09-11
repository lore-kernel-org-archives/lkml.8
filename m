Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B93C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61C5A221EB
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gPyGKwnG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgIKQg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbgIKQeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 12:34:04 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEC3C061573
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 09:34:04 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id m7so8579519oie.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 09:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LXuI1+2niHV1f/itEDtLBlt+egT8GEGRmfKrWMZ85Ng=;
        b=gPyGKwnGM1G4h49Vz2S2gxB+Iub1XTLvkXVUxUDWA9zqi3G6XLGlEH+NbXH92MinNL
         bPp+fmjiAji2QO8/gVFHtFwnXp4Q3BFZnDYqgI/m4dGxmyY68jLER1kQu9rST+AFag/n
         RHpNL2CDn1B8ZlJBMMrHj7PUnc4xIWd4L6iMoYbfjWv71mVlAjxn7Tkg63j79tBeqkhr
         vTgN6cNA5c/XhSanFsKnUKeWF3Gt2JEByZzJ/qxTGfe4SwmqY/JHUoiLaGklx83GFHuT
         7N//ZByW/IvZjob5vVqze7DrtCfZiSDfQK/5UwatBjtWOV99ErfEL6NSWqD9nwo0H5jh
         sy1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LXuI1+2niHV1f/itEDtLBlt+egT8GEGRmfKrWMZ85Ng=;
        b=raUiCcsW7FK6BObzayUMWE1WyUX8D8dG5YSY9A66ku/fiWY3hT5gXUK6Y89ZKFwWt6
         2LPOYwEj637EPW+tpjgZx12j+j5+bAIJ+m/NvNHefm21qtUWLfTtq4Qt567ttjMJQFBT
         vruJCyIn+2ZSIVUMZbtgQ9nePYwpHqIYhrc7qwstNV/100Z8tA3NzbauduvxmcYNI3gG
         ABpshlBFWtJicrZ83zClqSxRjfZ5n61c//px8Gl7uBO8pSBM+ryN/CqLBoY1cQYDrtTY
         YZLdLL+fLcA94t6/1mbIqZErChwzbgbS8oAPURCUAcBQtbjsYit/2ETrH4mNGk0JvMR+
         cPVQ==
X-Gm-Message-State: AOAM530WYE9u/G2HhIebgXXj+FBn0Bzrtfe1B4HJ769de5mqfb6yxurV
        LCC5YElbqdJur8G6jbi4zg01eLEeysWKiq2M1/2CBw==
X-Google-Smtp-Source: ABdhPJwGiZMFMPYdc2jzGyDoUKrANSuGf5WBAyb+m1FAjK+gLOrz9ts2OJiDc13pK0JCuZAVplb5SoIninhtNvLBI3s=
X-Received: by 2002:aca:54d1:: with SMTP id i200mr1720432oib.172.1599842043737;
 Fri, 11 Sep 2020 09:34:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200907134055.2878499-1-elver@google.com> <e399d8d5-03c2-3c13-2a43-3bb8e842c55a@intel.com>
 <20200908153102.GB61807@elver.google.com> <feb73053-17a6-8b43-5b2b-51a813e81622@suse.cz>
 <20200908155631.GC61807@elver.google.com> <CACT4Y+YZqj0CJTumpHr-g9HcRgs+JHwWP5eg1nYHP0E-Zw25DQ@mail.gmail.com>
 <CANpmjNO7XwhefA+NKszVkNqj8a60QY45n-=EUtGns+ysNYV9mQ@mail.gmail.com>
 <CACT4Y+YSQDjEh6+XMXiHvMaKAT8bA=JkC8xY3AXfcSk+f9yR+g@mail.gmail.com> <CANpmjNNWOVi317bF_E=QdcSSd5x6Dfk=+nECA9VnZSLGMKigYQ@mail.gmail.com>
In-Reply-To: <CANpmjNNWOVi317bF_E=QdcSSd5x6Dfk=+nECA9VnZSLGMKigYQ@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 11 Sep 2020 18:33:52 +0200
Message-ID: <CANpmjNN_OPCvWPnb62nu+B94t7P54utAH6BGaRYuYuuCfygzig@mail.gmail.com>
Subject: Re: [PATCH RFC 00/10] KFENCE: A low-overhead sampling-based memory
 safety error detector
To:     Dmitry Vyukov <dvyukov@google.com>
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

On Fri, 11 Sep 2020 at 15:33, Marco Elver <elver@google.com> wrote:
> On Fri, 11 Sep 2020 at 15:10, Dmitry Vyukov <dvyukov@google.com> wrote:
> > On Fri, Sep 11, 2020 at 2:03 PM Marco Elver <elver@google.com> wrote:
> > > On Fri, 11 Sep 2020 at 09:36, Dmitry Vyukov <dvyukov@google.com> wrote:
> [...]
> > > > By "reasonable" I mean if the pool will last long enough to still
> > > > sample something after hours/days? Have you tried any experiments with
> > > > some workload (both short-lived processes and long-lived
> > > > processes/namespaces) capturing state of the pool? It can make sense
> > > > to do to better understand dynamics. I suspect that the rate may need
> > > > to be orders of magnitude lower.
> > >
> > > Yes, the current default sample interval is a lower bound, and is also
> > > a reasonable default for testing. I expect real deployments to use
> > > much higher sample intervals (lower rate).
> > >
> > > So here's some data (with CONFIG_KFENCE_NUM_OBJECTS=1000, so that
> > > allocated KFENCE objects isn't artificially capped):
> > >
> > > -- With a mostly vanilla config + KFENCE (sample interval 100 ms),
> > > after ~40 min uptime (only boot, then idle) I see ~60 KFENCE objects
> > > (total allocations >600). Those aren't always the same objects, with
> > > roughly ~2 allocations/frees per second.
> > >
> > > -- Then running sysbench I/O benchmark, KFENCE objects allocated peak
> > > at 82. During the benchmark, allocations/frees per second are closer
> > > to 10-15. After the benchmark, the KFENCE objects allocated remain at
> > > 82, and allocations/frees per second fall back to ~2.
> > >
> > > -- For the same system, changing the sample interval to 1 ms (echo 1 >
> > > /sys/module/kfence/parameters/sample_interval), and re-running the
> > > benchmark gives me: KFENCE objects allocated peak at exactly 500, with
> > > ~500 allocations/frees per second. After that, allocated KFENCE
> > > objects dropped a little to 496, and allocations/frees per second fell
> > > back to ~2.
> > >
> > > -- The long-lived objects are due to caches, and just running 'echo 1
> > > > /proc/sys/vm/drop_caches' reduced allocated KFENCE objects back to
> > > 45.
> >
> > Interesting. What type of caches is this? If there is some type of
> > cache that caches particularly lots of sampled objects, we could
> > potentially change the cache to release sampled objects eagerly.
>
> The 2 major users of KFENCE objects for that workload are
> 'buffer_head' and 'bio-0'.
>
> If we want to deal with those, I guess there are 2 options:
>
> 1. More complex, but more precise: make the users of them check
> is_kfence_address() and release their buffers earlier.
>
> 2. Simpler, generic solution: make KFENCE stop return allocations for
> non-kmalloc_caches memcaches after more than ~90% of the pool is
> exhausted. This assumes that creators of long-lived objects usually
> set up their own memcaches.
>
> I'm currently inclined to go for (2).

Ok, after some offline chat, we determined that (2) would be premature
and we can't really say if kmalloc should have precedence if we reach
some usage threshold. So for now, let's just leave as-is and start
with the recommendation to monitor and adjust based on usage, fleet
size, etc.

Thanks,
-- Marco
