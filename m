Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAACC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 509B320748
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590076445;
	bh=TKWRFarh/DR/G+dyqD24vZ5+B4+IDBEfETfLPpR5GC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aRvADLL6cgnDFECRBvcxzBD4dk+MVUOXSHv6JZRKzS5ElaCrv0ufo2/5kBkG9ofSR
	 XisSpbenZmT3wp2rIPjMALQ7ZJkL3O4YgErVqr5R20VIH67HCaY26+pdWiv//x7yC+
	 t35VprLUFAp6FWxUgkYloITECt4bK31eSoLotweo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgEUPyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 11:54:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:42998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728295AbgEUPyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 11:54:04 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61828206F6;
        Thu, 21 May 2020 15:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590076443;
        bh=TKWRFarh/DR/G+dyqD24vZ5+B4+IDBEfETfLPpR5GC4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I0jYgn73mDBEa820iMQpAo4MjQC+FGRPpOjEOaFRwbXq0f1dN+WI8MsKLaYbgF7cQ
         NcrhhAAU+P+iI4xcIanYFO1r4Vg3S0ZfJgeWveLLzdoATSJRKrhCsgU34Qtyy2EH+t
         7UyxvJRHd9oWXFnF2HA50KDgcUcbnvCqrdMbYb9w=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7197D40AFD; Thu, 21 May 2020 12:54:00 -0300 (-03)
Date:   Thu, 21 May 2020 12:54:00 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Wei Li <liwei391@huawei.com>, Ian Rogers <irogers@google.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Li Bin <huawei.libin@huawei.com>,
        Xie XiuQi <xiexiuqi@huawei.com>,
        Hongbo Yao <yaohongbo@huawei.com>
Subject: Re: [PATCH 1/4] perf metrictroup: Fix memory leak of metric_events
Message-ID: <20200521155400.GA14034@kernel.org>
References: <20200521133218.30150-1-liwei391@huawei.com>
 <20200521133218.30150-2-liwei391@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521133218.30150-2-liwei391@huawei.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, May 21, 2020 at 09:32:15PM +0800, Wei Li escreveu:
> From: Hongbo Yao <yaohongbo@huawei.com>
> 
> Fix memory leak of metric_events in function metricgroup__setup_events()

The leak is there but this code has changed a lot recently, please take
a look at my perf/core branch and keep Ian Rogers in the loop,

- Arnaldo
 
> Signed-off-by: Hongbo Yao <yaohongbo@huawei.com>
> ---
>  tools/perf/util/metricgroup.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 926449a7cdbf..69bf0f4d646e 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -184,6 +184,7 @@ static int metricgroup__setup_events(struct list_head *groups,
>  		if (!evsel) {
>  			pr_debug("Cannot resolve %s: %s\n",
>  					eg->metric_name, eg->metric_expr);
> +			free(metric_events);
>  			continue;
>  		}
>  		for (i = 0; i < eg->idnum; i++)
> @@ -191,11 +192,13 @@ static int metricgroup__setup_events(struct list_head *groups,
>  		me = metricgroup__lookup(metric_events_list, evsel, true);
>  		if (!me) {
>  			ret = -ENOMEM;
> +			free(metric_events);
>  			break;
>  		}
>  		expr = malloc(sizeof(struct metric_expr));
>  		if (!expr) {
>  			ret = -ENOMEM;
> +			free(metric_events);
>  			break;
>  		}
>  		expr->metric_expr = eg->metric_expr;
> -- 
> 2.17.1
> 

-- 

- Arnaldo
