Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F1EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 11:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFDAF206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 11:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgGILWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 07:22:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1572 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726315AbgGILWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 07:22:43 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 069B2IdY121496;
        Thu, 9 Jul 2020 07:22:27 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 325kh3xw8q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jul 2020 07:22:27 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 069B3FHs125428;
        Thu, 9 Jul 2020 07:22:27 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 325kh3xw7d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jul 2020 07:22:27 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 069BKvQV015376;
        Thu, 9 Jul 2020 11:22:24 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma02fra.de.ibm.com with ESMTP id 325mr2rsek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jul 2020 11:22:24 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 069BL6Ua47579232
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Jul 2020 11:21:07 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CF2D6AE053;
        Thu,  9 Jul 2020 11:21:06 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 67361AE055;
        Thu,  9 Jul 2020 11:21:05 +0000 (GMT)
Received: from [9.79.211.226] (unknown [9.79.211.226])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  9 Jul 2020 11:21:05 +0000 (GMT)
Subject: Re: [PATCH 2/2] powerpc/powernv/idle: save-restore DAWR0,DAWRX0 for
 P10
To:     ego@linux.vnet.ibm.com
Cc:     mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
        paulus@samba.org, svaidy@linux.ibm.com, pratik.r.sampat@gmail.com,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20200703124640.42820-1-psampat@linux.ibm.com>
 <20200703124640.42820-2-psampat@linux.ibm.com>
 <20200709090948.GB24354@in.ibm.com>
From:   Pratik Sampat <psampat@linux.ibm.com>
Message-ID: <87fdebb1-93e1-a59d-f582-784ee1c19279@linux.ibm.com>
Date:   Thu, 9 Jul 2020 16:51:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200709090948.GB24354@in.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-09_05:2020-07-09,2020-07-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 mlxscore=0 bulkscore=0
 spamscore=0 suspectscore=1 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007090084
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/07/20 2:39 pm, Gautham R Shenoy wrote:
> On Fri, Jul 03, 2020 at 06:16:40PM +0530, Pratik Rajesh Sampat wrote:
>> Additional registers DAWR0, DAWRX0 may be lost on Power 10 for
>> stop levels < 4.
> Adding Ravi Bangoria <ravi.bangoria@linux.ibm.com> to the cc.
>
>> Therefore save the values of these SPRs before entering a  "stop"
>> state and restore their values on wakeup.
>>
>> Signed-off-by: Pratik Rajesh Sampat <psampat@linux.ibm.com>
>
> The saving and restoration looks good to me.
>> ---
>>   arch/powerpc/platforms/powernv/idle.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
>> index 19d94d021357..471d4a65b1fa 100644
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
>> @@ -677,6 +679,10 @@ static unsigned long power9_idle_stop(unsigned long psscr, bool mmu_on)
>>   		sprs.tscr	= mfspr(SPRN_TSCR);
>>   		if (!firmware_has_feature(FW_FEATURE_ULTRAVISOR))
>>   			sprs.ldbar = mfspr(SPRN_LDBAR);
>> +		if (cpu_has_feature(CPU_FTR_ARCH_31)) {
>> +			sprs.dawr0 = mfspr(SPRN_DAWR0);
>> +			sprs.dawrx0 = mfspr(SPRN_DAWRX0);
>> +		}
>>
>
> But this is within the if condition which says
>
> 	if ((psscr & PSSCR_RL_MASK) >= pnv_first_spr_loss_level)
>
> This if condition is meant for stop4 and stop5 since these are stop
> levels that have OPAL_PM_LOSE_HYP_CONTEXT set.
>
> Since we can lose DAWR*, on states that lose limited hypervisor
> context, such as stop0-2, we need to unconditionally save them
> like AMR, IAMR etc.
>
Right, shallow states too loose DAWR/X. Thanks for pointing it out.
I'll fix this and resend.

>>   		sprs_saved = true;
>>
>> @@ -792,6 +798,10 @@ static unsigned long power9_idle_stop(unsigned long psscr, bool mmu_on)
>>   	mtspr(SPRN_MMCR2,	sprs.mmcr2);
>>   	if (!firmware_has_feature(FW_FEATURE_ULTRAVISOR))
>>   		mtspr(SPRN_LDBAR, sprs.ldbar);
>> +	if (cpu_has_feature(CPU_FTR_ARCH_31)) {
>> +		mtspr(SPRN_DAWR0, sprs.dawr0);
>> +		mtspr(SPRN_DAWRX0, sprs.dawrx0);
>> +	}
>
> Likewise, we need to unconditionally restore these SPRs.
>
>
>>   	mtspr(SPRN_SPRG3,	local_paca->sprg_vdso);
>>
>> -- 
>> 2.25.4
>>
Thanks
Pratik
