Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52987C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B1932137B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RgRGcSMJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgFZVLK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 17:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbgFZVLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 17:11:10 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AB8C03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:11:10 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id a6so9633887wmm.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JheVoZwO8k0jmPVu/g3KXqdNyf9JfGI9W35mhlnDf2o=;
        b=RgRGcSMJzEnnjiJ+aeyEG+dm/0hDQFXMDTqba3ELjSSenFDq2jLUT1okGHoDbwJCFY
         c2kPb+Rn3T7qU0oeW/j85BTd2MvYCCDIq3sFBAq0SkGQAktbDYL8HcyzlLuRMD8sGCyi
         8/5gq+Zj1/2e+oVne5tEb/lBxuiSuPEZfAbQXDToJNl5JEpnzECw8goaOWXSJTrmXEEx
         r/rvcrLbufVn3daAyjyKrl/O/uNj9EaYAf6+vDCaFOZLll0oaKixNlCUDSM7P7z9TeJl
         5S4WNFEQu2vBQP9pV/XRVi9gVl+T/nH8Q8Vzwt/tr6kcOfKsZXpCeNDZYk+CFgZL8qfS
         PYGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JheVoZwO8k0jmPVu/g3KXqdNyf9JfGI9W35mhlnDf2o=;
        b=Isl0s0CqUtx4uQSDnu0nqN5aNgocCKrdrUEfOfagcFewgHifeZPyUJhSq3EAgmpERr
         wtKiEgEn8jsEISkWb6+Cn8b9YCJTq5cOD74qh3rQ112kMPW6kDnWLG/cG6aE09BNSwsc
         vRJm86dwq7fqKznwDwAKkUEB7R9EZlv/j2MXa6+n3Y68NERnrpk09ZiM8ltjeDsuWvrc
         J/F8M2F2PoTqGkFggrF3lXZ347I8VugZZOceszst+/IXEN5SSoBhhDc4fpzA0PIfQHzU
         zR/hdMoUk3mf9lxZXw+TiVs6vx39wD/l46w2k1+2YXJlvBcs5Dsot57oU7DHMV4Pq8/6
         AFYA==
X-Gm-Message-State: AOAM5320EUwgHR0Z9AAIyXqyAcVpzw0gucNfayZ9L9BfBeM63bsOCqsY
        gXqGOJgWx9sAW6FaW1TQvPAf2Oya2GNHdx3TVC4hPA==
X-Google-Smtp-Source: ABdhPJx+/RcSsWHs5yrxH7FA7fqliEB/cSlY+1TVVHqcZMoTEGw/E1qcLpltzQ6bFBBLbI5ln1h1pAO8Y74IIFmc+Dw=
X-Received: by 2002:a1c:7e94:: with SMTP id z142mr5275559wmc.124.1593205868736;
 Fri, 26 Jun 2020 14:11:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200626194720.2915044-1-jolsa@kernel.org> <20200626194720.2915044-8-jolsa@kernel.org>
In-Reply-To: <20200626194720.2915044-8-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 26 Jun 2020 14:10:57 -0700
Message-ID: <CAP-5=fUB3cs7Px6NkpBtWaWdR5-qQGAd2hAGjQjyMJt=bDKXOA@mail.gmail.com>
Subject: Re: [PATCH 07/10] perf tools: Collect other metrics in struct metric_expr
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
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

On Fri, Jun 26, 2020 at 12:48 PM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Add 'other' metrics into struct metric_expr object,
> so they are accessible when computing the metric.
>
> Storing just name and expression itself, so the metric
> can be resolved and computed.

Nit, other vs something like referenced_metric but otherwise lgtm.

Acked-by: Ian Rogers

> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/metricgroup.c | 27 +++++++++++++++++++++++++++
>  tools/perf/util/metricgroup.h |  6 ++++++
>  2 files changed, 33 insertions(+)
>
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index f88fd667cc78..a5d5dcc1b805 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -83,6 +83,7 @@ static void metric_event_delete(struct rblist *rblist __maybe_unused,
>         struct metric_expr *expr, *tmp;
>
>         list_for_each_entry_safe(expr, tmp, &me->head, nd) {
> +               free(expr->metric_other);
>                 free(expr);
>         }
>
> @@ -243,6 +244,7 @@ static int metricgroup__setup_events(struct list_head *groups,
>
>         list_for_each_entry (eg, groups, nd) {
>                 struct evsel **metric_events;
> +               struct metric_other *other = NULL;
>
>                 metric_events = calloc(sizeof(void *),
>                                 hashmap__size(&eg->pctx.ids) + 1);
> @@ -274,6 +276,31 @@ static int metricgroup__setup_events(struct list_head *groups,
>                         free(metric_events);
>                         break;
>                 }
> +
> +               /*
> +                * Collect and store collected 'other' expressions
> +                * for metric processing.
> +                */
> +               if (eg->other_cnt) {
> +                       struct eother *eo;
> +
> +                       other = zalloc(sizeof(struct metric_other) * (eg->other_cnt + 1));
> +                       if (!other) {
> +                               ret = -ENOMEM;
> +                               free(metric_events);
> +                               free(other);
> +                               break;
> +                       }
> +
> +                       i = 0;
> +                       list_for_each_entry(eo, &eg->other, list) {
> +                               other[i].metric_name = eo->metric_name;
> +                               other[i].metric_expr = eo->metric_expr;
> +                               i++;
> +                       }
> +               };
> +
> +               expr->metric_other = other;
>                 expr->metric_expr = eg->metric_expr;
>                 expr->metric_name = eg->metric_name;
>                 expr->metric_unit = eg->metric_unit;
> diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
> index 8315bd1a7da4..3a1e320cb2d3 100644
> --- a/tools/perf/util/metricgroup.h
> +++ b/tools/perf/util/metricgroup.h
> @@ -18,12 +18,18 @@ struct metric_event {
>         struct list_head head; /* list of metric_expr */
>  };
>
> +struct metric_other {
> +       const char *metric_name;
> +       const char *metric_expr;
> +};
> +
>  struct metric_expr {
>         struct list_head nd;
>         const char *metric_expr;
>         const char *metric_name;
>         const char *metric_unit;
>         struct evsel **metric_events;
> +       struct metric_other *metric_other;
>         int runtime;
>  };
>
> --
> 2.25.4
>
