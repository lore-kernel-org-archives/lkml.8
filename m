Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2CCC2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 08:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F270D20709
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 08:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729946AbgAXI6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 03:58:50 -0500
Received: from gate.crashing.org ([63.228.1.57]:42470 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbgAXI6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 03:58:49 -0500
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 00O8wVx7016348;
        Fri, 24 Jan 2020 02:58:31 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 00O8wU1T016347;
        Fri, 24 Jan 2020 02:58:30 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Fri, 24 Jan 2020 02:58:30 -0600
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] powerpc/irq: don't use current_stack_pointer() in check_stack_overflow()
Message-ID: <20200124085830.GT3191@gate.crashing.org>
References: <bae3e75a0c7f9037e4012ee547842c04cd527931.1575871613.git.christophe.leroy@c-s.fr> <87d0b9iez3.fsf@mpe.ellerman.id.au> <f4196f83-82ac-4df0-8c15-267a2c6c07ba@c-s.fr> <74cb4227-1a24-6fe1-2df4-3d4b069453c4@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <74cb4227-1a24-6fe1-2df4-3d4b069453c4@c-s.fr>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2020 at 07:03:36AM +0000, Christophe Leroy wrote:
> >Le 24/01/2020 à 06:46, Michael Ellerman a écrit :
> >>
> >>If I do this it seems to work, but feels a little dicey:
> >>
> >>    asm ("" : "=r" (r1));
> >>    sp = r1 & (THREAD_SIZE - 1);
> >
> >
> >Or we could do add in asm/reg.h what we have in boot/reg.h:
> >
> >register void *__stack_pointer asm("r1");
> >#define get_sp()    (__stack_pointer)
> >
> >And use get_sp()
> >
> 
> It works, and I guess doing it this way is acceptable as it's exactly 
> what's done for current in asm/current.h with register r2.

That is a *global* register variable.  That works.  We still need to
document a bit better what it does exactly, but this is the expected
use case, so that will work.

> Now I (still) get:
> 
> 	sp = get_sp() & (THREAD_SIZE - 1);
>  b9c:	54 24 04 fe 	clrlwi  r4,r1,19
> 	if (unlikely(sp < 2048)) {
>  ba4:	2f 84 07 ff 	cmpwi   cr7,r4,2047
> 
> Allthough GCC 8.1 what doing exactly the same with the form CLANG don't 
> like:
> 
> 	register unsigned long r1 asm("r1");
> 	long sp = r1 & (THREAD_SIZE - 1);
>  b84:	54 24 04 fe 	clrlwi  r4,r1,19
> 	if (unlikely(sp < 2048)) {
>  b8c:	2f 84 07 ff 	cmpwi   cr7,r4,2047

Sure, if it did what you expected, things will usually work out fine ;-)

(Pity that the compiler didn't come up with
    rlwinm. r4,r1,0,19,20
    bne bad
Or are the low bits of r4 used later again?)


Segher
