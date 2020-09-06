Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0436FC43461
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 12:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6ED8208B3
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 12:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b7wlFKC2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbgIFM4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 08:56:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25503 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728692AbgIFM4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 08:56:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599396963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4ZIYk6eIpSqRXg8aHD2RmgdI5tSsATFe7QlkOtEKQH4=;
        b=b7wlFKC2bjVcKYE5ozDyoVs2/QSrxGaOiWLkhtlIHScPVWxFn/liJFVVuDScErJ3/fW5bE
        GtB/kCkCAAoxIdigfAbN4slCFQBjQ0CI9MyxqTvWCPuj6W2vsdomB/yNBvzNAIm1HihlqJ
        eUdw5OgYKysTAAoKfZXQ/rZbXYgWA4A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-sJLWIHuRMOmKlYVGiTQfgg-1; Sun, 06 Sep 2020 08:55:59 -0400
X-MC-Unique: sJLWIHuRMOmKlYVGiTQfgg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 77C711DDE9;
        Sun,  6 Sep 2020 12:55:57 +0000 (UTC)
Received: from krava (ovpn-112-63.ams2.redhat.com [10.36.112.63])
        by smtp.corp.redhat.com (Postfix) with SMTP id D5DA65D9CC;
        Sun,  6 Sep 2020 12:55:53 +0000 (UTC)
Date:   Sun, 6 Sep 2020 14:55:52 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Kajol Jain <kjain@linux.ibm.com>
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        pc@us.ibm.com, namhyung@kernel.org, ak@linux.intel.com,
        yao.jin@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, irogers@google.com,
        maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com,
        john.garry@huawei.com
Subject: Re: [PATCH v8 3/5] perf jevents: Add support for parsing
 perchip/percore events
Message-ID: <20200906125552.GC1199773@krava>
References: <20200906112004.49574-1-kjain@linux.ibm.com>
 <20200906112004.49574-4-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200906112004.49574-4-kjain@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 06, 2020 at 04:50:02PM +0530, Kajol Jain wrote:

SNIP

>  typedef int (*func)(void *data, struct json_event *je);
>  
>  int eprintf(int level, int var, const char *fmt, ...)
> @@ -355,6 +368,8 @@ static int print_events_table_entry(void *data, struct json_event *je)
>  		fprintf(outfp, "\t.unit = \"%s\",\n", je->unit);
>  	if (je->perpkg)
>  		fprintf(outfp, "\t.perpkg = \"%s\",\n", je->perpkg);
> +	if (je->aggr_mode)
> +		fprintf(outfp, "\t.aggr_mode = \"%d\",\n", convert(je->aggr_mode));
>  	if (je->metric_expr)
>  		fprintf(outfp, "\t.metric_expr = \"%s\",\n", je->metric_expr);
>  	if (je->metric_name)
> @@ -379,6 +394,7 @@ struct event_struct {
>  	char *pmu;
>  	char *unit;
>  	char *perpkg;
> +	char *aggr_mode;
>  	char *metric_expr;
>  	char *metric_name;
>  	char *metric_group;
> @@ -408,6 +424,7 @@ struct event_struct {
>  	op(pmu);						\
>  	op(unit);						\
>  	op(perpkg);						\
> +	op(aggr_mode);						\
>  	op(metric_expr);					\
>  	op(metric_name);					\
>  	op(metric_group);					\
> @@ -613,6 +630,8 @@ static int json_events(const char *fn,
>  				addfield(map, &je.unit, "", "", val);
>  			} else if (json_streq(map, field, "PerPkg")) {
>  				addfield(map, &je.perpkg, "", "", val);
> +			} else if (json_streq(map, field, "AggregationMode")) {
> +				addfield(map, &je.aggr_mode, "", "", val);

I think you should free je.aggr_mode

jirka

>  			} else if (json_streq(map, field, "Deprecated")) {
>  				addfield(map, &je.deprecated, "", "", val);
>  			} else if (json_streq(map, field, "MetricName")) {
> diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
> index c8f306b572f4..7da1a3743b77 100644
> --- a/tools/perf/pmu-events/pmu-events.h
> +++ b/tools/perf/pmu-events/pmu-events.h
> @@ -2,6 +2,11 @@
>  #ifndef PMU_EVENTS_H
>  #define PMU_EVENTS_H
>  
> +enum aggr_mode_class {
> +	PerChip = 1,
> +	PerCore
> +};
> +
>  /*
>   * Describe each PMU event. Each CPU has a table of PMU events.
>   */
> @@ -14,6 +19,7 @@ struct pmu_event {
>  	const char *pmu;
>  	const char *unit;
>  	const char *perpkg;
> +	const char *aggr_mode;
>  	const char *metric_expr;
>  	const char *metric_name;
>  	const char *metric_group;
> -- 
> 2.26.2
> 

