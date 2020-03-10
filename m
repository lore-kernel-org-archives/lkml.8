Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF149C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 17:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8248B20727
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 17:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PnK4YGP2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgCJRpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 13:45:45 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33932 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgCJRpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 13:45:44 -0400
Received: by mail-qt1-f196.google.com with SMTP id 59so10316631qtb.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 10:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QemRXrwL4UpnbRsBf8B1D0cgwOeA2HFZJdAYO2yUd+0=;
        b=PnK4YGP2qfUv9J0y4rZzgHSykk9vpQGWzvfrDJsrAjNzvFsQya1S0ori9X893E6wrG
         ZYwFo/R1lwWACsfmbkFn9ihmaUQVJQT/Q1x05VYOBMxCa1y6Lv6JpLZmBcXTZ0ny9Lu2
         u5rEMUagxSPGtUDLNCx59YNLtmB8BxObOgPqlJpjtL/qpn9DJihxtbu4dUwngqsYUFkZ
         xHknKsWRn5ySwLlfeRw/lyQge8++l/J6bw5ubi1W2P5ehdnO9AKzsWqbCutxwLGsxtHV
         oBI0RcieUlDrg5DzQ7DgC3ocHWqRspiQmNrcTx/URTpS8nPWO2Fsi9wKMpjFVGRQ+tFF
         KoWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QemRXrwL4UpnbRsBf8B1D0cgwOeA2HFZJdAYO2yUd+0=;
        b=jI55qpIWFw7hY7Dd95+X0QZDuUeJn+cXWUcUyNHtiBYWQqTVMiDIhl/onJF4/rfJCI
         uj71eGVGRwlSE6W2rslAKEqbt0ovRn9pUtc93TCKqoLKnUkfJDWO7yf3jUoUcmdNhAAa
         iwPseZVmYIMJvn0z0W7v5F/SZ8rrXpo6oyd6BM6WWpnAxzXUh+l1DKl1LzBzioX3vjnL
         dxFRFANwrZBypkoA1HNmYltaXqF5awNTfnP7LEiwUgA12X6931+2xclTJk/HbITCi1T4
         /sln9MnbDvRaKYRE85a9sgo4i/nFiJKoxwVGxy3uvv+Qe/CYtORUpPW7sE6E0V4YuzoB
         IApw==
X-Gm-Message-State: ANhLgQ0VirABeq+ElZ6gCDXPO1bcwtZrWXRSVcfaT5d7w04lyM3UvnXQ
        Z1R2OVbDGXAW9nz+ZuYqA0g=
X-Google-Smtp-Source: ADFU+vsZ+3W5RC8V8z+YWUm6MPwR4I5DeT3zuXd/8eQdwRF3k6qsqY3YQ6v2QIvnHIVqC9gfFZsZLw==
X-Received: by 2002:ac8:7493:: with SMTP id v19mr19261822qtq.318.1583862343247;
        Tue, 10 Mar 2020 10:45:43 -0700 (PDT)
Received: from quaco.ghostprotocols.net (179-240-149-111.3g.claro.net.br. [179.240.149.111])
        by smtp.gmail.com with ESMTPSA id h47sm5764078qtb.75.2020.03.10.10.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 10:45:42 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9500140009; Tue, 10 Mar 2020 14:45:38 -0300 (-03)
Date:   Tue, 10 Mar 2020 14:45:38 -0300
To:     kan.liang@linux.intel.com
Cc:     jolsa@redhat.com, mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        namhyung@kernel.org, ravi.bangoria@linux.ibm.com,
        yao.jin@linux.intel.com, ak@linux.intel.com
Subject: Re: [PATCH V2 2/5] perf metricgroup: Factor out
 metricgroup__add_metric_weak_group()
Message-ID: <20200310174538.GK15931@kernel.org>
References: <1582581564-184429-1-git-send-email-kan.liang@linux.intel.com>
 <1582581564-184429-3-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582581564-184429-3-git-send-email-kan.liang@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Feb 24, 2020 at 01:59:21PM -0800, kan.liang@linux.intel.com escreveu:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Factor out metricgroup__add_metric_weak_group() which add metrics into a
> weak group. The change can improve code readability. Because following
> patch will introduce a function which add standalone metrics.
> 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  tools/perf/util/metricgroup.c | 57 +++++++++++++++++++++++++------------------
>  1 file changed, 33 insertions(+), 24 deletions(-)
> 
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 02aee94..1cd042c 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -399,13 +399,42 @@ void metricgroup__print(bool metrics, bool metricgroups, char *filter,
>  	strlist__delete(metriclist);
>  }
>  
> +static void metricgroup__add_metric_weak_group(struct strbuf *events,
> +					       const char **ids,
> +					       int idnum)
> +{
> +	bool no_group = false;
> +	int i;
> +
> +	for (i = 0; i < idnum; i++) {
> +		pr_debug("found event %s\n", ids[i]);
> +		/*
> +		 * Duration time maps to a software event and can make
> +		 * groups not count. Always use it outside a
> +		 * group.
> +		 */
> +		if (!strcmp(ids[i], "duration_time")) {
> +			if (i > 0)
> +				strbuf_addf(events, "}:W,");
> +			strbuf_addf(events, "duration_time");

At some point we need to do some error checking on these strbuf calls,
but since this was the state in this file, lets not block this patchkit
on such grounds,

- Arnaldo

> +			no_group = true;
> +			continue;
> +		}
> +		strbuf_addf(events, "%s%s",
> +			i == 0 || no_group ? "{" : ",",
> +			ids[i]);
> +		no_group = false;
> +	}
> +	if (!no_group)
> +		strbuf_addf(events, "}:W");
> +}
> +
>  static int metricgroup__add_metric(const char *metric, struct strbuf *events,
>  				   struct list_head *group_list)
>  {
>  	struct pmu_events_map *map = perf_pmu__find_map(NULL);
>  	struct pmu_event *pe;
> -	int ret = -EINVAL;
> -	int i, j;
> +	int i, ret = -EINVAL;
>  
>  	if (!map)
>  		return 0;
> @@ -422,7 +451,6 @@ static int metricgroup__add_metric(const char *metric, struct strbuf *events,
>  			const char **ids;
>  			int idnum;
>  			struct egroup *eg;
> -			bool no_group = false;
>  
>  			pr_debug("metric expr %s for %s\n", pe->metric_expr, pe->metric_name);
>  
> @@ -431,27 +459,8 @@ static int metricgroup__add_metric(const char *metric, struct strbuf *events,
>  				continue;
>  			if (events->len > 0)
>  				strbuf_addf(events, ",");
> -			for (j = 0; j < idnum; j++) {
> -				pr_debug("found event %s\n", ids[j]);
> -				/*
> -				 * Duration time maps to a software event and can make
> -				 * groups not count. Always use it outside a
> -				 * group.
> -				 */
> -				if (!strcmp(ids[j], "duration_time")) {
> -					if (j > 0)
> -						strbuf_addf(events, "}:W,");
> -					strbuf_addf(events, "duration_time");
> -					no_group = true;
> -					continue;
> -				}
> -				strbuf_addf(events, "%s%s",
> -					j == 0 || no_group ? "{" : ",",
> -					ids[j]);
> -				no_group = false;
> -			}
> -			if (!no_group)
> -				strbuf_addf(events, "}:W");
> +
> +			metricgroup__add_metric_weak_group(events, ids, idnum);
>  
>  			eg = malloc(sizeof(struct egroup));
>  			if (!eg) {
> -- 
> 2.7.4
> 

-- 

- Arnaldo
