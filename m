Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDDCAC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 05:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A49DB206C9
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 05:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bfchoPp5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgIDFvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 01:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgIDFvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 01:51:21 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D08DC061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 22:51:21 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id a65so4888430wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 22:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VBkALWNFmSZj7rK+SmejfUE4FzmI9+bkW+wvdb/tgIU=;
        b=bfchoPp5zj2lItpqUucfpnTEhQD1FHHPAGOIkeuUZVWDDo5HxG8ybEi/qEjt2BAbRz
         gPGLG3VT9Y4mAmhzVVhYijXN7UOUvEbSB58Fvx0Pm4TidSPoINzyIYjEdldmE2y8zMZv
         QZsUB1GVUy4/D2xHNbaOKupKDg82JDojrtPLY1/bEzlVsQYFPQwf4Ok2+wbWzj+yyfah
         h8m8EbNu+OK1CqM5QLswpmmBD9Nhue8UnY71/09ccFOYwvpsi8KYfb28cATjtBoaqdgn
         tWV0Tsqjs1KiKpVPen4DB4C8hThzO+BYqj24APl2mMnfW7mEggKTMs3HpgEqFNkfIQzN
         MsXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VBkALWNFmSZj7rK+SmejfUE4FzmI9+bkW+wvdb/tgIU=;
        b=lgtlZqPmhMnyEEww1bQXo7riAVjXhJC4HIh12sqF7dM0eE/XyldWLs9lMH1evYNbc5
         P/NStdnJafLhFVDxl+OcE5Sjsv5cXDD2hCRciMeDOrE91iFpvj7YeQQSvaJxkRumrh9M
         okpHEuk9nTy8sNjWbnwG7/A7nycMsDCwbxr5CVGluf8LNPzEw6l9ve48hjqTDXQxhELt
         D0fhiOek6IInExcXWxbvxJikF9UWlFv5aNN5Vy2dsirwgd3/i31p5aKp1K3wfwEO2Ui0
         68rVGrzE3zuVhWSdq9+CKGb0vd4+RSHIliTiC9SN8sCAXtHKGPNuUNHYaOs1+wkf3bXK
         9Cxg==
X-Gm-Message-State: AOAM5310rE1cpz7+q2yiKe10hBjEUuDTfw+WhDiIBIruUdI6ypOs6r7y
        GmBy8da3rHuL/mCUg3oG8ix7imNGA8v7hOp44IO+RQ==
X-Google-Smtp-Source: ABdhPJyjfg4RTVOS1EmVbuIhdOMU+V8UOMkY75qdg9ilr5NV+1cnP9l4YOD2cVaYmZAtsmnQPCN//Uc++UbX7cPSGkU=
X-Received: by 2002:a05:600c:22d1:: with SMTP id 17mr1830382wmg.58.1599198679685;
 Thu, 03 Sep 2020 22:51:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200828205614.3391252-1-robh@kernel.org> <20200828205614.3391252-6-robh@kernel.org>
 <CAP-5=fXTEd14wCZJgPyk1wUsSDAWP1zW+=e7sUx66L_1+YOO7A@mail.gmail.com> <CAL_JsqLUZ+iejO0WyqivPfkZ+Wk_VC-fw260ScqGk1r=PnUZbA@mail.gmail.com>
In-Reply-To: <CAL_JsqLUZ+iejO0WyqivPfkZ+Wk_VC-fw260ScqGk1r=PnUZbA@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 3 Sep 2020 22:51:08 -0700
Message-ID: <CAP-5=fUYsNZNM-s8auc5RVwQ-oqEnG10uBVhorns5aU29OAYXw@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] libperf: Add support for user space counter access
To:     Rob Herring <robh@kernel.org>
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

