Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACB3C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 09:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6750F20772
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 09:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732167AbgDAJAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 05:00:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44746 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727627AbgDAJA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 05:00:29 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0318YnB3109042
        for <linux-kernel@vger.kernel.org>; Wed, 1 Apr 2020 05:00:28 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 301yfgmswk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 05:00:28 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Wed, 1 Apr 2020 10:00:15 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 1 Apr 2020 10:00:11 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03190KlS62259290
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Apr 2020 09:00:21 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C5A6742056;
        Wed,  1 Apr 2020 09:00:20 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E8D842041;
        Wed,  1 Apr 2020 09:00:17 +0000 (GMT)
Received: from [9.199.48.114] (unknown [9.199.48.114])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  1 Apr 2020 09:00:16 +0000 (GMT)
Subject: Re: [PATCH v2 08/16] powerpc/watchpoint: Disable all available
 watchpoints when !dawr_force_enable
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     mpe@ellerman.id.au, mikey@neuling.org, apopple@linux.ibm.com,
        paulus@samba.org, npiggin@gmail.com,
        naveen.n.rao@linux.vnet.ibm.com, peterz@infradead.org,
        jolsa@kernel.org, oleg@redhat.com, fweisbec@gmail.com,
        mingo@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20200401061309.92442-1-ravi.bangoria@linux.ibm.com>
 <20200401061309.92442-9-ravi.bangoria@linux.ibm.com>
 <1bef7056-b862-3b20-c3b8-8b161511c60a@c-s.fr>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Wed, 1 Apr 2020 14:30:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1bef7056-b862-3b20-c3b8-8b161511c60a@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20040109-0008-0000-0000-000003685C24
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20040109-0009-0000-0000-00004A89E3C2
Message-Id: <3042ffeb-0587-79cb-1401-070715d3adb6@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-03-31_07:2020-03-31,2020-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 mlxscore=0 phishscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 spamscore=0 mlxlogscore=945 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004010073
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/1/20 12:03 PM, Christophe Leroy wrote:
> 
> 
> Le 01/04/2020 à 08:13, Ravi Bangoria a écrit :
>> Instead of disabling only first watchpoint, disable all available
>> watchpoints while clearing dawr_force_enable.
> 
> Can you also explain why you change the function name ?

Right. I should have. Will add it in next version.

> 
>>
>> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
>> ---
>>   arch/powerpc/kernel/dawr.c | 10 +++++++---
>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/dawr.c b/arch/powerpc/kernel/dawr.c
>> index 311e51ee09f4..5c882f07ac7d 100644
>> --- a/arch/powerpc/kernel/dawr.c
>> +++ b/arch/powerpc/kernel/dawr.c
>> @@ -50,9 +50,13 @@ int set_dawr(struct arch_hw_breakpoint *brk, int nr)
>>       return 0;
>>   }
>> -static void set_dawr_cb(void *info)
>> +static void disable_dawrs(void *info)
> 
> Wouldn't it be better to keep _cb at the end of the function ?

Sure.

Ravi

