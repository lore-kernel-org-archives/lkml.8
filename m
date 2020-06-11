Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF51EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 08:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B185E20656
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 08:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgFKIxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 04:53:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17252 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726817AbgFKIxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 04:53:01 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05B8YaWn154938;
        Thu, 11 Jun 2020 04:52:38 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31k7s4e6e0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Jun 2020 04:52:38 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05B8aL98161224;
        Thu, 11 Jun 2020 04:52:37 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31k7s4e6dd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Jun 2020 04:52:37 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05B8pN6E004026;
        Thu, 11 Jun 2020 08:52:36 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma01fra.de.ibm.com with ESMTP id 31g2s7uu30-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Jun 2020 08:52:36 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05B8qX8e62390780
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Jun 2020 08:52:33 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC1E011C058;
        Thu, 11 Jun 2020 08:52:33 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CDA2D11C04A;
        Thu, 11 Jun 2020 08:52:31 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.60.164])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 11 Jun 2020 08:52:31 +0000 (GMT)
Subject: Re: [PATCH? v2] powerpc: Hard wire PT_SOFTE value to 1 in gpr_get()
 too
To:     Oleg Nesterov <oleg@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     Jan Kratochvil <jan.kratochvil@redhat.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20190917121256.GA8659@redhat.com>
 <20190917143753.GA12300@redhat.com> <20200610150224.GA6793@redhat.com>
From:   Madhavan Srinivasan <maddy@linux.ibm.com>
Message-ID: <321e6865-1762-c459-56c4-0cc89c7c2a7e@linux.ibm.com>
Date:   Thu, 11 Jun 2020 14:22:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200610150224.GA6793@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-11_07:2020-06-10,2020-06-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 phishscore=0 clxscore=1011 cotscore=-2147483648
 adultscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006110067
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/10/20 8:37 PM, Oleg Nesterov wrote:
> Hi,
>
> looks like this patch was forgotten.

yep, I missed this. But mpe did have comments for the patch.

https://lkml.org/lkml/2019/9/19/107

Maddy
>
> Do you think this should be fixed or should we document that
> PTRACE_GETREGS is not consistent with PTRACE_PEEKUSER on ppc64?
>
>
> On 09/17, Oleg Nesterov wrote:
>> I don't have a ppc machine, this patch wasn't even compile tested,
>> could you please review?
>>
>> The commit a8a4b03ab95f ("powerpc: Hard wire PT_SOFTE value to 1 in
>> ptrace & signals") changed ptrace_get_reg(PT_SOFTE) to report 0x1,
>> but PTRACE_GETREGS still copies pt_regs->softe as is.
>>
>> This is not consistent and this breaks
>> http://sourceware.org/systemtap/wiki/utrace/tests/user-regs-peekpoke
>>
>> Reported-by: Jan Kratochvil <jan.kratochvil@redhat.com>
>> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
>> ---
>>   arch/powerpc/kernel/ptrace.c | 25 +++++++++++++++++++++++++
>>   1 file changed, 25 insertions(+)
>>
>> diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
>> index 8c92feb..291acfb 100644
>> --- a/arch/powerpc/kernel/ptrace.c
>> +++ b/arch/powerpc/kernel/ptrace.c
>> @@ -363,11 +363,36 @@ static int gpr_get(struct task_struct *target, const struct user_regset *regset,
>>   	BUILD_BUG_ON(offsetof(struct pt_regs, orig_gpr3) !=
>>   		     offsetof(struct pt_regs, msr) + sizeof(long));
>>   
>> +#ifdef CONFIG_PPC64
>> +	if (!ret)
>> +		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
>> +					  &target->thread.regs->orig_gpr3,
>> +					  offsetof(struct pt_regs, orig_gpr3),
>> +					  offsetof(struct pt_regs, softe));
>> +
>> +	if (!ret) {
>> +		unsigned long softe = 0x1;
>> +		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf, &softe,
>> +					  offsetof(struct pt_regs, softe),
>> +					  offsetof(struct pt_regs, softe) +
>> +					  sizeof(softe));
>> +	}
>> +
>> +	BUILD_BUG_ON(offsetof(struct pt_regs, trap) !=
>> +		     offsetof(struct pt_regs, softe) + sizeof(long));
>> +
>> +	if (!ret)
>> +		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
>> +					  &target->thread.regs->trap,
>> +					  offsetof(struct pt_regs, trap),
>> +					  sizeof(struct user_pt_regs));
>> +#else
>>   	if (!ret)
>>   		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
>>   					  &target->thread.regs->orig_gpr3,
>>   					  offsetof(struct pt_regs, orig_gpr3),
>>   					  sizeof(struct user_pt_regs));
>> +#endif
>>   	if (!ret)
>>   		ret = user_regset_copyout_zero(&pos, &count, &kbuf, &ubuf,
>>   					       sizeof(struct user_pt_regs), -1);
>> -- 
>> 2.5.0
>>

