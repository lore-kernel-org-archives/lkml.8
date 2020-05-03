Return-Path: <SRS0=5Fkd=6R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684DFC28CBC
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 17:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D008206B9
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 17:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BOA3sc/0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbgECRG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 13:06:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33523 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728992AbgECRG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 13:06:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588525585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oioYJOHMoLTTMlPRMjWe3kQ1lyBxtyf6zEkUg0F1cdM=;
        b=BOA3sc/0umDxoPA9wKkoXrvDDqSDt0q/0JQ+Wzq/KSGWMawAlhiJ0ks2zNvXzzhf0WmKjA
        yJEwmX8Mbdxwo9F7KoV7ndW9rnM2OOv9FLmVHV+8DHro0bA5bttjuXik2meHSlM4gABjyT
        c9mDb5mRKxZ8yz9/1PXUUtqdt011tJc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-0VSx_DckMV-3NG7mntal-w-1; Sun, 03 May 2020 13:06:21 -0400
X-MC-Unique: 0VSx_DckMV-3NG7mntal-w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB282800D24;
        Sun,  3 May 2020 17:06:17 +0000 (UTC)
Received: from krava (unknown [10.40.192.85])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E50E5D9D5;
        Sun,  3 May 2020 17:06:11 +0000 (UTC)
Date:   Sun, 3 May 2020 19:06:08 +0200
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
        Haiyan Song <haiyanx.song@intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Clarke <pc@us.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kajoljain <kjain@linux.ibm.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v4 12/12] perf test: improve pmu event metric testing
Message-ID: <20200503170608.GA1915271@krava>
References: <20200501173333.227162-1-irogers@google.com>
 <20200501173333.227162-13-irogers@google.com>
 <20200503145553.GA1865281@krava>
 <CAP-5=fXrwcz+MMF0Dqd_UnoXoTo1iO7T3-ENX0fzytPmJWmtoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fXrwcz+MMF0Dqd_UnoXoTo1iO7T3-ENX0fzytPmJWmtoA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 03, 2020 at 08:26:22AM -0700, Ian Rogers wrote:
> On Sun, May 3, 2020 at 7:56 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Fri, May 01, 2020 at 10:33:33AM -0700, Ian Rogers wrote:
> > > Add a basic floating point number test to expr.
> > > Break pmu-events test into 2 and add a test to verify that all pmu metric
> > > expressions simply parse. Try to parse all metric ids/events, failing if
> > > metrics for the current architecture fail to parse.
> > >
> > > Tested on skylakex with the patch set in place. May fail on other
> > > architectures if metrics are invalid.
> >
> > yep, failing for me (-vvv output below).. could you plz
> > detect that and skip the test ?
> 
> Thanks, filtering the verbose output we have just 1 parse event failure:
> 
> Parse event failed: id 'arb/event=0x80,umask=0x2,thresh=1/' metric
> 'DRAM_Parallel_Reads' expr 'arb@event\=0x80\,umask\=0x2@ /
> arb@event\=0x80\,umask\=0x2\,thresh\=1@'
> Error string 'unknown term 'thresh' for pmu 'uncore_arb'' help 'valid
> terms: event,edge,inv,umask,cmask,config,config1,config2,name,period,freq,branch_type,time,call-graph,stack-size,no-inherit,inherit,max-stack,nr,no-overwrite,overwrite,driver-config,percore,aux-output,aux-sample-size'
> 
> This looks like a bug in skl-metrics.json:
> 
>    {
>         "BriefDescription": "Average number of parallel data read
> requests to external memory. Accounts for demand loads and L1/L2
> prefetches",
>         "MetricExpr": "arb@event\\=0x80\\,umask\\=0x2@ /
> arb@event\\=0x80\\,umask\\=0x2\\,thresh\\=1@",
>         "MetricGroup": "Memory_BW",
>         "MetricName": "DRAM_Parallel_Reads"
>     },
> 
> which can be fixed by removing "\\,thresh\\=1" but looking at the
> expression this will just make the expression yield a value of 1. As
> this is an Intel json file could they comment? Jiri, could you be
> missing a patch on the kernel side? We could lower this failure to
> just a diagnostic message to land this set of patches, let me know
> what you'd like me to do.

I applied this on current Arnaldo's perf/core.. not sure there's
more pending changes out there

I'd like not to delay this patchset too long.. could we push the
first 10 patches and solve the rest in separate change?

thanks,
jirka

