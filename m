Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C0CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 18:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F3A1205CB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 18:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gmxuHP6A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390229AbgEMSju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 14:39:50 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51531 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389724AbgEMSjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 14:39:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589395188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BavTkUCkU5lOlqm34/OAaeadhok337Em0LQ0JqmIrBo=;
        b=gmxuHP6ADh1Bv9k+0KdJJJ6AL5OZUCGwnJO3ebUbm/seNh0xa2Ecg+dNCcufj6x7rDhLQ6
        AuKWGxcLT+KIk1wzOM7mhnBkT2cmz6MkZsNZTpblpp1786M0L6SZinNjAXBVDN7cg6vdGX
        C5Gza7tQ9sd4/i0MaWvpYm2ZZ+b3PT8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-7m8wSnxJNiOuKndsraMyMg-1; Wed, 13 May 2020 14:39:42 -0400
X-MC-Unique: 7m8wSnxJNiOuKndsraMyMg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B184873065;
        Wed, 13 May 2020 18:39:40 +0000 (UTC)
Received: from krava (unknown [10.40.195.109])
        by smtp.corp.redhat.com (Postfix) with SMTP id 107A75D9C5;
        Wed, 13 May 2020 18:39:34 +0000 (UTC)
Date:   Wed, 13 May 2020 20:39:32 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf parse-events: Make add PMU verbose output clearer
Message-ID: <20200513183932.GC3343750@krava>
References: <20200513001729.21155-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513001729.21155-1-irogers@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 05:17:29PM -0700, Ian Rogers wrote:

SNIP

> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 92bd7fafcce6..71d0290b616a 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1056,7 +1056,8 @@ static char *pmu_formats_string(struct list_head *formats)
>   * Setup one of config[12] attr members based on the
>   * user input data - term parameter.
>   */
> -static int pmu_config_term(struct list_head *formats,
> +static int pmu_config_term(const char *pmu_name,
> +			   struct list_head *formats,
>  			   struct perf_event_attr *attr,
>  			   struct parse_events_term *term,
>  			   struct list_head *head_terms,
> @@ -1082,16 +1083,24 @@ static int pmu_config_term(struct list_head *formats,
>  
>  	format = pmu_find_format(formats, term->config);
>  	if (!format) {
> -		if (verbose > 0)
> -			printf("Invalid event/parameter '%s'\n", term->config);
> +		char *pmu_term = pmu_formats_string(formats);
> +		char *unknown_term;
> +		char *help_msg;
> +
> +		if (asprintf(&unknown_term,
> +				"unknown term '%s' for pmu '%s'",
> +				term->config, pmu_name) < 0)
> +			unknown_term = strdup("unknown term");

is that really necessary? is asprintf fails, strdup will probably too,
and parse_events__handle_error checks on the !str, so we should be fine

other than that it looks ok to me

thanks,
jirka

> +		help_msg = parse_events_formats_error_string(pmu_term);
>  		if (err) {
> -			char *pmu_term = pmu_formats_string(formats);
> -
>  			parse_events__handle_error(err, term->err_term,
> -				strdup("unknown term"),
> -				parse_events_formats_error_string(pmu_term));
> -			free(pmu_term);
> +						   unknown_term,
> +						   help_msg);
> +		} else {
> +			pr_debug("%s (%s)\n", unknown_term, help_msg);
> +			free(unknown_term);
>  		}
> +		free(pmu_term);

SNIP

