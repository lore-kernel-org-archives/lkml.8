Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A8DC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE2CC20801
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wv/jznOk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729592AbgEKLBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 07:01:33 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21960 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728574AbgEKLBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 07:01:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589194890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N2PRhyVQqj4CNO2Ups/0yQavldCLC2be0VW7v1d7TC8=;
        b=Wv/jznOklmsWnt10ZdzmMHxldb6eOard4DkLLGg+JuftPfFz9lFCn3ubqo+ebEqoCH7InT
        //sszQpZYxuvpXqqxy0wEl9kQyv4lNU0HUfAIntlVV1ZBPKkLuQMAJc4MBbmt6mJwVbWu5
        AgVuTxqU3VIhRE/ArC/72MEulukct4U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-HTg4J8gcPCOvjKF8vyHnzA-1; Mon, 11 May 2020 07:01:26 -0400
X-MC-Unique: HTg4J8gcPCOvjKF8vyHnzA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8CCF71009441;
        Mon, 11 May 2020 11:01:23 +0000 (UTC)
Received: from krava (unknown [10.40.194.31])
        by smtp.corp.redhat.com (Postfix) with SMTP id BBD801001920;
        Mon, 11 May 2020 11:01:19 +0000 (UTC)
Date:   Mon, 11 May 2020 13:01:18 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, will@kernel.org, ak@linux.intel.com,
        linuxarm@huawei.com, linux-kernel@vger.kernel.org,
        qiangqing.zhang@nxp.com, irogers@google.com, robin.murphy@arm.com,
        zhangshaokun@hisilicon.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC v3 09/12] perf metricgroup: Split up
 metricgroup__add_metric()
Message-ID: <20200511110118.GA2986380@krava>
References: <1588852671-61996-1-git-send-email-john.garry@huawei.com>
 <1588852671-61996-10-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588852671-61996-10-git-send-email-john.garry@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 07:57:48PM +0800, John Garry wrote:
> To aid supporting system event metric groups, break up the function
> metricgroup__add_metric() into a part which iterates metrics and a part
> which actually "adds" the metric.
> 
> No functional change intended.

this no longer applied on Arnaldo's perf/core,
it's very busy part now :-\

jirka

> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  tools/perf/util/metricgroup.c | 75 ++++++++++++++++++++++++++-----------------
>  1 file changed, 45 insertions(+), 30 deletions(-)
> 
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 926449a7cdbf..d1033756a1bc 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -231,6 +231,12 @@ static bool match_metric(const char *n, const char *list)
>  	return false;
>  }
>  
> +static bool match_pe_metric(struct pmu_event *pe, const char *metric)
> +{
> +	return match_metric(pe->metric_group, metric) ||
> +	       match_metric(pe->metric_name, metric);
> +}
> +
>  struct mep {
>  	struct rb_node nd;
>  	const char *name;
> @@ -485,6 +491,40 @@ static bool metricgroup__has_constraint(struct pmu_event *pe)
>  	return false;
>  }
>  
> +static int metricgroup__add_metric_pmu_event(struct pmu_event *pe,
> +					     struct strbuf *events,
> +					     struct list_head *group_list)
> +{
> +	const char **ids;
> +	int idnum;
> +	struct egroup *eg;
> +
> +	pr_debug("metric expr %s for %s\n", pe->metric_expr, pe->metric_name);
> +
> +	if (expr__find_other(pe->metric_expr, NULL, &ids, &idnum) < 0)
> +		return 0;
> +
> +	if (events->len > 0)
> +		strbuf_addf(events, ",");
> +
> +	if (metricgroup__has_constraint(pe))
> +		metricgroup__add_metric_non_group(events, ids, idnum);
> +	else
> +		metricgroup__add_metric_weak_group(events, ids, idnum);
> +
> +	eg = malloc(sizeof(*eg));
> +	if (!eg)
> +		return -ENOMEM;
> +	eg->ids = ids;
> +	eg->idnum = idnum;
> +	eg->metric_name = pe->metric_name;
> +	eg->metric_expr = pe->metric_expr;
> +	eg->metric_unit = pe->unit;
> +	list_add_tail(&eg->nd, group_list);
> +
> +	return 0;
> +}
> +
>  static int metricgroup__add_metric(const char *metric, struct strbuf *events,
>  				   struct list_head *group_list)
>  {
> @@ -502,37 +542,12 @@ static int metricgroup__add_metric(const char *metric, struct strbuf *events,
>  			break;
>  		if (!pe->metric_expr)
>  			continue;
> -		if (match_metric(pe->metric_group, metric) ||
> -		    match_metric(pe->metric_name, metric)) {
> -			const char **ids;
> -			int idnum;
> -			struct egroup *eg;
> -
> -			pr_debug("metric expr %s for %s\n", pe->metric_expr, pe->metric_name);
>  
> -			if (expr__find_other(pe->metric_expr,
> -					     NULL, &ids, &idnum) < 0)
> -				continue;
> -			if (events->len > 0)
> -				strbuf_addf(events, ",");
> -
> -			if (metricgroup__has_constraint(pe))
> -				metricgroup__add_metric_non_group(events, ids, idnum);
> -			else
> -				metricgroup__add_metric_weak_group(events, ids, idnum);
> -
> -			eg = malloc(sizeof(struct egroup));
> -			if (!eg) {
> -				ret = -ENOMEM;
> -				break;
> -			}
> -			eg->ids = ids;
> -			eg->idnum = idnum;
> -			eg->metric_name = pe->metric_name;
> -			eg->metric_expr = pe->metric_expr;
> -			eg->metric_unit = pe->unit;
> -			list_add_tail(&eg->nd, group_list);
> -			ret = 0;
> +		if (match_pe_metric(pe, metric)) {
> +			ret = metricgroup__add_metric_pmu_event(pe, events,
> +								group_list);
> +			if (ret)
> +				return ret;
>  		}
>  	}
>  	return ret;
> -- 
> 2.16.4
> 

