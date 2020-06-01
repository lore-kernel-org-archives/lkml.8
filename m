Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22820C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 15:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC207207FB
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 15:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591023873;
	bh=IpTx7nnx1mp8ehJgM+gN6VFNSO8KbEMfp595a0amc9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TNL6XizyoOwZbPYUs9eTonalvwN2BoMvD3Es21HU6inMXsD4to64uHLN/L9t8ZUFl
	 gs5dwOR5rIlR8NjLUcb8fg9p6mYaheJxiXX6kJ9g0esFZgq9FUC1onEEusQe2nhII6
	 H5MSalGOnQgieSnlTQqw+Pcq2dW9okpiqraPe11E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgFAPEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 11:04:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:33656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgFAPEb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 11:04:31 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A92C12065C;
        Mon,  1 Jun 2020 15:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591023871;
        bh=IpTx7nnx1mp8ehJgM+gN6VFNSO8KbEMfp595a0amc9Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2ABpnLOJqaEkBP846oPPEM0vc3pFwA/t8MlhH1EBDukU9BRl5JHZFfLJpRRw7kLxo
         QCIbvot+MtNS7Cgq5FXHAmhek6fqMw54Cgw74diTR7n160io8+55k5yHTgNeQv/kT/
         JBXupq3LNSiF8crTY56wYgvrOHy1IjMJnab1QvaA=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D533940AFD; Mon,  1 Jun 2020 12:04:28 -0300 (-03)
Date:   Mon, 1 Jun 2020 12:04:28 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 05/14] perf tools: Add parse_events_fake interface
Message-ID: <20200601150428.GJ31795@kernel.org>
References: <20200524224219.234847-1-jolsa@kernel.org>
 <20200524224219.234847-6-jolsa@kernel.org>
 <CAP-5=fXaRv3rbjUYoTJUgc+GfnLku--O5LiHrM1W3ofaFz28rQ@mail.gmail.com>
 <20200601090850.GI881900@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200601090850.GI881900@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jun 01, 2020 at 11:08:50AM +0200, Jiri Olsa escreveu:
> On Mon, Jun 01, 2020 at 12:28:31AM -0700, Ian Rogers wrote:
> > On Sun, May 24, 2020 at 3:42 PM Jiri Olsa <jolsa@kernel.org> wrote:
> > >
> > > Adding parse_events_fake interface to parse events
> > > and use fake pmu event in case pmu event is parsed.
> > >
> > > This way it's possible to parse events from PMUs
> > > which are not present in the system. It's available
> > > only for testing purposes coming in following
> > > changes.
> > >
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > 
> > Acked-by: Ian Rogers <irogers@google.com>
> > 
> > Alternatively fake_pmu could be an argument to parse_events.
> 
> yea I checked that and I was surprised how many parse_events calls
> we have in perf, so I went this way.. but I haven't really tried it,
> so it might look actually etter despite the many places we need to change,
> I'll try

Thanks! My admitedly unchecked thinking is that most places will just
pass NULL, only the test case will pass it, right?

- Arnaldo
 
