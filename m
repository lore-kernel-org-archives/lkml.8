Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F86FC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 17:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC27224958
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 17:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fKnrsQXE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgEHRWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 13:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbgEHRWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 13:22:17 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C50CC061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 10:22:17 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id c2so1301390ybi.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 10:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3BZcZCzohuOP+8Cj8iVBVdevp4JbY7gWgDz8TOl6KdQ=;
        b=fKnrsQXE3DCx0wx6qh99OwgoCRBlTvUiGV4qz0NQRWVpgWapYPb7Mu8R414CKmYEoN
         /yGyYtPv8NcmU6WA66L+G8ra0WXK39Jg2iK+FZoHKjoqOujUsNKFLadAn0pjYrroJEJ1
         HjJk7Bd4IeLUrzO3HRcotI2PQkuoAQnUyX3s4LKm/5U2x0koMBzoqU+YYX2++bYtEjLj
         8g/DVfqqfMQtBV5TvIN57EhHG2dwDWDFE/M+mB4XPT7467IrKjKJ63JuDWLfDfJecWLb
         DxPOhWHr6c71UYGqQs7gtzdhRu9GXJo++6+x+hxsri+ydDAzjhUho6E3Qs9rqBEW0eAv
         Qfxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3BZcZCzohuOP+8Cj8iVBVdevp4JbY7gWgDz8TOl6KdQ=;
        b=kztOUs2MrKoHTQfMY3oeRUQUsfriiu4Nc9UChfmnh9rioWF+4lNCYUtACAucUGeP8Z
         lFvBDJx8Vc+ICz1uaZbL345ymDPLcrjlFQX2/xxErvHfa61fKBBEGrSQdItM8382rtSf
         vooKQsKSJKykk7RfBYi60Oa/L5b4IXK6dNrBVDxrQ5886U5bW3ZAUH0QZmFaIWOwFr9u
         S2kcIncBLw+CTCjEbqh1ylrCAfbSe1IITay2ja/ddNEZTRbG+pYPdq3Qg6YMymo9Um2D
         f8lV2FIvQAvhTUKBWrFla7hMIyYufo4PTRvBgk5+K3ZpRjYupSt5DW9OPBKo2eESEWGY
         Gt0A==
X-Gm-Message-State: AGi0PubZRJ/u1gULebWuyMKIzCbzg+p2buCaTxj8imBmmdve9KZeJjsi
        KjlTO/kMZz1aD+A/v6Aimgc5hSqupSG16BXmcOsNeQ==
X-Google-Smtp-Source: APiQypK2WyCYY6uWTsBnOv6jWEG9LVq4N7h+sv7xX9CwD7WpR+HpUUlIZAnEWtp6mVPRDbPJWEbxq5YHgMUk0bJEpgw=
X-Received: by 2002:a25:d688:: with SMTP id n130mr6132388ybg.324.1588958535241;
 Fri, 08 May 2020 10:22:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200422173615.59436-1-irogers@google.com> <20200508162944.GA20581@kernel.org>
In-Reply-To: <20200508162944.GA20581@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 8 May 2020 10:22:03 -0700
Message-ID: <CAP-5=fVPheBUbngHu_2GZhxYgoqomFoG3dijkRF_+9JKEza+ng@mail.gmail.com>
Subject: Re: [PATCH v3] perf record: add dummy event during system wide synthesis
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 8, 2020 at 9:29 AM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Wed, Apr 22, 2020 at 10:36:15AM -0700, Ian Rogers escreveu:
> > During the processing of /proc during event synthesis new processes may
> > start. Add a dummy event if /proc is to be processed, to capture mmaps
> > for starting processes. This reuses the existing logic for
> > initial-delay.
> >
> > v3 fixes the attr test of test-record-C0
> > v2 fixes the dummy event configuration and a branch stack issue.
>
> Thanks, applied after splitting it up into two patches, one for this
> part:
>
> > +++ b/tools/perf/util/evsel.c
> > @@ -1163,11 +1163,14 @@ void perf_evsel__config(struct evsel *evsel, struct record_opts *opts,
> >       }
> >
> >       /*
> > +      * A dummy event never triggers any actual counter and therefore
> > +      * cannot be used with branch_stack.
> > +      *
> >        * For initial_delay, a dummy event is added implicitly.
> >        * The software event will trigger -EOPNOTSUPP error out,
> >        * if BRANCH_STACK bit is set.
> >        */
> > -     if (opts->initial_delay && is_dummy_event(evsel))
> > +     if (is_dummy_event(evsel))
> >               perf_evsel__reset_sample_bit(evsel, BRANCH_STACK);
> >  }
>
> Which isn't related to what is in the subject line for this patch, ok?
>
> We don't need to get more patches, but we need to have patches that do
> one thing and just that, to ease with bisecting, reverting things
> sometimes, etc.

Thanks for merging! Won't that separation break system wide mode? I
guess you can do the evsel change first and then the system wide
change, but the effect of 1 change won't be felt without the other.
I'm looking to keep patches separate but when one patch can only be
tested with another in place the separation is hard to work with for
testing. There is also the issue of trying to understand the context a
change was made, which is broken by separation. Anyway, I want to
minimize your work in merging changes so I'll try to fit your needs
with future patches.

Thanks,
Ian

