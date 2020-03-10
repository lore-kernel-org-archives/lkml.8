Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F4AC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3B1220727
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TD0HyEqM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgCJSfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 14:35:03 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44509 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgCJSfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 14:35:02 -0400
Received: by mail-qk1-f196.google.com with SMTP id f198so13698345qke.11;
        Tue, 10 Mar 2020 11:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zHa0iiMg1LtsQPa4RzS3SJC7qiq1r42M4MmqcLqD6hU=;
        b=TD0HyEqM+V7/qanUWngHe4SaoRRuZsGJU+eQwh3spFHBWrNBe9rptkiNmukwHt9qer
         /6qGrwun+Z6334XjK3ow1kKUrjqF8HI56BJYI1ediDkE4OxBSzFqDffX8PCKErNdNqN2
         3q+FEhvfzF0u2d6x0ZRLXCHF/OiQTYFBwU/FP3zKgZwkfBuSYg5IfW1V42hSVLK+0Sk5
         cXY8EuCO8VjYpZvc/HW0V+KGinWyURKTmOe/lM1/Mcc/EHwaejx9N05fAopNPOwtJoTy
         CBa+wVUXIYXtTTs2Pr9DFxXaquN8xQ7n3CT/XJH7NfaKfjzp367C2vpa+mylnUkivWfZ
         n0Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zHa0iiMg1LtsQPa4RzS3SJC7qiq1r42M4MmqcLqD6hU=;
        b=ug7ZRN+fJujtZkdd4hPy9xmBCrQGqenaa18veQ/nWhx+ELSsr5rmIFTP1EFvO1qXdv
         xG1oYPtJZZ21B2abxlkLAM2JEjOPJLnkRFemZmaWwotpHXAufoLFRaAe1sb24libOeIg
         vXDFM4/dnDGSpiI9UOYQkAlUL5hBfnwOf1s1edWLzgUbgDrP0LZnQquHLmwA8d0LGcNM
         i2owVb325eTHaHQUXioSmBl+HONKtPA2X6ZsbR8tYanWb5qs77dW2C9toWIaJWfaf9dY
         ZUFH8OQwBtF0TKjoaPo2uwMiaw6g/UiXVxxE7Sso4f0s24FJxmrOf+4E8rriUA8KUHPU
         xhNg==
X-Gm-Message-State: ANhLgQ1K5UY9y+czhNrsQ8DDpXXRFUUIxKhl90T5Dv9YBXTg4213rQBx
        hmL26B/EQhcKphT4g9zt6hU=
X-Google-Smtp-Source: ADFU+vtz2HTPPKJN12hgGqJTzAUV58Lqv96kvPnXb1MUjvUWy/yLrJk4YOI4USVsnW1fjEL8EzmjEw==
X-Received: by 2002:a37:b042:: with SMTP id z63mr15279655qke.269.1583865300544;
        Tue, 10 Mar 2020 11:35:00 -0700 (PDT)
Received: from quaco.ghostprotocols.net (179-240-149-111.3g.claro.net.br. [179.240.149.111])
        by smtp.gmail.com with ESMTPSA id z11sm6740092qti.23.2020.03.10.11.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 11:35:00 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 339C140009; Tue, 10 Mar 2020 15:34:55 -0300 (-03)
Date:   Tue, 10 Mar 2020 15:34:55 -0300
To:     Kajol Jain <kjain@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
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
Subject: Re: [PATCH v4 6/8] perf/tools: Enhance JSON/metric infrastructure to
 handle "?"
Message-ID: <20200310183455.GB12036@kernel.org>
References: <20200309062552.29911-1-kjain@linux.ibm.com>
 <20200309062552.29911-7-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309062552.29911-7-kjain@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 09, 2020 at 11:55:50AM +0530, Kajol Jain escreveu:
> Patch enhances current metric infrastructure to handle "?" in the metric
> expression. The "?" can be use for parameters whose value not known while
> creating metric events and which can be replace later at runtime to
> the proper value. It also add flexibility to create multiple events out
> of single metric event added in json file.
> 
> Patch adds function 'arch_get_runtimeparam' which is a arch specific
> function, returns the count of metric events need to be created.
> By default it return 1.
> 
> One loop is added in function 'metricgroup__add_metric', which create
> multiple events at run time depend on return value of
> 'arch_get_runtimeparam' and merge that event in 'group_list'.
> 
> This infrastructure needed for hv_24x7 socket/chip level events.
> "hv_24x7" chip level events needs specific chip-id to which the
> data is requested. Function 'arch_get_runtimeparam' implemented
> in header.c which extract number of sockets from sysfs file
> "sockets" under "/sys/devices/hv_24x7/interface/".
> 
> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> ---
>  tools/perf/arch/powerpc/util/header.c |  22 +++++
>  tools/perf/util/expr.h                |   1 +
>  tools/perf/util/expr.l                |  19 +++-
>  tools/perf/util/metricgroup.c         | 124 ++++++++++++++++++++------
>  tools/perf/util/metricgroup.h         |   1 +
>  tools/perf/util/stat-shadow.c         |   8 ++
>  6 files changed, 148 insertions(+), 27 deletions(-)
> 
> diff --git a/tools/perf/arch/powerpc/util/header.c b/tools/perf/arch/powerpc/util/header.c
> index 3b4cdfc5efd6..036f6b2ce202 100644
> --- a/tools/perf/arch/powerpc/util/header.c
> +++ b/tools/perf/arch/powerpc/util/header.c
> @@ -7,6 +7,11 @@
>  #include <string.h>
>  #include <linux/stringify.h>
>  #include "header.h"
> +#include "metricgroup.h"
> +#include "evlist.h"
> +#include <dirent.h>
> +#include "pmu.h"
> +#include <api/fs/fs.h>
>  
>  #define mfspr(rn)       ({unsigned long rval; \
>  			 asm volatile("mfspr %0," __stringify(rn) \
> @@ -16,6 +21,8 @@
>  #define PVR_VER(pvr)    (((pvr) >>  16) & 0xFFFF) /* Version field */
>  #define PVR_REV(pvr)    (((pvr) >>   0) & 0xFFFF) /* Revison field */
>  
> +#define SOCKETS_INFO_FILE_PATH "/devices/hv_24x7/interface/"
> +
>  int
>  get_cpuid(char *buffer, size_t sz)
>  {
> @@ -44,3 +51,18 @@ get_cpuid_str(struct perf_pmu *pmu __maybe_unused)
>  
>  	return bufp;
>  }
> +
> +int arch_get_runtimeparam(void)
> +{
> +	int count;
> +	char path[PATH_MAX];
> +	char filename[] = "sockets";
> +
> +	snprintf(path, PATH_MAX,
> +		 SOCKETS_INFO_FILE_PATH "%s", filename);
> +
> +	if (sysfs__read_ull(path, (unsigned long long *)&count) < 0)
> +		return 1;
> +	else
> +		return count;

Why this cast dance? We have sysfs__read_int(path, &count).

Also this is more compact:

	return sysfs__read_int(path, &count) < 0 ? 1 : count;

> +}
> diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
> index 9377538f4097..d17664e628db 100644
> --- a/tools/perf/util/expr.h
> +++ b/tools/perf/util/expr.h
> @@ -15,6 +15,7 @@ struct parse_ctx {
>  	struct parse_id ids[MAX_PARSE_ID];
>  };
>  
> +int expr__runtimeparam;
>  void expr__ctx_init(struct parse_ctx *ctx);
>  void expr__add_id(struct parse_ctx *ctx, const char *id, double val);
>  int expr__parse(double *final_val, struct parse_ctx *ctx, const char *expr);
> diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
> index 1928f2a3dddc..ec4b00671f67 100644
> --- a/tools/perf/util/expr.l
> +++ b/tools/perf/util/expr.l
> @@ -45,6 +45,21 @@ static char *normalize(char *str)
>  			*dst++ = '/';
>  		else if (*str == '\\')
>  			*dst++ = *++str;
> +        else if (*str == '?') {
> +
> +			int size = snprintf(NULL, 0, "%d", expr__runtimeparam);

TIL that C99 allows for a NULL str to format and return the number of
bytes it would write if the string was large enough... wonders never
cease :-)

> +			char * paramval = (char *)malloc(size);

No need for the cast, malloc returns void *, or has that changed? 8-)
and please no space before the variable name.

