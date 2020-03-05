Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E80C3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 04:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 193ED2072D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 04:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbgCEErG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 23:47:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19256 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725830AbgCEErG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 23:47:06 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0254gwvX014467
        for <linux-kernel@vger.kernel.org>; Wed, 4 Mar 2020 23:47:05 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yfkncqp3v-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 23:47:04 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Thu, 5 Mar 2020 04:47:02 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 5 Mar 2020 04:46:52 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0254kpjE54853756
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 Mar 2020 04:46:51 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BFE93A4040;
        Thu,  5 Mar 2020 04:46:51 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1DD1DA4053;
        Thu,  5 Mar 2020 04:46:45 +0000 (GMT)
Received: from [9.199.61.135] (unknown [9.199.61.135])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  5 Mar 2020 04:46:44 +0000 (GMT)
Subject: Re: [RFC 00/11] perf: Enhancing perf to export processor hazard
 information
To:     Kim Phillips <kim.phillips@amd.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        yao.jin@linux.intel.com, Robert Richter <robert.richter@amd.com>,
        maddy@linux.ibm.com
References: <20200302052355.36365-1-ravi.bangoria@linux.ibm.com>
 <20200302101332.GS18400@hirez.programming.kicks-ass.net>
 <CABPqkBSzwpR6p7UZs7g1vWGCJRLsh565mRMGc6m0Enn1SnkC4w@mail.gmail.com>
 <df966d6e-8898-029f-e697-8496500a1663@amd.com>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Thu, 5 Mar 2020 10:16:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <df966d6e-8898-029f-e697-8496500a1663@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20030504-0016-0000-0000-000002ED4E8B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030504-0017-0000-0000-00003350A046
Message-Id: <2550ec4d-a015-4625-ca24-ff10632dbe2e@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-04_10:2020-03-04,2020-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 clxscore=1015 mlxscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003050025
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kim,

Sorry about being bit late.

On 3/3/20 3:55 AM, Kim Phillips wrote:
> On 3/2/20 2:21 PM, Stephane Eranian wrote:
>> On Mon, Mar 2, 2020 at 2:13 AM Peter Zijlstra <peterz@infradead.org> wrote:
>>>
>>> On Mon, Mar 02, 2020 at 10:53:44AM +0530, Ravi Bangoria wrote:
>>>> Modern processors export such hazard data in Performance
>>>> Monitoring Unit (PMU) registers. Ex, 'Sampled Instruction Event
>>>> Register' on IBM PowerPC[1][2] and 'Instruction-Based Sampling' on
>>>> AMD[3] provides similar information.
>>>>
>>>> Implementation detail:
>>>>
>>>> A new sample_type called PERF_SAMPLE_PIPELINE_HAZ is introduced.
>>>> If it's set, kernel converts arch specific hazard information
>>>> into generic format:
>>>>
>>>>    struct perf_pipeline_haz_data {
>>>>           /* Instruction/Opcode type: Load, Store, Branch .... */
>>>>           __u8    itype;
>>>>           /* Instruction Cache source */
>>>>           __u8    icache;
>>>>           /* Instruction suffered hazard in pipeline stage */
>>>>           __u8    hazard_stage;
>>>>           /* Hazard reason */
>>>>           __u8    hazard_reason;
>>>>           /* Instruction suffered stall in pipeline stage */
>>>>           __u8    stall_stage;
>>>>           /* Stall reason */
>>>>           __u8    stall_reason;
>>>>           __u16   pad;
>>>>    };
>>>
>>> Kim, does this format indeed work for AMD IBS?
> 
> It's not really 1:1, we don't have these separations of stages
> and reasons, for example: we have missed in L2 cache, for example.
> So IBS output is flatter, with more cycle latency figures than
> IBM's AFAICT.

AMD IBS captures pipeline latency data incase Fetch sampling like the
Fetch latency, tag to retire latency, completion to retire latency and
so on. Yes, Ops sampling do provide more data on load/store centric
information. But it also captures more detailed data for Branch instructions.
And we also looked at ARM SPE, which also captures more details pipeline
data and latency information.

> 
>> Personally, I don't like the term hazard. This is too IBM Power
>> specific. We need to find a better term, maybe stall or penalty.
> 
> Right, IBS doesn't have a filter to only count stalled or otherwise
> bad events.  IBS' PPR descriptions has one occurrence of the
> word stall, and no penalty.  The way I read IBS is it's just
> reporting more sample data than just the precise IP: things like
> hits, misses, cycle latencies, addresses, types, etc., so words
> like 'extended', or the 'auxiliary' already used today even
> are more appropriate for IBS, although I'm the last person to
> bikeshed.

We are thinking of using "pipeline" word instead of Hazard.

> 
>> Also worth considering is the support of ARM SPE (Statistical
>> Profiling Extension) which is their version of IBS.
>> Whatever gets added need to cover all three with no limitations.
> 
> I thought Intel's various LBR, PEBS, and PT supported providing
> similar sample data in perf already, like with perf mem/c2c?

perf-mem is more of data centric in my opinion. It is more towards
memory profiling. So proposal here is to expose pipeline related
details like stalls and latencies.

Thanks for the review,
Ravi

