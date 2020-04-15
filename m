Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F9CBC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 07:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0806320768
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 07:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="aaFgGe6j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635332AbgDOHsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 03:48:52 -0400
Received: from mail.skyhub.de ([5.9.137.197]:59110 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2635311AbgDOHst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 03:48:49 -0400
Received: from zn.tnic (p200300EC2F095B00D1697A0DDC961078.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:5b00:d169:7a0d:dc96:1078])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 422671EC0591;
        Wed, 15 Apr 2020 09:48:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1586936927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=6I3FIZce64bDLoDmq+PGpLnRSsjIWzLbWIT/VRIHmeE=;
        b=aaFgGe6jWyv4YuhUEmn54xvS7cekKBpl1xOqbx8WG5AQUdvs5M4tZ+BWgpX56AQHD3zx00
        88uB8Ur4sb4XGJIsrt8YBqQfopZqBEtOqGuhqJRPkE7+Aeg6PTqSpUTCVBZsDJkIrc/nj6
        Rbfqu1uNhaWhU4tILvnpJNzieRDwqzc=
Date:   Wed, 15 Apr 2020 09:48:42 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Michael Matz <matz@suse.de>
Cc:     Jakub Jelinek <jakub@redhat.com>,
        Sergei Trofimovich <slyfox@gentoo.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Subject: Re: [PATCH v2] x86: fix early boot crash on gcc-10
Message-ID: <20200415074842.GA31016@zn.tnic>
References: <20200326223501.GK11398@zn.tnic>
 <20200328084858.421444-1-slyfox@gentoo.org>
 <20200413163540.GD3772@zn.tnic>
 <alpine.LSU.2.21.2004141343370.11688@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.2004141343370.11688@wotan.suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 01:50:29PM +0000, Michael Matz wrote:
> So this part expects that the caller (!) of trace_hardirqs_on was compiled
> with a frame pointer (in %ebp).

/me looks at the .s file...

options passed comment at the top has -fno-omit-frame-pointer

> Obviously that's not the case as you traced above. Is start_secondary
> the immediate caller in the above case?

Yes, start_secondary() is the function which is marked as
__attribute__((optimize("-fno-stack-protector"))) and it does:

# arch/x86/kernel/smpboot.c:264:        local_irq_enable();
        call    trace_hardirqs_on       #

(the local_irq_enable() is a macro which has the call to
trace_hardirqs_on().

> Look at it's disassembly.  If it doesn't have the usual push
> %ebp/mov%esp,%ebp prologue it probably doesn't use a frame pointer.

Here's the preamble:

        .text
        .p2align 4
        .type   start_secondary, @function
start_secondary:
        pushl   %esi    #
        pushl   %ebx    #
        subl    $28, %esp       #,
# arch/x86/kernel/smpboot.c:226:        cr4_init();
        call    cr4_init        #
	...

Those two pushes on entry are for callee-saved regs, AFAICT, because it
is going to use them later. But no frame setup.

> In that case I would speculate that having a frame pointer
> was (before the change above) only a side-effect of being
> compiled with -fstack-protector, which got now disabled.

Looks like it. And that's 32-bit. 64-bit variant of this looks more like it:

        .text
        .p2align 4
        .type   start_secondary, @function
start_secondary:
        pushq   %rbp    #
        subq    $8, %rsp        #,

although it doesn't save %rsp on the stack. I think it leaves space on
the stack for the canary but I'm not sure.

> But I was under the impression that the upstream kernels build with
> -fno-omit-frame-pointer, so that sounds unexpected.

Yap, see above.

> But I have no better explanation at the moment. If the above
> speculation doesn't make you progress: preprocessed file and a note of
> what the immediate caller of trace_hardirqs_on is in the above case,
> please.

Ok, I'll find you on IRC to talk details.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
