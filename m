Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86643C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 17:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A8C206D3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 17:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IuhmeGX4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbgA3RwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 12:52:16 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42476 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727263AbgA3RwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 12:52:16 -0500
Received: by mail-ot1-f66.google.com with SMTP id 66so3947419otd.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 09:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yhyu6UknstC0YzrN3vkBmYQYQFYPV18Wwp32gXQbglA=;
        b=IuhmeGX4PDbSyTaf32nBmDhLU8f+7sPFGeVemiy41TxG1USq/JyHtgg9g2uDWNU3+O
         JkXDOoJYFhRGnAJXpB7TC9ARtNC8S6yX0bCbCMAnZqoR7H9Bjin2DhIHFYfl3Hc9PhmP
         UUO2UJpXJ/lLuRSjyR3GsWS0CsdAs2ynN0Dyd4d+tKSn9hQAJcWO6r9qDSOuZWzESgBu
         cGSRXWD09Oma221hdNg7QW9Q21bQhfBt9zZnpQofDn4Vo7imXXTwSL00aM0tJeIjTd43
         U0lt3Rvasb/MeQKOVpIsilI4ji+kA/I6jMkQhvxx4GxGEO/RxQDg23b29Yqjp3S47w8g
         xV5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yhyu6UknstC0YzrN3vkBmYQYQFYPV18Wwp32gXQbglA=;
        b=hOY5ecqeQ2nJJfBdz30MIrgGCNcCyYEJgbNicFGXoBGOPo3k3I6cOyxN+Y1yp3z/vN
         uMcDQ/BGOp5qGFXN0jx9Jo2r4KZUm5QLnXFDZCF2YNLgHTAxCmsOz2ctNh621Ovb/U/3
         IJhRpLG43Put5xdSaj4SPIzswSSvExtR1XuwhEpXLbS3Z4VwFumi1bsUHOu8Kwn5RhN/
         srKpJ4e9G4ZDIhaNqatNvnhLSTCokmnikS7hLgrVl31S8snk9gBhDcbLDLVOlHfPZ5/u
         K4mWKq8BRtFz5BvPDq2HEFj1EDt967qOJ5REPbwKKR36j9E5CHMHPY/hJkAo3ziZvlEn
         6+JA==
X-Gm-Message-State: APjAAAWmYtHtFgGbsbjhNxxO6AiPOXPmr9zRlREbqhiyvExWy78qtafF
        y86vZ3e0RXMD6HUdayogOBxA6mDHoQ6uRqe8FJ4=
X-Google-Smtp-Source: APXvYqwEJn/pwd2NEK7XRcvE4I+r4sPVg37UM4L55KDwT516tJSHh5mRquO/NYijHBiRfhCZVj9gLHIU2nDf9xJfuSI=
X-Received: by 2002:a9d:6510:: with SMTP id i16mr4283509otl.142.1580406734641;
 Thu, 30 Jan 2020 09:52:14 -0800 (PST)
MIME-Version: 1.0
References: <20200124181819.4840-1-hjl.tools@gmail.com> <20200124181819.4840-3-hjl.tools@gmail.com>
 <202001271531.B9ACE2A@keescook>
In-Reply-To: <202001271531.B9ACE2A@keescook>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Thu, 30 Jan 2020 09:51:38 -0800
Message-ID: <CAMe9rOrVyzvaTyURc4RJJTHUXGG6uAC9KyQomxQFzWzrAN4nrg@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="0000000000000516c0059d5f1e60"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000000516c0059d5f1e60
Content-Type: text/plain; charset="UTF-8"

