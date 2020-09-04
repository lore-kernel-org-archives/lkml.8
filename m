Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A1DC433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27C762074D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbgIDPxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:53:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59767 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726063AbgIDPxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:53:04 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-phUf1-h1O-qRNfE9OnVoiA-1; Fri, 04 Sep 2020 11:53:02 -0400
X-MC-Unique: phUf1-h1O-qRNfE9OnVoiA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F280F640C6;
        Fri,  4 Sep 2020 15:52:58 +0000 (UTC)
Received: from krava (ovpn-112-34.ams2.redhat.com [10.36.112.34])
        by smtp.corp.redhat.com (Postfix) with SMTP id 247A75DA81;
        Fri,  4 Sep 2020 15:52:52 +0000 (UTC)
Date:   Fri, 4 Sep 2020 17:52:51 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Kemeng Shi <shikemeng@huawei.com>,
        James Clark <james.clark@arm.com>,
        Wei Li <liwei391@huawei.com>, Al Grant <Al.Grant@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/14] perf mem: Introduce weak function
 perf_mem_events__ptr()
Message-ID: <20200904155251.GC939481@krava>
References: <20200901083815.13755-1-leo.yan@linaro.org>
 <20200901083815.13755-3-leo.yan@linaro.org>
 <20200903135054.GD713364@krava>
 <20200904003447.GB5979@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904003447.GB5979@leoy-ThinkPad-X240s>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 04, 2020 at 08:34:47AM +0800, Leo Yan wrote:
> Hi Jiri,
> 
> On Thu, Sep 03, 2020 at 03:50:54PM +0200, Jiri Olsa wrote:
> > On Tue, Sep 01, 2020 at 09:38:03AM +0100, Leo Yan wrote:
> > 
> > SNIP
> > 
> > > @@ -2941,30 +2942,38 @@ static int perf_c2c__record(int argc, const char **argv)
> > >  	rec_argv[i++] = "record";
> > >  
> > >  	if (!event_set) {
> > > -		perf_mem_events[PERF_MEM_EVENTS__LOAD].record  = true;
> > > -		perf_mem_events[PERF_MEM_EVENTS__STORE].record = true;
> > > +		e = perf_mem_events__ptr(PERF_MEM_EVENTS__LOAD);
> > > +		e->record = true;
> > > +
> > > +		e = perf_mem_events__ptr(PERF_MEM_EVENTS__STORE);
> > > +		e->record = true;
> > >  	}
> > >  
> > > -	if (perf_mem_events[PERF_MEM_EVENTS__LOAD].record)
> > > +	e = perf_mem_events__ptr(PERF_MEM_EVENTS__LOAD);
> > > +	if (e->record)
> > >  		rec_argv[i++] = "-W";
> > >  
> > >  	rec_argv[i++] = "-d";
> > >  	rec_argv[i++] = "--phys-data";
> > >  	rec_argv[i++] = "--sample-cpu";
> > >  
> > > -	for (j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
> > > -		if (!perf_mem_events[j].record)
> > > +	j = 0;
> > > +	while ((e = perf_mem_events__ptr(j)) != NULL) {
> > > +		if (!e->record) {
> > 
> > you could keep the above 'for loop' in here, it seems better
> > than taking care of j++
> 
> Actually in patch v1 I did this way :)  I followed James' suggestion to
> encapsulate PERF_MEM_EVENTS__MAX into perf_mem_events__ptr(), thus
> builtin-mem.c and buildin-c2c.c are not necessary to use
> PERF_MEM_EVENTS__MAX in the loop and only needs to detect if the
> pointer is NULL or not when return from perf_mem_events__ptr().

ah because u added that load_store event

> 
> How about change as below?
> 
>         for (j = 0; (e = perf_mem_events__ptr(j)) != NULL; j++) {
>                 [...]

will this work? e will be NULL for first iteration no?

there are still other for loops with PERF_MEM_EVENTS__MAX used
in the patch.. you overload the perf_mem_events access for arm,
and add missing load_store NULL item to generic version, so there's
always PERF_MEM_EVENTS__MAX items in the array

can we just use the current for loop and check for e->tag != NULL
or any other field

thanks,
jirka

