Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B318C4BA0A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 05:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65B2921927
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 05:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S60pJC8C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgBZFfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 00:35:53 -0500
Received: from mail-pf1-f175.google.com ([209.85.210.175]:44610 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgBZFfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 00:35:52 -0500
Received: by mail-pf1-f175.google.com with SMTP id y5so844018pfb.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 21:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D5/Ju2tq5be6Ks63/zLa9GYBbQxPXMVnyMNgldjudzg=;
        b=S60pJC8Coxc6xTAlQ3B/DrOh05QFUsCGdyRC1lQfv3tN+xGU5gMRuNfFHdgNsUJO7V
         kVYivjTFO3HFjhm/cuZNSFMECNYzY6Bmy3e34+3galxUqkSJ5cTnTfHW/cJHU9Qrdl7y
         pJ3jOHQ4GHudvRvxL15YQVHe95tTuTtAL6hLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D5/Ju2tq5be6Ks63/zLa9GYBbQxPXMVnyMNgldjudzg=;
        b=N/6jW3e+0o1Po018VLiiwg1j4f1HEzvvJB8Z3DxDGW89ejNdfaeQnxMBFFC1vqAYib
         V8q85yLrJd1sJhPk6GmgLvN2rRiIKSdZY7633OUzRjMqlN4aH7vKzRrm0P1BzJg3Ri6E
         6oOdqPvEHI9waz+x2e1U2Y4D3c9xUMem9GxYUOhG4+e1v3NkjUmXKBpWKUwwZAfcniPA
         701mfwN1qHPLDAIG7XZZncC/wVOsW72LodgYLEABIpAxpUmBQsqVDumHGs2AZWAL0Drw
         ubRm8gb7ncPGI7eMl/XjHdu1IJEL63PmwsoT3m0yb2hsXMQcNBkOh6mEjhk1GaMtKNhc
         N76A==
X-Gm-Message-State: APjAAAXfOgtJq7iOFr+VU04d4C1Tw9MdHRMJKQUlin9C8+JvYM/bWy1x
        OlhsotxemIAQjT9HauWZgzxR9A==
X-Google-Smtp-Source: APXvYqyaTtBE87vKm7yr6RjewtLzv4zAe7WXJOrZTEBz8pF9Mxqq2cQk5OgQjPBfbVgxO9muCSomZA==
X-Received: by 2002:a62:cf07:: with SMTP id b7mr2397497pfg.77.1582695351516;
        Tue, 25 Feb 2020 21:35:51 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z127sm822015pgb.64.2020.02.25.21.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 21:35:50 -0800 (PST)
Date:   Tue, 25 Feb 2020 21:35:49 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Fangrui Song <maskray@google.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@alien8.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Michael Matz <matz@suse.de>,
        Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: Re: --orphan-handling=warn
Message-ID: <202002252103.B4BBF01091@keescook>
References: <20200222072144.asqaxlv364s6ezbv@google.com>
 <20200222074254.GB11284@zn.tnic>
 <20200222162225.GA3326744@rani.riverdale.lan>
 <CAKwvOdnvMS21s9gLp5nUpDAOu=c7-iWYuKTeFUq+PMhsJOKUgw@mail.gmail.com>
 <202002242122.AA4D1B8@keescook>
 <20200225182951.GA1179890@rani.riverdale.lan>
 <202002251140.4F28F0A4F@keescook>
 <CAKwvOdnkr1W4LTm8XmTKGkSDUhSBRowLbKwJwyitDMAGLh9ywg@mail.gmail.com>
 <202002251358.EDA50C11F@keescook>
 <20200226015606.ij7wn7emuj4bfkvn@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226015606.ij7wn7emuj4bfkvn@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 05:56:06PM -0800, Fangrui Song wrote:
> > > Kees is working on a series to just be explicit about what sections
> > > are ordered where, and what's discarded, which should better handle
> > > incompatibilities between linkers in regards to orphan section
> > > placement and "what does `*` mean."  Kees, that series can't come soon
> > 
> > So, with my series[1] applied, ld.bfd builds clean. With ld.lld, I get a
> > TON of warnings, such as:
> > 
> > (.bss.rel.ro) is being placed in '.bss.rel.ro'
> 
> .bss.rel.ro (SHT_NOBITS) is lld specific. GNU ld does not have it. It is
> currently used for copy relocations of symbols in read-only PT_LOAD
> segments. If a relro section's statically relocated data is all zeros,
> we can move the section to .bss.rel.ro
> 
> > (.iplt) is being placed in '.iplt'
> > (.plt) is being placed in '.plt'
> > (.rela.altinstr_aux) is being placed in '.rela.altinstr_aux'
> > (.rela.altinstr_replacement) is being placed in
> > '.rela.altinstr_replacement'
> > (.rela.altinstructions) is being placed in '.rela.altinstructions'
> > (.rela.apicdrivers) is being placed in '.rela.apicdrivers'
> > (.rela__bug_table) is being placed in '.rela__bug_table'
> > (.rela.con_initcall.init) is being placed in '.rela.init.data'
> > (.rela.cpuidle.text) is being placed in '.rela.text'
> > (.rela.data..cacheline_aligned) is being placed in '.rela.data'
> > (.rela.data) is being placed in '.rela.data'
> > (.rela.data..percpu) is being placed in '.rela.data..percpu'
> > (.rela.data..percpu..page_aligned) is being placed in '.rela.data..percpu'
> > ...
> 
> I need to figure out the exact GNU ld rule for input SHT_REL[A] retained
> by --emit-relocs.
> 
>   ld.bfd: warning: orphan section `.rela.meminit.text' from `arch/x86/kernel/head_64.o' being placed in section `.rela.dyn'
>   ld.bfd: warning: orphan section `.rela___ksymtab+__ctzsi2' from `arch/x86/kernel/head_64.o' being placed in section `.rela.dyn'
>   ld.bfd: warning: orphan section `.rela___ksymtab+__clzsi2' from `arch/x86/kernel/head_64.o' being placed in section `.rela.dyn'
>   ld.bfd: warning: orphan section `.rela___ksymtab+__clzdi2' from `arch/x86/kernel/head_64.o' being placed in section `.rela.dyn'
>   ld.bfd: warning: orphan section `.rela___ksymtab+__ctzdi2' from `arch/x86/kernel/head_64.o' being placed in section `.rela.dyn'
> 
> lld simply ignores such SHT_REL[A] when checking input section descriptions.
> A .rela.foo relocating .foo will be named .rela.foobar if .foo is placed in .foobar
> 
> It makes sense for --orphan-handling= not to warn/error.
> https://reviews.llvm.org/D75151

Awesome! I commented on the review, but just to follow up, this cuts out
all the .rela warnings.

> 
> > But as you can see in the /DISCARD/, these (and all the others), should
> > be getting caught:
> > 
> >         /DISCARD/ : {
> >                 *(.eh_frame)
> > +               *(.rela.*) *(.rela_*)
> > +               *(.rel.*) *(.rel_*)
> > +               *(.got) *(.got.*)
> > +               *(.igot.*) *(.iplt)
> >         }
> > 
> > I don't understand what's happening here. I haven't minimized this case
> > nor opened an lld bug yet.
> 
> --orphan-handling was implemented per
> https://bugs.llvm.org/show_bug.cgi?id=34946
> It seems the reporter did not follow up after the feature was implemented.
> Now we have the Linux kernel case...
> Last December I encountered another case in my company.
> 
> It is pretty clear that this feature is useful and we should fix it :)
> 
> https://reviews.llvm.org/D75149

