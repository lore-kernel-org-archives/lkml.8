Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2465C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 21:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE54520658
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 21:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ee9l3Ewn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbgGNVLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 17:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbgGNVLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 17:11:45 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD0FC061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 14:11:45 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id r12so149367wrj.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 14:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0bZxxgGja6pXJRsgu7DrcIxUysWFYNYsK1F7hKnVb/Q=;
        b=Ee9l3EwnMqPal7hABALi4cEnxpIBYAOxsL2g8vqFioa1kU0L2RbXqej2Kb7ATudRYI
         ltvNQ2HBVFgKQHhYmzq+w+iQ4de/vQ+Bqxu2/ajHaTJyq52Oi3kbYuokHWe0CrqUw8m3
         F4/IID3Z5Wf/31GJ2VLAhmD9/g0AQwXX4f0Ld3VwONpvkv1Zx7orEUN6dWG1B7Tw4JoF
         WFfTqyII/vr2Z+EX1yv+aD3wyaynhPioTuLBQcWaw5MehToY5oYNrMZxeGT5ZcOiRMrb
         4hq6wY9g7A5ySZjt2Bj0OxI9zdXCbONerY9D6/CTWAK7PHgoxHxWPj4zsuToSDg/asDf
         e6JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0bZxxgGja6pXJRsgu7DrcIxUysWFYNYsK1F7hKnVb/Q=;
        b=oRtG8VS22OWwC7LW1c7lqmjb9UdA0yfJNPurfMu1qEhNo1C2QtScYGVSQebnwfnK15
         lMdGOFhasdU9Obn4S5ESqfzs0J2lAUaNshgzGbD5h4risrxeXBqdSmeLwGAOttaHmz/a
         1jTbLz5veza5cuXa1pMLBJXqdL+GvrANPhDTej2s9A5JsZ2Y+un/Y+/+wUJmG1ldrj1Z
         2tER2CTodzOiawWszLdJZKqAGtuw7ViS9vCJxg38N77wPFzkP4ET4op1/eMh4iTP0Jxe
         xmE2IMThWPfEHrWAMlKBKBxYNHSDEJwRSGpyHViZfQRAFNvianigyglNkvIdit+CX80S
         p52g==
X-Gm-Message-State: AOAM533/8SZAmsTJhcEbnWeUL8cxwF6t4jqXLVPiEcWpCURcSZ9gh3pq
        14nF8+eyAdJddRhwSgIQMyOZwDrR+E0PtkF8eCiy7Q==
X-Google-Smtp-Source: ABdhPJzfh13nK6HUuzHYhLTwnjUGRd9XtMNnpD4z0eOLxPibyTgG+vi6ljERg43dSTuTm92hlqmHtHeZWr4HV+uz5d0=
X-Received: by 2002:adf:e6cb:: with SMTP id y11mr7729652wrm.282.1594761103775;
 Tue, 14 Jul 2020 14:11:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200712132634.138901-1-jolsa@kernel.org> <20200712132634.138901-9-jolsa@kernel.org>
In-Reply-To: <20200712132634.138901-9-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 14 Jul 2020 14:11:32 -0700
Message-ID: <CAP-5=fXjg1MSzzHHiSeco-dTZpwufJkHwTY6LHZ-xz9LEv94eA@mail.gmail.com>
Subject: Re: [PATCH 08/18] perf metric: Rename __metricgroup__add_metric to __add_metric
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
> Renaming __metricgroup__add_metric to __add_metric
> to fit in the current function names.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/metricgroup.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
>
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 9a168f3df7a4..f0b0a053bfd2 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -571,10 +571,10 @@ int __weak arch_get_runtimeparam(void)
>         return 1;
>  }
>
> -static int __metricgroup__add_metric(struct list_head *group_list,
> -                                    struct pmu_event *pe,
> -                                    bool metric_no_group,
> -                                    int runtime)
> +static int __add_metric(struct list_head *group_list,
> +                       struct pmu_event *pe,
> +                       bool metric_no_group,
> +                       int runtime)
>  {
>         struct egroup *eg;
>
> @@ -643,10 +643,7 @@ static int add_metric(struct list_head *group_list,
>         pr_debug("metric expr %s for %s\n", pe->metric_expr, pe->metric_name);
>
>         if (!strstr(pe->metric_expr, "?")) {
> -               ret = __metricgroup__add_metric(group_list,
> -                                               pe,
> -                                               metric_no_group,
> -                                               1);
> +               ret = __add_metric(group_list, pe, metric_no_group, 1);
>         } else {
>                 int j, count;
>
> @@ -658,9 +655,7 @@ static int add_metric(struct list_head *group_list,
>                  */
>
>                 for (j = 0; j < count && !ret; j++) {
> -                       ret = __metricgroup__add_metric(
> -                               group_list, pe,
> -                               metric_no_group, j);
> +                       ret = __add_metric(group_list, pe, metric_no_group, j);
>                 }
>         }
>
> --
> 2.25.4
>
