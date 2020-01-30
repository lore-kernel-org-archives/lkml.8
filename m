Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBEAC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 20:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3406320674
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 20:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnC2Wzqv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbgA3Urp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 15:47:45 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43228 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbgA3Uro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 15:47:44 -0500
Received: by mail-ot1-f65.google.com with SMTP id p8so4397574oth.10
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 12:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GjvZAdb+dPg7WQDK5MQE15dbidK+TtdUyyc+BBbAtRw=;
        b=OnC2WzqvXVUUegI2fDHqNJCr0T92rdUTTuht/QKSV9u6p1A9ogXryrMFNkrByEwUl8
         znSkYwIvlzEGliCJySlrpvv5zmIkfZA9hdRyDErLp8JaCP7KHQlBeX6YlyzFSc5G9cFX
         hHS3vndnIUdZpmcMSF+X4KGpsGxgdpKg8I79kIKCRqq1eYFIGwF1Rc7+fju4r0XkMpMR
         BKE+dXemfx48rKGkJCT1V5b179Z29oE61KUYtN/BKJDxD+gC7YFgfNpQvwsOgE7kcuGH
         /TZAr4wuat4KHgm+uSOeRh+oS/DBwwPcZi7EZpQJBOw5bU6j8QDS/HqH8UX9U90CZPFF
         KpxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GjvZAdb+dPg7WQDK5MQE15dbidK+TtdUyyc+BBbAtRw=;
        b=CxZLDwmVIKFBl7NLiyTeascPfGi8Iwnh1IAJIDDN+w480aGnMb2l27jrTlkfjZDyJx
         qbfamaMVhTuJXJA2mreDXF+0OgObdK2Qw4Lg+rZIWUsVnbbR1msB5yuiltfL02aDMmGX
         CpKvsZxffwBWY24YwfuuwIIpVVRw7hlfzBKMyuMHp++m5NmKys36+buHku/zzNXD9KFF
         LDowjd36TD02HcXb/0o5l0FlGDG2R29RRaWQoIU6+LK97uWHa/ZprOWPms7bLXfZhZAI
         cfYlHIJAta+I7kFkuCKA66hM/omsM0udod/Bcu2d6Ny+ACVvOs87hlcDNpg6mY/VnPe6
         H+gQ==
X-Gm-Message-State: APjAAAV60rcKUtVXZiTvx4lJ00J2xsy3xfOXDyqdiLWXMoCv6lNPQai+
        FCFDrc5TLmY5H37/HeKuMwOyUAoMphFK4fEZEw4=
X-Google-Smtp-Source: APXvYqyah544SkEus4oz7h25yjaaMR5pX+tQEkuECkWzNyFFrCjbtTIlavJyGB/39Y1RmtUL/rxLy7vl9HNHfIlgydY=
X-Received: by 2002:a9d:7590:: with SMTP id s16mr4702972otk.89.1580417263552;
 Thu, 30 Jan 2020 12:47:43 -0800 (PST)
MIME-Version: 1.0
References: <20200130180048.2901-1-hjl.tools@gmail.com> <202001301139.F8859A4@keescook>
 <CAMe9rOrrrZFWgVpsKAWjHKzVh3ZziFLs2ua0m0Ewymrjs-b+EA@mail.gmail.com>
 <202001301152.DF108B6CC@keescook> <CAMe9rOp1SJvsjSMtDFi4HWKPpu2eePCDiedTPAndUEL5-HSU1w@mail.gmail.com>
In-Reply-To: <CAMe9rOp1SJvsjSMtDFi4HWKPpu2eePCDiedTPAndUEL5-HSU1w@mail.gmail.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Thu, 30 Jan 2020 12:47:07 -0800
Message-ID: <CAMe9rOqYh3QEdT16C8TOCBhYqfzsYJ6re0x+MDjpad9_59krZw@mail.gmail.com>
Subject: [PATCH] Add RUNTIME_DISCARD_EXIT to generic DISCARDS
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
Content-Type: multipart/mixed; boundary="000000000000976d3f059d61916d"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000976d3f059d61916d
Content-Type: text/plain; charset="UTF-8"