> thanks,
> jirka
> 
> > 
> > Thanks,
> > Ian
> > 
> > > ---
> > >  tools/perf/util/parse-events.c | 48 +++++++++++++++++++++++++---------
> > >  tools/perf/util/parse-events.h |  2 ++
> > >  2 files changed, 37 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> > > index 8304f9b6e6be..89239695a728 100644
> > > --- a/tools/perf/util/parse-events.c
> > > +++ b/tools/perf/util/parse-events.c
> > > @@ -2082,22 +2082,15 @@ int parse_events_terms(struct list_head *terms, const char *str)
> > >         return ret;
> > >  }
> > >
> > > -int parse_events(struct evlist *evlist, const char *str,
> > > -                struct parse_events_error *err)
> > > +static int parse_events_state(struct parse_events_state *parse_state,
> > > +                             struct evlist *evlist, const char *str)
> > >  {
> > > -       struct parse_events_state parse_state = {
> > > -               .list   = LIST_HEAD_INIT(parse_state.list),
> > > -               .idx    = evlist->core.nr_entries,
> > > -               .error  = err,
> > > -               .evlist = evlist,
> > > -               .stoken = PE_START_EVENTS,
> > > -       };
> > >         int ret;
> > >
> > > -       ret = parse_events__scanner(str, &parse_state);
> > > +       ret = parse_events__scanner(str, parse_state);
> > >         perf_pmu__parse_cleanup();
> > >
> > > -       if (!ret && list_empty(&parse_state.list)) {
> > > +       if (!ret && list_empty(&parse_state->list)) {
> > >                 WARN_ONCE(true, "WARNING: event parser found nothing\n");
> > >                 return -1;
> > >         }
> > > @@ -2105,12 +2098,12 @@ int parse_events(struct evlist *evlist, const char *str,
> > >         /*
> > >          * Add list to the evlist even with errors to allow callers to clean up.
> > >          */
> > > -       perf_evlist__splice_list_tail(evlist, &parse_state.list);
> > > +       perf_evlist__splice_list_tail(evlist, &parse_state->list);
> > >
> > >         if (!ret) {
> > >                 struct evsel *last;
> > >
> > > -               evlist->nr_groups += parse_state.nr_groups;
> > > +               evlist->nr_groups += parse_state->nr_groups;
> > >                 last = evlist__last(evlist);
> > >                 last->cmdline_group_boundary = true;
> > >
> > > @@ -2125,6 +2118,35 @@ int parse_events(struct evlist *evlist, const char *str,
> > >         return ret;
> > >  }
> > >
> > > +int parse_events(struct evlist *evlist, const char *str,
> > > +                struct parse_events_error *err)
> > > +{
> > > +       struct parse_events_state parse_state = {
> > > +               .list   = LIST_HEAD_INIT(parse_state.list),
> > > +               .idx    = evlist->core.nr_entries,
> > > +               .error  = err,
> > > +               .evlist = evlist,
> > > +               .stoken = PE_START_EVENTS,
> > > +       };
> > > +
> > > +       return parse_events_state(&parse_state, evlist, str);
> > > +}
> > > +
> > > +int parse_events_fake(struct evlist *evlist, const char *str,
> > > +                     struct parse_events_error *err)
> > > +{
> > > +       struct parse_events_state parse_state = {
> > > +               .list     = LIST_HEAD_INIT(parse_state.list),
> > > +               .idx      = evlist->core.nr_entries,
> > > +               .error    = err,
> > > +               .evlist   = evlist,
> > > +               .stoken   = PE_START_EVENTS,
> > > +               .fake_pmu = true,
> > > +       };
> > > +
> > > +       return parse_events_state(&parse_state, evlist, str);
> > > +}
> > > +
> > >  #define MAX_WIDTH 1000
> > >  static int get_term_width(void)
> > >  {
> > > diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
> > > index 963b0ea6c448..4a23b6cd9924 100644
> > > --- a/tools/perf/util/parse-events.h
> > > +++ b/tools/perf/util/parse-events.h
> > > @@ -34,6 +34,8 @@ int parse_events_option(const struct option *opt, const char *str, int unset);
> > >  int parse_events_option_new_evlist(const struct option *opt, const char *str, int unset);
> > >  int parse_events(struct evlist *evlist, const char *str,
> > >                  struct parse_events_error *error);
> > > +int parse_events_fake(struct evlist *evlist, const char *str,
> > > +                     struct parse_events_error *error);
> > >  int parse_events_terms(struct list_head *terms, const char *str);
> > >  int parse_filter(const struct option *opt, const char *str, int unset);
> > >  int exclude_perf(const struct option *opt, const char *arg, int unset);
> > > --
> > > 2.25.4
> > >
> > 
> 

-- 

- Arnaldo
