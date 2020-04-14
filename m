Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C877EC3815B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AA2C2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dnYHCASW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391434AbgDNQXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391393AbgDNQV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:21:56 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C1DC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 09:21:56 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id n188so6930498ybc.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 09:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1f3ZNjAipdWqn01FcBvkjSGQhICfEN6BiRkEXX2TWkk=;
        b=dnYHCASW4ZwpPhjwCr6CelVlsIFhQiraeCdBbPDzj+sjlg7kMBqu/hwO26JU3xMQqx
         Z+KKQcCN2XR547SxErlek5JWsNfGixGibbkGbhIcSLyAzmk1/pMIoTYuxEQty+XX51py
         SBzrc1TC+W9prxqJjkzSvOs+r2j7Nvy+W6y987xsR8wx6pOUOLzE9vNVkSiXpEqeaxeR
         gptCSdBUwU/LWpQr8MqZAXvPSC5iwMUBpqJNkdugdnzcarnGZWCBJY1u2DUy6+4yjtrU
         ierzkozaKcm0yt+mssaoTQRbXp8sWbQNhMZl/tyNW9oEufGKqf7OovqH/qUHtJU4/6jP
         kXyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1f3ZNjAipdWqn01FcBvkjSGQhICfEN6BiRkEXX2TWkk=;
        b=dXvrPrvzLS9M7tha+VqqR4kzULsiR7whVgTtgueqeX609rmdih38FoFVyYTWn4g3VF
         uPNkPshJCKpo2QKGJZV+irmEQWzS9jxyRSCi+0/pwI8kd5eXRX0oZA2X/jWrrKXme4EY
         7PdShQK7BjirxbmTgCQscRMs37zsEH9s6HNlvXAWD6JL9w25R6gmVrZByvV3pLYolu4K
         XH3T1ByTTbNtqEzVrGtPHrJs5iL0aUpd1KRrHR/MVQibkHLyOt63EIdnVjXXVabHgED8
         lGBHy2CCkoM5JhgD3W1o5aokDrs/ozQmMtirThBAWXZU7+nUk7F9U8HpCdZs6/meNOl/
         QPcw==
X-Gm-Message-State: AGi0Pua+ESyQssCjrJ3yEIPBwp6AlS7KkdelAeIV4Ws3fsVH9j1cWDKO
        6GoAxl/21ZPaAc1PhHmaKNE4rO2IhUiHo2I0DPOhwQ==
X-Google-Smtp-Source: APiQypI2cEfSAE0o32C/G2J4Imxu24B2IucsWdSzaXWLTvYcArwtjaAsGN3JbLlAt3zkKU33Nt3jc3F6S0hAYkIycTk=
X-Received: by 2002:a25:aaa4:: with SMTP id t33mr1250100ybi.324.1586881315033;
 Tue, 14 Apr 2020 09:21:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200413235515.221467-1-irogers@google.com> <20200414130209.GD117177@krava>
 <CAP-5=fVM6gg3Bo5jHwYG=vhLZ-HQaQfwZFg_=DwRJOmHqRRDMA@mail.gmail.com> <20200414151247.GB208694@krava>
In-Reply-To: <20200414151247.GB208694@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 14 Apr 2020 09:21:43 -0700
Message-ID: <CAP-5=fWw_oPknf_Rp5gCuLJwnD2oHYSPXQz5XXHrOUnWCTfMjA@mail.gmail.com>
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

On Tue, Apr 14, 2020 at 8:12 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Tue, Apr 14, 2020 at 07:38:17AM -0700, Ian Rogers wrote:
> > On Tue, Apr 14, 2020 at 6:02 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > >
> > > On Mon, Apr 13, 2020 at 04:55:15PM -0700, Ian Rogers wrote:
> > > > From: Stephane Eranian <eranian@google.com>
> > > >
> > > > When it is not possible for a non-privilege perf command
> > > > to monitor at the kernel level (:k), the fallback code forces
> > > > a :u. That works if the event was previously monitoring both levels.
> > > > But if the event was already constrained to kernel only, then it does
> > > > not make sense to restrict it to user only.
> > > > Given the code works by exclusion, a kernel only event would have:
> > > > attr->exclude_user = 1
> > > > The fallback code would add:
> > > > attr->exclude_kernel = 1;
> > > >
> > > > In the end the end would not monitor in either the user level or kernel
> > > > level. In other words, it would count nothing.
> > > >
> > > > An event programmed to monitor kernel only cannot be switched to user only
> > > > without seriously warning the user.
> > > >
> > > > This patch forces an error in this case to make it clear the request
> > > > cannot really be satisfied.
> > > >
> > > > Signed-off-by: Stephane Eranian <eranian@google.com>
> > > > Reviewed-by: Ian Rogers <irogers@google.com>
> > > > ---
> > > >  tools/perf/util/evsel.c | 7 +++++++
> > > >  1 file changed, 7 insertions(+)
> > > >
> > > > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > > > index d23db6755f51..d1e8862b86ce 100644
> > > > --- a/tools/perf/util/evsel.c
> > > > +++ b/tools/perf/util/evsel.c
> > > > @@ -2446,6 +2446,13 @@ bool perf_evsel__fallback(struct evsel *evsel, int err,
> > > >               char *new_name;
> > > >               const char *sep = ":";
> > > >
> > > > +             if (evsel->core.attr.exclude_user) {
> > > > +                     scnprintf(msg, msgsize,
> > > > +"kernel.perf_event_paranoid=%d, event set to exclude user, so cannot also exclude kernel",
> > > > +                             paranoid);
> > > > +                     return false;
> > >
> > > I'm not able to get this error printed, it seems to be
> > > overwritten by perf_evsel__open_strerror call
> > >
> > > please include perf example with the new output
> >
> > Agreed, it is possible the change builtin-top/sched/record so that on
> > error the msg is checked and dumped in verbose mode. I think it is
> > also fine to just remove the scnprintf. Do you have a preference?
>
> not sure ;-) but let's make sure we don't remove some expected output
>
> jirka

I went the easier route as I don't think the new error message adds
anything over the perf_evsel__open_strerror message. v2 is here:
https://lore.kernel.org/lkml/20200414161550.225588-1-irogers@google.com/T/#u

Thanks,
Ian

> >
> > Thanks,
> > Ian
> >
> > > thanks,
> > > jirka
> > >
> > > > +             }
> > > > +
> > > >               /* Is there already the separator in the name. */
> > > >               if (strchr(name, '/') ||
> > > >                   strchr(name, ':'))
> > > > --
> > > > 2.26.0.110.g2183baf09c-goog
> > > >
> > >
> >
>