On Wed, Sep 2, 2020 at 12:48 PM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Sep 2, 2020 at 12:07 PM Ian Rogers <irogers@google.com> wrote:
> >
> > On Fri, Aug 28, 2020 at 1:56 PM Rob Herring <robh@kernel.org> wrote:
> > >
> > > x86 and arm64 can both support direct access of event counters in
> > > userspace. The access sequence is less than trivial and currently exists
> > > in perf test code (tools/perf/arch/x86/tests/rdpmc.c) with copies in
> > > projects such as PAPI and libpfm4.
> > >
> > > In order to support usersapce access, an event must be mmapped. While
> > > there's already mmap support for evlist, the usecase is a bit different
> > > than the self monitoring with userspace access. So let's add a new
> > > perf_evsel__mmap() function to mmap an evsel. This allows implementing
> > > userspace access as a fastpath for perf_evsel__read().
> > >
> > > The mmapped address is returned by perf_evsel__mmap() primarily for
> > > users/tests to check if userspace access is enabled.
> > >
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > ---
>
> > > +int perf_mmap__read_self(struct perf_mmap *map, struct perf_counts_values *count)
> > > +{
> > > +       struct perf_event_mmap_page *pc = map->base;
> > > +       u32 seq, idx, time_mult = 0, time_shift = 0;
> > > +       u64 cnt, cyc = 0, time_offset = 0, time_cycles = 0, time_mask = ~0ULL;
> > > +
> > > +       BUG_ON(!pc);
> > > +
> > > +       if (!pc->cap_user_rdpmc)
> > > +               return -1;
> > > +
> > > +       do {
> > > +               seq = READ_ONCE(pc->lock);
> > > +               barrier();
> > > +
> > > +               count->ena = READ_ONCE(pc->time_enabled);
> > > +               count->run = READ_ONCE(pc->time_running);
> > > +
> > > +               if (pc->cap_user_time && count->ena != count->run) {
> > > +                       cyc = read_timestamp();
> > > +                       time_mult = READ_ONCE(pc->time_mult);
> > > +                       time_shift = READ_ONCE(pc->time_shift);
> > > +                       time_offset = READ_ONCE(pc->time_offset);
> > > +
> > > +                       if (pc->cap_user_time_short) {
> > > +                               time_cycles = READ_ONCE(pc->time_cycles);
> > > +                               time_mask = READ_ONCE(pc->time_mask);
> > > +                       }
> > > +               }
> > > +
> > > +               idx = READ_ONCE(pc->index);
> > > +               cnt = READ_ONCE(pc->offset);
> > > +               if (pc->cap_user_rdpmc && idx) {
> > > +                       u64 evcnt = read_perf_counter(idx - 1);
> > > +                       u16 width = READ_ONCE(pc->pmc_width);
> > > +
> > > +                       evcnt <<= 64 - width;
> > > +                       evcnt >>= 64 - width;
> > > +                       cnt += evcnt;
> > > +               } else
> > > +                       return -1;
> > > +
> > > +               barrier();
> > > +       } while (READ_ONCE(pc->lock) != seq);
> > > +
> > > +       if (count->ena != count->run) {
> >
> > There's an existing bug here that I tried to resolve in this patch:
> > https://lore.kernel.org/lkml/CAP-5=fVRdqvswtyQMg5cB+ntTGda+SAYskjTQednEH-AeZo13g@mail.gmail.com/
> > Due to multiplexing, enabled may be > 0 but run == 0 and the divide
> > below can end up with divide by zero.
>
> Yeah, I saw that, but didn't try to also fix that issue here.
>
> > I like the idea of this code being in a library, there's an intent
> > that the perf_event.h and test code be copy-paste-able, but there is
> > some pre-existing divergence. It would be nice if this code could be
> > closer to the sample code in both the test and perf_event.h.
>
> The only way we get and keep all the versions of the code aligned is
> removing the other copies. We should just remove the code comment from
> perf_event.h IMO. If rdpmc.c is going to stick around given some
> resistance to removing it, then perhaps it should be converted to use
> libperf. At that point it could also be arch independent. Though I
> don't like the idea of having the same test twice.

This makes sense to me, perhaps others could comment. Given the
cleaned up API fixing or deleting tools/perf/arch/x86/tests/rdpmc.c is
desirable (as your patch set does). I wondered if we could do Jiri's
suggestion to run the lib/perf tests with perf test. One way would be
to have shell script wrapper in tools/perf/tests/shell. It's not clear
how to make a dependency from a shell script there and tests built
elsewhere in the tree though.

> > As per the change above, I think running and enabled times need to be
> > out arguments.
>
> They are now in this version.

Sorry, my mistake. I'd missed that.

Thanks,
Ian

> Rob
