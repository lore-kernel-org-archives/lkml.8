Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D567C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 16:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DC85206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 16:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vKvqKizm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgEOQl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 12:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726170AbgEOQl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 12:41:58 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2085C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 09:41:57 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id z80so3229030qka.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 09:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=u0ZuybrZ1QP1/y/4CJz8f7xi85dpURrmWK65H2FvumM=;
        b=vKvqKizm0y76swH70f79IKU1r0/QhgSk8sLw0orY7VBZi8NdGo9oZ+8YNXHP9FVUt0
         /vICJ4q4RFanLQrvGw3YkErUTqcrzQj4TEbMcvbtjsw5lioR0NCqkXPMRsEhyNCNj6Ih
         brd/EnhTU6Srnk0r9wG+WsnWUqUbsiIeEuHNqHu9fwsQhM3MOYv+vmcGvuA2zSj4TUse
         NanprxOhlpuWd0NklBQdOY0aMan1NAJdq8tLZTc9wtduCJwE4R2Lc0TA2XoIHzxTn2RH
         2qBA5A1xHJNz6Bh2Qn+vgbz4L7tp8P3kCnlalgZM8LaIWebtB20RwZUgZ4c3VEd/MR1d
         emsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u0ZuybrZ1QP1/y/4CJz8f7xi85dpURrmWK65H2FvumM=;
        b=MBYxaGuIy1PfjpHVb9k/i7Z4MnfU3Nh4m0CK19R/2ZwlcK6a5C8m8FFrx85Z54uX2g
         eB/RlIi6sLQ6GaQEumqg1hoQ0/I8/F8c0xM/yzMXzFoLChSW3jzyYnO95+D3bttdb8zW
         txInZzZtWBtGIXisKjIF2hOvmOKafXYQBn2sjmKiUeWvfRMGp/7WapZJr3OTDRncQJpK
         6TRJxuOvt2jtC7WCOih+6xdxD8JQ6eBnL2ZHVXYYcHu7voKSOe3LyAnAEVkkPdgHBp02
         gBw6JxgdUygb+QTJJDy2Djx4zvrNrH/jkajTtYbfbi/d9xO8bsAI6UnEm3EP2+hR1CRm
         ehwg==
X-Gm-Message-State: AOAM531fMMup1yU0RhY3buZcvdtlfW3HLELP9j1zwaPfLwEUe7aqLeCQ
        E04RSs78pOGLlSA+zzHz2ub4UOnYNX5X6w==
X-Google-Smtp-Source: ABdhPJyVyP5XC0vtB8tjt+4anS6N3a+qpRUrcTzfPi1XzePhokbtkZeHWaiKczh7ad5l6Am0qAwPOw==
X-Received: by 2002:a37:6843:: with SMTP id d64mr4163469qkc.24.1589560917145;
        Fri, 15 May 2020 09:41:57 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id n206sm1963001qke.20.2020.05.15.09.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 09:41:55 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9B59540AFD; Fri, 15 May 2020 13:41:53 -0300 (-03)
Date:   Fri, 15 May 2020 13:41:53 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH perf/core] perf intel-pt: Fix clang build failure in
 intel_pt_synth_pebs_sample
Message-ID: <20200515164153.GD9335@kernel.org>
References: <20200513234738.GA21211@embeddedor>
 <20200514131030.GL5583@kernel.org>
 <20200514150601.GS4897@embeddedor>
 <CAP-5=fWTCFx80Hd_97_4AxFV4KsRyYptLbQfw=XVw_j8i-EAyg@mail.gmail.com>
 <20200514220934.GT4897@embeddedor>
 <CAP-5=fV5URsHn+SpW8N4XjkKT1vt2T1Us5FsqaJsoOW0zn=OxQ@mail.gmail.com>
 <20200515001025.GU4897@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515001025.GU4897@embeddedor>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the top post: Adrian, can you take a look at this?

