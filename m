Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6F1C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 01:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 752E120737
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 01:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gE65XOfx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbgGFBnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 21:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728430AbgGFBnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 21:43:22 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9192BC061794
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jul 2020 18:43:21 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id f18so40224093wml.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jul 2020 18:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jKK9HpRferHtmH1nOMnD8dmwU67PINPEbl22Kk6iVnk=;
        b=gE65XOfxUMChkRO+PL/K/uJwQ0G1U3/GHMH2ptvjBPiqToaNu6KUeoTHdl2sbg3FEm
         IOAK0y/sbtjx2XSSVzQMJJDjMqP7a2hNI0rzUVrmc/XvssTKOYzqhN03SS8A8eaLQVVL
         8zwhkTkdJTz+OmAoZuiTz8IZPdW8dS/z4IbxJFDERT9VLukK3j1OKNAx7fQdJuRfw86H
         19cyUjJSDGDxO++aG4RrjyBVLasRGRBRspBr7lFDzx5uc4Atdz70Tdrlb3ZGivl4J8Lm
         xirb6sFaLQ/x8GB2COBBPsdPt/DQgLJEaG0wKwYWkA+kMNkbU90DISq+sbVzq69mpyVG
         HT3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jKK9HpRferHtmH1nOMnD8dmwU67PINPEbl22Kk6iVnk=;
        b=OE0V7K3UpUnPDjdgR5aqp5fkpiNu/hV5/EFtAsxau9X5GZT50d5mQmwWtjpMqI/gi6
         NEX60yp3JmvmnEP9Bn2xVF0o2pWlt1TOE9RNc6P/GVv/DpRq2lZGlknfHaIY0qJ6XITU
         DCZ4jiZz0ZD3ZSqB3tWTBj+heleVXjI1E4BMlOk9LuYmNbA394CX+AcAJ0jNELTdCu1m
         ZwwQkReh9vZFmrt+98jb+GbfRYJ2TIlffkZ6NmY9gU9U+RdfAR2zn/pvxyEYOiEpPe1g
         /fxaN4BfjPzpC0Gnm6IlvMYY2UrGfJEYyCfUyXEWJNPUv+XdZSoiE+prv2R6FeRsxLxb
         yLYw==
X-Gm-Message-State: AOAM532sTgmZM5HDxyZ1xar8Kl6vmvGX2wR8vzqg0OeTE2+j3scdI3cw
        iBUq2r3nwkEGnNhL61ZtLBA2DPbj74A5t4vzYHgFag==
X-Google-Smtp-Source: ABdhPJy5l1FBXjXnaz/KzhDBpi/WnlUyc7LdG4FgESOz6z2Yxf9h0zPQiBhr6taMCguP530g4uUJcmHKsj1gIkjmfrM=
X-Received: by 2002:a1c:48c5:: with SMTP id v188mr45492230wma.58.1593999799098;
 Sun, 05 Jul 2020 18:43:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200625114718.229911-1-kjain@linux.ibm.com> <20200625114718.229911-2-kjain@linux.ibm.com>
 <CAP-5=fWG9rxObKJ38dQ=VUf3_mQbNDCTzgU1kkyw=9uVfBa+qw@mail.gmail.com> <512670c2-bb61-7c2f-68bc-7752499300c6@linux.ibm.com>
