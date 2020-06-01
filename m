Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23102C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 16:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F100E206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 16:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T8HLFGd4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgFAQVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 12:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgFAQVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 12:21:01 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA5DC05BD43
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 09:21:01 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id t9so2492509ybk.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 09:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W40DinL331qIeXqWX5ayxHagpklU6DhmULvE0lzv51U=;
        b=T8HLFGd473UtnDsiesS/gwKlqFtr1it/5KEOFHrOMlOXlGROXXWMW/lDAcJGnxIs8a
         vXhDXwjkGdm3ZJbiHBVa8y96I3A9EG8TP+Mt20aLjQm/6X8Wn/2rPgKldhJJGbyWO/KS
         oGRCSTdlkAKzesD8A8zNHK+fdofClKRabIvTI1KbplDrpcToUewsflBVCagX/eLRO279
         Ghh0AtKl15RHzifaWlyXvHUFgcjBrzm4Qu41Xj5AELYdRGdPsDdrFhjOXyGsTvzx7VqH
         RvMI2Bj7qTM9AgpkCZDDTiuVZwRUw0rgCD96RX+xj8JOc+nygl8SrQV6RIOe2N3HbaoH
         jEVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W40DinL331qIeXqWX5ayxHagpklU6DhmULvE0lzv51U=;
        b=AMaJiZMRg5FKhTFSsatGtQHY5Ixu4m8lVaZHwLNR54W35qQEq6s9Jq5e5AdmTjZ7Fk
         8I/nhVzcct24mYu1Jrjuqz7MA5GPq/N4nSVn+gVxGpwwkuIe/yIUyZIT3/9SCD1Ak59c
         qetl50s1faXM6BKr9mK5iStKfbqjv48Oydz61DW3xKWKqXS6HU84zQIP6RA/QX7PGZoB
         UiN4tjU7+1cHkqMH/58cWWf5Q/gELQ6kK0w3tB/lWQs9forNZBw9hBGrYJM0MPMVZx+P
         7ttuikRXdMay4hbB6p85AZF7sQMoeYIE36J4Uvz6jJmc+nzUsMEtwc0t2L0ekPExl685
         9rTQ==
X-Gm-Message-State: AOAM5334r5q9wTHj2TFdEgrTB3Rch5IrtSv2Q/x7p/A18ll2mqXHOVIb
        WzuU/Lp/E61VyNB3+ktsLTN1ZmzfNo+N54oJeFkjwg==
X-Google-Smtp-Source: ABdhPJxZ6R+TWfNoVTbAIPqkWBx8Lgsy5ed62ApaAgfbfxEP8RigUcW39XL1vv9x9872nX4TbPSbFlwytHmg+nSruvo=
X-Received: by 2002:a25:be81:: with SMTP id i1mr34991850ybk.184.1591028460554;
 Mon, 01 Jun 2020 09:21:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200531162206.911168-1-jolsa@kernel.org> <CAP-5=fUk97P-ECojBya1CRE4SQoX2erNgFujEJFvSgOk6e6pdQ@mail.gmail.com>
 <20200601082027.GF881900@krava>
