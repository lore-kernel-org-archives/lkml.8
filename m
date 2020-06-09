Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE05C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 15:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DD0120734
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 15:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730718AbgFIPKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 11:10:38 -0400
Received: from foss.arm.com ([217.140.110.172]:43834 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726903AbgFIPKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 11:10:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DE891FB;
        Tue,  9 Jun 2020 08:10:35 -0700 (PDT)
Received: from [10.37.12.139] (unknown [10.37.12.139])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 777CC3F66F;
        Tue,  9 Jun 2020 08:10:33 -0700 (PDT)
Subject: Re: [PATCH v6] s390: Fix vDSO clock_getres()
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
References: <20200324121027.21665-1-vincenzo.frascino@arm.com>
 <20200609144608.GB4575@osiris>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <fefd4ba9-6e00-5aba-ac95-b1fbf7e1bf13@arm.com>
Date:   Tue, 9 Jun 2020 16:12:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200609144608.GB4575@osiris>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On 6/9/20 3:46 PM, Heiko Carstens wrote:
> Hello Vincenzo,
> 
> sorry it took such a long time to answer!
> 
>> clock_getres in the vDSO library has to preserve the same behaviour
>> of posix_get_hrtimer_res().
>>
>> In particular, posix_get_hrtimer_res() does:
>>     sec = 0;
>>     ns = hrtimer_resolution;
>> and hrtimer_resolution depends on the enablement of the high
>> resolution timers that can happen either at compile or at run time.
>>
>> Fix the s390 vdso implementation of clock_getres keeping a copy of
>> hrtimer_resolution in vdso data and using that directly.
>>
>> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
>> Cc: Vasily Gorbik <gor@linux.ibm.com>
>> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>> Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
>> ---
>>  arch/s390/include/asm/vdso.h           |  1 +
>>  arch/s390/kernel/asm-offsets.c         |  2 +-
>>  arch/s390/kernel/time.c                |  1 +
>>  arch/s390/kernel/vdso64/clock_getres.S | 10 +++++-----
>>  4 files changed, 8 insertions(+), 6 deletions(-)
> ...
> 
>> diff --git a/arch/s390/kernel/vdso64/clock_getres.S b/arch/s390/kernel/vdso64/clock_getres.S
>> index 081435398e0a..022b58c980db 100644
>> --- a/arch/s390/kernel/vdso64/clock_getres.S
>> +++ b/arch/s390/kernel/vdso64/clock_getres.S
>> @@ -17,12 +17,14 @@
>>  	.type  __kernel_clock_getres,@function
>>  __kernel_clock_getres:
>>  	CFI_STARTPROC
>> -	larl	%r1,4f
>> +	larl	%r1,3f
>> +	lg	%r0,0(%r1)
>>  	cghi	%r2,__CLOCK_REALTIME_COARSE
>>  	je	0f
>>  	cghi	%r2,__CLOCK_MONOTONIC_COARSE
>>  	je	0f
>> -	larl	%r1,3f
>> +	larl	%r1,_vdso_data
>> +	l	%r0,__VDSO_CLOCK_REALTIME_RES(%r1)
> 
> This should be llgf for proper zero extension. The code works anyway,
> since the upper lg would clear the high order bits, however this looks
> like it works more or less by accident ;)
> 
> I changed it and applied your patch. Thanks a lot!

Thank you for this and for the explanation. I must admit that this was the first
attempt to write s390 assembly. I had to go through most of the "Principles of
Operation" before I could get something meaningful going ;)

> 

-- 
Regards,
Vincenzo

P.S. Now I can finally say that once in my life I wrote s390 assembler ;)
