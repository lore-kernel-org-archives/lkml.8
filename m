Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6438C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 09:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94B6620739
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 09:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgCTJYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 05:24:46 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2581 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726602AbgCTJYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 05:24:46 -0400
Received: from lhreml707-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id E4CC1AD2BC13204D257A;
        Fri, 20 Mar 2020 09:24:43 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml707-cah.china.huawei.com (10.201.108.48) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 20 Mar 2020 09:24:43 +0000
Received: from [127.0.0.1] (10.210.167.248) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5; Fri, 20 Mar
 2020 09:24:38 +0000
Subject: Re: [PATCH v2 7/7] perf test: Test pmu-events aliases
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <namhyung@kernel.org>,
        <will@kernel.org>, <ak@linux.intel.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <james.clark@arm.com>,
        <qiangqing.zhang@nxp.com>
References: <1584442939-8911-1-git-send-email-john.garry@huawei.com>
 <1584442939-8911-8-git-send-email-john.garry@huawei.com>
 <20200317162043.GC759708@krava>
 <01dd565b-931c-e853-a721-aa995f87469c@huawei.com>
 <20200317170730.GF759708@krava> <20200319183622.GD14841@kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <c00876b9-99bb-9272-6602-98806808cac3@huawei.com>
Date:   Fri, 20 Mar 2020 09:24:19 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200319183622.GD14841@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.167.248]
X-ClientProxiedBy: lhreml704-chm.china.huawei.com (10.201.108.53) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/03/2020 18:36, Arnaldo Carvalho de Melo wrote:
> Em Tue, Mar 17, 2020 at 06:07:30PM +0100, Jiri Olsa escreveu:
>> On Tue, Mar 17, 2020 at 04:41:04PM +0000, John Garry wrote:
>>> On 17/03/2020 16:20, Jiri Olsa wrote:
>>>> On Tue, Mar 17, 2020 at 07:02:19PM +0800, John Garry wrote:
>>>>> @@ -36,6 +51,8 @@ static struct perf_pmu_test_event test_cpu_events[] = {
>>>>>    			.desc = "Number of segment register loads",
>>>>>    			.topic = "other",
>>>>>    		},
>>>>> +		.alias_str = "umask=0x80,(null)=0x30d40,event=0x6",
> 
>>>> ah so we are using other pmus because of the format definitions
> 
>>>> why is there the '(null)' in there?
> 
>>> Well this is just coming from the generated alias string in the pmu code,
>>> and it does not seem to be handling "period" argument properly. It needs to
>>> be checked.
>   
>> nice, it found first issue already ;-)

thanks

> 
> Applied the series to perf/core, good job! What about the fix for the
> above (null) problem?

So I had started to look at that, but then the codepath lead into the 
lex parsing, which I am not familiar with.

So from when we parse the event terms in parse_events_terms(), we get 3x 
terms:
config=umask, then newval=umask=0x80
confg=(null), then newval=umask=0x80,(null)=x030d40
config=event, then newval=umask=0x80,(null)=x030d40,event=0x6

I can continue to look. Maybe jirka has an idea on this and what happens 
in the lex parsing.

Cheers,
John
