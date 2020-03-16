Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9954C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 13:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F45020658
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 13:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ijc/0a4B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731426AbgCPNmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 09:42:50 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52002 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731330AbgCPNmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 09:42:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hXk6G8BC2OZrv5EeXODBUkPYq1TPsurqTNGDI/u77MU=; b=Ijc/0a4BODhTmhO9Zs5kmfH6PW
        SpeJGCxFhND9WzDCk3PPVAPKpQRuX5XYbxo+1rCL2kb91ndgtieH0svBOJWrYnMG8Yn+iIA45Qk1k
        zBevBEqBDj+9JG3nXYNJlRnu9JYRhY3AI7PGlR7kNM60BXsy2KtcdUTW59RXJ1ECyPwrU3ZnXG6AU
        v7XtEwjzQhhH0iO4iCwq2qMXDEeWDuu4vxD35o0+J7MpPlzmiciFE+NWQwWxCMafN6KMc/YcwsQbC
        OXitI9PPMHlgar5XXJsulE+rLHI9D4vPurqg8x2Yzeg/3RA8ESy0dCWE3Dilb6ZMS7KyBj/hvvkEM
        l5aqiNcQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jDq0q-0006k8-EX; Mon, 16 Mar 2020 13:42:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 183E63012C3;
        Mon, 16 Mar 2020 14:42:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ECBE020B16472; Mon, 16 Mar 2020 14:42:34 +0100 (CET)
Date:   Mon, 16 Mar 2020 14:42:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jakub Jelinek <jakub@redhat.com>
Cc:     Sergei Trofimovich <slyfox@gentoo.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org
Subject: Re: [PATCH] x86: fix early boot crash on gcc-10
Message-ID: <20200316134234.GE12561@hirez.programming.kicks-ass.net>
References: <20200314164451.346497-1-slyfox@gentoo.org>
 <20200316130414.GC12561@hirez.programming.kicks-ass.net>
 <20200316132648.GM2156@tucnak>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316132648.GM2156@tucnak>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 02:26:48PM +0100, Jakub Jelinek wrote:
> On Mon, Mar 16, 2020 at 02:04:14PM +0100, Peter Zijlstra wrote:
> > > diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> > > index 9b294c13809a..da9f4ea9bf4c 100644
> > > --- a/arch/x86/kernel/Makefile
> > > +++ b/arch/x86/kernel/Makefile
> > > @@ -11,6 +11,12 @@ extra-y	+= vmlinux.lds
> > >  
> > >  CPPFLAGS_vmlinux.lds += -U$(UTS_MACHINE)
> > >  
> > > +# smpboot's init_secondary initializes stack canary.
> > > +# Make sure we don't emit stack checks before it's
> > > +# initialized.
> > > +nostackp := $(call cc-option, -fno-stack-protector)
> > > +CFLAGS_smpboot.o := $(nostackp)
> > 
> > What makes GCC10 insert this while GCC9 does not. Also, I would much
> 
> My bet is different inlining decisions.
> If somebody hands me over the preprocessed source + gcc command line, I can
> have a look in detail (which exact change and why).
> 
> > rather GCC10 add a function attrbute to kill this:
> > 
> >   __attribute__((no_stack_protect))
> 
> There is no such attribute,

Right I know, I looked for it recently :/ But since this is new in 10
and 10 isn't released yet, I figured someone can add the attribute
before it does get released.

> only __attribute__((stack_protect)) which is
> meant mainly for -fstack-protector-explicit and does the opposite, or
> __attribute__((optimize ("no-stack-protector"))) (which will work only
> in GCC7+, since https://gcc.gnu.org/PR71585 changes).

Cute..

> Or of course you could add noinline attribute to whatever got inlined
> and contains some array or addressable variable that whatever
> -fstack-protector* mode kernel uses triggers it.  With -fstack-protector-all
> it would never work even in the past I believe.

I don't think the kernel supports -fstack-protector-all, but I could be
mistaken.
