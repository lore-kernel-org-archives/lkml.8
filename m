Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64839C433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ECAF20716
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AllhKL4d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbgICPCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 11:02:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52920 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729047AbgICN7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 09:59:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599141547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q7d9IVaLdiU8t+KOY9YhvBtmvx3P89f14MOWNMV2Ces=;
        b=AllhKL4dpaYEFLCH8jrr7hjEwCytlmrbXN2FsF3ESnhe9lhEPJ3umnHB29sWhMdbpQtVZ3
        Qk9ihlN0rJOZpq1jSY63xkic/+TokLyLgB0+CNVmdSmPo0Rd7TpyyFqmCLVdyEsQky9wrk
        7itnzsrTXu562Q+UYibLzWVUMgxy12c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-546-Q4-sYnx8OtqZ9He-a06fKw-1; Thu, 03 Sep 2020 09:50:54 -0400
X-MC-Unique: Q4-sYnx8OtqZ9He-a06fKw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 99F8D85C733;
        Thu,  3 Sep 2020 13:50:50 +0000 (UTC)
Received: from krava (unknown [10.40.195.71])
        by smtp.corp.redhat.com (Postfix) with SMTP id B95CD19C78;
        Thu,  3 Sep 2020 13:50:45 +0000 (UTC)
Date:   Thu, 3 Sep 2020 15:50:44 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Kemeng Shi <shikemeng@huawei.com>,
        James Clark <james.clark@arm.com>,
        Wei Li <liwei391@huawei.com>, Al Grant <Al.Grant@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/14] perf mem: Search event name with more flexible
 path
Message-ID: <20200903135044.GC713364@krava>
References: <20200901083815.13755-1-leo.yan@linaro.org>
 <20200901083815.13755-2-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901083815.13755-2-leo.yan@linaro.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 09:38:02AM +0100, Leo Yan wrote:
> Perf tool searches memory event name under the folder
> '/sys/devices/cpu/events/', this leads to the limitation for selection
> memory profiling event which must be under this folder.  Thus it's
> impossible to use any other event as memory event which is not under
> this specific folder, e.g. Arm SPE hardware event is not located in
> '/sys/devices/cpu/events/' so it cannot be enabled for memory profiling.
> 
> This patch changes to search folder from '/sys/devices/cpu/events/' to
> '/sys/devices', so it give flexibility to find events which can be used
> for memory profiling.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/perf/util/mem-events.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> index ea0af0bc4314..35c8d175a9d2 100644
> --- a/tools/perf/util/mem-events.c
> +++ b/tools/perf/util/mem-events.c
> @@ -18,8 +18,8 @@ unsigned int perf_mem_events__loads_ldlat = 30;
>  #define E(t, n, s) { .tag = t, .name = n, .sysfs_name = s }
>  
>  struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX] = {
> -	E("ldlat-loads",	"cpu/mem-loads,ldlat=%u/P",	"mem-loads"),
> -	E("ldlat-stores",	"cpu/mem-stores/P",		"mem-stores"),
> +	E("ldlat-loads",	"cpu/mem-loads,ldlat=%u/P",	"cpu/events/mem-loads"),
> +	E("ldlat-stores",	"cpu/mem-stores/P",		"cpu/events/mem-stores"),
>  };
>  #undef E
>  
> @@ -93,7 +93,7 @@ int perf_mem_events__init(void)
>  		struct perf_mem_event *e = &perf_mem_events[j];
>  		struct stat st;
>  
> -		scnprintf(path, PATH_MAX, "%s/devices/cpu/events/%s",
> +		scnprintf(path, PATH_MAX, "%s/devices/%s",
>  			  mnt, e->sysfs_name);
>  
>  		if (!stat(path, &st))
> -- 
> 2.20.1
> 

