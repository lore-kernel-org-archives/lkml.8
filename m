Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE72C433E6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 07:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D4A42072A
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 07:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgIBH1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 03:27:49 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2733 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726528AbgIBH1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 03:27:43 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 7ACF0C3A901EC844D857;
        Wed,  2 Sep 2020 08:27:41 +0100 (IST)
Received: from [127.0.0.1] (10.47.4.206) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 2 Sep 2020
 08:27:40 +0100
Subject: Re: [PATCH v6 1/5] perf/jevents: Remove jevents.h file
To:     kajoljain <kjain@linux.ibm.com>, Jiri Olsa <jolsa@redhat.com>
CC:     <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <pc@us.ibm.com>, <namhyung@kernel.org>, <ak@linux.intel.com>,
        <yao.jin@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>, <irogers@google.com>,
        <maddy@linux.ibm.com>, <ravi.bangoria@linux.ibm.com>
References: <20200827130958.189146-1-kjain@linux.ibm.com>
 <20200827130958.189146-2-kjain@linux.ibm.com> <20200831084348.GB287892@krava>
 <ca73d0ff-0dfa-8d9e-1cb8-5791a78eb4e2@huawei.com>
 <92f58d69-849a-5df4-6b24-87542138806d@linux.ibm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <6967c008-acda-6df4-799a-a657ec231476@huawei.com>
Date:   Wed, 2 Sep 2020 08:25:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <92f58d69-849a-5df4-6b24-87542138806d@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.4.206]
X-ClientProxiedBy: lhreml716-chm.china.huawei.com (10.201.108.67) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/09/2020 06:56, kajoljain wrote:
>>>> +#define min(x, y) ({                \
>>>> +    typeof(x) _min1 = (x);            \
>>>> +    typeof(y) _min2 = (y);            \
>>>> +    (void)(&_min1 == &_min2);        \
>>>> +    _min1 < _min2 ? _min1 : _min2; })
>>>> +#endif
>> Wondering what is special about this definition of min that it's required? Compiled ok for me without it.
> Hi John,
>       You are right, for me also in power it compiled without any issues, but not sure if somewhere we have dependency,
> that's why I didn't remove it.

If it builds for x86, then that's main thing ;) But seriously, Arnaldo 
has lots of bots to test builds also.

BTW, I got this from your patchset:

pmu-events/jevents.c:98:29: warning: no previous prototype for 
‘get_cpu_str’ [-Wmissing-prototypes]
__attribute__((weak)) char *get_cpu_str(void)
                             ^~~~~~~~~~~
pmu-events/jevents.c:529:5: warning: no previous prototype for 
‘json_events’ [-Wmissing-prototypes]
int json_events(const char *fn,
     ^~~~~~~~~~~

But I think that you will remove this.

Finally, generated pmu-events.c looks ok for arm64, which I am 
interested in.

Thanks,
John
