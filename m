Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA9AC2BA2B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 12:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58B0520709
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 12:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgDLMSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 08:18:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44744 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726689AbgDLMSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 08:18:52 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03CC4ZnT095482
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 08:18:51 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30ba1ft492-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 08:18:51 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <psampat@linux.ibm.com>;
        Sun, 12 Apr 2020 13:18:17 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 12 Apr 2020 13:18:15 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03CCIkcd50200792
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 12 Apr 2020 12:18:46 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 098E7AE055;
        Sun, 12 Apr 2020 12:18:46 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3F30AAE045;
        Sun, 12 Apr 2020 12:18:44 +0000 (GMT)
Received: from [9.79.189.139] (unknown [9.79.189.139])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 12 Apr 2020 12:18:44 +0000 (GMT)
Subject: Re: [RFC 1/3] Interface for an idle-stop dependency structure
To:     ego@linux.vnet.ibm.com
Cc:     linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
        mpe@ellerman.id.au, mikey@neuling.org, npiggin@gmail.com,
        vaidy@linux.ibm.com, skiboot@lists.ozlabs.org, oohall@gmail.com,
        pratik.r.sampat@gmail.com
References: <cover.1583332695.git.psampat@linux.ibm.com>
 <80c7a6ae66ab25bd088beaa3bd5c69f3b1352ac2.1583332695.git.psampat@linux.ibm.com>
 <20200408105140.GD950@in.ibm.com>
From:   Pratik Sampat <psampat@linux.ibm.com>
Date:   Sun, 12 Apr 2020 17:48:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200408105140.GD950@in.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 20041212-0016-0000-0000-000003032452
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20041212-0017-0000-0000-000033671226
Message-Id: <d2af70ee-6927-c29e-a7cb-a5dbd7c05c31@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-12_02:2020-04-11,2020-04-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 adultscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 suspectscore=1 impostorscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004120106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Gautham

On 08/04/20 4:21 pm, Gautham R Shenoy wrote:
> Hi Pratik,
>
> On Wed, Mar 04, 2020 at 09:31:21PM +0530, Pratik Rajesh Sampat wrote:
>> Design patch to introduce the idea of having a dependency structure for
>> idle-stop. The structure encapsulates the following:
>> 1. Bitmask for version of idle-stop
>> 2. Bitmask for propterties like ENABLE/DISABLE
>> 3. Function pointer which helps handle how the stop must be invoked
>>
>> The commit lays a foundation for other idle-stop versions to be added
>> and handled cleanly based on their specified requirments.
>> Currently it handles the existing "idle-stop" version by setting the
>> discovery bits and the function pointer.
> So, if this patch is applied, and we are running with an OPAL that
> doesn't publish the "idle-stop" dt-cpu-feature, then the goal is to
> not enable any stop states. Is this correct ?
>
Yes, all states will be disabled with no power saving.

>> Signed-off-by: Pratik Rajesh Sampat <psampat@linux.ibm.com>
>> ---
>>   arch/powerpc/include/asm/processor.h  | 17 +++++++++++++++++
>>   arch/powerpc/kernel/dt_cpu_ftrs.c     |  5 +++++
>>   arch/powerpc/platforms/powernv/idle.c | 17 +++++++++++++----
>>   drivers/cpuidle/cpuidle-powernv.c     |  3 ++-
>>   4 files changed, 37 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
>> index eedcbfb9a6ff..da59f01a5c09 100644
>> --- a/arch/powerpc/include/asm/processor.h
>> +++ b/arch/powerpc/include/asm/processor.h
>> @@ -429,6 +429,23 @@ extern void power4_idle_nap(void);
>>   extern unsigned long cpuidle_disable;
>>   enum idle_boot_override {IDLE_NO_OVERRIDE = 0, IDLE_POWERSAVE_OFF};
>>
>> +#define STOP_ENABLE		0x00000001
>> +
>> +#define STOP_VERSION_P9       0x1
>> +
>> +/*
>> + * Classify the dependencies of the stop states
>> + * @idle_stop: function handler to handle the quirk stop version
>> + * @cpuidle_prop: Signify support for stop states through kernel and/or firmware
>> + * @stop_version: Classify quirk versions for stop states
>> + */
>> +typedef struct {
>> +	unsigned long (*idle_stop)(unsigned long, bool);
>> +	uint8_t cpuidle_prop;
>> +	uint8_t stop_version;
> Why do we need both cpuidle_prop and stop_version ?

The idea is that each stop_version has house multitude of overlapping properties.
So the idea is to give a clean distinction. However, I can see now that the
versioning and properties could be embedded in a single bitmask


>> @@ -657,6 +659,9 @@ static void __init cpufeatures_setup_start(u32 isa)
>>   	}
>>   }
>>
>> +stop_deps_t stop_dep = {NULL, 0x0, 0x0};
>> +EXPORT_SYMBOL(stop_dep);
>> +
>>   static bool __init cpufeatures_process_feature(struct dt_cpu_feature *f)
>>   {
>>   	const struct dt_cpu_feature_match *m;
>> diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
>> index 78599bca66c2..c32cdc37acf4 100644
>> --- a/arch/powerpc/platforms/powernv/idle.c
>> +++ b/arch/powerpc/platforms/powernv/idle.c
>> @@ -812,7 +812,7 @@ static unsigned long power9_offline_stop(unsigned long psscr)
>>
>>   #ifndef CONFIG_KVM_BOOK3S_HV_POSSIBLE
>>   	__ppc64_runlatch_off();
>> -	srr1 = power9_idle_stop(psscr, true);
>> +	srr1 = stop_dep.idle_stop(psscr, true);
>>   	__ppc64_runlatch_on();
>>   #else
>>   	/*
>> @@ -828,7 +828,7 @@ static unsigned long power9_offline_stop(unsigned long psscr)
>>   	local_paca->kvm_hstate.hwthread_state = KVM_HWTHREAD_IN_IDLE;
>>
>>   	__ppc64_runlatch_off();
>> -	srr1 = power9_idle_stop(psscr, false);
>> +	srr1 = stop_dep.idle_stop(psscr, true);
>>   	__ppc64_runlatch_on();
>>
>>   	local_paca->kvm_hstate.hwthread_state = KVM_HWTHREAD_IN_KERNEL;
>> @@ -856,7 +856,7 @@ void power9_idle_type(unsigned long stop_psscr_val,
>>   	psscr = (psscr & ~stop_psscr_mask) | stop_psscr_val;
>>
>>   	__ppc64_runlatch_off();
>> -	srr1 = power9_idle_stop(psscr, true);
>> +	srr1 = stop_dep.idle_stop(psscr, true);
>>   	__ppc64_runlatch_on();
>>
> There is one other place in arch/powerpc/kvm/book3s_hv_rmhandlers.S
> where call isa300_idle_stop_mayloss (this is kvm_nap_sequence).
>
> So, if stop states are not supported, then, KVM subsystem should know
> about it. Some KVM configurations depend on putting the secondary
> threads of the core offline into an idle state whose wakeup is from
> 0x100 vector. Your patch doesn't address that part.
>
Sure, I'll make sure to address it there too.

>
>>   		goto out;
>> +	switch(stop_dep.stop_version) {
>> +	case STOP_VERSION_P9:
>> +		stop_dep.idle_stop = power9_idle_stop;
>> +		break;
>> +	default:
>> +		stop_dep.idle_stop = NULL;
> You should add a pr_warn() here that stop state isn't supported
> because the kernel doesn't know about the version.
>
Sure


Thanks
Pratik

