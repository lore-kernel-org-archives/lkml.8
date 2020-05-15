Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098DEC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 09:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD9BE205CB
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 09:10:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgEOJKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 05:10:09 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2211 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726922AbgEOJKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 05:10:08 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id DB2A597F4B563AF90316;
        Fri, 15 May 2020 10:10:06 +0100 (IST)
Received: from [127.0.0.1] (10.47.1.24) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Fri, 15 May
 2020 10:10:05 +0100
Subject: Re: [PATCH 2/2] perf test: Improve pmu event metric testing
To:     Ian Rogers <irogers@google.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Clarke <pc@us.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
References: <20200513062236.854-1-irogers@google.com>
 <20200513062236.854-2-irogers@google.com>
 <ac88604a-56c2-b632-57c2-3bee316dcea7@huawei.com>
 <CAP-5=fVkD+0wCMcBBHWM8djsnn2KsshOyK_XcjNDTsiVo04vwQ@mail.gmail.com>
 <5264e16c-fb1a-4bbc-96b5-1d867e38902e@huawei.com>
 <CAP-5=fWt58UVTTj_qvirMhMOaUbur+HzxrTi5u1qvCA1ft9BEw@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <799e8dde-6f56-7add-a177-3e21c0de03fc@huawei.com>
Date:   Fri, 15 May 2020 10:09:10 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <CAP-5=fWt58UVTTj_qvirMhMOaUbur+HzxrTi5u1qvCA1ft9BEw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.1.24]
X-ClientProxiedBy: lhreml709-chm.china.huawei.com (10.201.108.58) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/2020 00:02, Ian Rogers wrote:
> On Thu, May 14, 2020 at 2:00 AM John Garry <john.garry@huawei.com> wrote:
>>
>> On 13/05/2020 17:10, Ian Rogers wrote:
>>>> Out of interest, if we could move the validation of metrics to jevents,
>>>> how much functionality would we still have here?
>>> If we add checking to jevents then the MetricExpr would be known to be
>>> valid, however, the events (aka ids) within the expression could be
>>> invalid.
>>
>> So I think that has some value. I mean, just to detect syntax errors,
>> like those remedied in "perf metrics: fix parse errors in power8 metrics".
>>
>>> I'm not sure we could realistically check the events at
>>> jevents (build) time as there is no guarantee that the machine we run
>>> on is the same as the one we compile on.
>>
>> But we could at least check that there are event aliases for that CPU,
>> right? (by examining the JSONs for that cpu). If the event alias does
>> not actually match on the target CPU, then that can't be helped.
> 
> Agreed, I think there will be some cases where something more can be
> done. Jiri has proposed fake pmus as well:
> https://www.spinics.net/lists/linux-perf-users/msg11760.html
> I don't know how much sense it makes trying to get this in jevents, as
> long as 'perf test' is run.

At a glance, that does not look like something we would want in jevents. 
But rather the metric expr parsing error detection and alias checking.

About jirka's patch:

--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -485,6 +485,102 @@ static int test_parsing(void)
  	return ret == 0 ? TEST_OK : TEST_SKIP;
  }

+
+static struct test_metric metrics[] = {
+	{ .metric = "imx8_ddr0@read\\-cycles@ * 4 * 4", },
+	{ .metric = 
"imx8_ddr0@axid\\-read\\,axi_mask\\=0xffff\\,axi_id\\=0x0000@ * 4", },
+	{ .metric = "(cstate_pkg@c2\\-residency@ / msr@tsc@) * 100", },
+	{ .metric = "(imx8_ddr0@read\\-cycles@ + imx8_ddr0@write\\-cycles@)", },
+};

Maybe we could add these to pmu-events/arch/test/test_cpu/metric.json, 
and get at them that way.

Thanks,
John
