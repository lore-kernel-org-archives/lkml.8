Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7EA8C5ACD6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 09:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0AC020674
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 09:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbgCRJoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 05:44:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15294 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727695AbgCRJoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 05:44:11 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02I9XUnE025036
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 05:44:10 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yu8br9fa9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 05:44:09 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Wed, 18 Mar 2020 09:44:07 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 18 Mar 2020 09:44:02 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02I9i1mA59441288
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Mar 2020 09:44:01 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5779152052;
        Wed, 18 Mar 2020 09:44:01 +0000 (GMT)
Received: from [9.203.170.80] (unknown [9.203.170.80])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id B804952065;
        Wed, 18 Mar 2020 09:43:10 +0000 (GMT)
Subject: Re: [PATCH 10/15] powerpc/watchpoint: Use loop for
 thread_struct->ptrace_bps
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     mpe@ellerman.id.au, mikey@neuling.org, apopple@linux.ibm.com,
        paulus@samba.org, npiggin@gmail.com,
        naveen.n.rao@linux.vnet.ibm.com, peterz@infradead.org,
        jolsa@kernel.org, oleg@redhat.com, fweisbec@gmail.com,
        mingo@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20200309085806.155823-1-ravi.bangoria@linux.ibm.com>
 <20200309085806.155823-11-ravi.bangoria@linux.ibm.com>
 <0eeeac90-b5e3-722b-2d2c-bb95c81d851a@c-s.fr>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Wed, 18 Mar 2020 15:13:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <0eeeac90-b5e3-722b-2d2c-bb95c81d851a@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20031809-0016-0000-0000-000002F31937
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031809-0017-0000-0000-000033569D96
Message-Id: <a52ef8d3-b27b-d48d-b0ab-c9b41209a6ca@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-18_03:2020-03-17,2020-03-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003180048
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> @@ -1628,6 +1628,9 @@ int copy_thread_tls(unsigned long clone_flags, unsigned long usp,
>>       void (*f)(void);
>>       unsigned long sp = (unsigned long)task_stack_page(p) + THREAD_SIZE;
>>       struct thread_info *ti = task_thread_info(p);
>> +#ifdef CONFIG_HAVE_HW_BREAKPOINT
>> +    int i;
>> +#endif
> 
> Could we avoid all those #ifdefs ?
> 
> I think if we make p->thread.ptrace_bps[] exist all the time, with a size of 0 when CONFIG_HAVE_HW_BREAKPOINT is not set, then we can drop a lot of #ifdefs.

Hmm.. what you are saying seems possible. But IMO it should be done as
independent series. Will work on it.

> 
>>       klp_init_thread_info(p);
>> @@ -1687,7 +1690,8 @@ int copy_thread_tls(unsigned long clone_flags, unsigned long usp,
>>       p->thread.ksp_limit = (unsigned long)end_of_stack(p);
>>   #endif
>>   #ifdef CONFIG_HAVE_HW_BREAKPOINT
>> -    p->thread.ptrace_bps[0] = NULL;
>> +    for (i = 0; i < nr_wp_slots(); i++)
>> +        p->thread.ptrace_bps[i] = NULL;
>>   #endif
>>       p->thread.fp_save_area = NULL;
>> diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
>> index f6d7955fc61e..e2651f86d56f 100644
>> --- a/arch/powerpc/kernel/ptrace.c
>> +++ b/arch/powerpc/kernel/ptrace.c
> 
> You'll have to rebase all this on the series https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=161356 which is about to go into powerpc-next

Sure. Thanks for heads up.

> 
>> @@ -2829,6 +2829,19 @@ static int set_dac_range(struct task_struct *child,
>>   }
>>   #endif /* CONFIG_PPC_ADV_DEBUG_DAC_RANGE */
>> +#ifdef CONFIG_HAVE_HW_BREAKPOINT
>> +static int empty_ptrace_bp(struct thread_struct *thread)
>> +{
>> +    int i;
>> +
>> +    for (i = 0; i < nr_wp_slots(); i++) {
>> +        if (!thread->ptrace_bps[i])
>> +            return i;
>> +    }
>> +    return -1;
>> +}
>> +#endif
> 
> What does this function do exactly ? I seems to do more than what its name suggests.

It finds an empty breakpoint in ptrace_bps[]. But yeah, function name is
misleading. I'll rename it to find_empty_ptrace_bp().

...

>> @@ -2979,10 +2993,10 @@ static long ppc_del_hwdebug(struct task_struct *child, long data)
>>           return -EINVAL;
>>   #ifdef CONFIG_HAVE_HW_BREAKPOINT
>> -    bp = thread->ptrace_bps[0];
>> +    bp = thread->ptrace_bps[data - 1];
> 
> Is data checked somewhere to ensure it is not out of boundaries ? Or are we sure it is always within ?

Yes. it's checked. See patch #9:

   @@ -2955,7 +2975,7 @@ static long ppc_del_hwdebug(struct task_struct *child, long data)
    	}
    	return rc;
    #else
   -	if (data != 1)
   +	if (data < 1 || data > nr_wp_slots())
    		return -EINVAL;
    
    #ifdef CONFIG_HAVE_HW_BREAKPOINT

Thanks,
Ravi

