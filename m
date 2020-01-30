Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBAB1C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 20:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF2D620708
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 20:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EiDoJLVi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbgA3UFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 15:05:32 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40742 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbgA3UFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 15:05:31 -0500
Received: by mail-oi1-f196.google.com with SMTP id a142so4888968oii.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 12:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=94xgiZ2GumdGMWJPAkQ3lyvxruP/ROGgeixLfGHw8Ow=;
        b=EiDoJLViz5lUKkMfgtBo8x5JnS7D+OdkBhGRwWBdINZjG2IGt2XkWeAnHNpgBuUi5e
         +qAfzqN8IdhbxK/50JNcYwaSo+9mJ9BVi9jw+XsV0hjKstwSsTSSF2Xjv7Jyci+kp6DJ
         LpVxgaDXdnf5qntrp9/i2qcKJc2bAn2oLFD4zHdnzQmvOHlzbqAVY0ilMBHpoxPCvUxs
         hl30zg1wsxT8yKMOr5CZvPT7b4mKV3MjARh6A1cq3eh6kEG+W9CSZcNdwgoygeMP0usu
         iNbtD52IJSZ2KxFtmH7gTnYd3+m0vizDKMHpV2WYwmcYyitgswhnvKza5hwsKCg1XRAC
         RrTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=94xgiZ2GumdGMWJPAkQ3lyvxruP/ROGgeixLfGHw8Ow=;
        b=qDiad1V3gO87tcItaGpinS9+GFGHhluqLdEt2EIWWv1SyzXV9iOQIV4mEDny3OuqoS
         X1cuqTjI7axitSgT243ZSVDinXcgwtAuY/9P7l5AEtzfO8aHA3DBKc9fEWmXmXkWOnr5
         CZKLvEYg3KStWM2JnJioTitnT/LrF/drG5WDTJDh2c5WKjtW7T2FGsVXC4aFbEtEaNeB
         KDfMNZ6+8tqyEo14nyH0sFLO1FVIiXQHI80eO4v4bQMtcKrAsC9A0MpVQR6I5KQg2G6b
         tp1WQDBlsI70qs3FNQcUZOctzdV2VLn2F4t+RcCNb8i31I57B1NqzD7BjvK96td/x8WX
         83aw==
X-Gm-Message-State: APjAAAUxGRpSQKzPWa9YibLGmGmrzWkZNkgntioDD7Xqi1mO16vM66cG
        Ig4E6hGbyApe0XrrGWGcG6viGmm07XzpnxgM2AM=
X-Google-Smtp-Source: APXvYqyVj9Wrj/4DIMLggqhfTwjlBIv98W9yE4P5oojXinLflpKsa/LIPbMLXErln3G4483H+MEy18jv5ttZh3OTQ94=
X-Received: by 2002:aca:1b17:: with SMTP id b23mr2344068oib.95.1580414730517;
 Thu, 30 Jan 2020 12:05:30 -0800 (PST)
MIME-Version: 1.0
References: <20200124181819.4840-1-hjl.tools@gmail.com> <20200124181819.4840-3-hjl.tools@gmail.com>
 <202001271531.B9ACE2A@keescook> <CAMe9rOrVyzvaTyURc4RJJTHUXGG6uAC9KyQomxQFzWzrAN4nrg@mail.gmail.com>
 <202001301143.288B55DCC1@keescook>
In-Reply-To: <202001301143.288B55DCC1@keescook>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Thu, 30 Jan 2020 12:04:54 -0800
Message-ID: <CAMe9rOocT960KsofP9o_y49FdgY9NGix=GcYnpKLvp7RhieZNA@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86: Discard .note.gnu.property sections in vmlinux
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 11:51 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Jan 30, 2020 at 09:51:38AM -0800, H.J. Lu wrote:
> > On Mon, Jan 27, 2020 at 3:34 PM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > On Fri, Jan 24, 2020 at 10:18:19AM -0800, H.J. Lu wrote:
> > > > With the command-line option, -mx86-used-note=yes, the x86 assembler
> > > > in binutils 2.32 and above generates a program property note in a note
> > > > section, .note.gnu.property, to encode used x86 ISAs and features.
> > > > But x86 kernel linker script only contains a signle NOTE segment:
> > > >
> > > > PHDRS {
> > > >  text PT_LOAD FLAGS(5);
> > > >  data PT_LOAD FLAGS(6);
> > > >  percpu PT_LOAD FLAGS(6);
> > > >  init PT_LOAD FLAGS(7);
> > > >  note PT_NOTE FLAGS(0);
> > > > }
> > > > SECTIONS
> > > > {
> > > > ...
> > > >  .notes : AT(ADDR(.notes) - 0xffffffff80000000) { __start_notes = .; KEEP(*(.not
> > > > e.*)) __stop_notes = .; } :text :note
> > > > ...
> > > > }
> > > >
> > > > which may not be incompatible with note.gnu.property sections.  Since
>
> I don't understand this. "may not be incompatible"? Is there an error
> generated? If so, what does it look like?

