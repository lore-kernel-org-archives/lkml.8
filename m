Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A3CC38BE2
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 20:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA34020732
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 20:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IU480/eX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbgBXUv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 15:51:26 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37234 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbgBXUv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 15:51:26 -0500
Received: by mail-pf1-f194.google.com with SMTP id p14so5963649pfn.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 12:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jRq4pHDxuVRc7aayKg6MpqkDQ8S3ZSOkFs6fEcDKK0o=;
        b=IU480/eXPWvhS9EHPf7MNW016x1zh5V4dxlrK8iAuDS26pQgW2+UqLW1Iyqm14qYRQ
         auJIu2WCWHmhrMXju0bfXnQlEt1DEJmLhG4OHAoYBi88S+AYEb3VEuqq8cE8Iti2Ngvx
         eGSKwSvng+3K1RVSXF0KXiERYYT12TETUB1Kq5t4kgGNtj5Vop7sCuy+OkW0TDQHwIeU
         AhHy12YQX/A55dkFcAv2vH0UG3JM3unTcU4ofWodum/YvywpKaTa/rYJLHP/wy4fqEXJ
         NJrunc/YeqjOveUVA2xBXdRCI4HOgu9nFXDDhScbLqFyg3VwOo3pBOn8Y0AKPfNaODgX
         kVSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jRq4pHDxuVRc7aayKg6MpqkDQ8S3ZSOkFs6fEcDKK0o=;
        b=Vai0vjPH0Zvp923lV6Styx0gJdLMRlbyShVGvjyIx+aZSm8L0NzXEgk/PR9gJOGYEv
         ou/cg/HQnSo4XrpYp4sxe+pwzl+kjBQ33oOtLvXKp1ciQVf5ztVK1yQmEEglihNkbDvR
         DAC2wpsE5+AqfK965Ui7d0imLPeD63zgAj5fJah22GKP6CwdNEm0t3UJJVUoBdZU4C0n
         sux5/EbuVHhgawEWyTV7dixLRoICv98OcmJXMPNAYK+JMPNk07LxXWFu0xMUJlWLZLqA
         07x+y37W4TKDeeRcAwDxhTxYRyjiK853ISR3otTnwYi1MsTASuU8CQZj05shIdSPBi2S
         ymPw==
X-Gm-Message-State: APjAAAUEtzSJEoZQszDo6xO/Ae4VqjQax8lJ9HMN4d7oUeU4zh79ZA2w
        DoZI/s73B1covFo+Sbes3AU18VuGw5lpAGzFVD+9fg==
X-Google-Smtp-Source: APXvYqzok7aE34QEYfjGZA9qQtbEAuKSXoSDQbao1jucTKTY39CHYx7GjPVVjZxvljqsOgBegnFj+df3sWnSk6IaIag=
X-Received: by 2002:a63:4e22:: with SMTP id c34mr18743179pgb.263.1582577485165;
 Mon, 24 Feb 2020 12:51:25 -0800 (PST)
MIME-Version: 1.0
References: <20200109150218.16544-1-nivedita@alum.mit.edu> <20200109150218.16544-2-nivedita@alum.mit.edu>
 <20200222050845.GA19912@ubuntu-m2-xlarge-x86> <20200222065521.GA11284@zn.tnic>
 <20200222070218.GA27571@ubuntu-m2-xlarge-x86> <20200222072144.asqaxlv364s6ezbv@google.com>
 <20200222074254.GB11284@zn.tnic> <20200222162225.GA3326744@rani.riverdale.lan>
 <CAKwvOdnvMS21s9gLp5nUpDAOu=c7-iWYuKTeFUq+PMhsJOKUgw@mail.gmail.com> <alpine.LSU.2.21.2002241319150.12812@wotan.suse.de>
In-Reply-To: <alpine.LSU.2.21.2002241319150.12812@wotan.suse.de>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 24 Feb 2020 12:51:14 -0800
Message-ID: <CAKwvOd=nCAyXtng1N-fvNYa=-NGD0yu+Rm6io9F1gs0FieatwA@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86/boot/compressed: Remove unnecessary sections from bzImage
To:     Michael Matz <matz@suse.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 5:28 AM Michael Matz <matz@suse.de> wrote:
>
> Hello,
>
> On Sat, 22 Feb 2020, Nick Desaulniers wrote:
>
> > > > > In GNU ld, it seems that .shstrtab .symtab and .strtab are special
> > > > > cased. Neither the input section description *(.shstrtab) nor *(*)
> > > > > discards .shstrtab . I feel that this is a weird case (probably even a bug)
> > > > > that lld should not implement.
> > > >
> > > > Ok, forget what the tools do for a second: why is .shstrtab special and
> > > > why would one want to keep it?
> > > >
> > > > Because one still wants to know what the section names of an object are
> > > > or other tools need it or why?
> > > >
> > > > Thx.
> > > >
> > > > --
> > > > Regards/Gruss,
> > > >     Boris.
> > > >
> > > > https://people.kernel.org/tglx/notes-about-netiquette
> > >
> > > .shstrtab is required by the ELF specification. The e_shstrndx field in
> > > the ELF header is the index of .shstrtab, and each section in the
> > > section table is required to have an sh_name that points into the
> > > .shstrtab.
> >
> > Yeah, I can see it both ways.  That `*` doesn't glob all remaining
> > sections is surprising to me, but bfd seems to be "extra helpful" in
> > not discarding sections that are required via ELF spec.
>
> In a way the /DISCARD/ assignment should be thought of as applying to
> _input_ sections (as all such section references on the RHS), not
> necessarily to output sections.  What this then means for sections that
> are synthesized by the link editor is less clear.  Some of them are
> generated regardless (as you noted, e.g. the symbol table and associated
> string sections, including section name string table), some of them are
> suppressed, and either lead to an followup error (e.g. with .gnu.hash), or
> to invalid output (e.g. missing .dynsym for executables simply lead to
> segfaults when running them).
>
> That's the reason for the perceived inconsistency with behaviour on '*':
> it's application to synthesized sections.  Arguably bfd should be fixed to
> also not discard the other essential sections (or alternatively to give an
> error when an essential section is discarded).  The lld behaviour of e.g.
> discarding .shstrtab (or other synthesized sections necessary for valid
> ELF output) doesn't make much sense either, though.

Hi Michael, thank you for the precise feedback.  Do you have a list of
"synthesized sections necessary for valid ELF output?" Also, could you
point me to the documentation about `*` and its relation to
"synthesized sections necessary for valid ELF output?"  This will help
me file a precise bug against LLD.
-- 
Thanks,
~Nick Desaulniers
