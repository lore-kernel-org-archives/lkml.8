Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C431C2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 01:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 018A3206B9
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 01:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbgDQBjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 21:39:33 -0400
Received: from gate.crashing.org ([63.228.1.57]:52788 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbgDQBjd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 21:39:33 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 03H1d752021251;
        Thu, 16 Apr 2020 20:39:07 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 03H1d6nr021244;
        Thu, 16 Apr 2020 20:39:06 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Thu, 16 Apr 2020 20:39:06 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/uaccess: Use flexible addressing with __put_user()/__get_user()
Message-ID: <20200417013906.GK26902@gate.crashing.org>
References: <4fdc2aba6f5e51887d1cd0fee94be0989eada2cd.1586942312.git.christophe.leroy@c-s.fr> <20200415220652.GW26902@gate.crashing.org> <1f5a7975-3b32-3a14-e03e-7c875df57aa3@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1f5a7975-3b32-3a14-e03e-7c875df57aa3@c-s.fr>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Thu, Apr 16, 2020 at 07:50:00AM +0200, Christophe Leroy wrote:
> Le 16/04/2020 à 00:06, Segher Boessenkool a écrit :
> >On Wed, Apr 15, 2020 at 09:20:26AM +0000, Christophe Leroy wrote:
> >>At the time being, __put_user()/__get_user() and friends only use
> >>register indirect with immediate index addressing, with the index
> >>set to 0. Ex:
> >>
> >>	lwz	reg1, 0(reg2)
> >
> >This is called a "D-form" instruction, or sometimes "offset addressing".
> >Don't talk about an "index", it confuses things, because the *other*
> >kind is called "indexed" already, also in the ISA docs!  (X-form, aka
> >indexed addressing, [reg+reg], where D-form does [reg+imm], and both
> >forms can do [reg]).
> 
> In the "Programming Environments Manual for 32-Bit Implementations of 
> the PowerPC™ Architecture", they list the following addressing modes:
> 
> Load and store operations have three categories of effective address 
> generation that depend on the
> operands specified:
> • Register indirect with immediate index mode
> • Register indirect with index mode
> • Register indirect mode

Huh.  I must have pushed all that confusing terminology to the back of
my head :-)

> >%Un on an "m" operand doesn't do much: you need to make it "m<>" if you
> >want pre-modify ("update") insns to be generated.  (You then will want
> >to make sure that operand is used in a way GCC can understand; since it
> >is used only once here, that works fine).
> 
> Ah ? Indeed I got the idea from include/asm/io.h where there is:
> 
> #define DEF_MMIO_IN_D(name, size, insn)				\
> static inline u##size name(const volatile u##size __iomem *addr)	\
> {									\
> 	u##size ret;							\
> 	__asm__ __volatile__("sync;"#insn"%U1%X1 %0,%1;twi 0,%0,0;isync"\
> 		: "=r" (ret) : "m" (*addr) : "memory");			\
> 	return ret;							\
> }
> 
> It should be "m<>" there as well ?

Yes, that will work here.

Long ago, "m" in inline assembler code did the same as "m<>" now does
(and "m" internal in GCC still does).  To get a memory without pre-modify
addressing, you used "es".

Since people kept getting that wrong (it *is* surprising), it was changed
to the current scheme.  But the kernel uses weren't updated (and no one
seems to have missed it).

> >>  #else /* __powerpc64__ */
> >>  #define __put_user_asm2(x, addr, err)				\
> >>  	__asm__ __volatile__(					\
> >>-		"1:	stw %1,0(%2)\n"				\
> >>-		"2:	stw %1+1,4(%2)\n"			\
> >>+		"1:	stw%U2%X2 %1,%2\n"			\
> >>+		"2:	stw%U2%X2 %L1,%L2\n"			\
> >>  		"3:\n"						\
> >>  		".section .fixup,\"ax\"\n"			\
> >>  		"4:	li %0,%3\n"				\
> >>@@ -140,7 +140,7 @@ extern long __put_user_bad(void);
> >>  		EX_TABLE(1b, 4b)				\
> >>  		EX_TABLE(2b, 4b)				\
> >>  		: "=r" (err)					\
> >>-		: "r" (x), "b" (addr), "i" (-EFAULT), "0" (err))
> >>+		: "r" (x), "m" (*addr), "i" (-EFAULT), "0" (err))
> >
> >Here, it doesn't work.  You don't want two consecutive update insns in
> >any case.  Easiest is to just not use "m<>", and then, don't use %Un
> >(which won't do anything, but it is confusing).
> 
> Can't we leave the Un on the second stw ?

That cannot work.  You can use it on only the *first* though :-)

And this doesn't work on LE I think?  (But the asm doesn't anyway?)

Or, you can decide this is all way too tricky, and not worth it.


Segher
