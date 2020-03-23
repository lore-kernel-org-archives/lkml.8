Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064B4C4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 10:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDF9320784
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 10:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N4oeHIHd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbgCWK7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 06:59:15 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:43280 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727974AbgCWK7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 06:59:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584961153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8mKkMCxUz98E1nhjMRn0Wqmkvjw6DFydIpIMbYY2oNk=;
        b=N4oeHIHdndqWI5Nv8gj9zvr1RyHHNWY8gHY89yGO+rlTZSP2WVtMl0ois2yNFxZhXFeEfN
        5qQCMzJlOjHdd2VDUc0DQMjzwWMDz/A0dSFjGqs0RhRwy3mDc4vn0MnBY+OPNURddhi/IL
        CCgGt1eMGGVR5xFRn+nVWNQSuwRHTiY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-pVpfyIBBOl2cnWiuZjJVFw-1; Mon, 23 Mar 2020 06:59:09 -0400
X-MC-Unique: pVpfyIBBOl2cnWiuZjJVFw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C66E8100550D;
        Mon, 23 Mar 2020 10:59:07 +0000 (UTC)
Received: from krava (unknown [10.40.192.119])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E3885C1B5;
        Mon, 23 Mar 2020 10:59:04 +0000 (UTC)
Date:   Mon, 23 Mar 2020 11:59:02 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf parse-events: fix memory leaks found on parse_events
Message-ID: <20200323105902.GD1534489@krava>
References: <20200316041431.19607-1-irogers@google.com>
 <20200318104011.GF821557@krava>
 <CAP-5=fXQzLMuv-6EWGdFY1p5oLjV9301k1tkYL+R7qYHQR6wXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fXQzLMuv-6EWGdFY1p5oLjV9301k1tkYL+R7qYHQR6wXA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 08:56:26PM -0700, Ian Rogers wrote:
> On Wed, Mar 18, 2020 at 3:40 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Sun, Mar 15, 2020 at 09:14:31PM -0700, Ian Rogers wrote:
> > > Memory leaks found by applying LLVM's libfuzzer on the parse_events
> > > function.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/lib/perf/evlist.c        | 2 ++
> > >  tools/perf/util/parse-events.c | 2 ++
> > >  tools/perf/util/parse-events.y | 3 ++-
> > >  3 files changed, 6 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> > > index 5b9f2ca50591..6485d1438f75 100644
> > > --- a/tools/lib/perf/evlist.c
> > > +++ b/tools/lib/perf/evlist.c
> > > @@ -125,8 +125,10 @@ static void perf_evlist__purge(struct perf_evlist *evlist)
> > >  void perf_evlist__exit(struct perf_evlist *evlist)
> > >  {
> > >       perf_cpu_map__put(evlist->cpus);
> > > +     perf_cpu_map__put(evlist->all_cpus);
> >
> > ugh, yes, could you please put it to separate libperf patch?
> 
> Done. https://lkml.org/lkml/2020/3/18/1318
> 
> > >       perf_thread_map__put(evlist->threads);
> > >       evlist->cpus = NULL;
> > > +     evlist->all_cpus = NULL;
> >
> > there's already change adding this waiting on the list:
> >   https://lore.kernel.org/lkml/1583665157-349023-1-git-send-email-zhe.he@windriver.com/

Arnaldo, could you plz pull this one ^^^ ?

thanks,
jirka

