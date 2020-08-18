Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B0AC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 03:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33EE2206DA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 03:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgHRDp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 23:45:29 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:44332 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726302AbgHRDp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 23:45:28 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 39F24E96411B170DCDAF;
        Tue, 18 Aug 2020 11:45:16 +0800 (CST)
Received: from [10.174.178.63] (10.174.178.63) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Tue, 18 Aug 2020 11:45:07 +0800
Subject: Re: [PATCH] perf: arm-spe: Fix check error when synthesizing events
To:     Leo Yan <leo.yan@linaro.org>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, <guohanjun@huawei.com>
References: <20200724072628.35904-1-liwei391@huawei.com>
 <20200724083218.GA5185@leoy-ThinkPad-X240s>
From:   "liwei (GF)" <liwei391@huawei.com>
Message-ID: <5e77ab6d-eccf-d7fa-bafa-d2077c949dc4@huawei.com>
Date:   Tue, 18 Aug 2020 11:45:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <20200724083218.GA5185@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.63]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping...

On 2020/7/24 16:32, Leo Yan wrote:
> Hi Wei,
> 
> On Fri, Jul 24, 2020 at 03:26:28PM +0800, Wei Li wrote:
>> In arm_spe_read_record(), when we are processing an events packet,
>> 'decoder->packet.index' is the length of payload, which has been
>> transformed in payloadlen(). So correct the check of 'idx'.
>>
>> Signed-off-by: Wei Li <liwei391@huawei.com>
> 
> Good catch.  I checked the ARMv8 ARM and the function payloadlen(),
> can confirm the fixing is correct.
> 
> Reviewed-by: Leo Yan <leo.yan@linaro.org>
> 
>> ---
>>  tools/perf/util/arm-spe-decoder/arm-spe-decoder.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
>> index 302a14d0aca9..93e063f22be5 100644
>> --- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
>> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
>> @@ -182,15 +182,15 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
>>  			if (payload & BIT(EV_TLB_ACCESS))
>>  				decoder->record.type |= ARM_SPE_TLB_ACCESS;
>>  
>> -			if ((idx == 1 || idx == 2 || idx == 3) &&
>> +			if ((idx == 2 || idx == 4 || idx == 8) &&
>>  			    (payload & BIT(EV_LLC_MISS)))
>>  				decoder->record.type |= ARM_SPE_LLC_MISS;
>>  
>> -			if ((idx == 1 || idx == 2 || idx == 3) &&
>> +			if ((idx == 2 || idx == 4 || idx == 8) &&
>>  			    (payload & BIT(EV_LLC_ACCESS)))
>>  				decoder->record.type |= ARM_SPE_LLC_ACCESS;
>>  
>> -			if ((idx == 1 || idx == 2 || idx == 3) &&
>> +			if ((idx == 2 || idx == 4 || idx == 8) &&
>>  			    (payload & BIT(EV_REMOTE_ACCESS)))
>>  				decoder->record.type |= ARM_SPE_REMOTE_ACCESS;
>>  
>> -- 
>> 2.17.1
>>
