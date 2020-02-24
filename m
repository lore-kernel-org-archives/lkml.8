Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB6CC38BFA
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 23:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9047E2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 23:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJQfuOa4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbgBXXIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 18:08:38 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35958 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728357AbgBXXIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 18:08:34 -0500
Received: by mail-qk1-f196.google.com with SMTP id f3so7354604qkh.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 15:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K/3B2abZ2PBE11q9O8trcN53LJz/Y46vhRJiFNVlNjE=;
        b=ZJQfuOa4PmMxgwNEyZ6LbhqGYDrh/NXEos30/OO8oYeHjhLasX46l3geY6DYzl4SoT
         A5+rgGQX/fo6zsfo0klq8ZAphcq4fDYw3J/MsZtMdR/P1uF0bMd1N6TLLubpi54nddF8
         ZV2Lvt6SmVFmJ85zetUMSTb3KQ84s7GRRhjlnyPpkiLEMYOdMem6Cg4n1JTOi5favvdn
         uGVCcWcdP6vgUY/etcNj4bc++Q4AukRLnsMg54OgNTVY0yP4lcxxmcJhT6igJriEZhu3
         +9IrwT87rpdudARyQSlqdXXpOAJKwMrYTiUI+ZvPaeLKokZA3jl7WLFCbXwOosz/Ms4h
         f7bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=K/3B2abZ2PBE11q9O8trcN53LJz/Y46vhRJiFNVlNjE=;
        b=USmyCRzXohRBvAZQ+gGAJ5DpXIyixMBg8OwgRQZUygNDDt15ru3jV9lNZUfAqpMKyF
         tcpaoE8g8ctFOk8JRex6BR0GiCbT565rtKdd/Pm7xEgDSRqQT1FNFuhdrVXgv/m5lT74
         5+53tdTOazTobW7gUhC4TLWJ7Mqet6eDhIL+ar1l0VoLuf34nc8xrAsxx6IcoKHj4PiE
         /jsSSvkZlpjWr7Q4cMdTnjZHUI/X46JaneUWTblVHHYgWD5cX0EyKv3wJNwwQx2KteWB
         aKZRhv0OHz3s5bHWvNVNIWjUqysNLEkEg2O8iP/hEY3NRwEOaMbtuqTKjejn8DX+vLh7
         QWFQ==
X-Gm-Message-State: APjAAAU+pS1cZ2XvLIe1sJatsR7I0egm8wEGOkshp/P2mWo/7LFss28Q
        wzdEbNx3MvNbf4k1QWYCwDA=
X-Google-Smtp-Source: APXvYqzDjfHjXkHL9dWj2tEj72QxQ6RQ2vTvOLp2ezZ82vnFjdEmd7u+/uDH3Q2z4seWbwktDVCUuA==
X-Received: by 2002:a37:40d2:: with SMTP id n201mr53037062qka.211.1582585711270;
        Mon, 24 Feb 2020 15:08:31 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id z18sm2813397qki.8.2020.02.24.15.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 15:08:31 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 24 Feb 2020 18:08:29 -0500
To:     Fangrui Song <maskray@google.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Michael Matz <matz@suse.de>, Borislav Petkov <bp@alien8.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 2/2] x86/boot/compressed: Remove unnecessary sections
 from bzImage
Message-ID: <20200224230829.GA586317@rani.riverdale.lan>
References: <20200222074254.GB11284@zn.tnic>
 <20200222162225.GA3326744@rani.riverdale.lan>
 <CAKwvOdnvMS21s9gLp5nUpDAOu=c7-iWYuKTeFUq+PMhsJOKUgw@mail.gmail.com>
 <alpine.LSU.2.21.2002241319150.12812@wotan.suse.de>
 <CAKwvOd=nCAyXtng1N-fvNYa=-NGD0yu+Rm6io9F1gs0FieatwA@mail.gmail.com>
 <20200224212828.xvxl3mklpvlrdtiw@google.com>
 <20200224214845.GC409112@rani.riverdale.lan>
 <20200224221703.eqql5hrx4ccngwa5@google.com>
 <20200224224343.GA572699@rani.riverdale.lan>
 <20200224225059.2scjklfi4g7wwdkp@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200224225059.2scjklfi4g7wwdkp@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 02:50:59PM -0800, Fangrui Song wrote:
> On 2020-02-24, Arvind Sankar wrote:
> >On Mon, Feb 24, 2020 at 02:17:03PM -0800, Fangrui Song wrote:
> >> On 2020-02-24, Arvind Sankar wrote:
> >> >On Mon, Feb 24, 2020 at 01:28:28PM -0800, Fangrui Song wrote:
> >> >> Hi Michael, please see my other reply on this thread: https://lkml.org/lkml/2020/2/24/47
> >> >>
> >> >> Synthesized sections can be matched as well. For example, SECTIONS { .pltfoo : { *(.plt) }} can rename the output section .plt to .pltfoo
> >> >> It seems that in GNU ld, the synthesized section is associated with the
> >> >> original object file, so it can be written as:
> >> >>
> >> >>    SECTIONS { .pltfoo : { a.o(.plt) }}
> >> >>
> >> >> In lld, you need a wildcard to match the synthesized section *(.plt)
> >> >>
> >> >> .rela.dyn is another example.
> >> >>
> >> >
> >> >With the BFD toolchain, file matching doesn't actually seem to work at
> >> >least for .rela.dyn. I've tried playing around with it in the past and
> >> >if you try to use file-matching to capture relocations from a particular
> >> >input file, it just doesn't work sensibly.
> >>
> >> I think most things are working in GNU ld...
> >>
> >> /* a.x */
> >> SECTIONS {
> >>    .rela.pltfoo : { a.o(.rela.plt) }  /* *(.rela.plt) with lld */
> >>    .rela.dynfoo : { a.o(.rela.data) } /* *(.rela.dyn) with lld */
> >> }
> >
> >The file matching doesn't do anything sensible. If you split your .data
> >section out into b.s, and update the linker script so it filters for
> >b.o(.rela.data), .rela.dynfoo doesn't get created, instead the default
> >.rela.dyn will contains the .data section relocation. If you keep the
> >filter as a.o(.rela.data), you get .rela.dynfoo, even though a.o doesn't
> >actually contain any .rela.data section any more.
> 
> I raised the examples to support my viewpoint "synthesized sections can
> be matched, as well as input sections."
> 
> If there is really a need (rare, not recommended) to rename output
> sections only consisting of synthesized sections (e.g. .plt .rela.dyn),
> for linker portability, it is better using a wildcard for the input
> filename pattern.

Yep, you have to use * for the filename. My comment was only addressing
the fact that this part isn't accurate:

> >> >> It seems that in GNU ld, the synthesized section is associated with the
> >> >> original object file, so it can be written as:

I can't make head or tail of how GNU ld decides what file to associate
with the synthesized sections.

Also, even section name matching doesn't work with all synthesized
sections -- it's not possible to match .strtab or .shstrtab with GNU ld
in order to rename them, in addition to not being able to discard them,
while that does work with LLD.

> 
> As another example, SECTIONS { /DISCARD/ : { *(.rela.*) } } discards synthesized .rela.*
> 
> >>
> >> % cat <<e > a.s
> >>   .globl foo
> >>   foo:
> >>     call bar
> >>   .data
> >>   .quad quz
> >> e
> >> % as a.s -o a.o
> >> % ld.bfd -T a.x a.o -shared -o a.so