Em Thu, May 14, 2020 at 07:10:25PM -0500, Gustavo A. R. Silva escreveu:
> On Thu, May 14, 2020 at 03:46:05PM -0700, Ian Rogers wrote:
> > On Thu, May 14, 2020 at 3:04 PM Gustavo A. R. Silva
> > <gustavoars@kernel.org> wrote:
> > >
> > > On Thu, May 14, 2020 at 12:06:48PM -0700, Ian Rogers wrote:
> > > > On Thu, May 14, 2020 at 8:01 AM Gustavo A. R. Silva
> > > > <gustavoars@kernel.org> wrote:
> > > > >
> > > > > On Thu, May 14, 2020 at 10:10:30AM -0300, Arnaldo Carvalho de Melo wrote:
> > > > > > Em Wed, May 13, 2020 at 06:47:38PM -0500, Gustavo A. R. Silva escreveu:
> > > > > > > Fix the following build failure generated with command
> > > > > > > $ make CC=clang HOSTCC=clang -C tools/ perf:
> > > > > > >
> > > > > > > util/intel-pt.c:1802:24: error: field 'br_stack' with variable sized type 'struct branch_stack' not at the end of a struct or class is a GNU extension [-Werror,-Wgnu-variable-sized-type-not-at-end]
> > > > > > >                         struct branch_stack br_stack;
> > > > > > >                                             ^
> > > > > > > 1 error generated.
> > > > > > >
> > > > > > > Fix this by reordering the members of struct br.
> > > > > >
> > > > > > Yeah, I noticed that as far back as with ubuntu 16.04's clang:
> > > > > >
> > > > > > clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)
> > > > > >
> > > > > > util/intel-pt.c:1802:24: error: field 'br_stack' with variable sized type 'struct branch_stack' not at the end of a struct or class is a GNU
> > > > > >       extension [-Werror,-Wgnu-variable-sized-type-not-at-end]
> > > > > >                         struct branch_stack br_stack;
> > > > > >                                             ^
> > > > > > 1 error generated.
> > > > > >
> > > > > >
> > > > > > Will fold this with the bug introducing the problem to avoid bisection
> > > > > > problems.
> > > > > >
> > > > >
> > > > > I agree. Also, the commit hash of the "Fixes" tag only applies to the
> > > > > perf/core branch and, I guess that might create confusion.
> > > >
> > > >
> > > > So while this fixes the warning I believe it breaks the intent of the code.
> > > >
> > > > tools/perf/util/branch.h:
> > > > struct branch_stack {
> > > >        u64                     nr;
> > > >        u64                     hw_idx;
> > > >        struct branch_entry     entries[];
> > > > };
> > > >
> > > > tools/perf/util/intel-pt.c:
> > > >                struct {
> > > >                        struct branch_stack br_stack;
> > > >                        struct branch_entry entries[LBRS_MAX];
> > > >                } br;
> > > >
> > > > The array in br is trying to extend branch_stack's entries array. You
> > > > might have to do something like:
> > > >
> > > > alignas(alignof(branch_stack)) char storage[sizeof(branch_stack) +
> > > > sizeof(branch_entry) * LBRS_MAX];
> > > > struct branch_stack *br = &storage;
> > > >
> > > > malloc/free may be nicer on the eyeballs.
> > > >
> > >
> > > Yep, I'd go for zalloc/free. There are a couple of places where dynamic
> > > memory is being allocated for struct branch_stack:
> > >
> > > tools/perf/util/cs-etm.c-256-   if (etm->synth_opts.last_branch) {
> > > tools/perf/util/cs-etm.c:257:           size_t sz = sizeof(struct branch_stack);
> > > tools/perf/util/cs-etm.c-258-
> > > tools/perf/util/cs-etm.c-259-           sz += etm->synth_opts.last_branch_sz *
> > > tools/perf/util/cs-etm.c-260-                 sizeof(struct branch_entry);
> > > tools/perf/util/cs-etm.c-261-           tidq->last_branch = zalloc(sz);
> > >
> > > tools/perf/util/thread-stack.c-148-     if (br_stack_sz) {
> > > tools/perf/util/thread-stack.c:149:             size_t sz = sizeof(struct branch_stack);
> > > tools/perf/util/thread-stack.c-150-
> > > tools/perf/util/thread-stack.c-151-             sz += br_stack_sz * sizeof(struct branch_entry);
> > > tools/perf/util/thread-stack.c-152-             ts->br_stack_rb = zalloc(sz);
> > >
> > > there is even function intel_pt_alloc_br_stack().
> > >
> > > Just out of curiosity, why the need of such a hack in this case (the
> > > on-stack extension of branch_stack's entries array)?
> > 
> > My guess would be that the lbr size is an architectural constant and
> > so avoiding malloc/free in what could be a hot loop was desirable.
> > As this is part of a larger patch set, is this the only place this
> > problem has been encountered? Perhaps a macro could perform the
> 
> Yep. I just built linux-next --which contains all the flexible-array
> conversions-- with Clang --GCC doesn't catch this issue, not even GCC
> 10-- and I don't see any other issue like this.
> 
> I mean, I have run into these other two:
> 
> https://lore.kernel.org/lkml/20200505235205.GA18539@embeddedor/
> https://lore.kernel.org/lkml/20200508163826.GA768@embeddedor/
> 
> but those are due to the erroneous application of the sizeof operator
> to zero-length arrays.
> 
> > complicated stack allocation I suggested. It may be nice to save
> > cycles if code this pattern is widespread and the code hot.
> > 
> 
> Apparently, this is the only instace of this sort of issue in the whole
> codebase.

Adrian Hunter was not CCed, Adrian?

- Arnaldo