When -mx86-used-note=yes is passed to assembler, with my patch, I got

[hjl@gnu-skx-1 linux]$ readelf -n vmlinux

Displaying notes found in: .notes
  Owner                Data size Description
  Xen                  0x00000006 Unknown note type: (0x00000006)
   description data: 6c 69 6e 75 78 00
  Xen                  0x00000004 Unknown note type: (0x00000007)
   description data: 32 2e 36 00
  Xen                  0x00000008 Unknown note type: (0x00000005)
   description data: 78 65 6e 2d 33 2e 30 00
  Xen                  0x00000008 Unknown note type: (0x00000003)
   description data: 00 00 00 80 ff ff ff ff
  Xen                  0x00000008 Unknown note type: (0x0000000f)
   description data: 00 00 00 00 80 00 00 00
  Xen                  0x00000008 NT_VERSION (version)
   description data: 80 a1 ba 82 ff ff ff ff
  Xen                  0x00000008 NT_ARCH (architecture)
   description data: 00 10 00 81 ff ff ff ff
  Xen                  0x00000029 Unknown note type: (0x0000000a)
   description data: 21 77 72 69 74 61 62 6c 65 5f 70 61 67 65 5f 74
61 62 6c 65 73 7c 70 61 65 5f 70 67 64 69 72 5f 61 62 6f 76 65 5f 34
67 62
  Xen                  0x00000004 Unknown note type: (0x00000011)
   description data: 01 88 00 00
  Xen                  0x00000004 Unknown note type: (0x00000009)
   description data: 79 65 73 00
  Xen                  0x00000008 Unknown note type: (0x00000008)
   description data: 67 65 6e 65 72 69 63 00
  Xen                  0x00000010 Unknown note type: (0x0000000d)
   description data: 01 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00
  Xen                  0x00000004 Unknown note type: (0x0000000e)
   description data: 01 00 00 00
  Xen                  0x00000004 Unknown note type: (0x00000010)
   description data: 01 00 00 00
  Xen                  0x00000008 Unknown note type: (0x0000000c)
   description data: 00 00 00 00 00 80 ff ff
  Xen                  0x00000008 Unknown note type: (0x00000004)
   description data: 00 00 00 00 00 00 00 00
  GNU                  0x00000014 NT_GNU_BUILD_ID (unique build ID bitstring)
    Build ID: 11c73de2922f593e1b35b92ab3c70eaa1a80fa83
  Linux                0x00000018 OPEN
   description data: 35 2e 33 2e 39 2d 32 30 30 2e 30 2e 66 63 33 30
2e 78 38 36 5f 36 34 00
  Xen                  0x00000008 Unknown note type: (0x00000012)
   description data: 70 04 00 01 00 00 00 00
[hjl@gnu-skx-1 linux]$

Without my patch,

[hjl@gnu-skx-1 linux]$ readelf -n vmlinux

Displaying notes found in: .notes
  Owner                Data size Description
  Xen                  0x00000006 Unknown note type: (0x00000006)
   description data: 6c 69 6e 75 78 00
  Xen                  0x00000004 Unknown note type: (0x00000007)
   description data: 32 2e 36 00
  xen-3.0              0x00000005 Unknown note type: (0x006e6558)
   description data: 08 00 00 00 03
readelf: Warning: note with invalid namesz and/or descsz found at offset 0x50
readelf: Warning:  type: 0xffffffff, namesize: 0x006e6558, descsize:
0x80000000, alignment: 8
[hjl@gnu-skx-1 linux]$

> > > > note.gnu.property section in kernel image is unused, this patch discards
> > > > .note.gnu.property sections in kernel linker script by adding
> > > >
> > > >  /DISCARD/ : {
> > > >   *(.note.gnu.property)
> > > >  }
> > >
> > > I think this is happening in the wrong place? Shouldn't this be in the
> > > DISCARDS macro in include/asm-generic/vmlinux.lds.h instead?
> >
> > Please read my commit message closely.   We can't discard .note.gnu.property
> > sections by adding .note.gnu.property to default discarded sections
> > since default
> > discarded sections are placed AFTER .notes sections in x86 kernel
> > linker scripts.
>
> I see what you mean now, /DISCARD/ happens after the NOTES macro (now in
> the RO_DATA macro). To this end, I think this should be in
> include/asm-generic/vmlinux.lds.h in the NOTES macro? It's x86-specific
> right now, but why not make this future-proof?

I am trying to avoid touching generic parts.  I will give it a try.

> I'd like to avoid as much arch-specific linker stuff as we can. I spent
> a lot of time trying to clean up NOTES specifically. :)
>
> > +     /* .note.gnu.property sections should be discarded */
>
> This comment should say _why_ -- the script already shows _what_ is
> happening...

I will update comments.

> > +     /DISCARD/ : {
> > +             *(.note.gnu.property)
> > +     }
>

Thanks.

-- 
H.J.
