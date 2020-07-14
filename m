Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D51AC433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 21:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48E1620656
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 21:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nQ7NjsUI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbgGNVP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 17:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbgGNVP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 17:15:26 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455B9C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 14:15:26 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id w3so613226wmi.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 14:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KIxvXUYU+bkotW7iXeLXLPJODE7YZ1E35UdctuSTBps=;
        b=nQ7NjsUIH3QedVvSipBYtCo0Es/mGjFSHXAlmkJMkJE4+Jk9qsWpSC+uMn7dRCmr3G
         Ii2XEa7UJ22OomWOYiubVseshbuHZ0AtdDPS0XcowL+7K8UxrmL6dXGWQi7LtCZEzJ2m
         d3OOW+1+70k//QLNUhkzQQwI+5sCZpFKhmA9whYc2TRFdHPNW68YkJ29Tsexbye+yNy5
         6O9bgzWdNXEUW8DWgKUdLNqDsZ8yZJfeCtZBFpRiM0liVXcr1MzRS5ke/BXBVMfpdoju
         ZZc0gjCZTSa+NbzqbG/5WhGwkM5D60iji/GMgD9DHB0ApPPqEqvlsW/8HegLjQsqvhTm
         5IRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KIxvXUYU+bkotW7iXeLXLPJODE7YZ1E35UdctuSTBps=;
        b=kT2EGqz6CNA9BAH0/e7qauD23Qejb87jcKI9J37uZSB96LR919PhngJbvcOHCTkuHh
         u8zYGx50NYGNDZqKjIW3K+i4d1vzPc/I+Vj49eJbPmpd2eBtxcjS7oMKNrWUjfcwooqB
         3i9dpXYCda1Q5+S9YR+bm/7wzM3ieZiRLbTKW+3ujVuHtWZJ+ZtqyhlwUYDoy4dbSggI
         4ddfXh0uTZnCJRMQIyLJCMuadUA1k3WGy3WUW8bbpFPaJl+wG+icxGotEqhlMajgLt0k
         98Fv9rREAOdUOvhCKQVI7W1UWlhvUO/ERJv+JlyrVeYPIS0lCqHMJvZK088pZiKO33lh
         L02A==
X-Gm-Message-State: AOAM531S5Qi5tOlEC48oJ/Oitaz6xdsIO0XiFkoOxjmkFMtxL7SC+MuB
        aGY/VKj3ss1weJqY+2Zh6s+EtMnwc4TmBWYVu/Lg1m/hOpCzmg==
X-Google-Smtp-Source: ABdhPJyS2B0FndPK1O7ffPIQbWKZy0Fqs99bEx3UaCqAARTHLEkEaibCdH8JBXYrC2UzvYMXwPdx+mvOwoUw+AnIzkQ=
X-Received: by 2002:a1c:19c5:: with SMTP id 188mr5546907wmz.124.1594760979897;
 Tue, 14 Jul 2020 14:09:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200712132634.138901-1-jolsa@kernel.org> <20200712132634.138901-7-jolsa@kernel.org>
In-Reply-To: <20200712132634.138901-7-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 14 Jul 2020 14:09:28 -0700
Message-ID: <CAP-5=fWeRpc-G8fJgOpox3nvP9jzrC8ijkPKaAdBUGby1VkASg@mail.gmail.com>
Subject: Re: [PATCH 06/18] perf metric: Add find_metric function
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
> Decouple lookup metric logic into find_metric function,
> so it can be used from other places in following changes.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/metricgroup.c | 89 +++++++++++++++++++----------------
>  1 file changed, 48 insertions(+), 41 deletions(-)
>
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index df0356ec120d..72552608ff7d 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -614,57 +614,64 @@ static int __metricgroup__add_metric(struct list_head *group_list,
>         return 0;
>  }
>
> -static int metricgroup__add_metric(const char *metric, bool metric_no_group,
> -                                  struct strbuf *events,
> -                                  struct list_head *group_list,
> -                                  struct pmu_events_map *map)
> +static struct pmu_event *find_metric(const char *metric, struct pmu_events_map *map)
>  {
>         struct pmu_event *pe;
> -       struct egroup *eg;
> -       int i, ret;
> -       bool has_match = false;
> +       int i;
>
>         for (i = 0; ; i++) {
>                 pe = &map->table[i];
> -
> -               if (!pe->name && !pe->metric_group && !pe->metric_name) {
> -                       /* End of pmu events. */
> -                       if (!has_match)
> -                               return -EINVAL;
> +               /* End of pmu events. */
> +               if (!pe->name && !pe->metric_group && !pe->metric_name)
>                         break;
> -               }
>                 if (!pe->metric_expr)
>                         continue;
>                 if (match_metric(pe->metric_group, metric) ||
> -                   match_metric(pe->metric_name, metric)) {
> -                       has_match = true;
> -                       pr_debug("metric expr %s for %s\n", pe->metric_expr, pe->metric_name);
> -
> -                       if (!strstr(pe->metric_expr, "?")) {
> -                               ret = __metricgroup__add_metric(group_list,
> -                                                               pe,
> -                                                               metric_no_group,
> -                                                               1);
> -                               if (ret)
> -                                       return ret;
> -                       } else {
> -                               int j, count;
> -
> -                               count = arch_get_runtimeparam();
> -
> -                               /* This loop is added to create multiple
> -                                * events depend on count value and add
> -                                * those events to group_list.
> -                                */
> +                   match_metric(pe->metric_name, metric))
> +                       return pe;
> +       }
>
> -                               for (j = 0; j < count; j++) {
> -                                       ret = __metricgroup__add_metric(
> -                                               group_list, pe,
> -                                               metric_no_group, j);
> -                                       if (ret)
> -                                               return ret;
> -                               }
> -                       }
> +       return NULL;
> +}
> +
> +static int metricgroup__add_metric(const char *metric, bool metric_no_group,
> +                                  struct strbuf *events,
> +                                  struct list_head *group_list,
> +                                  struct pmu_events_map *map)
> +{
> +       struct pmu_event *pe;
> +       struct egroup *eg;
> +       int ret;
> +
> +       pe = find_metric(metric, map);
> +       if (!pe)
> +               return -EINVAL;
> +
> +       pr_debug("metric expr %s for %s\n", pe->metric_expr, pe->metric_name);
> +
> +       if (!strstr(pe->metric_expr, "?")) {
> +               ret = __metricgroup__add_metric(group_list,
> +                                               pe,
> +                                               metric_no_group,
> +                                               1);
> +               if (ret)
> +                       return ret;
> +       } else {
> +               int j, count;
> +
> +               count = arch_get_runtimeparam();
> +
> +               /* This loop is added to create multiple
> +                * events depend on count value and add
> +                * those events to group_list.
> +                */
> +
> +               for (j = 0; j < count; j++) {
> +                       ret = __metricgroup__add_metric(
> +                               group_list, pe,
> +                               metric_no_group, j);
> +                       if (ret)
> +                               return ret;
>                 }
>         }
>         list_for_each_entry(eg, group_list, nd) {
> --
> 2.25.4
>
