Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2132C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 18:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A5052065C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 18:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390335AbgEMS4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 14:56:13 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:48235 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732218AbgEMS4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 14:56:13 -0400
Received: from [192.168.1.123] (cm-84.210.220.251.getinternet.no [84.210.220.251])
        (Authenticated sender: fredrik@strupe.net)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 67E2C240005;
        Wed, 13 May 2020 18:56:09 +0000 (UTC)
Subject: Re: [RFC PATCH] arm: Don't trap conditional UDF instructions
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        Richard Fontana <rfontana@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>
References: <b2042f19-9477-272c-0989-d6cab1572cca@strupe.net>
 <20200513181209.GM1551@shell.armlinux.org.uk>
From:   Fredrik Strupe <fredrik@strupe.net>
Message-ID: <9fba4d17-d826-6a3a-86fc-60977aa6cc9e@strupe.net>
Date:   Wed, 13 May 2020 20:56:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200513181209.GM1551@shell.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.05.2020 20:12, Russell King - ARM Linux admin wrote:
> On Wed, May 13, 2020 at 05:41:58PM +0200, Fredrik Strupe wrote:
>> Hi,
>>
>> This is more of a question than a patch, but I hope the attached patch makes
>> the issue a bit clearer.
>>
>> The arm port of Linux supports hooking/trapping of undefined instructions. Some
>> parts of the code use this to trap UDF instructions with certain immediates in
>> order to use them for other purposes, like 'UDF #16' which is equivalent to a
>> BKPT instruction in A32.
>>
>> Moreover, most of the undef hooks on UDF instructions assume that UDF is
>> conditional and mask out the condition prefix during matching. The attached
>> patch shows the locations where this happens. However, the Arm architecture
>> reference manual explicitly states that UDF is *not* conditional, making
>> any instruction encoding with a condition prefix other than 0xe (always
>> execute) unallocated.
>
> The latest version of the ARM architecture reference manual may say
> that, but earlier versions say different things. The latest reference
> manual does not apply to earlier architectures, so if you're writing
> code to cover multiple different architectures, you must have an
> understanding of each of those architectures.
>
> So, from the code:
>
> 	ARM:   xxxx 0111 1111 xxxx xxxx xxxx 1111 xxxx
>
> From DDI0100E:
>
> 3.13.1 Undefined instruction space
>        Instructions with the following opcodes are undefined
>        instruction space:
>
>        opcode[27:25] = 0b011
>        opcode[4] = 1
>
>        31 28 27 26 25 24                                     5 4 3     0
>        cond  0  1  1  x  x x x x x x x x x x x x x x x x x x x 1 x x x x
>
> So, in this version of the architecture, undefined instructions may
> be conditional - and indeed that used to be the case.  The condition
> code was always respected, and cond=1111 meant "never" (NV).
>
> Hence, trapping them if the condition code is not 1110 (AL) is
> entirely reasonable, legal and safe.  If an ARM CPU defines an
> instruction coding that matches the above, then it won't take the
> undefined instruction trap, and we'll never see it.
>
> Now, as for UDF usage in the kernel, it may be quite correct that we
> always use the AL condition code for them, but it would be very odd
> for there to be an instruction implemented with a different (non-NV)
> condition code that can't also have it's AL condition code encoding.
> You could never execute such an instruction unconditionally.
>

That makes sense. Thank you very much for a great answer!

Fredrik

