Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AD7C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 13:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7829A20639
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 13:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cWor6SLf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbgHLNGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 09:06:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51898 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728028AbgHLNF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 09:05:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597237525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+ksdIEzAumaIrjq79KXqgfvDcQg8WBIlI9c7pSMGN7s=;
        b=cWor6SLfOdhniR9cPcxrd61s6V1szTejkXcAqbM648cxXHlgXR19lg6qzONvqxvGUIwPL/
        VKpoA2KImVnyFatHS8s8XDtGcxGvP3Q00VGNYjb17Xhae/hM0gBwz6ioFVkHLpAD+WleEU
        Q794966KhF6cWD/HIrDv50bFVGZjILM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-hr9UxgMkPhyi_FTkxI23Bg-1; Wed, 12 Aug 2020 09:05:23 -0400
X-MC-Unique: hr9UxgMkPhyi_FTkxI23Bg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6FA1610199A7;
        Wed, 12 Aug 2020 13:05:21 +0000 (UTC)
Received: from krava.homenet.telecomitalia.it (unknown [10.40.192.161])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2BDF919D7C;
        Wed, 12 Aug 2020 13:05:18 +0000 (UTC)
Date:   Wed, 12 Aug 2020 15:05:17 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Rob Herring <robh@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [RFC] libperf: Add support for user space counter access
Message-ID: <20200812130517.GB4872@krava.homenet.telecomitalia.it>
References: <20200807230517.57114-1-robh@kernel.org>
 <20200808102208.GA619980@krava>
 <CAL_Jsq+gfqyqCx3Yuc6TsbXjYSLfJQhhPUnwRVjpJgwL24v1Qg@mail.gmail.com>
 <20200811105027.GD699846@krava>
 <CAL_Jsq+tsTrYCddSSb5d2vC7TTKUZTgjBQr4FHXBKCePo-beZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+tsTrYCddSSb5d2vC7TTKUZTgjBQr4FHXBKCePo-beZQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 10:49:30AM -0600, Rob Herring wrote:
> On Tue, Aug 11, 2020 at 4:50 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Mon, Aug 10, 2020 at 12:11:23PM -0600, Rob Herring wrote:
> > > On Sat, Aug 8, 2020 at 4:22 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > > >
> > > > On Fri, Aug 07, 2020 at 05:05:17PM -0600, Rob Herring wrote:
> > > > > x86 and arm64 can both support direct access of event counters in
> > > > > userspace. The access sequence is less than trivial and currently exists
> > > > > in perf test code (tools/perf/arch/x86/tests/rdpmc.c) with copies in
> > > > > projects such as PAPI and libpfm4.
> > > > >
> > > > > Patches to add arm64 userspace support are pending[1].
> > > > >
> > > > > For this RFC, looking for a yes, seems like a good idea, or no, go away we
> > > > > don't want this in libperf.
> > > >
> > > > hi,
> > > > looks great!
> > > >
> > > > I wanted to add this for very long time.. so yes, we want this ;-)
> > >
> > > Thanks for the quick feedback. Would this be better implemented as a
> > > fast path for perf_evsel__read()? If so, how to get the mmap data
> >
> > if it works for all events, which I'm not sure of
> >
> > > which is associated with a evlist rather than a evsel?
> >
> > not sure what you mean, you can mmap evsel, not evlist
> 
> While yes the mmap is created from an evsel fd, they are ultimately
> associated with the evlist struct and are per thread or cpu. If
> there's more than 1 evsel, then the additional ones are set to the 1st
> mmap with PERF_EVENT_IOC_SET_OUTPUT. Which I now realize means this
> RFC only works for the first evsel. So I guess the API needs to work
> something like this:
> 
> threads = perf_thread_map__new_dummy();
> perf_thread_map__set_pid(threads, 0, 0);
> 
> evsel = perf_evsel__new(&attr);
> perf_evsel__open(evsel, NULL, threads);
> 

hum, I wonder we should remove maps from perf_evsel__open
args and factor out some perf_evsel__set_map function..

> perf_evsel__mmap(evsel);    <--- *new*

.. because you'll need those maps in here, right?

> 
> perf_evsel__read(evsel, 0, 0, &counts);  // If we have an mmap, then
> try a direct read
> 
> 
> Perhaps some refactoring of the mmap code in evlist.c will be needed,
> but the usage seems pretty orthogonal. I'd propose that mmapping via
> perf_evlist__mmap() behavior remain unchanged and direct access is not
> supported in that case.

seems ok to me, perf_evlist__mmap and perf_evsel__mmap would
mean to mutually exclusive usages

thanks,
jirka

