Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C24C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 07:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4744220809
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 07:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgG2HnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 03:43:02 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59948 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726299AbgG2HnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 03:43:01 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7C583CB271A10AF009FB;
        Wed, 29 Jul 2020 15:42:57 +0800 (CST)
Received: from [10.174.178.63] (10.174.178.63) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Wed, 29 Jul 2020 15:42:46 +0800
Subject: Re: [PATCH 2/4] perf: arm-spe: Add support for ARMv8.3-SPE
To:     Leo Yan <leo.yan@linaro.org>
CC:     Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Clark <james.clark@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>, <zhangshaokun@hisilicon.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        "Peter Zijlstra" <peterz@infradead.org>, <guohanjun@huawei.com>
References: <20200724091607.41903-1-liwei391@huawei.com>
 <20200724091607.41903-3-liwei391@huawei.com>
 <20200729062951.GE4343@leoy-ThinkPad-X240s>
 <a8f9df67-adf1-09e7-b117-ff4163cc2a03@huawei.com>
 <20200729072844.GH4343@leoy-ThinkPad-X240s>
From:   "liwei (GF)" <liwei391@huawei.com>
Message-ID: <beabfb2a-e9ec-fe8e-a6ae-a7d4935a421e@huawei.com>
Date:   Wed, 29 Jul 2020 15:42:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <20200729072844.GH4343@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.63]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

On 2020/7/29 15:28, Leo Yan wrote:
> On Wed, Jul 29, 2020 at 03:21:20PM +0800, liwei (GF) wrote:
> 
> [...]
> 
>>>> @@ -354,8 +372,38 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
>>>>  	}
>>>>  	case ARM_SPE_OP_TYPE:
>>>>  		switch (idx) {
>>>> -		case 0:	return snprintf(buf, buf_len, "%s", payload & 0x1 ?
>>>> -					"COND-SELECT" : "INSN-OTHER");
>>>> +		case 0:	{
>>>> +			if (payload & 0x8) {
>>>
>>> Some nitpicks for packet format checking ...
>>>
>>> For SVE operation, the payload partten is: 0b0xxx1xx0.
>>>
>>> So it's good to check the partten like:
>>>
>>>   /* SVE operation subclass is: 0b0xxx1xx0 */
>>>   if ((payload & 0x8081) == 0x80) {
>>>      ....
>>>   }
>>>
>>> If later the packet format is extended, this will not introduce any
>>> confliction.
>>
>> Get it, but i think what you are really meaning is:
>> if ((payload & 0x89) == 0x80) {
>> 	...
>> }
> 
> Yes.
> 
>>>
>>>> +				size_t blen = buf_len;
>>>> +
>>>> +				ret = snprintf(buf, buf_len, "SVE-OTHER");
>>>> +				buf += ret;
>>>> +				blen -= ret;
>>>> +				if (payload & 0x2) {
>>>
>>> Here should express as binary results: " FP" or " INT".
>>
>> I think this is a style choice, i add these just like the current code where
>> processing "AT", "EXCL", "AR", "COND" and so on. So should we modify all the corresponding code together?
> 
> Okay, understood.  Let's just follow the existed style and later can
> enhance the output log with more readable format.
> 
> [...]
> 
>>>
>>>> +					ret = snprintf(buf, buf_len, " FP");
>>>> +					buf += ret;
>>>> +					blen -= ret;
>>>> +				}
>>>> +				if (payload & 0x4) {
>>>> +					ret = snprintf(buf, buf_len, " PRED");
>>>
>>> Here should express as binary results: " PRED" or " NOT-PRED".
>>
>> Ditto.
>>
>>>
>>>> +					buf += ret;
>>>> +					blen -= ret;
>>>> +				}
>>>> +				if (payload & 0x70) {
>>>
>>> This is incorrect.  If bits[6:4] is zero, it presents vector length is 32 bits.
>>>
>>
>> I am a little confused here.
>> Refer to the ARM DDI 0487F.b (ID040120), page D10-2830, if bits[6:4] is zero,
>> it presents vector length is 32 bits indeed.
> 
> Yes, if bits[6:4] is zero, your current code will not output any info.
> 

Yes, thanks for spotting this.
And thanks for you review.


Thanks,
Wei
