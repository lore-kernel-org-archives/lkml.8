Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0027CC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 14:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD2952064A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 14:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d9r6Sy6+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391017AbgDNOid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 10:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390985AbgDNOia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 10:38:30 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA178C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 07:38:29 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id l84so7318476ybb.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 07:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p3GiF90PQI3jeuHnPGpuoR4Am0RayaZ8dRJRZLF0hd4=;
        b=d9r6Sy6+FgVl9y+hN0tQGsQpbnEOnJHmrPmW3c0dscAmUBINQ7o1Z8KzaPgA+9VVhy
         /OLS+JSTRqocLZBakm4b7Wd/2ihJBl47rx+yZgQqI09wkym1D5s5B9vp1SwjjbVqoFXp
         KPm9RSbo2clb3k8nbByuQYH7HbtkQ3VInL9pU4gHvLudkZ92Kxo137h34Rk0IQ4WzVFF
         CLSsYkrVAjCqzP/ak2ZjlFfU8qyl/UoyJKIkxiEJIO9elhzDUOVqtQXLpbMtiZvnE8sG
         NYhf2nT7iQCZlc0CZ7TR1A8YAMfx4gxyK96aZn9qVYJk5iFx/CEqGS0Vro/OLxAZlJvR
         EFVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p3GiF90PQI3jeuHnPGpuoR4Am0RayaZ8dRJRZLF0hd4=;
        b=D4OkW/zoipKgMhpGtzLJODCdVwocvjQ64UMCb9jSoSKUZDCR8GDyk3Na1JZT+SEIcw
         GdMehPYoPyxB3w+jfj7mppV3PbiMdocypr9lGOYoCAy5R1Ei0FK6S3jp+0EoATxNsZ9U
         A4Uf+Hcm4LA3NZFZAHExGVmtlUUaTEvhdYFn7+6bBTpa+A6j+J7N4zOqdnnhmiQmwWfq
         KhGyTfAQVKWq/zez8KmFHZsIHnUQjvVsMimas/v+8xD6fhJfeP2TfpESh38lg47ZMgV4
         +B/KqTTi62YcJmRtsZ+xSgLEtZ9F325HUW/oHDzmXGUVBDcC5G6Wd/xBmCW1cAAjj97W
         ZozA==
X-Gm-Message-State: AGi0Pua5Nh3qEXaj8VRNAQxffAmPdadxadGRZkei5YtU3/JgotJ7D45Z
        uW02ws9Aweof4ae5ILAMjtdYyAf5V4+FYadhDzaNbQ==
X-Google-Smtp-Source: APiQypIk9DBVt3Yrvr2s7+gINd1eNMWwbxTIZEeqCXhnDy5IB1CctPu0YRml/nOZ6+Ry4q7ICIb8tcczd9FzTEG7gyM=
X-Received: by 2002:a25:ddc3:: with SMTP id u186mr421063ybg.383.1586875108752;
 Tue, 14 Apr 2020 07:38:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200413235515.221467-1-irogers@google.com> <20200414130209.GD117177@krava>
In-Reply-To: <20200414130209.GD117177@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 14 Apr 2020 07:38:17 -0700
Message-ID: <CAP-5=fVM6gg3Bo5jHwYG=vhLZ-HQaQfwZFg_=DwRJOmHqRRDMA@mail.gmail.com>
Subject: Re: [PATCH] perf stat: force error in fallback on :k events
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 6:02 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Mon, Apr 13, 2020 at 04:55:15PM -0700, Ian Rogers wrote:
> > From: Stephane Eranian <eranian@google.com>
> >
> > When it is not possible for a non-privilege perf command
> > to monitor at the kernel level (:k), the fallback code forces
> > a :u. That works if the event was previously monitoring both levels.
> > But if the event was already constrained to kernel only, then it does
> > not make sense to restrict it to user only.
> > Given the code works by exclusion, a kernel only event would have:
> > attr->exclude_user = 1
> > The fallback code would add:
> > attr->exclude_kernel = 1;
> >
> > In the end the end would not monitor in either the user level or kernel
> > level. In other words, it would count nothing.
> >
> > An event programmed to monitor kernel only cannot be switched to user only
> > without seriously warning the user.
> >
> > This patch forces an error in this case to make it clear the request
> > cannot really be satisfied.
> >
> > Signed-off-by: Stephane Eranian <eranian@google.com>
> > Reviewed-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/evsel.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index d23db6755f51..d1e8862b86ce 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -2446,6 +2446,13 @@ bool perf_evsel__fallback(struct evsel *evsel, int err,
> >               char *new_name;
> >               const char *sep = ":";
> >
> > +             if (evsel->core.attr.exclude_user) {
> > +                     scnprintf(msg, msgsize,
> > +"kernel.perf_event_paranoid=%d, event set to exclude user, so cannot also exclude kernel",
> > +                             paranoid);
> > +                     return false;
>
> I'm not able to get this error printed, it seems to be
> overwritten by perf_evsel__open_strerror call
>
> please include perf example with the new output

Agreed, it is possible the change builtin-top/sched/record so that on
error the msg is checked and dumped in verbose mode. I think it is
also fine to just remove the scnprintf. Do you have a preference?

Thanks,
Ian

> thanks,
> jirka
>
> > +             }
> > +
> >               /* Is there already the separator in the name. */
> >               if (strchr(name, '/') ||
> >                   strchr(name, ':'))
> > --
> > 2.26.0.110.g2183baf09c-goog
> >
>
