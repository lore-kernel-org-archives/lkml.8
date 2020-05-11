Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D84C38A2A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 01:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 380D220820
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 01:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbgEKBM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 21:12:28 -0400
Received: from mga06.intel.com ([134.134.136.31]:50983 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729170AbgEKBM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 21:12:28 -0400
IronPort-SDR: MXqgh1SOygL1dH5y5eVgbBOt+t4PY4CbFlR2cc4XfDRIl2lQwhtHff2yY3iVdEmEJ+7x3ZpJ8N
 UXDEpOlIp6AA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2020 18:12:27 -0700
IronPort-SDR: QrCd2RVzdCPcB2hu/mzT9yy2KlVmHHXNVVA7NitcCktSi8BwHOayfmeVvwoeXxhPnxPCVvT8d4
 tLZNr0oFFMJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,377,1583222400"; 
   d="scan'208";a="371061652"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.5.239]) ([10.238.5.239])
  by fmsmga001.fm.intel.com with ESMTP; 10 May 2020 18:12:24 -0700
Subject: Re: [RFC] Issue in final aggregate value, in case of multiple events
 present in metric expression
To:     kajoljain <kjain@linux.ibm.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        "acme@kernel.org" <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Andi Kleen <ak@linux.intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20200212054102.9259-1-kjain@linux.ibm.com>
 <DB7PR04MB46186AB5557F4D04FD5C4FEAE6160@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <be86ba99-ab5a-c845-46b6-8081edee00ca@linux.ibm.com>
 <DB7PR04MB461807389FDF9629ACA04533E6130@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <cb9b353b-c18a-0064-eb72-a6c91d5fdec9@linux.ibm.com>
 <DB7PR04MB4618D0696D39AC5D44FF5A51E6F50@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <6f98d281-f3de-b547-70d4-8fc95515b12f@linux.ibm.com>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <ea7e21e3-b324-3286-bcaa-cd37a4036c95@linux.intel.com>
Date:   Mon, 11 May 2020 09:12:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <6f98d281-f3de-b547-70d4-8fc95515b12f@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kajol,

On 3/24/2020 4:00 PM, kajoljain wrote:
> Hello All,
> 	I want to discuss one issue raised by Joakim Zhang where he mentioned
> that, we are not getting correct result in-case of multiple events present in metric
> expression.
> 
> This is one example pointed by him :
> 
> below is the JSON file and result.
> [
>          {
>               "PublicDescription": "Calculate DDR0 bus actual utilization which vary from DDR0 controller clock frequency",
>               "BriefDescription": "imx8qm: ddr0 bus actual utilization",
>               "MetricName": "imx8qm-ddr0-bus-util",
>               "MetricExpr": "( imx8_ddr0\\/read\\-cycles\\/ + imx8_ddr0\\/write\\-cycles\\/ )",
>               "MetricGroup": "i.MX8QM_DDR0_BUS_UTIL"
>          }
> ]
> ./perf stat -I 1000 -M imx8qm-ddr0-bus-util
> #           time             counts unit events
>       1.000104250              16720      imx8_ddr0/read-cycles/    #  22921.0 imx8qm-ddr0-bus-util
>       1.000104250               6201      imx8_ddr0/write-cycles/
>       2.000525625               8316      imx8_ddr0/read-cycles/    #  12785.5 imx8qm-ddr0-bus-util
>       2.000525625               2738      imx8_ddr0/write-cycles/
>       3.000819125               1056      imx8_ddr0/read-cycles/    #   4136.7 imx8qm-ddr0-bus-util
>       3.000819125                303      imx8_ddr0/write-cycles/
>       4.001103750               6260      imx8_ddr0/read-cycles/    #   9149.8 imx8qm-ddr0-bus-util
>       4.001103750               2317      imx8_ddr0/write-cycles/
>       5.001392750               2084      imx8_ddr0/read-cycles/    #   4516.0 imx8qm-ddr0-bus-util
>       5.001392750                601      imx8_ddr0/write-cycles/
> 
> Based on given metric expression, the sum coming correct for first iteration while for
> rest, we won't see same addition result. But in-case we have single event in metric
> expression, we are getting correct result as expected.
> 
> 
> So, I try to look into this issue and understand the flow. From my understanding, whenever we do
> calculation of metric expression we don't use exact count we are getting.
> Basically we use mean value of each metric event in the calculation of metric expression.
> 
> So, I take same example:
> 
> Metric Event: imx8qm-ddr0-bus-util
> MetricExpr": "( imx8_ddr0\\/read\\-cycles\\/ + imx8_ddr0\\/write\\-cycles\\/ )"
> 
> command#: ./perf stat -I 1000 -M imx8qm-ddr0-bus-util
> 
> #           time             counts unit events
>       1.000104250              16720      imx8_ddr0/read-cycles/    #  22921.0 imx8qm-ddr0-bus-util
>       1.000104250               6201      imx8_ddr0/write-cycles/
>       2.000525625               8316      imx8_ddr0/read-cycles/    #  12785.5 imx8qm-ddr0-bus-util
>       2.000525625               2738      imx8_ddr0/write-cycles/
>       3.000819125               1056      imx8_ddr0/read-cycles/    #   4136.7 imx8qm-ddr0-bus-util
>       3.000819125                303      imx8_ddr0/write-cycles/
>       4.001103750               6260      imx8_ddr0/read-cycles/    #   9149.8 imx8qm-ddr0-bus-util
>       4.001103750               2317      imx8_ddr0/write-cycles/
>       5.001392750               2084      imx8_ddr0/read-cycles/    #   4516.0 imx8qm-ddr0-bus-util
>       5.001392750                601      imx8_ddr0/write-cycles/
> 
> So, there is one function called 'update_stats' in file util/stat.c where we do this calculation
> and updating stats->mean value. And this mean value is what we are actually using in our
> metric expression calculation.
> 
> We call this function in each iteration where we update stats->mean and stats->n for each event.
> But one weird issue is, for very first event, stat->n is always 1 that is why we are getting
> mean same as count.
> 
> So this the reason why for single event we get exact aggregate of metric expression.
> So doesn't matter how many events you have in your metric expression, every time
> you take exact count for first one and normalized value for rest which is weird.
> 
> According to update_stats function:  We are updating mean as:
> 
> stats->mean += delta / stats->n where,  delta = val - stats->mean.
> 
> If we take write-cycles here. Initially mean = 0 and n = 1.
> 
> 1st iteration: n=1, write cycle : 6201 and mean = 6201  (Final agg value: 16720 + 6201 = 22921)
> 2nd iteration: n=2, write cycles:  6201 + (2738 - 6201)/2 =  4469.5  (Final aggr value: 8316 + 4469.5 = 12785.5)
> 3rd iteration: n=3, write cycles: 4469.5 + (303 - 4469.5)/3 = 3080.6667 (Final aggr value: 1056 + 3080.6667 = 4136.7)
> 
> I am not sure if its expected behavior. I mean shouldn't we either take mean value of each event
> or take n as 1 for each event.
> 
> 
> I am thinking, Should we add an option to say whether user want exact aggregate or
> this normalize aggregate to remove the confusion? I try to find it out if we already have one but didn't get.
> Please let me know if my understanding is fine. Or something I can add to resolve this issue.
> 
> Thanks,
> Kajol
> 

Since you use the interval mode, can this commit fix the issue?

http://lore.kernel.org/lkml/20200420145417.6864-1-yao.jin@linux.intel.com

Thanks
Jin Yao
