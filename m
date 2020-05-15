Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF27C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 00:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87C6120727
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 00:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589502283;
	bh=3N+LRJRDKytxQkdKzVM1ntD86Awtd9VeAR49TqTFkQs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=b22dHQ2M0ix6dUKj8Fhc6aRfwN/s6DqbiLXzY4mBxjKsf3qdbfmZiIKyCSyNAIRaP
	 FQiBMQoMDmsrDIo3u6Fn8C8PXuRCAgtoqAhGPXm1Cnvjm7u6vYomqMIHs9E11UwV+9
	 DH9BD/BBp1KD34dp14b/T7CnoCvR22lmfczCqwI8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbgEOAYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 20:24:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:41126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728391AbgEOAYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 20:24:42 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B5CB206D8;
        Fri, 15 May 2020 00:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589502281;
        bh=3N+LRJRDKytxQkdKzVM1ntD86Awtd9VeAR49TqTFkQs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZFJic+Lp8ZbiXKoVl/6q58/ItinQ5DxOPaGATpW4YjlywkQ/MhArCpW2Iwe8U0Rko
         7YDdMGBOEJL7bMdQnNh+ZWowxJLIO+IoWt0knKDD7HoPwW8VPa6h92wyen077n1z+O
         bFc67CzHKWJ5mnH3wjgeIpYvStIxIpgohR6FLtEM=
Date:   Thu, 14 May 2020 19:29:19 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
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
Message-ID: <20200515002919.GA30837@embeddedor>
References: <20200513234738.GA21211@embeddedor>
 <20200514131030.GL5583@kernel.org>
 <20200514150601.GS4897@embeddedor>
 <CAP-5=fWTCFx80Hd_97_4AxFV4KsRyYptLbQfw=XVw_j8i-EAyg@mail.gmail.com>
 <20200514220934.GT4897@embeddedor>
 <CAP-5=fV5URsHn+SpW8N4XjkKT1vt2T1Us5FsqaJsoOW0zn=OxQ@mail.gmail.com>
 <20200515001025.GU4897@embeddedor>
 <CAP-5=fWMQvWJqv1CrMwftUgZ8jD2ET8BuQm3a=YNGDVotq8m3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWMQvWJqv1CrMwftUgZ8jD2ET8BuQm3a=YNGDVotq8m3g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 05:09:23PM -0700, Ian Rogers wrote:
