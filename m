Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B55AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AC8D206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c08DmiUL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgFAJJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 05:09:02 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23718 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725778AbgFAJJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 05:09:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591002540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X2AyyZvlSVEkYBXSE286PE3ct5ByfFHIgWPRXUK4tJ4=;
        b=c08DmiUL7EbZvWCxAyf0pMwCeDLEJVhotOKND0ktvytU2ZTok0AuyyUnngskVZ2ZAEsMOH
        spmi4hz2V4sPVM0ZMJu+qMP7bvTFL70JPUUh8wFcvL8ZcZjDVBS6jlgTlqNB/g97J15E+/
        DCrRxHEeyRzp1vrrWX/9zwqXw1gIzp8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-v0zoE9QcPK23ZzgCUKqT9g-1; Mon, 01 Jun 2020 05:08:55 -0400
X-MC-Unique: v0zoE9QcPK23ZzgCUKqT9g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 292C98014D4;
        Mon,  1 Jun 2020 09:08:54 +0000 (UTC)
Received: from krava (unknown [10.40.192.36])
        by smtp.corp.redhat.com (Postfix) with SMTP id 78C147A8B5;
        Mon,  1 Jun 2020 09:08:51 +0000 (UTC)
Date:   Mon, 1 Jun 2020 11:08:50 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 05/14] perf tools: Add parse_events_fake interface
Message-ID: <20200601090850.GI881900@krava>
References: <20200524224219.234847-1-jolsa@kernel.org>
 <20200524224219.234847-6-jolsa@kernel.org>
 <CAP-5=fXaRv3rbjUYoTJUgc+GfnLku--O5LiHrM1W3ofaFz28rQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fXaRv3rbjUYoTJUgc+GfnLku--O5LiHrM1W3ofaFz28rQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 01, 2020 at 12:28:31AM -0700, Ian Rogers wrote:
> On Sun, May 24, 2020 at 3:42 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding parse_events_fake interface to parse events
> > and use fake pmu event in case pmu event is parsed.
> >
> > This way it's possible to parse events from PMUs
> > which are not present in the system. It's available
> > only for testing purposes coming in following
> > changes.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> Acked-by: Ian Rogers <irogers@google.com>
> 
> Alternatively fake_pmu could be an argument to parse_events.

yea I checked that and I was surprised how many parse_events calls
we have in perf, so I went this way.. but I haven't really tried it,
so it might look actually etter despite the many places we need to change,
I'll try

thanks,
jirka

> 
> Thanks,
> Ian
> 
> > ---
> >  tools/perf/util/parse-events.c | 48 +++++++++++++++++++++++++---------
> >  tools/perf/util/parse-events.h |  2 ++
> >  2 files changed, 37 insertions(+), 13 deletions(-)
> >
> > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> > index 8304f9b6e6be..89239695a728 100644
> > --- a/tools/perf/util/parse-events.c
> > +++ b/tools/perf/util/parse-events.c
> > @@ -2082,22 +2082,15 @@ int parse_events_terms(struct list_head *terms, const char *str)
> >         return ret;
> >  }
> >
> > -int parse_events(struct evlist *evlist, const char *str,
> > -                struct parse_events_error *err)
> > +static int parse_events_state(struct parse_events_state *parse_state,
> > +                             struct evlist *evlist, const char *str)
> >  {
> > -       struct parse_events_state parse_state = {
> > -               .list   = LIST_HEAD_INIT(parse_state.list),
> > -               .idx    = evlist->core.nr_entries,
> > -               .error  = err,
> > -               .evlist = evlist,
> > -               .stoken = PE_START_EVENTS,
> > -       };
> >         int ret;
> >
> > -       ret = parse_events__scanner(str, &parse_state);
> > +       ret = parse_events__scanner(str, parse_state);
> >         perf_pmu__parse_cleanup();
> >
> > -       if (!ret && list_empty(&parse_state.list)) {
> > +       if (!ret && list_empty(&parse_state->list)) {
> >                 WARN_ONCE(true, "WARNING: event parser found nothing\n");
> >                 return -1;
> >         }
> > @@ -2105,12 +2098,12 @@ int parse_events(struct evlist *evlist, const char *str,
> >         /*
> >          * Add list to the evlist even with errors to allow callers to clean up.
> >          */
> > -       perf_evlist__splice_list_tail(evlist, &parse_state.list);
> > +       perf_evlist__splice_list_tail(evlist, &parse_state->list);
> >
> >         if (!ret) {
> >                 struct evsel *last;
> >
> > -               evlist->nr_groups += parse_state.nr_groups;
> > +               evlist->nr_groups += parse_state->nr_groups;
> >                 last = evlist__last(evlist);
> >                 last->cmdline_group_boundary = true;
> >
> > @@ -2125,6 +2118,35 @@ int parse_events(struct evlist *evlist, const char *str,
> >         return ret;
> >  }
> >
> > +int parse_events(struct evlist *evlist, const char *str,
> > +                struct parse_events_error *err)
> > +{
> > +       struct parse_events_state parse_state = {
> > +               .list   = LIST_HEAD_INIT(parse_state.list),
> > +               .idx    = evlist->core.nr_entries,
> > +               .error  = err,
> > +               .evlist = evlist,
> > +               .stoken = PE_START_EVENTS,
> > +       };
> > +
> > +       return parse_events_state(&parse_state, evlist, str);
> > +}
> > +
> > +int parse_events_fake(struct evlist *evlist, const char *str,
> > +                     struct parse_events_error *err)
> > +{
> > +       struct parse_events_state parse_state = {
> > +               .list     = LIST_HEAD_INIT(parse_state.list),
> > +               .idx      = evlist->core.nr_entries,
> > +               .error    = err,
> > +               .evlist   = evlist,
> > +               .stoken   = PE_START_EVENTS,
> > +               .fake_pmu = true,
> > +       };
> > +
> > +       return parse_events_state(&parse_state, evlist, str);
> > +}
> > +
> >  #define MAX_WIDTH 1000
> >  static int get_term_width(void)
> >  {
> > diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
> > index 963b0ea6c448..4a23b6cd9924 100644
> > --- a/tools/perf/util/parse-events.h
> > +++ b/tools/perf/util/parse-events.h
> > @@ -34,6 +34,8 @@ int parse_events_option(const struct option *opt, const char *str, int unset);
> >  int parse_events_option_new_evlist(const struct option *opt, const char *str, int unset);
> >  int parse_events(struct evlist *evlist, const char *str,
> >                  struct parse_events_error *error);
> > +int parse_events_fake(struct evlist *evlist, const char *str,
> > +                     struct parse_events_error *error);
> >  int parse_events_terms(struct list_head *terms, const char *str);
> >  int parse_filter(const struct option *opt, const char *str, int unset);
> >  int exclude_perf(const struct option *opt, const char *arg, int unset);
> > --
> > 2.25.4
> >
> 

