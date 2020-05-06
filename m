Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CC4C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 17:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 526B2208DB
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 17:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729625AbgEFR7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 13:59:15 -0400
Received: from gate.crashing.org ([63.228.1.57]:53441 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728082AbgEFR7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 13:59:15 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 046HwoSC014327;
        Wed, 6 May 2020 12:58:50 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 046HwnT3014321;
        Wed, 6 May 2020 12:58:49 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Wed, 6 May 2020 12:58:49 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, npiggin@gmail.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 1/2] powerpc/uaccess: Implement unsafe_put_user() using 'asm goto'
Message-ID: <20200506175849.GT31009@gate.crashing.org>
References: <23e680624680a9a5405f4b88740d2596d4b17c26.1587143308.git.christophe.leroy@c-s.fr> <87sggecv81.fsf@mpe.ellerman.id.au> <20200505153245.GN31009@gate.crashing.org> <87pnbhdgkw.fsf@mpe.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pnbhdgkw.fsf@mpe.ellerman.id.au>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 10:58:55AM +1000, Michael Ellerman wrote:
> >> The "m<>" here is breaking GCC 4.6.3, which we allegedly still support.
> >
> > [ You shouldn't use 4.6.3, there has been 4.6.4 since a while.  And 4.6
> >   is nine years old now.  Most projects do not support < 4.8 anymore, on
> >   any architecture.  ]
> 
> Moving up to 4.6.4 wouldn't actually help with this though would it?

Nope.  But 4.6.4 is a bug-fix release, 91 bugs fixed since 4.6.3, so you
should switch to it if you can :-)

> Also I have 4.6.3 compilers already built, I don't really have time to
> rebuild them for 4.6.4.
> 
> The kernel has a top-level minimum version, which I'm not in charge of, see:
> 
> https://www.kernel.org/doc/html/latest/process/changes.html?highlight=gcc

Yes, I know.  And it is much preferred not to have stricter requirements
for Power, I know that too.  Something has to give though :-/

> There were discussions about making 4.8 the minimum, but I'm not sure
> where they got to.

Yeah, just petered out I think?

All significant distros come with a 4.8 as system compiler.

> >> Plain "m" works, how much does the "<>" affect code gen in practice?
> >> 
> >> A quick diff here shows no difference from removing "<>".
> >
> > It will make it impossible to use update-form instructions here.  That
> > probably does not matter much at all, in this case.
> >
> > If you remove the "<>" constraints, also remove the "%Un" output modifier?
> 
> So like this?
> 
> diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
> index 62cc8d7640ec..ca847aed8e45 100644
> --- a/arch/powerpc/include/asm/uaccess.h
> +++ b/arch/powerpc/include/asm/uaccess.h
> @@ -207,10 +207,10 @@ do {								\
>  
>  #define __put_user_asm_goto(x, addr, label, op)			\
>  	asm volatile goto(					\
> -		"1:	" op "%U1%X1 %0,%1	# put_user\n"	\
> +		"1:	" op "%X1 %0,%1	# put_user\n"		\
>  		EX_TABLE(1b, %l2)				\
>  		:						\
> -		: "r" (x), "m<>" (*addr)				\
> +		: "r" (x), "m" (*addr)				\
>  		:						\
>  		: label)

Like that.  But you will have to do that to *all* places we use the "<>"
constraints, or wait for more stuff to fail?  And, there probably are
places we *do* want update form insns used (they do help in some loops,
for example)?


Segher
