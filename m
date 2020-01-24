Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CACC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 18:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F34A2072C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 18:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pL7cB63/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391505AbgAXSpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 13:45:08 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45664 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388325AbgAXSpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 13:45:07 -0500
Received: by mail-ot1-f68.google.com with SMTP id 59so2557501otp.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 10:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sd1b8l7D71Ce6EfWTCmTNwRga6rDOdhYHiLl9y5e+A8=;
        b=pL7cB63/tkXIsbjmtTyf6hRnBfG8zMBnBH8MGdrp9Wwx04NbTmsR+5drVHHUNjlWz+
         T1RZzllC9U95UVfGsxie0pKn7275++5pHGP+OB7tZHBpW8HU1SKYRQf0Sia3OUV6QiTu
         GdMYa7alYalIa/8VcB5ScPXUgl/OHr3V6ZDaSdJbz4sVIE+kX8xhe2idI7Z+vkcEDyx8
         2pVuxlwZpMjKwkLOopfIYH3OuhjNVpMlF9oaw9Bd5dk4aEcCHHR2MZyC1A9/6dp/JrmQ
         mJnrug5nHflKwzegxt0xlN6/HyOd7QIOm32SHgqwn3ywzNaH4medTiJ0i4zMPjuEyA0A
         Uiyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sd1b8l7D71Ce6EfWTCmTNwRga6rDOdhYHiLl9y5e+A8=;
        b=a8h4CIXvlM9/IPdQ8ZoEJ9q1J0+pChrvF3zzTAeNzaOoR1qN+sx9AN7AZ9BGuZb0mm
         uMCujj58BTjLNiY2PhUHcyNUqCG2reyC5IK0Qgfhtifc6At3fxyEc4e46Y636TT/CqNu
         /Aclo5QqbRIUSUyJmnoAxOn4Ch94vHN5x+SLTLzEzE4NGqiUAUsrgbzONNAllDscTHKY
         3lEwtvbYs7EV8vymJoHCzP6sXeNFqJ+Z6tvzv7hN0b9fW9hV5W7InlHXlfNGGIjQ0lVc
         sfplnznXlYhNlpvGufU6knsXi2JtD3nPphRKkPDa6y1eNpJqeY3ffIS8MtwsQdccdXfV
         KUcQ==
X-Gm-Message-State: APjAAAXOuIb5nwDIbPpfkYMpoqxOuBIiAeownTa7vMwIFjaX0g6zlV3g
        BR4ULK83m7T0thSzWmfUlpNRO6qEtJjgoA02YE8=
X-Google-Smtp-Source: APXvYqzXCR/YpbMQqoeLyUZklRtfSCOOEwi5O1ny8m0trRj6FPiVx5EBdAlSzW8RV4+s97/VfOPcb4n0sy3bilIAMPU=
X-Received: by 2002:a9d:4c14:: with SMTP id l20mr884043otf.125.1579891506709;
 Fri, 24 Jan 2020 10:45:06 -0800 (PST)
MIME-Version: 1.0
References: <20200124181811.4780-1-hjl.tools@gmail.com> <E184715B-30CD-4951-BAF4-E95135AEE938@amacapital.net>
 <CAMe9rOov9pLYcDLcu2CR7-i5VJhWzz4n95MYiXZDd9p79nQFyQ@mail.gmail.com>
