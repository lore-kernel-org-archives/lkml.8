Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1089C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8116520768
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UaWIE5iA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895267AbgDOJSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 05:18:51 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60777 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2895258AbgDOJSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 05:18:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586942325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=URQUpKC6fTrIzufDdCsc1nVAnH1v0PyahflhCC/xQMo=;
        b=UaWIE5iAMeRvUDMbPcE+2kI7Ls+qYNFPpJFZWHUhw9ZA3OdX9+aSPMlbZO4p+xlskFnJ0F
        FXtqmcb+ma9uCQoWz4wHLsNsQO8ZqplpI6BUlCAr1as2ZHONf3QRZmixNHaMEHO8V0ixAN
        gPB9TWBvn810PyVpdiy5a3btn9kuX0g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404--4gXu9EYOBKPaO3TIOuT5Q-1; Wed, 15 Apr 2020 05:18:43 -0400
X-MC-Unique: -4gXu9EYOBKPaO3TIOuT5Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C4617DB60;
        Wed, 15 Apr 2020 09:18:41 +0000 (UTC)
Received: from krava (unknown [10.40.193.71])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 75197116D96;
        Wed, 15 Apr 2020 09:18:39 +0000 (UTC)
Date:   Wed, 15 Apr 2020 11:18:36 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2] perf stat: force error in fallback on :k events
Message-ID: <20200415091836.GH208694@krava>
References: <20200414161550.225588-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414161550.225588-1-irogers@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 09:15:50AM -0700, Ian Rogers wrote:

SNIP

> New behavior with paranoid 2:
> $ sudo bash -c "echo 2 > /proc/sys/kernel/perf_event_paranoid"
> $ perf stat -e cycles:k sleep 1
> Error:
> You may not have permission to collect stats.
> 
> Consider tweaking /proc/sys/kernel/perf_event_paranoid,
> which controls use of the performance events system by
> unprivileged users (without CAP_PERFMON or CAP_SYS_ADMIN).
> 
> The current value is 2:
> 
>   -1: Allow use of (almost) all events by all users
>       Ignore mlock limit after perf_event_mlock_kb without CAP_IPC_LOCK
> >= 0: Disallow ftrace function tracepoint by users without CAP_PERFMON or CAP_SYS_ADMIN
>       Disallow raw tracepoint access by users without CAP_SYS_PERFMON or CAP_SYS_ADMIN
> >= 1: Disallow CPU event access by users without CAP_PERFMON or CAP_SYS_ADMIN
> >= 2: Disallow kernel profiling by users without CAP_PERFMON or CAP_SYS_ADMIN
> 
> To make this setting permanent, edit /etc/sysctl.conf too, e.g.:
> 
>         kernel.perf_event_paranoid = -1
> 
> v2 of this patch addresses the review feedback from jolsa@redhat.com.
> 
> Signed-off-by: Stephane Eranian <eranian@google.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/evsel.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index d23db6755f51..b4e8bcb5ab05 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2446,6 +2446,10 @@ bool perf_evsel__fallback(struct evsel *evsel, int err,
>  		char *new_name;
>  		const char *sep = ":";
>  
> +		/* If event has exclude user then don't exclude kernel. */
> +		if (evsel->core.attr.exclude_user)
> +			return false;
> +

nice, it's much simpler

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

>  		/* Is there already the separator in the name. */
>  		if (strchr(name, '/') ||
>  		    strchr(name, ':'))
> -- 
> 2.26.0.110.g2183baf09c-goog
> 

