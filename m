Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A40C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 22:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 356EB20734
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 22:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iPSYU1NF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbgENWqS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 18:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728229AbgENWqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 18:46:18 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A5FC061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 15:46:17 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id o134so128658ybg.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 15:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=POuXew2dZTfo+AAdAXA/gMfQxAYaYlVBrbHqZq4eBQI=;
        b=iPSYU1NFFmECEfZZoetjsu3C8g7e+tEssoRwhVZyOSA85xhQMR/pjPT9cXHmdmOxE+
         /KJgAc7ucvmkGmvYfpFKk7bDn3qUbQEAjklSh54N85axgBUtOZ41y7f/TJ80mTb2wWNK
         WWeowifC7Cd0cTdTD2DbiLNU4cS9jGI7tYugf+UaSLISm7d7b/dDWBnxpWy0dLiw4YZX
         agge5yeKaOs+STLbz2DJbN4gJB1oYk2/00Y63q+m2UB6hrWotMtieVoGz9vJWpFldMHw
         jA3iPtfNMGKYj/HYpcDRzgMz8iPKOzzvD3CvCPx3HN++K8laH7BpYPzZcU3I0duIDVL4
         Q9Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=POuXew2dZTfo+AAdAXA/gMfQxAYaYlVBrbHqZq4eBQI=;
        b=m6qfKc4BVgrh78dIAptwiDPcApmaR5ulfy47bCqK6QsC+/wbveXfckUknKzPRpj+kK
         aF9sHBaommeHe4Kwqs+g7Yr78gCl2HR4tp4OF50Vpyg4lVle334jEM+nToUexCr2AOog
         zAIo6JW1IBU6NjVvN+BNXEa1aUuz91LfimkIJ3uQDRkoZ9MzU51PAjyaa9xVTfSmDsTQ
         gC7y+L2hKe9qvIzSvbrsxgZ4CYMrAdnCVWsj7FKnTHGYhFN8NH4qLBnMPGp6hMjR+89b
         BhMFMAh2S1qdwOdqOlKHCwocbWS3qF6oN1zE+pI2VrPs58X/drYVaDrVctgm1PAzoKys
         Bp8A==
X-Gm-Message-State: AOAM530ZAKvvaFWLGCCWrBLzoI5CPIzOGm3MRRBu016xQDH/gohQzWwh
        8iRC4EXjfm3IZmLTUsjShlHXIycpuKOnGDglo8mn4A==
X-Google-Smtp-Source: ABdhPJzrhS5iga/Jep70n6Eujt0J+XcfIlwwM4+SMNTF+7FwI83KwV2QrBSrdeoVZMMx1Ksx+kKDt/KqPHdJfvPk0DY=
X-Received: by 2002:a25:c08b:: with SMTP id c133mr943269ybf.286.1589496376951;
 Thu, 14 May 2020 15:46:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200513234738.GA21211@embeddedor> <20200514131030.GL5583@kernel.org>
 <20200514150601.GS4897@embeddedor> <CAP-5=fWTCFx80Hd_97_4AxFV4KsRyYptLbQfw=XVw_j8i-EAyg@mail.gmail.com>
 <20200514220934.GT4897@embeddedor>
