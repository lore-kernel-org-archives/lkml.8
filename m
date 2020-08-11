Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D53C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 16:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4A722076C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 16:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597164587;
	bh=akTT90bDQQJmLbk8/GS4R574/R2wiYb5j0Z9I5TuGGY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=lv36aKSaPpolpaC0CtCe8f05je7e8OXu48qRtLGX+8f5pOsR1COl5c5I1zSu7jou3
	 ZvWKh8htrqMTgeP3yVrBazsiaDAxB5AhxtalEKAB6hU4SW9wAvutnGdt9+MmzyIlRw
	 j+BgPhgkGuQ4XYBRwjz2F/H6jlvTS4k0YVJl4sqA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbgHKQtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 12:49:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:48900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728962AbgHKQtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 12:49:43 -0400
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A339820774
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 16:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597164582;
        bh=akTT90bDQQJmLbk8/GS4R574/R2wiYb5j0Z9I5TuGGY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ab+7zW2LU48xao3DCk18XY3kdo+6GcqmPXIlZ4sZETf/uAvFa7/FzB08eVX8to+c7
         SeldIMxZKkSPbarmrQemSj4VuEQpd63sueP+hNAVTR4ZLGxr9q6HOvbERFDU3dtF30
         IOdkEYDQXXfNqrxoEgjEvr8saK2SnLoZcdrDn8pA=
Received: by mail-ot1-f54.google.com with SMTP id v21so10610500otj.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 09:49:42 -0700 (PDT)
X-Gm-Message-State: AOAM531BfzXo2Pq1lmrMKeJ+FS41Q5ccy6BGWxleKPgIdzFHjdVZH5fw
        hMTCofB94BnetNZdsXqU/x3yCLIquKPX853uyg==
X-Google-Smtp-Source: ABdhPJx8qcGRTnuQ7eULUCQs3eTOvTSWkK1Fd5nerPFfrWYs97rg1R/J945Xfm4vRqRIN2kD37y1jskAK4LOHJRmjM0=
X-Received: by 2002:a05:6830:1b79:: with SMTP id d25mr5470795ote.107.1597164582008;
 Tue, 11 Aug 2020 09:49:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200807230517.57114-1-robh@kernel.org> <20200808102208.GA619980@krava>
 <CAL_Jsq+gfqyqCx3Yuc6TsbXjYSLfJQhhPUnwRVjpJgwL24v1Qg@mail.gmail.com> <20200811105027.GD699846@krava>
In-Reply-To: <20200811105027.GD699846@krava>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 11 Aug 2020 10:49:30 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+tsTrYCddSSb5d2vC7TTKUZTgjBQr4FHXBKCePo-beZQ@mail.gmail.com>
Message-ID: <CAL_Jsq+tsTrYCddSSb5d2vC7TTKUZTgjBQr4FHXBKCePo-beZQ@mail.gmail.com>
Subject: Re: [RFC] libperf: Add support for user space counter access
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 4:50 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Mon, Aug 10, 2020 at 12:11:23PM -0600, Rob Herring wrote:
> > On Sat, Aug 8, 2020 at 4:22 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > >
> > > On Fri, Aug 07, 2020 at 05:05:17PM -0600, Rob Herring wrote:
> > > > x86 and arm64 can both support direct access of event counters in
> > > > userspace. The access sequence is less than trivial and currently exists
> > > > in perf test code (tools/perf/arch/x86/tests/rdpmc.c) with copies in
> > > > projects such as PAPI and libpfm4.
> > > >
> > > > Patches to add arm64 userspace support are pending[1].
> > > >
> > > > For this RFC, looking for a yes, seems like a good idea, or no, go away we
> > > > don't want this in libperf.
> > >
> > > hi,
> > > looks great!
> > >
> > > I wanted to add this for very long time.. so yes, we want this ;-)
> >
> > Thanks for the quick feedback. Would this be better implemented as a
> > fast path for perf_evsel__read()? If so, how to get the mmap data
>
> if it works for all events, which I'm not sure of
>
> > which is associated with a evlist rather than a evsel?
>
> not sure what you mean, you can mmap evsel, not evlist

While yes the mmap is created from an evsel fd, they are ultimately
associated with the evlist struct and are per thread or cpu. If
there's more than 1 evsel, then the additional ones are set to the 1st
mmap with PERF_EVENT_IOC_SET_OUTPUT. Which I now realize means this
RFC only works for the first evsel. So I guess the API needs to work
something like this:

threads = perf_thread_map__new_dummy();
perf_thread_map__set_pid(threads, 0, 0);

evsel = perf_evsel__new(&attr);
perf_evsel__open(evsel, NULL, threads);

perf_evsel__mmap(evsel);    <--- *new*

perf_evsel__read(evsel, 0, 0, &counts);  // If we have an mmap, then
try a direct read


Perhaps some refactoring of the mmap code in evlist.c will be needed,
but the usage seems pretty orthogonal. I'd propose that mmapping via
perf_evlist__mmap() behavior remain unchanged and direct access is not
supported in that case.

Rob
