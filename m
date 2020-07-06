Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8798AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 11:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61ABB20773
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 11:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KBs8sXqI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbgGFLzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 07:55:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41682 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728845AbgGFLzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 07:55:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594036515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eNCOjbm+kaBtEPxCgtMOBt6PbfRkCiU3/O11Ce9NgUA=;
        b=KBs8sXqIovcX84zmqeKdcEEo6HqTmYvBVRG/JLZqG43mJ5nctrU3oaqtBjsY3eU33JEEfA
        yet6gqGncEQMUSLJMZ+k8OKTQbruswJLImAqYMzrrHvRtCOau540J2AxEKXtl30pw275Ig
        GTgOEAO3rBKWJYaVu3yLPLJDAyfaqSw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-8wmitDwgPgO7xCv6fomz_Q-1; Mon, 06 Jul 2020 07:55:11 -0400
X-MC-Unique: 8wmitDwgPgO7xCv6fomz_Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2809107ACF6;
        Mon,  6 Jul 2020 11:55:09 +0000 (UTC)
Received: from sandy.ghostprotocols.net (unknown [10.3.128.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C7AA671662;
        Mon,  6 Jul 2020 11:55:08 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id AF4921E1; Mon,  6 Jul 2020 08:54:52 -0300 (BRT)
Date:   Mon, 6 Jul 2020 08:54:52 -0300
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] perf report TUI: Remove needless 'dummy' event from
 menu
Message-ID: <20200706115452.GA2772@redhat.com>
References: <20200703123431.GG1320@kernel.org>
 <CAM9d7cgGcpnX+cSY0UvYjRkG9PF8X3Yyf_AOy+nGxbPjtjDvxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cgGcpnX+cSY0UvYjRkG9PF8X3Yyf_AOy+nGxbPjtjDvxw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jul 03, 2020 at 10:44:28PM +0900, Namhyung Kim escreveu:
> Hi Arnaldo,
> 
> On Fri, Jul 3, 2020 at 9:34 PM Arnaldo Carvalho de Melo <acme@redhat.com> wrote:
> >
> > Please Ack,
> >
> > - Arnaldo
> >
> > ----
> >
> > Fixing the common case of:
> >
> >   perf record
> >   perf report
> >
> > And getting just the cycles events.
> >
> > We now have a 'dummy' event to get perf metadata events that take place
> > while we synthesize metadata records for pre-existing processes by
> > traversing procfs, so we always have this extra 'dummy' evsel, but we
> > don't have to offer it as there will be no samples on it, remove this
> > distraction.
> >
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/perf/ui/browsers/hists.c | 19 ++++++++++++++++++-
> >  1 file changed, 18 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
> > index 4cd556c1276f..be9c4c0549bc 100644
> > --- a/tools/perf/ui/browsers/hists.c
> > +++ b/tools/perf/ui/browsers/hists.c
> > @@ -3603,6 +3603,23 @@ static int __perf_evlist__tui_browse_hists(struct evlist *evlist,
> >                                     hbt, warn_lost_event);
> >  }
> >
> > +static bool perf_evlist__single_entry(struct evlist *evlist)
> > +{
> > +       int nr_entries = evlist->core.nr_entries;
> > +
> > +       if (nr_entries == 1)
> > +              return true;
> > +
> > +       if (nr_entries == 2) {
> > +               struct evsel *last = evlist__last(evlist);
> > +
> > +               if (evsel__is_dummy_event(last))
> > +                       return true;
> > +       }
> > +
> > +       return false;
> > +}
> > +
> >  int perf_evlist__tui_browse_hists(struct evlist *evlist, const char *help,
> >                                   struct hist_browser_timer *hbt,
> >                                   float min_pcnt,
> > @@ -3613,7 +3630,7 @@ int perf_evlist__tui_browse_hists(struct evlist *evlist, const char *help,
> >         int nr_entries = evlist->core.nr_entries;
> >
> >  single_entry:
> > -       if (nr_entries == 1) {
> > +       if (perf_evlist__single_entry(evlist)) {
> 
> But I think it cannot cover the event group case below..

Right, we can fix that later, I think, my worry at this point was that
the simplest case, which is:

   # perf record
   ^C
   # perf report

Would get that annoyance :-)

- Arnaldo
 
> Thanks
> Namhyung
> 
> 
> >                 struct evsel *first = evlist__first(evlist);
> >
> >                 return perf_evsel__hists_browse(first, nr_entries, help,
> > --
> > 2.21.3
> >

