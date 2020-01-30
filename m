Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB31C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 20:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC5332083E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 20:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSaB8Xzx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbgA3UVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 15:21:08 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39505 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgA3UVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 15:21:07 -0500
Received: by mail-ot1-f67.google.com with SMTP id 77so4359881oty.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 12:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fOJEE1fkLwQsVSnFFDCeiNMIe7GX26OPeYKy9HbEFGg=;
        b=dSaB8Xzxl0tgYBnY8WWqccFO4aKhOpEKCcG8OYcXKqhigHa4cX5a+yQ6m3OoPjKe2a
         9KtGInNtcrHL82kDG1PHJCpk15YLNm4JbKkuAz58+CPLeNUN/BzlL4RZHZx4wzj0F8zv
         gIo2SXPaWtKj5ASJEqCiWPC4BKKt5TXBMSvmSalsF4BA1EkOpS+NFqlFsc1o8s4ZOyZF
         RYLSwGwLF1T3Z6mw+kMgBJqs2HwgokfUxtN5xRXKyrWvLTXCKZdSHoa9TqV7uEiX7NLx
         E9meXMT/aBKgHxVSzDSh7eFntmyec2YfC8nOp2aNXD7V6Isx3eU3sKBB3/5QlMHxxANl
         Hg8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fOJEE1fkLwQsVSnFFDCeiNMIe7GX26OPeYKy9HbEFGg=;
        b=oaCTJt/zp2FGCk56qgcfIFZ5JLjxWH1XY1lGuLwIlnrU1IyQjiCPriHPh7sY7FFRdX
         r1I0ZIkJkKufbMHj33QNOxySaUGxKlNMMAdWTWPtTgGUZkM2R3LBB23sO3+ZLe4gkaEC
         UI9fPANc7NXNrNluR+vuYASOsIvYkr988dyHURcTGdBgD1lVSgXTDWLDPIH5YffE4jyx
         yjTt1kYm5VdFkNlFRa4EOUHZR3ZD9g+XqgHMNbrYUfAAyB5mQRdxDyBK6uydqBRhVsvV
         EVGfgz2aPIXWeGsaVYL+hInoHw0cQQeGONedjrLTBgY2fDifJ81BtLlYt21Xwmatos7P
         5vtg==
X-Gm-Message-State: APjAAAUw/9erOMX7gMCh3OsJr6HZTQoG1k/Gb/bRgR6+iZlRQwdAugml
        oVl/wwO9rQyeMN6tPwFb9U+ivHXg+0S3xlcvC+I=
X-Google-Smtp-Source: APXvYqzDM8OCFgNpvqzUl2WS7ghEHAAo5ALxx1Xwxs+PJKijo5lCEE8CT8lEB9ddQyjzOMjy6M3gmCPlGP6jjUGEAPw=
X-Received: by 2002:a05:6830:1e30:: with SMTP id t16mr5070986otr.220.1580415665784;
 Thu, 30 Jan 2020 12:21:05 -0800 (PST)
MIME-Version: 1.0
References: <20200124181819.4840-1-hjl.tools@gmail.com> <20200124181819.4840-3-hjl.tools@gmail.com>
 <202001271531.B9ACE2A@keescook> <CAMe9rOrVyzvaTyURc4RJJTHUXGG6uAC9KyQomxQFzWzrAN4nrg@mail.gmail.com>
 <202001301143.288B55DCC1@keescook> <CAMe9rOocT960KsofP9o_y49FdgY9NGix=GcYnpKLvp7RhieZNA@mail.gmail.com>
 <202001301206.13AF0512@keescook>
In-Reply-To: <202001301206.13AF0512@keescook>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Thu, 30 Jan 2020 12:20:30 -0800
Message-ID: <CAMe9rOoU1B8enyoL4-SSQKYLHpevR5yrbp5ewztC=Owr69y2SQ@mail.gmail.com>
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

