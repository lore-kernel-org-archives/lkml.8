Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC9FC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 09:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20F0820784
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 09:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="XH7zg2Fd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731982AbgDAJU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 05:20:27 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:11052 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbgDAJU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 05:20:27 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48sgf04npTz9txmT;
        Wed,  1 Apr 2020 11:20:24 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=XH7zg2Fd; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id LrwWMFl3-E7n; Wed,  1 Apr 2020 11:20:24 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48sgf03bt7z9txmS;
        Wed,  1 Apr 2020 11:20:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1585732824; bh=RdCwVqnG+mgvh3hfqg59yovpqSaBby3zvQrIMEdmRpE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=XH7zg2FdzF2RS35R/gIrtumJIqP3Hvo83KJDW/dz5mimMYkfSu70Y9/6Z3S7O7zWF
         u3dRyixL/1pDSpdDRPVf7qpFVRl4MtL/BvgBVf2Wbrm7a84WGCc54DXbhndSfyAA63
         k8TrANwQfZKZ+/lVsp6SHURFcLuGb03DN02KwiHw=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 986F98B7B9;
        Wed,  1 Apr 2020 11:20:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id N0fWgGw9nX-y; Wed,  1 Apr 2020 11:20:25 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 61D468B752;
        Wed,  1 Apr 2020 11:20:21 +0200 (CEST)
Subject: Re: [PATCH v2 13/16] powerpc/watchpoint: Prepare handler to handle
 more than one watcnhpoint
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     mpe@ellerman.id.au, mikey@neuling.org, apopple@linux.ibm.com,
        paulus@samba.org, npiggin@gmail.com,
        naveen.n.rao@linux.vnet.ibm.com, peterz@infradead.org,
        jolsa@kernel.org, oleg@redhat.com, fweisbec@gmail.com,
        mingo@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20200401061309.92442-1-ravi.bangoria@linux.ibm.com>
 <20200401061309.92442-14-ravi.bangoria@linux.ibm.com>
 <6b89991b-481a-8cbd-b5b7-559e5e16cf92@c-s.fr>
 <cb2c250b-c963-45fe-f3b4-879076c495ab@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <78559ff4-c2c3-e652-a906-8f40673b53d6@c-s.fr>
Date:   Wed, 1 Apr 2020 11:20:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <cb2c250b-c963-45fe-f3b4-879076c495ab@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 01/04/2020 à 11:13, Ravi Bangoria a écrit :
> 
> 
> On 4/1/20 12:20 PM, Christophe Leroy wrote:
>>
>>
>> Le 01/04/2020 à 08:13, Ravi Bangoria a écrit :
>>> Currently we assume that we have only one watchpoint supported by hw.
>>> Get rid of that assumption and use dynamic loop instead. This should
>>> make supporting more watchpoints very easy.
>>>
>>> With more than one watchpoint, exception handler need to know which
>>> DAWR caused the exception, and hw currently does not provide it. So
>>> we need sw logic for the same. To figure out which DAWR caused the
>>> exception, check all different combinations of user specified range,
>>> dawr address range, actual access range and dawrx constrains. For ex,
>>> if user specified range and actual access range overlaps but dawrx is
>>> configured for readonly watchpoint and the instruction is store, this
>>> DAWR must not have caused exception.
>>>
>>> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
>>> ---
>>>   arch/powerpc/include/asm/processor.h |   2 +-
>>>   arch/powerpc/include/asm/sstep.h     |   2 +
>>>   arch/powerpc/kernel/hw_breakpoint.c  | 396 +++++++++++++++++++++------
>>>   arch/powerpc/kernel/process.c        |   3 -
>>>   4 files changed, 313 insertions(+), 90 deletions(-)
>>>
>>
>> [...]
>>
>>> -static bool
>>> -dar_range_overlaps(unsigned long dar, int size, struct 
>>> arch_hw_breakpoint *info)
>>> +static bool dar_user_range_overlaps(unsigned long dar, int size,
>>> +                    struct arch_hw_breakpoint *info)
>>>   {
>>>       return ((dar <= info->address + info->len - 1) &&
>>>           (dar + size - 1 >= info->address));
>>>   }
>>
>> Here and several other places, I think it would be more clear if you 
>> could avoid the - 1 :
>>
>>      return ((dar < info->address + info->len) &&
>>          (dar + size > info->address));
> 
> Ok. see below...
> 
>>
>>
>>> +static bool dar_in_hw_range(unsigned long dar, struct 
>>> arch_hw_breakpoint *info)
>>> +{
>>> +    unsigned long hw_start_addr, hw_end_addr;
>>> +
>>> +    hw_start_addr = ALIGN_DOWN(info->address, HW_BREAKPOINT_SIZE);
>>> +    hw_end_addr = ALIGN(info->address + info->len, 
>>> HW_BREAKPOINT_SIZE) - 1;
>>> +
>>> +    return ((hw_start_addr <= dar) && (hw_end_addr >= dar));
>>> +}
>>
>>      hw_end_addr = ALIGN(info->address + info->len, HW_BREAKPOINT_SIZE);
>>
>>      return ((hw_start_addr <= dar) && (hw_end_addr > dar));
> 
> I'm using -1 while calculating end address is to make it
> inclusive. If I don't use -1, the end address points to a
> location outside of actual range, i.e. it's not really an
> end address.

But that's what is done is several places, for instance:

https://elixir.bootlin.com/linux/v5.6/source/arch/powerpc/mm/dma-noncoherent.c#L22

https://elixir.bootlin.com/linux/v5.6/source/arch/powerpc/include/asm/book3s/32/kup.h#L92

In several places like this, end is outside of the range. My feeling is 
that is helps with readability.

Christophe