In-Reply-To: <512670c2-bb61-7c2f-68bc-7752499300c6@linux.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Sun, 5 Jul 2020 18:43:07 -0700
Message-ID: <CAP-5=fVQDYGCWp-Ye7a=msgkGKR_q4RGpudbWHFrcvCarVZwmA@mail.gmail.com>
Subject: Re: [RFC 1/3] perf jevents: Add support for parsing perchip/percore events
To:     kajoljain <kjain@linux.ibm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Paul Clarke <pc@us.ibm.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        maddy@linux.ibm.com, Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 2, 2020 at 11:20 PM kajoljain <kjain@linux.ibm.com> wrote:
>
> On 6/25/20 7:38 PM, Ian Rogers wrote:
> > On Thu, Jun 25, 2020 at 4:47 AM Kajol Jain <kjain@linux.ibm.com> wrote:
> >>
> >> Set up the "PerChip" field  so that perf knows they are
> >> per chip events.
> >>
> >> Set up the "PerCore" field  so that perf knows they are
> >> per core events and add these fields to pmu_event structure.
> >>
> >> Similar to the way we had "PerPkg field
> >> to specify perpkg events.
> >>
> >> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> >> ---
> >>  tools/perf/pmu-events/jevents.c    | 34 ++++++++++++++++++++++++------
> >>  tools/perf/pmu-events/jevents.h    |  3 ++-
> >>  tools/perf/pmu-events/pmu-events.h |  2 ++
> >>  3 files changed, 32 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
> >> index fa86c5f997cc..21fd7990ded5 100644
> >> --- a/tools/perf/pmu-events/jevents.c
> >> +++ b/tools/perf/pmu-events/jevents.c
> >> @@ -323,7 +323,8 @@ static int print_events_table_entry(void *data, char *name, char *event,
> >>                                     char *pmu, char *unit, char *perpkg,
> >>                                     char *metric_expr,
> >>                                     char *metric_name, char *metric_group,
> >> -                                   char *deprecated, char *metric_constraint)
> >> +                                   char *deprecated, char *perchip, char *percore,
> >> +                                   char *metric_constraint)
> >>  {
> >>         struct perf_entry_data *pd = data;
> >>         FILE *outfp = pd->outfp;
> >> @@ -357,6 +358,10 @@ static int print_events_table_entry(void *data, char *name, char *event,
> >>                 fprintf(outfp, "\t.metric_group = \"%s\",\n", metric_group);
> >>         if (deprecated)
> >>                 fprintf(outfp, "\t.deprecated = \"%s\",\n", deprecated);
> >> +       if (perchip)
> >> +               fprintf(outfp, "\t.perchip = \"%s\",\n", perchip);
> >> +       if (percore)
> >> +               fprintf(outfp, "\t.percore = \"%s\",\n", percore);
> >>         if (metric_constraint)
> >>                 fprintf(outfp, "\t.metric_constraint = \"%s\",\n", metric_constraint);
> >>         fprintf(outfp, "},\n");
> >> @@ -378,6 +383,8 @@ struct event_struct {
> >>         char *metric_group;
> >>         char *deprecated;
> >>         char *metric_constraint;
> >> +       char *perchip;
> >> +       char *percore;
> >>  };
> >>
> >>  #define ADD_EVENT_FIELD(field) do { if (field) {               \
> >> @@ -406,6 +413,8 @@ struct event_struct {
> >>         op(metric_name);                                        \
> >>         op(metric_group);                                       \
> >>         op(deprecated);                                         \
> >> +       op(perchip);                                            \
> >> +       op(percore);                                            \
> >>  } while (0)
> >>
> >>  static LIST_HEAD(arch_std_events);
> >> @@ -425,7 +434,8 @@ static int save_arch_std_events(void *data, char *name, char *event,
> >>                                 char *desc, char *long_desc, char *pmu,
> >>                                 char *unit, char *perpkg, char *metric_expr,
> >>                                 char *metric_name, char *metric_group,
> >> -                               char *deprecated, char *metric_constraint)
> >> +                               char *deprecated, char *perchip, char *percore,
> >> +                               char *metric_constraint)
> >>  {
> >>         struct event_struct *es;
> >>
> >> @@ -489,7 +499,8 @@ try_fixup(const char *fn, char *arch_std, char **event, char **desc,
> >>           char **name, char **long_desc, char **pmu, char **filter,
> >>           char **perpkg, char **unit, char **metric_expr, char **metric_name,
> >>           char **metric_group, unsigned long long eventcode,
> >> -         char **deprecated, char **metric_constraint)
> >> +         char **deprecated, char **perchip, char **percore,
> >> +         char **metric_constraint)
> >>  {
> >>         /* try to find matching event from arch standard values */
> >>         struct event_struct *es;
> >> @@ -518,7 +529,8 @@ int json_events(const char *fn,
> >>                       char *pmu, char *unit, char *perpkg,
> >>                       char *metric_expr,
> >>                       char *metric_name, char *metric_group,
> >> -                     char *deprecated, char *metric_constraint),
> >> +                     char *deprecated, char *perchip, char *percore,
> >> +                     char *metric_constraint),
> >>           void *data)
> >>  {
> >>         int err;
> >> @@ -548,6 +560,8 @@ int json_events(const char *fn,
> >>                 char *metric_name = NULL;
> >>                 char *metric_group = NULL;
> >>                 char *deprecated = NULL;
> >> +               char *perchip = NULL;
> >> +               char *percore = NULL;
> >>                 char *metric_constraint = NULL;
> >>                 char *arch_std = NULL;
> >>                 unsigned long long eventcode = 0;
> >> @@ -629,6 +643,10 @@ int json_events(const char *fn,
> >>                                 addfield(map, &perpkg, "", "", val);
> >>                         } else if (json_streq(map, field, "Deprecated")) {
> >>                                 addfield(map, &deprecated, "", "", val);
> >> +                       } else if (json_streq(map, field, "PerChip")) {
> >> +                               addfield(map, &perchip, "", "", val);
> >> +                       } else if (json_streq(map, field, "PerCore")) {
> >> +                               addfield(map, &percore, "", "", val);
> >>                         } else if (json_streq(map, field, "MetricName")) {
> >>                                 addfield(map, &metric_name, "", "", val);
> >>                         } else if (json_streq(map, field, "MetricGroup")) {
> >> @@ -676,13 +694,15 @@ int json_events(const char *fn,
> >>                                         &long_desc, &pmu, &filter, &perpkg,
> >>                                         &unit, &metric_expr, &metric_name,
> >>                                         &metric_group, eventcode,
> >> -                                       &deprecated, &metric_constraint);
> >> +                                       &deprecated, &perchip, &percore,
> >> +                                       &metric_constraint);
> >>                         if (err)
> >>                                 goto free_strings;
> >>                 }
> >>                 err = func(data, name, real_event(name, event), desc, long_desc,
> >>                            pmu, unit, perpkg, metric_expr, metric_name,
> >> -                          metric_group, deprecated, metric_constraint);
> >> +                          metric_group, deprecated, perchip, percore,
> >> +                          metric_constraint);
> >>  free_strings:
> >>                 free(event);
> >>                 free(desc);
> >> @@ -693,6 +713,8 @@ int json_events(const char *fn,
> >>                 free(filter);
> >>                 free(perpkg);
> >>                 free(deprecated);
> >> +               free(perchip);
> >> +               free(percore);
> >>                 free(unit);
> >>                 free(metric_expr);
> >>                 free(metric_name);
> >> diff --git a/tools/perf/pmu-events/jevents.h b/tools/perf/pmu-events/jevents.h
> >> index 2afc8304529e..3c439ecdac7c 100644
> >> --- a/tools/perf/pmu-events/jevents.h
> >> +++ b/tools/perf/pmu-events/jevents.h
> >> @@ -8,7 +8,8 @@ int json_events(const char *fn,
> >>                                 char *pmu,
> >>                                 char *unit, char *perpkg, char *metric_expr,
> >>                                 char *metric_name, char *metric_group,
> >> -                               char *deprecated, char *metric_constraint),
> >> +                               char *deprecated, char *perchip, char *percore,
> >> +                               char *metric_constraint),
> >>                 void *data);
> >>  char *get_cpu_str(void);
> >>
> >> diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
> >> index c8f306b572f4..13d96b732963 100644
> >> --- a/tools/perf/pmu-events/pmu-events.h
> >> +++ b/tools/perf/pmu-events/pmu-events.h
> >> @@ -19,6 +19,8 @@ struct pmu_event {
> >>         const char *metric_group;
> >>         const char *deprecated;
> >>         const char *metric_constraint;
> >> +       const char *perchip;
> >> +       const char *percore;
> >
> > (In general this looks good! Some nits)
> > Could we document perchip and percore? Agreed that the style here is
> > not to comment.
> > I'm a little confused as to why these need to be const char* and can't
> > just be a bool? Perhaps other variables shouldn't be const char* too.
> > Is there ever a case where both perchip and percore could be true?
> > Would something like an enum capture this better? I can imagine other
> > cases uncore and it seems a little strange to add a new "const char*"
> > each time
> >
> > I'm wondering if there needs to be a glossary of terms, so that the
> > use of terms like core, chip, thread, socket, cpu, package is kept
> > consistent. It's not trivially clear what the difference between a
> > chip and a socket is, for example. Mapping terms to other vendors
> > commonly used terms, such as "complex" would also be useful.
> >
>
> Hi Ian,
>      Thanks for reviewing the patchset. You are right adding new parameter
> each time will not be good way to go. So, there won't be a case where both
> perchip/percore will be enabled. Hence we can add something like enum to
> capture the data.
>
> I work on prototype of adding all terms like percore, perchip, perpkg as
> part of enum. Now in future if we need to add new terms like thread, cpu etc. We just need
> to add that part in enum without creating new parameter each time.
> Please let me know any reviews on that.

Thanks Kajol! This looks better to me, but Jiri may have additional feedback.

Acked-by: Ian Rogers <irogers@google.com>

> diff --git a/tools/perf/arch/powerpc/util/header.c b/tools/perf/arch/powerpc/util/header.c
> index d4870074f14c..5220b28a35a1 100644
> --- a/tools/perf/arch/powerpc/util/header.c
> +++ b/tools/perf/arch/powerpc/util/header.c
> @@ -47,8 +47,11 @@ get_cpuid_str(struct perf_pmu *pmu __maybe_unused)
>         return bufp;
>  }
>
> -int arch_get_runtimeparam(void)
> +int arch_get_runtimeparam(struct pmu_event *pe)
>  {
>         int count;
> -       return sysfs__read_int("/devices/hv_24x7/interface/sockets", &count) < 0 ? 1 : count;
> +       char path[PATH_MAX] = "/devices/hv_24x7/interface/";
> +
> +       atoi(pe->event_class_type) == PerChip ? strcat(path, "sockets") : strcat(path, "coresperchip");
> +       return sysfs__read_int(path, &count) < 0 ? 1 : count;
>  }
> diff --git a/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json b/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
> index c121e526442a..2819ea041c78 100644
> --- a/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
> +++ b/tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
> @@ -3,17 +3,26 @@
>          "MetricExpr": "(hv_24x7@PM_MCS01_128B_RD_DISP_PORT01\\,chip\\=?@ + hv_24x7@PM_MCS01_128B_RD_DISP_PORT23\\,chip\\=?@ + hv_24x7@PM_MCS23_128B_RD_DISP_PORT01\\,chip\\=?@ + hv_24x7@PM_MCS23_128B_RD_DISP_PORT23\\,chip\\=?@)",
>          "MetricName": "Memory_RD_BW_Chip",
>          "MetricGroup": "Memory_BW",
> -        "ScaleUnit": "1.6e-2MB"
> +        "ScaleUnit": "1.6e-2MB",
> +       "EventClassType": "PerChip"
>      },
>      {
>         "MetricExpr": "(hv_24x7@PM_MCS01_128B_WR_DISP_PORT01\\,chip\\=?@ + hv_24x7@PM_MCS01_128B_WR_DISP_PORT23\\,chip\\=?@ + hv_24x7@PM_MCS23_128B_WR_DISP_PORT01\\,chip\\=?@ + hv_24x7@PM_MCS23_128B_WR_DISP_PORT23\\,chip\\=?@ )",
>          "MetricName": "Memory_WR_BW_Chip",
>          "MetricGroup": "Memory_BW",
> -        "ScaleUnit": "1.6e-2MB"
> +        "ScaleUnit": "1.6e-2MB",
> +       "EventClassType": "PerChip"
>      },
>      {
>         "MetricExpr": "(hv_24x7@PM_PB_CYC\\,chip\\=?@ )",
>          "MetricName": "PowerBUS_Frequency",
> -        "ScaleUnit": "2.5e-7GHz"
> -    }
> +        "ScaleUnit": "2.5e-7GHz",
> +       "EventClassType": "PerChip"
> +    },
> +    {
> +       "MetricExpr": "(hv_24x7@CPM_CS_32MHZ_CYC\\,domain\\=3\\,core\\=?@ )",
> +        "MetricName": "CPM_CS_32MHZ_CYC",
> +        "ScaleUnit": "1MHz",
> +       "EventClassType": "PerCore"
> +     }
>  ]
> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
> index fa86c5f997cc..dd2b14cc147c 100644
> --- a/tools/perf/pmu-events/jevents.c
> +++ b/tools/perf/pmu-events/jevents.c
> @@ -53,6 +53,23 @@
>  int verbose;
>  char *prog;
>
> +enum event_class {
> +       PerChip = 0,
> +       PerPkg = 1,
> +       PerCore = 2
> +};
> +
> +enum event_class convert(const char* event_class_type) {
> +
> +       if (!strcmp(event_class_type, "PerCore"))
> +               return PerCore;
> +       else if (!strcmp(event_class_type, "PerChip"))
> +               return PerChip;
> +       else if (!strcmp(event_class_type, "PerPkg"))
> +               return PerPkg;
> +       return -1;
> +}
> +
>  int eprintf(int level, int var, const char *fmt, ...)
>  {
>
> @@ -320,7 +337,7 @@ static void print_events_table_prefix(FILE *fp, const char *tblname)
>
>  static int print_events_table_entry(void *data, char *name, char *event,
>                                     char *desc, char *long_desc,
> -                                   char *pmu, char *unit, char *perpkg,
> +                                   char *pmu, char *unit, char *event_class_type,
>                                     char *metric_expr,
>                                     char *metric_name, char *metric_group,
>                                     char *deprecated, char *metric_constraint)
> @@ -345,10 +362,10 @@ static int print_events_table_entry(void *data, char *name, char *event,
>                 fprintf(outfp, "\t.long_desc = \"%s\",\n", long_desc);
>         if (pmu)
>                 fprintf(outfp, "\t.pmu = \"%s\",\n", pmu);
> +       if (event_class_type)
> +               fprintf(outfp, "\t.event_class_type = \"%d\",\n", convert(event_class_type));
>         if (unit)
>                 fprintf(outfp, "\t.unit = \"%s\",\n", unit);
> -       if (perpkg)
> -               fprintf(outfp, "\t.perpkg = \"%s\",\n", perpkg);
>         if (metric_expr)
>                 fprintf(outfp, "\t.metric_expr = \"%s\",\n", metric_expr);
>         if (metric_name)
> @@ -372,7 +389,7 @@ struct event_struct {
>         char *long_desc;
>         char *pmu;
>         char *unit;
> -       char *perpkg;
> +       char *event_class_type;
>         char *metric_expr;
>         char *metric_name;
>         char *metric_group;
> @@ -401,7 +418,7 @@ struct event_struct {
>         op(long_desc);                                          \
>         op(pmu);                                                \
>         op(unit);                                               \
> -       op(perpkg);                                             \
> +       op(event_class_type);                   \
>         op(metric_expr);                                        \
>         op(metric_name);                                        \
>         op(metric_group);                                       \
> @@ -423,7 +440,7 @@ static void free_arch_std_events(void)
>
>  static int save_arch_std_events(void *data, char *name, char *event,
>                                 char *desc, char *long_desc, char *pmu,
> -                               char *unit, char *perpkg, char *metric_expr,
> +                               char *unit, char *event_class_type, char *metric_expr,
>                                 char *metric_name, char *metric_group,
>                                 char *deprecated, char *metric_constraint)
>  {
> @@ -487,7 +504,7 @@ static char *real_event(const char *name, char *event)
>  static int
>  try_fixup(const char *fn, char *arch_std, char **event, char **desc,
>           char **name, char **long_desc, char **pmu, char **filter,
> -         char **perpkg, char **unit, char **metric_expr, char **metric_name,
> +         char **event_class_type, char **unit, char **metric_expr, char **metric_name,
>           char **metric_group, unsigned long long eventcode,
>           char **deprecated, char **metric_constraint)
>  {
> @@ -515,7 +532,7 @@ try_fixup(const char *fn, char *arch_std, char **event, char **desc,
>  int json_events(const char *fn,
>           int (*func)(void *data, char *name, char *event, char *desc,
>                       char *long_desc,
> -                     char *pmu, char *unit, char *perpkg,
> +                     char *pmu, char *unit, char *event_class_type,
>                       char *metric_expr,
>                       char *metric_name, char *metric_group,
>                       char *deprecated, char *metric_constraint),
> @@ -542,7 +559,7 @@ int json_events(const char *fn,
>                 char *extra_desc = NULL;
>                 char *pmu = NULL;
>                 char *filter = NULL;
> -               char *perpkg = NULL;
> +               char *event_class_type = NULL;
>                 char *unit = NULL;
>                 char *metric_expr = NULL;
>                 char *metric_name = NULL;
> @@ -625,8 +642,8 @@ int json_events(const char *fn,
>                                 addfield(map, &filter, "", "", val);
>                         } else if (json_streq(map, field, "ScaleUnit")) {
>                                 addfield(map, &unit, "", "", val);
> -                       } else if (json_streq(map, field, "PerPkg")) {
> -                               addfield(map, &perpkg, "", "", val);
> +                       } else if (json_streq(map, field, "EventClassType")) {
> +                               addfield(map, &event_class_type, "", "", val);
>                         } else if (json_streq(map, field, "Deprecated")) {
>                                 addfield(map, &deprecated, "", "", val);
>                         } else if (json_streq(map, field, "MetricName")) {
> @@ -673,7 +690,7 @@ int json_events(const char *fn,
>                          * fixup any unassigned values.
>                          */
>                         err = try_fixup(fn, arch_std, &event, &desc, &name,
> -                                       &long_desc, &pmu, &filter, &perpkg,
> +                                       &long_desc, &pmu, &filter, &event_class_type,
>                                         &unit, &metric_expr, &metric_name,
>                                         &metric_group, eventcode,
>                                         &deprecated, &metric_constraint);
> @@ -681,7 +698,7 @@ int json_events(const char *fn,
>                                 goto free_strings;
>                 }
>                 err = func(data, name, real_event(name, event), desc, long_desc,
> -                          pmu, unit, perpkg, metric_expr, metric_name,
> +                          pmu, unit, event_class_type, metric_expr, metric_name,
>                            metric_group, deprecated, metric_constraint);
>  free_strings:
>                 free(event);
> @@ -691,7 +708,7 @@ int json_events(const char *fn,
>                 free(extra_desc);
>                 free(pmu);
>                 free(filter);
> -               free(perpkg);
> +               free(event_class_type);
>                 free(deprecated);
>                 free(unit);
>                 free(metric_expr);
> diff --git a/tools/perf/pmu-events/jevents.h b/tools/perf/pmu-events/jevents.h
> index 2afc8304529e..f399ab47cfa4 100644
> --- a/tools/perf/pmu-events/jevents.h
> +++ b/tools/perf/pmu-events/jevents.h
> @@ -6,7 +6,7 @@ int json_events(const char *fn,
>                 int (*func)(void *data, char *name, char *event, char *desc,
>                                 char *long_desc,
>                                 char *pmu,
> -                               char *unit, char *perpkg, char *metric_expr,
> +                               char *unit, char *event_class_type, char *metric_expr,
>                                 char *metric_name, char *metric_group,
>                                 char *deprecated, char *metric_constraint),
>                 void *data);
> diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
> index c8f306b572f4..079af277da47 100644
> --- a/tools/perf/pmu-events/pmu-events.h
> +++ b/tools/perf/pmu-events/pmu-events.h
> @@ -2,6 +2,7 @@
>  #ifndef PMU_EVENTS_H
>  #define PMU_EVENTS_H
>
> +enum event_class { PerChip = 0, PerPkg, PerCore};
>  /*
>   * Describe each PMU event. Each CPU has a table of PMU events.
>   */
> @@ -13,7 +14,7 @@ struct pmu_event {
>         const char *long_desc;
>         const char *pmu;
>         const char *unit;
> -       const char *perpkg;
> +       const char *event_class_type;
>         const char *metric_expr;
>         const char *metric_name;
>         const char *metric_group;
> diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
> index ab64b4a4e284..df91aa6fe0e6 100644
> --- a/tools/perf/tests/pmu-events.c
> +++ b/tools/perf/tests/pmu-events.c
> @@ -206,10 +206,10 @@ static int test_pmu_event_table(void)
>                                 return -1;
>                         }
>
> -                       if (!is_same(table->perpkg, te->perpkg)) {
> -                               pr_debug2("testing event table %s: mismatched perpkg, %s vs %s\n",
> -                                         table->name, table->perpkg,
> -                                         te->perpkg);
> +                       if (!is_same(table->event_class_type, te->event_class_type)) {
> +                               pr_debug2("testing event table %s: mismatched event_class_type, %s vs %s\n",
> +                                         table->name, table->event_class_type,
> +                                         te->event_class_type);
>                                 return -1;
>                         }
>
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 9e21aa767e41..c06166ec64d6 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -15,7 +15,6 @@
>  #include "rblist.h"
>  #include <string.h>
>  #include <errno.h>
> -#include "pmu-events/pmu-events.h"
>  #include "strlist.h"
>  #include <assert.h>
>  #include <linux/ctype.h>
> @@ -547,7 +546,7 @@ static bool metricgroup__has_constraint(struct pmu_event *pe)
>         return false;
>  }
>
> -int __weak arch_get_runtimeparam(void)
> +int __weak arch_get_runtimeparam(struct pmu_event *pe __maybe_unused)
>  {
>         return 1;
>  }
> @@ -634,7 +633,7 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
>                         } else {
>                                 int j, count;
>
> -                               count = arch_get_runtimeparam();
> +                               count = arch_get_runtimeparam(pe);
>
>                                 /* This loop is added to create multiple
>                                  * events depend on count value and add
> diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
> index 287850bcdeca..c0bf77514343 100644
> --- a/tools/perf/util/metricgroup.h
> +++ b/tools/perf/util/metricgroup.h
> @@ -5,6 +5,7 @@
>  #include <linux/list.h>
>  #include <linux/rbtree.h>
>  #include <stdbool.h>
> +#include "pmu-events/pmu-events.h"
>
>  struct evsel;
>  struct option;
> @@ -37,5 +38,5 @@ int metricgroup__parse_groups(const struct option *opt,
>  void metricgroup__print(bool metrics, bool groups, char *filter,
>                         bool raw, bool details);
>  bool metricgroup__has_metric(const char *metric);
> -int arch_get_runtimeparam(void);
> +int arch_get_runtimeparam(struct pmu_event *pe __maybe_unused);
>  #endif
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 93fe72a9dc0b..cc18a4c7cfc3 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -306,7 +306,7 @@ static bool perf_pmu_merge_alias(struct perf_pmu_alias *newalias,
>  static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
>                                  char *desc, char *val,
>                                  char *long_desc, char *topic,
> -                                char *unit, char *perpkg,
> +                                char *unit, char *event_class_type,
>                                  char *metric_expr,
>                                  char *metric_name,
>                                  char *deprecated)
> @@ -378,7 +378,7 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
>                         return -1;
>                 snprintf(alias->unit, sizeof(alias->unit), "%s", unit);
>         }
> -       alias->per_pkg = perpkg && sscanf(perpkg, "%d", &num) == 1 && num == 1;
> +       alias->per_pkg = event_class_type && sscanf(event_class_type, "%d", &num) == 1 && num == 1;
>         alias->str = strdup(newval);
>
>         if (deprecated)
> @@ -776,7 +776,7 @@ void pmu_add_cpu_aliases_map(struct list_head *head, struct perf_pmu *pmu,
>                 __perf_pmu__new_alias(head, NULL, (char *)pe->name,
>                                 (char *)pe->desc, (char *)pe->event,
>                                 (char *)pe->long_desc, (char *)pe->topic,
> -                               (char *)pe->unit, (char *)pe->perpkg,
> +                               (char *)pe->unit, (char *)pe->event_class_type,
>                                 (char *)pe->metric_expr,
>                                 (char *)pe->metric_name,
>                                 (char *)pe->deprecated);
> --
> 2.26.2
>
> Thanks,
> Kajol Jain
> > Thanks,
> > Ian
> >
> >>  };
> >>
> >>  /*
> >> --
> >> 2.26.2
> >>