Also commented in the review; this removes the following:

... (.bss.rel.ro) is being placed in '.bss.rel.ro'
... (.iplt) is being placed in '.iplt'
... (.plt) is being placed in '.plt'
... (.symtab_shndx) is being placed in '.symtab_shndx'

I'm now only left with:

ld.lld: warning: <internal>:(.symtab) is being placed in '.symtab'
ld.lld: warning: <internal>:(.shstrtab) is being placed in '.shstrtab'
ld.lld: warning: <internal>:(.strtab) is being placed in '.strtab'

> > enough. ;) (I think it's intended to help "fine grain" (per function)
> > KASLR).  More comments in the other thread.
> 
> > Actually, it's rather opposed to the FGKASLR series, as for that, I need
> > some kind of linker script directive like this:
> > 
> > 	/PASSTHRU/ : {
> > 		*(.text.*)
> > 	}
> > 
> > Where "PASSTHRU" would create a 1-to-1 input-section to output-section
> > with the same name, flags, etc.
> 
> /PASSTHRU/ sections are still handled as orphan sections?

If PASSTHRU existed, I wouldn't want them reported as orphan sections
(since they'd be chosen). This "section" would serve two purposes:

- remove the warning about being orphan
- position the sections in a known location (FGKASLR needs this so that
  it can know where the end of the all the .text.* sections actually
  are. Right now, the correct result is effectively accidental[1].)

[1] https://lore.kernel.org/lkml/20200205223950.1212394-7-kristen@linux.intel.com/

> Do you restrict { } to input section descriptions, not output section
> data (https://sourceware.org/binutils/docs/ld/Output-Section-Data.html#Output-Section-Data)?
> or symbol assignments?

I only imagine it being input section descriptions. (I imagine PASSTHRU
being much like DISCARD -- it won't make sense to put output section
data there either.)

> You can ask https://sourceware.org/ml/binutils/2020-02/ whether
> they'd like to accept the feature request:)
> 
> (My personal feeling is that I want to see more use cases to add the new
> feature...)

This is the only case I've got for this right now. If the "do not merge
the orphan .text.* into .text" bug is fixed, then FGKASLR can continue
to work "on accident", and nothing like PASSTHRU would be needed. :)
In this case, I would have FGKASLR disable the orphan section warning,
since it would depend on orphan handling.

> > ld.bfd's handling of orphan sections named .text.* is to put them each
> > as a separate output section, after the existing .text output section.
> > 
> > ld.lld's handling of orphan sections named .text.* is to put them into
> > the .text output section.
> 
> Confirmed. lld can adapt. I need to do some homework...

Awesome. If it matches bfd, then that'll be sufficient:

https://sourceware.org/binutils/docs/ld/Orphan-Sections.html

Namely:
	"If there is no output section with a matching name then new
	 output sections will be created."
and:
	"... the linker attempts to place orphan sections after sections
	 of the same attribute ..."

So .text.blah would end up in .text.blah but after .text (since they're
both code).

(And as noted earlier, --unique support is needed too.)

> > For FGKASLR (as it is currently implemented[2]), the sections need to be
> > individually named output sections (as bfd does it). *However*, with the
> > "warn on orphans" patch, FGKASLR's intentional orphaning will backfire
> > (I guess the warning could be turned off, but I'd like lld to handle
> > FGKASLR at some point.)
> > 
> > Note that cheating and doing the 1-to-1 mapping by handy with a 40,000
> > entry linker script ... made ld.lld take about 15 minutes to do the
> > final link. :(
> 
> Placing N orphan sections requires O(N^2) time (in both GNU ld and lld) :(

Owchy. :)

> [...]
> Now I learned the term FGKASLR... I need to do some homework.

Thanks for looking into this! It'll be really nice to have the orphan
section warnings working in the kernel. And getting the ground work for
FGKASLR ready will be nice!

Kristen, can I convince you that FG stands for function-granular
instead of fine-grain? :)

-- 
Kees Cook
