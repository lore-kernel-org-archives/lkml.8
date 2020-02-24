Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D732C35671
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 13:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 389672080D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 13:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbgBXN2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 08:28:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:38216 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726308AbgBXN2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 08:28:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A9C1BAB6D;
        Mon, 24 Feb 2020 13:28:38 +0000 (UTC)
Date:   Mon, 24 Feb 2020 13:28:36 +0000 (UTC)
From:   Michael Matz <matz@suse.de>
To:     Nick Desaulniers <ndesaulniers@google.com>
cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Fangrui Song <maskray@google.com>,
        Borislav Petkov <bp@alien8.de>,
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
In-Reply-To: <CAKwvOdnvMS21s9gLp5nUpDAOu=c7-iWYuKTeFUq+PMhsJOKUgw@mail.gmail.com>
Message-ID: <alpine.LSU.2.21.2002241319150.12812@wotan.suse.de>
References: <20200109150218.16544-1-nivedita@alum.mit.edu> <20200109150218.16544-2-nivedita@alum.mit.edu> <20200222050845.GA19912@ubuntu-m2-xlarge-x86> <20200222065521.GA11284@zn.tnic> <20200222070218.GA27571@ubuntu-m2-xlarge-x86> <20200222072144.asqaxlv364s6ezbv@google.com>
 <20200222074254.GB11284@zn.tnic> <20200222162225.GA3326744@rani.riverdale.lan> <CAKwvOdnvMS21s9gLp5nUpDAOu=c7-iWYuKTeFUq+PMhsJOKUgw@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sat, 22 Feb 2020, Nick Desaulniers wrote:

> > > > In GNU ld, it seems that .shstrtab .symtab and .strtab are special
> > > > cased. Neither the input section description *(.shstrtab) nor *(*)
> > > > discards .shstrtab . I feel that this is a weird case (probably even a bug)
> > > > that lld should not implement.
> > >
> > > Ok, forget what the tools do for a second: why is .shstrtab special and
> > > why would one want to keep it?
> > >
> > > Because one still wants to know what the section names of an object are
> > > or other tools need it or why?
> > >
> > > Thx.
> > >
> > > --
> > > Regards/Gruss,
> > >     Boris.
> > >
> > > https://people.kernel.org/tglx/notes-about-netiquette
> >
> > .shstrtab is required by the ELF specification. The e_shstrndx field in
> > the ELF header is the index of .shstrtab, and each section in the
> > section table is required to have an sh_name that points into the
> > .shstrtab.
> 
> Yeah, I can see it both ways.  That `*` doesn't glob all remaining
> sections is surprising to me, but bfd seems to be "extra helpful" in
> not discarding sections that are required via ELF spec.

In a way the /DISCARD/ assignment should be thought of as applying to 
_input_ sections (as all such section references on the RHS), not 
necessarily to output sections.  What this then means for sections that 
are synthesized by the link editor is less clear.  Some of them are 
generated regardless (as you noted, e.g. the symbol table and associated 
string sections, including section name string table), some of them are 
suppressed, and either lead to an followup error (e.g. with .gnu.hash), or 
to invalid output (e.g. missing .dynsym for executables simply lead to 
segfaults when running them).

That's the reason for the perceived inconsistency with behaviour on '*': 
it's application to synthesized sections.  Arguably bfd should be fixed to 
also not discard the other essential sections (or alternatively to give an 
error when an essential section is discarded).  The lld behaviour of e.g. 
discarding .shstrtab (or other synthesized sections necessary for valid 
ELF output) doesn't make much sense either, though.


Ciao,
Michael.
