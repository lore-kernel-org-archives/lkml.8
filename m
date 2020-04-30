Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE5BC4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 17:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8ABF20870
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 17:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgD3RyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 13:54:15 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2137 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726285AbgD3RyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 13:54:14 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 67AC53A5A62927E3F39B;
        Thu, 30 Apr 2020 18:54:12 +0100 (IST)
Received: from [127.0.0.1] (10.47.0.178) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 30 Apr
 2020 18:54:10 +0100
Subject: Re: [PATCH v3 12/12] perf test: improve pmu event metric testing
To:     Ian Rogers <irogers@google.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Haiyan Song <haiyanx.song@intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Clarke <pc@us.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kajoljain <kjain@linux.ibm.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
References: <20200430075144.132716-1-irogers@google.com>
 <20200430075144.132716-13-irogers@google.com>
 <6a3d68fd-c489-c0d5-8612-69f15be1bf64@huawei.com>
 <CAP-5=fUA3UDNdreJBhdLBPgyFUutN_qUqaL-Diu3yihSDc_niw@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <49698917-cdc0-52d5-9c08-ba82f8438657@huawei.com>
Date:   Thu, 30 Apr 2020 18:53:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <CAP-5=fUA3UDNdreJBhdLBPgyFUutN_qUqaL-Diu3yihSDc_niw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.0.178]
X-ClientProxiedBy: lhreml731-chm.china.huawei.com (10.201.108.82) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/04/2020 15:31, Ian Rogers wrote:
> On Thu, Apr 30, 2020 at 4:44 AM John Garry <john.garry@huawei.com> wrote:
>>
>> On 30/04/2020 08:51, Ian Rogers wrote:
>>> Add a basic floating point number test to expr.
>>> Break pmu-events test into 2 and add a test to verify that all pmu metric
>>> expressions simply parse.
>>
>> Could we add also add something in jevents to ensure this?
> 
> I think it is an interesting possibility. Instead of strings we could
> also parse the metrics into C functions, that could cause build time
> errors at least for the simple expressions. An issue I've faced is
> that if jevents fails, such as a json parse error, it has an exit code
> of 0 and creates an empty map file. This allows the build to proceed
> but with the pmu-events functionality broken. I'd prefer a build to
> fail as early as possible.

Yeah, the idea is to allow perf to continue to build even when we have 
broken JSONs, but without aliases. It's been that way since day one, so 
maybe that can be turned off now.

Thanks,
John
