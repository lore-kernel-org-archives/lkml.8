Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C620C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 00:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 575E720723
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 00:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aDA2GwNK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728439AbgFAAFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 20:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgFAAE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 20:04:59 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDF6C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 17:04:59 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id p123so4319282yba.6
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 17:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jjj6eWvS7e1mj+eJam5N+2rvoKgDVsk9FDt9PbhoqpY=;
        b=aDA2GwNKefW0b0673a1OSraFtu3qnzx/a02mNNikuBNMHd0y4zKy9t3UjzcSOoDITy
         se32lqZ+qFW4raVgkryWrgaeMvhzByfDcURBVy53mNA+Fgtc2Gl++KQnrwEdUmehyFob
         5dqWy1EXCHCyTAhoTNZPnTvYsO10fnDjTC7a1ZV+mxhWC7ShPZDY+VyoVRLHnemmP5sL
         D3D3KZu5vN74hSh8fRXIWo7/mz0OvzOj3vyOKF8QWoAKN1ap/1Kcscs0BSSp/Y+uP6at
         vueTCOwM2fY2TkZBcpG0FOsvUQzM/pQOYGplIBxCoMDPcTc7KliD7MGa3aCwDcDu9Nr0
         7CWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jjj6eWvS7e1mj+eJam5N+2rvoKgDVsk9FDt9PbhoqpY=;
        b=OdPxiUyFtx7noAexZ5krNshFxlrmIhRN2bOM6A0B1KW1wyvQFSmUPqWzj8qC/ibFvQ
         S1mwCeGOfMSrD8q99GUIP4h13VjfhL+G2g3jWZGyTVxUFGGgTtzdg8d4qXWrMHPNV7nt
         2I/4Jhc5czcwWuLSExBBE+8/Bdu4AYRVKI3i0kwWFhmF3KO3BXxU4HsylXf2PkbUtCgu
         /QDxjqlaD4Ep6wVdl68sSM0fs1r0j2lO/h/6azMvNxR9GH5WuvZ19pXqrqY4Jl8AH4h2
         zaiLPwRU9w4gNe2b+mP/hHNOXcNLDWz6hGC/qYQRMHiT7wKseagO/QQGqi1z98PPuRSN
         N0DA==
X-Gm-Message-State: AOAM531UPErWsNdS1POYfKrcFnnwMKfsvmF5nLNIUBVDgRht7g9LuRXV
        DTSVjl6G7bX41QDJRcbc5+5pClAW01IW+sIuTHLkVy+O
X-Google-Smtp-Source: ABdhPJz4rGRL5Jkuspj93VWMocMBL6JgCsO5otMcIog8ue7DfHNRT+jjvBenNWEfxXnvknkQix3gLRbLR+C4k82JBLg=
X-Received: by 2002:a25:c08b:: with SMTP id c133mr30227264ybf.286.1590969898250;
 Sun, 31 May 2020 17:04:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200531162206.911168-1-jolsa@kernel.org>
In-Reply-To: <20200531162206.911168-1-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Sun, 31 May 2020 17:04:47 -0700
Message-ID: <CAP-5=fUk97P-ECojBya1CRE4SQoX2erNgFujEJFvSgOk6e6pdQ@mail.gmail.com>
Subject: Re: [PATCH] perf stat: Ensure group is defined on top of the same cpu mask
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
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

On Sun, May 31, 2020 at 9:22 AM Jiri Olsa <jolsa@kernel.org> wrote:
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

This is really cool! I wonder if there is a better wording for 'event
cpu maps' ? It may be useful to list what the cpu maps are for the
events as a diagnostic aid.

Thanks,
Ian

> Fixes: 6a4bb04caacc8 ("perf tools: Enable grouping logic for parsed events")
> Co-developed-by: Jin Yao <yao.jin@linux.intel.com>
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/builtin-stat.c | 51 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index b2b79aa161dd..512a41363d07 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -190,6 +190,55 @@ static struct perf_stat_config stat_config = {
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
> @@ -1962,6 +2011,8 @@ int cmd_stat(int argc, const char **argv)
>         } else if (argc && !strncmp(argv[0], "rep", 3))
>                 return __cmd_report(argc, argv);
>
> +       evlist__check_cpu_maps(evsel_list);
> +
>         interval = stat_config.interval;
>         timeout = stat_config.timeout;
>
> --
> 2.25.4
>