Humm this is all complicated, why not use asprintf and have something
like:

> +			int i = 0;
> +
> +			if(!paramval)
> +				*dst++ = '0';
> +			else {
> +				sprintf(paramval, "%d", expr__runtimeparam);
> +				while(i < size)
> +					*dst++ = paramval[i++];
> +				free(paramval);
> +			}

			char *paramval;
			int size = asprintf(&paramval, "%d", expr__runtimeparam);

			if (size < 0)
				*dst++ = '0';
			else {
				while (i < size)
					*dst++ = paramval[i++];
				free(paramval);
			}


> +		}
>  		else
>  			*dst++ = *str;
>  		str++;
> @@ -72,8 +87,8 @@ number		[0-9]+
>  
>  sch		[-,=]
>  spec		\\{sch}
> -sym		[0-9a-zA-Z_\.:@]+
> -symbol		{spec}*{sym}*{spec}*{sym}*
> +sym		[0-9a-zA-Z_\.:@?]+
> +symbol		{spec}*{sym}*{spec}*{sym}*{spec}*{sym}
>  
>  %%
>  	{
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index c3a8c701609a..11eeeb929b91 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -474,6 +474,98 @@ static bool metricgroup__has_constraint(struct pmu_event *pe)
>  	return false;
>  }
>  
> +int __weak arch_get_runtimeparam(void)
> +{
> +	return 1;
> +}
> +
> +static int metricgroup__add_metric_runtime_param(struct strbuf *events,
> +			struct list_head *group_list, struct pmu_event *pe)
> +{
> +	int i, count;
> +	int ret = -EINVAL;
> +
> +	count = arch_get_runtimeparam();
> +
> +	/* This loop is added to create multiple
> +	 * events depend on count value and add
> +	 * those events to group_list.
> +	 */
> +
> +	for (i = 0; i < count; i++) {
> +		const char **ids;
> +		int idnum;
> +		struct egroup *eg;
> +		char value[PATH_MAX];
> +
> +		expr__runtimeparam = i;
> +
> +		if (expr__find_other(pe->metric_expr,
> +					NULL, &ids, &idnum) < 0)
> +			return ret;
> +
> +		if (events->len > 0)
> +			strbuf_addf(events, ",");
> +
> +		if (metricgroup__has_constraint(pe))
> +			metricgroup__add_metric_non_group(events, ids, idnum);
> +		else
> +			metricgroup__add_metric_weak_group(events, ids, idnum);
> +
> +		eg = malloc(sizeof(struct egroup));

Shorter form that works even if you change that type:

+		eg = malloc(sizeof(*eg));

> +		if (!eg) {
> +			ret = -ENOMEM;
> +			return ret;
> +		}
> +		sprintf(value, "%s%c%d", pe->metric_name, '_', i);
> +		eg->ids = ids;
> +		eg->idnum = idnum;
> +		eg->metric_name = strdup(value);

Please check strdup() return just like you checked the malloc(sizeof(struct egroup)).

> +		eg->metric_expr = pe->metric_expr;
> +		eg->metric_unit = pe->unit;
> +		list_add_tail(&eg->nd, group_list);
> +		ret = 0;
> +
> +		if (ret != 0)
> +			break;
> +	}
> +	return ret;
> +}
> +static int metricgroup__add_metric_param(struct strbuf *events,
> +			struct list_head *group_list, struct pmu_event *pe)
> +{
> +
> +	const char **ids;
> +	int idnum;
> +	struct egroup *eg;
> +	int ret = -EINVAL;
> +
> +	if (expr__find_other(pe->metric_expr,
> +					     NULL, &ids, &idnum) < 0)

Why break the above in two lines?

> +		return ret;
> +	if (events->len > 0)
> +		strbuf_addf(events, ",");
> +
> +	if (metricgroup__has_constraint(pe))
> +		metricgroup__add_metric_non_group(events, ids, idnum);
> +	else
> +		metricgroup__add_metric_weak_group(events, ids, idnum);
> +
> +	eg = malloc(sizeof(struct egroup));

Ditto

> +	if (!eg)
> +		ret = -ENOMEM;
> +
> +	eg->ids = ids;
> +	eg->idnum = idnum;
> +	eg->metric_name = pe->metric_name;
> +	eg->metric_expr = pe->metric_expr;
> +	eg->metric_unit = pe->unit;
> +	list_add_tail(&eg->nd, group_list);
> +	ret = 0;
> +
> +	return ret;
> +}
> +
>  static int metricgroup__add_metric(const char *metric, struct strbuf *events,
>  				   struct list_head *group_list)
>  {
> @@ -493,35 +585,17 @@ static int metricgroup__add_metric(const char *metric, struct strbuf *events,
>  			continue;
>  		if (match_metric(pe->metric_group, metric) ||
>  		    match_metric(pe->metric_name, metric)) {
> -			const char **ids;
> -			int idnum;
> -			struct egroup *eg;
>  
>  			pr_debug("metric expr %s for %s\n", pe->metric_expr, pe->metric_name);
>  
> -			if (expr__find_other(pe->metric_expr,
> -					     NULL, &ids, &idnum) < 0)
> -				continue;
> -			if (events->len > 0)
> -				strbuf_addf(events, ",");
> -
> -			if (metricgroup__has_constraint(pe))
> -				metricgroup__add_metric_non_group(events, ids, idnum);
> +			if (strstr(pe->metric_expr, "?"))
> +				ret = metricgroup__add_metric_runtime_param(events,
> +							group_list, pe);
>  			else
> -				metricgroup__add_metric_weak_group(events, ids, idnum);
> -
> -			eg = malloc(sizeof(struct egroup));

                                             *eg
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
> +				ret = metricgroup__add_metric_param(events,
> +							group_list, pe);
> +			if (ret == -EINVAL)
> +				continue;
>  		}
>  	}
>  	return ret;
> diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
> index 475c7f912864..81224ba1270d 100644
> --- a/tools/perf/util/metricgroup.h
> +++ b/tools/perf/util/metricgroup.h
> @@ -34,4 +34,5 @@ int metricgroup__parse_groups(const struct option *opt,
>  void metricgroup__print(bool metrics, bool groups, char *filter,
>  			bool raw, bool details);
>  bool metricgroup__has_metric(const char *metric);
> +int arch_get_runtimeparam(void);
>  #endif
> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
> index 0fd713d3674f..92c4c9abbaa0 100644
> --- a/tools/perf/util/stat-shadow.c
> +++ b/tools/perf/util/stat-shadow.c
> @@ -777,6 +777,14 @@ static void generic_metric(struct perf_stat_config *config,
>  	}
>  
>  	if (!metric_events[i]) {
> +
> +		if (strstr(metric_expr, "?")) {
> +			char *tmp = strrchr(metric_name, '_');
> +

So at this point a metric name is guaranteed to have a _?

> +			tmp++;
> +			expr__runtimeparam = strtol(tmp, &tmp, 10);
> +		}
> +
>  		if (expr__parse(&ratio, &pctx, metric_expr) == 0) {
>  			char *unit;
>  			char metric_bf[64];
> -- 
> 2.18.1
> 

-- 

- Arnaldo
