Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222D3C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 14:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E69602465B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 14:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="fOVdqwxM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbgAVOpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 09:45:55 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:57540 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgAVOpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 09:45:54 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 482p9q2lNqz9v1Rw;
        Wed, 22 Jan 2020 15:45:51 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=fOVdqwxM; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id zYe3Aaqe7DY8; Wed, 22 Jan 2020 15:45:51 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 482p9q1RXbz9v1Rv;
        Wed, 22 Jan 2020 15:45:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1579704351; bh=juzR+YRFTPaCzQ0oEefLpxdaPNZJwaaecMFiD3I2xhk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fOVdqwxM7oxUuAUpQHFOrGHQaAQ5Ca3a1l277V7R/3mq6a//tarMYbEQTjxYja17o
         xPjWsYYL/gISQIP6gKGVyMSrAiif5toC950L6u+fg/NPFd/AI3GGl6R4xb4B7vaSQi
         xqJzkU+cY0fdTLbL1kOscEFNgf1RX+IniBenHlPQ=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 98E8D8B802;
        Wed, 22 Jan 2020 15:45:52 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id w8iI4pNtOjos; Wed, 22 Jan 2020 15:45:52 +0100 (CET)
Received: from [172.25.230.100] (po15451.idsi0.si.c-s.fr [172.25.230.100])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5B5878B7FE;
        Wed, 22 Jan 2020 15:45:52 +0100 (CET)
Subject: Re: GCC bug ? Re: [PATCH v2 10/10] powerpc/32s: Implement Kernel
 Userspace Access Protection
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, ruscur@russell.cc,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1552292207.git.christophe.leroy@c-s.fr>
 <a2847248a92cb1641b1740fa121c5a30593ae662.1552292207.git.christophe.leroy@c-s.fr>
 <87ftqfu7j1.fsf@concordia.ellerman.id.au>
 <a008a182-f1db-073c-7d38-27bfd1fd8676@c-s.fr>
 <20200121195501.GJ3191@gate.crashing.org>
 <af9ad296-401c-cb5c-868a-7a6f91d1e8bc@c-s.fr>
 <20200122133626.GL3191@gate.crashing.org>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <7e470743-b11c-81ae-fbca-c8c9aac67896@c-s.fr>
Date:   Wed, 22 Jan 2020 15:45:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200122133626.GL3191@gate.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 22/01/2020 à 14:36, Segher Boessenkool a écrit :
> On Wed, Jan 22, 2020 at 07:52:02AM +0100, Christophe Leroy wrote:
>> Le 21/01/2020 à 20:55, Segher Boessenkool a écrit :
>>> On Tue, Jan 21, 2020 at 05:22:32PM +0000, Christophe Leroy wrote:
>>>> g1() should return 3, not 5.
>>>
>>> What makes you say that?
>>
>> What makes me say that is that NULL is obviously a constant pointer and
>> I think we are all expecting gcc to see it as a constant during kernel
>> build, ie at -O2
> 
> But apparently at the point where the builtin was checked it did not
> yet know it is passed a null pointer.
> 
> Please make a self-contained test case if we need further investigation?

The test in my original mail is self-contained:


#define NULL (void*)0

static inline int f1(void *to)
{
     if (__builtin_constant_p(to) && to == NULL)
         return 3;
     return 5;
}

int g1(void)
{
     return f1(NULL);
}


Build the above with -O2 then objdump:

00000000 <g1>:
    0:    38 60 00 05     li      r3,5
    4:    4e 80 00 20     blr

It returns 5 so that shows __builtin_constant_p(to) was evaluated as false.


> 
>>> "A return of 0 does not indicate that the
>>>   value is _not_ a constant, but merely that GCC cannot prove it is a
>>>   constant with the specified value of the '-O' option."
>>>
>>> (And the rules it uses for this are *not* the same as C "constant
>>> expressions" or C "integer constant expression" or C "arithmetic
>>> constant expression" or anything like that -- which should be already
>>> obvious from that it changes with different -Ox).
>>>
>>> You can use builtin_constant_p to have the compiler do something better
>>> if the compiler feels like it, but not anything more.  Often people
>>> want stronger guarantees, but when they see how much less often it then
>>> returns "true", they do not want that either.
> 
>> If GCC doesn't see NULL as a constant, then the above doesn't work as
>> expected.
> 
> That's not the question.  Of course GCC sees it as a null pointer
> constant, because it is one.  But this builtin does its work very
> early, during preprocessing already.  Its concept of "constant" is
> very different.
> 
> Does it work if you write just "0" instead of "NULL", btw?  "0" is
> also a null pointer constant eventually (here, that is).

No it doesn't.

It works if you change the 'void *to' to 'unsigned long to'

> 
> The question is why (and if, it still needs verification after all)
> builtin_constant_p didn't return true.

I sent a patch to overcome the problem. See 
https://patchwork.ozlabs.org/patch/1227249/

Christophe
