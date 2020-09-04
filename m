Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D5BC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 19:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A94DB20684
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 19:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599246569;
	bh=yGieg0rB6mcTupicJQJ8TCxkfLXk3xxMEwRgDZvs2nk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Bl5kYt+vzDLym2eV38ba4yOqmNaDrqEQa9ZTxOYpZQQNdFBFAnPSvrHgwkx8cQ6bN
	 f5Fx0E86kLGpzRFli9Nq784HE1D+altxKDRMORqnuCgUN8Qj7CW61/IlHh4LD7zpwl
	 AWd4Wd5Ix002sFR0KrgXM8TFJPNBZtI5rbeKRBKA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgIDTJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 15:09:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:59108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbgIDTJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 15:09:27 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8F6D206A5;
        Fri,  4 Sep 2020 19:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599246567;
        bh=yGieg0rB6mcTupicJQJ8TCxkfLXk3xxMEwRgDZvs2nk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gYS4Jci5+soErC9DEwqFx8O6dF3toHYffuPwTeTrzpIXYV5ERs+tS2EJaSr8/3M7x
         MoAGX+DjPXHXTJ+3fdpZDoXljuiEGdPh2GnJqtbHd+bZtVx5yegOPUb1xSgEnxVVr7
         TbRHIypHC1g8a7MOvOuVwkJHcGCK2Tw8nHY6AAfw=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D56A440D3D; Fri,  4 Sep 2020 16:09:24 -0300 (-03)
Date:   Fri, 4 Sep 2020 16:09:24 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Jin Yao <yao.jin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Olsa <jolsa@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Stephane Eranian <eranian@google.com>,
        Yonghong Song <yhs@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf parse-events: Use uintptr_t when casting numbers to
 pointers
Message-ID: <20200904190924.GD3753976@kernel.org>
References: <20200903184359.GC3495158@kernel.org>
 <CAP-5=fWvLaeuvQ6p0ep_uA0MNpk3o0hxim5tPQf+RXCafj8E=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWvLaeuvQ6p0ep_uA0MNpk3o0hxim5tPQf+RXCafj8E=A@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Sep 03, 2020 at 10:31:09PM -0700, Ian Rogers escreveu:
> On Thu, Sep 3, 2020 at 11:44 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >         Please check that this is ok with you,
> 
> Thanks Arnaldo, this looks good to me!

Thanks for checkint!

- Arnaldo

> There is a separate issue, the casts are necessary as we have
> PE_VALUEs that are supposed to be numbers but here are list*. It seems
> error prone to have something that is a pointer or a number, and so I
> wonder if we can introduce new tokens in parse-events.y to handle
> this. It'd also mean that yydestructors and the like could clean up
> error states. I'll try to take a look.
 
> Thanks,
> Ian
> 
> > commit 0823f768b800cca2592fad3b5649766ae6bc4eba
> > Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Date:   Thu Sep 3 15:34:20 2020 -0300
> >
> >     perf parse-events: Use uintptr_t when casting numbers to pointers
> >
> >     To address these errors found when cross building from x86_64 to MIPS
> >     little endian 32-bit:
> >
> >         CC       /tmp/build/perf/util/parse-events-bison.o
> >       util/parse-events.y: In function 'parse_events_parse':
> >       util/parse-events.y:514:6: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
> >         514 |      (void *) $2, $6, $4);
> >             |      ^
> >       util/parse-events.y:531:7: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
> >         531 |       (void *) $2, NULL, $4)) {
> >             |       ^
> >       util/parse-events.y:547:6: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
> >         547 |      (void *) $2, $4, 0);
> >             |      ^
> >       util/parse-events.y:564:7: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
> >         564 |       (void *) $2, NULL, 0)) {
> >             |       ^
> >
> >     Fixes: cabbf26821aa210f ("perf parse: Before yyabort-ing free components")
> >     Cc: Adrian Hunter <adrian.hunter@intel.com>
> >     Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> >     Cc: Alexei Starovoitov <ast@kernel.org>
> >     Cc: Andi Kleen <ak@linux.intel.com>
> >     Cc: Daniel Borkmann <daniel@iogearbox.net>
> >     Cc: Ian Rogers <irogers@google.com>
> >     Cc: Jin Yao <yao.jin@linux.intel.com>
> >     Cc: Jiri Olsa <jolsa@kernel.org>
> >     Cc: John Garry <john.garry@huawei.com>
> >     Cc: Kan Liang <kan.liang@linux.intel.com>
> >     Cc: Mark Rutland <mark.rutland@arm.com>
> >     Cc: Martin KaFai Lau <kafai@fb.com>
> >     Cc: Namhyung Kim <namhyung@kernel.org>
> >     Cc: Peter Zijlstra <peterz@infradead.org>
> >     Cc: Song Liu <songliubraving@fb.com>
> >     Cc: Stephane Eranian <eranian@google.com>
> >     Cc: Yonghong Song <yhs@fb.com>
> >     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> >
> > diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
> > index b9fb91fdc5de9177..645bf4f1859fd76b 100644
> > --- a/tools/perf/util/parse-events.y
> > +++ b/tools/perf/util/parse-events.y
> > @@ -511,7 +511,7 @@ PE_PREFIX_MEM PE_VALUE '/' PE_VALUE ':' PE_MODIFIER_BP sep_dc
> >         list = alloc_list();
> >         ABORT_ON(!list);
> >         err = parse_events_add_breakpoint(list, &parse_state->idx,
> > -                                       (void *) $2, $6, $4);
> > +                                       (void *)(uintptr_t) $2, $6, $4);
> >         free($6);
> >         if (err) {
> >                 free(list);
> > @@ -528,7 +528,7 @@ PE_PREFIX_MEM PE_VALUE '/' PE_VALUE sep_dc
> >         list = alloc_list();
> >         ABORT_ON(!list);
> >         if (parse_events_add_breakpoint(list, &parse_state->idx,
> > -                                               (void *) $2, NULL, $4)) {
> > +                                               (void *)(uintptr_t) $2, NULL, $4)) {
> >                 free(list);
> >                 YYABORT;
> >         }
> > @@ -544,7 +544,7 @@ PE_PREFIX_MEM PE_VALUE ':' PE_MODIFIER_BP sep_dc
> >         list = alloc_list();
> >         ABORT_ON(!list);
> >         err = parse_events_add_breakpoint(list, &parse_state->idx,
> > -                                       (void *) $2, $4, 0);
> > +                                       (void *)(uintptr_t) $2, $4, 0);
> >         free($4);
> >         if (err) {
> >                 free(list);
> > @@ -561,7 +561,7 @@ PE_PREFIX_MEM PE_VALUE sep_dc
> >         list = alloc_list();
> >         ABORT_ON(!list);
> >         if (parse_events_add_breakpoint(list, &parse_state->idx,
> > -                                               (void *) $2, NULL, 0)) {
> > +                                               (void *)(uintptr_t) $2, NULL, 0)) {
> >                 free(list);
> >                 YYABORT;
> >         }

-- 

- Arnaldo
