Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229B1C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD2B8206DB
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cL1oEi6G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgIKQ0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgIKPWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:22:41 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE778C06179A
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 06:33:56 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id n2so9474512oij.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 06:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TpsoM88cyk0U9ujavsoiNiP/xNpunXVnqQMw3rUrW70=;
        b=cL1oEi6GisMpZ+1vyaA1YZmE9+hCJmDs4kjImnwwOvOvKuOrq7EHDUtsuuabzR57Po
         K0AAX9GUto+YmGqhasb5W+vSlZpIfwGIpXn8/ZobsoDeJAJ/YCW6Jf2ybVuHSXZ02iHQ
         h6tve/Bzu8Wpl7KaWn7eZFKsYkyrouec6acrsO3QrHhdbgZgDli4Blz30Kn6EMMfCBB6
         58ax9jDb2e5Q/SgCE0G1rBCJ/6kVKL7K1KguH/4zVty6MT6Hs8WiLxSXGArkPLwwuURv
         HHvmieKXwiJoMkOUJQMjpACLQQ0BtYCF8oF3Vir4JYh/XjFSG9+Miqora4bd5lLjf1sX
         HUkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TpsoM88cyk0U9ujavsoiNiP/xNpunXVnqQMw3rUrW70=;
        b=BDMyrkthghmoxu36GwcvqAb2F4NxqKibZbWHJ7UT3A9e1+M7himbmLivuA1JIOqKmz
         fLtSc4FkKbas8Trb+vnlTCS/inqJTN+uIONUw71D5Fxqzl8AfQUBzHeZ0FJdZ5fTMwyO
         t203keZFidYBVHJ86VBelD0v1ePpO9tfoJ0yTdE5e4cz9LClJEKuWrx0sSZ6Yi3fHVWd
         7dEdW3IvQ7CY1X/Q/lXIp+HyYci1Aw2ZNb/qU20JBuvmYKvqgDg3Gq0n6tJt2m7/gAS+
         GaaWkLlzjntaU2tQ4M+hD1z09WYgKfpJoNpcB4iCww/erlYcZtAkJ5L3UAoQ9Gr1Pe9k
         yXHQ==
X-Gm-Message-State: AOAM533DVHtrMP0VgiZ0FlOWH/G0fSNFm1mQE4ycrN8sJCuOv3+My8IN
        oUikgjrR0xlBcSSBLgbhAjkARJsSSc11sFooVbVUEg==
X-Google-Smtp-Source: ABdhPJzVyxHRpCzzWlwpCs+zsjH4vVQha0aihZX+rNn7CbuvYFeOPOIR3N4j0lJ6yIb7854KZDwveUXgHPVXHY+FMZ4=
X-Received: by 2002:aca:54d1:: with SMTP id i200mr1268021oib.172.1599831235876;
 Fri, 11 Sep 2020 06:33:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200907134055.2878499-1-elver@google.com> <e399d8d5-03c2-3c13-2a43-3bb8e842c55a@intel.com>
 <20200908153102.GB61807@elver.google.com> <feb73053-17a6-8b43-5b2b-51a813e81622@suse.cz>
 <20200908155631.GC61807@elver.google.com> <CACT4Y+YZqj0CJTumpHr-g9HcRgs+JHwWP5eg1nYHP0E-Zw25DQ@mail.gmail.com>
 <CANpmjNO7XwhefA+NKszVkNqj8a60QY45n-=EUtGns+ysNYV9mQ@mail.gmail.com> <CACT4Y+YSQDjEh6+XMXiHvMaKAT8bA=JkC8xY3AXfcSk+f9yR+g@mail.gmail.com>
In-Reply-To: <CACT4Y+YSQDjEh6+XMXiHvMaKAT8bA=JkC8xY3AXfcSk+f9yR+g@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 11 Sep 2020 15:33:44 +0200
Message-ID: <CANpmjNNWOVi317bF_E=QdcSSd5x6Dfk=+nECA9VnZSLGMKigYQ@mail.gmail.com>
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

On Fri, 11 Sep 2020 at 15:10, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Fri, Sep 11, 2020 at 2:03 PM Marco Elver <elver@google.com> wrote:
> > On Fri, 11 Sep 2020 at 09:36, Dmitry Vyukov <dvyukov@google.com> wrote:
[...]
> > > By "reasonable" I mean if the pool will last long enough to still
> > > sample something after hours/days? Have you tried any experiments with
> > > some workload (both short-lived processes and long-lived
> > > processes/namespaces) capturing state of the pool? It can make sense
> > > to do to better understand dynamics. I suspect that the rate may need
> > > to be orders of magnitude lower.
> >
> > Yes, the current default sample interval is a lower bound, and is also
> > a reasonable default for testing. I expect real deployments to use
> > much higher sample intervals (lower rate).
> >
> > So here's some data (with CONFIG_KFENCE_NUM_OBJECTS=1000, so that
> > allocated KFENCE objects isn't artificially capped):
> >
> > -- With a mostly vanilla config + KFENCE (sample interval 100 ms),
> > after ~40 min uptime (only boot, then idle) I see ~60 KFENCE objects
> > (total allocations >600). Those aren't always the same objects, with
> > roughly ~2 allocations/frees per second.
> >
> > -- Then running sysbench I/O benchmark, KFENCE objects allocated peak
> > at 82. During the benchmark, allocations/frees per second are closer
> > to 10-15. After the benchmark, the KFENCE objects allocated remain at
> > 82, and allocations/frees per second fall back to ~2.
> >
> > -- For the same system, changing the sample interval to 1 ms (echo 1 >
> > /sys/module/kfence/parameters/sample_interval), and re-running the
> > benchmark gives me: KFENCE objects allocated peak at exactly 500, with
> > ~500 allocations/frees per second. After that, allocated KFENCE
> > objects dropped a little to 496, and allocations/frees per second fell
> > back to ~2.
> >
> > -- The long-lived objects are due to caches, and just running 'echo 1
> > > /proc/sys/vm/drop_caches' reduced allocated KFENCE objects back to
> > 45.
>
> Interesting. What type of caches is this? If there is some type of
> cache that caches particularly lots of sampled objects, we could
> potentially change the cache to release sampled objects eagerly.

The 2 major users of KFENCE objects for that workload are
'buffer_head' and 'bio-0'.

If we want to deal with those, I guess there are 2 options:

1. More complex, but more precise: make the users of them check
is_kfence_address() and release their buffers earlier.

2. Simpler, generic solution: make KFENCE stop return allocations for
non-kmalloc_caches memcaches after more than ~90% of the pool is
exhausted. This assumes that creators of long-lived objects usually
set up their own memcaches.

I'm currently inclined to go for (2).

Thanks,
-- Marco
