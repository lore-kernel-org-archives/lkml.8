Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D1DC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 180E420752
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gTh04MXV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731742AbgEKU3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 16:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727873AbgEKU3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:29:54 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B92FC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 13:29:54 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id m10so3403417ybf.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 13:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lqp0tT919521XWu/FUN0YyklAmxZCcc7Pfzs6YFFyZU=;
        b=gTh04MXVd2ji8esde/XdgwiKEYioXZQWX+fFBKH6JEiBecEkSRsRqrAQ3fbQ0sVtvs
         rUW0WAjPDRTZfKzHm2w+goxZHdU9MwNYPHxD8NFvd89tVRHUUr54/rUXkb1/e1qNvXEa
         NLg7+4Qr2jNp29uCoiVxNHDvO++q+AKSa/cPOgnUjd8Cmi9oBSrBDI6bemuMbek96bDy
         YFxHqK+/1Xceey7uIheOkCWJBTEVS5v8Ja3mxG5EETXXoAcF1X61fH42PWxvxRV24c+6
         282FwYVApaAyum+trJtEader9KEXHCtim+JjkX1lBNH826zy32LZPf+WcgN+T85CuNAs
         ETFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lqp0tT919521XWu/FUN0YyklAmxZCcc7Pfzs6YFFyZU=;
        b=W4JoI2iYe+gR4HXjs5J/bRyOUBy3b4MlZSY5tJQlF8M7WtTMu9QVoU/eKA7Krfxv11
         4jVLx/TkOL7LJf5YUE11TMBalgI1n/U1ZNsHM9g3DjntnvpQplwhy4L6SUdMyQRpavmf
         DbVH+D8dKPLn79VOmrfKt+xDcNZ6zLjgoCCuFEc9++WGxlVl0206kRhx1rgu1AlYOBG2
         SgqL9ScVCjeX2kfGh0ZsfSdP10xUOXjS3NHAa3ZgDLkQNxMQDK4l25ReEUxroAh6y+zN
         msYngQhTsCCEPs61Mvt8yVeH0WSIE26CrIRptsuK7IAELPBjBT9E2XtfLoyqiCpxshkb
         IUuw==
X-Gm-Message-State: AOAM530Khq7qZfghZOyHdpbbfZUVyopV3cwO4qXWdBoAaqSQFVbujNYF
        R8HIRwf6YytFUCTIcqFId5AmFAQ9bd79h/gShooE8Q==
X-Google-Smtp-Source: ABdhPJwLFCL10MARvUZLxQAGbzISzHL5pRVyScdEK4Opo1IIG/HghTobshcJkT2f7jzyV+l6qJv7u0U/WiDrd1Cg6U4=
X-Received: by 2002:a25:d450:: with SMTP id m77mr7993937ybf.177.1589228993297;
 Mon, 11 May 2020 13:29:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200507220604.3391-1-irogers@google.com> <20200511193604.GF2986380@krava>
In-Reply-To: <20200511193604.GF2986380@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 11 May 2020 13:29:42 -0700
Message-ID: <CAP-5=fWQ_bx0g3dGDQcmW7MhUAadA0rwahGPvGFTfGo6qoeLww@mail.gmail.com>
Subject: Re: [PATCH v3] perf c2c: fix '-e list'
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 12:36 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Thu, May 07, 2020 at 03:06:04PM -0700, Ian Rogers wrote:
> > When the event is passed as list, the default events should be listed as
> > per 'perf mem record -e list'. Previous behavior is:
> >
> > $ perf c2c record -e list
> > failed: event 'list' not found, use '-e list' to get list of available events
> >
> >  Usage: perf c2c record [<options>] [<command>]
> >     or: perf c2c record [<options>] -- <command> [<options>]
> >
> >     -e, --event <event>   event selector. Use 'perf mem record -e list' to list available events
> >
> > New behavior:
> >
> > $ perf c2c record -e list
> > ldlat-loads  : available
> > ldlat-stores : available
> >
> > v3: is a rebase.
> > v2: addresses review comments by Jiri Olsa.
> > https://lore.kernel.org/lkml/20191127081844.GH32367@krava/
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/Documentation/perf-c2c.txt |  2 +-
> >  tools/perf/builtin-c2c.c              |  9 ++++++++-
> >  tools/perf/builtin-mem.c              | 24 +++++++-----------------
> >  tools/perf/util/mem-events.c          | 15 +++++++++++++++
> >  tools/perf/util/mem-events.h          |  2 ++
> >  5 files changed, 33 insertions(+), 19 deletions(-)
> >
> > diff --git a/tools/perf/Documentation/perf-c2c.txt b/tools/perf/Documentation/perf-c2c.txt
> > index 2133eb320cb0..98efdab5fbd4 100644
> > --- a/tools/perf/Documentation/perf-c2c.txt
> > +++ b/tools/perf/Documentation/perf-c2c.txt
> > @@ -40,7 +40,7 @@ RECORD OPTIONS
> >  --------------
> >  -e::
> >  --event=::
> > -     Select the PMU event. Use 'perf mem record -e list'
> > +     Select the PMU event. Use 'perf c2c record -e list'
> >       to list available events.
> >
> >  -v::
> > diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> > index 1baf4cae086f..d617d5682c68 100644
> > --- a/tools/perf/builtin-c2c.c
> > +++ b/tools/perf/builtin-c2c.c
> > @@ -2887,8 +2887,15 @@ static int parse_record_events(const struct option *opt,
> >  {
> >       bool *event_set = (bool *) opt->value;
> >
> > +     if (!strcmp(str, "list")) {
> > +             perf_mem_events__list();
> > +             exit(0);
> > +     }
> > +     if (perf_mem_events__parse(str))
> > +             exit(-1);
>
> won't this exit(-1) callsbreak the parsing stuff?
> like displaying the option values on error or such?

The previous code was:
-       if (strcmp(str, "list")) {
This is handled explicitly in the code above this.

-               if (!perf_mem_events__parse(str)) {
-                       mem->operation = 0;
-                       return 0;
-               }
-               exit(-1);
This is the code where the exit -1 happens, I inverted the comparison
so that exit was more the exceptional code path. The behavior should
be identical.

Thanks,
Ian

> other than that it looks ok to me
>
> jirka
>
