Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A757C47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 12:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AF532068E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 12:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B2+75IhX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbgEAMX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 08:23:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48459 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726131AbgEAMX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 08:23:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588335834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wP17silhFjqURPZ0lCw7pPN8/+HElMBtuNcuxrK7Duw=;
        b=B2+75IhXlLHoF/+WQn2Teg+AZqRGtO1ANQjKoPixHy9+b5U9hc2BkdHyUvirCQWUnDqlpe
        jNgD6H7z7OaVKey3u96H2hj2PUHolRSkpUbFI7eLD+croV62WjiosdAER8oEbTotNcvfbq
        /iSleg422Ox0tPLTUn4jDPay0hxvXKs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-N2GGkVmeNxia3slNZEYmDg-1; Fri, 01 May 2020 08:23:53 -0400
X-MC-Unique: N2GGkVmeNxia3slNZEYmDg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5AF21107ACCA;
        Fri,  1 May 2020 12:23:51 +0000 (UTC)
Received: from krava (unknown [10.40.192.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C390F60C47;
        Fri,  1 May 2020 12:23:48 +0000 (UTC)
Date:   Fri, 1 May 2020 14:23:45 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 2/2] lib kallsyms: parse using io api
Message-ID: <20200501122345.GA1810115@krava>
References: <20200430193557.101831-1-irogers@google.com>
 <20200430193557.101831-3-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430193557.101831-3-irogers@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 12:35:57PM -0700, Ian Rogers wrote:
> Perf record will call kallsyms__parse 4 times during startup and process
> megabytes of data. This changes kallsyms__parse to use the io library
> rather than fgets to improve performance of the user code by over 8%.
> 
> Before:
>   Running 'internals/kallsyms-parse' benchmark:
>   Average kallsyms__parse took: 103.988 ms (+- 0.203 ms)
> After:
>   Running 'internals/kallsyms-parse' benchmark:
>   Average kallsyms__parse took: 95.571 ms (+- 0.006 ms)
> 
> For a workload like:
> $ perf record /bin/true
> Run under 'perf record -e cycles:u -g' the time goes from:
> Before
> 30.10%     1.67%  perf     perf                [.] kallsyms__parse
> After
> 25.55%    20.04%  perf     perf                [.] kallsyms__parse
> So a little under 5% of the start-up time is removed. A lot of what
> remains is on the kernel side, but caching kallsyms within perf would
> at least impact memory footprint.

with your change I'm getting following warnings:

$ sudo ./perf record -a
Couldn't record kernel reference relocation symbol
Symbol resolution may be skewed if relocation was used (e.g. kexec).
Check /proc/kallsyms permission or run as root.

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/lib/api/io.h          |  3 ++
>  tools/lib/symbol/kallsyms.c | 81 +++++++++++++++++++------------------
>  2 files changed, 44 insertions(+), 40 deletions(-)
> 
> diff --git a/tools/lib/api/io.h b/tools/lib/api/io.h
> index b7e55b5f8a4a..777c20f6b604 100644
> --- a/tools/lib/api/io.h
> +++ b/tools/lib/api/io.h
> @@ -7,6 +7,9 @@
>  #ifndef __API_IO__
>  #define __API_IO__
>  
> +#include <stdlib.h>
> +#include <unistd.h>

was this missing?

jirka

> +
>  struct io {
>  	/* File descriptor being read/ */
>  	int fd;

SNIP

