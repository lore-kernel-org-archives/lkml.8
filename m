Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FF6C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 20:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29AA32054F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 20:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgEMU6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 16:58:01 -0400
Received: from foss.arm.com ([217.140.110.172]:53488 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbgEMU6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 16:58:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8048230E;
        Wed, 13 May 2020 13:57:59 -0700 (PDT)
Received: from [10.57.36.85] (unknown [10.57.36.85])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD0923F68F;
        Wed, 13 May 2020 13:57:57 -0700 (PDT)
Subject: Re: [RFC PATCH] arm: Don't trap conditional UDF instructions
To:     Fredrik Strupe <fredrik@strupe.net>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
        Richard Fontana <rfontana@redhat.com>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Enrico Weigelt <info@metux.net>,
        linux-arm-kernel@lists.infradead.org
References: <b2042f19-9477-272c-0989-d6cab1572cca@strupe.net>
 <20200513181209.GM1551@shell.armlinux.org.uk>
 <9fba4d17-d826-6a3a-86fc-60977aa6cc9e@strupe.net>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <d2171942-e4b4-4441-b3ba-b5c16c06c2a2@arm.com>
Date:   Wed, 13 May 2020 21:57:54 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <9fba4d17-d826-6a3a-86fc-60977aa6cc9e@strupe.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-13 7:56 pm, Fredrik Strupe wrote:
> On 13.05.2020 20:12, Russell King - ARM Linux admin wrote:
>> On Wed, May 13, 2020 at 05:41:58PM +0200, Fredrik Strupe wrote:
>>> Hi,
>>>
>>> This is more of a question than a patch, but I hope the attached patch makes
>>> the issue a bit clearer.
>>>
>>> The arm port of Linux supports hooking/trapping of undefined instructions. Some
>>> parts of the code use this to trap UDF instructions with certain immediates in
>>> order to use them for other purposes, like 'UDF #16' which is equivalent to a
>>> BKPT instruction in A32.
>>>
>>> Moreover, most of the undef hooks on UDF instructions assume that UDF is
>>> conditional and mask out the condition prefix during matching. The attached
>>> patch shows the locations where this happens. However, the Arm architecture
>>> reference manual explicitly states that UDF is *not* conditional, making
>>> any instruction encoding with a condition prefix other than 0xe (always
>>> execute) unallocated.
>>
>> The latest version of the ARM architecture reference manual may say
>> that, but earlier versions say different things. The latest reference
>> manual does not apply to earlier architectures, so if you're writing
>> code to cover multiple different architectures, you must have an
>> understanding of each of those architectures.
>>
>> So, from the code:
>>
>> 	ARM:   xxxx 0111 1111 xxxx xxxx xxxx 1111 xxxx
>>
>>  From DDI0100E:
>>
>> 3.13.1 Undefined instruction space
>>         Instructions with the following opcodes are undefined
>>         instruction space:
>>
>>         opcode[27:25] = 0b011
>>         opcode[4] = 1
>>
>>         31 28 27 26 25 24                                     5 4 3     0
>>         cond  0  1  1  x  x x x x x x x x x x x x x x x x x x x 1 x x x x
>>
>> So, in this version of the architecture, undefined instructions may
>> be conditional - and indeed that used to be the case.  The condition
>> code was always respected, and cond=1111 meant "never" (NV).
>>
>> Hence, trapping them if the condition code is not 1110 (AL) is
>> entirely reasonable, legal and safe.  If an ARM CPU defines an
>> instruction coding that matches the above, then it won't take the
>> undefined instruction trap, and we'll never see it.
>>
>> Now, as for UDF usage in the kernel, it may be quite correct that we
>> always use the AL condition code for them, but it would be very odd
>> for there to be an instruction implemented with a different (non-NV)
>> condition code that can't also have it's AL condition code encoding.
>> You could never execute such an instruction unconditionally.
>>
> 
> That makes sense. Thank you very much for a great answer!

The other subtlety is that UDF is a *mnemonic* for a specific encoding 
with cond=0b1110, thus "conditional UDF" is an oxymoron. You can still 
have a conditional instruction from the "permanently undefined" space 
(although on Armv7-A it's implementation-defined whether it causes an 
exception regardless of the condition), it's just not a UDF.

Robin.
