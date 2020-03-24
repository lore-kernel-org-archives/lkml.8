Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5B8C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AABD720775
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mz3AaVGy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbgCXNLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:11:42 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:35493 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726915AbgCXNLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:11:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585055501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cd6KV/emetvr0s6RZCThEP3Rmoq7QiPbyQdz5ZsuYJo=;
        b=Mz3AaVGyLr2vyI1pSkVCHL/mz2qblEpDtsAosS0MHzDw0fGWxwwTbbdw7M3ZT6WvPb/wPD
        8R/ce1e4Wicb4bcQRzFla3FMAk6CoT6lkPs5HyErqYETxx5N3yxcbFIMmwnyefYF90ykvq
        e79PwC/JWJNujoD8kyWoLk3TCo1h6GY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-K2fQwpdFM1ycnE_NYyjqzQ-1; Tue, 24 Mar 2020 09:11:37 -0400
X-MC-Unique: K2fQwpdFM1ycnE_NYyjqzQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0ADEB801E67;
        Tue, 24 Mar 2020 13:11:34 +0000 (UTC)
Received: from krava (unknown [10.40.192.119])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 859B290CF1;
        Tue, 24 Mar 2020 13:11:21 +0000 (UTC)
Date:   Tue, 24 Mar 2020 14:11:12 +0100
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
Subject: Re: [PATCH v6 09/11] perf/tools: Enhance JSON/metric infrastructure
 to handle "?"
Message-ID: <20200324131112.GU1534489@krava>
References: <20200320125406.30995-1-kjain@linux.ibm.com>
 <20200320125406.30995-10-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320125406.30995-10-kjain@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 06:24:04PM +0530, Kajol Jain wrote:

SNIP

> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 52fb119d25c8..b4b91d8ad5be 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -474,8 +474,13 @@ static bool metricgroup__has_constraint(struct pmu_event *pe)
>  	return false;
>  }
>  
> +int __weak arch_get_runtimeparam(void)
> +{
> +	return 1;
> +}
> +
>  static int metricgroup__add_metric_param(struct strbuf *events,
> -			struct list_head *group_list, struct pmu_event *pe)
> +		struct list_head *group_list, struct pmu_event *pe, int param)
>  {
>  
>  	const char **ids;
> @@ -483,7 +488,7 @@ static int metricgroup__add_metric_param(struct strbuf *events,

could you please call this function __metricgroup__add_metric instead?

>  	struct egroup *eg;
>  	int ret = -EINVAL;
>  
> -	if (expr__find_other(pe->metric_expr, NULL, &ids, &idnum) < 0)
> +	if (expr__find_other(pe->metric_expr, NULL, &ids, &idnum, param) < 0)
>  		return ret;
>  
>  	if (events->len > 0)
> @@ -502,11 +507,21 @@ static int metricgroup__add_metric_param(struct strbuf *events,
>  
>  	eg->ids = ids;
>  	eg->idnum = idnum;
> -	eg->metric_name = pe->metric_name;
> +	if (strstr(pe->metric_expr, "?")) {
> +		char value[PATH_MAX];
> +
> +		sprintf(value, "%s%c%d", pe->metric_name, '_', param);
> +		eg->metric_name = strdup(value);

how is eg->metric_name getting released?

> +		if (!eg->metric_name) {
> +			ret = -ENOMEM;
> +			return ret;

		return -ENOMEM; ??

> +		}
> +	}
> +	else
> +		eg->metric_name = pe->metric_name;
>  	eg->metric_expr = pe->metric_expr;
>  	eg->metric_unit = pe->unit;
>  	list_add_tail(&eg->nd, group_list);
> -
>  	return 0;
>  }
>  

SNIP

thanks,
jirka

