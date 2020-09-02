Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0BA2C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 19:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAE9220758
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 19:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599076114;
	bh=OgzbxnKzljOfmxtIw6lHS6/Ks7BP9r+XE+ldLoye0S8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xg5EFNfVgMLJksEN/uEeWDqOlj8TQbmAyCnq36QJr6crVJa65pS13KSwNQumIlH6d
	 UUkHqSz5S/BNWbrUF5dAlV9sqGtatQ6LAEuQs7X50i6D5Z85igwceUOQEJoKFYM87T
	 UuBfHXu23ExFbApBya2mnd73fQ1MZxqKDX4X/DKE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbgIBTsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 15:48:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:54558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgIBTsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 15:48:31 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 248F12137B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 19:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599076110;
        bh=OgzbxnKzljOfmxtIw6lHS6/Ks7BP9r+XE+ldLoye0S8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wc9/EXwJXadx1uom4vWBN+DhcVK0L21EW4UBR4F7VC9UROrvtFXm0jeAO2A/VWUQT
         m/4HklpWsDMS8vOJlwNnV7fQYu1A6GvdY7wPT1qYT/3/vxmEiRyVbIG8bB7vklj8Hx
         ccqv0CAQ+eM+/I2LdzlblQgzJnoqAisjJHwjiOEg=
Received: by mail-oi1-f170.google.com with SMTP id 2so515991ois.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 12:48:30 -0700 (PDT)
X-Gm-Message-State: AOAM533TCo352eKmNwd+hHTXrtDRLH9iCpmfD3oUaKtEDuQC+1X5ckEE
        Fle3JQqPzgUXRoYOfOCcljpKGCXThC1jJKrdaw==
X-Google-Smtp-Source: ABdhPJwMYBuyVJXnWDArWAOHngKUgcVT57YVsk57VQvLP5QeaDmaoqfZYf7wAesEdzPQ1pEU2JPhWekekt3Wtqx7AWc=
X-Received: by 2002:a54:4197:: with SMTP id 23mr3066920oiy.106.1599076109367;
 Wed, 02 Sep 2020 12:48:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200828205614.3391252-1-robh@kernel.org> <20200828205614.3391252-6-robh@kernel.org>
 <CAP-5=fXTEd14wCZJgPyk1wUsSDAWP1zW+=e7sUx66L_1+YOO7A@mail.gmail.com>
In-Reply-To: <CAP-5=fXTEd14wCZJgPyk1wUsSDAWP1zW+=e7sUx66L_1+YOO7A@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 2 Sep 2020 13:48:18 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLUZ+iejO0WyqivPfkZ+Wk_VC-fw260ScqGk1r=PnUZbA@mail.gmail.com>
Message-ID: <CAL_JsqLUZ+iejO0WyqivPfkZ+Wk_VC-fw260ScqGk1r=PnUZbA@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] libperf: Add support for user space counter access
To:     Ian Rogers <irogers@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Raphael Gault <raphael.gault@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 2, 2020 at 12:07 PM Ian Rogers <irogers@google.com> wrote:
>
> On Fri, Aug 28, 2020 at 1:56 PM Rob Herring <robh@kernel.org> wrote:
> >
> > x86 and arm64 can both support direct access of event counters in
> > userspace. The access sequence is less than trivial and currently exists
> > in perf test code (tools/perf/arch/x86/tests/rdpmc.c) with copies in
> > projects such as PAPI and libpfm4.
> >
> > In order to support usersapce access, an event must be mmapped. While
> > there's already mmap support for evlist, the usecase is a bit different
> > than the self monitoring with userspace access. So let's add a new
> > perf_evsel__mmap() function to mmap an evsel. This allows implementing
> > userspace access as a fastpath for perf_evsel__read().
> >
> > The mmapped address is returned by perf_evsel__mmap() primarily for
> > users/tests to check if userspace access is enabled.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---

> > +int perf_mmap__read_self(struct perf_mmap *map, struct perf_counts_values *count)
> > +{
> > +       struct perf_event_mmap_page *pc = map->base;
> > +       u32 seq, idx, time_mult = 0, time_shift = 0;
> > +       u64 cnt, cyc = 0, time_offset = 0, time_cycles = 0, time_mask = ~0ULL;
> > +
> > +       BUG_ON(!pc);
> > +
> > +       if (!pc->cap_user_rdpmc)
> > +               return -1;
> > +
> > +       do {
> > +               seq = READ_ONCE(pc->lock);
> > +               barrier();
> > +
> > +               count->ena = READ_ONCE(pc->time_enabled);
> > +               count->run = READ_ONCE(pc->time_running);
> > +
> > +               if (pc->cap_user_time && count->ena != count->run) {
> > +                       cyc = read_timestamp();
> > +                       time_mult = READ_ONCE(pc->time_mult);
> > +                       time_shift = READ_ONCE(pc->time_shift);
> > +                       time_offset = READ_ONCE(pc->time_offset);
> > +
> > +                       if (pc->cap_user_time_short) {
> > +                               time_cycles = READ_ONCE(pc->time_cycles);
> > +                               time_mask = READ_ONCE(pc->time_mask);
> > +                       }
> > +               }
> > +
> > +               idx = READ_ONCE(pc->index);
> > +               cnt = READ_ONCE(pc->offset);
> > +               if (pc->cap_user_rdpmc && idx) {
> > +                       u64 evcnt = read_perf_counter(idx - 1);
> > +                       u16 width = READ_ONCE(pc->pmc_width);
> > +
> > +                       evcnt <<= 64 - width;
> > +                       evcnt >>= 64 - width;
> > +                       cnt += evcnt;
> > +               } else
> > +                       return -1;
> > +
> > +               barrier();
> > +       } while (READ_ONCE(pc->lock) != seq);
> > +
> > +       if (count->ena != count->run) {
>
> There's an existing bug here that I tried to resolve in this patch:
> https://lore.kernel.org/lkml/CAP-5=fVRdqvswtyQMg5cB+ntTGda+SAYskjTQednEH-AeZo13g@mail.gmail.com/
> Due to multiplexing, enabled may be > 0 but run == 0 and the divide
> below can end up with divide by zero.

Yeah, I saw that, but didn't try to also fix that issue here.

> I like the idea of this code being in a library, there's an intent
> that the perf_event.h and test code be copy-paste-able, but there is
> some pre-existing divergence. It would be nice if this code could be
> closer to the sample code in both the test and perf_event.h.

The only way we get and keep all the versions of the code aligned is
removing the other copies. We should just remove the code comment from
perf_event.h IMO. If rdpmc.c is going to stick around given some
resistance to removing it, then perhaps it should be converted to use
libperf. At that point it could also be arch independent. Though I
don't like the idea of having the same test twice.

> As per the change above, I think running and enabled times need to be
> out arguments.

They are now in this version.

Rob
