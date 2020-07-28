Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245C3C433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 17:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08C3022B40
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 17:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nbzh/iVe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731991AbgG1R0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 13:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731684AbgG1R0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 13:26:33 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E000C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 10:26:33 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id b6so19067441wrs.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 10:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s8HmD2+W32Ksd26J0Q9yAAyP6paGN4AidnrWfkdiGWk=;
        b=nbzh/iVebMLRJd22MAzNuOfOpDFAWNGK8zWhMVfwAPd56jrymzn/jt0y/w7GOr12/j
         8UIlCUA453dSY1YPMmgQ75xhLGHsY+41Bx728SHa8jSaAf8YrsAJiDyL8laz4Di1BlRG
         r0mdw0XkApyFun/j+8yU8HfNuXPx9N8HY05HLc2D0NArPxoGVd9gzZzVkKMDMHHY1YdP
         IaP+kH6zhGWs/gH/uZL6+SWIlatira6mpOw8P+Afx8GLJ8kIUlcUx++lUmEVLB4GvE45
         isyV0rkkT1uIaBe2nzwTFl3RK0j4H4aomPyrngB/9ndE6euH/6LXv3u+k3UJj0s3+8mH
         cuiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s8HmD2+W32Ksd26J0Q9yAAyP6paGN4AidnrWfkdiGWk=;
        b=KILPeiy7ylMapAV5S/EXsS2mLOOtFRMF6+UpBuvBEuP3IOcV5cHGc3IZ5h7k1jbwlo
         1O17/qYPQf+KhqX9fWN02eeTJSrB7Uz/1bLT4/ml4wFAi+WBJM9D8k/kDSUeYgysxwJT
         adbk8cCrgJo49nt//qQu+sAI68d3AXj/azZ1P/ucJ+HTOztWQECZAlr3zsgKA7+K7OlW
         nlhnSQ1nIeeJEld9vIjrKGHXj+QAhdBzMXjO/8xgX4XpLXlvarBr4ktOUlJfPNjBPZZH
         a9W8pWhEwDHHO8JzR/6iMiesEI/AtJ7C478Av181dmeA72Hr5xU5LyAufKYv0u46yg/Y
         /NaA==
X-Gm-Message-State: AOAM531TDnPRu5Ky9zlnQ0Z/wvZDSBeeW20UrDaky5xDYLp+wCXwIx1m
        JeyaDF8/ZgyBKg3dM8r2FKffrlkJVcMG6SDFChS1lKHQ
X-Google-Smtp-Source: ABdhPJz/7AvqFSQzMQ51/J8k71NOIcZ9fjFqwsFpUa/K8MNKKufqoVCPWmquuNkgne2ST9+MkLYfOAiJDq4Mol/4O90=
X-Received: by 2002:a5d:4bd2:: with SMTP id l18mr24848678wrt.119.1595957192009;
 Tue, 28 Jul 2020 10:26:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200719181320.785305-1-jolsa@kernel.org> <20200719181320.785305-17-jolsa@kernel.org>
 <20200728123629.GW40195@kernel.org>
In-Reply-To: <20200728123629.GW40195@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 28 Jul 2020 10:26:20 -0700
Message-ID: <CAP-5=fWAC4DkKiPzKvAiVpMDFWvf3HPZ5=tiSUbJ50w+kjXhfg@mail.gmail.com>
Subject: Re: [PATCH 16/19] perf metric: Make compute_single function more precise
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A. Clarke" <pc@us.ibm.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 5:36 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Sun, Jul 19, 2020 at 08:13:17PM +0200, Jiri Olsa escreveu:
> > So far compute_single function relies on the fact, that
> > there's only single metric defined within evlist in all
> > tests. In following patch we will add test for metric
> > group, so we need to be able to compute metric by given
> > name.
> >
> > Adding the name argument to compute_single and iterating
> > evlist and evsel's expression to find the given metric.
>
> Applied, thanks.
>
> Ian, Kajol, I didn't notice your Acked-by or Reviewed-by, like for the
> other patches, can you check?


Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> - Arnaldo
>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/tests/parse-metric.c | 22 +++++++++++++---------
> >  1 file changed, 13 insertions(+), 9 deletions(-)
> >
> > diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
> > index 01370ccb9ed9..5ac32f80f8ea 100644
> > --- a/tools/perf/tests/parse-metric.c
> > +++ b/tools/perf/tests/parse-metric.c
> > @@ -108,17 +108,21 @@ static void load_runtime_stat(struct runtime_stat *st, struct evlist *evlist,
> >  }
> >
> >  static double compute_single(struct rblist *metric_events, struct evlist *evlist,
> > -                          struct runtime_stat *st)
> > +                          struct runtime_stat *st, const char *name)
> >  {
> > -     struct evsel *evsel = evlist__first(evlist);
> > +     struct metric_expr *mexp;
> >       struct metric_event *me;
> > +     struct evsel *evsel;
> >
> > -     me = metricgroup__lookup(metric_events, evsel, false);
> > -     if (me != NULL) {
> > -             struct metric_expr *mexp;
> > -
> > -             mexp = list_first_entry(&me->head, struct metric_expr, nd);
> > -             return test_generic_metric(mexp, 0, st);
> > +     evlist__for_each_entry(evlist, evsel) {
> > +             me = metricgroup__lookup(metric_events, evsel, false);
> > +             if (me != NULL) {
> > +                     list_for_each_entry (mexp, &me->head, nd) {
> > +                             if (strcmp(mexp->metric_name, name))
> > +                                     continue;
> > +                             return test_generic_metric(mexp, 0, st);
> > +                     }
> > +             }
> >       }
> >       return 0.;
> >  }
> > @@ -162,7 +166,7 @@ static int compute_metric(const char *name, struct value *vals, double *ratio)
> >       load_runtime_stat(&st, evlist, vals);
> >
> >       /* And execute the metric */
> > -     *ratio = compute_single(&metric_events, evlist, &st);
> > +     *ratio = compute_single(&metric_events, evlist, &st, name);
> >
> >       /* ... clenup. */
> >       metricgroup__rblist_exit(&metric_events);
> > --
> > 2.25.4
> >
>
> --
>
> - Arnaldo
