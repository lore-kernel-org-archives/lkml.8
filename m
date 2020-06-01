Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 040ADC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 08:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3C8B206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 08:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xo6k765T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbgFAIPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 04:15:43 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46268 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726142AbgFAIPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 04:15:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590999341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ivinF440YL1yO0sGUAZhTpAZaKRycn1aa7X7LA045XU=;
        b=Xo6k765T/NZs2RlOw7Bzfo0jWCwA29nhtgl1eNh20hCFHDzTf/qGTp/xQrdXZY9mUtEkpM
        x0V82TNzPbO/M3Td3YsKjjIq+TPQnxfIArXynxRz2kjVv40vertI3WeQdeHFkhR6JVbPnq
        aYUpzRZ7sLLGjuwf7b7RqmNNQu3RkQg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-md2nsfSmNcmZtWBz-FSNgQ-1; Mon, 01 Jun 2020 04:15:37 -0400
X-MC-Unique: md2nsfSmNcmZtWBz-FSNgQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8F86219200C0;
        Mon,  1 Jun 2020 08:15:35 +0000 (UTC)
Received: from krava (unknown [10.40.192.36])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8790760BEC;
        Mon,  1 Jun 2020 08:15:32 +0000 (UTC)
Date:   Mon, 1 Jun 2020 10:15:31 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
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
Subject: Re: [PATCH] perf stat: Ensure group is defined on top of the same
 cpu mask
Message-ID: <20200601081531.GE881900@krava>
References: <20200531162206.911168-1-jolsa@kernel.org>
 <CAP-5=fUk97P-ECojBya1CRE4SQoX2erNgFujEJFvSgOk6e6pdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fUk97P-ECojBya1CRE4SQoX2erNgFujEJFvSgOk6e6pdQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 31, 2020 at 05:04:47PM -0700, Ian Rogers wrote:
> On Sun, May 31, 2020 at 9:22 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Jin Yao reported the issue (and posted first versions of this change)
> > with groups being defined over events with different cpu mask.
> >
> > This causes assert aborts in get_group_fd, like:
> >
> >   # perf stat -M "C2_Pkg_Residency" -a -- sleep 1
> >   perf: util/evsel.c:1464: get_group_fd: Assertion `!(fd == -1)' failed.
> >   Aborted
> >
> > All the events in the group have to be defined over the same
> > cpus so the group_fd can be found for every leader/member pair.
> >
> > Adding check to ensure this condition is met and removing the
> > group (with warning) if we detect mixed cpus, like:
> >
> >   $ sudo perf stat -e '{power/energy-cores/,cycles},{instructions,power/energy-cores/}'
> >   WARNING: event cpu maps do not match, disabling group:
> >     anon group { power/energy-cores/, cycles }
> >     anon group { instructions, power/energy-cores/ }
> 
> This is really cool! I wonder if there is a better wording for 'event
> cpu maps' ? It may be useful to list what the cpu maps are for the
> events as a diagnostic aid.

right, something like this in verbose mode?
it display cpu maps of events that did not match

[root@krava perf]# ./perf stat -e '{cycles,power/energy-cores/}' -v
WARNING: group events cpu maps do not match, disabling group:
  anon group { cycles, power/energy-cores/ }
     cycles: 0-7
     power/energy-cores/: 0

jirka

> 
> Thanks,
> Ian
> 
> > Fixes: 6a4bb04caacc8 ("perf tools: Enable grouping logic for parsed events")
> > Co-developed-by: Jin Yao <yao.jin@linux.intel.com>
> > Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/builtin-stat.c | 51 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 51 insertions(+)
> >
> > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > index b2b79aa161dd..512a41363d07 100644
> > --- a/tools/perf/builtin-stat.c
> > +++ b/tools/perf/builtin-stat.c
> > @@ -190,6 +190,55 @@ static struct perf_stat_config stat_config = {
> >         .big_num                = true,
> >  };
> >
> > +static bool cpus_map_matched(struct evsel *a, struct evsel *b)
> > +{
> > +       if (!a->core.cpus && !b->core.cpus)
> > +               return true;
> > +
> > +       if (!a->core.cpus || !b->core.cpus)
> > +               return false;
> > +
> > +       if (a->core.cpus->nr != b->core.cpus->nr)
> > +               return false;
> > +
> > +       for (int i = 0; i < a->core.cpus->nr; i++) {
> > +               if (a->core.cpus->map[i] != b->core.cpus->map[i])
> > +                       return false;
> > +       }
> > +
> > +       return true;
> > +}
> > +
> > +static void evlist__check_cpu_maps(struct evlist *evlist)
> > +{
> > +       struct evsel *evsel, *pos, *leader;
> > +       char buf[1024];
> > +
> > +       evlist__for_each_entry(evlist, evsel) {
> > +               leader = evsel->leader;
> > +
> > +               /* Check that leader matches cpus with each member. */
> > +               if (leader == evsel)
> > +                       continue;
> > +               if (cpus_map_matched(leader, evsel))
> > +                       continue;
> > +
> > +               /*
> > +                * If there's mismatch display dismantle the
> > +                * group and warn user.
> > +                */
> > +               WARN_ONCE(1, "WARNING: group events cpu maps do not match, disabling group:\n");
> > +               evsel__group_desc(leader, buf, sizeof(buf));
> > +               pr_warning("  %s\n", buf);
> > +
> > +               for_each_group_evsel(pos, leader) {
> > +                       pos->leader = pos;
> > +                       pos->core.nr_members = 0;
> > +               }
> > +               evsel->leader->core.nr_members = 0;
> > +       }
> > +}
> > +
> >  static inline void diff_timespec(struct timespec *r, struct timespec *a,
> >                                  struct timespec *b)
> >  {
> > @@ -1962,6 +2011,8 @@ int cmd_stat(int argc, const char **argv)
> >         } else if (argc && !strncmp(argv[0], "rep", 3))
> >                 return __cmd_report(argc, argv);
> >
> > +       evlist__check_cpu_maps(evsel_list);
> > +
> >         interval = stat_config.interval;
> >         timeout = stat_config.timeout;
> >
> > --
> > 2.25.4
> >
> 

