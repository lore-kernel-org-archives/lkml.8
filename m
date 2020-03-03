Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97C2C3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A03C20838
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729393AbgCCOdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 09:33:25 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36502 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727576AbgCCOdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 09:33:24 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 023EQuW7038632
        for <linux-kernel@vger.kernel.org>; Tue, 3 Mar 2020 09:33:22 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yhr4gjyg0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 09:33:22 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Tue, 3 Mar 2020 14:33:19 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 3 Mar 2020 14:33:13 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 023EXBpQ59899988
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Mar 2020 14:33:11 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6F3FA405B;
        Tue,  3 Mar 2020 14:33:11 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F3642A4054;
        Tue,  3 Mar 2020 14:33:00 +0000 (GMT)
Received: from [9.199.50.120] (unknown [9.199.50.120])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  3 Mar 2020 14:33:00 +0000 (GMT)
Subject: Re: [RFC 02/11] perf/core: Data structure to present hazard data
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        eranian@google.com, peterz@infradead.org, mpe@ellerman.id.au,
        paulus@samba.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, adrian.hunter@intel.com, ak@linux.intel.com,
        kan.liang@linux.intel.com, alexey.budankov@linux.intel.com,
        yao.jin@linux.intel.com, robert.richter@amd.com,
        kim.phillips@amd.com, maddy@linux.ibm.com,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20200302052355.36365-1-ravi.bangoria@linux.ibm.com>
 <20200302052355.36365-3-ravi.bangoria@linux.ibm.com>
 <20200302144842.GD56497@lakrids.cambridge.arm.com>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Tue, 3 Mar 2020 20:02:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200302144842.GD56497@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20030314-0008-0000-0000-00000358F4F8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030314-0009-0000-0000-00004A7A241B
Message-Id: <218edf7b-7062-6133-e534-b0d3bd90c2ff@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-03_05:2020-03-03,2020-03-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003030110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/2/20 8:18 PM, Mark Rutland wrote:
>> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
>> index 377d794d3105..ff252618ca93 100644
>> --- a/include/uapi/linux/perf_event.h
>> +++ b/include/uapi/linux/perf_event.h
>> @@ -142,8 +142,9 @@ enum perf_event_sample_format {
>>   	PERF_SAMPLE_REGS_INTR			= 1U << 18,
>>   	PERF_SAMPLE_PHYS_ADDR			= 1U << 19,
>>   	PERF_SAMPLE_AUX				= 1U << 20,
>> +	PERF_SAMPLE_PIPELINE_HAZ		= 1U << 21,
> 
> Can we please have perf_event_open() reject this sample flag for PMUs
> without the new callback (introduced in the next patch)?
> 
> That way it'll be possible to detect whether the PMU exposes this.

Sure. Will change it.

Ravi