On Thu, Jan 30, 2020 at 12:06 PM H.J. Lu <hjl.tools@gmail.com> wrote:
>
> On Thu, Jan 30, 2020 at 11:58 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Thu, Jan 30, 2020 at 11:45:15AM -0800, H.J. Lu wrote:
> > > On Thu, Jan 30, 2020 at 11:40 AM Kees Cook <keescook@chromium.org> wrote:
> > > >
> > > > On Thu, Jan 30, 2020 at 10:00:48AM -0800, H.J. Lu wrote:
> > > > > Since .exit.text and .exit.data sections are discarded at runtime, we
> > > > > should undefine EXIT_TEXT and EXIT_DATA to exclude .exit.text and
> > > > > .exit.data sections from default discarded sections.
> > > >
> > > > This is just a correctness fix, yes? The EXIT_TEXT and EXIT_DATA were
> > > > already included before the /DISCARD/ section here, so there's no
> > > > behavioral change with this patch, correct?
> > >
> > > That is correct.  I was confused by EXIT_TEXT and EXIT_DATA in generic
> > > DISCARDS.   My patch just makes it more explicit.
> >
> > Okay, so to that end and because this isn't arch-specific, I'd like to
> > see this be a behavioral flag, and then the generic DISCARDS macro can
> > be adjusted. This lets all architectures implement this without having
> > to scatter undef/define lines in each arch.
> >
> > Something like this:
> >
> > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> > index e00f41aa8ec4..f242d3b4814d 100644
> > --- a/include/asm-generic/vmlinux.lds.h
> > +++ b/include/asm-generic/vmlinux.lds.h
> > @@ -894,11 +894,17 @@
> >   * section definitions so that such archs put those in earlier section
> >   * definitions.
> >   */
> > -#define DISCARDS                                                       \
> > -       /DISCARD/ : {                                                   \
> > +#ifdef RUNTIME_DISCARD_EXIT
> > +#define EXIT_DISCARDS
> > +#else
> > +#define EXIT_DISCARDS                                                  \
> >         EXIT_TEXT                                                       \
> >         EXIT_DATA                                                       \
> > -       EXIT_CALL                                                       \
> > +       EXIT_CALL
> > +#endif

We should keep EXIT_CALL in DISCARDS.  Only .exit.text and .exit.data
sections are discarded at runtime.

> > +#define DISCARDS                                                       \
> > +       /DISCARD/ : {                                                   \
> > +       EXIT_DISCARDS                                                   \
> >         *(.discard)                                                     \
> >         *(.discard.*)                                                   \
> >         *(.modinfo)                                                     \
> >
> > Then x86 and all other architectures that do this can just use
> > #define RUNTIME_DISCARD_EXIT
> > at the top (like EMITS_PT_NOTE, etc).
> >
>
> It should work.

Here is the patch to add RUNTIME_DISCARD_EXIT to generic DISCARDS.

-- 
H.J.

--000000000000976d3f059d61916d
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-Add-RUNTIME_DISCARD_EXIT-to-generic-DISCARDS.patch"
Content-Disposition: attachment; 
	filename="0001-Add-RUNTIME_DISCARD_EXIT-to-generic-DISCARDS.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_k617jujr0>
X-Attachment-Id: f_k617jujr0

RnJvbSBiZGUyODIxZjVlMDFhNWY0OWIyMjdjNmZiOGJhNjE5NWMyNjM4MWE5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiAiSC5KLiBMdSIgPGhqbC50b29sc0BnbWFpbC5jb20+CkRhdGU6
IFRodSwgMzAgSmFuIDIwMjAgMTI6MzE6MjIgLTA4MDAKU3ViamVjdDogW1BBVENIXSBBZGQgUlVO
VElNRV9ESVNDQVJEX0VYSVQgdG8gZ2VuZXJpYyBESVNDQVJEUwoKSW4geDg2IGtlcm5lbCwgLmV4
aXQudGV4dCBhbmQgLmV4aXQuZGF0YSBzZWN0aW9ucyBhcmUgZGlzY2FyZGVkIGF0CnJ1bnRpbWUg
bm90IGJ5IGxpbmtlci4gIEFkZCBSVU5USU1FX0RJU0NBUkRfRVhJVCB0byBnZW5lcmljIERJU0NB
UkRTCmFuZCBkZWZpbmUgaXQgaW4geDg2IGtlcm5lbCBsaW5rZXIgc2NyaXB0IHRvIGtlZXAgdGhl
bS4KLS0tCiBhcmNoL3g4Ni9rZXJuZWwvdm1saW51eC5sZHMuUyAgICAgfCAgMSArCiBpbmNsdWRl
L2FzbS1nZW5lcmljL3ZtbGludXgubGRzLmggfCAxMCArKysrKysrKy0tCiAyIGZpbGVzIGNoYW5n
ZWQsIDkgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL3g4
Ni9rZXJuZWwvdm1saW51eC5sZHMuUyBiL2FyY2gveDg2L2tlcm5lbC92bWxpbnV4Lmxkcy5TCmlu
ZGV4IGUzMjk2YWEwMjhmZS4uNzIwNmUxYWMyM2RkIDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9rZXJu
ZWwvdm1saW51eC5sZHMuUworKysgYi9hcmNoL3g4Ni9rZXJuZWwvdm1saW51eC5sZHMuUwpAQCAt
MjEsNiArMjEsNyBAQAogI2RlZmluZSBMT0FEX09GRlNFVCBfX1NUQVJUX0tFUk5FTF9tYXAKICNl
bmRpZgogCisjZGVmaW5lIFJVTlRJTUVfRElTQ0FSRF9FWElUCiAjZGVmaW5lIEVNSVRTX1BUX05P
VEUKICNkZWZpbmUgUk9fRVhDRVBUSU9OX1RBQkxFX0FMSUdOCTE2CiAKZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvYXNtLWdlbmVyaWMvdm1saW51eC5sZHMuaCBiL2luY2x1ZGUvYXNtLWdlbmVyaWMvdm1s
aW51eC5sZHMuaAppbmRleCBlMDBmNDFhYThlYzQuLjZiOTQzZmI4YzVmZCAxMDA2NDQKLS0tIGEv
aW5jbHVkZS9hc20tZ2VuZXJpYy92bWxpbnV4Lmxkcy5oCisrKyBiL2luY2x1ZGUvYXNtLWdlbmVy
aWMvdm1saW51eC5sZHMuaApAQCAtODk0LDEwICs4OTQsMTYgQEAKICAqIHNlY3Rpb24gZGVmaW5p
dGlvbnMgc28gdGhhdCBzdWNoIGFyY2hzIHB1dCB0aG9zZSBpbiBlYXJsaWVyIHNlY3Rpb24KICAq
IGRlZmluaXRpb25zLgogICovCisjaWZkZWYgUlVOVElNRV9ESVNDQVJEX0VYSVQKKyNkZWZpbmUg
RVhJVF9ESVNDQVJEUworI2Vsc2UKKyNkZWZpbmUgRVhJVF9ESVNDQVJEUwkJCQkJCQlcCisJRVhJ
VF9URVhUCQkJCQkJCVwKKwlFWElUX0RBVEEKKyNlbmRpZgogI2RlZmluZSBESVNDQVJEUwkJCQkJ
CQlcCiAJL0RJU0NBUkQvIDogewkJCQkJCQlcCi0JRVhJVF9URVhUCQkJCQkJCVwKLQlFWElUX0RB
VEEJCQkJCQkJXAorCUVYSVRfRElTQ0FSRFMJCQkJCQkJXAogCUVYSVRfQ0FMTAkJCQkJCQlcCiAJ
KiguZGlzY2FyZCkJCQkJCQkJXAogCSooLmRpc2NhcmQuKikJCQkJCQkJXAotLSAKMi4yNC4xCgo=
--000000000000976d3f059d61916d--
