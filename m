Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996DAC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D2A02083B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730031AbgF3VSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 17:18:45 -0400
Received: from gate.crashing.org ([63.228.1.57]:48640 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbgF3VSo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 17:18:44 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 05ULIIPG003747;
        Tue, 30 Jun 2020 16:18:18 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 05ULIHW0003746;
        Tue, 30 Jun 2020 16:18:17 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Tue, 30 Jun 2020 16:18:17 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, npiggin@gmail.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] powerpc/uaccess: Use flexible addressing with __put_user()/__get_user()
Message-ID: <20200630211817.GZ3598@gate.crashing.org>
References: <c2addbd9d76212242d3d8554a2f7ff849fb08b85.1587040754.git.christophe.leroy@c-s.fr> <7b916759-1683-b4df-0d4b-b04b3fcd9a02@csgroup.eu> <878sg6862r.fsf@mpe.ellerman.id.au> <875zb98i5a.fsf@mpe.ellerman.id.au> <311c3471-cad7-72d5-a5e6-04cf892c5e41@csgroup.eu> <20200630163324.GW3598@gate.crashing.org> <f8819fa4-94e3-4bf9-4b60-c57d2804e529@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8819fa4-94e3-4bf9-4b60-c57d2804e529@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

Thanks for your work so far!

On Tue, Jun 30, 2020 at 06:53:39PM +0000, Christophe Leroy wrote:
> On 06/30/2020 04:33 PM, Segher Boessenkool wrote:
> >>>+ make -s CC=powerpc64-linux-gnu-gcc -j 160
> >>>In file included from /linux/include/linux/uaccess.h:11:0,
> >>>                  from /linux/include/linux/sched/task.h:11,
> >>>                  from /linux/include/linux/sched/signal.h:9,
> >>>                  from /linux/include/linux/rcuwait.h:6,
> >>>                  from /linux/include/linux/percpu-rwsem.h:7,
> >>>                  from /linux/include/linux/fs.h:33,
> >>>                  from /linux/include/linux/huge_mm.h:8,
> >>>                  from /linux/include/linux/mm.h:675,
> >>>                  from /linux/arch/powerpc/kernel/signal_32.c:17:
> >>>/linux/arch/powerpc/kernel/signal_32.c: In function
> >>>'save_user_regs.isra.14.constprop':
> >>>/linux/arch/powerpc/include/asm/uaccess.h:161:2: error: 'asm' operand has
> >>>impossible constraints
> >>>   __asm__ __volatile__(     \
> >>>   ^
> >>>/linux/arch/powerpc/include/asm/uaccess.h:197:12: note: in expansion of
> >>>macro '__put_user_asm'
> >>>     case 4: __put_user_asm(x, ptr, retval, "stw"); break; \
> >>>             ^
> >>>/linux/arch/powerpc/include/asm/uaccess.h:206:2: note: in expansion of
> >>>macro '__put_user_size_allowed'
> >>>   __put_user_size_allowed(x, ptr, size, retval);  \
> >>>   ^
> >>>/linux/arch/powerpc/include/asm/uaccess.h:220:2: note: in expansion of
> >>>macro '__put_user_size'
> >>>   __put_user_size(__pu_val, __pu_addr, __pu_size, __pu_err); \
> >>>   ^
> >>>/linux/arch/powerpc/include/asm/uaccess.h:96:2: note: in expansion of
> >>>macro '__put_user_nocheck'
> >>>   __put_user_nocheck((__typeof__(*(ptr)))(x), (ptr), sizeof(*(ptr)))
> >>>   ^
> >>>/linux/arch/powerpc/kernel/signal_32.c:120:7: note: in expansion of macro
> >>>'__put_user'
> >>>    if (__put_user((unsigned int)gregs[i], &frame->mc_gregs[i]))
> >>>        ^
> >
> >Can we see what that was after the macro jungle?  Like, the actual
> >preprocessed code?
> 
> Sorry for previous misunderstanding
> 
> Here is the code:
> 
> #define __put_user_asm(x, addr, err, op)			\
> 	__asm__ __volatile__(					\
> 		"1:	" op "%U2%X2 %1,%2	# put_user\n"	\
> 		"2:\n"						\
> 		".section .fixup,\"ax\"\n"			\
> 		"3:	li %0,%3\n"				\
> 		"	b 2b\n"					\
> 		".previous\n"					\
> 		EX_TABLE(1b, 3b)				\
> 		: "=r" (err)					\
> 		: "r" (x), "m<>" (*addr), "i" (-EFAULT), "0" (err))

Yeah I don't see it.  I'll have to look at compiler debug dumps, but I
don't have any working 4.9 around, and I cannot reproduce this with
either older or newer compilers.

It is complainig that constrain_operands just does not work *at all* on
this "m<>" constraint apparently, which doesn't make much sense.

I'll try later when I have more time, sorry :-/


Segher
