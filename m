Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00375C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 16:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D271021775
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 16:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbgCBQeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 11:34:03 -0500
Received: from lizzard.sbs.de ([194.138.37.39]:39945 "EHLO lizzard.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727054AbgCBQeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 11:34:03 -0500
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
        by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 022GXoxm004401
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Mar 2020 17:33:51 +0100
Received: from [139.25.68.37] ([139.25.68.37])
        by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 022GXoVW007772;
        Mon, 2 Mar 2020 17:33:50 +0100
Subject: Re: x2apic_wrmsr_fence vs. Intel manual
To:     Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <783add60-f6c7-c8c6-b369-42e5ebfbf8c9@siemens.com>
 <87lfoienjp.fsf@nanos.tec.linutronix.de>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <9a7c60d5-bbb2-98a4-4564-844f161b212c@siemens.com>
Date:   Mon, 2 Mar 2020 17:33:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87lfoienjp.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.03.20 17:20, Thomas Gleixner wrote:
> Jan Kiszka <jan.kiszka@siemens.com> writes:
>> as I generated a nice bug around fence vs. x2apic icr writes, I studied
>> the kernel code and the Intel manual in this regard more closely. But
>> there is a discrepancy:
>>
>> arch/x86/include/asm/apic.h:
>>
>> /*
>>   * Make previous memory operations globally visible before
>>   * sending the IPI through x2apic wrmsr. We need a serializing instruction or
>>   * mfence for this.
>>   */
>> static inline void x2apic_wrmsr_fence(void)
>> {
>>          asm volatile("mfence" : : : "memory");
>> }
>>
>> Intel SDM, 10.12.3 MSR Access in x2APIC Mode:
>>
>> "A WRMSR to an APIC register may complete before all preceding stores
>> are globally visible; software can prevent this by inserting a
>> serializing instruction or the sequence MFENCE;LFENCE before the WRMSR."
>>
>> The former dates back to ce4e240c279a, but that commit does not mention
>> why lfence is not needed. Did the manual read differently back then? Or
>> why are we safe? To my reading of lfence, it also has a certain
>> instruction serializing effect that mfence does not have.
> 
> The 2011 SDM says:
> 
>    A WRMSR to an APIC register may complete before all preceding stores
>    are globally visible; software can prevent this by inserting a
>    serializing instruction, an SFENCE, or an MFENCE before the WRMSR.
> 
> Sigh....
> 

OK, that explains it. Curious since when (date and CPU generation) we 
unknowingly started to play roulette here.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
