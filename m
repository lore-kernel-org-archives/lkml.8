Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B7BC33CAF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 01:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 831AE20728
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 01:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388281AbgAQB3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 20:29:52 -0500
Received: from ZXSHCAS1.zhaoxin.com ([203.148.12.81]:54065 "EHLO
        ZXSHCAS1.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730070AbgAQB3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 20:29:49 -0500
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS1.zhaoxin.com
 (10.28.252.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Fri, 17 Jan
 2020 09:29:46 +0800
Received: from [10.32.64.11] (10.32.64.11) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Fri, 17 Jan
 2020 09:29:39 +0800
Subject: Re: [PATCH] x86/speculation/spectre_v2: Exclude Zhaoxin CPUs from
 SPECTRE_V2
To:     Thomas Gleixner <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <hpa@zytor.com>, <x86@kernel.org>,
        <luto@kernel.org>, <pawan.kumar.gupta@linux.intel.com>,
        <peterz@infradead.org>, <fenghua.yu@intel.com>,
        <vineela.tummalapalli@intel.com>, <linux-kernel@vger.kernel.org>
CC:     <DavidWang@zhaoxin.com>, <CooperYan@zhaoxin.com>,
        <QiyuanWang@zhaoxin.com>, <HerryYang@zhaoxin.com>
References: <1579146434-2668-1-git-send-email-TonyWWang-oc@zhaoxin.com>
 <87r1zzuy48.fsf@nanos.tec.linutronix.de>
From:   Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Message-ID: <b61738fe-4a2f-db39-4740-8c4a4ee5d91d@zhaoxin.com>
Date:   Fri, 17 Jan 2020 09:29:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87r1zzuy48.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.32.64.11]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/01/2020 01:09, Thomas Gleixner wrote:
> Tony,
> 
> Tony W Wang-oc <TonyWWang-oc@zhaoxin.com> writes:
> 
>> @@ -1023,6 +1023,7 @@ static void identify_cpu_without_cpuid(struct cpuinfo_x86 *c)
>>  #define MSBDS_ONLY		BIT(5)
>>  #define NO_SWAPGS		BIT(6)
>>  #define NO_ITLB_MULTIHIT	BIT(7)
>> +#define NO_SPECTRE_V2		BIT(8)
>>  
>>  #define VULNWL(_vendor, _family, _model, _whitelist)	\
>>  	{ X86_VENDOR_##_vendor, _family, _model, X86_FEATURE_ANY, _whitelist }
>> @@ -1084,6 +1085,10 @@ static const __initconst struct x86_cpu_id cpu_vuln_whitelist[] = {
>>  	/* FAMILY_ANY must be last, otherwise 0x0f - 0x12 matches won't work */
>>  	VULNWL_AMD(X86_FAMILY_ANY,	NO_MELTDOWN | NO_L1TF | NO_MDS | NO_SWAPGS | NO_ITLB_MULTIHIT),
>>  	VULNWL_HYGON(X86_FAMILY_ANY,	NO_MELTDOWN | NO_L1TF | NO_MDS | NO_SWAPGS | NO_ITLB_MULTIHIT),
>> +
>> +	/* Zhaoxin Family 7 */
>> +	VULNWL(CENTAUR,	7, X86_MODEL_ANY,	NO_SPECTRE_V2),
>> +	VULNWL(ZHAOXIN,	7, X86_MODEL_ANY,	NO_SPECTRE_V2),
>>  	{}
>>  };
>>  
>> @@ -1116,7 +1121,9 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
>>  		return;
>>  
>>  	setup_force_cpu_bug(X86_BUG_SPECTRE_V1);
>> -	setup_force_cpu_bug(X86_BUG_SPECTRE_V2);
>> +
>> +	if (!cpu_matches(NO_SPECTRE_V2))
>> +		setup_force_cpu_bug(X86_BUG_SPECTRE_V2);
> 
> That's way better. But as you might have noticed yourself this conflicts
> with the other patch which excludes these machines from the SWAPGS bug.
> 
> Granted it's a trivial conflict, but maintainers are not there to mop up
> the mess others create. So the right thing here is to resend both
> patches as a patch series with the conflict properly resolved.
> 

Sorry for this conflict. Will resend these two patches as a patch set.

Sincerely
TonyWWang-oc
