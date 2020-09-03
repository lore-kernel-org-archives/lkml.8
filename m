Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D10C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 14:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2DD02071B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 14:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ifgqJf4M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbgICOIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 10:08:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38838 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728902AbgICN7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 09:59:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599141550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HSP0jlbzyLAhK2BkAi7h81czBQdiNtcooqFsNBJUUcY=;
        b=ifgqJf4MeqVSqMWp+ZEDNDlx2Y/kWigQhU4icJk9zDkK7yRc16V/VFpaB+00+KbuHZSzDx
        lEoTEaVa7Iqa4hgtGs/pkPwjSxQ/NBVvmbews2+zxZ2W0r+4gvhzBWK19kYG9zaoRLRZg2
        n8+ABSAdqZIO/ME4Mf2AXnLw2pLfh44=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-DfqQZNWEN7Wr1pwnY2Tl7w-1; Thu, 03 Sep 2020 09:51:03 -0400
X-MC-Unique: DfqQZNWEN7Wr1pwnY2Tl7w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2DA918C5204;
        Thu,  3 Sep 2020 13:51:00 +0000 (UTC)
Received: from krava (unknown [10.40.195.71])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0C3CF5D6C4;
        Thu,  3 Sep 2020 13:50:55 +0000 (UTC)
Date:   Thu, 3 Sep 2020 15:50:54 +0200
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
Subject: Re: [PATCH v2 02/14] perf mem: Introduce weak function
 perf_mem_events__ptr()
Message-ID: <20200903135054.GD713364@krava>
References: <20200901083815.13755-1-leo.yan@linaro.org>
 <20200901083815.13755-3-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901083815.13755-3-leo.yan@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 09:38:03AM +0100, Leo Yan wrote:

SNIP

> @@ -2941,30 +2942,38 @@ static int perf_c2c__record(int argc, const char **argv)
>  	rec_argv[i++] = "record";
>  
>  	if (!event_set) {
> -		perf_mem_events[PERF_MEM_EVENTS__LOAD].record  = true;
> -		perf_mem_events[PERF_MEM_EVENTS__STORE].record = true;
> +		e = perf_mem_events__ptr(PERF_MEM_EVENTS__LOAD);
> +		e->record = true;
> +
> +		e = perf_mem_events__ptr(PERF_MEM_EVENTS__STORE);
> +		e->record = true;
>  	}
>  
> -	if (perf_mem_events[PERF_MEM_EVENTS__LOAD].record)
> +	e = perf_mem_events__ptr(PERF_MEM_EVENTS__LOAD);
> +	if (e->record)
>  		rec_argv[i++] = "-W";
>  
>  	rec_argv[i++] = "-d";
>  	rec_argv[i++] = "--phys-data";
>  	rec_argv[i++] = "--sample-cpu";
>  
> -	for (j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
> -		if (!perf_mem_events[j].record)
> +	j = 0;
> +	while ((e = perf_mem_events__ptr(j)) != NULL) {
> +		if (!e->record) {

you could keep the above 'for loop' in here, it seems better
than taking care of j++

> +			j++;
>  			continue;
> +		}
>  
> -		if (!perf_mem_events[j].supported) {
> +		if (!e->supported) {
>  			pr_err("failed: event '%s' not supported\n",
> -			       perf_mem_events[j].name);
> +			       perf_mem_events__name(j));
>  			free(rec_argv);
>  			return -1;
>  		}
>  
>  		rec_argv[i++] = "-e";
>  		rec_argv[i++] = perf_mem_events__name(j);
> +		j++;
>  	}
>  
>  	if (all_user)

SNIP

> @@ -100,11 +106,14 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
>  	if (mem->phys_addr)
>  		rec_argv[i++] = "--phys-data";
>  
> -	for (j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
> -		if (!perf_mem_events[j].record)
> +	j = 0;
> +	while ((e = perf_mem_events__ptr(j)) != NULL) {
> +		if (!e->record) {

same here

thanks,
jirka

> +			j++;
>  			continue;
> +		}
>  
> -		if (!perf_mem_events[j].supported) {
> +		if (!e->supported) {
>  			pr_err("failed: event '%s' not supported\n",
>  			       perf_mem_events__name(j));
>  			free(rec_argv);
> @@ -113,6 +122,7 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
>  
>  		rec_argv[i++] = "-e";
>  		rec_argv[i++] = perf_mem_events__name(j);
> +		j++;

SNIP