On Mon, Jan 27, 2020 at 3:34 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Jan 24, 2020 at 10:18:19AM -0800, H.J. Lu wrote:
> > With the command-line option, -mx86-used-note=yes, the x86 assembler
> > in binutils 2.32 and above generates a program property note in a note
> > section, .note.gnu.property, to encode used x86 ISAs and features.
> > But x86 kernel linker script only contains a signle NOTE segment:
> >
> > PHDRS {
> >  text PT_LOAD FLAGS(5);
> >  data PT_LOAD FLAGS(6);
> >  percpu PT_LOAD FLAGS(6);
> >  init PT_LOAD FLAGS(7);
> >  note PT_NOTE FLAGS(0);
> > }
> > SECTIONS
> > {
> > ...
> >  .notes : AT(ADDR(.notes) - 0xffffffff80000000) { __start_notes = .; KEEP(*(.not
> > e.*)) __stop_notes = .; } :text :note
> > ...
> > }
> >
> > which may not be incompatible with note.gnu.property sections.  Since
> > note.gnu.property section in kernel image is unused, this patch discards
> > .note.gnu.property sections in kernel linker script by adding
> >
> >  /DISCARD/ : {
> >   *(.note.gnu.property)
> >  }
>
> I think this is happening in the wrong place? Shouldn't this be in the
> DISCARDS macro in include/asm-generic/vmlinux.lds.h instead?

Please read my commit message closely.   We can't discard .note.gnu.property
sections by adding .note.gnu.property to default discarded sections
since default
discarded sections are placed AFTER .notes sections in x86 kernel
linker scripts.

> > before .notes sections.  Since .exit.text and .exit.data sections are
> > discarded at runtime, it undefines EXIT_TEXT and EXIT_DATA to exclude
> > .exit.text and .exit.data sections from default discarded sections.
>
> This looks like a separate issue (though maybe related to DISCARDS)?

Here is the updated patch without  EXIT_TEXT and EXIT_DATA change.
I will submit a separate patch for it.

Thanks.

-- 
H.J.

--0000000000000516c0059d5f1e60
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0002-x86-Discard-.note.gnu.property-sections-in-vmlinux.patch"
Content-Disposition: attachment; 
	filename="0002-x86-Discard-.note.gnu.property-sections-in-vmlinux.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_k611ak450>
X-Attachment-Id: f_k611ak450