In-Reply-To: <20200601082027.GF881900@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 1 Jun 2020 09:20:49 -0700
Message-ID: <CAP-5=fWLp8qyVjwVuQCTEoz=SY5FFtEEZyH5=L-5cAEeN4_5uw@mail.gmail.com>
Subject: Re: [PATCHv2] perf stat: Ensure group is defined on top of the same
 cpu mask
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 1, 2020 at 1:20 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> Jin Yao reported the issue (and posted first versions of this change)
> with groups being defined over events with different cpu mask.
>
> This causes assert aborts in get_group_fd, like:
>
>   # perf stat -M "C2_Pkg_Residency" -a -- sleep 1
>   perf: util/evsel.c:1464: get_group_fd: Assertion `!(fd == -1)' failed.
>   Aborted
>
> All the events in the group have to be defined over the same
> cpus so the group_fd can be found for every leader/member pair.
>
> Adding check to ensure this condition is met and removing the
> group (with warning) if we detect mixed cpus, like:
>
>   $ sudo perf stat -e '{power/energy-cores/,cycles},{instructions,power/energy-cores/}'
>   WARNING: event cpu maps do not match, disabling group:
>     anon group { power/energy-cores/, cycles }
>     anon group { instructions, power/energy-cores/ }
>
> Ian asked also for cpu maps details, it's displayed in verbose mode:
>
>   $ sudo perf stat -e '{cycles,power/energy-cores/}' -v
>   WARNING: group events cpu maps do not match, disabling group:
>     anon group { power/energy-cores/, cycles }
>        power/energy-cores/: 0
>        cycles: 0-7
>     anon group { instructions, power/energy-cores/ }
>        instructions: 0-7
>        power/energy-cores/: 0

This is great! A nit, would 'grouped events cpus do not match' read
better? I think the cpu map is more of an internal naming convention.

Thanks,
Ian

> Fixes: 6a4bb04caacc8 ("perf tools: Enable grouping logic for parsed events")
> Co-developed-by: Jin Yao <yao.jin@linux.intel.com>
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/builtin-stat.c | 58 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>
> v2 changes:
>   - display mixed events maps in verbose mode
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index b2b79aa161dd..dda60b9dbc63 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -190,6 +190,62 @@ static struct perf_stat_config stat_config = {
>         .big_num                = true,
>  };
>
> +static bool cpus_map_matched(struct evsel *a, struct evsel *b)
> +{
> +       if (!a->core.cpus && !b->core.cpus)
> +               return true;
> +
> +       if (!a->core.cpus || !b->core.cpus)
> +               return false;
> +
> +       if (a->core.cpus->nr != b->core.cpus->nr)
> +               return false;
> +
> +       for (int i = 0; i < a->core.cpus->nr; i++) {
> +               if (a->core.cpus->map[i] != b->core.cpus->map[i])
> +                       return false;
> +       }
> +
> +       return true;
> +}
> +
> +static void evlist__check_cpu_maps(struct evlist *evlist)
> +{
> +       struct evsel *evsel, *pos, *leader;
> +       char buf[1024];
> +
> +       evlist__for_each_entry(evlist, evsel) {
> +               leader = evsel->leader;
> +
> +               /* Check that leader matches cpus with each member. */
> +               if (leader == evsel)
> +                       continue;
> +               if (cpus_map_matched(leader, evsel))
> +                       continue;
> +
> +               /*
> +                * If there's mismatch display dismantle the
> +                * group and warn user.
> +                */
> +               WARN_ONCE(1, "WARNING: group events cpu maps do not match, disabling group:\n");
> +               evsel__group_desc(leader, buf, sizeof(buf));
> +               pr_warning("  %s\n", buf);
> +
> +               if (verbose) {
> +                       cpu_map__snprint(leader->core.cpus, buf, sizeof(buf));
> +                       pr_warning("     %s: %s\n", leader->name, buf);
> +                       cpu_map__snprint(evsel->core.cpus, buf, sizeof(buf));
> +                       pr_warning("     %s: %s\n", evsel->name, buf);
> +               }
> +
> +               for_each_group_evsel(pos, leader) {
> +                       pos->leader = pos;
> +                       pos->core.nr_members = 0;
> +               }
> +               evsel->leader->core.nr_members = 0;
> +       }
> +}
> +
>  static inline void diff_timespec(struct timespec *r, struct timespec *a,
>                                  struct timespec *b)
>  {
> @@ -2113,6 +2169,8 @@ int cmd_stat(int argc, const char **argv)
>                 goto out;
>         }
>
> +       evlist__check_cpu_maps(evsel_list);
> +
>         /*
>          * Initialize thread_map with comm names,
>          * so we could print it out on output.
> --
> 2.25.4
>