In-Reply-To: <20200514220934.GT4897@embeddedor>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 14 May 2020 15:46:05 -0700
Message-ID: <CAP-5=fV5URsHn+SpW8N4XjkKT1vt2T1Us5FsqaJsoOW0zn=OxQ@mail.gmail.com>
Subject: Re: [PATCH perf/core] perf intel-pt: Fix clang build failure in intel_pt_synth_pebs_sample
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 3:04 PM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> On Thu, May 14, 2020 at 12:06:48PM -0700, Ian Rogers wrote:
> > On Thu, May 14, 2020 at 8:01 AM Gustavo A. R. Silva
> > <gustavoars@kernel.org> wrote:
> > >
> > > On Thu, May 14, 2020 at 10:10:30AM -0300, Arnaldo Carvalho de Melo wrote:
> > > > Em Wed, May 13, 2020 at 06:47:38PM -0500, Gustavo A. R. Silva escreveu:
> > > > > Fix the following build failure generated with command
> > > > > $ make CC=clang HOSTCC=clang -C tools/ perf:
> > > > >
> > > > > util/intel-pt.c:1802:24: error: field 'br_stack' with variable sized type 'struct branch_stack' not at the end of a struct or class is a GNU extension [-Werror,-Wgnu-variable-sized-type-not-at-end]
> > > > >                         struct branch_stack br_stack;
> > > > >                                             ^
> > > > > 1 error generated.
> > > > >
> > > > > Fix this by reordering the members of struct br.
> > > >
> > > > Yeah, I noticed that as far back as with ubuntu 16.04's clang:
> > > >
> > > > clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)
> > > >
> > > > util/intel-pt.c:1802:24: error: field 'br_stack' with variable sized type 'struct branch_stack' not at the end of a struct or class is a GNU
> > > >       extension [-Werror,-Wgnu-variable-sized-type-not-at-end]
> > > >                         struct branch_stack br_stack;
> > > >                                             ^
> > > > 1 error generated.
> > > >
> > > >
> > > > Will fold this with the bug introducing the problem to avoid bisection
> > > > problems.
> > > >
> > >
> > > I agree. Also, the commit hash of the "Fixes" tag only applies to the
> > > perf/core branch and, I guess that might create confusion.
> >
> >
> > So while this fixes the warning I believe it breaks the intent of the code.
> >
> > tools/perf/util/branch.h:
> > struct branch_stack {
> >        u64                     nr;
> >        u64                     hw_idx;
> >        struct branch_entry     entries[];
> > };
> >
> > tools/perf/util/intel-pt.c:
> >                struct {
> >                        struct branch_stack br_stack;
> >                        struct branch_entry entries[LBRS_MAX];
> >                } br;
> >
> > The array in br is trying to extend branch_stack's entries array. You
> > might have to do something like:
> >
> > alignas(alignof(branch_stack)) char storage[sizeof(branch_stack) +
> > sizeof(branch_entry) * LBRS_MAX];
> > struct branch_stack *br = &storage;
> >
> > malloc/free may be nicer on the eyeballs.
> >
>
> Yep, I'd go for zalloc/free. There are a couple of places where dynamic
> memory is being allocated for struct branch_stack:
>
> tools/perf/util/cs-etm.c-256-   if (etm->synth_opts.last_branch) {
> tools/perf/util/cs-etm.c:257:           size_t sz = sizeof(struct branch_stack);
> tools/perf/util/cs-etm.c-258-
> tools/perf/util/cs-etm.c-259-           sz += etm->synth_opts.last_branch_sz *
> tools/perf/util/cs-etm.c-260-                 sizeof(struct branch_entry);
> tools/perf/util/cs-etm.c-261-           tidq->last_branch = zalloc(sz);
>
> tools/perf/util/thread-stack.c-148-     if (br_stack_sz) {
> tools/perf/util/thread-stack.c:149:             size_t sz = sizeof(struct branch_stack);
> tools/perf/util/thread-stack.c-150-
> tools/perf/util/thread-stack.c-151-             sz += br_stack_sz * sizeof(struct branch_entry);
> tools/perf/util/thread-stack.c-152-             ts->br_stack_rb = zalloc(sz);
>
> there is even function intel_pt_alloc_br_stack().
>
> Just out of curiosity, why the need of such a hack in this case (the
> on-stack extension of branch_stack's entries array)?

My guess would be that the lbr size is an architectural constant and
so avoiding malloc/free in what could be a hot loop was desirable.
As this is part of a larger patch set, is this the only place this
problem has been encountered? Perhaps a macro could perform the
complicated stack allocation I suggested. It may be nice to save
cycles if code this pattern is widespread and the code hot.

Thanks,
Ian

> Thanks
> --
> Gustavo
>
