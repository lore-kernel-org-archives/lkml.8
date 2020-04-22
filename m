Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE3BC55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECE222077D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="guEBXDyA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbgDVLos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 07:44:48 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58710 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726426AbgDVLos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 07:44:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587555887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xYjsgPTBbEllvea9H8SobRIIj2A4KdZWTwT6pRyZnis=;
        b=guEBXDyAw8r58vc6D46YXpsEiBZYE6RrfxEBm2LGZRug1Y4xt+VG4WgE2EwJcQdnKFV50q
        2NL4ldb5YYB9fa9qaqpHDR2HlPdIIoUhdzrMo7ZHnBCmXSV7KJkgsDJjhH9XhUeYwIr9/i
        o4n/MNyiftD4ii311lwLVS+oKdex3Lk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-aTGTmnOjNNKKlr6hVs-fwg-1; Wed, 22 Apr 2020 07:44:45 -0400
X-MC-Unique: aTGTmnOjNNKKlr6hVs-fwg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C8D910139AC;
        Wed, 22 Apr 2020 11:44:42 +0000 (UTC)
Received: from krava (unknown [10.40.196.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 67234101E58A;
        Wed, 22 Apr 2020 11:44:39 +0000 (UTC)
Date:   Wed, 22 Apr 2020 13:44:32 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, will@kernel.org, ak@linux.intel.com,
        linuxarm@huawei.com, linux-kernel@vger.kernel.org,
        qiangqing.zhang@nxp.com, irogers@google.com, robin.murphy@arm.com,
        zhangshaokun@hisilicon.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH v2 10/13] perf metricgroup: Split up
 metricgroup__add_metric()
Message-ID: <20200422114432.GH962614@krava>
References: <1587120084-18990-1-git-send-email-john.garry@huawei.com>
 <1587120084-18990-11-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587120084-18990-11-git-send-email-john.garry@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 06:41:21PM +0800, John Garry wrote:

SNIP

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

also this place got changed just recently a lot,
so you might want to rebase to the Arnaldo's latest perf/core

jirka

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

