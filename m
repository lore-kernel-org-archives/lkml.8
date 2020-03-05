Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBAAC3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 05:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CBA9208CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 05:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbgCEFHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 00:07:00 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49438 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725208AbgCEFG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 00:06:59 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0254xpHa054385
        for <linux-kernel@vger.kernel.org>; Thu, 5 Mar 2020 00:06:58 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yj6nk1xe9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 00:06:58 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Thu, 5 Mar 2020 05:06:56 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 5 Mar 2020 05:06:50 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02556ma238338688
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 Mar 2020 05:06:48 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A000EA4051;
        Thu,  5 Mar 2020 05:06:48 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5BD0DA4053;
        Thu,  5 Mar 2020 05:06:41 +0000 (GMT)
Received: from [9.199.61.135] (unknown [9.199.61.135])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  5 Mar 2020 05:06:40 +0000 (GMT)
Subject: Re: [RFC 00/11] perf: Enhancing perf to export processor hazard
 information
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        eranian@google.com, mpe@ellerman.id.au, paulus@samba.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, adrian.hunter@intel.com,
        kan.liang@linux.intel.com, alexey.budankov@linux.intel.com,
        yao.jin@linux.intel.com, robert.richter@amd.com,
        kim.phillips@amd.com, maddy@linux.ibm.com,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20200302052355.36365-1-ravi.bangoria@linux.ibm.com>
 <20200302101332.GS18400@hirez.programming.kicks-ass.net>
 <20200303013329.GB1319864@tassilo.jf.intel.com>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Thu, 5 Mar 2020 10:36:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200303013329.GB1319864@tassilo.jf.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20030505-0008-0000-0000-00000359772C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030505-0009-0000-0000-00004A7AACFD
Message-Id: <aaab8c6a-a02a-f96b-ec43-e9694c8aad02@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-04_10:2020-03-04,2020-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxlogscore=961 suspectscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 phishscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003050028
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

Sorry for being bit late.

On 3/3/20 7:03 AM, Andi Kleen wrote:
> On Mon, Mar 02, 2020 at 11:13:32AM +0100, Peter Zijlstra wrote:
>> On Mon, Mar 02, 2020 at 10:53:44AM +0530, Ravi Bangoria wrote:
>>> Modern processors export such hazard data in Performance
>>> Monitoring Unit (PMU) registers. Ex, 'Sampled Instruction Event
>>> Register' on IBM PowerPC[1][2] and 'Instruction-Based Sampling' on
>>> AMD[3] provides similar information.
>>>
>>> Implementation detail:
>>>
>>> A new sample_type called PERF_SAMPLE_PIPELINE_HAZ is introduced.
>>> If it's set, kernel converts arch specific hazard information
>>> into generic format:
>>>
>>>    struct perf_pipeline_haz_data {
>>>           /* Instruction/Opcode type: Load, Store, Branch .... */
>>>           __u8    itype;
>>>           /* Instruction Cache source */
>>>           __u8    icache;
>>>           /* Instruction suffered hazard in pipeline stage */
>>>           __u8    hazard_stage;
>>>           /* Hazard reason */
>>>           __u8    hazard_reason;
>>>           /* Instruction suffered stall in pipeline stage */
>>>           __u8    stall_stage;
>>>           /* Stall reason */
>>>           __u8    stall_reason;
>>>           __u16   pad;
>>>    };
>>
>> Kim, does this format indeed work for AMD IBS?
> 
> Intel PEBS has a similar concept for annotation of memory accesses,
> which is already exported through perf_mem_data_src. This is essentially
> an extension. It would be better to have something unified here.
> Right now it seems to duplicate at least part of the PEBS facility.

IIUC there is a distinction from perf mem vs exposing the pipeline details.
perf-mem/perf_mem_data_src is more of memory accesses profiling. And proposal
here is to expose pipeline related details like stalls and latencies. Would
prefer/suggest not to extend the current structure further to capture pipeline
details.

Ravi

