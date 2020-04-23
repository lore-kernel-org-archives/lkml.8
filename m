Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59828C55191
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 16:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A1332168B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 16:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ejyAs5SS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729621AbgDWQVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 12:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729453AbgDWQVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 12:21:36 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C006DC09B041
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 09:21:36 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id o127so7027598iof.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 09:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dYg/Ll+qg4QpigLgy5DOhsXWYPV1sUDJ8jqzISmIC90=;
        b=ejyAs5SSEEUZV6b3rk7cXp0gczcL9ZTsm6K686uWlzOJqIcMX1O8adPp4vconsSXro
         r3Zfqv9BiJx+x2zUdof1oE8nxMVjPyZHxz4VzWuhSYq0oLMIbJ+0ISGQgfyp/KNoKXmh
         2xgxC2U0reRe+AkZ0zNG+fQx2tALFOhbtxOJ7NuHySb8DSXgpG9GvCaQDIVHS5YPqcbk
         MysnBNy6Gc3A8wUhlXizR12M/yLnLFvkEvtYTkMUWSuwbBTt33u0cJutmWCwRiEqMP/V
         J+5mmVz+RD7la72OKvDrNt/2gc3gXXH3xJsia946HmdeUgMsN+gkfSztaS8Ij3zhQVCy
         ss4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dYg/Ll+qg4QpigLgy5DOhsXWYPV1sUDJ8jqzISmIC90=;
        b=guDfhKhvkVyFthUK2YpQkLOuk98Gxn6/n+AbbEmowG99xjcK0a7JIJCwn0X/7Zk/kT
         ZBsJ5BjohBXIG4t+pSHLUUarKZt4QDOwVnzTLhuUxJutzd4omEGW/nUI3f7Vu52yfMNS
         CzhMU8HpCoOKWz45nEYDrJyMqdb9BeSpx66DUgBKO7H4CbrwmMH49bFfs0RWJXx2LA+0
         fAwvIRTqprpMkfOS/JBf5lw6PYS85iNwEIZnNoHvg4BrYBSKK9STYEWXY9O7TJdpofjG
         I4lLEThINmg2m9Qhc2wd+3327Cv15dHZq7VP7q6gO59HhMgjVz5qJMDKKvpLj3MxPEdK
         yHug==
X-Gm-Message-State: AGi0PuZx4OASzXTtr8+djYxoZCHhUw44kIBC2bqmcnLWfZxkjH35x/0b
        yIx9dkiyv5cay7D/qO1bppl+YImwaO5ryKBwFth5nQ==
X-Google-Smtp-Source: APiQypJTaVn5mWlpWUQYcA5tRzISVbu6xu6H2hxPoP0m12Cpto0wOQZg8sIgsplgSNQwBzoCJg+pWI4sZ15S7Ddgmwg=
X-Received: by 2002:a02:6f4b:: with SMTP id b11mr3933217jae.39.1587658894355;
 Thu, 23 Apr 2020 09:21:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200422220430.254014-1-irogers@google.com> <20200422220430.254014-12-irogers@google.com>
 <20200423112847.GF1136647@krava> <CAP-5=fVwfu0s8Sqhs7+aTqN1Gh2SaEu=feOEQssSu9MB+7hk8Q@mail.gmail.com>
 <0edf66da-bedf-c5e9-aa2b-e9073a2d0203@huawei.com>
In-Reply-To: <0edf66da-bedf-c5e9-aa2b-e9073a2d0203@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 23 Apr 2020 09:21:23 -0700
Message-ID: <CAP-5=fWTgdQ-RC-CtyEPKFvOPfbANajgT61+4k6-7S9poaNEog@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] perf test: add expr test for pmu metrics
To:     John Garry <john.garry@huawei.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
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

On Thu, Apr 23, 2020 at 8:11 AM John Garry <john.garry@huawei.com> wrote:
>
> On 23/04/2020 15:22, Ian Rogers wrote:
> > On Thu, Apr 23, 2020 at 4:29 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >>
> >> On Wed, Apr 22, 2020 at 03:04:30PM -0700, Ian Rogers wrote:
> >>
> >> SNIP
> >>
> >>> +
> >>> +static int pmu_tests(void)
> >>> +{
> >>> +     struct pmu_events_map *map;
> >>> +     struct pmu_event *pe;
> >>> +     int i, j, k;
> >>> +     const char **ids;
> >>> +     int idnum;
> >>> +     int ret = 0;
> >>> +     struct expr_parse_ctx ctx;
> >>> +     double result;
> >>> +
> >>> +     i = 0;
> >>> +     for (;;) {
> >>> +             map = &pmu_events_map[i++];
> >>> +             if (!map->table) {
> >>> +                     map = NULL;
> >>> +                     break;
> >>> +             }
> >>> +             j = 0;
> >>> +             for (;;) {
> >>> +                     pe = &map->table[j++];
> >>> +                     if (!pe->name && !pe->metric_group && !pe->metric_name)
> >>> +                             break;
> >>> +                     if (!pe->metric_expr)
> >>> +                             continue;
> >>
> >> so we go throught all the metrics for the current cpu
> >> and test the parsing on them.. great!
> >
> > It's not just the current CPU (such as skylake) it is every map
> > (skylake, cascade lake, etc), but this only works for the architecture
> > that jevents built.
> > If jevents built all architectures then this could check them as well.
> > Perhaps there should be a jevents test suite, but I think even then
> > this test has value.
>
> note: there is test__pmu_events(), which verifies that some test events
> generated in pmu-events.c are as expected, and also verifies that we
> create PMU events aliases as expected (for those test events). Nothing
> is done for metrics, ATM.

Thanks John, that sounds like the right place to start.

Ian

> Thanks,
> John
