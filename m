Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDB1C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 09:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BF8C20784
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 09:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731862AbgDAJUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 05:20:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63906 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726368AbgDAJUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 05:20:02 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03196Cq6104281
        for <linux-kernel@vger.kernel.org>; Wed, 1 Apr 2020 05:20:01 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 301yfgncjf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 05:20:01 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Wed, 1 Apr 2020 10:19:42 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 1 Apr 2020 10:19:37 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0319Jq7S55443614
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Apr 2020 09:19:52 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F59B42049;
        Wed,  1 Apr 2020 09:19:52 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 111AE42042;
        Wed,  1 Apr 2020 09:19:49 +0000 (GMT)
Received: from [9.199.48.114] (unknown [9.199.48.114])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  1 Apr 2020 09:19:48 +0000 (GMT)
Subject: Re: [PATCH v2 07/16] powerpc/watchpoint: Get watchpoint count
 dynamically while disabling them
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     mpe@ellerman.id.au, mikey@neuling.org, apopple@linux.ibm.com,
        paulus@samba.org, npiggin@gmail.com,
        naveen.n.rao@linux.vnet.ibm.com, peterz@infradead.org,
        jolsa@kernel.org, oleg@redhat.com, fweisbec@gmail.com,
        mingo@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20200401061309.92442-1-ravi.bangoria@linux.ibm.com>
 <20200401061309.92442-8-ravi.bangoria@linux.ibm.com>
 <3c2312bb-9689-830e-3bc8-c828eddf369c@c-s.fr>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Wed, 1 Apr 2020 14:49:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <3c2312bb-9689-830e-3bc8-c828eddf369c@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20040109-0020-0000-0000-000003BF8182
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20040109-0021-0000-0000-00002218265D
Message-Id: <299bf5b6-a293-aa59-b27a-04b00ef7ea2c@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-03-31_07:2020-03-31,2020-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 mlxscore=0 phishscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004010078
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/1/20 12:02 PM, Christophe Leroy wrote:
> 
> 
> Le 01/04/2020 à 08:13, Ravi Bangoria a écrit :
>> Instead of disabling only one watchpoint, get num of available
>> watchpoints dynamically and disable all of them.
>>
>> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
>> ---
>>   arch/powerpc/include/asm/hw_breakpoint.h | 15 +++++++--------
>>   1 file changed, 7 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/hw_breakpoint.h b/arch/powerpc/include/asm/hw_breakpoint.h
>> index 4e4976c3248b..fae33c729ba9 100644
>> --- a/arch/powerpc/include/asm/hw_breakpoint.h
>> +++ b/arch/powerpc/include/asm/hw_breakpoint.h
>> @@ -78,14 +78,13 @@ extern void ptrace_triggered(struct perf_event *bp,
>>               struct perf_sample_data *data, struct pt_regs *regs);
>>   static inline void hw_breakpoint_disable(void)
>>   {
>> -    struct arch_hw_breakpoint brk;
>> -
>> -    brk.address = 0;
>> -    brk.type = 0;
>> -    brk.len = 0;
>> -    brk.hw_len = 0;
>> -    if (ppc_breakpoint_available())
>> -        __set_breakpoint(&brk, 0);
>> +    int i;
>> +    struct arch_hw_breakpoint null_brk = {0};
> 
> Those declaration should be in the block unsigned them below.
> 
>> +
>> +    if (ppc_breakpoint_available()) {
>> +        for (i = 0; i < nr_wp_slots(); i++)
>> +            __set_breakpoint(&null_brk, i);
>> +    }
> 
> I would have had a preference to the following, but that's detail I guess:
> 
>      int i;
>      struct arch_hw_breakpoint null_brk = {0};
> 
>      if (!ppc_breakpoint_available())
>          return;
> 
>      for (i = 0; i < nr_wp_slots(); i++)
>          __set_breakpoint(&null_brk, i);

This looks more better. Will change it.

Ravi