On Thu, Jan 30, 2020 at 12:08 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Jan 30, 2020 at 12:04:54PM -0800, H.J. Lu wrote:
> > > I don't understand this. "may not be incompatible"? Is there an error
> > > generated? If so, what does it look like?
> >
> > When -mx86-used-note=yes is passed to assembler, with my patch, I got
> >
> > [hjl@gnu-skx-1 linux]$ readelf -n vmlinux
> >
> > Displaying notes found in: .notes
> >   Owner                Data size Description
> >   Xen                  0x00000006 Unknown note type: (0x00000006)
> >    description data: 6c 69 6e 75 78 00
> >   Xen                  0x00000004 Unknown note type: (0x00000007)
> >    description data: 32 2e 36 00
> >   Xen                  0x00000008 Unknown note type: (0x00000005)
> >    description data: 78 65 6e 2d 33 2e 30 00
> >   Xen                  0x00000008 Unknown note type: (0x00000003)
> >    description data: 00 00 00 80 ff ff ff ff
> >   Xen                  0x00000008 Unknown note type: (0x0000000f)
> >    description data: 00 00 00 00 80 00 00 00
> >   Xen                  0x00000008 NT_VERSION (version)
> >    description data: 80 a1 ba 82 ff ff ff ff
> >   Xen                  0x00000008 NT_ARCH (architecture)
> >    description data: 00 10 00 81 ff ff ff ff
> >   Xen                  0x00000029 Unknown note type: (0x0000000a)
> >    description data: 21 77 72 69 74 61 62 6c 65 5f 70 61 67 65 5f 74
> > 61 62 6c 65 73 7c 70 61 65 5f 70 67 64 69 72 5f 61 62 6f 76 65 5f 34
> > 67 62
> >   Xen                  0x00000004 Unknown note type: (0x00000011)
> >    description data: 01 88 00 00
> >   Xen                  0x00000004 Unknown note type: (0x00000009)
> >    description data: 79 65 73 00
> >   Xen                  0x00000008 Unknown note type: (0x00000008)
> >    description data: 67 65 6e 65 72 69 63 00
> >   Xen                  0x00000010 Unknown note type: (0x0000000d)
> >    description data: 01 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00
> >   Xen                  0x00000004 Unknown note type: (0x0000000e)
> >    description data: 01 00 00 00
> >   Xen                  0x00000004 Unknown note type: (0x00000010)
> >    description data: 01 00 00 00
> >   Xen                  0x00000008 Unknown note type: (0x0000000c)
> >    description data: 00 00 00 00 00 80 ff ff
> >   Xen                  0x00000008 Unknown note type: (0x00000004)
> >    description data: 00 00 00 00 00 00 00 00
> >   GNU                  0x00000014 NT_GNU_BUILD_ID (unique build ID bitstring)
> >     Build ID: 11c73de2922f593e1b35b92ab3c70eaa1a80fa83
> >   Linux                0x00000018 OPEN
> >    description data: 35 2e 33 2e 39 2d 32 30 30 2e 30 2e 66 63 33 30
> > 2e 78 38 36 5f 36 34 00
> >   Xen                  0x00000008 Unknown note type: (0x00000012)
> >    description data: 70 04 00 01 00 00 00 00
> > [hjl@gnu-skx-1 linux]$
> >
> > Without my patch,
> >
> > [hjl@gnu-skx-1 linux]$ readelf -n vmlinux
> >
> > Displaying notes found in: .notes
> >   Owner                Data size Description
> >   Xen                  0x00000006 Unknown note type: (0x00000006)
> >    description data: 6c 69 6e 75 78 00
> >   Xen                  0x00000004 Unknown note type: (0x00000007)
> >    description data: 32 2e 36 00
> >   xen-3.0              0x00000005 Unknown note type: (0x006e6558)
> >    description data: 08 00 00 00 03
> > readelf: Warning: note with invalid namesz and/or descsz found at offset 0x50
> > readelf: Warning:  type: 0xffffffff, namesize: 0x006e6558, descsize:
> > 0x80000000, alignment: 8
> > [hjl@gnu-skx-1 linux]$
>
> What is the source of this failure? Does readelf need updating instead?
> Is the linking step producing an invalid section? It seems like
> discarding the properties isn't the right solution here?