RnJvbSA2Mzk3MDA4YzJjMjk1Y2Q1OGEwNTJhY2Y5ZmM2NDExYTNkNjhlNDZkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiAiSC5KLiBMdSIgPGhqbC50b29sc0BnbWFpbC5jb20+CkRhdGU6
IFRodSwgMzAgSmFuIDIwMjAgMDk6MjU6NTQgLTA4MDAKU3ViamVjdDogW1BBVENIIDIvMl0geDg2
OiBEaXNjYXJkIC5ub3RlLmdudS5wcm9wZXJ0eSBzZWN0aW9ucyBpbiB2bWxpbnV4CgpXaXRoIHRo
ZSBjb21tYW5kLWxpbmUgb3B0aW9uLCAtbXg4Ni11c2VkLW5vdGU9eWVzLCB0aGUgeDg2IGFzc2Vt
YmxlcgppbiBiaW51dGlscyAyLjMyIGFuZCBhYm92ZSBnZW5lcmF0ZXMgYSBwcm9ncmFtIHByb3Bl
cnR5IG5vdGUgaW4gYSBub3RlCnNlY3Rpb24sIC5ub3RlLmdudS5wcm9wZXJ0eSwgdG8gZW5jb2Rl
IHVzZWQgeDg2IElTQXMgYW5kIGZlYXR1cmVzLgpCdXQgeDg2IGtlcm5lbCBsaW5rZXIgc2NyaXB0
IG9ubHkgY29udGFpbnMgYSBzaWdubGUgTk9URSBzZWdtZW50OgoKUEhEUlMgewogdGV4dCBQVF9M
T0FEIEZMQUdTKDUpOwogZGF0YSBQVF9MT0FEIEZMQUdTKDYpOwogcGVyY3B1IFBUX0xPQUQgRkxB
R1MoNik7CiBpbml0IFBUX0xPQUQgRkxBR1MoNyk7CiBub3RlIFBUX05PVEUgRkxBR1MoMCk7Cn0K
U0VDVElPTlMKewouLi4KIC5ub3RlcyA6IEFUKEFERFIoLm5vdGVzKSAtIDB4ZmZmZmZmZmY4MDAw
MDAwMCkgeyBfX3N0YXJ0X25vdGVzID0gLjsgS0VFUCgqKC5ub3QKZS4qKSkgX19zdG9wX25vdGVz
ID0gLjsgfSA6dGV4dCA6bm90ZQouLi4KfQoKd2hpY2ggbWF5IG5vdCBiZSBpbmNvbXBhdGlibGUg
d2l0aCBub3RlLmdudS5wcm9wZXJ0eSBzZWN0aW9ucy4gIFNpbmNlCm5vdGUuZ251LnByb3BlcnR5
IHNlY3Rpb24gaW4ga2VybmVsIGltYWdlIGlzIG5ldmVyIHVzZWQsIHRoaXMgcGF0Y2gKZGlzY2Fy
ZHMgLm5vdGUuZ251LnByb3BlcnR5IHNlY3Rpb25zIGluIGtlcm5lbCBsaW5rZXIgc2NyaXB0IGJ5
IGFkZGluZwoKL0RJU0NBUkQvIDogewogICooLm5vdGUuZ251LnByb3BlcnR5KQp9CgpiZWZvcmUg
Lm5vdGVzIHNlY3Rpb25zLiAgTkI6IFdlIGNhbid0IGRpc2NhcmQgLm5vdGUuZ251LnByb3BlcnR5
IHNlY3Rpb25zCmJ5IGFkZGluZyAubm90ZS5nbnUucHJvcGVydHkgdG8gZGVmYXVsdCBkaXNjYXJk
ZWQgc2VjdGlvbnMgc2luY2UgZGVmYXVsdApkaXNjYXJkZWQgc2VjdGlvbnMgYXJlIHBsYWNlZCBB
RlRFUiAubm90ZXMgc2VjdGlvbnMgaW4geDg2IGtlcm5lbCBsaW5rZXIKc2NyaXB0cy4KClNpZ25l
ZC1vZmYtYnk6IEguSi4gTHUgPGhqbC50b29sc0BnbWFpbC5jb20+Ci0tLQogYXJjaC94ODYva2Vy
bmVsL3ZtbGludXgubGRzLlMgfCA1ICsrKysrCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25z
KCspCgpkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL3ZtbGludXgubGRzLlMgYi9hcmNoL3g4
Ni9rZXJuZWwvdm1saW51eC5sZHMuUwppbmRleCBlMzI5NmFhMDI4ZmUuLmQxYjk0MjM2NWQyNyAx
MDA2NDQKLS0tIGEvYXJjaC94ODYva2VybmVsL3ZtbGludXgubGRzLlMKKysrIGIvYXJjaC94ODYv
a2VybmVsL3ZtbGludXgubGRzLlMKQEAgLTE1MCw2ICsxNTAsMTEgQEAgU0VDVElPTlMKIAlfZXRl
eHQgPSAuOwogCS4gPSBBTElHTihQQUdFX1NJWkUpOwogCisJLyogLm5vdGUuZ251LnByb3BlcnR5
IHNlY3Rpb25zIHNob3VsZCBiZSBkaXNjYXJkZWQgKi8KKwkvRElTQ0FSRC8gOiB7CisJCSooLm5v
dGUuZ251LnByb3BlcnR5KQorCX0KKwogCVg4Nl9BTElHTl9ST0RBVEFfQkVHSU4KIAlST19EQVRB
KFBBR0VfU0laRSkKIAlYODZfQUxJR05fUk9EQVRBX0VORAotLSAKMi4yNC4xCgo=
--0000000000000516c0059d5f1e60--
