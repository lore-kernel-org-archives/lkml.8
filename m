Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 794C1C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5614F2076D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e9gZ1tOg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437657AbgDNPN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 11:13:59 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28065 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2437531AbgDNPM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 11:12:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586877177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hWdxsxQ1IMDhmXo5WAMFE5k2BVlneem3CQpGkc+AuvY=;
        b=e9gZ1tOgRcN8dlqXtCfqShtwpKxYMsetLehLda7a/WijSKrwDW8yyinYnuWuY7izkjUeqH
        Y1BGVDA23Kv8UShrnZna0py4l4giGH0oDktWkJrFSWLctZ3mHqkynMjR+N3EjGGfcsDzWO
        7Vumdy9ppPK3Axc539uVPCcsjaW7NpI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-3BpvUORRMJS8qDbO7QY6GQ-1; Tue, 14 Apr 2020 11:12:53 -0400
X-MC-Unique: 3BpvUORRMJS8qDbO7QY6GQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D58D41137840;
        Tue, 14 Apr 2020 15:12:51 +0000 (UTC)
Received: from krava (unknown [10.40.195.121])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BE27C5C1BE;
        Tue, 14 Apr 2020 15:12:49 +0000 (UTC)
Date:   Tue, 14 Apr 2020 17:12:47 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf stat: force error in fallback on :k events
Message-ID: <20200414151247.GB208694@krava>
References: <20200413235515.221467-1-irogers@google.com>
 <20200414130209.GD117177@krava>
 <CAP-5=fVM6gg3Bo5jHwYG=vhLZ-HQaQfwZFg_=DwRJOmHqRRDMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fVM6gg3Bo5jHwYG=vhLZ-HQaQfwZFg_=DwRJOmHqRRDMA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 07:38:17AM -0700, Ian Rogers wrote:
> On Tue, Apr 14, 2020 at 6:02 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Mon, Apr 13, 2020 at 04:55:15PM -0700, Ian Rogers wrote:
> > > From: Stephane Eranian <eranian@google.com>
> > >
> > > When it is not possible for a non-privilege perf command
> > > to monitor at the kernel level (:k), the fallback code forces
> > > a :u. That works if the event was previously monitoring both levels.
> > > But if the event was already constrained to kernel only, then it does
> > > not make sense to restrict it to user only.
> > > Given the code works by exclusion, a kernel only event would have:
> > > attr->exclude_user = 1
> > > The fallback code would add:
> > > attr->exclude_kernel = 1;
> > >
> > > In the end the end would not monitor in either the user level or kernel
> > > level. In other words, it would count nothing.
> > >
> > > An event programmed to monitor kernel only cannot be switched to user only
> > > without seriously warning the user.
> > >
> > > This patch forces an error in this case to make it clear the request
> > > cannot really be satisfied.
> > >
> > > Signed-off-by: Stephane Eranian <eranian@google.com>
> > > Reviewed-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/util/evsel.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > > index d23db6755f51..d1e8862b86ce 100644
> > > --- a/tools/perf/util/evsel.c
> > > +++ b/tools/perf/util/evsel.c
> > > @@ -2446,6 +2446,13 @@ bool perf_evsel__fallback(struct evsel *evsel, int err,
> > >               char *new_name;
> > >               const char *sep = ":";
> > >
> > > +             if (evsel->core.attr.exclude_user) {
> > > +                     scnprintf(msg, msgsize,
> > > +"kernel.perf_event_paranoid=%d, event set to exclude user, so cannot also exclude kernel",
> > > +                             paranoid);
> > > +                     return false;
> >
> > I'm not able to get this error printed, it seems to be
> > overwritten by perf_evsel__open_strerror call
> >
> > please include perf example with the new output
> 
> Agreed, it is possible the change builtin-top/sched/record so that on
> error the msg is checked and dumped in verbose mode. I think it is
> also fine to just remove the scnprintf. Do you have a preference?

not sure ;-) but let's make sure we don't remove some expected output

jirka

> 
> Thanks,
> Ian
> 
> > thanks,
> > jirka
> >
> > > +             }
> > > +
> > >               /* Is there already the separator in the name. */
> > >               if (strchr(name, '/') ||
> > >                   strchr(name, ':'))
> > > --
> > > 2.26.0.110.g2183baf09c-goog
> > >
> >
> 

