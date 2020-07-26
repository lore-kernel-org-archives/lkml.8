Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B845C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 07:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57B9420715
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 07:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eCjgtJ8A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgGZHrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 03:47:51 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38615 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725789AbgGZHrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 03:47:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595749670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qlfvn5Nkzs/xgydDaV2BwGMzu9w0jWBrrqGBm93HJbs=;
        b=eCjgtJ8AVjBvc2K+ZeFKTjGCKoIcjbMS3Zpx3l9laahpn2gdcDJBs1vCmv6q1ZJVloV004
        ygWs11GrYJK0z9LzbMQ6tluRz9TqU1vzQKanHHvwsE5da/UkmzTsYDkiFblxnWCebpxbX0
        pZGsuKDYkSHsFm54wVxiARWoe+eE/X4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-pX0ffD0OP7a3O4HIXceqVg-1; Sun, 26 Jul 2020 03:47:46 -0400
X-MC-Unique: pX0ffD0OP7a3O4HIXceqVg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB09E59;
        Sun, 26 Jul 2020 07:47:43 +0000 (UTC)
Received: from krava (unknown [10.40.192.47])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5ABBA89516;
        Sun, 26 Jul 2020 07:47:39 +0000 (UTC)
Date:   Sun, 26 Jul 2020 09:47:37 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: Re: [PATCH 2/2] perf tools: Fix term parsing for raw syntax
Message-ID: <20200726074737.GB1175442@krava>
References: <20200725121959.1181869-1-jolsa@kernel.org>
 <20200725121959.1181869-2-jolsa@kernel.org>
 <CAP-5=fUmJSZfCrP=gdYOwd2gpAgXsiSTBDwtLp=_e7a434weTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fUmJSZfCrP=gdYOwd2gpAgXsiSTBDwtLp=_e7a434weTA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 25, 2020 at 09:58:13AM -0700, Ian Rogers wrote:

SNIP

> >         ret = parse_events_terms(&terms, t->str);
> >         if (ret) {
> >                 pr_debug("failed to parse terms '%s', err %d\n",
> > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> > index e88e4c7a2a9a..254f02a7fb0d 100644
> > --- a/tools/perf/util/parse-events.c
> > +++ b/tools/perf/util/parse-events.c
> > @@ -2019,6 +2019,27 @@ static void perf_pmu__parse_init(void)
> >         perf_pmu__parse_cleanup();
> >  }
> >
> > +int perf_pmu__test_parse_init(void)
> > +{
> > +       struct perf_pmu_event_symbol *list;
> > +
> > +       list = malloc(sizeof(*list) * 1);
> > +       if (!list)
> > +               return -ENOMEM;
> > +
> > +       list->type   = PMU_EVENT_SYMBOL;
> > +       list->symbol = strdup("read");
> > +
> > +       if (!list->symbol) {
> > +               free(list);
> > +               return -ENOMEM;
> > +       }
> > +
> > +       perf_pmu_events_list = list;
> > +       perf_pmu_events_list_num = 1;
> > +       return 0;
> > +}
> 
> nit: It's easy to see in the test code why this is necessary, could
> the function be moved there? If not perhaps add a function comment?
> The test in the function name is quite load bearing.

both perf_pmu_events_list/cnt are static and I'd like to keep it that
way, so the function needs to be in here.. I'll add comment explaining
this

jirka

