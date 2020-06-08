Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CBC8C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 16:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 566452076A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 16:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ICRkLk+E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387481AbgFHQw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 12:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730637AbgFHQw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 12:52:56 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D731BC08C5C2
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 09:52:55 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id a80so9567906ybg.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 09:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LxC9yr5pcIbFYNuvtgd8dcuLjHwvYsOdMQD9eBhAIIs=;
        b=ICRkLk+EWV0XKL+5j4ZWGdsA2MnZSDJ8kyz0KyhVYqMiL922ZjMPhIUPkNsklFgaw1
         4jlS72yUIFx/SnaqlPgIOub3YmR3SuvS7HukJFo2fMf3uU8aTGhcZRAL+PBkNI36jEz+
         XJQMGgmzsWOnt7rmV/jLxDkwDBY48dmzkK0vLfyjDU8fgdKfvse/1V0Bah79RckaVE9W
         UirUP5/JwFIx8yvP/g0F9c1us4il4kxmzlUd1YRNyZ9FMYeoBURGLaaGWQjx4kUf6hqH
         yN+B172w1HFnnyrQNwHJArrFh9tKra8O5a4jLARwSRwSXsY0XUTaBzTk8rVxOdSKUwzl
         819w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LxC9yr5pcIbFYNuvtgd8dcuLjHwvYsOdMQD9eBhAIIs=;
        b=TXZvI1Db3c4/fafEYp0ZTCsVWDvNJKxmn8UWnwDIUKIE4yuGcVSKMwLVjTNHYAreq1
         am6rtHPgtfN6yWVSkHjGtgVLCM9J7rmIXX0ZPiKkoBRG+YS00d0hRFczGZwICAPNSlzi
         l+fm0R/vX9tVkMWKpMc0Ds7nBZ6C9BZciCh+y0kP6Cp6fEx1XSHAaUzm17J5WAPbxnfI
         TE0AvIQM55p/RzQ0kOu18pP+EM9CvnoTDWZw2aH2PMY8rBFX4YMfv30RP1bcOS33Lj5o
         6XBNCIHb71kambBCMl5DnFzK6ZjehJnZ50TB2b+od+TvLRqtzjs9u6ia+QZwZPSzAQm5
         1xdQ==
X-Gm-Message-State: AOAM532cSw2e1Q4seMfta8tUrcZnI1dDUh+7GeN/4ZsePRgfmsB0x9z4
        o1imUgFHTUJz4DtQcXulYdlegtMEU0i7VIZAnI2Ffg==
X-Google-Smtp-Source: ABdhPJzk/ToSU4eBaN+gQQO6z9MooSc81KgTbKAz11Ec1pWQtsNNSDUQWFLkl+kO95xnA6Lnr7FX5q/i7PUyAR4ElFM=
X-Received: by 2002:a5b:f4d:: with SMTP id y13mr7799523ybr.286.1591635174852;
 Mon, 08 Jun 2020 09:52:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200608161805.65841-1-eranian@google.com>
In-Reply-To: <20200608161805.65841-1-eranian@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 8 Jun 2020 09:52:43 -0700
Message-ID: <CAP-5=fXmrbBqDj6udGJCLHF5ePERr1S5qTKGZZAUBC1EmA-8LQ@mail.gmail.com>
Subject: Re: [PATCH] perf headers: fix processing of pmu_mappings
To:     Stephane Eranian <eranian@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, mingo@elte.hu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 8, 2020 at 9:18 AM Stephane Eranian <eranian@google.com> wrote:
>
> This patch fixes a bug in process_pmu_mappings() where the code
> would not produce an env->pmu_mappings string that was easily parsable.
> The function parses the PMU_MAPPING header information into a string
> consisting of value:name pairs where value is the PMU type identifier
> and name is the PMU name, e.g., 10:ibs_fetch. As it was, the code
> was producing a truncated string with only the first pair showing
> even though the rest was there but after the \0.
> This patch fixes the problem byt adding a proper white space between
> pairs and moving the \0 termination to the end. With this patch applied,
> all pairs appear and are easily parsed.
>
> Before:
> 14:amd_iommu_1
>
> After:
> 14:amd_iommu_1 7:uprobe 5:breakpoint 10:amd_l3 19:amd_iommu_6 8:power 4:cpu 17:amd_iommu_4 15:amd_iommu_2 1:software 6:kprobe 13:amd_iommu_0 9:amd_df 20:amd_iommu_7 18:amd_iommu_5 2:tracepoint 21:msr 12:ibs_op 16:amd_iommu_3 11:ibs_fetch
>
> Signed-off-by: Stephane Eranian <eranian@google.com>
> ---
>  tools/perf/util/header.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 7a67d017d72c3..cf72124da9350 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -2462,13 +2462,15 @@ static int process_numa_topology(struct feat_fd *ff, void *data __maybe_unused)
>  static int process_pmu_mappings(struct feat_fd *ff, void *data __maybe_unused)
>  {
>         char *name;
> -       u32 pmu_num;
> +       u32 pmu_num, o_num;
>         u32 type;
>         struct strbuf sb;
>
>         if (do_read_u32(ff, &pmu_num))
>                 return -1;
>
> +       o_num = pmu_num;
> +
>         if (!pmu_num) {
>                 pr_debug("pmu mappings not available\n");
>                 return 0;
> @@ -2486,10 +2488,11 @@ static int process_pmu_mappings(struct feat_fd *ff, void *data __maybe_unused)
>                 if (!name)
>                         goto error;
>
> -               if (strbuf_addf(&sb, "%u:%s", type, name) < 0)
> +               /* add proper spacing between entries */
> +               if (pmu_num < o_num && strbuf_add(&sb, " ", 1) < 0)
>                         goto error;
> -               /* include a NULL character at the end */
> -               if (strbuf_add(&sb, "", 1) < 0)
> +
> +               if (strbuf_addf(&sb, "%u:%s", type, name) < 0)
>                         goto error;
>
>                 if (!strcmp(name, "msr"))
> @@ -2498,6 +2501,9 @@ static int process_pmu_mappings(struct feat_fd *ff, void *data __maybe_unused)
>                 free(name);
>                 pmu_num--;
>         }
> +       /* include a NULL character at the end */
> +       if (strbuf_add(&sb, "", 1) < 0)
> +               goto error;
>         ff->ph->env.pmu_mappings = strbuf_detach(&sb, NULL);
>         return 0;
>
> --
> 2.27.0.278.ge193c7cf3a9-goog

Acked-by: Ian Rogers <irogers@google.com>

A lot of the complexity in this code came from strbuf not \0
terminating strings. Would a strbuf that always \0 terminated be a
useful change? In general there's a lack of consistent style with
strbuf, strcat and asprintf being used in different parts of the code.
Perhaps strbuf use should migrate to asprintf? There are currently
just 13 callers of strbuf_init.

Thanks,
Ian
