Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA436C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 07:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDBAD206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 07:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aJvBx3mF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgFAH2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 03:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgFAH2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 03:28:44 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD909C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 00:28:43 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id j8so5847559iog.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 00:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZID94TU6tFG7wYH7dZo83f1hFQXBxAzEx2wLz2hNO0o=;
        b=aJvBx3mFfg34i/Er639/8hxkWjPJg0RRiGa/6C9pjKmvHeSzbO+H1kgDFCsxI1mVbo
         HzUebTt+ktLtfVxjE0cewIYJV3UsSsjzQX5jSo14qMxgwYuqtm6FzsH9c7N81jEKxoXe
         BfFiNc0PTTcTIYBGtmnY3MGyHjbjdSOyEZmCViS0Y/5q1zN0L7CAC+bWdepz8NWaK0mI
         uwrtRr1PqkYMRtyqqVr95yrSeUl9H8aIBDApVzTNoyQjDKdWxxNApibFdJnpdVzvDmxM
         SQ19+qYrsALwaqe8NjJG5UI9JPh02vERofTHOIo30UoJgA3PcefgT/dChRXino3lnPYz
         q2BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZID94TU6tFG7wYH7dZo83f1hFQXBxAzEx2wLz2hNO0o=;
        b=luc2EDb0hfQzbPVWj+s9Q51nNAtX/gqoEGPM9bzBTUEFK5GHlJ9hJqdHs3f5nfnck7
         ICFs2RwAvvL/b9EWBXUU+0MVWq383UMdI9O2iOX6NS+fE9PPbs+k4zE+mHPz7rymAETd
         uCwZ2JxJbCgOle99neCf56jbIre+6TdVRN1J/htmPfjpYr674JCYW+Yx2p7mnpS6EVM1
         OByZVqPvAn6+6k0cEd5vEgHdiRM0du1L/o4gbX2LmpnfqbMqXPircWuaHVcvg78h+vYg
         4R/9CJQP4i6wTCp1sZHkkW9NmUf1TWuDjTf1aVFbZCTImkhAYkdzZuuwj3ZwXGSQCK3u
         NhVA==
X-Gm-Message-State: AOAM533abg6Swfxf3MQo6++3JSOPDkPgQoEf+H7/EsaqFjqUsCnKRpQz
        a3qJpSPEeBEwE75SwBr/Mq04I3TNwkZnA0MgaDzrlrJUS+w=
X-Google-Smtp-Source: ABdhPJx/e3Kw2NM5e61GO7r/Zo8mTjy2VnxQyDMp1m5YsvmnrNppj0Yo4J7E5QkE1XEm6HCL/hQO64OpzO/76itax9o=
X-Received: by 2002:a05:6638:35d:: with SMTP id x29mr8710754jap.71.1590996522880;
 Mon, 01 Jun 2020 00:28:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200524224219.234847-1-jolsa@kernel.org> <20200524224219.234847-6-jolsa@kernel.org>
In-Reply-To: <20200524224219.234847-6-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 1 Jun 2020 00:28:31 -0700
Message-ID: <CAP-5=fXaRv3rbjUYoTJUgc+GfnLku--O5LiHrM1W3ofaFz28rQ@mail.gmail.com>
Subject: Re: [PATCH 05/14] perf tools: Add parse_events_fake interface
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
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

On Sun, May 24, 2020 at 3:42 PM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding parse_events_fake interface to parse events
> and use fake pmu event in case pmu event is parsed.
>
> This way it's possible to parse events from PMUs
> which are not present in the system. It's available
> only for testing purposes coming in following
> changes.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Alternatively fake_pmu could be an argument to parse_events.

Thanks,
Ian

> ---
>  tools/perf/util/parse-events.c | 48 +++++++++++++++++++++++++---------
>  tools/perf/util/parse-events.h |  2 ++
>  2 files changed, 37 insertions(+), 13 deletions(-)
>
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 8304f9b6e6be..89239695a728 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -2082,22 +2082,15 @@ int parse_events_terms(struct list_head *terms, const char *str)
>         return ret;
>  }
>
> -int parse_events(struct evlist *evlist, const char *str,
> -                struct parse_events_error *err)
> +static int parse_events_state(struct parse_events_state *parse_state,
> +                             struct evlist *evlist, const char *str)
>  {
> -       struct parse_events_state parse_state = {
> -               .list   = LIST_HEAD_INIT(parse_state.list),
> -               .idx    = evlist->core.nr_entries,
> -               .error  = err,
> -               .evlist = evlist,
> -               .stoken = PE_START_EVENTS,
> -       };
>         int ret;
>
> -       ret = parse_events__scanner(str, &parse_state);
> +       ret = parse_events__scanner(str, parse_state);
>         perf_pmu__parse_cleanup();
>
> -       if (!ret && list_empty(&parse_state.list)) {
> +       if (!ret && list_empty(&parse_state->list)) {
>                 WARN_ONCE(true, "WARNING: event parser found nothing\n");
>                 return -1;
>         }
> @@ -2105,12 +2098,12 @@ int parse_events(struct evlist *evlist, const char *str,
>         /*
>          * Add list to the evlist even with errors to allow callers to clean up.
>          */
> -       perf_evlist__splice_list_tail(evlist, &parse_state.list);
> +       perf_evlist__splice_list_tail(evlist, &parse_state->list);
>
>         if (!ret) {
>                 struct evsel *last;
>
> -               evlist->nr_groups += parse_state.nr_groups;
> +               evlist->nr_groups += parse_state->nr_groups;
>                 last = evlist__last(evlist);
>                 last->cmdline_group_boundary = true;
>
> @@ -2125,6 +2118,35 @@ int parse_events(struct evlist *evlist, const char *str,
>         return ret;
>  }
>
> +int parse_events(struct evlist *evlist, const char *str,
> +                struct parse_events_error *err)
> +{
> +       struct parse_events_state parse_state = {
> +               .list   = LIST_HEAD_INIT(parse_state.list),
> +               .idx    = evlist->core.nr_entries,
> +               .error  = err,
> +               .evlist = evlist,
> +               .stoken = PE_START_EVENTS,
> +       };
> +
> +       return parse_events_state(&parse_state, evlist, str);
> +}
> +
> +int parse_events_fake(struct evlist *evlist, const char *str,
> +                     struct parse_events_error *err)
> +{
> +       struct parse_events_state parse_state = {
> +               .list     = LIST_HEAD_INIT(parse_state.list),
> +               .idx      = evlist->core.nr_entries,
> +               .error    = err,
> +               .evlist   = evlist,
> +               .stoken   = PE_START_EVENTS,
> +               .fake_pmu = true,
> +       };
> +
> +       return parse_events_state(&parse_state, evlist, str);
> +}
> +
>  #define MAX_WIDTH 1000
>  static int get_term_width(void)
>  {
> diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
> index 963b0ea6c448..4a23b6cd9924 100644
> --- a/tools/perf/util/parse-events.h
> +++ b/tools/perf/util/parse-events.h
> @@ -34,6 +34,8 @@ int parse_events_option(const struct option *opt, const char *str, int unset);
>  int parse_events_option_new_evlist(const struct option *opt, const char *str, int unset);
>  int parse_events(struct evlist *evlist, const char *str,
>                  struct parse_events_error *error);
> +int parse_events_fake(struct evlist *evlist, const char *str,
> +                     struct parse_events_error *error);
>  int parse_events_terms(struct list_head *terms, const char *str);
>  int parse_filter(const struct option *opt, const char *str, int unset);
>  int exclude_perf(const struct option *opt, const char *arg, int unset);
> --
> 2.25.4
>
