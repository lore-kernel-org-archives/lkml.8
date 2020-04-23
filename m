Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783E1C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 14:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5332C2076C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 14:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A7KbWzNe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbgDWOW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 10:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728015AbgDWOW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 10:22:26 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15285C08ED7D
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 07:22:26 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id e17so3247605ybq.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 07:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cWWfNltpIdiww9JMz4KcVCbcQVu3qR2i6dEP2PEQbfE=;
        b=A7KbWzNe8gI2FaXWn2zfmmU7bz0SGqZhlk488ySyuetMclPuuLa0W+uny3B56WFwtw
         YcRm7YBHh86git1zG0oaInuRvUhm5FL4qjQEJnbkTYM16siz6I+gSHDMZ9/HLUs3QB/f
         mFZ9vv8atBfuHLgXy6g9kV5MOnYCb7P2WiFTsoShdeafMdbJsAhj+LrNZTosjGn5h/EX
         pnPtxFtYKQpKuyXDXsy75GrdhQfJkLeU2XPcTXl299lmHMSBRIbGQ71f2+ytCmI6k9w3
         8tJPOE3t9NaTZWUWG4IpwTwwl3klHRJRbO4TARMjSHZS/4tOrdLVSh6eM1DzzhgzQ0VV
         0lhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cWWfNltpIdiww9JMz4KcVCbcQVu3qR2i6dEP2PEQbfE=;
        b=rgTysXLWQA0IdsK4QetAfI2T5E4AVxZaDKiY0NyjC1ISGZ3CKLrp0WdK5y063luymU
         M+15Ifx6BksshAG/g/k7Tgh6lo65DFWhx0kdDgzEuRGDNjvsfwbujMwKQSsIivtrUnxx
         ZdkAjkPfp1IIaJdFf6+Voq5pppRE1N8wL1iis31cjvc3IqlrlBi6fvms24A49/lMSIKE
         LH8RDhEece+iHdXCjpiyDZobwLPdvF84/4Tsv7Sh0kybTG9fYIOptwIViikLl9JaH/NJ
         n/7eY4Yilej8ohHwywhins16ZlMm4lHQWMkgBnVByYD7sViFGsbV9YbrhL3vWSsbnslG
         bQ7w==
X-Gm-Message-State: AGi0PuZc4B1yAX5bXUxBnQ5HdR/N4Z8KPrlFFV+fTMSDGN91Wz8x7sEo
        5VjuZ1HVLbrHwRv1wcnV5kEqDym+ixaGR3dEwQAAgA==
X-Google-Smtp-Source: APiQypIOO5KsEv8kMjXVqNo7ZloiHHlUiiLnW+/IItRglQZI2L+0MFgcmJQWvTWQ3C4TTY4/WYdyYPaHLtAsiMP+H0g=
X-Received: by 2002:a5b:9cb:: with SMTP id y11mr7273198ybq.177.1587651744893;
 Thu, 23 Apr 2020 07:22:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200422220430.254014-1-irogers@google.com> <20200422220430.254014-12-irogers@google.com>
 <20200423112847.GF1136647@krava>
In-Reply-To: <20200423112847.GF1136647@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 23 Apr 2020 07:22:13 -0700
Message-ID: <CAP-5=fVwfu0s8Sqhs7+aTqN1Gh2SaEu=feOEQssSu9MB+7hk8Q@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] perf test: add expr test for pmu metrics
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Haiyan Song <haiyanx.song@intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Clarke <pc@us.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 4:29 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Wed, Apr 22, 2020 at 03:04:30PM -0700, Ian Rogers wrote:
>
> SNIP
>
> > +
> > +static int pmu_tests(void)
> > +{
> > +     struct pmu_events_map *map;
> > +     struct pmu_event *pe;
> > +     int i, j, k;
> > +     const char **ids;
> > +     int idnum;
> > +     int ret = 0;
> > +     struct expr_parse_ctx ctx;
> > +     double result;
> > +
> > +     i = 0;
> > +     for (;;) {
> > +             map = &pmu_events_map[i++];
> > +             if (!map->table) {
> > +                     map = NULL;
> > +                     break;
> > +             }
> > +             j = 0;
> > +             for (;;) {
> > +                     pe = &map->table[j++];
> > +                     if (!pe->name && !pe->metric_group && !pe->metric_name)
> > +                             break;
> > +                     if (!pe->metric_expr)
> > +                             continue;
>
> so we go throught all the metrics for the current cpu
> and test the parsing on them.. great!

It's not just the current CPU (such as skylake) it is every map
(skylake, cascade lake, etc), but this only works for the architecture
that jevents built.
If jevents built all architectures then this could check them as well.
Perhaps there should be a jevents test suite, but I think even then
this test has value.
A worthy addition to this is checking that the events within the
expression parse, but this is good progress and worth landing.

Thanks,
Ian

> thanks,
> jirka
>
