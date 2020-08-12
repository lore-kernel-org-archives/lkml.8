Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7112BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 08:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4650820786
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 08:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597222631;
	bh=OpdSJrDe6VRA6KahHe+zVXP/Gug35Hv/eCOg8dbd9DY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=bQRzldmfsAatFjbKsr1FC6A/bWKxK0ZEnU9+l12MKKiraJMtf4hsVT9p4nuQOMLjd
	 i4lBTH10AEmYZ7uyyBELErIyZOmfy4KhxhScF51SXagEk2SLa7Nh2HCGsq3CftZm+1
	 FmdrjEG0zVrB01FMlEKcCwqLetjdYybuPN2OrJN0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgHLI5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 04:57:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:44742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbgHLI5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 04:57:09 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6611A2083B
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 08:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597222628;
        bh=OpdSJrDe6VRA6KahHe+zVXP/Gug35Hv/eCOg8dbd9DY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Mq48PKcDAKPCs4uHN1OeOkS3bDpt771NTXFrCiRP7g1tQgfAQVG5PFzRN3n+6VQBj
         52V+BNWhpbjp/CVcMwvCMFHhgDs9sLVoZyzgfJsO8aBnnaAHBx+YAhI7PQ3nMBysb3
         6vutoL+B2atRXi/4iKBq6fUa2PLHAx6OnQeGiPQ0=
Received: by mail-ot1-f45.google.com with SMTP id h22so1329546otq.11
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 01:57:08 -0700 (PDT)
X-Gm-Message-State: AOAM531gvggMuAb7PpkIn5oTpl5JvwR3FFFf37MHLrPafFdLhjQSQTM3
        JmkAlJFW3Jp/KxxCL4R14Pxj233dk8tIBdYAzY0=
X-Google-Smtp-Source: ABdhPJwF0z1XdBIkc7lgzpT0TKJP7uCMbOPq4HE+7AdCj7tJjiyp1Nb5hK7VFoYBMlsVeraV9tugdkVFs+rdCdR9gxA=
X-Received: by 2002:a9d:6251:: with SMTP id i17mr8034568otk.90.1597222627672;
 Wed, 12 Aug 2020 01:57:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200403171303.GK20760@hirez.programming.kicks-ass.net>
 <20200808101222.5103093e@coco.lan> <20200810092523.GA8612@linux-8ccs>
 <20200810150647.GB8612@linux-8ccs> <20200811163427.6edbf343@coco.lan>
 <20200811145524.GE2674@hirez.programming.kicks-ass.net> <20200811172738.2d632a09@coco.lan>
 <20200811160134.GA13652@linux-8ccs>
In-Reply-To: <20200811160134.GA13652@linux-8ccs>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 12 Aug 2020 10:56:56 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF8fm=9CdQykqDbgYCJSP88ezMs3EOosCW+SDi+Lve0zg@mail.gmail.com>
Message-ID: <CAMj1kXF8fm=9CdQykqDbgYCJSP88ezMs3EOosCW+SDi+Lve0zg@mail.gmail.com>
Subject: Re: [PATCH v2] module: Harden STRICT_MODULE_RWX
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Aug 2020 at 18:01, Jessica Yu <jeyu@kernel.org> wrote:
>
> +++ Mauro Carvalho Chehab [11/08/20 17:27 +0200]:
> >Em Tue, 11 Aug 2020 16:55:24 +0200
> >peterz@infradead.org escreveu:
> >
> >> On Tue, Aug 11, 2020 at 04:34:27PM +0200, Mauro Carvalho Chehab wrote:
> >> >   [33] .plt              PROGBITS         0000000000000340  00035c80
> >> >        0000000000000001  0000000000000000 WAX       0     0     1
> >> >   [34] .init.plt         NOBITS           0000000000000341  00035c81
> >> >        0000000000000001  0000000000000000  WA       0     0     1
> >> >   [35] .text.ftrace[...] PROGBITS         0000000000000342  00035c81
> >> >        0000000000000001  0000000000000000 WAX       0     0     1
> >>
> >> .plt and .text.ftrace_tramplines are buggered.
> >>
> >> arch/arm64/kernel/module.lds even marks then as NOLOAD.
> >
> >Hmm... Shouldn't the code at module_enforce_rwx_sections() or at
> >load_module() ignore such sections instead of just rejecting probing
> >all modules?
> >
> >I mean, if the existing toolchain is not capable of excluding
> >those sections, either the STRICT_MODULE_RWX hardening should be
> >disabled, if a broken toolchain is detected or some runtime code
> >should handle such sections on a different way.
>
> Hi Mauro, thanks for providing the readelf output. The sections marked 'WAX'
> are indeed the reason why the module loader is rejecting them.
>
> Interesting, my cross-compiled modules do not have the executable flag -
>
>   [38] .plt              NOBITS           0000000000000340  00038fc0
>        0000000000000001  0000000000000000  WA       0     0     1
>   [39] .init.plt         NOBITS           0000000000000341  00038fc0
>        0000000000000001  0000000000000000  WA       0     0     1
>   [40] .text.ftrace_tram NOBITS           0000000000000342  00038fc0
>        0000000000000001  0000000000000000  WA       0     0     1
>
> ld version:
>
>     GNU ld (GNU Binutils) 2.34
>     Copyright (C) 2020 Free Software Foundation, Inc.
>     This program is free software; you may redistribute it under the terms of
>     the GNU General Public License version 3 or (at your option) a later version.
>
> And gcc:
>
>     aarch64-linux-gcc (GCC) 9.3.0
>     Copyright (C) 2019 Free Software Foundation, Inc.
>     This is free software; see the source for copying conditions.  There is NO
>     warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
>
> I'm a bit confused about what NOLOAD actually implies in this context. From the
> ld documentation - "The `(NOLOAD)' directive will mark a section to not be
> loaded at run time." But these sections are marked SHF_ALLOC and are referenced
> to in the module plt code. Or does it just tell the linker to not initialize it?
>
> Adding Ard to CC, I'm sure he'd know more about the section flag specifics.
>

The module .lds has BYTE(0) in the section contents to prevent the
linker from pruning them entirely. The (NOLOAD) is there to ensure
that this byte does not end up in the .ko, which is more a matter of
principle than anything else, so we can happily drop that if it helps.

However, this should only affect the PROGBITS vs NOBITS designation,
and so I am not sure whether it makes a difference.

Depending on where the w^x check occurs, we might simply override the
permissions of these sections, and strip the writable permission if it
is set in the PLT handling init code, which manipulates the metadata
of all these 3 sections before the module space is vmalloc'ed.
