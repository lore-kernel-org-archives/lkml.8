Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4610FC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 11:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4CD32166E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 11:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PR7a2SAa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbgIGLf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 07:35:56 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28491 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729078AbgIGLff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 07:35:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599478515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Bnd7OAaPMlBuHCu6MaFkDr3bmnu/d7VAmZEybBtgTF0=;
        b=PR7a2SAas8EOhTW0yFLvNbuWf89/CvaCe1XvVwxfQX8jcjBkMUaiigFRNlU53yTt+sOFqC
        lb0ZLd7JZcpsdWZzxab4B1ZMvLUZ1seVbnqPP/NJ8Ukg8S0/rRDnu90z7/yvK6sZL/pq4v
        RbG7+koNqP0tegq889eh0/DDMIHQK/0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-yfczK89bPhS-eZGFhA7WPw-1; Mon, 07 Sep 2020 07:35:13 -0400
X-MC-Unique: yfczK89bPhS-eZGFhA7WPw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD3511074661;
        Mon,  7 Sep 2020 11:35:11 +0000 (UTC)
Received: from krava (ovpn-112-180.ams2.redhat.com [10.36.112.180])
        by smtp.corp.redhat.com (Postfix) with SMTP id 16ECE60C0F;
        Mon,  7 Sep 2020 11:35:08 +0000 (UTC)
Date:   Mon, 7 Sep 2020 13:35:08 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <andi@firstfloor.org>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCHSET 0/9] perf tools: Fix various memory leaks
Message-ID: <20200907113508.GL1199773@krava>
References: <20200907034502.753230-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907034502.753230-1-namhyung@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 12:44:53PM +0900, Namhyung Kim wrote:
> Hello,
> 
> I've found and fixed a bunch of memory leaks during perf pmu and
> metric tests with address sanitizer.  Before this, the tests were
> mostly failed due to the leaks since ASAN makes it return non-zero.
> 
> Now I'm seeing no error with ASAN like below:
> 
>   $ ./perf test pmu metric
>    9: Parse perf pmu format                                 : Ok
>   10: PMU events                                            :
>   10.1: PMU event table sanity                              : Ok
>   10.2: PMU event map aliases                               : Ok
>   10.3: Parsing of PMU event table metrics                  : Skip (some metrics failed)
>   10.4: Parsing of PMU event table metrics with fake PMUs   : Ok
>   67: Parse and process metrics                             : Ok
> 
> The failure in 10.3 seems due to parse errors like below:
> 
>   Multiple errors dropping message: unknown term 'filter_opc' for pmu 'uncore_cbox_0'
>   (valid terms: event,edge,inv,umask,cmask,config,config1,config2,name,period,freq,
>                 branch_type,time,call-graph,stack-size,no-inherit,inherit,max-stack,
> 		nr,no-overwrite,overwrite,driver-config,percore,aux-output,aux-sample-size)
> 
> 
>   Parse event failed metric 'DRAM_Parallel_Reads' id 'arb/event=0x80,umask=0x2,thresh=1/'
>     expr 'arb@event\=0x80\,umask\=0x2@ / arb@event\=0x80\,umask\=0x2\,thresh\=1@'
>   Error string 'unknown term 'thresh' for pmu 'uncore_arb'' help
>     'valid terms: event,edge,inv,umask,cmask,config,config1,config2,name,period,freq,
>                   branch_type,time,call-graph,stack-size,no-inherit,inherit,max-stack,
> 		  nr,no-overwrite,overwrite,driver-config,percore,aux-output,aux-sample-size'
> 
> 
> The patches are also available at 'perf/metric-fix-v1' branch on
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
> 
> Thanks
> Namhyung
> 
> 
> Namhyung Kim (9):
>   perf evlist: Fix cpu/thread map leak
>   perf parse-event: Fix cpu map leaks
>   perf parse-event: Fix memory leak in evsel->unit
>   perf test: Fix memory leaks in parse-metric test
>   perf metric: Release expr_parse_ctx after testing
>   perf metric: Free metric when it failed to resolve
>   perf metric: Do not free metric when failed to resolve
>   perf test: Free aliases for PMU event map aliases test
>   perf test: Free formats for perf pmu parse test

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

