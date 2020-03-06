Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BA2C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 09:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2E01207FD
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 09:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbgCFJO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 04:14:58 -0500
Received: from ZXSHCAS2.zhaoxin.com ([203.148.12.82]:28090 "EHLO
        ZXSHCAS2.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725855AbgCFJO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 04:14:58 -0500
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS2.zhaoxin.com
 (10.28.252.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Fri, 6 Mar
 2020 17:14:54 +0800
Received: from [10.32.64.44] (10.32.64.44) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Fri, 6 Mar
 2020 17:14:52 +0800
Subject: Re: [PATCH] x86/Kconfig: Make X86_UMIP to cover Zhaoxin CPUs too
To:     Sean Christopherson <sean.j.christopherson@intel.com>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>, <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <DavidWang@zhaoxin.com>, <CooperYan@zhaoxin.com>,
        <QiyuanWang@zhaoxin.com>, <HerryYang@zhaoxin.com>
References: <1583288285-2804-1-git-send-email-TonyWWang-oc@zhaoxin.com>
 <20200304171336.GD21662@linux.intel.com>
 <c3d9ad69-4a49-19de-1680-84f7d5afeb81@zhaoxin.com>
 <20200305155909.GD11500@linux.intel.com>
From:   Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Message-ID: <47df634b-d13b-5a5e-c7a4-e6f674d7fdd0@zhaoxin.com>
Date:   Fri, 6 Mar 2020 17:14:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200305155909.GD11500@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.32.64.44]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03/2020 23:59, Sean Christopherson wrote:
> On Thu, Mar 05, 2020 at 11:40:02AM +0800, Tony W Wang-oc wrote:
>>
>> On 05/03/2020 01:13, Sean Christopherson wrote:
>>> On Wed, Mar 04, 2020 at 10:18:05AM +0800, Tony W Wang-oc wrote:
>>>> New Zhaoxin family 7 CPUs support the UMIP (User-Mode Instruction
>>>> Prevention) feature. So, modify X86_UMIP depends on Zhaoxin CPUs too.
>>>>
>>>> Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
>>>> ---
>>>>  arch/x86/Kconfig | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>>>> index 16a4b39..ca4beb8 100644
>>>> --- a/arch/x86/Kconfig
>>>> +++ b/arch/x86/Kconfig
>>>> @@ -1877,7 +1877,7 @@ config X86_SMAP
>>>>  
>>>>  config X86_UMIP
>>>>  	def_bool y
>>>> -	depends on CPU_SUP_INTEL || CPU_SUP_AMD
>>>> +	depends on CPU_SUP_INTEL || CPU_SUP_AMD || CPU_SUP_CENTAUR || CPU_SUP_ZHAOXIN
>>>
>>> The changelog only mentions Zhaoxin, but this also adds Centaur...
>>
>> Sorry for this. Some Centaur family 7 CPUs also support the UMIP
>> feature, so will resend this patch as a patch series.
> 
> Oooh, can you point me at architectural documentation for Centaur family 7?
> I've been trying to track down Centaur documentation for CPUID behavior.
> .
> 

Centaur uses CPUID.(EAX=7,ECX=0):ECX[bit 2] indicates UMIP feature, that
is compatible with Intel's UMIP implementation.

Sincerely
TonyWWang-oc
