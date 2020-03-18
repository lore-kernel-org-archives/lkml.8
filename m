Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB0AC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 05:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A43F32076C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 05:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbgCRFvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 01:51:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3394 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726550AbgCRFvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 01:51:51 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02I5e2La029912
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 01:50:49 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yu931fua3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 01:50:49 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Wed, 18 Mar 2020 05:50:47 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 18 Mar 2020 05:50:42 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02I5oeF847972436
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Mar 2020 05:50:40 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE1BBA405C;
        Wed, 18 Mar 2020 05:50:40 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 13DADA4064;
        Wed, 18 Mar 2020 05:50:10 +0000 (GMT)
Received: from [9.199.62.91] (unknown [9.199.62.91])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 18 Mar 2020 05:50:07 +0000 (GMT)
Subject: Re: [PATCH 03/15] powerpc/watchpoint: Introduce function to get nr
 watchpoints dynamically
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     mpe@ellerman.id.au, mikey@neuling.org, apopple@linux.ibm.com,
        paulus@samba.org, npiggin@gmail.com,
        naveen.n.rao@linux.vnet.ibm.com, peterz@infradead.org,
        jolsa@kernel.org, oleg@redhat.com, fweisbec@gmail.com,
        mingo@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20200309085806.155823-1-ravi.bangoria@linux.ibm.com>
 <20200309085806.155823-4-ravi.bangoria@linux.ibm.com>
 <53b8bf54-200f-6f37-5870-e641b35f373c@c-s.fr>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Wed, 18 Mar 2020 11:20:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <53b8bf54-200f-6f37-5870-e641b35f373c@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20031805-0008-0000-0000-0000035F212C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031805-0009-0000-0000-00004A807A65
Message-Id: <76ed70d0-c892-780f-338d-da8f35fa14c6@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-18_02:2020-03-17,2020-03-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0 mlxlogscore=802
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003180028
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> diff --git a/arch/powerpc/include/asm/hw_breakpoint.h b/arch/powerpc/include/asm/hw_breakpoint.h
>> index f2f8d8aa8e3b..741c4f7573c4 100644
>> --- a/arch/powerpc/include/asm/hw_breakpoint.h
>> +++ b/arch/powerpc/include/asm/hw_breakpoint.h
>> @@ -43,6 +43,8 @@ struct arch_hw_breakpoint {
>>   #define DABR_MAX_LEN    8
>>   #define DAWR_MAX_LEN    512
>> +extern int nr_wp_slots(void);
> 
> 'extern' keyword is unneeded and irrelevant here. Please remove it. Even checkpatch is unhappy (https://openpower.xyz/job/snowpatch/job/snowpatch-linux-checkpatch/12172//artifact/linux/checkpatch.log)

Sure.

...
>> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
>> index 110db94cdf3c..6d4b029532e2 100644
>> --- a/arch/powerpc/kernel/process.c
>> +++ b/arch/powerpc/kernel/process.c
>> @@ -835,6 +835,12 @@ static inline bool hw_brk_match(struct arch_hw_breakpoint *a,
>>       return true;
>>   }
>> +/* Returns total number of data breakpoints available. */
>> +int nr_wp_slots(void)
>> +{
>> +    return HBP_NUM_MAX;
>> +}
>> +
> 
> This is not worth a global function. At least it should be a static function located in hw_breakpoint.c. But it would be even better to have it as a static inline in asm/hw_breakpoint.h

Makes sense. Will change it.

Thanks.

