Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F493C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 20:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C1EA20674
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 20:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlB7Xgyd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbgA3UtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 15:49:16 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34881 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbgA3UtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 15:49:15 -0500
Received: by mail-oi1-f195.google.com with SMTP id b18so5066388oie.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 12:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vCcT1siJ5IBV77H1OUSBgYaYnrWi80q3LjkbW9oaqPQ=;
        b=KlB7XgydGS9R8VyUicwHZE7j/2w75FxxT7ri4D9pJK/mkGVUJF3iYmEBMdO7355lhL
         H+Brxm59MX+GUXWGl1nY8Zhxbq3/vlkWohFDY6gIxPWlTlXiBt5z/HGQOWoLbF8ytCty
         +c/R23X5Zcp9XIqUXVn3w0Vsxw3/8xiHakyI/mib0lhCV5J9E7TIAigWC9QmBx5TzkXD
         RO6qTA2VIaOMeYui6Fab8InzGjFohcw/Mlz3z7xNxsmSsFR7+SPOtdu8df7eIehBtGGj
         BhbtTCs7UeaM7lTXNkt2TTlP5z0ATqbjKFR1raDaAmQX1GMgyuHUoCm95qLj40dFFsQH
         vQgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vCcT1siJ5IBV77H1OUSBgYaYnrWi80q3LjkbW9oaqPQ=;
        b=APlwwtjOTgBIS+xJGeWfERqvSaR8i4EBSqKSUWZv5Z1BZd2NLNRpR5DQC4o8SKdip9
         osHaR/SlGCqpRRDSSKSOP9XqxiabwoS+qfzo2FPnOUVvFi3AXEJaItjh0Tx2Euq69Hj1
         bkz7waqJuEqAvc4rvO7JTTszFWxhj1WRvEqkM+s8EewTXxgPmHqx4/4KfEc0NvFnu+pu
         xE/CmzcGBuKsgJ0Bl2lyTHBZ1W8GG+6Ldin1sySEV5ME5ivPzQtpBfd8j7XmTWfmCsJj
         cZWUz4O8aBv2Y0LOnLwPZ8BqWpQ5cuOmAalYT2mUAb4wos94lmu7UC2m+oL/rHmswNJ9
         9lug==
X-Gm-Message-State: APjAAAUsW3yuuEb/bJ1aRj8mXTRO9lZ2XuKQsSnHoxbwBcm1NSA5tjDe
        S3wWeKECOLMI+dSAG38teNuWEgR71gHXfe/7HsE=
X-Google-Smtp-Source: APXvYqz35hoJH3yaW1Pxi1antqnUr+yY7Tqi4je1okA561lP9Z5To7Bh605Ul9kp8hoDrs6ecIdPzGtl66/rZQEZzZ0=
X-Received: by 2002:a54:4011:: with SMTP id x17mr4035693oie.35.1580417354465;
 Thu, 30 Jan 2020 12:49:14 -0800 (PST)
MIME-Version: 1.0
References: <20200124181819.4840-1-hjl.tools@gmail.com> <20200124181819.4840-3-hjl.tools@gmail.com>
 <202001271531.B9ACE2A@keescook> <CAMe9rOrVyzvaTyURc4RJJTHUXGG6uAC9KyQomxQFzWzrAN4nrg@mail.gmail.com>
 <202001301143.288B55DCC1@keescook> <CAMe9rOocT960KsofP9o_y49FdgY9NGix=GcYnpKLvp7RhieZNA@mail.gmail.com>
 <202001301206.13AF0512@keescook> <CAMe9rOoU1B8enyoL4-SSQKYLHpevR5yrbp5ewztC=Owr69y2SQ@mail.gmail.com>
In-Reply-To: <CAMe9rOoU1B8enyoL4-SSQKYLHpevR5yrbp5ewztC=Owr69y2SQ@mail.gmail.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Thu, 30 Jan 2020 12:48:38 -0800
Message-ID: <CAMe9rOpkrPOsymJiBv0i3_Q6hp=fyUYLqBKpOZAHx3d5t54GDA@mail.gmail.com>
Subject: [PATCH] Discard .note.gnu.property sections in generic NOTES
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
Content-Type: multipart/mixed; boundary="00000000000002a607059d6197f5"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000002a607059d6197f5
Content-Type: text/plain; charset="UTF-8"