With the command-line option, -mx86-used-note=yes, the x86 assembler
in binutils 2.32 and above generates a program property note in a note
section, .note.gnu.property, to encode used x86 ISAs and features.
But x86 kernel linker script only contains a signle NOTE segment:

PHDRS {
 text PT_LOAD FLAGS(5);
 data PT_LOAD FLAGS(6);
 percpu PT_LOAD FLAGS(6);
 init PT_LOAD FLAGS(7);
 note PT_NOTE FLAGS(0);
}
SECTIONS
{
...
 .notes : AT(ADDR(.notes) - 0xffffffff80000000) { __start_notes = .; KEEP(*(.not
e.*)) __stop_notes = .; } :text :note
...
}

But .note.gnu.property must be 8-byte aligned.  Linker deals with it
by generating
2 PT_NOTE segments, one has 4-byte alignment and the other has 8-byte alignment:

[hjl@gnu-cfl-1 ~]$ readelf -l /usr/local/bin/ld

Elf file type is EXEC (Executable file)
Entry point 0x404530
There are 13 program headers, starting at offset 64

Program Headers:
  Type           Offset             VirtAddr           PhysAddr
                 FileSiz            MemSiz              Flags  Align
  PHDR           0x0000000000000040 0x0000000000400040 0x0000000000400040
                 0x00000000000002d8 0x00000000000002d8  R      0x8
  INTERP         0x0000000000000318 0x0000000000400318 0x0000000000400318
                 0x000000000000001c 0x000000000000001c  R      0x1
      [Requesting program interpreter: /lib64/ld-linux-x86-64.so.2]
  LOAD           0x0000000000000000 0x0000000000400000 0x0000000000400000
                 0x0000000000002a30 0x0000000000002a30  R      0x1000
  LOAD           0x0000000000003000 0x0000000000403000 0x0000000000403000
                 0x00000000000d7b35 0x00000000000d7b35  R E    0x1000
  LOAD           0x00000000000db000 0x00000000004db000 0x00000000004db000
                 0x0000000000179248 0x0000000000179248  R      0x1000
  LOAD           0x0000000000254de0 0x0000000000655de0 0x0000000000655de0
                 0x00000000000062e8 0x000000000000ba68  RW     0x1000
  DYNAMIC        0x0000000000254df0 0x0000000000655df0 0x0000000000655df0
                 0x0000000000000200 0x0000000000000200  RW     0x8
  NOTE           0x0000000000000338 0x0000000000400338 0x0000000000400338
                 0x0000000000000030 0x0000000000000030  R      0x8
  NOTE           0x0000000000000368 0x0000000000400368 0x0000000000400368
                 0x0000000000000044 0x0000000000000044  R      0x4
  GNU_PROPERTY   0x0000000000000338 0x0000000000400338 0x0000000000400338
                 0x0000000000000030 0x0000000000000030  R      0x8
  GNU_EH_FRAME   0x0000000000233efc 0x0000000000633efc 0x0000000000633efc
                 0x000000000000478c 0x000000000000478c  R      0x4
  GNU_STACK      0x0000000000000000 0x0000000000000000 0x0000000000000000
                 0x0000000000000000 0x0000000000000000  RW     0x10
  GNU_RELRO      0x0000000000254de0 0x0000000000655de0 0x0000000000655de0
                 0x0000000000000220 0x0000000000000220  R      0x1

 Section to Segment mapping:
  Segment Sections...
   00
   01     .interp
   02     .interp .note.gnu.property .note.gnu.build-id .note.ABI-tag
.hash .gnu.hash .dynsym .dynstr .gnu.version .gnu.version_r .rela.dyn
.rela.plt
   03     .init .plt .text .fini
   04     .rodata .eh_frame_hdr .eh_frame
   05     .init_array .fini_array .dynamic .got .got.plt .data .bss
   06     .dynamic
   07     .note.gnu.property
   08     .note.gnu.build-id .note.ABI-tag
   09     .note.gnu.property
   10     .eh_frame_hdr
   11
   12     .init_array .fini_array .dynamic .got
[hjl@gnu-cfl-1 ~]$

Since .note.gnu.property in vmlinux is unused, it can be discarded.

-- 
H.J.
