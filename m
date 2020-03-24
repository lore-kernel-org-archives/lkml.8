Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283A5C4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 07:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1F922076A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 07:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbgCXHNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 03:13:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23944 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725905AbgCXHNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 03:13:52 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02O73tpT095384;
        Tue, 24 Mar 2020 03:13:41 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ywbuv2b88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Mar 2020 03:13:41 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 02O75stb017615;
        Tue, 24 Mar 2020 07:13:40 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma02dal.us.ibm.com with ESMTP id 2ywaw1v8p0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Mar 2020 07:13:40 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02O7Dc9O38011136
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Mar 2020 07:13:38 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D59AF13604F;
        Tue, 24 Mar 2020 07:13:38 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D884136051;
        Tue, 24 Mar 2020 07:13:34 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.58.144])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 24 Mar 2020 07:13:34 +0000 (GMT)
Subject: Re: [PATCH v4] tools/perf/metricgroup: Fix printing event names of
 metric group with multiple events incase of overlapping events
To:     Joakim Zhang <qiangqing.zhang@nxp.com>,
        "acme@kernel.org" <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Andi Kleen <ak@linux.intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20200212054102.9259-1-kjain@linux.ibm.com>
 <DB7PR04MB46186AB5557F4D04FD5C4FEAE6160@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <be86ba99-ab5a-c845-46b6-8081edee00ca@linux.ibm.com>
 <DB7PR04MB461807389FDF9629ACA04533E6130@DB7PR04MB4618.eurprd04.prod.outlook.com>
 <cb9b353b-c18a-0064-eb72-a6c91d5fdec9@linux.ibm.com>
 <DB7PR04MB4618D0696D39AC5D44FF5A51E6F50@DB7PR04MB4618.eurprd04.prod.outlook.com>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <648e08fb-ffd2-16f6-005d-527ac3fee6c0@linux.ibm.com>