On Thu, Jan 30, 2020 at 12:20 PM H.J. Lu <hjl.tools@gmail.com> wrote:
>
> On Thu, Jan 30, 2020 at 12:08 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Thu, Jan 30, 2020 at 12:04:54PM -0800, H.J. Lu wrote:
> > > > I don't understand this. "may not be incompatible"? Is there an error
> > > > generated? If so, what does it look like?
> > >
> > > When -mx86-used-note=yes is passed to assembler, with my patch, I got
> > >
> > > [hjl@gnu-skx-1 linux]$ readelf -n vmlinux
> > >
> > > Displaying notes found in: .notes
> > >   Owner                Data size Description
> > >   Xen                  0x00000006 Unknown note type: (0x00000006)
> > >    description data: 6c 69 6e 75 78 00
> > >   Xen                  0x00000004 Unknown note type: (0x00000007)
> > >    description data: 32 2e 36 00
> > >   Xen                  0x00000008 Unknown note type: (0x00000005)
> > >    description data: 78 65 6e 2d 33 2e 30 00
> > >   Xen                  0x00000008 Unknown note type: (0x00000003)
> > >    description data: 00 00 00 80 ff ff ff ff
> > >   Xen                  0x00000008 Unknown note type: (0x0000000f)
> > >    description data: 00 00 00 00 80 00 00 00
> > >   Xen                  0x00000008 NT_VERSION (version)
> > >    description data: 80 a1 ba 82 ff ff ff ff
> > >   Xen                  0x00000008 NT_ARCH (architecture)
> > >    description data: 00 10 00 81 ff ff ff ff
> > >   Xen                  0x00000029 Unknown note type: (0x0000000a)
> > >    description data: 21 77 72 69 74 61 62 6c 65 5f 70 61 67 65 5f 74
> > > 61 62 6c 65 73 7c 70 61 65 5f 70 67 64 69 72 5f 61 62 6f 76 65 5f 34
> > > 67 62
> > >   Xen                  0x00000004 Unknown note type: (0x00000011)
> > >    description data: 01 88 00 00
> > >   Xen                  0x00000004 Unknown note type: (0x00000009)
> > >    description data: 79 65 73 00
> > >   Xen                  0x00000008 Unknown note type: (0x00000008)
> > >    description data: 67 65 6e 65 72 69 63 00
> > >   Xen                  0x00000010 Unknown note type: (0x0000000d)
> > >    description data: 01 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00
> > >   Xen                  0x00000004 Unknown note type: (0x0000000e)
> > >    description data: 01 00 00 00
> > >   Xen                  0x00000004 Unknown note type: (0x00000010)
> > >    description data: 01 00 00 00
> > >   Xen                  0x00000008 Unknown note type: (0x0000000c)
> > >    description data: 00 00 00 00 00 80 ff ff
> > >   Xen                  0x00000008 Unknown note type: (0x00000004)
> > >    description data: 00 00 00 00 00 00 00 00
> > >   GNU                  0x00000014 NT_GNU_BUILD_ID (unique build ID bitstring)
> > >     Build ID: 11c73de2922f593e1b35b92ab3c70eaa1a80fa83
> > >   Linux                0x00000018 OPEN
> > >    description data: 35 2e 33 2e 39 2d 32 30 30 2e 30 2e 66 63 33 30
> > > 2e 78 38 36 5f 36 34 00
> > >   Xen                  0x00000008 Unknown note type: (0x00000012)
> > >    description data: 70 04 00 01 00 00 00 00
> > > [hjl@gnu-skx-1 linux]$
> > >
> > > Without my patch,
> > >
> > > [hjl@gnu-skx-1 linux]$ readelf -n vmlinux
> > >
> > > Displaying notes found in: .notes
> > >   Owner                Data size Description
> > >   Xen                  0x00000006 Unknown note type: (0x00000006)
> > >    description data: 6c 69 6e 75 78 00
> > >   Xen                  0x00000004 Unknown note type: (0x00000007)
> > >    description data: 32 2e 36 00
> > >   xen-3.0              0x00000005 Unknown note type: (0x006e6558)
> > >    description data: 08 00 00 00 03
> > > readelf: Warning: note with invalid namesz and/or descsz found at offset 0x50
> > > readelf: Warning:  type: 0xffffffff, namesize: 0x006e6558, descsize:
> > > 0x80000000, alignment: 8
> > > [hjl@gnu-skx-1 linux]$
> >
> > What is the source of this failure? Does readelf need updating instead?
> > Is the linking step producing an invalid section? It seems like
> > discarding the properties isn't the right solution here?
>
> With the command-line option, -mx86-used-note=yes, the x86 assembler
> in binutils 2.32 and above generates a program property note in a note
> section, .note.gnu.property, to encode used x86 ISAs and features.
> But x86 kernel linker script only contains a signle NOTE segment:
>
> PHDRS {
>  text PT_LOAD FLAGS(5);
>  data PT_LOAD FLAGS(6);
>  percpu PT_LOAD FLAGS(6);
>  init PT_LOAD FLAGS(7);
>  note PT_NOTE FLAGS(0);
> }
> SECTIONS
> {
> ...
>  .notes : AT(ADDR(.notes) - 0xffffffff80000000) { __start_notes = .; KEEP(*(.not
> e.*)) __stop_notes = .; } :text :note
> ...
> }
>
> But .note.gnu.property must be 8-byte aligned.  Linker deals with it
> by generating
> 2 PT_NOTE segments, one has 4-byte alignment and the other has 8-byte alignment:
>
> [hjl@gnu-cfl-1 ~]$ readelf -l /usr/local/bin/ld
>
> Elf file type is EXEC (Executable file)
> Entry point 0x404530
> There are 13 program headers, starting at offset 64
>
> Program Headers:
>   Type           Offset             VirtAddr           PhysAddr
>                  FileSiz            MemSiz              Flags  Align
>   PHDR           0x0000000000000040 0x0000000000400040 0x0000000000400040
>                  0x00000000000002d8 0x00000000000002d8  R      0x8
>   INTERP         0x0000000000000318 0x0000000000400318 0x0000000000400318
>                  0x000000000000001c 0x000000000000001c  R      0x1
>       [Requesting program interpreter: /lib64/ld-linux-x86-64.so.2]
>   LOAD           0x0000000000000000 0x0000000000400000 0x0000000000400000
>                  0x0000000000002a30 0x0000000000002a30  R      0x1000
>   LOAD           0x0000000000003000 0x0000000000403000 0x0000000000403000
>                  0x00000000000d7b35 0x00000000000d7b35  R E    0x1000
>   LOAD           0x00000000000db000 0x00000000004db000 0x00000000004db000
>                  0x0000000000179248 0x0000000000179248  R      0x1000
>   LOAD           0x0000000000254de0 0x0000000000655de0 0x0000000000655de0
>                  0x00000000000062e8 0x000000000000ba68  RW     0x1000
>   DYNAMIC        0x0000000000254df0 0x0000000000655df0 0x0000000000655df0
>                  0x0000000000000200 0x0000000000000200  RW     0x8
>   NOTE           0x0000000000000338 0x0000000000400338 0x0000000000400338
>                  0x0000000000000030 0x0000000000000030  R      0x8
>   NOTE           0x0000000000000368 0x0000000000400368 0x0000000000400368
>                  0x0000000000000044 0x0000000000000044  R      0x4
>   GNU_PROPERTY   0x0000000000000338 0x0000000000400338 0x0000000000400338
>                  0x0000000000000030 0x0000000000000030  R      0x8
>   GNU_EH_FRAME   0x0000000000233efc 0x0000000000633efc 0x0000000000633efc
>                  0x000000000000478c 0x000000000000478c  R      0x4
>   GNU_STACK      0x0000000000000000 0x0000000000000000 0x0000000000000000
>                  0x0000000000000000 0x0000000000000000  RW     0x10
>   GNU_RELRO      0x0000000000254de0 0x0000000000655de0 0x0000000000655de0
>                  0x0000000000000220 0x0000000000000220  R      0x1
>
>  Section to Segment mapping:
>   Segment Sections...
>    00
>    01     .interp
>    02     .interp .note.gnu.property .note.gnu.build-id .note.ABI-tag
> .hash .gnu.hash .dynsym .dynstr .gnu.version .gnu.version_r .rela.dyn
> .rela.plt
>    03     .init .plt .text .fini
>    04     .rodata .eh_frame_hdr .eh_frame
>    05     .init_array .fini_array .dynamic .got .got.plt .data .bss
>    06     .dynamic
>    07     .note.gnu.property
>    08     .note.gnu.build-id .note.ABI-tag
>    09     .note.gnu.property
>    10     .eh_frame_hdr
>    11
>    12     .init_array .fini_array .dynamic .got
> [hjl@gnu-cfl-1 ~]$
>
> Since .note.gnu.property in vmlinux is unused, it can be discarded.
>

