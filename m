Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7B1C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 12:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C19272074F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 12:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdNmKdGE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbgC0MIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 08:08:19 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:36096 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgC0MIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 08:08:19 -0400
Received: by mail-il1-f193.google.com with SMTP id p13so8493313ilp.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 05:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kbO0lHuZsUKur8Xx2DyfrCXgWZZVXfZaATPKKkvt8Bc=;
        b=QdNmKdGEdVooYkdLrfjElrOl7ucEZ9mfMAJhGRxScANHMCVkg3Qd6V0V7cH8bqZYf1
         tpLq3sBCFSUZsPpYwIWYrWBnbiNfhCZ86lFyBhhICmzdbhtB1YWLGtPFGvtqv0+nutJV
         K/ooAFHXoJ3NFbvve25P3+e82TdtYzQAoR2z5ePDTAVFwlLsiZc3iXPWGZRKLFiPB4BP
         1s7bLPnQP85Q2UbhFMzdZUL39/epdFiKVAzfK1rhScSYWKbetINEzggXcCWC+/0W7YRL
         6o25P/11cEAO4RpEzIwYLyYzls7lWLt8ILwsORgkdYjJfEaSuY0UlwKTmwsxPQJmW1Wb
         WYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kbO0lHuZsUKur8Xx2DyfrCXgWZZVXfZaATPKKkvt8Bc=;
        b=NFrliA9NlOU+RKXx/OHvo548OleHzlX96+Qh7F8ke5KxiNUnXPtX8HYJSaSNzabbhu
         4T3EH+24SxYY7/khF4iQPxd/mWk4e1tgKQGqDhvdQqTNvC2qiopO8fkclvzJT2JQVa4c
         N09IURCfM0mutd/pLR5Pce4Fot423c/qxOfdKNUn6s88a2ASPLrAX0eSqdohi+6bWVIV
         QLRv91c5F1Z9v+yeW+1yzp6oZW+VENdBFT9eJIs9iRene8k1vkFgrOIoEv4oo8lj6nFM
         I3Wl7USnuDXrQMXBpVgKAauN/s046aAwxgG6fR5Y2dpQsH5Sa2Xz1oa9HJqHkwDck4h8
         V6fw==
X-Gm-Message-State: ANhLgQ260SHZ5gKClXCLxseuQb/JJU7KcyZ3kdabOCx3pxAPXAujR9gt
        AG3TTCCj9d3qIZ+XDN/yH/XzcMSdlnWsYO+otDuDc0rr
X-Google-Smtp-Source: ADFU+vut+1DUt6ANPYKIkv5LwhoW56JDBrS4rSXFOhzWBkL3Y8PA6qdwdonFWuBzjFRs/qgDletxgqG1c1IHvaLCa58=
X-Received: by 2002:a92:bf0b:: with SMTP id z11mr12605401ilh.213.1585310897779;
 Fri, 27 Mar 2020 05:08:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200326174314.254662-1-hjl.tools@gmail.com> <20200327104450.GA8015@zn.tnic>
In-Reply-To: <20200327104450.GA8015@zn.tnic>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Fri, 27 Mar 2020 05:07:41 -0700
Message-ID: <CAMe9rOpTWtojC=cJzw1AECrT=Q_cYN06uiv1V2JySwVm7N71dA@mail.gmail.com>
Subject: Re: [PATCH] x86: Discard .note.gnu.property sections in vDSO
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 3:44 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, Mar 26, 2020 at 10:43:14AM -0700, H.J. Lu wrote:
> > With the command-line option, -mx86-used-note=yes, the x86 assembler
>
> I see:
>
>        -mx86-used-note=no
>        -mx86-used-note=yes
>            These options control whether the assembler should generate
>            GNU_PROPERTY_X86_ISA_1_USED and GNU_PROPERTY_X86_FEATURE_2_USED GNU property
>            notes.  The default can be controlled by the --enable-x86-used-note
>            configure option.
>
> Is there a plan to use this build option in the kernel in the future or
> all binutils will have it enabled or what's the story here?
>
> Because I don't see -mx86-used-note used anywhere in the kernel...

-mx86-used-note=yes can be enabled by default at binutils configure time:

[hjl@gnu-cfl-2 ~]$ as --help | grep mx86-used-note
  -mx86-used-note=[no|yes] (default: yes)
[hjl@gnu-cfl-2 ~]$

I am changing the commit log to

---
With the command-line option, -mx86-used-note=yes, which can also be
enabled at binutils build time with

  --enable-x86-used-note  generate GNU x86 used ISA and feature properties

the x86 assembler in binutils 2.32 and above generates a program property
note in a note section, .note.gnu.property, to encode used x86 ISAs and
features.  But kernel linker script only contains a single NOTE segment:
---

> > in binutils 2.32 and above generates a program property note in a note
> > section, .note.gnu.property, to encode used x86 ISAs and features.  But
> > x86 kernel vDSO linker script only contains a single NOTE segment:
> >
> > PHDRS
> > {
> >  text PT_LOAD FLAGS(5) FILEHDR PHDRS; /* PF_R|PF_X */
> >  dynamic PT_DYNAMIC FLAGS(4); /* PF_R */
> >  note PT_NOTE FLAGS(4); /* PF_R */
> >  eh_frame_hdr 0x6474e550;
> > }
> >
> > The NOTE segment generated by vDSO linker script is aligned to 4 bytes.
> > But .note.gnu.property section must be aligned to 8 bytes on x86-64 and
> > we get
> >
> > [hjl@gnu-skx-1 vdso]$ readelf -n vdso64.so
> >
> > Displaying notes found in: .note
> >   Owner                Data size      Description
> >   Linux                0x00000004     Unknown note type: (0x00000000)
> >    description data: 06 00 00 00
> > readelf: Warning: note with invalid namesz and/or descsz found at offset 0x20
> > readelf: Warning:  type: 0x78, namesize: 0x00000100, descsize: 0x756e694c, alignment: 8
> > [hjl@gnu-skx-1 vdso]$
> >
> > Since note.gnu.property section in vDSO is not checked by dynamic linker,
> > this patch discards .note.gnu.property sections in vDSO by adding
>
> Avoid having "This patch" or "This commit" in the commit message. It is
> tautologically useless.

I am changing it to

Since note.gnu.property section in kernel image is never used, discard
.note.gnu.property sections in kernel linker script by adding

/DISCARD/ : {
  *(.note.gnu.property)
}

> Also, do
>
> $ git grep 'This patch' Documentation/process
>
> for more details.

Thanks.

-- 
H.J.