> On Thu, May 14, 2020 at 5:05 PM Gustavo A. R. Silva
> <gustavoars@kernel.org> wrote:
> >
> > On Thu, May 14, 2020 at 03:46:05PM -0700, Ian Rogers wrote:
> > > On Thu, May 14, 2020 at 3:04 PM Gustavo A. R. Silva
> > > <gustavoars@kernel.org> wrote:
> > > >
> > > > On Thu, May 14, 2020 at 12:06:48PM -0700, Ian Rogers wrote:
> > > > > On Thu, May 14, 2020 at 8:01 AM Gustavo A. R. Silva
> > > > > <gustavoars@kernel.org> wrote:
> > > > > >
> > > > > > On Thu, May 14, 2020 at 10:10:30AM -0300, Arnaldo Carvalho de Melo wrote:
> > > > > > > Em Wed, May 13, 2020 at 06:47:38PM -0500, Gustavo A. R. Silva escreveu:
> > > > > > > > Fix the following build failure generated with command
> > > > > > > > $ make CC=clang HOSTCC=clang -C tools/ perf:
> > > > > > > >
> > > > > > > > util/intel-pt.c:1802:24: error: field 'br_stack' with variable sized type 'struct branch_stack' not at the end of a struct or class is a GNU extension [-Werror,-Wgnu-variable-sized-type-not-at-end]
> > > > > > > >                         struct branch_stack br_stack;
> > > > > > > >                                             ^
> > > > > > > > 1 error generated.
> > > > > > > >
> > > > > > > > Fix this by reordering the members of struct br.
> > > > > > >
> > > > > > > Yeah, I noticed that as far back as with ubuntu 16.04's clang:
> > > > > > >
> > > > > > > clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)
> > > > > > >
> > > > > > > util/intel-pt.c:1802:24: error: field 'br_stack' with variable sized type 'struct branch_stack' not at the end of a struct or class is a GNU
> > > > > > >       extension [-Werror,-Wgnu-variable-sized-type-not-at-end]
> > > > > > >                         struct branch_stack br_stack;
> > > > > > >                                             ^
> > > > > > > 1 error generated.
> > > > > > >
> > > > > > >
> > > > > > > Will fold this with the bug introducing the problem to avoid bisection
> > > > > > > problems.
> > > > > > >
> > > > > >
> > > > > > I agree. Also, the commit hash of the "Fixes" tag only applies to the
> > > > > > perf/core branch and, I guess that might create confusion.
> > > > >
> > > > >
> > > > > So while this fixes the warning I believe it breaks the intent of the code.
> > > > >
> > > > > tools/perf/util/branch.h:
> > > > > struct branch_stack {
> > > > >        u64                     nr;
> > > > >        u64                     hw_idx;
> > > > >        struct branch_entry     entries[];
> > > > > };
> > > > >
> > > > > tools/perf/util/intel-pt.c:
> > > > >                struct {
> > > > >                        struct branch_stack br_stack;
> > > > >                        struct branch_entry entries[LBRS_MAX];
> > > > >                } br;
> > > > >
> > > > > The array in br is trying to extend branch_stack's entries array. You
> > > > > might have to do something like:
> > > > >
> > > > > alignas(alignof(branch_stack)) char storage[sizeof(branch_stack) +
> > > > > sizeof(branch_entry) * LBRS_MAX];
> > > > > struct branch_stack *br = &storage;
> > > > >
> > > > > malloc/free may be nicer on the eyeballs.
> > > > >
> > > >
> > > > Yep, I'd go for zalloc/free. There are a couple of places where dynamic
> > > > memory is being allocated for struct branch_stack:
> > > >
> > > > tools/perf/util/cs-etm.c-256-   if (etm->synth_opts.last_branch) {
> > > > tools/perf/util/cs-etm.c:257:           size_t sz = sizeof(struct branch_stack);
> > > > tools/perf/util/cs-etm.c-258-
> > > > tools/perf/util/cs-etm.c-259-           sz += etm->synth_opts.last_branch_sz *
> > > > tools/perf/util/cs-etm.c-260-                 sizeof(struct branch_entry);
> > > > tools/perf/util/cs-etm.c-261-           tidq->last_branch = zalloc(sz);
> > > >
> > > > tools/perf/util/thread-stack.c-148-     if (br_stack_sz) {
> > > > tools/perf/util/thread-stack.c:149:             size_t sz = sizeof(struct branch_stack);
> > > > tools/perf/util/thread-stack.c-150-
> > > > tools/perf/util/thread-stack.c-151-             sz += br_stack_sz * sizeof(struct branch_entry);
> > > > tools/perf/util/thread-stack.c-152-             ts->br_stack_rb = zalloc(sz);
> > > >
> > > > there is even function intel_pt_alloc_br_stack().
> > > >
> > > > Just out of curiosity, why the need of such a hack in this case (the
> > > > on-stack extension of branch_stack's entries array)?
> > >
> > > My guess would be that the lbr size is an architectural constant and
> > > so avoiding malloc/free in what could be a hot loop was desirable.
> > > As this is part of a larger patch set, is this the only place this
> > > problem has been encountered? Perhaps a macro could perform the
> >
> > Yep. I just built linux-next --which contains all the flexible-array
> > conversions-- with Clang --GCC doesn't catch this issue, not even GCC
> > 10-- and I don't see any other issue like this.
> >
> > I mean, I have run into these other two:
> >
> > https://lore.kernel.org/lkml/20200505235205.GA18539@embeddedor/
> > https://lore.kernel.org/lkml/20200508163826.GA768@embeddedor/
> >
> > but those are due to the erroneous application of the sizeof operator
> > to zero-length arrays.
> >
> > > complicated stack allocation I suggested. It may be nice to save
> > > cycles if code this pattern is widespread and the code hot.
> > >
> >
> > Apparently, this is the only instace of this sort of issue in the whole
> > codebase.
> 
> Thanks for checking, I'd convert it to malloc/free but Intel really
> owns this code.
> 

Go ahead and I can add that part to my patch and include a Co-developed-by
tag. :)

Thanks
--
Gustavo

