Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2869C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 09:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9895620784
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 09:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730831AbgDAJX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 05:23:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48842 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726205AbgDAJX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 05:23:58 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03193KYX010282
        for <linux-kernel@vger.kernel.org>; Wed, 1 Apr 2020 05:23:57 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3020705ytc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 05:23:56 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Wed, 1 Apr 2020 10:23:53 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 1 Apr 2020 10:23:49 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0319Nov552035588
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Apr 2020 09:23:50 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0721F42045;
        Wed,  1 Apr 2020 09:23:50 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 830424203F;
        Wed,  1 Apr 2020 09:23:46 +0000 (GMT)
Received: from [9.199.48.114] (unknown [9.199.48.114])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  1 Apr 2020 09:23:46 +0000 (GMT)
Subject: Re: [PATCH v2 13/16] powerpc/watchpoint: Prepare handler to handle
 more than one watcnhpoint
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     mpe@ellerman.id.au, mikey@neuling.org, apopple@linux.ibm.com,
        paulus@samba.org, npiggin@gmail.com,
        naveen.n.rao@linux.vnet.ibm.com, peterz@infradead.org,
        jolsa@kernel.org, oleg@redhat.com, fweisbec@gmail.com,
        mingo@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20200401061309.92442-1-ravi.bangoria@linux.ibm.com>
 <20200401061309.92442-14-ravi.bangoria@linux.ibm.com>
 <6b89991b-481a-8cbd-b5b7-559e5e16cf92@c-s.fr>
 <cb2c250b-c963-45fe-f3b4-879076c495ab@linux.ibm.com>
 <78559ff4-c2c3-e652-a906-8f40673b53d6@c-s.fr>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Wed, 1 Apr 2020 14:53:45 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <78559ff4-c2c3-e652-a906-8f40673b53d6@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20040109-0028-0000-0000-000003EFEF27
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20040109-0029-0000-0000-000024B5749D
Message-Id: <955bf95b-0cda-dfa4-57ca-3f0f4415b5ea@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-03-31_07:2020-03-31,2020-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 mlxscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004010078
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/1/20 2:50 PM, Christophe Leroy wrote:
> 
> 
> Le 01/04/2020 à 11:13, Ravi Bangoria a écrit :
>>
>>
>> On 4/1/20 12:20 PM, Christophe Leroy wrote:
>>>
>>>
>>> Le 01/04/2020 à 08:13, Ravi Bangoria a écrit :
>>>> Currently we assume that we have only one watchpoint supported by hw.
>>>> Get rid of that assumption and use dynamic loop instead. This should
>>>> make supporting more watchpoints very easy.
>>>>
>>>> With more than one watchpoint, exception handler need to know which
>>>> DAWR caused the exception, and hw currently does not provide it. So
>>>> we need sw logic for the same. To figure out which DAWR caused the
>>>> exception, check all different combinations of user specified range,
>>>> dawr address range, actual access range and dawrx constrains. For ex,
>>>> if user specified range and actual access range overlaps but dawrx is
>>>> configured for readonly watchpoint and the instruction is store, this
>>>> DAWR must not have caused exception.
>>>>
>>>> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
>>>> ---
>>>>   arch/powerpc/include/asm/processor.h |   2 +-
>>>>   arch/powerpc/include/asm/sstep.h     |   2 +
>>>>   arch/powerpc/kernel/hw_breakpoint.c  | 396 +++++++++++++++++++++------
>>>>   arch/powerpc/kernel/process.c        |   3 -
>>>>   4 files changed, 313 insertions(+), 90 deletions(-)
>>>>
>>>
>>> [...]
>>>
>>>> -static bool
>>>> -dar_range_overlaps(unsigned long dar, int size, struct arch_hw_breakpoint *info)
>>>> +static bool dar_user_range_overlaps(unsigned long dar, int size,
>>>> +                    struct arch_hw_breakpoint *info)
>>>>   {
>>>>       return ((dar <= info->address + info->len - 1) &&
>>>>           (dar + size - 1 >= info->address));
>>>>   }
>>>
>>> Here and several other places, I think it would be more clear if you could avoid the - 1 :
>>>
>>>      return ((dar < info->address + info->len) &&
>>>          (dar + size > info->address));
>>
>> Ok. see below...
>>
>>>
>>>
>>>> +static bool dar_in_hw_range(unsigned long dar, struct arch_hw_breakpoint *info)
>>>> +{
>>>> +    unsigned long hw_start_addr, hw_end_addr;
>>>> +
>>>> +    hw_start_addr = ALIGN_DOWN(info->address, HW_BREAKPOINT_SIZE);
>>>> +    hw_end_addr = ALIGN(info->address + info->len, HW_BREAKPOINT_SIZE) - 1;
>>>> +
>>>> +    return ((hw_start_addr <= dar) && (hw_end_addr >= dar));
>>>> +}
>>>
>>>      hw_end_addr = ALIGN(info->address + info->len, HW_BREAKPOINT_SIZE);
>>>
>>>      return ((hw_start_addr <= dar) && (hw_end_addr > dar));
>>
>> I'm using -1 while calculating end address is to make it
>> inclusive. If I don't use -1, the end address points to a
>> location outside of actual range, i.e. it's not really an
>> end address.
> 
> But that's what is done is several places, for instance:
> 
> https://elixir.bootlin.com/linux/v5.6/source/arch/powerpc/mm/dma-noncoherent.c#L22
> 
> https://elixir.bootlin.com/linux/v5.6/source/arch/powerpc/include/asm/book3s/32/kup.h#L92
> 
> In several places like this, end is outside of the range. My feeling is that is helps with readability.

Agreed, it helps with readability. Will change it.
Thanks for the links.

Ravi

