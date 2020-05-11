Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECB8C54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 07:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 329B724960
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 07:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbgEKHim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 03:38:42 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:51535 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728638AbgEKHii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 03:38:38 -0400
Received: from [192.168.0.3] (ip5f5af07e.dynamic.kabel-deutschland.de [95.90.240.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 350442002EE14;
        Mon, 11 May 2020 09:38:35 +0200 (CEST)
Subject: Re: [PATCH] x86/tsc: Use hard-coded crystal clock for Skylake mobile
To:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc:     Radoslaw Biernacki <biernacki@google.com>,
        Ross Zwisler <zwisler@google.com>,
        Daniel Drake <drake@endlessm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Len Brown <len.brown@intel.com>, linux@endlessm.com,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200509113717.9084-1-pmenzel@molgen.mpg.de>
 <87eerr3ppb.fsf@nanos.tec.linutronix.de>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <edc5af47-27e6-753f-c095-bd3087942690@molgen.mpg.de>
Date:   Mon, 11 May 2020 09:38:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <87eerr3ppb.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Thomas,


Thank you for the quick reply.

Am 11.05.20 um 09:17 schrieb Thomas Gleixner:

> Paul Menzel <pmenzel@molgen.mpg.de> writes:
> 
> please send patches to LKML and not offlist.

Sorry about that. From `MAINTAINERS` I thought x86@kernel.org is wanted. 
Other subsystems list LKML explicitly there.

>> From: Radoslaw Biernacki <biernacki@google.com>
>>
>> @@ -636,10 +636,24 @@ unsigned long native_calibrate_tsc(void)
>>   	 * Denverton SoCs don't report crystal clock, and also don't support
>>   	 * CPUID.0x16 for the calculation below, so hardcode the 25MHz crystal
>>   	 * clock.
>> +	 * Also estimation code is not reliable and gives 1.5%  difference for
>> +	 * tsc/clock ratio on Skylake mobile. Therefore below is a hardcoded
>> +	 * crystal frequency for Skylake which was removed by upstream commit
>> +	 * "x86/tsc: Use CPUID.0x16 to calculate missing crystal frequency"
>> +	 * This is temporary workaround for bugs:
>> +	 * b/148108096, b/154283905, b/146787525, b/153400677, b/148178929
>> +	 * chromium/1031054
>>   	 */
>> -	if (crystal_khz == 0 &&
>> -			boot_cpu_data.x86_model == INTEL_FAM6_ATOM_GOLDMONT_D)
>> -		crystal_khz = 25000;
>> +	if (crystal_khz == 0) {
>> +		switch (boot_cpu_data.x86_model) {
>> +		case INTEL_FAM6_SKYLAKE_MOBILE:
>> +			crystal_khz = 24000;	/* 24.0 MHz */
>> +			break;
>> +		case INTEL_FAM6_ATOM_GOLDMONT_X:
>> +			crystal_khz = 25000;	/* 25.0 MHz */
>> +			break;
>> +		}
> 
> Aside of being a workaround for Google issues which are probably caused > by broken BIOSes

Even if it was caused by broken firmware, wouldn’t Linux’ no regression 
policy still consider this a regression as user should be able to the 
Linux kernel “no matter what”?

> that patch is broken.
> 
>     INTEL_FAM6_ATOM_GOLDMONT_D != INTEL_FAM6_ATOM_GOLDMONT_X

Good catch. The commit didn’t apply cleanly to the master branch, and I 
missed this.

I’ll wait for Radoslaw to comment before proceeding further with this.


Kind regards,

Paul