> And thanks for the extra comments :-)
>
> - Arnaldo
>
> > Suggested-by: Stephane Eranian <eranian@google.com>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/builtin-record.c             | 19 +++++++---
> >  tools/perf/tests/attr/system-wide-dummy | 50 +++++++++++++++++++++++++
> >  tools/perf/tests/attr/test-record-C0    | 12 +++++-
> >  tools/perf/util/evsel.c                 |  5 ++-
> >  4 files changed, 78 insertions(+), 8 deletions(-)
> >  create mode 100644 tools/perf/tests/attr/system-wide-dummy
> >
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index 1ab349abe904..8d1e93351298 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -805,19 +805,28 @@ static int record__open(struct record *rec)
> >       int rc = 0;
> >
> >       /*
> > -      * For initial_delay we need to add a dummy event so that we can track
> > -      * PERF_RECORD_MMAP while we wait for the initial delay to enable the
> > -      * real events, the ones asked by the user.
> > +      * For initial_delay or system wide, we need to add a dummy event so
> > +      * that we can track PERF_RECORD_MMAP to cover the delay of waiting or
> > +      * event synthesis.
> >        */
> > -     if (opts->initial_delay) {
> > +     if (opts->initial_delay || target__has_cpu(&opts->target)) {
> >               if (perf_evlist__add_dummy(evlist))
> >                       return -ENOMEM;
> >
> > +             /* Disable tracking of mmaps on lead event. */
> >               pos = evlist__first(evlist);
> >               pos->tracking = 0;
> > +             /* Set up dummy event. */
> >               pos = evlist__last(evlist);
> >               pos->tracking = 1;
> > -             pos->core.attr.enable_on_exec = 1;
> > +             /*
> > +              * Enable the dummy event when the process is forked for
> > +              * initial_delay, immediately for system wide.
> > +              */
> > +             if (opts->initial_delay)
> > +                     pos->core.attr.enable_on_exec = 1;
> > +             else
> > +                     pos->immediate = 1;
> >       }
> >
> >       perf_evlist__config(evlist, opts, &callchain_param);
> > diff --git a/tools/perf/tests/attr/system-wide-dummy b/tools/perf/tests/attr/system-wide-dummy
> > new file mode 100644
> > index 000000000000..eba723cc0d38
> > --- /dev/null
> > +++ b/tools/perf/tests/attr/system-wide-dummy
> > @@ -0,0 +1,50 @@
> > +# Event added by system-wide or CPU perf-record to handle the race of
> > +# processes starting while /proc is processed.
> > +[event]
> > +fd=1
> > +group_fd=-1
> > +cpu=*
> > +pid=-1
> > +flags=8
> > +type=1
> > +size=120
> > +config=9
> > +sample_period=4000
> > +sample_type=455
> > +read_format=4
> > +# Event will be enabled right away.
> > +disabled=0
> > +inherit=1
> > +pinned=0
> > +exclusive=0
> > +exclude_user=0
> > +exclude_kernel=0
> > +exclude_hv=0
> > +exclude_idle=0
> > +mmap=1
> > +comm=1
> > +freq=1
> > +inherit_stat=0
> > +enable_on_exec=0
> > +task=1
> > +watermark=0
> > +precise_ip=0
> > +mmap_data=0
> > +sample_id_all=1
> > +exclude_host=0
> > +exclude_guest=0
> > +exclude_callchain_kernel=0
> > +exclude_callchain_user=0
> > +mmap2=1
> > +comm_exec=1
> > +context_switch=0
> > +write_backward=0
> > +namespaces=0
> > +use_clockid=0
> > +wakeup_events=0
> > +bp_type=0
> > +config1=0
> > +config2=0
> > +branch_sample_type=0
> > +sample_regs_user=0
> > +sample_stack_user=0
> > diff --git a/tools/perf/tests/attr/test-record-C0 b/tools/perf/tests/attr/test-record-C0
> > index 93818054ae20..317730b906dd 100644
> > --- a/tools/perf/tests/attr/test-record-C0
> > +++ b/tools/perf/tests/attr/test-record-C0
> > @@ -9,6 +9,14 @@ cpu=0
> >  # no enable on exec for CPU attached
> >  enable_on_exec=0
> >
> > -# PERF_SAMPLE_IP | PERF_SAMPLE_TID PERF_SAMPLE_TIME | # PERF_SAMPLE_PERIOD
> > +# PERF_SAMPLE_IP | PERF_SAMPLE_TID | PERF_SAMPLE_TIME |
> > +# PERF_SAMPLE_ID | PERF_SAMPLE_PERIOD
> >  # + PERF_SAMPLE_CPU added by -C 0
> > -sample_type=391
> > +sample_type=455
> > +
> > +# Dummy event handles mmaps, comm and task.
> > +mmap=0
> > +comm=0
> > +task=0
> > +
> > +[event:system-wide-dummy]
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index 6a571d322bb2..ca8f9533d8f9 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -1163,11 +1163,14 @@ void perf_evsel__config(struct evsel *evsel, struct record_opts *opts,
> >       }
> >
> >       /*
> > +      * A dummy event never triggers any actual counter and therefore
> > +      * cannot be used with branch_stack.
> > +      *
> >        * For initial_delay, a dummy event is added implicitly.
> >        * The software event will trigger -EOPNOTSUPP error out,
> >        * if BRANCH_STACK bit is set.
> >        */
> > -     if (opts->initial_delay && is_dummy_event(evsel))
> > +     if (is_dummy_event(evsel))
> >               perf_evsel__reset_sample_bit(evsel, BRANCH_STACK);
> >  }
> >
> > --
> > 2.26.2.303.gf8c07b1a785-goog
> >
>
> --
>
> - Arnaldo
