Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABA8C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 15:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C16820733
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 15:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbgBJPrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 10:47:11 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2402 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726991AbgBJPrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 10:47:11 -0500
Received: from LHREML712-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id DFD6BDD31CA7FEDB42FA;
        Mon, 10 Feb 2020 15:47:09 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML712-CAH.china.huawei.com (10.201.108.35) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 10 Feb 2020 15:47:10 +0000
Received: from [127.0.0.1] (10.202.226.45) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 10 Feb
 2020 15:47:09 +0000
Subject: Re: [PATCH RFC 1/7] perf jevents: Add support for an extra directory
 level
To:     Jiri Olsa <jolsa@redhat.com>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <namhyung@kernel.org>, <will@kernel.org>, <ak@linux.intel.com>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <suzuki.poulose@arm.com>,
        <james.clark@arm.com>, <zhangshaokun@hisilicon.com>,
        <robin.murphy@arm.com>
References: <1579876505-113251-1-git-send-email-john.garry@huawei.com>
 <1579876505-113251-2-git-send-email-john.garry@huawei.com>
 <20200210120727.GD1907700@krava>
From:   John Garry <john.garry@huawei.com>
Message-ID: <8bf65f0c-d4cf-8c69-15b3-961ce4f3cd2f@huawei.com>
Date:   Mon, 10 Feb 2020 15:47:08 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200210120727.GD1907700@krava>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.45]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/2020 12:07, Jiri Olsa wrote:
> On Fri, Jan 24, 2020 at 10:34:59PM +0800, John Garry wrote:
>> Currently we support upto a level 2 directory, and level 2 would be in the
>> form vendor/platform.
>>
>> Add support for a further level, to hold specific categories of events for
>> when we want to segregate them for matching purposes.
>>
>> Signed-off-by: John Garry <john.garry@huawei.com>
>> ---
>>   tools/perf/pmu-events/jevents.c | 11 ++++++++---
>>   1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
>> index 079c77b6a2fd..8af05b94a37d 100644
>> --- a/tools/perf/pmu-events/jevents.c
>> +++ b/tools/perf/pmu-events/jevents.c
>> @@ -960,15 +960,20 @@ static int process_one_file(const char *fpath, const struct stat *sb,
>>   	int level   = ftwbuf->level;
>>   	int err = 0;
>>   
>> -	if (level == 2 && is_dir) {
>> +	if (level >= 2 && is_dir) {
>> +		int count = 0;
>>   		/*
>>   		 * For level 2 directory, bname will include parent name,
>>   		 * like vendor/platform. So search back from platform dir
>>   		 * to find this.
>> +		 * Something similar for level 3 directory, but we're a PMU
>> +		 * category folder, like vendor/platform/cpu.
>>   		 */
>>   		bname = (char *) fpath + ftwbuf->base - 2;
>>   		for (;;) {
>>   			if (*bname == '/')
>> +				count++;
>> +			if (count == level - 1)
>>   				break;
>>   			bname--;
> 

Hi Jirka,

> I was wondering why we just don't use different filename for that,
> but it's true that the code transforms directory chain to the table
> name.. so I guess another directory level is justified ;-)

Yes, and we need to have separate tables for system and CPU/uncore PMU 
aliases.

Thanks,
John

> 
> jirka
> 
> 
>>   		}
>> @@ -981,13 +986,13 @@ static int process_one_file(const char *fpath, const struct stat *sb,
>>   		 level, sb->st_size, bname, fpath);
>>   
>>   	/* base dir or too deep */
>> -	if (level == 0 || level > 3)
>> +	if (level == 0 || level > 4)
>>   		return 0;
>>   
>>   
>>   	/* model directory, reset topic */
>>   	if ((level == 1 && is_dir && is_leaf_dir(fpath)) ||
>> -	    (level == 2 && is_dir)) {
>> +	    (level >= 2 && is_dir && is_leaf_dir(fpath))) {
>>   		if (close_table)
>>   			print_events_table_suffix(eventsfp);
>>   
>> -- 
>> 2.17.1
>>
> 
> .
> 

