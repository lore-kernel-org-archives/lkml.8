Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E987CC18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 15:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEA4B20714
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 15:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WW5z8lsT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbgCQPHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 11:07:24 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:23990 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726726AbgCQPHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 11:07:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584457642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EO6KQuA127O5XZwuqvLGhbQe2uTfyPpCExwjf2857y0=;
        b=WW5z8lsTjyK5Olp/LoEWxf4c4XwXMouLJFR1HPmL+gr/stMbSoGxmjnptl0/TEgYFn59pD
        hnMaPyjGGgsVdr96UKsozb7SUHtMRqEB9ZQemz3dpsU5HRW80vOYQ3RQJnlzEfv4DsfKHA
        VF4ZROuYgqUqBLLZzh1OYFm4xVdAl/8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-sJ61PwVKPvCDsPCkPWqb7w-1; Tue, 17 Mar 2020 11:07:18 -0400
X-MC-Unique: sJ61PwVKPvCDsPCkPWqb7w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B66CD107B789;
        Tue, 17 Mar 2020 15:06:58 +0000 (UTC)
Received: from krava (unknown [10.40.195.82])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E3DB60BF3;
        Tue, 17 Mar 2020 15:06:53 +0000 (UTC)
Date:   Tue, 17 Mar 2020 16:06:47 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Kajol Jain <kjain@linux.ibm.com>
Cc:     acme@kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        sukadev@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, anju@linux.vnet.ibm.com,
        maddy@linux.vnet.ibm.com, ravi.bangoria@linux.ibm.com,
        peterz@infradead.org, yao.jin@linux.intel.com, ak@linux.intel.com,
        jolsa@kernel.org, kan.liang@linux.intel.com, jmario@redhat.com,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        paulus@ozlabs.org, namhyung@kernel.org, mpetlan@redhat.com,
        gregkh@linuxfoundation.org, benh@kernel.crashing.org,
        mamatha4@linux.vnet.ibm.com, mark.rutland@arm.com,
        tglx@linutronix.de
Subject: Re: [PATCH v5 09/11] perf/tools: Enhance JSON/metric infrastructure
 to handle "?"
Message-ID: <20200317150647.GA757893@krava>
References: <20200317062333.14555-1-kjain@linux.ibm.com>
 <20200317062333.14555-10-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317062333.14555-10-kjain@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 11:53:31AM +0530, Kajol Jain wrote:

SNIP

> diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
> index 0938ad166ece..7786829b048b 100644
> --- a/tools/perf/util/expr.h
> +++ b/tools/perf/util/expr.h
> @@ -17,12 +17,13 @@ struct expr_parse_ctx {
>  
>  struct expr_scanner_ctx {
>  	int start_token;
> +	int expr__runtimeparam;

no need for expr__ prefix in here.. jsut runtime_param

> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
> index 402af3e8d287..85ac6d913782 100644
> --- a/tools/perf/util/stat-shadow.c
> +++ b/tools/perf/util/stat-shadow.c
> @@ -336,7 +336,7 @@ void perf_stat__collect_metric_expr(struct evlist *evsel_list)
>  		metric_events = counter->metric_events;
>  		if (!metric_events) {
>  			if (expr__find_other(counter->metric_expr, counter->name,
> -						&metric_names, &num_metric_names) < 0)
> +						&metric_names, &num_metric_names, 1) < 0)
>  				continue;
>  
>  			metric_events = calloc(sizeof(struct evsel *),
> @@ -777,7 +777,15 @@ static void generic_metric(struct perf_stat_config *config,
>  	}
>  
>  	if (!metric_events[i]) {
> -		if (expr__parse(&ratio, &pctx, metric_expr) == 0) {
> +		int param = 1;
> +		if (strstr(metric_expr, "?")) {
> +			char *tmp = strrchr(metric_name, '_');
> +
> +			tmp++;
> +			param = strtol(tmp, &tmp, 10);
> +		}

so, if metric_expr contains '?' you go and search metric_name for '_'
and use the number after '_' ... ugh.. what's the logic? 

I understand you create as many metrics as the magic runtime param
tells you.. but what's the connection to this?

could you please outline in the changelog or comment the whole scheme
of how this all should work? like step by step on some simple example?

thanks,
jirka

