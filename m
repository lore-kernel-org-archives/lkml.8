Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C77C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 03:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D2BD20B80
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 03:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="Mc/oOTj2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgGCDPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 23:15:14 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:54533 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbgGCDPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 23:15:13 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49yg7c4MDFz9sRW;
        Fri,  3 Jul 2020 13:15:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1593746111;
        bh=xrhV7mFpYqjEET0styJIDaaRlrdHNT2J0CceIfNA+BI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Mc/oOTj21DfwWI4SUfqYityNavn8+SAohINjgOhnU7JaC1sYq3EQdyZ30ZI8foyJZ
         haSQq0lLsZn8WebzDMiw9pFOv7YcPX6J1NSWkQcUALVfKS54vD3tl+KemFCQxiYtPO
         8dWOw02lWGbbWml9aV2aswU28DLUbg9Xrzi1HAoErF0+yGaN3ykF7d+1JsdEWSxVtd
         BpL3RQG9AtZxOEVFoO4x8eGEGdnJmKJNqoFmgJcwQGKek2mXYwWk7/LPK8FbTg5YwR
         vAY0tLuG5veJyQ1E3LXzFybgdfwmWDA11O7VSFG6eu6e1Xn261TvoBUUkOqo1xyHzo
         INWzQ8orwk33A==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: objtool clac/stac handling change..
In-Reply-To: <8be7cf19-9fc9-ce9c-091f-c8824a01a3c8@csgroup.eu>
References: <CAHk-=wjc-ktbOr7ZHMY8gfAmHxUK+aMdDsQjeh+BvmQwnQfN_g@mail.gmail.com> <20200701184131.GI2786714@ZenIV.linux.org.uk> <CAHk-=wj_2v9m+yZioE4vOLGW1mc9SBa5+++LdeJ86aEeB5OXcw@mail.gmail.com> <20200701195914.GK2786714@ZenIV.linux.org.uk> <CAHk-=wj-CYhKZR8ZKQgi=VTx=o7n6dtwPXikvgkJ3SdiqRPd8A@mail.gmail.com> <87lfk26nx4.fsf@mpe.ellerman.id.au> <8be7cf19-9fc9-ce9c-091f-c8824a01a3c8@csgroup.eu>
Date:   Fri, 03 Jul 2020 13:17:22 +1000
Message-ID: <87h7up70e5.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 02/07/2020 =C3=A0 15:34, Michael Ellerman a =C3=A9crit=C2=A0:
>> Linus Torvalds <torvalds@linux-foundation.org> writes:
>>> On Wed, Jul 1, 2020 at 12:59 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>>>> On Wed, Jul 01, 2020 at 12:04:36PM -0700, Linus Torvalds wrote:
>>>>>
>>>>> That's actually for the access granting. Shutting the access down ends
>>>>> up always doing the same thing anyway..
>>>>
>>>> #define user_read_access_end            prevent_current_read_from_user
>>>> #define user_write_access_end           prevent_current_write_to_user
>>>> static inline void prevent_current_read_from_user(void)
>>>> {
>>>>          prevent_user_access(NULL, NULL, ~0UL, KUAP_CURRENT_READ);
>>>> }
>>>>
>>>> static inline void prevent_current_write_to_user(void)
>>>> {
>>>>          prevent_user_access(NULL, NULL, ~0UL, KUAP_CURRENT_WRITE);
>>>> }
>>>>
>>>> and prevent_user_access() has instances that do care about the directi=
on...
>>>
>>> Go and look closer.
>>>
>>> There are three cases:
>>>
>>>   (a) the 32-bit book3s case. It looks like it cares, but when you look
>>> closer, it ends up not caring about the read side, and saving the
>>> "which address to I allow user writes to" in current->thread.kuap
>>>
>>>   (b) the nohash 32-bit case - doesn't care
>>>
>>>   (c) the 64-bit books case - doesn't care
>>>
>>> So yes, in the (a) case it does make a difference between reads and
>>> writes, but at least as far as I can tell, it ignores the read case,
>>> and has code to avoid the unnecessary "disable user writes" case when
>>> there was only a read enable done.
>>=20
>> Yeah that's my understanding too.
>>=20
>> Christophe is the expert on that code so I'll defer to him if I'm wrong.
>>=20
>>> Now, it's possible that I'm wrong, but the upshot of that is that even
>>> on powerpc, I think that if we just made the rule be that "taking a
>>> user exception should automatically do the 'user_access_end()' for us"
>>> is trivial.
>>=20
>> I think we can do something to make it work.
>>=20
>> We don't have an equivalent of x86's ex_handler_uaccess(), so it's not
>> quite as easy as whacking a user_access_end() in there.
>
> Isn't it something easy to do in bad_page_fault() ?

We'd need to do it there at least.

But I'm not convinced that's the only place we'd need to do it. We could
theoretically take a machine check on a user access, and those are
handled differently on each sub-(sub-sub)-platform, and I think all or
most of them don't call bad_page_fault().

> Not exactly a call to user_access_end() but altering regs->kuap so that=20
> user access is not restored on exception exit.

Yes.

>> Probably the simplest option for us is to just handle it in our
>> unsafe_op_wrap(). I'll try and come up with something tomorrow.
>
> unsafe_op_wrap() is not used anymore for unsafe_put_user() as we are now=
=20
> using asm goto.

Sure, but we could change it back to use unsafe_op_wrap().

I did a quick hack to do that and see no difference in the generated
code, but your commit adding put_user_goto() did show better code
generation, so possibly it depends on compiler version, or my example
wasn't complicated enough (filldir()).

cheers
