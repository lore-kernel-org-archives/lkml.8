Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AEBC3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 14:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1D36214DB
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 14:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbgCBOXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 09:23:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27590 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726988AbgCBOXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 09:23:43 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 022ELBRk013224
        for <linux-kernel@vger.kernel.org>; Mon, 2 Mar 2020 09:23:42 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yfm51dcee-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 09:23:41 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <maddy@linux.ibm.com>;
        Mon, 2 Mar 2020 14:23:39 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 2 Mar 2020 14:23:34 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 022ENXTY54395004
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Mar 2020 14:23:33 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5210F4C04E;
        Mon,  2 Mar 2020 14:23:33 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DA27E4C044;
        Mon,  2 Mar 2020 14:23:27 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.48.197])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  2 Mar 2020 14:23:27 +0000 (GMT)
Subject: Re: [RFC 02/11] perf/core: Data structure to present hazard data
To:     Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        eranian@google.com, mpe@ellerman.id.au, paulus@samba.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, adrian.hunter@intel.com, ak@linux.intel.com,
        kan.liang@linux.intel.com, alexey.budankov@linux.intel.com,
        yao.jin@linux.intel.com, robert.richter@amd.com,
        kim.phillips@amd.com,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
References: <20200302052355.36365-1-ravi.bangoria@linux.ibm.com>
 <20200302052355.36365-3-ravi.bangoria@linux.ibm.com>
 <20200302095515.GR18400@hirez.programming.kicks-ass.net>
From:   maddy <maddy@linux.ibm.com>
Date:   Mon, 2 Mar 2020 19:53:26 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200302095515.GR18400@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 20030214-0016-0000-0000-000002EC4BF6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030214-0017-0000-0000-0000334F8EBF
Message-Id: <c9dc6d62-3847-4080-8122-d62621455372@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-02_04:2020-03-02,2020-03-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxscore=0
 clxscore=1015 bulkscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003020105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/2/20 3:25 PM, Peter Zijlstra wrote:
> On Mon, Mar 02, 2020 at 10:53:46AM +0530, Ravi Bangoria wrote:
>> From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
>>
>> Introduce new perf sample_type PERF_SAMPLE_PIPELINE_HAZ to request kernel
>> to provide cpu pipeline hazard data. Also, introduce arch independent
>> structure 'perf_pipeline_haz_data' to pass hazard data to userspace. This
>> is generic structure and arch specific data needs to be converted to this
>> format.
>>
>> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
>> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
>> ---
>>   include/linux/perf_event.h            |  7 ++++++
>>   include/uapi/linux/perf_event.h       | 32 ++++++++++++++++++++++++++-
>>   kernel/events/core.c                  |  6 +++++
>>   tools/include/uapi/linux/perf_event.h | 32 ++++++++++++++++++++++++++-
>>   4 files changed, 75 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>> index 547773f5894e..d5b606e3c57d 100644
>> --- a/include/linux/perf_event.h
>> +++ b/include/linux/perf_event.h
>> @@ -1001,6 +1001,7 @@ struct perf_sample_data {
>>   	u64				stack_user_size;
>>   
>>   	u64				phys_addr;
>> +	struct perf_pipeline_haz_data	pipeline_haz;
>>   } ____cacheline_aligned;
>>   
>>   /* default value for data source */
>> @@ -1021,6 +1022,12 @@ static inline void perf_sample_data_init(struct perf_sample_data *data,
>>   	data->weight = 0;
>>   	data->data_src.val = PERF_MEM_NA;
>>   	data->txn = 0;
>> +	data->pipeline_haz.itype = PERF_HAZ__ITYPE_NA;
>> +	data->pipeline_haz.icache = PERF_HAZ__ICACHE_NA;
>> +	data->pipeline_haz.hazard_stage = PERF_HAZ__PIPE_STAGE_NA;
>> +	data->pipeline_haz.hazard_reason = PERF_HAZ__HREASON_NA;
>> +	data->pipeline_haz.stall_stage = PERF_HAZ__PIPE_STAGE_NA;
>> +	data->pipeline_haz.stall_reason = PERF_HAZ__SREASON_NA;
>>   }
> NAK, Don't touch anything outside of the first cacheline here.

My bad, should have looked at the comment in "struct perf_sample_data {".
Will move it to perf_prepare_sample().

Thanks for comments.
Maddy

