Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E67C38A29
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 09:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4175E207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 09:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="FV6iwrNg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730168AbgDQJJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 05:09:17 -0400
Received: from mail.skyhub.de ([5.9.137.197]:60974 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729920AbgDQJJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 05:09:16 -0400
Received: from zn.tnic (p200300EC2F0DA8007D6645F2EFE7966D.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:a800:7d66:45f2:efe7:966d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 700A01EC0D3D;
        Fri, 17 Apr 2020 11:09:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1587114554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=KofRMhS2HujTnfZn9TNmDLVzxb/tgBzRqrHpSR1K+Eg=;
        b=FV6iwrNgNlOj8tX8gds27ZvyJEqp9SOETGK9iwy6Z2kywqG4VaPKjPWGy+CyREgw68N8+r
        nu8ePaqY4y1jUNGE3MV5tawE+O/YG0O2a1BlPCXDvOJ+fTWtxDxzntyatEgqwHk0fIoVvk
        AQ5+C1KE9x82MJ0S0ZD4vIcWBduFIa4=
Date:   Fri, 17 Apr 2020 11:09:09 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jakub Jelinek <jakub@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Sergei Trofimovich <slyfox@gentoo.org>,
        Michael Matz <matz@suse.de>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Subject: Re: [PATCH v2] x86: fix early boot crash on gcc-10
Message-ID: <20200417090909.GC7322@zn.tnic>
References: <20200328084858.421444-1-slyfox@gentoo.org>
 <20200413163540.GD3772@zn.tnic>
 <alpine.LSU.2.21.2004141343370.11688@wotan.suse.de>
 <20200415074842.GA31016@zn.tnic>
 <alpine.LSU.2.21.2004151445520.11688@wotan.suse.de>
 <20200415231930.19755bc7@sf>
 <20200417075739.GA7322@zn.tnic>
 <20200417080726.GS2424@tucnak>
 <20200417084224.GB7322@zn.tnic>
 <20200417085859.GU2424@tucnak>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200417085859.GU2424@tucnak>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 10:58:59AM +0200, Jakub Jelinek wrote:
> On Fri, Apr 17, 2020 at 10:42:24AM +0200, Borislav Petkov wrote:
> > On Fri, Apr 17, 2020 at 10:07:26AM +0200, Jakub Jelinek wrote:
> > > If you want minimal changes, you can as I said earlier either
> > > mark cpu_startup_entry noreturn (in the declaration in some header so that
> > > smpboot.c sees it), or you could add something after the cpu_startup_entry
> > > call to ensure it is not tail call optimized (e.g. just
> > > 	/* Prevent tail call to cpu_startup_entry because the stack
> > > 	   protector guard has been changed in the middle of this function
> > > 	   and must not be checked before tail calling another function.  */
> > > 	asm ("");
> > 
> > That sounds ok-ish to me too.
> > 
> > I know you probably can't tell the future :) but what stops gcc from
> > doing the tail-call optimization in the future?
> > 
> > Or are optimization decisions behind an inline asm a no-no and will
> > pretty much always stay that way?
> 
> GCC intentionally treats asm as a black box, the only thing which it does
> with it is: non-volatile asm (but asm without outputs is implicitly
> volatile) can be CSEd, and if the compiler needs to estimate size, it
> uses some heuristics by counting ; and newlines.
> And it will stay this way.
> 
> > And I hope the clang folks don't come around and say, err, nope, we're
> > much more aggressive here.
> 
> Unlike GCC, I think clang uses the builtin assembler to parse the string,
> but don't know if it still treats the asms more like black boxes or not.
> Certainly there is a lot of code in the wild that uses inline asm
> as optimization barriers, so if it doesn't, then it would cause a lot of
> problems.
> 
> Or go with the for (;;);, I don't think any compiler optimizes those away;
> GCC 10 for C++ can optimize away infinite loops that have some conditional
> exit because the language guarantees forward progress, but the C language
> rules are different and for unconditional infinite loops GCC doesn't
> optimize them away even if explicitly asked to -ffinite-loops.

Lemme add Nick for clang for an opinion:

Nick, we're discussing what would be the cleanest and future-proof
way to disable stack protector for the function in the kernel which
generates the canary value as gcc10 ends up checking that value due to
tail-call optimizing the last function called by start_secondary()...
upthread are all the details.

And question is, can Jakub's suggestions above prevent tail-call
optimization on clang too and how reliable and future proof would that
be if we end up going that way?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