Date:   Tue, 24 Mar 2020 12:43:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <DB7PR04MB4618D0696D39AC5D44FF5A51E6F50@DB7PR04MB4618.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-24_01:2020-03-23,2020-03-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 impostorscore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003240032
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/20/20 12:17 PM, Joakim Zhang wrote:
> 
> [...]
>>>>> Hi Kajol,
>>>>>
>>>>> I am not sure if it is good to ask a question here :-)
>>>>>
>>>>> I encountered a perf metricgroup issue, the result is incorrect when
>>>>> the
>>>> metric includes more than 2 events.
>>>>>
>>>>> git log --oneline tools/perf/util/metricgroup.c
>>>>> 3635b27cc058 perf metricgroup: Fix printing event names of metric
>>>>> group with multiple events f01642e4912b perf metricgroup: Support
>>>>> multiple events for metricgroup
>>>>> 287f2649f791 perf metricgroup: Scale the metric result
>>>>>
>>>>> I did a simple test, below is the JSON file and result.
>>>>> [
>>>>>         {
>>>>>              "PublicDescription": "Calculate DDR0 bus actual
>>>>> utilization
>>>> which vary from DDR0 controller clock frequency",
>>>>>              "BriefDescription": "imx8qm: ddr0 bus actual utilization",
>>>>>              "MetricName": "imx8qm-ddr0-bus-util",
>>>>>              "MetricExpr": "( imx8_ddr0\\/read\\-cycles\\/ +
>>>> imx8_ddr0\\/write\\-cycles\\/ )",
>>>>>              "MetricGroup": "i.MX8QM_DDR0_BUS_UTIL"
>>>>>         }
>>>>> ]
>>>>> ./perf stat -I 1000 -M imx8qm-ddr0-bus-util
>>>>> #           time             counts unit events
>>>>>      1.000104250              16720      imx8_ddr0/read-cycles/
>>>> #  22921.0 imx8qm-ddr0-bus-util
>>>>>      1.000104250               6201
>> imx8_ddr0/write-cycles/
>>>>>      2.000525625               8316      imx8_ddr0/read-cycles/
>>>> #  12785.5 imx8qm-ddr0-bus-util
>>>>>      2.000525625               2738
>> imx8_ddr0/write-cycles/
>>>>>      3.000819125               1056      imx8_ddr0/read-cycles/
>>>> #   4136.7 imx8qm-ddr0-bus-util
>>>>>      3.000819125                303
>> imx8_ddr0/write-cycles/
>>>>>      4.001103750               6260      imx8_ddr0/read-cycles/
>>>> #   9149.8 imx8qm-ddr0-bus-util
>>>>>      4.001103750               2317
>> imx8_ddr0/write-cycles/
>>>>>      5.001392750               2084      imx8_ddr0/read-cycles/
>>>> #   4516.0 imx8qm-ddr0-bus-util
>>>>>      5.001392750                601
>> imx8_ddr0/write-cycles/
>>>>>
>>>>> You can see that only the first result is correct, could this be
>>>>> reproduced at
>>>> you side?
>>>>
>>>> Hi Joakim,
>>>>         Will try to look into it from my side.
>>>
>>
>>> Thanks Kajol for your help, I look into this issue, but don't know how to fix it.
>>>
>>> The results are always correct if signal event used in "MetricExpr" with "-I"
>> parameters, but the results are incorrect when more than one events used in
>> "MetricExpr".
>>>
>>
>> Hi Joakim,
>>     So, I try to look into this issue and understand the flow. From my
>> understanding, whenever we do
>>     calculation of metric expression we don't use exact count we are getting.
>>     Basically we use mean value of each event in the calculation of metric
>> expression.
>>
>> So, I am taking same example you refer.
>>
>> Metric Event: imx8qm-ddr0-bus-util
>> MetricExpr": "( imx8_ddr0\\/read\\-cycles\\/ + imx8_ddr0\\/write\\-cycles\\/ )"
>>
>> command#: ./perf stat -I 1000 -M imx8qm-ddr0-bus-util
>>
>> #           time             counts unit events
>>      1.000104250              16720      imx8_ddr0/read-cycles/
>> #  22921.0 imx8qm-ddr0-bus-util
>>      1.000104250               6201      imx8_ddr0/write-cycles/
>>      2.000525625               8316      imx8_ddr0/read-cycles/
>> #  12785.5 imx8qm-ddr0-bus-util
>>      2.000525625               2738      imx8_ddr0/write-cycles/
>>      3.000819125               1056      imx8_ddr0/read-cycles/
>> #   4136.7 imx8qm-ddr0-bus-util
>>      3.000819125                303      imx8_ddr0/write-cycles/
>>      4.001103750               6260      imx8_ddr0/read-cycles/
>> #   9149.8 imx8qm-ddr0-bus-util
>>      4.001103750               2317      imx8_ddr0/write-cycles/
>>      5.001392750               2084      imx8_ddr0/read-cycles/
>> #   4516.0 imx8qm-ddr0-bus-util
>>      5.001392750                601      imx8_ddr0/write-cycles/
>>
>> If you see we have a function called 'update_stats' in file util/stat.c where we
>> do this calculation and updating stats->mean value. And this mean value is
>> what we are using actually in our metric expression calculation.
>>
>> We call this function in each iteration where we update stats->mean and
>> stats->n for each event.
>> But one weird issue is, for very first event, stat->n is always 1 that is why we
>> are getting mean same as count.
>> So this is the reason for single event you get exact aggregate of metric
>> expression.
>> So doesn't matter how many events you have in your metric expression, every
>> time you take exact count for first one and normalized value for rest which is
>> weird.
>>
>> According to update_stats function:  We are updating mean as:
>>
>> stats->mean += delta / stats->n where,  delta = val - stats->mean.
>>
>> If we take write-cycles here. Initially mean = 0 and n = 1.
>>
>> 1st iteration: n=1, write cycle : 6201 and mean = 6201  (Final agg value: 16720
>> + 6201 = 22921) 2nd iteration: n=2, write cycles:  6201 + (2738 - 6201)/2 =
>> 4469.5  (Final aggr value: 8316 + 4469.5 = 12785.5) 3rd iteration: n=3, write
>> cycles: 4469.5 + (303 - 4469.5)/3 = 3080.6667 (Final aggr value: 1056 +
>> 3080.6667 = 4136.7)
>>
>> Andi and Jiri, I am not sure if its expected behavior. I mean shouldn't we either
>> take mean value of each event or take n as 1 for each event. And one more
>> question, Should we add an option to say whether user want exact aggregate
>> or this normalize aggregate to remove the confusion? I try to find it out if we
>> already have one but didn't get.
>> Please let me know if my understanding is fine.
> 
> Hi Kajol,
> 
> Sorry, your reply was buried in a sea of emails, it comes into my eyes when I searched any feedback from you. Much thanks for your great details!!!!!
> 
> I can quite understand what you explained. As a user, I think we always want to get the exact result according to the metric expression.
> 
> Can you take this case as an example then send out a formal email into mailing list to reflect this weird issue, more people can participate and discuss about it. Or you need me clear up and sent out the email?
> This could attract maintainers' attention.
> 

Hi Joakim,
    Yes you are right, I will send separate mail on lkml. That way it will be better.

Thanks,
Kajol

> Best Regards,
> Joakim Zhang
> 
