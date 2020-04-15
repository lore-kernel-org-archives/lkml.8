Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F19BC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 22:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FC5E20784
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 22:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725856AbgDOWIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 18:08:19 -0400
Received: from gate.crashing.org ([63.228.1.57]:56671 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbgDOWHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 18:07:35 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 03FM6sb4027212;
        Wed, 15 Apr 2020 17:06:54 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 03FM6rJd027211;
        Wed, 15 Apr 2020 17:06:53 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Wed, 15 Apr 2020 17:06:52 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/uaccess: Use flexible addressing with __put_user()/__get_user()
Message-ID: <20200415220652.GW26902@gate.crashing.org>
References: <4fdc2aba6f5e51887d1cd0fee94be0989eada2cd.1586942312.git.christophe.leroy@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fdc2aba6f5e51887d1cd0fee94be0989eada2cd.1586942312.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Wed, Apr 15, 2020 at 09:20:26AM +0000, Christophe Leroy wrote:
> At the time being, __put_user()/__get_user() and friends only use
> register indirect with immediate index addressing, with the index
> set to 0. Ex:
> 
> 	lwz	reg1, 0(reg2)

This is called a "D-form" instruction, or sometimes "offset addressing".
Don't talk about an "index", it confuses things, because the *other*
kind is called "indexed" already, also in the ISA docs!  (X-form, aka
indexed addressing, [reg+reg], where D-form does [reg+imm], and both
forms can do [reg]).

> Give the compiler the opportunity to use other adressing modes
> whenever possible, to get more optimised code.

Great :-)

> --- a/arch/powerpc/include/asm/uaccess.h
> +++ b/arch/powerpc/include/asm/uaccess.h
> @@ -114,7 +114,7 @@ extern long __put_user_bad(void);
>   */
>  #define __put_user_asm(x, addr, err, op)			\
>  	__asm__ __volatile__(					\
> -		"1:	" op " %1,0(%2)	# put_user\n"		\
> +		"1:	" op "%U2%X2 %1,%2	# put_user\n"	\
>  		"2:\n"						\
>  		".section .fixup,\"ax\"\n"			\
>  		"3:	li %0,%3\n"				\
> @@ -122,7 +122,7 @@ extern long __put_user_bad(void);
>  		".previous\n"					\
>  		EX_TABLE(1b, 3b)				\
>  		: "=r" (err)					\
> -		: "r" (x), "b" (addr), "i" (-EFAULT), "0" (err))
> +		: "r" (x), "m" (*addr), "i" (-EFAULT), "0" (err))

%Un on an "m" operand doesn't do much: you need to make it "m<>" if you
want pre-modify ("update") insns to be generated.  (You then will want
to make sure that operand is used in a way GCC can understand; since it
is used only once here, that works fine).

> @@ -130,8 +130,8 @@ extern long __put_user_bad(void);
>  #else /* __powerpc64__ */
>  #define __put_user_asm2(x, addr, err)				\
>  	__asm__ __volatile__(					\
> -		"1:	stw %1,0(%2)\n"				\
> -		"2:	stw %1+1,4(%2)\n"			\
> +		"1:	stw%U2%X2 %1,%2\n"			\
> +		"2:	stw%U2%X2 %L1,%L2\n"			\
>  		"3:\n"						\
>  		".section .fixup,\"ax\"\n"			\
>  		"4:	li %0,%3\n"				\
> @@ -140,7 +140,7 @@ extern long __put_user_bad(void);
>  		EX_TABLE(1b, 4b)				\
>  		EX_TABLE(2b, 4b)				\
>  		: "=r" (err)					\
> -		: "r" (x), "b" (addr), "i" (-EFAULT), "0" (err))
> +		: "r" (x), "m" (*addr), "i" (-EFAULT), "0" (err))

Here, it doesn't work.  You don't want two consecutive update insns in
any case.  Easiest is to just not use "m<>", and then, don't use %Un
(which won't do anything, but it is confusing).

Same for the reads.

Rest looks fine, and update should be good with that fixed as said.

Reviewed-by: Segher Boessenkool <segher@kernel.crashing.org>


Segher
