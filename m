Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417DCC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F9DE20836
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IWH6xgff"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbgEKVJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 17:09:23 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48048 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725888AbgEKVJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 17:09:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589231361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NzxwDFhFnKquU9wvdTnO5T31dALjfyUDr2p+5t8c/2c=;
        b=IWH6xgffxRCXUC9mIsLZSRAGSrFLSKywKvAhAd9szjpxbm0f72FdrOuVq+cxN6z8QZklQX
        BNP08KUaigb+EHLfkhc2TN6QZa/+J+GKb1u5rDJrnyxo+TP/OmuJRELYF8FQlJAdmExZ9R
        jVs0uNrLnlKOjiEMOneA5dSW+C9UZfY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-eettOW_FO4SjGIdos7NmJw-1; Mon, 11 May 2020 17:09:19 -0400
X-MC-Unique: eettOW_FO4SjGIdos7NmJw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C41757A561;
        Mon, 11 May 2020 21:08:47 +0000 (UTC)
Received: from krava (unknown [10.40.194.31])
        by smtp.corp.redhat.com (Postfix) with SMTP id C2EAE7D8CF;
        Mon, 11 May 2020 21:08:44 +0000 (UTC)
Date:   Mon, 11 May 2020 23:08:43 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
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
Subject: Re: [PATCH v3] perf c2c: fix '-e list'
Message-ID: <20200511210843.GG2986380@krava>
References: <20200507220604.3391-1-irogers@google.com>
 <20200511193604.GF2986380@krava>
 <CAP-5=fWQ_bx0g3dGDQcmW7MhUAadA0rwahGPvGFTfGo6qoeLww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWQ_bx0g3dGDQcmW7MhUAadA0rwahGPvGFTfGo6qoeLww@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 01:29:42PM -0700, Ian Rogers wrote:

SNIP

> > > diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> > > index 1baf4cae086f..d617d5682c68 100644
> > > --- a/tools/perf/builtin-c2c.c
> > > +++ b/tools/perf/builtin-c2c.c
> > > @@ -2887,8 +2887,15 @@ static int parse_record_events(const struct option *opt,
> > >  {
> > >       bool *event_set = (bool *) opt->value;
> > >
> > > +     if (!strcmp(str, "list")) {
> > > +             perf_mem_events__list();
> > > +             exit(0);
> > > +     }
> > > +     if (perf_mem_events__parse(str))
> > > +             exit(-1);
> >
> > won't this exit(-1) callsbreak the parsing stuff?
> > like displaying the option values on error or such?
> 
> The previous code was:
> -       if (strcmp(str, "list")) {
> This is handled explicitly in the code above this.
> 
> -               if (!perf_mem_events__parse(str)) {
> -                       mem->operation = 0;
> -                       return 0;
> -               }
> -               exit(-1);
> This is the code where the exit -1 happens, I inverted the comparison
> so that exit was more the exceptional code path. The behavior should
> be identical.

ok

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

