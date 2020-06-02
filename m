Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85223C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 15:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62B8C2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 15:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GGppdtml"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgFBPsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 11:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgFBPsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 11:48:17 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8323C05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 08:48:16 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id d13so3965877ybk.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 08:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7D+Gesf5VeOY6UB8iu5HAPTN7vFAkIyi9oq1WiCYfKI=;
        b=GGppdtml8Hmg6cHU7eTwhoNvI/HWEpa3UrZJRkleKa1iXqtfWI8DxDPtK3f/pUfbKM
         +zohXgMKwbQ03A2N5pkbfPDWqWaDKFrxF+lVVFgv+ur3Wh0qjBgpyepQGL6KIamdBEE1
         Y1d8SGUowbb3PV3/SWK7xI28Aa41XAxnNysIBHRVu3Vbtaa053ZTsiROOrH2XkXwi52R
         GTiH54DpThKngl5QargmQWzMZnB2nt/sPTUYRg2N/89/sByL6rSUyd+ZECPkEhSeykw0
         094d/bxxV3k2mQHlfycgfdxilGSCfw+vvKGc9Et1B/gd/zqnjgW8Z0x+2Dgvng4vDzTF
         wWPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7D+Gesf5VeOY6UB8iu5HAPTN7vFAkIyi9oq1WiCYfKI=;
        b=cPimpD9cJ75eUr2GNwqv6aKYHGXsIn16TOQf2Z5KrIA3tOzZmF/cYvAovjNwc6RuMV
         KNcbUAQa1x0KVdzrgRW4zToIwo+WFKcGv4CO88YVSNy8LhLO0hmQ7a3yyYeVTspuZfLM
         fYTDtb+bvLZpRDRXAb76CwkV/KTuO8p+vTN91Z4oMdw/cX6RwGFSDANCTwtNobCUQRMn
         vARyc9/aVZ83aLTZ6ttGQzU9HWvaXDbc5MaqXBA55SZWJTw/3PdFzbg/szsULFlc28Qh
         urCSA5A0YyJwxzK1TzKdkGMBOJrkZ63d1kjF37UxP8ImtxCM7u9RJzGhgNhLTNybuVYc
         6VkA==
X-Gm-Message-State: AOAM531epXoryQcfDQqpZE36IQRC/Edxhjhht4OtZKwZv3e4s1UOKWOF
        eueRRaX+SrMF5sNO74nIOlMqmJDTOfmUjVdvUflU8Q==
X-Google-Smtp-Source: ABdhPJwv/XL42FjlaV4YmCa1W6/N3Og+4Jo4QusVLtPKkrXZG2cE7REgeeOY3V4WmP7CC0ywMKK8tCkZjLq3IaF2zWs=
X-Received: by 2002:a5b:ec1:: with SMTP id a1mr18721631ybs.41.1591112895689;
 Tue, 02 Jun 2020 08:48:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200531162206.911168-1-jolsa@kernel.org> <CAP-5=fUk97P-ECojBya1CRE4SQoX2erNgFujEJFvSgOk6e6pdQ@mail.gmail.com>
 <20200601082027.GF881900@krava> <CAP-5=fWLp8qyVjwVuQCTEoz=SY5FFtEEZyH5=L-5cAEeN4_5uw@mail.gmail.com>
 <20200602101736.GE1112120@krava>
In-Reply-To: <20200602101736.GE1112120@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 2 Jun 2020 08:48:04 -0700
Message-ID: <CAP-5=fVrxpXAp3btYWJAXnnSC4fMLOza+hULRXVm1LKTj7P20A@mail.gmail.com>
Subject: Re: [PATCHv3] perf stat: Ensure group is defined on top of the same
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

On Tue, Jun 2, 2020 at 3:17 AM Jiri Olsa <jolsa@redhat.com> wrote:
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
>
> Fixes: 6a4bb04caacc8 ("perf tools: Enable grouping logic for parsed events")
> Co-developed-by: Jin Yao <yao.jin@linux.intel.com>
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
>  tools/perf/builtin-stat.c | 55 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
>
>  v3 changes:
>    - reword the warning with Ian's suggestion
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index b2b79aa161dd..9be020e0098a 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -190,6 +190,59 @@ static struct perf_stat_config stat_config = {
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
> +               /* If there's mismatch disable the group and warn user. */
> +               WARN_ONCE(1, "WARNING: grouped events cpus do not match, disabling group:\n");
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
> @@ -2113,6 +2166,8 @@ int cmd_stat(int argc, const char **argv)
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
