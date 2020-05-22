Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DC1C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 09:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1101207CB
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 09:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b4bOQEFR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbgEVJx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 05:53:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57823 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728425AbgEVJx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 05:53:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590141204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=phT8Jdcjb8WhmeRHEo/eXl/PflCfxX/KJwitxNs5m9k=;
        b=b4bOQEFRYpnHoccuAED+XhLnr1isFDdqcLpakw/FXMl+b2h1OPJzUTQJMo5qmqUrPnXx+V
        6/xiwsXhGWA9VkXLem6hjI1BxZ2c0MfNoD3e0k060v3IGgv8+nZytw6dM7WXlqZsuZ5lpN
        2+0jEln55Ye90DZPTtciEi2KGKln22M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-kGdR8j8pO1iQEfkv9udLCg-1; Fri, 22 May 2020 05:53:22 -0400
X-MC-Unique: kGdR8j8pO1iQEfkv9udLCg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 241608018A2;
        Fri, 22 May 2020 09:53:21 +0000 (UTC)
Received: from krava (unknown [10.40.195.217])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0B81160CD0;
        Fri, 22 May 2020 09:53:14 +0000 (UTC)
Date:   Fri, 22 May 2020 11:53:14 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf evlist: Ensure grouped events with same cpu map
Message-ID: <20200522095314.GD264196@krava>
References: <20200521062240.18865-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521062240.18865-1-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 02:22:40PM +0800, Jin Yao wrote:

SNIP

> ---
>  tools/perf/builtin-stat.c |  3 +++
>  tools/perf/util/evlist.c  | 32 ++++++++++++++++++++++++++++++++
>  tools/perf/util/evlist.h  |  5 +++++
>  3 files changed, 40 insertions(+)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 377e575f9645..0e4fc6b3323c 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -584,6 +584,9 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>  	if (affinity__setup(&affinity) < 0)
>  		return -1;
>  
> +	if (!evlist__cpus_matched(evsel_list))
> +		evlist__force_disable_group(evsel_list);
> +
>  	evlist__for_each_cpu (evsel_list, i, cpu) {
>  		affinity__set(&affinity, cpu);
>  
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 2a9de6491700..fc6e410ca63b 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -1704,3 +1704,35 @@ struct evsel *perf_evlist__reset_weak_group(struct evlist *evsel_list,
>  	}
>  	return leader;
>  }
> +
> +bool evlist__cpus_matched(struct evlist *evlist)
> +{
> +	struct evsel *prev = evlist__first(evlist), *evsel = prev;
> +
> +	if (prev->core.nr_members <= 1)
> +		return true;

hum, this assumes there's only one group in evlist?

how about case like A,{B,C},D,{E,F}

also please add automated tests for this

> +
> +	evlist__for_each_entry_continue(evlist, evsel) {
> +		if (evsel->core.cpus->nr != prev->core.cpus->nr)
> +			return false;
> +
> +		for (int i = 0; i < evsel->core.cpus->nr; i++) {
> +			if (evsel->core.cpus->map[i] != prev->core.cpus->map[i])
> +				return false;
> +		}
> +
> +		prev = evsel;
> +	}
> +
> +	return true;
> +}
> +
> +void evlist__force_disable_group(struct evlist *evlist)
> +{
> +	struct evsel *evsel;

we need to put some warning for user in here

thanks,
jirka

> +
> +	evlist__for_each_entry(evlist, evsel) {
> +		evsel->leader = evsel;
> +		evsel->core.nr_members = 0;
> +	}
> +}
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index b6f325dfb4d2..ea7a53166cbd 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -355,4 +355,9 @@ void perf_evlist__force_leader(struct evlist *evlist);
>  struct evsel *perf_evlist__reset_weak_group(struct evlist *evlist,
>  						 struct evsel *evsel,
>  						bool close);
> +
> +bool evlist__cpus_matched(struct evlist *evlist);
> +
> +void evlist__force_disable_group(struct evlist *evlist);
> +
>  #endif /* __PERF_EVLIST_H */
> -- 
> 2.17.1
> 

