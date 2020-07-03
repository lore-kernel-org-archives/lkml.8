Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13B2C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 04:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8160208C7
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 04:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgGCEGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 00:06:21 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:33186 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725294AbgGCEGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 00:06:21 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C812CD09CA642B69DF95;
        Fri,  3 Jul 2020 12:06:18 +0800 (CST)
Received: from [10.174.178.63] (10.174.178.63) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Fri, 3 Jul 2020 12:06:17 +0800
From:   "liwei (GF)" <liwei391@huawei.com>
Subject: Re: [PATCH 2/2] perf tools: Fix record failure when mixed with ARM
 SPE event
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Kim Phillips <kim.phillips@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, <leo.yan@linaro.org>
References: <20200623123141.27747-1-liwei391@huawei.com>
 <20200623123141.27747-3-liwei391@huawei.com> <20200702230322.GB471976@xps15>
Message-ID: <5d872f6f-3665-5abd-7251-13926a70f793@huawei.com>
Date:   Fri, 3 Jul 2020 12:06:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200702230322.GB471976@xps15>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.63]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On 2020/7/3 7:03, Mathieu Poirier wrote:
> Hi Li,
> 
> On Tue, Jun 23, 2020 at 08:31:41PM +0800, Wei Li wrote:
>> When recording with cache-misses and arm_spe_x event, i found that
>> it will just fail without showing any error info if i put cache-misses
>> after arm_spe_x event.
>>
>> [root@localhost 0620]# perf record -e cache-misses -e \
>> arm_spe_0/ts_enable=1,pct_enable=1,pa_enable=1,load_filter=1,\
>> jitter=1,store_filter=1,min_latency=0/ sleep 1
>> [ perf record: Woken up 1 times to write data ]
>> [ perf record: Captured and wrote 0.067 MB perf.data ]
>> [root@localhost 0620]# perf record -e \
>> arm_spe_0/ts_enable=1,pct_enable=1,pa_enable=1,load_filter=1,jitter=1,\
>> store_filter=1,min_latency=0/ -e cache-misses sleep 1
>> [root@localhost 0620]#
>>
>> Finally, i found the reason is that the parameter 'arm_spe_pmu' passed to
>> arm_spe_recording_init() in auxtrace_record__init() is wrong. When the
>> arm_spe_x event is not the last event, 'arm_spe_pmus[i]' will be out of
>> bounds.
> 
> Yes, this indeed broken.  
> 
> The current code can only work if the only event to be
> traced is an arm_spe_X, or if it is the last event to be specified.
> Otherwise the last event type will be checked against all the
> arm_spe_pmus[i]->types, none will match and an out of bound i index will be
> used in arm_spc_recording_init().
> 
> Since this problem is not easy to figure out please include the above
> explanation in the changelog.

OK.
>>
>> It seems that the code can't support concurrent multiple different
>> arm_spe_x events currently. So add the code to check and record the
>> found 'arm_spe_pmu' to fix this issue.
>>
>> In fact, we don't support concurrent multiple same arm_spe_x events either,
>> that is checked in arm_spe_recording_options(), and it will show the
>> relevant info.
>>
>> Fixes: ffd3d18c20b8d ("perf tools: Add ARM Statistical Profiling Extensions (SPE) support")
>> Signed-off-by: Wei Li <liwei391@huawei.com>
>> ---
>>  tools/perf/arch/arm/util/auxtrace.c | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util/auxtrace.c
>> index 62b7b03d691a..7bb6f29e766c 100644
>> --- a/tools/perf/arch/arm/util/auxtrace.c
>> +++ b/tools/perf/arch/arm/util/auxtrace.c
>> @@ -58,6 +58,7 @@ struct auxtrace_record
>>  	bool found_etm = false;
>>  	bool found_spe = false;
>>  	static struct perf_pmu **arm_spe_pmus;
>> +	static struct perf_pmu *arm_spe_pmu;
> 
> As far as I can tell the "static" doesn't do anything.
> 
I will remove that in v2.
>>  	static int nr_spes = 0;
>>  	int i = 0;
>>  
>> @@ -77,6 +78,13 @@ struct auxtrace_record
>>  
>>  		for (i = 0; i < nr_spes; i++) {
>>  			if (evsel->core.attr.type == arm_spe_pmus[i]->type) {
>> +				if (found_spe && (arm_spe_pmu != arm_spe_pmus[i])) {
>> +					pr_err("Concurrent multiple SPE operation not currently supported\n");
>> +					*err = -EOPNOTSUPP;
>> +					return NULL;
>> +				}
> 
> Instead of the above, which as you rightly pointed out, is also done in
> arm_spe_recording_options() it might be best to just fix the "if (!nr_spes)"
> condition:
>                 if (!nr_spes || arm_spe_pmu)
>                         continue

This is more brief, i will use 'found_spe' as 'arm_spe_pmu' is not initialized.
> Furthermore, instead of having a new arm_spe_pmu variable you could simply make
> found_spe a struct perf_pmu.  That would be one less variable to take care of.
> 
>> +
>> +				arm_spe_pmu = arm_spe_pmus[i];
>>  				found_spe = true;
> 
> Last but not least do you know where the memory allocated for array arm_spe_pmus
> is released?  If you can't find it either then we have a memory leak and it
> would be nice to have that fixed.
Yes, we have a memory leak here indeed, i forgot to free it in this function.
As 'arm_spe_pmus' is defined as static, i think the author meant to assign it only at the first call,
but this function is only called once when we executing 'record', should i go on fixing it
or just drop the patch 1?

> Regards
> Mathieu
> 
> PS: Leo Yan has spent a fair amount of time in the SPE code - please CC him on
> your next revision.
> 
Thanks,
Wei
