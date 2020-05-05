Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E063C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3368220838
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730359AbgEEPdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 11:33:17 -0400
Received: from gate.crashing.org ([63.228.1.57]:42699 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730346AbgEEPdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 11:33:15 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 045FWkQB009965;
        Tue, 5 May 2020 10:32:46 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 045FWjVS009961;
        Tue, 5 May 2020 10:32:45 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Tue, 5 May 2020 10:32:45 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, npiggin@gmail.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 1/2] powerpc/uaccess: Implement unsafe_put_user() using 'asm goto'
Message-ID: <20200505153245.GN31009@gate.crashing.org>
References: <23e680624680a9a5405f4b88740d2596d4b17c26.1587143308.git.christophe.leroy@c-s.fr> <87sggecv81.fsf@mpe.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sggecv81.fsf@mpe.ellerman.id.au>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Wed, May 06, 2020 at 12:27:58AM +1000, Michael Ellerman wrote:
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
> > unsafe_put_user() is designed to take benefit of 'asm goto'.
> >
> > Instead of using the standard __put_user() approach and branch
> > based on the returned error, use 'asm goto' and make the
> > exception code branch directly to the error label. There is
> > no code anymore in the fixup section.
> >
> > This change significantly simplifies functions using
> > unsafe_put_user()
> >
> ...
> >
> > Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> > ---
> >  arch/powerpc/include/asm/uaccess.h | 61 +++++++++++++++++++++++++-----
> >  1 file changed, 52 insertions(+), 9 deletions(-)
> >
> > diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
> > index 9cc9c106ae2a..9365b59495a2 100644
> > --- a/arch/powerpc/include/asm/uaccess.h
> > +++ b/arch/powerpc/include/asm/uaccess.h
> > @@ -196,6 +193,52 @@ do {								\
> >  })
> >  
> >  
> > +#define __put_user_asm_goto(x, addr, label, op)			\
> > +	asm volatile goto(					\
> > +		"1:	" op "%U1%X1 %0,%1	# put_user\n"	\
> > +		EX_TABLE(1b, %l2)				\
> > +		:						\
> > +		: "r" (x), "m<>" (*addr)				\
> 
> The "m<>" here is breaking GCC 4.6.3, which we allegedly still support.

[ You shouldn't use 4.6.3, there has been 4.6.4 since a while.  And 4.6
  is nine years old now.  Most projects do not support < 4.8 anymore, on
  any architecture.  ]

> Plain "m" works, how much does the "<>" affect code gen in practice?
> 
> A quick diff here shows no difference from removing "<>".

It will make it impossible to use update-form instructions here.  That
probably does not matter much at all, in this case.

If you remove the "<>" constraints, also remove the "%Un" output modifier?


Segher
