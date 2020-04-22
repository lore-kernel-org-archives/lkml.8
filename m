Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3536C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 16:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B681820706
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 16:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="NZV5+Dl7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgDVQxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 12:53:41 -0400
Received: from mail.skyhub.de ([5.9.137.197]:47074 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbgDVQxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 12:53:40 -0400
Received: from zn.tnic (p200300EC2F0DC10099981D244BC6B235.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:c100:9998:1d24:4bc6:b235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4D8651EC0D4E;
        Wed, 22 Apr 2020 18:53:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1587574419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AVKnR0QOloA4aew99lOCASo2crQf98GdsdZcG1lVtB8=;
        b=NZV5+Dl7EGPIw4/KYqCmncuiKXzr+/gOLUTmaT8wOqxBvX8e+PWKV1dAcT6trRB/UeHZog
        KN/sfzwnFChYC14r48VTkq18iy3W+iymCDt9wAGMDyR22A0A7Xgs7/Nrnl39oWMyfUTKY2
        +RerxXb8IfTmBm4AVFmg1+zCt9jBEOE=
Date:   Wed, 22 Apr 2020 18:53:39 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>
Cc:     Jakub Jelinek <jakub@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Michael Matz <matz@suse.de>,
        Sergei Trofimovich <slyfox@gentoo.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH v2] x86: fix early boot crash on gcc-10
Message-ID: <20200422165339.GE26846@zn.tnic>
References: <CAKwvOdnFXPBJsAUD++HtYS5JiR2KmX73M5GAUe-tvX-JYV7DaA@mail.gmail.com>
 <CAKwvOdmNwNwa6rMC27-QZq8VDrYdTQeQqss-bAwF1EMmnAHxdw@mail.gmail.com>
 <20200417190607.GY2424@tucnak>
 <CAKwvOdkkbWgWmNthq5KijCdtatM9PEAaCknaq8US9w4qaDuwug@mail.gmail.com>
 <alpine.LSU.2.21.2004201401120.11688@wotan.suse.de>
 <20200422102309.GA26846@zn.tnic>
 <20200422114007.GC20730@hirez.programming.kicks-ass.net>
 <20200422134924.GB26846@zn.tnic>
 <20200422135531.GM2424@tucnak>
 <20a91f2e-0f25-8dba-e441-3233cc1ef398@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20a91f2e-0f25-8dba-e441-3233cc1ef398@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 04:16:53PM +0200, Martin Liška wrote:
> And as I talked to Boris, I would recommend to come up with a "configure" check
> that a compiler does not optimize the key code sequence:
> 
> $ cat asm-detect.c
> int foo(int a);
> int bar(int a)
> {
>   int r = foo(a);
>   asm ("");
>   return r;
> }
> 
> $ gcc -O2 -c asm-detect.c -S -o/dev/stdout | grep jmp
> [no output]

That is a good test to run at the beginning of the compilation I guess.

Without the asm("") it produces:

bar:
.LFB0:
	.cfi_startproc
	jmp	foo@PLT
	.cfi_endproc

I'd like for LLVM folks to confirm that this is a good test for LLVM too
Trying that here with clang gives:

bar:                                    # @bar
        .cfi_startproc
# %bb.0:
        jmp     foo                     # TAILCALL
.Lfunc_end0:

so this *looks* like it would work with LLVM too but I might be missing
something...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
