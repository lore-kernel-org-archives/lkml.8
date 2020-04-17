Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE51C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 16:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7E9E2072D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 16:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729891AbgDQQOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 12:14:41 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2058 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728105AbgDQQOk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 12:14:40 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 770A64AD4C372DC997F5;
        Fri, 17 Apr 2020 17:14:38 +0100 (IST)
Received: from [127.0.0.1] (10.210.172.89) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 17 Apr
 2020 17:14:36 +0100
Subject: Re: [RFC PATCH v2 05/13] perf vendor events arm64: Add Architected
 events smmuv3-pmcg.json
To:     Ian Rogers <irogers@google.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, <will@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, <linuxarm@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, <qiangqing.zhang@nxp.com>,
        <robin.murphy@arm.com>, <zhangshaokun@hisilicon.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <1587120084-18990-1-git-send-email-john.garry@huawei.com>
 <1587120084-18990-6-git-send-email-john.garry@huawei.com>
 <CAP-5=fX0yt73ASQm-XD0Nqj8yNn=UhiaBr9T808ot=66SjSg6w@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <9f5cafde-5aed-b626-5397-2ebed357dd8b@huawei.com>
Date:   Fri, 17 Apr 2020 17:14:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <CAP-5=fX0yt73ASQm-XD0Nqj8yNn=UhiaBr9T808ot=66SjSg6w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.172.89]
X-ClientProxiedBy: lhreml735-chm.china.huawei.com (10.201.108.86) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/04/2020 16:13, Ian Rogers wrote:
>> +        "PublicDescription": "TLB miss caused by incomingtransaction or (ATS or non-ATS) translation request",
> It looks like a space was missed in "incomingtransaction".
> 
>> +        "EventCode": "0x02",
>> +        "EventName": "smmuv3_pmcg.TLB_MISS",
>> +        "BriefDescription": "TLB miss caused by incomingtransaction or (ATS or non-ATS) translation request"
> And here.

Right, a copy-and-paste formatting error.

Cheers,
john

> 
> Thanks,
> Ian
> 
>> +

