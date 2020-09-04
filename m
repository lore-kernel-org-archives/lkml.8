Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FB9C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9927320C56
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730583AbgIDNpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 09:45:13 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:34114 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730411AbgIDNlv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 09:41:51 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 57E99F562622980621CA;
        Fri,  4 Sep 2020 21:25:08 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.108) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Fri, 4 Sep 2020
 21:25:03 +0800
Subject: Re: [PATCH -next] perf bench: fix return value check in
 do_run_multi_threaded()
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
References: <20200902140526.26916-1-yuehaibing@huawei.com>
 <20200903185301.GE3495158@kernel.org> <20200903185451.GF3495158@kernel.org>
 <20200903185549.GG3495158@kernel.org>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <irogers@google.com>,
        <linux-kernel@vger.kernel.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <6815e565-c3a2-c7a2-f164-8d3c56f9c516@huawei.com>
Date:   Fri, 4 Sep 2020 21:25:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20200903185549.GG3495158@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/9/4 2:55, Arnaldo Carvalho de Melo wrote:
> Em Thu, Sep 03, 2020 at 03:54:51PM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Thu, Sep 03, 2020 at 03:53:01PM -0300, Arnaldo Carvalho de Melo escreveu:
>>> Em Wed, Sep 02, 2020 at 10:05:26PM +0800, YueHaibing escreveu:
>>>> In case of error, the function perf_session__new() returns ERR_PTR()
>>>> and never returns NULL. The NULL test in the return value check
>>>> should be replaced with IS_ERR()
>>>>
>>>> Fixes: 13edc237200c ("perf bench: Add a multi-threaded synthesize benchmark")
>>>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>>>
>>> Thanks, applied, kudos for adding the Fixes: tag, appreciated!
>>
>> But...

OOps, sorry for this, I'll pay attention next time.

>>  
>>>> ---
>>>>  tools/perf/bench/synthesize.c | 4 ++--
>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/tools/perf/bench/synthesize.c b/tools/perf/bench/synthesize.c
>>>> index 8d624aea1c5e..e39daa609db2 100644
>>>> --- a/tools/perf/bench/synthesize.c
>>>> +++ b/tools/perf/bench/synthesize.c
>>>> @@ -162,8 +162,8 @@ static int do_run_multi_threaded(struct target *target,
>>>>  	init_stats(&event_stats);
>>>>  	for (i = 0; i < multi_iterations; i++) {
>>>>  		session = perf_session__new(NULL, false, NULL);
>>>> -		if (!session)
>>>> -			return -ENOMEM;
>>>> +		if (IS_ERR(session)) {
>>>> +			return PTR_ERR(session);
>>
>> This doesn't compile, so I take back that kudo ;-\
>>
>> I'm fixing this by removing that needless '{'.
> 
> diff --git a/tools/perf/bench/synthesize.c b/tools/perf/bench/synthesize.c
> index e39daa609db2ed9b..b2924e3181dc3844 100644
> --- a/tools/perf/bench/synthesize.c
> +++ b/tools/perf/bench/synthesize.c
> @@ -162,7 +162,7 @@ static int do_run_multi_threaded(struct target *target,
>  	init_stats(&event_stats);
>  	for (i = 0; i < multi_iterations; i++) {
>  		session = perf_session__new(NULL, false, NULL);
> -		if (IS_ERR(session)) {
> +		if (IS_ERR(session))
>  			return PTR_ERR(session);
>  
>  		atomic_set(&event_count, 0);
> 
> .
> 