Here is a patch to discard .note.gnu.property sections in generic NOTES.

-- 
H.J.

--00000000000002a607059d6197f5
Content-Type: application/x-patch; 
	name="0001-Discard-.note.gnu.property-sections-in-generic-NOTES.patch"
Content-Disposition: attachment; 
	filename="0001-Discard-.note.gnu.property-sections-in-generic-NOTES.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_k617mj9k0>
X-Attachment-Id: f_k617mj9k0

RnJvbSA2OTAxNGFmNzFjZjQyNjNhMTA2MDk3ODcyOGE4ZTcwNTgwY2NkZWJiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiAiSC5KLiBMdSIgPGhqbC50b29sc0BnbWFpbC5jb20+CkRhdGU6
IFRodSwgMzAgSmFuIDIwMjAgMTI6Mzk6MDkgLTA4MDAKU3ViamVjdDogW1BBVENIXSBEaXNjYXJk
IC5ub3RlLmdudS5wcm9wZXJ0eSBzZWN0aW9ucyBpbiBnZW5lcmljIE5PVEVTCgpXaXRoIHRoZSBj
b21tYW5kLWxpbmUgb3B0aW9uLCAtbXg4Ni11c2VkLW5vdGU9eWVzLCB0aGUgeDg2IGFzc2VtYmxl
cgppbiBiaW51dGlscyAyLjMyIGFuZCBhYm92ZSBnZW5lcmF0ZXMgYSBwcm9ncmFtIHByb3BlcnR5
IG5vdGUgaW4gYSBub3RlCnNlY3Rpb24sIC5ub3RlLmdudS5wcm9wZXJ0eSwgdG8gZW5jb2RlIHVz
ZWQgeDg2IElTQXMgYW5kIGZlYXR1cmVzLiAgQnV0Cmtlcm5lbCBsaW5rZXIgc2NyaXB0IG9ubHkg
Y29udGFpbnMgYSBzaWdubGUgTk9URSBzZWdtZW50OgoKUEhEUlMgewogdGV4dCBQVF9MT0FEIEZM
QUdTKDUpOwogZGF0YSBQVF9MT0FEIEZMQUdTKDYpOwogcGVyY3B1IFBUX0xPQUQgRkxBR1MoNik7
CiBpbml0IFBUX0xPQUQgRkxBR1MoNyk7CiBub3RlIFBUX05PVEUgRkxBR1MoMCk7Cn0KU0VDVElP
TlMKewouLi4KIC5ub3RlcyA6IEFUKEFERFIoLm5vdGVzKSAtIDB4ZmZmZmZmZmY4MDAwMDAwMCkg
eyBfX3N0YXJ0X25vdGVzID0gLjsgS0VFUCgqKC5ub3QKZS4qKSkgX19zdG9wX25vdGVzID0gLjsg
fSA6dGV4dCA6bm90ZQouLi4KfQoKVGhlIE5PVEUgc2VnbWVudCBnZW5lcmF0ZWQgYnkga2VybmVs
IGxpbmtlciBzY3JpcHQgaXMgYWxpZ25lZCB0byA0IGJ5dGVzLgpCdXQgLm5vdGUuZ251LnByb3Bl
cnR5IHNlY3Rpb24gbXVzdCBiZSBhbGlnbmVkIHRvIDggYnl0ZXMgb24geDg2LTY0IGFuZAp3ZSBn
ZXQKCltoamxAZ251LXNreC0xIGxpbnV4XSQgcmVhZGVsZiAtbiB2bWxpbnV4CgpEaXNwbGF5aW5n
IG5vdGVzIGZvdW5kIGluOiAubm90ZXMKICBPd25lciAgICAgICAgICAgICAgICBEYXRhIHNpemUg
RGVzY3JpcHRpb24KICBYZW4gICAgICAgICAgICAgICAgICAweDAwMDAwMDA2IFVua25vd24gbm90
ZSB0eXBlOiAoMHgwMDAwMDAwNikKICAgZGVzY3JpcHRpb24gZGF0YTogNmMgNjkgNmUgNzUgNzgg
MDAKICBYZW4gICAgICAgICAgICAgICAgICAweDAwMDAwMDA0IFVua25vd24gbm90ZSB0eXBlOiAo
MHgwMDAwMDAwNykKICAgZGVzY3JpcHRpb24gZGF0YTogMzIgMmUgMzYgMDAKICB4ZW4tMy4wICAg
ICAgICAgICAgICAweDAwMDAwMDA1IFVua25vd24gbm90ZSB0eXBlOiAoMHgwMDZlNjU1OCkKICAg
ZGVzY3JpcHRpb24gZGF0YTogMDggMDAgMDAgMDAgMDMKcmVhZGVsZjogV2FybmluZzogbm90ZSB3
aXRoIGludmFsaWQgbmFtZXN6IGFuZC9vciBkZXNjc3ogZm91bmQgYXQgb2Zmc2V0IDB4NTAKcmVh
ZGVsZjogV2FybmluZzogIHR5cGU6IDB4ZmZmZmZmZmYsIG5hbWVzaXplOiAweDAwNmU2NTU4LCBk
ZXNjc2l6ZToKMHg4MDAwMDAwMCwgYWxpZ25tZW50OiA4CltoamxAZ251LXNreC0xIGxpbnV4XSQK
ClNpbmNlIG5vdGUuZ251LnByb3BlcnR5IHNlY3Rpb24gaW4ga2VybmVsIGltYWdlIGlzIG5ldmVy
IHVzZWQsIHRoaXMgcGF0Y2gKZGlzY2FyZHMgLm5vdGUuZ251LnByb3BlcnR5IHNlY3Rpb25zIGlu
IGtlcm5lbCBsaW5rZXIgc2NyaXB0IGJ5IGFkZGluZwoKL0RJU0NBUkQvIDogewogICooLm5vdGUu
Z251LnByb3BlcnR5KQp9CgpiZWZvcmUga2VybmVsIE5PVEUgc2VnbWVudCBpbiBnZW5lcmljIE5P
VEVTLgotLS0KIGluY2x1ZGUvYXNtLWdlbmVyaWMvdm1saW51eC5sZHMuaCB8IDUgKysrKysKIDEg
ZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2FzbS1n
ZW5lcmljL3ZtbGludXgubGRzLmggYi9pbmNsdWRlL2FzbS1nZW5lcmljL3ZtbGludXgubGRzLmgK
aW5kZXggNmI5NDNmYjhjNWZkLi43MDQ2ZmQyMzI1ZmIgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvYXNt
LWdlbmVyaWMvdm1saW51eC5sZHMuaAorKysgYi9pbmNsdWRlL2FzbS1nZW5lcmljL3ZtbGludXgu
bGRzLmgKQEAgLTgxOCw3ICs4MTgsMTIgQEAKICNkZWZpbmUgVFJBQ0VEQVRBCiAjZW5kaWYKIAor
LyogRGlzY2FyZCAubm90ZS5nbnUucHJvcGVydHkgc2VjdGlvbnMgd2hpY2ggYXJlIHVudXNlZCBh
bmQgaGF2ZQorICAgZGlmZmVyZW50IGFsaWdubWVudCByZXF1aXJlbWVudCBmcm9tIGtlcm5lbCBu
b3RlIHNlY3Rpb25zLiAgKi8KICNkZWZpbmUgTk9URVMJCQkJCQkJCVwKKwkvRElTQ0FSRC8gOiB7
CQkJCQkJCVwKKwkJKigubm90ZS5nbnUucHJvcGVydHkpCQkJCQlcCisJfQkJCQkJCQkJXAogCS5u
b3RlcyA6IEFUKEFERFIoLm5vdGVzKSAtIExPQURfT0ZGU0VUKSB7CQkJXAogCQlfX3N0YXJ0X25v
dGVzID0gLjsJCQkJCVwKIAkJS0VFUCgqKC5ub3RlLiopKQkJCQkJXAotLSAKMi4yNC4xCgo=
--00000000000002a607059d6197f5--
