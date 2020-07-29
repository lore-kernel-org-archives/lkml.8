Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3E6C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 23:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D7E52074B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 23:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wGuLColH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgG2XYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 19:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbgG2XYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 19:24:42 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A34C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 16:24:42 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f18so3126295wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 16:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6Vid/bDwyKAx4BwcecnBtz+573/IH5tF8O95k6nel7Q=;
        b=wGuLColHUeEnR/+pnRTEHr+CehDViADj2T/7m0JQzD4OJ25qpDd0Frb0QO7pXd+4MU
         oR8iEDFQravsltjXVqqQgfGLvIkBjls1WV1pB9dSo0qloTLnQ7M9lhTTF905On1xmQcw
         Z4khFbpFIW+8sEpWGmbWDSYlxTtlEGBHqQL4SvKVGjt8bQWmDVT6vRHpulidLrsrChMg
         3ON13gdAKqV96e3I7vUrspej3hskaAOvJYiCqEzBik+XeWWcge5IqPz2OBWzl9drgseE
         RNXiYCZRrSu9tVGJNJgnqSTVe7CBzvV/Tqgxd0DfeQw/mWAj7r6++2taGt2rBI8TOgbj
         e+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Vid/bDwyKAx4BwcecnBtz+573/IH5tF8O95k6nel7Q=;
        b=iesBjJdik0O/3P8wUigW+5oXok2hw9ylT4BHeMr9j/5gUHvU96Lbx9sczMfgFAvaUF
         S3zvhy6gn1JP2x32CZc66HcEh5TOzmzZnI9S/WZlytThib8mVkvq/7I7+0vGRr3qwJwu
         VlBJxcxMkd87iHnzuO1IBYIRjqeDRcHKhy3n+L8m6l8vOdFgs5601W/bidvLZFs2NuwC
         0yE0g9DEBc9eJXPZe7jRL9wuaqeNTxHn0l5aG44/gLOz39j7TyiZF04x4Fbtbp4X0aUm
         AZrW/R1Y14j7F+f0yzbBVDASzrfSyDv+VJHBa6zbLeOI3DnBbA4j4Hgx+4Vk2NftmWQq
         1TdA==
X-Gm-Message-State: AOAM5326GfBx1PLEXval2ZJnxvlN8mtzR9/49ZiRZcsTqInQcii2n/2t
        WmHtqxAbjB87UnIouGfurbYuW/kop6gzZXaOLI0R5g==
X-Google-Smtp-Source: ABdhPJyOuua7jlIFxpN/h+EHbIiE+S3oPLKPPuDHHT6GbYoawNV8FbDgzCDPHGbBm+BMUS9rJoIcmqcspMYdpR7fDGU=
X-Received: by 2002:a1c:a9ce:: with SMTP id s197mr10474653wme.58.1596065080650;
 Wed, 29 Jul 2020 16:24:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200728085734.609930-1-irogers@google.com> <20200728085734.609930-3-irogers@google.com>
 <20200728155940.GC1319041@krava> <20200728160954.GD1319041@krava>
In-Reply-To: <20200728160954.GD1319041@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 29 Jul 2020 16:24:28 -0700
Message-ID: <CAP-5=fVqto0LrwgW6dHQupp7jFA3wToRBonBaXXQW4wwYcTreg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] perf record: Prevent override of
 attr->sample_period for libpfm4 events
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 9:10 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Tue, Jul 28, 2020 at 05:59:46PM +0200, Jiri Olsa wrote:
> > On Tue, Jul 28, 2020 at 01:57:31AM -0700, Ian Rogers wrote:
> > > From: Stephane Eranian <eranian@google.com>
> > >
> > > Before:
> > > $ perf record -c 10000 --pfm-events=cycles:period=77777
> > >
> > > Would yield a cycles event with period=10000, instead of 77777.
> > >
> > > This was due to an ordering issue between libpfm4 parsing
> > > the event string and perf record initializing the event.
> > >
> > > This patch fixes the problem by preventing override for
> > > events with attr->sample_period != 0 by the time
> > > perf_evsel__config() is invoked. This seems to have been the
> > > intent of the author.
> > >
> > > Signed-off-by: Stephane Eranian <eranian@google.com>
> > > Reviewed-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/util/evsel.c | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > >
> > > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > > index 811f538f7d77..8afc24e2ec52 100644
> > > --- a/tools/perf/util/evsel.c
> > > +++ b/tools/perf/util/evsel.c
> > > @@ -976,8 +976,7 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
> > >      * We default some events to have a default interval. But keep
> > >      * it a weak assumption overridable by the user.
> > >      */
> > > -   if (!attr->sample_period || (opts->user_freq != UINT_MAX ||
> > > -                                opts->user_interval != ULLONG_MAX)) {
> > > +   if (!attr->sample_period) {
> >
> > I was wondering why this wouldn't break record/top
> > but we take care of the via record_opts__config
> >
> > as long as 'perf test attr' works it looks ok to me
>
> hum ;-)
>
> [jolsa@krava perf]$ sudo ./perf test 17 -v
> 17: Setup struct perf_event_attr                          :
> ...
> running './tests/attr/test-record-C0'
> expected sample_period=4000, got 3000
> FAILED './tests/attr/test-record-C0' - match failure

I'm not able to reproduce this. Do you have a build configuration or
something else to look at? The test doesn't seem obviously connected
with this patch.

Thanks,
Ian

> jirka
>
> >
> > Acked-by: Jiri Olsa <jolsa@redhat.com>
> >
> > thanks,
> > jirka
>
