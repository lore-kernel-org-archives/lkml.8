Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4781BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 17:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA608205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 17:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ECX2to14"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390000AbgEMRsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 13:48:36 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50357 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732670AbgEMRsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 13:48:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589392114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eQomhzuW4Cs2AjAbkSBWe/UTSeGb0joo7UtJLPw4J4M=;
        b=ECX2to14q6N5GLftxUf6aOl5ywIiBORuNkZObVCvZggwuYQV6FNVgdAoF0JSLic0i97yoX
        h1vSMHPzHwxUHjfwbSHVfRkYPhazyjFLgAepz2JVjRGwYUv9ZoMq7yGgEpNNpCQ2ExcVI/
        UblOWpqT+HqBe+RFo0XCfizDG3xGDvA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-130-G88DI2OoNu6tUsF93zBg-w-1; Wed, 13 May 2020 13:48:26 -0400
X-MC-Unique: G88DI2OoNu6tUsF93zBg-w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 54D8D84B8A7;
        Wed, 13 May 2020 17:48:24 +0000 (UTC)
Received: from krava (unknown [10.40.195.109])
        by smtp.corp.redhat.com (Postfix) with SMTP id A05525C49B;
        Wed, 13 May 2020 17:48:20 +0000 (UTC)
Date:   Wed, 13 May 2020 19:48:19 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Clarke <pc@us.ibm.com>, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 2/2] perf test: Improve pmu event metric testing
Message-ID: <20200513174819.GA3343750@krava>
References: <20200513062236.854-1-irogers@google.com>
 <20200513062236.854-2-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513062236.854-2-irogers@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 11:22:36PM -0700, Ian Rogers wrote:

SNIP

> +
> +static int check_parse_id(const char *id, bool same_cpu, struct pmu_event *pe)
> +{
> +	struct parse_events_error error;
> +	struct evlist *evlist;
> +	int ret;
> +
> +	/* Numbers are always valid. */
> +	if (is_number(id))
> +		return 0;
> +
> +	evlist = evlist__new();
> +	memset(&error, 0, sizeof(error));
> +	ret = parse_events(evlist, id, &error);
> +	if (ret && same_cpu) {
> +		fprintf(stderr,
> +			"\nWARNING: Parse event failed metric '%s' id '%s' expr '%s'\n",
> +			pe->metric_name, id, pe->metric_expr);
> +		fprintf(stderr, "Error string '%s' help '%s'\n",
> +			error.str, error.help);
> +	} else if (ret) {
> +		pr_debug3("Parse event failed, but for an event that may not be supported by this CPU.\nid '%s' metric '%s' expr '%s'\n",
> +			id, pe->metric_name, pe->metric_expr);
> +	}

I wonder if we could add 'fake pmu' that would be used for tests
and use it parse_events_add_pmu to add 'fake' evsel but the name
would be correct.. we could add parse_events_state::fake_pmu bool
for that

rest of the event types (other than pmu syntax) might be ok


> +	evlist__delete(evlist);
> +	free(error.str);
> +	free(error.help);
> +	free(error.first_str);
> +	free(error.first_help);
> +	/* TODO: too many metrics are broken to fail on this test currently. */
> +	return 0;
> +}
> +
> +static int test_parsing(void)
> +{
> +	struct pmu_events_map *cpus_map = perf_pmu__find_map(NULL);
> +	struct pmu_events_map *map;
> +	struct pmu_event *pe;
> +	int i, j, k;
> +	const char **ids;
> +	int idnum;
> +	int ret = 0;
> +	struct expr_parse_ctx ctx;
> +	double result;
> +
> +	i = 0;
> +	for (;;) {
> +		map = &pmu_events_map[i++];
> +		if (!map->table) {
> +			map = NULL;

hum, what's the map = NULL for in here?

thanks,
jirka

> +			break;
> +		}
> +		j = 0;
> +		for (;;) {
> +			pe = &map->table[j++];
> +			if (!pe->name && !pe->metric_group && !pe->metric_name)
> +				break;
> +			if (!pe->metric_expr)
> +				continue;
> +			if (expr__find_other(pe->metric_expr, NULL,
> +						&ids, &idnum, 0) < 0) {
> +				pr_debug("Parse other failed for map %s %s %s\n",
> +					map->cpuid, map->version, map->type);
> +				pr_debug("On metric %s\n", pe->metric_name);
> +				pr_debug("On expression %s\n", pe->metric_expr);
> +				ret++;
> +				continue;
> +			}
> +			expr__ctx_init(&ctx);
> +
> +			/*
> +			 * Add all ids with a made up value. The value may
> +			 * trigger divide by zero when subtracted and so try to
> +			 * make them unique.
> +			 */
> +			for (k = 0; k < idnum; k++)
> +				expr__add_id(&ctx, ids[k], k + 1);
> +
> +			for (k = 0; k < idnum; k++) {
> +				if (check_parse_id(ids[k], map == cpus_map, pe))
> +					ret++;
> +			}
> +
> +			if (expr__parse(&result, &ctx, pe->metric_expr, 0)) {
> +				pr_debug("Parse failed for map %s %s %s\n",
> +					map->cpuid, map->version, map->type);
> +				pr_debug("On metric %s\n", pe->metric_name);
> +				pr_debug("On expression %s\n", pe->metric_expr);
> +				ret++;
> +			}
> +			for (k = 0; k < idnum; k++)
> +				zfree(&ids[k]);
> +			free(ids);
> +		}
> +	}
> +	return ret;

SNIP

