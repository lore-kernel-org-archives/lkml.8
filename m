Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98AD2C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B764206B7
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729917AbgGBPNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 11:13:40 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:59909 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729439AbgGBPNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 11:13:40 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49yM740VqWz9v2nf;
        Thu,  2 Jul 2020 17:13:36 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Qu-mGGqH2LKJ; Thu,  2 Jul 2020 17:13:35 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49yM735TG1z9v2nX;
        Thu,  2 Jul 2020 17:13:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CD50B8B9A0;
        Thu,  2 Jul 2020 17:13:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id MOh1RW9HUzGe; Thu,  2 Jul 2020 17:13:37 +0200 (CEST)
Received: from [10.25.210.22] (po15451.idsi0.si.c-s.fr [10.25.210.22])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 978428B99A;
        Thu,  2 Jul 2020 17:13:37 +0200 (CEST)
Subject: Re: objtool clac/stac handling change..
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wjc-ktbOr7ZHMY8gfAmHxUK+aMdDsQjeh+BvmQwnQfN_g@mail.gmail.com>
 <20200701184131.GI2786714@ZenIV.linux.org.uk>
 <CAHk-=wj_2v9m+yZioE4vOLGW1mc9SBa5+++LdeJ86aEeB5OXcw@mail.gmail.com>
 <20200701195914.GK2786714@ZenIV.linux.org.uk>
 <CAHk-=wj-CYhKZR8ZKQgi=VTx=o7n6dtwPXikvgkJ3SdiqRPd8A@mail.gmail.com>
 <87lfk26nx4.fsf@mpe.ellerman.id.au>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <8be7cf19-9fc9-ce9c-091f-c8824a01a3c8@csgroup.eu>
Date:   Thu, 2 Jul 2020 17:13:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87lfk26nx4.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 02/07/2020 à 15:34, Michael Ellerman a écrit :
> Linus Torvalds <torvalds@linux-foundation.org> writes:
>> On Wed, Jul 1, 2020 at 12:59 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>>> On Wed, Jul 01, 2020 at 12:04:36PM -0700, Linus Torvalds wrote:
>>>>
>>>> That's actually for the access granting. Shutting the access down ends
>>>> up always doing the same thing anyway..
>>>
>>> #define user_read_access_end            prevent_current_read_from_user
>>> #define user_write_access_end           prevent_current_write_to_user
>>> static inline void prevent_current_read_from_user(void)
>>> {
>>>          prevent_user_access(NULL, NULL, ~0UL, KUAP_CURRENT_READ);
>>> }
>>>
>>> static inline void prevent_current_write_to_user(void)
>>> {
>>>          prevent_user_access(NULL, NULL, ~0UL, KUAP_CURRENT_WRITE);
>>> }
>>>
>>> and prevent_user_access() has instances that do care about the direction...
>>
>> Go and look closer.
>>
>> There are three cases:
>>
>>   (a) the 32-bit book3s case. It looks like it cares, but when you look
>> closer, it ends up not caring about the read side, and saving the
>> "which address to I allow user writes to" in current->thread.kuap
>>
>>   (b) the nohash 32-bit case - doesn't care
>>
>>   (c) the 64-bit books case - doesn't care
>>
>> So yes, in the (a) case it does make a difference between reads and
>> writes, but at least as far as I can tell, it ignores the read case,
>> and has code to avoid the unnecessary "disable user writes" case when
>> there was only a read enable done.
> 
> Yeah that's my understanding too.
> 
> Christophe is the expert on that code so I'll defer to him if I'm wrong.
> 
>> Now, it's possible that I'm wrong, but the upshot of that is that even
>> on powerpc, I think that if we just made the rule be that "taking a
>> user exception should automatically do the 'user_access_end()' for us"
>> is trivial.
> 
> I think we can do something to make it work.
> 
> We don't have an equivalent of x86's ex_handler_uaccess(), so it's not
> quite as easy as whacking a user_access_end() in there.

Isn't it something easy to do in bad_page_fault() ?

Not exactly a call to user_access_end() but altering regs->kuap so that 
user access is not restored on exception exit.

> 
> Probably the simplest option for us is to just handle it in our
> unsafe_op_wrap(). I'll try and come up with something tomorrow.

unsafe_op_wrap() is not used anymore for unsafe_put_user() as we are now 
using asm goto.

Christophe
