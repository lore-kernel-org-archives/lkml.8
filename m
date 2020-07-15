Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F31FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 00:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F78F20674
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 00:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nQAtCVzU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgGOAhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 20:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbgGOAhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 20:37:01 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E161BC061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 17:37:00 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id o8so2326226wmh.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 17:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fyYHKBAEzWizf9raS+o1+KdK49GqNrkiRZGBEtob6wU=;
        b=nQAtCVzUhpS93taxTWnLXkxMV9e8LFmbTxpMYPt3h4S9PC7WSh9WDOpFBH2ssKXCKW
         1ysNRALjweghfM0buYTQz0ODi9le7f692CurPwnafhsGQcEIXOiDOnIs6ZGSjyxtPACs
         1QGfzPgg9a01ouhFHRnyd9VF7slLelIIXll67D5oW+uFNFWqkLh7Axk5nzir/NKmqww8
         9a2hzfW3LtdDfhEQudTbg/m12LJzChK1bj+i0RMgED4cEwCGGs82ZASilgAmT9VbKoCI
         pRxgPSqcJQ8LkK36otymqsFjkBYyJUlcSOZrHqXdLLRAaxndr+VeyBdrOm4Xx6FPieQE
         15FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fyYHKBAEzWizf9raS+o1+KdK49GqNrkiRZGBEtob6wU=;
        b=r4K0ly/ayYWTjGCB2wF4pK9yspJEOHsAO3E5Ey+8/YbUxnB+Vz7aftrJ24WucJ8WMi
         1P3zzNwrtobJwJ1w7msNC9XLUp+f7GrbtQs1fg9NypyIB+nitk8e8vBHJeRThF20/NmO
         v9DWBvAfBawH/M29yt0kGryxuyKxgsvZi0ikYKlZSV6K3D03G6c97YGsZaE43h+5lCRc
         9IUYEVlnJuv4Qp4UQnLnKyRWHYxEIJ0JXK2FAN4r9QcB2UsxOUuzAaBCdA9as87HYMo9
         3VZx/g4TWbfP5eugKjFEvi+TxaVQ8A+y5Rb1NEJNfc6tzCv57vfGsEPRJxo2LSak5VHo
         nw7w==
X-Gm-Message-State: AOAM5303hrvuF55wEq/hans5iwSD6pLVbc/zAEjcuY0jhWvwKACQ1qE9
        6ki03QtVJBoL26fx/VlRT6QAE+KLD5E58cVDSjZnaKqSbWQ=
X-Google-Smtp-Source: ABdhPJx7l4LDaw+zhDnbEnv4B+UZ34ld6qKBXtTgvzH4TTCQ1rPk1xzm6TX1TvjrOlweSDOmwbxSOhm49DM/1+4vaE4=
X-Received: by 2002:a1c:4e08:: with SMTP id g8mr6204312wmh.77.1594771798282;
 Tue, 14 Jul 2020 17:09:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200712132634.138901-1-jolsa@kernel.org> <20200712132634.138901-11-jolsa@kernel.org>
In-Reply-To: <20200712132634.138901-11-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 14 Jul 2020 17:09:47 -0700
Message-ID: <CAP-5=fXm7YxrnemW-FWvZCvP8JUqJ2HMeRwUE3E=bM3XszxcFA@mail.gmail.com>
Subject: Re: [PATCH 10/18] perf metric: Collect referenced metrics in struct metric_expr
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

On Sun, Jul 12, 2020 at 6:27 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Add referenced metrics into struct metric_expr object,
> so they are accessible when computing the metric.
>
> Storing just name and expression itself, so the metric
> can be resolved and computed.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/metricgroup.c | 26 ++++++++++++++++++++++++++
>  tools/perf/util/metricgroup.h |  6 ++++++
>  2 files changed, 32 insertions(+)
>
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 9923eef1e2d4..8cbcc5e05fef 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -83,6 +83,7 @@ static void metric_event_delete(struct rblist *rblist __maybe_unused,
>         struct metric_expr *expr, *tmp;
>
>         list_for_each_entry_safe(expr, tmp, &me->head, nd) {
> +               free(expr->metric_refs);
>                 free(expr);
>         }
>
> @@ -243,6 +244,7 @@ static int metricgroup__setup_events(struct list_head *groups,
>
>         list_for_each_entry (eg, groups, nd) {
>                 struct evsel **metric_events;
> +               struct metric_ref *metric_refs = NULL;
>
>                 metric_events = calloc(sizeof(void *),
>                                 hashmap__size(&eg->pctx.ids) + 1);
> @@ -274,6 +276,30 @@ static int metricgroup__setup_events(struct list_head *groups,
>                         free(metric_events);
>                         break;
>                 }
> +
> +               /*
> +                * Collect and store collected nested expressions
> +                * for metric processing.
> +                */
> +               if (eg->refs_cnt) {
> +                       struct metric_ref_node *ref;
> +
> +                       metric_refs = zalloc(sizeof(struct metric_ref) * (eg->refs_cnt + 1));
> +                       if (!metric_refs) {
> +                               ret = -ENOMEM;
> +                               free(metric_events);
> +                               break;
> +                       }
> +
> +                       i = 0;
> +                       list_for_each_entry(ref, &eg->refs, list) {
> +                               metric_refs[i].metric_name = ref->metric_name;
> +                               metric_refs[i].metric_expr = ref->metric_expr;
> +                               i++;
> +                       }
> +               };
> +
> +               expr->metric_refs = metric_refs;
>                 expr->metric_expr = eg->metric_expr;
>                 expr->metric_name = eg->metric_name;
>                 expr->metric_unit = eg->metric_unit;
> diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
> index 8315bd1a7da4..62623a39cbec 100644
> --- a/tools/perf/util/metricgroup.h
> +++ b/tools/perf/util/metricgroup.h
> @@ -18,12 +18,18 @@ struct metric_event {
>         struct list_head head; /* list of metric_expr */
>  };
>
> +struct metric_ref {
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
> +       struct metric_ref *metric_refs;
>         int runtime;
>  };
>
> --
> 2.25.4
>
