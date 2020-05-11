Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C64CC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 19:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AAC2206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 19:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M3zPyWcs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731471AbgEKTgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 15:36:14 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52599 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731243AbgEKTgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 15:36:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589225772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n1Azc72m1cbrlLpDQQKhMzhm3+sIV9uhpCTEmWjBjEo=;
        b=M3zPyWcsBucCaC0ZUT1gEop6aiQQF6RQAoDTeYmBfJ8K34mAd1AiPy0m1hDj9PLUvNcALt
        xog5jp6nEEdhz06H6DcB0BdCYsbKnoUNsdNOBqHHkvkI4xlLXR9st7LVUqm+g/bVCXwigy
        NPsuQ2fU+wjQP42yyshp+lYHt0qHHJs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-fKVFL0qOMnau3mM0hfQlUg-1; Mon, 11 May 2020 15:36:10 -0400
X-MC-Unique: fKVFL0qOMnau3mM0hfQlUg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09825835B42;
        Mon, 11 May 2020 19:36:09 +0000 (UTC)
Received: from krava (unknown [10.40.194.31])
        by smtp.corp.redhat.com (Postfix) with SMTP id 200C05D9DC;
        Mon, 11 May 2020 19:36:05 +0000 (UTC)
Date:   Mon, 11 May 2020 21:36:04 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v3] perf c2c: fix '-e list'
Message-ID: <20200511193604.GF2986380@krava>
References: <20200507220604.3391-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507220604.3391-1-irogers@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 03:06:04PM -0700, Ian Rogers wrote:
> When the event is passed as list, the default events should be listed as
> per 'perf mem record -e list'. Previous behavior is:
> 
> $ perf c2c record -e list
> failed: event 'list' not found, use '-e list' to get list of available events
> 
>  Usage: perf c2c record [<options>] [<command>]
>     or: perf c2c record [<options>] -- <command> [<options>]
> 
>     -e, --event <event>   event selector. Use 'perf mem record -e list' to list available events
> 
> New behavior:
> 
> $ perf c2c record -e list
> ldlat-loads  : available
> ldlat-stores : available
> 
> v3: is a rebase.
> v2: addresses review comments by Jiri Olsa.
> https://lore.kernel.org/lkml/20191127081844.GH32367@krava/
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/Documentation/perf-c2c.txt |  2 +-
>  tools/perf/builtin-c2c.c              |  9 ++++++++-
>  tools/perf/builtin-mem.c              | 24 +++++++-----------------
>  tools/perf/util/mem-events.c          | 15 +++++++++++++++
>  tools/perf/util/mem-events.h          |  2 ++
>  5 files changed, 33 insertions(+), 19 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-c2c.txt b/tools/perf/Documentation/perf-c2c.txt
> index 2133eb320cb0..98efdab5fbd4 100644
> --- a/tools/perf/Documentation/perf-c2c.txt
> +++ b/tools/perf/Documentation/perf-c2c.txt
> @@ -40,7 +40,7 @@ RECORD OPTIONS
>  --------------
>  -e::
>  --event=::
> -	Select the PMU event. Use 'perf mem record -e list'
> +	Select the PMU event. Use 'perf c2c record -e list'
>  	to list available events.
>  
>  -v::
> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index 1baf4cae086f..d617d5682c68 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -2887,8 +2887,15 @@ static int parse_record_events(const struct option *opt,
>  {
>  	bool *event_set = (bool *) opt->value;
>  
> +	if (!strcmp(str, "list")) {
> +		perf_mem_events__list();
> +		exit(0);
> +	}
> +	if (perf_mem_events__parse(str))
> +		exit(-1);

won't this exit(-1) callsbreak the parsing stuff?
like displaying the option values on error or such?

other than that it looks ok to me

jirka

