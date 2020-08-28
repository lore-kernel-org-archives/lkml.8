Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F351CC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 15:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6D4E20791
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 15:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgH1Pkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 11:40:45 -0400
Received: from foss.arm.com ([217.140.110.172]:52092 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbgH1Pko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 11:40:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9549B31B;
        Fri, 28 Aug 2020 08:40:43 -0700 (PDT)
Received: from [10.57.47.125] (unknown [10.57.47.125])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C39E3F71F;
        Fri, 28 Aug 2020 08:40:39 -0700 (PDT)
Subject: Re: [PATCH RESEND v1 02/11] perf mem: Introduce weak function
 perf_mem_events__ptr()
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ian Rogers <irogers@google.com>,
        Kemeng Shi <shikemeng@huawei.com>,
        Wei Li <liwei391@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Al Grant <Al.Grant@arm.com>, linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>
References: <20200806030727.30267-1-leo.yan@linaro.org>
 <20200806030727.30267-3-leo.yan@linaro.org>
From:   James Clark <james.clark@arm.com>
Cc:     nd <nd@arm.com>
Message-ID: <e756de3d-d41f-4b51-d434-fe12cd2da251@arm.com>
Date:   Fri, 28 Aug 2020 16:40:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200806030727.30267-3-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

On 06/08/2020 04:07, Leo Yan wrote:
>  
>  	for (j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
> -		if (!perf_mem_events[j].record)
> +		e = perf_mem_events__ptr(j);
> +		if (!e->record)
>  			continue;
>  
> -		if (!perf_mem_events[j].supported) {
> +		if (!e->supported) {
>  			pr_err("failed: event '%s' not supported\n",
> -			       perf_mem_events[j].name);
> +			       perf_mem_events__name(j));
>  			free(rec_argv);
>  			return -1;

Does it make sense to do something like:

   for(j = 0; e = perf_mem_events__ptr(j); j++) {
       ...
   }

now that it's a weak function that returns NULL when the argument out of range. That way the caller
doesn't need to know about PERF_MEM_EVENTS__MAX as well and it could potentially be a different
value. I don't know if it would ever make sense to have a different number of events on different platforms?

James