In-Reply-To: <CAMe9rOov9pLYcDLcu2CR7-i5VJhWzz4n95MYiXZDd9p79nQFyQ@mail.gmail.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Fri, 24 Jan 2020 10:44:30 -0800
Message-ID: <CAMe9rOrtj-Hrr6tmSrwg_V9bawXXB2WjsSedL=aCaaH-=ZSKsA@mail.gmail.com>
Subject: [PATCH] x86: Don't declare __force_order in kaslr_64.c
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Content-Type: multipart/mixed; boundary="0000000000000ae2a9059ce728da"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000000ae2a9059ce728da
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2020 at 10:39 AM H.J. Lu <hjl.tools@gmail.com> wrote:
>
> On Fri, Jan 24, 2020 at 10:24 AM Andy Lutomirski <luto@amacapital.net> wr=
ote:
> >
> >
> >
> > > On Jan 24, 2020, at 10:18 AM, H.J. Lu <hjl.tools@gmail.com> wrote:
> > >
> > > =EF=BB=BFGCC 10 changed the default to -fno-common, which leads to
> > >
> > >  LD      arch/x86/boot/compressed/vmlinux
> > > ld: arch/x86/boot/compressed/pgtable_64.o:(.bss+0x0): multiple defini=
tion of `__force_order'; arch/x86/boot/compressed/kaslr_64.o:(.bss+0x0): fi=
rst defined here
> > > make[2]: *** [arch/x86/boot/compressed/Makefile:119: arch/x86/boot/co=
mpressed/vmlinux] Error 1
> > >
> > > Since __force_order is already provided in pgtable_64.c, there is no
> > > need to declare __force_order in kaslr_64.c.
> >
> > Why does anything actually define that variable?  Surely any actual ref=
erences are just an outright bug.  Is it needed for LTO?
>
> It is needed by GCC 10 without LTO.
>

This updated patch fixed a typo in Subject: "care" -> "declare".


--=20
H.J.

--0000000000000ae2a9059ce728da
Content-Type: application/x-patch; 
	name="0001-x86-Don-t-declare-__force_order-in-kaslr_64.c.patch"
Content-Disposition: attachment; 
	filename="0001-x86-Don-t-declare-__force_order-in-kaslr_64.c.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_k5sij6xy0>
X-Attachment-Id: f_k5sij6xy0

RnJvbSBjOGMyNjE5NGNmNWEzNDRjZDUzNzYzZWFhZjE2YzNhYjYwOTczNmY0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiAiSC5KLiBMdSIgPGhqbC50b29sc0BnbWFpbC5jb20+CkRhdGU6
IFRodSwgMTYgSmFuIDIwMjAgMTI6NDY6NTEgLTA4MDAKU3ViamVjdDogW1BBVENIXSB4ODY6IERv
bid0IGRlY2xhcmUgX19mb3JjZV9vcmRlciBpbiBrYXNscl82NC5jCgpHQ0MgMTAgY2hhbmdlZCB0
aGUgZGVmYXVsdCB0byAtZm5vLWNvbW1vbiwgd2hpY2ggbGVhZHMgdG8KCiAgTEQgICAgICBhcmNo
L3g4Ni9ib290L2NvbXByZXNzZWQvdm1saW51eApsZDogYXJjaC94ODYvYm9vdC9jb21wcmVzc2Vk
L3BndGFibGVfNjQubzooLmJzcysweDApOiBtdWx0aXBsZSBkZWZpbml0aW9uIG9mIGBfX2ZvcmNl
X29yZGVyJzsgYXJjaC94ODYvYm9vdC9jb21wcmVzc2VkL2thc2xyXzY0Lm86KC5ic3MrMHgwKTog
Zmlyc3QgZGVmaW5lZCBoZXJlCm1ha2VbMl06ICoqKiBbYXJjaC94ODYvYm9vdC9jb21wcmVzc2Vk
L01ha2VmaWxlOjExOTogYXJjaC94ODYvYm9vdC9jb21wcmVzc2VkL3ZtbGludXhdIEVycm9yIDEK
ClNpbmNlIF9fZm9yY2Vfb3JkZXIgaXMgYWxyZWFkeSBwcm92aWRlZCBpbiBwZ3RhYmxlXzY0LmMs
IHRoZXJlIGlzIG5vCm5lZWQgdG8gZGVjbGFyZSBfX2ZvcmNlX29yZGVyIGluIGthc2xyXzY0LmMu
CgpTaWduZWQtb2ZmLWJ5OiBILkouIEx1IDxoamwudG9vbHNAZ21haWwuY29tPgpTaWduZWQtb2Zm
LWJ5OiBZdS1jaGVuZyBZdSA8eXUtY2hlbmcueXVAaW50ZWwuY29tPgotLS0KIGFyY2gveDg2L2Jv
b3QvY29tcHJlc3NlZC9rYXNscl82NC5jIHwgMyAtLS0KIDEgZmlsZSBjaGFuZ2VkLCAzIGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2Jvb3QvY29tcHJlc3NlZC9rYXNscl82NC5j
IGIvYXJjaC94ODYvYm9vdC9jb21wcmVzc2VkL2thc2xyXzY0LmMKaW5kZXggNzQ4NDU2YzM2NWY0
Li45NTU3YzVhMTViOTEgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2Jvb3QvY29tcHJlc3NlZC9rYXNs
cl82NC5jCisrKyBiL2FyY2gveDg2L2Jvb3QvY29tcHJlc3NlZC9rYXNscl82NC5jCkBAIC0yOSw5
ICsyOSw2IEBACiAjZGVmaW5lIF9fUEFHRV9PRkZTRVQgX19QQUdFX09GRlNFVF9CQVNFCiAjaW5j
bHVkZSAiLi4vLi4vbW0vaWRlbnRfbWFwLmMiCiAKLS8qIFVzZWQgYnkgcGd0YWJsZS5oIGFzbSBj
b2RlIHRvIGZvcmNlIGluc3RydWN0aW9uIHNlcmlhbGl6YXRpb24uICovCi11bnNpZ25lZCBsb25n
IF9fZm9yY2Vfb3JkZXI7Ci0KIC8qIFVzZWQgdG8gdHJhY2sgb3VyIHBhZ2UgdGFibGUgYWxsb2Nh
dGlvbiBhcmVhLiAqLwogc3RydWN0IGFsbG9jX3BndF9kYXRhIHsKIAl1bnNpZ25lZCBjaGFyICpw
Z3RfYnVmOwotLSAKMi4yNC4xCgo=
--0000000000000ae2a9059ce728da--
