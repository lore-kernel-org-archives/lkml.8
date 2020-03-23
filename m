Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13666C4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 11:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D82D02070A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 11:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AQtK4jQ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbgCWLBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 07:01:15 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:20450 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727991AbgCWLBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 07:01:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584961274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UhvE5SsATsLb9aEaVavJjTl1Si3A9wCeislY3orrWOU=;
        b=AQtK4jQ6VXT9KHHGXSHFA5cfsMkrMFRWyfuinLbZK8LB+1gibwRoca0QU2YkjieTuIG6It
        aJKS/cS3cQz3IVuLHC3oZ6ECtBFyQ8IwDJWTVASbCLhqVv76Jnasf76RfgzdEe0Ic/024N
        xj7Suo+7GCWW+oht/Oi3AUNcBcMiGwI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-u1LTdQP9O6SPU5UtK40M-g-1; Mon, 23 Mar 2020 07:01:09 -0400
X-MC-Unique: u1LTdQP9O6SPU5UtK40M-g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C71D4DB63;
        Mon, 23 Mar 2020 11:01:07 +0000 (UTC)
Received: from krava (unknown [10.40.192.119])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1651B5DA7B;
        Mon, 23 Mar 2020 11:01:04 +0000 (UTC)
Date:   Mon, 23 Mar 2020 12:01:02 +0100
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
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2 2/2] libperf evlist: fix memory leaks
Message-ID: <20200323110102.GF1534489@krava>
References: <20200319023101.82458-1-irogers@google.com>
 <20200319023101.82458-2-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319023101.82458-2-irogers@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 07:31:01PM -0700, Ian Rogers wrote:
> Memory leaks found by applying LLVM's libfuzzer on the tools/perf
> parse_events function.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Arnaldo,
could you plz pull first:
  https://lore.kernel.org/lkml/1583665157-349023-1-git-send-email-zhe.he@windriver.com/

and then merge in this one? 

thanks,
jirka

Acked-by: Jiri Olsa <jolsa@redhat.com>

> ---
>  tools/lib/perf/evlist.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> index 5b9f2ca50591..6485d1438f75 100644
> --- a/tools/lib/perf/evlist.c
> +++ b/tools/lib/perf/evlist.c
> @@ -125,8 +125,10 @@ static void perf_evlist__purge(struct perf_evlist *evlist)
>  void perf_evlist__exit(struct perf_evlist *evlist)
>  {
>  	perf_cpu_map__put(evlist->cpus);
> +	perf_cpu_map__put(evlist->all_cpus);
>  	perf_thread_map__put(evlist->threads);
>  	evlist->cpus = NULL;
> +	evlist->all_cpus = NULL;
>  	evlist->threads = NULL;
>  	fdarray__exit(&evlist->pollfd);
>  }
> -- 
> 2.25.1.696.g5e7596f4ac-goog
> 

