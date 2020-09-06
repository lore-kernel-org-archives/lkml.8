Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94701C433E2
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 12:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3333920C09
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 12:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gYU/B3kN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbgIFMmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 08:42:18 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41975 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728688AbgIFMla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 08:41:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599396088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pgqQVs5j8I92ZxK0jg9iRh7f5oc/9ZNPC4FIf1M06Mo=;
        b=gYU/B3kNBbS6E/FA2UdGzgYinxHYi4giojK36CbRlXfkBNwwN0wjxPW0PE3EoFzTddGHlR
        tSVaBNHmcBSQKjTXeCAs3ftdOWFo6oCu2IyTj5y1QzEktvASRlBVgoHM6QyCcvw1N6nugY
        7g2yQ2Aru4JUze/+2ZPNliP4lGorpl8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-6tqiricAMYaQReqICHXRVA-1; Sun, 06 Sep 2020 08:41:24 -0400
X-MC-Unique: 6tqiricAMYaQReqICHXRVA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B8011DDE9;
        Sun,  6 Sep 2020 12:41:22 +0000 (UTC)
Received: from krava (ovpn-112-63.ams2.redhat.com [10.36.112.63])
        by smtp.corp.redhat.com (Postfix) with SMTP id F2F0A10002A6;
        Sun,  6 Sep 2020 12:41:18 +0000 (UTC)
Date:   Sun, 6 Sep 2020 14:41:18 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <andi@firstfloor.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v2 1/2] perf metric: Fix some memory leaks
Message-ID: <20200906124118.GA1199773@krava>
References: <20200905021912.621388-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200905021912.621388-1-namhyung@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 05, 2020 at 11:19:11AM +0900, Namhyung Kim wrote:
> I found some memory leaks while reading the metric code.  Some are
> real and others only occur in the error path.  When it failed during
> metric or event parsing, it should release all resources properly.
> 
> Cc: Kajol Jain <kjain@linux.ibm.com>
> Cc: John Garry <john.garry@huawei.com>
> Cc: Ian Rogers <irogers@google.com>
> Fixes: b18f3e365019d ("perf stat: Support JSON metrics in perf stat")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/perf/util/metricgroup.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 8831b964288f..af664d6218d6 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -530,6 +530,9 @@ void metricgroup__print(bool metrics, bool metricgroups, char *filter,
>  						continue;
>  					strlist__add(me->metrics, s);
>  				}
> +
> +				if (!raw)
> +					free(s);
>  			}
>  			free(omg);
>  		}
> @@ -1040,7 +1043,7 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
>  	ret = metricgroup__add_metric_list(str, metric_no_group,
>  					   &extra_events, &metric_list, map);
>  	if (ret)
> -		return ret;
> +		goto out;
>  	pr_debug("adding %s\n", extra_events.buf);
>  	bzero(&parse_error, sizeof(parse_error));
>  	ret = __parse_events(perf_evlist, extra_events.buf, &parse_error, fake_pmu);
> @@ -1048,11 +1051,11 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
>  		parse_events_print_error(&parse_error, extra_events.buf);
>  		goto out;
>  	}
> -	strbuf_release(&extra_events);
>  	ret = metricgroup__setup_events(&metric_list, metric_no_merge,
>  					perf_evlist, metric_events);
>  out:
>  	metricgroup__free_metrics(&metric_list);
> +	strbuf_release(&extra_events);
>  	return ret;
>  }
>  
> -- 
> 2.28.0.526.ge36021eeef-goog
> 

