Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68B1C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 06:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A57C920748
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 06:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgGXGec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 02:34:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3364 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726178AbgGXGeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 02:34:31 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06O6XFIc052004;
        Fri, 24 Jul 2020 02:34:11 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32f23h06ff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jul 2020 02:34:10 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06O6YAqF054466;
        Fri, 24 Jul 2020 02:34:10 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32f23h06de-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jul 2020 02:34:10 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06O6FZqc014045;
        Fri, 24 Jul 2020 06:34:08 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 32brq7pyds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jul 2020 06:34:07 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06O6Y54I56951026
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jul 2020 06:34:05 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 19752A404D;
        Fri, 24 Jul 2020 06:34:05 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D9BFA4069;
        Fri, 24 Jul 2020 06:34:03 +0000 (GMT)
Received: from [9.199.35.65] (unknown [9.199.35.65])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 24 Jul 2020 06:34:03 +0000 (GMT)
Subject: Re: [PATCH v2 2/3] powerpc/powernv/idle: save-restore DAWR0,DAWRX0
 for P10
To:     Michael Neuling <mikey@neuling.org>, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org,
        ravi.bangoria@linux.ibm.com, ego@linux.vnet.ibm.com,
        svaidy@linux.ibm.com, pratik.r.sampat@gmail.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20200710052207.12003-1-psampat@linux.ibm.com>
 <20200710052207.12003-3-psampat@linux.ibm.com>
 <b9507631629bfc1f36893a280b2b83ea484516f9.camel@neuling.org>
From:   Pratik Sampat <psampat@linux.ibm.com>
Message-ID: <cb410050-71ee-5385-096c-3f57e3aa226e@linux.ibm.com>
Date:   Fri, 24 Jul 2020 12:04:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <b9507631629bfc1f36893a280b2b83ea484516f9.camel@neuling.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-24_01:2020-07-24,2020-07-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 adultscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 clxscore=1015 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007240047
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/07/20 6:55 am, Michael Neuling wrote:
> On Fri, 2020-07-10 at 10:52 +0530, Pratik Rajesh Sampat wrote:
>> Additional registers DAWR0, DAWRX0 may be lost on Power 10 for
>> stop levels < 4.
>> Therefore save the values of these SPRs before entering a  "stop"
>> state and restore their values on wakeup.
>>
>> Signed-off-by: Pratik Rajesh Sampat <psampat@linux.ibm.com>
>> ---
>>   arch/powerpc/platforms/powernv/idle.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/arch/powerpc/platforms/powernv/idle.c
>> b/arch/powerpc/platforms/powernv/idle.c
>> index 19d94d021357..f2e2a6a4c274 100644
>> --- a/arch/powerpc/platforms/powernv/idle.c
>> +++ b/arch/powerpc/platforms/powernv/idle.c
>> @@ -600,6 +600,8 @@ struct p9_sprs {
>>   	u64 iamr;
>>   	u64 amor;
>>   	u64 uamor;
>> +	u64 dawr0;
>> +	u64 dawrx0;
>>   };
>>   
>>   static unsigned long power9_idle_stop(unsigned long psscr, bool mmu_on)
>> @@ -687,6 +689,10 @@ static unsigned long power9_idle_stop(unsigned long
>> psscr, bool mmu_on)
>>   	sprs.iamr	= mfspr(SPRN_IAMR);
>>   	sprs.amor	= mfspr(SPRN_AMOR);
>>   	sprs.uamor	= mfspr(SPRN_UAMOR);
>> +	if (cpu_has_feature(CPU_FTR_ARCH_31)) {

You are actually viewing an old version of the patches
The main point of change were based on comments from Nick Piggin, I
have changed the top level function check from ARCH_300 to a P9 PVR
check instead.

A similar thing needs to be done for P10, however as the P10 PVR isn't
exposed yet, I've shelved this particular patch.

Nick's comment to check based on PVR:https://lkml.org/lkml/2020/7/13/1018
v4 of the series:https://lkml.org/lkml/2020/7/21/784

Thanks for your review,
Pratik

> Can you add a comment here saying even though DAWR0 is ARCH_30, it's only
> required to be saved on 31. Otherwise this looks pretty odd.
>
>> +		sprs.dawr0 = mfspr(SPRN_DAWR0);
>> +		sprs.dawrx0 = mfspr(SPRN_DAWRX0);
>> +	}
>>   
>>   	srr1 = isa300_idle_stop_mayloss(psscr);		/* go idle */
>>   
>> @@ -710,6 +716,10 @@ static unsigned long power9_idle_stop(unsigned long
>> psscr, bool mmu_on)
>>   		mtspr(SPRN_IAMR,	sprs.iamr);
>>   		mtspr(SPRN_AMOR,	sprs.amor);
>>   		mtspr(SPRN_UAMOR,	sprs.uamor);
>> +		if (cpu_has_feature(CPU_FTR_ARCH_31)) {
>> +			mtspr(SPRN_DAWR0, sprs.dawr0);
>> +			mtspr(SPRN_DAWRX0, sprs.dawrx0);
>> +		}
>>   
>>   		/*
>>   		 * Workaround for POWER9 DD2.0, if we lost resources, the ERAT

