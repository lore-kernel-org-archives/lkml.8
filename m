Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A175C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 11:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 090602071E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 11:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="A+PuLPY1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729953AbgHYLIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 07:08:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46278 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729458AbgHYLIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 07:08:37 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07PB3RDo033396;
        Tue, 25 Aug 2020 07:08:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=NcMX5ZLwonyyuW1UQGnW6NTW1nKey9uwaFJF5lARtTQ=;
 b=A+PuLPY1eY2gIbBLZqEGERdaFmMo8dKeVtHfpA0oSPf6XC3sbLSeGsKRvK7+qlZzV2S4
 uIaYsVfwfJtDhcIDWTwFXTebAD6nOt8Ue11c6ixw4hNPhREvVr3fgvKjGlZMmtIPcHS+
 GlJ7mPgQlwnIIozOL/XR0dsa9+nGAgChsncoRDLolW+XtgqRnRip1kJgqeMhk4hGjzZi
 QaZ+Q4/VMlhIAWLmu2FpLluUZBEyZ5PCv0MlMdxQbox2/zLXp9CFp6TmApA5hBAzpHxa
 /kgH4T6A0c96Mz7NsJ3XeTzXaefI6QLm9wN+6PBzo3sMzKhc9XwyWcwKImcYf1hBf9Jp KA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 334x7t5x8y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Aug 2020 07:08:07 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07PB3wor036503;
        Tue, 25 Aug 2020 07:08:06 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 334x7t5x78-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Aug 2020 07:08:06 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07PB7sMk014512;
        Tue, 25 Aug 2020 11:08:04 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 332ujkubn7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Aug 2020 11:08:04 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07PB81WZ29884680
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Aug 2020 11:08:01 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B83E42047;
        Tue, 25 Aug 2020 11:08:01 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7BE2F42049;
        Tue, 25 Aug 2020 11:07:58 +0000 (GMT)
Received: from [9.199.33.167] (unknown [9.199.33.167])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 25 Aug 2020 11:07:58 +0000 (GMT)
Subject: Re: [PATCH v5 5/8] powerpc/watchpoint: Fix exception handling for
 CONFIG_HAVE_HW_BREAKPOINT=N
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        christophe.leroy@c-s.fr
Cc:     mpe@ellerman.id.au, mikey@neuling.org, paulus@samba.org,
        naveen.n.rao@linux.vnet.ibm.com, pedromfc@linux.ibm.com,
        rogealve@linux.ibm.com, jniethe5@gmail.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20200825043617.1073634-1-ravi.bangoria@linux.ibm.com>
 <20200825043617.1073634-6-ravi.bangoria@linux.ibm.com>
 <91d34b89-603a-fddc-ea0f-53a79b287eed@csgroup.eu>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Message-ID: <1e706137-3de9-a713-5a86-48fbc5e6f740@linux.ibm.com>
Date:   Tue, 25 Aug 2020 16:37:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <91d34b89-603a-fddc-ea0f-53a79b287eed@csgroup.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-25_02:2020-08-25,2020-08-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 clxscore=1011 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008250083
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

>> diff --git a/arch/powerpc/kernel/ptrace/ptrace-noadv.c b/arch/powerpc/kernel/ptrace/ptrace-noadv.c
>> index 57a0ab822334..866597b407bc 100644
>> --- a/arch/powerpc/kernel/ptrace/ptrace-noadv.c
>> +++ b/arch/powerpc/kernel/ptrace/ptrace-noadv.c
>> @@ -286,11 +286,16 @@ long ppc_del_hwdebug(struct task_struct *child, long data)
>>       }
>>       return ret;
>>   #else /* CONFIG_HAVE_HW_BREAKPOINT */
>> +    if (child->thread.hw_brk[data - 1].flags & HW_BRK_FLAG_DISABLED)
> 
> I think child->thread.hw_brk[data - 1].flags & HW_BRK_FLAG_DISABLED should go around additionnal ()

Not sure I follow.

> 
>> +        goto del;
>> +
>>       if (child->thread.hw_brk[data - 1].address == 0)
>>           return -ENOENT;
> 
> What about replacing the above if by:
>      if (!(child->thread.hw_brk[data - 1].flags) & HW_BRK_FLAG_DISABLED) &&
>          child->thread.hw_brk[data - 1].address == 0)
>          return -ENOENT;
okay.. that's more compact.

But more importantly, what I wanted to know is whether CONFIG_HAVE_HW_BREAKPOINT
is set or not in production/distro builds for 8xx. Because I see it's not set in
8xx defconfigs.

Thanks,
Ravi
